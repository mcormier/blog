--- 
layout: post
title: Is Windows Safari using Objective-C 2.0?

---
If you look at the Safari installation directory on Windows you probably noticed the <strong>objc.dll</strong> file.  Are you curious if Windows Safari is using Objective-C version 1.0 or 2.0?  I was, and this is my little adventure on trying to find that out.  The short answer is<strong> NO</strong>.  Safari on Windows still uses Objective-C 1.0.  In this article I'm going to build the  Objective-C DLL and show you why I don't think Safari for Windows is using version 2.0.

<center><img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/11/files.gif" alt="files" title="files" width="141" height="224" class="size-full wp-image-672" border=1/></center>

<h3>The Objective-C Runtime Environment</h3>

In my <a href="http://www.preenandprune.com/cocoamondo/?p=635">last article</a> I showed you how to build a bare bones Objective-C program in Windows with <a href="http://cygwin.com/">Cygwin</a>.  In that case, the Objective-C runtime used was installed with Cygwin.  You can execute the following command to take a peek at the Objective-C header and library files that Cygwin uses.

<strong>find /lib/gcc | grep objc</strong>

This is not the same Objective-C runtime that Apple uses when compiling Safari for Windows.  In fact there are three Objective-C runtime environments that I know of:

<ol>
	<li>Cygwin</li>
	<li>Apple</li>
	<li>GnuStep</li>
</ol>

We used Cygwin in the last article and now we're going to build Apple's implementation on Windows. I may discuss <a href="http://www.gnustep.org/">GnuStep</a> at a later date.

<h3>Let's Start Building Something</h3>

The first thing we need to do is get the latest source.
<a href="http://www.opensource.apple.com/tarballs/objc4/objc4-437.tar.gz">http://www.opensource.apple.com/tarballs/objc4/objc4-437.tar.gz</a>

Once you unpack the <a href="http://en.wiktionary.org/wiki/tarball">tarball</a> it's time to find out how to build this sucker.  You won't find a Makefile but you will find <strong>objc.vcproj</strong>.  This is a Microsoft Visual Studio project file.

If you don't have Visual Studio installed you can download the free version <a href="http://www.microsoft.com/exPress/">here</a>.  Why Microsoft insists on on continuing to charge for an IDE is beyond me.  Must be a cultural thing.  What you want is Visual C++ Expression Edition 2008.  It may or may not work with the new 2010 Beta; I have no idea.  I ran 2008 so I'm telling you to do the same.

Once you have Visual Studio installed, open up the project file and choose <strong> build --> build solution</strong>.  You're going to get some errors about <strong>AvailablityMacros.h</strong> and <strong>TargetConditionals.h</strong> not being found.

Did you really think it was going to be that easy?

<h3>Error #1 TargetConditionals.h</h3>

If you have XCode installed on a Mac you can easily find TargetConditionals.h.  However, that file doesn't support the Microsoft compiler. This is evident by the comment at the top of the file.  It's good to read the source no?
{% highlight c %}
/*
     File:       TargetConditionals.h

     Contains:   Autoconfiguration of TARGET_ conditionals for Mac OS X and iPhone

                 Note:  TargetConditionals.h in 3.4 Universal Interfaces works
                        with all compilers.  This header only recognizes compilers
                        known to run on Mac OS X.

*/

#ifndef __TARGETCONDITIONALS__
#define __TARGETCONDITIONALS__
{% endhighlight  %}

So with a little Googly magic you'll find the TargetConditionals.h that you're looking for <a href="http://developer.apple.com/carbon/download/">here</a> under Universal Interfaces 3.4.2.  Of course, a \*.img.bin file isn't much help on a Windows operating system so you're going to have to extract the files on a Mac and then copy them to the Windows Machine.

Oh, and the files are going to have those classic Mac line breaks instead of Unix line breaks so you're going to have to convert them.

{% highlight sh %}
for file in `ls *.h`
do
  tr '\r' '\n' < $file  > tempfile.txt
  mv tempfile.txt $file
done
{% endhighlight  %}

Put those UniversalHeaders files you worked so hard to get somewhere logical, and include the header files in your project search path.  What's that? You can't figure out where to do that?  Confusing Microsoft UI got you down?

<center><strong>Tools --> Options --> VC++ Directories</strong></center>

Then set the "Show directories for" combo box to "Include files".
<center><img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/11/includeFiles.png" alt="includeFiles" title="includeFiles" border=2 width="409" height="155" class="aligncenter size-full wp-image-684" /></center>

If you do another build then you'll notice there are no complaints about TargetConditionals.h but Visual Studio still can't find AvailabilityMacros.h.

<h3>Error #2 AvailabilityMacros.h</h3>

To get rid of the AvailabilityMacros.h error grab all the header files in the latest SDK you installed on your Mac.  We are trying to compile the version of Objective-C that is compiled on Snow Leopard so you should probably get the 10.6 \*.h files.

Create another directory for some extra includes.  I called mine
<strong>/cygdrive/c/Dev/usr/include/VisualStudio</strong>, but you can call it what you like.  Now copy these three files to that new directory, and add the directory to the list of include directories in Visual Studio.
<ul>
	<li>Availability.h</li>
	<li>AvailabilityInternal.h</li>
	<li>AvailabilityMacros.h</li>
</ul>

<h3>Error #3 stdint.h</h3>
<a href="http://en.wikipedia.org/wiki/Stdint.h">Stdint.h </a> is used for making C code more portable and you need a copy.

