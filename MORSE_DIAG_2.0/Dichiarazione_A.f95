
MODULE Dichiarazione_A
    !
    ! Modulo contenente variabili di lavoro della funzione lapack DPTEQR(...)
    ! e variabili per il funzionamento del main programm (Main_A)
    ! DOCUMENTAZIONE: 
    ! http://www.netlib.org/lapack/explore-html/d0/d2f/group__double_p_tcomputational_ga03d834df95ce593c02831f77602cfa7d.html#ga03d834df95ce593c02831f77602cfa7d
    ! 
    !
    ! Variabili : DPTEQR(COMPTZ, N, D, E, Z, LDZ, Work, Info)
    !
    ! L - ampiezza intervallo 
    ! N - numero di punti in cui dividere intervallo L
    ! h - distanza punti successivi
    ! D (in)  - diagonale principale della matrice studiata 
    ! D (out) - autovalori in ordine decrescente della matrice studiata
    ! E (in)  - sottodiagonale principale della matrice interessata
    ! E (out) - dealloacata in seguito all'esecuzione di DPTEQR(...)
    ! Z (out) - Matrice(LDZ,N) contenente autovettori della matrice studiata 
    ! LDZ  - dimensione dominante della matrice Z
    ! Work - variabile di lavoro per DPTEQR(...)
    ! Info - variabile di controllo per la funzione DPTEQR(...)
    ! COMPTZ - parametro gestione output di DPTEQR()
    !
    ! PER ULTERIORI INF. CONSULTARE DOCUMENTAZIONE DPTEQR(COMPTZ, N, D, E, Z, LDZ, Work, Info)
    !
    !
    ! Variabili di lavoro del main programm :
    !
    ! M - numero di autovalori & autovettori salvati su file
    ! P - Gli autovettori verrano valutati su N punti ma salvati su file con passo N/P
    ! MaxN - numero massimo di punti su cui valutare il potenziale 
    ! WarnN_B - numero di punti elevato - tempistiche elevate 
    ! WarnN_L - numero di punti esiguo - bassa precisione 
    ! xo - punto della griglia che identifica la distanza all'equiliburio
    ! alpha - parametro che determina l'ampiezza della buca di potenziale di morse
    ! ( ioerr,ioerrInput ) - variabili di controllo 
    ! ( UnitAVAL,UnitAVET,UnitRead) - numero varie unità  di memoria
    !
    ! (fmt_ ...) - variabili contenenti i vari formati sotto forma di stringa 
    !
    !
    ! FileName_Autoval - nome file.txt autovalori in fase di salvataggio su disco
    ! FileName_Autovet - nome file.txt autovettoir in fase di salvataggio su disco 
    ! 
    ! label - variabile junk che prende in ingresso stringhe 
    ! header - vettore di tipo CHARACTER contenente le intestazioni delle diverse colonne
    ! (i,j,k) - variabili iterative
    !
    IMPLICIT NONE   
    !
    !
    INTEGER :: N, M, LDZ, Info
    CHARACTER,PARAMETER :: COMPTZ = 'I'
    DOUBLE PRECISION,PARAMETER :: xo = 5.d0
    DOUBLE PRECISION:: h, L, alpha
    DOUBLE PRECISION, DIMENSION(:), ALLOCATABLE :: D, E, Work
    DOUBLE PRECISION, DIMENSION(:,:), ALLOCATABLE :: Z 
    !
    !
    ! VARIABILI DI CONTROLLO
    INTEGER :: ioerr=0, ioerrInput=0
    !
    !
    INTEGER :: k,i,j
    INTEGER, PARAMETER :: P = 200, MaxN = 12000, WarnN_B = 4000 , WarnN_L = 20    
    !
    !
    ! UNITA' SCRITTURA SU FILE 
    INTEGER,PARAMETER :: UnitRead = 11, UnitAVAL = 12, UnitAVET = 14
    !
    !
    ! FORMATI SCRITTURA FILE
    CHARACTER(LEN= 20 ) :: fmt_write_row ,fmt_write_header
    CHARACTER(LEN = * ),PARAMETER :: fmt_A_vet="(a,f15.10)",fmt_A_vet_header= "(a,a,8x)",fmt_write_AV = "(i3,a4,f15.10)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_make_fmt_i1 =  "(a,i1,a,a)", fmt_make_fmt_i2 = "(a,i2,a,a)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_write_input = "(a,i6,a,f6.1,a,i2,a,f5.3)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_make_fmt_f1 = "(a,a,i1,a,a)", fmt_make_fmt_f2 = "(a,a,i2,a,a)"
    !
    !
    ! NOMI FILE LETTURA & SCRITTURA 
    CHARACTER(LEN = * ),PARAMETER :: FileName_Autoval = "autoval.txt", FileName_Autovet = "autovet.txt"
    CHARACTER(LEN = 50) :: FileInput = "file_input.txt"
    !
    ! SCRITTURA & LETTURA
    CHARACTER(LEN = 300 ):: label
    CHARACTER(LEN = 50),DIMENSION(:), ALLOCATABLE :: header
    !
    !
    !
END MODULE Dichiarazione_A
