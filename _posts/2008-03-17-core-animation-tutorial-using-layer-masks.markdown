--- 
layout: post
title: "Core Animation: Using Layer Masks"
categories: 
- Core Animation
tags: 
- Core Animation
status: trash
type: post
published: false
meta: 
  _edit_last: "1"
  _wp_trash_meta_status: publish
  _wp_trash_meta_time: "1381771023"
  _wp_trash_meta_comments_status: a:2:{i:2;s:1:"1";i:3;s:1:"1";}
---
Using a mask on a core animation layer is quite easy.  This example does the following:

<ul>
  <li>Creates an NSImage by filling an NSBezierPath.</li>
  <li>Converts the NSImage into a CGImageRef </li>
  <li>Creates three CALayers
 <ul>
     	<li>one to show what the mask looks like</li>
        <li>one for the layer that will have</li>
	<li>one for our our mask</li>
 </ul>
 </li>

</ul>


Voila!

<img src="http://173.203.83.44/cocoamondo/wp-content/uploads/2008/04/calayermask.png" alt="A Core Animation Mask" title="calayermask" width="406" height="319" class="aligncenter size-full wp-image-5" border="2" />

You can <a href='http://173.203.83.44/cocoamondo/wp-content/uploads/2008/04/calayermask.zip'>grab the kode here.</a>
