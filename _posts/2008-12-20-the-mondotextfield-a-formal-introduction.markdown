--- 
layout: post
title: The MondoTextField, a Formal Introduction
categories: 
- Mondo Kode
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
  enclosure: |-
    http://blip.tv/file/get/Mcormier-MondoTextFieldDemo201.m4v
    1057165
    video/mp4
---
 

<hr />
<h2>The Problem</h2>
 
One of the the UI quirks I noticed when developing <a href="http://sunflower.preenandprune.com">SunFlower</a> is that when trying to present an URL in an inspector panel it is most likely going to be truncated.  Inspector panels by their very nature are small.  They are used as an aid to a larger context and made small so that they don't obscure the main interface.  A full web site address (URL) on the other hand can be very long.  This makes editing a long url in an inspector panel a nuisance.

 

What does Apple do?  Let's take a look at how you edit an external link in iWeb.

 
<img class="aligncenter size-full wp-image-143" title="iweb inspector panel" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/iweb.png" alt="" width="230" height="261" />
 

In the case of iWeb, you must scroll through the text field with the left and right arrow keys. I find this very cumbersome.

This is not the only implementation I've found.  <a href="http://inessential.com/">Brent Simmons</a> of <a href="http://www.newsgator.com/INDIVIDUALS/NETNEWSWIRE/">NetNewsWire</a> fame chose a different approach.  He tackled this issue by using an NSTextView instead of an NSTextField.

 
<img class="aligncenter size-full wp-image-146" title="NetNewsWire inspector panel" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/netnewswire.png" alt="" width="265" height="417" />
 

I prefer Brent's solution to Apple's and that is what has been used in <a href="http://sunflower.preenandprune.com">SunFlower</a> to date. However, in the yet to be released version of <a href="http://sunflower.preenandprune.com">SunFlower</a> I rebuilt the inspector panel to use tabs because I'm doing some redesigning.  So I reconsidered whether I wanted to use an NSTextView and decided I wanted to prototype an interface that I had been pondering.

I wanted something clean and compact like Apple's solution but something that would allow the user to see the entire URL like Brent's solution.

 

<hr />
<h2>The Solution</h2>
 

 

The solution I came up with is to take the concept of <a href="http://www.apple.com/macosx/features/quicklook.html">Quick Look</a> and squish it into a text field; I'm calling it the MondoTextField.  It's not called a QuickLookTextField because you don't just look at the content. With the MondoTextField you look, possibly edit and then close the surrogate window.

<script src="http://www.apple.com/library/quicktime/scripts/ac_quicktime.js" type="text/javascript"></script> <script src="http://www.apple.com/library/quicktime/scripts/qtp_library.js" type="text/javascript"></script>

 
<script type="text/javascript"><!--
	QT_WritePoster_XHTML('Click to Play', 'http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/mondotextfieldvideo-poster.jpg',
		'http://blip.tv/file/get/Mcormier-MondoTextFieldDemo201.m4v',
		'406', '496', '',
		'controller', 'true',
		'autoplay', 'true',
		'bgcolor', 'black',
		'scale', 'aspect');
// --></script>
<noscript>
<object classid="clsid:02bf25d5-8c17-4b23-bc80-d3488abddc6b" width="406" height="496" codebase="http://www.apple.com/qtactivex/qtplugin.cab#version=6,0,2,0"><param name="id" value="movie1" /><param name="src" value="http://blip.tv/file/get/Mcormier-MondoTextFieldDemo201.m4v" /><param name="controller" value="true" /><param name="autoplay" value="false" /><param name="enablejavascript" value="true" /><param name="bgcolor" value="#fff" /><embed id="movie1" type="video/quicktime" width="406" height="496" src="http://blip.tv/file/get/Mcormier-MondoTextFieldDemo201.m4v" bgcolor="#fff" enablejavascript="true" autoplay="false" controller="true"></embed></object>
</noscript>
 

 

<hr />
<h2>Implementation Details</h2>
 

 
<h2>Classes</h2>
To create this component we extend two UI classes (NSTextFieldCell, and NSTextField).  The custom text field cell constrains the width of the cell so that text never appears where the button may appear.  The custom text field manages the button visibility and sends messages to the controller if the button is pushed. There is also an animation class that manages the size of the window during a zoom in or zoom out.

