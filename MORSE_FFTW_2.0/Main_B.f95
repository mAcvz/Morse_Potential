PROGRAM  Main_B
    !
    !
    ! 
    ! Programma che risolvere l'EQ. di Schrodinger unidimensionale per il potenziale di Morse. Il problema
    ! viene affrontato determinando A.Valori e A.Vettori (riscalati) nel modo seguente:
    ! si effettua una FFT del potenziele di Morse e si costruisce l'Hamiltoniana 
    ! nello spazio dei k, dopo di che la si diagonalizza richiamando la funzione lapack ZHEEV(...) 
    ! e si ottiene una matrice di coefficenti impiegati per cotruire 
    ! una combinazione linera delle onde piane di una base opportunamente scelta. La comb. lin.
    ! cosí ottenuta restituisce gli autovettori dell'Hamiltoniana 
    ! 
    ! VARIABLES dichiarate in MODULE Dichiazione_B
    ! SUBROUTINE di controllo in MODULE Control_B
    ! SUBROUTINE per salvataggio su file in MODULE Scrittura_B
    !
    ! PER MAGGIORI INFORMAZIONI CONTROLLARE DOCUMENTAZIONE DI OGNI "MODULE"
    !
        USE Dichiarazione_B
        USE Scrittura_B
        USE Control_B
        !
        IMPLICIT NONE
        !
        INCLUDE "fftw3.f" 
        !
        !
        ! LETTURA RANGE, N°PUNTI, N° Autovalori & Autovettori, alpha
        WRITE(*,*) NEW_LINE("A") // "PROGRAMMA:  " // NEW_LINE("A")
        !
        WRITE(*,*) "POTENZIALE DI MORSE: CALCOLO AUTO VALORI & AUTO FUNZIONI " // NEW_LINE("A")
        !
        WRITE(*,*) "Lettura parametri di input da file: ", unit_input_name, NEW_LINE("A")
        !
        !
        ! LETTURA DA FILE
        OPEN(UNIT = unit_input , FILE = unit_input_name, IOSTAT = ioerrInput)
        READ(UNIT = unit_input , FMT = *, IOSTAT = ioerrInput)        
        READ(UNIT = unit_input , FMT = *, IOSTAT = ioerrInput) N
        READ(UNIT = unit_input , FMT = *, IOSTAT = ioerrInput) L,label
        READ(UNIT = unit_input , FMT = *, IOSTAT = ioerrInput) alpha,label
        READ(UNIT = unit_input , FMT = *, IOSTAT = ioerrInput) M,label
        READ(UNIT = unit_input , FMT = *, IOSTAT = ioerrInput) LWORK,label
        CLOSE(UNIT = unit_input, IOSTAT = ioerrInput) 
        !
        ! CONTROLLO INSERIMENTO 
        CALL Control_Ins()
        !
        ! STAMPA A VIDEO PARAMETRI 
        WRITE(*,FMT=fmt_scrittura_parametri) "N = ",N, "  L = ",L,"  alpha = ",alpha,"  M = ",M,"  LWORK = ", LWORK
        !
        WRITE(*,*) NEW_LINE("A")
        !
        ! ALLOCAZIONE
        ALLOCATE(x(N))
        ALLOCATE(in(N))
        ALLOCATE(out(N))
        ALLOCATE(V(N,N))
        ALLOCATE(Ham(N,N))
        ALLOCATE(W(N))
        ALLOCATE(WORK(LWORK))
        ALLOCATE(K_vec(N))
        ALLOCATE(RWORK(3*N-2))
        ALLOCATE(Avett(dim_G,M))
        !
        h = 2*L/DBLE(N)   
        DO i=0, N-1
            x(i+1) = h*i
            in(i+1) = (1 - EXP(-(alpha)*(x(i+1)- L/6.d0) ))**2 
        END DO
        !
        ! CREAZIONE GRIGLIA 
        step = 2*L/ DBLE(dim_G - 1)
        DO i = 0,(dim_G -1)
            griglia(i+1) = i*step 
        END DO 
        !  
        ! UTILIZZO FFTW3
        CALL dfftw_plan_dft_1d(plan,N,in,out,FFTW_forward,fftw_estimate) 
        CALL dfftw_execute(plan,in,out)
        CALL dfftw_destroy_plan(plan)
        out = out/DBLE(N)     
        !   
        ! COSTRUZIONE MATRICE V
        DO i=0,N-1
            DO j = 1, N-i 
                V(j,j+i)= (out(i+1))  
            END DO  
        END DO   
        !
        Ham = 0.d0   
        DO i=1,N
            IF (i <= N/2) THEN
                K_vec(i) = i*(pi/L)
            ELSE IF (i > N/2) THEN 
                K_vec(i) = (i-N)*(pi/L)
            END IF 
        END DO 
        !
        DO i=1,N
            Ham(i,i) = K_vec(i)**2
        END DO 
        !    
        Ham = Ham + V       ! FFTW
        !
        ! DIAGONALIZZAZIONE  Ham TRAMITE ROUTINE LAPACK
        ! http://www.netlib.org/lapack/explore-html/df/d9a/group__complex16_h_eeigen_gaf23fb5b3ae38072ef4890ba43d5cfea2.html#gaf23fb5b3ae38072ef4890ba43d5cfea2
        CALL ZHEEV (JOBZ,UPLO,N,Ham,N,W,WORK,LWORK,RWORK,INFO)
        CALL Control_ZHEEV()
        !
        WRITE(*,FMT=fmt_LWORK_term) "SCELTA OTTIMALE DELLA VARIABILE LWORK : ",INT(WORK(1))
        !
        WRITE(*,*) NEW_LINE("A")
        !
        ! STAMPA A VIDEO DEGLI AUTOVALORI 1,2 ... M
        WRITE(*,FMT = "(a,i2)") "ANTEPRIMA AUTOVALORI: 1,2 ...",M, NEW_LINE("A")
        WRITE(*,FMT = fmt_Aval) (i,W(i)/2 ,i=1,M)
        !
        ! STAMPA SU FILE AUTOVALORI 1,2 ... M
        CALL Scrittura_A_val()
        !
        !
        ! AUTOVETTORI RIPORTATI IN SPAZIO REALE
        ! PER ORA NON MOLTIPLICHIAMO PER LA NORMALIZZAZIONE TANTO  !!!!!!!!!!!!!!!!!!!!! ATTENZIONE !!!!!!!!!!!!!!!!!!!!!!!!
        ! E' UN FATTORE MOLTIPLICATIVO, NON VARIA L'ANDAMENTO
        DO s=1,M
            DO i=1,dim_G
                sum = 0
                DO j=1,N
                   sum = sum + CMPLX(COS(K_vec(j)*griglia(i)),-SIN(K_vec(j)*griglia(i)),KIND=dp)*Ham(j,s)
                END DO 
                Avett(i,s) = sum 
            END DO 
        END DO 
        !
        ! STAMPA SU FILE AUTO VETTORI 1,2 ... M
        CALL Scrittura_A_vet() 
        !
        WRITE(*,*) NEW_LINE("A"),"END TASK B" ,NEW_LINE("A")
    !
    !
    !
    END PROGRAM  Main_B
    