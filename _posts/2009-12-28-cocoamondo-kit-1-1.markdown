--- 
layout: post
title: CocoaMondo Kit 1.1
categories: 
- Mondo Kode
tags: []

status: publish
type: post
published: false
meta: 
  _edit_last: "1"
---
I looked high and low for a switch interface similar to the Time Machine switch.  The iPhone uses this style of interface all the time with the <a href="http://developer.apple.com/iphone/library/documentation/UIKit/Reference/UISwitch_Class/Reference/Reference.html">UISwitch</a>.  Since I couldn't find an implementation, I bit the bullet, created one and added it to <a href="http://mcormier.github.com/CocoaMondoKit/">CocoaMondo Kit 1.1</a>.

<center><img src="http://mcormier.github.com/CocoaMondoKit/images/switch.jpg"></center>

Please don't abuse this control and replace all your checkboxes with switches.  Use common sense.  A good guildine is to use a switch for a desktop application when the state of the switch has far reaching implications.  <strong>For example</strong>: <em>The switch disables or enables the core functionality of the application.</em>

<center>
<a href="http://mcormier.github.com/CocoaMondoKit/release/CocoaMondoKit_1.1.zip"  ><img src="http://mcormier.github.com/CocoaMondoKit/images/zip.png" border=0></a>
Cocoa Mondo Kit 1.1</center>

If switches are used sparingly then the user will hopefully pay closer attention when enabling or disabling them.

Kode on!
