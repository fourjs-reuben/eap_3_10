MAIN

TYPE maths_function FUNCTION(x INT, y INT) RETURNS INT
DEFINE operation maths_function

    -- Do via callback functions
    LET operation = FUNCTION add
    DISPLAY operation(1,2)
    LET operation = FUNCTION sub
    DISPLAY operation(1,2)

    -- Do via use of a CASE statement
    DISPLAY do_via_case("add",1,2)
    DISPLAY do_via_case("sub",1,2)
    

END MAIN


FUNCTION add(x INTEGER, y INTEGER) RETURNS INTEGER
DEFINE z INTEGER
    LET z = x + y
    RETURN z
END FUNCTION

FUNCTION sub(x INTEGER, y INTEGER) RETURNS INTEGER
DEFINE z INTEGER
    LET z = x - y
    RETURN z
END FUNCTION


FUNCTION do_via_case(op,x,y)
DEFINE op STRING
DEFINE x,y INTEGER
DEFINE z INTEGER

    CASE op
        WHEN "add"
            LET z = add(x,y)
        WHEN "sub"
            LET z = sub(x,y)
    END CASE
    RETURN z
END FUNCTION