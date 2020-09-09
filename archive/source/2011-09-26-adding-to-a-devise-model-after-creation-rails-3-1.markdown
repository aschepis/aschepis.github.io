---
layout: post
status: publish
published: true
title: Adding to a Devise model after creation (Rails 3.1)
author:
  display_name: aschepis
  login: aschepis
  email: adam.schepis@gmail.com
  url: ''
author_login: aschepis
author_email: adam.schepis@gmail.com
wordpress_id: 182
wordpress_url: http://adamschepis.com/blog/?p=182
date: '2011-09-26 08:36:06 +0000'
date_gmt: '2011-09-26 13:36:06 +0000'
categories:
- Uncategorized
tags: []
comments: []
color_scheme: nephritis
---

This blog post is going to be fairly light on content, but it was
something I googled quite a bit this weekend until i realized that
Rails 3.1 provides a pretty awesome option.

The problem I had is that i have an existing
[Devise](https://github.com/plataformatec/devise) model and I wanted
to add the :confirmable trait to that model so that when a user
registers they have to provide a valid email address in order to use
the site. One suggestion online was to just regenerate the model and
use the newer migration but that seemed like overkill. Another answer
was to add the columns yourself. The "up" migration was easy and just
involved modifying the table to add "t.confirmable" which would
generate the proper columns. The "down" migration was ugly though
because you had to have knowledge of each column that devise would add
when you put confirmable.

A better solution? Rails 3.1 Reversible Migrations to the rescue! If
you are using rails 3.1 instead of having "up" and "down" methods you
can just have a "change" method and for the most part, Rails and
ActiveRecord are smart enough to figure out how to migrate that up and
down (there are a few caveats, such as removing columns when migrating
up.)  So in the end, the code to add confirmable columns to the DB was
quite simple:

{% gist 1240114 %}
