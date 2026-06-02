<!-- https://github.com/kaiyga/icecast-exporter -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="text" encoding="UTF-8" media-type="application/json" />

    <xsl:template match="/icestats">
        {
            "icestats": {
                "source": [
                    <xsl:for-each select="source">
                        {
                            "mount": "<xsl:value-of select="@mount" />",
                            "listeners": <xsl:choose>
                                <xsl:when test="listeners"><xsl:value-of select="listeners" /></xsl:when>
                                <xsl:otherwise>0</xsl:otherwise>
                            </xsl:choose>,
                            "server_name": "<xsl:value-of select="server_name" />",
                            "title": "<xsl:value-of select="title" />",
                            "bitrate": "<xsl:value-of select="bitrate" />",
                            "server_type": "<xsl:value-of select="server_type" />"
                        }<xsl:if test="position() != last()">,</xsl:if>
                    </xsl:for-each>
                ]
            }
        }
    </xsl:template>
</xsl:stylesheet>

