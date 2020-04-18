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
        Retrieving a temporary configuration file
    -->

    <!-- Temporary configuration file path -->
    <xsl:param name="cpm.cfg.tmpCfgPath"/>

    <!-- Temporary configuration file -->
    <xsl:variable name="cpm.cfg.tmpCfg" select="document($cpm.cfg.tmpCfgPath)"/>


    <!--
        Accessing property values
    -->

    <!-- Retrieving a configuration property value by the name -->
    <xsl:function name="cpm:cfg.value">
        <xsl:param name="strPropName"/>
        <xsl:variable name="strPropTag" select="concat($strPropName, '=')"/>
        <xsl:variable name="strProp" select="$cpm.cfg.tmpCfg//prop[starts-with(., $strPropTag)]"/>
        <xsl:value-of select="substring-after($strProp, '=')"/>
    </xsl:function>

    <!-- Retrieving an URI by the property name -->
    <xsl:function name="cpm:cfg.uri">
        <xsl:param name="strPropName"/>
        <xsl:value-of select="cpm:path.2uri(cpm:cfg.value($strPropName), cpm:cfg.osType())"/>
    </xsl:function>


    <!-- 
        Detecting environment parameter values
    -->

    <!-- Detecting the OS type -->
    <xsl:function name="cpm:cfg.osType">
        <xsl:variable name="strOsType" select="lower-case(cpm:cfg.value('cpm.sys.osType'))"/>
        <xsl:choose>
            <xsl:when test="contains($strOsType, 'linux')">
                <xsl:text>linux</xsl:text>
            </xsl:when>
            <xsl:when test="contains($strOsType, 'mac')">
                <xsl:text>macos</xsl:text>
            </xsl:when>
            <xsl:when test="contains($strOsType, 'windows')">
                <xsl:text>windows</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:function>


    <!-- 
        Assembling URIs for the essential folders
    -->

    <xsl:function name="cpm:cfg.cpmFolder">
        <xsl:value-of select="cpm:cfg.uri('cpm.cfg.cpmFolder')"/>
    </xsl:function>

    <xsl:function name="cpm:cfg.userpref.tmpFolder">
        <xsl:value-of select="cpm:cfg.uri('cpm:cfg.userpref.tmpFolder')"/>
    </xsl:function>


    <!-- 
        Assembling URIs, paths, and values for essential components
    -->

    <!-- Java -->

    <xsl:function name="cpm:cfg.java.executable">
        <xsl:value-of select="cpm:cfg.value('cpm.cfg.java.executable')"/>
    </xsl:function>

    <xsl:function name="cpm:cfg.java.minMemory">
        <xsl:value-of select="cpm:cfg.value('cpm.cfg.java.minMemory')"/>
    </xsl:function>

    <xsl:function name="cpm:cfg.java.maxMemory">
        <xsl:value-of select="cpm:cfg.value('cpm.cfg.java.maxMemory')"/>
    </xsl:function>


    <!-- Saxon -->

    <xsl:function name="cpm:cfg.saxon.jarClasspath">
        <xsl:value-of select="cpm:cfg.uri('cpm.cfg.saxon.jarClasspath')"/>
    </xsl:function>

    <xsl:function name="cpm:cfg.saxon.transformerFactory">
        <xsl:value-of select="cpm:cfg.value('cpm.cfg.saxon.transformerFactory')"/>
    </xsl:function>

    <xsl:function name="cpm:cfg.resolver.jarClasspath">
        <xsl:value-of select="cpm:cfg.uri('cpm.cfg.resolver.jarClasspath')"/>
    </xsl:function>


    <!-- 
        Accessing library or application configuration properties
    -->

    <xsl:function name="cpm:cfg.componentPropValue">
        <xsl:param name="strComponentName"/>
        <xsl:param name="strPropName"/>

        <xsl:variable name="strGfgPropFileURI"
            select="cpm:cfg.componentPropFileURI($strComponentName)"/>


        <xsl:if test="unparsed-text-available($strGfgPropFileURI)">
            <xsl:variable name="txtCfgProps" select="unparsed-text($strGfgPropFileURI)"/>
            <xsl:value-of select="cpm:cfg.propValue($txtCfgProps, $strPropName)"/>
        </xsl:if>

    </xsl:function>

</xsl:stylesheet>
