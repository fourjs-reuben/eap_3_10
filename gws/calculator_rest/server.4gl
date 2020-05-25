IMPORT com
IMPORT util 
IMPORT FGL WSHelper

TYPE TYP_status RECORD
        code INTEGER,
        desc STRING
    END RECORD

GLOBALS
  DEFINE 
    add_in RECORD
      a INTEGER,
      b INTEGER
    END RECORD,
    add_out RECORD
      status TYP_status,
      r INTEGER
    END RECORD

  DEFINE 
    substract_in RECORD
      a INTEGER,
      b INTEGER
    END RECORD,
    substract_out RECORD
      status TYP_status,
      r INTEGER
    END RECORD

  DEFINE 
    multiply_in RECORD
      a INTEGER,
      b INTEGER
    END RECORD,
    multiply_out RECORD
      status TYP_status,
      r INTEGER
    END RECORD

  DEFINE 
    divide_in RECORD
      a INTEGER,
      b INTEGER
    END RECORD,
    divide_out RECORD
      status TYP_status,
      quotient  INTEGER,
      remainder INTEGER
    END RECORD

  DEFINE
    err TYP_status
    
END GLOBALS

TYPE reqInfoTyp RECORD
    method      STRING,
    ctype       STRING,     # check the Content-Type
    informat    STRING,     # short word for Content Type 
    caccept     STRING,     # check which format the client accepts
    outformat   STRING,     # short word for Accept
    path        STRING,
    items       WSHelper.WSQueryType
END RECORD

DEFINE m_reqInfo reqInfoTyp

CONSTANT ERR_PARAM_A        = "Operand 'a' not found"
CONSTANT ERR_PARAM_B        = "Operand 'b' not found"
CONSTANT ERR_OPERATION      = "Operation not found"
CONSTANT ERR_METHOD         = "Method not supported"

