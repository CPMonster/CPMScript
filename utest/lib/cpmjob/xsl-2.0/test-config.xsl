<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" 
    version="2.0">
    
    <xsl:import href="../../../../cpm/lib/cpmjob/xsl-2.0/config.xsl"/>
    
    <xsl:template match="/">
        
        <xsl:value-of select="cpm:cfg.CfgScriptURI()"/>
        
        <xsl:copy-of select="$GLOBAL_CfgReaders"/>                
        
    </xsl:template>
    
    
</xsl:stylesheet>