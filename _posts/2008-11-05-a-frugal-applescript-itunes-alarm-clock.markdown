--- 
layout: oneColumnPost
title: A Frugal Applescript iTunes Alarm Clock
categories: 
tags: 
type: post

---

Financially these appear to be turbulent times.  Okay that's an understatement.   It's time to cut spending and quit slacking off, so maybe you should start setting your alarm clock instead of rolling into work at noon. What‽‽‽ You don't have an alarm clock‽‽  We'll don't go out and buy one because that would break your new cut the spending rule.  You're a rough and tough Mac koder so why don't you make one yourself?

1. Create an iTunes playlist called "Wake Up".  Put whatever music you want to wake up to in this playlist.  I recommend Shellac; in particular the <a href="http://petdance.com/actionpark/shellac/discography/futurist/">Futurist</a> LP.
2. Write some applescript.
3. Call the applescript from a cron.

### The Applescript

In your favourite editor create a file called iTunesAlarm.osascript and give it the following contents.

{% highlight applescript %}
#!/usr/bin/osascript

tell application "iTunes"
	play playlist "Wake Up"
end tell
{% endhighlight %}

You can test that the script works by running it from the a terminal window.

### The cron entry

Now add a cron entry in your crontab, using the <strong>crontab -e</strong> command.  I like to put comments in the crontab so I have to do less thinking in the future.

{% highlight sh %}
# minute      hour     day     month     day_of_week
# 0-59        0-23    1-31    1-12    0-6 (sunday = 0)
#
# Run itunes Alarm Monday-Friday at 6:30 AM
30 6 * * 1-5 /Users/mcormier/cron/iTunesAlarm.osascript
{% endhighlight %}

That's it.  You're done.

If this is too complicated or you feel the need to spend money then you can always try <a href="http://www.embraceware.com/software/awaken/">Awaken.
</a>

