## Tent Server-Server Communication Protocol

This document describes the protocol that Tent servers use to communicate with
each other.

### Server Discovery

Both discovery methods should be implemented.

#### HTML `link` tag

The `link` tag should be placed in the `head` tag of all HTML pages associated
with the Tent entity.

```html
<link rel="tent" href="https://tent.titanous.com" />
```

#### HTTP Header

The HTTP header allows discovery of Tent servers by just doing a HEAD request
instead of getting the page and parsing it for the `link` tag. It should be
added to all responses associated with the Tent entity.

```text
Link: <https://tent.titanous.com>; rel="tent"
```

There might be multiple `Link` headers which should be tried in order.


### Entity Profile

```text
GET /profile
Accept: application/json
```

```text
200 OK
Content-Type: application/json
```

```json
[
  {
    "type": {
      "url": "https://tent.io",
      "version": "0.1.0"
    },
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "entity": "titanous.com",
    "servers": [
      "https://tent.titanous.com",
      "https://eqt5g4fuenphqinx.onion",
      "https://titn.us/api"
    ]
  },
  {
    "type": {
      "url": "https://tent.io/types/profile/music",
      "version": "0.1.0"
    },
    "bands": [ "foo", "bar" ]
  }
]
```


### Follow an entity

A follow request is required in order to receive notifications about posts
published by an entity.

The `secret` is only returned once and should be persisted along with the `id`
for authentication.

### POST /followers

```text
POST /followers
Content-Type: application/json
Accept: application/json
```

```json
{
  "entity": "danielsiders.com",
  "licenses": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "types": [
    {
      "url": "https://tent.io/types/posts/status",
      "version": "~> 1.1",
      "view": "full"
    },
    {
      "url": "https://tent.io/types/posts/photo",
      "version": "~> 1.0",
      "view": "meta"
    },
  ]
}
```

```text
201 Created
Content-Type: application/json
Location: https://tent.titanous.com/api/followers/775ecf8
```

```json
{
  "id": "775ecf8"
  "secret": "b524ce27f1882bcad98092175fbe7040",
  "mac_algorithm": "hmac-sha-256"
}
```

## Authentication

All requests must be made using SSL.

Authentication is required for all resources except some of the profile and
publicly accessible posts.

Tent uses [MAC Access
Authentication](http://tools.ietf.org/html/draft-ietf-oauth-v2-http-mac-01)
for all requests. The `id` and `secret` from the follow response are used as the
MAC key identifier and MAC key respectively.

All requests must be signed using MAC, and all notifications from the server
are signed as well.

Currently the signatures in example requests are fake, they will be correct when
the documentation generator is done.


## Get Current Following

danielsiders.com checks its following of titanous.com

### GET /followers/:id

```text
GET /followers/775ecf8
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "id": "775ecf8",
  "entity": "danielsiders.com",
  "licenses": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "types": [
    {
      "url": "https://tent.io/types/posts/status",
      "version": "~> 1.1",
      "view": "full"
    },
    {
      "url": "https://tent.io/types/posts/photo",
      "version": "~> 1.0",
      "view": "meta"
    },
  ],
  "mac_algorithm": "hmac-sha-256"
}
```

## Edit Following

### PATCH /followers/:id

```text
PATCH /followers/775ecf8
Accept: application/json
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "id": "775ecf8",
  "entity": "danielsiders.com",
  "licenses": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "types": [
    {
      "url": "https://tent.io/types/posts/status",
      "version": "~> 1.1",
      "view": "full"
    },
    {
      "url": "https://tent.io/types/posts/photo",
      "version": "~> 1.0",
      "view": "thumb"
    },
  ],
  "mac_algorithm": "hmac-sha-256"
}
```

```text
200 OK
Content-Type: application/json
```

```json
{
  "id": "775ecf8",
  "entity": "danielsiders.com",
  "licenses": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "types": [
    {
      "url": "https://tent.io/types/posts/status",
      "version": "~> 1.1",
      "view": "full"
    },
    {
      "url": "https://tent.io/types/posts/photo",
      "version": "~> 1.0",
      "view": "thumb"
    },
  ],
  "mac_algorithm": "hmac-sha-256"
}
```

## Stop Following

### DELETE /followers/:id

```text
DELETE /followers/775ecf8
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```text
204 No Content
```

## Notifications

Notification from titanous.com to danielsiders.com that new content has been
posted.

### POST /notifications

```text
POST /notifications
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
[
  {
    "id": "jA4Mzdh",
    "entity": "titanous.com",
    "time": 1345322351,
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "scope": "public",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/status",
        "version": "0.1.0",
        "view": "full"
      },
      "text": "Tent.io is awesome!"
    }
  }
]
```

### POST /notifications

```text
POST /notifications
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
[
  {
    "id": "8c73440",
    "entity": "titanous.com",
    "time": 1345322351,
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "scope": "public",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/delete",
        "version": "0.1.0",
        "view": "full"
      },
      "id": "jA4Mzdh",
      "entity": "titanous.com",
    }
  }
]
```

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

```text
GET /posts
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```text
200 OK
Content-Type: application/json
```

```json
[
  {
    "id": "jA4Mzdh",
    "entity": "titanous.com",
    "time": 1345322351,
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "scope": "public",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/status",
        "version": "0.1.0",
        "view": "full"
      },
      "text": "Tent.io is awesome!"
    }
  }
]
```

## Fetch Single Post

### GET /posts/:id

```text
GET /posts/jA4Mzdh
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```text
200 OK
Content-Type: application/json
```

```json
{
  "id": "jA4Mzdh",
  "entity": "titanous.com",
  "time": 1345322351,
  "licenses": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "scope": "public",
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/status",
      "version": "0.1.0",
      "view": "full"
    },
    "text": "Tent.io is awesome!"
  }
}
```
