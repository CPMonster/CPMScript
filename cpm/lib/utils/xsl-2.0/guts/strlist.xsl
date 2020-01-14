<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     strlists.xsl
    Usage:      Guts    
    Func:       Processing lists that are represented by strings
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Custom normalization for strings -->
    <xsl:import href="polystr.xsl"/>

    <!-- Extracting an item pattern, e.g. cpmitem: [A-Za-z][A-Za-z\d]* -->
    <xsl:function name="cpm:strlist.listItemPattern">
        <xsl:param name="strPatterns"/>
        <xsl:analyze-string select="$strPatterns" regex="cpmitem:(\s*)(^\s+)">
            <xsl:matching-substring>
                <xsl:value-of select="normalize-space(substring-after($strPatterns, 'cpmitem:'))"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:function>

    <!-- Extracting a separator pattern, e.g. cpmsep: \s*,\s* -->
    <xsl:function name="cpm:strlist.listSepPattern">
        <xsl:param name="strPatterns"/>
        <xsl:choose>
            <xsl:when test="contains($strPatterns, 'cpmsep:')">
                <xsl:analyze-string select="$strPatterns" regex="cpmsep:(\s*)([^\s]+)">
                    <xsl:matching-substring>
                        <xsl:value-of
                            select="normalize-space(substring-after($strPatterns, 'cpmsep:'))"/>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:when
                test="not(contains($strPatterns, 'cpmitem:') or contains($strPatterns, 'cpmsep:'))">
                <xsl:value-of select="$strPatterns"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>

    <!-- Splitting a list using patterns like -->
    <xsl:function name="cpm:strlist.sequence" as="xs:string*">
        <xsl:param name="strList"/>
        <xsl:param name="strPatterns"/>

        <xsl:variable name="strListItemPattern" select="cpm:strlist.listItemPattern($strPatterns)"/>
        <xsl:variable name="strListSepPattern" select="cpm:strlist.listSepPattern($strPatterns)"/>

        <xsl:message>
            <xsl:value-of select="$strListSepPattern"/>
        </xsl:message>

        <xsl:choose>

            <xsl:when test="$strListItemPattern != ''">
                <xsl:analyze-string select="$strList" regex="$strListItemPattern">
                    <xsl:matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:when>

            <xsl:when test="$strListSepPattern != ''">
                <xsl:copy-of select="tokenize($strList, $strListSepPattern)"/>
            </xsl:when>

        </xsl:choose>

    </xsl:function>

    <xsl:function name="cpm:strlist.string">
        <xsl:param name="strList" as="xs:string*"/>
        <xsl:param name="strSep"/>
        <xsl:value-of select="string-join($strList, $strSep)"/>
    </xsl:function>

    <xsl:function name="cpm:strlist.head">
        <xsl:param name="strList"/>
        <xsl:param name="strSep"/>
        <xsl:value-of select="cpm:strlist.sequence($strList, $strSep)[1]"/>
    </xsl:function>

    <xsl:function name="cpm:strlist.tail" as="xs:string">
        <xsl:param name="strList" as="xs:string*"/>
        <xsl:param name="strSep"/>
        <xsl:variable name="seqList" select="cpm:strlist.sequence($strList, $strSep)"/>
        <xsl:value-of select="cpm:strlist.string($seqList[position() != 1], $strSep)"/>
    </xsl:function>

</xsl:stylesheet>
