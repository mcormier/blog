--- 
layout: post
title: How to open a DMG file in Windows?

---
So for some reason or another you need to get something from a DMG file and there isn't a Mac in the vicinity.  It is possible, and you don't need to pay $50 for something like <a href="http://www.mediafour.com/products/macdrive/">MacDrive</a>.

For the super lazy and non-koder types you can use <a href="http://vu1tur.eu.org/tools/" >dmg2iso</a> to create an ISO from the DMG file.  Then mount the ISO with some windows ISO mounting software.

I didn't do this.  I downloaded the source to <a href="http://vu1tur.eu.org/tools/" >dmg2img</a> and read the README.  Yes, I actually read README files, why do you think they're named so?  This pointed me in the direction of <a href="http://github.com/planetbeing/libdmg-hfsplus">libdmg-hfsplus</a>.

People looking for a more professional tool should take a look to the libdmg library and related utilities:

- http://github.com/planetbeing/libdmg-hfsplus/tree/master
- http://www.shanemcc.co.uk/libdmg/

(the libdmg code is still reported to be experimental, though, and it is also much bigger than dmg2img.)

<h3>Build the Tools</h3>
Download the latest version of <a href="http://github.com/planetbeing/libdmg-hfsplus">libdmg-hfsplus</a> , the git enlightened can execute:

{% highlight sh %}
git clone git://github.com/planetbeing/libdmg-hfsplus.git
{% endhighlight %}

libdmg-hfsplus uses <a href="http://www.cmake.org/">CMake</a> so make sure you have cmake installed.  You can either install the cygwin package or get the latest <a href="http://www.cmake.org/cmake/resources/software.html">Windows version</a>.  I recommend the cygwin version since that's what I used.

Execute these commands in the root libdmg-hfsplus directory:
{% highlight sh %}
cmake ./
make
{% endhighlight %}

Now you've built the tools you need to cut through DMG files like butter.
<ul><li>dmg.exe</li><li>hdutil.exe</li><li>hfsplus.exe</li>
</ul>

Copy the exe files somewhere that is in your path (~/bin for example).

<h3>Use the Tools</h3>

To test this out you're gonna need a DMG file. You can download the DMG file I used <a href="http://sunflower.preenandprune.com/download.php">here</a>.  It's zipped up so you should probably unzip it.

Of the three executable files you built the only one you really need to use is <strong>hdutil</strong>.  Here is the command to list the contents of a DMG file.

{% highlight sh %}
hdutil SunFlowerPublic-0.7.dmg ls
{% endhighlight %}

The ls command will also take a parameter which will let you explore the contents of the DMG file system.

{% highlight sh %}
hdutil SunFlowerPublic-0.7.dmg ls /SunFlower.app/Contents
{% endhighlight %}

The extract command wants two arguments.  The first is the location of the file in the DMG file.  The second is where to put the file on your machine.

{% highlight sh %}
hdutil SunFlowerPublic-0.7.dmg extract /DMG_backgroundPro.png local.png
{% endhighlight %}

Use the extractall command to pull out everything in one fell swoop.

{% highlight sh %}
hdutil SunFlowerPublic-0.7.dmg extractall
{% endhighlight %}

Finally the easiest way to extract the DMG to a clean directory is to create a new directory and call the extractall command from that location.

{% highlight sh %}
mkdir explodedDMG
cd explodedDMG
hdutil ../SunFlowerPublic-0.7.dmg extractall
{% endhighlight %}

The core code of libdmg-hfsplus appears to be system independent so this should work with Linux also.

Kode on!

<strong>References:</strong>
<ul><li><a href="http://github.com/planetbeing/libdmg-hfsplus">libdmg-hfsplus</a></li><li><a href="http://vu1tur.eu.org/tools/" > dmg2img + dmg2iso</a> </li><li><a href="http://www.linuxjournal.com/node/6700/print">Cross-Platform Software Development Using CMake</a></li>
<li><a href="http://www.computing.net/answers/mac/dmg-without-os-x-using-a-pc/10311.html">.DMG without OS X using a PC</a></li>
</ul>
