---
title: "Pourquoi vos projets data ratent leur mise en production"
date: 2026-05-15
type: posts
draft: false
language: fr
hero: "images/sections/posts/Article_projets.png"
tags: ["DataOps", "Gouvernance", "Data Product Management", "Conduite du changement"]
categories: ["Thought Leadership"]
summary: "Ce n'est presque jamais le code le problème. C'est l'organisation autour du code."
---

J'ai travaillé sur un projet data qui avait tout pour réussir.

Un budget. Une équipe motivée. Une DSI impliquée. Des données disponibles. Un besoin métier réel.

Et pourtant, les livrables n'arrivaient pas conformes aux attentes du contrat d'interface entre la DSI et le métier. Les tensions montaient. Quelqu'un finissait toujours par porter le chapeau.

C'est un pattern que j'ai vu confirmé, de par des témoignages d'experts lors de webinaires et conférences, dans des configurations différentes, dans des organisations différentes. Et après plusieurs années à travailler au cœur de projets data complexes, j'ai compris pourquoi.

**Ce n'est presque jamais le code, ni les programmes le problème. C'est l'organisation autour du code.**

---

## Le projet parfait sur le papier

L'équipe était constituée d'un chef de projet, d'un manager, d'un alternant, et de quelques profils techniques. Les compétences individuelles étaient là. La bonne volonté aussi.

Mais personne dans cette équipe n'avait de formation solide en **DataOps**. Personne ne savait vraiment faire du **product management appliqué à la data**. La **gouvernance qualité des données** était traitée comme un problème de la DSI, pas de l'équipe projet. Et la **conduite du changement** ? On verrait à la livraison.

Résultat : les livrables pouvaient être techniquement corrects mais inutilisables en production. Les indicateurs pouvaient changer de définition entre deux sprints sans que personne ne le documente. La DSI recevait des données difficiles à industrialiser. Les équipes métier questionnaient les délais, la DSI questionnait la qualité des spécifications — une méfiance mutuelle s'installait, sans que personne n'en soit responsable individuellement.

Et quand la pression montait, il fallait un responsable.

---

## Les 4 compétences que personne n'a pensé à inclure

### 1. DataOps — la mise en production n'est pas la fin, c'est le début

Dans beaucoup d'équipes data, la mise en production est traitée comme une ligne d'arrivée. On livre, on passe à autre chose.

En réalité, c'est le moment où tout commence. Un pipeline data en production doit être **observable, maintenable, reproductible**. Il doit survivre à l'absence de son créateur. Il doit pouvoir être modifié sans tout casser.

Sans quelqu'un qui maîtrise les pratiques DataOps — versionnement, CI/CD, environnements séparés, tests automatisés — chaque mise à jour devient une opération à risque. Et chaque incident devient une crise.

**Ce que ça aurait changé :** un environnement de test séparé de la production, des pipelines versionnés, des Quality Gates bloquantes avant chaque déploiement. Zéro livraison sans validation automatique.

### 2. Data Product Management — savoir ce qu'on construit avant de le construire

Un projet data sans product manager data, c'est une équipe qui construit ce que les développeurs comprennent du besoin métier — pas ce dont le métier a réellement besoin.

Le Data PM n'est pas un chef de projet avec un tableur. C'est quelqu'un qui sait traduire un besoin business en spécification technique, définir des métriques de succès **avant** la livraison, prioriser un backlog par impact réel, et distinguer ce qui doit être livré vite de ce qui doit être fait bien.

Sans cette compétence, les équipes livrent des fonctionnalités que personne n'utilise. Elles passent des mois sur des tableaux de bord que les décideurs ne regardent pas.

**Ce que ça aurait changé :** une phase de discovery avec les vrais utilisateurs, un backlog priorisé par données d'usage, des métriques définies avant chaque sprint — pas après.

### 3. Gouvernance & qualité des données — le problème invisible jusqu'au jour où il explose

