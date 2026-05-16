#!/bin/bash
# ══════════════════════════════════════════════════════════════════════════════
# PORTFOLIO DEPLOY — Script sécurisé complet
# Auteur : Oumar Fodé KEBE
# Usage  : bash deploy_portfolio.sh
# Depuis : ~/Bureau/portofolio-oumar  (racine du repo Hugo)
# Sources: /home/oumar/Téléchargements/maj Deploy potofolio/
# ══════════════════════════════════════════════════════════════════════════════

set -e

YAML_SRC="/home/oumar/Téléchargements/maj Deploy potofolio"
BRANCH_DEV="dev"
BRANCH_STRAT="strategie-branding"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; NC='\033[0m'; BOLD='\033[1m'

log()  { echo -e "${GREEN}✓${NC}  $1"; }
warn() { echo -e "${YELLOW}⚠${NC}  $1"; }
info() { echo -e "${BLUE}▸${NC}  $1"; }
err()  { echo -e "${RED}✗${NC}  $1"; exit 1; }
sep()  { echo -e "\n${BOLD}── $1 $(printf '─%.0s' {1..40})${NC}"; }

# ── 1. VÉRIFICATIONS ──────────────────────────────────────────────────────────
sep "VÉRIFICATIONS"

[ -f "hugo.yaml" ] || [ -f "hugo.toml" ] || [ -f "config.toml" ] \
  || err "Lancez depuis la racine du repo Hugo : cd ~/Bureau/portofolio-oumar"

[ -d "$YAML_SRC" ] \
  || err "Dossier source introuvable : $YAML_SRC"

[ -f "$YAML_SRC/projects_fr_updated.yaml" ] \
  || err "projects_fr_updated.yaml absent dans $YAML_SRC — vérifiez le nom du dossier"

command -v git &>/dev/null || err "git non installé"
command -v hugo &>/dev/null || warn "hugo non trouvé — test local ignoré"

log "Repo    : $(pwd)"
log "Sources : $YAML_SRC"
log "Remote  : $(git remote get-url origin 2>/dev/null || echo 'local uniquement')"

# Stash si fichiers non commités
if [ -n "$(git status --porcelain)" ]; then
  warn "Fichiers non commités → stash automatique"
  git stash push -m "auto-stash avant deploy $(date +%Y%m%d_%H%M%S)"
  STASHED=true
else
  STASHED=false
fi

# ── 2. BRANCHES ───────────────────────────────────────────────────────────────
sep "BRANCHES GIT"

info "Branche actuelle : $(git branch --show-current)"

# dev
if git show-ref --verify --quiet "refs/heads/$BRANCH_DEV"; then
  git checkout "$BRANCH_DEV"
  git pull origin "$BRANCH_DEV" 2>/dev/null || warn "Remote $BRANCH_DEV absent — local seulement"
  log "Basculé sur $BRANCH_DEV (existante)"
else
  git checkout -b "$BRANCH_DEV"
  log "Créé : $BRANCH_DEV"
fi

# strategie-branding
if git show-ref --verify --quiet "refs/heads/$BRANCH_STRAT"; then
  warn "$BRANCH_STRAT existe déjà — basculement"
  git checkout "$BRANCH_STRAT"
else
  git checkout -b "$BRANCH_STRAT"
  log "Créé depuis $BRANCH_DEV : $BRANCH_STRAT"
fi

log "Branche active : $(git branch --show-current)"

# ── 3. COPIE DES YAML ─────────────────────────────────────────────────────────
sep "COPIE DES FICHIERS YAML"

cp_yaml() {
  local src="$YAML_SRC/$1" dst="$2" label="$3"
  if [ -f "$src" ]; then
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    log "$label"
  else
    warn "Absent, ignoré : $1"
  fi
}

# FR sections
cp_yaml "projects_fr_updated.yaml"    "data/fr/sections/projects.yaml"     "projects.yaml FR"
cp_yaml "about_fr_updated.yaml"       "data/fr/sections/about.yaml"        "about.yaml FR"
cp_yaml "experiences_fr_updated.yaml" "data/fr/sections/experiences.yaml"  "experiences.yaml FR"
cp_yaml "achievements_updated.yaml"   "data/fr/sections/achievements.yaml" "achievements.yaml FR"

# EN sections
cp_yaml "projects_en_updated.yaml"    "data/en/sections/projects.yaml"     "projects.yaml EN"
cp_yaml "about_en_updated.yaml"       "data/en/sections/about.yaml"        "about.yaml EN"
cp_yaml "experiences_en_updated.yaml" "data/en/sections/experiences.yaml"  "experiences.yaml EN"

