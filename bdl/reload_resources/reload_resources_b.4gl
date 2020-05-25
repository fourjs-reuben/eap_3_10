FUNCTION hello_world()
MENU %"title" ATTRIBUTES(STYLE="dialog", COMMENT=%"comment", IMAGE=%"flag")
        ON ACTION accept ATTRIBUTES(TEXT=%"accept.text")
            EXIT MENU
    END MENU
END FUNCTION