---
title: Server API for Apps
---

## Server API for Apps

### Get profile

Tent servers are required to have a profile JSON file describing their setup. The JSON is formatted as an array of info-types.

Your app, or a third party app your using, will request the profile JSON from your server initially and will be notified when it changes. This will allow it to display your name and other personal information (within the scope of its permissions), and use canonical servers if your primary one goes down.

```
GET /profile
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```
200 OK
Content-Type: application/json
```
``` json
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
    "entity": "smith.me",
    "servers": [
      "https://tent.smith.me",
      "https://eqt5g4fuenphqinx.onion",
      "https://smi.th/api"
    ]
  },
  {
    "type": {
      "url": "https://tent.io/types/info/music",
      "version": "0.1.0"
    },
    "bands": [ "foo", "bar" ]
  }
]
```

### Update profile.json

If given permission, an app can update your profile JSON. An app can have permission to update all or just specific sections of the file.

```
PATCH /profile
Accept: application/json
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
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
    "entity": "smith.me",
    "servers": [
      "https://tent.smith.me",
      "https://eqt5g4fuenphqinx.onion",
      "https://smi.th/api"
    ]
  },
  {
    "type": {
      "url": "https://tent.io/types/info/music",
      "version": "0.1.0"
    },
    "bands": [ "foo", "bar", "baz" ]
  }
]
```

```
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
    "entity": "smith.me",
    "servers": [
      "https://tent.smith.me",
      "https://eqt5g4fuenphqinx.onion",
      "https://smi.th/api"
    ]
  },
  {
    "type": {
      "url": "https://tent.io/types/info/music",
      "version": "0.1.0"
    },
    "bands": [ "foo", "bar", "baz" ]
  }
]
```

### Get following entities

App gets list of entities your server is following.

```
GET /following
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": "ddc0563f12de",
    "entity": "johnsmith.me",
    "groups": ["friends"],
    "licenses": [
      {
        "url": "http://license.org/free-speach",
        "version": "0.1.0"
      }
    ],
    "post_types": [
      {
        "url": "https://tent.io/post-types/photo",
        "version": "0.1.0"
      }
    ]
  }
]
```

### Follow

App tells server to follow an entity.

```
POST /following
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```
```json
{
  "entity": "elza-mraz.me",
  "groups": ["friends", "business"]
}
```

```
201 Created
```

### Update Following

App changes what groups are applied to an entity your server is following.

#### PATCH /following/:id

```
PATCH /following/bda7f416fbba
Accept: application/json
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```
```json
{
  "entity": "elza-mraz.me",
  "groups": ["business"]
}
```

```
200 OK
Content-Type: application/json
```
```json
{
  "id": "bda7f416fbba",
  "entity": "elza-mraz.me",
  "groups": ["business"]
}
```

### Unfollow

App tells server not to follow an entity.

#### DELETE /following/:id

```
DELETE /following/bda7f416fbba
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```
204 No Content
```

### Followers

App asks for list of entities that are following the server.

```
GET /followers
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": "ddd67278456b",
    "entity": "koss.me",
    "groups": [],
    "full_name": "Tim Koss",
    "display_name": "koss"
  }
]
```

### Update Follower

App tells server to update information about a follower entity.

#### PATCH /followers/:id

```
PATCH /followers/ddd67278456b
Accept: application/json
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```
```json
{
  "entity": "koss.me",
  "groups": ["random-people"],
  "full_name": "Tim Koss",
  "display_name": "koss"
}

```

```
200 OK
Content-Type: application/json
```
```json
{
  "id": "ddd67278456b",
  "entity": "koss.me",
  "groups": ["random-people"],
  "full_name": "Tim Koss",
  "display_name": "koss"
}
```

### Follower

App asks for info about specific follower

```
GET /followers/ddd67278456b
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```
200 OK
Content-Type: application/json
```
```json
{
  "id": "ddd67278456b",
  "entity": "koss.me",
  "groups": ["random-people"],
  "full_name": "Tim Koss",
  "display_name": "koss"
}
```

### Block Follower

App tells server not to send notifications to entity.

```
DELETE /followers/ddd67278456b
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```
204 No Content
```

### Publish

App publishes content to server.

For example, you have an app that manages status updates. You type a status update (post) in the app, your app sends that post to the server with this API.

