--- 
layout: post
title: The Little Things, Like Good documentation
categories: 
- Mondo Kode
- Rant
- User Interface
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
Over time having good documentation can have subtle effects on the flow of what you produce in an environment and how enjoyable it is to program for that environment.  As someone who programs in Java and in Cocoa it seems worth it to point out the differences in how the API documentation is laid out.   I'm gonna explain why Apple's Cocoa docs are better than Sun's (uh, I mean Oracle's) Java docs, and why I always dread having to look something up in the Java API.

We will be comparing <a href="http://java.sun.com/j2se/1.5.0/docs/api/javax/swing/JWindow.html">JWindow</a> with <a href="http://developer.apple.com/documentation/Cocoa/Reference/ApplicationKit/Classes/NSWindow_Class/Reference/Reference.html">NSWindow</a>. Both documentation sources are created with document genertation tools.  Apple uses <a href="http://developer.apple.com/opensource/tools/headerdoc.html">HeaderDoc</a> for their API and Sun (errr, Oracle) uses <a href="http://java.sun.com/j2se/javadoc/">JavaDoc</a> for their API.

<h3>Method Overview</h3>

The first noticeable and most important difference is the method overview for each.  Java documentation is in alphabetical order.  Cocoa documentation has been organized into logical groups.  Organization is important because the most common thing you do as a programmer is look for a method that does what you want to do.  When you are unfamiliar with the methods on a class or haven't used the class for a while all you know is "I want to do X".  Grouping the methods into categories of actions makes it easier for the uninitiated to find what they are looking for.

<center><img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/04/javamethods.gif" alt="" title="javamethods" width="402" height="419" class="alignnone size-full wp-image-436" border=2/>
Method documentation in Java
</center>
<center><img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/04/cocoamethods.gif" alt="" title="cocoamethods" width="354" height="419" class="alignnone size-full wp-image-439" border=2/>
Method documentation in Cocoa
</center>
You might be thinking <em>"Hey, wait a minute, the cocoa documentation looks cleaner but where are the method parameters, return types and method description?" </em> The method parameters and return types aren't that important when you're looking for what will do the job.  If you need to know them you can click on the method to get more detailed information.  The method description is important and is displayed when you mouseover the method link.  By removing visual clutter the Cocoa documentation makes it easier to find what you need.
<center>
<img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/04/cocoamouseover.jpg" alt="" title="cocoamouseover" width="414" height="184" class="alignnone size-full wp-image-442" border=2/>
Displaying a method description with a mouseover
</center>

<h3>Super class methods</h3>

Super class methods are handled differently also.  In Cocoa, they simply aren't there. If you want to see the methods on the super class then you must navigate to the definition of the super class. In JavaDoc, however, there is a less than useful dump of all the methods of all the super classes in a highly unreadable form.  This can create a lot of visual garbage that you have to scroll over.

<center><img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/04/readable.jpg" alt="" title="readable" width="348" height="232" class="alignnone size-full wp-image-446" border=2 />
A summary of super class methods in JavaDoc</center>


<h3>Conclusion</h3>

The point here is a point that has been made in the past <a href="http://queue.acm.org/detail.cfm?id=1255422">"API Design Matters"</a>. Not only should it be well documented, but that documentation should be an easy to use reference.
