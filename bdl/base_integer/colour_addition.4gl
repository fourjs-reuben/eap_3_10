IMPORT util
TYPE colourType RECORD
    r, g, b INTEGER,
    hex STRING
END RECORD
MAIN
DEFINE a colourType

    OPEN WINDOW w WITH FORM "colour_addition"
    LET a.r = 0
    LET a.g = 0
    LET a.b= 0
    LET a.hex = rgb_to_hex(a.r, a.g, a.b)
    
    INPUT a.r, a.g, a.b, a.hex FROM r,g,b,h ATTRIBUTES(UNBUFFERED, WITHOUT DEFAULTS=TRUE, ACCEPT=FALSE, CANCEL=FALSE)
        BEFORE INPUT
            CALL display_colour(a.hex)

        ON CHANGE r
            LET a.hex = rgb_to_hex(a.r, a.g, a.b)
            CALL display_colour(a.hex)

        ON CHANGE g
            LET a.hex = rgb_to_hex(a.r, a.g, a.b)
            CALL display_colour(a.hex)

        ON CHANGE b
            LET a.hex = rgb_to_hex(a.r, a.g, a.b)
            CALL display_colour(a.hex)

        ON CHANGE h
            CALL hex_to_rgb(a.hex) RETURNING a.r, a.g, a.b
            CALL display_colour(a.hex)

        ON ACTION dialogtouched INFIELD h
          #  IF a.hex MATCHES "#??????" THEN
            CALL hex_to_rgb(FGL_DIALOG_GETBUFFER()) RETURNING a.r, a.g, a.b
            CALL display_colour(FGL_DIALOG_GETBUFFER())
          #  END IF

        ON ACTION darker
            LET a.r = a.r * 0.9
            LET a.g = a.g * 0.9
            LET a.b = a.b * 0.9
            LET a.hex = rgb_to_hex(a.r, a.g, a.b)
            CALL display_colour(a.hex)

        ON ACTION lighter
            LET a.r = (a.r - 256) * 0.9 + 256
            LET a.g = (a.g - 256) * 0.9 + 256
            LET a.b = (a.b - 256) * 0.9 + 256

            LET a.hex = rgb_to_hex(a.r, a.g, a.b)
            CALL display_colour(a.hex)

        ON ACTION random
            LET a.r = util.Math.rand(256)
            LET a.g = util.Math.rand(256)
            LET a.b = util.Math.rand(256)
            LET a.hex = rgb_to_hex(a.r, a.g, a.b)
            CALL display_colour(a.hex)

        ON ACTION close
            EXIT INPUT
    END INPUT
END MAIN



FUNCTION display_colour(c)
DEFINE c STRING
DEFINE h STRING

    LET h = SFMT('<html><body style="background-color:%1"> </body></html>', c)
    DISPLAY h TO colour;
END FUNCTION



FUNCTION gradient_colour(a,b,gradient)
DEFINE a,b,c colourType
DEFINE gradient FLOAT

    LET c.r= a.r + (b.r-a.r) * gradient
    LET c.g= a.g + (b.g-a.g) * gradient
    LET c.b= a.b + (b.b-a.b) * gradient

    RETURN c.*
END FUNCTION



FUNCTION rgb_to_hex(r,g,b)
DEFINE r,g,b INTEGER
DEFINE sb base.StringBuffer

    LET sb = base.StringBuffer.create()
    CALL sb.append("#")
    -- Should not need to to this for leading zeros.
    IF r < 16 THEN
        CALL sb.append("0")
    END IF
    CALL sb.append(util.Integer.toHexString(r))
    IF g < 16 THEN
        CALL sb.append("0")
    END IF
    CALL sb.append(util.Integer.toHexString(g))
    IF b < 16 THEN
        CALL sb.append("0")
    END IF
    CALL sb.append(util.Integer.toHexString(b))
    
    RETURN sb.toString()
END FUNCTION



FUNCTION hex_to_rgb(h)
DEFINE h STRING
DEFINE r,g,b INTEGER

    LET r = util.Integer.parseHexString(h.subString(2,3))
    LET g = util.Integer.parseHexString(h.subString(4,5))
    LET b = util.Integer.parseHexString(h.subString(6,7))
    RETURN r,g,b
END FUNCTION


