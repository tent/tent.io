---
title: Updated Tent Roadmap
kind: article
created_at: March 15, 2013 13:10 EDT
---

Today we released some notes on the changes coming on Tent v0.3. This post will explain the motivation behind many of those changes and lay out the next steps in the evolution of the Tent protocol.

A comlpete list of the proposed changes is available on [Github](https://github.com/tent/tent.io/issues)

## Motivation

Tent 0.3 is a major step towards 1.0 and enables several major new classes of functionality which can be combined to great effect throughout the ecosystem. 

We learned a lot from users, application developers, and hosts during their use of Tent 0.1 and 0.2. 

Today we know a lot more about what Tent can and should do which enabled us to distill the most important parts of Tent. 0.3 is simpler, more consistent, and more powerful. 

By reducing the number of extraneous data types and representations we were able to add features that open a whole new set of possibilities for apps and users. This versions brings us *much* closer to achieving the original vision of Tent.

There are many small and some large optimizations that come in response to requests from developers and seeing how Tent behaves in the wild. We also tried to consolidate as many "breaking changes" as possible into a single version to make future version transitions cleaner for developers and hosts. 


## Major Changes

In addition to performance and stability improvements, v0.3 includes several major structural changes that affect the future of Tent development.

### (Almost) Everything is a post

Posts are Tent's most powerful and expressive data type. Most other information in Tent already inherited many of the features and characteristics of posts including versions and permissions. As the post format evolved it became clear that almost all other information stored in Tent including profiles and relationships could be stored as posts. 

This let us add a number of important new features to posts.

### Post type fragments

Fragments are like subtypes of posts that let developers add more information about the meaning of a post. For example, status posts have the fragment #reply which indicates a post is in reply to another. This allows a great deal of unwanted noise to be removed from users feeds as well as more powerful querying.

### Versions

Tent posts are now essentially a light weight version control system. Each post can have many versions with complex inheritance structures. Users can even specify another user's post as the parent of their own. This will enable Tent-powered collaborative editing apps and allow content to more clearly evolve over time. Each version can also have its own distinct permissions, so a user can keep previous or future versions of a post private or shared with only a limited group (think drafts).

### Status posts

Status posts now support Tent Flavored Markdown which include **bold**, _italic_, ~~strikethrough~~, `code`, [links](https://tent.io), and standardized inline mentions. 

Status posts can also include a media reference like a photo post. This means microblogging apps won't be swamped with photos when an entity uploads all their vacation albums, but users can still share photos easily. 

The `#reply` fragment will also aid in feed cleanup: apps can query for status posts that reply only to someone the user follows, removing extraneous conversations.

### Private mentions

Mentions are increasingly important now that most data is represented as posts. Mentions can be set to private enabling private tags and bcc messaging.

### Tags 

Rather than create a new metadata field, tags are just posts. To tag a post, mention a post of type `tag`. To get a list of posts with a specific tag, just query for posts mentioning the `tag` post.

Tags acn also be used as a sort of topical inbox. Users can tag posts with another user's tags, alerting the author of the tag about the post. Similarly users can query another user's tag post for posts mentioning it publicly. There are a number of ways this can be used to collaborative content aggregation and sharing.

### Batch requests

Applications can now request many posts at once.

## Upgrading

We recommend that hosts update all posts and records in their databases to their 0.3 equivalents. While Tent remains in alpha converting legacy posts will continue to be rocky, but this process will be formalized and simplified before the 1.0 release candidate.

## Roadmap

We have a fairly clear picture of the road to Tent 1.0. Here's how it looks today:

### 0.4

 - Multipart responses
 - Machine readable post schemas
 - Views
 - Streaming
 - Cryptographic signatures

### 0.5

 - Deep linking
 - Post body query syntax
 - Asynchronous login
 - Dependant batch requests
 - Quorum-based actions
 
### 0.6

 - Protocol extensions (including logging)
 
This list will evolve over the coming months and items may be added, edited, removed, or moved to a different release. Continuing at our current pace, we hope to have a release candidate for Tent 1.0 near the end of 2013.
