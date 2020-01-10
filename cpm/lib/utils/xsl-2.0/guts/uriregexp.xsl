<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     uriregexp.xsl
    Usage:      Guts    
    Func:       Providing regular expressions for parsing URIs
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Assembling regular expressions -->
    <xsl:import href="../regexp.xsl"/>


    <!-- 
        Assembling building blocks for URI regexps
    -->

    <xsl:function name="cpm:uriregexp.commonChar">
        <xsl:text><![CDATA[(([A-Za-z\d\-\._~])|(%[A-F\d]{2}))]]></xsl:text>
    </xsl:function>

    <xsl:function name="cpm:uriregexp.commonTerm">
        <xsl:value-of select="cpm:regexp.multiGroup(cpm:uriregexp.commonChar(), '+')"/>
    </xsl:function>

    <xsl:function name="cpm:uriregexp.hostChar">
        <xsl:text><![CDATA[[A-Za-z\d\-_~]]]></xsl:text>
    </xsl:function>

    <xsl:function name="cpm:uriregexp.hostTerm">
        <xsl:value-of select="cpm:regexp.multiGroup(cpm:uriregexp.hostChar(), '+')"/>
    </xsl:function>

    <xsl:function name="cpm:uriregexp.protocol">
        <xsl:value-of select="cpm:uriregexp.commonTerm()"/>
    </xsl:function>

    <xsl:function name="cpm:uriregexp.login">
        <xsl:value-of select="cpm:uriregexp.commonTerm()"/>
    </xsl:function>

    <xsl:function name="cpm:uriregexp.pwd">
        <xsl:value-of select="cpm:uriregexp.commonTerm()"/>
    </xsl:function>

    <xsl:function name="cpm:uriregexp.pwdGroup">
        <xsl:call-template name="cpm.regexp.sequenceGroup">
            <xsl:with-param name="seqItems">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="cpm:uriregexp.pwd()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:function>

    <xsl:function name="cpm:uriregexp.credentials">
        <xsl:call-template name="cpm.regexp.sequenceGroup">
            <xsl:with-param name="seqItems">
                <xsl:value-of select="cpm:uriregexp.login()"/>
                <xsl:value-of select="cpm:regexp.multiGroup(cpm:uriregexp.pwdGroup(), '?')"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:function>
    
    <xsl:function name="cpm:uriregexp.hostGroup">
        <xsl:call-template name="cpm.regexp.sequenceGroup">
            <xsl:with-param name="seqItems">
                <xsl:text>\.</xsl:text>
                <xsl:value-of select="cpm:uriregexp.hostTerm()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:function>
    
    <xsl:function name="cpm:uriregexp.host">
        <xsl:call-template name="cpm.regexp.sequenceGroup">
            <xsl:with-param name="seqItems">
                <xsl:value-of select="cpm:uriregexp.hostTerm()"/>
                <xsl:value-of select="cpm:regexp.multiGroup(cpm:uriregexp.hostGroup(), '*')"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:function>
    
    <xsl:function name="cpm:uriregexp.port">
        <xsl:text><![CDATA[([\dA-F]+)]]></xsl:text>
    </xsl:function>
    
    <xsl:function name="cpm:uriregexp.portGroup">
        <xsl:call-template name="cpm.regexp.sequenceGroup">
            <xsl:with-param name="seqItems">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="cpm:uriregexp.port()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:function>
    
    <xsl:function name="cpm:uriregexp.fullHost">
        <xsl:call-template name="cpm.regexp.sequenceGroup">
            <xsl:with-param name="seqItems">
                <xsl:value-of select="cpm:uriregexp.host()"/>
                <xsl:value-of select="cpm:regexp.multiGroup(cpm:uriregexp.portGroup(), '?')"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:function>


    <!-- 
        Providing regexps for URIs
    -->

    <xsl:function name="cpm:uri.regexpRelative">
        <xsl:text><![CDATA[.+]]></xsl:text>
    </xsl:function>

    <xsl:function name="cpm:uri.regexpAbsolute">
        <xsl:text><![CDATA[.+]]></xsl:text>
    </xsl:function>


</xsl:stylesheet>
