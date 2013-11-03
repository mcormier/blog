--- 
layout: oneColumnPost
title: Make Cygwin Play Nice with SunOs

---

If you've ever logged into a SunOs box using Cygwin you've probably gotten the message **Cannot find terminfo entry for 'cygwin'.**.  This can be quite a nuisance as it makes editing files with VI  very difficult.  You can set your TERM variable to vt100 but this only half works.

The correct way to fix this is to let SunOs know what a Cygwin terminal is and how it behaves.  If you take the time and set up proper introductions SunOs and Cygwin will have a civil conversation together.

On the SunOS box:
{% highlight sh %}
mkdir ~/terminfo
mkdir ~/terminfo/c
echo "export TERMINFO=~/terminfo" >> ~/.bashrc
{% endhighlight %}

On the Windows box:
{% highlight sh %}
cd /usr/lib/terminfo/c
scp cygwin username@server:~/terminfo/c/cygwin
{% endhighlight %}
