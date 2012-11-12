---
title: Tent Roadmap
kind: article
created_at: November 12, 2012 12:30 EDT
---

The past few months have been a period of intense growth for Tent. Users, developers, and service providers have tested the limits of the protocol and discovered many opportunities for improvement. The core Tent team has received hundreds of suggestions, many of which will be incorporated into future releases.

## Schedule

A new point release is schedule to ship every 2 months starting in late November 2012. Below is a list of features scheduled to for each upcoming release.

### v0.2 Late Nov 2012

 - Auth credential expiration
 - New auth credential request 
 - Pagination headers
 - Fetch mentions from mentioned user 
 - Standardized JSON errors
 - Profile versioning
 - Global & post type cursors
 
### v0.3 Late jan 2013

 - Streaming connections
 - Machine Readable post type schemas
 - **Tags**
 	- part of protocol metadata
 	- Bookmarks/favorites
 	- public and private
 - Profile encapsulation (query/view)

 	 
### v0.4 Late March 2013

 - Async login
 - Deep links
 - Crypto
	 - Auth deletes
	 - Auth mentions
	 - Non-follower auth
 	 - "Likes"

### Backwards Compatibility

Tent profiles include information on which versions of Tent they are running and endpoints for each. This allows users to run different Tent servers for different Tent versions if necessary. However, most of the features on the current roadmap are only additions and therefore directly backwards compatible.

### Governance

Tent is an open protocol and all open source software released by Tent.io is published under the MIT license. The docs and spec itself use the same copyright notice as the [IETF](http://ietf.org/) uses on the [HTTP spec](https://tools.ietf.org/html/rfc2616). We are committed to governing Tent in a similar way to prevent fragmentation, ensure clear use of Tent-related terms and branding, and keep Tent free and open. Tent will remain a benevolent dictatorship until at least the release of v1.0. This structure will dramatically speed development and help Tent reach its fullest potential. Community feedback and feature requests are greatly appreciated on Tent, [Github](https://github.com/tent/tent.io), and [email](mailto:contact@tent.io). 

### Contributions

Contributions are strongly encouraged and requested both to the specification and other community efforts. The reference implementations developed by the Tent team are available on [Github](https://github.com/tent/). There is a list of other ways to help on the [Contribute page](http://tent.io/contribute).