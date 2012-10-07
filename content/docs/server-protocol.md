## Tent Server-Server Communication Protocol

This document describes the protocol that Tent servers use to communicate with
each other.

### Basics

Every Tent user is represented by a server. Servers establish and maintain relationships and exchange content between users. 

Applications send new content to servers and receive content from the server.

Servers should always be online and be accessible over HTTPS.

### Server Discovery

Users and applications discover Tent servers in one of two ways: HTTP `Link` Headers and HTML `link` tags. Users can provide multiple links to access their Tent server. Multiple links are usually provided in case a particular address becomes unavailable. When multiple links are listed, they should be listed in order of preference from most preferred to least preferred, and contact attempted in the same order.

These links can be either absolute or relative URLs.

#### HTTP `Link` Header

The HTTP header allows discovery of Tent servers by performing a HEAD request
instead of retrieving the entire page and parsing for the `link` tag. It should be
added to all responses associated with the Tent entity. Other pages associated with the user may also serve the same header.

```text
Link: <https://tent.titanous.com/profile>; rel="https://tent.io/rels/profile"
```

or

```text
Link: <https://tent.titanous.com/profile>; rel="https://tent.io/rels/profile",
      <https://titanous.tent.is/tent/profile>; rel="https://tent.io/rels/profile",
      <https://tent.jonathan.cloudmir.com/profile>; rel="https://tent.io/rels/profile"
```

#### HTML `link` tag

The `link` tag should be placed in the `head` tag of all HTML pages associated
with the Tent entity.

```html
<link href="https://tent.titanous.com/profile" rel="https://tent.io/rels/profile" />
```

#### Completing the discovery process

The address in the `Link` header or `link` tag points not to the Tent server itself, but to its `/profile` API method.

To get a list of canonical API roots, do this:

* Perform a `GET` request on the profile address using an `Accept: application/vnd.tent.v0+json` header, as specified on the [Server API for Apps](http://tent.io/docs/app-server) page.
* You will get back the profile as a JSON object. The list of API roots will be in `json["https://tent.io/types/info/core/v0.1.0"]["servers"]`.
* You should also get the entity URL from `json["https://tent.io/types/info/core/v0.1.0"]["entity"]`.  This is the canonical entity URL and it might be different than the entity URL you started with before discovery.

There may be more than one API root in the `servers` list.  Like multiple `Link` headers, multiple server URLs should be
treated as backups/fallbacks and tried in the order listed. If a post is successfully sent to one of the listed
servers, then the entity is considered to have received it.

### Follow an entity

To follow a user, send a POST request with acceptable licenses, post types, and
views, and a path to send post notifications to.

To verify the following, the server will first perform discovery on the
`entity`, then send a GET request to the `notification_path` with a `challenge`
parameter that must be returned as the response to the request with a 200 status
code. Subsequent signed GET requests to the notification path with a challenge
must return the challenge as the response body with a 200 in order to verify
that the follow is still active.

Accepted follow requests will respond 200 OK and provide authentication
credentials.

All post notifications will be POSTed to the notification path and signed with
the credentials.

### POST /followers

{create_follower example}


## Notifications

Tent entities communicate with each other using notifications. Notifications are
sent out when a new post is created. New post notifications are sent out to all
entities who subscribed to the post type before the post was published and have
permission to see it. They are also sent to any entities who are mentioned in
the post.

If the entity being notified is following the publishing entity, the
notification will be sent to the `notification_path` that was configured when
the following was created and signed with the exchanged credentials.

If the entity being notified is not following the publishing entity, the
notification will be sent to `/posts`. The notification will be signed if the
publishing entity is following the notification recipient.

A notification is a `POST` request with a body that contains a post in JSON
format.


## Authentication


All requests should be made using SSL.

Authentication is required to access resources that are not marked as public.

Tent uses [MAC Access
Authentication](http://tools.ietf.org/html/draft-ietf-oauth-v2-http-mac-01)
for all requests.

All requests must be signed using MAC, and all notifications from the server
are signed as well.


## Get Current Following

Some details are available on who is following whom. A server can request information about a specific following, including your own current details, as specified below. Only your apps and the follower herself can see the specific details of their following.

### GET /followers/:id

{get_follower example}


## Edit Following

When a user wants to change the licenses, views, or post types she receives, she makes a PUT request.

### PUT /followers/:id

{update_follower example}


## Stop Following

If one user wants to stop following another, a DELETE request will end their relationship.

### DELETE /followers/:id

{delete_follower example}


## Fetch Posts

Following is not the only way to get posts or other content from a user. Anyone can request posts from another user with a GET request. If the requesting user is not authenticated, only public posts will be available. 

### GET /posts

There are a number of parameters available to limit the scope of the request.

{follower_get_posts example}

### GET /posts/:id

It is also possible to retrieve a single post by that post's id. This is useful in retrieving reposted content and 

{follower_get_post example}
