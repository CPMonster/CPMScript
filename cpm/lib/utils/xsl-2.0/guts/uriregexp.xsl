<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     uriregexp.xsl
    Usage:      Guts    
    Func:       Providing regular expressions for parsing URIs
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
    
    <!-- Assembling regular expressions -->
    <xsl:import href="../regexp.xsl"/>
    
    
    <!-- 
        Providing building blocks for URI regexps
    -->
    
    <xsl:function name="cpm:uriregexp.protocol">
        <xsl:text><![CDATA[[A-Za-z\d]+]]></xsl:text>
    </xsl:function>
    
    <xsl:function name="cpm:uriregexp.login">
        <xsl:text><![CDATA[[A-Za-z\d\-_]+]]></xsl:text>
    </xsl:function>
    
    <xsl:function name="cpm:uriregexp.password">
        <xsl:text><![CDATA[[A-Za-z\d\-_]+]]></xsl:text>
    </xsl:function>
    
    <xsl:function name="cpm:uriregexp.credentials">
        <xsl:call-template name="cpm.regexp.sequenceGroup">
            <xsl:with-param name="seqItems">
                <xsl:value-of select="cpm:uriregexp.login()"/>
                <xsl:text>:</xsl:text>
                <xsl:value-of select="cpm:uriregexp.password()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:function>
    
    
    <!-- 
        Providing regexps for URIs
    -->
    
    <xsl:function name="cpm:uri.regexpRelative">
        <xsl:text><![CDATA[.+]]></xsl:text>                
    </xsl:function>
    
    <xsl:function name="cpm:uri.regexpAbsolute">
        <xsl:text><![CDATA[.+]]></xsl:text>                
    </xsl:function>
    
    
</xsl:stylesheet>