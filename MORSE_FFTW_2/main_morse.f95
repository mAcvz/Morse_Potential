PROGRAM  main_morse
    ! 
        USE Dichiarazione
        USE Scrittura
        USE Control
        !
        IMPLICIT NONE
        !
        INCLUDE "fftw3.f" 
        !
        ! LETTURA DA FILE
        OPEN(UNIT = unit_input , FILE = unit_input_name, IOSTAT = ioerrInput)
        READ(UNIT = unit_input , FMT = *, IOSTAT = ioerrInput)
        !READ(UNIT = unit_input , FMT = *, IOSTAT = ioerrInput) N,Z,L,C,alpha,B,M,O,LWORK,G
        
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
        WRITE(*,FMT=fmt_lettura_input) "PARAMETRI LETTI DA: ",ADJUSTL(unit_input_name) // NEW_LINE("A")
        WRITE(*,FMT=fmt_scrittura_parametri) "N = ",N, "  L = ",L,"  alpha = ",alpha,"  M = ",M,"  LWORK = ", LWORK
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
        ALLOCATE(Avett(N,M))
        !
        h = 2*L/DBLE(N)   ! SECONDO ME SAREBBE N-1 MA NON FUNZIONA 
        DO i=0, N-1
            x(i+1) = h*i
            in(i+1) = (1 - EXP(-(alpha)*(x(i+1)- L/8.d0) ))**2 
        END DO
        ! CALL cpu_time(tic)  
        !  
        ! UTILIZZO FFTW3
        CALL dfftw_plan_dft_1d(plan,N,in,out,FFTW_forward,fftw_estimate) 
        CALL dfftw_execute(plan,in,out)
        CALL dfftw_destroy_plan(plan)
        out = out/dble(N)     
        !   
        ! CALL cpu_time(toc)
        ! WRITE(*,*) toc - tic 
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
        ! STAMPA A VIDEO DEGLI AUTOVALORI 1,2 ... M
        WRITE(*,FMT = "(a19,i2)") "AUTOVALORI: 1,2 ...",M, NEW_LINE("A")
        WRITE(*,FMT = fmt_Aval) (i,W(i)/2 ,i=1,5)
        !
        ! STAMPA SU FILE AUTOVALORI 1,2 ... M
        CALL Scrittura_A_val()
        !
        !
        ! AUTOVETTORI RIPORTATI IN SPAZIO REALE
        ! PER ORA NON MOLTIPLICHIAMO PER LA NORMALIZZAZIONE TANTO 
        ! E' UN FATTORE MOLTIPLICATIVO, NON VARIA L'ANDAMENTO
        DO s=1,M
            DO i=1,N 
                sum = 0
                DO j=1,N
                   sum = sum + CMPLX(COS(K_vec(j)*x(i)),-SIN(K_vec(j)*x(i)),KIND=dp)*Ham(j,s)
                END DO 
                Avett(i,s) = sum 
            END DO 
        END DO 
        !
        CALL Scrittura_A_vet()
        !
       
    !  
    END PROGRAM  main_morse
    