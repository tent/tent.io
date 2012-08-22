---
title: App Notifications
---

## App Notifications

If the app does not respond with 2XX, then the server should try again later.

For the purpose of examples, the server entity is thora.me and the app hostname is thoraapp.io

### New Content Notification

Server tells app about new content.

For example, smithson.me (an entity thora.me is following) posts a new status update. thora.me will notify all authorized apps requesting to be notified about status posts (just thoraapp.io for this example):

```
POST /notifications
Host: thoraapp.io
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
[
  {
    "id": "fadb14",
    "entity": "smithson.me",
    "time": 1345317776,
    "scope": "public",
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/status",
        "version": "0.1.0",
        "view": "full"
      },
      "text": "Think different!"
    }
  }
]
```

```
204 No Content
```

### Content Deleted Notification

Server tells app about a deleted post.

For example, thora.me receives a deleted post notification from smithson.me. thora.me already pushed the post to thoraapp.io so it pushes the deleted notification there as well.

```text
POST /notifications
Host: thoraapp.io
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
[
  {
    "id": "d2c519",
    "entity": "smithson.me",
    "time": 1345317776,
    "scope": "public",
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/delete",
        "version": "0.1.0",
        "view": "full"
      },
      "id": "fadb14",
      "entity": "smithson.me"
    }
  }
]
```

```
204 No Content
```

### New Following Notification

Server tells app about new entity it is following.

For example, thora.me follows johnsmith.me. thora.me will notify all authorized apps requesting to be notified about new followings (just thoraapp.io in this example):

```
POST /notifications
Host: thoraapp.io
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
[
  {
    "id": "54f85a",
    "entity": "thora.me",
    "scope": "direct",
    "content": {
      "type": {
        "url": "https://tent.io/types/posts/following",
        "version": "0.1.0",
        "view": "meta"
      },
      "groups": ["friends"],
      "entity": "johnsmith.me"
    }
  }
]
```

```
204 No Content
```

### Deleted Following Notification

Server tells app about an entity it is no longer following.

For example, thora.me is following elza-mraz.me. thora.me stops following elza-mraz.me and notifies all authorized apps requesting to be notified about followings (just thoraapp.io in this example):

```
DELETE /notifications
Host: thoraapp.io
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "id": "5f5ea4",
  "entity": "thora.me",
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/following",
      "version": "0.1.0",
      "view": "meta"
    },
    "id": "54f85a",
    "action": "remove",
    "entity": "elza-mraz.me"
  }
}
```

```
204 No Content
```

### New Follower Notification

Server tells app about new entity that is following it.

For example, koss.me follows thora.me. thora.me sends a notification to all authorized apps requesting to be notified about followers (just thoraapp.io in this example):

```
POST /notifications
Host: thoraapp.io
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "id": "ba8a7f4",
  "entity": "thora.me",
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/follower",
      "version": "0.1.0",
      "view": "meta"
    },
    "action": "add",
    "entity": "koss.me",
    "groups": ["random-people"],
    "name": "Tim Koss"
  }
}
```

```
204 No Content
```

### Deleted Follower Notification

Server tells app about an entity that is no longer following it, or it blocked.

For example, koss.me informs thora.me it no longer follows thora.me. thora.me sends a notification to all authorized apps requesting to be notified about followers (just thoraapp.io in this example):

```
DELETE /notifications
Host: thoraapp.io
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```
```json
{
  "id": "477fc5",
  "entity": "thora.me",
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/follower",
      "version": "0.1.0",
      "view": "meta"
    },
    "action": "remove",
    "id": "ba8a7f4",
    "entity": "koss.me"
  }
}
```

```
204 No Content
```

