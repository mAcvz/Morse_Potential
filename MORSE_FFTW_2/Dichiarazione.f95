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
    CHARACTER(LEN =20),DIMENSION(:),ALLOCATABLE :: header, label

    !
    ! UNIT 
    INTEGER,PARAMETER :: unit_input = 10, unit_output_eValues = 12, unit_output_eVectors = 13
    !
    ! UNIT NAME
    CHARACTER(LEN = * ),PARAMETER :: unit_input_name = 'file_input.dat',unit_eValues_name = "file_output_eValues.txt"
    CHARACTER(LEN = * ),PARAMETER :: unit_eVectors_name = "autovet_real.txt"
    !
    ! FORMATI
    CHARACTER(LEN= 20 ) :: fmt_write_row ,fmt_write_header
    CHARACTER(LEN = * ),PARAMETER :: fmt_A_vet="(a,f15.10)",fmt_A_vet_header= "(a,a,8x)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_make_fmt_i1 =  "(a,i1,a,a)", fmt_make_fmt_i2 = "(a,i2,a,a)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_make_fmt_f1 = "(a,a,i1,a,a)", fmt_make_fmt_f2 = "(a,a,i2,a,a)"
    CHARACTER(LEN = * ),PARAMETER :: fmt_lettura_input="(a20,a40)", fmt_scrittura_parametri="(a4,i3,a6,f5.1,a11,f5.3,a6,i2,a10,i6)"
    CHARACTER(LEN = * ),PARAMETER ::  fmt_LWORK_term = "(a40, i7)",fmt_Aval = "(i4,f15.10)"
  
    !
    ! VARIABILI DI CONTROLLO
    INTEGER :: ioerrInput=0
    !
END MODULE Dichiarazione  
