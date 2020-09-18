+++
title = "Of Heroes and Pit Crews"
subtitle = "Bringing techniques from the surgical world to software"
tags = ['development']
date = '2011-05-16'

# For description meta tag
description = "Of Heroes and Pit Crews: Bringing techniques from the surgical world to software"

# Comment next line and the default banner wil be used.
banner = 'img/andrew-roberts-6lqk_bNnw_c-unsplash.jpg'
bannerCredit='<span>Photo by <a href="https://unsplash.com/@ar1428?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Andrew Roberts</a> on <a href="https://unsplash.com/s/photos/pit-stop?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>'
+++

Last night I had the pleasure of going to listen to
[Atul Gawande](http://gawande.com) speak about medicine, healthcare,
his latest book
([The Checklist Manifesto](http://gawande.com/the-checklist-manifesto)),
and more generally about making systems, processes, and procedures
work as complexity increases beyond the capabilities of the
individual.

As a surgeon, researcher, and writer Dr. Gawande has tackled some
really difficult problems with regards to reducing deaths as a result
of surgery and done an impressive amount of research across many
fields (including with Boeing engineers, and people who build
skyscrapers) to determine how to deal with complexity in a way that
reduces error but also allows members of a team to exercise judgement
in the heat of the moment.

The most important thing that I took away from his talk was his
emphasis on the need to shift our thinking in terms of how we get
things done. Medicine and Software Engineering have deeply entrenched
concepts of lone geniuses. The Brilliant Doctor. The Rockstar
Developer.

Dr. Gawande emphasizes the need to shift from the "hero" culture to
more of a "pit crew" mentality where there is a team of people who all
have set responsibilities, where everybody knows everybody else's
responsibility, and every team member feels confident enough to speak
up if something is going off the tracks. A team where everybody is
moving forward, pointed in the same direction. I have seen this same
sort of shift in software engineering. I think that in some ways the
agile movement reflects this mentality. The best teams I have been on
were the teams where everybody (regardless of level) felt like they
had a say, and where we were all driving towards the same goal (not
just a ship date, but a level of quality, a level of service to the
teams we interacted with, and a commitment to doing what is right for
the customer.)

The tool that Dr. Gawande introduced to his operating room (and others
around the world) with stunning success is a simple one. The
checklist. His argument is that while people's intuitive reaction to
the idea of a checklist is that it means shutting down your brain, but
that a well-written checklist for a team of people can spark the
memory and bring out better performance. The idea of introducing
checklists into some of the processes we do at work is intriguing
me. I'm analyzing where we fail (in field bugs, broken builds, failed
build acceptance tests) and why the failures occur in order to find a
place where a simple checklist could be effective.

Off the bat i've come up with a few ideas:


- Code reviews -- On my team we already have an informal checklist for
  code reviews: Does the code look right (match standards, appear to
  be logically correct?) Does it build? Does it work? Do the unit
  tests run? Do our automated integration tests run? I wonder if this
  can be extended or formalized, and how?
- Deployments -- When we are deploying a service and the deployment
  has to be coordinated with several teams does it make sense to form
  a "pit crew" with well known responsibilities and a checklist of
  things that we are all accountable for? I'll admit here that i'd
  rather try to go the devops route and automate deployments with
  something like Puppet but my group is just not there yet.

What do you think? Has anyone read the book and thought of how it
applies to software engineering? Where else would a checklist be
appropriate for preventing errors? Are checklists something we can
codify? Are we already doing this to some extent with automation and
unit-testing?
