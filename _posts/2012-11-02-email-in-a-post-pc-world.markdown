--- 
layout: post
title: Email in a post-PC world
categories: 
- Rant
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
Like many people I have a Gmail account and have been using it for about 8 years now.  Gmail was introduced in April of 2004 <a href="#ref1"><sup>[1]</sup></a> as a free email service and it was big deal at the time.  Originally available by invitation only,Gmail  invites were briefly a commodity with people trying to sell them on message boards until Google allowed anyone to sign up.  When it first debuted, Gmail gave users 1 Gig of storage for free and has since increased storage to 10 Gig.  Google have even announced that they will continue to increase storage.  Basically, your email is data, and Google like's to mine data.
<h2>Google Adds IMAP Support</h2>
In 2007 Gmail became accessible by IMAP and I have been accessing my Gmail account through IMAP ever since. It's important to note that Gmail is not an IMAP server.  Google is storing the data in some proprietary format and has made it accessible through an IMAP protocol.  You can also retrieve your mail with POP3 and Exchange ActiveSync.  This type of data abstraction means that if some new fangled mail protocol (SPDY for email?<a href="#ref9"><sup>[9]</sup></a>) were to appear in the future Google could easily support it.  Google could potentially be already doing this or planning to do this in their ChromeOS. 

IMAP allows you to read your email in a third party email client which can be more enjoyable than the web interface since it avoids the prevalent advertising. It also allows you to copy your email to a local mailbox so that you can have a copy of your data. So once IMAP support was added in 2007 I started reading my mail in Mail.app and making a backup copy of my messages. If I was away from home (at a friends house) I could check my inbox with any web browser. 

Even with the large storage space available in Gmail I like to have a copy of my data.  It doesn't take a lot of storage to store email messages and having an active internet connection seems an unnecessary constraint for searching through past messages. Besides, even though Google currently give us email for free and obviously plan to do so in the long-term this could change eventually. So once I have dealt with or read an email I copy it to a local mailbox.  2007 looks like the diagram below.



<center><img class="size-full wp-image-1186" title="pcWorld" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2012/10/pcWorld.gif" alt="" width="155" height="347" />
2007
</center>



This worked for many years but has become less convenient in today's post-PC era because my desktop is no longer the main place I read my mail.  In fact, I rarely read mail from desktop for the first time anymore.  I generally read my mail on a mobile device now and if I'm at work I tend to read my mail with pine.  Since I rarely use my desktop these days, my inbox piles up with read messages until I get to my desktop to file away these messages.  What used to be a natural process of archiving email is now a chore.  This is a great problem to have because it means that I am no longer getting sucked into the time sink that desktops can be during my leisure time.

So my current setup looks something like this:

<center><img class="size-full wp-image-1196" title="postPcWorld" src="http://www.preenandprune.com/cocoamondo/wp-content/uploads/2012/10/postPcWorld.gif" alt="" width="641" height="480" />
2012
</center>

Things have gotten a little more complicated.  In 2007 I had one main device that I used for viewing my mail and archiving it and used the web interface occasionally   In 2012 I have three auxiliary devices for viewing my mail and one application that is used for archiving and rarely viewing mail.  Obviously, I wouldn't trade the mobility and convenience of checking my mail from anywhere  for the simpler configuration in 2007. I still want to have a local archive and I don't want it to be a chore any longer.  It is tempting to simply stop storing things locally and store everything on Google's servers. I'm not anti-cloud, however, I am cautious about depending 100% on a free service that I could potentially lose access to at any time.  Storage is cheap and I have a neglected desktop that is happy to have it's bits put to use.  It would be foolish not to use that desktop to have an extra backup of my mail, especially if I can automate the process.
<h2>IMAP flags</h2>
The final solution I settled on is quite simple and does not involve IMAP flags.  If you are only interested in the final solution then skip this section as it is a journey down a rabbit hole; albeit an interesting one.