<img class="aligncenter size-full wp-image-176" title="classes" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/classes.png" alt="" />
<h2>Scaling</h2>
To achieve a look similar to Quick Look it is necessary to scale the window when the HUD window zooms in and out.  This means more than just making the frame of the window a different size. It requires scaling the window so that the window, and it's contained elements (title bar, text fields, ...) are all scaled.

 
<img class="aligncenter size-full wp-image-185" title="Scaling Merged" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/merged.jpg" alt="" width="430" height="508" /> 

<style>
.note {
background-color: #F3F6F0;
line-height: 1.3em;
color: #060606;
padding-right: 8px;
padding-bottom: 5px;
padding-left: 8px;
padding-top: 3px;
border-top-width: 1px;
border-bottom-width: 1px;
border-right-width: 1px;
border-left-width: 1px;
border-style: solid;
border-color: #C0C3CF;
margin-left: 1em;
margin-right: 5em;
}

</style>

<del datetime="2009-01-11T23:48:14+00:00">
<h2>Undocumented API's</h2>
</del>

 
<div class="note"><strong>Update - Jan 11th 2009</strong>
MondoTextField has been modified so that it does not use any undocumented API calls by using <a href="http://www.noodlesoft.com/blog/2007/06/30/animation-in-the-time-of-tiger-part-1/">kode</a> published by Paul Kim.</div>
<del datetime="2009-01-11T23:49:09+00:00">
Although the scaling animation seems like a job for core animation, it is not possible to scale a window with core animation.  To do this we need to use undocumented API's.</del>
<pre lang="c">extern OSStatus
CGSGetWindowTransform(const CGSConnection,
                         CGSWindow wid,
                         CGAffineTransform *outTransform);

extern OSStatus
CGSSetWindowTransform(const CGSConnection cid,
                         CGSWindow wid,
                         CGAffineTransform transform);</pre>
<del datetime="2009-01-11T23:49:09+00:00">
For more information on these undocumented API's take a look at the sample project that <a href="http://lipidity.com/apple/core-graphics-meet-core-image-demo-app/">lipidity.com</a> released over two years ago.
</del>
<div class="note"><del datetime="2009-01-11T23:49:09+00:00">
<strong>A note about undocumented API's.</strong> 

Apple obviously does not recommend that you use undocumented API's. They recommend that you make a feature request, and wait for the API call to become officially available (which could be never).  I do not encourage the use of undocumented API's and am only using it in this case because I feel the benefits of using it far outweigh the risk and maintenance of future changes.

</del></div>
<del datetime="2009-01-11T23:50:14+00:00">
There is nothing stopping you from using the API's once they are discovered, however your application could break with even a minor release of the operating system.  These particular API's have been available and undocumented since 10.4 (I believe) and I doubt that will change anytime soon as  Apple appears to be too busy working on the iPhone version of Mac OS X.
<del datetime="2009-01-11T23:51:09+00:00">
If you decide to use the MondoTextField in your application then you should understand that there is some risk associated with using it.</del>
</del>

 

<hr />
<h2>Design Decisions</h2>
 

 

It is important to note that the button appears just before the text field is completely filled.  When the button is not visible and text reaches the left of where the button will be, the button appears.  Although this decreases the available space for displaying text in some cases I felt it was a better solution then using the button area temporarily and then shifting the text over when the button needs to be displayed.  This was a conscious design decision.

Another issue I considered was how would users react with a button inside of a text field?  The short answer is, <em>Apple does it so it must be okay</em>. Seriously though, it appears to be a fairly standard practice to put buttons in text fields these days.  In the Safari address field there are sometimes even multiple buttons.  Below is an example of Safari with a "Snapback" button and a "RSS" feed button.

 
<a href="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/safaributtons.jpg"><img class="alignnone size-medium wp-image-205" title="safari text field buttons" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/safaributtons-300x90.jpg" alt="" width="300" height="90" /></a>
 

 

<hr />
<h2>Conclusion</h2>
 
I hope you find this component useful and am interested in any feedback as I am planning on adding it to the next version of <a href="http://sunflower.preenandprune.com">SunFlower</a>.

 

You can get the code by downloading <a href="http://www.preenandprune.comcocoamondo/wp-content/uploads/2009/01/mondotextfieldv2.zip">this self-contained xCode project</a>, or you can access it through <a href="http://github.com/mcormier/mondotextfield/tree/master">github</a>.

Kode on!
