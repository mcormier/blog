--- 
layout: post
title: A Frugal Applescript iTunes Alarm Clock
categories: 
- Applescript
- Mondo Kode
tags: 
- Applescript
status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
Financially these appear to be turbulent times.  Okay that's an understatement.   It's time to cut spending and quit slacking off, so maybe you should start setting your alarm clock instead of rolling into work at noon. What‽‽‽ You don't have an alarm clock‽‽  We'll don't go out and buy one because that would break your new cut the spending rule.  You're a rough and tough Mac koder so why don't you make one yourself?
<ol>
	<li>Create an iTunes playlist called "Wake Up".  Put whatever music you want to wake up to in this playlist.  I recommend Shellac; in particular the <a href="http://petdance.com/actionpark/shellac/discography/futurist/">Futurist</a> LP.</li>
	<li>Write some applescript.</li>
	<li>Call the applescript from a cron.</li>
</ol>

<h3>The Applescript</h3>

In your favourite editor create a file called iTunesAlarm.osascript and give it the following contents.

<pre lang="applescript">
#!/usr/bin/osascript

tell application "iTunes"
	play playlist "Wake Up"
end tell
</pre>

You can test that the script works by running it from the a terminal window.

<h3>The cron entry</h3>

Now add a cron entry in your crontab, using the <strong>crontab -e</strong> command.  I like to put comments in the crontab so I have to do less thinking in the future.

<pre lang="bash">
# minute      hour     day     month     day_of_week
# 0-59        0-23    1-31    1-12    0-6 (sunday = 0)
#
# Run itunes Alarm Monday-Friday at 6:30 AM
30 6 * * 1-5 /Users/mcormier/cron/iTunesAlarm.osascript
</pre>

That's it.  You're done.

If this is too complicated or you feel the need to spend money then you can always try <a href="http://www.embraceware.com/software/awaken/">Awaken.
</a>

Kode on!
