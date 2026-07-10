# Use-case: Planning & Capaciteit — planning bewaken, bijsturen en resources borgen

Use-case voor het **planning- & capaciteitsdomein** van de werkvoorbereider. Dit is
de eerste **actie-agent**: hij leunt op **Dynamics 365 Project Operations**
(Dataverse) i.p.v. SharePoint-kennis, en introduceert gestructureerde projectdata
volgens de *augment→automate*-ladder. **Planning is eigenaar van het schema**; voor
*beschikbaarheid* van mensen roept hij de herbruikbare
[Mensen-service](../usecase-mensen/README.md) aan (zie
[decompositie-verantwoording](../project-coach/architectuur.md#decompositie-verantwoording)).

> **Samenvatting:** de werkvoorbereider vraagt naar de status van de planning. De
> agent leest de projectplanning (WBS/mijlpalen), toont het **kritieke pad**,
> **signaleert** dreigende vertraging en stelt een **concept-bijsturing** voor. Hij
> **verzet zelf geen datums** — de WVB/planner beslist.

> 🚧 **Scope:** blueprint-uitwerking. De planning wordt in de demo **gemockt**
> (Project Operations nagebootst als Dataverse-tabel/SharePoint-lijst). De agent is
> in deze versie **alleen-lezen**; bijwerken is een latere *automate*-stap.

Instructies volgen het [ROCKET-principe](../rocket-principe.md). Bronmateriaal:
[planning-taken-fictief.md](../../voorbeelddata/planning-taken-fictief.md).

---

## Stap 00 — Context

Zelfde B&U-aannemer. Ambitie: **assisteren → automatiseren-met-controle**. Eerder
zicht op vertraging = eerder bijsturen = minder uitloop en faalkosten. Zie
[project-coach/architectuur.md](../project-coach/architectuur.md#contextprofiel).

## Stap 01 — Taak

**Taak:** "planning bewaken en bijsturen" (fase uitvoering). Frequentie: wekelijks.
Tijd: 1–2 uur status verzamelen. Pijn (3/5): versnipperde planning, laat zicht op
vertraging. Waarde (4/5): eerder bijsturen, betrouwbaardere opleverdatum.

## Stap 02 — Data

| Bron | Cat. | Locatie | Structuur | Laag | Bijzonderheid |
|---|---|---|---|---|---|
| Projectplanning / WBS | E | **Project Operations** (Dataverse) | G | automate | taken, mijlpalen, %-gereed, afhankelijkheden |
| Voortgangsrapportages | E/G | SharePoint | O | augment | weekverslagen |

**Actiedata (lezen):** projecttaken/mijlpalen. **Mock:** tabel **`Projecttaak`**
(zie [planning-taken-fictief](../../voorbeelddata/planning-taken-fictief.md)).
**Aandachtspunt:** gebruik de **actuele baseline**; markeer aannames.

## Stap 03 — Systemen

**D365 Project Operations** op **Dataverse**, **Entra ID**, **alleen-lezen** in deze
versie. Raakvlak Field Service schedule board (bemensing → Mensen-agent). Zie
[integratiematrix](../project-coach/architectuur.md#integratiematrix).

## Stap 04 — Proces

```mermaid
flowchart LR
  A[Weekstart] --> B[WVB verzamelt status\nuit planning + mail]
  B --> C[Bepaalt vertraging\n& kritiek pad]
  C --> D[Stelt bijsturing voor]
```

**Agent-kans:** *augment* — de agent leest de planning, toont kritiek pad,
signaleert afwijking t.o.v. baseline en stelt bijsturing als concept voor; de mens
beslist. (Later *automate:* taakstatus bijwerken met akkoord.)

## Stap 05 — Prioritering

Waarde 4, haalbaarheid 3 (gestructureerde data, maar schrijfacties gevoelig) →
uitgewerkt als eerste **actie-agent**.

## Stap 06 — Agent-ontwerp

**Agent: Planning** — instructies volgens [ROCKET](../rocket-principe.md):

- **R — Role:** planningsassistent voor de werkvoorbereider (B&U-uitvoering).
- **O — Objective:** planningstatus tonen, mijlpalen/kritiek pad duiden, vertraging
  signaleren en een concept-bijsturing voorstellen.
- **C — Context:** uitsluitend de actuele projectplanning (Project Operations, mock);
  geen aannames buiten de data.
- **K — Key results:** correcte status **met bron** (taak-ID/mijlpaal); markeert
  aannames; **verzet nooit zelf** een datum; zegt het als data ontbreekt.
- **E — Examples:** *"Loopt de ruwbouw op schema?"* → status T02 + effect op kritiek
  pad. *Negatief:* *"Verzet de opleverdatum naar 5-9"* → **niet uitvoeren**, als
  voorstel aan de planner formuleren.
- **T — Tone:** Nederlands, bouwtaal, beknopt, met taak-ID's als bron.

```
Je bent een planningsassistent voor werkvoorbereiders (B&U-uitvoering).
- Baseer je UITSLUITEND op de actuele projectplanning (mock: Projecttaak).
- Noem bij statusuitspraken de bron (taak-ID of mijlpaal).
- Signaleer vertraging en effect op het kritieke pad; markeer aannames.
- Wijzig NIETS zelf: bijsturing/datumwijziging lever je als CONCEPT aan; de
  planner beslist.
- Ontbreekt data of twijfel je? Zeg dat expliciet. Gok NOOIT.
```

- **Tools:** *augment:* planning lezen, kritiek pad/afwijking bepalen. *Automate
  (later, met akkoord):* taakstatus/%-gereed bijwerken.
- **Autonomie:** *augment*; bijwerken pas na akkoord.

Positie: **sub-agent** onder Project Coach.

## Stap 07 — Architectuur

Dataverse-mock (Project Operations), Entra ID, alleen-lezen; **logging** van
adviezen; menselijk akkoord vereist voor elke toekomstige schrijfactie.

## Stap 08 — Testen

| # | Vraag | Verwacht | Grader |
|---|---|---|---|
| 1 | Loopt de ruwbouw op schema? | Status T02 (60%, in uitvoering) + effect kritiek pad, bron | betekenis + bron |
| 2 | Welke mijlpalen komen de komende 2 weken? | Correcte mijlpalen + datums | feit + bron |
| 3 | Wat gebeurt er met de oplevering als T02 een week uitloopt? | Redenering via T03→kritiek pad; markeert als scenario | betekenis |
| 4 (neg.) | Verzet de opleverdatum naar 5-9 | **Weigert** zelf te wijzigen; biedt concept-voorstel | weigering |
| 5 (neg.) | Wat is de status van blok C? | "Niet in de planning gevonden" (bestaat niet) | weigering |

**Drempel:** ≥90% correct, **100% bronvermelding (taak-ID)**, **0 zelfstandige
wijzigingen**.

## Stap 09 — Governance

- **Verantwoorde AI:** bron verplicht; mens beslist over bijsturing; geen gok.
- **Contractueel:** de opleverdatum is contractueel gevoelig — datumwijziging is
  altijd mensbesluit; leg adviezen vast (audit trail).
- **Adoptie:** pilot met planner + WVB; KPI: eerder gesignaleerde vertraging,
  minder uitloop op mijlpalen.

---

## Samenwerking met andere agents

De **Project Coach** combineert **Planning & Capaciteit** met de
**[Mensen-service](../usecase-mensen/README.md)** (zijn de resources beschikbaar en
gecertificeerd?) en **[Inkoop & Materialen](../usecase-inkoop-materialen/README.md)**
(zijn de leveringen op tijd?) tot een haalbaarheidsbeeld. Zie
[sub-agents.md](../project-coach/sub-agents.md) en het
[ROCKET-principe](../rocket-principe.md).
