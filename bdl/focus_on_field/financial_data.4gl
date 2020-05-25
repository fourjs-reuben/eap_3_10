IMPORT util

DEFINE arr DYNAMIC ARRAY OF RECORD
    account STRING,
    value01 DECIMAL(11,2),
    value02 DECIMAL(11,2),
    value03 DECIMAL(11,2),
    value04 DECIMAL(11,2),
    value05 DECIMAL(11,2),
    value06 DECIMAL(11,2),
    value07 DECIMAL(11,2),
    value08 DECIMAL(11,2),
    value09 DECIMAL(11,2),
    value10 DECIMAL(11,2),
    value11 DECIMAL(11,2),
    value12 DECIMAL(11,2)
END RECORD

MAIN
DEFINE i INTEGER

DEFINE row INTEGER
DEFINE col STRING
DEFINE value DECIMAL(11,2)

    OPTIONS FIELD ORDER FORM
    OPTIONS INPUT WRAP

    CALL ui.Interface.loadStyles("financial_data.4st")

    FOR i = 1 TO 100
        LET arr[i].account =SFMT("%1", i*100 USING "&&&&&")
        LET arr[i].value01 = util.Math.rand(10000)/100
        LET arr[i].value02 = util.Math.rand(10000)/100
        LET arr[i].value03 = util.Math.rand(10000)/100
        LET arr[i].value04 = util.Math.rand(10000)/100
        LET arr[i].value05 = util.Math.rand(10000)/100
        LET arr[i].value06 = util.Math.rand(10000)/100
        LET arr[i].value07 = util.Math.rand(10000)/100
        LET arr[i].value08 = util.Math.rand(10000)/100
        LET arr[i].value09 = util.Math.rand(10000)/100
        LET arr[i].value10 = util.Math.rand(10000)/100
        LET arr[i].value11 = util.Math.rand(10000)/100
        LET arr[i].value12 = util.Math.rand(10000)/100
    END FOR
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "financial_data" ATTRIBUTES(TEXT="Account Balances")

    DISPLAY ARRAY arr TO scr.* ATTRIBUTES(UNBUFFERED, DOUBLECLICK=select, FOCUSONFIELD, ACCEPT=FALSE)
        BEFORE DISPLAY
            MESSAGE "Double click on month balance to view transactions in month"
        ON ACTION select
            LET row = DIALOG.getCurrentRow("scr")  
            LET col = DIALOG.getCurrentItem()
            IF col = "scr.account" THEN
                ERROR "Select a value column to drilldown on"
                CONTINUE DISPLAY
            END IF

            -- One of these should work?
            #LET value = DIALOG.getFieldValue(col)  # currently returns value for last displayed row
            #LET value = FGL_DIALOG_GETBUFFER() # currently returns NULL
            #LET value = DIALOG.getFieldBuffer() # currently returs NULL
            LET value = get_current_value(col, row)
           
            CALL view_daily_balance(row, col, value, arr[row].account)
    END DISPLAY
END MAIN





FUNCTION view_daily_balance(row,col,value, account)
DEFINE row INTEGER
DEFINE col STRING
DEFINE value DECIMAL(11,2)
DEFINE account STRING

DEFINE i, dmy, cnt INTEGER
DEFINE daily_balance_arr DYNAMIC ARRAY OF RECORD
    dmy DATE,
    value DECIMAL(11,2)
END RECORD


    -- Quick hack that spreads transactions over days in month
    LET cnt = util.Math.rand(20)+10
    FOR i = 1 TO (cnt-1)
        LET dmy = (i*28/cnt) +1
        LET daily_balance_arr[i].dmy = MDY(get_column_index(col),dmy, YEAR(TODAY)-1)
        LET daily_balance_arr[i].value = util.math.rand(25)/100*value
        LET value = value - daily_balance_arr[i].value
    END FOR
    LET daily_balance_arr[cnt].dmy =  MDY(get_column_index(col),28, YEAR(TODAY)-1)
    LET daily_balance_arr[cnt].value = value
        
    OPEN WINDOW daily_balance WITH FORM "focus_on_field2" ATTRIBUTES(TEXT=SFMT("%1 Transactions for %2",get_column_title(col), account))
    DISPLAY ARRAY daily_balance_arr TO daily_balance_scr.* ATTRIBUTES(UNBUFFERED, ACCEPT=FALSE)
    END DISPLAY
    CLOSE WINDOW daily_balance
    LET int_flag = 0
END FUNCTION


-- should not need this
FUNCTION get_current_value(col, row)
DEFINE col STRING
DEFINE row INTEGER

    CASE col
        WHEN "scr.account" RETURN arr[row].account
        WHEN "scr.value01" RETURN arr[row].value01
        WHEN "scr.value02" RETURN arr[row].value02
        WHEN "scr.value03" RETURN arr[row].value03
        WHEN "scr.value04" RETURN arr[row].value04
        WHEN "scr.value05" RETURN arr[row].value05
        WHEN "scr.value06" RETURN arr[row].value06
        WHEN "scr.value07" RETURN arr[row].value07
        WHEN "scr.value08" RETURN arr[row].value08
        WHEN "scr.value09" RETURN arr[row].value09
        WHEN "scr.value10" RETURN arr[row].value10
        WHEN "scr.value11" RETURN arr[row].value11
        WHEN "scr.value12" RETURN arr[row].value12
    END CASE
    RETURN NULL
END FUNCTION

FUNCTION get_column_title(col)
DEFINE col STRING

    CASE col
        WHEN "scr.value01" RETURN "January"
        WHEN "scr.value02" RETURN "February"
        WHEN "scr.value03" RETURN "March"
        WHEN "scr.value04" RETURN "April"
        WHEN "scr.value05" RETURN "May"
        WHEN "scr.value06" RETURN "June"
        WHEN "scr.value07" RETURN "July"
        WHEN "scr.value08" RETURN "August"
        WHEN "scr.value09" RETURN "September"
        WHEN "scr.value10" RETURN "October"
        WHEN "scr.value11" RETURN "November"
        WHEN "scr.value12" RETURN "December"
    END CASE
    RETURN NULL
END FUNCTION

FUNCTION get_column_index(col)
DEFINE col STRING

    RETURN col.subString(10,11)
END FUNCTION