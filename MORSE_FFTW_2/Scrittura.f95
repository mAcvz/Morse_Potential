MODULE Scrittura
    USE Dichiarazione
    !
    IMPLICIT NONE
    !
    CONTAINS
    !
    !
    ! SUBROUTINE SCRITTURA COLONNE MATRICE Ham
    SUBROUTINE Scrittura_A_vet()
        IF(M .LE. 9) THEN 
            WRITE(fmt_write_row ,fmt=fmt_make_fmt_1) '(',M,fmt_A_vet,')'
        ELSE IF (M .LE. 99) THEN 
            WRITE(fmt_write_row ,fmt=fmt_make_fmt_2) '(',M,fmt_A_vet,')'
        END IF 
        !
        OPEN(unit=unit_output_eVectors,file=unit_eVectors_name)
        DO i=1,N
        WRITE(unit=unit_output_eVectors,fmt= fmt_write_row )(real(Avett(i,j)),j=1,M)
        !
        END DO
        CLOSE(unit=unit_output_eVectors)
        !
    END SUBROUTINE Scrittura_A_vet
    !
    !
    ! SUBROUTINE SCRITTURA AUTO VALORI SU FILE 
    SUBROUTINE Scrittura_A_val()
        !
        OPEN(unit=unit_output_eValues,file=unit_eValues_name)
        WRITE(unit=unit_output_eValues,FMT=fmt_Aval)(i,W(i)/2 ,i=1,5)
        CLOSE(unit=unit_output_eValues)
        !
    END SUBROUTINE Scrittura_A_val
        

END MODULE