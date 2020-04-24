<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       YAON
    Module:     yaon.xsl    
    Usage:      Library
    Func:       Yet Another Object Notation
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <xsl:import href="../../utils/xsl-2.0/morestr.xsl"/>

    <xsl:import href="../../utils/xsl-2.0/morexsl.xsl"/>

    <xsl:import href="../../utils/xsl-2.0/rhist.xsl"/>


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
        Resolving a reference to a storage id
    -->

    <xsl:function name="cpm:yaon.ref2id">
        <xsl:param name="elmBase"/>
        <xsl:param name="strRef"/>
        <xsl:variable name="strRefPropName" select="cpm:morestr.extract($strRef, '${', '}')"/>
        <xsl:value-of select="cpm:morexsl.id($elmBase/../*[@name = $strRefPropName])"/>
    </xsl:function>


    <!-- 
        Evaluating property values
    -->

    <xsl:function name="cpm:yaon.eval">
        <xsl:param name="elmProp"/>
        <xsl:param name="emlHistory"/>

        <xsl:if test="cpm:rhist.isUniqueId($emlHistory, $elmProp)">

            <xsl:variable name="strRawValue" select="cpm:yaon.rawValue($elmProp)"/>

            <xsl:variable name="strPropNamePattern">
                <xsl:text><![CDATA[\$\{[A-Za-z_\.][A-Za-z_.\d]+\}]]></xsl:text>
            </xsl:variable>

            <xsl:analyze-string select="$strRawValue" regex="{$strPropNamePattern}" flags="i">

                <xsl:matching-substring>

                    <xsl:variable name="idRef" select="cpm:yaon.ref2id($elmProp, .)"/>

                    <xsl:variable name="elmMyHistory"
                        select="cpm:rhist.pushIdAsItem($emlHistory, $elmProp)"/>

                    <xsl:value-of
                        select="cpm:yaon.eval(root($elmProp)//*[cpm:morexsl.checkId(., $idRef)], $elmMyHistory)"/>

                </xsl:matching-substring>

                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>

            </xsl:analyze-string>

        </xsl:if>

    </xsl:function>


    <!-- 
        Reading a value of a property or whatever while we keep it in our hands
    -->

    <xsl:template match="*" mode="cpm.yaon.value"/>

    <xsl:template match="property" mode="cpm.yaon.value">
        <xsl:value-of select="cpm:yaon.eval(., cpm:rhist.new())"/>
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
        <xsl:param name="strPropName"/>
        <xsl:value-of select="cpm:yaon.value(property[@name = $strPropName])"/>
    </xsl:template>

    <xsl:function name="cpm:yaon.propValue">
        <xsl:param name="elmRecord"/>
        <xsl:param name="strPropName"/>
        <xsl:apply-templates select="$elmRecord" mode="cpm.yaon.propValue">
            <xsl:with-param name="strPropName" select="$strPropName"/>
        </xsl:apply-templates>
    </xsl:function>

</xsl:stylesheet>
