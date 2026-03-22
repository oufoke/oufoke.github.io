````markdown
# Portfolio personnel — Oumar KEBE

[![Déploiement GitHub Pages](https://github.com/oufoke/oufoke.github.io/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/oufoke/oufoke.github.io/actions)

Portfolio statique multilingue (FR/EN) généré avec **Hugo** et le thème **Toha V4**.

🔗 **Site en ligne :** [https://oufoke.github.io/](https://oufoke.github.io/)

---

## 🛠 Prérequis techniques

Pour faire tourner ce projet en local, l'environnement suivant est nécessaire :
- **Hugo Extended** (v0.152.0 ou supérieure)
- **Go** (v1.19+)
- **Node.js** (v20 LTS recommandée pour la compatibilité avec le thème)

## 💻 Développement local

1. **Cloner le dépôt :**
   ```bash
   git clone [https://github.com/oufoke/oufoke.github.io.git](https://github.com/oufoke/oufoke.github.io.git)
   cd oufoke.github.io
````

2.  **Installer les dépendances requises :**
    Pour que les assets (comme les drapeaux SVG multilingues) soient correctement montés par le thème, les dépendances NPM doivent être installées localement.

    ```bash
    nvm use 20
    npm install
    ```

3.  **Lancer le serveur de développement :**
    ⚠️ **Règle d'or : Ne jamais utiliser `sudo hugo`.**

    Pour éviter les erreurs de cache et les URLs corrompues, il est recommandé d'utiliser cet alias de développement personnalisé :

    ```bash
    # À ajouter dans votre ~/.bashrc
    alias hugodev="sudo rm -rf public/ && hugo server --baseURL=http://localhost:1313/"
    ```

    Lancez ensuite la commande :

    ```bash
    hugodev
    ```

    Le site sera disponible sur `http://localhost:1313/`.

## 🚀 Déploiement

Ce site est automatiquement hébergé et déployé via **GitHub Pages**.
Tout `push` validé sur la branche `main` déclenche le workflow d'intégration continue `.github/workflows/gh-pages.yml`. Ce workflow compile le site et le publie automatiquement.

**Commandes de mise à jour courantes :**

```bash
git add .
git commit -m "feat: description de la mise à jour"
git push origin main
```

## 📝 Attributions

  - Thème original : [Hugo Toha V4](https://github.com/hugo-toha/toha)
  - \<a href='https://www.freepik.com/vectors/business'\>Business vector created by studiogstock - www.freepik.com\</a\>

<!-- end list -->

```

Dès que ce fichier est enregistré et poussé sur ton dépôt, ton profil GitHub affichera une documentation claire et professionnelle. As-tu pu vérifier l'affichage des drapeaux sur ton site en ligne en parallèle ?
```
