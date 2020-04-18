<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       CPMJob
    Module:     job2ant.xsl    
    Usage:      Library
    Func:       Tranforming a CPM job file to an Ant script
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- URIs and paths -->
    <xsl:import href="../../utils/xsl-2.0/pathuri.xsl"/>

    <!-- Retrieving the configuration properties -->
    <xsl:import href="config.xsl"/>
    
    <!-- Assembling Ant tasks -->
    <xsl:import href="antscript.xsl"/>


    <!-- 
        Output properties
    -->

    <xsl:output method="xml" indent="yes"/>


    <!-- 
        Assembling target names    
    -->

    <!-- A target assembling a source XML tree -->
    <xsl:function name="cpm:job.inTargetName">
        <xsl:param name="strCpmTargetName"/>
        <xsl:value-of select="concat($strCpmTargetName, '.in')"/>
    </xsl:function>

    <!-- A target assembling an output XML tree -->
    <xsl:function name="cpm:job.styleTargetName">
        <xsl:param name="strCpmTargetName"/>
        <xsl:value-of select="concat($strCpmTargetName, '.task')"/>
    </xsl:function>

    <!-- A target assembling an output Ant script -->
    <xsl:function name="cpm:job.outTargetName">
        <xsl:param name="strCpmTargetName"/>
        <xsl:value-of select="concat($strCpmTargetName, '.out')"/>
    </xsl:function>


    <!-- 
        Assembling paths
    -->
    
    <xsl:function name="cpm:job.inputTreePath">
        <xsl:param name="elmTarget"/>
        <xsl:text>imputTree.xml</xsl:text>
    </xsl:function>
    
    <xsl:function name="cpm:job.outputTreePath">
        <xsl:param name="elmTarget"/>
        <xsl:text>outputTree.xml</xsl:text>
    </xsl:function>
    
    <xsl:function name="cpm:job.taskStylePath">
        <xsl:param name="elmTarget"/>
        <xsl:text>taskStyle.xsl</xsl:text>
    </xsl:function>
    

    <!-- 
        Assembling targets
    -->

    <!-- A target assembling a source XML tree -->
    <xsl:template match="target" mode="cpm.job.inTarget">
        <target>
            <xsl:attribute name="name" select="cpm:job.inTargetName(@name)"/>
        </target>
    </xsl:template>

    <!-- A target assembling an output XML tree -->
    <xsl:template match="target" mode="cpm.job.styleTarget">
        <target>
            <xsl:attribute name="name" select="cpm:job.styleTargetName(@name)"/>
            <xsl:attribute name="depends" select="cpm:job.inTargetName(@name)"/>
            
            <xsl:call-template name="cpm.ant.saxon">
                <xsl:with-param name="strIn" select="cpm:job.inputTreePath(.)"/>
                <xsl:with-param name="strOut" select="cpm:job.outputTreePath(.)"/>
                <xsl:with-param name="strStyle" select="cpm:job.taskStylePath(.)"/>
            </xsl:call-template>
            
        </target>
    </xsl:template>

    <!-- A target assembling an output Ant script -->
    <xsl:template match="target" mode="cpm.job.outTarget">
        <target>
            <xsl:attribute name="bame" select="cpm:job.outTargetName(@name)"/>
            <xsl:attribute name="depends" select="cpm:job.styleTargetName(@name)"/>
        </target>
    </xsl:template>

    <!-- Transforming a CPM target to an Ant target -->
    <xsl:template match="target" mode="cpm.job.ant">
        <xsl:apply-templates select="." mode="cpm.job.inTarget"/>
        <xsl:apply-templates select="." mode="cpm.job.styleTarget"/>
        <xsl:apply-templates select="." mode="cpm.job.outTarget"/>
    </xsl:template>

    <!-- Assembling a default target -->
    <xsl:template match="target[@name = 'main']" mode="cpm.job.ant">

        <xsl:variable name="seqCpmTargets" select="tokenize(@depends, '\s*,\s*')" as="xs:string*"/>

        <xsl:variable name="seqAntTargets" as="xs:string*">
            <xsl:for-each select="$seqCpmTargets">
                <xsl:value-of select="cpm:job.outTargetName(.)"/>
            </xsl:for-each>
        </xsl:variable>

        <xsl:copy>
            <xsl:copy-of select="@name"/>
            <xsl:attribute name="depends" select="string-join($seqAntTargets, ',')"/>
        </xsl:copy>

    </xsl:template>


    <!-- 
        Providing generic processing for Ant tasks
    -->

    <xsl:template match="description" mode="cpm.job.ant"/>

    <xsl:template match="node() | @*" mode="cpm.job.ant">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>


    <!-- 
        Transforming a CPM job to an Ant project
    -->

    <xsl:template match="project" mode="cpm.job.ant">
        
        <xsl:copy>
        
            <xsl:copy-of select="@*"/>
            
            <xsl:copy-of select="description"/>
            
            <xsl:variable name="strDefaultTmpFolder"
                select="cpm:uri.2path(cpm:cfg.defaultTmpFolder(), cpm:cfg.osType())"/>
            <xsl:copy-of select="cpm:ant.property('default.tmpFolder', $strDefaultTmpFolder)"/>
            
            <xsl:apply-templates select="*" mode="#current"/>
        
        </xsl:copy>
        
    </xsl:template>


    <!-- 
        Main
    -->

    <xsl:template match="/">
        <xsl:apply-templates select="project" mode="cpm.job.ant"/>
    </xsl:template>

</xsl:stylesheet>
