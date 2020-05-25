MAIN
DEFINE rec RECORD
    field1, field2, field3 STRING
END RECORD

    #CALL ui.Interface.loadStyles("stack")
    OPEN WINDOW w WITH FORM "stack"
    INPUT BY NAME rec.*
END MAIN