---
title: Protocol Introduction
---

## The Tent Protocol

Tent is a protocol for distributed social networking. It allows you to control
your data, who has access to it, and what can be done with it.


### API Overview

Tent uses [JSON](http://en.wikipedia.org/wiki/JSON) over HTTP.

Requests are authenticated with [HMAC](http://en.wikipedia.org/wiki/Hash-based_message_authentication_code)
signatures, and apps use [OAuth 2](http://en.wikipedia.org/wiki/OAuth) to access
content on behalf of users.

Client libraries for Ruby, Python, Java, Objective-C, JavaScript, and C++ are coming
soon so you can focus on writing your app.


### Users

Tent users are called entities and are defined by a URI.

**Example:** John Smith's entity might be `johnsmith.me`, implying a [HEAD
request](http://en.wikipedia.org/wiki/HEAD_%28HTTP%29#Request_methods) to
`https://johnsmith.me/` would respond with a `Tent-Server` header pointing to
a Tent API root (e.g. `Tent-Server: https://tent.johnsmith.me`)


### Profiles

Every Tent entity has a profile JSON file describing it. The profile contains an
array of JSON objects each described by an info-type. The most basic profile has
a single object containing the supported Tent version, the entity name (e.g.
johnsmith.me), an array of supported licences, and an array of servers
containing canonical API roots.

You may have multiple versions of the same info type in your profile (e.g. you
might need to support multiple versions of Tent.)


### Servers

Tent servers are the protocol core. A server handles these responsibilities:

- Persisting data
- Notifying other servers about new data
- Ensuring content is only pushed to recipients accepting associated licences
- Managing a list of servers (entities) it is following
- Managing a list of servers (entities) that are following it
- Authorizing apps to access data
- Notifying apps about new or modified data they have access to


### Apps

Tent apps are typically where content is created and consumed.

For example:

1. ian-hanson.me (Ian) posts a status update (post) from a micro blogging app authenticated with his server.
2. The app publishes the post to his server.
3. His server sends a notification to every server following him or mentioned in the post with permission to see the post.
4. If anna-collins.me (Anna) is following Ian, her server will receive a notification from Ian’s server containing the post.
5. If Anna has an app setup for consuming status updates, her server will send it a notification with Ian’s post.
6. Anna can now read Ian’s post from the status app.
7. If Anna decides to reply, her response will follow a path inverse to Ian’s post.


### Posts

Tent posts can be used to describe anything. The term used to describe a piece
of content is __post__. Posts each have a post-type which describes its data.

For example, a post containing a photo would be described by a photo post-type.
The post-type outlines what content keys to expect, in this case it might have
`exif`, `binary`, and `filetype`.


### Notifications

Tent notifications are used when a server needs to let another server or app
know about new content updates. Notifications are JSON webhooks with an array of
Tent posts.
