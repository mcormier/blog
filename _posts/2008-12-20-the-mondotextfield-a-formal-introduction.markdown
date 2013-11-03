--- 
layout: post
title: A Zoomable Text Field

---
 
## The Problem ##
 
One of the the UI quirks I noticed when developing [SunFlower][SunFlower] is that when trying to present an URL in an inspector panel it is most likely going to be truncated.  Inspector panels by their very nature are small.  They are used as an aid to a larger context and made small so that they don't obscure the main interface.  A full web site address (URL) on the other hand can be very long.  This makes editing a long url in an inspector panel a nuisance.

What does Apple do?  Let's take a look at how you edit an external link in iWeb.

 
<img title="iweb inspector panel" src="/notcocoa/images/iweb.png" />
 

In the case of iWeb, you must scroll through the text field with the left and right arrow keys. I find this very cumbersome.

This is not the only implementation I've found.  [Brent Simmons][Inessential] the original author of [NetNewsWire][NetNewsWire] (versions 1-3) chose a different approach.  He tackled this issue by using an NSTextView instead of an NSTextField.
 
<img title="NetNewsWire inspector panel" src="/notcocoa/images/netnewswire.png"  />

I prefer Brent's solution to Apple's, yet was not satisified with either solution. I wanted something clean and compact like Apple's solution but something that would allow the user to see the entire URL like Brent's solution.
 
## The Solution  ##

The solution I came up with is to take the concept of [Quick Look][QuickLook] and squish it into a text field; I'm calling it the MondoTextField.  It's not called a QuickLookTextField because you don't just look at the content. With the MondoTextField you look, possibly edit and then close the surrogate window.
 
<img src="/notcocoa/images/merged.jpg"  />

## Implementation Details ##
 
### Classes ###
To create this component we extend two UI classes (NSTextFieldCell, and NSTextField).  The custom text field cell constrains the width of the cell so that text never appears where the button may appear.  The custom text field manages the button visibility and sends messages to the controller if the button is pushed. There is also an animation class that manages the size of the window during a zoom in or zoom out.

<img src="/notcocoa/images/classes.png"  />

### Scaling ###
To achieve a look similar to Quick Look it is necessary to scale the window when the HUD window zooms in and out.  This means more than just making the frame of the window a different size. It requires scaling the window so that the window, and it's contained elements (title bar, text fields, ...) are all scaled.

## Design Decisions ##

It is important to note that the button appears just before the text field is completely filled.  When the button is not visible and text reaches the left of where the button will be, the button appears.  Although this decreases the available space for displaying text in some cases I felt it was a better solution then using the button area temporarily and then shifting the text over when the button needs to be displayed.  This was a conscious design decision.

Another issue I considered was how would users react with a button inside of a text field?  The short answer is, <em>Apple does it so it must be okay</em>. Seriously though, it appears to be a fairly standard practice to put buttons in text fields these days.  In the Safari address field there are sometimes even multiple buttons.  Below is an example of Safari with a "Snapback" button and a "RSS" feed button.

<img src="/notcocoa/images/safaributtons.jpg"  />

## Conclusion ##
 
I hope you find this component useful.  You can get the code by downloading it on [github][CocoaMondoKit].

[Sunflower]: http://sunflower.preenandprune.com
[Inessential]: http://inessential.com
[NetNewsWire]: http://en.wikipedia.org/wiki/NetNewsWire
[QuickLook]: http://en.wikipedia.org/wiki/Quick_Look
[CocoaMondoKit]: https://github.com/mcormier/CocoaMondoKit
