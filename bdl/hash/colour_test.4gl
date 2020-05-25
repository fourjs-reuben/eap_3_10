IMPORT FGL colour
DEFINE red, green, blue, yellow colour.colourPointer

MAIN
    LET red = colour.create(255,0,0)
    LET green = colour.create(0,255,0)
    LET blue = colour.create(0,0,255)

    LET yellow = colour.add(red, green)

    CALL colour.display(yellow)

    CALL colour.display_uuid(red)
    CALL colour.display_uuid(green)
    CALL colour.display_uuid(blue)
    CALL colour.display_uuid(yellow)
END MAIN

    

