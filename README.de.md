# Genitem

**Fragebogen-Items mit KI erstellen, anpassen und prüfen, vollständig auf dem eigenen Computer.**

[![Lizenz: CC BY-NC 4.0](https://img.shields.io/badge/Lizenz-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.22801168-blue.svg)](https://doi.org/10.5281/zenodo.22801168)

Website: <https://genitem.recherche-formation.com>

[Français](README.md) · [English](README.en.md) · [Español](README.es.md) · **Deutsch** · [Português](README.pt.md) · [Italiano](README.it.md)

> **Mit KI übersetzt.** Dieser Text wurde mit Claude (Anthropic) aus dem
> französischen Original übersetzt. Bei Abweichungen ist die französische
> Fassung maßgeblich.

## Einführungsvideo

<a href="https://genitem.recherche-formation.com/wp-content/uploads/data/genitem-de.mp4"><img src="ressources/vignettes/genitem-de.jpg" width="480" alt="Die allgemeine Vorstellung von Genitem ansehen (2 Minuten)"></a>

[Die allgemeine Vorstellung von Genitem ansehen (2 Minuten)](https://genitem.recherche-formation.com/wp-content/uploads/data/genitem-de.mp4)

---

## Worum es geht

Genitem (Jan et al., 2026) ist eine Sammlung kostenloser, im Browser nutzbarer
Werkzeuge für Forschende, die Fragebögen, Umfragen und Messskalen entwickeln,
anpassen und prüfen. Generative KI übernimmt die sich wiederholende Arbeit. Die
menschliche Expertise behält bei jeder Entscheidung die Kontrolle.

Alle Sprachmodelle laufen **lokal** auf dem Computer der forschenden Person,
mithilfe von [Ollama](https://ollama.com) (Windows, macOS oder Linux). Weder
Items noch Antworten noch personenbezogene Daten werden an einen externen
Dienst gesendet. Genitem eignet sich daher für Studien mit strengen ethischen
oder datenschutzrechtlichen Anforderungen.

Die Oberfläche ist in sechs Sprachen verfügbar: Französisch, Englisch,
Spanisch, Deutsch, Portugiesisch und Italienisch.

---

## Das zentrale Werkzeug: die Itemgenerierung

Die Itemgenerierung erfolgt in zwei Schritten.

1. **Hierarchisch organisierte KI-Agenten.** Ein Konfigurator koordiniert ihre
   Arbeit. Die forschende Person wählt das Modell und legt die Rolle jedes
   Agenten fest. Beispielsweise entwirft ein Agent eine Reihe von Items zu
   einem bestimmten Konstrukt, danach prüfen mehrere Gutachter-Agenten
   (meist drei bis acht) unabhängig voneinander, ob die Items beim Thema
   bleiben, die Formulierungsregeln einhalten und frei von ethischen
   Verzerrungen sind. Dieser Prüfzyklus wird mehrmals wiederholt, wobei jeder
   Agent die Rückmeldungen der anderen berücksichtigt, bevor ein abschließender
   Agent die Items zu einem Itempool zusammenführt.
2. **Eine psychometrische Validierung.** Das R-Paket AI-GENIE
   (Russell-Lasalandra et al., 2026) analysiert diesen Pool mit
   Netzwerkpsychometrie, entfernt redundante oder instabile Items und behält
   die stabilsten. Werden mehrere Konstrukte gemessen, wird jedes Item zuerst
   seinem Faktor zugeordnet.

Die Stärke von Genitem liegt darin, den technischen Teil einfach und
verständlich zu machen und dabei dem menschlichen Urteil die führende Rolle bei
der Steuerung der KI-Agenten zu überlassen.

---

## Die Werkzeuge

Zu jedem Werkzeug gibt es ein Einführungsvideo von etwa einer Minute (mit
Untertiteln, auf der Website in sechs Sprachen). Die folgenden Links führen zur
deutschen Fassung.

### Erstellen und anpassen

| Werkzeug | Funktion | Video |
|---|---|---|
| [Itemgenerierung](https://genitem.recherche-formation.com/app/) | KI-Agenten entwerfen und prüfen einen Itempool, danach prüft AI-GENIE dessen Struktur. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/generation-items-de.mp4"><img src="ressources/vignettes/generation-items-de.jpg" width="220" alt="Ansehen"></a> |
| [Neue Items](https://genitem.recherche-formation.com/new_item/) | Schlägt Items zu dem vor, was bestehende Fragebögen noch nicht abdecken, ohne deren Items je zu übernehmen oder nachzuahmen. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/nouveaux-items-de.mp4"><img src="ressources/vignettes/nouveaux-items-de.jpg" width="220" alt="Ansehen"></a> |
| [Fragebogenüberarbeitung](https://genitem.recherche-formation.com/revision_questionnaire/) | Vergleicht bestehende Skalen: Redundanzen, Formulierungsprobleme und nicht abgedeckte Themen. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/revision-de.mp4"><img src="ressources/vignettes/revision-de.jpg" width="220" alt="Ansehen"></a> |
| [Rückübersetzung](https://genitem.recherche-formation.com/retrotraduction/) | Übersetzung, blinde Rückübersetzung und Vergleich, mit einem anderen Modell für jede Rolle. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/retrotraduction-de.mp4"><img src="ressources/vignettes/retrotraduction-de.jpg" width="220" alt="Ansehen"></a> |

### Vor der Erhebung prüfen

| Werkzeug | Funktion | Video |
|---|---|---|
| [Psychometrische Qualität](https://genitem.recherche-formation.com/quali_psy/) | Wiederholt die Itemgenerierung mit mehreren Modellen und vergleicht die Qualität ihrer Ergebnisse in einer Excel-Arbeitsmappe. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/qualite-psychometrique-de.mp4"><img src="ressources/vignettes/qualite-psychometrique-de.jpg" width="220" alt="Ansehen"></a> |
| [Item-Sortierung](https://genitem.recherche-formation.com/tri_items/) | Mehrere Modelle ordnen die Items Faktoren zu: Konsens, Fleiss' Kappa und Aikens V für jedes Item. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/tri-items-de.mp4"><img src="ressources/vignettes/tri-items-de.jpg" width="220" alt="Ansehen"></a> |
| [Variation der Bedingungen](https://genitem.recherche-formation.com/variation_conditions/) | Legt KI-Modellen einen Fragebogen unter mehreren Bedingungen vor und vergleicht ihre Antworten. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/variation-conditions-de.mp4"><img src="ressources/vignettes/variation-conditions-de.jpg" width="220" alt="Ansehen"></a> |
| [Modelltest](https://genitem.recherche-formation.com/test_modeles/) | Sendet dieselbe Anweisung an mehrere Modelle und vergleicht, was sie erzeugen und wie lange sie dafür brauchen. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/test-modeles-de.mp4"><img src="ressources/vignettes/test-modeles-de.jpg" width="220" alt="Ansehen"></a> |

### Textantworten analysieren

| Werkzeug | Funktion | Video |
|---|---|---|
| [Kodierung offener Antworten](https://genitem.recherche-formation.com/codage-de-reponse-ouverte/) | Induktive Kodierung: Mehrere KI-Modelle schlagen Codes vor, ein Codebuch wird erstellt, danach wird das Korpus kodiert und die Reliabilität gemessen. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/codage-de.mp4"><img src="ressources/vignettes/codage-de.jpg" width="220" alt="Ansehen"></a> |
| [Textometrie](https://genitem.recherche-formation.com/textometrie/) | Ordnet Textsegmente nach ihrem Wortschatz (Reinert-Methode) und stellt sie auf Karten dar. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/textometrie-de.mp4"><img src="ressources/vignettes/textometrie-de.jpg" width="220" alt="Ansehen"></a> |
| [Verbatims](https://genitem.recherche-formation.com/ia-humain/) | Kodiert Verbatims mit dem siebenstufigen Rahmen von Lee und Ha (2026) und vergleicht die KI-Kodierung mit der menschlichen. | <a href="https://genitem.recherche-formation.com/wp-content/uploads/data/info/verbatims-de.mp4"><img src="ressources/vignettes/verbatims-de.jpg" width="220" alt="Ansehen"></a> |

Die [Installation](https://genitem.recherche-formation.com/install/) (Ollama,
Python und R) wird auf der Website Schritt für Schritt erklärt, mit einem
eigenen [Video](https://genitem.recherche-formation.com/wp-content/uploads/data/info/installation-de.mp4).

---

## Einblick in die Website

Bildschirmfotos der aktuellen Website, auf Deutsch. Klicken Sie auf ein Bild, um es zu vergrößern.

<table>
<tr><td width="50%"><a href="ressources/captures/generation-items-de.jpg"><img src="ressources/captures/generation-items-de.jpg" alt="Itemgenerierung"></a><br><b>Itemgenerierung</b></td><td width="50%"><a href="ressources/captures/nouveaux-items-de.jpg"><img src="ressources/captures/nouveaux-items-de.jpg" alt="Neue Items"></a><br><b>Neue Items</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/revision-de.jpg"><img src="ressources/captures/revision-de.jpg" alt="Fragebogenüberarbeitung"></a><br><b>Fragebogenüberarbeitung</b></td><td width="50%"><a href="ressources/captures/retrotraduction-de.jpg"><img src="ressources/captures/retrotraduction-de.jpg" alt="Rückübersetzung"></a><br><b>Rückübersetzung</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/qualite-psychometrique-de.jpg"><img src="ressources/captures/qualite-psychometrique-de.jpg" alt="Psychometrische Qualität"></a><br><b>Psychometrische Qualität</b></td><td width="50%"><a href="ressources/captures/tri-items-de.jpg"><img src="ressources/captures/tri-items-de.jpg" alt="Item-Sortierung"></a><br><b>Item-Sortierung</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/variation-conditions-de.jpg"><img src="ressources/captures/variation-conditions-de.jpg" alt="Variation der Bedingungen"></a><br><b>Variation der Bedingungen</b></td><td width="50%"><a href="ressources/captures/test-modeles-de.jpg"><img src="ressources/captures/test-modeles-de.jpg" alt="Modelltest"></a><br><b>Modelltest</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/codage-de.jpg"><img src="ressources/captures/codage-de.jpg" alt="Kodierung offener Antworten"></a><br><b>Kodierung offener Antworten</b></td><td width="50%"><a href="ressources/captures/textometrie-de.jpg"><img src="ressources/captures/textometrie-de.jpg" alt="Textometrie"></a><br><b>Textometrie</b></td></tr>
<tr><td width="50%"><a href="ressources/captures/verbatims-de.jpg"><img src="ressources/captures/verbatims-de.jpg" alt="Verbatims"></a><br><b>Verbatims</b></td><td width="50%"><a href="ressources/captures/installation-de.jpg"><img src="ressources/captures/installation-de.jpg" alt="Installation"></a><br><b>Installation</b></td></tr>
</table>

---

## Inhalt dieses Repositorys

Dieses Repository stellt Genitem vor und archiviert seine zitierfähigen
Versionen auf Zenodo. Die Werkzeuge selbst werden über die Website genutzt.

| Ordner oder Datei | Inhalt |
|---|---|
| `scripts/analyse_genie.R` | Strukturelle Validierung eines Itempools mit AI-GENIE (ein Konstrukt) |
| `scripts/analyse_genie_multi_construits.R` | Dieselbe Analyse, wenn die Items mehrere Konstrukte messen |
| `ressources/` | Logo, Kodierraster, Vorschaubilder der Videos und Bildschirmfotos der Website |
| `CITATION.cff`, `.zenodo.json` | Zitation und Beschreibung des Zenodo-Archivs |

---

## Zitation

> Jan, D., Béland, S., Vincent, C., Michelot, F., & Caron, É. (2026). *Genitem:
> A user-friendly tool for the generation and pre-validation of items with AI*
> [Computer software]. Zenodo. <https://doi.org/10.5281/zenodo.22801168>

Dieser DOI verweist auf alle Versionen. Zitieren Sie für die
Reproduzierbarkeit die Version, die Sie verwendet haben (Zenodo-Seite,
Abschnitt *Versions*).

### Arbeiten, auf denen dieses Projekt aufbaut

- Russell-Lasalandra, L. L., Christensen, A. P., & Golino, H. (2026).
  Generative psychometrics via AI-GENIE: Automatic item generation and
  validation with network-integrated evaluation. *Behavior Research Methods,
  58*(8), 217. <https://doi.org/10.3758/s13428-026-03082-1>

---

## Lizenz

Seit dem 6. November 2026 steht das gesamte Repository unter der Lizenz
[CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/): freie Nutzung
und Bearbeitung, ohne kommerzielle Zwecke, unter Nennung der Autorinnen und
Autoren. Siehe [LICENSE](LICENSE). Für eine kommerzielle Nutzung wenden Sie sich
bitte an die Autorinnen und Autoren.

Die auf Zenodo archivierte Version 0.1 behält ihre ursprünglichen Lizenzen (MIT
für den Code, CC BY 4.0 für die Dokumentation).

---

## Förderung und Zugehörigkeit

Durchgeführt im Rahmen eines Projekts der **Universität Freiburg (Schweiz)**,
mit Unterstützung des **Fonds du centenaire** (Projekt FC-26-989), in Zusammenarbeit
mit der **Université de Montréal**.

## Kontakt

<info@genitem.education>
