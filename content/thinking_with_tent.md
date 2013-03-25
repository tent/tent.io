Tent applications work differently than centralized web apps or isolated desktop and mobile applications.

This page describes how a number os simple Tent applicationns are architected.

## Remember

 - Users' Tent servers should be the primary data store
 - Use common post types to make data accessible across applications

## Applications

### Microblogging
  
  One of the simplest uses of Tent is microblogging.

  The `status` post type allows short messages (up to 256 characters) with basic formatting and the ability to mention other users inside a post.
    
  The simplest status app would use a single query: `GET /posts?types=https://tent.io/types/status/v0`. This app would display all status posts that the user's server has come into contact with. 

  A more sophisticated application could filter less relevant conversations from a user's feed and set up a separate section of the app for mentions of the user. `GET /posts?types=https://tent.io/types/status/v0#` will fetch status posts strictly (only plain status posts, no replies or other subtypes). Add this query `GET /posts?types=https://tent.io/types/status/v0#reply&mentions=followings` to show conversations between entities that the user follows. Status posts by other entities that mention the user can be retrieved using `GET /posts?types=https://tent.io/types/status/v0#&mentions=https://daniel.cupcake.is`
