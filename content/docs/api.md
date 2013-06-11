---
title: API Endpoints
---

## Concepts

### Pagination

All post lists (feed, versions, children, mentions) support pagination. The
response to a list request contains a set of links to other pages. These links
are just the query part of the URL ("?" followed by zero or more query
parameters) and contain all filtering and limiting parameters specified in the
request plus additional/updated parameters that specify a page. Links to the
current page and pages that do not exist are omitted.

```json
{
  "pages": {
    "first": "?page=1",
    "prev": "?page=1",
    "next": "?page=2",
    "last": "?page=4"
  }
}
```

### Response Envelope

{data schema}

## new_post

{new_post example}

### Attachments

{new_multipart_post example}

## posts_feed

### Sorting

The feed is sorted in descending order by timestamp. The timestamp used to sort
is specified with the `sort_by` parameter, and defaults to `received_at`. The
most recent version of each post is shown, as determined by sorting the
versions with the version timestamp equivalent to the one specified in
`sort_by`. For example if `sort_by` is `received_at`, the version shown is the
most recent as sorted by `version.received_at`. When there are duplicate
timestamps, the natural byte order of the version identifier is used to maintain
a deterministic sort.

### Parameters

| Parameter | Value |  Description |
| --------- | ----- | ------------ |
| `limit` | Integer | The maximum number of posts to return. Defaults to `25`. |
| `max_refs` | Integer | The maximum number of refs to return per post. Defaults to `0`. |
| `sort_by` | String | Specifies the sort order. One of `received_at`, `published_at`, `version.received_at` or `version.published_at`. Defaults to `received_at`. |
| `since` | String | Requests posts published after the specified timestamp. The last post on the page is the first post published after the specified timestamp. The timestamp is in milliseconds since the Unix epoch, and may be optionally followed by a space and a post version. |
| `until` | String | Requests posts published after the specified timestamp. The first post on the page is the most recent post published. Must not be combined with `since`. The timestamp is in milliseconds since the Unix epoch, and may be optionally followed by a space and a post version. |
| `before` | String | Requests posts published before the specified timestamp. The first post on the page is the most recent post published before the specified timestamp unless combined with `since`. The timestamp is in milliseconds since the Unix epoch, and may be optionally followed by a space and a post version. |
| `types` | String | Limits posts by comma-separated post types. Types with no fragment match all posts of the specified base type. |
| `entities` | String | Selects posts published by one or more comma-separated entities. |
| `mentions` | String | Selects posts that mention specified entities and posts. One or more comma-separated mentions may be specified. Each mention is a entity url optionally followed by a space and a post ID. Multiple `mentions` parameters may be specified. |

[**Pagination Diagram**](<%= image_url('tent_pagination.png') %>)

### Examples

{posts_feed example}

#### Refs

{posts_feed_refs example}

#### Conditional Request

{posts_feed_304 example}

#### HEAD Request (Count)

{posts_feed_count example}

## post

### Create New Version

{new_post_version example}

### Get (with refs)

{post_refs example}

### Mentions

{post_mentions example}

#### HEAD (Count)

{post_mentions_count example}

### Versions

{post_versions example}

#### HEAD (Count)

{post_versions_count example}

### Child Versions

{post_children example}

#### HEAD (Count)

{post_children_count example}

## attachment

{get_attachment example}

## post_attachment

{get_post_attachment example}

## batch

## server_info

## oauth_auth

{oauth_redirect example}

## oauth_token

{oauth_token example}
