MODULE Dichiarazione_B
    !
    !
    ! Modulo contenente variabili di lavoro della funzione lapack ZHEEV(...)
    ! e variabili per il funzionamento del main program (Main_B)
    ! DOCUMENTAZIONE: 
    ! http://www.netlib.org/lapack/explore-html/df/d9a/group__complex16_h_eeigen_gaf23fb5b3ae38072ef4890ba43d5cfea2.html#gaf23fb5b3ae38072ef4890ba43d5cfea2
    ! 
    !
    ! Variabili : ZHEEV(JOBZ,UPLO,N,A,LDA,W,WORK,LWORK,RWORK,INFO)
    !
    !
    ! N - ordine della matrice A & numero di onde piane della base
    !
    ! JOBZ ---- valori possibili: 'N' & 'V'
    !         - JOBZ = 'N' => subroutine determina solo gli autovalori 
    !         - JOBZ = 'V' => subroutine determina autovalori & autovettori
    ! UPLO ---- valori possibili: 'U' & 'L'
    !         - UPLO = 'U' => matrice A triangolare superiore 
    !         - UPLO = 'L' => matrice A triangolare inferiore
    ! A = H (in)  - matrice hermitiana di dimensione (LDA, N) - triangolare sup. o inf.
    ! A = H (out) - se JOBZ = 'V' & INFO = 0 => matrice contenente autovettori in colonna
    !               - se JOBZ = 'N' => dealloacata in seguito all'esecuzione di ZHEEV(...)
    ! W (out) - vettore contenente gli tutti autovalori 
    ! LDA     - dimensione dominante della matrice A
    ! WORK    - variabile di lavoro per ZHEEV(...)
    ! LWORK   - lunghezza ottimale del vettore WORK 
    ! RWORK   - DOUBLE PRECISION array, di dimensione (max(1, 3*N -2))
    ! INFO    - variabile di controllo per la funzione ZHEEV(...)
    !
    ! PER ULTERIORI INF. CONSULTARE DOCUMENTAZIONE ZHEEV(COMPTZ, N, D, E, Z, LDZ, Work, Info)
    !
    !
    ! Variabili di lavoro del main program:
    ! xo - punto della griglia che identifica la distanza all'equilibrio
    ! alpha - parametro che determina l'ampiezza della buca di potenziale di morse
    ! L - ampiezza intervallo 
    ! x - prima griglia su cui valutare il potenziale
    ! dx - distanza punti successivi nella griglia x
    ! griglia - griglia valutazione autovettori in spazio reale 
    ! step - distanza punti successi nella griglia di valutazione 
    ! M - numero di autovalori & autovettori salvati su file
    !
    ! (unit_input, unit_output_eValues, unit_output_eVectors) - numero varie unità  di memoria
    ! unit_input_name - file.txt di input
    ! unit_eValues_name - file.txt output autovalori
    ! unit_eVectors_name - file.txt output autovettori
    ! fmt_(...) - variabili contenenti i vari formati sotto forma di stringa 
    !
    ! ( ioerr,ioerrInput ) - variabili di controllo 
    ! (i,j,s) - variabili iterative
    ! sum - variabile di lavoro (accumulatore)
    ! (dp,pi) - costanti di lavoro
    !
    ! plan - piano di lavoro della routine FFTW3
    ! in - vettore contenente il potenziale di morse valutato sui punti x
    ! out - vettore contente la FFT del potenziale di morse 
    ! K_vec - vettore contenente i vettori d'onda delle onde piane della base
    !
    ! Avett - matrice di dimensione (dim_G,M) contenente i primi M autovettori (parte reale)
    ! 
    ! label - variabile junk che prende in ingresso stringhe 
    ! header - vettore di tipo CHARACTER contenente le intestazioni delle diverse colonne
    ! norma - variabile di normalizzazione delle autofunzioni 
    !
    IMPLICIT NONE
    ! COSTANTI DI LAVORO 
    INTEGER,PARAMETER :: dp =  KIND(0.d0)
    REAL(KIND = dp),PARAMETER :: pi =  acos(-1.d0)
    INTEGER,PARAMETER :: dim_G = 200
    COMPLEX(KIND=dp), PARAMETER :: img = dcmplx(0,1)
    ! 
    !
    INTEGER :: N,M,i,j,s, INFO,LWORK
    CHARACTER,PARAMETER :: JOBZ = "V", UPLO = "U"
    REAL(KIND = dp),PARAMETER :: xo = 5.d0
    REAL(KIND = dp) :: dx,L,alpha,step,norma
    INTEGER(KIND = dp) :: plan
    REAL(KIND = dp),DIMENSION(:),ALLOCATABLE :: x,w,K_vec,RWORK
    COMPLEX(KIND = dp),DIMENSION(:),ALLOCATABLE :: in, out, WORK
    COMPLEX(KIND = dp),DIMENSION(:,:),ALLOCATABLE :: H, Avett
    CHARACTER(LEN =20),DIMENSION(:),ALLOCATABLE :: header
    REAL(KIND = dp),DIMENSION(dim_G) :: griglia
    COMPLEX(KIND = dp) :: sum = (0.d0,0.d0)
    !
    ! UNITS 
    INTEGER,PARAMETER :: unit_input = 10, unit_output_eValues = 12, unit_output_eVectors = 13
    !
    ! UNITS NAME
    CHARACTER(LEN = * ),PARAMETER :: unit_input_name = 'file_input.txt',unit_eValues_name = "autoval.txt"
    CHARACTER(LEN = * ),PARAMETER :: unit_eVectors_name = "autovet.txt"
    !
    ! FORMATI
    CHARACTER(LEN = 300 ):: label
    CHARACTER(LEN = 20 ) :: fmt_write_row ,fmt_write_header
    CHARACTER(LEN = * ),PARAMETER :: fmt_A_vet="(a,f15.10)",fmt_A_vet_header= "(a,a,8x)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_make_fmt_i1 =  "(a,i1,a,a)", fmt_make_fmt_i2 = "(a,i2,a,a)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_make_fmt_f1 = "(a,a,i1,a,a)", fmt_make_fmt_f2 = "(a,a,i2,a,a)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_scrittura_parametri="(a,i4,a,f7.1,a,f7.3,a,i2,a,i7)"
    CHARACTER(LEN = * ),PARAMETER ::  fmt_LWORK_term = "(a,i7)",fmt_Aval = "(i4,f20.10)"
    !
    ! VARIABILI DI CONTROLLO
    INTEGER :: ioerrInput=0,ioerr=0

!
END MODULE Dichiarazione_B
