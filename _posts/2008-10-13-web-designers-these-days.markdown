--- 
layout: post
title: Web Designers These Days...
categories: 
- Rant
tags: []

status: trash
type: post
published: false
meta: 
  _edit_last: "1"
  _wp_trash_meta_status: publish
  _wp_trash_meta_time: "1381771085"
---
Repeat after me.  Keep things simple. Don't over complicate things.  This post is about quirky web design, it is not Mac specific (except for the fact that I am using Mac Safari to do all the testing); you can safely skip this post if you're only interested in pure Mac content.

One of the sites I monitor with <a href="http://sunflower.preenandprune.com/">SunFlower</a> is an IT company called <a href="http://www.coemergence.com/index.php">coemergence</a>.  They updated their site recently, and ever since then the rendering of the image below started causing false positives.

<img class="aligncenter size-medium wp-image-71" title="cobanner_665x218" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2008/10/cobanner_665x218-300x98.jpg" alt="" width="300" height="98" />

The false positives occurred because the image would be rendered at slightly different sizes.  The reason for this stems from the javascript code below; in particular the use of <strong>document.body.clientWidth</strong>.

<pre lang="html4strict" >
var coe_image_width = 665;
var coe_image_height = 218;
var coe_width = document.body.clientWidth;
var coe_left = coe_width - (coe_width * 0.8);
var coe_center = (coe_width - coe_left) * 0.8;
var coe_multiplier = coe_center / coe_image_width;
document.write("<img src='/images/stories/coemergence/cobanner_665x218.jpg' " +
"width='" + ((coe_image_width * coe_multiplier) * 0.82) + "' " +
"height='" + ((coe_image_height * coe_multiplier) * 0.82)  + "' " +
"align='center'/>");
</pre>

<h3>What mistakes did the author make? </h3>

For one, <strong>document.body.client</strong> has no relation to the actual width of the webview, it is the size of the view port.  If you squeeze this page to about 300px wide and do a refresh you will get a small image. If you then resize the window the image stays small, which is probably not the effect the author is looking for. We'll look the other way and pretend the page doesn't look icky when you resize it.

The designer also made the assumption that the page is fully rendered and that the last thing that will be rendered will always be this image where the height and width are being calculated dynamically.

<h3>Want to see that the result is inconsistent?</h3>
<ol>
	<li>Load <a href="http://www.coemergence.com/index.php">http://www.coemergence.com/index.php</a> in a new Safari  window</li>
	<li>Choose Develop -&gt; Show Web Inspector</li>
	<li>Switch to the DOM tree view</li>
	<li>Find the calculated height and width of the image</li>
	<li>Close the window</li>
	<li>Open a new Safari window (which will be the same size as the previous)</li>
	<li>Repeat steps 1 to 6 and compare the results</li>
</ol>
I did the steps above and I got the following different results.

<h3>Result 1</h3>
<img src="http://173.203.83.44/cocoamondo/wp-content/uploads/2008/10/test1.png" alt="" title="test1" width="484" height="126" class="aligncenter size-full wp-image-80" />
<h3>Result 2</h3>
<img src="http://173.203.83.44/cocoamondo/wp-content/uploads/2008/10/test2.png" alt="" title="test2" width="422" height="111" class="aligncenter size-full wp-image-81" />

I'm not sure the exact reason that the sizes are different, and I don't plan on spending any time checking, however I have two hypotheses.
<ol>
	<li>When windows/views are created in Mac OS X the size is not exact.  You could get a width of 799.99999 when you requested 800 (very doubtful) </li>
	<li>The size of the variable depends on the order that elements are rendered on the page, and stylesheet elements are applied, and that order is not guaranteed.</li>
</ol>

There are many other design quirks with the page, like the fact that there is no minimum width and if you make the page narrow the search field and text resize buttons hide behind a current.

<h3>Conclusion</h3>

The calculated width and height are only slightly different and I only noticed it because I am using <a href="http://sunflower.preenandprune.com/">SunFlower</a> to monitor the page.  But that doesn't excuse the author for making things over-complicated.

Choose a layout and stick to it.  Making the width of your page a certain size and using white space is a tried and true method of web design. Don't get all fancy pants when you could just do something simple.

Unfortunately, for this page, using an exclusion filter in <a href="http://sunflower.preenandprune.com/">SunFlower</a> does not eliminate false positives because even though we can ignore the image, when the height of the image is different, it pushes the content text up or down.

Kode on!