MAIN
  DEFINE ret INTEGER
  DEFINE req com.HTTPServiceRequest
  DEFINE method STRING
  DEFINE url STRING
  DEFINE qry STRING
  DEFINE acc STRING
  DEFINE idx INT
      
  DEFER INTERRUPT
    
  #
  # Start the server
  #
  DISPLAY "Starting server..."
  #
  # Starts the server on the port number specified by the FGLAPPSERVER environment variable
  #  (EX: FGLAPPSERVER=8090)
  # 
  CALL com.WebServiceEngine.Start()
  DISPLAY "The server is listening."

  # create the server
  WHILE TRUE
      TRY
          LET req = com.WebServiceEngine.getHTTPServiceRequest(-1)
          CALL getReqInfo(req)
          # Get the type of method
          LET method = m_reqInfo.method
          # Get the request path
          LET url = m_reqInfo.path
          # Get the output format
          LET acc = m_reqInfo.outformat

          DISPLAY "Processing request... ", method, " ", url

          # parse the url, retrieve the operation and the operand
          CASE method
              WHEN "GET"
                IF url.getIndexOf("/add",1) > 0 THEN
                    LET idx = getParameterIndex("a") 
                    IF idx = 0 THEN
                        LET add_out.status.code = -1
                        LET add_out.status.desc = ERR_PARAM_A
                        CALL req.setResponseHeader("Content-Type","application/json")
                        CALL req.sendTextResponse(200, "OK", util.JSON.stringify(add_out))
                        EXIT CASE
                    ELSE
                        LET add_in.a = getParameterValue(idx)
                    END IF
                    LET idx = getParameterIndex("b")
                    IF idx = 0 THEN
                        LET add_out.status.code = -1
                        LET add_out.status.desc = ERR_PARAM_B
                        CALL req.setResponseHeader("Content-Type","application/json")
                        CALL req.sendTextResponse(200, "OK", util.JSON.stringify(add_out))
                        EXIT CASE
                    ELSE
                        LET add_in.b = getParameterValue(idx)
                    END IF
                    CALL add()
                    CALL req.setResponseHeader("Content-Type","application/json")
                    CALL req.sendTextResponse(200, "OK", util.JSON.stringify(add_out))

                ELSE IF url.getIndexOf("/substract",1) > 0 THEN
                    LET idx = getParameterIndex("a") 
                    IF idx = 0 THEN
                        LET add_out.status.code = -1
                        LET add_out.status.desc = ERR_PARAM_A
                        CALL req.setResponseHeader("Content-Type","application/json")
                        CALL req.sendTextResponse(200, "OK", util.JSON.stringify(substract_out))
                        EXIT CASE
                    ELSE
                        LET substract_in.a = getParameterValue(idx)
                    END IF
                    LET idx = getParameterIndex("b")
                    IF idx = 0 THEN
                        LET add_out.status.code = -1
                        LET add_out.status.desc = ERR_PARAM_B
                        CALL req.setResponseHeader("Content-Type","application/json")
                        CALL req.sendTextResponse(200, "OK", util.JSON.stringify(substract_out))
                        EXIT CASE
                    ELSE
                        LET substract_in.b = getParameterValue(idx)
                    END IF
                    CALL substract()
                    CALL req.setResponseHeader("Content-Type","application/json")
                    CALL req.sendTextResponse(200, "OK", util.JSON.stringify(substract_out))
                    
                ELSE IF url.getIndexOf("/multiply",1) > 0 THEN
                    LET idx = getParameterIndex("a") 
                    IF idx = 0 THEN
                        LET add_out.status.code = -1
                        LET add_out.status.desc = ERR_PARAM_A
                        CALL req.setResponseHeader("Content-Type","application/json")
                        CALL req.sendTextResponse(200, "OK", util.JSON.stringify(multiply_out))
                        EXIT CASE
                    ELSE
                        LET multiply_in.a = getParameterValue(idx)
                    END IF
                    LET idx = getParameterIndex("b")
                    IF idx = 0 THEN
                        LET add_out.status.code = -1
                        LET add_out.status.desc = ERR_PARAM_B
                        CALL req.setResponseHeader("Content-Type","application/json")
                        CALL req.sendTextResponse(200, "OK", util.JSON.stringify(multiply_out))
                        EXIT CASE
                    ELSE
                        LET multiply_in.b = getParameterValue(idx)
                    END IF
                    CALL multiply()
                    CALL req.setResponseHeader("Content-Type","application/json")
                    CALL req.sendTextResponse(200, "OK", util.JSON.stringify(multiply_out))
                    
                ELSE IF url.getIndexOf("/divide",1) > 0 THEN
                    LET idx = getParameterIndex("a") 
                    IF idx = 0 THEN
                        LET add_out.status.code = -1
                        LET add_out.status.desc = ERR_PARAM_A
                        CALL req.setResponseHeader("Content-Type","application/json")
                        CALL req.sendTextResponse(200, "OK", util.JSON.stringify(divide_out))
                        EXIT CASE
                    ELSE
                        LET divide_in.a = getParameterValue(idx)
                    END IF
                    LET idx = getParameterIndex("b")
                    IF idx = 0 THEN
                        LET add_out.status.code = -1
                        LET add_out.status.desc = ERR_PARAM_B
                        CALL req.setResponseHeader("Content-Type","application/json")
                        CALL req.sendTextResponse(200, "OK", util.JSON.stringify(divide_out))
                        EXIT CASE
                    ELSE
                        LET divide_in.b = getParameterValue(idx)
                    END IF
                    CALL divide()
                    CALL req.setResponseHeader("Content-Type","application/json")
                    CALL req.sendTextResponse(200, "OK", util.JSON.stringify(divide_out))
                ELSE
                    CALL setError("Unknown request:\n" || url || "\n" || method)
                    LET err.code = -2
                    LET err.desc = ERR_OPERATION
                    CALL req.sendTextResponse(200,"OK",util.JSON.stringify(err))
                END IF
                END IF
                END IF
                END IF
              OTHERWISE
                CALL setError("Unknown request:\n" || url || "\n" || method)
                LET err.code = -3
                LET err.desc = ERR_METHOD
                CALL req.sendTextResponse(200,"OK",util.JSON.stringify(err))
          END CASE

          IF int_flag<>0 THEN
            LET int_flag=0
            EXIT WHILE
          END IF
        CATCH
            LET ret = STATUS
            CASE ret
            WHEN -15565
                DISPLAY "Disconnected from application server."
                EXIT WHILE
            OTHERWISE
                DISPLAY "[ERROR] " || ret
                EXIT WHILE
            END CASE
        END TRY
    END WHILE
