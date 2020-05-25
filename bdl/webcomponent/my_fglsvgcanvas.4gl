IMPORT FGL fglsvgcanvas

MAIN
    DEFINE cid SMALLINT,
           root_svg om.DomNode,
           attr DYNAMIC ARRAY OF om.SaxAttributes,
           h,th,m,tm,s,ts SMALLINT,
           defs, gr, g, g2, g3, n om.DomNode

    OPEN FORM f1 FROM "my_fglsvgcanvas"
    DISPLAY FORM f1

    CALL fglsvgcanvas.initialize()
    LET cid = fglsvgcanvas.create("formonly.my_canvas")
    LET root_svg = fglsvgcanvas.setRootSVGAttributes( NULL,
                                   NULL, NULL,
                                   "0 0 270 270",
                                   "xMidYMid meet"
                                )
    CALL root_svg.setAttribute(SVGATT_CLASS,"root_svg")

    LET h = CURRENT HOUR TO HOUR || " "
    IF h > 12 THEN LET h = h - 12 END IF
    LET m = CURRENT MINUTE TO MINUTE || " "
    LET s = CURRENT SECOND TO SECOND || " "
    LET ts = 6*s
    LET tm = (m+s/60)*6
    LET th = (h+m/60+s/3600)*30

    LET attr[1] = om.SaxAttributes.create()
    CALL attr[1].addAttribute(SVGATT_STROKE,         "blue" )
    CALL attr[1].addAttribute(SVGATT_STROKE_WIDTH,   "5" )
    CALL attr[1].addAttribute(SVGATT_STROKE_LINECAP, "round" )

    LET attr[2] = om.SaxAttributes.create()
    CALL attr[2].addAttribute(SVGATT_STROKE,         "navy" )
    CALL attr[2].addAttribute(SVGATT_STROKE_WIDTH,   "4" )
    CALL attr[2].addAttribute(SVGATT_STROKE_LINECAP, "round" )

    LET attr[3] = om.SaxAttributes.create()
    CALL attr[3].addAttribute(SVGATT_STROKE,         "red" )
    CALL attr[3].addAttribute(SVGATT_STROKE_WIDTH,   "2" )
    CALL attr[3].addAttribute(SVGATT_STROKE_LINECAP, "round" )

    LET attr[4] = om.SaxAttributes.create()
    CALL attr[4].addAttribute(SVGATT_FILL,           "none" )
    CALL attr[4].addAttribute(SVGATT_STROKE,         "gray" )
    CALL attr[4].addAttribute(SVGATT_STROKE_WIDTH,   "1" )

    LET attr[5] = om.SaxAttributes.create()
    CALL attr[5].addAttribute(SVGATT_FILL,           "none" )
    CALL attr[5].addAttribute(SVGATT_STROKE,         "gray" )
    CALL attr[5].addAttribute(SVGATT_STROKE_WIDTH,   "4" )

    LET attr[6] = om.SaxAttributes.create()
    CALL attr[6].addAttribute(SVGATT_FILL,             "none" )
    CALL attr[6].addAttribute(SVGATT_STROKE,           "lightBlue" )
    CALL attr[6].addAttribute(SVGATT_STROKE_WIDTH,     "5" )
    CALL attr[6].addAttribute(SVGATT_STROKE_DASHARRAY, "2,8.471976" )
    CALL attr[6].addAttribute(SVGATT_TRANSFORM,        "rotate(-.873)" )

    LET attr[7] = om.SaxAttributes.create()
    CALL attr[7].addAttribute(SVGATT_FILL,             "none" )
    CALL attr[7].addAttribute(SVGATT_STROKE,           "blue" )
    CALL attr[7].addAttribute(SVGATT_STROKE_WIDTH,     "11" )
    CALL attr[7].addAttribute(SVGATT_STROKE_DASHARRAY, "4,46.789082" )
    CALL attr[7].addAttribute(SVGATT_TRANSFORM,        "rotate(-1.5)" )

    LET defs = fglsvgcanvas.defs( NULL )
    CALL root_svg.appendChild( defs )

    LET gr = fglsvgcanvas.radialGradient( "gradient_1",
                                         NULL, NULL, "5%", "5%", "65%",
                                         "pad", NULL, NULL )
    CALL gr.appendChild( fglsvgcanvas.stop(   "0%", "gray", 0.4 ) )
    CALL gr.appendChild( fglsvgcanvas.stop( "100%", "navy", 0.7 ) )
    CALL defs.appendChild( gr )

    LET g = fglsvgcanvas.g( "clock" )
    CALL g.setAttribute(SVGATT_TRANSFORM,"translate(135,135)")
    CALL root_svg.appendChild( g )
    LET g2 = fglsvgcanvas.g( NULL )
    CALL g.appendChild( g2 )
    CALL g2.appendChild( n:=fglsvgcanvas.circle(0,0,110) )
    CALL n.setAttribute(SVGATT_STYLE, "fill:url(#gradient_1);")
    CALL g2.appendChild( n:=fglsvgcanvas.circle(0,0,115) )
    CALL n.setAttribute(SVGATT_STYLE, fglsvgcanvas.styleAttributeList(attr[4]))
    CALL g2.appendChild( n:=fglsvgcanvas.circle(0,0,108) )
    CALL n.setAttribute(SVGATT_STYLE, fglsvgcanvas.styleAttributeList(attr[5]))
    CALL g2.appendChild( n:=fglsvgcanvas.circle(0,0,100) )
    CALL n.setAttribute(SVGATT_STYLE, fglsvgcanvas.styleAttributeList(attr[6]))
    CALL g2.appendChild( n:=fglsvgcanvas.circle(0,0, 97) )
    CALL n.setAttribute(SVGATT_STYLE, fglsvgcanvas.styleAttributeList(attr[7]))

    LET g2 = fglsvgcanvas.g( NULL )
    CALL g2.setAttribute(SVGATT_TRANSFORM,"rotate(180)")
    CALL g.appendChild( g2 )

    LET g3 = fglsvgcanvas.g( "hour" )
    CALL g3.setAttribute(SVGATT_TRANSFORM,SFMT("rotate(%1)",th))
    CALL g2.appendChild( g3 )
    CALL g3.appendChild( n:=fglsvgcanvas.line(0,0,0,75) )
    CALL n.setAttribute(SVGATT_STYLE,fglsvgcanvas.styleAttributeList(attr[1]))
    CALL g3.appendChild( fglsvgcanvas.animateTransform("transform", "XML", "rotate", NULL, NULL,
                                                       "360", NULL, "12h", "indefinite") )
    CALL g3.appendChild( fglsvgcanvas.circle(0,0,7) )

    LET g3 = fglsvgcanvas.g( "minute" )
    CALL g3.setAttribute(SVGATT_TRANSFORM,SFMT("rotate(%1)",tm))
    CALL g2.appendChild( g3 )
    CALL g3.appendChild( n:=fglsvgcanvas.line(0,0,0,93) )
    CALL n.setAttribute(SVGATT_STYLE,fglsvgcanvas.styleAttributeList(attr[2]))
    CALL g3.appendChild( fglsvgcanvas.animateTransform("transform", "XML", "rotate", NULL, NULL,
                                                       "360", NULL, "60min", "indefinite" ) )
    CALL g3.appendChild( n:=fglsvgcanvas.circle(0,0,6) )
    CALL n.setAttribute(SVGATT_STYLE,'fill="red"')

    LET g3 = fglsvgcanvas.g( "second" )
    CALL g3.setAttribute(SVGATT_TRANSFORM,SFMT("rotate(%1)",ts))
    CALL g2.appendChild( g3 )
    CALL g3.appendChild( n:=fglsvgcanvas.line(0,-20,0,102) )
    CALL n.setAttribute(SVGATT_STYLE,fglsvgcanvas.styleAttributeList(attr[3]))
    CALL g3.appendChild( fglsvgcanvas.animateTransform("transform", "XML", "rotate", NULL, NULL,
                                                       "360", NULL, "60s", "indefinite" ) )
    CALL g3.appendChild( n:=fglsvgcanvas.circle(0,0,4) )
    CALL n.setAttribute(SVGATT_STYLE,'fill="blue"')

    CALL fglsvgcanvas.display(cid)

    MENU "test" COMMAND "quit" EXIT MENU END MENU

    CALL fglsvgcanvas.destroy(cid)
    CALL fglsvgcanvas.finalize()

END MAIN