# author.yaml FR — tout ce qui est avant le bloc EN commenté
if [ -f "$YAML_SRC/author_updated.yaml" ]; then
  awk '/^# ══.*data\/en\/author/{exit} {print}' \
    "$YAML_SRC/author_updated.yaml" > data/fr/author.yaml
  log "author.yaml FR"

  # author.yaml EN — décommenter le bloc EN
  awk '/^# ══.*data\/en\/author/{f=1;next} f && /^#/{sub(/^# ?/,"");print} f && /^[^#]/{print}' \
    "$YAML_SRC/author_updated.yaml" > data/en/author.yaml
  [ -s data/en/author.yaml ] \
    && log "author.yaml EN" \
    || warn "author EN vide → copier manuellement la section EN de author_updated.yaml"
fi

# achievements.yaml EN — décommenter le bloc EN
if [ -f "$YAML_SRC/achievements_updated.yaml" ]; then
  awk '/^# ══.*data\/en\/sections\/achievements/{f=1;next} f && /^#/{sub(/^# ?/,"");print} f && /^[^#]/{print}' \
    "$YAML_SRC/achievements_updated.yaml" > data/en/sections/achievements.yaml
  [ -s data/en/sections/achievements.yaml ] \
    && log "achievements.yaml EN" \
    || warn "achievements EN vide → à remplir manuellement"
fi

# Vider publications placeholder FR + EN
for lang in fr en; do
  PUB="data/$lang/sections/publications.yaml"
  [ -f "$PUB" ] || continue
  cat > "$PUB" << 'YAML'
section:
  name: Publications
  id: publications
  enable: false
  weight: 6
  showOnNavbar: false

buttons: []
publications: []
YAML
  log "publications $lang — placeholder vidé"
done

# ── 4. SUPPRESSION NOTES TOHA ─────────────────────────────────────────────────
sep "SUPPRESSION NOTES TOHA"

for lang in fr en; do
  DIR="content/$lang/notes"
  if [ -d "$DIR" ]; then
    # git rm pour que la suppression soit trackée proprement
    git rm -rf "$DIR" 2>/dev/null || rm -rf "$DIR"
    log "Supprimé (git rm) : $DIR"
  else
    info "Déjà absent : $DIR"
  fi
done

# ── 5. ARTICLES BLOG ──────────────────────────────────────────────────────────
sep "ARTICLES BLOG"

mkdir -p content/fr/posts content/en/posts

# Index si absent
for f in "content/fr/posts/_index.md" "content/en/posts/_index.md"; do
  [ -f "$f" ] && continue
  echo -e "---\ntitle: \"Articles\"\n---" > "$f"
  log "Index créé : $f"
done

# Copier depuis sources si présents, sinon créer inline
copy_article() {
  local src="$YAML_SRC/$1" dst="$2" label="$3"
  if [ -f "$src" ]; then
    cp "$src" "$dst"; log "$label (depuis sources)"
  else
    info "$label — création inline (fichier source absent)"
    return 1
  fi
}

# Article 1 FR
copy_article "article1_mise_en_prod_hugo.md" \
  "content/fr/posts/pourquoi-vos-projets-data-ratent-mise-en-prod.md" \
  "Article 1 FR" || cat > content/fr/posts/pourquoi-vos-projets-data-ratent-mise-en-prod.md << 'MD'
---
title: "Pourquoi vos projets data ratent leur mise en production"
date: 2026-05-15
draft: false
tags: ["DataOps", "Gouvernance", "Data Product Management", "Conduite du changement"]
categories: ["Thought Leadership"]
summary: "Ce n'est jamais le code qui rate. C'est l'organisation autour du code."
---

J'ai travaillé sur un projet data qui avait tout pour réussir. Budget, équipe, DSI, données, besoin métier. Et pourtant les livrables n'arrivaient pas.

**Ce n'est jamais le code qui rate. C'est l'organisation autour du code.**

## Les 4 compétences absentes

**DataOps** — Sans CI/CD, environnements séparés et tests automatisés, chaque update est une opération à risque.

**Data Product Management** — Sans Data PM, les équipes livrent ce que les devs ont compris du besoin. Les métriques se définissent après la livraison, pas avant.

**Gouvernance & qualité des données** — J'ai vu des projets où le même indicateur avait trois définitions selon qui vous demandiez. Pas de mauvaise volonté — absence de processus.

**Conduite du changement** — La résistance n'est pas de la mauvaise volonté. C'est une réponse normale à un outil imposé sans explication.

## Ce que j'ai mis en place

- Docs-as-Code : règles métier versionnées, traçables
- Quality Gates automatiques : aucune donnée en prod sans validation
- MVP itératif : chaque sprint livre quelque chose d'utilisable
- Ambassadeurs identifiés avant la première livraison

