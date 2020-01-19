<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <xsl:import href="../../../../cpm/lib/utils/xsl-2.0/pathuri.xsl"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        
        <xsl:variable name="strAbsURI1">
            <xsl:text>http://www.philosoft.ru:80?page=1&amp;size=10#pivoraki</xsl:text>
        </xsl:variable>
        
        <!--
        <test uri="{$strAbsURI1}" valid="{cpm:uri.isAbsolute($strAbsURI1)}"/>
        -->
        
        <xsl:variable name="strRelURI1">
            <xsl:text>http://www.philosoft.ru:80?page=1&amp;size=10#pivoraki</xsl:text>
        </xsl:variable>
        
        <test uri="{$strRelURI1}" valid="{cpm:uri.isRelative($strRelURI1)}"/>
        
        <xsl:copy-of select="cpm:uriparse.uri('http://www.philosoft.ru:80?page=1&amp;size=10#pivoraki')"/>
        <xsl:copy-of select="cpm:uriparse.uri('http://www.philosoft.ru:80#pivoraki')"/>
        <xsl:copy-of select="cpm:uriparse.uri('http://www.philosoft.ru:80/services/docs.html#pivoraki')"/>
        <xsl:copy-of select="cpm:uriparse.uri('http://www.philosoft.ru:80/services/docs.html')"/>
        <xsl:copy-of select="cpm:uriparse.uri('file:///c:/foo/bar/figar.new.last.txt')"/>
        <xsl:copy-of select="cpm:uriparse.uri('file:/c:/foo/bar/figar.txt')"/>
        <xsl:copy-of select="cpm:uriparse.uri('file:/c:/figar.txt')"/>
        
        
        
    </xsl:template>
    
    
</xsl:stylesheet>