PROGRAM  main_morse
    ! 
        USE Dichiarazione
        USE scrittura
        !
        IMPLICIT NONE
        !
        INCLUDE "fftw3.f"
        !
        ! LETTURA DA FILE
        OPEN(UNIT=1,FILE='file_input.dat')
        read(UNIT=1,FMT=*)
        read(UNIT=1,FMT=*)N,L,alpha,M,LWORK
        CLOSE(UNIT=1)
        !
        LWORK = 6600 ! valore ottimale per LWORK 
        !allocazione
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
            in(i+1) = (1 - EXP(-(alpha)*(x(i+1)- L/8.d0) ))**2 ! studiare meglio x0 prima era L/8
        END DO
        !CALL cpu_time(tic)    
        !UTILIZZO FFTW3
        CALL dfftw_plan_dft_1d(plan,N,in,out,FFTW_forward,fftw_estimate) 
        CALL dfftw_execute(plan,in,out)
        CALL dfftw_destroy_plan(plan)
        out = out/dble(N)        
        ! CALL cpu_time(toc)
        OPEN(UNIT=2,FILE='file_output.dat')
        WRITE(UNIT=2,FMT="(i6,f30.15,a3,f30.15,a2)")(i,real(out(i)),"  ",(AIMAG(out(i)))," i",i=1,N)
        CLOSE(UNIT=2)
        ! WRITE(*,*) toc - tic 
        ! COSTRUZIONE MATRICE V
        DO i=0,N-1
            DO j = 1, N-i 
                V(j,j+i)= (out(i+1))  
               ! IF (i .ne. 0 ) THEN 
               !     V(j+i,j) = real(out(i+1))     !RIEMPIAMO SOLO SOPRA
               ! END IF  
            END DO  
        END DO 
        !  k = i *(pi/L)     
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
        OPEN(UNIT=3,FILE='riga_v.txt')
        WRITE(UNIT=3,FMT="(i4,f15.5)")(i,REAL(V(1,i)),i=1,N)
        CLOSE(UNIT=3)
        !    
        Ham = Ham + V       ! FFTW
        !
        CALL ZHEEV (JOBZ,UPLO,N,Ham,N,W,WORK,LWORK,RWORK,INFO)
        ! http://www.netlib.org/lapack/explore-html/df/d9a/group__complex16_h_eeigen_gaf23fb5b3ae38072ef4890ba43d5cfea2.html#gaf23fb5b3ae38072ef4890ba43d5cfea2
        !
        !PRINT*, "SCELTA OTTIMALE DELLA VARIABILE LWORK -> ",real(WORK(1))
        WRITE(*,FMT="(a40, f10.1)") "SCELTA OTTIMALE DELLA VARIABILE LWORK : ",REAL(WORK(1))
        !
        ! STAMPA A VIDEO DEGLI AUTOVALORI 1,2 ... M
        !
        WRITE(*,FMT="(a19,i2)") "AUTOVALORI: 1,2 ...",M, NEW_LINE("A")
        WRITE(*,FMT="(i4,f15.10)")(i,W(i)/2 ,i=1,5)
        !
        !
        ! AUTOVETTORI RIPORTATI IN SPAZIO REALE, PER ORA NON MOLTIPLICHIAMO PER LA NORMALIZZAZIONE TANTO 
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
    