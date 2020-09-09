---
layout: post
color_scheme: nephritis
status: publish
published: true
title: Setting up a 3 Node Riak Cluster with EC2 Cluster Compute Instances
author:
  display_name: aschepis
  login: aschepis
  email: adam.schepis@gmail.com
  url: ''
author_login: aschepis
author_email: adam.schepis@gmail.com
wordpress_id: 112
wordpress_url: http://adamschepis.com/blog/?p=112
date: '2011-06-06 13:49:02 +0000'
date_gmt: '2011-06-06 18:49:02 +0000'
categories:
- Uncategorized
tags: []
comments: true
---

I've been doing some investigation into a few NoSQL databases lately
for use in a project at Symantec. One of the NoSQL DBs I really like
and wanted to test some specific use cases for is
[Riak](http://wiki.basho.com/). I already think that Riak is pretty
awesome so i'm not going to get into evangelizing. This blog is purely
about the test setup I created on Amazon EC2.

For my tests I decided to create a 3 node Riak cluster. I wanted some
beefy hardware that would be roughly analogous to the machines we
would be putting Riak on in our real datacenters so I opted to use EC2
Cluster Compute instances to reduce latency. The nodes are Quad-XL
(because it was either that or a GPU instance, which I don't need.)

So without any further delay... here is how to set up a 3 node Riak
cluster on EC2:

**Creating the First Node**

Start by spinning up an EC2 Cluster Compute Instance:

![Step 1](/images/riak-1.png)
![Step 2](/images/riak-2.png)

**Security Groups**

One very important part of this process is Security Groups. AWS uses
security groups to define who can access your instances, and how. Here
is what my Security Group looks like for my Riak cluster:

![Step 3](/images/riak-3.png)

- TCP 0-65535 (within the Riak Security Group) is the only thing here
  that i would justify as a hack :) When i was trying to get my
  cluster to join with just 8099 open it failed. Perhaps somebody from
  Basho (or a Riak expert) can fill me in on exactly which ports are
  needed. I'm not too worried about this since its confined to chatter
  between my Security Group, but I would never have a production
  deployment like this.
- TCP 8099 (within the Riak Security Group) This is the port that Riak
  uses for intra-cluster data handoff
- 22 (SSH) - So i can get to the box :)
- 80 HTTP - Not actually necessary
- TCP 8098 (Public) - exposing the Riak HTTP interface to the
  world. In a production environment this would probably be restricted
  to the IP-space of the servers that would be interacting with Riak.

PS -- I just learned while doing this that you can define a port to be
available to all instances in a security group. How long has that been
around?! It is an awesome feature! &lt;3

**Installing Riak**

Once your instance is up and running, installing Riak is a breeze
(much of this is borrowed from the excellent
[Riak RHEL install documentation](http://wiki.basho.com/Installing-on-RHEL-and-CentOS.html)). The
only thing I had to poke around a little bit to figure out was

```
wget http://downloads.basho.com/riak/riak-0.14/riak-0.14.2-1.el5.x86_64.rpm
sudo yum install openssl098e
sudo rpm -Uvh riak-0.14.2-1.el5.x86_64.rpm
```

**Note: I got a few errors from chcon, but they didnt seem to cause
  any issues.**

Okay! We've got Riak installed. Next I edited the Riak app.config file
to bind to all IP address, just for external testing:


in /etc/riak/app.config:

```
{http, [{ "127.0.01", 8098 }]},
```

becomes

```
{http, [{ "0.0.0.0", 8098 }]},
```

Now you can run `sudo riak start` to start Riak. If your Security
groups are set up correctly you should be able to hit it via port
8098.

Now, shut down that instance. In AWS create an AMI from the instance
(right click the instance, choose "Create Image (EBS AMI") Once your
AMI is created launch two more EC2 instances from the AMI. This spares
you the effort of having to install Riak on each node in your
cluster. It also makes scaling out easier in the future since you can
create a new instance, edit some config (preferably via Puppet or Chef
in an production environment) and run `riak join` to join the
cluster.

Once your two instances are up and running, I **literally** followed
the Riak documentation at
[http://wiki.basho.com/Basic-Cluster-Setup.html](http://wiki.basho.com/Basic-Cluster-Setup.html). It
was really that easy. **The was one gotcha, though.** Make sure that
when you choose the IP address to bind (and name)for the nodes in your
cluster that you use the EC2 Private IP Address (or DNS name should be
fine too.)

![Step 4](/images/riak-4.png)

I do have some concerns that this will cause problems on reboots, but
I haven't tested it yet. Anyone else done this and determined that for
sure?

There you have it. At this point you should have a fully functional 3
node Riak cluster running on AWS EC2 Cluster Compute Instances. It
should be pretty damn fast! The only thing I added on top of this was
an Elastic Load Balancer that would round robin the traffic between
the three nodes so that I could test how it is really scaling.

For the record, I have made my AMI public (just a base Riak install.)
The AMI ID is: `ami-981ee7f1`