Download a copy and put it in that new include directory you created.
<a href="http://msinttypes.googlecode.com/svn/trunk/stdint.h">http://msinttypes.googlecode.com/svn/trunk/stdint.h</a>

<h3>Error #4 _unmap_image_nolock</h3>

Next you will see a link error about  some functions in the file objc-runtime-old.m.  There is some information about this issue here:
<a href=" http://lists.apple.com/archives/darwin-dev/2009/Sep/msg00075.html">http://lists.apple.com/.../msg00075.html</a>
<a href="http://lists.apple.com/archives/darwin-dev/2009/Sep/msg00076.html">http://lists.apple.com/.../msg00076.html</a>

Basically you need to comment out three functions so that it will compile.  The explanation on the mailing list is that the source is out of sync which means nobody at Apple has probably tried to build objc on Windows for a while.
<ul>
<li>unmap\_image</li>
<li>map\_images</li>
<li>load\_images</li>
</ul>

Add <strong>#if !TARGET_OS_WIN32 ... #endif </strong> around those three functions.

{% highlight c %}
#if !TARGET_OS_WIN32
/***********************************************************************
* unmap_image
* Process the given image which is about to be unmapped by dyld.
* mh is mach_header instead of headerType because that's what
*   dyld_priv.h says even for 64-bit.
**********************************************************************/
__private_extern__ void
unmap_image(const struct mach_header *mh, intptr_t vmaddr_slide)
{
    recursive_mutex_lock(&loadMethodLock);
    unmap_image_nolock(mh, vmaddr_slide);
    recursive_mutex_unlock(&loadMethodLock);
}


/***********************************************************************
* map_images
* Process the given images which are being mapped in by dyld.
* Calls ABI-agnostic code after taking ABI-specific locks.
**********************************************************************/
__private_extern__ const char *
map_images(enum dyld_image_states state, uint32_t infoCount,
           const struct dyld_image_info infoList[])
{
    const char *err;

    recursive_mutex_lock(&loadMethodLock);
    err = map_images_nolock(state, infoCount, infoList);
    recursive_mutex_unlock(&loadMethodLock);

    return err;
}


/***********************************************************************
* load_images
* Process +load in the given images which are being mapped in by dyld.
* Calls ABI-agnostic code after taking ABI-specific locks.
*
* Locking: acquires classLock and loadMethodLock
**********************************************************************/
__private_extern__ const char *
load_images(enum dyld_image_states state, uint32_t infoCount,
           const struct dyld_image_info infoList[])
{
    BOOL found;

    recursive_mutex_lock(&loadMethodLock);

    // Discover +load methods
    found = load_images_nolock(state, infoCount, infoList);

    // Call +load methods (without classLock - re-entrant)
    if (found) {
        call_load_methods();
    }

    recursive_mutex_unlock(&loadMethodLock);

    return NULL;
}
#endif
{% endhighlight  %}

<h3>Error #5 SRCROOT & DSTROOT</h3>

We've almost got this DLL built, we just need to do one last thing. Several places in the project properties the variables $(SRCROOT) and $(DSTROOT) are referenced.

<center><img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/11/srcRoot.png" alt="srcRoot" title="srcRoot" width="413" height="157" class="aligncenter size-full wp-image-691" /></center>

Created a batch file to define those variables right before opening up the Visual Studio Project file.

{% highlight dosbatch %}
set DSTROOT=c:\Dev\builds\ObjC\
set SRCROOT=c:\Dev\sourceRoot\ObjC\
C:\cygwin\bin\cygstart.exe objc.vcproj
{% endhighlight  %}

Now you should be able to successfully build the objc.dll library. It can be found under <strong>$DSTROOT\AppleInternal\bin\objc.dll</strong>.

<h3>Attempt to Build Objective-C 2.0</h3>

So far you've built Objective-C 1.0.  Now let's try to build version 2.0.  If you look at the source code you see <strong>__OBJC2__</strong> littered all over the kode.  To build version 2.0 you need to define it.

Add <strong>/D "__OBJC2__"</strong> to the C/C++ command line arguments in the project properties and do a build.  You will get lots of errors.

If you're building on 32-bit windows like myself you'll get an error about an unknown preprocessor command in <strong>objc-runtime-new.m</strong>.  Apparently the Microsoft C++ compiler does not recognize the <strong>#warning</strong> directive, must be a cultural thing.

{% highlight c linenos linenostart=430 %}
#if defined(__x86_64__)
    uint16_t *p = (uint16_t *)(dst + vtable_prototype_index_offset + 3);
    if (*p != 0x7fff) _objc_fatal("vtable_prototype busted");
    *p = index * 8;
#else
#   warning unknown architecture
#endif
{% endhighlight %}

I didn't try too hard to build Objective-C 2.0 because I bumped into the following nugget when perusing <strong>objc-confg.h</strong>.

{% highlight c linenos linenostart=28 %}
#if TARGET_OS_EMBEDDED  ||  TARGET_OS_WIN32
#   define NO_GC 1
#endif
{% endhighlight %}

### Conclusion
If Objective-C 2.0 can be built on 32-bit Windows I don't know how to do it.  Garbage collection is one of the staple features of Objective-C 2.0 (properties and fast enumeration are just syntactic sugar) and if it's not supported, is there really any point of building it?  Therefore we can firmly conclude that Safari for Windows is not using Objective-C 2.0, at least the 32-bit version anyway.

<strong>References</strong>
<a href="http://www.theocacao.com/document.page/510">A Quick Objective-C 2.0 Tutorial</a>
