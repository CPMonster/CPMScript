<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="../../utils/xsl-2.0/morestr.xsl"/>





    <xsl:function name="cpm:yaon.resolve">
        <xsl:param name="strRef"/>
        <xsl:param name="elmBase"/>
        <xsl:param name="xmlHostory"/>

        <xsl:variable name="idTarget">
            <xsl:value-of select="generate-id($elmBase/../property[@name = $strRef])"/>
        </xsl:variable>

        <xsl:if test="not($xmlHostory/* = $idTarget)">
            <xsl:value-of select="cpm:yaon.value($elmBase/../property[@name = $strRef])"/>
        </xsl:if>

    </xsl:function>


    <xsl:template match="property" mode="cpm.yaon.value">
        <xsl:variable name="strRawValue" select="cpm:yaon.rawValue(.)"/>

        <xsl:analyze-string select="$strRawValue" regex="\$\{{.*\}}">

            <xsl:matching-substring>

                <xsl:variable name="strRef">
                    <xsl:value-of select="cpm:morestr.extract($strRawValue, '${', '}')"/>
                </xsl:variable>

                <xsl:variable name="xmlHistory">
                    <item>
                        <xsl:value-of select="generate-id()"/>
                    </item>
                </xsl:variable>

                <xsl:value-of select="cpm:yaon.resolve($strRef, ., $xmlHistory)"/>

            </xsl:matching-substring>

            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>

        </xsl:analyze-string>

    </xsl:template>


    <!-- 
        Extracting a string representation of a propery value
    -->

    <xsl:template match="*" mode="cpm.yaon.rawValue"/>

    <xsl:template match="property[@value]" mode="cpm.yaon.rawValue">
        <xsl:value-of select="@value"/>
    </xsl:template>

    <xsl:template match="property[not(@value)]" mode="cpm.yaon.rawValue">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:function name="cpm:yaon.rawValue">
        <xsl:param name="elmProp"/>
        <xsl:apply-templates select="$elmProp" mode="cpm.yaon.rawValue"/>
    </xsl:function>


    <!-- 
        Reading a property value while we have a property
    -->

    <xsl:template match="*" mode="cpm.yaon.value"/>

    <xsl:template match="property" mode="cpm.yaon.value">
        <xsl:variable name="strRawValue" select="cpm:yaon.rawValue(.)"/>
        
        <xsl:variable name="seqHistory">
            <item>
                <xsl:value-of select="generate-id()"/>
            </item>
        </xsl:variable>
        
        <xsl:value-of select="cpm:yaon.evaluate($rawValue, $seqHistory)"/>

    </xsl:template>

    <xsl:function name="cpm:yaon.value">
        <xsl:param name="emlProp"/>
        <xsl:apply-templates select="$emlProp" mode="cpm.yaon.value"/>
    </xsl:function>


    <!-- 
        Reading a property value while we have a record
    -->

    <xsl:template match="*" mode="cpm.yaon.propValue"/>

    <xsl:template match="record" mode="cpm.yaon.propValue">
        <xsl:param name="strName"/>
        <xsl:value-of select="cpm:yaon.value(property[@name = $strName])"/>
    </xsl:template>

    <xsl:function name="cpm:yaon.propValue">
        <xsl:param name="elmRecord"/>
        <xsl:param name="strName"/>
        <xsl:apply-templates select="$elmRecord" mode="cpm.yaon.propValue"/>
    </xsl:function>


</xsl:stylesheet>
