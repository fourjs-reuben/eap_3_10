MAIN
DEFINE s STRING

    CLOSE WINDOW SCREEN
    CALL ui.Interface.loadStyles("my_fglrichtext")
    OPEN WINDOW w WITH FORM "my_fglrichtext"
    INPUT BY NAME s ATTRIBUTES(UNBUFFERED)
        ON ACTION raw
            DISPLAY s TO raw
    END INPUT
END MAIN