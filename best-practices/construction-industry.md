# Bouwsector — standaarden, best practices & consultant-customisatie

Waarom de blueprint **generiek werkt voor bijna elk Nederlands bouwbedrijf**, welke
branche-standaarden je benut, en hoe een **consultant** hem per bedrijf aanpast.

> **Illustratief, geen normatief advies.** Standaarden en regelgeving toetsen door
> een bevoegd persoon. **Laatst getoetst:** 2026-07-10.

## Branche-standaarden om op te bouwen

| Standaard | Waarvoor | Relevantie voor de agent |
|---|---|---|
| **STABU** (B&U) / **RAW–CROW** (GWW) | Bestek-systematiek | Structuur voor de Bestek-agent (hoofdstukken/posten) |
| **NL-SfB / CB-NL** | Classificatie bouwdelen | Consistente terminologie/glossary |
| **BIM basis ILS** | Informatie-leverings­specificatie | Kwaliteit/consistentie van modeldata |
| **ISO 19650** | BIM-informatiemanagement, **CDE** | Single source of truth voor documenten |
| **Ketenstandaard / DICO (SALES/ORDERS)** | Digitale uitwisseling inkoop/orders | Basis voor Inkoop & Materialen-koppelingen |
| **Bbl / NEN** | Bouwregelgeving/normen | Compliance-agent (met bron + versie) |
| **Lean / Last Planner, ketensamenwerking** | Planning & samenwerking | Planning & Capaciteit; voorspelbaarder plannen |

**Rode draad:** standaardiseer op één **single source of truth** (CDE/SharePoint/
Dataverse), zodat agents betrouwbare, actuele data gebruiken.

## Waarom generiek toepasbaar

De sub-agents zijn ontworpen op **domeinen die elke bouwer herkent** — bestek,
compliance, inkoop & materiaal, planning & capaciteit, meer-/minderwerk, oplevering —
niet op één bedrijf of systeem. De *methodiek* (stap 00–09) is bedrijfsonafhankelijk;
alleen de **inhoud** (data, systemen, terminologie, drempels) verschilt.

## Consultant-customisatiegids

Wat je **per bedrijf** aanpast (en waar):

1. **Segment & scope** — B&U-woning/utiliteit, GWW, installatie, onderhoud. Bepaalt
   welke sub-agents relevant zijn. → [stap 00](../blueprint/00-context-en-ambitie/) +
   [decompositie-verantwoording](../referentie/project-coach/architectuur.md#decompositie-verantwoording).
2. **Data-/kennisbronnen** — welke SharePoint-sites, bestek-systematiek (STABU/RAW),
   normen-licenties. → [stap 02](../blueprint/02-data-inventarisatie/) + [data-design](data-design.md).
3. **Systemen** — ERP (4PS/Metacom/Bouw7…), planning (MS Project/Primavera/KYP),
   BIM, en **Field Service / Project Operations** waar aanwezig. → [stap 03](../blueprint/03-systeem-inventarisatie/).
4. **Terminologie & synoniemen** — vul de **glossary** voor Dataverse-kennis met
   bedrijfs-/vakbegrippen (WBDBO, Rc, stelpost, meer-/minderwerk). → [data-design](data-design.md).
5. **Governance-zone & autonomie** — kies de [zone](../blueprint/09-governance-en-adoptie/)
   en de augment/automate-drempels per actie-agent.
6. **Succesmaat & KPI's** — stem af op de business (uren, faalkosten, doorlooptijd).
   → [stap 00](../blueprint/00-context-en-ambitie/) + [stap 09](../blueprint/09-governance-en-adoptie/).
7. **Merk & kanaal** — naam, conversation starters, Teams/kanaalkeuze. → [stap 06/07](../blueprint/06-agent-ontwerp/).
8. **Toon & doelgroep** — schrijf voor bouwvakkennis en houd de toon collegiaal en
   praktisch (geen managementtaal). → [WAY-OF-WORKING.md](../WAY-OF-WORKING.md#doelgroep--toon).

> **Aanpak:** begin met **één** hoog-waarde use-case (vaak Bestek of Compliance),
> bewijs de waarde, en breid daarna uit — precies de *prototype-first, design-before-
> scaling*-lijn uit de [werkwijze](../WAY-OF-WORKING.md).

## Bouwspecifieke valkuilen (borgen in het ontwerp)

- **Verouderde revisie** van bestek/tekening als waarheid → revisiebeheer in [stap 07](../blueprint/07-architectuur-en-integratie/).
- **Normtekst-auteursrecht (NEN)** → alleen verwijzen, niet reproduceren; zie de
  [compliance-use-case](../referentie/usecase-compliance/README.md).
- **Financiële gevoeligheid** (offertes/meer-minderwerk) → geen bedragen verzinnen;
  mens gunt/stelt vast.
