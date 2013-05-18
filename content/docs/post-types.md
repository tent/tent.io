---
title: Post Types
---

## Status

`https://tent.io/types/status/v0`

Status is Tent's take on microblogging. Messages contain up to 256 characters of
text and optionally have a location and/or media reference.


### Reply fragment

Status posts that are replies to another status post (mentioning one or more
posts) should set the fragment to
`reply`: `https://tent.io/types/status/v0#reply`

### Markdown

Status posts support a limited variant of Markdown, known as "Tent-flavored
Markdown", in the `text`.

#### Inline Mention

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

#### Span Elements

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

### Counting Characters

The maximum length of the `text` is 256 Unicode characters (also known as code
points). Applications may want to normalize the text using [Unicode
Normalization Form C](http://unicode.org/reports/tr15/) to avoid surprising
users (for example `café` is 5 characters, while `café` is 4).

### Schema

{post_status schema}


## Repost

## Photo

## Album

## Essay

## Cursor

## Tag

## Favorite

## Meta

## Credentials

## Relationship

## Subscription

## Delivery Failure

## Delete

## Group

## App

## App Authorization
