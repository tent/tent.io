---
title: API Endpoints
layout: docs
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

<div class='panel panel-primary'>
  <div class='panel-heading'>POST new_post</div>

  <div class='panel-body'>
    {new_post example}
  </div>
</div>

### Attachments

<div class='panel panel-primary'>
  <div class='panel-heading'>POST new_post</div>

  <div class='panel-body'>
    {new_multipart_post example}
  </div>
</div>


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

[**Pagination Diagram**](<%= asset_path('tent_pagination.png') %>)

### Examples

<div class='panel panel-primary'>
  <div class='panel-heading'>GET posts_feed</div>

  <div class='panel-body'>
    {posts_feed example}
  </div>
</div>

#### Refs

<div class='panel panel-primary'>
  <div class='panel-heading'>GET posts_feed</div>

  <div class='panel-body'>
    {posts_feed_refs example}
  </div>
</div>

#### Conditional Request

<div class='panel panel-primary'>
  <div class='panel-heading'>GET posts_feed</div>

  <div class='panel-body'>
    {posts_feed_304 example}
  </div>
</div>

#### HEAD Request (Count)

<div class='panel panel-primary'>
  <div class='panel-heading'>HEAD posts_feed</div>

  <div class='panel-body'>
    {posts_feed_count example}
  </div>
</div>

## post

### Create New Version

<div class='panel panel-primary'>
  <div class='panel-heading'>PUT post</div>

  <div class='panel-body'>
    {new_post_version example}
  </div>
</div>

### Get (with refs)

<div class='panel panel-primary'>
  <div class='panel-heading'>GET post</div>

  <div class='panel-body'>
    {post_refs example}
  </div>
</div>

### Mentions

<div class='panel panel-primary'>
  <div class='panel-heading'>GET post</div>

  <div class='panel-body'>
    {post_mentions example}
  </div>
</div>

<div class='panel panel-primary'>
  <div class='panel-heading'>HEAD post</div>

  <div class='panel-body'>
    {post_mentions_count example}
  </div>
</div>

### Versions

<div class='panel panel-primary'>
  <div class='panel-heading'>GET post</div>

  <div class='panel-body'>
    {post_versions example}
  </div>
</div>

<div class='panel panel-primary'>
  <div class='panel-heading'>HEAD post</div>

  <div class='panel-body'>
    {post_versions_count example}
  </div>
</div>

### Child Versions

<div class='panel panel-primary'>
  <div class='panel-heading'>GET post</div>

  <div class='panel-body'>
    {post_children example}
  </div>
</div>

<div class='panel panel-primary'>
  <div class='panel-heading'>HEAD post</div>

  <div class='panel-body'>
    {post_children_count example}
  </div>
</div>

## attachment

<div class='panel panel-primary'>
  <div class='panel-heading'>GET attachment</div>

  <div class='panel-body'>
    {get_attachment example}
  </div>
</div>

## post_attachment

<div class='panel panel-primary'>
  <div class='panel-heading'>GET post_attachment</div>

  <div class='panel-body'>
    {get_post_attachment example}
  </div>
</div>

## batch

Documentation pending

## server_info

Documentation pending

## oauth_auth

<div class='panel panel-primary'>
  <div class='panel-heading'>GET oauth</div>

  <div class='panel-body'>
    {oauth_redirect example}
  </div>
</div>

## oauth_token

<div class='panel panel-primary'>
  <div class='panel-heading'>POST oauth_token</div>

  <div class='panel-body'>
    {oauth_token example}
  </div>
</div>
