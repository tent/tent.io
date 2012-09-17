---
title: Protocol Introduction
---
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

Tent **servers** are the protocol core. They represent the users and maintain their data and relationships. Servers also handle these responsibilities:
 
- Persisting data
- Notifying other servers about new data
- Ensuring content is only pushed to recipients accepting associated licences
- Managing a list of servers (entities) it is following
- Managing a list of servers (entities) that are following it
- Authorizing apps to access data
- Notifying apps about new or modified data to which they have access

[tentd](https://github.com/tent/tentd) is the current reference Tent server.

### Apps

Users create and view **posts** and **profiles** on **apps**. Apps must authenticate with the user's server before content can be posted or viewed.

The Process:

1. User A creates a `status` post on her app.
2. App sends posts to user A's server.
3. User A's Server sends post notifications to all users who follow User A's `status` posts and users mentioned in this post. The server will not send notifications to users not allowed in the post's permissions.
4. The servers operated by user A's followers each receive this notification.
5. These servers each send the post to the appropriate app(s).
6. The following users can view the post on their apps.

TentStatus is an open source Tent app for creating and viewing status posts.

### Posts

**Posts** are at the core of Tent. Posts are sent to followers immediately after being created. 

Users set permissions on each post that determine which other users can access them. Other users can fetch public posts individually or over a date range. 

Post types describe the format and content of each post. Tent posts can be used for almost anything, and developers can create new post types for different kinds of media, interactions, or applications. 

This documentation describes four basic post types: `status`, short messages of 140 characters or less, `essay`, longer form writing, `photo`, pictures, and `album`, a collection of `photo` posts. 

### Profiles

Every Tent entity's server has a **profile** JSON file describing it. Profiles store information about the user, specifically static information that should always be accessible.

The most basic profile has a single object containing the Tent version, the entity name (e.g.
johnsmith.me), an array of supported licences, and an array of servers
containing canonical API roots.

A user may have multiple versions of the same info type in their profile.

### Notifications

Tent **notifications** are used when a server needs to let another server or app
know about new content updates. This includes new posts and profile changes. Notifications are JSON POST requests containing posts. A new notification is sent for event (post, following event, profile change).

### Example

https://cloudmir.com/ (Lindsay) and https://titanous.com (Jonathan) are both following https://daniel.tent.is (Daniel) and have requested all his status posts. 

2. https://daniel.tent.is creates a `status` post on TentStatus in which he mentions another user, https://jesse.tent.is (Jesse). 

3. TentStatus sends this post to Daniel's server.

4. Daniel's server sends post notifications to Lindsay and Jonathan, because they follow Daniel and requested all `status` posts he creates, and Jesse, because the post mentions him.

5. Lindsay, Jonathan, and Jesse's servers receive the post and send a copy of the post to TentStatus, the application they each have configures to read `status` posts.

6. Lindsay, Jonathan, and Jesse can each read, reply to, repost, or ignore the post as they wish.

![diagram](/assets/images/diagram.png)