---
title: Tent Profile
---

## Tent Profile

This is where you define what version(s) of Tent you're using, what urls act as
Tent API endpoints for your content, what licences you support, your entity name
(can be any URI with a tent-`Link` header, and any other information about you
(e.g. Your real name, email, interest, etc.)

A very basic profile might look like this:

```json
[
  {
    "type": {
      "url": "https://tent.io",
      "version": "0.1.0"
    },
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "entity": "johnsmith.io",
    "servers": [
      "https://tent.johnsmith.io"
    ]
  }
]
```

The JSON is an array of objects complying with an info-type schema (See [info
types](/docs/info-types)). You may have multiple objects of the same type in
order to support multiple versions.

You could add support for another Tent version like this:

```json
[
  {
    "type": {
      "url": "https://tent.io",
      "version": "0.1.0"
    },
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "entity": "johnsmith.io",
    "servers": [
      "https://tent.johnsmith.io"
    ]
  },
  {
    "type": {
      "url": "https://tent.io",
      "version": "0.2.0"
    },
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "entity": "johnsmith.io",
    "servers": [
      "https://tent.johnsmith.io"
    ]
  }
]
```

You could add your basic information:

```json
[
  {
    "type": {
      "url": "https://tent.io",
      "version": "0.1.0"
    },
    "licenses": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "entity": "johnsmith.io",
    "servers": [
      "https://tent.johnsmith.io"
    ]
  },
  {
    "type": {
      "url": "https://tent.io/types/info-types/basic-info",
      "version": "0.1.0"
    },
    "name": "John Smith",
    "age": 25
  }
]
```

