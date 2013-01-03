---
title: Les essentiels de Tent
kind: article
created_at: October 5, 2012 11:20 EDT
---

Tent est un protocole événementiel pour partager et stocker des données.

### Vision

Tent sera le vôtre: l'endroit où vous pouvez stocker toutes vos données, renseignements et contenus; et aussi où les autres peuvent se connecter avec vous. Avec toutes vos données dans un endroit où vous seul avez l'accès, vous pouvez utiliser plusieurs applications sur les divers périphériques et changer votre fournisseur de service lorsque vous choisissez. Vous décidez quoi, quand et avec qui vous voulez partager, aussi bien que les moyens dont les autres peuvent avoir accès à vos renseignements.

### Tent, à quoi ça sert?

Tent permet de partager et d'enregistrer. Vous pouvez enregistrer n'importe quel type des données avec Tent -- et les partager avec n'importe qui et n'importe quelle application que vous souhaitez. La publication peut être faite par n'importe quel application qui supporte le post-type, pour que les données puissent être utilisées dans diverses applications.

**Utilisateurs:** Gardez vos publications et vos relations avec vous pour toujours, à travers les applications, fournisseurs ou noms d'utilisateurs. Vos données seront toujours disponibles et portables, et elles vous appartiendront toujours.
 
**Développeurs:** Les serveurs Tent de vos utilisateurs sont responsable pour le stockage, les notifications et l'intégration sociale.

**Marques de commerce:** Avec Tent, vous pouvez avoir des conversations directes avec vos clients, au lieu de passer par des intermédiares.

### Tent est un protocole

Tent est un protocole, comme l'email ou l'internet. Cela veut dire que n'importe qui peut développer des applications ou des serveurs qui utilisent Tent. Cela veut aussi dire que les utilisateurs ont le choix de leur fournisseur de service. Ils peuvent même héberger un serveur Tent eux-mêmes. Les relations entre les utilisateurs ne sont pas affectées par leur choix de fournisseur.  Les utilisateurs choisissent les applications qu'ils utilisent, comme leur navigateur Web ou client email préferé. Les publications Tent sont sauvegardées sur le propre serveur Tent de l'utilisateur,  même si il peuvent changer d'application et emporter toutes leurs publications et relations avec eux.

### Les serveurs Tent

Chaque utilisateur a besoin d'un serveur. Ils peuvent héberger ce serveur eux-memes, ou ils peuvent utiliser un fournisseur de service comme Tent.is. Si on parle de Tent comme email, Tent.is est équivalent à Gmail. Comme avec les emails, les serveurs doivent être en ligne en tout temps.

### Noms d'utilisateurs

Tent s'étend sur tout l'Internet, donc les utilisateurs sont identifiés par leur URL, comme http://tent.io ou http://titanous.com au lieu des noms d'utilisateur comme @danielsiders. Tent vous donne la possibilité de faire les mentions avec autant d'utilisateurs et autant des publications que vous souhaitez. Les applications différentes peuvent afficher ces mentions différemment.

### Trouver les autres utilisateurs

