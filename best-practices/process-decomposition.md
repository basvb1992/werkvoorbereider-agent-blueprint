# Businessproces-decompositie

Een agent helpt op **taakniveau**. Goede decompositie voorkomt zowel te grote
("monolithische") als te kleine (versplinterde) agents. Dit sluit aan op Microsoft's
building block *Flows & orchestration* en op de multi-agent-regels.

> **Laatst getoetst:** 2026-07-10.

## Decompositie-hiërarchie

```
Waardestroom  →  Proces  →  Sub-proces  →  Activiteit  →  Taak / Stap
```

Voor de werkvoorbereider (waardestroom *offerte → uitvoering → oplevering*):
- **Proces:** bv. "inkoop & materiaal voorbereiden".
- **Sub-proces:** "offertes aanvragen en vergelijken".
- **Activiteit:** "offertes normaliseren".
- **Taak/stap:** "prijs, levertijd en raamcontract naast elkaar zetten".

Decomponeer tot het niveau waarop **één agent (of tool) een stap kan bezitten**.

## Per proces vastleggen (SIPOC + RACI)

| Element | Vraag |
|---|---|
| **Trigger** | Wat start het proces? (nieuw project, wijziging, mail, planning) |
| **Suppliers / Inputs** | Welke bronnen/data komen binnen? |
| **Process** | Welke stappen, in welke volgorde? |
| **Outputs / Customers** | Wat levert het op, voor wie? |
| **Rollen (RACI)** | Wie is Responsible/Accountable/Consulted/Informed? |
| **Beslissingen & uitzonderingen** | Waar wordt gekozen; wat zijn randgevallen? |
| **KPI's** | Hoe meet je succes? |

## As-is → to-be → automatiseringskandidaat

1. Teken **as-is** (hoe het nu echt gaat).
2. Markeer **knelpunten** (handwerk, wachttijd, fouten).
3. Bepaal per stap: **augment** (agent helpt) of **automate** (agent doet, mens
   controleert) — en wat **mens blijft** (oordeel, risico, aansprakelijkheid).
4. Kies de stappen die een agent/tool kan bezitten → dat worden je **use-cases**.

## Van proces naar agent-architectuur

- Groepeer stappen die **dezelfde kennis/data en governance** delen tot **één domein**
  = één sub-agent (zie [decompositie-verantwoording](../referentie/project-coach/architectuur.md#decompositie-verantwoording)).
- **Niet** decomponeren per bronsysteem — dat gaf bij ons routing-overlap.

## Toegepast in de blueprint

- [Stap 04 — Proces-mapping](../blueprint/04-proces-mapping/): as-is/to-be + knelpunten.
- [Stap 05 — Use-case prioritering](../blueprint/05-usecase-prioritering/): waarde × haalbaarheid.
