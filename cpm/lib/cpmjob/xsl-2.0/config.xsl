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
        <xsl:apply-templates select="$GLOBAL.cfgScript//property[@name = $strPropName]"
            mode="cpm.cfg.value"/>
    </xsl:function>


    <!-- 
        The configuration parameters
    -->
    
    <!-- The OS name -->
    <xsl:param name="GLOBAL.os.name"/>
    
    <!-- System temporary folder -->
    <xsl:param name="GLOBAL.default.tmpFolder"/>
    
    
    <!-- 
        Detecting the environment parameters
    -->
    
    <!-- Detecting the OS type -->
    <xsl:function name="cpm:cfg.osType">
        <xsl:choose>
            <xsl:when test="contains(lower-case($GLOBAL.os.name),'linux')">
                <xsl:text>linux</xsl:text>
            </xsl:when>
            <xsl:when test="contains(lower-case($GLOBAL.os.name),'mac')">
                <xsl:text>macos</xsl:text>
            </xsl:when>
            <xsl:when test="contains(lower-case($GLOBAL.os.name),'windows')">
                <xsl:text>windows</xsl:text>
            </xsl:when>            
        </xsl:choose>
    </xsl:function>
    
    
    <!-- 
        Loading configuration files
    -->
    
    <xsl:function name="cpm:cfg.cfgFolder">
        <xsl:variable name="strMyURI" select="cpm:uri.baseURI(document('config.xsl'))"/>
        <xsl:value-of select="cpm:uri.absolute(cpm:uri.parentFolder($strMyURI), '../../../cfg')"/>
    </xsl:function>
    
    <!-- The main script configuration file -->
    <xsl:function name="cpm:cfg.cfgScriptURI">
        <xsl:value-of select="cpm:uri.absolute(cpm:cfg.cfgFolder(), 'script.xml')"/>
    </xsl:function>
    
    <!-- General script configuration -->
    <xsl:variable name="GLOBAL.cfgScript">
        <xsl:copy-of select="document(cpm:cfg.cfgScriptURI())"/>
    </xsl:variable>
    
    <!-- A list of the available readers -->
    <xsl:variable name="GLOBAL.cfgReaders">
        <xsl:variable name="strReadersHref"
            select="$GLOBAL.cfgScript//import[cpm:polystr.equal(@as, 'readers', 'case')]/@file"/>
        <xsl:copy-of select="document(cpm:uri.absolute(cpm:cfg.cfgFolder(), $strReadersHref))"/>
    </xsl:variable>
    
    
    <!-- 
        Assembling URIs for the essential folders
    -->
    
    <xsl:function name="cpm:cfg.cpmFolder">
        <xsl:value-of select="cpm:uri.absolute(cpm:cfg.cfgFolder(), '..')"/>
    </xsl:function>
    
    <xsl:function name="cpm:cfg.defaultTmpFolder">
        <xsl:value-of select="cpm:path.2uri($GLOBAL.default.tmpFolder, cpm:cfg.osType())"/>
    </xsl:function>


    <!-- 
        Assembling URIs, paths, and values for essential components
    -->
    
    <!-- Saxon -->
        
    <xsl:function name="cpm:cfg.saxon.jarClasspath">
        <xsl:value-of select="cpm:cfg.property('saxon.jarClasspath')"/>
    </xsl:function>

    <xsl:function name="cpm:cfg.saxon.transformerFactory">
        <xsl:value-of select="cpm:cfg.property('saxon.transformerFactory')"/>
    </xsl:function>

</xsl:stylesheet>
