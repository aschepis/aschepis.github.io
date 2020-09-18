+++
title = "I'm Adam, and i'm a recovering Singleton addict."
subtitle = ""
tags = ['development', 'code']
date = '2011-05-02'

# For description meta tag
description = "I'm Adam, and i'm a recovering Singleton addict."

# Comment next line and the default banner wil be used.
banner = 'img/chris-ried-ieic5Tq8YMk-unsplash.jpg'
bannerCredit='<span>Photo by <a href="https://unsplash.com/@cdr6934?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Chris Ried</a> on <a href="https://unsplash.com/s/photos/code?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>'

+++

My name is Adam, and i'm a recovering Singleton addict. There,
i've said it. I used to use singletons all the time
because they make doing some things, like sharing state
globally, incredibly convenient. My code was littered with
XYZManager classes. The defining trait of these classes was the
static GetInstance() method that magically enabled me to get access to
that object and its state wherever I wanted!! What a great idea,
right?

What a mess! I learned over time that the cost of changing one
of these things, or the cost of doing a major refactor was really high
in terms of code change. And to make things worse, because my
classes' dependencies were hidden in implementation and weren't
transparent in the interfaces it was impossible to write real unit
tests. This made doing a big refactor even less attractive.

So over the years, through work in the industry and coding on my own
I've come to the conclusion that the singleton sucks, and that there
are very few places where they are actually appropriate (logging comes
to mind as one acceptable place). The fact of the matter is that
most of the places I see singletons used in software they are actually
just an enable for developer laziness.

So here is my off the cuff list of why singletons suck. Feel
free to comment and add your own reasons (or counterpoints)

- Singletons hide your dependencies. This makes code harder to
  understand
- Singletons make unit testing difficult. It's hard to mock out
  a global object that you can't inject into a class
- Singletons reduce reusability. If i'm writing a class that
  utilizes a singleton because my application will only ever use one
  then i'm limiting myself because I can't use that library to write
  test tools that may want to simulate how many of these object (for
  instance, many users) interact with a system.
- Singletons reduce scalability. A single, global object?
  Sounds like a source of contention to me.
- Singletons are not good object oriented design, they are lazy!