END MAIN

FUNCTION add()
  LET add_out.r = add_in.a + add_in.b
  LET add_out.status.code = 0
  LET add_out.status.desc = "OK"
END FUNCTION

FUNCTION substract()
  LET substract_out.r = substract_in.a - substract_in.b
  LET substract_out.status.code = 0
  LET substract_out.status.desc = "OK"
END FUNCTION

FUNCTION multiply()
  LET multiply_out.r = multiply_in.a * multiply_in.b
END FUNCTION

FUNCTION divide()
  IF divide_in.b != 0 THEN 
    LET divide_out.quotient  = divide_in.a / divide_in.b
    LET divide_out.remainder = divide_in.a MOD divide_in.b
    LET divide_out.status.code = 0
    LET divide_out.status.desc = "OK"
  ELSE
    LET divide_out.status.code = 0
    LET divide_out.status.desc = "Cannot divide by 0"
  END IF
END FUNCTION

FUNCTION getHeaderByName(areq,hname)
    DEFINE areq com.HTTPServiceRequest
    DEFINE hname STRING

    DEFINE aname STRING
    DEFINE iname STRING
    DEFINE i INT
    DEFINE n INT

    LET aname = hname.toLowerCase()
    LET n = areq.getRequestHeaderCount()
    FOR i=1 TO n
        LET iname = areq.getRequestHeaderName(i)
        IF aname.equals(iname.toLowerCase()) THEN
            RETURN areq.getRequestHeaderValue(i)
        END IF
    END FOR

    RETURN NULL
END FUNCTION

FUNCTION getReqInfo(req)
    DEFINE req com.HTTPServiceRequest
    DEFINE str, val base.StringTokenizer
    DEFINE token STRING
    DEFINE i INT
    
    INITIALIZE m_reqInfo TO NULL

    LET m_reqInfo.ctype = getHeaderByName(req,"Content-Type")
    IF m_reqInfo.ctype.getIndexOf("/xml",1) THEN
        LET m_reqInfo.informat = "XML"
    ELSE 
        LET m_reqInfo.informat = "JSON"
    END IF
    
    LET m_reqInfo.caccept = getHeaderByName(req,"Accept")
    IF m_reqInfo.caccept.getIndexOf("/xml",1) THEN
        LET m_reqInfo.outformat = "XML"
    ELSE 
        LET m_reqInfo.outformat = "JSON"
    END IF
    
    LET m_reqInfo.method = req.getMethod()
    
    LET m_reqInfo.path = req.getURLPath()
    
    CALL req.getURLQuery(m_reqInfo.items)
  
END FUNCTION

FUNCTION setError(s)
    DEFINE s STRING
    DISPLAY s
END FUNCTION

# returns 0 if element not found
FUNCTION getParameterIndex(s)
    DEFINE s STRING
    DEFINE i INT

    FOR i=1 TO m_reqInfo.items.getLength()
        IF s.equals(m_reqInfo.items[i].name) THEN 
            RETURN i 
        END IF
    END FOR

    RETURN 0
END FUNCTION

FUNCTION getParameterValue(i)
    DEFINE i INT

    RETURN m_reqInfo.items[i].value
END FUNCTION