# Implementatie-voorbeeld — werkende demo (Fase B)

Van blueprint naar een **werkende agent**. Dit is de bouw-runbook voor de eerste
demo: de **Bestek & Tekeningen-agent** (modern, augment/kennis) in Copilot Studio.

> **Doel:** in ±1 dagdeel een werkende, gegronde agent die het fictieve bestek
> doorzoekt en eisen samenvat **met bronvermelding** — zonder Dataverse, zonder code.

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

## Onderdelen

| Bestand | Inhoud |
|---|---|
| [bestek-agent-runbook.md](bestek-agent-runbook.md) | Stap-voor-stap bouwen in de Copilot Studio-UI |
| [bestek-agent-instructie.md](bestek-agent-instructie.md) | De agent-instructie (ROCKET), klaar om te plakken |
| [bestek-agent-testset.md](bestek-agent-testset.md) | Testvragen incl. negatieve tests |

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
