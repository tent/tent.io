---
title: Application-Level Profile Semantics
---

Tent.io Application-Level Profile Semantics
=============================

### Authors:
Cameron Bytheway (cameron@nujii.com)
### Dates:
2012-08-25 (Created)
### Status
Unstable Draft

* [General Description](#general-description)
* [Compliance](#compliance)
* [Design Characteristics](#design-characteristics)
  * [Base Format](#base-format)
  * [Domain Semantics](#domain-semantics)
  * [State Transfer](#state-transfer)
  * [Application Flow](#application-flow)
  * [H-Factors](#h-factors)
* [Additional Constraints](#additional-constraints)
* [Semantic Profile](#semantic-profile)
  * [Definitions](#definitions)
  * [Class Attribute Values](#class-attribute-values)
  * [ID Attribute Values](#id-attribute-values)
  * [Name Attribute Values](#name-attribute-values)
  * [Rel Attribute Values](#rel-attribute-values)
* [Acknowledgements](#acknowledgements)

## General Description

The profile here contains details on customizing the HTML media type for the specific application domain of [tent.io](http://tent.io). It contains descriptions of valid @class, @id, @name, and @rel values that can appear within HTML resource representations. The identified base media type (HTML) along with the list of attributes, values, and their meaning describes a hypermedia interface. This document is presented as a complete blueprint for implementing a compliant client or server that supports the basic features of the target application domain.

It should be noted that this documentation does not contain any of the following:
* URI construction rules
* Suggested resource names
* HTTP request/response samples
* Example resource representations

## Compliance
An implementation is not compliant if it fails to satisfy one or more of the MUST or REQUIRED level requirements. An implementation that satisfies all of the MUST or REQUIRED and all of the SHOULD level requirements, is said to be "unconditionally compliant." One that satisfies all of the MUST level requirements but not all the SHOULD level requirements is said to be "conditionally compliant."

> The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
> "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
> document are to be interpreted as described in 
> [RFC 2119](http://www.ietf.org/rfc/rfc2119.txt).

## Design Characteristics
### Base Format
HTML

### Domain Semantics
Specific (via Semantic Profile)

### State Transfer
Ad hoc (via HTML FORMs)

### Application Flow
Applied (via Semantic Profile)

### [H-Factors](http://www.amundsen.com/hypermedia/hfactor/)
* [LO](http://www.amundsen.com/hypermedia/hfactor/#lo)
* [LE](http://www.amundsen.com/hypermedia/hfactor/#le)
* [LT](http://www.amundsen.com/hypermedia/hfactor/#lt)
* [LN](http://www.amundsen.com/hypermedia/hfactor/#ln)
* [CM](http://www.amundsen.com/hypermedia/hfactor/#cm)
* [CL](http://www.amundsen.com/hypermedia/hfactor/#cl)

## Additional Constraints
* All resource representations MUST be valid HTML documents.
* Servers MAY require clients to support OAuth 2.0 Authentication for some requests.
* Servers MAY provide additional markup or features not covered in this profile, but these additions MUST NOT contradict the semantics outlined here.
* Servers MAY supply code-on-demand elements with their resource representations (JavaScript, CSS, XSLT, etc.), but servers SHOULD NOT assume clients will support them.
* Servers MAY supply INPUT elements in FORMS which are not documented in this spec and clients SHOULD return those INPUT elements when POSTing the FORM.

## Semantic Profile
What follows is a list of HTML attributes and their possible values. Servers SHOULD send resource representations that contain these values along with appropriate markup and data. Servers are free to decide which elements are appropriate for each resource representation. Servers are also free to determine which of the elements below are to be supported.

Clients SHOULD be prepared to properly handle all of the attributes and elements described here. Clients SHOULD also be prepared to provide state transfers (FORMs) back to the server as indicated.

Servers MAY provide additional semantics and clients MAY support those additional semantics.

### Definitions

#### Designated User
The phrase "designated user" means: 1) the currently authenticated (logged-in) user; 2) a user identified via other state information such as cookies; or 3) a user selected by some other means such as following a link.

#### Entity
The phrase "entity" refers to a server containing data and meta-data associated with a particular user.


### Class Attribute Values
The following class values MAY appear within the response representation:

#### all
Applied to a `UL` tag. A list representation. When this element is a descendant of [DIV.id="messages"](#messages) it MAY have one or more [LI.class="message"](#message) descendant elements. When this element is a descendant of [DIV.id="users"](#users) it MAY have one or more [LI.class="user"](#user) descendant elements. When this element is a descendant of [DIV.id="notifications"](#notifications) it MAY have one or more [LI.class="notification"](#notification) descendant elements.

#### action
Applied to a `SPAN` tag. Describes interaction between a [user](#user) and a [target](#target-1) resource.

#### avatar
Applied to an `IMG` tag. A reference to an image of the [designated user](#designated-user).

#### date-time
Applied to a `SPAN` tag. Contains the UTC date and time the [message](#message) or [notification](#notification) was posted. When present, it SHOULD be valid per [RFC 3339](http://www.ietf.org/rfc/rfc3339.txt).

#### following-add
Applied to a `FORM` tag. A link template to register an [entity](#entity) to the [followers list](#followers). The element MUST be set to FORM.method="post" and MUST contain the following descendant elements:
* [INPUT[url].name="entity"](#entity-1)

#### following
Applied to a `UL` tag. A list representation. When this element is a descendant of [DIV.id="messages"](#messages) it contains the list of messages posted by the [users](#users) the [designated user](#designated-user) is following and MAY have one or more [LI.class="message"](#message) descendant elements. When this element is a descendant of [DIV.id="users"](#users) it contains the list of [user](#user) who are the followers of the [designated user](#designated-user) and MAY have one or more [LI.class="user"](#user) descendant elements. When this element is a descendant of [DIV.id="notifications"](#notifications) it contains the list of [notification](#notification)s from the [designated user](#designated-user)'s followers and MAY have one or more [LI.class="notification"](#notification) descendant elements.

#### follower-add
Applied to a `FORM` tag. A link template to add a [entity](#entity) to the [designated user](#designated-user)'s [following](#following) list. The element MUST be set to FORM.method="post" and MUST contain the descendant element:
* [INPUT[url].name="entity"](#entity-1)

#### followers
Applied to a `UL` tag. A list representation of all of the [users](#users) from the [designated user](#designated-user)'s follower list. MAY have one or more [LI.class="user"](#user) descendant elements.

#### me
Applied to a `UL` tag. When this element is a descendant of [DIV.id="messages"](#messages) it contains the list of messages posted by the [designated user](#designated-user) and MAY have one or more [LI.class="message"](#message) descendant elements. When this element is a descendant of [DIV.id="users"](#users) it SHOULD contain a single descendant [LI.class="user"](#user) with the [designated user](#designated-user)'s profile. When this element is a descendant of [DIV.id="notifications"](#notifications) it contains the list of notifications for the [designated user](#designated-user) and MAY have one or more [LI.class="notification"](#notification) descendant elements.

#### message
Applied to an `LI` tag. A representation of a single message. It SHOULD contain the following descendant elements:

* [SPAN.class="user-handle"](#user-handle)
* [A.rel="user"](#user-1)
* [SPAN.class="message-content"](#message-content)
* [A.rel="message"](#message-1)

It MAY also contain the following descendant elements:

* [IMG.class="avatar"](#avatar)
* [SPAN.class="date-time"](#date-time)

#### message-content
Applied to a `SPAN` tag. The text of a message posted by a [user](#user).

#### message-post
Applied to a `FORM` tag. A link template to add a new message to the system by the [designated user](#designated-user). The element MUST be set to FORM.method="post" and SHOULD contain a descendant element:
* [TEXTAREA.name="message-content"](#message-content-1)

It also MAY contain one or more of the following descendant elements:
* [INPUT[file].name="attachment"](#attachment)

#### message-search
Applied to a `FORM` tag. A link template to search all of the messages. The element MUST be set to FORM.method="get" and SHOULD contain the following descendant elements:
* [INPUT[text].name="search"](#search-1)

#### notification
Applied to an `LI` tag. A representation of a single notification. It MUST contain the following descendant elements:
* [A.rel="entity"](#entity-2)
* [SPAN.class="action"](#action)
* [A.rel="target"](#target-1)

It also MAY contain one or more of the following descendant elements:
* [SPAN.class="notification-text"](#notification-text)
* [A.rel="client"](#client)
* [SPAN.class="date-time"](#date-time)

#### notification-post
Applied to a `FORM` tag. A link template to create a notification on an [entity](#entity). The element MUST be set to FORM.method="post" and MUST contain the following descendant elements:
* [INPUT[url].name="entity"](#entity-1)
* [INPUT[url].name="action"](#action)
* [INPUT[url].name="target"](#target)

#### notification-text
Applied to a `SPAN` tag. Contains the embedded content from a [notification](#notification).

#### search
Applied to a `UL` tag. A list representation. When this element is a descendant of [DIV.id="messages"](#messages) it contains a list of messages and MAY have one or more [LI.class="message"](#message) descendant elements. When this element is a descendant of [DIV.id="users"](#users) it contains a list of [users](#users) and MAY have one or more [LI.class="user"](#user) descendant elements. When this element is a descendant of [DIV.id="notifications"](#notifications) it contains a list of notifications and MAY have one or more [LI.class="notification"](#notification) descendant elements.

#### single
Applied to a `UL` tag. When this element is a descendant of [DIV.id="messages"](#messages) it contains the message selected via a message link. SHOULD have a single [LI.class="message"](#message) descendant element. When this element is a descendant of [DIV.id="users"](#users) it contains the user selected via a user link. SHOULD have a single [LI.class="user"](#user) descendant element. When this element is a descendant of [DIV.id="notifications"](#notifications) it contains the notification selected via a message link. SHOULD have a single [LI.class="notification"](#notification) descendant element.

#### user
Applied to an `LI` tag. A representation of a single user. It SHOULD contain the following descendant elements:
* [SPAN.class="user-handle"](#user-handle)
* [IMG.class="avatar"](#avatar)
* [A.rel="entity"](#entity-2)

#### user-handle
Applied to a `SPAN` tag. The [user](#user) nickname text.

#### users-search
Applied to a `FORM` tag. A link template to search all of the [users](#users) in the [entity](#entity)'s network. The element MUST be set to FORM.method="get" and SHOULD contain the descendant element:
* [INPUT[text].name="search"](#search)

#### user-update
Applied to a `FORM` tag. A link template to update the [designated user](#designated-user)’s profile. The element MUST be set to FORM.method="post" and SHOULD contain one or more of the following descendant elements:
* [INPUT[file].name="avatar"](#avatar-1)
* [INPUT[email].name="email"](#email)
* [INPUT[text].name="first-name"](#first-name)
* [INPUT[text].name="handle"](#handle)
* [INPUT[text].name="language"](#language)
* [INPUT[text].name="last-name"](#last-name)
* [INPUT[text].name="middle-name"](#middle-name)


### ID Attribute Values
The following id values SHOULD appear within response representations:

#### messages
Applied to a `DIV` tag. The list of messages in this representation. MAY have one or more of the following descendant elements:
* [UL.class="all"](#all)
* [UL.class="following"](#following)
* [UL.class="me"](#me)
* [UL.class="mentions"](#mentions)
* [UL.class="search"](#search)
* [UL.class="shares"](#shares)
* [UL.class="single"](#single)

#### notifications
Applied to a `DIV` tag. The list of [LI.class="notification"](#notification) in this representation. MAY have one or more of the following descendant elements:
* [UL.class="all"](#all)
* [UL.class="following"](#following)
* [UL.class="me"](#me)
* [UL.class="search"](#search)
* [UL.class="single"](#single)

#### queries
Applied to a `DIV` tag. The list of valid queries in this representation. MAY have one or more FORM and/or A descendant elements (see [rel](#rel-attribute-values) and [class](#class-attribute-values) section for details).

#### users
Applied to a `DIV` tag. The list of [LI.class="user"](#user) in this representation. MAY have one or more of the following descendant elements:
* [UL.class="all"](#all)
* [UL.class="following"](#following)
* [UL.class="followers"](#followers)
* [UL.class="me"](#me)
* [UL.class="search"](#search)
* [UL.class="single"](#single)

### Name Attribute Values
The following name values MAY appear within response representations:

#### action
**The profile semantics used to describe actions will be determined at a later stage**

Applied to an `INPUT[url]` element. The URL of a resource describing the action. It SHOULD be valid per [RFC 3986](http://www.ietf.org/rfc/rfc3986.txt). The resource located at the URL MUST instruct the server how to handle the [notification](#notification).

#### avatar
Applied to an `INPUT[file]` element. The image for the [user](#user).

#### client
Applied to an `INPUT[url]` element. The URL containing information about the client used to execute the action. It SHOULD be valid per [RFC 3986](http://www.ietf.org/rfc/rfc3986.txt).

#### email
Applied to an `INPUT[email]` element. The [user's](#user) email address.

#### entity
Applied to an `INPUT[url]` element. The URL of the [user's](#user) [entity](#entity) server. It SHOULD be valid per [RFC 3986](http://www.ietf.org/rfc/rfc3986.txt).

#### first-name
Applied to an `INPUT[text]` element. The first name of the [user](#user).

#### handle
Applied to an `INPUT[text]` element. The public nickname of a [user](#user).

#### language
Applied to an `INPUT[text]` element. The preferred language of the [user](#user). It SHOULD be valid per [RFC 5646](http://www.ietf.org/rfc/rfc5646.txt) and [RFC 4647](http://www.ietf.org/rfc/rfc4647.txt).

#### last-name
Applied to an `INPUT[text]` element. The last name of the [user](#user).

#### message-content
Applied to a `TEXTAREA` element. The message to post (for the [designated user](#designated-user)).

#### middle-name
Applied to an `INPUT[text]` element. The middle name of the [user](#user).

#### original-message
URI pointing to the original [message](#message) in a [reply](#message-reply).

#### scope
Applied to an `SELECT` element. The scope of a [message](#message). Its value MUST be one of the following:

* ##### associates

  Any [entities](#entity) associated with the user may see the [message](#message) ([followers](#followers) and [following](#following)).

* ##### followers

  Any [entities](#entity) that [follow](#user-register) the [designated user](#designated-user).

* ##### public

  Any client (authentication or unauthenticated) may see the [message](#message).

#### search
Applied to an `INPUT[text]`. The search value to use when searching [messages](#messages) (when applied to [FORM.class="message-search"](#message-search)) or when searching [users](#users) (when applied to [FORM.class="users-search"](#users-search)).

#### target
Applied to an `INPUT[url]` element. The URL MUST point to the resource the [entity](#entity) had acted upon. It SHOULD be valid per [RFC 3986](http://www.ietf.org/rfc/rfc3986.txt).


### Rel Attribute Values
The following rel values MAY appear within response representations:

#### client
Applied to an `A` tag. A reference to information about the client used by a [user](#user) to act upon a [target resource](#target).

#### entity
Applied to an `A` tag. A reference to the [entity](#entity) associated with a [user](#user).

#### first
Applied to an `A` tag. A reference to the first page in a list of data ([messages](#messages), [users](#users)).

#### follower-add
Applied to an `A` tag. A reference to the [follower-add](#follower-add) FORM.

#### following-add
Applied to an `A` tag. A reference to the [following-add](#following-add) FORM.

#### index
Applied to an `A` tag. A reference to the starting URI for the application.

#### last
Applied to an `A` tag. A reference to the last page in a list of data ([messages](#messages), [users](#users)).

#### message
Applied to an `A` tag. A reference to a [message](#message) representation.

#### message-post
Applied to an `A` tag. A reference to the [message-post](#message-post) FORM.

#### messages-all
Applied to an `A` tag. A reference to a list representation of all the [messages](#messages) in the system ([messages-following](#messages-following) and [messages-me](#messages-me)).

#### messages-user
Applied to an `A` tag. A reference to a list representation of all the [messages](#messages) posted by a [user](#user).

#### messages-following
Applied to an `A` tag. A reference to a list representation of all the [messages](#messages) from the [users](#users) the [designated user](#designated-user) is following.

#### messages-me
Applied to an `A` tag. A reference to a list representation of all the [messages](#messages) posted by the [designated user](#designated-user).

#### messages-search
Applied to an `A` tag. A reference to the [messages-search](#messages-search) FORM.

#### next
Applied to an `A` tag. A reference to the next page in a list of data ([messages](#messages), [users](#users)).

#### previous
Applied to an `A` tag. A reference to the previous page in a list of data ([messages](#messages), [users](#users)).

#### self
Applied to an `A` tag. A reference to the currently loaded resource representation.

#### target
Applied to an `A` tag. A reference to the resource an [entity](#entity) has acted upon.

#### user
Applied to an `A` tag. A reference to a [user](#user) representation.

#### user-me
Applied to an `A` tag. A reference to the [designated user](#designated-user)’s representation.

#### user-update
Applied to an `A` tag. A reference to the [user-update](#user-update) FORM.

#### users-following
Applied to an `A` tag. A reference to list representation of the [users](#users) the [entity](#entity) is following.

#### users-followers
Applied to an `A` tag. A reference to list representation of the [users](#users) who are following the [entity](#entity).

#### users-search
Applied to an `A` tag. A reference to the [users-search](#users-search) FORM.


## Acknowledgements

This work was inspired by Mike Amundsen's [Microblogging Application](http://amundsen.com/hypermedia/profiles).

