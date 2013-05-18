---
title: Post Types
---

## Protocol Posts

### Meta

`https://tent.io/types/meta/v0`

### Credentials

`https://tent.io/types/credentials/v0`

{post_credentials schema}

### Relationship

`https://tent.io/types/relationship/v0`

### Subscription

`https://tent.io/types/subscription/v0`

{post_subscription schema}

### Delivery Failure

### Delete

`https://tent.io/types/delete/v0`

{post_delete schema}

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
text and optionally have a location and/or media reference.


#### Reply fragment

Status posts that are replies to another status post (mentioning one or more
posts) should set the fragment to
`reply`: `https://tent.io/types/status/v0#reply`

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

The post must include a mention of the original post. The type fragment must be set to the type of the original post.

{post_repost schema}

### Photo

`https://tent.io/types/photo/v0`

An album groups photo posts.

{post_photo schema}

### Album

`https://tent.io/types/album/v0`

An album groups photo posts.

{post_album schema}

### Essay

`https://tent.io/types/essay/v0`

An Essay is a piece of writing.

{post_essay schema}


### Cursor

`https://tent.io/types/cursor/v0`

A cursor indicates an entity's position in the feed. The fragment must be set to
a URI identifying the cursor type.

{post_cursor schema}

### Tag

`https://tent.io/types/tag/v0`

A tag is mentioned other posts in order to categorize them.

{post_tag schema}

### Favorite

`https://tent.io/types/favorite/v0`

A favorite references another post.

The post must include a mention of the original post. The type fragment must be set to the type of the original post.

{post_favorite schema}
