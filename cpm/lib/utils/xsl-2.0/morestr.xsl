<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     morestr.xsl    
    Usage:      Library
    Func:       Parsing and reassembling strings
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Extracting strings out of separators 
    -->

    <!-- Left optional separator -->
    <xsl:function name="cpm:morestr.dockHead">
        <xsl:param name="strItem"/>
        <xsl:param name="strHead"/>
        <xsl:choose>
            <xsl:when test="starts-with($strItem, $strHead) and $strHead != ''">
                <xsl:value-of select="substring($strItem, string-length($strHead) + 1)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$strItem"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!-- Right optional separator -->
    <xsl:function name="cpm:morestr.dockTail">
        <xsl:param name="strItem"/>
        <xsl:param name="strTail"/>
        <xsl:choose>
            <xsl:when test="ends-with($strItem, $strTail) and $strTail != ''">
                <xsl:variable name="numLength">
                    <xsl:value-of select="string-length($strItem) - string-length($strTail)"/>
                </xsl:variable>
                <xsl:value-of select="substring($strItem, 1, $numLength)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$strItem"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <!-- Two optional separators -->
    <xsl:function name="cpm:morestr.extract">
        <xsl:param name="strItem"/>
        <xsl:param name="strLSep"/>
        <xsl:param name="strRSep"/>
        <xsl:variable name="strRemain" select="cpm:morestr.dockHead($strItem, $strLSep)"/>
        <xsl:value-of select="cpm:morestr.dockTail($strRemain, $strRSep)"/>
    </xsl:function>


    <!-- 
        Combining sunstring-after with substring-before 
    -->
    
    <!-- Left and right delimiters are both mandatory -->
    <xsl:function name="cpm:morestr.afterBefore">
        <xsl:param name="strItem"/>
        <xsl:param name="strAfter"/>
        <xsl:param name="strBefore"/>
        <xsl:variable name="strTmpAfter" select="substring-after($strItem, $strAfter)"/>
        <xsl:value-of select="substring-before($strTmpAfter, $strBefore)"/>
    </xsl:function>

    <!-- A left delimiter is mandatory; a right delimiter is optional -->
    <xsl:function name="cpm:morestr.leftAfterBefore">
        <xsl:param name="strItem"/>
        <xsl:param name="strAfter"/>
        <xsl:param name="strBefore"/>
        <xsl:variable name="strTmpAfter" select="substring-after($strItem, $strAfter)"/>
        <xsl:choose>
            <xsl:when test="contains($strTmpAfter, $strBefore)">
                <xsl:value-of select="substring-before($strTmpAfter, $strBefore)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$strTmpAfter"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


</xsl:stylesheet>
