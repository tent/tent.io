---
title: About
layout: blog_layout
---

Tent is a way to store all your data in one place that you control. Instead of your digital life being spread across many services, Tent lets you keep it all in one place. Users can choose any hosting provider (or host their own Tent server) and any apps they want to use. Tent handles storing their data and sending it to their friends. Tent is designed to be the hub of your digital life and remove any centralized authorities that could screw it up.

## How it works

Tent is built around `posts`. Each Tent server stores a single user's posts and sends copies to the user's subscribers. Every Tent user either signs up for a service provider or sets up their own Tent server. Tent apps read and create posts from the user's server. Different apps use different post types for different kinds of content. Tent apps can talk to any Tent server so if a user changes providers they can still use the same apps.

```text
Example:
  User A creates a post in app 1.
  App 1 sends the post to user A's server.
  User A's server sends the post to user B's server.
  User B's server sends the post to user B's app 2.
  User B reads the post in app 2 and responds
  (the cycle repeats in reverse)
```

## What it's for

Different people use Tent in different ways from microblogging and photo filtering to file sync, media library management, and personal data logging, Tent can do it all. Tent can store just about anything which means Tent apps can do just about anything. Tent is content agnostic, so it will be able to handle many new kinds of data that don't exist yet. Developers can create new kinds of applications that wouldn't be possible anywhere else

## What's special about Tent

Tent is a protocol, not a piece of software. Anyone can create a new Tent server or app at any time without anyone else's permission. There's no central authority to restrict developers, spy on, or censor users.

Tent is decentralized like email and the web. That means that users interact with each other in the same way whether they're on the same service provider or across the world. That means no one company can control the ecosystem. If a service provider starts behaving badly, users can move to another provider or set up their own servers, taking their data and relationships with them. Unlike email, address books are updated automatically so migration is seamless.

Tent servers handle data storage and communication so all your data is always under your control. If an app gets popular, other developers can create new apps that use the same kind of data so users can choose the app with the best experience. Different users can use different apps to talk to each other if they use the same kind of data. Developers can even write apps that don't "phone home" with your data.

Tent makes it hard for anyone to interfere with your experience. If a service provider starts behaving badly, you can switch to a different provider with your data and relationships. If a developer discontinues an app another developer can create a new app that uses your old data. With Tent no one can shut off your experience.
