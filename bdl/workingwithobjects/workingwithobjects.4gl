MAIN
DEFINE f ui.Form
    MENU ""
        ON ACTION title
            CALL ui.Window.getCurrent().setText("Window Title")

        ON ACTION change_text
            CALL ui.Dialog.getCurrent().setActionText("title","Title")

        ON ACTION get_form
            LET f= ui.Window.getCurrent().getForm()
            
        
    END MENU
END MAIN

--FUNCTION title() RETURNS base.StringBuffer
--DEFINE sb base.StringBuffer 
    --LET sb = base.StringBuffer.create()
    --CALL sb.append("TItle")
    --RETURN sb
--END FUNCTION
