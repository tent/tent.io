---
title: Protocol Introduction
layout: docs
---

Tent uses HTTPS and JSON to transport [posts](/docs/posts) between servers and
apps.

## Entities

Entities are the users of Tent. They authorize apps, establish relationships and
read/publish posts. Each entity is identified by their *Entity URL*, a HTTPS or
HTTP URL that has link metadata to facilitate
[discovery](/docs/servers-entities).

## Servers

Each entity has one or more servers that represent it. Servers handle the
storage and dissemination of posts.

## Posts

[Posts](/docs/posts) are the atomic unit of content in Tent. Each post is JSON
and may have attached files.

## Apps

[Apps](/docs/apps) provide the UI for Tent. Tent is a machine-readable JSON API;
some apps consume this API and provide human interfaces to Tent. Apps must be
authorized via OAuth 2 before it can modify data or access private posts.

## Relationships

Entities establish relationships when they send posts that mention other
entities. Relationships ensure that a post publishers cannot be spoofed and
allow granular permissions to be applied to posts.

## Subscriptions

Subscriptions build on relationships and provide a mechanism to request that
a subset of posts get pushed when they are published by an entity.

## Notifications

Notifications are [webhooks](https://en.wikipedia.org/wiki/Webhook) containing
posts that are delivered to entities based on subscriptions and mentions. Apps
may also request notifications for published posts.
