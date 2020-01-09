<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     encoding.xsl    
    Usage:      Library
    Func:       Working with symbol encoding
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:java-urldecode="java:java.net.URLDecoder" 
    exclude-result-prefixes="cpm java-urldecode xs"
    version="2.0">
    
    <!-- 
        Replacing codes like %20 with corresponding Unicode characters 
    -->
    <xsl:function name="cpm:pathuri.decodeURI">
        <xsl:param name="strItem"/>
        <xsl:value-of select="java-urldecode:decode($strItem, 'UTF-8')"/>
    </xsl:function>
    
</xsl:stylesheet>