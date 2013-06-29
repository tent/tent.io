---
title: About
---

## Basics

Tent is a communications protocol. It lets users store any kind of data and send that data to other users in real time. Just like other protocol-based services like email or the web, anyone can host their own server or write apps. Also like email, users can host their own Tent server or use a Tent hosting provider.

Tent stores data as *posts* on each server. Posts are JSON and can contain binary attachments. Developers can create new types of posts for any kind of data and create Tent apps for everything from microblogging to cloud file sync.

## How it works

Every Tent user has a Tent server and many Tent apps.

Users create and view posts with apps.

Apps send posts to the user's server or fetch them from other users' servers.

When a user creates a post, their server sends copies of the post to their followers' Tent servers.

The user's server also stores copies of posts it receives from other users.

Apps that support the same post types are interoperable.

## What can you do with Tent?

Tent is a communications protocol. There is no limit to the type of data or apps it can support. Apps can be "social", collaborative, or meant for storing private information. Web apps, and native desktop and mobile apps for all operating systems are possible.

## Why Tent?

Tent is generic and decentralized. Users aren't stuck in a walled garden. If they choose they can host their own server and control their data and identity. Developers aren't locked into a single platform. Anyone can build any kind of app and there are no API keys to be revoked later. There are no limits or central authorities to censor or intermediate communication, invade privacy, or take control.

## Get Started

To get started with Tent, you need a Tent server. You can use a Tent host like [Tent.is](https://tent.is) or host [your own](https://github.com/tent/tentd-admin).


Thinking about hosting your own Tent server? Consider the following criteria:

### Tent servers should 

- have a high storage capacity
- have lots of bandwidth
- have a fast CPU
- have redundant infrastructure
- always be on
