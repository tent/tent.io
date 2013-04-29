---
title: Apps
---

Apps allow users to interact with data in Tent. [OAuth
2.0](https://tools.ietf.org/html/rfc6749) combined with the
[Hawk](https://github.com/hueniverse/hawk) authentication scheme are used for
authorization and authentication.

## Discovery

Typically an entity will provide the app with their Entity URL when logging in.
[Discovery](/docs/servers-entities#discovery) must be performed on the URL in
order to get the meta post with the list of servers and endpoints necessary to
talk to the Tent servers that represent the entity.

{discover_head example}

{discover_meta example}

## Registration

Before going through the OAuth Authorization Grant flow for the first time, the
app must be registered. Registration is the process of creating an app post
using the `new_post` endpoint. The app post contains all of the metadata that
the server needs from the app.

{app_create example}

{app_credentials example}

## OAuth

The `oauth_auth` and `oauth_token` endpoints are utilized for the OAuth
**Authorization Request** and the **Access Token Request** respectively. Tent
implements a subset of OAuth 2.0 that only supports the Authorization Code grant
type. The authorization code is exchanged for the authorization's Hawk
credentials.

{oauth_redirect example}

{oauth_token example}

## Notifications
