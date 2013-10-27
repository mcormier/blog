--- 
layout: oneColumnPost
title: Make Cygwin Play Nice with SunOs
categories: 
- Cygwin
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
If you've ever logged into a SunOs box using a Windows Cygwin terminal you've probably gotten the message "<em>Cannot find terminfo entry for 'cygwin'.</em>".  This can be quite a nuisance as it makes editing files with VI  very difficult.  You can set your TERM variable to vt100 but this only half works.  

The correct way to fix this is to let SunOs know what a Cygwin terminal is and how it behaves.  If you take the time and set up proper introductions SunOs and Cygwin will have a civil conversation together.  Here's how:

On the SunOS box:
<pre lang="sh" >
mkdir ~/terminfo
mkdir ~/terminfo/c
echo "export TERMINFO=~/terminfo" >> ~/.bashrc
</pre>

On the Windows box:
<pre lang="sh" >
cd /usr/lib/terminfo/c
scp cygwin username@server:~/terminfo/c/cygwin
</pre>

Kode on!
