IMPORT security
PUBLIC TYPE colourPointer STRING
TYPE colourType RECORD
    r,g,b SMALLINT
END RECORD
PRIVATE DEFINE colour DICTIONARY OF colourType

FUNCTION create(r SMALLINT, g SMALLINT,b SMALLINT) RETURNS colourPointer
DEFINE id colourPointer
    LET id = security.RandomGenerator.CreateUUIDString()
    LET colour[id].r = r
    LET colour[id].g = g
    LET colour[id].b = b
    RETURN id
END FUNCTION

FUNCTION remove(id colourPointer)
    CALL colour.remove(id)
END FUNCTION

FUNCTION add(c1 colourPointer,c2 colourPointer) RETURNS colourPointer
DEFINE id colourPointer

    LET id = security.RandomGenerator.CreateUUIDString()
    LET colour[id].r = colour[c1].r + colour[c2].r
    LET colour[id].g = colour[c1].g + colour[c2].g
    LET colour[id].b = colour[c1].b + colour[c2].b
    RETURN id
END FUNCTION

FUNCTION display(c colourPointer)
    DISPLAY SFMT("Red=%1, Green=%2, Blue=%3", colour[c].r, colour[c].g, colour[c].b)
END FUNCTION

FUNCTION display_uuid(c colourPointer)
    DISPLAY c
END FUNCTION


