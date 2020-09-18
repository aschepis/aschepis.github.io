+++
title = "Still Bullish on the Cloud"
subtitle = ""
tags = ['development']
date = '2011-05-14'

# For description meta tag
description = "Still Bullish on the Cloud"

# Comment next line and the default banner wil be used.
banner = 'img/pero-kalimero-9BJRGlqoIUk-unsplash.jpg'
bannerCredit='<span>Photo by <a href="https://unsplash.com/@pericakalimerica?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Pero Kalimero</a> on <a href="https://unsplash.com/s/photos/cloud?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>'

+++

Over the past few weeks we've witnessed a couple of big outages in the
cloud computer world. First there was the
[downtime on Amazon's EC2 infrastructure](http://aws.amazon.com/message/65648/),
and then this week there was the
[Blogger outage](http://buzz.blogger.com/2011/05/blogger-is-back.html)
on Google's infrastructure. These high profile outages, coupled with
the slightly different but orders of magnitude more damaging
Playstation Network outage have gotten some people questioning the
wisdom of building or moving services into the cloud,
[including the New York Times](http://www.nytimes.com/2011/04/23/technology/23cloud.html?_r=1).

I'm still incredibly bullish on cloud-hosted services and the power
and potential of the cloud. There are two fundamental reasons
why. First, the cloud is The Great Leveler. Not since the advent of
the personal computer has the playing field been leveled so
significantly. If you come up with the idea for the next Facebook or
Google you can bootstrap it for a tiny fraction of what buying the
required hardware would have cost you. As your service grows, you can
scale. You can compete with anybody in the world for handling user
traffic on day 1.

The second reason is that while I discovered that AWS Availability
Zones aren't quite as separated as I thought (EBS control plane is
shared per-region, but distributed across AZs in the region) there
were many websites who survived the outage came to little or no harm
(namely Twilio, Netflix.) The outage at EC2 makes the case for cloud
computing, it doesn't damn. High Availability 101 says that you can't
have a single point of failure. The services that went down were
primarily in a single Availability Zone on AWS. If you have everything
running in a single AZ then you are asking for trouble. You have to
assume failure. Netflix takes this to the extreme with their
[Chaos Monkey](http://techblog.netflix.com/2010/12/5-lessons-weve-learned-using-aws.html).

Furthermore, the cloud is still evolving. One thing that I think that
we will see developing as an extension of some current endeavors, and
as a result of these recent outages, is the "meta-cloud"
provider. Companies like RightScale are already playing in this
space. I think that they should start building technology to abstract
away the cloud provider entirely and create a market for compute
resources. They can run your service on EC2 if thats where they are
getting the best combination of cost and performance (think: spot
instances) or they could bring it up on RackSpace's cloud if the best
price and performance is there. They could utilize many providers to
get better performance (routing users to datacenters closest to them.)
They could also bring your service up in multiple cloud providers to
add an even higher level of availability and redundancy, or switch
your provider if an anomaly or outage is detected where you are
currently hosted.
