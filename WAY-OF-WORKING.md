# De werkwijze — van blueprint naar werkende werkvoorbereidingsagent

Deze repo is een **herhaalbare werkwijze** (blueprint) waarmee **bijna elk
Nederlands bouwbedrijf** een eigen werkvoorbereidingsagent kan ontwerpen en bouwen.
De blueprint is **generiek**; **consultants** en makers passen hem per bedrijf aan.

> **Kernidee:** ontwerp op **domein/uitkomst** (jobs-to-be-done), niet op techniek.
> Volg de 9 stappen, gebruik de referentie-agent als voorbeeld, en toets je ontwerp
> tegen de [best practices](best-practices/README.md).

---

## Prototype eerst, ontwerp vóór je opschaalt

Microsoft's guidance is helder: **niet elke agent vraagt vooraf zwaar ontwerp**,
maar zodra een agent **data raakt, acties uitvoert, meerdere teams betreft of moet
schalen/voldoen aan governance**, gebruik je een gestructureerd ontwerp. Een
werkvoorbereidingsagent valt in die categorie. Bron:
[Design effective agents using a structured design framework](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-design-canvas-overview).

De balans:
1. **Prototype snel** om haalbaarheid en gedrag te leren.
2. **Pauzeer en ontwerp bewust** vóór je opschaalt of automatiseert.

---

## Onze 9 stappen ↔ Microsoft Agent Design Canvas

Onze blueprint dekt alle **10 bouwstenen** van het officiële
[Agent Design Framework](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-design-canvas-framework):

| Microsoft-bouwsteen | Onze stap(pen) |
|---|---|
| **Goal** (jobs-to-be-done) | [00 Context & ambitie](blueprint/00-context-en-ambitie/) |
| **Triggers** | [06 Agent-ontwerp](blueprint/06-agent-ontwerp/) |
| **Tools & integrations** | [03 Systemen](blueprint/03-systeem-inventarisatie/) + [06](blueprint/06-agent-ontwerp/)/[07](blueprint/07-architectuur-en-integratie/) |
| **Channels** | [06](blueprint/06-agent-ontwerp/) / [07](blueprint/07-architectuur-en-integratie/) |
| **Knowledge & data** | [02 Data](blueprint/02-data-inventarisatie/) (+ [data-design](best-practices/data-design.md)) |
| **Flows & orchestration** (human-in-the-loop) | [04 Proces](blueprint/04-proces-mapping/) + [06](blueprint/06-agent-ontwerp/) |
| **Instructions & behavior** | [06](blueprint/06-agent-ontwerp/) via [ROCKET](referentie/rocket-principe.md) |
| **Agent architecture & composition** | [referentie/architectuur](referentie/project-coach/architectuur.md) |
| **Governance & risk** | [09 Governance](blueprint/09-governance-en-adoptie/) |
| **Evaluation & optimization** | [08 Bouwen & testen](blueprint/08-bouwen-en-testen/) |

---

## Generiek toepasbaar — en toch bedrijfsspecifiek

De blueprint werkt generiek doordat hij op **domeinen** is ontworpen die elke
bouwer herkent: bestek, compliance, inkoop & materiaal, planning & capaciteit,
meer-/minderwerk, oplevering. Wat een **consultant per bedrijf aanpast**:

| Aanpasbaar per bedrijf | Waar |
|---|---|
| Segment (B&U-woning/utiliteit, GWW, installatie, onderhoud) | [00 Context](blueprint/00-context-en-ambitie/) |
| Data-/kennisbronnen (welke SharePoint, bestek-systematiek) | [02 Data](blueprint/02-data-inventarisatie/) |
| Systemen (ERP, planning, BIM; Field Service / Project Operations) | [03 Systemen](blueprint/03-systeem-inventarisatie/) |
| Terminologie & synoniemen (glossary voor Dataverse-kennis) | [data-design](best-practices/data-design.md) |
| Welke sub-agents wel/niet (scope) | [decompositie-verantwoording](referentie/project-coach/architectuur.md#decompositie-verantwoording) |
| Governance-zone & drempels | [09 Governance](blueprint/09-governance-en-adoptie/) |

Zie de **[consultant-customisatiegids](best-practices/construction-industry.md#consultant-customisatiegids)**.

---

## Toets je ontwerp

Voordat je bouwt of oplevert, loop je de [best practices](best-practices/README.md)
langs — met de [Microsoft-alignment-matrix](best-practices/microsoft-alignment.md)
zie je in één oogopslag of je ontwerp actueel en compleet is.

> **Laatst getoetst aan Microsoft Learn:** 2026-07-10.
