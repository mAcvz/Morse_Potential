MODULE Control_B
    !
    !
    !
    ! Modulo contenente 2 subroutine con il compito di gestire eventuali errori:
    !
    ! 1) SUBROUTINE Control_Ins(...) gestisce gli errori commessi in fase di inserimento
    !
    ! 2) SUBROUTINE Control_ZHEEV(...) segnala l'esecuzione / non esecuzione di ZHEEV(...)
    !
    !
    USE Dichiarazione_B
    !
    IMPLICIT NONE
    !
    CONTAINS
    !
    ! CONTROLLO PARAMETRI INGRESSO
    SUBROUTINE Control_Ins()
        !
        IF (N .LE. 0 .OR. L .LE. 0 .OR. M .LE. 0 .OR. alpha .LE. 0  .OR. LWORK .LE. 0)  THEN  ! CONTROLLO POSITIVITA'
            WRITE(*,*) "OPERAZIONE ANNULLATA - valori in ingresso non corretti"
            STOP
        END IF 
        !
        IF (ioerrInput .EQ. 0 )  THEN                  ! CONTROLLO LETTURA
            CONTINUE
        ELSE
            WRITE(*,*) "(ERRORE DI INSERIMENTO: input non corretto - ARRESTO)"
            STOP
        END IF
        !
        IF (alpha .GT. 6.0 ) THEN  ! CONTROLLO RANGE DI ALPHA
            WRITE(*,*) "OPERAZIONE ANNULLATA - valore di alpha non appartenente a range limite [0,6.0]"
            STOP
        END IF 
        !
        IF (alpha .LT. 0.5 .OR. alpha .GT. 2.0 ) THEN  ! CONTROLLO RANGE DI ALPHA
            WRITE(*,*) "WARNING: valore di alpha non appartenente a [0.5,2.0]" // NEW_LINE("A")
            CONTINUE
        END IF 
        !
        IF ( M .GT. 99) THEN                             ! CONTROLLO N° A.VALORI STAMPATI
            WRITE(*,*) "ERRORE: n° di autovettori richiesti in fase di stampa ECCESSIVO - ARRESTO"
            STOP
        END IF 
    END SUBROUTINE Control_Ins
    !
    !
    ! CONTROLLO ESECUZIONE ZHEEV (...)
    SUBROUTINE Control_ZHEEV()
        IF (INFO.EQ. 0 )  THEN                         
            CONTINUE
        ELSE IF (INFO .LT. 0  )  THEN   
            WRITE(*,*) "(ERRORE : fallita convergenza di ZHEEV - ARRESTO)"
            STOP
        ELSE IF (INFO .gT. 0  )  THEN   
            WRITE(*,*) "(ERRORE DI INSERIMENTO ZHEEV - ARRESTO)"
            STOP
        END IF
        END SUBROUTINE Control_ZHEEV
    !
    !
    !
END MODULE Control_B

