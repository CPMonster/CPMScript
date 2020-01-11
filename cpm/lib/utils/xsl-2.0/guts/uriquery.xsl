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
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules 
    -->

    <!-- Parsing URIs -->
    <xsl:import href="uriparse.xsl"/>


    <!-- 
        Detecting protocols
    -->

    <!-- A string is not a protocol name by default -->
    <xsl:template match="*" mode="cpm.uri.isProtocol" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>

    <!-- Detecting standard protocols -->
    <xsl:template match="*[lower-case(@protocol) = ('file', 'ftp', 'http', 'https')]"
        mode="cpm.uri.isProtocol" as="xs:boolean">
        <xsl:value-of select="true()"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:uri.isProtocol" as="xs:boolean">
        <xsl:param name="strItem"/>
        <xsl:variable name="xmlData">
            <data protocol="{cpm:morestr.dockTail($strItem,':')}"/>
        </xsl:variable>
        <xsl:apply-templates select="$xmlData/data" mode="cpm.uri.isProtocol"/>
    </xsl:function>


    <!-- 
        Retrieving URI parts
    -->

    <xsl:function name="cpm:uri.protocol">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:value-of select="$xmlURI//protocol"/>
    </xsl:function>

    <xsl:function name="cpm:uri.host">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:value-of select="$xmlURI//host"/>
    </xsl:function>

    <xsl:function name="cpm:uri.port">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:value-of select="$xmlURI//port"/>
    </xsl:function>

    <xsl:function name="cpm:uri.hostPort">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:variable name="strHostPort">
            <xsl:value-of select="$xmlURI//host"/>
            <xsl:if test="$xmlURI//port">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="$xmlURI//port"/>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$strHostPort"/>
    </xsl:function>

    <xsl:function name="cpm:uri.drive">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:variable name="strDrive">
            <xsl:if test="$xmlURI//drive">
                <xsl:value-of select="$xmlURI//drive"/>
                <xsl:text>:</xsl:text>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$strDrive"/>
    </xsl:function>

    <xsl:function name="cpm:uri.localFile">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:variable name="strLocalFile">
            <xsl:for-each select="$xmlURI//folder">
                <xsl:value-of select="."/>
                <xsl:text>/</xsl:text>
            </xsl:for-each>
            <xsl:value-of select="$xmlURI//file"/>
        </xsl:variable>
        <xsl:value-of select="$strLocalFile"/>
    </xsl:function>

    <xsl:function name="cpm:uri.parentFolder">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:variable name="strParentFolder">
            <xsl:for-each select="$xmlURI//folder">
                <xsl:value-of select="."/>
                <xsl:if test="position() != last()">
                    <xsl:text>/</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$strParentFolder"/>
    </xsl:function>

    <xsl:function name="cpm:uri.fileName">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:variable name="strFileName">
            <xsl:value-of select="$xmlURI//file"/>
            <xsl:if test="$xmlURI//type">
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$xmlURI//type"/>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$strFileName"/>
    </xsl:function>

    <xsl:function name="cpm:uri.fileNameBase">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:value-of select="$xmlURI//base"/>
    </xsl:function>

    <xsl:function name="cpm:uri.fileNameType">
        <xsl:param name="strURI"/>
        <xsl:variable name="xmlURI" select="cpm:uri.parse($strURI)"/>
        <xsl:value-of select="$xmlURI//type"/>
    </xsl:function>


    <!-- 
        Validating URIs
    -->

    <xsl:function name="cpm:uri.isRelative" as="xs:boolean">
        <xsl:param name="strURI"/>
        <xsl:value-of select="matches($strURI, cpm:urisyn.path())"/>
    </xsl:function>

    <xsl:function name="cpm:uri.isLocal" as="xs:boolean">
        <xsl:param name="strURI"/>
        <xsl:value-of select="matches($strURI, cpm:urisyn.localURI())"/>
    </xsl:function>
    
    <xsl:function name="cpm:uri.isGlobal" as="xs:boolean">
        <xsl:param name="strURI"/>
        <xsl:value-of select="matches($strURI, cpm:urisyn.globalURI())"/>
    </xsl:function>
    
    <xsl:function name="cpm:uri.isURI" as="xs:boolean">
        <xsl:param name="strURI"/>
        <xsl:value-of select="cpm:uri.isLocal($strURI) or cpm:uri.isGlobal($strURI)"/>
    </xsl:function>
    
    <xsl:function name="cpm:uri.isValid" as="xs:boolean">
        <xsl:param name="strURI"/>
        <xsl:value-of select="cpm:uri.isRelative($strURI) or cpm:uri.isURI($strURI)"/>
    </xsl:function>

</xsl:stylesheet>
