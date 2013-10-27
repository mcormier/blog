--- 
layout: post
title: Loading a Message Url Drop
categories: 
- Mondo Kode
tags: []

status: draft
type: post
published: false
meta: 
  _edit_last: "1"
---
<p align="left">
In Leopard a new url type of URl has been created.  Message urls
(i.e. message://%3C1213312431.3782@hoopla.com%3E)
for referencing mail messages in Mail.app.  This is thoroughly documented by the almighty <a href="http://daringfireball.net/2007/12/message_urls_leopard_mail#fn1-2007-12-04">Grubes.</a>  In this entry I am going to explore how to use this message url to find the message on disk and load that message.  The techniques discussed work only for messages that are stored locally.  Accessing messages stored remotely on an email server is left as an exercise for the reader.
</p>

<p align="left">
You can create an application that accepts the URL drop type [VERIFY], and receive this message url type.  However, there is no easy way to get the contents of the URL.  Both the NSString method string, stringWithContentsOfURL: and the NSData method dataWithContentsOfURL: produce nil with a message URL.
</p>

<p align="left">Mail.app stores its message data on disk under the directory <b>[UserHome]/Library/Mail/Mailboxes.</b>

To find the email message file for the message url we can use a recursive grep under that directory.
<strong>grep -r 1213312431.3782@ hoopla.com *</strong>

This will return a result similar to:
<em>hoopla.mbox/Messages/2755.emlx:Message-Id: <1213312431.3782@hoopla.com></em>
</p>

<p alight="left">
With that result we know what file the message is in and we can load the message data.  This doesn't feel like the most elegant solution, how will it scale?  If all these emlx files have a Message-Id: line which is almost identical to Apple's message URL format, maybe we should create an index of all these  message ID's?
</p>

<p>Apple has provided us with an index in the form of an sqlite3 database.  The index is called "Envelope Index" and can be accessed with the command
<strong>sqlite3 Envelope\ Index</strong>
We can get the info we want with the following SQL command:

select messages.rowid, mailboxes.url from messages, mailboxes where date_sent = 1213312431 and mailboxes.rowid = mailbox;

This will give us a result like below:
2755|local:///SunFlower/Hoopla

The message ID (2755) is the file we are looking for (2755.emlx).  The mailbox url helps us locate where it is on disk SunFlower/Hoopla.mbox/Messages.

So we need to load [UserHome]/Library/Mail/Mailboxes/SunFlower/Hoopla.mbox/Messages/2755.emlx
</p>
<h2>Just One Thing...</h2>

<p>Accessing the Envelope Index database is not always guaranteed.  If Mail.app is checking it's mail boxes on remote servers it will lock the database.  This makes even a read only select statement not possible. But there's no reason to choose one technique over the other.  We can attempt a database select, and if that doesn't work, then we can do the slower brute force recursive grep.</p>
