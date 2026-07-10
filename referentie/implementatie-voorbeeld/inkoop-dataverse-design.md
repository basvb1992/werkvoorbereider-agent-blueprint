# Dataverse-ontwerp — Inkoop & Materialen (Fase C, automate-met-controle)

Dit is het **datamodel** voor de tweede demo: de **Inkoop & Materialen-agent** die,
naast opzoeken en vergelijken, één **schrijf-actie** toont — het aanmaken van een
**CONCEPT-inkoopaanvraag** in Dataverse, **na bevestiging** door de mens.

> **Kern:** de schrijf-actie is bewust **veilig**. De agent maakt uitsluitend een
> record met **status `Concept`**. Hij **bestelt niet**, **gunt niet** en **dient
> niets in of keurt niets goed** — de mens beslist. Dit is *augment → automate met
> controle*, precies zoals de blueprint voorschrijft. Zie
> [usecase Inkoop & Materialen](../usecase-inkoop-materialen/README.md) en
> [blueprint 09 — governance](../../blueprint/09-governance-en-adoptie/).

## Waarom deze demo (na de Bestek-agent)

De [Bestek-agent](bestek-agent-runbook.md) was **augment-only** (alleen kennis, geen
mutaties) — de snelste route naar "het werkt". Fase C zet één stap verder: een
**echte schrijf-actie op Dataverse**, maar met een **mens-in-de-lus**. Zo laat je
zien hoe je van assisteren naar *automatiseren-met-controle* groeit zonder de
governance los te laten.

## Bewust een plat ontwerp (voor de demo)

De tabellen zijn **plat**: alleen **tekst / getal / decimaal / memo**, geen lookups
en geen choice-kolommen. Twee redenen:

1. **Volledig scriptbaar en herhaalbaar** — het meegeleverde
   [scaffold-inkoop-dataverse.ps1](scaffold-inkoop-dataverse.ps1) maakt in één run de
   publisher, drie tabellen, alle kolommen én de seed-data.
2. **Eenvoudiger schrijf-tool** — de agent vult platte velden (bv. `wvb_status =
   "Concept"`, `wvb_materiaalartikel = "ART-KOZ-004 Hardhouten kozijn"`) zonder een
   lookup-GUID te hoeven opzoeken.

In **productie** kies je natuurlijk rijkere modellering — een **lookup** Offerte →
Materiaal en Inkoopaanvraag → Materiaal, een **choice** voor `status`, en een aparte
**Leverancier**-tabel met raamcontract als vlag. Dat staat los van de kern van de
demo (lezen + één gecontroleerde schrijf-actie) en is bewust weggelaten om
reproduceerbaar te blijven.

> **Data = fictief.** Alle rijen komen uit project *"De Beemster"* en zijn verzonnen
> (zie [../../voorbeelddata/materialen-voorraad-fictief.md](../../voorbeelddata/materialen-voorraad-fictief.md)
> en [../../voorbeelddata/offertes-leveranciers-fictief.md](../../voorbeelddata/offertes-leveranciers-fictief.md)).
> Gebruik een **demo-/test-omgeving**, geen productie.

## Prefix & publisher

Alle tabellen en kolommen krijgen de prefix **`wvb_`** (werkvoorbereider). Het
scaffold-script maakt zo nodig een publisher `wvb` aan. Vervang `wvb_` door je eigen
prefix als je dat wilt.

## Tabellen

### 1. Materiaal — `wvb_materiaal` (lezen)

Bootst **Field Service** producten/voorraad na. Primaire kolom: **`wvb_naam`**.

| Kolom (weergave) | Logische naam | Type | Toelichting |
|---|---|---|---|
| Naam | `wvb_naam` | Tekst | Artikelnaam (primair) |
| Artikelnummer | `wvb_artikelnummer` | Tekst | bron-ID voor bronvermelding |
| Eenheid | `wvb_eenheid` | Tekst | `st`, `m²`, `zak`, `ton`… |
| Voorraad | `wvb_voorraad` | Decimaal | huidige voorraad |
| Magazijn | `wvb_magazijn` | Tekst | locatie |
| Levertijd (weken) | `wvb_levertijdweken` | Geheel getal | `0` = ≤ 1 week |
| Behoefte project | `wvb_nodig` | Decimaal | benodigd voor "De Beemster" |

