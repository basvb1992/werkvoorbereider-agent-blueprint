# Roadmap

Ideeën en vervolgstappen voor deze blueprint en de bijbehorende tool. Samen op te
pakken — dit is een levend document.

> **Huidige focus:** eerst een **werkende demo** (zie Fase B hieronder). Verdere
> polish van de begeleide tool-experience is bewust geparkeerd tot de demo staat.

## Interactieve tool (`tool/index.html`)

De tool is nu een begeleide bouwgids: startscherm met sessie-gegevens, 9 stappen
met rolbadges (business ↔ IT ↔ consultant), checklists, praktische tips, een
ROCKET prompt-starter, lokale opslag (`localStorage`) en export naar Markdown/JSON.
Kandidaten voor een volgende ronde:

- **Systeem-koppelbeslisser (stap 03)** — een kleine interactieve matrix waarin je
  per systeem kiest: koppelen ja/nee, integratievorm (API/MCP/Dataverse/export),
  benodigde rechten en eigenaar. Nu nog vrije tekstvelden + checklist.
- ~~Print/PDF-weergave~~ — **gedaan:** knop **Print / PDF** (client-side, via de
  browser "Opslaan als PDF", geen dependencies).
- **Voorbeeld-invulling laden** — knop om het fictieve project "De Beemster" als
  voorbeeld in te laden, zodat mensen de tool meteen gevuld zien.
- **Use-case-sjablonen** — kies een kern-use-case (bestek, compliance,
  meer-/minderwerk, inkoop & materialen, planning, oplevering) en pre-fill stap 05/06.
- **Deelbare read-only export** — een HTML-export die het resultaat toont zonder
  bewerken, om met stakeholders te delen.
- **Meertaligheid** — nu NL; eventueel EN.

## Blueprint / inhoud

- **Fase B: werkende demo — GESTART.** Runbook voor de **moderne Bestek-agent**
  (augment/kennis, geen Dataverse) staat in
  [referentie/implementatie-voorbeeld/](referentie/implementatie-voorbeeld/README.md).
  Volgende: bouwen in de gekozen demo-omgeving (interactieve sign-in vereist).
  **Fase C** = een automate-use-case (Inkoop) met Dataverse + `pac`.
- **ROCKET-interpretatie bevestigen** — huidige invulling: Role · Objective ·
  Context · Key results · Examples · Tone. Definitief maken met de gebruiker.
- **Moderne Copilot Studio-agents** — bouwen via de UI; er is geen ondersteunde
  `pac copilot push` round-trip voor moderne agents (vastgelegd in `best-practices/`).

## Onderhoud

- Best-practices-pagina's dragen een "laatst getoetst"-datum; periodiek toetsen aan
  de actuele Microsoft-guidance.
