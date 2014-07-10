---
layout: post
color_scheme: nephritis
status: publish
published: true
title: Taking a screenshot of a section of a UIView
author:
  display_name: aschepis
  login: aschepis
  email: adam.schepis@gmail.com
  url: ''
author_login: aschepis
author_email: adam.schepis@gmail.com
wordpress_id: 49
wordpress_url: http://adamschepis.com/blog/?p=49
date: '2011-03-06 20:32:33 +0000'
date_gmt: '2011-03-07 01:32:33 +0000'
categories:
- code
tags:
- objective-c
- iPad
- iOS
- works-for-me
- hack
comments: true
---

There doesn't appear to be a great solution in the iOS platform for
taking a screenshot of a section of a UIView. This is an issue that I
ran into while doing some iPad development recently. The requirement
was to determine the bounds of all of the subviews (which are free
floating and arranged by the user) in an very large UIView and convert
that rectangle subsection of the UIView that corresponds with the
bounds to a UIImage. Creating a PNG of the entire UIView was not
acceptable because it caused the size of the images to explode due to
all of the extra empty space. What I came up with is admittedly a
hack, but it works for me and it works well for the application in
which it is used. Maybe it will work for you as well.

Please let me know if you know a better way to do this! I'd love to hear it.

The basic strategy is this:

- Create a CGRect that that fits all of the subviews. Let's call it rect.
- loop through all subviews and shift them towards to fit in the main view starting at {0,0}. (e.g. shift {-rect.origin.x, -rect.origin.y})
- Create an image context that is the size of the rectangle (rect.size)
- call renderInContext on the main view to render it to the image context
- create UIImage from the image context
- shift all subviews back to their original location.

Viola! A screenshots of a section of the view. Here's some code.

Code to get the bounds of my CGRect:
<script src="https://gist.github.com/aschepis/85722448c8a7d074eaad.js?file=GetBounds.m"></script>

In my view controller.  Code to take the screenshot:
<script src="https://gist.github.com/aschepis/85722448c8a7d074eaad.js?file=MyView.m"></script>

Enjoy!
