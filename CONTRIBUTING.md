# Contributing

Genitem is a research tool built by a small team. Contributions are welcome,
and the bar for a useful one is lower than you might expect: a clearer
explanation, a translation corrected, a confusing step reworded — these matter
as much here as code.

Read [ARCHITECTURE.md](ARCHITECTURE.md) first. It is short, and it explains
constraints that are not obvious from the files.

---

## Before you write code

**Open an issue.** Not as a formality — the project has a deliberate shape, and
some improvements that look obvious run against it. Calling Ollama from the
page would remove a whole download-and-run step and destroy the guarantee the
project exists to give. Adding a build step would make the files unreadable to
the researchers who currently read them.

Saying what you intend to do costs you a paragraph and may save you an evening.

## Good first contributions

Ordered by usefulness, not by difficulty:

1. **Unify the two i18n mechanisms** on `data-i18n`, one page at a time.
   See ARCHITECTURE.md. Tedious, mechanical, and it removes a class of silent
   bugs that has already cost several hours.
2. **English proofreading.** The English is a translation from French and shows
   it in places.
3. **Filter the PowerShell drive search** to fixed and removable drives. It
   currently walks unreachable network drives, printing red errors that look
   like failures and are not.
4. **Split `ia-humain.html`.** 120 kB in a single file, without breaking the
   open-it-and-it-works property. Harder than it sounds; discuss first.
5. **Make the generated scripts report their errors.** Some are printed, some
   are stored in a field nobody reads. Diagnosing a failing run is harder than
   it should be.

## Bugs

Say what you did, what happened, and what you expected. For anything involving
a run, include:

- the version stamp at the bottom right of the page
- the console output, complete — the useful line is often not the last one
- the model names and `ollama --version`
- the workbook, with the verbatims removed if they are not yours to share

**Never attach real participant data.** Two invented rows reproduce most
problems.

## Pull requests

- One subject per pull request.
- **Update the version stamp** of any page you touch: `v.DD.MM.YYYY-HH:MM:SS`,
  Swiss time. Forgetting it means the next person cannot tell what is deployed.
- Keep the comment style of the file you are in — French, unaccented,
  explaining why rather than what.
- Say what you tested, and on which models. "Tested on `mistral:7b`, 30
  verbatims, French" tells a reviewer more than a paragraph of prose.
- No new dependency without discussing it. The no-build-step, no-framework
  constraint is what keeps these files readable.

### Testing, such as it is

There is no automated test suite. Until there is:

- Check that the page still loads with the browser console open and clean.
- Export the generated script and read it. Run it on two or three rows.
- Toggle the language and check that nothing stayed French, or English.
- Reload the page: your settings should come back.
- Open the file directly from disk, with no web server. It must still work.

Contributions that add a genuine test harness are welcome, provided they do
not require a build step to run the pages themselves.

## Translations

Adding a language to the interface is straightforward: extend the translation
table. Adding a language to the **coding grid** is not, and should not be done
by translating it.

The grid reproduces a published instrument. A direct translation of a
measurement instrument is not a validated instrument, whatever its quality.
Two automatically translated grids were withdrawn from this project for exactly
that reason. If you want the grid in another language, produce it through the
back-translation tool, document the procedure, and say in the pull request who
performed each step.

## Scope

In scope: the six HTML tools, the R analysis scripts, the PowerShell launchers,
the documentation.

Out of scope: the WordPress site that embeds the tools. It is a thin layer —
it displays the pages and remembers which models each user installed — and it
is not what this repository is for.

## Licence

Contributions are accepted under the licences of this repository: CC BY 4.0 for
documentation and resources, MIT for code. By opening a pull request you agree
to that.

## Contact

<info@genitem.education> — an issue is usually better, since the answer then
helps the next person.
