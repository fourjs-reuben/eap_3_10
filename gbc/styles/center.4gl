MAIN
DEFINE rec RECORD
    field1, field2, field3 STRING
END RECORD
DEFINE arr DYNAMIC ARRAY OF RECORD
    col1 STRING
END RECORD
DEFINE i INTEGER

    FOR i =1  TO 100
        LEt arr[i].col1 = i
    END FOR
    CALL ui.Interface.loadStyles("center")
    OPEN WINDOW w WITH FORM "center"
    
    DIALOG
        INPUT BY NAME rec.*
        END INPUT
        DISPLAY ARRAY arr TO scr.*
        END DISPLAY
        ON ACTION close
            EXIT DIALOG
    END DIALOG
END MAIN
