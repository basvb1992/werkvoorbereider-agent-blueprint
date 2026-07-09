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
  bespaarde tijd, minder faalkosten, gebruikstevredenheid.

## Invulvragen

1. Welke verantwoorde-AI-maatregelen zijn geborgd (bron, mens-in-de-loop, logging)?
2. Wie houdt kennisbronnen en regelgeving actueel, en hoe vaak?
3. Hoe is revisiebeheer geborgd?
4. Hoe wordt privacy/AVG afgedekt?
5. Wat is het adoptieplan (pilot, training, feedback)?
6. Welke KPI's meten de impact?

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
