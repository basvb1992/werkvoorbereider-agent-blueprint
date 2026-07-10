# Implementatie-voorbeeld — werkende demo (Fase B → C)

Van blueprint naar **werkende agents**. Twee demo's, oplopend in ambitie:

- **Fase B — Bestek & Tekeningen** (modern, *augment/kennis*): doorzoekt het fictieve
  bestek en vat eisen samen **met bronvermelding** — zonder Dataverse, zonder code.
- **Fase C — Inkoop & Materialen** (modern, *automate met controle*): leest voorraad
  en offertes uit **Dataverse** en maakt — **na bevestiging** — één **concept-
  inkoopaanvraag** aan. De eerste **schrijf-actie**, met de mens in de lus.
- **Documenten — SharePoint** (*augment + automate*): de documentlaag naast Dataverse —
  SharePoint als **kennisbron** voor de Bestek-agent én **projectmappen aanmaken** met
  bevestiging.

> **Doel:** per demo in ±1 dagdeel een werkende, gegronde agent — Fase B laat "het
> werkt" zien, Fase C laat zien hoe je veilig van *assisteren* naar
> *automatiseren-met-controle* groeit.

## Waarom deze demo

- **Bestek doorzoeken** is de eerste use-case uit de blueprint (hoogste waarde ×
  haalbaarheid, augment/kennis). Zie [referentie/usecase-bestek](../usecase-bestek/README.md).
- **Augment-only:** alleen een kennisbron (RAG), geen schrijfacties → de snelste
  route naar "het werkt".
- **Modern agent:** de huidige Copilot Studio-experience met generative orchestration,
  die 1-op-1 op deze blueprint aansluit.

## Modern = in de UI gebouwd (belangrijk)

Een **moderne** Copilot Studio-agent bouw je in de **Copilot Studio-portal**
([copilotstudio.microsoft.com](https://copilotstudio.microsoft.com)). Er is **geen**
ondersteunde `pac copilot push`-round-trip voor moderne agents, dus we borgen
reproduceerbaarheid met **deze runbook** (en de Dataverse-kant — indien later nodig —
via een solution).

## Fase B — Bestek & Tekeningen (augment/kennis)

| Bestand | Inhoud |
|---|---|
| [bestek-agent-runbook.md](bestek-agent-runbook.md) | Stap-voor-stap bouwen in de Copilot Studio-UI |
| [bestek-agent-instructie.md](bestek-agent-instructie.md) | De agent-instructie (ROCKET), klaar om te plakken |
| [bestek-agent-testset.md](bestek-agent-testset.md) | Testvragen incl. negatieve tests |

## Fase C — Inkoop & Materialen (automate met controle)

Een tweede demo met één **gecontroleerde schrijf-actie** op **Dataverse**: de agent
maakt — na bevestiging — een **concept-inkoopaanvraag** (status `Concept`). De
Dataverse-kant is **scriptbaar**; de agent bouw je in de UI.

| Bestand | Inhoud |
|---|---|
| [inkoop-dataverse-design.md](inkoop-dataverse-design.md) | Datamodel (3 tabellen) + seed-data + schrijf-contract |
| [scaffold-inkoop-dataverse.ps1](scaffold-inkoop-dataverse.ps1) | Idempotent script: maakt tabellen + fictieve data (Web API) |
| [inkoop-agent-runbook.md](inkoop-agent-runbook.md) | Stap-voor-stap: agent + lees-tools + schrijf-actie (met bevestiging) |
| [inkoop-agent-instructie.md](inkoop-agent-instructie.md) | De agent-instructie (ROCKET), klaar om te plakken |
| [inkoop-agent-testset.md](inkoop-agent-testset.md) | Testvragen incl. negatieve tests (geen bedrag verzinnen, alleen concept) |

## Documenten — SharePoint (augment + automate)

De documentlaag naast Dataverse: SharePoint als **kennisbron** (bestek, tekeningen,
contracten) én als **document-automatisering** (projectmap-structuur aanmaken, met
bevestiging). Vult zowel Fase B (kennis) als de automate-lijn aan.

| Bestand | Inhoud |
|---|---|
| [sharepoint-documenten.md](sharepoint-documenten.md) | SharePoint als kennis (A) + projectmap-provisioning (B) + hybride Dataverse (C) + mappenstructuur + governance |
| [scaffold-sharepoint-demo.ps1](scaffold-sharepoint-demo.ps1) | Idempotent script: projectmap-taxonomie + fictieve documenten (Graph) |

## Overige agents (build-kits)

Paste-ready build-kits (ROCKET-instructie + tools + testset) voor de resterende agents
uit de [Project Coach-architectuur](../project-coach/architectuur.md). De Dataverse-
datalaag voor de automate-agents is **scriptbaar** en is **live gescaffold** in de
demo-omgeving.

| Bestand | Inhoud |
|---|---|
| [overige-agents-dataverse-design.md](overige-agents-dataverse-design.md) | Datamodel (6 tabellen: Projecttaak / Medewerker / Boeking / Restpunt / Keuring / Wijzigingsverzoek) |
| [scaffold-agents-dataverse.ps1](scaffold-agents-dataverse.ps1) | Idempotent script: tabellen + fictieve seed (Web API) |
| [compliance-agent.md](compliance-agent.md) | Compliance / Regelgeving (augment, Bbl) |
| [planning-agent.md](planning-agent.md) | Planning & Capaciteit (automate) |
| [mensen-agent.md](mensen-agent.md) | Mensen (automate, herbruikbare service) |
| [oplever-agent.md](oplever-agent.md) | Oplever & Kwaliteit (automate) |
| [meerminderwerk-agent.md](meerminderwerk-agent.md) | Meer-/minderwerk (augment→automate) |
| [project-coach-orchestrator.md](project-coach-orchestrator.md) | Project Coach (orchestrator, connected agents) |

> **Status:** Bestek + Inkoop zijn **live gebouwd**; de Dataverse-datalaag voor
> Planning/Mensen/Oplever/Meer-/minderwerk is **live gescaffold**. De agents zelf bouw
> je in de Copilot Studio-UI met deze kits (moderne agents: geen `pac copilot push`).

## Vooraf (prerequisites)

- Toegang tot een **Power Platform-omgeving** met Copilot Studio (voor de demo een
  test-/demo-tenant — vul je eigen omgeving in, gebruik **géén** productiedata).
- Rechten om een agent te maken en te publiceren in die omgeving.
- Een plek voor de **kennisbron**: een SharePoint-documentbibliotheek óf lokale
  bestanden om te uploaden. Gebruik het fictieve materiaal uit
  [../../voorbeelddata/](../../voorbeelddata/).

> **Placeholders:** vul overal je eigen omgeving (`<jouw-omgeving>`), `<ENV_ID>` en
> `<gebruiker>` in. Zet **géén** echte omgevings-/tenant-ID's of org-URL's in deze
> (publieke) repo.

## Data = fictief

Alle bronnen in [../../voorbeelddata/](../../voorbeelddata/) zijn **verzonnen**
(project "De Beemster"). Perfect voor een demo; het is geen echte project- of
bedrijfsdata.
