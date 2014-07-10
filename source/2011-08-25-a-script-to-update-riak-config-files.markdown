---
layout: post
color_scheme: wisteria
status: publish
published: true
title: A Script to Update Riak Config Files
author:
  display_name: aschepis
  login: aschepis
  email: adam.schepis@gmail.com
  url: ''
author_login: aschepis
author_email: adam.schepis@gmail.com
wordpress_id: 155
wordpress_url: http://adamschepis.com/blog/?p=155
date: '2011-08-25 08:42:08 +0000'
date_gmt: '2011-08-25 13:42:08 +0000'
categories:
- Uncategorized
tags: []
comments: true
---

Yesterday, one of my teammates who does a lot of work in automating
our deployments came to me and asked me for some in parsing and
updating a JSON config file so that he could automate the setting of
configuration data during automated deployments. I took one look
at the config file in front of me and said "Bro, that's not
JSON. Those are Erlang terms."

He was working on automating the Riak deployment we are setting up for
some new features. He had never touched erlang (or any
functional language) so i offered to show him the ropes and write a
script that could read and update Riak app.config. I figured i would
post it here for a couple of reasons:

- I'm no Erlang expert myself. I'd love to get feedback on easier/better ways to accomplish this
- Somebody else probably wants to solve this problem and the script may help.

So here it is, enjoy!

<script src="https://gist.github.com/aschepis/1168630.js?file=config.erl"></script>
