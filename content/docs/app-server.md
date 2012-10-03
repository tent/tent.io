---
title: Server API for Apps
---

## Server API for Apps

Users interact with their own server primarily through apps. They can set permissions for different apps to limit the scope of access and control over the server. All requests should be sent to the tent api root, as provided during the first step of authentication via HEAD request to the entity URI.

### GET /profile

Apps can request the user's profile from the server.

{get_profile example}


### PUT /profile/:type

Apps can add or edit information in a user's profile including adding new profile info types. Users choose which apps have permission to make edits and additions to different sections of their profiles.

{update_profile example}


### POST /followings

Apps can tell a server to follow another entity.

{create_following example}

#### URL Parameters

GET parameters can be used to filter and paginate the returned followings.

| Name | Description |
| ---- | ----------- |
| `before_id` | Followings before a specific entity identifier. |
| `since_id` | Followings since a specific entity identifier. |
| `limit` | The number of followings to return (defaults to the maximum of 50). |

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

#### URL Parameters

GET parameters can be used to filter and paginate the returned followers.

| Name | Description |
| ---- | ----------- |
| `before_id` | Followers before a specific entity identifier. |
| `since_id` | Followers since a specific entity identifier. |
| `limit` | The number of followers to return (defaults to the maximum of 50). |

### GET /followers/:id

Apps can request information on a specific follower.

{get_follower example}


### DELETE /followers/:id

Apps can end the user's relationship with a follower, which means that the server will no longer notify
the follower of the user's new posts.  The follower will still be able to get the user's public posts using the API.

{delete_follower example}

### POST /posts

Apps can create posts by sending them to the server. The server will then send notifications to any entities with permission to see the post and who either requested the post type in their following request or who were mentioned in the post.

{create_post example}

### GET /posts

Apps can retrieve posts.  If the request is not authenticated this will return the user's own public posts.
If the request is authenticated and the app has been granted the necessary scopes, this will also return
the user's non-public posts, posts from entities the user follows, and posts that mention the user.

{get_posts example}

#### URL Parameters

GET parameters can be used to filter and paginate the returned posts.

| Name | Description |
| ---- | ----------- |
| `since_id` | Posts made since a specific post identifier. |
| `before_id` | Posts made before a specific post identifier. |
| `since_time` | Posts with `published_at` greater than the specified unix epoch. |
| `before_time` | Posts with `published_at` less than the specified unix epoch. |
| `entity` | Posts published by the specified entity. |
| `post_types` | Posts that match specific comma-separated type URIs. |
| `limit` | The number of posts to return (defaults to the maximum of 200). |


### GET /posts/:id

Apps can retrieve a specific post.

{get_post example}

### Post Attachments

Apps can create a new post with an attachment and send both to the server. Files and binary data are usually transferred as attachments to posts.

{create_post_with_attachments example}

#### GET /posts/:post_id/attachments/:name

Apps can retrieve attachments from a specific post by name and content-type from the server.

{get_post_attachment example}
