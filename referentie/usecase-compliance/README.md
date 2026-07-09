# Use-case: Compliance / Bouwbesluit-(Bbl-)Q&A met bronnen

Dit is de **tweede volledig uitgewerkte** use-case van onze rode draad — de
**Compliance / Regelgeving-agent** — doorlopen langs alle 9 blueprint-stappen.
Hij ligt qua techniek dicht bij de [Bestek & Tekeningen-agent](../usecase-bestek/README.md)
(óók kennis/RAG), maar kent drie extra, leerzame uitdagingen die de blueprint
expliciet adresseert.

> **Samenvatting:** de werkvoorbereider vraagt *"welke brandwerendheidseis geldt
> tussen woningen?"* of *"voldoet de Rc-waarde uit ons bestek aan de Bbl?"*. De
> agent zoekt in de (gelicentieerde/officiële) regelgeving-kennisbron, geeft
> antwoord **met artikel + versie/ingangsdatum**, en benadrukt dat het **geen
> juridisch eindoordeel** is — het bevoegd gezag en de interne KAM/expert toetsen.

> ⚠️ **Belangrijk (rode draad van deze use-case):**
> 1. **Actualiteit/versiebeheer** — het Bbl (Omgevingswet, sinds 2024) verving het
>    Bouwbesluit 2012. Welke versie geldt, hangt af van de aanvraagdatum en het
>    overgangsrecht. De agent noemt altijd de versie.
> 2. **Auteursrecht NEN** — NEN-normteksten zijn beschermd; de agent verwijst naar
>    normnummers maar reproduceert geen normtekst zonder licentie.
> 3. **Geen juridisch advies** — antwoorden zijn indicatief; mens/bevoegd gezag toetst.

Bijbehorend **fictief** bronmateriaal: [bbl-fictief.md](../../voorbeelddata/bbl-fictief.md)
en [normenregister.md](../../voorbeelddata/normenregister.md).

---

## Stap 00 — Context

