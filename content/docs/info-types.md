---
title: Profile Info Types
---

## Profile Info Types

### Core

`https://tent.io/types/info/core/v0.1.0`

Every Tent user needs a profile with the `Core` info type. This block provides critical information that tells other servers and users how to interact with it.

{info_core schema}


### Basic

`https://tent.io/types/info/basic/v0.1.0`

`Basic` profile info helps humanize users. All fields are optional but help provide a context in which to place the user's s. 

{info_basic schema}

### Cursor

`https://tent.io/types/info/cursor/v0.1.0`

Global cursors for each post type helps multiple apps hold the same feed position. Each cursor specifies the most recent post the user has seen.

{info_cursor schema}

Cursor properties must be scoped by post type uri.

There is also a `mentions` cursor that wraps post type cursors and represents the last seen post of each type mentioning the user.

**Example:**

```json
{
  "https://tent.io/types/info/cursor/v0.1.0": {
    "https://tent.io/types/post/status/v0.1.0": {
      "post": "fh3n5i",
      "entity": "https://example.com"
    },
    "mentions": {
      "https://tent.io/types/post/status/v0.1.0": {
        "post": "fh3n5i",
        "entity": "https://example.com"
      }
    }
  }
}
```

### App Specific Cursor

Apps may define a custom profile section for the purpose of custom cursors by using a uri unique to the app as the profile key. App developers should use this as a last resort for when the global cursors don't meet their needs.

**Example:**

```json
{
  "https://app.example.org/cursor/v0.1.0": {
    "xyz" : {
      "post": "hsk4is",
      "entity": "https://example.com"
    }
  }
}
```

## Creating New Profile Info Types

Tent highly extensible and allows developers to create new profile info types to support new kinds of user data, interactions, and functionality.

### Guidelines
#### Do

 - **Use snake case for JSON key names.**
 - **Use existing types when possible.** Consider whether a new type is really necessary. Would an existing type work? Contact the maintainer of the type to suggest changes for a future version. Type-creep makes everyone's lives worse. Avoid proliferation.
 - **Fork existing types** Start with what already exists. Common types are familiar to both developers and users. They can more easily support your great new type if it is based of something familiar.
 - **Version your profile info type.** The profile info type specification supports versions. When it comes time to change your type, create a new version of the same type with a different number. Do not overwrite the original or start with a new name. This could lead to confusion and your type being blocked as spam. 
 - **Document your type.** Eventually another developer or user will want to know how your type works. Create clear, concise documentation including your contact information.
 - **Collaborate with other developers.** If you have encountered a challenge, it is likely many others have as well. Work with other developers who have similar goals. Create a single type that serves both your needs instead of two similar, competing types.
 - **Keep it simple.** Users and developers alike benefit from a small set of simple types. With a small number of types, users can find apps that suit their specific needs and know their data is portable. Developers can build interoperable, compliant apps without reinventing the wheel. Avoid NIH (Not Invented Here) Syndrome and the desire to start from scratch.
 - **Consider privacy settings.** Users will set whole sections to public or private. Do not combine fields that would be private with public ones in the same profile info type.
 - **Publish your type.** If you have created a new type, publish it to a popular Tent community site (like this one) so other developers can add support for it into their apps.
 
#### Do Not

 - **Create duplicate profile info types** Multiple types with the same purpose will create a fragmented ecosystem. Tent was designed to avoid this problem, please do not make it worse.
 - **Create proprietary profile info types** Users and other developers expect to be able to view profiles in different applications. Limiting which apps can use a profile info type is against the spirit of Tent.
 - **Create types with identical names.** Names should disambiguate profile info types, not confuse them. An entity may have many info types in its profile, duplicate names will cause errors. Choose a unique name for your type.
 - **Use deeply nested data structures.** They make querying difficult.
 - **Put too much data in a profile.** Profiles are transferred over the wire each time they are updated.
