MODULE Dichiarazione

    IMPLICIT NONE
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

END MODULE Dichiarazione  
