MAIN
DEFINE d ui.Dialog
DEFINE fields DYNAMIC ARRAY OF RECORD
    name STRING,
    type STRING
END RECORD
DEFINE ev STRING
DEFINE sb base.StringBuffer
DEFINE i,j INTEGER
DEFINE cb STRING
DEFINE tok_line, tok_field base.StringTokenizer
DEFINE line,value STRING

DEFINE arr DYNAMIC ARRAY OF RECORD
    field1, field2 STRING
END RECORD
DEFINE current_row INTEGER

    #CALL ui.Dialog.setDefaultUnbuffered(TRUE)

    OPEN WINDOW w WITH FORM "excel"
    LET fields[1].name = "field1"
    LET fields[1].type = "STRING"
    LET fields[2].name = "field2"
    LET fields[2].type = "STRING"
{
    INPUT ARRAY arr WITHOUT DEFAULTS FROM scr.*
        ON ACTION paste_special
                LET d = ui.Dialog.getCurrent()
                CALL ui.Interface.frontCall("standard","cbget",[],cb)
                LET tok_line = base.StringTokenizer.create(cb,"\r")
                LET i = 0
                WHILE tok_line.hasMoreTokens()
                    LET i = i + 1
                    CALL arr.appendElement()
                    CALL d.setCurrentRow("scr",i)                
                    LET line = tok_line.nextToken()
                    LET tok_field = base.StringTokenizer.create(line,"\t")
                    LET j = 0
                    WHILE tok_field.hasMoreTokens()
                        LET j = j + 1
                        LET value = tok_field.nextToken()
                        CALL d.setFieldValue(fields[j].name,value)
                        DISPLAY i," ",fields[j].name, value
                    END WHILE
                END WHILE
                CALL d.setCurrentRow("scr",1)

                DISPLAY arr[2].field2
            

    END INPUT
    EXIT PROGRAM 1
    }
    LET d= ui.Dialog.createInputArrayFrom(fields, "scr")
   
   
    CALL d.addTrigger("ON ACTION close")
    CALL d.addTrigger("ON ACTION copy2excel")
    CALL d.addTrigger("ON ACTION pastespecial")
    CALL d.addTrigger("ON ACTION clear")
    #CALL d.addTrigger("ON ACTION init")



    

    WHILE TRUE
        LET ev = d.nextEvent()
        CASE
            WHEN ev = "BEFORE INPUT"
                CALL d.setActionActive("delete", FALSE)
                CALL d.setActionHidden("delete", TRUE)
                CALL d.setActionActive("insert", FALSE)
                CALL d.setActionHidden("insert", TRUE)
                CALL d.setActionActive("append", FALSE)
                CALL d.setActionHidden("append", TRUE)

                CALL d.setActionText("copy2excel", "Copy To Excel")
                CALL d.setActionImage("copy2excel", "fa-file-excel-o")
                
  
            WHEN ev = "ON ACTION close"
                EXIT WHILE
            WHEN ev = "ON ACTION clear"
                CALL d.deleteAllRows("scr")
            --WHEN ev = "ON ACTION init"
              --CALL d.setArrayLength("scr",3)
    --CALL d.setCurrentRow("scr",1)
    --CALL d.setFieldValue(fields[1].name,1)
    --CALL d.setFieldValue(fields[2].name,2)
    --CALL d.setCurrentRow("scr",2)
    --CALL d.setFieldValue(fields[1].name,3)
    --CALL d.setFieldValue(fields[2].name,4)
    --CALL d.setCurrentRow("scr",3)
    --CALL d.setFieldValue(fields[1].name,5)
    --CALL d.setFieldValue(fields[2].name,6)
            
            WHEN ev = "ON ACTION pastespecial"
                CALL ui.Interface.frontCall("standard","cbget",[],cb)
                LET tok_line = base.StringTokenizer.create(cb,"\r")
                LET i = 0
                WHILE tok_line.hasMoreTokens()
                    LET i = i+1
                    CALL d.setArrayLength("scr",i)
                    CALL d.setCurrentRow("scr",i)                
                    LET line = tok_line.nextToken()
                    LET tok_field = base.StringTokenizer.create(line,"\t")
                    LET j = 0
                    WHILE tok_field.hasMoreTokens()
                        LET j = j + 1
                        IF j > fields.getLength() THEN
                            EXIT WHILE
                        END IF
                        LET value = tok_field.nextToken()
                        CALL d.setFieldValue(fields[j].name,value)
                    END WHILE
                END WHILE
                CALL d.setCurrentRow("scr",i)
            
            WHEN ev = "ON ACTION copy2excel"
                LET current_row = d.getCurrentRow("scr") -- save current row, restore at end
                LET sb = base.StringBuffer.create()
                FOR i = 1 TO d.getArrayLength("scr")
                    IF i > 1 THEN
                        CALL sb.append(ASCII(10))
                    END IF
                    CALL d.setCurrentRow("scr",i)
                    FOR j = 1 TO fields.getLength()
                        IF j > 1 THEN
                            CALL sb.append(ASCII(9))
                        END IF
                        CALL sb.append(d.getFieldValue(fields[j].name))
                    END FOR
                END FOR
                CALL ui.Interface.frontCall("standard","cbset", sb.toString(),[])
                CALL d.setCurrentRow("scr", current_row) -- restore saved row
                
        END CASE
    END WHILE
    
END MAIN