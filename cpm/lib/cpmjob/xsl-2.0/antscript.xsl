<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="config.xsl"/>

    <!-- 
        Assembling Ant properties
    -->

    <xsl:function name="cpm:ant.property">
        <xsl:param name="strName"/>
        <xsl:param name="strValue"/>
        <property name="{$strName}" value="{$strValue}"/>
    </xsl:function>
    
    
    <!-- 
        Assembling CPM-specific Java tasks launching Saxon
    -->

    <!-- Assembling an Ant Java <arg> for passing an XSLT parameter to Saxon -->
    <xsl:function name="cpm:ant.saxonParam">
        <xsl:param name="strName"/>
        <xsl:param name="strValue"/>
        <arg>
            <xsl:choose>
                <xsl:when test="contains($strValue, ' ')">
                    <xsl:attribute name="line">
                        <xsl:value-of select="$strName"/>
                        <xsl:text disable-output-escaping="yes">="</xsl:text>
                        <xsl:value-of select="$strValue"/>
                        <xsl:text disable-output-escaping="yes">"</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="value">
                        <xsl:value-of select="$strName"/>
                        <xsl:text>=</xsl:text>
                        <xsl:value-of select="$strValue"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </arg>
    </xsl:function>

    <!-- Assembling a CPM-specific Java task -->
    <xsl:template name="cpm.ant.saxon">
        <xsl:param name="strIn"/>
        <xsl:param name="strOut"/>
        <xsl:param name="strStyle"/>
        <xsl:param name="strCatalog"/>
        <xsl:param name="xmlParams"/>

        <java classname="net.sf.saxon.Transform" fork="true">
            <classpath path="cpm:saxon.jarClasspath"/>
            <classpath path="cpm:resolver.jarClasspath"/>
            <!--
            <jvmarg value="${java.minMemory}"/>
            <jvmarg value="${java.maxMemory}"/>
            -->

            <xsl:if test="$strCatalog != ''">
                <jvmarg>
                    <xsl:attribute name="line">
                        <xsl:value-of
                            select="concat('-Dxml.catalog.files=&quot;', $strCatalog, '&quot;')"
                            disable-output-escaping="yes"/>
                    </xsl:attribute>
                </jvmarg>
            </xsl:if>
            
            <arg value="-r:org.apache.xml.resolver.tools.CatalogResolver"/>
            <arg value="-x:org.apache.xml.resolver.tools.ResolvingXMLReader"/>
            <arg value="-y:org.apache.xml.resolver.tools.ResolvingXMLReader"/>
            <arg value="-o"/>
            <arg value="{$strOut}"/>
            <arg value="{$strIn}"/>
            <arg value="{$strStyle}"/>
            <xsl:copy-of select="$xmlParams/arg"/>
        </java>

    </xsl:template>


</xsl:stylesheet>
