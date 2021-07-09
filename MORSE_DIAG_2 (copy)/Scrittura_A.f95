 MODULE Scrittura_A
    !
    ! Modulo contenente 2 SUBROUTINE dedicate alla scrittura su file: 
    !
    !
    ! 1) SUBROUTINE  Scrittura_File_Autoval (...)
    ! genera 1 file.txt su cui salvare A.valori 
    !
    !
    ! 2) SUBROUTINE Scrittura_File_Autovet (...)
    ! genera 1 file.txt con M+1 colonne in cui salvare gli A.vettori 
    ! valutati sui punti della griglia (con passo N/P)
    !
    USE Dichiarazione_A
    !
    IMPLICIT NONE 
    !
    CONTAINS 
    !
    SUBROUTINE Scrittura_File_Autoval()      !!! scrittura AUTOVALORI
        !
        IMPLICIT NONE 
        !
        !
        OPEN(UNIT=UnitAVAL,FILE=FileName_Autoval,IOSTAT=ioerr)
        !
        WRITE(UNIT=UnitAVAL,FMT='(a22)' ,IOSTAT=ioerr) "Indice     Autovalore"
        !
        WRITE(UNIT=UnitAVAL,FMT= FMTwrite_AV,IOSTAT=ioerr)(i,"    ",D(N-i)/2,i=0,M-1)   ! stampa A.Valori su file
        !
        WRITE(*,*)"Anteprima autovalori:" // NEW_LINE("A")
        WRITE(*,FMT="(i3,f15.10)",IOSTAT=ioerr)(i,D(N-i)/2,i=0,M-1)                  ! stampa A.Valori su display
        !
        CLOSE(UNIT=UnitAVAL,IOSTAT=ioerr)
        !
        control_1: IF (ioerr .NE. 0) THEN
            !
            PRINT "('ESITO SCRITTURA FILE AUTOVALORI : ioerr = ',i1,' ERRORE')",ioerr   ! Esito operazione
            !
        ELSE
            WRITE(*,*) NEW_LINE("A") // "AUTOVALORI STAMPATI CORRETAMENTE SUL FILE: " ,FileName_Autoval ! Esito operazione
        END IF control_1
        !
    END SUBROUTINE Scrittura_File_Autoval
    !
    !
    !
    SUBROUTINE  Scrittura_File_Autovet()
        ! GENEREA UNA COPPIA DI IDENTIFICATORI ADATTI A STAMPARE "M" COLONNE NEL FILE 
        CHARACTER(LEN = 2) :: index
        ALLOCATE(header(M))
        !
        ! VETTORE INDICI IN FORMATO CHARACTER
        DO j=1,M
            WRITE(index,FMT ="(i2)") j 
            header(j) = "A_vet_" // ADJUSTL(index)
         END DO 
        !
        ! GENERAZIONE DESCRITTORI DI FORMATO 
        OPEN(UNIT=unit_output_eVectors,FILE=unit_eVectors_name,IOSTAT=ioerr)
        IF(M .LT. 10) THEN 
            WRITE(fmt_write_row ,FMT=fmt_make_fmt_f1) '(',"f8.4,",M,fmt_A_vet,')'
            WRITE(fmt_write_header ,FMT=fmt_make_fmt_i1) '(2x,a,8x,',M,fmt_A_vet_header,')'
        ELSE IF (M .LT. 100) THEN 
            WRITE(fmt_write_row ,FMT=fmt_make_fmt_f2) '(',"f8.4,",M,fmt_A_vet,')'
            WRITE(fmt_write_header,FMT=fmt_make_fmt_i1) '(2x,a,10x,',M,fmt_A_vet_header,')'
        END IF 
        !
        ! SCRITTURA SU FILE DI HEADER & AUTOVETTORI 
        WRITE(UNIT=unit_output_eVectors,FMT = fmt_write_header,IOSTAT=ioerr) "x",(",",TRIM(header(j)),j=1,M)
        !
        DO i=1,N,N/P
            WRITE(UNIT=unit_output_eVectors,FMT = fmt_write_row,IOSTAT=ioerr) (h*(i-1)),(",",REAL(Z(i,N-j)),j=0,M-1)
        END DO  !fmt_write_row  (f8.4,5(f15.10))  
        !         
        CLOSE(UNIT=unit_output_eVectors,IOSTAT=ioerr)
        control_2: IF (ioerr .NE. 0) THEN
            !
            PRINT "('ESITO SCRITTURA FILE AUTOVETTORI : ioerr = ',i1,' ERRORE')",ioerr   ! Esito operazione
            !
        ELSE
            WRITE(*,*) NEW_LINE("A") // "AUTOVETTORI STAMPATI CORRETAMENTE SUL FILE: " , unit_eVectors_name ! Esito operazione
        END IF control_2
        !
    END SUBROUTINE Scrittura_File_Autovet
    !
    !
    !
END MODULE Scrittura_A
