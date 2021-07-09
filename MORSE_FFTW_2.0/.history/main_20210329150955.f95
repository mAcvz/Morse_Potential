PROGRAM Use_fftw
    !
    ! AVVISO: "
    ! La documentazione a CAZZO DI CANE fa si che l'allocamento delle variabili sia a sua volta alla CAZZO !!!
    !
    USE fftw_module ! importiamo  un po' come capita l'interfaccia C++ 
    !
    IMPLICIT NONE    
    ! 
    type(C_PTR) :: plan     ! il prof usa integer fa facciamo un po' a caso... tanto cosa cambia 
    integer(C_int) ::   N, M, F, i   
    INTEGER,PARAMETER :: UnitRead = 11
    CHARACTER(LEN = 50) :: FileInput = "Input.txt"
    real(C_DOUBLE) :: L,h                                        
    complex(C_DOUBLE), dimension(:),ALLOCATABLE:: in,x           ! allochiamo le variabili secondo 
    complex(C_DOUBLE_complex), dimension(:),ALLOCATABLE:: out    ! l'interfaccia C++
    !
    ! Lettura  input (numero punti, range, quanti autovalori, numero funzioni di base )
    !
    WRITE(*,*) "PROGRAMMA: test 1.2  " // new_line("A")
    WRITE(*,*) "OSCILLATORE ARMONICO QUANTISTICO: test uso FFTW " // new_line("A")
    !
    OPEN(UNIT=UnitRead,FILE = FileInput) 
    READ(UNIT=UnitRead,FMT = *)
    READ(UNIT=UnitRead,FMT = *)N,L,M,F
    CLOSE(UNIT=UnitRead)
    !
    print*,N,L,M,F
    ! NON VERRA' FATTO NESSUN CONTROLLO SULLE VARIABILI DI INGESSEO STACCI ATTENTO
    !
    ALLOCATE(x(N))
    ALLOCATE(in(N))   ! non ho seguito l'allocamento "consigliato dalla documentazione" fuck the system !
    ALLOCATE(out(N))  ! porco "cazzo" il prof non mette la dimensione (N/2 + 1 ) quindi ... fanculo nemmeno noi 
    !
    ! CALCOLO: passo di avanzamento h e creazione vettori E e in
    h = L/ dble(N-1) ! passo avanzamento
    !
    DO i = 1,N-1
        x(i) = (-L/2. + h*i) ! vettore griglia punti
    END DO 
    !
    in = x**2       ! potenzile armonico valutato punto per punto (costanti assunte = 1)
    !
    call dfftw_plan_dft_1d(plan, N, in,out, FFTW_FORWARD,FFTW_ESTIMATE) ! creazione piano 
    call dfftw_execute_dft(plan,in,out)                             ! esecuzione piano
    !
    OPEN(UNIT=20,FILE="out.txt")
    WRITE(UNIT=20,FMT="(i4,f13.5,a4,f13.5)")(i,real(out(i)),"  i",(aimag(out(i))),i=1,F)
    CLOSE(UNIT=20)
    ! 
    call dfftw_destroy_plan(plan)                                   !distruzione piano
    !
    WRITE(*,*)"VETTORE SALVATO SU FILE: out.txt"
    !
END PROGRAM Use_fftw