---
title: Example Tent Conversation
---

## Example Tent Conversation

Jerrold posts an opinionated status to his 'friends' group of followers:

His client posts to his server:

```text
POST https://tent.jerrold.me/posts
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
    "friends"
  ],
  "licences": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/status",
      "version": "1.2.0"
    },
    "text": "I love kittens!"
  }
}
```

```text
201 Created
```

Jerrold has Kavon and Shirley in his friends group of followers.

His server lets the recipients know about the post:

```text
POST https://tent.kavon.me/notifications
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
    "entity": "jerrold.me",
    "time": 1345317062,
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "scope": "limited",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/status",
        "version": "1.2.0"
      },
      "text": "I love kittens!"
    }
  }
]
```

```text
200 OK
```

```text
POST https://shirley.me/tent/notifications
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
    "entity": "jerrold.me",
    "time": 1345317062,
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "scope": "limited",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/status",
        "version": "1.2.0"
      },
      "text": "I love kittens!"
    }
  }
]
```

```text
200 OK
```

Their servers instantly propigate the post to designated clients:

```text
POST https://status-updates.kavon.me/notifications
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
    "entity": "jerrold.me",
    "time": 1345317062,
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "scope": "limited",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/status",
        "version": "1.2.0",
        "view": "full"
      },
      "text": "I love kittens!"
    }
  }
]
```

```text
200 OK ## response can be any 200 series http code
```

Shirley has her client in maintenence mode; jerrold.me will attempt to deliver the notification later using an exponential backoff algorithm.

```text
POST https://shirley.me/status-updates/notifications
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
    "entity": "jerrold.me",
    "time": 1345317062,
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "scope": "limited",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/status",
        "version": "1.2.0",
        "view": "full"
      },
      "text": "I love kittens!"
    }
  }
]
```

```text
503 Service Unavailable
```

Kavon responds to the post:

```text
POST https://tent.kavon.me/posts
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "time": 1345409893,
  "recipients": [
    "jerrold.me"
  ],
  "licences": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "mentions": [
    {
      "id": "jA4Mzdh",
      "entity": "jerrold.me"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/photo",
      "version": "0.6.0"
    },
    "exif": { ... },
    "binary": "...",
    "filetype": "jpeg",
    "caption": "Cute Kitten"
  }
}
```

```text
201 Created
```

His server sends it along to Jerrold’s server:

```text
POST https://tent.jerrold.me/notifications
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
[
  {
    "id": "d8c9d3453e33",
    "time": 1345409893,
    "licences": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "mentions": [
      {
        "id": "jA4Mzdh",
        "entity": "jerrold.me"
      }
    ],
    "scope": "direct",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/photo",
        "version": "0.6.0"
      },
      "exif": { ... },
      "binary": "...",
      "filetype": "jpeg",
      "caption": "Cute Kitten"
    }
  }
]
```

```
200 OK
```

Jerrold’s server instantly propagates it to his client:

```
POST https://status.jerrold.me/notifications
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
[
  {
    "id": "d8c9d3453e33",
    "time": 1345409893,
    "licences": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "mentions": [
      {
        "id": "jA4Mzdh",
        "entity": "jerrold.me"
      }
    ],
    "scope": "direct",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/photo",
        "version": "0.6.0"
      },
      "exif": { ... },
      "binary": "...",
      "filetype": "jpeg",
      "caption": "Cute Kitten"
    }
  }
]
```

```
200 OK
```

Jerrold sees Kavon’s reply and reposts it to his friends:

```
POST https://tent.jerrold.me/posts
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "time": 1345410615,
  "recipients": [
    "friends"
  ],
  "licences": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "mentions": [
    {
      "id": "jA4Mzdh",
      "entity": "jerrold.me"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/repost",
      "version": "1.0.0"
    },
    "entity": "kavon.me",
    "id": "d8c9d3453e33"
  }
}
```

```
201 Created
```

Shirley’s client is back up and receives the two posts:

```
POST https://shirley.me/status-updates/notifications
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
    "entity": "jerrold.me",
    "time": 1345317062,
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "scope": "limited",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/status",
        "version": "1.2.0",
        "view": "full"
      },
      "text": "I love kittens!"
    }
  }
]
```

```
200 OK
```

```
POST https://shirley.me/status-updates/notifications
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "id": "d0f2eeb833e8",
  "time": 1345410615,
  "licences": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "mentions": [
    {
      "id": "jA4Mzdh",
      "entity": "jerrold.me"
    }
  ],
  "scope": "limited",
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/repost",
      "version": "1.0.0"
    },
    "entity": "kavon.me",
    "id": "d8c9d3453e33"
  }
}
```

```
200 OK
```

Her client requests Kavon’s post:

```
GET https://shirley.me/tent/posts/d8c9d3453e33
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

It is not on her server, so it attempts to fetch it:

```
GET https://tent.kavon.me/posts/d8c9d3453e33
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

She is not authorized to see it, so Kavon’s server responds with:

```
403 Forbidden
```

Her server responds to her client:

```
403 Forbidden
```
