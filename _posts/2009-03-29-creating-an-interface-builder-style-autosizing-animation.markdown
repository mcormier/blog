--- 
layout: post
title: Creating an Interface Builder Style Autosizing Animation
categories: 
- Core Animation
- Mondo Kode
tags: []

status: trash
type: post
published: false
meta: 
  _edit_last: "1"
  enclosure: |
    http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/03/attempt1.mp4
    81762
    video/mp4

  _wp_trash_meta_status: publish
  _wp_trash_meta_time: "1381772043"
---
Configuring view autosizing in Apple's Interface Builder is greatly aided by an animated view that shows how the currently selected element will resize with respect to it's parent. In the yet to be released version of <a href="http://sunflower.preenandprune.com">SunFlower</a> I am planning on using a similar animation to make the anchor corner property of exclusion filters more intuitive. This article is about copying that Interface Builder UI element.

<center>
<img class="alignnone  wp-image-365" style="border: 2px solid black;" title="ibinterface" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/03/ibinterface.png" alt="" border="2" /></center>
<h2>Attempt 1</h2>
My first attempt was unsuccessful. I attempted to use two layers and constraints. When I automated the bounds of the parent layer the sublayer only moved on the Y axis and did not move on the X axis.

<center>
<object width="352" height="308" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"><param name="src" value="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/03/attempt1.mp4" /><param name="autoplay" value="false" /><embed width="352" height="308" type="application/x-shockwave-flash" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/03/attempt1.mp4" autoplay="false" /></object></center>Download the <a href="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/06/IB_AnimationEmulateFAIL.zip">kode</a>.
<h2>Attempt 2</h2>
After must chagrin I solved the problem. Instead of using two layers and constraints the kode was changed to use one layer. The resizing white rectangle is still a core animation layer but the red square was is now image content. The red square is anchored to the corner using the contentsgravity property.

<center>
<object width="352" height="308" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"><param name="src" value="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/03/attempt2.mp4" /><param name="autoplay" value="false" /><embed width="352" height="308" type="application/x-shockwave-flash" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/03/attempt2.mp4" autoplay="false" /></object></center>Download the <a href="http://173.203.83.44/cocoamondo/wp-content/uploads/2009/06/IB_AnimationEmulate.zip">kode</a>. <em>(If you click on the view the red square will cycle the corner it is anchored to.)</em>

I am still curious to know if it is possible to solve this problem with the two layer constraint method; if you know how, then please drop me a line.
