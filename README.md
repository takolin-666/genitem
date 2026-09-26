# Genitem

**Génération et analyse d'items assistées par IA, entièrement sur votre machine.**

[![Documentation : CC BY 4.0](https://img.shields.io/badge/docs-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![Code : MIT](https://img.shields.io/badge/code-MIT-green.svg)](LICENSE)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.22801168-blue.svg)](https://doi.org/10.5281/zenodo.22801168)

Site : <https://genitem.recherche-formation.com>

**Français** · [English](README.en.md) *(traduit par IA)*

---

## De quoi s'agit-il

Genitem réunit des outils, utilisables dans un navigateur, destinés aux
chercheurs qui construisent et éprouvent des instruments de mesure. Ils
couvrent la partie initiale et coûteuse du travail — rédiger un pool d'items, en vérifier
la structure, coder des retours qualitatifs, traduire un instrument — au moyen
de grands modèles de langue qui tournent en local.

Rien n'est envoyé nulle part. Les pages n'appellent aucun modèle : chacune
compose un script Python que vous téléchargez et lancez sur votre ordinateur,
contre un serveur [Ollama](https://ollama.com) local. Pas de clé d'API, pas de
compte, aucune trace sur le disque d'un tiers. Cela compte pour des données
d'étudiants, des réponses de préenquête, et tout ce que couvre une autorisation
éthique interdisant la transmission à des services externes.

Toutes les pages sont bilingues, français et anglais.

---

## Les outils

### 1. Génération d'items — `AI-agent.html`

Un configurateur pour une chaîne multi-agents, puis les deux sorties possibles.

**Étape 1 — configurer les agents.** Un *générateur* rédige le pool : vous lui
donnez un modèle, le construit, le nombre d'items, leur type — dichotomique ou
échelle d'accord — et ses consignes. Plusieurs *relecteurs* critiquent ensuite
le brouillon en parallèle — contenu, formulation, couverture du construit — sur
autant de tours que vous fixez ; les cartes de relecteurs s'ajoutent et se
retirent. Un agent *final* produit la version révisée.

**Étape 2 — exporter `agents.txt`.** Toute la configuration devient un script
Python commenté. Vous pouvez le lire avant de le lancer, et le garder comme
trace de ce qui a produit un pool donné.

**Étape 3 — générer.** Deux fenêtres PowerShell : collez
[`1-lancer-ollama.txt`](powershell/1-lancer-ollama.txt) dans la première, qui
démarre Ollama et reste ouverte, et
[`2-generer-items.txt`](powershell/2-generer-items.txt) dans la seconde, qui
exécute le script. Il écrit les items, l'échange complet entre agents, et
`AI-GENIE.txt` — le pool dans la forme qu'attend la chaîne R.

**La bifurcation.** La suite dépend du nombre de construits mesurés, et la page
vous pose la question :

```
                    AI-GENIE.txt
                         │
        ┌────────────────┴────────────────┐
        │                                 │
  Valider les items              Assigner les facteurs
  un seul construit               plusieurs construits
        │                                 │
        │                    charger AI-GENIE.txt
        │                    fixer le nombre de facteurs
        │                    cocher le facteur de chaque item
        │                    exporter pour AI-GENIE
        │                                 │
        └────────────────┬────────────────┘
                         │
                 Étape 4 — analyser avec AI-GENIE
                    scripts/analyse_genie.R
```

Avec un seul construit, il n'y a rien à trier : le pool part directement vers
la validation structurelle. Avec plusieurs, les items doivent d'abord être
attribués à leur facteur, un par un, par vous. La page les présente dans un
tableau avec une colonne par facteur ; rien n'est déduit, car un item mal
attribué fausse précisément la structure dimensionnelle que l'analyse cherche à
estimer.

**Étape 4 — analyser.** Une troisième commande,
[`3-analyser-ai-genie.txt`](powershell/3-analyser-ai-genie.txt), lance la
chaîne R.

### 2. Comparaison de modèles — `test_modeles.html`

La même consigne soumise à plusieurs modèles installés, côte à côte, avec ce
que chacun produit et le temps qu'il y met. Utile avant de s'engager : un
modèle à 1 milliard de paramètres et un modèle à 8 milliards diffèrent bien
plus que leur taille ne le laisse croire, et la différence se voit mieux
qu'elle ne se prévoit.

### 3. Gestion des modèles — `aide.html`

Ajout et suppression de modèles Ollama, enregistrés par compte. Contient aussi
des méthodes d'installation de secours et un diagnostic Ollama pour les cas où
rien ne démarre. Demande un compte sur le site.

### 4. Codage de verbatims — `ia-humain.html`

Classe des retours écrits selon le cadre à sept niveaux de Lee et Ha (2026),
Table 3, repris sans modification et en anglais — la langue de l'instrument.

| Niveau | Type | Description |
|---|---|---|
| 0 | Irrelevant Feedback | Sans lien avec la réponse, ou sans contenu exploitable |
| 1 | General Impression | Impression vague ou superficielle sur l'ensemble |
| 2 | Correctness-Focused | Seulement si la réponse est juste, ou sa comparaison au corrigé |
| 3 | Rubric-Based | Jugement selon la grille : structure et validité d'ensemble |
| 4 | Error Identification | Signale une erreur précise ou un élément manquant |
| 5 | Commentary | Relève une force ou une faiblesse et l'explique |
| 6 | Suggestion with Alternative | Propose une alternative concrète ou un autre angle |

Plusieurs modèles codent chaque verbatim de leur côté. S'ils s'accordent, le
verbatim est réglé. Sinon, chacun reçoit les classements des autres et reprend
son analyse, jusqu'à un plafond que vous fixez. Passé ce plafond, le niveau
majoritaire l'emporte. Un modèle final rédige la justification du niveau
retenu ; il n'arbitre pas, car compter des voix identiques est de
l'arithmétique et n'a rien à faire dans un modèle de langue.

Entrée : un classeur avec l'identifiant en colonne A et le verbatim en colonne
B, la première ligne étant un intitulé. Sortie : un classeur portant le
classement de chaque modèle à chaque étape, le niveau retenu, l'accord et le
nombre de tours.

### 5. Rétrotraduction — `retrotraduction.html`

Traduction, puis une ou deux rétrotraductions à l'aveugle par des modèles
différents, puis comparaison à la source. Le classeur s'ouvre sur la traduction
à conserver, avec sa provenance et son verdict d'équivalence ; le détail des
deux passages occupe la deuxième feuille.

La rétrotraduction à l'aveugle est la norme pour adapter un instrument de
mesure. Une traduction directe, si bonne soit-elle, n'est pas validée par le
fait qu'elle se lit bien.

### 6. Validation structurelle — `scripts/analyse_genie.R`

Applique le paquet R [AIGENIE](https://github.com/laralee/AIGENIE) à un pool
d'items : embeddings, Exploratory Graph Analysis, Unique Variable Analysis pour
la redondance, et bootstrap EGA pour la stabilité. Exporte les résultats vers
Excel, avec les graphiques.

`analyse_genie_multi_construits.R` fait de même sur plusieurs construits.

---

## Prérequis

- **Windows**, avec PowerShell (les commandes de lancement sont écrites pour lui)
- **[Ollama](https://ollama.com)** et au moins un modèle installé
- **Python 3** avec `ollama` et `openpyxl`
- **R** avec `AIGENIE`, `ggplot2` et `writexl`, pour la validation structurelle seule

Une installation portable — Ollama, Python et R sur un seul disque amovible,
sans rien installer sur la machine hôte — est disponible depuis le site.

Voir [Quelle commande lance quoi](#quelle-commande-lance-quoi) plus bas pour les
trois commandes PowerShell et la manière dont elles trouvent ce disque.

### Choisir un modèle

Les petits modèles sont tentants et décevants. Un modèle à 0,8 milliard de
paramètres à qui l'on demande trente items distincts tournera autour de
quelques tournures, et l'Unique Variable Analysis en supprimera ensuite la
plupart — n'en laissant pas assez pour que bootstrap EGA puisse seulement
s'exécuter. `mistral:7b`, `qwen3:8b` ou `gemma4:e4b` sont des points de départ
raisonnables. Les modèles à raisonnement fonctionnent mais sont lents, et le
raisonnement apporte peu sur des tâches de codage et de traduction.

---

## Structure du dépôt

```
pages/          les six outils — un fichier HTML autonome chacun
powershell/     les trois commandes à coller dans une fenêtre PowerShell
scripts/        l'analyse R (chaîne AI-GENIE)
ressources/     la grille de codage et ses sources
wordpress/      la couche mince qui affiche les pages sur le site
```

Aucune étape de compilation, aucun empaqueteur, aucune dépendance à installer.
Ouvrez n'importe quel fichier de `pages/` dans un navigateur et il fonctionne,
depuis un serveur comme depuis une clé USB.

### Quel fichier fait quoi

Chaque outil est une page sur le site, un fichier HTML ici, et — pour les trois
outils qui font tourner des modèles — un script Python exporté et un classeur.

| Page sur le site | Fichier du dépôt | Exporte | Produit |
|---|---|---|---|
| [`/app/`](https://genitem.recherche-formation.com/app/) — AI-agent | `pages/AI-agent.html` | `agents.txt` | le pool d'items, l'échange entre agents, `AI-GENIE.txt` |
| [`/test_modeles/`](https://genitem.recherche-formation.com/test_modeles/) — Test modèles | `pages/test_modeles.html` | `test_modeles.txt` | une comparaison, relue dans la page |
| [`/ia-humain/`](https://genitem.recherche-formation.com/ia-humain/) — Verbatims | `pages/ia-humain.html` | `classement.txt` | `classement_<date>.xlsx` |
| [`/retrotraduction/`](https://genitem.recherche-formation.com/retrotraduction/) — Rétrotraduction | `pages/retrotraduction.html` | `retrotraduction.txt` | `retrotraduction_<date>.xlsx` |
| [`/aide/`](https://genitem.recherche-formation.com/aide/) — Aide *(compte)* | `pages/aide.html` | — | gère la liste des modèles |
| [`/extra/`](https://genitem.recherche-formation.com/extra/) — Extra | `pages/bonus.html` | — | page d'accueil des trois outils annexes |

Le script exporté est un `.txt` et non un `.py`, à dessein : il est écrit pour
être lu avant d'être lancé. Renommez-le si vous préférez.

### Quelle commande lance quoi

Trois commandes, **à coller dans une fenêtre PowerShell** plutôt qu'à exécuter
comme des fichiers. Windows bloque par défaut les scripts `.ps1` téléchargés,
et le collage contourne cela sans demander à personne d'abaisser un réglage de
sécurité.

| Commande | Fenêtre | Ce qu'elle lance |
|---|---|---|
| [`1-lancer-ollama.txt`](powershell/1-lancer-ollama.txt) | la première, qui reste ouverte | le serveur Ollama |
| [`2-generer-items.txt`](powershell/2-generer-items.txt) | la seconde | `agents.txt`, exporté depuis `/app/` |
| [`3-analyser-ai-genie.txt`](powershell/3-analyser-ai-genie.txt) | la seconde | `scripts/analyse_genie.R` |

La première sert à tous les outils : rien ne tourne sans Ollama. Les scripts
exportés par les pages des verbatims et de la rétrotraduction se lancent comme
la deuxième commande, le nom du script changé.

Chacune commence par repérer l'installation **par son contenu plutôt que par sa
lettre** : elle cherche un dossier nommé `ollama` contenant `ollama.exe`,
d'abord à la racine de chaque disque, puis plus profondément, puis dans le
profil utilisateur — où elle crée un disque virtuel court avec `subst`, Windows
butant toujours sur les chemins longs. Un disque amovible qui apparaît en `E:`
sur une machine et en `H:` sur la suivante n'a rien à modifier. Elles sont
commentées pas à pas ; en lire une est le moyen le plus rapide de voir comment
les pièces s'emboîtent.

Un défaut connu : la recherche profonde parcourt aussi les disques réseau, et
affiche des erreurs en rouge quand l'un d'eux est injoignable. Rien n'est cassé
quand cela se produit — y remédier figure parmi les premières contributions
utiles.

### Comment s'enchaîne un traitement

```
  /app/  ──exporte──▶  agents.txt
                            │
  coller 1-lancer-ollama.txt ──▶  Ollama tourne, fenêtre laissée ouverte
                            │
  coller 2-generer-items.txt ──▶  python agents.txt
                            │
                            ├──▶  items + échange
                            └──▶  AI-GENIE.txt
                                        │
  coller 3-analyser-ai-genie.txt ──▶  Rscript analyse_genie.R
                                        │
                                        └──▶  résultats + graphiques (.xlsx)
```

Les outils de verbatims et de rétrotraduction suivent les mêmes trois temps —
exporter, démarrer Ollama, lancer le script — et relisent leur propre classeur
pour l'afficher.

---

## Comprendre et modifier

- **[SITEMAP.md](SITEMAP.md)** — le menu et la navigation du site, et l'ordre
  dans lequel un chercheur parcourt les outils.
- **[ARCHITECTURE.md](ARCHITECTURE.md)** — comment une page est faite, pourquoi
  elle écrit un script Python au lieu d'appeler un modèle, les conventions
  communes et les points faibles connus.
- **[CONTRIBUTING.md](CONTRIBUTING.md)** — comment proposer une amélioration,
  ce qui fait une bonne première contribution, et les deux ou trois changements
  qui ressembleraient à des améliorations mais casseraient le projet.

En bref : pas de cadriciel, pas d'étape de compilation, un fichier par outil,
et la page ne parle jamais à un modèle elle-même.

---

## Limites connues

Le cadre à sept niveaux n'est reproduit qu'en anglais. Les grilles que nous
avions fait traduire automatiquement dans d'autres langues ont été retirées :
aucune n'avait été validée par rétrotraduction, ce qui est précisément la
raison d'être de l'outil 5.

La règle de codage unique — coder le niveau le plus élevé dont la définition
est pleinement remplie, et en cas d'hésitation retenir le plus élevé de ceux
envisagés — est de nous, non de Lee et Ha. La Table 3 donne les niveaux et rien
d'autre. Quiconque publie des résultats obtenus ici devrait le mentionner.

L'accord entre modèles n'est pas l'accord entre codeurs. Deux instances du même
modèle s'accordent presque toujours, et cet accord ne mesure rien.

---

## Citation

> Jan, D., Beland, S., Vincent, C., & Michelot, F. (2026). *Genitem: A
> user-friendly tool for the generation and pre-validation of items with AI*
> (Version 0.1) [Computer software]. Zenodo.
> <https://doi.org/10.5281/zenodo.22801169>

Deux DOI coexistent, Zenodo en délivrant toujours deux :

| DOI | Renvoie à |
|---|---|
| [10.5281/zenodo.22801168](https://doi.org/10.5281/zenodo.22801168) | toutes les versions — à citer pour désigner le logiciel en général |
| [10.5281/zenodo.22801169](https://doi.org/10.5281/zenodo.22801169) | la version 0.1 — à citer pour désigner le code exact utilisé |

Pour la reproductibilité, citez la version que vous avez exécutée. Une fiche de
citation au format RDF est également disponible depuis le site, et le fichier
`CITATION.cff` de ce dépôt alimente le bouton *Cite this repository* de GitHub.

### Travaux dont dépend ce projet

- Russell-Lasalandra, L. L., Christensen, A. P., & Golino, H. (2026).
  Generative psychometrics via AI-GENIE: Automatic item generation and
  validation with network-integrated evaluation. *Behavior Research Methods*.
  <https://doi.org/10.3758/s13428-026-03082-1>
- Lee, & Ha (2026). *Sage Open*. <https://doi.org/10.1177/21582440261418083>

---

## Licence

Le code — HTML, JavaScript, Python, R et PowerShell — est diffusé sous
[licence MIT](LICENSE). La documentation, la grille de codage et les autres
ressources écrites sont diffusées sous
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), voir
[LICENSE-DOCS](LICENSE-DOCS).

Le partage est délibéré. Les licences Creative Commons ne sont pas conçues pour
le logiciel : elles n'accordent aucun droit de brevet et ne portent pas de
clause de garantie adaptée au code. L'attribution est exigée des deux côtés.

---

## Écrit avec l'aide d'une IA

Deux mentions, faites parce que le projet porte sur le travail assisté par IA
et qu'il serait étrange de s'en cacher.

**La version anglaise du site** est une traduction produite avec Claude
(Opus 5, Anthropic) à partir de l'original français. En cas d'écart entre les
deux, le français fait foi.

**La documentation de ce dépôt** — ce fichier, `README.en.md`, `ARCHITECTURE.md`,
`CONTRIBUTING.md` et `SITEMAP.md` — a été rédigée avec Claude à partir des
fichiers sources du projet, puis publiée sous la responsabilité des auteurs. Le
code lui-même, la grille de codage et les décisions de recherche sont des
auteurs.

Des erreurs de fait dans la documentation restent possibles, ici comme
ailleurs, et peut-être un peu plus. Signalez-les comme n'importe quel autre
défaut.

---

## Financement et rattachement

Mené dans le cadre d'un projet affilié à l'**Université de Fribourg**, avec le
soutien du **Fonds du centenaire** (projet FC-26-989), et en collaboration avec
l'**Université de Montréal**.

## Contact

<info@genitem.education>
