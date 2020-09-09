---
layout: post
color_scheme: peter-river
status: publish
published: true
title: I'm Adam, and i'm a recovering Singleton addict.
author:
  display_name: aschepis
  login: aschepis
  email: adam.schepis@gmail.com
  url: ''
author_login: aschepis
author_email: adam.schepis@gmail.com
wordpress_id: 86
wordpress_url: http://adamschepis.com/blog/?p=86
date: '2011-05-02 06:17:32 +0000'
date_gmt: '2011-05-02 11:17:32 +0000'
categories:
- Uncategorized
tags: []
comments: true
---

My name is Adam, and i'm a recovering Singleton addict. &nbsp;There,
i've said it. &nbsp;I used to use singletons all the time
&nbsp;because they make doing some things, like sharing state
globally, incredibly convenient. &nbsp;My code was littered with
XYZManager classes. &nbsp;The defining trait of these classes was the
static GetInstance() method that magically enabled me to get access to
that object and its state wherever I wanted!! &nbsp;What a great idea,
right?

What a mess! &nbsp;I learned over time that the cost of changing one
of these things, or the cost of doing a major refactor was really high
in terms of code change. &nbsp;And to make things worse, because my
classes' dependencies were hidden in implementation and weren't
transparent in the interfaces it was impossible to write real unit
tests. &nbsp;This made doing a big refactor even less attractive.

So over the years, through work in the industry and coding on my own
I've come to the conclusion that the singleton sucks, and that there
are very few places where they are actually appropriate (logging comes
to mind as one acceptable place). &nbsp;The fact of the matter is that
most of the places I see singletons used in software they are actually
just an enable for developer laziness.

So here is my off the cuff list of why singletons suck. &nbsp;Feel
free to comment and add your own reasons (or counterpoints)

- Singletons hide your dependencies. &nbsp;This makes code harder to
  understand
- Singletons make unit testing difficult. &nbsp;It's hard to mock out
  a global object that you can't inject into a class
- Singletons reduce reusability. &nbsp;If i'm writing a class that
  utilizes a singleton because my application will only ever use one
  then i'm limiting myself because I can't use that library to write
  test tools that may want to simulate how many of these object (for
  instance, many users) interact with a system.
- Singletons reduce scalability. &nbsp;A single, global object?
  &nbsp;Sounds like a source of contention to me.
- Singletons are not good object oriented design, they are lazy!
