<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="../../../cpm/lib/props/xsl-2.0/props.xsl"/>

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">

        <xsl:variable name="strProps">
            <xsl:text># Sample&#10;</xsl:text>
            <xsl:text>! Sample&#10;</xsl:text>
            <xsl:text>build.compiler=jikes&#10;</xsl:text>
            <xsl:text>deploy.server=lucky&#10;</xsl:text>
            <xsl:text>&#10;</xsl:text>
            <xsl:text>deploy.port=8443&#10;</xsl:text>
            <xsl:text>deploy.url=https://${deploy.server}:${deploy.port}/&#10;</xsl:text>
        </xsl:variable>


        <xsl:copy-of select="cpm:props.parse($strProps)"/> 

        <xsl:variable name="strPropsFile" select="unparsed-text('data/sample.properties')"/>        

        <file>
            <xsl:value-of select="$strPropsFile"/>
        </file>

        <xsl:copy-of select="cpm:props.parse($strPropsFile)"/>


    </xsl:template>

</xsl:stylesheet>
