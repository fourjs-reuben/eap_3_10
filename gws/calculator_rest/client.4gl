IMPORT com
IMPORT xml 
IMPORT util

TYPE TYP_status RECORD
        code INTEGER,
        desc STRING
    END RECORD
    
PUBLIC DEFINE info RECORD
    url     STRING,
    verb    STRING,
    reqtype STRING,
    request STRING,
    status  STRING,
    resptype STRING,
    response STRING,
    result RECORD
        code INT,
        desc STRING
    END RECORD
END RECORD

DEFINE 
    add_in RECORD
      a INTEGER,
      b INTEGER
    END RECORD,
    add_out RECORD
      status TYP_status,
      r INTEGER
    END RECORD

MAIN
    DEFINE req com.HttpRequest
    DEFINE resp com.HttpResponse
    DEFINE doc xml.DomDocument
    DEFINE node xml.DomNode

    TRY
        LET add_in.a = 1
        LET add_in.b = 2
        LET req = com.HttpRequest.Create("http://localhost:8095/add?a=" || add_in.a || "&b=" || add_in.b)
        CALL req.setMethod("GET")
        CALL req.setHeader("Content-Type", "application/json")
        CALL req.setHeader("Accept", "application/json")
        CALL req.doRequest()
        LET resp = req.getResponse()

        LET info.status = resp.getStatusCode() 
        IF  info.status = 200 THEN
            LET info.resptype = resp.getHeader("Content-Type")
            IF info.resptype.getIndexOf("/xml",1) THEN
                LET doc = resp.getXmlResponse()
                LET node = doc.getDocumentElement()
                CALL xml.Serializer.DomToVariable(node, add_out)
                LET info.response = node.toString()
            ELSE
                LET info.response = resp.getTextResponse()
                CALL util.JSON.parse(info.response, add_out)
            END IF
            IF add_out.status.code = 0 THEN
                DISPLAY add_in.a USING "#", " + ", add_in.b USING "#", " = ", add_out.r USING "#"
            ELSE
                DISPLAY "[", add_out.status.code, "] ", add_out.r
            END IF
        ELSE
            LET info.response = SFMT("[%1] %2",resp.getStatusCode(), resp.getStatusDescription())
        END IF
    CATCH
        LET info.result.code = status
        LET info.result.desc = sqlca.sqlerrm
    END TRY
END MAIN