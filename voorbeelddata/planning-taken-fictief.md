# Planning (FICTIEF) — Woongebouw "De Beemster"

> ⚠️ **FICTIEF EN ILLUSTRATIEF.** Verzonnen planningsdata om de
> [Planning-use-case](../referentie/usecase-planning/README.md) mee te oefenen.
> Bootst een **Project Operations**-projectplanning (WBS) na; in de demo als
> Dataverse-tabel **`Projecttaak`** of SharePoint-lijst **"Projecttaken"**.

Project: FIC-2026-012 · Baseline-versie: 2026-05-20

| ID | Taak | Fase | Start | Eind | %gereed | Status | Afhankelijk van |
|---|---|---|---|---|---|---|---|
| T01 | Grondwerk & fundering | Ruwbouw | 06-01 | 06-14 | 100% | Gereed | — |
| T02 | Wanden begane grond | Ruwbouw | 06-16 | 06-30 | 60% | In uitvoering | T01 |
| T03 | Verdiepingsvloeren | Ruwbouw | 07-01 | 07-11 | 0% | Gepland | T02 |
| T04 | Gevel + kozijnen | Gevel | 07-14 | 08-01 | 0% | Gepland | T03 |
| T05 | Installaties (E&W) | Afbouw | 07-21 | 08-08 | 0% | Gepland | T03 |
| T06 | Afbouw & afwerking | Afbouw | 08-04 | 08-22 | 0% | Gepland | T04, T05 |
| T07 | Oplevering | Oplevering | 08-25 | 08-29 | 0% | Gepland | T06 |

**Mijlpalen:** ruwbouw gereed (11-07), waterdicht/gevel dicht (01-08),
oplevering (29-08).

> *Oefenpunt:* T02 loopt (60%); een lichte uitloop van T02 raakt via T03 het
> kritieke pad naar de oplevering. Een goede Planning-agent **signaleert** dit,
> maar **verzet zelf geen opleverdatum**.
