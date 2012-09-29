---
title: Posts
---

## Posts

Posts are the core of Tent. A post consists of these fields:

{post schema}

### Mentions

Mentions mark a post as mentioning one or more entities and posts. A `mentions`
array looks like this:

```json
[
  {
    "entity": "https://daniel.tent.is"
  },
  {
    "entity": "https://jonathan.tent.is",
    "post": "aa123b3"
  }
]
```

Each mention must have an entity and can also specify an optional post
identifier, which allows replying to posts.


### Types

The post type describes the schema and semantics of the `content` object. Types
are referenced by a url, the last part of the url must be the version of the
type (ex: `/v0.1.0`).

#### Status

`https://tent.io/types/post/status/v0.1.0`

**Status** is Tent's take on microblogging. Messages are 256 characters or less and have the option to add a location for the post as well.  The `text` and `location` fields are optional, but at least one of them must be present.


{post_status schema}


#### Essay

`https://tent.io/types/post/essay/v0.1.0`

**Essay** is a longer piece of writing. It also allows authors to provide a title for the essay, an excerpt for followers who might want to sample before reading the whole piece, and tags to categorize the post. There is no limit on length.


{post_essay schema}

#### Photo

`https://tent.io/types/post/photo/v0.1.0`

**Photo** is the post type for sharing pictures. The file itself is attached to the post. Applications can add EXIF data, tags, and a caption to describe the issue, plus a list of albums that include the `photo`.

{post_photo schema}


#### Album

`https://tent.io/types/post/album/v0.1.0`

An **album** is a collection of `photo`s. Albums may optionally list a cover photo, description, and title.

{post_album schema}


#### Repost

`https://tent.io/types/post/repost/v0.1.0`

A **repost** is a post that points to a post created by another entity.

{post_repost schema}


#### Profile

`https://tent.io/types/post/profile/v0.1.0`

A **profile** post notifies followers about modifications to an entity's
profile.

{post_profile schema}


#### Delete

`https://tent.io/types/post/delete/v0.1.0`

**Delete** informs followers that a post was deleted.

{post_delete schema}



### Creating New Post Types

Tent highly extensible and allows developers to create new post types to support new kinds of media, interactions, and functionality.

#### Guidelines
##### Do

 - **Use snake case for JSON key names.**
 - **Use existing types when possible.** Consider whether a new type is really necessary. Would an existing type work? Contact the maintainer of the type to suggest changes for a future version. Type-creep makes everyone's lives worse. Avoid proliferation.
 - **Fork existing types** Start with what already exists. Common types are familiar to both developers and users. They can more easily support your great new type if it is based of something familiar.
 - **Version your type.** The post type specification supports versions. When it comes time to change your post type, create a new version of the same post type with a different number. Do not overwrite the original or start with a new name. This could lead to confusion and your post type being blocked as spam. 
 - **Document your type.** Eventually another developer or user will want to know how your post type works. Create clear, concise documentation including your contact information.
 - **Collaborate with other developers.** If you have encountered a challenge, it is likely many others have as well. Work with other developers who have similar goals. Create a single post type that serves both your needs instead of two similar, competing types.
 - **Keep it simple.** Users and developers alike benefit from a small set of simple post types. With a small number of types, users can find apps that suit their specific needs and know their data is portable. Developers can build interoperable, compliant apps without reinventing the wheel. Avoid NIH (Not Invented Here) Syndrome and the desire to start from scratch.
 - **Publish your type.** If you have created a new type, publish it to a popular Tent community site (like this one) so other developers can add support for it into their apps.
 
##### Do Not

 - **Create duplicate post types** Multiple post types with the same purpose will create a fragmented ecosystem. Tent was designed to avoid this problem.
 - **Create proprietary post types** Users and other developers expect to be able to view posts in different applications. Limiting which apps can use a post type is against the spirit of Tent.
 - **Create post types with identical names.** Names should disambiguate post types, not confuse them. Choose a different name for your type when possible.
 - **Use deeply nested data structures.** They make querying difficult.
