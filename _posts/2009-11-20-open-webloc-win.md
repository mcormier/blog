--- 
layout: post
title: Opening a .webloc file in Windows
categories: 
- Mondo Kode
- Windows Cocoa
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
<h3>An Exploration of Cocoa on Windows</h3>
<h4>The problem</h4><br>

I have a habit of dragging addresses from the Safari address bar to my desktop on my Mac.  Eventually these web link files pile up and things become unmanageable.  Since I use dropbox, I decided to do a reboot by copying all of these files to a dropbox folder.   Then when I had free time and was sitting in front of a Windows machine that was also using dropbox I could do some reading.

<em>"Safari is on Windows, it must read .webloc files"</em>, I naively thought.  When I got to my Windows machine and had some free time I discovered that Windows Safari does not read .webloc files.  The .webloc file was in a binary format.  Opening the webloc file in vi showed some goobly-gook (binary data) and the URL string floating in binary data.  I could have easily copied the URL in vi and pasted it into the address bar, but  I'd gone this far and a program was demanding to be written.

So a .webloc file is stored as a binary plist, and reading a plist file is simple in Cocoa.  This was the perfect excuse for writing an Objective-C program in Windows.

Be forewarned.  Unlike my regular posts which I try to keep focused and to the point this one does go off on a tangent.

If you want to just skip ahead and read the kode then take a look at the following two gitHub repositories:
<ul><li><a href="http://github.com/mcormier/lilac">lilac</a> (pure cygwin implementation)</li><li><a href="http://github.com/mcormier/lilacStep">lilacStep</a> (a GNUStep implementation)</li></ul>

<h4>Where to Start?</h4><br>
In a <a href="http://www.preenandprune.com/cocoamondo/?p=635">previous posting</a> I explained how to write a simple Objective-C program in Windows.  The main benefits of using Objective-C on the Macintosh are:
<ol><li>It's object oriented</li>
<li>The frameworks/libraries provided</li>
<li>It's not as ugly as C++</li>
</ol>

The frameworks and libraries are particularly important.  Learning new frameworks takes time, and being able to leverage a familiar framework can save time.  Frameworks can also be designed poorly making them hard to use.  Lots of methods with too many parameters for example.

<pre lang="Cplusplus">
BOOL WINAPI CreateProcess(
  __in_opt     LPCTSTR lpApplicationName,
  __inout_opt  LPTSTR lpCommandLine,
  __in_opt     LPSECURITY_ATTRIBUTES lpProcessAttributes,
  __in_opt     LPSECURITY_ATTRIBUTES lpThreadAttributes,
  __in         BOOL bInheritHandles,
  __in         DWORD dwCreationFlags,
  __in_opt     LPVOID lpEnvironment,
  __in_opt     LPCTSTR lpCurrentDirectory,
  __in         LPSTARTUPINFO lpStartupInfo,
  __out        LPPROCESS_INFORMATION lpProcessInformation
);
</pre>
<ul>
<li><a href="http://msdn.microsoft.com/en-us/library/ms682425(VS.85).aspx">CreateProcess Reference</a></li>
<li><a href="http://queue.acm.org/detail.cfm?id=1255422">API Design Matters</a></li>
</ul>

Even if a framework is designed well, if the documentation for that framework is poor then learning how to use that framework will still be tedious.  Without proper documentation, you will need to experiment with method calls more which will take more time.

The framework that we're talking about here is obviously Cocoa.  All those classes that make Objective-C programming fun like NSString and NSData.  So what options do we have for using Cocoa on Windows?
<ol><li><a href="http://www.cocotron.com/">Cocotron</a></li>
<li><a href="http://www.gnustep.org/">GnuStep</a></li>
<li>Build your own</li>
</ol>

I decided to first start with Cocotron so I downloaded the latest source code.  However, Cocotron can only be built through XCode on Mac OS X.  Since I'm trying to do the build directly from Windows this was a non-starter but I figured having the source code handy would be a good idea.

Initially I stayed away from GNUStep because I was unsure of the licensing. I also already have a highly customized Cygwin environment so was hesitant in using GNUStep because it uses <a href="http://www.mingw.org/">minGW</a> and that would be another environment to customize and maintain.  Later I did look into GNUStep and ported my implementation to GNUStep easily.

As far as GNUStep licensing is concerned it uses GPL and LGPL so it should be safe to link to and distribute a binary.  However, I am not a lawyer and have yet to find a good explanation of the licensing terms.  There is no clear document that I could find in the GNUStep installation or website that states that GNUStep uses LGPL.  I determined that GNUStep is LGPL by the description on <a href="http://en.wikipedia.org/wiki/Gnustep">wikipedia</a> and by looking at the license inside the header files (<strong>/GNUstep/System/Library/Headers</strong>).  Documentation is not fun work, but the organization of the GNUStep documentation is particularly scatterbrained.

So with the constraint of doing the build purely in Windows, Cocotron was not an option. I decided to stay away from GNUStep temporarily so what option did that leave me with?  Surely I wasn't going to build my own Cocoa framework.  That would be pure folly.

