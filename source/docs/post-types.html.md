---
title: Post Types
---

Data is stored in Tent as posts. Posts, like files, are typed. There are a small number of post types specified by the protocol that Tent servers use. Developers are free to create new post types for content/data storage. The list of content post types on this page contains some common types. 

## Protocol Posts

### Meta

`https://tent.io/types/meta/v0`

Every entity has a meta post, it is retrieved during
[discovery](/docs/servers-entities#discovery) by apps and servers. Some of the
`servers[].urls` members are Level 1 URI Templates as defined in [RFC
6570](https://tools.ietf.org/html/rfc6570).

When selecting a server to contact, sort the servers by `servers[].preference`,
preferring lower numbers over higher. If multiple servers have the same
preference, make a random selection. If server errors are encountered and there
is more than one server listed, another should be selected.

Changing the `entity` field triggers a change of the entity identifier that the
server represents. The previous entity must be added to the `previous_entities`
list in the same request.

All entities notified of this change must rewrite their posts with the updated
`entity` and add an `original_entity` parameter where applicable. This applies
to the post `entity` as well as entities used in mentions, version parents,
groups and permissions.

Modified meta posts are sent to all relationships and apps regardless of
subscriptions.

{post_meta schema}

### Credentials

`https://tent.io/types/credentials/v0`

{post_credentials schema}

### Relationship

`https://tent.io/types/relationship/v0`

### Subscription

`https://tent.io/types/subscription/v0`

{post_subscription schema}

### Delivery Failure

`https://tent.io/types/delivery-failure/v0`

{post_delivery-failure schema}

Delivery failure posts indicate delivery to a mentioned recipient was not successful. The post for which delivery failed must be in the `refs` and `mentions` arrays of the delivery failure post (`entity`, `post`, `type`, and `version`) and it's type (excluding fragment) must be the fragment of the delivery failure post.

### Delete

`https://tent.io/types/delete/v0`

Delete posts indicate posts that were deleted via one or more refs of posts or
versions published by the same entity.

### App

`https://tent.io/types/app/v0`

{post_app schema}

### App Authorization

`https://tent.io/types/app-auth/v0`

{post_app-auth schema}

## Content Posts

### Status

`https://tent.io/types/status/v0`

Status is Tent's take on microblogging. Messages contain up to 256 characters of
text and optionally have a location.


#### Reply fragment

Status posts that are replies to another status post (mentioning one or more
posts) should set the fragment to
`reply`: `https://tent.io/types/status/v0#reply`
and ref the mentioned post(s).

#### Markdown

Status posts support a limited variant of Markdown, known as "Tent-flavored
Markdown", in the `text`.

##### Inline Mention

`^[name](0)` is the syntax used to reference an entity. `name` is the display
text and `0` is the index of the mention in the `mentions` array.

```json
{
  // ...
  "mentions": [
    {
      "entity": "https://jesse.tent.is"
    },
    {
      "entity": "https://daniel.tent.is"
    }
  ],
  "content": {
    "text": "Hey ^[Jesse](0) and ^[Daniel](1)!"
  }
}
```

##### Span Elements

A limited set of the Markdown-style span element syntax is supported:

- [link](https://example.com) `[link](https://example.com)`
- _italic_ `_italic_`
- **bold** `*bold*`
- `code` `` `code` ``
- ~~strikethrough~~ `~strikethrough~`

Backslash is used to escape literals (`\*foobar`).

Line breaks are treated literally:

`Some text\n\nSome more text` becomes

```text
Some text

Some more text
```

(rendered with the empty line.)

`Some text\nSome more text` becomes

```text
Some text
Some more text
```

#### Counting Characters

The maximum length of the `text` is 256 Unicode characters (also known as code
points). Applications may want to normalize the text using [Unicode
Normalization Form C](http://unicode.org/reports/tr15/) to avoid surprising
users (for example `café` is 5 characters, while `café` is 4).

#### Schema

{post_status schema}


### Repost

`https://tent.io/types/repost/v0`

A repost is a post that points to a post published by another entity.

The post must include a mention and a single ref of the original post. The type
fragment must be set to the type of the original post.

### Photo

`https://tent.io/types/photo/v0`

A photo post contains a single photo and metadata about it.

{post_photo schema}

### Album

`https://tent.io/types/album/v0`

An album groups photo posts, and has one ref for each included photo.

{post_album schema}

### Essay

`https://tent.io/types/essay/v0`

An Essay is a piece of writing.

{post_essay schema}


### Cursor

`https://tent.io/types/cursor/v0`

A cursor indicates an entity's position in the feed and must have a single post
ref. The fragment must be set to a URI identifying the cursor type.

### Tag

`https://tent.io/types/tag/v0`

A tag is mentioned by other posts in order to categorize them.

{post_tag schema}

### Favorite

`https://tent.io/types/favorite/v0`

A favorite references another post.

The post must include a ref may include a mention of the original post. The type
fragment must be set to the type of the original post.

{post_favorite schema}
