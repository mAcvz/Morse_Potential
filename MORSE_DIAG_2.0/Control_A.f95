MODULE Control_A
    !
    ! Modulo contenente 2 subroutine con il compito di gestire eventuali errori:
    !
    ! 1) SUBROUTINE Control_Ins(...) gestisce gli errori commessi in fase di inserimento
    !
    ! 2) SUBROUTINE Control_DPTEQR(...) segnala l'esecuzione / non esecuzione di DPTEQR(...)
    !
    !
    USE Dichiarazione_A
    !
    IMPLICIT NONE 
    !
    CONTAINS
    !
    SUBROUTINE Control_Ins()
        !
        CHARACTER :: answer 
        !
        IF (N .LE. 0 .OR. L .LE. 0 .OR. M .LE. 0 .OR. alpha .LT. 0  )  THEN  ! CONTROLLO POSITIVITA'
            WRITE(*,*) "OPERAZIONE ANNULLATA - valori in ingresso non corretti"
            STOP
        ELSE
        !
        END IF 
        !
        !    
        IF (ioerrInput .EQ. 0 )  THEN  ! CONTROLLO LETTURA
            CONTINUE
        ELSE
            WRITE(*,*) "(ERRORE DI INSERIMENTO: L,N,M,alpha non sono stati inseriti corretamente - ARRESTO)"
            STOP
        END IF
        !
        !
        IF (alpha .LT. 0 .OR. alpha .GT. 6.0 ) THEN  ! CONTROLLO RANGE DI ALPHA
            WRITE(*,*) "OPERAZIONE ANNULLATA - valore di alpha non appartenente a range limite [0,6.0]"
            STOP
        END IF 
        !
        IF ( M .GT. 99) THEN                     ! CONTROLLO N° A.VETTORI & A.VALORI STAMPATI
            WRITE(*,*) "ERRORE: n° di autovettori richiesti in fase di stampa ECCESSIVO - ARRESTO"
            STOP
        ELSE IF (M > 10 ) THEN                   ! CONTROLLO NUMERO PUNTI 1 
            WRITE(*,'(a43,i2,a9)') "WARNING: n° M elevato - VERRANNO GENERATI  ", M + 2,' file.txt'
            WRITE(*,*) "Si desidera continuare?  y/n"
            READ(*,*,IOSTAT = ioerrInput) answer
            IF (ioerrInput .EQ. 0 .AND. answer .EQ. "y") THEN  
                CONTINUE 
            ELSE
                WRITE(*,*) "OPERAZIONE ANNULLATA - ARRESTO"
                STOP
            END IF 
            !
        ELSE IF (N .LT. P ) THEN                ! CONTROLLO NUMERO PUNTI 1 
            WRITE(*,FMT="(a,i4)") "ERRORE: n° di punti inferiore al minimo N(min) = ",P+1
            STOP
        ELSE IF (N .GT. MaxN) THEN               ! CONTROLLO NUMERO PUNTI 2
            WRITE(*,*) "ERRORE: n° di punti selezionato  troppo elevato - ARRESTO "
            STOP
        ELSE IF (N .GT. WarnN_B ) THEN               ! CONTROLLO NUMERO PUNTI 3
            WRITE(*,*) "WARNING: n° di punti selezionato elevato - L'operazione potrebbe richiedere alcuni minuti "
        ELSE IF (N/L .LT. WarnN_L) THEN                ! CONTROLLO AMPIEZZA INTERVALLO 
            WRITE(*,*) "WARNING: Rapporto N/L < 20 - Il numero di punti potrebbe non essere sufficiente"
        ELSE     
            CONTINUE
        ENDIF 
        !
    END SUBROUTINE Control_Ins
    !
    !
    !
    SUBROUTINE Control_DPTEQR()
        !
        ! CONTROLLO CORRETTA ESECUZIONE DI DPTEQR(...)
        ! Se Info .NE. 0 allora DPTEQR(...) è andata incontro ad errori
        IF (Info == 0)  THEN 
            WRITE(*,*)"CALCOLO A.VAL & A.VET COMPLETATO" //  NEW_LINE("A")
        ELSE
            WRITE(*,*) "MANCATA ESECUZIONE DELLA FUNZIONE  dpteqr()'"
        END IF 
    END SUBROUTINE Control_DPTEQR
    !
    !
    !
END MODULE Control_A