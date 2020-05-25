IMPORT util

MAIN
    DISPLAY bsd_checksum("reuben")
END MAIN

FUNCTION bsd_checksum(s)
DEFINE s STRING
DEFINE c SMALLINT
DEFINE checksum INTEGER
DEFINE i INTEGER

DEFINE ff INTEGER

    LET ff = util.Integer.parseHexString("FF")

    LET checksum = 0
    FOR i = 1 TO s.getLength()
        LET c = ORD(s.getCharAt(i))
        DISPLAY checksum,"-",c
        LET checksum = checksum + c
        LET checksum = util.Integer.shiftRight(checksum, 1)
        #LET checksum =  util.Integer.and(checksum,ff)
    END FOR
    RETURN checksum
END FUNCTION

