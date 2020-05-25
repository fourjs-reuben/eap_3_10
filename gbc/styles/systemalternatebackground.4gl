MAIN
DEFINE arr DYNAMIC ARRAY OF RECORD
    field1 INTEGER
END RECORD
DEFINE i INTEGER

    CALL ui.Interface.loadStyles("systemalternatebackground.4st")
    FOR i = 1 TO 100
        LET arr[i].field1 = i
    END FOR
    OPEN WINDOW w WITH FORM "systemalternatebackground"
    DISPLAY ARRAY arr TO scr.*
END MAIN