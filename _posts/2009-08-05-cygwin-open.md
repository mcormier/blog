--- 
layout: oneColumnPost
title: Simulating the open command in cygwin

---

You may or may not be familiar with the [open command][openCommand] in the terminal application.  With the open command you can type **"open ."** at the command line and a Finder window will appear.  You can also type **"open &lt;filename&gt;"** and the file will be opened with it's associated application, as if you double clicked on it from the finder.

Now suppose you're a Mac aficionado using Windows.  You've installed [Cygwin][cygwin] to gain access to the power of Unix but you miss the open command.  The following script can help you out.

{% highlight bash %}
#!/usr/bin/bash

if [ -z "$1" ] ; then
  echo "I'm hungry give me a parameter."
  exit
fi

PARAM=`cygpath --dos --absolute "$1"`

/cygdrive/c/Windows/explorer.exe $PARAM &
{% endhighlight%}

**UPDATE:** Or you can alias the **cygstart** command in your .bashrc file as this [stackoverflow posting explains][overflowPost].



[openCommand]: http://ss64.com/osx/open.html
[cygwin]: http://www.cygwin.com
[overflowPost]: http://stackoverflow.com/questions/577595/open-a-file-from-cygwin