### 2. Offerte — `wvb_offerte` (lezen)

Bootst **Project Operations** inkoop + offertes na. Primaire kolom: **`wvb_naam`**
(= offertenummer). **Bedragen zijn fictief en vertrouwelijk.**

| Kolom (weergave) | Logische naam | Type | Toelichting |
|---|---|---|---|
| Offertenummer | `wvb_naam` | Tekst | bv. `O-101` (primair) |
| Materiaal/artikel | `wvb_materiaalartikel` | Tekst | artikelnr + naam |
| Leverancier | `wvb_leverancier` | Tekst | incl. code, bv. `L01 Kozijnfabriek Noord` |
| Post | `wvb_post` | Tekst | bv. `12 kozijnen 1.800×2.400` |
| Bedrag (€, fictief) | `wvb_bedrag` | Decimaal | **vertrouwelijk** |
| Levertijd (weken) | `wvb_levertijdweken` | Geheel getal | `0` = n.v.t. |
| Raamcontract | `wvb_raamcontract` | Tekst | `Ja` / `Nee` |
| Geldig tot | `wvb_geldigtot` | Tekst | `JJJJ-MM-DD` |

### 3. Inkoopaanvraag — `wvb_inkoopaanvraag`  ⟵ *de schrijf-actie*

Dit is het **doel van de schrijf-actie**. De agent maakt hier — en **alleen hier** —
een rij aan met **status `Concept`**. Primaire kolom: **`wvb_naam`**.

