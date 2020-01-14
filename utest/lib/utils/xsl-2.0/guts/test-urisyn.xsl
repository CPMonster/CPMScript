<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="../../../../../cpm/lib/utils/xsl-2.0/guts/urisyn.xsl"/>

    <xsl:output method="text" indent="yes"/>

    <xsl:template match="/">
        
        <xsl:text>Protocol: </xsl:text>
        <xsl:value-of select="cpm:urisyn.protocol()"/>
        <xsl:text>&#10;</xsl:text>
        
        <xsl:text>Credentials: </xsl:text>
        <xsl:value-of select="cpm:urisyn.credentials()"/>
        <xsl:text>&#10;</xsl:text>
        
        <xsl:text>Host: </xsl:text>
        <xsl:value-of select="cpm:urisyn.host()"/>
        <xsl:text>&#10;</xsl:text>
        
        <xsl:text>Full host: </xsl:text>
        <xsl:value-of select="cpm:urisyn.fullHost()"/>
        <xsl:text>&#10;</xsl:text>
        
        <xsl:text>Any URI: </xsl:text>
        <xsl:value-of select="cpm:urisyn.URI()"/>
        <xsl:text>&#10;</xsl:text>
        
        <xsl:text>Global URI: </xsl:text>
        <xsl:value-of select="cpm:urisyn.globalURI()"/>
        <xsl:text>&#10;</xsl:text>

    </xsl:template>


</xsl:stylesheet>
