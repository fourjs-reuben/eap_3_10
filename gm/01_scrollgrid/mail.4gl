IMPORT util
MAIN
DEFINE i INTEGER
DEFINE arr DYNAMIC ARRAY OF RECORD
    from STRING,
    when DATETIME YEAR TO MINUTE,
    subject STRING,
    preview STRING
END RECORD

    FOR i = 1 TO 100
        LET arr[i].from = "Four Js Support"
        LET arr[i].when = "2017-03-03 12:00"
        LET arr[i].subject = "Lorem Ipsum"
        LET arr[i].preview = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    END FOR
    LET arr[1].from = "Four Js Support Strasbourg"
    LET arr[2].from = "Four Js Support Dallas"
    LET arr[3].from = "Four Js Support London"
    LET arr[4].from = "Four Js Support Mexico City"
    LET arr[5].from = "Four Js Support Buenos Aires"
    LET arr[6].from = "Four Js Support Sydney"
    LET arr[7].from = "Four Js Support Auckland"
    CALL ui.Interface.loadStyles("mail.4st")

    OPEN WINDOW w WITH FORM "mail"

    DISPLAY ARRAY arr TO scr.* #ATTRIBUTES(ACCESSORYTYPE=DISCLOSUREINDICATOR)

END MAIN