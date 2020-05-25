IMPORT util

TYPE arrType DYNAMIC ARRAY OF RECORD
    key INTEGER
END RECORD
DEFINE a arrType

CONSTANT TEST_ITERATIONS = 100
CONSTANT ARRAY_SIZE = 5000


MAIN
DEFINE i iNTEGER
DEFINE test_value INTEGER
    CALL init()
    FOR i = 1 TO TEST_ITERATIONS
         LET test_value = util.Math.rand(ARRAY_SIZE)+1
         CALL do_test(test_value)
    END FOR
END MAIN



FUNCTION do_test(test_value)
DEFINE test_value INTEGER
DEFINE test_result INTEGER
    LET test_result =  search_manually(test_value)
    # LET test_result =  search_manually2(test_value)
     LET test_result =  search_method(test_value)
    #LET test_result =  search_sorted(test_value)
END FUNCTION



FUNCTION search_manually(test_value)
DEFINE test_value INTEGER
DEFINE i INTEGER
DEFINE len INTEGER

    FOR i = 1 TO a.getLength()
        IF a[i].key = test_value THEN
            RETURN i
        END IF
    END FOR
    RETURN 0
END FUNCTION

FUNCTION search_manually2(test_value)
DEFINE test_value INTEGER
DEFINE i INTEGER
DEFINE len INTEGER

    LET len = a.getLength()
    FOR i = 1 TO len
        IF a[i].key = test_value THEN
            RETURN i
        END IF
    END FOR
    RETURN 0
END FUNCTION


{
FUNCTION search_sorted(test_value)
DEFINE test_value INTEGER
    RETURN search_sorted_binary(test_value,1,a.getLength())
END FUNCTION

FUNCTION search_sorted_binary(test_value, low_value, high_value)
DEFINE test_value, low_value, high_value, mid_value INTEGER

    IF low_value = high_value THEN
        RETURN a[low_value].key
    ELSE
        LET mid_value = (high_value-low_value)/2+low_value
        CASE
            WHEN a[mid_value].key > test_value 
                RETURN search_sorted_binary(test_value, low_value, mid_value-1)
            WHEN a[mid_value].key < test_value
                RETURN search_sorted_binary(test_value, mid_value+1, high_value)
            OTHERWISE
                RETURN a[low_value].key
        END CASE
    END IF
END FUNCTION
}

FUNCTION search_method(test_value)
DEFINE test_value INTEGER
   RETURN a.search("key",test_value)
END FUNCTION



FUNCTION init()
DEFINE i INTEGER
    FOR i = 1 TO ARRAY_SIZE
        LET a[i].key = i
    END FOR
END FUNCTION
