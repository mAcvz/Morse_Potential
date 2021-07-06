MODULE Scrittura
    USE Dichiarazione
    !
    IMPLICIT NONE
    !
    CONTAINS
    !
    !
    ! SUBROUTINE SCRITTURA COLONNE MATRICE Ham + vettore X
    SUBROUTINE Scrittura_A_vet()
        ! GENEREA UNA COPPIA DI IDENTIFICATORI ADATTI A STAMPARE "M" COLONNE NEL FILE 
        CHARACTER(LEN = 2) :: index
        ALLOCATE(header(M))
        !
        ! VETTORE INDICI IN FORMATO CHARACTER
        DO j=1,M
            WRITE(index,fmt="(i2)") j 
            header(j) = "A_vet_" // ADJUSTL(index)
         END DO 
        !
        ! GENERAZIONE DESCRITTORI DI FORMATO 
        OPEN(unit=unit_output_eVectors,file=unit_eVectors_name)
        IF(M .LT. 10) THEN 
            WRITE(fmt_write_row ,fmt=fmt_make_fmt_f1) '(',"f8.4,",M,fmt_A_vet,')'
            WRITE(fmt_write_header ,fmt=fmt_make_fmt_i1) '(2x,a,8x,',M,fmt_A_vet_header,')'
        ELSE IF (M .LT. 100) THEN 
            WRITE(fmt_write_row ,fmt=fmt_make_fmt_f2) '(',"f8.4,",M,fmt_A_vet,')'
            WRITE(fmt_write_header ,fmt=fmt_make_fmt_i1) '(2x,a,8x,',M,fmt_A_vet_header,')'
        END IF 
        !
        ! SCRITTURA SU FILE DI HEADER & AUTOVETTORI 
        WRITE(unit=unit_output_eVectors,fmt=fmt_write_header) "x",(TRIM(header(j)),j=1,M)
        !
        DO i=1,N
            WRITE(unit=unit_output_eVectors,fmt= fmt_write_row) x(i),(REAL(Avett(i,j)),j=1,M)
        END DO
        !         
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
    !
    !
    
END MODULE