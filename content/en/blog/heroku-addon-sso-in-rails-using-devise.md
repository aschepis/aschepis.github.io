+++
title = "Integrating Heroku addon SSO in Rails using Devise"
subtitle = ""
tags = ['code']
date = "2012-04-30"

# For description meta tag
description = "Integrating Heroku addon SSO in Rails using Devise"

# Comment next line and the default banner wil be used.
banner = 'img/heroku-vector-logo.png'

+++

I was going through the process of integrating
[Heroku](http://www.heroku.com) SSO with the addon I am developing and
although it was pretty straightforward I was surprised that I couldn't
find an existing gem that would add this functionality to
[Devise](https://github.com/plataformatec/devise).

Once I had it all working in my rails app via a custom Warden strategy
I decided that I would extract it into a Rails engine and commit it to
Github so that maybe others can use it.

It's still pretty rough and there are a number of things I'm not happy
with in the code, but it works for my purposes. I will continue to
update and maintain it to keep it working in my projects and if there
is some positive response for it in the community I'd love to add more
features and clean things up to make it more useful to everyone.

So here is the github:
[devise-heroku](https://github.com/aschepis/devise-heroku)

A few things I don't like that i would love some feedback on or help
in fixing:

- Integration feels like its a bit too hard.. i would love to be able
  to find a way to avoid making the user edit their devise.rb file and
  specify the scope
- would love to be able to add this to the model being used in devise
  and just specify :heroku_sso_authenticable
