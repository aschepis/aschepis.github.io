---
layout: post
color_scheme: alizarin
status: publish
published: true
title: Handling many UIAlertViewDelegate callbacks in the same class
author:
  display_name: aschepis
  login: aschepis
  email: adam.schepis@gmail.com
  url: ''
author_login: aschepis
author_email: adam.schepis@gmail.com
wordpress_id: 26
wordpress_url: http://adamschepis.com/blog/?p=26
date: '2011-02-28 16:52:54 +0000'
date_gmt: '2011-02-28 21:52:54 +0000'
categories:
- code
tags:
- objective-c
- UIAlertView
- iPad
- iOS
- code
comments: true
---

I've been doing a fairly decent amount of iPad development lately and
in the application i'm working on there is one UIView that is fairly
central to the app. In several circumstances I need to display a
UIAlertView on top of this UIView. The buttons and responses to what
was clicked different depending on which alert is being shown.

I didn't want to have to add a delegate class specific to each alert
view. Instead, I wanted to centralize that functionality in the
UIViewController for the main view. I also didn't want to have to hold
on to a reference to the UIAlertView object until it was dismissed.

What I came up with was a class I called
UIAlertViewSelectorDelegate. The purpose of this class is to act as a
UIAlertViewDelegate that calls a selector on one of your objects when
a button is clicked on the UIAlertView. In this was I was able to have
a different method in my UIViewController for each of my UIAlertViews
logic.

Here's the code:

<script src="https://gist.github.com/aschepis/256d81b11dfc8c7eef43.js?file=UIAlertViewSelectorDelegate.h"></script>
<script src="https://gist.github.com/aschepis/256d81b11dfc8c7eef43.js?file=UIAlertViewSelectorDelegate.m"></script>

And an example of usage:

<script src="https://gist.github.com/aschepis/256d81b11dfc8c7eef43.js?file=example.m"></script>

How could this be improved? First of all, all my UIAlertViews required
a simple yes/no selection so I was able to pass by only sending the
clicked button index to the selector as an NSNumber. If you needed to
send more information you could extend the class to do that.

I don't claim to be an iOS or objective-c expert, but this worked for
me. If it works for you, or if you have a better solution, or if a
solution already exists in an existing Framework please feel free to
comment and share!
