---
title: Protocol Introduction
---

## The Tent Protocol

Tent is a protocol for decentralized social networking. It allows you to control your data, who has access to it, and what can be done with it. 

Anyone can run a Tent server or write a Tent app. There are Tent hosts for users who do not want to manage a server. 


### API Overview

Tent is a social layer over HTTP using [JSON](http://en.wikipedia.org/wiki/JSON).

Requests are authenticated with [HMAC](http://en.wikipedia.org/wiki/Hash-based_message_authentication_code)
signatures, and apps use [OAuth 2](http://en.wikipedia.org/wiki/OAuth) to access
content on behalf of users.


### Users

Tent users are called **entities** and identified by a URI. 

**Example:** John Smith's entity might be `https://johnsmith.me/. 

A [HEAD request](http://en.wikipedia.org/wiki/HEAD_%28HTTP%29#Request_methods) to
`https://johnsmith.me/` would respond with a `Link` header pointing to
a Tent profile (e.g. `https://tent.johnsmith.me/profile`)

### Servers

Tent servers are the protocol core. They represent the users and maintain their data and relationships. Servers also handle these responsibilities:

- Persisting data
- Notifying other servers about new data
- Ensuring content is only pushed to recipients accepting associated licences
- Managing a list of servers (entities) it is following
- Managing a list of servers (entities) that are following it
- Authorizing apps to access data
- Notifying apps about new or modified data to which they have access

tentd is the current reference Tent server.

### Apps

Users create and view content on apps. Apps must authenticate with the user's server before content can be posted or viewed.

For example:

1. ian-hanson.me (Ian) posts a status update (post) from a micro blogging app authenticated with his server.
2. The app publishes the post to his server.
3. His server sends a notification to every server following him or mentioned in the post with permission to see the post.
4. If anna-collins.me (Anna) is following Ian, her server will receive a notification from Ian’s server containing the post.
5. If Anna has an app setup for consuming status updates, her server will send it a notification with Ian’s post.
6. Anna can now read Ian’s post from the status app.
7. If Anna decides to reply, her response will follow a path inverse to Ian’s post.

TentStatus is an open source Tent app for creating and viewing status posts.

### Posts

Posts are at the core of Tent. They are sent to followers immediately after being created. Users set permissions on each post that determine which other users can access them. Other users can fetch public posts individually or over a date range. Posts each have a post type which describes its data. Tent posts can be used to describe anything, and developers can create new post types for different kinds of media, interactions, or applications. This documentation describes four basic post types: **status**, short messages of 140 characters or less, **essay**, longer form writing, **photo**, pictures, and **album**, a collection of **photo** posts. 

### Profiles

Every Tent entity's server has a profile JSON file describing it. They store information about the user, specifically static information that should always be accessible.

The most basic profile
has a single object containing the Tent version, the entity name (e.g.
johnsmith.me), an array of supported licences, and an array of servers
containing canonical API roots.

A user may have multiple versions of the same info type in your profile.

### Notifications

Tent notifications are used when a server needs to let another server or app
know about new content updates. This includes new posts and profile changes. Notifications are JSON POST requests containing posts.