The first idea I had for automating the backup process was to use a message flag to signal to Mail.app to move a message from the inbox to the local archive folder.  Although this solution is technically possible, it does not work with Mail.app because rules are only applied when a new message is received.  Even if filtering based on a flag was supported, and it isn't, nothing would be archived until a new message is received.

Knowing this I still decided to look into how IMAP flags work since I could theoretically write a program that monitored the Inbox.  This program would detect when a message was flagged and immediately archive it on my desktop and then remove it from the inbox.  Mail.app supports seven different color flags so theoretically different color flags could be used to move a message to a specific folder (i.e. work, receipts, general archive).

I had never flagged a message with an iOS device and was surprised to discover that flag support was only added in iOS 5 <a href="#ref10"><sup>[10]</sup></a>.  iOS devices also don't have support for the seven different color variations in Mail.app, at least with a Gmail account. I don't use iCloud @me.com but apparently iOS devices support color flags with iCloud<a href="#ref11"><sup>[11]</sup></a>.  Another interesting thing I found was that if I flagged a message on one software client the flag does not immediately show up when viewing mail in another client if that client was already running.  This is not an isolated issue, all clients appear to behave this way.

<strong>Simple Flag Test</strong>: Have Mail.app running on your desktop and pointed to the inbox. Flag a message in your inbox with iOS mail and then view the message in Mail.app.  The flag will not appear in the inbox even if you issue a get new mail command in Mail.app.  The message will appear in Mail.app's new "flagged" folder (Mountain Lion) as flagged, but if you switch back to the inbox folder the message will not appear as flagged.

Although this seems like a simple user interface bug it is not easily fixed. There is no notification for meta-data changes in the IMAP protocol<a href="#ref2"><sup>[2]</sup></a> so for the client to detect a flag change it would have to request the flag meta-data on all the messages in the inbox again.   This issue can be fixed by creating an inefficient chatty client that requests all the message meta-data every time you view a mailbox, a solution that gets progressively worse with the number of messages in the mailbox.  There is also an IMAP NOTIFY extension <a href="#ref3"><sup>[3]</sup></a> that was proposed three years ago but Gmail does not currently support this IMAP extension.  Viewing the "flagged" folder works because the client is sending a SEARCH request to the server, "Give me a list of all flagged messages", and displaying that to the user.

This same test can be done with any combination of clients and you will receive similar results.  When an application is restarted it does a full sync and checks all the meta data on the inbox but once it has connected it makes the assumption that no meta-data has changed. I performed a combination of tests with Pine, iOS Mail, Gmail and Mail.app and saw the same behavior in all clients.

Flags work fine if you close down an IMAP client when you are not using it when using multiple IMAP clients. They were not designed to signal event changes from one client to another which is why I started investigating IMAP flags in the first place.  By this time I knew that flags probably wouldn't be a good solution to my problem but I decided to investigate them anyway.  I was curious  because there are slight variations in the way all the clients present flags: Pine uses the term "Important", Gmail uses the term "Starred", iOS devices use the term "Flag". Mail.app has 7 different color flags while Gmail also has 12 flag types but they are not enabled by default<a href="#ref8"><sup>[8]</sup></a>.

I've been using IMAP for many years now and it seemed worthwhile to understand how it works to some extent.  What follows is an explanation on how to connect to Gmail from the command line, without an email client, executing IMAP commands manually. Basically a quick tutorial on how to travel further down the IMAP rabbit hole.

You won't get message flag data by selecting "view raw message" in your email client. Flags are meta-data on the messages so to see the actual flag data you need to log into the IMAP server. If you've ever used telnet to test an HTTP server you'll be interested to know that you can do the same with IMAP.  You can't connect to Gmail with an insecure connection so you'll have to use OpenSSL instead.
<pre lang="bash">openssl s_client -crlf -connect imap.gmail.com:993</pre>
To make the output easier to read the client request lines, what you type at the command line, have been prefixed with "C: " and the server responses have been prefixed with "S: ".  This is how all the IMAP RFC documents are written so it seems an appropriate format.  Once you've connected to the Gmail IMAP server with OpenSSL a bunch of certificate information<a href="#ref5"><sup>[5]</sup></a>  will be spewed out at you which I won't bother reproducing here. Eventually you will see the following line which means the server is ready for you to give it commands.
<pre lang="bash">S: * OK Gimap ready for requests ...</pre>
The IMAP protocol is interesting because a robust client is expected to prefix all commands with a unique tag. This is so the server can send new information to the client at any time.  The actual command is the second argument. So when you execute a command with the tag "tag1" the final response from the server will start with "tag1".

