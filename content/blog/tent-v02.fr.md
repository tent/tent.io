---
title: Tent v0.2
kind: article
created_at: December 10, 2012 14:05 EDT
---

La version du Tent 0.2 est maintenant disponible. Tous les changements au protocole sont des additions; aucune fonctionnalité a été dépreciée ou enlevée.

## Les nouvelles

La nouvelle version ajoute plusieurs fonctionnalités:

 - **Version Tent** - La [section du profil Core](/docs/info-types#core) contient la version actuelle de Tent qui est en marche. Les applis peuvent faire référence à cette section pour trouver les fonctionnalités disponibles d'un serveur.

 - **Récupération des mentions** - Une liste des [mentions publique d'une publication](/docs/app-server#get-postsidementions) peut être récupéré du créateur original de la publication.

 - **Curseurs** - Les profils peuvent contenir [des curseurs specifiques au post-type](/docs/info-types#cursor). Les positions dans un flux peuvent être partagés à travers des applications diverses. Les sections du profil doivent être modifié pour les post-types affichables.

 - **L'expiration des données d'authentification** - Les applications peuvent faire des [demandes d'authentification temporaires](/docs/app-auth#request-parameters) qui expire à un certain moment. Cette fonctionnalité est preferée lorsqu'une application a seulement besoin d'un accès temporaire au compte.

 - **Demandes d'authentification** - Les applications peuvent rafraîchir leurs jetons OAuth. 

 - **En-têtes de pagination** - Les [en-têtes de lien](/docs/app-server#get-posts) qui relient les pages précedentes et suivantes sont disponibles pour améliorer la navigation entre les résultats.

 - **Erreurs JSON** - Toutes les erreurs sont maintenant [livrées comme JSON](/docs/server-protocol#error-responses) au lieu de texte brut.

 - **Le versionnage des profils** - [Les profils](/docs/app-server#get-profiletype) sont versionnés comme les publications. Les versions antérieures peuvent être récuperées directement. Si aucune version n'est specifiée, la version le plus récente est utilisée.

## La prochaine étape

[tentd](https://github.com/tent/tentd-admin) avec Tent v0.2 est maintenant disponible et il contient des instructions sur les migrations nécessaires des bases de données. Tent.is est maintenant en marche avec v0.2.

La version v0.3 est prévue pour fin janvier 2013. Consultez le [calendrier de lancement Tent](https://tent.io/blog/tent-roadmap) pour plus de détails.