Le protocole Tent dit aux applications et serveurs comment ils peuvent trouver d'autres serveurs Tent, de les sauvegarder et de reçevoir des publications depuis d'autres serveurs. Si vous avez le contrôle d'une domaine (exemple.fr) vous pouvez ajouter un lien pour que les visiteurs de votre site web sachent que vous utilisez Tent et comment vous joindre. Vous n'avez besoin que de l'URL de l'autre utilisateur Tent (http://daniel.tent.is). Ajoutez votre URL Tent sur vos cartes d'affaires, signatures d'email et anciens réseaux sociaux.

Dans les prochains jours il y aura une application pour trouver vos amis sur Tent.is par adresse email.

### Applications

La première application Tent est TentStatus, une application de microblogging. C'était l'application le plus simple que nous pouvions créer comme démonstration du protocole Tent. Les applications Tent sont capables de beaucoup plus. La plupart des applications existantes peuvent être modifiées pour Tent; par exemple, les applications de stockage de fichiers comme Dropbox, les discussions audiovisuelle comme Skype ou FaceTime, et les blogues comme Wordpress or Tumblr. Les applications peuvent aussi être modifiées pour se brancher à Tent avec les autres réseaux sociaux.

### Commencer

Vous pouvez commencer votre propre serveur Tent avec [tentd](https://github.com/tent/tentd-admin) ou aussi vous enregistrer sur [Tent.is](https://tent.is). Si vous êtes un développeur, vous pouvez écrire les applications avec le [protocole Tent](http://tent.io/docs). Aujourd'hui, il est facile d'utiliser Tent pour du microblogging; bientôt il sera possible de faire beaucoup plus.

## L'avenir
 
Comme Tent évolue, il sera bientôt possible de faire plusieurs choses uniques.

### Autorisations

Le contrôle d'accès est fondamental pour Tent. Les utilisateurs configurent leur serveur Tent pour gérer qui peut voir leurs publications. Cela crée un environnement sécurisé pour partager avec les autres utilisateurs et services, mais cela donne aussi le pouvoir de créer des publications seulement disponible aux utilisateurs d'origine. Tent peut être utilisé comme une coffre-fort de données personel, qui peut être accédé par les applications et services autorisés.

### Xanadu 

La conception de Tent a été inspiré par [Xanadu](https://fr.wikipedia.org/wiki/Projet_Xanadu), un précurseur au web. Avec Tent, comme avec Xanadu, tout contenu est versionné, alors que les publications peuvent être modifiées plusieurs fois, avec chaque version sauvegardée et disponible aux utilisateurs.

Xanadu encourage aussi les utilisateurs de créer des "liens profonds" directement dans les publications d'autres utilisateurs, au lieu de les copier et coller. Cette fonctionnalité donne aux utilisateurs le pouvoir de mantenir le contrôle des contenus. Utilisateur #1 crée une publication avec un "lien profond" vers la publication d'Utilisateur #2. Lorsqu'Utilisateur #3 lit la publication d'Utilisateur #1, Utilisateur #3 fait une demande au serveur d'Utilisateur #2 pour demander d'accès à la publication. Cette fonctionnalité permet chaque utilisateur d'avoir le contrôle de leurs contenus, et de mettre leurs propres conditions sur l'accès.

### Licenses

Les publications Tent peuvent avoir des licences jointes. Les licenses sont essentiellement des contrats, comme des conditions de service sur une publication. Les licences sont présentement très ouvertes. Les licences Creative Commons peuvent être appliqués, mais aussi d'autres types. Par exemple, une license peut être crée qui empêche certains utilisateurs de renvoyer des publications avec la licence jointe, ou bien qui exige les autres utilisateurs qui l'ont vu de le sauvegarder sur un serveur chiffré seulement. Lorsqu'un utilisateur suit un autre, ils demandent une combinaison des post-types et des licenses. Par exemple: "Je veux que vous m'envoyiez toutes vos publications de statut licencés comme "secret", et tous vos photos qui sont licencés comme Creative Commons 'Partage dans les mêmes conditions'."

Cette idée est même plus puissante lorsque Tent est utilisé pour les applications hébergées. Imaginez que Facebook ou Google suit le compte Tent de quelqu'un, et l'utilisateur leur dit que ses posts peuvent être rendus disponible seulement avec une licence "lecture seule," qui veut dire que les publications peut être montrés aux autres utilisateurs, mais pas vendues aux agences de publicité. Les licences ont le pouvoir de renverser totalement le monde des "conditions de service," mais elles sont toujours à l'étape de la théorie. Nous sommes en train de développer des licences "standards" pour commencer avec cette idée. Les fondations légales sont toujours incertaines.

### Applications interdites

Il y a une valeur incalculable dans nos données personnelles. Plusieurs applications sont capables d'analyser les données personnelles d'un utilisateur, et les résultats d'une telle analyse peuvent améliorer la vie de l'utilisateur. Malheureusement, les utilisateurs doivent céder le contrôle de leurs données à l'application et ses conditions de service. Avec Tent, toutes les données de l'utilisateur sont stockées sur son propre serveur. Si l'utilisateur télécharge une application d'analyse de données et l'utilise sur son propre serveur, il peut l'empêcher de renvoyer les données. Dans l'avenir nous intégrerons ces contrôles d'accès directement avec le serveur Tent, pour que les utilisateurs puissent essayer de nouvelles applications avec confiance.