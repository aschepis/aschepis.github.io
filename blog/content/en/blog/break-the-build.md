+++
title = "Break the Build!"
subtitle = ""
tags = ['code']
date = '2011-07-19'

# For description meta tag
description = "Break the Build!"

# Comment next line and the default banner wil be used.
banner = 'img/scream-wide.jpg'

+++

![The Scream Doll -- Our token object of shame, given to build breakers.](/img/scream.jpg)

I was just having a conversation with a colleague and he was telling me about how the bug count on one of our projects skyrocketed overnight (during the last week of a cycle) because QA finally looked at the output of our static analysis (Java <a href="http://findbugs.sourceforge.net/">findbugs</a>) and logged defects on all the medium and high priority errors. We both lamented about how QA should do this earlier in the cycle so we don't get swamped at the end.

My suggestion to him for the future: let's break the build. We already perform static analysis as part of our build process so why don't we look at our own output and if we create findbugs warnings with severity > medium (or any findbugs warning) let's cause the build to fail. This is how things work with our unit tests, so why not with static analysis? After all, static analysis is just another kind of test that we can perform at build time. This would have some immediate outcomes:

- everybody on the team would start running findbugs on their changes before checking them in (or risk having our token burden of shame "The Scream Doll (pictured)" brought to their cubicle.
- QA would never log a findbugs defect again.
- The feedback loop gets shorter, developers would learn more, faster.
- Our code would be better.

You could extend this to failing on ANY java warning (equivalent of gcc -wall -werror).

The bottom line is that if you don't want QA to see it and you can detect it you build needs to break when it occurs.
