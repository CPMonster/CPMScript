<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     uriquery.xsl
    Usage:      Guts    
    Func:       Analyzing and assembling URIs
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
    
    <!-- Parsing URIs -->
    <xsl:import href="uriparse.xsl"/>
    
    
    <!-- 
        Recognizing protocols
    -->
    
    <!-- A string is not a protocol name by default -->
    <xsl:template match="*" mode="cpm.pathuri.isProtocol" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>
    
    <!-- Detecting standard protocols -->
    <xsl:template match="*[lower-case(@protocol) = ('file', 'ftp', 'http', 'https')]"
        mode="cpm.pathuri.isProtocol" as="xs:boolean">
        <xsl:value-of select="true()"/>
    </xsl:template>
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:pathuri.isProtocol" as="xs:boolean">
        <xsl:param name="strItem"/>
        <xsl:variable name="xmlData">
            <data protocol="{cpm:morestr.dockTail($strItem,':')}"/>
        </xsl:variable>
        <xsl:apply-templates select="$xmlData/data" mode="cpm.pathuri.isProtocol"/>
    </xsl:function>
    
    
    
    
    
    <xsl:function name="cpm:pathuri.protocol"> </xsl:function>
    
    <xsl:function name="cpm:pathuri.host"> </xsl:function>
    
    <xsl:function name="cpm:pathuri.drive"> </xsl:function>
    
    <xsl:function name="cpm:pathuri.parentFolder"> </xsl:function>
    
    <!-- 
        Extracting a local file from an URI
    -->
    <xsl:function name="cpm:pathuri.localFile">
        
        <xsl:param name="strURI"/>
        
        <xsl:variable name="xmlURI" select="cpm:pathuri.parseURI($strURI)"/>
        
        <xsl:variable name="tmp">
            <xsl:for-each select="$xmlURI//folder">
                <xsl:value-of select="."/>
                <xsl:text>/</xsl:text>
            </xsl:for-each>
            <xsl:value-of select="$xmlURI//file"/>
        </xsl:variable>
        
        <xsl:value-of select="$tmp"/>
        
    </xsl:function>
    
    <xsl:function name="cpm:pathuri.fileName"> </xsl:function>
    
    <xsl:function name="cpm:pathuri.fileNameType"> </xsl:function>
    
    <xsl:function name="cpm:pathuri.fileNameBase"> </xsl:function>
    
    <!-- <xsl:function name="cpm:pathuri.isURI" as="xs:boolean"> </xsl:function> -->
    
    
    
    
    <!-- <xsl:function name="cpm:pathuri.isAbsolute" as="xs:boolean"> </xsl:function> -->
    
    <!--
    <xsl:function name="cpm:pathuri.fileURI">

        <xsl:param name="strItem"/>

        <xsl:choose>
            <xsl:when test="cpm:pathuri.isURI()">
                <xsl:value-of select="$strItem"/>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>

    </xsl:function>
    -->
    
    <xsl:function name="cpm:pathuri.inetURI">
        
        <xsl:param name="strItem"/>
        
        <xsl:param name="strProtocol"/>
        
        <xsl:param name="strHost"/>
        
        
        
    </xsl:function>
    
</xsl:stylesheet>