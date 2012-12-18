---
title: Types of Tent Apps
kind: article
created_at: December 18, 2012 11:20 EDT
---

Applications can make use Tent in many ways. This post explains the different levels of Tent integration available to applications so developers and users can choose the right option for their needs.

**Note**: There is a broad spectrum of options available when working with Tent. This post heavily simplifies the major categories of Tent integration and their consequences, but individual apps may combine approaches.

### Identity

Tent can be used to sign users into applications as a replacement for email/password logins and centralized OAuth systems like Facebook, Twitter, Github, and Linkedin. Apps can use Tent for login without taking advantage of any othe Tent features. 
  
### Backup

Some applications use Tent to store a backup, personal copy, or export of users' data. The application holds the primary database and handles communication itself, but allows users to keep a real time copy of their data in Tent.

### 100% Tent 

Some applications fully embrace Tent in its entirety. These apps use Tent for communication between users, data and file storage, sign-in, social graph, cross-device sync, and all other transactions. There are many advantages to using applications architected in this way.

These applications do not require server infrastructure which means there is no developer maintenance required. Since users' Tent servers manage storage and communication, developers do not pay for infrastructure. Essentially, developers define logic and create the design and UI, but Tent handles communication, storage, and sign-in. In practice this can remove the need for advertisements or subscription fees/plans to cover the cost of operation since developers can "ship it and forget it". If a developer abandons a project, users are unaffected and the service continues operation. 

When an app or service with a server component becomes suddenly and rapidly successful, the server architecture needs to scale with user activity growth. Applications that use Tent do not have this concern. Each user's Tent server handles storage and communication. Without centralized servers, the application can scale gracefully.

Anyone can run their own Tent server and change hosts when they wish. This makes Tent-based services much harder to block or censor. If a region's connection to the external internet was deactivated but internal services remained, communication between Tent users inside that region would not be affected. 

Most importantly, users stay in control. When software companies are sold or shut down, products are often discontinued or merged into other lines. User data can be lost and terms of service are often changed to the detriment of users. Apps that use Tent for storage and communication can avoid this trap entirely. Users control the only copy of their own data and have the original application, so there's nothing to discontinue or unplug. Users can keep using the app with their data as long as they wish.

Additionally if developers' servers never touch users' data, new applications are possible. Today working with sensitive data like medical and financial records terrifies most developers and users alike. Tent lets users keep control of their data. Tent enables applications to analyze and handle sensitive data without "phoning home" with copies of that information. Users can keep their data private and developers can explore domains that were previously inaccessible.
