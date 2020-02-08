<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

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

        <xsl:copy-of
            select="cpm:uriparse.uri('http://www.philosoft.ru:80?page=1&amp;size=10#pivoraki')"/>
        <xsl:copy-of select="cpm:uriparse.uri('http://www.philosoft.ru:80#pivoraki')"/>
        <xsl:copy-of
            select="cpm:uriparse.uri('http://www.philosoft.ru:80/services/docs.html#pivoraki')"/>
        <xsl:copy-of select="cpm:uriparse.uri('http://www.philosoft.ru:80/services/docs.html')"/>
        <xsl:copy-of select="cpm:uriparse.uri('file:///c:/foo/bar/figar.new.last.txt')"/>
        <xsl:copy-of select="cpm:uriparse.uri('file:/c:/foo/bar/figar.txt')"/>
        <xsl:copy-of select="cpm:uriparse.uri('file:/c:/figar.txt')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="cpm:path.2uri('c:\zoo\animals\вомбат.doc', 'windows')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of
            select="cpm:uri.2path('file:/c:/zoo/animals/%D0%B2%D0%BE%D0%BC%D0%B1%D0%B0%D1%82.doc', 'windows')"/>


        <xsl:text>&#10;</xsl:text>
        <xsl:value-of
            select="cpm:uri.relative('file:/c:/zoo/animals/wombat.html', 
                                     'file:/c:/zoo/animals/images/wombat.jpg')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of
            select="cpm:uri.relative('file:/c:/zoo/animals/wombat.html', 
                                     'file:/c:/zoo/images/wombat.jpg')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of
            select="cpm:uri.relative('file:/c:/zoo/animals/mummles/wombat.html', 'file:/c:/zoo/images/wombat.jpg')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of
            select="cpm:uri.relative('file:/c:/zoo/animals/mummles/wombat.html', 'file:/c:/wombat.jpg')"/>
        
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of
            select="cpm:uri.relative('file:/c:/wombat.html', 'file:/d:/wombat.jpg')"/>

        <xsl:text>&#10;</xsl:text>
        <xsl:text>Parent folder: </xsl:text>
        <xsl:value-of select="cpm:uri.parentFolder('file:/f:/foo/bar/figar.txt')"/>


    </xsl:template>


</xsl:stylesheet>
