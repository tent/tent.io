---
title: Server API for Apps
---

## Server API for Apps

Users interact with their own server primarily through apps. They can set permissions for different apps to limit the scope of access and control over the server.

### GET /profile

Apps can request the user's profile from the server.

{get_profile example}


### PUT /profile/:type

Apps can add or edit information in a user's profile including adding new profile info types. Users choose which apps have permission to make edits and additions to different sections of their profiles.

{update_profile example}


### POST /followings

Apps can tell a server to follow another entity.

{create_following example}


### GET /followings

Apps can also retrieve a list of the entities currently being followed.

{get_followings example}


### GET /followings/:id

Apps can request information on the relationship with a specific entity being followed.

{get_followings example}


### DELETE /followings/:id

Apps can request the server stop following a specific entity.

{delete_following example}


### GET /followers

Apps can get a list of current followers.

{get_followers example}


### GET /followers/:id

Apps can request information on a specific follower.

{get_follower example}


### DELETE /followers/:id

Apps can end the user's relationship with a follower.

{delete_follower example}

### POST /posts

Apps can create posts by sending them to the server. The server will then send notifications to any entities with permission to see the post and who either requested the post type in their following request or who were mentioned in the post.

{create_post example}

### GET /posts

Apps can retrieve posts.

{get_posts example}


### GET /posts/:id

Apps can retrieve a specific post.

{get_post example}

### Post Attachments

Apps can create a new post with an attachment and send both to the server. Files and binary data are usually transferred as attachments to posts.

{create_post_with_attachments example}

#### GET /posts/:post_id/attachments/:name

Apps can retrieve attachments from a specific post by name and content-type from the server.

{get_post_attachment example}
