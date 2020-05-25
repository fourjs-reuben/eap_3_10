MAIN
DEFINE te1, te2 STRING

    LET te1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    LET te2 = te1
    OPEN WINDOW w WITH FORM "noteditable_textedit"
    --DISPLAY BY NAME te1, te2
    --MENU ""
        --ON ACTION accept
            --EXIT MENU
    --END MENU
    INPUT BY NAME te1, te2 ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
END MAIN