| Kolom (weergave) | Logische naam | Type | Toelichting |
|---|---|---|---|
| Naam | `wvb_naam` | Tekst | bv. `IA-2026-001` (primair) |
| Project | `wvb_project` | Tekst | bv. `De Beemster` |
| Materiaal/artikel | `wvb_materiaalartikel` | Tekst | artikelnr + naam |
| Aantal | `wvb_aantal` | Decimaal | gevraagde hoeveelheid |
| Eenheid | `wvb_eenheid` | Tekst | `st`, `m²`… |
| Status | `wvb_status` | Tekst | **altijd `Concept`** bij aanmaken door de agent |
| Toelichting | `wvb_toelichting` | Meerregelige tekst | onderbouwing + afweging (offerte-ID's) |
| Aangevraagd door | `wvb_aangevraagddoor` | Tekst | aanvrager (demo) |

## Voorbeelddata (fictief) — seed

Overgenomen uit [materialen-voorraad-fictief](../../voorbeelddata/materialen-voorraad-fictief.md)
en [offertes-leveranciers-fictief](../../voorbeelddata/offertes-leveranciers-fictief.md).
Artikelnummers zijn voor de demo toegevoegd.

**Materiaal**

| Naam | Artikelnr | Eenheid | Voorraad | Magazijn | Levertijd (wkn) | Nodig |
|---|---|---|---|---|---|---|
| Baksteen roodbruin genuanceerd | ART-BAK-001 | 1000 st | 24000 | Centraal | 2 | 60000 |
| Metselmortel | ART-MOR-002 | zak | 800 | Centraal | 1 | 650 |
| HR++ beglazing | ART-GLA-003 | m² | 0 | — | 4 | 210 |
| Hardhouten kozijn 1.800×2.400 | ART-KOZ-004 | st | 6 | Centraal | 5 | 12 |
| Beton C30/37 | ART-BET-005 | m³ | 0 | — | 0 | 140 |
| Wapeningsstaal | ART-WAP-006 | ton | 3 | Centraal | 1 | 2,4 |

**Offerte** (bedragen fictief)

| Offertenummer | Materiaal/artikel | Leverancier | Post | Bedrag | Levertijd | Raamcontract | Geldig tot |
|---|---|---|---|---|---|---|---|
| O-101 | ART-KOZ-004 Hardhouten kozijn | L01 Kozijnfabriek Noord | 12 kozijnen 1.800×2.400 | 18600 | 5 | Ja | 2026-07-31 |
| O-102 | ART-KOZ-004 Hardhouten kozijn | L02 HoutTech Kozijnen | 12 kozijnen 1.800×2.400 | 17200 | 8 | Nee | 2026-07-15 |
| O-201 | ART-BAK-001 Baksteen | L03 Metselbedrijf Zuid | Metselwerk gevel | 42000 | 0 | Nee | 2026-08-01 |

**Inkoopaanvraag** — het script maakt één verificatierij (`IA-2026-001`, status
*Concept*) zodat je ziet dat schrijven werkt; in de demo laat je de agent zelf een
aanvraag aanmaken.

## De schrijf-actie — contract & guardrails

Wat de agent-tool **"Maak concept-inkoopaanvraag"** mag doen:

- **Maakt** een record in `wvb_inkoopaanvraag` met **`wvb_status = "Concept"`**.
- Vult `wvb_naam`, `wvb_project`, `wvb_materiaalartikel`, `wvb_aantal`, `wvb_eenheid`
  en `wvb_toelichting` (afweging + reden, met offerte-ID's).
- **Alleen ná expliciete bevestiging** van de gebruiker in de chat (human-in-the-loop).
- **Nooit** een andere status dan `Concept`; **nooit** bestellen/gunnen; **nooit**
  bedragen verzinnen.

Zo blijft de mens eigenaar van de beslissing, terwijl de agent het voorwerk (de
concept-aanvraag) klaarzet.

## Klaarzetten — optie A: scriptbaar (aanbevolen)

Gebruik [scaffold-inkoop-dataverse.ps1](scaffold-inkoop-dataverse.ps1). Het script is
**idempotent** (veilig om opnieuw te draaien).

```powershell
# 1) Log met Azure CLI in op de TENANT van je doelomgeving:
az login --tenant <jouw-tenant>.onmicrosoft.com --allow-no-subscriptions

# 2) Draai het script tegen je org-URL:
./scaffold-inkoop-dataverse.ps1 -OrgUrl https://<jouw-org>.crm.dynamics.com/
```

> Het script haalt een token via `az account get-access-token` voor je org-URL. Zorg
> dus dat je met `az login` op de **juiste tenant** zit (de tenant van je Dataverse-
> omgeving).

## Klaarzetten — optie B: handmatig (maker-portal)

1. [make.powerapps.com](https://make.powerapps.com) → juiste **omgeving** →
   **Tabellen → Nieuwe tabel**.
2. Maak de drie tabellen met de kolommen uit de tabellen hierboven.
3. Voer de seed-rijen in (of importeer uit Excel).

## Wat is scriptbaar vs. UI?

| Onderdeel | Hoe |
|---|---|
| Tabellen, kolommen, **seed-data** | **Scriptbaar** — [scaffold-inkoop-dataverse.ps1](scaffold-inkoop-dataverse.ps1) (Dataverse Web API) |
| De **moderne agent** + de **tools** (lezen + de schrijf-actie) | **In de Copilot Studio-UI** — zie [runbook](inkoop-agent-runbook.md) |

> Moderne Copilot Studio-agents kennen **geen** ondersteunde `pac copilot push`
> round-trip; daarom bouw je de agent in de UI en borg je reproduceerbaarheid met de
> [runbook](inkoop-agent-runbook.md). De **Dataverse-kant** is wél volledig
> scriptbaar en dus herhaalbaar.

## Placeholders

Vul overal je eigen omgeving in (`<jouw-org>`, `<jouw-tenant>`, `<ENV_ID>`). Zet
**géén** echte org-URL's of tenant-/omgevings-ID's in deze (publieke) repo.