Below is the output from a successful login. The first line is the login command executed manually through OpenSSL and the following two lines are the response from the server which lists the features this IMAP server supports. The capabilities that are prefixed with X (i.e. XLIST or X-GM-EXT-1) are custom IMAP features implemented by Google.  If Google implemented the NOTIFY command it would be listed here.
<pre lang="bash">C: tag1 login user@gmail.com password
S: * CAPABILITY IMAP4rev1 UNSELECT IDLE NAMESPACE QUOTA ID XLIST CHILDREN X-GM-EXT-1 UIDPLUS COMPRESS=DEFLATE
S: tag1 OK user@gmail.com Matthieu Cormier authenticated (Success)</pre>
Once you've logged in successfully you need to select the inbox in order to be able to examine message data.  To see what flags are  currently set on a message you need to use the FETCH command.
<pre lang="bash">C: tag2 SELECT INBOX
S: * FLAGS (\Answered \Flagged \Draft \Deleted \Seen $MailFlagBit0 $MailFlagBit1 $MailFlagBit2 NotJunk $Junk $Forwarded JunkRecorded $NotJunk)
S: * OK [PERMANENTFLAGS (\Answered \Flagged \Draft \Deleted \Seen $MailFlagBit0 $MailFlagBit1 $MailFlagBit2 NotJunk $Junk myflag $Forwarded JunkRecorded $NotJunk \*)] Flags permitted.
S: * OK [UIDVALIDITY 625864318] UIDs valid.
S: * 7 EXISTS
S: * 0 RECENT
S: * OK [UIDNEXT 7259] Predicted next UID.
S: tag2 OK [READ-WRITE] INBOX selected. (Success)
C: tag3 FETCH 1 FLAGS
S: * 1 FETCH (FLAGS (NotJunk $NotJunk \Seen))
S: tag3 OK Success</pre>
The number in the FETCH command is the index of the message you want the command to work on.  In this example the server responded saying that three flags are set on message 1.  As you can see flags are used for identifying  if you've answered a message, read the message and even to determine that it is not junk mail.  Flags that start with a slash are flags that are defined in the IMAP specification.  The particular flag that we are interested in is "\Flagged".  If an email message has the flag "\Flagged" then an email client will display a flag, or star it (Gmail).

You can add or remove a flag from a message with the STORE command.
<pre lang="bash">C: tag4 STORE 1 +FLAGS (myCustomFlag)
S: * 1 FETCH (FLAGS (\Seen myCustomFlag NotJunk $NotJunk))
S: tag4 OK Success
C: tag5 STORE 1 -FLAGS (myCustomFlag)
S: * 1 FETCH (FLAGS (\Seen NotJunk $NotJunk))
S: tag5 OK Success</pre>
Finally to logout simply use the LOGOUT command.
<pre lang="bash">C: tag6 LOGOUT
S: * BYE LOGOUT Requested
S: tag6 OK 73 good day (Success)</pre>
Once you understand how to manually connect to the IMAP server and examine the flag meta-data it's monkey work to determine what a particular application does when setting a flag on a message.  iOS, Pine, and Gmail all use "\flagged", so they are all doing the same thing under the covers.

Mail.app is also setting "\flagged" but it is also using three custom flags, $MailFlagBit0, $MailFlagBit1, and $MailFlagBit2 when you choose a color.  It takes three binary bits to count to eight, so a combination of these flags is used to represent all the colors.

