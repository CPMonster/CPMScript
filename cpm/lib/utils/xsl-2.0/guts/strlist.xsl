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


    <!-- 
        Unpacking a string to a sequence of string items    
    -->

    <!-- 
        Both item and separator patterns:         '[A-Za-z]+ \s*(,|;)\s*'
        An item pattern; separators don't matter: '[A-Za-z]+ .+'
        A separator pattern; item don't matter:   '\s*(,|;)\s*'
    -->

    <!-- Extracting an item pattern, e.g. cpmitem: [A-Za-z][A-Za-z\d]* -->
    <xsl:function name="cpm:strlist.listItmPattern">
        <xsl:param name="strPatterns"/>
        <xsl:if test="contains($strPatterns, ' ')">
            <xsl:value-of select="normalize-space(substring-before($strPatterns, ' '))"/>
        </xsl:if>
    </xsl:function>

    <!-- Extracting a separator pattern, e.g. cpmsep: \s*,\s* -->
    <xsl:function name="cpm:strlist.listSepPattern">
        <xsl:param name="strPatterns"/>

        <xsl:choose>

            <xsl:when test="contains($strPatterns, ' ')">
                <xsl:variable name="strRawSepPattern">
                    <xsl:value-of select="normalize-space(substring-after($strPatterns, ' '))"/>
                </xsl:variable>
                <xsl:if test="not($strRawSepPattern = '.+')">
                    <xsl:value-of select="$strRawSepPattern"/>
                </xsl:if>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$strPatterns"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>

    <!-- Splitting a list using patterns like -->
    <xsl:function name="cpm:strlist.sequence" as="xs:string*">
        <xsl:param name="strList"/>
        <xsl:param name="strPatterns"/>

        <xsl:variable name="strListItmPattern" select="cpm:strlist.listItmPattern($strPatterns)"/>
        <xsl:variable name="strListSepPattern" select="cpm:strlist.listSepPattern($strPatterns)"/>

        <xsl:choose>

            <xsl:when test="$strListItmPattern != ''">
                <xsl:analyze-string select="$strList" regex="{$strListItmPattern}">
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
    
    <!-- What do we do if we failed to detect a separator? -->
    <xsl:function name="cpm:strlist.patterns2separ">
        <xsl:param name="strPatterns"/>
        
        <!-- This way so far -->
        <xsl:text>,</xsl:text>
        
    </xsl:function>

    <!-- Detecting an actual separator -->
    <xsl:function name="cpm:strlist.separ">
        <xsl:param name="strList"/>
        <xsl:param name="strPatterns"/>

        <xsl:variable name="strListItmPattern" select="cpm:strlist.listItmPattern($strPatterns)"/>
        <xsl:variable name="strListSepPattern" select="cpm:strlist.listSepPattern($strPatterns)"/>

        <xsl:variable name="seqSeps" as="xs:string*">
            <xsl:choose>

                <xsl:when test="$strListSepPattern != ''">
                    <xsl:analyze-string select="$strList" regex="{$strListSepPattern}">
                        <xsl:matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:analyze-string select="$strList" regex="{$strListItmPattern}">
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:otherwise>

            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$seqSeps[1] != '' ">
                <xsl:value-of select="$seqSeps[1]"/>        
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="cpm:strlist.patterns2separ($strPatterns)"/>
            </xsl:otherwise>
        </xsl:choose>
               
    </xsl:function>


    <!-- 
        Serializing a sequence to a list
    -->

    <xsl:function name="cpm:strlist.string">
        <xsl:param name="strList" as="xs:string*"/>
        <xsl:param name="strSep"/>
        <xsl:value-of select="string-join($strList, $strSep)"/>
    </xsl:function>


    <!-- 
        Assembling lists
    -->

    <!-- 'cow, horse' and 'cat, dog' give 'cow, horse, cat, dog' -->
    <xsl:function name="cpm:strlist.append">
        <xsl:param name="strList1"/>
        <xsl:param name="strList2"/>
        <xsl:param name="strPatterns"/>
        <xsl:variable name="strSep" select="cpm:strlist.separ($strList1, $strPatterns)"/>
        <xsl:value-of select="concat($strList1, $strSep, $strList2)"/>
    </xsl:function>


    <!-- 
        Processing a list
    -->

    <!-- 'cow, horse, rabbit' gives 'cow' -->
    <xsl:function name="cpm:strlist.head">
        <xsl:param name="strList"/>
        <xsl:param name="strPatterns"/>
        <xsl:value-of select="cpm:strlist.sequence($strList, $strPatterns)[1]"/>
    </xsl:function>

    <!-- 'cow, horse, rabbit' gives 'horse, rabbit' -->
    <xsl:function name="cpm:strlist.tail" as="xs:string">
        <xsl:param name="strList"/>
        <xsl:param name="strPatterns"/>
        <xsl:variable name="seqList" select="cpm:strlist.sequence($strList, $strPatterns)"/>
        <xsl:variable name="strSep" select="cpm:strlist.separ($strList, $strPatterns)"/>
        <xsl:value-of select="cpm:strlist.string($seqList[position() != 1], $strSep)"/>
    </xsl:function>

</xsl:stylesheet>
