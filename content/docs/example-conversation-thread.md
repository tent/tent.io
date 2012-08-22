---
title: Example Conversation Thread
---

## Example Conversation Thread

Brant decides the weather is great for going to the beach, he publicly asks a few friends if they want to go:

```
POST https://tent.brant.io/posts
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "time": 1345475873,
  "licences": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "mentions": [
    { "entity": "allison.me" },
    { "entity": "kelsi.io" }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/status",
      "version": "1.2.0"
    },
    "text": "^Allison ^Kelsi looks like a great day to go beaching"
  }
}
```

```
201 Created
```

His server pushes his post to them and his followers...

Kelsi responds:

```
POST https://kelsi.io/tent/posts
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "time": 1345476455,
  "licences": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "mentions": [
    { "entity": "brant.io" },
    { "entity": "allison.me" },
    {
      "id": "24894d54305a",
      "entity": "brant.io"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/status",
      "version": "1.2.0"
    },
    "text": "^Brant ^Allison I'm not doing anything later if you want to go around 3"
  }
}
```

```
201 Created
```

Her server pushes her response to them and her followers...

Susie is following Kelsi and responds to her post:

```
POST https://tent.susie.com/posts
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "time": 1345476455,
  "licences": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "mentions": [
    { "entity": "kelsi.io" },
    {
      "id": "24894d54305a",
      "entity": "brant.io"
    },
    {
      "id": "a9448b1b33ec",
      "entity": "kelsi.io"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/status",
      "version": "1.2.0"
    },
    "text": "^Kelsi I'll be down there around 2:30"
  }
}
```

```
201 Created
```

Susie’s server pushes her post to her followers (which includes Kelsi), and Brant...

Brant responds:

```
POST https://tent.brant.io/posts
Content-Type: application/json
Authorization: MAC id="775ecf8",
                   ts="1336363200",
                   nonce="dj83hs9s",
                   mac="bhCQXTVyfj5cmA9uKkPFx1zeOXM="
```

```json
{
  "time": 1345476455,
  "licences": [
    {
      "url": "https://tent.io/types/licenses/creative-commons",
      "version": "3.0.0"
    }
  ],
  "mentions": [
    { "entity": "kelsi.io" },
    { "entity": "susie.com" },
    {
      "id": "24894d54305a",
      "entity": "brant.io"
    },
    {
      "id": "a9448b1b33ec",
      "entity": "kelsi.io"
    },
    {
      "id": "87cc8698f03f",
      "entity": "susie.com"
    }
  ],
  "content": {
    "type": {
      "url": "https://tent.io/types/posts/status",
      "version": "1.2.0"
    },
    "text": "^Kelsi ^Susie Should I meet the two of you there around 3?"
  }
}
```

```
201 Created
```

Susi, and Brant’s followers (which includes Kelsi) get pushed the post...
