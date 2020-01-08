<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     pathuri.xsl    
    Func:       Parsing and assembling paths and URIs
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:java-urldecode="java:java.net.URLDecoder"
    exclude-result-prefixes="cpm java-urldecode xs"
    version="2.0">
    
    
    <xsl:template name="cpm.pathuri.decodeURI">        
        <xsl:param name="strItem"/>        
        <xsl:value-of select="java-urldecode:decode($strItem, 'UTF-8')"/>        
    </xsl:template>
    
    
    <xsl:function name="cpm:pathuri.parseURI">
        
        <xsl:param name="strURI"/>
        
        
    </xsl:function>
    
    <xsl:function name="cpm:pathuri.isPath" as="xs:boolean">
        
    </xsl:function>
    
    <xsl:function name="cpm:pathuri.isURI" as="xs:boolean">
        
    </xsl:function>
    
    <xsl:template name="cpm:pathuri.normalize">
        
        
    </xsl:template>
    
    
    <xsl:function name="cpm:pathuri.isAbsolute" as="xs:boolean">
        
    </xsl:function>
    
    
    <xsl:function name="cpm.pathuri.drive">
        
    </xsl:function>
    
    <xsl:function name="cpm.pathuri.parentFolder">
        
    </xsl:function>
    
    <xsl:function name="cpm.pathuri.file">
        
    </xsl:function>
    
    <xsl:function name="cpm.pathuri.fileName">
        
    </xsl:function>
    
    <xsl:function name="cpm.pathuri.fileNameType">
        
    </xsl:function>
    
    <xsl:function name="cpm.pathuri.fileNameBase">
        
    </xsl:function>
        
    <xsl:function name="cpm.pathuri.path">
        
    </xsl:function>
    
    <xsl:function name="cpm.pathuri.uri">
        
    </xsl:function>
    
    <xsl:function name="cpm.pathuri.relative">
        
        <xsl:param name="strBaseURI"/>
        
        <xsl:param name="strTargetURI"/>
        
    </xsl:function>
    
</xsl:stylesheet>