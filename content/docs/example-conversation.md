---
title: Example Tent Conversation
---

## Example Tent Conversation

Jerrold posts an opinionated status to his 'friends' group of followers:

His client posts to his server:

```text
POST https://tent.jerrold.me/posts
Content-Type: application/json
Authorization: Basic siueXXjTBoVvjpJAH8Mi2CB58pxGoGes06F2Yhhv4sh13LEdasECwCBOt+GhE3PiBniMZoiBoOeNUiI+mIUN0w==
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
Authorization: Basic pFxCQ0EIDgJDAkWi1kXr1nHBR2BhrSqY5IGgjgXgwriuuiFI8R+u2jKuw8+DmiJMcUt+08HI55xDeT7KBgnhLQ==
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
Authorization: Basic 8g/A17DuOlwKODrhxr6wKUnm2kmoA7wMHnMtdsj7pTLGcNaoq8wavPgxzd7ihtif2ywPrwJowHaHy8wTexeRCg==
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
Authorization: Basic wMgriYX2cr2kgVFRrrlndRuz4K20pAcm5GZzQ8akYYqSxRHS3mkujksjHkszZhp3IP+EXcA7vYDAt3k/8QIYeQ==
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
Authorization: Basic 3H5i9F6HlFCgdFywnuUN1ATleGgaO1Y+fYTWBBPQ35NzyG9YzLeLRS2xdlibiGl15UQ91w/e61+5F9PM0KGqvQ==
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
Authorization: Basic LfSERqFpMAyaYhWCMsQrZuY+SYwrjAarVqrtYWDkE209igHeo3TbRjWu2hY8r9IeUkXZlyUqicNvkV8zIrUL9Q==
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
Authorization: Basic Em3TI5yRwASeeVlUIEBW5T8rBSKdtwZR9CPZ/8hOphLRwWjOzns1bctZSVFm9MrEdR/jZ61EEPInOl4cvFr8bg==
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
Authorization: Basic SySu6uvpKu+Wc7jpZGStQMTQU6HVLC0TGaH2gyHwmRGNHUOhFiRK0WAN4+6YzXC2qWkiH7DxurpoqCtWFsrH7A==
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
Authorization: Basic siueXXjTBoVvjpJAH8Mi2CB58pxGoGes06F2Yhhv4sh13LEdasECwCBOt+GhE3PiBniMZoiBoOeNUiI+mIUN0w==
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
Authorization: Basic 3H5i9F6HlFCgdFywnuUN1ATleGgaO1Y+fYTWBBPQ35NzyG9YzLeLRS2xdlibiGl15UQ91w/e61+5F9PM0KGqvQ==
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
Authorization: Basic 3H5i9F6HlFCgdFywnuUN1ATleGgaO1Y+fYTWBBPQ35NzyG9YzLeLRS2xdlibiGl15UQ91w/e61+5F9PM0KGqvQ==
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
Authorization: Basic QIGjvhI003diqWIoZlcegn/zSGMpSUheElNZv/uBUEgXE6n2kCNrnu16kLRgZ5keZI37IXStGJUdDH7lZ5mCLQ==
```

It is not on her server, so it attempts to fetch it:

```
GET https://tent.kavon.me/posts/d8c9d3453e33
Content-Type: application/json
Authorization: Basic uzYm8HtmWBAjqBdLA+kmTT4yZc5930ydU/dSQxFDtzFXu0xEfektBCDy/c167JFBOClqmShh0wF3omuqD9Mhvg==
```

She is not authorized to see it, so Kavon’s server responds with:

```
403 Forbidden
```

Her server responds to her client:

```
403 Forbidden
```
