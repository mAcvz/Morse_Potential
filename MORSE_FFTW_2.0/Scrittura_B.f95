MODULE Scrittura_B
    !
    !
    ! Modulo contenente 2 SUBROUTINE dedicate alla scrittura su file: 
    !
    !
    ! 1) SUBROUTINE  Scrittura_A_val (...)
    ! genera 1 file.txt su cui salvare A.valori 
    !
    !
    ! 2) SUBROUTINE Scrittura_A_vet (...)
    ! genera 1 file.txt con M+1 colonne in cui salvare gli A.vettori 
    ! valutati sui punti della griglia 
    !
    USE Dichiarazione_B
    !
    IMPLICIT NONE
    !
    CONTAINS
    !
    ! SUBROUTINE SCRITTURA COLONNE MATRICE H + vettore griglia
    SUBROUTINE Scrittura_A_vet()
        ! GENERA UNA COPPIA DI IDENTIFICATORI ADATTI A STAMPARE "M" COLONNE NEL FILE 
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
        OPEN(unit=unit_output_eVectors,file=unit_eVectors_name,IOSTAT=ioerr)
        IF(M .LT. 10) THEN 
            WRITE(fmt_write_row ,fmt=fmt_make_fmt_f1) '(',"f12.7,",M,fmt_A_vet,')'
            WRITE(fmt_write_header ,fmt=fmt_make_fmt_i1) '(2x,a,8x,',M,fmt_A_vet_header,')'
        ELSE IF (M .LT. 100) THEN 
            WRITE(fmt_write_row ,fmt=fmt_make_fmt_f2) '(',"f12.7,",M,fmt_A_vet,')'
            WRITE(fmt_write_header ,fmt=fmt_make_fmt_i1) '(2x,a,10x,',M,fmt_A_vet_header,')'
        END IF 
        !
        ! SCRITTURA SU FILE DI HEADER & AUTOVETTORI 
        WRITE(unit=unit_output_eVectors,fmt=fmt_write_header,IOSTAT=ioerr) "x",(",",TRIM(header(j)),j=1,M)
        !
        !
        DO i=1,dim_G
            WRITE(unit=unit_output_eVectors,fmt= fmt_write_row,IOSTAT=ioerr) griglia(i),(",",REAL(Avett(i,j)),j=1,M)
        END DO  
        !         
        CLOSE(unit=unit_output_eVectors,IOSTAT=ioerr)
        !
        control_1: IF (ioerr .NE. 0) THEN
            !
            PRINT "('ESITO SCRITTURA FILE AUTOVETTORI : ioerr = ',i1,' ERRORE')",ioerr   ! Esito operazione
            !
        ELSE
            WRITE(*,*) NEW_LINE("A") // "AUTOVETTORI STAMPATI CORRETAMENTE SUL FILE: " , unit_eVectors_name ! Esito operazione
        END IF control_1
    END SUBROUTINE Scrittura_A_vet
    !
    !
    ! SUBROUTINE SCRITTURA AUTO VALORI SU FILE 
    SUBROUTINE Scrittura_A_val()
        !
        OPEN(unit=unit_output_eValues,file=unit_eValues_name,IOSTAT=ioerr)
        WRITE(unit=unit_output_eValues,FMT=fmt_Aval,IOSTAT=ioerr)(i,W(i)/2 ,i=1,M)
        CLOSE(unit=unit_output_eValues,IOSTAT=ioerr)
        control_2: IF (ioerr .NE. 0) THEN
            !
            PRINT "('ESITO SCRITTURA FILE AUTOVALORI : ioerr = ',i1,' ERRORE')",ioerr   ! Esito operazione
            !
        ELSE
            WRITE(*,*) NEW_LINE("A") // "AUTOVALORI STAMPATI CORRETAMENTE SUL FILE: " , unit_eValues_name ! Esito operazione
        END IF control_2
        !
        !
    END SUBROUTINE Scrittura_A_val
!  
END MODULE Scrittura_B