See [conversation example](https://github.com/tent/tent-docs/blob/master/examples/conversation.md), and [conversation thread example](https://github.com/tent/tent-docs/blob/master/examples/conversation-thread.md) for full examples of publishing content through an app.

```
POST /posts
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```
```json
{
  "time": 1345317062,
  "recipients": [
    "friends",
    "elza-mraz.me"
  ],
  "licences": [
    {
      "url": "https://licences.org/free-speach",
      "version": "0.1.0"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/status",
      "version": "0.1.0",
      "view": "full"
    },
    "text": "Necessitatibus saepe exercitationem. Quidem rem aspernatur atque numquam in. Voluptas qui et.",
    "excerpt": "Necessitatibus saepe exercitationem..."
  }
}
```

```
201 Created
```

### Fetch Single Post

App fetches a specific post from server.

For example, a post your app has previously fetched or otherwise obtained is referencing another post.
```json
{
  "id": "8fec7937f7c1",
  "time": 1342217776,
  "entity": "sheldon.io",
  "scope": "public",
  "licences": [
    {
      "url": "https://licences.org/free-speach",
      "version": "0.1.0"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/repost",
      "version": "0.1.0",
    },
    "id": "3fe1abef41cb",
    "entity": "smithson.me"
  }
}
```

You want to see it, so your app requests it from your server.

#### GET /posts/:id[?params]

```
GET /posts/3fe1abef41cb?entity=smithson%2Eme&fetch=force
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

#### Request Params

| Param    | Required | Possible values | Description |
| -------- | -------- | --------------- | ----------- |
| `fetch`  | Optional | `true`, `force` | When `true`, query listed entity' server when not in own database. When `force`, query listed entity' server instead of own database. |
| `entity` | When the id was generated by another entity | Escaped Hostname of the entity responsible for the id (e.g. `entity=smithson%2Eme`) | Informs the server where to look (e.g. smithson.me) |

```
200 OK
Content-Type: application/json
```
```json
{
  "id": "3fe1abef41cb",
  "time": 1345317776,
  "entity": "smithson.me",
  "scope": "public",
  "licences": [
    {
      "url": "https://licences.org/free-speach",
      "version": "0.1.0"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/repost",
      "version": "0.1.0",
      "view": "full"
    },
    "entity": "elza-mraz.me"
  }
}
```

### Fetch Multiple Posts

App fetches posts from server matching specified criteria.

For example, your app has a stream view showing status updates from you and your followings. Your app paginates in an infinite-scroll pane, fetching 50 more updates when you reach the bottom. If the id of the last post loaded in your stream is `80b445839dd1` and your server Tent API root is `https://tent.johnsmith.io`, fetching the next page might look like this:
```
GET https://tent.johnsmith.io/posts?since_id=80b445839dd1&limit=50
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

#### GET /posts[?params]

```
GET /posts?fetch=false
Accept: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

#### Request Params

Param        | Required | Possible values | Description |
------------ | -------- | --------------- | ----------- |
`fetch`      | No       | `true`, `force` | When `true`, query listed entities’ servers in addition to own database. When `force`, query listed entities' servers instead of own database. |
`entity`     | No       | Comma separated list of escaped Hostnames (e.g. `entity=smithson%2Eme,sheldon%2Eio` would only return content from smithson.me and sheldon.io) | Informs the server where to look. |
`post_types` | No       | Comma separated list of escaped post-type urls (e.g. `?post_types=https%3A%2F%2Ftent%2Eio%2Fpost-types%2Fpost##excerpt,https%3A%2F%2Ftent%2Eio%2Fpost-types%2Fphoto##thumb`) | Informs the server what post-types to return (e.g.  https://tent.io/post-types/post##excerpt and https://tent.io/post-types/photo##thumb) |
`since_id`   | No       | ID recognized by server, or listed entity’s server (if only one entity is listed) | Only return content created after given ID |
`before_id`  | No       | ID recognized by server, or listed entity’s server (if only one entity is listed) | Only return content created before given ID |
`since_time` | No       | UTC epoch timestamp (e.g. 1345575602) | Only return content created after given time |
`before_time`| No       | UTC epoch timestamp (e.g. 1345575602) | Only return content created before given time |
`limit`      | No       | Any positive integer (e.g. 500) | Max number of posts server should return |

```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": "3fe1abef41cb",
    "time": 1345317776,
    "entity": "smithson.me",
    "scope": "public",
    "licences": [
      {
        "url": "https://licences.org/free-speach",
        "version": "0.1.0"
      }
    ],
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/repost",
        "version": "0.1.0",
        "view": "full"
      },
      "entity": "elza-mraz.me"
    }
  }
]
```