<h4>Core Foundation</h4><br>
Well there was another option I didn't mention, Core Foundation. Like the Objective-C runtime, Apple has been releasing their Core Foundation library as open source for some time now. Core Foundation is not Objective-C kode, it is pure C, however the names of the C structures are eerily similar to some Objective-C foundation classes.  Core Foundation has a CFStringRef (NSString), CFArrayRef(NSArray), etc.  So it didn't seem far fetched to write Objective-C wrappers for these C data structures.

I downloaded and compiled Core Foundation, which was a little bit more difficult than I expected.  Like the <a href="http://www.preenandprune.com/cocoamondo/?p=663">Objective-C runtime</a> the build is not always verified to see if it works in Windows so some massaging is required.  If you are interested in doing this then check out the links below this paragraph.  Building Core Foundation is a good exercise, because it will help familiarize you with the library if you read some of the kode.  Now that I've built it however, I will just grab a copy out of a Safari installation because it's just plain easier.
<ul>
<li><a href="http://developer.apple.com/opensource/cflite.html">Creating Cross-Platform Applications with Core Foundation and Open Source</a></li>
<li><a href="http://karaoke.kjams.com/wiki/CFLite">More recent instructions on building Core Foundation</a></li>
</ul>

Once I decided to write Objective-C wrappers for Core Foundation I wondered if that was what Cocotron did.  So I looked at the CocoTron kode and discovered that CocoTron does not rely on Core Foundation. This surprised me because it went completely against my lazy programmer instincts.  Why reinvent the wheel?  You have this highly tested kodebase that you can use but you're going to rewrite it?

Eventually Christopher Lloyd did explain that Cocotron does not use Core Foundation because of some philosophical issues with regard to the APSL (Apple Software License Agreement).
<ol><li>If you modify any APSL kode you must clearly mark what you modified.</li>
<li>Apple has the right to terminate the APSL.</li></ol>

Christopher believes that issue #1 would be a long term hassle.  Personally I just wouldn't modify any APSL kode unless there were no other options.  Fix any issues with the kode in the wrapper layer, or provide an alternative implementation if the APSL kode doesn't work properly.

Issue #2 is nothing to get your feathers ruffled about.  Sure it sounds pretty nasty but this is a corporate cover your ass clause.  Apple has been releasing stuff under APSL for 10 years now and I have not heard of them terminating the license on anything.  I can see this clause only being used in exceptional circumstances because the PR backlash it would generate in the programmer world (general consumers couldn't care less) could be big.

Here are some interesting links. If you're smart enough to read then you're smart enough to think. Make up your own mind about the APSL.

<ul><li><a href="http://groups.google.com/group/cocotron-dev/browse_thread/thread/8d9b9ae9b9c17c8d/cff964c9398a8868?lnk=gst&q=matthieu#cff964c9398a8868">Why doesn't Cocotron use Core Foundation? (Part 1)</a></li>
<li><a href="http://stackoverflow.com/questions/56708/objective-c-for-windows/1683163#1683163">Why doesn't CocoTron use Core Foundation? (Part 2)</a></li>
<li><a href="http://www.gnu.org/philosophy/apsl.html">FSF's Opinion of the Apple Public Source License</a></li>
<li><a href="http://lists.spi-inc.org/pipermail/spi-general/1999-April/000276.html">APSL 1.1 certification... [talking with the lawyers]</a></li></ul>

<h4>The implementation</h4><br>

So the stage has been set and now you know the actors. I decided to call the program <a href="http://github.com/mcormier/lilac">lilac</a> for lack of a better name.  I first wrote lilac in pure C with Core Foundation to read the .webloc file as a plist and print out the URL value to the console.  This was very easy as Apple has the kode to read a plist file with Core Foundation <a href="http://developer.apple.com/opensource/cflite.html">here</a>.  Then I figured out how to read the default web browser from the registry (fun) and open a link in the default browser (see <a href="http://github.com/mcormier/lilac/blob/8af4f3db5353fdfc56b66374e74c983b70d4d5f4/src/mondoWin32/WinHelper.m">mondoWin32/WinHelper.m</a>).

After the core logic was built I started implementing it in Objective-C.  I created only the Cocoa objects that I needed, with the methods that I needed and put these source files in a directory called <a href="http://github.com/mcormier/lilac/tree/master/src/cocoaLite/">cocoaLite</a>.  I copied what code I could from CocoTron but some of the logic is obviously different since I was plugging into Core Foundation.

In the end I really only created NSString and NSArray, but this was enough for me to prove that it could be done.  Since the application I was creating is very short-lived (it reads a file and passes an URL to a browser and then dies), there was no need to support memory management (retain, release, pools).

<h4>How NSString Works</h4><br>

The trickiest part of the implementation was getting NSString working, and the Cocotron kode was very helpful in this regard.  Actually the trickiest part was sitting down and learning how to write a <a href="http://www.gnu.org/software/make/manual/make.html">makefile</a> but that was more patience and reading than anything else; I had been avoiding that for years anyway.

