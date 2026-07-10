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

- **Fase B: werkende demo (Bestek, augment/kennis) — runbook klaar.** Staat in
  [referentie/implementatie-voorbeeld/](referentie/implementatie-voorbeeld/README.md).
- **Fase C: automate-met-controle (Inkoop) — GESTART.** Runbook, ROCKET-instructie,
  testset, [Dataverse-ontwerp](referentie/implementatie-voorbeeld/inkoop-dataverse-design.md)
  en een **idempotent scaffold-script** (Web API) staan klaar. De schrijf-actie maakt
  een **concept-inkoopaanvraag** (status `Concept`) met bevestiging. Volgende:
  Dataverse live scaffolden en de agent in de demo-omgeving bouwen.
- **Documentlaag — SharePoint (demo).** Runbook voor SharePoint als **kennisbron**
  (Bestek-agent) én **projectmap-provisioning** (automate met controle) staat in
  [referentie/implementatie-voorbeeld/sharepoint-documenten.md](referentie/implementatie-voorbeeld/sharepoint-documenten.md).
  Volgende: live koppelen van de kennisbron en de provisioning-flow bouwen.
- **Overige agents — build-kits + datalaag.** Build-kits (ROCKET + tools + testset) voor
  Compliance / Planning / Mensen / Oplever / Meer-/minderwerk + de Project Coach-
  orchestrator staan in [referentie/implementatie-voorbeeld/](referentie/implementatie-voorbeeld/README.md);
  de Dataverse-datalaag (6 tabellen) is scriptbaar en **live gescaffold**. Volgende:
  de agents in de Copilot Studio-UI bouwen + publiceren, dan de orchestrator koppelen.
- **ROCKET-interpretatie VASTGESTELD (optie B):** Role · Objective · Context ·
  **Knowledge** · **Expectations** · Tone. `referentie/rocket-principe.md` bijgewerkt; de
  live agents volgen deze indeling.
- **Moderne Copilot Studio-agents** — bouwen via de UI; er is geen ondersteunde
  `pac copilot push` round-trip voor moderne agents (vastgelegd in `best-practices/`).

## Onderhoud

- Best-practices-pagina's dragen een "laatst getoetst"-datum; periodiek toetsen aan
  de actuele Microsoft-guidance.
