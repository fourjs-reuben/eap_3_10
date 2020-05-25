MAIN
DEFINE l_path STRING

   # LET l_path = FGL_GETENV("FGLRESOURCEPATH")
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "reload_resources"
    MENU ""  ATTRIBUTES(STYLE="dialog", COMMENT="Select language")
        ON ACTION en ATTRIBUTES(IMAGE="https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/72px-Flag_of_the_United_Kingdom.svg.png", TEXT="") LET l_path="./en"
        ON ACTION fr ATTRIBUTES(IMAGE="https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/72px-Flag_of_France.svg.png", TEXT="") LET l_path="./fr"
        ON ACTION de ATTRIBUTES(IMAGE="https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/72px-Flag_of_Germany.svg.png", TEXT="")   LET l_path="./de"
    END MENU
    DISPLAY l_path
    CALL base.Application.reloadResources(l_path)
    LET l_path = FGL_GETENV("FGLRESOURCEPATH")
    DISPLAY l_path

    CALL hello_world()
END MAIN