La qualité des données est le sujet dont personne ne parle jusqu'à ce qu'un chiffre faux arrive en comité de direction — ou pire, dans une publication publique.

Dans les configurations les plus courantes, chaque équipe a sa propre définition des indicateurs. Les sources de données changent sans que les consommateurs en soient informés. Les anomalies s'accumulent silencieusement jusqu'à ce qu'un utilisateur final les détecte — trop tard, trop visiblement.

Des études sectorielles sur la gouvernance des données montrent que le même indicateur peut avoir jusqu'à trois définitions différentes selon l'équipe interrogée. Pas par mauvaise volonté. Par absence de processus formalisé.

**Ce que ça aurait changé :** un dictionnaire de données maintenu, des Quality Gates automatiques bloquant toute livraison avec des anomalies détectées, un responsable de la donnée identifié pour chaque indicateur critique.

### 4. Conduite du changement — les utilisateurs ne s'adaptent pas spontanément

C'est la compétence la plus sous-estimée de toutes.

Un outil data peut être techniquement parfait et être un échec complet si les utilisateurs ne comprennent pas pourquoi il remplace leur ancien process, comment il fonctionne, et ce qu'ils y gagnent.

La résistance au changement dans les projets data n'est pas de la mauvaise volonté. C'est une réponse normale à un outil qu'on vous impose sans vous expliquer ni vous impliquer.

**Ce que ça aurait changé :** identifier les ambassadeurs avant la livraison, organiser des sessions de test avec les vrais utilisateurs, documenter les cas d'usage concrets, prévoir une phase de transition — pas un basculement brutal.

---

## Ce que j'ai mis en place ensuite

Après m'être formé sur ces sujets, j'ai appliqué une approche différente sur les projets suivants.

**Docs-as-Code** : toute la documentation des règles de gestion métier versionnée comme du code, dans un dépôt partagé, avec un historique de modifications traçable. Plus de règles qui changent sans laisser de trace.

**Quality Gates automatiques** : aucune donnée ne passe en production sans validation automatique des seuils de qualité définis en amont avec les équipes métier. Si un indicateur sort de sa plage normale, le pipeline s'arrête et alerte.

**MVP itératif** : on ne livre pas tout en une fois. On identifie les 20% de fonctionnalités qui couvrent 80% des besoins, on les livre, on mesure, on ajuste. Chaque sprint délivre quelque chose d'utilisable — pas une promesse de livraison future.

**Ambassadeurs identifiés** : avant même la première livraison, on identifie les utilisateurs les plus actifs et les plus influents. Ils testent en avant-première. Ils remontent les problèmes. Ils deviennent les relais internes.

Les problèmes de livraison se sont espacés. Pas parce que le code était meilleur. Parce que l'organisation autour du code avait changé.

---

## La checklist avant votre prochaine mise en production

Avant de démarrer votre prochain projet data, posez-vous ces questions :

- **DataOps** : Avez-vous un environnement de test séparé de la production ? Vos pipelines sont-ils versionnés ? Avez-vous des tests automatisés ?
- **Data PM** : Avez-vous défini les métriques de succès avant de commencer à coder ? Savez-vous qui sont vos utilisateurs prioritaires ?
- **Gouvernance** : Avez-vous un dictionnaire de données ? Qui est responsable de chaque indicateur critique ? Vos Quality Gates sont-elles automatiques ou manuelles ?
- **Conduite du changement** : Avez-vous identifié vos ambassadeurs ? Les utilisateurs finaux ont-ils été impliqués dans la définition du besoin ?

Si vous répondez non à plus de la moitié de ces questions, votre projet n'est pas en retard sur le code. Il est en retard sur l'organisation.

---

*Oumar Fodé KEBE — Mathématicien-Ingénieur Data, Senior Data Product Manager.*  
*[oufoke.github.io](https://oufoke.github.io)*