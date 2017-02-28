This program illustrates an XSLT Transformation, taking as inout some data in 
xml form, a transformation as .xslt, and using the new xml.XSLTTransformer
methods to create some .html

This example replicates what the w3schools try it yourself example does at
https://www.w3schools.com/xml/tryxslt.asp?xmlfile=cdcatalog&xsltfile=cdcatalog

It also has a link to a real life example of a transformation at 
http://harness.hrnz.co.nz/gws/ws/r/infohorsews/wsd06x?Arg=hrnzg-Ptype&Arg=HorseSearch&Arg=hrnzg-DoSearch&Arg=TRUE&Arg=hrnzg-HorseName&Arg=Four+Jays
(Note the gws/ws/r in the URL)
Harness wrote this before we added XSLT transformation to the product but will
hopefully modify their sources to use our method when they upgrade to 3.10

If you navigate around their web-site, either from "Fields" 
(http://infohorse.hrnz.co.nz/datahr/fields/fields.htm) on their home page
or from Infohorse http://harness.hrnz.co.nz/gws/ws/r/infohorsews/wsd08x you will
see a number of web pages created by running an XSLT transformation on data in
their database.  

As an optimization, they generate overnight a number of pages and serve these
as static web pages, but as you drill down you will eventually see /ws/r/ in 
the URL which indicates page is being generated on demand via an XSLT 
transformation.
