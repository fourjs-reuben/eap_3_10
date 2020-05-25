IMPORT util
MAIN
DEFINE arr DYNAMIC ARRAY OF RECORD
    major STRING, minor INTEGER, img STRING
END RECORD
DEFINE i INTEGER


    LET arr[1].major = "North"
    LET arr[2].major = "East"
    LET arr[3].major = "West"
    LET arr[4].major = "Central"
    LET arr[5].major = "South"
    FOR i = 1 TO 5
        LET arr[i].minor = util.Math.rand(1000)
        LET arr[i].img = IIF(arr[i].minor>500,"smiley","ssmiley")
    END FOR
    CALL arr.sort("minor",TRUE)
    CALL ui.Interface.loadStyles("tablelistview.4st")
    OPEN WINDOW w WITH FORM "tablelistview"
    DISPLAY ARRAY arr TO scr.* ATTRIBUTES(ACCEPT=FALSE, CANCEL=FALSE)
END MAIN