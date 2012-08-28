---
title: Profile Info Types
---

## Profile Info Types

Profile info type schemas.

### Building your own type

Your type schema needs to have `url`, `name`, `description`, `version`, and `content` keys. `content` holds all your custom data keys.

#### Example
```json
{
  "type": {
    "url": "https://tent.io/types/info/relationship-status",
    "version": "0.1.0"
  },
  "name": "Relationship Status",
  "description": "Publish your relationship status",
  "content": {
    "status": "single",
    "interested_in": ["women"],
    "looking_for": ["friendship", "networking", "random play"]
  }
}
```

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `status`				| Required | String | Possible values: "single", "in a relationship", "it's complicated", "divorced" |
| `interested_in` | Required | Array  | Possible values: anything |
| `looking_for`   | Required | Array  | Possible values: "random play", "friendship", "relationship", "whatever I can get", "networking" |

### Tent

Every profile JSON file must have this

```json
{
  "type": {
    "url": "https://tent.io/types/info/tent",
    "version": "0.1.0"
  },
  "name": "Tent",
  "description": "Core of self.json, must be included to be Tent compatible",
  "content": {
    "licences": [
      {
        "url": "https://tent.io/types/licenses/creative-commons",
        "version": "3.0.0"
      }
    ],
    "entity": "johnsmith.me",
    "servers": [
      "john.smith.com",
      "https://eqt5g4fuenphqinx.onion",
      "smi.th/tent-api"
    ]
  }
}
```

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `licenses`			| Required | Array  | List of accepted licences (url and version) |
| `entity`				| Required | String | Url with `Tent-Server` header pointing to your tent-api root (https:// prefix is implied) |
| `servers`				| Required | Array  | List of canonical tent-api roots |

### Profile

Basic personal information.

```json
{
  "type": {
    "url": "https://tent.io/types/info/profile",
    "version": "0.1.0"
  },
  "name": "Profile",
  "description": "Basic personal information",
  "content": {
    "display_name": "jdoe",
    "full_name": "Dr. John Blake Doe",
    "avatar_url": "https://avatar.io/jdoe.png"
  }
}
```

| Name            | Required | Type   | Description      | 
| --------------- | -------- | ------ | ---------------- | 
| `display_name`  | Required | String | Name to be used from within posts |
| `name`					| Optional | String | Your full name |
| `avatar_url`    | Optional | String | URL of your public display photo |

