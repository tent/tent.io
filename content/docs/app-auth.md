---
title: App Authentication
---

# App Authentication

Tent uses [OAuth 2](http://tools.ietf.org/html/draft-ietf-oauth-v2-31) for app
authentication. Because of the distributed nature of Tent, it is necessary for
apps to register with the Tent entity before doing the authentication flow.

After the authentication flow, requests are authenticated using the credentials
with [MAC Access
Authentication](http://tools.ietf.org/html/draft-ietf-oauth-v2-http-mac-01).


## App Registration

Before authenticating a user, the application must be registered with the
specified Tent entity. The first step is to perform discovery on the provided
entity url.

```text
HEAD /
Host: titanous.com
```

```text
200 OK
Tent-Server: https://tent.titanous.com
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

### Request Parameters

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Required</th>
      <th>Type</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>name</code></td>
      <td>Required</td>
      <td>String</td>
      <td>The human name of the app to show the user</td>
    </tr>
    <tr>
      <td><code>description</code></td>
      <td>Required</td>
      <td>String</td>
      <td>A short description of the application to show the user</td>
    </tr>
    <tr>
      <td><code>url</code></td>
      <td>Required</td>
      <td>String</td>
      <td>The main url of the app</td>
    </tr>
    <tr>
      <td><code>icon</code></td>
      <td>Optional</td>
      <td>String</td>
      <td>The url to an icon for the app</td>
    </tr>
    <tr>
      <td><code>redirect_uris</code></td>
      <td>Optional</td>
      <td>Array</td>
      <td>
        A list of <strong>exact</strong> (including parameters) urls that will 
        be used as OAuth <code>redirect_uri</code>.
      </td>
    </tr>
    <tr>
      <td><code>scopes</code></td>
      <td>Optional</td>
      <td>Object</td>
      <td>
        A list of scope key to description value mappings of all scopes that
        the app might use. The descriptions should describe why the specific
        scope is necessary for the app to function.
      </td>
    </tr>
  </tbody>
</table>

### Response Parameters

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>id</code></td>
      <td>
        The identifier of the app. This is used as the MAC key identifier for
        requests to/from the Tent server, as well as the <code>client_id</code>
        in the OAuth flow.
      </td>
    </tr>
    <tr>
      <td><code>secret</code></td>
      <td>
        The secret used as the MAC key when modifying the registration and
        receiving notifications.
      </td>
    </tr>
    <tr>
      <td><code>mac_algorithm</code></td>
      <td>The MAC algorithm to be used.</td>
    </tr>
  </tbody>
</table>

## App Registration Modification

The request must be authenticated with a MAC generated using the secret from the
initial registration.

### PATCH /apps/:id

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


## Authentication Flow

### Auth Request

The app requests the user's Tent identifier, and performs discovery on it to
find the Tent API root. The app then builds an auth request and redirects the
user-agent to it:

```text
/auth?client_id=6737b
  &redirect_uri=http://fooapp.com/tent/callback
  &scope=read_posts,read_profile
  &state=87351cc2f6737bfc8ba
  &tent_profile_info_types=https://tent.io/types/info/music
  &tent_post_types=https://tent.io/types/posts/status#0.2.0,https://tent.io/types/posts/photo#0.2.0
```

#### Parameters

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Required</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>client_id</code></td>
      <td>Required</td>
      <td>
        The <code>id</code> obtained by registering with the Tent server
      </td>
    </tr>
    <tr>
      <td><code>redirect_uri</code></td>
      <td>Required</td>
      <td>
        The URI to redirect to after authentication is complete. It must
        <strong>exactly</strong> match a URI (including parameters)
        provided during app registration in <code>redirect_uris</code>.
      </td>
    </tr>
    <tr>
      <td><code>state</code></td>
      <td>Optional</td>
      <td>
        This parameter will be added to the <code>redirect_uri</code> and should
        always be set to a random string that is stored in the session, and then
        verified to prevent cross-site request forgery attacks.
      </td>
    </tr>
    <tr>
      <td><code>scope</code></td>
      <td>Optional</td>
      <td>
        A comma-separated list of scopes that the app is requesting access to.
      </td>
    </tr>
    <tr>
      <td><code>tent_profile_info_types</code></td>
      <td>Optional</td>
      <td>
        A comma-separated list of <code>profile_info_type_url#version</code>
        profile info type specifiers that the app is requesting access to. Set
        to <code>all</code> to request full access to the profile.
      </td>
    </tr>
    <tr>
      <td><code>tent_post_types</code></td>
      <td>Optional</td>
      <td>
        A comma-separated list of <code>post_type_url#version</code>
        type/version specifiers that the app is requesting access to.
        Set to <code>all</code> to request access to all posts.
      </td>
    </tr>
  </tbody>
</table>

#### Scopes

<table>
  <thead>
    <tr>
      <th>Scope</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>read_profile</code></td>
      <td>Read profile sections listed in the <code>profile_info</code> parameter</td>
    </tr>
    <tr>
      <td><code>write_profile</code></td>
      <td>Read and write profile sections listed in the <code>profile_info</code> parameter</td>
    </tr>
    <tr>
      <td><code>read_followers</code></td>
      <td>Read follower list</td>
    </tr>
    <tr>
      <td><code>write_followers</code></td>
      <td>Read follower list and block followers</td>
    </tr>
    <tr>
      <td><code>read_followings</code></td>
      <td>Read followings list</td>
    </tr>
    <tr>
      <td><code>write_followings</code></td>
      <td>Read followings list and follow new entities</td>
    </tr>
    <tr>
      <td><code>read_posts</code></td>
      <td>Read posts with types listed in the <code>post_types</code> parameter</td>
    </tr>
    <tr>
      <td><code>write_posts</code></td>
      <td>Read and publish posts with types listed in the <code>post_types</code> parameter</td>
    </tr>
  </tbody>
</table>

### Redirect

After the user has authorized the application, the Tent server will redirect the
User-Agent back to the specified `redirect_uri` with a `code` that can be used
to retrieve authentication details from the server.

The `state` parameter should be matched against the `state` parameter sent in
the initial request to prevent request forgery.

```text
302 Found
Location: http://fooapp.com/tent/callback?code=27ec1c54980f1af74&state=87351cc2f6737bfc8ba
```

### Access Token

The `code` must be traded for permanent authentication details that can be used
to access the Tent server on behalf of the user.

#### POST /apps/:id/access\_token

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

#### Response Parameters

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>access_token</code></td>
      <td>Used as the MAC key identifier.</td>
    </tr>
    <tr>
      <td><code>mac_key</code></td>
      <td>Used as the MAC key for requests.</td>
    </tr>
    <tr>
      <td><code>mac_algorithm</code></td>
      <td>The MAC algorithm to be used.</td>
    </tr>
    <tr>
      <td><code>token_type</code></td>
      <td>Specifies the token type. Currently always <code>mac</code></td>
    </tr>
  </tbody>
</table>

## Request Authentication

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
