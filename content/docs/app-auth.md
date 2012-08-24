---
title: App Authentication
---

## App Authentication

Tent uses [OAuth 2](http://tools.ietf.org/html/draft-ietf-oauth-v2-31) for app
authentication. Because of the distributed nature of Tent, it is necessary for
apps to register with the Tent entity before doing the authentication flow.

After the authentication flow, requests are authenticated using the credentials
with [MAC Access
Authentication](http://tools.ietf.org/html/draft-ietf-oauth-v2-http-mac-01).


### App Registration

Before authenticating a user, the application must be registered with the
specified Tent entity. The first step is to perform discovery on the provided
entity url.

```text
HEAD /
Host: titanous.com
```

```text
200 OK
Link: <https://tent.titanous.com>; rel="tent"
```

The next step is to register the application with the server. Registration
specifies some details about the app, as well as the exact `redirect_uris` that
will be used during the OAuth flow. The response `id`, `secret`, and
`mac_algorithm` are used to authenticate future requests to the Tent server.
The `id` is used as the `client_id` in all OAuth requests.

```text
POST /apps
Content-Type: application/json
Accept: application/json
```

```json
{
  "name": "FooApp",
  "description": "Does amazing foos with your data",
  "url": "http://foooo.com",
  "icon": "http://foooo.com/icon.png",
  "redirect_uris": ["http://fooapp.com/tent/callback"],
  "scopes": {
    "write_profile": "Uses an app profile section to describe foos",
    "read_followings": "Calculates foos based on your followings"
  }
}
```

```text
201 Created
Content-Type: application/json
Location: https://tent.titanous.com/apps/6737b
```


```json
{
  "id": "6737b",
  "secret": "3d2adf9a68bf64f4eaff70a7c7700a8",
  "mac_algorithm": "hmac-sha-256"
}
```

#### Request Parameters

| Name            | Required | Type   | Description |
| --------------- | -------- | ------ | ----------- |
| `name`          | Required | String | The human name of the app to show the user |
| `description`   | Required | String | A short description of the application to show the user |
| `url`           | Required | String | The main url of the app |
| `icon`          | Optional | String | The url to an icon for the app |
| `redirect_uris` | Optional | Array  | A list of **exact** (including parameters) urls that will be used as OAuth `redirect_uri` |
| `scopes`        | Optional | Object | A list of scope key to description value mappings of all scopes that the app might use. The descriptions should describe why the specific scope is necessary for the app to function. |

#### Response Parameters

| Name            | Description |
| --------------- | ----------- |
| `id`            | The identifier of the app. This is used as the MAC key identifier for requests to/from the Tent server, as well as the `client_id` in the OAuth flow. |
| `secret`        | The secret used as the MAC key when modifying the registration and receiving notifications. |
| `mac_algorithm` | The MAC algorithm to be used. |

### App Registration Modification

The request must be authenticated with a MAC generated using the secret from the
initial registration.

#### PATCH /apps/:id

```text
PATCH /apps/aff70a7
Host: tent.titanous.com
Content-Type: application/json
Accept: application/json
Authorization: MAC id="aff70a7",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "name": "FooApp",
  "description": "Does amazing foos with your data",
  "url": "http://foooo.com",
  "icon": "http://foooo.com/icon.png",
  "redirect_uris": ["http://fooapp.com/tent/callback"],
  "scopes": {
    "write_profile": "Uses an app profile section to describe foos",
    "read_followings": "Calculates foos based on your followings"
  }
}
```


### Authentication Flow

#### Auth Request

The app requests the user's Tent identifier, and performs discovery on it to
find the Tent API root. The app then builds an auth request and redirects the
user-agent to it:

```text
/auth?client_id=6737b
  &redirect_uri=http://fooapp.com/tent/callback
  &scope=read_posts,read_profile
  &state=87351cc2f6737bfc8ba
  &tent_profile_info_types=https://tent.io/types/info/music
  &tent_post_types=https://tent.io/types/posts/status##0.2.0,https://tent.io/types/posts/photo##0.2.0
```

##### Parameters

| Name                        | Required  | Description |
| --------------------------- | --------- | ----------- |
| `client_id`                 | Required  | The `id` obtained by registering with the Tent server |
| `redirect_uri`              | Required  | The URI to redirect to after authentication is complete. It must **exactly** match a URI (including parameters) provided during app registration in `redirect_uris`. |
| `state`                     | Optional  | This parameter will be added to the `redirect_uri` and should always be set to a random string that is stored in the session, and then verified to prevent cross-site request forgery attacks. |
| `scope`                     | Optional  | A comma-separated list of scopes that the app is requesting access to. |
| `tent_profile_info_types`   | Optional  | A comma-separated list of `profile_info_type_url##version` profile info type specifiers that the app is requesting access to. Set to `all` to request full access to the profile. |
| `tent_post_types`           | Optional  | A comma-separated list of `post_type_url##version` type/version specifiers that the app is requesting access to. Set to `all` to request access to all posts. |


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
302 Found
Location: http://fooapp.com/tent/callback?code=27ec1c54980f1af74&state=87351cc2f6737bfc8ba
```

#### Access Token

The `code` must be traded for permanent authentication details that can be used
to access the Tent server on behalf of the user.

##### POST /apps/:id/access\_token

The request must be signed with a MAC using the secret obtained during app
registration. Currently only the `mac` `token_type` is supported.

```text
POST /apps/6737b/access_token
Content-Type: application/json
Accept: application/json
Authorization: MAC id="6737b",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "code": "27ec1c54980f1af74",
  "token_type": "mac"
}
```

The server will respond with the authentication details necessary to interact
with the Tent server on behalf of the user.

```text
200 OK
Content-Type: application/json
```

```json
{
  "access_token": "7b7df67598602",
  "mac_key": "18bcf2bae86948731",
  "mac_algorithm": "hmac-sha-256"
  "token_type": "mac",
}
```

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

Currently all Authorization headers in this documentation are fake, but they
will be real examples when we have the example generator written.
