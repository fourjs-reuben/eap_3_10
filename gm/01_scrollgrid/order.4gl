IMPORT util

MAIN
DEFINE i INTEGER

DEFINE arr DYNAMIC ARRAY OF RECORD
    product STRING,
    -- These are variables for actual value
    quantity DECIMAL(11,2),
    price DECIMAL(11,2),
    line_value  DECIMAL(11,2),
    -- These are for display purposes
    q,p,v STRING
END RECORD
DEFINE att DYNAMIC ARRAY OF RECORD
    product STRING,
    quantity STRING,
    price STRING,
    line_value STRING,
    q,p,v STRING
END RECORD
DEFINE nett_value DECIMAL(11,2)
DEFINE tax_value DECIMAL(11,2)
DEFINE gross_value DECIMAL(11,2)

    -- Product, quantity, price, value case
    LET nett_value = 0
    FOR i = 1 TO 5
        LET arr[i].product =  ASCII(64)+i, ASCII(96)+i, ASCII(96)+i, ASCII(96)+i, ASCII(96)+i, ASCII(96)+i, ASCII(96)+i
        LET arr[i].quantity = util.Math.rand(100) 
        IF i = 3 THEN
            LET arr[3].quantity = -arr[3].quantity
        END IF
        LET arr[i].price = (util.Math.rand(10000) / 100) 
        LET arr[i].line_value =  (arr[i].quantity *  arr[i].price) 
        LET nett_value = nett_value +  arr[i].line_value
    END FOR

    -- Strings
    FOR i = 1 TO 5
        LET arr[i].q = arr[i].quantity USING "---&"
        LET arr[i].p = arr[i].price USING "----,-$&.&&"
        LET arr[i].v = arr[i].line_value USING "----,-$&.&&"
    END FOR

    -- Totals
    LET tax_value = nett_value * 0.15
    LET gross_value = nett_value + tax_value
    LET arr[i].p = "Nett"
    LET arr[i].v = nett_value USING "----,-$&.&&"
    LET att[i].p = "bold underline"
    LET att[i].v = "bold underline"

    LET arr[i+1].p = "Tax"
    LET arr[i+1].v = tax_value USING "----,-$&.&&"
    LET att[i+1].p = "bold "
    LET att[i+1].v = "bold "

    LET arr[i+2].p = "Gross"
    LET arr[i+2].v = gross_value USING "----,-$&.&&"
    LET att[i+2].p = "bold underline"
    LET att[i+2].v = "bold underline"

   
    
    -- Headings
    CALL arr.insertElement(1)
    CALL att.insertElement(1)
    LET arr[1].product = "Product"
    LET arr[1].q = "Quantity"
    LET arr[1].p = "Price"
    LET arr[1].v = "Value"

    LET att[1].product = "bold"
    LET att[1].q = "bold"
    LET att[1].p = "bold"
    LET att[1].v = "bold"

    LEt att[4].q = "red"
    LET att[4].v = "red"


    CALL ui.Interface.loadStyles("order")
   
    OPEN WINDOW w WITH FORM "order" ATTRIBUTES(TEXT="Sales Order #1234")
    DISPLAY ARRAY arr TO scr.* #ATTRIBUTES(ACCESSORYTYPE=DISCLOSUREINDICATOR)
        BEFORE DISPLAY
            CALL DIALOG.setArrayAttributes("scr",att)
            CALL DIALOG.setCurrentRow("scr",2)
        BEFORE ROW
            -- Don't allow user to scroll into header or footer.
            IF DIALOG.getCurrentRow("scr") = 1 THEN
                CALL DIALOG.setCurrentRow("scr",2)
            END IF
            IF DIALOG.getCurrentRow("scr") > (arr.getLength() -3) THEN
                CALL DIALOG.setCurrentRow("scr", arr.getLength()-3)
            END IF
            
    END DISPLAY
END MAIN