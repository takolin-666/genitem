# Architecture

How the six tools are built, and why. Read this before changing a page.

---

## The one idea

**A page never talks to a model. It writes a script that does.**

Every tool follows the same shape:

```
the researcher fills in a form
        ↓
the page builds a Python script as a string
        ↓
the script is downloaded as a .txt
        ↓
the researcher runs it in PowerShell, against a local Ollama
        ↓
the script writes an .xlsx next to itself
        ↓
the researcher drops that .xlsx back on the page to read the results
```

This is not a limitation to be engineered away. It is the point. A browser
calling Ollama would mean the material passes through the page; a script run
by hand means it never leaves the machine, and the researcher can read exactly
what will be sent before sending it. Any contribution that makes the page call
a model directly defeats the purpose of the project.

It has a second benefit: the generated script is a plain, commented Python
file. A researcher who distrusts the interface can read it, modify it, and run
it alone. Several already do.

---

## Anatomy of a page

Each tool is **one self-contained HTML file**. No build step, no bundler, no
dependencies to install. Open it in a browser and it works. Edit it in a text
editor and reload.

The internal order is always the same:

| Part | What sits there |
|---|---|
| `<style>` | CSS variables in `:root`, then the shared component classes |
| `<body>` | Numbered sections, each a `<section class="card">` |
| `<script>` | State, config, script generation, i18n, event wiring |

The numbered sections are the workflow, in order. In `ia-humain.html`:
start Ollama, load the file, read the grid, choose the models, prepare the
analysis, read the results. A researcher who follows them from top to bottom
cannot get lost, and that ordering is worth protecting.

### Shared CSS vocabulary

The same variables and classes appear in all six files:

```css
--accent   the page's own colour   --ok --warn --err
.card      a numbered section      .hint    explanatory grey text
.field     a labelled control      .chip    a coloured level badge
.row       a flex line of fields   .banner  a dismissible notice
```

Each tool has its own accent: blue `#2f5496` for verbatim coding, green
`#0f6e56` for model testing, orange `#b35309` for back-translation. The colour
carries meaning — the cards on the landing page take the colour of their
destination — so keep it when adding a page.

### Generating the Python

The script is assembled in a JavaScript template literal, with `pyStr()`
escaping anything that comes from the user. Two traps:

- The template literal is delimited by backticks, so **no backtick may appear
  in the Python**, and `${` must be escaped unless you mean interpolation.
- The Python is written **without accented characters in comments and strings**,
  because it lands on Windows machines whose console encoding cannot be relied
  on. Non-ASCII in the generated script has broken runs before.

The header of every generated script carries the settings that produced it, so
a researcher opening an old script a year later knows what it did.

### Configuration and results

Settings live in `localStorage` and are restored on load, so closing the tab
does not lose an afternoon of setup. Results are not stored: they live in the
workbook, which is the durable artefact.

The workbooks are readable back by the page that wrote them, which is how an
interrupted run resumes. Scripts also save every ten items and on `Ctrl+C`,
and move any previous workbook into a dated `archive/` folder before starting.

### Bilingualism — two mechanisms, and that is one too many

Every page is French and English, with a toggle at the top right. But the six
files do it in two different ways:

| Mechanism | Pages | How |
|---|---|---|
| `data-i18n` attributes | `AI-agent`, `test_modeles`, `aide` | each element carries a key, looked up in `TRADUCTIONS` |
| Text-node walking | `ia-humain`, `retrotraduction`, `bonus` | a `TreeWalker` matches whole French strings against `TRAD_EN` |

The second is fragile: the key is the trimmed text content, so an inline
`<strong>` splits a sentence into fragments that no longer match, and a comma
changed in the HTML silently breaks the translation. The first is sturdier.

**Unifying them on `data-i18n` is the single most useful contribution
available.** It is tedious rather than difficult, and it should be done one
page at a time, never all at once.

### Model lists

Pages read the researcher's installed models from the site, through one call
that returns session state, a fresh token and the list together. Where that
call fails — opened as a local file, no account, site down — the page falls
back to a text field. **Every page must keep working without the site.** That
is not a courtesy to offline users; it is what makes the files reusable by
anyone who copies them.

### Version stamp

Bottom right of each page, `v.DD.MM.YYYY-HH:MM:SS`, Swiss time of the last
edit. Each page carries its own; they are not synchronised.

It exists because these files are served from a cache that holds old versions
for hours. Comparing the stamp on screen against the one in the file is the
only reliable way to know what is actually running. **Update it in the same
commit as any change to a page** — a stale stamp costs an hour of confusion,
as it has done.

---

## Where the languages meet

```
HTML page  ──writes──▶  Python script  ──calls──▶  Ollama (local)
    ▲                         │
    └────reads────  .xlsx  ◀──┘

R script  ──reads──▶  AI-GENIE.txt  (written by the item-generation script)
```

The R side is separate and stands alone: it takes an item pool, whatever
produced it, and runs the psychometric reduction. It has no knowledge of the
pages.

PowerShell sits underneath all of it, finding a portable drive by its contents
rather than its letter — the letter changes between machines, the `ollama\`
folder does not.

---

## Conventions

- **Comments in French, without accents.** The accents are omitted in the
  generated Python for encoding reasons and kept consistent elsewhere.
- **Comments explain why, not what.** `// incremente i` is noise;
  `// absolute et non fixed : la page est affichee dans un cadre` is the
  reason someone will need in six months.
- **French identifiers in newer code, English in older.** Both exist. Match the
  file you are editing rather than converting it.
- **No framework, no build step.** A researcher must be able to open the file
  and read it. That constraint has held for six pages and is not negotiable.

---

## Known weaknesses

Honest ones, all of them open to contribution:

- The two i18n mechanisms, above.
- `ia-humain.html` is 120 kB in one file. It has outgrown the format.
- The drive-search PowerShell walks network drives and prints alarming red
  errors when one is unreachable. Filtering to fixed and removable drives would
  fix both the noise and the delay.
- There is no automated test of any kind. The generated Python is checked by
  reading it.
- Error handling in the generated scripts is uneven: some failures are printed,
  others are stored in a field nobody reads.
