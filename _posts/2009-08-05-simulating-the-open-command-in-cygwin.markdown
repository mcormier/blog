--- 
layout: oneColumnPost
title: Simulating the open command in cygwin
categories: 
- Mondo Kode
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
You may or may not be familiar with the <a href="http://ss64.com/osx/open.html">open command</a> in the terminal application.  With the open command you can type
<strong>"open ."</strong>
at the command line and a Finder window will appear.  You can also type
<strong>"open &lt;filename&gt;"</strong>
 and the file will be opened with it's associated application, as if you double clicked on it from the finder.

Now suppose you're a Mac aficionado using Windows.  You've installed <a href="http://www.cygwin.com/">Cygwin</a> to gain access to the power of Unix but you miss the open command.  The following script can help you out.

<pre lang="bash">
#!/usr/bin/bash

if [ -z "$1" ] ; then
  echo "I'm hungry give me a parameter."
  exit
fi

PARAM=`cygpath --dos --absolute "$1"`

/cygdrive/c/Windows/explorer.exe $PARAM &
</pre>

<strong>UPDATE:</strong> Or you can alias the <strong>cygstart </strong>command in your .bashrc file as this <a href="http://stackoverflow.com/questions/577595/open-a-file-from-cygwin" >stackoverflow posting explains</a>.