Les problèmes de livraison se sont espacés. Pas parce que le code était meilleur. Parce que l'organisation autour du code avait changé.

---
*Oumar Fodé KEBE — Senior Data Product Manager | IA & Gouvernance Data · [oufoke.github.io](https://oufoke.github.io)*
MD
log "Article 1 FR"

# Article 2 FR
copy_article "article2_bi_inutile_hugo.md" \
  "content/fr/posts/pourquoi-vos-tableaux-de-bord-bi-ne-servent-a-rien.md" \
  "Article 2 FR" || cat > content/fr/posts/pourquoi-vos-tableaux-de-bord-bi-ne-servent-a-rien.md << 'MD'
---
title: "Pourquoi vos tableaux de bord BI ne servent à rien — et comment en sortir"
date: 2026-05-15
draft: false
tags: ["Business Intelligence", "DataOps", "Data Product Management", "Power BI", "Digdash"]
categories: ["Thought Leadership"]
summary: "3 318 consultations. 10 pages = 76,7% du trafic. Le reste existait pour rien."
---

**3 318 consultations sur 4 mois. 60 pages disponibles.** 10 pages concentraient 76,7% du trafic. Les autres : moins de 3 clics sur 4 mois. Ce n'est pas une anomalie — c'est la règle.

## Pourquoi ça arrive

**On construit par l'offre, pas par la demande.** La bonne logique : décisions à prendre → données → vues qui facilitent ces décisions.

**On mélange opérationnel et stratégique.** Règle simple : un tableau de bord = une audience = une décision type.

**On ne mesure pas l'usage.** Sans logs d'usage, vous pilotez à l'aveugle.

## Ce que j'ai fait concrètement

1. Audit logs d'usage — 2 jours qui ont orienté 3 mois de dev
2. Restructuration en 4 pôles par décision, pas par catégorie de données
3. Module stratégique séparé : 5 indicateurs C-Level, réponse en 30 secondes
4. 10 ambassadeurs parmi les 126 utilisateurs actifs — testeurs avant déploiement général

## La question clé

**Savez-vous quels rapports vos utilisateurs ont ouverts la semaine dernière ?**

Si non — vous construisez pour vous, pas pour eux.

---
*Oumar Fodé KEBE — Senior Data Product Manager | IA & Gouvernance Data · [oufoke.github.io](https://oufoke.github.io)*
MD
log "Article 2 FR"

# Article 1 EN
copy_article "article1_mise_en_prod_hugo.md" \
  "content/en/posts/why-your-data-projects-fail-at-production.md" \
  "Article 1 EN" || cat > content/en/posts/why-your-data-projects-fail-at-production.md << 'MD'
---
title: "Why your data projects fail at production"
date: 2026-05-15
draft: false
tags: ["DataOps", "Governance", "Data Product Management", "Change Management"]
categories: ["Thought Leadership"]
summary: "It's never the code that fails. It's the organization around the code."
---

**It's never the code that fails. It's the organization around the code.**

## The 4 missing competencies

**DataOps** — Without CI/CD, separate environments, and automated tests, every update is a risky operation.

**Data Product Management** — Without a Data PM, teams ship what developers understood of the need — not what the business actually needs.

**Data Governance & Quality** — I've seen projects where the same KPI had three different definitions. Not bad intent — no process.

**Change Management** — Resistance isn't bad will. It's a normal response to a tool imposed without explanation.

## What I put in place

- Docs-as-Code: business rules versioned and traceable
- Automatic Quality Gates: no data reaches production without validation
- Iterative MVP: every sprint delivers something usable
- Ambassadors identified before the first release

Delivery problems decreased. Not because the code was better. Because the organization around the code had changed.

---
*Oumar Fodé KEBE — Senior Data Product Manager | AI & Data Governance · [oufoke.github.io/en/](https://oufoke.github.io/en/)*
MD
log "Article 1 EN"

# Article 2 EN
copy_article "article2_bi_inutile_hugo.md" \
  "content/en/posts/why-your-bi-dashboards-are-useless.md" \
  "Article 2 EN" || cat > content/en/posts/why-your-bi-dashboards-are-useless.md << 'MD'
---
title: "Why your BI dashboards are useless — and how to fix it"
date: 2026-05-15
draft: false
tags: ["Business Intelligence", "DataOps", "Data Product Management", "Power BI", "Digdash"]
categories: ["Thought Leadership"]
summary: "3,318 sessions analyzed. 10 pages drove 76.7% of traffic. The rest existed for nothing."
---

**3,318 sessions over 4 months. 60 pages available.** 10 pages drove 76.7% of all traffic. The rest: fewer than 3 clicks over 4 months. This isn't an anomaly — it's the norm.

## Why it happens

**Building by supply, not demand.** Right logic: decisions to make → data needed → views that enable those decisions.

**Mixing operational and strategic.** One dashboard = one audience = one decision type.

**Not measuring usage.** Without usage logs, you're flying blind.

## What I did concretely

1. Usage log audit — 2 days that guided 3 months of development
2. Restructured into 4 thematic clusters by decision type
3. Separate strategic module: 5 C-Level KPIs only, answer in 30 seconds
4. 10 ambassadors among 126 active users — tested before general deployment

## The key question

**Do you know which reports your users opened last week?**

If not — you're not building for your users. You're building for yourself.

---
*Oumar Fodé KEBE — Senior Data Product Manager | AI & Data Governance · [oufoke.github.io/en/](https://oufoke.github.io/en/)*
MD
log "Article 2 EN"

# ── 6. ACTIVATION BLOG ────────────────────────────────────────────────────────
sep "ACTIVATION BLOG"

for lang in fr en; do
  FILE="data/$lang/sections/recent-posts.yaml"
  if [ -f "$FILE" ]; then
    sed -i.bak 's/enable: false/enable: true/g' "$FILE"
    sed -i.bak 's/showOnNavbar: false/showOnNavbar: true/g' "$FILE"
    rm -f "${FILE}.bak"
    log "Blog activé : $lang"
  else
    warn "recent-posts.yaml absent ($lang)"
  fi
done

# ── 7. BUILD HUGO ─────────────────────────────────────────────────────────────
sep "BUILD HUGO"

git add -A

if command -v hugo &>/dev/null; then
  info "hugo --minify --quiet..."
  hugo --minify --quiet 2>&1 && log "Build OK" || err "Build en erreur — corrigez avant de merger"
else
  warn "Hugo absent — vérifiez manuellement"
fi

# ── 8. COMMIT ─────────────────────────────────────────────────────────────────
sep "COMMIT"

CHANGED=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')

if [ "$CHANGED" -eq 0 ]; then
  warn "Aucun changement à commiter"
else
  git commit -m "feat(branding): portfolio stratégie v2 complet

- about FR/EN : accroche propriétaire + preuves chiffrées
- experiences FR/EN : DICN poste distinct + metrics réels
- projects FR/EN : OptIMMO en tête + format Problème→Impact
- author FR/EN : 4 punchlines alignées
- achievements FR/EN : connexion pro
- Blog FR/EN activé + 4 articles thought leadership
- Notes Toha Go/Bash supprimées (git rm)
- Publications placeholder vidées

Objectif : Head of Data / VP AI Products — novembre 2026"
  log "$CHANGED fichiers commités"
fi

# ── 9. INSTRUCTIONS FINALES ───────────────────────────────────────────────────
sep "PROCHAINES ÉTAPES"

echo ""
echo -e "  ${BOLD}1. TEST VISUEL${NC}"
echo -e "     hugo serve --disableFastRender"
echo -e "     → FR : http://localhost:1313"
echo -e "     → EN : http://localhost:1313/en/"
echo -e "     Ctrl+C pour arrêter"
echo ""
echo -e "  ${BOLD}2. MERGER strategie-branding → dev${NC}"
echo -e "     git checkout $BRANCH_DEV"
echo -e "     git merge --no-ff $BRANCH_STRAT \\"
echo -e "       -m 'merge: strategie-branding complet'"
echo ""
echo -e "  ${BOLD}3. MERGER dev → main + PUSH${NC}"
echo -e "     git checkout main"
echo -e "     git merge --no-ff $BRANCH_DEV \\"
echo -e "       -m 'release: portfolio v2 branding'"
echo -e "     git push origin main"
echo ""
echo -e "  ${BOLD}4. VÉRIFIER GITHUB PAGES (1-2 min)${NC}"
echo -e "     https://oufoke.github.io"
echo -e "     https://oufoke.github.io/en/"
echo ""
echo -e "  ${BOLD}ROLLBACK si problème${NC}"
echo -e "     git revert HEAD --no-edit && git push origin main"
echo ""

# Résumé commit
echo -e "  ${BOLD}Fichiers dans ce commit :${NC}"
git show --stat HEAD 2>/dev/null | grep '|' | sed 's/^/     /' || true

[ "$STASHED" = true ] && \
  echo -e "\n  ${YELLOW}⚠${NC}  Stash à restaurer : git stash pop"

echo ""
log "Script terminé — branche : $(git branch --show-current)"
