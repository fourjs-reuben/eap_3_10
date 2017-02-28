IMPORT xml
MAIN
DEFINE data, xslt, html STRING
DEFINE t TEXT

    LET data = populate_string_from_file("xslt_transformation_data.xml")
    LET xslt = populate_string_from_file("xslt_transformation_xslt.xml")


   # https://www.w3schools.com/xml/tryxslt.asp?xmlfile=cdcatalog&xsltfile=cdcatalog
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "xslt_transformation"

    INPUT BY NAME data, xslt, html ATTRIBUTES(UNBUFFERED, WITHOUT DEFAULTS=TRUE, ACCEPT=FALSE, CANCEL=FALSE)
        BEFORE INPUT
            CALL FGL_WINMESSAGE("Info","Click Transform button to view the result of the xslt transformation\nExperiment with changes to the xml and xslt.","info")
        ON ACTION transform ATTRIBUTES(TEXT="Transform")
            LET html = xslt_transform(data, xslt)
        ON ACTION real_world_example ATTRIBUTES(TEXT="Real World XSLT Example")
            CALL ui.Interface.frontCall("standard","launchurl","http://harness.hrnz.co.nz/gws/ws/r/infohorsews/wsd06x?Arg=hrnzg-Ptype&Arg=HorseSearch&Arg=hrnzg-DoSearch&Arg=TRUE&Arg=hrnzg-HorseName&Arg=Four+Jays",[])
        ON ACTION close
            EXIT INPUT
    END INPUT
END MAIN



FUNCTION xslt_transform(data, xslt)
DEFINE data, xslt STRING

DEFINE dom_data, dom_xslt, dom_result xml.DomDocument
DEFINE transformer xml.XSLTtransformer
DEFINE i INTEGER

    LET dom_data = xml.DomDocument.create()
    CALL dom_data.loadFromString(data)

    LET dom_xslt = xml.DomDocument.create()
    CALL dom_xslt.loadFromString(xslt)

    TRY
        LET transformer = xml.XSLTtransformer.createFromDocument(dom_xslt)
        FOR i = 1 TO transformer.getErrorsCount()
             DISPLAY "StyleSheet error #"||i||" : ",transformer.getErrorDescription(i)
        END FOR
    CATCH
        RETURN "Error: unable to create XSLT Transformer"
    END TRY

    TRY
        LET dom_result = transformer.doTransform(dom_data)
        FOR i = 1 TO transformer.getErrorsCount()
             DISPLAY "StyleSheet error #"||i||" : ",transformer.getErrorDescription(i)
        END FOR
    CATCH
        FOR i = 1 TO transformer.getErrorsCount()
             DISPLAY "Fatal error #"||i||" : ",transformer.getErrorDescription(i)
        END FOR
        RETURN "FATAL Error"

    END TRY

    RETURN dom_result.saveToString()
END FUNCTION

FUNCTION populate_string_from_file(filename)
DEFINE filename STRING
DEFINE t TEXT
DEFINE s STRING

    LOCATE t IN MEMORY
    CALL t.readFile(filename)
    LET s=t
    RETURN s
END FUNCTION

  
