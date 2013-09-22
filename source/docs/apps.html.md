---
title: Apps
layout: docs
---

Apps allow users to interact with data in Tent. [OAuth
2.0](https://tools.ietf.org/html/rfc6749) combined with the [Hawk authentication
scheme](/docs/authentication) are used for authorization and authentication.

## Discovery

Typically an entity will provide the app with their Entity URL when logging in.
[Discovery](/docs/servers-entities#discovery) must be performed on the URL in
order to get the meta post with the list of servers and endpoints necessary to
talk to the Tent servers that represent the entity.

<div class='panel panel-primary'>
  <div class='panel-heading'>HEAD entity</div>

  <div class='panel-body'>
    {discover_head example}
  </div>
</div>

<div class='panel panel-primary'>
  <div class='panel-heading'>GET post</div>

  <div class='panel-body'>
    {discover_meta example}
  </div>
</div>

## Registration

Before going through the OAuth Authorization Grant flow for the first time, the
app must be registered. Registration is the process of creating an app post
using the `new_post` endpoint. The app post contains all of the metadata that
the server needs from the app.

<div class='panel panel-primary'>
  <div class='panel-heading'>POST new_post</div>

  <div class='panel-body'>
    {app_create example}
  </div>
</div>

The response to the post creation request will include a `Link` header that
contains a link to the credentials for the app. The credentials are used in the
*Access Token Request*.

<div class='panel panel-primary'>
  <div class='panel-heading'>GET post</div>

  <div class='panel-body'>
    {app_credentials example}
  </div>
</div>

## OAuth

The `oauth_auth` and `oauth_token` endpoints are utilized for the OAuth
*Authorization Request* and the *Access Token Request* respectively. Tent
implements a subset of OAuth 2.0 that only supports the Authorization Code grant
type. The authorization code is exchanged for the authorization's Hawk
credentials.

To authorize the app, redirect the user to the `oauth_auth` endpoint with the
`client_id` URL parameter set to the `id` field from the previously created app
post. If the app is web-based, the `state` parameter should also be set to
a random value to be verified when the user is redirected back.

<div class='panel panel-primary'>
  <div class='panel-heading'>GET oauth_auth</div>

  <div class='panel-body'>
    {oauth_redirect example}
  </div>
</div>

After the user authorizes the application, the server will redirect to the app's
`redirect_uri` provided in the initial registration. The redirect URL will
include a `code` parameter and the `state` parameter if provided in the initial
redirect. The `code` is then traded by the application for authorized
credentials that may be used to interact with the server. The `access_token` is
used as the ID in Hawk signatures.

<div class='panel panel-primary'>
  <div class='panel-heading'>POST oauth_token</div>

  <div class='panel-body'>
    {oauth_token example}
  </div>
</div>

### App Registration Schema

{post_app schema}

## Notifications
