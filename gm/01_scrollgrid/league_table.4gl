IMPORT util
MAIN
DEFINE ladder DYNAMIC ARRAY OF RECORD
    team STRING,
    win,draw,loss, for, against, goal_difference, pts INTEGER,
    w,d,l,f,a,p STRING
END RECORD
DEFINE att DYNAMIC ARRAY OF STRING

DEFINE i,j INTEGER
DEFINE h, a INTEGER

CONSTANT TEAM_COUNT = 20

    CALL ui.Interface.loadStyles("league_table.4st")

    FOR i = 1 TO TEAM_COUNT
       # LET ladder[i].team = ASCII(64+i), ASCII(96+i), ASCII(96+i), ASCII(96+i), ASCII(96+i), ASCII(96+i), ASCII(96+i)
        LET ladder[i].win = 0
        LET ladder[i].draw = 0
        LET ladder[i].loss = 0
        LET ladder[i].for= 0
        LET ladder[i].against = 0
    END FOR
    LET ladder[1].team = "Arsenal"
    LET ladder[2].team = "Man City"
    LET ladder[3].team = "Man Utd"
    LET ladder[4].team = "Liverpool"
    LET ladder[5].team = "Chelsea"
    LET ladder[6].team = "West Ham"
    LET ladder[7].team = "Southampton"
    LET ladder[8].team = "Leicester"
    LET ladder[9].team = "WBA"
    LET ladder[10].team = "Stoke"
    LET ladder[11].team = "Everton"
    LET ladder[12].team = "Swansea"
    LET ladder[13].team = "Bouremouth"
    LET ladder[14].team = "Burnley"
    LET ladder[15].team = "Crystal Palace"
    LET ladder[16].team = "Sunderland"
    LET ladder[17].team = "Middlesborough"
    LET ladder[18].team = "Watford"
    LET ladder[19].team = "Hull"
    LET ladder[20].team = "Tottenham"
    # populate ladder the hard way
    FOR i = 1 TO TEAM_COUNT
        FOR j = 1 TO TEAM_COUNT
            IF i<>j THEN
                IF i = 1 THEN LET h = 3
                ELSE
                LET h = util.Math.rand(100-3*i)/20
                END IF
                LET a = util.Math.rand(100-3*j)/25
                LET ladder[i].win = ladder[i].win + IIF(h>a,1,0)
                LET ladder[j].loss = ladder[j].loss + IIF(h>a,1,0) 
                LET ladder[i].loss = ladder[i].loss + IIF(h<a,1,0)
                LET ladder[j].win = ladder[j].win + IIF(h<a,1,0) 
                LET ladder[i].draw = ladder[i].draw + IIF(h=a,1,0)
                LET ladder[j].draw = ladder[j].draw + IIF(h=a,1,0)

                LET ladder[i].for = ladder[i].for + h
                LET ladder[j].against = ladder[j].against + h
                LET ladder[j].for = ladder[j].for + a
                LET ladder[i].against = ladder[i].against + a
            END IF
        END FOR
    END FOR

    -- Calculate goal diff, and points
    FOR i = 1 TO TEAM_COUNT
        LET ladder[i].goal_difference = ladder[i].for - ladder[i].against
        LET ladder[i].pts = 3 * ladder[i].win + ladder[i].draw
    END FOR

    -- Sort array pts, then goal diff, then goals scored
    CALL ladder.sort("for", TRUE)
    CALL ladder.sort("goal_difference", TRUE)
    CALL ladder.sort("pts", TRUE)

    -- Place integer data in strings
    FOR i = 1 TO TEAM_COUNT
        LET ladder[i].w = ladder[i].win USING "<&"
        LET ladder[i].d = ladder[i].draw USING "<&"
        LET ladder[i].l = ladder[i].loss USING "<&"
        LET ladder[i].f = ladder[i].for USING "<<&"
        LET ladder[i].a = ladder[i].against USING "<<&"
        LET ladder[i].p = ladder[i].pts USING "<<&"
    END FOR

    -- Insert row at beginning for titles
    CALL ladder.insertElement(1)
    #LET ladder[1].team = "Team"
    LET ladder[1].w = "W"
    LET ladder[1].d = "D"
    LET ladder[1].l = "L"
    LET ladder[1].f = "F"
    LET ladder[1].a = "A"
    LET ladder[1].p = "P"

    LET att[1]  = "bold underline"
    

     -- Promoted teams in green
    --FOR i = 1 TO  4#(TEAM_COUNT*0.20)
        --LET att[i+1].team = "#00ff00 bold"
        --LET att[i+1].w = "#00ff00 bold"
        --LET att[i+1].d = "#00ff00 bold"
        --LET att[i+1].l = "#00ff00 bold"
        --LET att[i+1].f = "#00ff00 bold"
        --LET att[i+1].a = "#00ff00 bold"
        --LET att[i+1].p = "#00ff00 bold"
    --END FOR

    -- Relegated teams in red
    --FOR i =18 TO 20# (TEAM_COUNT*0.90) TO TEAM_COUNT
        --LET att[i+1].team = "red"
        --LET att[i+1].w = "red"
        --LET att[i+1].d = "red"
        --LET att[i+1].l = "red"
        --LET att[i+1].f = "red"
        --LET att[i+1].a = "red"
        --LET att[i+1].p = "red"
    --END FOR
   
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "league_table"
    DISPLAY ARRAY ladder TO scr.* ATTRIBUTES(ACCEPT=FALSE)
        BEFORE DISPLAY 
            CALL DIALOG.setCellAttributes(att)

    END DISPLAY
END MAIN    