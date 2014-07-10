---
layout: post
color_scheme: clouds
status: publish
published: true
title: Pure-FTPd + Passive FTP on Amazon EC2
author:
  display_name: aschepis
  login: aschepis
  email: adam.schepis@gmail.com
  url: ''
author_login: aschepis
author_email: adam.schepis@gmail.com
wordpress_id: 3
wordpress_url: http://adamschepis.com/blog/?p=3
date: '2011-02-23 22:36:15 +0000'
date_gmt: '2011-02-24 03:36:15 +0000'
categories:
- sysadmin
tags:
- pure-ftpd
- ec2
- aws
- sysadmin
- wordpress
comments: true
---

In the never-ending search for the perfect blog theme I decided to get the WordPress automatic theme
install stuff working on the EC2 instance that hosts this blog. &nbsp;This involved setting up and
FTP server on the instance.

A quick search in the package manager found pure-ftpd, so i installed the package. &nbsp;I googled
around to figure out how to configure pure-ftpd. &nbsp;This was a snap, and my test FTP session
worked! &nbsp;However, when i sent to install a WP theme it always failed! &nbsp;What gives?!

After turning on verbose logging in pure-ftpd and tailing `/var/log/messages`
I saw something like this at the end of the log:

```
pure-ftpd: (wordpress@127.0.01) [DEBUG] Command [pasv] []
pure-ftpd: (wordpress@127.0.0.1) [DEBUG] Command [list] [-la /var/www/htdocs/myblog]
```

I had to do a bit more googling to brush up on my rusty knowledge of the <a
[FTP protocol](http://en.wikipedia.org/wiki/File_Transfer_Protocol), but
what was happening here is that the client (WordPress theme installer) is failing to list the files
in the folder because it has activated Passive Mode.

The first step was to edit my EC2 Instance to allow the ports specified in my
`pure-ftpd.conf` file. You can find these values out by looking for this in your conf
file:

```
PassivePortRange                50000 50100
```

So I updated my EC2 instance to allow these ports, but it was still failing!  I furiously search the
internet for a clue and finally found one in a blog post about
[setting up proftpd on EC2](http://www.iknowfoobar.co.uk/2010/09/16/how-to-get-passive-ftp-working-on-an-amazon-ec2-instance-with-proftpd/). The
one thing i was missing was forcing the second connection made by the client in Passive Mode to use
my EC2 instance's public IP address. &nbsp;The fix was a simple as uncommenting and editing the
following line in <code>pure-ftpd.conf</code> and restarting the daemon:

```
# Force an IP address in PASV/EPSV/SPSV replies. - for NAT.
# Symbolic host names are also accepted for gateways with dynamic IP
# addresses.
ForcePassiveIP                127.0.0.1
```

Once this was set up themes, plugins, and updates all started to install perfectly!  Hopefully
anyone else who runs into this issue finds this post and avoids the headache that it caused me!
