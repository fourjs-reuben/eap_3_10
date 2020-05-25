DEFINE d,s ui.DIALOG
DEFINE f1,usd, eur DYNAMIC ARRAY OF RECORD
    name, type STRING
END RECORD
DEFINE ev STRING
MAIN

    OPTIONS INPUT WRAP

    LET f1[1].name = "currency" LET f1[1].type = "STRING"

    -- Notes for USD
    LET usd[1].name = "field1" LET usd[1].type = "INTEGER"
    LET usd[2].name = "field2" LET usd[2].type = "INTEGER"
    LET usd[3].name = "field5" LET usd[3].type = "INTEGER"
    LET usd[4].name = "field10" LET usd[4].type = "INTEGER"
    LET usd[5].name = "field20" LET usd[5].type = "INTEGER"
    LET usd[6].name = "field50" LET usd[6].type = "INTEGER"
    LET usd[7].name = "field100" LET usd[7].type = "INTEGER"

    -- Notes for EURO
    LET eur[1].name = "field5" LET eur[1].type = "INTEGER"
    LET eur[2].name = "field10" LET eur[2].type = "INTEGER"
    LET eur[3].name = "field20" LET eur[3].type = "INTEGER"
    LET eur[4].name = "field50" LET eur[4].type = "INTEGER"
    LET eur[5].name = "field100" LET eur[5].type = "INTEGER"
    LET eur[6].name = "field200" LET eur[6].type = "INTEGER"
    LET eur[7].name = "field500" LET eur[7].type = "INTEGER"
   

    OPEN WINDOW w WITH FORM "multidialog"
    LET d = ui.Dialog.createMultipleDialog()
    CALL d.addInputByName(f1,"f1")
    
    WHILE TRUE
        LET ev = d.nextEvent()
        DISPLAY ev
        CASE
            WHEN ev = "ON CHANGE currency"
                CASE d.getFieldValue("currency")
                    WHEN "USD"  
                        # NEED TO BE ABLE TO REMOVE PREVIOUS IF IT EXISTS
                        
                        CALL add_to_form(usd)
                        CALL d.addInputByName(usd,"subdialog")
                    WHEN "EUR" 
                        # NEED TO BE ABLE TO REMOVE PREVIOUS IF IT EXISTS
                        
                        CALL add_to_form(eur)
                        CALL d.addInputByName(eur,"subdialog")
                END CASE
            WHEN ev = "AFTER INPUT subdialog"
                DISPLAY "validate all curency fields"
        END CASE
    END WHILE
END MAIN

FUNCTION add_to_form(f)
DEFINE f DYNAMIC ARRAY OF RECORD
    name STRING, type STRING
END RECORD
DEFINE w ui.Window
DEFINE v,g,ff,l,e om.DomNode
DEFINE i INTEGER
DEFINE denom STRING

    LET w = ui.Window.getCurrent()
    
    LET v =  w.findNode("VBox","vbx_main")
    LET g = v.createChild("Grid")
    FOR i = 1 TO f.getLength()
        LET denom = f[i].name.subString(6,f[i].name.getLength())

        LET l = g.createChild("Label")
        CALL l.setAttribute("posX", 0)
        CALL l.setAttribute("posY",i)
        CALL l.setAttribute("text", denom)
    
        LET ff = g.createChild("FormField")
        CALL ff.setAttribute("name", SFMT("formonly.%1", f[i].name))
        CALL ff.setAttribute("colName",f[i].name)
        CALL ff.setAttribute("fieldId", i)
        CALL ff.setAttribute("sqlTabName", "formonly")
        CALL ff.setAttribute("tabIndex", i+1)
    
        LET e = ff.createChild("Edit")
        CALL e.setAttribute("width",10)
        CALL e.setAttribute("gridWidth",10)
        CALL e.setAttribute("posY",i)
        CALL e.setAttribute("posX",10)
    END FOR
END FUNCTION