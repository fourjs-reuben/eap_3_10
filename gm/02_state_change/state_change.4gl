MAIN
    MENU ""
        ON ACTION enterbackground
            DISPLAY "Background entered"
        ON ACTION enterforeground
            DISPLAY "Foreground entered"
        ON TIMER 5
            DISPLAY "Timer triggered", CURRENT HOUR TO SECOND
        ON ACTION child
            MENU ""
                ON ACTION accept
                    EXIT MENU
            END MENU
        ON ACTION sleep_test
            MENU ""
                ON ACTION accept
                    EXIT MENU
                ON ACTION enterbackground
                    DISPLAY "Background (sleep 1) entered"
                ON ACTION enterforeground
                    DISPLAY "Foreground (sleep 1) entered"
            END MENU
            SLEEP 30
             MENU ""
                ON ACTION accept
                    EXIT MENU
                ON ACTION enterbackground
                    DISPLAY "Background (sleep 2) entered"
                ON ACTION enterforeground
                    DISPLAY "Foreground (sleep 2) entered"
            END MENU
            
        ON ACTION close
            EXIT MENU
    END MENU
END MAIN