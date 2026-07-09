# Interactieve blueprint-canvas

Een self-contained HTML-tool om de 9 blueprint-stappen als canvas in te vullen en
te exporteren. Geen server of internet nodig — alles draait lokaal in je browser.

## Gebruiken

1. Open [index.html](index.html) in een moderne browser (dubbelklik of sleep in
   een browservenster).
2. Doorloop de 9 stappen in het linkermenu; je invoer wordt automatisch lokaal
   opgeslagen (browser `localStorage`).
3. Exporteer je resultaat:
   - **Export Markdown** — een ingevuld blueprint-document.
   - **Export JSON** — om later verder te werken of te delen.
4. **Importeren** laadt een eerder geëxporteerd JSON-bestand terug.

## Privacy

- Er wordt niets verzonden; data blijft in je browser tot je op **Wissen** klikt.
- Exports kunnen bedrijfsgegevens bevatten — bewaar ze buiten deze repo
  (`.canvas.json` en de map `ingevuld/` staan in `.gitignore`).

## Thema

De tool respecteert licht/donker (systeeminstelling) en heeft een **◐ Thema**-knop
om te wisselen.
