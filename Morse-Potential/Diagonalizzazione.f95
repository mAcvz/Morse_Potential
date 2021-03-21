PROGRAM Diagonalizzazione
    ! 
    ! Programma che prende in ingresso L,N,M e richiama la funzione lapack DPTEQR(...)  per 
    ! risolvere l'EQ. di Schrodinger unidimensionale per un potenziale armonico. Il problema
    ! viene affrontato determinando A.Valori e A.Vettori (riscalati) di una matrice tridiagonale. 
    ! Il programma salva su file.txt i risultati ottenuti
    ! 
    ! VARIABLES dichiarate in MODULE Dichiazione
    ! SUBROUTINE di controllo in MODULE Control
    ! SUBROUTINE per salvataggio su file in MODULE Scrittura_File
    !
    ! PER MAGGIORI INFORMAZIONI CONTROLLARE DOCUMENTAZIONE DI OGNI "MODULE"
    !
    USE Dichiarazione
    USE Scrittura_File
    USE Control
    !
    IMPLICIT NONE    
    !
    !
    ! Lettura RANGE, N°PUNTI e N° Autovalori & Autovettori
    !
    WRITE(*,*) "PROGRAMMA:  "
    !
    WRITE(*,*) "OSCILLATORE ARMONICO QUANTISTICO: CALCOLO AUTO VALORI & AUTO FUNZIONI "
    WRITE(*,*)
    !
    WRITE(*,*) "Lettura parametri da file in corso: " 
    WRITE(*,*)
    !
    OPEN(UNIT=UnitRead,FILE = FileInput,IOSTAT=ioerrInput) 
    !
    READ(UNIT=UnitRead,FMT = *,IOSTAT = ioerrInput)
    !
    READ(UNIT=UnitRead,FMT = *,IOSTAT = ioerrInput) N,L,M
    !
    CLOSE(UNIT=UnitRead,IOSTAT=ioerrInput)
    !
    print*,N,L,M
    
    !WRITE(*,*) "RANGE INTERVALLO L =  "
    !READ(*,*,IOSTAT = ioerrL) L
    !
    !WRITE(*,*) 'N° punti di suddivisione griglia N = '
    !READ(*,*,IOSTAT = ioerrN) N
    !
    !WRITE(*,*) 'N° AutoVAL / AutoVETT salvati M = '
    !READ(*,*,IOSTAT = ioerrM) M  
    !
    !
    ! CONTROLLO INSERIMENTO
    CALL Control_Ins()
    !
    WRITE(*,*)"Calcolo ..."
    !
    ! ALLOCAZIONE VARIABILI DI LAVORO
    !
    LDZ=N
    !
    ALLOCATE(E(N-1))
    ALLOCATE(D(N))
    ALLOCATE(Work(4*N))
    ALLOCATE(Z(LDZ,N))
    !
    !
    ! CALCOLO: passo di avanzamento h e creazione vettori E e D
    h = L/(N-1)
    E = -1. / h**2 
    !
    DO i = 1,N 
        D(i) = (2./h**2 + (-L/2. + h*(i-1))**2 )
    END DO 

    !
    !
    ! Funzione lapack: per determinazione di autovalori & auotovettori : controllare documentazione
    ! http://www.netlib.org/lapack/explore-html/d0/d2f/group__double_p_tcomputational_ga03d834df95ce593c02831f77602cfa7d.html#ga03d834df95ce593c02831f77602cfa7d
    CALL DPTEQR(COMPTZ, N, D, E, Z, LDZ, Work, Info)
    !
    !
    ! CONTROLLO ESECUZIONE DPTEQR()
    CALL Control_DPTEQR()
    !
    !
    ! SCRITTURA AUTOVAL
    CALL Scrittura_File_Autoval()
    !
    !
    ! SCRITTURA AUTOVETTORI 
    CALL Scrittura_File_Autovet()
    !
    !
    ! SCRITTURA FILE GRIGLIA PUNTI
    CALL Scrittura_File_Griglia()
    !
    !
    !
    END PROGRAM Diagonalizzazione