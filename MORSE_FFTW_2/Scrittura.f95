MODULE Scrittura
    USE Dichiarazione
    !
    IMPLICIT NONE
    !
    CONTAINS
    !
    !
    !SUBROUTINE SCRITTURA COLONNE MATRICE Ham
    SUBROUTINE Scrittura_A_vet()
        IF(M .LE. 9) THEN 
            WRITE(fmt_write_row ,fmt="(a1,i1,a6,a1)") '(',M,fmt_A_vet,')'
        ELSE IF (M .LE. 99) THEN 
            WRITE(fmt_write_row ,fmt="(a1,i2,a6,a1)") '(',M,fmt_A_vet,')'
        END IF 
        !
        OPEN(unit=7,file='autovet_real.txt')
        DO i=1,N
        WRITE(unit=7,fmt= fmt_write_row )(real(Avett(i,j)),j=1,M) ! non corrispondono a quelli dello spazio reale
        !
        END DO
        CLOSE(unit=7)
        !
    END SUBROUTINE Scrittura_A_vet
        

END MODULE