---
layout: post
title:  "Humanizing XML"
date:   2010-08-25 16:49:14
categories: cygwin xml 
---

XML is supposed to be human readable, so it can be quite the hair tearing ordeal when reading it, if it is stripped of whitespaces. That whitespace was taken out to speed up computer to computer transactions, or the schlep that wrote the outputter never considered people, but you’ve got to read it now and you need some spaces and tabs in the mix. With a little setup you can cut through that unindented XML like butter.

## Ingredients

- A VI editor
- Extensible stylesheet language transformation tool (xsltproc)

Install xsltproc on your system if it doesn't exist. I don’t recall if it is installed with Mac OS X as I set this up a while back on my Mac. If you’re in Cygwin country install the libxml2 and libxslt packages.

Create the following XML stylesheet file and call it indent.xsl.


{% highlight xml %}
<xsl:stylesheet version="1.0" 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
  <xsl:copy-of select="."/>
  </xsl:template>
</xsl:stylesheet>
{% endhighlight %}

Now add the following function to your .vimrc file.

{% highlight vim %}
function! DoPrettyXML()
  '[,']!xsltproc indent.xsl %
endfunction
 
command! PrettyXML call DoPrettyXML()
{% endhighlight %}

You can now use the command **:PrettyXML** in VI and cut through XML like butter, keeping those precious follicles intact.

## References:

 - [Automatically indent an XML file using XSLT][vixslt]
 - [Pretty-formatting XML][pretty]
 - [XSLT][xslt]


[vixslt]: http://vim.wikia.com/wiki/VimTip551
[pretty]: http://vim.wikia.com/wiki/Pretty-formatting_XML
[xslt]: http://en.wikipedia.org/wiki/XSLT
