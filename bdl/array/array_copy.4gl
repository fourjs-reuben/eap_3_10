TYPE arrType DYNAMIC ARRAY OF INTEGER
DEFINE a,b,c arrType

CONSTANT TEST_ITERATIONS = 100
CONSTANT ARRAY_SIZE = 5000


MAIN
DEFINE i iNTEGER
    CALL init()
    FOR i = 1 TO TEST_ITERATIONS
        CALL b.clear()
        CALL c.clear()
        CALL do_test()
    END FOR
END MAIN



FUNCTION do_test()
    CALL copy_manually()
    CALL copy_method()
END FUNCTION



FUNCTION copy_manually()
DEFINE i INTEGER
    CALL b.clear()
    FOR i = 1 TO a.getLength()
        LET b[i] = a[i]
    END FOR
END FUNCTION



FUNCTION copy_method()
    CALL a.copyTo(c)
END FUNCTION



FUNCTION init()
DEFINE i INTEGER
    FOR i = 1 TO ARRAY_SIZE
        LET a[i] = i
    END FOR
END FUNCTION