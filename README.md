# Genitem

**AI-assisted item generation and analysis, running entirely on your own machine.**

[![Documentation: CC BY 4.0](https://img.shields.io/badge/docs-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![Code: MIT](https://img.shields.io/badge/code-MIT-green.svg)](LICENSE)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.22801169-blue.svg)](https://doi.org/10.5281/zenodo.22801169)

Live site: <https://genitem.recherche-formation.com> · [Français](README.fr.md)

---

## What this is

Genitem is a set of browser-based tools for researchers who build and evaluate
measurement instruments. It covers the early, expensive part of scale
development — drafting a pool of items, checking their structure, coding
qualitative feedback, translating an instrument — using large language models
that run locally.

Nothing is sent anywhere. The pages do not call any model themselves: each one
builds a Python script that you download and run on your own computer, against
a local [Ollama](https://ollama.com) server. No API key, no account, no
transcript on someone else's disk. This matters for student data, pilot
responses, and anything covered by an ethics approval that forbids sending
material to third-party services.

Every page is bilingual, French and English.

---

## The tools

### 1. Item generation — `AI-agent.html`

A configurator for a multi-agent pipeline, then the two ways out of it.

**Step 1 — configure the agents.** One *generator* drafts the pool: you give it
a model, the construct, how many items, whether they are dichotomous or
agreement-scale, and its instructions. Several *reviewers* then criticise the
draft in parallel — content, wording, coverage of the construct — over as many
rounds as you set; reviewer cards can be added or removed. A *final* agent
produces the revised set.

**Step 2 — export `agents.txt`.** The whole configuration becomes a commented
Python script. You can read it before running it, and keep it as the record of
what produced a given pool.

**Step 3 — generate.** Two PowerShell windows: paste
[`1-lancer-ollama.txt`](powershell/1-lancer-ollama.txt) into the first, which
starts Ollama and stays open, and
[`2-generer-items.txt`](powershell/2-generer-items.txt) into the second, which
runs the script. It writes the items, the full exchange between
agents, and `AI-GENIE.txt` — the item pool in the form the R pipeline expects.

**The fork.** What happens next depends on how many constructs you are
measuring, and the page asks you outright:

```
                    AI-GENIE.txt
                         │
        ┌────────────────┴────────────────┐
        │                                 │
  Validate items                   Assign factors
  one construct                    several constructs
        │                                 │
        │                    load AI-GENIE.txt
        │                    set the number of factors
        │                    tick each item's factor
        │                    export for AI-GENIE
        │                                 │
        └────────────────┬────────────────┘
                         │
                   Step 4 — analyse with AI-GENIE
                      scripts/analyse_genie.R
```

With a single construct there is nothing to sort: the pool goes straight to the
structural validation. With several, the items must first be attributed to
their factor, one by one, by you. The page presents them in a table with a
column per factor; nothing is inferred, because a wrongly attributed item
corrupts the dimensional structure the analysis is meant to estimate.

**Step 4 — analyse.** A third command,
[`3-analyser-ai-genie.txt`](powershell/3-analyser-ai-genie.txt), runs the R
pipeline.

### 2. Model comparison — `test_modeles.html`

The same brief given to several installed models, side by side, with what each
produced and how long it took. Useful before committing to a model: a 1B model
and an 8B model differ far more than their size suggests, and the difference is
easier to see than to predict.

### 3. Model management — `aide.html`

Adding and removing Ollama models, stored per user account. Includes fallback
installation methods and an Ollama diagnostic for when something refuses to
start. Requires a site account.

### 4. Verbatim coding — `ia-humain.html`

Classifies written feedback against the seven-level framework of Lee and Ha
(2026), Table 3, reproduced unmodified and in English — the language of the
instrument.

| Level | Type | Description |
|---|---|---|
| 0 | Irrelevant Feedback | Unrelated to the response, or without meaningful content |
| 1 | General Impression | Vague or superficial impressions of the whole response |
| 2 | Correctness-Focused | Only whether the answer is right, or how it compares to the model answer |
| 3 | Rubric-Based | Judged against the rubric: overall structure and validity |
| 4 | Error Identification | Points out a specific error or a missing element |
| 5 | Commentary | Identifies a strength or weakness and explains it |
| 6 | Suggestion with Alternative | Offers a concrete alternative or an additional perspective |

Several models code each verbatim independently. Where they agree, the verbatim
is settled. Where they disagree, each model receives the others' codings and
reviews its own, up to a cap you set. Past the cap, the majority level wins.
A final model writes the justification for the retained level; it does not
arbitrate, since counting identical votes is arithmetic and does not belong to
a language model.

Input: a spreadsheet with the identifier in column A and the verbatim in
column B, the first row being a header. Output: a workbook with each model's
coding at each stage, the retained level, agreement, and the number of rounds.

### 5. Back-translation — `retrotraduction.html`

Translation, then one or two blind back-translations by different models, then
comparison against the source. The workbook opens on the translation to keep,
with its provenance and its equivalence verdict; the detail of both passes sits
on the second sheet.

Blind back-translation is the standard for adapting a measurement instrument.
A direct translation, however good, is not validated by the fact that it reads
well.

### 6. Structural validation — `scripts/analyse_genie.R`

Runs the [AIGENIE](https://github.com/laralee/AIGENIE) R package on a generated
item pool: embeddings, Exploratory Graph Analysis, Unique Variable Analysis for
redundancy, and bootstrap EGA for stability. Exports the results to Excel with
the plots.

`analyse_genie_multi_construits.R` does the same across several constructs.

---

## Requirements

- **Windows**, with PowerShell (the launcher scripts are written for it)
- **[Ollama](https://ollama.com)** and at least one installed model
- **Python 3** with `ollama` and `openpyxl`
- **R** with `AIGENIE`, `ggplot2` and `writexl`, for the structural validation only

A portable bundle — Ollama, Python and R on a single removable drive, with no
installation on the host machine — is available from the site.

See [Which command runs what](#which-command-runs-what) below for the three
PowerShell commands and how they find that drive.

### Choosing a model

Small models are tempting and disappointing. A 0.8B model asked for thirty
distinct items will circle a handful of phrasings, and Unique Variable Analysis
will then delete most of them — leaving too few for bootstrap EGA to run at
all. `mistral:7b`, `qwen3:8b` or `gemma4:e4b` are reasonable starting points.
Reasoning models work but are slow, and reasoning buys little on coding and
translation tasks.

---

## Project structure

```
pages/          the six tools — one self-contained HTML file each
powershell/     the three commands to paste into a PowerShell window
scripts/        the R analysis (AI-GENIE pipeline)
ressources/     the coding grid and related source material
wordpress/      the thin layer that embeds the pages on the live site
```

No build step, no bundler, no dependencies to install. Open any file in
`pages/` in a browser and it works, on a server or from a USB stick.

### Which file does what

Each tool is one page on the live site, one HTML file here, and — for the three
tools that run models — one exported Python script and one workbook.

| Page on the site | File in this repository | Exports | Produces |
|---|---|---|---|
| [`/app/`](https://genitem.recherche-formation.com/app/) — AI-agent | `pages/AI-agent.html` | `agents.txt` | the item pool, the agents' exchange, `AI-GENIE.txt` |
| [`/test_modeles/`](https://genitem.recherche-formation.com/test_modeles/) — Model testing | `pages/test_modeles.html` | `test_modeles.txt` | a comparison, read back in the page |
| [`/ia-humain/`](https://genitem.recherche-formation.com/ia-humain/) — Verbatims | `pages/ia-humain.html` | `classement.txt` | `classement_<date>.xlsx` |
| [`/retrotraduction/`](https://genitem.recherche-formation.com/retrotraduction/) — Back-translation | `pages/retrotraduction.html` | `retrotraduction.txt` | `retrotraduction_<date>.xlsx` |
| [`/aide/`](https://genitem.recherche-formation.com/aide/) — Help *(account)* | `pages/aide.html` | — | manages the model list |
| [`/extra/`](https://genitem.recherche-formation.com/extra/) — Extra | `pages/bonus.html` | — | landing page for the three side tools |

The exported script is a `.txt` rather than a `.py` on purpose: it is written
to be read before it is run. Rename it if you prefer.

### Which command runs what

Three commands, **pasted into a PowerShell window** rather than run as files.
Windows blocks downloaded `.ps1` scripts by default, and pasting sidesteps that
without asking anyone to lower a security setting.

| Command | Window | What it runs |
|---|---|---|
| [`1-lancer-ollama.txt`](powershell/1-lancer-ollama.txt) | first, stays open | the Ollama server |
| [`2-generer-items.txt`](powershell/2-generer-items.txt) | second | `agents.txt`, exported from `/app/` |
| [`3-analyser-ai-genie.txt`](powershell/3-analyser-ai-genie.txt) | second | `scripts/analyse_genie.R` |

The first is needed for every tool: nothing runs without Ollama. The scripts
exported by the verbatim and back-translation pages are launched the same way
as the second command, with the script name changed.

Each command begins by locating the installation **by its contents rather than
its letter**: it looks for a folder named `ollama` containing `ollama.exe`,
first at the root of each drive, then deeper, then in the user profile — where
it creates a short virtual drive with `subst`, because Windows still chokes on
long paths. A removable drive that comes up as `E:` on one machine and `H:` on
the next needs no editing. They are commented step by step; reading one is the
fastest way to see how the pieces fit.

One known annoyance: the deep search walks network drives too, and prints red
errors when one is unreachable. Nothing is broken when that happens — fixing it
is listed as a good first contribution.

### How a run fits together

```
  /app/  ──exports──▶  agents.txt
                            │
  paste 1-lancer-ollama.txt ──▶  Ollama running, window kept open
                            │
  paste 2-generer-items.txt ──▶  python agents.txt
                            │
                            ├──▶  items + exchange
                            └──▶  AI-GENIE.txt
                                        │
  paste 3-analyser-ai-genie.txt ──▶  Rscript analyse_genie.R
                                        │
                                        └──▶  results + plots (.xlsx)
```

The verbatim and back-translation tools follow the same three beats — export,
start Ollama, run the script — and read their own workbook back for display.

## Understanding and changing it

- **[SITEMAP.md](SITEMAP.md)** — the live site's menu and navigation, and the
  order a researcher usually goes through the tools.
- **[ARCHITECTURE.md](ARCHITECTURE.md)** — how a page is built, why it writes a
  Python script rather than calling a model, the shared conventions, and the
  known weak points.
- **[CONTRIBUTING.md](CONTRIBUTING.md)** — how to propose an improvement, what
  makes a good first contribution, and the two or three changes that would look
  like improvements but would break the project.

Short version: no framework, no build step, one file per tool, and the page
never talks to a model itself.

---

## Known limits

The seven-level framework is reproduced in English only. The two grids we had
translated automatically into other languages were withdrawn: none had been
validated by back-translation, which is precisely what tool 5 exists to do.

The single coding rule — code the highest level whose definition is fully met,
and where you hesitate, keep the highest of those you are considering — is
ours, not Lee and Ha's. Table 3 gives the levels and nothing else. Anyone
reporting results obtained here should say so.

Agreement between models is not agreement between coders. Two instances of the
same model agree almost always, and that agreement measures nothing.

---

## Citation

> Jan, D., Beland, S., Vincent, C., & Michelot, F. (2026). *Genitem: A
> user-friendly tool for the generation and pre-validation of items with AI*
> (Version 0.1) [Computer software]. Zenodo.
> <https://doi.org/10.5281/zenodo.22801169>

Two DOIs exist, as Zenodo issues both:

| DOI | Resolves to |
|---|---|
| [10.5281/zenodo.22801168](https://doi.org/10.5281/zenodo.22801168) | every version — cite this to mean the software in general |
| [10.5281/zenodo.22801169](https://doi.org/10.5281/zenodo.22801169) | version 0.1 — cite this to mean the exact code you used |

For reproducibility, cite the version you ran. A citation file in RDF is also
available from the site, and `CITATION.cff` in this repository feeds GitHub's
*Cite this repository* button.

### Works this depends on

- Russell-Lasalandra, L. L., Christensen, A. P., & Golino, H. (2026).
  Generative psychometrics via AI-GENIE: Automatic item generation and
  validation with network-integrated evaluation. *Behavior Research Methods*.
  <https://doi.org/10.3758/s13428-026-03082-1>
- Lee, & Ha (2026). *Sage Open*. <https://doi.org/10.1177/21582440261418083>

---

## Licence

The code — HTML, JavaScript, Python, R and PowerShell — is released under the
[MIT licence](LICENSE). The documentation, the coding grid and the other
written resources are released under
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), see
[LICENSE-DOCS](LICENSE-DOCS).

The split is deliberate. Creative Commons licences are not designed for
software: they grant no patent rights and carry no warranty disclaimer suited
to code. Attribution is required either way.

---

## Written with AI

Two disclosures, made because the project is about AI-assisted work and it
would be odd to be coy about it.

**The English version of the site** is a translation produced with Claude
(Opus 5, Anthropic) from the French original. Where the two differ, the French
is the reference.

**The documentation in this repository** — this file, `ARCHITECTURE.md`,
`CONTRIBUTING.md` and `SITEMAP.md` — was drafted with Claude from the project's
own source files, then published under the authors' responsibility. The code
itself, the coding grid and the research decisions are the authors'.

Errors of fact in the documentation are as possible here as anywhere else, and
perhaps a little more so. Report them like any other bug.

---

## Funding and affiliation

Carried out within a project affiliated with the **University of Fribourg**,
with support from the **Fonds du centenaire** (project FC-26-989), and in
collaboration with the **Université de Montréal**.

## Contact

<info@genitem.education>
