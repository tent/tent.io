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


## Notifications

Notification from titanous.com to danielsiders.com that new content has been
posted.



## Fetch Post Feed

### GET /posts

#### Parameters

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Required</th>
      <th>Type</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>post_types</code></td>
      <td>Optional</td>
      <td>string</td>
      <td>Specifies the post types and views to return. ex: <code>https://tent.io/types/posts/blog#excerpt,https://tent.io/types/posts/photo#meta</code>
    </tr>
    <tr>
      <td><code>since_id</code></td>
      <td>Optional</td>
      <td>string</td>
      <td>Show posts newer than this id.</td>
    </tr>
    <tr>
      <td><code>before_id</code></td>
      <td>Optional</td>
      <td>string</td>
      <td>Show posts older than this id.</td>
    </tr>
    <tr>
      <td><code>since_time</code></td>
      <td>Optional</td>
      <td>integer</td>
      <td>Show posts made since this time (unix epoch time).</td>
    </tr>
    <tr>
      <td><code>before_time</code></td>
      <td>Optional</td>
      <td>integer</td>
      <td>Show posts made before this time (unix epoch time).</td>
    </tr>
    <tr>
      <td><code>count</code></td>
      <td>Optional</td>
      <td>integer</td>
      <td>The number of posts to return.</td>
    </tr>
  </tbody>
</table>
