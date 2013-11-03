--- 
layout: post
title: Objective-C on Windows Tutorial
categories: 
- Mondo Kode
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
This is a explanation of how to compile an Objective-C hello world program on the Windows platform.  To follow this tutorial you will need <a href="http://cygwin.com/">cygwin </a>installed with gcc.

Let's get started.

First create the header file <strong>Hello.h</strong>
<pre lang="objc" >
#import <objc/Object.h>

@interface Hello : Object {

}

-(void)world;

@end
</pre>

Because this is a pure Objective-C program and does not use Apple's cocoa framework the Hello object extends Object instead of NSObject.

Now create the implementation file <strong>Hello.m</strong>.
<pre lang="objc">
#import "Hello.h"

@implementation Hello

-(void)world {
  printf("Hello World!\n");
}
@end
</pre>
Nothing unusual in the <strong>Hello.m</strong> file. Let's do some compiling.

<strong>gcc -c -Wno-import Hello.m</strong>

GCC can compile and link programs so we pass the -c flag to tell it to compile, and it happily creates a sparkling <strong>Hello.o</strong> object file for us.

The second flag is much more interesting. It specifies not to display warnings if <strong>#import</strong> statements are used.  The free software movement fanatics don't like <strong>#import</strong> and it is listed as an obsolete feature[2].  Of course, it has probably been listed as obsolete for twenty years, and if it is ever removed Apple will just fork GCC.  Oh wait, Apple is now providing <a href="http://llvm.org/">llvm</a> as an option with Xcode so that problem has already been solved.

Now let's use our object in a program.  Create a <strong>main.m</strong> file.
<pre lang="objc">
#import <objc/Object.h>
#import "Hello.h"

main () {

  id hello;

  hello = [Hello new];
  [hello world];
  [hello free];
}
</pre>

New and free? Where's alloc, init, retain and release?  Those are all defined in NSObject of the Cocoa framework and are not part of the core Objective-C language.

Now compile this new implementation file to create a second object file <strong>main.o</strong>.

<strong>gcc -c -Wno-import main.m</strong>

Take the two object files and squish them together with the GCC linker to create a windows executable.

<strong>gcc -o helloWorld Hello.o main.o -lobjc</strong>

This is simple stuff. The -o parameter specifies the name of the executable.  Then we give a list of the object files we created and specify to link to the Objective-C library (-lobjc).  Now you should have <strong>helloWorld.exe</strong> on disk.

<h3>The -mno-cygwin Option</h3>

You're really proud of your helloWorld.exe and you think you might have something here.  You want to sell your program.  Who wouldn't pay for an application that displays "Hello World"?  It makes that computer seem so friendly.

Well you might have a problem. You see you built your program in cygwin and the EXE got linked to a DLL file called <strong>cygwin1.dll</strong>.  If you link and distribute this DLL file then your program falls under the GPL license agreement.

If the following command displays <strong>cygwin1.dll</strong> then you have a GPL problem.

<strong>objdump -p helloWorld.exe | grep "DLL Name"</strong>

If you prefer a GUI <a href="http://www.dependencywalker.com/">Dependency Walker</a> is a free tool that can also show you what DLL's an executable is linked to.

By adding the -mno-cygwin option to the link stage we can create a helloWorld.exe that we can sell without the constraints of the GPL.

<strong>gcc -o helloWorld -mno-cygwin Hello.o main.o -lobjc</strong>

<strong>objdump -p helloWorld.exe | grep "DLL Name"</strong>

Kode on.


<strong>References
</strong>
1. <em>Indiana University - CS304 - Compiling Objective-C </em><a href="http://www.cs.indiana.edu/classes/c304/ObjCompile.html">http://www.cs.indiana.edu/classes/c304/ObjCompile.html</a>

2. <em>The C Preprocessor for gcc version 3(Section 11.3.2)</em>
<a href="http://gcc.gnu.org/onlinedocs/gcc-3.4.6/cpp.pdf">http://gcc.gnu.org/onlinedocs/gcc-3.4.6/cpp.pdf</a>

3. <em>-mno-cygwin -- Building Mingw executables using Cygwin </em><a href="http://www.delorie.com/howto/cygwin/mno-cygwin-howto.html">http://www.delorie.com/howto/cygwin/mno-cygwin-howto.html</a>
