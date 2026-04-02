# 🌐 Mon Portfolio Personnel | Senior Data Product Manager
[![Visiter le site](https://img.shields.io/badge/Live_Site-oufoke.github.io-blue?style=for-the-badge)](https://oufoke.github.io/)

> *🇺🇸 Source code for my multilingual personal portfolio, showcasing my Data & AI Product Management case studies.*
> *🇫🇷 Code source de mon portfolio personnel multilingue, présentant mes expertises en Data, IA et Stratégie Produit.*

👉 **[Découvrir mon profil et mes projets en ligne](https://oufoke.github.io/)**

---

### 🛠 Architecture & Déploiement (CI/CD)
*Pour les plus curieux, voici comment ce site est construit et maintenu.*

Portfolio statique multilingue (FR/EN) généré avec **Hugo** et le thème **Toha V4**, avec un pipeline de déploiement automatisé (GitHub Actions).

#### Prérequis techniques
[... Garde la suite de tes instructions techniques ici : Node.js, git clone, etc.]

## 🛠 Prérequis techniques

Pour faire tourner ce projet en local, l’environnement suivant est nécessaire :

- **Hugo Extended** (v0.152.0 ou supérieure)
- **Go** (v1.19+)
- **Node.js** (v20 LTS recommandée pour la compatibilité avec le thème)

## 💻 Développement local

### 1. Cloner le dépôt

```bash
git clone https://github.com/oufoke/oufoke.github.io.git
cd oufoke.github.io
```

### 2. Installer les dépendances requises

Pour que les assets (comme les drapeaux SVG multilingues) soient correctement montés par le thème, les dépendances NPM doivent être installées localement.

```bash
nvm use 20
npm install
```

### 3. Lancer le serveur de développement

⚠️ **Éviter d’utiliser `sudo` avec Hugo.**

Si nécessaire, nettoyer le dossier `public/` avant de lancer le serveur :

```bash
rm -rf public/
hugo server --baseURL=http://localhost:1313/
```

Le site sera disponible sur `http://localhost:1313/`.

## 🚀 Déploiement

Ce site est automatiquement hébergé et déployé via **GitHub Pages**.

Tout `push` validé sur la branche `main` déclenche le workflow d’intégration continue `.github/workflows/gh-pages.yml`. Ce workflow compile le site et le publie automatiquement.

### Commandes de mise à jour courantes

```bash
git add .
git commit -m "feat: description de la mise à jour"
git push origin main
```

## 📝 Attributions

- Thème original : [Hugo Toha V4](https://github.com/hugo-toha/toha)
- [Business vector created by studiogstock - www.freepik.com](https://www.freepik.com/vectors/business)
