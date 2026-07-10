# Stap 09 — Governance & adoptie

> **Resultaat van deze stap:** een *governance- & adoptieplan* dat borgt dat de
> agent verantwoord, compliant en daadwerkelijk gebruikt wordt.

## Doel

Een technisch werkende agent is niet genoeg. In de bouw gelden hoge eisen aan
betrouwbaarheid, aansprakelijkheid en regelgeving. Deze stap borgt drie dingen:
**verantwoorde AI**, **compliance** en **adoptie**.

## A. Verantwoorde AI

- **Bronvermelding verplicht** — elk inhoudelijk antwoord verwijst naar bestek,
  tekening of norm (document + hoofdstuk).
- **Mens-in-de-loop** — bij oordeels-, risico- en aansprakelijkheidsgevoelige
  stappen beslist een mens (zie autonomieniveau uit stap 06).
- **Geen hallucinaties** — de agent zegt *"niet gevonden in de bron"* i.p.v.
  gokken. Getest via negatieve tests (stap 08).
- **Transparantie** — gebruikers weten dat ze met een agent praten en wat hij
  wel/niet kan.
- **Logging** — vragen, antwoorden, bronnen en acties zijn herleidbaar.

## B. Compliance (bouwspecifiek)

> **Let op — geen juridisch advies.** Onderstaande is een checklist, geen
> uitputtende toets. Betrek een bevoegd persoon.

- **Regelgeving actueel houden** — Bbl/Bouwbesluit, NEN-normen en vergunningen
  wijzigen. Wie houdt de kennisbron actueel? Hoe vaak?
- **Revisiebeheer** — borg dat alleen actuele, geaccordeerde revisies van
  bestek/tekeningen worden gebruikt (grootste bouw-risico).
- **Aansprakelijkheid** — de agent adviseert; de verantwoordelijkheid blijft bij
  de WVB/organisatie. Leg dit vast.
- **Privacy (AVG)** — persoonsgegevens (medewerkers, onderaannemers) alleen waar
  nodig, met juiste grondslag en toegangsbeperking.
- **AI-regelgeving** — houd rekening met de EU AI Act (transparantie, risico).

## C. Adoptie

- **Betrek de WVB's vroeg** — laat ze meedenken over instructies en testset;
  eigenaarschap vergroot gebruik.
- **Training** — korte, praktijkgerichte uitleg: wat kan de agent, hoe stel je
  goede vragen, wanneer vertrouw je hem niet.
- **Feedbacklus** — maak het makkelijk om foute antwoorden te melden; voed dat
  terug in de verbeterlus (stap 08).
- **Impact meten** — meet tegen de succesmaat uit [stap 00](../00-context-en-ambitie/):
  bespaarde tijd, minder faalkosten, gebruikstevredenheid. Gebruik **Copilot Studio
  Analytics** + de **savings calculator**, en tenant-breed het **Viva Insights
  Copilot Studio agents report**.

**Adoptie-hefbomen (Microsoft, op impact-volgorde):** rol-gebaseerde training met
**managers/uitvoerders eerst**; anker de agent aan **één benoemde, hoog-volume taak**;
**zichtbaar voorbeeldgedrag** van leiding; een **gedeelde prompt-bibliotheek**;
**zichtbare guardrails**; en een **kwartaalritme** (90 dagen meten tegen baseline,
bespreken met de **sponsor**, dan schalen of stoppen).

**Waarde groeit in fasen:** dag 1–90 adoptie + efficiency · dag 91–1 jaar kwaliteit +
omzet · jaar 2+ strategische waarde. Zie
[best-practices/business-case.md](../../best-practices/business-case.md).

## D. Governance & ALM (Microsoft-platform)

Sluit aan op de Copilot Studio governance-guidance
([zoned governance](https://learn.microsoft.com/microsoft-copilot-studio/guidance/sec-gov-phase2),
[ALM](https://learn.microsoft.com/microsoft-copilot-studio/guidance/alm)):

- **Zoned governance** — kies de zone: Zone 1 (persoonlijk/read-only), **Zone 2
  (IT-begeleide makers — Copilot Studio, meestal hier)**, Zone 3 (pro-dev/enterprise).
- **3-omgevingen ALM** — dev → test → prod met **managed solutions**;
  **environment variables** + **connection references** voor omgevingsspecifieke config.
- **DLP & Purview** — data-loss-prevention op connectors; sensitivity labels + audit logs.
- **Toegang** — via **Entra ID-groepen** (niet individuen); **least privilege**;
  secrets in **Key Vault**.
- **Monitoring** — analytics + App Insights; gated approvals voor productie.

> Details en de "passen we ze toe?"-check:
> [best-practices/copilot-studio.md](../../best-practices/copilot-studio.md) en de
> [alignment-matrix](../../best-practices/microsoft-alignment.md).

## Invulvragen

1. Welke verantwoorde-AI-maatregelen zijn geborgd (bron, mens-in-de-loop, logging)?
2. Wie houdt kennisbronnen en regelgeving actueel, en hoe vaak?
3. Hoe is revisiebeheer geborgd?
4. Hoe wordt privacy/AVG afgedekt?
5. Wat is het adoptieplan (pilot, training, feedback)?
6. Welke KPI's meten de impact, en aan welke **waarde-driver** hangen ze?
7. Wie is de **sponsor** en met welke **cadans** worden de resultaten besproken?

## Valkuilen

- **Governance als sluitstuk.** Neem het mee vanaf stap 00, niet pas bij uitrol.
- **Geen eigenaar voor onderhoud.** Kennis veroudert; zonder eigenaar verslechtert
  de agent stilletjes.
- **Adoptie onderschat.** Een goede agent die niemand gebruikt levert niets op.

## Ingevuld referentievoorbeeld

Zie het governance- & adoptieplan in
[referentie/usecase-bestek/README.md](../../referentie/usecase-bestek/README.md#stap-09--governance).

---

🎉 Je hebt de blueprint doorlopen. Itereer terug naar
[stap 05](../05-usecase-prioritering/) voor de volgende use-case, en bekijk de
volledige rode draad in [referentie/](../../referentie/).
