MODULE Dichiarazione

    IMPLICIT NONE
    !
    INTEGER,PARAMETER :: dp =  KIND(    0.d0)
    REAL(KIND=dp),PARAMETER :: pi =  acos(-1.d0)
    INTEGER :: N,M,i,j,s, INFO,LWORK
    CHARACTER,PARAMETER :: JOBZ = "V", UPLO = "U"
    REAL(KIND=dp) :: h,L,alpha
    INTEGER(KIND=dp) :: plan
    COMPLEX(KIND=dp) :: sum = (0.d0,0.d0)
    REAL(KIND=dp),DIMENSION(:),ALLOCATABLE :: x,w,K_vec,RWORK
    COMPLEX(KIND=dp),DIMENSION(:),ALLOCATABLE :: in, out, WORK
    COMPLEX(KIND=dp),DIMENSION(:,:),ALLOCATABLE :: Ham, V, Avett
    CHARACTER(LEN= 20 ) :: fmt_write_row 
    CHARACTER(LEN = * ),PARAMETER :: fmt_A_vet="f15.10"
    !
    ! UNIT 
    INTEGER,PARAMETER :: unit_input = 10, unit_output_eValues = 12, unit_output_eVectors = 13
    !
    ! UNIT NAME
    CHARACTER(LEN = * ),PARAMETER :: unit_input_name = 'file_input.dat',unit_eValues_name = "file_output_eValues.txt"
    CHARACTER(LEN = * ),PARAMETER :: unit_eVectors_name = "autovet_real.txt"
    !
    ! FORMATI
    CHARACTER(LEN = * ),PARAMETER :: fmt_lettura_input="(a20,a40)", fmt_scrittura_parametri="(a4,i3,a6,f5.1,a11,f5.3,a6,i2,a10,i6)"
    CHARACTER(LEN = * ),PARAMETER ::  fmt_LWORK_term = "(a40, f10.1)",fmt_Aval = "(i4,f15.10)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_make_fmt_1 = "(a1,i1,a6,a1)", fmt_make_fmt_2 = "(a1,i2,a6,a1)"
    !
    ! VARIABILI DI CONTROLLO
    INTEGER :: ioerrInput=0
    !
END MODULE Dichiarazione  
