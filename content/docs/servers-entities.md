---
title: Servers and Entities
---

## Entity URLs

Each entity is identified by a *Entity URL*. This URL used to discover the [meta
post](/docs/post-types#meta) that describes the servers that represent the
entity. The entity URL may be any standard HTTP/HTTPS URL that has no query
parameters or fragment.

## Discovery

Discovery is the process of taking an Entity URL and finding the associated
[meta post](/docs/post-types#meta) in order to locate the servers that represent
the entity.

There are two discovery methods, both utilizing [Web
Linking](https://tools.ietf.org/html/rfc5988) to point to the meta post. The
preferred method is a HTTP `Link` header presented in response to a `HEAD` or
`GET` request to the Entity URL.  Alternatively, a HTML document may be served
with a `link` tag. The `rel` used is `https://tent.io/rels/meta-post`. Multiple
links may be provided, the first one that has a `200` response status with
a valid meta post should be used.

{discover_head example}

**HTML Example**

```html
<link href="https://mytent.example.com/posts/aaf43" rel="https://tent.io/rels/meta-post"/>
```

## Server Info
