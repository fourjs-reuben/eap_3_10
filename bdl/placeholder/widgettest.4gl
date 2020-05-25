MAIN
    OPEN WINDOW w WITH FORM "widgettest"
    MENU ""
        COMMAND "Input"
            CALL do_input()
        COMMAND "Construct"
           CALL do_construct()
         COMMAND "Input Array"
           CALL do_inputarray()
        ON ACTION close
            EXIT MENU
    END MENU
END MAIN

FUNCTION do_input()
DEFINE rec RECORD
    ed01    STRING,
    ed02    INTEGER,
    be01    STRING,
    de01    DATE,
    dt01    DATETIME YEAR TO SECOND,
    te01    DATETIME HOUR TO MINUTE,
    se01    INTEGER,
    tx01    STRING,
    cb01    CHAR(1)
END RECORD
DEFINE active BOOLEAN
    INITIALIZE rec.* TO NULL
    LET active = TRUE
    INPUT BY NAME rec.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        ON ACTION toggle
            LET active = NOT active
            CALL DIALOG.setFieldActive("ed01", active)
    END INPUT
    LET int_flag = 0
END FUNCTION

FUNCTION do_construct()
DEFINE sql STRING

    CONSTRUCT BY NAME sql ON ed01, be01
    LET int_flag = 0
END FUNCTION


FUNCTION do_inputarray()
DEFINE arr DYNAMIC ARRAY OF RECORD
    ed06 STRING,
    be06 STRING
END RECORD
    INPUT ARRAY arr WITHOUT DEFAULTS FROM scr.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
END FUNCTION