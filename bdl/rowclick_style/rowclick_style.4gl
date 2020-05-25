DEFINE arr DYNAMIC ARRAY OF RECORD
    id, parentid INTEGER,
    expanded BOOLEAN,
    field1 INTEGER
END RECORD

CONSTANT ROWCOUNT = 3

MAIN
DEFINE i INTEGER
DEFINE w ui.Window
DEFINE f ui.Form

    CALL ui.Interface.loadStyles("rowclick_style")
    OPEN WINDOW w WITH FORM "rowclick_style"
    LET w = ui.Window.getCurrent()
    LET f = w.getForm()
    LET arr[1].field1 = "Root"
    LET arr[1].parentid = NULL
    LET arr[1].id = 1
    LET arr[1].expanded = FALSE
    FOR i = 1 TO ROWCOUNT
        LET arr[i+1].field1 = i
        LET arr[i+1].parentid = 1
        LET arr[i+1].id = i+1
    END FOR
    DIALOG
        -- Dialog for array on left
        DISPLAY ARRAY arr TO scr.* ATTRIBUTES(DOUBLECLICK=select)
            ON ACTION select
                -- Show the selected sub-dialog when user clicks on row, hide the other sub-dialogs
                FOR i = 1 TO ROWCOUNT
                    CALL f.setElementHidden(SFMT("grp_%1", i USING "&"), i!=(arr_curr()-1))
                END FOR
                IF arr_curr() = 1 THEN
                    LET arr[1].expanded = NOT arr[1].expanded
                END IF
               
        END DISPLAY

         -- Sub Dialog for each row entry
        SUBDIALOG sub_1
        SUBDIALOG sub_2
        SUBDIALOG sub_3
        # ..
        #SUBDIALOG sub_ROWCOUNT

        ON ACTION close
            EXIT DIALOG
            
        BEFORE DIALOG
            -- Display the first child initially
            FOR i = 1 TO ROWCOUNT
                CALL f.setElementHidden(SFMT("grp_%1", i USING "&"), TRUE)
            END FOR
    END DIALOG
END MAIN


-- Many independent sub-dialogs
DIALOG sub_1()
DEFINE field11 STRING
    INPUT BY NAME field11
    END INPUT
END DIALOG

DIALOG sub_2()
DEFINE field21, field22 STRING
    INPUT BY NAME field21, field22
    END INPUT
END DIALOG

DIALOG sub_3()
DEFINE field31, field32, field33 STRING
    INPUT BY NAME field31, field32, field33
    END INPUT
END DIALOG

{
...
DIALOG sub_ROWCOUNT()
DEFINE ...
    INPUT ...
    END INPUT
END DIALOG
}