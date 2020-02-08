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

    <xsl:import href="../../utils/xsl-2.0/morestr.xsl"/>

    <xsl:output method="xml" indent="yes"/>


    <xsl:output method="xml" indent="yes"/>
    
    <xsl:function name="cpm:job.inTargetName">        
        <xsl:param name="strCpmTargetName"/>
        <xsl:value-of select="concat($strCpmTargetName,'.in')"/>
    </xsl:function>
    
    <xsl:function name="cpm:job.styleTargetName">        
        <xsl:param name="strCpmTargetName"/>
        <xsl:value-of select="concat($strCpmTargetName,'.task')"/>
    </xsl:function>    
    
    <xsl:function name="cpm:job.outTargetName">        
        <xsl:param name="strCpmTargetName"/>
        <xsl:value-of select="concat($strCpmTargetName,'.out')"/>
    </xsl:function>

    <xsl:template match="target" mode="cpm.job.inTarget">
        
        <target name="{cpm:job.inTargetName(@name)}">
            <xslt>                
                <xsl:attribute name="in" select="cpm:job.srcTreePath(.)"/>
                <xsl:attribute name="out" select="cpm:job.outTreePath(.)"/>
                <xsl:attribute name="style" select="cpm:job.stylePath(.)"/>                
                <classpath path="{cpm:cfg.saxon.jarClasspath()}"/>
                <factory name="{cpm:cfg.saxon.transformerFactory()}"/>               
            </xslt>
        </target>
        
    </xsl:template>

    <xsl:template match="target" mode="cpm.job.styleTarget">
        <target name="{cpm:job.styleTargetName(@name)}">
            
        </target>
    </xsl:template>

    <xsl:template match="target" mode="cpm.job.outTarget"> </xsl:template>

    <xsl:template match="target" mode="cpm.job.ant">
        <xsl:apply-templates select="." mode="cpm.job.inTarget"/>
        <xsl:apply-templates select="." mode="cpm.job.styleTarget"/>
        <xsl:apply-templates select="." mode="cpm.job.outTarget"/>
    </xsl:template>

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


    <xsl:template match="project" mode="cpm.job.ant">
        <copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="*" mode="#current"/>
        </copy>
    </xsl:template>


    <xsl:template match="/">
        <xsl:apply-templates select="project" mode="cpm.job.ant"/>
    </xsl:template>

</xsl:stylesheet>
