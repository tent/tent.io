## Tent Server-Server Communication Protocol

This document describes the protocol that Tent servers use to communicate with
each other.

### Server Discovery

Server discovery is done through HTTP `Link` headers as well as HTML `link`
tags. Multiple links may be presented, and should be tried by the client in
order.

#### HTTP `Link` Header

The HTTP header allows discovery of Tent servers by just doing a HEAD request
instead of getting the page and parsing it for the `link` tag. It should be
added to all responses associated with the Tent entity.


```text
Link: <https://tent.titanous.com/profile>; rel="https://tent.io/rels/profile"
```

#### HTML `link` tag

The `link` tag should be placed in the `head` tag of all HTML pages associated
with the Tent entity.

```html
<link href="https://tent.titanous.com/profile" rel="https://tent.io/rels/profile" />
```


### Follow an entity

A follow request is required in order to receive notifications about posts
published by an entity.

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
