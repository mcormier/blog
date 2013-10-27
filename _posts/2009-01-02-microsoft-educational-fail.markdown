--- 
layout: post
title: Microsoft Educational FAIL
categories: 
- Rant
- User Interface
tags: []

status: trash
type: post
published: false
meta: 
  _edit_last: "1"
  _wp_trash_meta_status: publish
  _wp_trash_meta_time: "1381771168"
---
Although the primary topic for this blog is Macintosh development, user interface and experience are also becoming a main theme.  Therefore I thought it would be valuable to outline the technical issues I had viewing the Microsoft 2008 <a href="http://www.msteched.com">tech-ed</a> conference presentations.

Even if your focus is primarily as a Cocoa (insert other programming language here) developer, it's a good professional development strategy to get an overview of the technological offerings in other ponds.  You might take an idea or concept and apply it to what you're working on, or you might see what doesn't work well and avoid the same mistake.

I heard about a conference called Microsoft tech-days and planned on watching presentations on the Windows mobile technology for a day.  We all know the iPhone is the hot ticket item to kode for these days, but to get a sense of perspective, I thought it would be interesting to get an overview of Windows mobile.

Due to poor registration the live talk was canceled.  However, I did receive the conference swag bag in the mail.  It contained some obligatory evaluation software and a set of DVD's for the 2008 Microsoft tech-ed conference (Cocoa translation:tech-ed is roughly equivalent to the WWDC).

These discs sat around the house for a while and over the holidays I decided to start looking at them.  I yanked out my work laptop (not a Mac) running Vista with all the latest updates, and put the first disc in.  An HTML page (Default.htm) on the DVD automatically loaded up in my default browser, Chrome, so I opened the URL in Internet Explorer.  Viewing Microsoft web pages in a Microsoft web browser is generally advisable. ;)

<center>
<a href="http://173.203.83.44/cocoamondo/wp-content/uploads/2008/12/default.jpg"><img class="aligncenter size-medium wp-image-234" title="Tech-ed cover page" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/default-300x225.jpg" alt="" width="300" height="225" /></a>
 </center>

This is where things got interesting.  I clicked on the "view sessions" button and I was prompted to install Silverlight.  I was pretty sure I had the latest version installed because I always install the latest updates on this machine, but I clicked on the install Silverlight button anyway and got the following page.

<center>
<a href="http://173.203.83.44/cocoamondo/wp-content/uploads/2008/12/silverlight.jpg"><img class="aligncenter size-medium wp-image-239" title="silverlight" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/12/silverlight-300x225.jpg" alt="" width="300" height="225" /></a>
</center> 

The page states, <em>"The site that you visited was built for an earlier, beta version of Silverlight - not the current one"</em>.  So I have the latest Silverlight (version 2) but I can't view the page because the page burnt onto the DVD specifies version 2 beta 2.
<div class="note"><a href="http://en.wikipedia.org/wiki/Microsoft_Silverlight#Silverlight_2"><strong>Silverlight</strong></a> is basically Microsoft's competitive offering to Adobe flash and dynamic AJAXy web pages.</div>

No problem, I'll manually browse the disk; the Silverlight page is just an index of all the sessions.

<center><img class="size-full wp-image-254" title="directories" src="http://173.203.83.44/cocoamondo/wp-content/uploads/2009/01/directories.jpg" border="2" alt="" width="228" height="190" />
 </center>

Of course every directory is three characters long, except PPTX, it gets an extra character, so more digging is required.   Looking in the ARC folder there are a bunch of other ARC folders with number codes appended to the name (ARC201, ARC202,...).  Inside each of these directories is a slides directory with a bunch of jpeg files (Slide1.jpg, Slide2.jpg,...).  The second slide contains the title of the talk.  Finally, I know the title of a talk, and I know that ARC probably stands for Architecture.  This is a little thing, but big things can be the summation of the little things like this.

I looked at the HTML code and ancillary files until my curiosity was satisfied,(eventually I determined that WIT=Women in Technology, KEY=Keynote, MBL=Mobile.) then I started doing web searches about the issue I was having with Silverlight not displaying the page.

A blog posting by Tim Heuer entitled <a href="http://timheuer.com/blog/archive/2008/10/31/teched-north-america-dvd-silverlight-update.aspx">TechEd 2008 North America DVD Update</a> explains that yes, it was a big goof.

<em>"In hindsight, choosing to burn a copy of a Beta 2 application to a distributable disc was not a good idea.  We admit that and apologize.  Hopefully you can see that the content is the king here and that is not lost or unusable.  Thanks for your patience while we created the content map based on your feedback!"</em> -- Tim Heuer

The blog posting also provides a <a href="http://s3.amazonaws.com/timheuer-img/techeddvdmap.pdf">downloadable PDF</a> with an index for all the sessions. This document also explains that you need to click on the WMS (Windows Media Skin) file to watch the talk.  The WMS file uses javascript with begin and end times for each slide and plays a WMV audio file synchronously.
<h2>Conclusion</h2>
Let's take a look at my entire educational experience:
<ul>
	<li>The live talk was canceled.</li>
	<li>The DVD didn't work properly because it was hard coded for Silverlight beta 2.</li>
	<li>Unreadable three character directory names.</li>
	<li>I had to do research to figure out the best way to view the sessions and get an index of the sessions.</li>
</ul>
So far I've spent more time tinkering with files and web pages in order to view the tech-ed conference than viewing the DVD material.  Something that should be drop dead simple, putting a bunch of video files on a DVD for developers to view, became an ordeal.  Creating WMV files with the jpeg slides as the video track would have been much simpler. One file with a video and audio track for each talk.

<center>
<a href="http://173.203.83.44/cocoamondo/wp-content/uploads/2009/01/player.jpg"><img class="alignnone size-medium wp-image-265" title="player" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/01/player-300x225.jpg" alt="" width="300" height="225" /></a></center>

Instead Microsoft decided to use a WMS file to create a custom video player; with chapters created by using a javascript file and a bunch of jpeg files.  Having chapters is a good idea, unfortunately the ability to watch the talk in full screen mode was sacrificed (another one of those little things).

I can confidently say that Microsoft does not have their act together, and will not anytime soon.  But some of these talks do look interesting.  So thanks for the <a href="http://en.wikipedia.org/wiki/So_Long,_and_Thanks_for_All_the_Fish"><del>fish</del></a> free DVD's.

So far I've enjoyed <a href="http://www.linkedin.com/in/mihak">Miha Kralj</a>'s talk on architecture entitled <a href="http://msevents.microsoft.com/CUI/WebCastEventDetails.aspx?EventID=1032382336&amp;EventCategory=3&amp;culture=en-US&amp;CountryCode=US">"Architectures: The Good, the Bad and the Ugly"</a>. In it he discusses many anti-patterns and lets the ugly out of the bag on Sharepoint; apparently it uses stored procedures instead of foreign key constraints for referential integrity.