If you turn on extra star colors in Gmail, IMAP custom flags are not used to distinguish between the different color stars like in Mail.app. This makes sense because Gmail is not primarily an IMAP server, it is a mail server that is accessible by IMAP, POP3, and Exchange ActiveSync. Gmail defines advanced search terms so that you can search for messages based on a specific star color in the web interface<a href="#ref7"><sup>[7]</sup></a>.  If you are logged in to the web interface you can do a search for "has:red-star".      I attempted to do an IMAP search using Google's X-GM-RAW IMAP extension<a href="#ref6"><sup>[6]</sup></a>, however, searching for a message with a particular star does not appear to be supported.
<pre lang="bash">tag SEARCH X-GM-RAW "has:red-star in:anywhere"</pre>
<h2>The Final Solution</h2>
After all this interesting investigation into the internals of IMAP and Gmail I described my problem to a colleague.  He suggested that I make the problem simpler, forget about writing a custom IMAP client that monitors flags and archives messages offline when they are flagged. Forget about using flags to signal what folder to archive a message to.  Simply write a rule on the desktop client that archives everything to one folder.  Add a rule to Mail.app to copy new messages to folder X.

With my old manual archive process I don't archive everything because every email I get isn't exactly worth saving (i.e. new software version X just released!!). I do move messages to a couple of different folders too and was trying to automate my current process exactly.  By making the problem simpler and automatically copying everything to a backup folder all the filing work is eliminated. When looking for something in the future you only need to search one place for it.

There is one quirk with this solution; messages that are copied to the backup folder will be copied in an unread state. I attempted to write a rule in Mail.app that:
<ol>
	<li>Marked the message as read</li>
	<li>Copied the message to the backup folder</li>
	<li>Marked the inbox version as unread.</li>
</ol>
<div>Unfortunately this is not possible since Apple's Mail.app rules only allow marking a message as read, not unread.  Since Mail.app's dock unread count can be set to apply to the inbox only this really isn't an issue.  It's also easy to right click on the folder and mark all messages unread when using Mail.app.</div>
<h2>Conclusion</h2>
It was enjoyable to get into the guts of IMAP and figure out how things work and I'm glad I found a simple solution to my problem that didn't require writing a custom application.  I enjoy having my data in the cloud but also want my own personal copy.  There may be a potential market for more complicated data interaction models beyond simply store everything in the cloud. 

 
<h2>References:</h2>
 
<ol>
	<li><a name="ref1" href="http://en.wikipedia.org/wiki/Gmail">Gmail Wikipedia entry</a></li>
	<li><a name="ref2" href="http://www.ietf.org/rfc/rfc1730.txt">INTERNET MESSAGE ACCESS PROTOCOL - VERSION 4</a></li>
	<li><a name="ref3" href="http://tools.ietf.org/html/rfc5465">The IMAP NOTIFY Extension</a></li>
	<li><a name="ref4" href="http://tools.ietf.org/html/rfc2177">IMAP4 IDLE command</a></li>
	<li><a name="ref5" href="http://delog.wordpress.com/2011/05/10/access-imap-server-from-the-command-line-using-openssl/">Access IMAP server from the command line uing OpenSSL</a></li>
	<li><a name="ref6" href="https://developers.google.com/google-apps/gmail/imap_extensions">Google IMAP Extensions</a></li>
	<li><a name="ref7" href="https://support.google.com/mail/bin/answer.py?hl=en&amp;answer=7190">Gmail Advanced Search</a></li>
	<li><a name="ref8" href="http://support.google.com/mail/bin/answer.py?hl=en&amp;answer=5904">Gmail - Get more star designs</a></li>
	<li><a name="ref9" href="http://en.wikipedia.org/wiki/SPDY">The SPDY protocol</a></li>
	<li><a name="ref10" href="http://www.macworld.com/article/1163008/up_close_with_ios_5_mails_changes.html">iOS message flagging</a></li>
	<li><a name="ref11" href="https://discussions.apple.com/thread/3359119?start=0&amp;tstart=0">iOS may support colored flags if you use an iCloud account</a></li>
</ol>
