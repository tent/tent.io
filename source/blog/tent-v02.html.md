---
title: Tent v0.2
kind: article
date: December 10, 2012 14:05 EDT
---
Tent version 0.2 is now available. All changes to the protocol are additions, no features have been deprecated or removed.

## What's New

Tent v0.2 adds a number of features:

 - **Tent Version** - The [Core profile info section](/docs/info-types#core) contains the version of Tent that a user's server is running. Apps can check this section to determine which features are available on a server.
 - **Retrieving Mentions** - A list of all [public mentions of a post](/docs/app-server#get-postsidmentions) can be retrieved from the original post's creator.
 - **Cursors** - Users' profiles can contain [post-type specific cursors](/docs/info-types#cursor). Feed positions can be shared across applications by modifying these profile sections for the post types they display.
 - **Auth Credential Expiration** - Applications can [request a temporary authorization](/docs/app-auth#request-parameters) that expires at a specific timestamp. This is preferable when an application only requires temorary access to a user's account.
 - **New Auth Credential Request** - Applications can refresh their OAuth tokens.
 - **Pagination Headers** - [Link headers](/docs/app-server#get-posts) to the next and previous pages are available to make paging through results easier.
 - **JSON errors** - All errors are now [returned as JSON](/docs/server-protocol#error-responses) instead of plain text for consistency.
 - **Profile Versioning** - [Profiles](/docs/app-server#get-profiletype) are versioned like posts. Previous versions can be fetched directly or if no version is specified the most recent version is returned.

## What's Next

[tentd](https://github.com/tent/tentd-admin) running Tent v0.2 is now available and contains instructions on performing necessary database migrations. Tent.is is also now running Tent v0.2.

Tent v0.3 is scheduled for release in late January 2013. See the [Tent Roadmap](https://tent.io/blog/tent-roadmap) for more details.
