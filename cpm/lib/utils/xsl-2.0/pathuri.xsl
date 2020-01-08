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
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:java-urldecode="java:java.net.URLDecoder" exclude-result-prefixes="cpm java-urldecode xs"
    version="2.0">

    <!-- 
        If you have gon an URI:
        * Just do that what you need to do
        
        If you have got a path:
        1. Convert a path to an URI
        2. Do that what you need to do with the URI
        3. Convert the URI back to a path
    -->


    <xsl:template name="cpm.pathuri.decodeURI">
        <xsl:param name="strItem"/>
        <xsl:value-of select="java-urldecode:decode($strItem, 'UTF-8')"/>
    </xsl:template>


    <xsl:function name="cpm:pathuri.parseURI">

        <xsl:param name="strURI"/>


    </xsl:function>

    <xsl:function name="cpm:pathuri.isPath" as="xs:boolean"> </xsl:function>

    <xsl:function name="cpm:pathuri.isURI" as="xs:boolean"> </xsl:function>

    <xsl:template name="cpm:pathuri.normalize"> </xsl:template>


    <xsl:function name="cpm:pathuri.isAbsolute" as="xs:boolean"> </xsl:function>

    <xsl:function name="cpm:pathuri.protocol"> </xsl:function>

    <xsl:function name="cpm:pathuri.host"> </xsl:function>

    <xsl:function name="cpm:pathuri.drive"> </xsl:function>

    <xsl:function name="cpm:pathuri.parentFolder"> </xsl:function>

    <xsl:function name="cpm:pathuri.file"> </xsl:function>

    <xsl:function name="cpm:pathuri.fileName"> </xsl:function>

    <xsl:function name="cpm:pathuri.fileNameType"> </xsl:function>

    <xsl:function name="cpm:pathuri.fileNameBase"> </xsl:function>

    <xsl:function name="cpm:pathuri.path">

        <xsl:param name="strItem"/>

        <xsl:param name="strOSType"/>

    </xsl:function>

    <xsl:function name="cpm:pathuri.fileURI">

        <xsl:param name="strItem"/>

        <xsl:choose>
            <xsl:when test="cpm:pathuri.isURI()">
                <xsl:value-of select="$strItem"/>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

    <xsl:function name="cpm:pathuri.inetURI">

        <xsl:param name="strItem"/>

        <xsl:param name="strProtocol"/>

        <xsl:param name="strHost"/>



    </xsl:function>

    <xsl:function name="cpm:pathuri.relativeURI">

        <xsl:param name="strBaseURI"/>

        <xsl:param name="strTargetURI"/>

    </xsl:function>

    <!-- Appending a relative URI to a base URI -->
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

</xsl:stylesheet>