To get @"" string constants to work you need to do the following:

<ol>
<li>Add <a href="http://github.com/mcormier/lilac/blob/master/build/makefile#L24"><strong>-fconstant-string-class=NSConstantString</strong></a> to your compile and link options.</li>
<li>Define <a href="http://github.com/mcormier/lilac/blob/master/src/cocoaLite/NSString/NSString.m#L7">NSString as an abstract class that dishes out a different concrete class in the alloc method. No variables can be defined in </a>NSString. This is because NSConstantString will be extending NSString and the compiler requires a specific variable structure for constant-string-class.</li>
</ol>

<pre lang="objc">
@implementation NSString

// NSString is a stub class that creates another class
// that extends NSString.  We need to do this
// so that the variable signature does not interfere
// with NSConstantString which allows us to use @"blah"
// to construct strings.
+ (id)alloc {
  return (id)class_create_instance([NSStringCF class]);
}
</pre>

<ol>
<li>Create an <a href="http://github.com/mcormier/lilac/blob/master/src/cocoaLite/NSString/NSString.h#L53">NSConstantString</a> class that extends NSString</li>
</ol>

<pre lang="objc">
@interface NSConstantString: NSString {
  char *c_string;
  unsigned int len;
}
</pre>

<ol>
<li>Create an <a href="http://github.com/mcormier/lilac/blob/master/src/cocoaLite/NSString/NSStringCF.m">NSStringCF</a> class that extends NSString and works as a wrapper for a Core Foundation CFStringRef.Because you're going to need a non-constant implementation of NSString.</li>
</ol>
So I defined NSString, and NSArray, and I could have implemented NSData but I didn't. I felt I had gotten a good feeling as to how much work was required to create Objective-C wrappers for all the Core Foundation objects; a lot.

Later I followed <a href="http://www.jayson.in/programming/objective-c-programming-in-windows-gnustep-projectcenter.html">a tutorial</a> on how to install GNUStep and create a HelloWorld application.  The installation for GNUStep strikes me as odd.  You have to run three installers to use GNUStep, and it is this type of disorganization that makes people shy away from things.  However, once you go through all those hoops, like an obedient show dog, you get the benefit of an Objective-C API (OpenStep/Cocoa) that you can program against.

Converting lilac to use GNUStep (<a href="http://github.com/mcormier/lilacStep">lilacStep</a>) was quick and easy.  The biggest stumbling block that I had was accidently typing "<strong>make</strong>" from a Cygwin window instead of the minGW.  Because I had access to a framework almost identical to Cocoa I could delete the files from src/CocoaLite and simplify the makefile.  I could also greatly simplify the implementation of <strong>getURLFromWeblocFilename</strong> since I had access to NSData and NSDictionary.

<h4>Lilac Version</h4><br>

<pre lang="objc" >
+ (NSString*)getURLFromWeblocFile:(NSString*)weblocFilename {

  CFDataRef data = NULL;
  NSString* urlString;

  FILE *file = fopen( [weblocFilename cString], "r" );

  if ( file != NULL ) {
       int result = fseek( file, 0, SEEK_END );
       result = ftell( file );
       rewind( file );

       char * buffer = ( char * )calloc( 1, result );

       if ( buffer != NULL ) {
           if ( fread( buffer, result, 1, file ) > 0 ) {
               data = CFDataCreate( NULL, buffer, result );
           }

           free( buffer );
       }

       fclose( file );
   }

   if ( data != NULL ) {
       CFPropertyListRef propertyList = CFPropertyListCreateFromXMLData( NULL, data,
           kCFPropertyListImmutable, NULL );


       CFTypeID typeID = CFGetTypeID(propertyList);
       if ( typeID == CFDictionaryGetTypeID() ) {
         CFDictionaryRef dict = (CFDictionaryRef)propertyList;
         CFStringRef value = CFDictionaryGetValue(dict, CFSTR( "URL" ) );
         if (value != NULL ) {
            char url[2048];
            Boolean success = CFStringGetCString(value, url, 2048, kCFStringEncodingWindowsLatin1);
            if (success) {
              urlString = [[NSString alloc] initWithCString:url encoding:NSISOLatin1StringEncoding];
            }
         }
       }
   }

   CFRelease( data );

  return urlString;
}
 </pre>

<h4>LilacStep Version</h4><br>

<pre lang="objc" >
+ (NSString*)getURLFromWeblocFile:(NSString*)weblocFilename {

  NSData *data  = [[NSData alloc] initWithContentsOfFile:weblocFilename];
  NSString* errorString;

  NSDictionary* propList = [NSPropertyListSerialization  propertyListFromData:data mutabilityOption:0
                                              format:NULL
                                    errorDescription:&errorString];

  NSString* urlString = [propList valueForKey:@"URL"];

  [data release];

  return urlString;
}
</pre>

<h4>Conclusion</h4><br>

Don't build you're own Cocoa framework, use one that is already working (GNUStep) and contribute to that one if it is missing something you need.

Kode on!
