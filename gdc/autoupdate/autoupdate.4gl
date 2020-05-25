MAIN
DEFINE result STRING

    CALL ui.Interface.frontCall("standard","feinfo",["fename"],result)
    DISPLAY result
    DISPLAY ui.interface.getFrontEndVersion()
    -- Don't worry about version check for now, we can get info that is enough
    -- CALL FGL_PUTFILE(copy file to GDC)
    MENU ""
        ON ACTION update
          CALL ui.interface.frontcall("monitor", "update", ["C:\\Users\\Demo\\tmp\\fjs-gdc-3.10.03-build155008-w64v120-autoupdate.zip"], result)
        ON ACTION cancel
            EXIT MENU
    END MENU
END MAIN