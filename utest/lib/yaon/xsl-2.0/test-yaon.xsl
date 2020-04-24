<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="../../../../cpm/lib/yaon/xsl-2.0/yaon.xsl"/>

    <xsl:output method="text"/>

    <xsl:template match="/">

        <xsl:variable name="xmlConfig">
            <record name="cfg">
                <property name="protocol" value="https"/>
                <property name="host" value="philosoft.ru"/>
                <property name="user"><![CDATA[ivanov${url}petrov]]></property>
                <property name="url"><![CDATA[${protocol}://${host}/${user}]]></property>
            </record>
        </xsl:variable>

        <xsl:value-of select="cpm:yaon.propValue($xmlConfig/record, 'protocol')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="cpm:yaon.propValue($xmlConfig/record, 'host')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="cpm:yaon.propValue($xmlConfig/record, 'user')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="cpm:yaon.propValue($xmlConfig/record, 'url')"/>
    </xsl:template>

</xsl:stylesheet>
