---
title: Post Types
---

## Post Types

Schema for posting content of different types.

### Building your own type

Your type schema needs to have `url`, `version`, `name`, `description`, `views`, and `content`.

| Name            | Required | Type   | Description                                                                                                  | 
| --------------- | -------- | ------ | ------------------------------------------------------------------------------------------------------------ | 
| `url`           | Required | String | The schema url (e.g. https://tent.io/types/posts/video)                                                      |
| `version`       | Required | String | See [Semantic Versioning](http://semver.org/) (e.g. "0.1.0")                                                 | 
| `name`          | Required | String | Name of the type (e.g. Video)                                                                                | 
| `description`   | Required | String | A short description of the type (e.g. "Any video format")                                                    | 
| `views`         | Required | Object | JSON object defining views for the type. `ignore` and `full` are implied and don't need specifying, `meta` is required and should only include meta content keys. `full` includes all content keys, `ignore` is used to ask never to be sent this type of content. | 
| `content`       | Required | Object | JSON object defining possible content key/value pairs.                                                       | 

For example, if you wanted to create a type for post cards the JSON schema might look like this:

```json
{
  "url": "https://tent.io/types/posts/post-card",
  "version": "0.1.0",
  "name": "Post Card",
  "description": "Virtual post cards",
  "views": {
    "meta": ["geo", "photo.exif", "photo.filetype"],
    "photo": ["photo", "geo"],
    "message": ["text", "geo"],
  },
  "content": {
    "text": "Grettings from Toronto",
    "photo": {
      "exif": {},
      "binary": "...",
      "filetype": "jpeg",
    },
    "geo": {
      "lat": 43.753504,
      "lng": -79.408326
    }
  }
}
```

### Text

```json
{
  "url": "https://tent.io/types/posts/text",
  "version": "0.1.0",
  "name": "General Text Post",
  "description": "Text-only blog post",
  "views": {
    "excerpt": ["excerpt"]
  },
  "content": {
    "excerpt": "Snippet of full text...",
    "text": "Full post text",
  }
}
```

#### Content

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `excerpt`       | Required | String | Short excerpt of `text` |
| `text`          | Required | String | Full text of post |

### HTML

```json
{
  "url": "https://tent.io/types/posts/html",
  "version": "0.1.0",
  "name": "HTML post",
  "description": "HTML blog post",
  "views": {
    "excerpt": ["excerpt"]
  },
  "content": {
    "excerpt": "Text only snippet of full HTML...",
    "html": "Full post HTML",
    "text": "Text only representation of HTML"
  }
}
```

#### Content

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `excerpt`       | Required | String | Short text-only excerpt of `html` |
| `html`          | Required | String | Full HTML of post. Disallowed tags are `link`, `script`, and `style` |
| `text`          | Optional | String | Text-only representation of HTML |

### Status

```json
{
  "url": "https://tent.io/types/posts/status",
  "version": "0.1.0",
  "name": "Short status update",
  "description": "160 character or less text post",
  "views": {
  },
  "content": {
    "text": "Omnis provident omnis. Et fuga error modi asperiores esse quis mollitia. In dignissimos odio molestiae qui. Nihil et consequuntur sed aperiam qui libero ##cupidit",
  }
}
```

#### Content

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `text`          | Required | String | plain text up to a limit of 160 character |

### Delete

```json
{
  "url": "https://tent.io/types/posts/delete",
  "version": "0.1.0",
  "name": "Delete",
  "description": "Delete existing post",
  "views": {},
  "content": {
    "id": "entity-post-uid",
    "entity": "entity.com"
  }
}
```

### Following

```json
{
  "url": "https://tent.io/types/posts/following",
  "version": "0.1.0",
  "name": "Following",
  "description": "Describes an entity you are following",
  "views": {},
  "content": {
    "action" "add",
    "entity": "johnsmith.com"
    "id": "your-uid-of-follower",
    "groups" ["random-people"],
    "name": "John Smith"
  }
}
```

| Name              | Required   | Type     | Description                                                                                                    | 
| ----------------- | ---------- | -------- | -------------------------------------------------------------------------------------------------------------- | 
| `action`          | Required   | String   | Possible values: `add`, `remove`, `update`                                                                     | 
| `entity`          | Required   | String   | Any Tent hostname                                                                                              | 
| `id`              | Varies     | String   | The uid representing the following on your Tent server. Required when `action` is set to `remove` or `update`  | 
| `groups`          | Optional   | Array    | List of group names attached to the following on your Tent server.                                             | 
| `name`            | Optional   | String   | The name you use to reference the entity                                                                       | 

### Follower

```json
{
  "url": "https://tent.io/types/posts/follower",
  "version": "0.1.0",
  "name": "Following",
  "description": "Describes an entity that is following you",
  "views": {},
  "content": {
    "action" "add",
    "entity": "johnsmith.com",
    "id": "your-uid-of-follower",
    "groups" ["random-people"],
    "name": "John Smith"
  }
}
```

| Name            | Required | Type   | Description                                                                                                  | 
| --------------- | -------- | ------ | ------------------------------------------------------------------------------------------------------------ |
| `action`        | Required | String | Possible values: `add`, `remove`, `update`                                                                   | 
| `entity`        | Required | String | Any Tent hostname                                                                                            | 
| `id`            | Varies   | String | The uid representing the follower on your Tent server. Required when `action` is set to `remove` or `update` | 
| `groups`        | Optional | Array  | List of group names attached to the follower on your Tent server.                                            | 
| `name`          | Optional | String | The name you use to reference the entity                                                                     | 

### Photo

```json
{
  "url": "https://tent.io/types/posts/photo",
  "version": "0.1.0",
  "name": "Photo",
  "description": "any format of photo",
  "views": {
    "meta": ["exif", "filetype", "caption", "album", "tags"]
  },
  "content": {
    "exif": {
    },
    "binary": "...",
    "filetype": "jpeg",
    "caption": "Short description of photo",
    "album": "travel",
    "tags": ["motion", "dark"]
  }
}
```

#### Content

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `exif`          | Required | Object | [exif](http://en.wikipedia.org/wiki/Exchangeable_image_file_format) key/value pairs |
| `filetype`      | Required | String | Type of photo (e.g. png) |
| `binary`        | Required | String | Base64 encoded photo binary |
| `caption`       | Optional | String | Short description of photo (max of 160 characters) |
| `album`         | Optional | String | Name of album photo belongs to |
| `tags`          | Optional | Array  | List of tags describing the photo |

### Video

```json
{
  "url": "https://tent.io/types/posts/video",
  "version": "0.1.0",
  "name": "Video",
  "description": "any format of video",
  "views": {
    "meta": ["exif", "filetype", "caption", "album", "tags", "length"]
  },
  "content": {
    "exif": {
    },
    "binary": "...",
    "filetype": "mpeg",
    "caption": "Short description of video",
    "album": "travel",
    "tags": ["under the sun"],
    "length": 160
  }
}
```

#### Content

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `exif`          | Required | Object | [exif](http://en.wikipedia.org/wiki/Exchangeable_image_file_format) key/value pairs |
| `filetype`      | Required | String | Type of video (e.g. mpeg) |
| `binary`        | Required | String | Base64 encoded video binary |
| `caption`       | Optional | String | Short description of video (max of 160 characters) |
| `album`         | Optional | String | Name of album video belongs to |
| `tags`          | Optional | Array  | List of tags describing the video |
| `length`        | Required | Number | Length of video in seconds |

### Message

```json
{
  "url": "https://tent.io/types/posts/message",
  "version": "0.1.0",
  "name": "Message",
  "description": "Tent equivalent of email",
  "views": {
    "meta": ["to", "cc", "bcc"]
  },
  "content": {
    "to": ["johndoe.me", "briansmith.com"],
    "cc": ["carla-laura.me"],
    "bcc": [],
    "attachments": [
      {
        "content_type": "jpeg",
        "content_encoding": "base64",
        "binary": "..."
      }
    ]
  }
}
```

#### Content

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `to`            | Required | Array  | List of entities to whom the message is to |
| `cc`            | Optional | Array  | List of entities who are carbon copied |
| `bcc`           | Optional | Array  | List of entities who are blind carbon copied (empty unless you are the sender) |
| `attachments`   | Optional | Array  | List of attachment objects |

##### Attachment Object

| Name               | Required | Type   | Description                                           | 
| ---------------    | -------- | ------ | ----------------------------------------------------- | 
| `content_type`     | Required | String | Type of attachment (e.g. pdf)                         | 
| `content_encoding` | Required | String | Encoding of attachment binary                         | 
| `binary`           | Required | String | Encoded binary of attachment (see `content_encoding`) | 
