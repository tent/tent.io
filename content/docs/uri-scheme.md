---
title: URI Scheme
---

Tent URIs allow unambiguous referencing of Tent entities, posts, post versions,
and post attachments.

## Format

Two schemes are defined: `tent+http` and `tent+https` specifying HTTP and HTTPS
entity URLs respectively. The scheme is followed by the entity, and query
parameters are used to specify resources of the entity.

**Examples**
```text
tent+http://example.com/user
tent+https://jonathan.tent.is
```

## Parameters

Several parameters may be specified to reference resources published by the
entity.

- `post` A post identifier.
- `version` A post version identifier. Requires `post` to be specified.
- `attachment_name` An attachment name. Requires `post` to be specified.
- `attachment_digest` The hex encoded digest of an attachment. Allows referencing and attachment without `post` and `version`.

**Examples**

```text
tent+https://jonathan.tent.is?post=123
tent+https://jonathan.tent.is?post=123&version=d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592
tent+https://jonathan.tent.is?post=123&attachment_name=foo.txt&version=d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592
tent+https://jonathan.tent.is?post=123&attachment_name=bar.txt
tent+https://jonathan.tent.is?attachment_digest=d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592
```
