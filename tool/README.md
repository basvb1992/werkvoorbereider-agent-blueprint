# Werkvoorbereider Agent — Bouwgids (interactieve tool)

Een self-contained HTML-tool die business én IT samen door de 9 blueprint-stappen
leidt naar een eigen werkvoorbereidings-agent. Geen server of internet nodig —
alles draait lokaal in je browser.

## Wat de tool biedt

- **Startscherm** met sessie-gegevens (bedrijf, facilitator, datum, deelnemers)
  en uitleg over de aanpak.
- **9 begeleide stappen**, elk met:
  - **Wie aan tafel** — rolbadges (Business/WVB · IT/Beheer · Consultant/Maker).
  - **Checklist** — afvinkbare punten zodat je niets vergeet.
  - **Invulvelden** — leg je keuzes vast.
  - **Praktische tips** — o.a. het gebruik van de prompt-agent/prompt-optimizer.
  - **Verdieping** — directe links naar `blueprint/`, `best-practices/` en `referentie/`.
- **ROCKET prompt-starter** (stap 06) — genereert uit je velden een start-instructie
  die je in Copilot Studio of Foundry plakt en daar verder verfijnt.
- **Voortgang** — één balk over velden én checklists samen.
- **Print / PDF** — knop die de volledige ingevulde blueprint als print-/PDF-weergave
  opent (browser "Opslaan als PDF"); geen dependencies, blijft offline.

## Gebruiken

1. Open [index.html](index.html) in een moderne browser (dubbelklik of sleep in
   een browservenster).
2. Vul op het startscherm de sessie-gegevens in en klik **Begin bij stap 00**.
3. Doorloop de 9 stappen: vink de checklist af en vul de velden in. Alles wordt
   automatisch lokaal opgeslagen (browser `localStorage`).
4. Exporteer je resultaat:
   - **Export Markdown** — een deelbaar blueprint-document (incl. checklists).
   - **Export JSON** — om later verder te werken of te delen.
5. **Importeren** laadt een eerder geëxporteerd JSON-bestand terug. Oude exports
   (alleen velden) worden automatisch overgenomen.

## Samen business + IT

De tool is bedoeld voor een gezamenlijke sessie. Business brengt de kennis van het
werk en de behoefte; IT/beheer bepaalt haalbaarheid, koppelingen en rechten
(vooral in stap 03 en 07); een consultant/maker helpt met ontwerp en bouw. De
rolbadges bovenaan elke stap laten zien wie je erbij nodig hebt.

## Privacy

- Er wordt niets verzonden; data blijft in je browser tot je op **Wissen** klikt.
- Exports kunnen bedrijfsgegevens bevatten — bewaar ze buiten deze repo
  (`werkvoorbereider-blueprint.json/.md`, `*.canvas.json` en de map `ingevuld/`
  staan in `.gitignore`).

## Thema

De tool respecteert licht/donker (systeeminstelling) en heeft een **◐ Thema**-knop
om te wisselen. Vormgeving volgt het Clawpilot-thema.
