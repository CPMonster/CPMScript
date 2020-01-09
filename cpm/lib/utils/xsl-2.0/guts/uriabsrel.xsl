<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     uriabsrel.xsl
    Usage:      Guts    
    Func:       Assembling absolute and relative URIs
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <!-- 
        Modules
    -->
    
    <!-- Working with URIs -->
    <xsl:import href="uriquery.xsl"/>
    
                
    <!-- 
        Assembling an absolute URI 
    -->
    <xsl:function name="cpm:pathuri.absoluteURI">
        
        <!-- E.g. file:/c:/foo/bar or file:/c:/foo/bar/ -->
        <!-- A relative URI is also allowed here -->
        <xsl:param name="strBaseURI"/>
        
        <!-- E.g. kaboom.jpg or taraboom/kaboom.jpg -->
        <xsl:param name="strRelativeURI"/>
        
        <xsl:variable name="strSep">
            <xsl:if test="not(ends-with($strBaseURI, '/'))">
                <xsl:text>/</xsl:text>
            </xsl:if>
        </xsl:variable>
        
        <xsl:value-of select="concat($strBaseURI, $strSep, $strRelativeURI)"/>
        
    </xsl:function>
    
    
    <!-- 
        Assembling a relative URI
    -->
    <xsl:function name="cpm:pathuri.relativeURI">
        
        <xsl:param name="strBaseURI"/>
        
        <xsl:param name="strTargetURI"/>
        
    </xsl:function>
    
    
</xsl:stylesheet>