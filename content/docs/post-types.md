---
title: Post Types
---

## Post Types

### Status

`https://tent.io/types/post/status/v0.1.0`

**Status** is Tent's take on microblogging. Messages are 140 characters or less and have the option to add a location for the post as well.


{post_status schema}


### Essay

`https://tent.io/types/post/essay/v0.1.0`

**Essay** is a longer piece of writing. It also allows authors to provide a title for the essay, an excerpt for followers who might want to sample before reading the whole piece, and tags to categorize the post. There is no limit on length.


{post_essay schema}

### Photo

`https://tent.io/types/post/photo/v0.1.0`

**Photo** is the post type for sharing pictures. The file itself is attached to the post. Applications can add EXIF data, tags, and a caption to describe the issue, plus a list of albums that include the `photo`.

{post_photo schema}


### Album

`https://tent.io/types/post/album/v0.1.0`

An **album** is a collection of `photo`s. Albums may optionally list a cover photo, description, and title.

{post_album schema}


### Repost

`https://tent.io/types/post/repost/v0.1.0`

A **repost** is a post that points to a post created by another entity.

{post_repost schema}


### Profile

`https://tent.io/types/post/profile/v0.1.0`

A **profile** post notifies followers about modifications to an entity's
profile.

{post_profile schema}


### Delete

`https://tent.io/types/post/delete/v0.1.0`

**Delete** informs followers that a post was deleted.

{post_delete schema}
