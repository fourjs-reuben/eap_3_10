IMPORT util

DEFINE month_dict DICTIONARY OF INTEGER

MAIN
CONSTANT ITERATIONS=100000
DEFINE test_value STRING
DEFINE i INTEGER

    CALL init_month_hash()
    FOR i = 1 TO ITERATIONS
        CASE util.Math.rand(12)+1
            WHEN 1  LET test_value = "January"
            WHEN 2  LET test_value = "February"
            WHEN 3  LET test_value = "March"
            WHEN 4  LET test_value = "April"
            WHEN 5  LET test_value = "May"
            WHEN 6  LET test_value = "June"
            WHEN 7  LET test_value = "July"
            WHEN 8  LET test_value = "August"
            WHEN 9  LET test_value = "September"
            WHEN 10 LET test_value = "October"
            WHEN 11 LET test_value = "November"
            WHEN 12 LET test_value = "December"
        END CASE
        CALL do_test(test_value)
    END FOR
END MAIN



FUNCTION do_test(test_value)
DEFINE test_value STRING
DEFINE month_idx, month_idx2 INTEGER

    LET month_idx = get_month_case(test_value)  -- get value using case
   # DISPLAY test_value, month_idx

    LET month_idx2 = get_month_hash(test_value)     -- use a function so equivalent overhead
    #DISPLAY test_value, month_idx2
END FUNCTION



FUNCTION get_month_hash(m)
DEFINE m STRING   -- Month as string
    RETURN month_dict[m]
END FUNCTION



FUNCTION get_month_case(m)
DEFINE m STRING
    CASE m
        WHEN "January"   RETURN 1
        WHEN "February"  RETURN 2
        WHEN "March"     RETURN 3
        WHEN "April"     RETURN 4
        WHEN "May"       RETURN 5
        WHEN "June"      RETURN 6
        WHEN "July"      RETURN 7
        WHEN "August"    RETURN 8
        WHEN "September" RETURN 9
        WHEN "October"   RETURN 10
        WHEN "November"  RETURN 11
        WHEN "December"  RETURN 12
    END CASE
END FUNCTION



FUNCTION init_month_hash()
DEFINE keys DYNAMIC ARRAY OF STRING
DEFINE i INTEGER
    LET month_dict["January"] = 1
    LET month_dict["February"] = 2
    LET month_dict["March"] = 3
    LET month_dict["April"] = 4
    LET month_dict["May"] = 5
    LET month_dict["June"] = 6
    LET month_dict["July"] = 7
    LET month_dict["August"] = 8
    LET month_dict["September"] = 9
    LET month_dict["October"] = 10
    LET month_dict["November"] = 11
    LET month_dict["December"] = 12
   

END FUNCTION