<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="../../../../cpm/lib/utils/xsl-2.0/rhist.xsl"/>

    <xsl:output indent="yes"/>

    <xsl:variable name="xmlTree">
        <nodes>
            <node id="root">
                <link ref="id-1-1"/>
                <link ref="id-1"/>
                <link ref="id-2"/>
                <link ref="id-3"/>                
            </node>
            <node id="id-1">
                <link ref="id-1-1"/>
                <link ref="id-1-2"/>
                <link ref="id-1-3"/>
            </node>
            <node id="id-2">
                <link ref="id-2-1"/>
                <link ref="id-2-2"/>
                <link ref="id-2-3"/>
            </node>
            <node id="id-3">
                <link ref="id-3-1"/>
                <link ref="id-3-2"/>
                <link ref="id-3-3"/>
            </node>
            <node id="id-1-1">
                <link ref="id-3"/>
            </node>
            <node id="id-1-2"/>
            <node id="id-1-3"/>
            <node id="id-2-1"/>
            <node id="id-2-2"/>
            <node id="id-2-3"/>
            <node id="id-3-1"/>
            <node id="id-3-2"/>
            <node id="id-3-3"/>
        </nodes>

    </xsl:variable>


    <xsl:function name="cpm:parse">
        <xsl:param name="elmItem"/>
        <xsl:param name="elmHistory"/>

        <xsl:variable name="idCurr" select="$elmItem/@id"/>

        <xsl:variable name="xmlLinks">
            <xsl:for-each select="$elmItem/*">
                <xsl:copy-of select="cpm:rhist.link(@ref)"/>
            </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="elmNode" select="cpm:rhist.node($idCurr, $xmlLinks)"/>

        <xsl:variable name="elmNewHistory" select="cpm:rhist.push($elmHistory, $elmNode)"/>


        <xsl:variable name="strNextId" select="cpm:rhist.firstTarget($elmNewHistory)"/>

        <xsl:message>
            <!--
            <xsl:value-of select="$elmItem/@id"/>
            <xsl:copy-of select="$xmlLinks"/>
            -->

            <xsl:copy-of select="$elmNewHistory"/>

            <xsl:copy-of select="$strNextId"/>
        </xsl:message>

        <xsl:if test="exists(root($elmItem)//node[@id = $strNextId])">
            <xsl:copy-of select="cpm:parse(root($elmItem)//node[@id = $strNextId], $elmNewHistory)"/>            
        </xsl:if>

        <item>
            <xsl:value-of select="$idCurr"/>
        </item>

    </xsl:function>


    <xsl:template match="/">
        <xsl:copy-of select="cpm:parse($xmlTree/nodes/node[@id = 'root'], cpm:rhist.new())"/>
    </xsl:template>


</xsl:stylesheet>
