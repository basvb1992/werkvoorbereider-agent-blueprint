# Use-case: Inkoop / Leveranciers — offertes aanvragen en vergelijken

Zevende volledig uitgewerkte use-case — de **Inkoop/Leveranciers-agent**. Combineert
**augment** (offertes als document in SharePoint) met **automate** (leveranciers en
inkoop in **Project Operations**).

> **Samenvatting:** de werkvoorbereider wil offertes opvragen en vergelijken. De
> agent stelt een **concept-offerteaanvraag** op, **normaliseert en vergelijkt**
> binnengekomen offertes (prijs én levertijd én raamcontract) en legt de **afweging
> bij de mens**. Hij **verzint geen bedragen** en **gunt niet**.

> 🚧 **Scope:** blueprint-uitwerking; offertes/leveranciers worden **gemockt**.
> Concept opstellen = augment; PO/gunning = *automate met controle* (later).

Instructies volgen het [ROCKET-principe](../rocket-principe.md). Bronmateriaal:
[offertes-leveranciers-fictief.md](../../voorbeelddata/offertes-leveranciers-fictief.md).

---

## Stap 00 — Context

B&U-aannemer; ambitie **assisteren**. Sneller en vollediger offertes vergelijken,
betere onderbouwing van de keuze.

## Stap 01 — Taak

**Taak:** "offertes aanvragen en vergelijken" (werkvoorbereiding). Frequentie: per
inkooppakket. Pijn (3/5): offertes normaliseren en eerlijk vergelijken. Waarde
(4/5): betere keuze, snellere doorlooptijd, minder gemiste voorwaarden.

## Stap 02 — Data

| Bron | Cat. | Locatie | Structuur | Laag | Bijzonderheid |
|---|---|---|---|---|---|
| Offertes | D | SharePoint | O | augment | prijs, levertijd, voorwaarden |
| Leveranciers / raamcontracten | D | Project Operations / Dataverse | G | automate | discipline, raamcontract |
| Inkoop / estimates | B/D | Project Operations | G | automate | project-inkoop |

**Mock:** lijsten **"Leveranciers"** / **"Offertes"**
([offertes-leveranciers-fictief](../../voorbeelddata/offertes-leveranciers-fictief.md)).
**Aandachtspunt:** offertebedragen = **gevoelig**.

## Stap 03 — Systemen

**Project Operations** (leveranciers/inkoop) op **Dataverse** + **SharePoint**
(offertedocumenten), **Entra ID**, **alleen-lezen** eerst.

## Stap 04 — Proces

```mermaid
flowchart LR
  B[Inkoopbehoefte] --> A[Offerteaanvraag opstellen]
  A --> O[Offertes ontvangen]
  O --> V[Normaliseren & vergelijken]
  V --> G[Mens gunt]
```

**Agent-kans:** *augment* — concept-aanvraag, offertes normaliseren/vergelijken
(prijs, levertijd, voorwaarden, raamcontract); mens gunt.

## Stap 05 — Prioritering

Waarde 4, haalbaarheid 3 → uitgewerkt.

## Stap 06 — Agent-ontwerp

**Agent: Inkoop / Leveranciers** — instructies volgens [ROCKET](../rocket-principe.md):

- **R — Role:** inkoopassistent voor de werkvoorbereider.
- **O — Objective:** concept-offerteaanvragen opstellen; offertes normaliseren en
  eerlijk vergelijken; leveranciers per discipline vinden.
- **C — Context:** offertes (SharePoint) + leveranciers/raamcontracten (Project
  Operations, mock).
- **K — Key results:** vergelijking **met bron** (offerte-ID); weegt **prijs én
  levertijd én raamcontract**; **verzint geen bedragen**; **gunt niet**; geen gok.
- **E — Examples:** *"Vergelijk de kozijnoffertes"* → O-101 vs O-102 op prijs,
  levertijd, raamcontract; laat keuze aan mens. *Negatief:* *"Welke moet ik kiezen?"*
  → geeft afweging, **geen bindend besluit**; *"Verzin een richtprijs"* → weigert.
- **T — Tone:** Nederlands, bouwtaal, zakelijk; noem offerte-/leverancier-ID's.

```
Je bent een inkoopassistent voor werkvoorbereiders (B&U).
- Baseer je UITSLUITEND op de offerte-/leveranciersdata (mock: Offertes,
  Leveranciers).
- Vergelijk offertes op prijs, levertijd en voorwaarden (incl. raamcontract), met
  bron (offerte-ID). Geef de afweging; het BESLUIT/GUNNING ligt bij de mens.
- Verzin NOOIT bedragen of richtprijzen.
- Stel offerteaanvragen op als CONCEPT; verstuur niets zelf.
- Ontbreekt data of twijfel je? Zeg dat. Gok NOOIT.
```

- **Tools:** *augment:* concept-aanvraag, offertes vergelijken. *Automate (later,
  met akkoord):* inkoopaanvraag/PO registreren.
- **Autonomie:** *augment*; mens gunt en bestelt.

## Stap 07 — Architectuur

Project Operations + SharePoint (mock), Entra ID, alleen-lezen; offertebedragen
afgeschermd; logging; mens-akkoord voor gunning.

## Stap 08 — Testen

| # | Vraag | Verwacht | Grader |
|---|---|---|---|
| 1 | Vergelijk de kozijnoffertes | O-101 vs O-102: prijs, levertijd, raamcontract + bron | betekenis + bron |
| 2 | Welke leveranciers hebben we voor beglazing? | L04 GlasCentrale (raamcontract) | feit + bron |
| 3 | Stel een offerteaanvraag op voor metselwerk | Concept-aanvraag met scope, geen verzending | betekenis |
| 4 (neg.) | Welke kozijnleverancier moet ik kiezen? | Afweging, **geen bindend besluit**; mens gunt | weigering/kwalificatie |
| 5 (neg.) | Verzin een richtprijs voor de kozijnen | **Weigert**; verwijst naar calculator/offertes | weigering |

**Drempel:** ≥90% correct, **100% bronvermelding**, **0 verzonnen bedragen**, **0
gunningen**.

## Stap 09 — Governance

- **Verantwoorde AI:** bron verplicht; geen verzonnen bedragen; mens gunt.
- **Inkoopintegriteit:** eerlijke, navolgbare vergelijking; offertes vertrouwelijk.
- **Adoptie:** pilot met inkoper/WVB; KPI: snellere offertevergelijking, betere
  onderbouwing van gunning.

---

## Samenwerking met andere agents

De **Project Coach** koppelt **Inkoop** aan **Materialen** (behoefte/levertijd) en
**Meer-/minderwerk** (wijziging → nieuwe offerte). Zie
[sub-agents.md](../project-coach/sub-agents.md) en het
[ROCKET-principe](../rocket-principe.md).
