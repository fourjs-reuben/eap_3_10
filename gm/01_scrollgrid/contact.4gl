MAIN
DEFINE arr DYNAMIC ARRAY OF RECORD
    name STRING
END RECORD

    LET arr[1].name = "<b>Reuben</b> Barclay"

 

    OPTIONS INPUT WRAP
    OPTIONS FIELD ORDER FORM

    OPEN WINDOW w WITH FORM "contact"
      DISPLAY Arr[1].name TO x
    DISPLAY ARRAY arr TO scr.*
END MAIN