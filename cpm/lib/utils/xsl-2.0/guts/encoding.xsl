<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     encoding.xsl    
    Usage:      Guts
    Func:       Working with symbol encoding
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:java-urldecode="java:java.net.URLDecoder" exclude-result-prefixes="cpm java-urldecode xs"
    version="2.0">

    <!-- 
        Replacing codes like %20 with corresponding Unicode characters 
    -->
    <xsl:function name="cpm:pathuri.decodeURI">
        <xsl:param name="strItem"/>
        <xsl:value-of select="java-urldecode:decode($strItem, 'UTF-8')"/>
    </xsl:function>


    <!-- 
        ASCII
    -->

    <!-- Listing ASCII characters -->
    <xsl:function name="cpm:encoding.strASCII">
        <xsl:variable name="strASCII">
            <xsl:text><![CDATA[&#00;&#01;&#02;&#03;&#04;&#05;&#06;&#07;&#08;&#09;]]></xsl:text>
            <xsl:text><![CDATA[&#10;&#11;&#12;&#13;&#14;&#15;&#16;&#17;&#18;&#19;]]></xsl:text>
            <xsl:text><![CDATA[&#20;&#21;&#22;&#23;&#24;&#25;&#26;&#27;&#29;&#29;]]></xsl:text>
            <xsl:text><![CDATA[&#30;&#21;]]></xsl:text>
            <xsl:text><![CDATA[ !"#$%&'()*+,-./0123456789:;<=>?@]]></xsl:text>
            <xsl:text><![CDATA[ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`]]></xsl:text>
            <xsl:text><![CDATA[abcdefghijklmnopqrstuvwxyz{|}~]]></xsl:text>
        </xsl:variable>
        <xsl:value-of select="$strASCII"/>
    </xsl:function>

    <!-- Removing ASCII characters out of a string -->
    <xsl:function name="cpm:encoding.nonASKII">
        <xsl:param name="strItem"/>
        <xsl:value-of select="translate($strItem, cpm:encoding.strASCII(), '')"/>
    </xsl:function>


    <!-- 
        Detecting Unicode ranges
    -->

    <!-- Does a character matches a range? -->
    <xsl:function name="cpm:encoding.match" as="xs:boolean">
        <xsl:param name="chrA"/>
        <xsl:param name="chrX"/>
        <xsl:param name="chrZ"/>
        <xsl:value-of select="compare($chrA, $chrX) != 1 and compare($chrX, $chrZ) != 1"/>
    </xsl:function>

    <!-- A Unicode range is unrecognized by default -->
    <xsl:template match="*" mode="cpm.encoding.range">
        <xsl:text>Unknown</xsl:text>
    </xsl:template>

    <!-- Detecting Cyrillic characters -->
    <xsl:template match="*[cpm:encoding.match('&#1024;', ., '&#1279;')]" mode="cpm.encoding.range">
        <xsl:text>Cyrillic</xsl:text>
    </xsl:template>

    <!-- Detecting Greek characters -->
    <xsl:template match="*[cpm:encoding.match('&#880;', ., '&#1023;')]" mode="cpm.encoding.range">
        <xsl:text>Greek</xsl:text>
    </xsl:template>

    <!-- Detecting Hebrew characters -->
    <xsl:template match="*[cpm:encoding.match('&#1424;', ., '&#1535;')]" mode="cpm.encoding.range">
        <xsl:text>Hebrew</xsl:text>
    </xsl:template>

    <!-- Detecting a unicode range for a string -->
    <xsl:function name="cpm:encoding.range">
        <xsl:param name="strItem"/>
        <xsl:variable name="strNonASCII" select="cpm:encoding.nonASKII($strItem)"/>
        <xsl:choose>
            <xsl:when test="$strNonASCII = ''">
                <xsl:text>ASCII</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="xmlChar">
                    <char>
                        <xsl:value-of select="substring($strNonASCII, 1, 1)"/>
                    </char>
                </xsl:variable>
                <xsl:apply-templates select="$xmlChar/char" mode="cpm.encoding.range"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>
