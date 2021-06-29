 MODULE Scrittura_File
    !
    ! Modulo contenente 3 SUBROUTINE dedicate alla scrittura su file: 
    !
    !
    ! 1) SUBROUTINE  Scrittura_File_Autoval (...)
    ! genera 1 file.txt su cui salvare A.valori 
    !
    !
    ! 2) SUBROUTINE Scrittura_File_Autovet (...)
    ! genera M file.txt su M unità differenti in ordine progressivo su cui salvare gli A.vettori 
    ! valutati sui punti della griglia (con passo N/P)
    !
    !
    ! 3) SUBROUTINE Scrittura_File_Griglia
    ! genera 1 file.txt su cui salvare i punti della griglia con passo N/P
    !
    !
    USE Dichiarazione   
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
    SUBROUTINE Scrittura_File_Autovet()  !!! scrittura AUTOVETTORI
        !
        IMPLICIT NONE 
        !
        !
        NameFileDO : DO k = 0, M-1                                                                 ! ciclo per stampa su file progressivi
        !
        ! 
        UnitAVET  = UnitAVET  + k 
        !
        control_2: IF (k < 10) THEN
            !
            WRITE(file_dati_autovet,FMT_fileA ) name_start,k,".txt"                                ! Generazione  nome fileA.txt
            !
        ELSE  
            !
            WRITE(file_dati_autovet,FMT_fileB) name_start,k,".txt"                                 ! Generazione  nome fileB.txt
            !
        END IF control_2
        !
        file_dati_autovet = ADJUSTL(file_dati_autovet) 
        !
        OPEN(UNIT = UnitAVET , FILE = file_dati_autovet, IOSTAT = ioerr) 
        !
        WRITE(UNIT = UnitAVET ,FMT= FMTwrite,IOSTAT=ioerr)(Z(i,LDZ-k),i=1,N,N/P)                    ! Scrittura A.Vettori                  
        !
        CLOSE(UNIT = UnitAVET ,IOSTAT=ioerr)
        !
        control_3: IF (ioerr .NE. 0) THEN
            !
            PRINT"('ESITO SCRITTURA ',i4,'° AUTOVETTORE: ioerr = ',i1,' ERRORE')",k+1,ioerr        ! Esito scrittura
            !
        END IF control_3
        !
        END DO NameFileDO
        !
        !
        !
        control_4: IF (ioerr .EQ. 0)  THEN 
        !
            WRITE(name_end,"(a15,a19,i2)") name_start,"i.txt   i = 0,1 ...",M-1
            !
            WRITE(*,*) NEW_LINE("A") // "AUTOVETTORI STAMPATI CORRETAMENTE SUI FILE: ", name_end, NEW_LINE("A")                 ! Esito operazione
        ELSE 
        !
            WRITE(*,*) "AUTOVETTORI NON SALVATI CORRETTAMENTE"                                     ! Esito scrittura
        !
        END IF control_4
        !
    END SUBROUTINE Scrittura_File_Autovet
    !
    !
    !
    SUBROUTINE Scrittura_File_Autovet_Mono_file()
    END SUBROUTINE Scrittura_File_Autovet_Mono_file

    !
    !
    !
    SUBROUTINE  Scrittura_File_Griglia()   !!! scrittura GRIGLIA
        !
        IMPLICIT NONE 
        !
        !
        !
        OPEN(UNIT=UnitGRIGLIA,FILE=File_Punti_Valutazione,IOSTAT=ioerr)
        !
        WRITE(UNIT=UnitGRIGLIA,FMT= FMTwrite,IOSTAT=ioerr)( h*(i-1),i=1,N,N/P)
        !
        CLOSE(UNIT=UnitGRIGLIA,IOSTAT=ioerr)
        ! 
        control_5: IF (ioerr .NE. 0) THEN
            !
            PRINT "('ESITO SCRITTURA PUNTI DI VALUTAZIONE : ioerr = ',i1,' ERRORE')",ioerr         ! Esito scrittura
            !
        END IF control_5
        !
    END SUBROUTINE Scrittura_File_Griglia
!
!
!
END MODULE Scrittura_File
