--- 
layout: post
title: The Ripple Effect
categories: 
- Mondo Kode
- User Interface
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
Software by it's very nature, tends towards complexity.

When a program is in it's infancy, with few features and few lines of code, adding a new feature can usually be done quickly.  As the program evolves adding a new feature may still be quick and easy but it may cause side effects in other parts of a program.  So adding the new feature may not take long but adjusting the rest of the program so that everything flows properly will take time.

Think of stable software as a calm pond, with a surface smooth as glass and adding a feature is like throwing a pebble in that pond, which causes ripples that need to be dealt with. One of the things that distinguishes a junior from a senior programmer is that the junior programmer will not foresee these ripples and will think he has completed his task prematurely.

To illustrate what I'm talking about I'm going to talk about a new feature that will be in the next <a href="http://sunflower.preenandprune.com">SunFlower</a> release.

<h3>The Problem</h3>

Snapshots in SunFlower can pile up, and eventually you need to delete some.  To delete a snapshot you must control-click on the snapshot and choose delete.
<center><img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/07/rightClick.png" alt="rightClick" title="rightClick" width="243" height="176" class="alignnone size-full wp-image-588" /></center>

This interface works but is kludgey.  It's not convenient when you need to delete many snapshots because control-clicking on each snapshot is slow and cumbersome.  There is definitely room for improvement in this interface.

<h3>The Solution</h3>

The solution is simple. Add a delete button that appears when the user positions the mouse over the snapshot.  This is an established interface, it's how Safari deals with the close buttons for tabs without making the interface feel cluttered.

<center>
<img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/07/mouseOver.png" alt="mouseOver" title="mouseOver" width="461" height="182" class="alignnone size-full wp-image-599" />
</center>

<h3>The Ripples</h3>

So what were some of the ripples caused by adding the delete button?

Because the user can navigate the snapshots with the keyboard, we need to detect if the mouse is over a snapshot after keyboard events.  We cannot simply use mouse move events to detect if the delete button should be shown.  <em><strong>((Ripple.))</strong></em>

In this case most of the ripples were design based.  Snapshots have a state of being "read" or "unread",  and an image is displayed on the top right corner when the snapshot is brand new.

<center><img src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2009/07/ripples.png" alt="ripples" title="ripples" width="236" height="173" class="alignnone size-full wp-image-601" /></center>

Having two images represent different things with varying red colours is not good.  So the unread marker image now needs to be changed. <em><strong>((Ripple.))</strong></em>  I could change the colour of the unread image to green but I'd prefer that both images weren't the same shape to prevent confusion.  <em><strong>((Ripple.))</strong></em>  The delete button has nice shading and puts the unread marker image to shame so the ante has been upped.  <em><strong>((Ripple.))</strong></em>

<h3>Addendum (Aug 03 2009)</h3>
Brent Simmons describes this concept in <a href="http://inessential.com/2009/07/30/anatomy_of_a_feature">more detail in a recent blog posting.</a>

<blockquote>It’s not enough just to write the basic functionality and add a menu item that runs it. Even a feature as simple as this one requires some up-front thinking, some design.</blockquote>
...
<blockquote>The code behind the feedback window is, again, bigger than the http-call code. (By now you’ve gotten the idea that the core functionality of a feature is often the very smallest part.)</blockquote>
