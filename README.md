# Genitem

**Générer, adapter et vérifier des items de questionnaires avec l'IA, entièrement sur votre ordinateur.**

[![Licence : CC BY-NC 4.0](https://img.shields.io/badge/licence-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.22801168-blue.svg)](https://doi.org/10.5281/zenodo.22801168)

Site : <https://genitem.recherche-formation.com>

**Français** · [English](README.en.md) · [Español](README.es.md) · [Deutsch](README.de.md) · [Português](README.pt.md) · [Italiano](README.it.md)

## Vidéo de présentation

<a href="https://genitem.recherche-formation.com/wp-content/uploads/data/genitem-fr.mp4"><img src="ressources/vignettes/genitem-fr.jpg" width="480" alt="Regarder la présentation générale de Genitem (2 minutes)"></a>

[Regarder la présentation générale de Genitem (2 minutes)](https://genitem.recherche-formation.com/wp-content/uploads/data/genitem-fr.mp4)

---

## De quoi s'agit-il

Genitem (Jan et al., 2026) est une suite d'outils gratuits, utilisables dans un
navigateur, pour les chercheuses et chercheurs qui construisent, adaptent et
vérifient des questionnaires, des enquêtes et des échelles de mesure. L'IA
générative y fait le travail répétitif. L'expertise humaine garde la main sur
chaque décision.

Tous les modèles de langue tournent **en local**, sur l'ordinateur de la
personne qui mène la recherche, grâce à [Ollama](https://ollama.com) (Windows,
macOS ou Linux). Aucun item, aucune réponse et aucune donnée personnelle n'est
envoyé à un service externe. Genitem convient donc aux études soumises à des
exigences éthiques ou de protection des données strictes.

L'interface existe en six langues : français, anglais, espagnol, allemand,
portugais et italien.

---

## L'outil central : la génération d'items

La génération d'items se fait en deux temps.

1. **Des agents IA organisés en hiérarchie.** Un configurateur coordonne leur
   travail. La chercheuse ou le chercheur choisit le modèle et définit le rôle
   de chaque agent. Par exemple, un agent rédige un ensemble d'items sur un
   construit donné, puis plusieurs agents relecteurs (souvent de trois à huit)
   vérifient chacun de leur côté que les items restent dans le sujet, respectent
   les règles de rédaction et ne contiennent pas de biais éthique. Ce cycle de
   relecture se répète plusieurs fois, chaque agent tenant compte des avis des
   autres, puis un agent final rassemble les items en un bassin.
2. **Une validation psychométrique.** Le package R AI-GENIE
   (Russell-Lasalandra et al., 2026) analyse ce bassin par la psychométrie de
   réseau, retire les items redondants ou instables et garde les plus stables.
   Quand plusieurs construits sont mesurés, chaque item est d'abord attribué à
   son facteur.

La force de Genitem est de rendre la partie technique simple et compréhensible,
tout en laissant au jugement humain le rôle principal dans la conduite des
agents IA.

---

## Les outils

Chaque outil a sa vidéo de présentation d'environ une minute (sous-titrée, en
six langues sur le site). Les liens ci-dessous mènent à la version française.

### Construire et adapter

| Outil | Ce qu'il fait | Vidéo |
|---|---|---|
| [Génération d'items](https://genitem.recherche-formation.com/app/) | Des agents IA rédigent et relisent un bassin d'items, puis AI-GENIE en vérifie la structure. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/generation-items-fr.mp4"><img src="ressources/vignettes/generation-items-fr.jpg" width="220" alt="Regarder"></a> |
| [Nouveaux items](https://genitem.recherche-formation.com/new_item/) | Propose des items sur ce que les questionnaires existants ne couvrent pas encore, sans jamais reproduire ni imiter leurs items. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/nouveaux-items-fr.mp4"><img src="ressources/vignettes/nouveaux-items-fr.jpg" width="220" alt="Regarder"></a> |
| [Révision de questionnaire](https://genitem.recherche-formation.com/revision_questionnaire/) | Compare des échelles existantes : redondances, problèmes de formulation et thèmes non abordés. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/revision-fr.mp4"><img src="ressources/vignettes/revision-fr.jpg" width="220" alt="Regarder"></a> |
| [Rétrotraduction](https://genitem.recherche-formation.com/retrotraduction/) | Traduction, rétrotraduction à l'aveugle et comparaison, avec un modèle différent pour chaque rôle. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/retrotraduction-fr.mp4"><img src="ressources/vignettes/retrotraduction-fr.jpg" width="220" alt="Regarder"></a> |

### Vérifier avant la collecte

| Outil | Ce qu'il fait | Vidéo |
|---|---|---|
| [Qualité psychométrique](https://genitem.recherche-formation.com/quali_psy/) | Répète la génération d'items avec plusieurs modèles et compare la qualité de leurs résultats dans un classeur Excel. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/qualite-psychometrique-fr.mp4"><img src="ressources/vignettes/qualite-psychometrique-fr.jpg" width="220" alt="Regarder"></a> |
| [Tri d'items](https://genitem.recherche-formation.com/tri_items/) | Plusieurs modèles classent les items dans des facteurs : consensus, kappa de Fleiss et V d'Aiken par item. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/tri-items-fr.mp4"><img src="ressources/vignettes/tri-items-fr.jpg" width="220" alt="Regarder"></a> |
| [Variation de conditions](https://genitem.recherche-formation.com/variation_conditions/) | Fait passer un questionnaire à des modèles IA sous plusieurs conditions, puis compare leurs réponses. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/variation-conditions-fr.mp4"><img src="ressources/vignettes/variation-conditions-fr.jpg" width="220" alt="Regarder"></a> |
| [Test modèles](https://genitem.recherche-formation.com/test_modeles/) | Soumet la même consigne à plusieurs modèles et compare ce qu'ils produisent et le temps qu'ils y mettent. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/test-modeles-fr.mp4"><img src="ressources/vignettes/test-modeles-fr.jpg" width="220" alt="Regarder"></a> |

### Analyser les réponses écrites

| Outil | Ce qu'il fait | Vidéo |
|---|---|---|
| [Codage de réponses ouvertes](https://genitem.recherche-formation.com/codage-de-reponse-ouverte/) | Codage inductif : plusieurs IA proposent des codes, un livre de codes est rédigé, puis le corpus est codé et la fidélité mesurée. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/codage-fr.mp4"><img src="ressources/vignettes/codage-fr.jpg" width="220" alt="Regarder"></a> |
| [Textométrie](https://genitem.recherche-formation.com/textometrie/) | Classe les segments de texte selon leur vocabulaire (méthode de Reinert) et les place sur des cartes. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/textometrie-fr.mp4"><img src="ressources/vignettes/textometrie-fr.jpg" width="220" alt="Regarder"></a> |
| [Verbatims](https://genitem.recherche-formation.com/ia-humain/) | Code des verbatims avec le cadre à sept niveaux de Lee et Ha (2026) et compare le codage de l'IA à celui d'humains. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/verbatims-fr.mp4"><img src="ressources/vignettes/verbatims-fr.jpg" width="220" alt="Regarder"></a> |

L'[installation](https://genitem.recherche-formation.com/install/) (Ollama,
Python et R) est guidée pas à pas sur le site, avec sa propre
[vidéo](https://genitem.recherche-formation.com/wp-content/uploads/data/info/installation-fr.mp4).

---

## Aperçu du site

Captures d'écran du site actuel, en français. Cliquez sur une image pour l'agrandir.

<table>
<tr><td width="50%"><a href="ressources/captures/generation-items-fr.jpg"><img src="ressources/captures/generation-items-fr.jpg" alt="Génération d’items"></a><br><b>Génération d’items</b></td><td width="50%"><a href="ressources/captures/nouveaux-items-fr.jpg"><img src="ressources/captures/nouveaux-items-fr.jpg" alt="Nouveaux items"></a><br><b>Nouveaux items</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/revision-fr.jpg"><img src="ressources/captures/revision-fr.jpg" alt="Révision de questionnaire"></a><br><b>Révision de questionnaire</b></td><td width="50%"><a href="ressources/captures/retrotraduction-fr.jpg"><img src="ressources/captures/retrotraduction-fr.jpg" alt="Rétrotraduction"></a><br><b>Rétrotraduction</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/qualite-psychometrique-fr.jpg"><img src="ressources/captures/qualite-psychometrique-fr.jpg" alt="Qualité psychométrique"></a><br><b>Qualité psychométrique</b></td><td width="50%"><a href="ressources/captures/tri-items-fr.jpg"><img src="ressources/captures/tri-items-fr.jpg" alt="Tri d’items"></a><br><b>Tri d’items</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/variation-conditions-fr.jpg"><img src="ressources/captures/variation-conditions-fr.jpg" alt="Variation de conditions"></a><br><b>Variation de conditions</b></td><td width="50%"><a href="ressources/captures/test-modeles-fr.jpg"><img src="ressources/captures/test-modeles-fr.jpg" alt="Test modèles"></a><br><b>Test modèles</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/codage-fr.jpg"><img src="ressources/captures/codage-fr.jpg" alt="Codage de réponses ouvertes"></a><br><b>Codage de réponses ouvertes</b></td><td width="50%"><a href="ressources/captures/textometrie-fr.jpg"><img src="ressources/captures/textometrie-fr.jpg" alt="Textométrie"></a><br><b>Textométrie</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/verbatims-fr.jpg"><img src="ressources/captures/verbatims-fr.jpg" alt="Verbatims"></a><br><b>Verbatims</b></td><td width="50%"><a href="ressources/captures/installation-fr.jpg"><img src="ressources/captures/installation-fr.jpg" alt="Installation"></a><br><b>Installation</b></td></tr>
</table>

---

## Contenu de ce dépôt

Ce dépôt présente Genitem et archive ses versions citables sur Zenodo. Les
outils eux-mêmes s'utilisent depuis le site.

| Dossier ou fichier | Contenu |
|---|---|
| `scripts/analyse_genie.R` | Validation structurelle d'un bassin d'items avec AI-GENIE (un seul construit) |
| `scripts/analyse_genie_multi_construits.R` | Même analyse quand les items mesurent plusieurs construits |
| `ressources/` | Logo, grilles de codage, vignettes des vidéos et captures du site |
| `CITATION.cff`, `.zenodo.json` | Citation et description de l'archive Zenodo |

---

## Citation

> Jan, D., Béland, S., Vincent, C., Michelot, F., & Caron, É. (2026). *Genitem:
> A user-friendly tool for the generation and pre-validation of items with AI*
> [Computer software]. Zenodo. <https://doi.org/10.5281/zenodo.22801168>

| DOI | Renvoie à |
|---|---|
| [10.5281/zenodo.22801168](https://doi.org/10.5281/zenodo.22801168) | toutes les versions, à citer pour désigner le logiciel en général |
| [10.5281/zenodo.22801169](https://doi.org/10.5281/zenodo.22801169) | la version 0.1 |

Pour la reproductibilité, citez la version que vous avez utilisée (page Zenodo,
rubrique *Versions*).

### Travaux dont dépend ce projet

- Russell-Lasalandra, L. L., Christensen, A. P., & Golino, H. (2026).
  Generative psychometrics via AI-GENIE: Automatic item generation and
  validation with network-integrated evaluation. *Behavior Research Methods,
  58*(8), 217. <https://doi.org/10.3758/s13428-026-03082-1>

---

## Licence

Depuis le 6 novembre 2026, tout le dépôt est diffusé sous licence
[CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) : utilisation et
modification libres, sans usage commercial, en citant les auteurs. Voir
[LICENSE](LICENSE). Pour un usage commercial, contacter les auteurs.

La version 0.1 archivée sur Zenodo garde ses licences d'origine (MIT pour le
code, CC BY 4.0 pour la documentation).

---

## Écrit avec l'aide d'une IA

Ce fichier et sa version anglaise ont été rédigés avec Claude (Anthropic) à
partir des contenus du site, puis publiés sous la responsabilité des auteurs.
Les versions espagnole, allemande, portugaise et italienne sont des traductions
faites avec la même IA. En cas d'écart, le français fait foi.
Les décisions de recherche sont celles des auteurs.

---

## Financement et rattachement

Mené dans le cadre d'un projet affilié à l'**Université de Fribourg**, avec le
soutien du **Fonds du centenaire** (projet FC-26-989), et en collaboration avec
l'**Université de Montréal**.

## Contact

<info@genitem.education>
