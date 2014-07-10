---
layout: post
color_scheme: emerald
status: publish
published: true
title: Offline testing of network driven apps
author:
  display_name: aschepis
  login: aschepis
  email: adam.schepis@gmail.com
  url: ''
author_login: aschepis
author_email: adam.schepis@gmail.com
wordpress_id: 67
wordpress_url: http://adamschepis.com/blog/?p=67
date: '2011-03-24 20:27:11 +0000'
date_gmt: '2011-03-25 01:27:11 +0000'
categories:
- code
tags:
- iOS
- hack
- network
- web-api
- location
comments: true
---

I was doing some traveling for work last week and wanted to do some
extra-curricular coding while I was on the road. Unfortunately the
project I was working on relied on things like location, and calling
web-apis. I flew United and didn't have WiFi on the flight so I had to
improvise. The solution is pretty straightforward but I figured that I
would write about it because it gave me an extra 15 hours of possible
coding time over the course of 3 days so it paid off.

This technique is also useful if you want to test things using a
consistent data-set, or you find a particular data-set that causes
problems in your application and you want to isolate the issue.

Since this was an iOS project, here's what i did:

First, i exercised the web API to get an example to work with. Since
the API returned JSON I just copied the result into a file called
`tempdata.json`. Next, I added
`tempdata.json` to my iOS project. Finally, where I
handled failures calling to the Web API I inserted the following code:

<script src="https://gist.github.com/aschepis/90e18182ff0ca532474a.js"></script>

Viola! When my API fails in the simulator, presumably because my internet connection isn't available during a flight, It will load up some sample data I had previously acquired and run the app based off that.
