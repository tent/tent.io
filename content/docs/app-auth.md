---
title: App Authentication
---

## App Authentication

Tent uses [OAuth 2](http://tools.ietf.org/html/draft-ietf-oauth-v2-31) for app
authentication. Because of the distributed nature of Tent,
apps must register with the Tent entity before starting the authentication flow.

After the authentication flow is complete, requests are authenticated using the credentials
with [MAC Access
Authentication](http://tools.ietf.org/html/draft-ietf-oauth-v2-http-mac-01).


### App Registration

Before authenticating a user, the application must be registered with the
specified Tent entity. The first step is to perform discovery on the provided
entity url.

{discovery example}

The next step is to register the application with the server. Registration
specifies some details about the app, as well as the exact `redirect_uris` that
will be used during the OAuth flow. The response `id`, `secret`, and
`mac_algorithm` are used to authenticate future requests to the Tent server.
The `id` is used as the `client_id` in all OAuth requests.

{create_app example}

#### App JSON Schema

{app schema}

### Authentication Flow


#### Auth Request

The app requests the user's Tent identifier, and performs discovery on it to
find the Tent API root. The app then builds an auth request and redirects the
user-agent to it:

```text
/oauth/authorize?client_id={app_id var}
  &redirect_uri=http://app.example.com/tent/callback
  &scope=read_posts,read_profile
  &state=87351cc2f6737bfc8ba
  &tent_profile_info_types=https://tent.io/types/info/music/v0.1.0
  &tent_post_types=https://tent.io/types/posts/status/v0.1.0,https://tent.io/types/posts/photo/v0.1.0
```

##### Parameters

| Name                        | Required  | Description |
| --------------------------- | --------- | ----------- |
| `client_id`                 | Required  | The `id` obtained by registering with the Tent server |
| `redirect_uri`              | Required  | The URI to redirect to after authentication is complete. It must **exactly** match a URI (including parameters) provided during app registration in `redirect_uris`. |
| `state`                     | Optional  | This parameter will be added to the `redirect_uri` and should always be set to a random string that is stored in the session, and then verified to prevent cross-site request forgery attacks. |
| `scope`                     | Optional  | A comma-separated list of scopes that the app is requesting access to. |
| `tent_profile_info_types`   | Optional  | A comma-separated list of profile info type urls that the app is requesting access to. Set to `all` to request full access to the profile. |
| `tent_post_types`           | Optional  | A comma-separated list of type urls that the app is requesting access to. Set to `all` to request access to all posts. |
| `tent_notification_url`     | Optional  | The URI to send post notifications to. |


##### Scopes

| Scope              | Description                                                            |
| ------------------ | ---------------------------------------------------------------------- |
| `read_profile`     | Read profile sections listed in the `profile_info` parameter           |
| `write_profile`    | Read and write profile sections listed in the `profile_info` parameter |
| `read_followers`   | Read follower list                                                     |
| `write_followers`  | Read follower list and block followers                                 |
| `read_followings`  | Read followings list                                                   |
| `write_followings` | Read followings list and follow new entities                           |
| `read_posts`       | Read posts with types listed in the `post_types` parameter             |
| `write_posts`      | Read and publish posts with types listed in the `post_types` parameter |


#### Redirect

After the user has authorized the application, the Tent server will redirect the
User-Agent back to the specified `redirect_uri` with a `code` that can be used
to retrieve authentication details from the server.

The `state` parameter should be matched against the `state` parameter sent in
the initial request to prevent request forgery.

```text
HTTP/1.1 302 Found
Location: http://app.example.com/tent/callback?code={app_code var}&state=87351cc2f6737bfc8ba
```

#### Access Token

The `code` must be traded for permanent authentication details that can be used
to access the Tent server on behalf of the user.

##### POST /apps/:id/authorizations

The request must be signed with a MAC using the secret obtained during app
registration. Currently only the `mac` `token_type` is supported.

{app_auth example}

##### Response Parameters

| Name            | Description                                      |
| --------------- | ------------------------------------------------ |
| `access_token`  | Used as the MAC key identifier.                  |
| `mac_key`       | Used as the MAC key for requests.                |
| `mac_algorithm` | The MAC algorithm to be used.                    |
| `token_type`    | Specifies the token type. Currently always `mac` |


### Request Authentication

Tent uses [HTTP MAC Access
Authentication](http://tools.ietf.org/html/draft-ietf-oauth-v2-http-mac-01) to
authenticate app requests. Requests to modify the app's registration details
must be authorized using the provided `id` and `secret` as the
MAC key identifier and MAC key respectively.

Requests to the Tent server on behalf of an authenticated user must be
authorized using the credentials retrieved at the end of the auth flow.
The `access_token` and `mac_key` are the MAC key identifier and MAC key
respectively.


### App Registration Modification

An app can change its metadata (name, icon, etc) after it's already been
approved by the user, but it cannot change its permissions.

The request must be authenticated with a MAC generated using the secret
from the initial registration.

#### GET /apps/:id

{get_app example}

#### PUT /apps/:id

{update_app example}
