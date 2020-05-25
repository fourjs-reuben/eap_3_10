IMPORT util
MAIN
DEFINE ladder DYNAMIC ARRAY OF RECORD
    team STRING,
    win,draw,loss, for, against, goal_difference, pts INTEGER,
    w,d,l,f,a,p STRING
END RECORD
DEFINE att DYNAMIC ARRAY OF RECORD
    team STRING,
    win,draw,loss, for, against, goal_difference, pts STRING,
    w,d,l,f,a,p STRING
END RECORD
DEFINE i,j INTEGER
DEFINE h, a INTEGER

DEFINE colour_att STRING
DEFINE colour_dict DICTIONARY OF STRING

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
    LET ladder[1].team = "Arsenal"     LET colour_dict["Arsenal"]="#FF0000 reverse bold"
    LET ladder[2].team = "Man City"    LET colour_dict["Man City"]="lightBlue reverse bold"
    LET ladder[3].team = "Man Utd"      LET colour_dict["Man Utd"]="#FF0000 reverse bold"
    LET ladder[4].team = "Liverpool"   LET colour_dict["Liverpool"]="#FF0000 reverse bold"
    LET ladder[5].team = "Chelsea"      LET colour_dict["Chelsea"]="#0000FF reverse bold"
    LET ladder[6].team = "West Ham"        LET colour_dict["West Ham"]="#6B0002 reverse bold"
    LET ladder[7].team = "Southampton"     LET colour_dict["Southampton"]="#FF0000 bold"
    LET ladder[8].team = "Leicester"      LET colour_dict["Leicester"]="#0000FF reverse bold"
    LET ladder[9].team = "WBA"             LET colour_dict["WBA"]="#0000FF bold"
    LET ladder[10].team = "Stoke"           LET colour_dict["Stoke"]="#FF0000 bold"
    LET ladder[11].team = "Everton"       LET colour_dict["Everton"]="#0000FF reverse bold"
    LET ladder[12].team = "Swansea"        LET colour_dict["Swansea"]="black bold"
    LET ladder[13].team = "Bournemouth"       LET colour_dict["Bournemouth"]="#FF0000 reverse bold"
    LET ladder[14].team = "Burnley"         LET colour_dict["Burnley"]="#6B0002 reverse bold"
    LET ladder[15].team = "Crystal Palace"   LET colour_dict["Crystal Palace"]="#FF0000 reverse bold"
    LET ladder[16].team = "Sunderland"        LET colour_dict["Sunderland"]="#FF0000 reverse bold"
    LET ladder[17].team = "Middlesborough"    LET colour_dict["Middlesborough"]="#FF0000 reverse bold"
    LET ladder[18].team = "Watford"      LET colour_dict["Watford"]="#FFFF00 reverse bold"
    LET ladder[19].team = "Hull"         LET colour_dict["Hull"]="orange reverse bold"
    LET ladder[20].team = "Tottenham"      LET colour_dict["Tottenham"]="#0000FF bold"
    # populate ladder the hard way
    FOR i = 1 TO TEAM_COUNT
        FOR j = 1 TO TEAM_COUNT
            IF i<>j THEN
                LET h = util.Math.rand(100-3*i)/IIF(i=1,10,20)
                LET a = util.Math.rand(100-3*j)/IIF(j=1,25,50)
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

   
    FOR i = 1 TO 20
        
        LET att[i].team = colour_dict[ladder[i].team]
    END FOR
     -- Promoted teams in green
    --FOR i = 1 TO  4#(TEAM_COUNT*0.20)
       --
        --LET att[i].w = "#00ff00"
        --LET att[i].d = "#00ff00"
        --LET att[i].l = "#00ff00"
        --LET att[i].f = "#00ff00"
        --LET att[i].a = "#00ff00"
        --LET att[i].p = "#00ff00"
    --END FOR
--
    -- Relegated teams in red
    --FOR i =18 TO 20# (TEAM_COUNT*0.90) TO TEAM_COUNT
        --
        --LET att[i].w = "red"
        --LET att[i].d = "red"
        --LET att[i].l = "red"
        --LET att[i].f = "red"
        --LET att[i].a = "red"
        --LET att[i].p = "red"
    --END FOR
   
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "league_table"
    DISPLAY ARRAY ladder TO scr.* ATTRIBUTES(ACCEPT=FALSE, CANCEL=FALSE)
        BEFORE DISPLAY 
           CALL DIALOG.setArrayAttributes("scr",att)
    END DISPLAY
END MAIN    