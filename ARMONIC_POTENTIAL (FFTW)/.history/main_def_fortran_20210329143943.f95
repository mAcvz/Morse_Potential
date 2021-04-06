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
    integer :: plan                                        ! creiamo il piano
    complex, dimension(:),ALLOCATABLE:: in             ! allochiamo le variabili secondo 
    complex, dimension(:),ALLOCATABLE:: out    ! l'interfaccia C++
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
    ALLOCATE(out(N/2 + 1))  ! non ho seguito l'allocamento "consigliato dalla documentazione" fuck the system !
    !
    ! CALCOLO: passo di avanzamento h e creazione vettori E e in
    h = L/(N-1) ! passo avanzamento
    !
    DO i = 1,N 
        E(i) = (-L/2. + h*(i-1)) ! vettore griglia punti
    END DO 
    !
    in = E**2       ! potenzile armonico valutato punto per punto (costanti assunte = 1)
    !
    call dfftw_plan_dft_1d(plan,F,in,out,FFTW_forward,fftw_estimate)! creazione piano 
    call dfftw_execute(plan,in,out)                             ! esecuzione piano
    !
    OPEN(UNIT=20,FILE="out.txt")
    WRITE(UNIT=20,FMT="(i5,e15.10,a4,e15.10)")(i,real(out(i)),"  i",(aimag(out(i))),i=1,F)
    CLOSE(UNIT=20)
    ! 
    call dfftw_destroy_plan(plan)                                   !distruzione piano
    !
    WRITE(*,*)"VETTORE SALVATO SU FILE: out.txt"
    !
END PROGRAM Use_fftw