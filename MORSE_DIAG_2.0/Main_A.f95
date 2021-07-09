PROGRAM Main_A
    ! 
    ! Programma che prende in ingresso L,N,M,alpha e richiama la funzione lapack DPTEQR(...)  per 
    ! risolvere l'EQ. di Schrodinger unidimensionale per il potenziale di Morse. Il problema
    ! viene affrontato determinando A.Valori e A.Vettori (riscalati) di una matrice tridiagonale. 
    ! Il programma salva su file.txt i risultati ottenuti
    ! 
    ! VARIABLES dichiarate in MODULE Dichiazione_A
    ! SUBROUTINE di controllo in MODULE Control_A
    ! SUBROUTINE per salvataggio su file in MODULE Scrittura_A
    !
    ! PER MAGGIORI INFORMAZIONI CONTROLLARE DOCUMENTAZIONE DI OGNI "MODULE"
    !
    USE Dichiarazione_A
    USE Scrittura_A
    USE Control_A
    !
    IMPLICIT NONE    
    !
    ! LETTURA RANGE, N°PUNTI, N° Autovalori & Autovettori, alpha
    WRITE(*,*) NEW_LINE("A") // "PROGRAMMA:  " // NEW_LINE("A")
    !
    WRITE(*,*) "POTENZIALE DI MORSE: CALCOLO AUTO VALORI & AUTO FUNZIONI " //NEW_LINE("A")
    !
    WRITE(*,*) "Lettura parametri di input da file: ", FileInput, NEW_LINE("A")
    !
    OPEN(UNIT=UnitRead,FILE = FileInput,IOSTAT=ioerrInput) 
    !
    READ(UNIT=UnitRead,FMT = *, IOSTAT = ioerrInput)
    READ(UNIT = UnitRead , FMT = *, IOSTAT = ioerrInput) N
    READ(UNIT = UnitRead , FMT = *, IOSTAT = ioerrInput) L,label
    READ(UNIT = UnitRead , FMT = *, IOSTAT = ioerrInput) alpha,label
    READ(UNIT = UnitRead , FMT = *, IOSTAT = ioerrInput) M,label
    !
    CLOSE(UNIT=UnitRead,IOSTAT=ioerrInput)
    !
    WRITE(*,FMT = fmt_write_input)"N =",N," L =",L,"  M =",M,"  alpha = ",alpha
    !
    WRITE(*,*) NEW_LINE("A")
    !
    ! CONTROLLO INSERIMENTO
    CALL Control_Ins()
    !
    WRITE(*,*) "Calcolo ...", NEW_LINE("A")
    !
    ! ALLOCAZIONE VARIABILI DI LAVORO
    LDZ=N
    !
    ALLOCATE(E(N-1))    
    ALLOCATE(D(N))
    ALLOCATE(Work(4*N))
    ALLOCATE(Z(LDZ,N))
    !
    ! CALCOLO: passo di avanzamento h e creazione vettori E e D
    h = L/(N-1)
    E = -1. / h**2 
    !
    !
    DO i = 1,N 
        D(i) = (2./h**2 + (1 - exp(-(alpha)*(h*(i-1) - L/6.d0)))**2)  
    END DO 
    !
    ! Funzione lapack: per determinazione di autovalori & auotovettori : controllare documentazione
    ! http://www.netlib.org/lapack/explore-html/d0/d2f/group__double_p_tcomputational_ga03d834df95ce593c02831f77602cfa7d.html#ga03d834df95ce593c02831f77602cfa7d
    CALL DPTEQR(COMPTZ, N, D, E, Z, LDZ, Work, Info)
    !
    ! CONTROLLO ESECUZIONE DPTEQR()
    CALL Control_DPTEQR()
    !
    ! SCRITTURA AUTOVAL
    CALL Scrittura_File_Autoval()
    !
    ! SCRITTURA AUTOVET
    CALL Scrittura_File_Autovet()
    !
    WRITE(*,*) NEW_LINE("A"), "END TASK A ",NEW_LINE("A")
    !
    !
    !
END PROGRAM Main_A