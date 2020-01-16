<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     translit.xsl    
    Usage:      Guts
    Func:       Transliterating strings
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->
    
    <!-- Working with symbol encoding -->
    <xsl:import href="encoding.xsl"/>


    <!-- 
        Loading transliteration tables
    -->
    
    <!-- No transliteration table is provided by default -->
    <xsl:template match="*" mode="cpm.translit.load"/>

    <!-- Cyrillic to ASCII -->
    <xsl:template match="*[@source = 'Cyrillic' and @target = 'ASCII']" mode="cpm.translit.load">
        <xsl:copy-of select="document('../data/translit/Cyrillic.xml')"/>
    </xsl:template>

    <!-- Wrapper function -->
    <xsl:function name="cpm:translit.load">
        <xsl:param name="strSource"/>
        <xsl:param name="strTarget"/>
        <xsl:variable name="xmlData">
            <alphabet source="{$strSource}" target="{$strTarget}"/>
        </xsl:variable>
        <xsl:variable name="xmlTrans">
            <xsl:apply-templates select="$xmlData" mode="cpm.translit.load"/>
        </xsl:variable>
        <xsl:copy-of select="$xmlTrans//alphabet[@source = $strSource and @target = $strTarget]"/>
    </xsl:function>


    <!-- 
        Transliterating strings
    -->
    
    <xsl:function name="cpm:translit.">
        <xsl:param name="strItem"/>
        <xsl:param name="strSource"/>
        <xsl:param name="strTarget"/>

        <xsl:variable name="xmlAlphabet" select="cpm:translit.load($strSource, $strTarget)"/>

        <xsl:variable name="strTrSource" select="$xmlAlphabet//translate/@source"/>
        <xsl:variable name="strTrTarget" select="$xmlAlphabet//translate/@target"/>
        <xsl:variable name="strStage1" select="translate($strItem, $strSource, $strTarget)"/>
        
        <xsl:variable name="strStage2">
            <xsl:for-each select=""></xsl:for-each>
        </xsl:variable>

    </xsl:function>

</xsl:stylesheet>
