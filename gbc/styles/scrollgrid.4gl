IMPORT os

DEFINE arr DYNAMIC ARRAY OF RECORD
    imagename STRING,
    code STRING,
    img STRING
END RECORD

MAIN

    CALL ui.Interface.loadStyles("scrollgrid.4st")
    DISPLAY FGL_GETENV("FGLIMAGEPATH")
    CALL add_images_to_array(SFMT("%1%2lib%2image2font.txt",FGL_GETENV("FGLDIR"), os.Path.separator()))
    
    
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "scrollgrid"
    DISPLAY ARRAY arr TO scr.* ATTRIBUTES(ACCEPT=FALSE, CANCEL=FALSE)
           
END MAIN



FUNCTION add_images_to_array(filename)
DEFINE filename STRING

DEFINE ch base.Channel
DEFINE line STRING
DEFINE equal_pos, colon_pos STRING

    LET ch = base.Channel.create()
    CALL ch.openFile(filename,"r")
    WHILE TRUE
        LET line = ch.readLine()
        IF ch.isEof() THEN
            EXIT WHILE
        END IF
        IF line MATCHES "#*" THEN
            -- ignore comments
            CONTINUE WHILE
        END IF
        LET equal_pos = line.getIndexOf("=",1)
        LET colon_pos = line.getIndexOf(":",1)
        LET arr[arr.getLength()+1].imagename = line.subString(1,equal_pos-1)
        LET arr[arr.getLength()].img = arr[arr.getLength()].imagename

        LET arr[arr.getLength()].code = line.subString(colon_pos+1, line.getLength())

    END WHILE
    CALL ch.close()
END FUNCTION

