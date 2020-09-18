+++
title = "Development Complexity vs. Operational Complexity"
subtitle = ""
tags = ['development']
date = '2011-04-05'

# For description meta tag
description = "Development Complexity vs. Operational Complexity"

# Comment next line and the default banner wil be used.
banner = 'img/taylor-vick-M5tzZtFCOfs-unsplash.jpg'
bannerCredit = '<span>Photo by <a href="https://unsplash.com/@tvick?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Taylor Vick</a> on <a href="https://unsplash.com/s/photos/data-center?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>'
+++

I was discussing some solutions with my co-workers recently and I was
advocating for one solution while some of my coworkers were advocating
for other solutions. The debate was good natured, but everybody felt
strongly about their opinions.

While the technical details of the proposed solutions were very
different, I also realized another key difference between the solution
I was proposing and one of the solutions that my coworker was fighting
hardest for. I was advocating for a solution that required development
complexity. It would be hard to maintain for a while (for reasons
having to do with legacy code and backwards compatibility) and we
would have to test it thoroughly. The other solution was less
challenging technically, but would require a lot more complexity from
an operational standpoint. Streaming data from one database to
another, making all the data in a DB that used to bewritableread-only,
monitoring the replication of data to make sure nothing goes wrong,
etc, etc.

I realized that given the alternative between development and
operational complexity I will almost always choose development
complexity. Here are a few reasons why:

- I can unit test code, Its harder to unit test a process.
- It is easier to test code through traditional QA organizations than
  it is to test an operations process that may only fail after a long
  period of time or when some strange data that won't exist in test
  data comes across.
- If anything that can go wrong will go wrong, then I want to make
  sure that when things go live there aren't many things that can go
  wrong. That way I can have a plan in place to account for them prior
  to going live.

In the end, we hashed everything and came to a conclusion and we all
moved forward but it was interesting to see which people tend to favor
development complexity over operational complexity. As a developer,
what do you favor? why? My guess is that any developer who is into the
DevOps frame of mind would much rather development complexity for the
reasons I listed above. Developers working with a traditional IT
organization maybe more apt to throw it over the wall to IT and let
them manage it.

Thoughts?