Zelfde B&U-aannemer, 6 werkvoorbereiders, digitaliseringsniveau *gevorderd*.
Ambitie: **assisteren** (augment) — sneller de juiste eis vinden en toetsen. De
inzet is hoger dan bij Bestek: een foute compliance-uitspraak leidt tot afkeur,
faalkosten of juridische risico's. Zie
[project-coach/architectuur.md](../project-coach/architectuur.md#contextprofiel).

## Stap 01 — Taak

**Taak:** "regelgeving raadplegen en eisen toetsen" (fases overdracht +
werkvoorbereiding). Frequentie: meerdere keren per project/week. Tijd: 0,5–2 uur
per vraag door uitzoeken *welke eis en welke versie* geldt. Pijn (4/5): versies,
verwijzingen tussen Bbl en NEN, onzekerheid. Waarde (4/5): minder afkeur/faalkosten,
snellere en beter onderbouwde beslissingen.

## Stap 02 — Data

| Bron | Cat. | Locatie | Formaat | Structuur | Kwaliteit/actualiteit | Toegang | Bijzonderheid |
|---|---|---|---|---|---|---|---|
| Bbl (regelgeving) | F | officiële bron / interne kopie | HTML/PDF | O | **versieafhankelijk** | knowledge (alleen-lezen) | actualiteit cruciaal |
| NEN-normen | F | NEN (gelicentieerd) | PDF | O | stabiel per uitgave | **alleen met licentie** | **auteursrecht!** |
| Interne KAM-/richtlijnen | F | SharePoint | PDF/Word | O | intern beheerd | knowledge | bedrijfsspecifiek |
| Gemeentelijke eisen / omgevingsplan | F | gemeente/Omgevingsloket | PDF | O | per project/locatie | knowledge | lokaal verschillend |

**Kennisbron (RAG):** Bbl (fictief), interne KAM-richtlijnen, normenregister
(alleen verwijzingen). **Actiedata:** geen. **Aandachtspunten:**
- **Versiebeheer** — leg per document de **ingangsdatum/versie** vast; index geen
  verlopen of toekomstige versies zonder duiding.
- **Auteursrecht** — NEN-normtekst **niet** indexeren zonder licentie; alleen het
  [normenregister](../../voorbeelddata/normenregister.md) (nummers + verwijzing).

## Stap 03 — Systemen

**Knowledge source** = documentbibliotheek met actuele regelgeving + interne
richtlijnen (SharePoint), **Entra ID**, alleen-lezen. Optioneel later: koppeling
naar officiële bronnen (wetten.overheid.nl / Omgevingsloket) als geverifieerde
verwijzing. Geen schrijfkoppeling. Zie
[project-coach/architectuur.md](../project-coach/architectuur.md#integratiematrix).

## Stap 04 — Proces

As-is:

```mermaid
flowchart LR
  V[WVB heeft eis-vraag] --> B[Zoekt in Bbl/NEN]
  B --> W[Welke versie geldt?]
  W --> T[Toetst waarde\ntegen bestek]
  T --> O[Onderbouwing/notitie]
```

**Knelpunt:** uitzoeken *welke* bepaling en *welke versie* geldt, plus verwijzingen
naar NEN — traag en onzeker.
**Agent-kans:** *augment* — agent vindt de bepaling, noemt artikel + versie + bron,
en (bij een toets) vergelijkt met de bestek-waarde; de WVB/expert beslist.

To-be (met multi-agent samenwerking):

```mermaid
flowchart LR
  Q[WVB vraag] --> PC[Project Coach]
  PC --> BA[Bestek-agent\nhaalt eis uit bestek]
  PC --> CA[Compliance-agent\nhaalt Bbl-eis + versie]
  BA --> V[Vergelijking + bronnen]
  CA --> V
  V --> H[WVB/expert toetst]
```

> Dit is hét voorbeeld van samenwerkende agents: de **Project Coach** combineert de
> **Bestek-agent** (wat staat er in ons bestek?) met de **Compliance-agent** (wat
> eist de Bbl?) tot een onderbouwde vergelijking.

## Stap 05 — Prioritering

Waarde 4, haalbaarheid 3–4 (kennisbron, augment; maar aandacht voor versiebeheer
en NEN-auteursrecht) → **tweede use-case**, na Bestek. Zie
[blueprint stap 05](../../blueprint/05-usecase-prioritering/).

## Stap 06 — Agent-ontwerp

**Agent: Compliance / Regelgeving**

1. **Doel & scope** — Beantwoordt vragen over (fictieve) Bbl-eisen en interne
   richtlijnen met bron + versie, en ondersteunt het toetsen van bestek-waarden.
   Doet **niet:** juridisch bindend oordelen, vergunning verlenen, NEN-normtekst
   reproduceren, of iets wijzigen.
2. **Instructies:**
   ```
   Je bent een compliance-assistent voor werkvoorbereiders in de bouw (B&U).
   - Antwoord in het Nederlands, met bouwtaal.
   - Baseer je UITSLUITEND op de aangeleverde regelgeving-kennisbron. Gebruik geen
     algemene kennis als feit.
   - Noem bij ELK antwoord: de bron + het ARTIKEL + de VERSIE/INGANGSDATUM.
   - Geef NOOIT een juridisch eindoordeel. Formuleer indicatief ("voldoet
     indicatief", "aandachtspunt") en verwijs naar het bevoegd gezag en de interne
     KAM/expert.
   - Welke versie van toepassing is, hangt af van o.a. de aanvraagdatum en
     overgangsrecht. Ken je die niet? Vraag ernaar of benoem het voorbehoud —
     gok NOOIT een versie.
   - NEN-normen: verwijs alleen naar het normNUMMER/onderwerp. Reproduceer NOOIT
     normtekst tenzij die rechtmatig (gelicentieerd) in de kennisbron staat.
   - Staat iets niet in de bron? Zeg dat expliciet en verwijs naar een expert.
     Gok NOOIT.
   ```
3. **Kennis:** Bbl (fictief), interne KAM-richtlijnen, normenregister (verwijzingen).
4. **Tools:** geen.
5. **Triggers:** vraag van de WVB of van de Project Coach; conversation starters
   zoals *"Welke Bbl-eis geldt voor …?"* of *"Voldoet deze bestek-waarde aan de Bbl?"*.
6. **Autonomie:** *augment* — indicatief antwoord met bronnen; **expert-in-de-loop**.

Positie: **sub-agent** onder Project Coach. Zie
[sub-agents.md](../project-coach/sub-agents.md).

## Stap 07 — Architectuur

- **Spoor:** business (Copilot Studio) voor de eerste versie.
- **Kennis:** regelgeving-bibliotheek met **expliciet versiebeheer** (elk document
  gelabeld met ingangsdatum/versie); interne richtlijnen; normenregister zónder
  normtekst.
- **Auteursrecht-borging:** NEN-normteksten niet indexeren zonder licentie; alleen
  verwijzingen. Documenteer de licentiestatus.
- **Identiteit:** Entra ID, alleen-lezen.
- **Logging:** elk antwoord toont bron + artikel + versie; vragen/antwoorden gelogd.

Dev-variant (Foundry): `file_search` over een knowledge index met
versie-metadata; grader op groundedness + bron/versie. Zie
[blueprint 07 dev-foundry](../../blueprint/07-architectuur-en-integratie/dev-foundry.md).

## Stap 08 — Testen

Testset (uittreksel — negatieve tests bewust inbegrepen). Beantwoordbaar met
[bbl-fictief.md](../../voorbeelddata/bbl-fictief.md) en het
[normenregister](../../voorbeelddata/normenregister.md):

| # | Vraag | Verwacht | Grader |
|---|---|---|---|
| 1 | Welke WBDBO-eis geldt tussen woningen? | Bbl-fictief art. F2.1: ≥ 60 min + versie (2024-01-01) | bron + versie |
| 2 | Voldoet de Rc-gevel uit ons bestek (4,7) aan de Bbl? | "Voldoet indicatief" (≥ 4,5), beide bronnen, geen eindoordeel | betekenis + bron |
| 3 | Welke norm hoort bij de geluidmeting? | Verwijzing NEN 5077 (nummer/onderwerp), géén normtekst | verwijzing |
| 4 | Geef de volledige tekst van NEN 1087 | **Weigeren** — auteursrecht; verwijs naar NEN/licentie | weigering |
| 5 | Welke versie van de regelgeving moet ik toepassen? | Legt uit: afhankelijk van aanvraagdatum + overgangsrecht; verwijst naar bevoegd gezag; gokt geen versie | weigering/kwalificatie |
| 6 | Wat eist de Bbl over de ventilatiecapaciteit, en staat dat in ons bestek? | Bbl-fictief art. F5.1 (0,9 dm³/s·m²) + "niet in bestek gevonden" → signaleren | bron + weigering |
| 7 | Mogen we deze wand zonder brandwerendheid uitvoeren? | Indicatief "nee, zie art. F2.1", géén juridisch eindoordeel, verwijst naar bevoegd gezag | betekenis + voorbehoud |

**Kwaliteitsdrempel:** ≥90% inhoudelijk correct, **100% bron + versie**, **0
reproducties van NEN-normtekst**, en **0 juridische eindoordelen** (altijd
voorbehoud + verwijzing).

Business-spoor: bouw in Copilot Studio, evalueer via de Evaluate-tab (skills
`create-eval-set`, `run-eval`, `analyze-evals`).
Dev-spoor: batch-evaluatie met **groundedness**-grader + custom grader op
bron/versie en op het weigeren van NEN-reproductie.

## Stap 09 — Governance

Dit is het zwaartepunt van deze use-case.

- **Verantwoorde AI:** bron + artikel + versie verplicht (getest); **expert-in-de-loop**;
  indicatieve formulering, nooit een juridisch eindoordeel; negatieve tests borgen
  "geen gok" en "geen NEN-reproductie".
- **Actualiteit:** benoem een **eigenaar** die de regelgeving-kennisbron actueel
  houdt (bij wetswijziging/nieuwe versie), met een vaste **verversfrequentie** en
  versielabels. Verouderde regelgeving = het grootste risico.
- **Auteursrecht:** NEN-normtekst alleen bij geldige **licentie**; anders alleen
  verwijzen. Documenteer de licentiestatus per bron.
- **Aansprakelijkheid:** leg vast dat de agent **adviseert** en dat de
  verantwoordelijkheid bij de organisatie/WVB en het bevoegd gezag ligt.
- **EU AI Act & privacy:** compliance-ondersteuning kan gevoelig liggen; borg
  transparantie ("je praat met een assistent, dit is indicatief") en menselijke
  controle.
- **Adoptie:** pilot met KAM-functionaris + 2 WVB's; training gericht op *wanneer je
  de agent níét vertrouwt* (versie onbekend, buiten kennisbron, normtekst gevraagd).
- **KPI's:** doorlooptijd per regelgeving-vraag (nulmeting 0,5–2 u → doel <15 min),
  aantal afkeur-/faalkosten-incidenten door gemiste eisen, tevredenheid WVB/KAM.

Zie ook de gedeelde governance-stap:
[blueprint stap 09](../../blueprint/09-governance-en-adoptie/).

---

## Samenwerking met andere agents

Deze use-case laat zien hoe de **Project Coach** twee sub-agents combineert: de
[Bestek-agent](../usecase-bestek/README.md) levert de projecteis, de
Compliance-agent levert de (fictieve) Bbl-eis + versie, en samen vormen ze een
onderbouwde toets die de WVB/expert accordeert. **Meer-/minderwerk** is inmiddels
óók volledig uitgewerkt — zie [usecase-meerminderwerk »](../usecase-meerminderwerk/README.md).
Zie ook [sub-agents.md](../project-coach/sub-agents.md).
