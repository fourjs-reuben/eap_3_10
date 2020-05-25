MAIN
   DEFINE i INTEGER
   DEFINE items DYNAMIC ARRAY OF RECORD
                key INTEGER,
                name CHAR(10)
              END RECORD
   DEFINE attributes DYNAMIC ARRAY OF RECORD
                key STRING,
                name STRING
              END RECORD

    OPEN WINDOW w WITH FORM "array_attributes"
   FOR i=1 TO 10
     CALL items.appendElement()
     LET items[i].key = i 
     LET items[i].name = "name " || i 
     CALL attributes.appendElement()
     --IF i MOD 2 = 0 THEN
       --LET attributes[i].key = "bold"
       --LET attributes[i].name = "bold"
     --ELSE
     #  LET attributes[i].key = "green"
      # LET attributes[i].name = "#00007F"
     --END IF
     IF i MOD 3 = 0  THEN
        #LET attributes[i].key = "bold underline "
        LET attributes[i].name = "#808080 bold underline"
    END IF
   END FOR
  

   DISPLAY ARRAY items TO scr.* ATTRIBUTES(UNBUFFERED)
       BEFORE DISPLAY 
         CALL DIALOG.setCellAttributes(attributes)
       ON ACTION att_modify_cell 
         LET attributes[2].key = "red reverse"
       ON ACTION att_clear_cell 
         LET attributes[2].key = NULL
   END DISPLAY

END MAIN