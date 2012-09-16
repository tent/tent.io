## Tent Server-Server Communication Protocol

This document describes the protocol that Tent servers use to communicate with
each other.

###Basics

Every Tent user is represented by a server. Servers establish and maintain relationships and exchange content between users. 

Applications send new content to servers and receive content from the server.

Servers should always be online and be accessible over HTTPS.

### Server Discovery

Users and applications discover Tent servers in one of two ways: HTTP `Link` Headers and HTML `link` tags. Users can provide multiple links to access their Tent server. Multiple links are usually provided in case a particular address becomes unavailble. When multiple links are listed, they should be listed in order of preference from most preferred to least preferred, and contact attempted in the same order.


#### HTTP `Link` Header

The HTTP header allows discovery of Tent servers by performing a HEAD request
instead of retrieving the entire page and parsing for the `link` tag. It should be
added to all responses associated with the Tent entity. Other pages associated with the user may also serve the same header.


```text
Link: <https://tent.titanous.com/profile>; rel="https://tent.io/rels/profile"
```
or
```text
Link: <https://tent.titanous.com/profile>; rel="https://tent.io/rels/profile", <https://titanous.tent.is/profile>; rel="https://tent.io/rels/profile", <https://tent.jonathan.cloudmir.com/profile>; rel="https://tent.io/rels/profile"
```

#### HTML `link` tag

The `link` tag should be placed in the `head` tag of all HTML pages associated
with the Tent entity.

```html
<link href="https://tent.titanous.com/profile" rel="https://tent.io/rels/profile" />
```


### Follow an entity

Users follow other users to receive new content. Different users create different kinds of content. Follow requests determine who follows whom and what content is delivered to each user in real time. 

Every user can always decide who can see different content. Following is about interest, not permission. Just because someone requests content from a user does not give them access to all of their posts.

There are three ways a follower can specify what information she wants to receive: licenses, post types, and views.

Licenses determine the terms under which content was published. Different users use different licenses for different reasons.

Post types are the kind of content the user created, like statuses, essays, photos, and albums. Anyone can create new post types.

Views specify what kind of content will be sent for each post type. For example, essays can be long so some users might only want to receive an excerpt of each essay before deciding to download the whole thing. Photos and albums can take up lots of space. Requesting an incomplete view of a post type does not mean the user can not download the rest later. A user with permission to see a post can see any of its views. The view types for each post type are defined in that type's description.

By combining these three options, users can request only specific types of content from another user when asking to follow them.

*Example:* A user, https://example.org, wants to follow her friend, https://cloudmir.com. If her request is accepted, https://example.org will receive new updates from https://cloudmir.com as soon as they are created. 

First, https://example.org needs to tell her friend what kind of content she wants to receive directly. Since https://cloudmir.com's server will send out new content immediately to everyone following him, https://example.org needs to think carefully about what to request. Her friend posts lots of photos and statuses which would clutter https://example.org's feed. 

In this case, she wants all of her friend's essays that are published under the Creative Commons Attribution v3.0 license. She can also choose how much information she wants sent to her about each post. The descriptions of each of these *views* can be found with the post type. For essays, she wants the entire post, so she requests the `full` view.

https://cloudmir.com accepts the following request and provides authenitcation credentials to manage future exchanges. https://cloudmir.com also tells https://example.org that he will not tell the public that she is following him.

https://example.org can always request to see other posts by https://cloudmir.com, but only the post types, licenses, and views in her following record will be automatically sent to her.

### POST /followers

{create_follower example}


## Authentication


All requests should be made using SSL.

Authentication is required to access resources that are not marked as public.

Tent uses [MAC Access
Authentication](http://tools.ietf.org/html/draft-ietf-oauth-v2-http-mac-01)
for all requests.

All requests must be signed using MAC, and all notifications from the server
are signed as well.


## Get Current Following

### GET /followers/:id

{get_follower example}


## Edit Following

### PUT /followers/:id

{update_follower example}


## Stop Following

### DELETE /followers/:id

{delete_follower example}


## Fetch Posts

### GET /posts

{follower_get_posts example}

### GET /posts/:id

{follower_get_post example}


## Notifications

Notifications of new content are sent as POST requests to `/posts` and
authenticated using the negotiated credentials.
