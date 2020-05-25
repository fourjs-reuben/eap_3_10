IMPORT com
IMPORT util
IMPORT FGL fglgallery
MAIN
DEFINE wc STRING
DEFINE id INTEGER

DEFINE req com.HttpRequest
DEFINE resp com.HttpResponse
DEFINE s STRING


DEFINE img, name,last_name STRING
DEFINE start,finish INTEGER
DEFINE start2,finish2 INTEGER

DEFINE struct_value fglgallery.t_struct_value
DEFINE count INTEGER

    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "my_fglgallery"
   
    INPUT BY NAME wc
        BEFORE INPUT
            CALL fglgallery.initialize()

            LET id = fglgallery.create("formonly.wc")
            LET req = com.HttpRequest.Create("https://en.wikipedia.org/wiki/Gallery_of_sovereign_state_flags")
            CALL req.doRequest()
            LET resp= req.getResponse()
            IF resp.getStatusCode() = 200 THEN
                LET s = resp.getTextResponse()
               
                LET start = 0
                WHILE TRUE
                    LET start = s.getIndexOf("//upload.wikimedia.org", start+1)
                    IF start = 0 THEN
                        EXIT WHILE
                    END IF
                    LET finish = s.getIndexOf("\"", start+1)
                    LET img = s.subString(start,finish-1)
                    LET img = "https:", img

                    LET start2 = s.getIndexOf("Flag_of_", start)
                    IF start2 = 0 THEN
                        CONTINUE WHILE
                    END IF
                    LET finish2 = s.getIndexOf(".", start2+1)
                    LET name = s.subString(start2+8, finish2-1)
                    IF name = last_name THEN
                        CONTINUE WHILE
                    END IF
                    IF name MATCHES "*depict*" THEN
                        CONTINUE WHILE
                    END IF
                    LET last_name = name
                    LET count = count + 1
                    CALL fglgallery.addImage(id,img,name)
                    
                
                END WHILE

                CALL fglgallery.flush(id)
                CALL fglgallery.display(id, fglgallery.FGLGALLERY_TYPE_THUMBNAILS, FGLGALLERY_SIZE_NORMAL)

            END IF

       # ON ACTION image_selection
           # DISPLAY wc
           # CALL util.JSON.parse( wc, struct_value )
           #DISPLAY struct_value.current,
           #   struct_value.selected.getLength()
    END INPUT
END MAIN