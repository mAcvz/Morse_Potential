MODULE Control !!! verifica funzionamento github
    !
    ! Modulo contenente 2 subroutine con il compito di gestire eventuali errori:
    !
    ! 1) SUBROUTINE Control_Ins(...) gestisce gli errori commessi in fase di inserimento
    !
    ! 2) SUBROUTINE Control_DPTEQR(...) segnala l'esecuzione / non esecuzione di DPTEQR(...)
    !
    !
    USE Dichiarazione
    !
    IMPLICIT NONE 
    !
    CONTAINS
    !
    SUBROUTINE Control_Ins()
        !
        !
        CHARACTER :: answer 
        !
        !
        IF (ioerrInput .EQ. 0 )  THEN  ! CONTROLLO LETTURA
            !
            CONTINUE
            !
        ELSE
            !
            WRITE(*,*) "(ERRORE DI INSERIMENTO: L,N,M non sono stati inseriti corretamente - ARRESTO)"
            STOP
            !
        END IF
        !
        !
        !
        IF ( M > 99) THEN                     ! CONTROLLO N° A.VETTORI & A.VALORI STAMPATI
            WRITE(*,*) "ERRORE: n° di autovettori richiesti in fase di stampa ECCESSIVO - ARRESTO"
            STOP
            !
        ELSE IF (M > 10 ) THEN                ! CONTROLLO NUMERO PUNTI 1 
            !
            WRITE(*,'(a43,i2,a9)') "WARNING: n° M elevato - VERRANNO GENERATI  ", M + 2,' file.txt'
            WRITE(*,*) "Si desidera continuare?  y/n"
            !
            READ(*,*,IOSTAT = ioerrInput) answer
            !
            IF (ioerrInput .EQ. 0 .AND. answer .EQ. "y") THEN
            !
                CONTINUE
            !
            ELSE
            !
                WRITE(*,*) "OPERAZIONE ANNULLATA - ARRESTO"
                STOP
            END IF 
            !
        ELSE IF (N < 200 ) THEN                ! CONTROLLO NUMERO PUNTI 1 
            !
            WRITE(*,*) "ERRORE: n° di punti inferiore al minimo N(min) = 201 "
            STOP
            !
        ELSE IF (N > 12000) THEN               ! CONTROLLO NUMERO PUNTI 2
            !
            WRITE(*,*) "ERRORE: n° di punti selezionato  troppo elevato - ARRESTO "
            STOP
            !
        ELSE IF (N > 4000 ) THEN               ! CONTROLLO NUMERO PUNTI 3
            !
            WRITE(*,*) "WARNING: n° di punti selezionato elevato - L' operazione potrebbe richiedere alcuni minuti "
            !
        ELSE IF (N/L < 20) THEN                ! CONTROLLO AMPIEZZA INTERVALLO 
            !
            WRITE(*,*) "WARNING: Rapporto N/L < 20 - Il numero di punti potrebbe non essere sufficiente"
            !
        ELSE     
            !
            CONTINUE
            !
        ENDIF 
    END SUBROUTINE Control_Ins
    !
    !
    !
    SUBROUTINE Control_DPTEQR()
        !
        ! CONTROLLO CORRETTA ESECUZIONE DI DPTEQR(...)
        ! Se Info .NE. 0 allora DPTEQR(...) è andata incontro ad errori
        !
        !
        IF (Info == 0)  THEN 
            !
            WRITE(*,*)"CALCOLO A.VAL & A.VET COMPLETATO"
            WRITE(*,*)"Stampa su file ..."
            !
        ELSE
            !
            WRITE(*,*) "MANCATA ESECUZIONE DELLA FUNZIONE  dpteqr()'"
            !
        END IF 
    END SUBROUTINE Control_DPTEQR
    !
    !
    !
END MODULE Control