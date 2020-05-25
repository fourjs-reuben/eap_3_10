MAIN
DEFINE sql STRING

    OPTIONS INPUT WRAP
    OPEN WINDOW w WITH FORM "construct_change"

    CONSTRUCT BY NAME sql  ON combo, check, radio, spinedit, completer, dte, tme, dttme
        BEFORE CONSTRUCT
            DISPLAY TODAY to dte
         ##   DISPLAY CURRENT HOUR TO MINUTE TO tme
          #  DISPLAY CURRENT YEAR TO SECOND TO dttme
        ON CHANGE combo
            MESSAGE "Combo changed ", FGL_DIALOG_GETBUFFER()
        ON CHANGE check
            MESSAGE "Check changed ", FGL_DIALOG_GETBUFFER()
        ON CHANGE radio
            MESSAGE "Radio changed ", FGL_DIALOG_GETBUFFER()
        ON CHANGE spinedit
            MESSAGE "Spinedit changed ", FGL_DIALOG_GETBUFFER()
        ON CHANGE completer
            MESSAGE "Completer changed ", FGL_DIALOG_GETBUFFER()
        ON CHANGE dte
            MESSAGE "Dateedit changed ", FGL_DIALOG_GETBUFFER()
        ON CHANGE tme
            MESSAGE "Timeedit changed ", FGL_DIALOG_GETBUFFER()
        ON CHANGE dttme
            MESSAGE "Datetimeedit changed ", FGL_DIALOG_GETBUFFER()
    END CONSTRUCT
END MAIN

