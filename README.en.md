# Genitem

**Generate, adapt and check questionnaire items with AI, entirely on your own computer.**

[![Licence: CC BY-NC 4.0](https://img.shields.io/badge/licence-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.22801168-blue.svg)](https://doi.org/10.5281/zenodo.22801168)

Website: <https://genitem.recherche-formation.com>

[Français](README.md) · **English**

---

## What it is

Genitem (Jan et al., 2026) is a free, browser-based suite for researchers who
build, adapt and check questionnaires, surveys and measurement scales.
Generative AI does the repetitive work. Human expertise stays in charge of
every decision.

All language models run **locally**, on the researcher's own computer, through
[Ollama](https://ollama.com) (Windows, macOS or Linux). No item, response or
personal data is sent to an external service. Genitem is therefore suitable for
studies with strict ethical or data-protection requirements.

The interface is available in six languages: English, French, Spanish, German,
Portuguese and Italian.

---

## The core tool: item generation

Item generation works in two stages.

1. **AI agents organised in a hierarchy.** A configurator coordinates their
   work. The researcher chooses the model and defines the role of each agent.
   For example, a generator agent drafts a set of items on a given construct,
   then several reviewer agents (typically three to eight) independently check
   that the items stay on topic, follow item-writing rules and are free from
   ethical bias. This review cycle is repeated several times, each agent taking
   the others' feedback into account, before a final agent compiles the items
   into a pool.
2. **Psychometric validation.** The AI-GENIE R package (Russell-Lasalandra et
   al., 2026) analyses this pool with network psychometrics, removes redundant
   or unstable items and retains the most stable ones. When several constructs
   are measured, each item is first assigned to its factor.

Genitem's strength lies in making the technical side simple and easy to
understand, while giving human judgement the leading role in directing the AI
agents.

---

## The tools

Each tool has an introductory video of about one minute (subtitled, in six
languages on the website). The links below lead to the English version.

### Build and adapt

| Tool | What it does | Video |
|---|---|---|
| [Item generation](https://genitem.recherche-formation.com/app/) | AI agents draft and review a pool of items, then AI-GENIE checks its structure. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/generation-items-en.mp4) |
| [New items](https://genitem.recherche-formation.com/new_item/) | Suggests items on what existing questionnaires do not yet cover, without ever reproducing or imitating their items. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/nouveaux-items-en.mp4) |
| [Questionnaire review](https://genitem.recherche-formation.com/revision_questionnaire/) | Compares existing scales: redundancies, wording problems and themes not covered. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/revision-en.mp4) |
| [Back-translation](https://genitem.recherche-formation.com/retrotraduction/) | Translation, blind back-translation and comparison, with a different model for each role. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/retrotraduction-en.mp4) |

### Check before data collection

| Tool | What it does | Video |
|---|---|---|
| [Psychometric quality](https://genitem.recherche-formation.com/quali_psy/) | Repeats item generation with several models and compares the quality of their results in an Excel workbook. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/qualite-psychometrique-en.mp4) |
| [Item sorting](https://genitem.recherche-formation.com/tri_items/) | Several models sort the items into factors: consensus, Fleiss' kappa and Aiken's V for each item. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/tri-items-en.mp4) |
| [Condition variation](https://genitem.recherche-formation.com/variation_conditions/) | Gives a questionnaire to AI models under several conditions, then compares their answers. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/variation-conditions-en.mp4) |
| [Model testing](https://genitem.recherche-formation.com/test_modeles/) | Sends the same prompt to several models and compares what they produce and how long they take. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/test-modeles-en.mp4) |

### Analyse text responses

| Tool | What it does | Video |
|---|---|---|
| [Open-ended response coding](https://genitem.recherche-formation.com/codage-de-reponse-ouverte/) | Inductive coding: several AI models suggest codes, a codebook is written, then the corpus is coded and reliability measured. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/codage-en.mp4) |
| [Textometrics](https://genitem.recherche-formation.com/textometrie/) | Classifies text segments by shared vocabulary (Reinert method) and places them on maps. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/textometrie-en.mp4) |
| [Verbatims](https://genitem.recherche-formation.com/ia-humain/) | Codes verbatims with the seven-level framework of Lee and Ha (2026) and compares AI coding with human coding. | [Watch](https://genitem.recherche-formation.com/wp-content/uploads/data/info/verbatims-en.mp4) |

[Installation](https://genitem.recherche-formation.com/install/) (Ollama,
Python and R) is guided step by step on the website, with its own
[video](https://genitem.recherche-formation.com/wp-content/uploads/data/info/installation-en.mp4).

---

## What this repository contains

This repository presents Genitem and archives its citable versions on Zenodo.
The tools themselves are used from the website.

| Folder or file | Contents |
|---|---|
| `scripts/analyse_genie.R` | Structural validation of an item pool with AI-GENIE (single construct) |
| `scripts/analyse_genie_multi_construits.R` | The same analysis when items measure several constructs |
| `ressources/` | Logo and coding grids |
| `CITATION.cff`, `.zenodo.json` | Citation and description of the Zenodo archive |

---

## Citation

> Jan, D., Béland, S., Vincent, C., Michelot, F., & Caron, É. (2026). *Genitem:
> A user-friendly tool for the generation and pre-validation of items with AI*
> [Computer software]. Zenodo. <https://doi.org/10.5281/zenodo.22801168>

| DOI | Resolves to |
|---|---|
| [10.5281/zenodo.22801168](https://doi.org/10.5281/zenodo.22801168) | all versions, to cite the software in general |
| [10.5281/zenodo.22801169](https://doi.org/10.5281/zenodo.22801169) | version 0.1 |

For reproducibility, cite the version you used (Zenodo page, *Versions*
section).

### Work this project builds on

- Russell-Lasalandra, L. L., Christensen, A. P., & Golino, H. (2026).
  Generative psychometrics via AI-GENIE: Automatic item generation and
  validation with network-integrated evaluation. *Behavior Research Methods,
  58*(8), 217. <https://doi.org/10.3758/s13428-026-03082-1>
- Lee, & Ha (2026). *Sage Open*. <https://doi.org/10.1177/21582440261418083>

---

## Licence

Since 6 November 2026, the whole repository is released under the
[CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/) licence: free to
use and adapt, for non-commercial purposes, with attribution. See
[LICENSE](LICENSE). For commercial use, please contact the authors.

Version 0.1, as archived on Zenodo, keeps its original licences (MIT for the
code, CC BY 4.0 for the documentation).

---

## Written with the help of AI

This file and its French version were drafted with Claude (Anthropic) from the
content of the website, then published under the authors' responsibility.
Research decisions are the authors' own.

---

## Funding and affiliation

Carried out within a project affiliated with the **University of Fribourg**,
supported by the **Centenary Fund** (project FC-26-989), in collaboration with
the **Université de Montréal**.

## Contact

<info@genitem.education>
