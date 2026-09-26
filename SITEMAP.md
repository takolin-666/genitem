# Site map

What sits where on <https://genitem.recherche-formation.com>, and which file in
this repository produces it.

---

## Pages

| Page | URL | File | Account |
|---|---|---|---|
| Home | `/` | — | no |
| AI-agent | `/app/` | `pages/AI-agent.html` | no |
| Extra | `/extra/` | `pages/bonus.html` | no |
| — Model testing | `/test_modeles/` | `pages/test_modeles.html` | no |
| — Verbatims | `/ia-humain/` | `pages/ia-humain.html` | no |
| — Back-translation | `/retrotraduction/` | `pages/retrotraduction.html` | no |
| Forums | `/forums/` | — | to post |
| Help | `/aide/` | `pages/aide.html` | **yes** |
| Contact | `/contact/` | — | no |
| Sign in | `/connexion/` | — | — |

*Extra* is a menu heading and a page at once: it holds the three side tools,
each card carrying the colour of its destination.

Only `/aide/` requires an account, because it writes to it — it is where a
researcher's list of installed models is stored. Everything else works signed
out; an account only means the model menus fill themselves in.

---

## Navigation

```
Home
│
├── AI-agent ......... generate an item pool, then assign factors
│
├── Extra ............ the three side tools
│   ├── Model testing
│   ├── Verbatims
│   └── Back-translation
│
├── Forums ........... questions and shared experience
├── Help ............. add and remove models  [account]
├── Contact
└── Sign in .......... sign in, request an account
```

The menu is a single Divi block, held in the library and shown on every page.
Each tool page is a WordPress page containing one Code module, which embeds the
matching HTML file in a frame.

Two consequences worth knowing before editing a page:

- Links from a tool page to another page of the site need `target="_top"`.
  Without it the destination loads inside the frame, and the menu appears
  twice.
- The embedding blocks append a cache-busting parameter to the file URL.
  Without it, a newly uploaded version stays invisible for hours.

---

## What a researcher actually does

The pages are not a sequence, but they do have a usual order.

```
1.  Sign in                     so the model menus fill themselves in
        ↓
2.  Help          /aide/        install a model or two
        ↓
3.  Model testing /test_modeles/ see what they are worth before committing
        ↓
4.  AI-agent      /app/         generate an item pool
        ↓
        ├──▶  scripts/analyse_genie.R      reduce and validate the pool
        │
        └──▶  Back-translation             adapt it to another language
                /retrotraduction/

    Verbatims     /ia-humain/   code written feedback — a separate path,
                                independent of the item pool
```

Steps 1 to 3 are done once. Step 4 is the work.

---

## Files served outside WordPress

The tools are static files uploaded to `/wp-content/uploads/code/`, not
WordPress pages. They are served as ordinary files and would run just as well
from any other server, or from a USB stick.

Also served that way, from `/wp-content/uploads/data/`:

- `guide.pdf` — the installation and use guide
- `install.zip` — the portable bundle: Ollama, Python and R on one drive
- `genitem.rdf` — the citation, for reference managers

---

## Not in this repository

The WordPress layer itself: the theme, the forum, the Divi page settings. Two
small plugins are included under `wordpress/` for completeness — one keeps each
user's model list and serves it to the pages, the other tidies the sign-in
screens — but the site is a display case, not the project. See
[CONTRIBUTING.md](CONTRIBUTING.md) on scope.
