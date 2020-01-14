<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     strsets.xsl
    Usage:      Guts    
    Func:       Processing sets that are represented by strings
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <!-- 
        Modules 
    -->
    
    <!-- Processing lists that are represented by strings -->
    <xsl:import href="strlist.xsl"/>
    
        
    <xsl:function name="cpm:strsets.sequence" as="xs:string*">
        <xsl:param name="strSet1"/>
        <xsl:param name="strSep"/>
        <xsl:param name="strMode"/>        
    </xsl:function>
    
    <xsl:function name="cpm:strsets.string" >
        <xsl:param name="strSet1" as="xs:string"/>
        <xsl:param name="strSep"/>
        <xsl:param name="strMode"/>        
    </xsl:function>
    
    <xsl:function name="cpm:strsets.count">
        <xsl:param name="strSet1"/>
        <xsl:param name="strSet2"/>
        <xsl:param name="strSep"/>
        <xsl:param name="strMode"/>
    </xsl:function>
    
    <xsl:function name="cpm:strsets.isEmpty">
        <xsl:param name="strSet1"/>
        <xsl:param name="strSet2"/>
        <xsl:param name="strSep"/>
        <xsl:param name="strMode"/>
    </xsl:function>
    
    <xsl:function name="cpm:strsets.union">
        <xsl:param name="strSet1"/>
        <xsl:param name="strSet2"/>
        <xsl:param name="strSep"/>
        <xsl:param name="strMode"/>
    </xsl:function>
    
    <xsl:function name="cpm:strsets.intersection">
        <xsl:param name="strSet1"/>
        <xsl:param name="strSet2"/>
        <xsl:param name="strSep"/>
        <xsl:param name="strMode"/>
    </xsl:function>
    
    <xsl:function name="cpm:strsets.difference">
        <xsl:param name="strSet1"/>
        <xsl:param name="strSet2"/>
        <xsl:param name="strSep"/>
        <xsl:param name="strMode"/>
    </xsl:function>
    
    <xsl:function name="cpm:strsets.areEqual">
        <xsl:param name="strSet1"/>
        <xsl:param name="strSet2"/>
        <xsl:param name="strSep"/>
        <xsl:param name="strMode"/>
    </xsl:function>
    
</xsl:stylesheet>