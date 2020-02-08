<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       CPMJob
    Module:     config.xsl    
    Usage:      Library
    Func:       Retrieving CPM configuration properties
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Paths, URIs -->
    <xsl:import href="../../utils/xsl-2.0/pathuri.xsl"/>


    <!-- 
        Loading configuration files
    -->

    <xsl:function name="cpm:cfg.CfgFolder">
        <xsl:variable name="strMyURI" select="cpm:uri.baseURI(document('config.xsl'))"/>
        <xsl:value-of select="cpm:uri.absolute(cpm:uri.parentFolder($strMyURI), '../../../cfg')"/>
    </xsl:function>

    <!-- The main script configuration file -->
    <xsl:function name="cpm:cfg.CfgScriptURI">
        <xsl:value-of select="cpm:uri.absolute(cpm:cfg.CfgFolder(), 'script.xml')"/>
    </xsl:function>

    <!-- General script configuration -->
    <xsl:variable name="GLOBAL_CfgScript">
        <xsl:copy-of select="document(cpm:cfg.CfgScriptURI())"/>
    </xsl:variable>

    <!-- A list of the available readers -->
    <xsl:variable name="GLOBAL_CfgReaders">        
        <xsl:variable name="strReadersHref"
            select="$GLOBAL_CfgScript//import[cpm:polystr.equal(@as, 'readers', 'case')]/@file"/>
        <xsl:copy-of select="document(cpm:uri.absolute(cpm:cfg.CfgFolder(), $strReadersHref))"/>        
    </xsl:variable>


    <!--
        Accessing property values
    -->

    <!-- Simple properties -->
    <xsl:template match="property" mode="cpm.cfg.value">
        <xsl:value-of select="."/>
    </xsl:template>

    <!-- Properties having a @value -->
    <xsl:template match="property[@value]">
        <xsl:value-of select="@value"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:cfg.property">
        <xsl:param name="strPropName"/>
        <xsl:apply-templates select="$GLOBAL_CfgScript//property[@name = $strPropName]"
            mode="cpm.cfg.value"/>
    </xsl:function>


    <xsl:function name="cpm:config.cpmFolder"> </xsl:function>

    <xsl:function name="cpm:cfg.saxon.jarClasspath">
        <xsl:value-of select="cpm:cfg.property('saxon.jarClasspath')"/>
    </xsl:function>

    <xsl:function name="cpm:cfg.saxon.transformerFactory">
        <xsl:value-of select="cpm:cfg.property('saxon.transformerFactory')"/>
    </xsl:function>

</xsl:stylesheet>
