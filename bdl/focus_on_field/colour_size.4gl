IMPORT util

DEFINE arr DYNAMIC ARRAY OF RECORD
    colour STRING,
    qty_s INTEGER,
    qty_m INTEGER,
    qty_l INTEGER,
    colour_text STRING
END RECORD
MAIN
DEFINE i INTEGER
DEFINE d ui.Dialog

    CLOSE WINDOW SCREEN

    CALL ui.Interface.loadStyles("colour_size")
    OPEN WINDOW w WITH FORM "colour_size"
    

    LET arr[1].colour = '<div style="background-color: white; color: black">White</div>'
    LET arr[2].colour = '<div style="background-color: red; color: white">Red</div>'
    LET arr[3].colour = '<div style="background-color: orange; color: white">Orange</div>'
    LET arr[4].colour = '<div style="background-color: yellow; color: black">Yellow</div>'
    LET arr[5].colour = '<div style="background-color: green; color: white">Green</div>'
    LET arr[6].colour = '<div style="background-color: blue; color: white">Blue</div>'
    LET arr[7].colour = '<div style="background-color: purple; color: white">Purple</div>'
    LET arr[8].colour = '<div style="background-color: black; color: white">Black</div>'
    LET arr[1].colour_text ="White"
    LET arr[2].colour_text ="Red"
    LET arr[3].colour_text ="Orange"
    LET arr[4].colour_text ="Yellow"    
    LET arr[5].colour_text ="Green"
    LET arr[6].colour_text ="Blue"    
    LET arr[7].colour_text ="Purple"
    LET arr[8].colour_text ="Black"

    FOR i = 1 TO arr.getLength()
        LET arr[i].qty_s = IIF(util.math.rand(2) = 0, util.math.rand(20),0)
        LET arr[i].qty_m = IIF(util.math.rand(2) = 0, util.math.rand(20),0)
        LET arr[i].qty_l = IIF(util.math.rand(2) = 0, util.math.rand(20),0)
    END FOR
         
    DISPLAY ARRAY arr TO scr.* ATTRIBUTES(FOCUSONFIELD, ACCEPT=FALSE, DOUBLECLICK=select)
        BEFORE DISPLAY
            MESSAGE "Double-click colour/size combination to drill down and view transactions"
        ON ACTION select
            DISPLAY "Row = ",DIALOG.getCurrentRow("scr")
            DISPLAY "Column = ", DIALOG.getCurrentItem()
           # DISPLAY "Value = ", DIALOG.getFieldValue(DIALOG.getCurrentItem())
            CALL FGL_WINMESSAGE("Info",SFMT("Colour = %1\nSize = %2\nQty=%3", arr[DIALOG.getCurrentRow("scr")].colour_text, column_to_size(DIALOG.getCurrentItem()), get_qty(DIALOG.getCurrentRow("scr"),DIALOG.getCurrentItem())),"info") 
    END DISPLAY
   
END MAIN

PRIVATE FUNCTION column_to_size(c STRING) RETURNS STRING

    CASE c
        WHEN "scr.qty_s" RETURN "Small"
        WHEN "scr.qty_m" RETURN "Medium"
        WHEN "scr.qty_l" RETURN "Large"
    END CASE
    RETURN "Other"
END FUNCTION

FUNCTION get_qty(r INT, c STRING) RETURNS INTEGER
     CASE c
        WHEN "scr.qty_s" RETURN arr[r].qty_s
        WHEN "scr.qty_m" RETURN arr[r].qty_m
        WHEN "scr.qty_l" RETURN arr[r].qty_l
    END CASE
    RETURN 0
END FUNCTION