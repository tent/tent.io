---
title: Authentication
---

Tent uses the [Hawk](https://github.com/hueniverse/hawk) HTTP authentication
scheme (v0.13.1).

## Hawk

Hawk is an authentication scheme built around [HMAC
digests](https://en.wikipedia.org/wiki/HMAC) of requests and responses. Every
authenticated client request has a `Authorization` header containing a MAC and
some metadata, and each server response to authenticated requests contains
a `Server-Authorization` header that authenticates the response.

In Tent, the credentials used with Hawk are provided in [credentials
posts](/docs/post-types#credentials). The `id` of the post is the Key ID in
Hawk. Tent currently only supports the `sha256` hash algorithm, used for HMAC
and payload validation.

## Request Header

The request `Authorization` header consists of fields in `key="value"` format:

| Field | Required | Description |
| ----- | -------- | ----------- |
| `id` | Required | The Key ID. In Tent, this is the `id` of the credentials post. |
| `ts` | Required | The timestamp in seconds since the Unix epoch. It must be within ±60 seconds of the server timestamp. If there is too much skew, [an error](#timestamp-skew) will be returned. |
| `nonce` | Required | A randomly generated string. This must be unique for each request. |
| `mac` | Required | The base64-encoded MAC of the [normalized string](#normalized-string). |
| `ext` | Optional | Application-specific data. Currently unused in Tent. |
| `hash` | Optional | The base64-encoded digest of the [request payload](#payload-validation). |
| `app` | Optional | The app ID (`id` from the app post). Required if the request is from an app. |
| `dlg` | Optional | The app delegate. Currently unused in Tent. |

**Example**

```text
Authorization: Hawk id="qUtGgNr7YTURDensMvGa1g", mac="mMiuXNaaEmw1alE15fU12ItH9jyKHlfh4/uZ14Lr6k8=", ts="1368116073", nonce="Wiok05gO", app="2HjRl8gWz5shfSXrwblRnw"
```

## Response Header

All responses to authenticated requests contain a `Server-Authorization` header.
The header is in the same format as the [Request Header](#request-header), but
does not have as many fields. The `mac` field is always included, and is based
on all of the same data provided in the request, except the `hash` and `ext`
values are replaced with response-specific values. The `hash` is optional and is
a digest of the response payload.

**Example**

```text
Server-Authorization: Hawk mac="YWojrFVgIjgd+RiPacnDwRcL8VtvcMEzahVfOpoLxoA=", hash="yAF3A3y3uzLvNT2m/nVwsifn1+joCqu0uNWZS8RSv6Y="
```

## Normalized String

The normalized string forms the HMAC digest value of the `mac` field. It is
based on request details, and consists of field values followed by newlines.
Some fields are also included in the request header/bewit.

| Field | Description |
| ----- | ----------- |
| Header | One of `hawk.1.header`, `hawk.1.request`, `hawk.1.bewit`. |
| `ts` | The timestamp in seconds since the Unix epoch. |
| `nonce` | A randomly generated string. |
| Method | The HTTP request method, all letters capitalized. |
| Request URI | The HTTP Request-URI, as sent in the request. Typically this is just the absolute path and query parameters. |
| Host | The HTTP host, as sent in the `Host` header, port omitted, all lowercase or if no `Host` is sent, the IP address. |
| Port | The port connected to, typically this will be `443`. |
| `hash` | The base64 encoded [payload digest](#payload-validation), blank if none. |
| `ext` | The app-specific data, blank if none. |
| `app` | The app id, omitted if none. |
| `dlg` | The app delegate, omitted unless `app` is set, blank if `app` is set. |

```text
Header
ts
nonce
Method
Request URI
Host
Port
hash
ext
app
dlg

```

**Example with app**

```text
hawk.1.header
1353832234
j4h3g2
POST
/resource?a=1&b=2
example.com
8000


1234


```

**Example with hash, no app**

```text
hawk.1.header
1353832234
j4h3g2
POST
/resource?a=1&b=2
example.com
8000

tREz+ddQOD9BUtIoQtq2W0u2qFlJrRbWpr0+y+Ux78Q=

```


## Payload Validation

Clients and servers may optionally validate payloads (request/response bodies).
There is no requirement to do so, but it is strongly recommended where possible.

The payload digest is of a header and the content type, each followed by
a newline, then the payload itself, also followed by a newline. The content type
is as provided in the `Content-Type` header with all parameters and
leading/trailing whitespace stripped.

**Example**

```text
hawk.1.payload
text/plain
Thank you for flying Hawk

```

## Timestamp Skew

When the client timestamp skew is outside of ±60 seconds of the server, the
server will return `401` response code with a `WWW-Authenticate` header
containing the server timestamp. The offset must be calculated from this
timestamp, and applied to all future requests.

The included `tsm` field is a HMAC of a header and the timestamp each followed
by a newline to prevent malicious skew attacks.

**Example**

```text
WWW-Authenticate: Hawk ts="1365741469", tsm="b4Qqhz8OUBq21saghHLV1ktwlXE72T1xtTEZkSlWizA=", error="Stale timestamp"
```

**MAC data**

```text
hawk.1.ts
1365741469

```

## URL Signing

Pre-signed URLs may be created, allowing temporary read access to the bearer of
the URL. These are called *bewit* URLs and have an added `bewit` URL parameter.
The `bewit` is a URL base64-encoded string with any trailing `=` elided field values separated by `\`.

The request method in the normalized string is always `GET`, and the server
allows `GET` and `HEAD` requests.

| Field | Description |
| ----- | ----------- |
| `id` | The Key ID. |
| `ts` | The expiry timestamp. The URL will work until the server clock passes this time. |
| `mac` | The base64-encoded HMAC digest of the normalized string. |
| `ext` | Application-specific data. Empty if not set. |

```text
url-base64("id\ts\mac\ext")
```

```text
123456\1356420707\kscxwNR2tJpP1T1zDLNPbB5UiKIU9tOSJXTUdG7X9h8=\
MTIzNDU2XDEzNTY0MjA3MDdca3NjeHdOUjJ0SnBQMVQxekRMTlBiQjVVaUtJVTl0T1NKWFRVZEc3WDloOD1c
```
