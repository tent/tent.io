---
title: Tent Basics
kind: article
created_at: October 5, 2012 12:05 EDT
---

Tent is a protocol for event-oriented data storage and sharing. 

### The Vision

Tent will be your home: the place you store all your information and content and the way others connect with you. With all your information in one place that you control, you can use different applications on different devices and change service providers when you choose. You decide when, what, and with whom to share and on what terms they have access to your information.

### What is Tent for

Tent is for saving and sharing. You can save any kind of data to Tent and share it with whichever users and apps you want. Post can be accessed from any app that supports the post type, so data can be used across different applications.

**Users:** Keep your posts and relationships forever, across apps and when you change your service provider or name. Your data will always be accessible, portable, and belong to you.

**Developers:** Your users' Tent servers are responsible for storage, notifications, and social integration. 

**Brands:** Have direct conversations with customers instead of letting third parties intermediate your relationships. 

### Tent is a protocol

Tent is a protocol, like email or the web, which means anyone can write apps or servers that use Tent. It also means that users have a choice of service providers, including hosting Tent themselves. Relationships between users are unaffected by which providers they use. Users choose the apps they use, just like their web browser or email program. Tent posts are saved to a user's Tent server, so users can change apps and take all their posts and relationships with them.

### Tent Servers

Every user needs a server. They can manage that server themselves or use a hosting provider like Tent.is. Tent is like email, Tent.is is like Gmail. Like with email, servers need to be online all the time.

### Usernames

Tent spans the whole internet, so users are identified by URLs, like http://tent.io or http://titanous.com instead of usernames like @danielsiders. Tent lets you mention as many other users and specific posts in a post as you want. Different applications will display these mentions differently.

### Finding other users

The Tent protocol tells apps and servers how to find Tent servers, save and get posts from them. If you control a domain (example.com) you can add a link so visitors to your site will know you use Tent and how to connect with you. All you need to connect with another Tent user is their URL (i.e. https://daniel.tent.is). Put your Tent address on your business card, email signatures, and legacy social networks. 

In the next few days there will be a friend finder app on Tent.is to lookup users by email address.

### Applications

The first Tent app was TentStatus, a microblogging app. This was the simplest application we could create as a proof of concept to demonstrate the Tent protocol. Tent apps are capable of a great deal more. Most existing applications could be built for Tent: File backups/sharing like Dropbox, Audio/Video chats and storage like Skype or Facetime, and Blogs like Wordpress or Tumblr could all be built on Tent. Applications can also be written to connect Tent to existing social networks.

### Getting Started

You can run your own Tent server with [tentd](https://github.com/tent/tentd-admin) or sign up for an account on [Tent.is](https://tent.is). If you're a developer you can write applications using the [Tent protocol](http://tent.io/docs). Today it's easy to use Tent for microblogging, soon it will be possible to do much more.

## In the Future

As Tent evolves it will be able to do several unique things. 

### Post permissions

Access control is at the heart of Tent. Users tell their Tent server who is allowed to see the post. This creates a secure environment to share post with other users and services, but also allows users to create posts available only to themselves. Tent can be used as a personal data vault which can be written to and read from different applications that a user authorizes.
  
### Xanadu 

Tent was inspired by [Xanadu](https://en.wikipedia.org/wiki/Project_Xanadu), a precursor to the world wide web. In Tent, like Xanadu, all content is versioned, so posts can be edited many times, with each version saved and accessible to users. 

Xanadu also encourages users to "deep link" directly to other users' posts instead of copying and pasting them. This allows the original author to maintain control of the content. User A creates a post containing a "deep link" to User B's post. When User C reads User A's post, User C actually talks to User B's server to arrange access to that post. This allows each user to remain in control and impose different terms of access to their data.
    
### Licenses

Tent posts can have licenses attached. Licenses are basically contracts, like terms of service on a specific post. Licenses are currently very open ended. Creative Commons licenses could obviously be applied, but so could other types. For example a license could be created that prohibited the receiving user from reposting any posts with the license attached or requiring all users who received the post to store it only on an encrypted server. When one user follows another, they request a combination of post types and licenses. For example: I want you to send me all your status posts that are "secret" licensed and all your photos that are Creative Commons Share-alike. 

This idea is even more powerful when Tent is used for hosted applications. Imagine Facebook or Google "following" a user's Tent and that user telling the company that their posts were only available under a "display only" license which allowed content to be shown to other human users, but not content analyzed or data mined and sold to advertisers. Licenses have the potential to turn dictated Terms of Service upside down, but are still in the very early stages. We are in the process of developing some "standard" licenses to get the community started, this is still shaky legal ground.
    
### Restricted applications

There is tremendous value in our personal data. Many applications are capable of performing analysis on a user's personal data, the results of which could measurably improve that user's life. Unfortunately, users must surrender control of their data to that application and its terms of service. With Tent all of a user's data lives on their Tent server. If the user downloads an analysis application and runs it on their own device, the user can keep the application from "phoning home" with the user's data. In the future we will implement these network access controls directly into Tent, so users can try new applications with confidence.
