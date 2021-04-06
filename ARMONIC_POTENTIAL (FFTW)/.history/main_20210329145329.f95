PROGRAM Use_fftw
    !
    ! PRIMO TENTATIVO NELL'UTLIZZO DI FFTW --> eseguimo un test sull'oscillatore armonico 
    !
    USE Dichiarazione
    USE Control     ! non ho modificato i controlli su F (numero funz. della base)
    USE fftw_module ! importiamo l'interfaccia C++
    !
    IMPLICIT NONE    
    ! 
    type(C_PTR) :: plan                                          ! creiamo il piano
    complex(C_DOUBLE), dimension(:),ALLOCATABLE:: in             ! allochiamo le variabili secondo 
    complex(C_DOUBLE_complex), dimension(:),ALLOCATABLE:: out    ! l'interfaccia C++
    !
    ! Lettura  input (numero punti, range, quanti autovalori, numero funzioni di base )
    !
    WRITE(*,*) "PROGRAMMA: test 1.2  " // new_line("A")
    WRITE(*,*) "OSCILLATORE ARMONICO QUANTISTICO: test uso FFTW " // new_line("A")
    !
    OPEN(UNIT=UnitRead,FILE = FileInput,IOSTAT=ioerrInput) 
    READ(UNIT=UnitRead,FMT = *,IOSTAT = ioerrInput)
    READ(UNIT=UnitRead,FMT = *,IOSTAT = ioerrInput) N,L,M,F
    CLOSE(UNIT=UnitRead,IOSTAT=ioerrInput)
    !
    print*,N,L,M,F
    CALL Control_Ins()
    !
    ALLOCATE(E(N))
    ALLOCATE(in(N))         ! non ho seguito l'allocamento "consigliato dalla documentazione" fuck the system !
    ALLOCATE(out(N))  ! non ho seguito l'allocamento "consigliato dalla documentazione" fuck the system !
    !
    ! CALCOLO: passo di avanzamento h e creazione vettori E e in
    h = L/(N-1) ! passo avanzamento
    !
    DO i = 1,N-1
        E(i) = (-L/2. + h*i) ! vettore griglia punti
    END DO 
    !
    in = E**2       ! potenzile armonico valutato punto per punto (costanti assunte = 1)
    !
    plan = fftw_plan_dft_1d(F, in,out, FFTW_FORWARD,FFTW_ESTIMATE) ! creazione piano 
    call fftw_execute_dft(plan,in,out)                             ! esecuzione piano
    !
    OPEN(UNIT=20,FILE="out.txt")
    WRITE(UNIT=20,FMT="(i4,f13.5,a4,f13.5)")(i,real(out(i)),"  i",(aimag(out(i))),i=1,F)
    CLOSE(UNIT=20)
    ! 
    call fftw_destroy_plan(plan)                                   !distruzione piano
    !
    WRITE(*,*)"VETTORE SALVATO SU FILE: out.txt"
    !
END PROGRAM Use_fftw