--- 
layout: post
title: Zathras.framework

---
Recently I started using some <a href="http://www.zathras.de/angelweb/sourcecode.htm">code (UKKQueue)</a> that <a href="http://www.zathras.de/angelweb/blog.htm">Uli Kusterer</a> published as open source.  Instead of just including the source files in my software I decided to wrap it in a framework.

One of the advantages of taking someone else's code and wrapping it in a framework in this manner is that it makes you stop and take the time to examine the code.  It's great that you have code that you didn't write and you haven't succumbed to the "not invented here" phenomena, but you're still using this code in your application.  You should do your homework and examine what it is your plugging into.

Uli's code is solid and many people have already hammered at it.  But sometimes it's good to make trivial changes to get that feeling of ownership.  For instance:  Some people like the { on the line after the function implementation, and some people like the { an the same line as the function implementation.  This is a trivial coding style difference; but if while you are reading the source code you change it to your preferred style you will gain a sense of ownership.  Or maybe this isn't true at all and I'm trying to justify the fact that I do this when reading code that I'm including in my project.

Here is a more concrete example of something I changed.  In the file UKFileWatcher.h Uli uses a category to define the protocol UKFileWatcherDelegate.  There is nothing wrong with this.  In fact, it is the standard by which Objective-C libraries are written.  This is the way Apple defines delegate protocols in their API.

{% highlight objc %}
@protocol UKFileWatcher
// Singleton accessor. Not officially part of the protocol, but 
// use this name if you provide a singleton.
// +(id) sharedFileWatcher;			

-(void) addPath: (NSString*)path;
-(void) removePath: (NSString*)path;

-(id)   delegate;
-(void) setDelegate: (id)newDelegate;

@end

// -----------------------------------------------------------------------------
//  Methods delegates need to provide:
// -----------------------------------------------------------------------------

@interface NSObject (UKFileWatcherDelegate)

-(void) watcher: (id<ukfileWatcher>)kq receivedNotification: (NSString*)nm 
forPath: (NSString*)fpath;

@end
{% endhighlight %}

Personally, I prefer formal protocols  So I changed the code to use a formal protocol.  At the end of the day, the code is functionally equivalent, but I twiddled with the knobs while I read the code.

{% highlight objc %}
@protocol UKFileWatcher

-(void) addPath: (NSString*)path;
-(void) removePath: (NSString*)path;

-(id)   delegate;
-(void) setDelegate: (id<ukfileWatcherDelegate>)newDelegate;

@end

// -----------------------------------------------------------------------------
//  Methods delegates need to provide:
// -----------------------------------------------------------------------------
@protocol UKFileWatcherDelegate
-(void) watcher: (id<ukfileWatcher>)kq receivedNotification: (NSString*)nm 
forPath: (NSString*)fpath;

@end

{% endhighlight %}

So I've created <a href="http://github.com/mcormier/ZathrasFramework">Zathras.framework</a>. In the future, I plan to wrap any other code by Uli that I use into this framework.

Code on.
