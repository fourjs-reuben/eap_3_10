MAIN
    DISPLAY add(1,2)
    DISPLAY add2(1,2)
#   DISPLAy ad
END MAIN

FUNCTION add(x,y)
DEFINE x,y,z INTEGER
    LET z = x + y
    RETURN z
END FUNCTION

FUNCTION add2(x INTEGER, y INTEGER) RETURNS INTEGER
DEFINE z INTEGER
    LET z = x + y
    RETURN z
END FUNCTION
