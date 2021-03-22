
MODULE Dichiarazione
    !
    ! Modulo contenente variabili di lavoro della funzione lapack DPTEQR(...)
    ! e variabili per il funzionamento del main programm (Diagonalizzazione)
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
    ! Work - variabile di lavoro pr DPTEQR(...)
    ! Info - varivabile di controllo per la funzione DPTEQR(...)
    ! COMPTZ - parametro gestione out-put di DPTEQR()
    !
    ! PER ULTERIORI INF. CONSULTARE DOCUMENTAZIONE DPTEQR(COMPTZ, N, D, E, Z, LDZ, Work, Info)
    !
    !
    ! Variabili di lavoro del main programm :
    !
    ! M - numero di autovalori & autovettori salvati su file
    ! P - Gli autovettori verrano valutati su N punti ma salvati su file con passo N/P
    ! alpha - parametro che determina l'ampiezza della buca di potenziale di morse
    ! ( ioerr,ioerrInput ) - variabili di controllo 
    ! ( UnitAVAL, UnitGRIGLIA ,UnitAVET,UnitRead)    - numero varie unità  di memoria
    !
    !
    ! FMTwrite - variabile formato di stampa usato  nella scrittura di Autovalori e Griglia punti
    ! FMTwrite_AV - variabile formato di stampa usato  nella scrittura degli Autovettori
    ! FMT_fileA,FMT_fileB) - formati di stampa usati per generare la succesione di nomi "file_dati_autovet"
    !
    !
    ! FileName_Autoval - nome file.txt autovolori in fase di salvataggio su disco
    ! File_Punti_Valutazione - nome file.txt punti della griglia in fase di salvataggio su disco
    ! FileInput - nome file.txt in cui sono salvati i parametri del problema
    ! file_dati_autovet - nome file.txt autovettori in fase di salvataggio su disco 
    ! name_start - variabile usata per generazione nomi file.txt progressivi (autovettori)
    ! name_end - variable usata per generazione nomi file.txt progressivi in USCITA (autovettori)
    ! 
    !
    !
    IMPLICIT NONE   
    !
    !
    INTEGER :: N, LDZ,Info
    CHARACTER,PARAMETER :: COMPTZ = 'I'
    DOUBLE PRECISION:: h, L,alpha
    DOUBLE PRECISION, DIMENSION(:), ALLOCATABLE :: D, E, Work
    DOUBLE PRECISION, DIMENSION(:,:), ALLOCATABLE :: Z 
    !
    !
    !Variabili di controllo
    INTEGER :: k,i,M,ioerr=0,ioerrInput=0
    INTEGER, PARAMETER :: P = 200
    !
    !
    !Unità  scrittura su file
    INTEGER,PARAMETER :: UnitRead = 11, UnitAVAL = 12, UnitGRIGLIA = 13
    INTEGER :: UnitAVET = 14
    !
    !
    !Formati scrittura su file 
    CHARACTER(LEN = * ),PARAMETER :: FMTwrite = "(f15.10)"
    CHARACTER(LEN = * ),PARAMETER :: FMTwrite_AV = "(i3,a4,f15.10)"
    CHARACTER(LEN = * ),PARAMETER :: FMT_fileA = "(A20,i1,A4)", FMT_fileB = "(A20,i2,A4)"
    !
    !
    !Nomi file in fase di salvataggio su disco
    CHARACTER(LEN = * ),PARAMETER :: FileName_Autoval = "autoval.txt"
    CHARACTER(LEN = * ),PARAMETER :: File_Punti_Valutazione = "Punti_valutazione.txt"
    CHARACTER(LEN = 50) :: file_dati_autovet
    CHARACTER(LEN = 50) :: FileInput = "Input.txt"
    CHARACTER(LEN = * ),PARAMETER :: name_start = "dati_autovet_n="
    CHARACTER(LEN = 50) :: name_end   
    !
END MODULE Dichiarazione
