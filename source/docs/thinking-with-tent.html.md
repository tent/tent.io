---
title: Thinking With Tent
layout: docs
---

Tent applications are designed differently than centralized web apps or isolated
desktop and mobile applications.

This page describes how different types of Tent applications could be architected.

URL query values are shown unencoded for clarity.

## Principles

 - Users' Tent servers should be the primary data store
 - Trust your Tent server: don't client-side encrypt content unless absolutely necessary
 - Use common post types to make data accessible across applications
 - Don't delete old versions of posts unless explicitly requested by the user.

## Examples

### Microblogging

One of the simplest uses of Tent is microblogging.

The `status` post type allows short messages up to 256 characters formatted with
Tent flavored Markdown and the ability to link to other media.

The simplest status app would use a single query: `GET posts_feed` with
`?types=https://tent.io/types/status/v0&entities=following`. This would display
all status posts with which the user's server has come into contact.

A more powerful application could filter less relevant conversations from
a user's feed and separate views for posts that mention the user. `GET
posts_feed` with `?types=https://tent.io/types/status/v0#` will fetch status
posts strictly (only plain status posts, no replies or other subtypes). This
query `GET posts_feed` with
`?types=https://tent.io/types/status/v0#reply&mentions=followings` shows
conversations between entities that the user follows. Status posts by other
entities that mention the user can be retrieved using `GET posts_feed` with
`?types=https://tent.io/types/status/v0#&mentions=https://daniel.tent.is`

### Blogs

Tent powered blogs need up to three separate types of functionality which may be
grouped into one or several different apps working together.

First the user needs a text editor in which to draft and format the blog post.
This application would save the finished entry as an `essay` post type. Private
drafts can be saved as earlier versions of the same post or using another type.
This post will be sent out to all of the user's followers who had subscribed to
the `essay` type.

Users need a way to read `essay` posts. This app should show posts by our user
and all the entities they follow plus comments on these posts. These functions
could be handled in the same application as the editor or another app
altogether.

To fetch all `essay` posts by a user, `GET posts_feed` with
`?types=https://tent.io/types/essay/v0&entities=https://daniel.tent.is`. To fetch
all essay posts from entities the user follows `GET posts_feed` with
`?types=https://tent.io/types/essay/v0&entities=followings`.

You can find all public comments on any post with `GET post` with `Accept:
application/vnd.tent.post-mentions.v0+json`.

To make posts available outside of Tent, another app could generate static sites
based on the user's essay posts that anyone could access in a web browser.

### Community News site

The functionality normally found on community news sites like Reddit and Hacker
News can be replicated with Tent, but would be architected very differently.
Posts and comments are located on their author's Tent server instead of being
aggregated on a single site or database. Three types of posts are needed to
model a basic community new site: `submissions`, `votes`, and `comments`. We may
also want a way of discovering submissions from outside of our social graph.

Submissions are the top-level content and consist of links and/or formatted text
blocks and may be tagged with topics or categories.

Votes are up or down votes added by other users. Vote posts mention the
`submission` they reference and contain an `#up` or `#down` fragment.

To find submissions from those a user follows, `GET posts_feed` with
`?types=https://example.com/types/submissions/v0&entities=followings`

To find up and down votes for each submission, `GET post` with `Accept:
application/vnd.tent.post-mentions.v0+json`.

A new entity could also be created to aid discovery. All users could mention
that entity in their community news posts and it could republish (via an app)
all incoming posts. Users could also tag submissions and comments by mentioning
topic tag posts belonging to that entity (see tags). This approach is
appropriate when post volume has scaled beyond the capacity of the Tent server
of the average community member.


### Todo Lists

There are two ways to architect a todo list app with Tent.

**Option 1**: each to do item is a post.

**Option 2**: each list is a post. The first option is more flexible, the second
is simpler. If you want users to have the freedom to move items from one list to
another or easily provide visibility into the timing of specific events, the
first is preferable.

**Option 1**

Create a new post for every to do item mentioning the post for any lists or
categories it is a part of.

Create a new version of each item post when it's list(s) or state changes

**Option 2**

Create a new list post for each list containing all items with their current
states

Create a new version of each list post whenever an item's state is changed or
the item is deleted

### Collaborative Editing

Tent posts are lightweight version control systems. Each post can have many
immutable versions. Each version specifies its parent(s) one of which must be
a post created by the author. However, a post version may specify a post version
created by another entity as an additional parent. This allows for collaborative
real-time editing applications to be powered by Tent.

A document is created by user A. The application creates a corresponding post
with the initial state of the document on user A's server. This post is just
a list of [operational
transformations](https://en.wikipedia.org/wiki/Operational_transformation). User
A permits user B to access the post. User B modifies the document in her
application which appends user B's transformations to the post. User B's server
sends a copy of the new version to user A's server. Tent's version control
system allows for multiple parents on a single version (version diamonds) so
users also have the option to resolve version conflicts in more complicated
document formats

### Polls and Surveys

A user could easily survey other entities with Tent. The user would create
a `survey` post including the question(s) to be answered, a list of possible
answers, and the time the survey stop accepting responses. Each responding user
would respond with a `survey_response` containing their answer(s). Respondents
choose the permissions for their response post.

To gather the final responses to the survey, `GET post` with `Accept:
application/vnd.tent.post-mentions.v0+json`.

### Music Scrobbling

Create a new `nowplaying` post including the song title, artist, and album
whenever a user starts playing a song on their local device of music service.
Each play should be a new post, not a new version of an earlier `nowplaying`
post.

### Photo Filtering

Tent prefers to preserve original data where possible. In the case of photos,
this means preserving the original photo. Create a post for the original
unaltered photo with the standard `photo` post type and another `photo#filtered`
post type fragment for the filtered photo. This preserves a copy of the original
unaltered photo for posterity and allows querying for all `photo`s (including
the filtered versions), just original `photo#`s, and/or `photo#filtered`s.

To show only filtered photos, `GET posts_feed` with
`?types=https://example.com/types/photo/v0#filtered`

### Calendars

Calendars demonstrate the ease of syncinf content in Tent. Each event would be its own post, say `calendar-event` containing all relevant details. Changes to the event data would be created as new versions of the same post. When a calendar app comes online to sync with the user's server it would request all `calendar-event` posts since its last sync. The results would include all new events and changes to existing events since the last sync.


