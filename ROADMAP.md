# Roadmap

Ideeën en vervolgstappen voor deze blueprint en de bijbehorende tool. Samen op te
pakken — dit is een levend document.

## Interactieve tool (`tool/index.html`)

De tool is nu een begeleide bouwgids: startscherm met sessie-gegevens, 9 stappen
met rolbadges (business ↔ IT ↔ consultant), checklists, praktische tips, een
ROCKET prompt-starter, lokale opslag (`localStorage`) en export naar Markdown/JSON.
Kandidaten voor een volgende ronde:

- **Systeem-koppelbeslisser (stap 03)** — een kleine interactieve matrix waarin je
  per systeem kiest: koppelen ja/nee, integratievorm (API/MCP/Dataverse/export),
  benodigde rechten en eigenaar. Nu nog vrije tekstvelden + checklist.
- **Print/PDF-weergave** — een nette one-pager van de volledige ingevulde blueprint
  (nu: Markdown-export).
- **Voorbeeld-invulling laden** — knop om het fictieve project "De Beemster" als
  voorbeeld in te laden, zodat mensen de tool meteen gevuld zien.
- **Use-case-sjablonen** — kies een kern-use-case (bestek, compliance,
  meer-/minderwerk, inkoop & materialen, planning, oplevering) en pre-fill stap 05/06.
- **Deelbare read-only export** — een HTML-export die het resultaat toont zonder
  bewerken, om met stakeholders te delen.
- **Meertaligheid** — nu NL; eventueel EN.

## Blueprint / inhoud

- **Fase B: werkende gemockte demo** — een uitgewerkt implementatie-voorbeeld
  (M365 + Power Apps/Dataverse) met een build-runbook in
  `referentie/implementatie-voorbeeld/`. Omgeving nog te bepalen. Start op verzoek.
- **ROCKET-interpretatie bevestigen** — huidige invulling: Role · Objective ·
  Context · Key results · Examples · Tone. Definitief maken met de gebruiker.
- **Moderne Copilot Studio-agents** — bouwen via de UI; er is geen ondersteunde
  `pac copilot push` round-trip voor moderne agents (vastgelegd in `best-practices/`).

## Onderhoud

- Best-practices-pagina's dragen een "laatst getoetst"-datum; periodiek toetsen aan
  de actuele Microsoft-guidance.
