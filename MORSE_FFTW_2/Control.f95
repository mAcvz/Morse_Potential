MODULE Control
! 
    USE Dichiarazione
    !
    IMPLICIT NONE
    !
    !
    CONTAINS
    !
    ! CONTROLLO PARAMETRI INGRESSO
    SUBROUTINE Control_Ins()
        !
        !
        IF (N .LE. 0 .OR. L .LE. 0 .OR. M .LE. 0 .OR. alpha .LT. 0  .OR. LWORK .LE. 0)  THEN  ! CONTROLLO POSITIVITA'
            !
            WRITE(*,*) "OPERAZIONE ANNULLATA - valori in ingresso non corretti"
            STOP
        END IF 
        !
        !
        IF (ioerrInput .EQ. 0 )  THEN                 ! CONTROLLO LETTURA
            !
            CONTINUE
            !
        ELSE
            !
            WRITE(*,*) "(ERRORE DI INSERIMENTO: input non corretto - ARRESTO)"
            STOP
            !
        END IF
        !
        !
        IF (alpha .LT. 0.5 .OR. alpha .GT. 2.5 ) THEN  ! CONTROLLO RANGE DI ALPHA
        !
            WRITE(*,*) "WORNING: valore di alpha non appartenente a [0.5,2.5]"
            CONTINUE
        END IF 
        !
        !
        IF ( M > 99) THEN                              ! CONTROLLO N° A.VALORI STAMPATI
            WRITE(*,*) "ERRORE: n° di autovettori richiesti in fase di stampa ECCESSIVO - ARRESTO"
            STOP
        END IF 
    END SUBROUTINE Control_Ins
    !
    !
    ! CONTROLLO ESECUZIONE ZHEEV (...)
    SUBROUTINE Control_ZHEEV()
        IF (INFO.EQ. 0 )  THEN                 ! CONTROLLO LETTURA
            !
            CONTINUE
            !
        ELSE IF (INFO .LT. 0  )  THEN   
            !
            WRITE(*,*) "(ERRORE : fallita convergenza di ZHEEV - ARRESTO)"
            STOP
            !
        ELSE IF (INFO .gT. 0  )  THEN   
            !
            WRITE(*,*) "(ERRORE DI INSERIMENTO ZHEEV - ARRESTO)"
            STOP
            !
        END IF
        END SUBROUTINE Control_ZHEEV

END MODULE

