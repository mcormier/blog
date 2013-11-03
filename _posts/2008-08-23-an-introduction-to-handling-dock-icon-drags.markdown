--- 
layout: post
title: An Introduction to Handling Dock Icon Drags
date:   2008-11-14 12:00:00
status: publish
type: post
published: true

---

One of the slickest touches you can add to a Mac application is handling dock drags.

To add dock icon drag support you need to register for the **open contents** event and register the file types your application supports (if it supports files).

### Registering for the open contents event

Register for the open contents event with a little kode and some entries in your info.plist file.  What you put in the info.plist file determines what type of data your application accepts.  Below is a plist entry that accepts string and URL data.

{% highlight xml %}
<key>NSServices</key>
<array>
  <dict>
    <key>NSPortName</key>
    <string>DockDrop</string>
    <key>NSSendTypes</key>
    <array>
      <string>NSStringPboardType</string>
      <string>NSURLPboardType</string>
    </array>
  </dict>
</array>
{% endhighlight %}

After the application launches, you register for the open contents event with the following kode.

{% highlight objc %}
- (void) applicationDidFinishLaunching:
  (NSNotification *) notification {

  [[NSAppleEventManager sharedAppleEventManager]
    setEventHandler: self
    andSelector: @selector(handleOpenContentsEvent:replyEvent:)
    forEventClass:kCoreEventClass andEventID:kAEOpenContents];
}

- (void) handleOpenContentsEvent:
  (NSAppleEventDescriptor *) event
  replyEvent: (NSAppleEventDescriptor *) replyEvent {

  // TODO -- handle event

  return;
}
{% endhighlight %}

### Registering for supported files

If you want to support file drags you have to add some more kode and some more groovy xml to the plist file.  In our sample application we will add some xml that states that we support all files and simply log the file names in the code.

{% highlight xml %}
<key>CFBundleDocumentTypes</key>
<array>
  <dict>
    <key>CFBundleTypeExtensions</key>
    <array>
      <string>*</string>
    </array>
    <key>CFBundleTypeName</key>
    <string>Plain Text File</string>
    <key>CFBundleTypeOSTypes</key>
    <array>
      <string>****</string>
    </array>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
  </dict>
</array>
{% endhighlight %}

{% highlight objc %}
- (id) init {
  if ((self = [super init])) {
    [NSApp setDelegate: self];
  }

  return self;
}

- (void) application: (NSApplication *) app
  openFiles: (NSArray *) filenames {
  NSLog(@"Received a request to open the following files... ");
  for( NSString* filename in filenames ) {
    NSLog(@"TODO, do somemthing with %@", filename);
  }
}
{% endhighlight %}

This supports dragging files onto the application icon when it is not running and outside of the dock. Responding to an action, such as dragging some data to the application when the application is not running but in the dock, is left as an exercise for the reader.

If you’re too lazy to set this up (and laziness is a common trait for excellent koders) <a href='http://173.203.83.44/cocoamondo/wp-content/uploads/2008/08/dockdrop.zip'>download this self-contained xCode project</a>.

Happy Koding,
