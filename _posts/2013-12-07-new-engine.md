---
layout: post
title:  "Jekyll"

---

I've converted this blog from wordpress to Jekyll. Wordpress is great software, but overkill for a simple blog that isn't updated frequently.  It's also built on PHP which comes with it's share of [issues.][PHPdesign]

In the last year or so every time I logged in to write a blog post in WordPress it would ask me to upgrade to the latest version. I would spend some time upgrading, and then start working on an entry. But I'd run out of steam and/or inspiration. WordPress does have a new full screen edit mode which is very slick but it wasn't enough to keep me on the platform. You still need to login and navigate past all the knobs and doo-dads. WordPress is a printing press but all I need is a mimeograph.

During the conversion I've also taken the time to preen and prune blog entries, and ponder the purpose of this blog. My original purpose for this blog was to motivate me to build Mac software. Looking back at previous entries, some of them were definitely created to generate traffic for software that I'm no longer selling. No surprise there, blogs are cheap promotion. I've kept what I consider the better entries of the bunch. 

As usual, I considered wiping everything and starting over.  It can be so easy to delete things in the digital age. But going back and editing old entries, although time-consuming can be enlightening. Although it's part of the web's nature to write and reference other websites it's also interesting to see link-rot when you go back and examine old posts. In the future I plan on trying to write blog posts that are more self-contained with less external linkage.

So let's face it, I've been avoiding you WordPress.  It's not you it's me.  I've been meaning to write about my [latest project][Tallyman]  which I started almost a year ago. And it's interesting since [Tallyman][Tallyman] follows the same basic architecture of monitoring data and generating html output that Jekyll does. 

<img src="/images/hellyeahdude.jpg" />

Maybe I won't write any new articles and will spend more time reformating old articles. Time will tell.

**P.S.** Here are some vi settings for editing jekyll style markdown files

{% highlight vim %}
function! MarkDownSettings()
  set wrap
  set columns=75
  set nofoldenable
  highlight Folded ctermfg=grey ctermbg=blue
  " So that jekyll highlight groups don't screw up the markdown highlighter
  syntax region code matchgroup=ignore start="% highlight" end="% endhighlight"
endfunction
{% endhighlight %}

**P.P.S** Here is what you need to do in your Apache .htaccess file to redirect old Wordpress query string URLS to static HTML pages.

{% highlight apache %}
<IfModule mod_rewrite.c>
RewriteEngine On

RewriteBase /cocoamondo/
RewriteCond %{QUERY_STRING}  ^p=1181$
# The Question mark at the end of the RewriteRule URL is used to 
# drop the query string after a redirect. 
RewriteRule (.*)  http://weblog.preenandprune.com/2012/post-pc-email.html? [R=301,L]

</IfModule>
{% endhighlight %}


[linkrot]: http://en.wikipedia.org/wiki/Link_rot
[jekyll]: http://jekyllrb.com
[wordpress]: http://wordpress.org
[Tallyman]: https://github.com/mcormier/tallyman
[PHPdesign]: http://me.veekun.com/blog/2012/04/09/php-a-fractal-of-bad-design/
