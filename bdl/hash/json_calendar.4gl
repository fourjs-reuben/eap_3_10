IMPORT util

DEFINE month_json util.JSONObject

MAIN
CONSTANT ITERATIONS=100000
DEFINE test_value STRING
DEFINE i INTEGER

    LET month_json = util.JSONObject.create() -- i is same argument as used in put, get
    CALL init_month_json()
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
    --DISPLAY test_value, month_idx

    -- CALL month_hash.get(test_value, month_idx2)  -- get value using hash
    LET month_idx2 = get_month_json(test_value)     -- use a function so equivalent overhead
   -- DISPLAY test_value, month_idx2
END FUNCTION



FUNCTION get_month_json(m)
DEFINE m STRING   -- Month as string
DEFINE v INTEGER  -- Month as integer
    RETURN month_json.get(m)  -- get value using hash
    RETURN v
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



FUNCTION init_month_json()
    CALL month_json.put("January",1)
    CALL month_json.put("February",2)
    CALL month_json.put("March",3)
    CALL month_json.put("April",4)
    CALL month_json.put("May",5)
    CALL month_json.put("June",6)
    CALL month_json.put("July",7)
    CALL month_json.put("August",8)
    CALL month_json.put("September",9)
    CALL month_json.put("October",10)
    CALL month_json.put("November",11)
    CALL month_json.put("December",12)
END FUNCTION