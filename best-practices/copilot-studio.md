# Copilot Studio — best practices (samengevat)

Actuele best practices uit de [Copilot Studio guidance hub](https://learn.microsoft.com/microsoft-copilot-studio/guidance/overview),
met per onderwerp **hoe wij ze toepassen**.

> **Laatst getoetst:** 2026-07-10.

## Instructies (generative orchestration)

Bron: [Configure high-quality instructions](https://learn.microsoft.com/microsoft-copilot-studio/guidance/generative-mode-guidance) ·
[Write agent instructions](https://learn.microsoft.com/microsoft-copilot-studio/authoring-instructions).

- Verwijs alleen naar tools/kennis die de agent **echt heeft**; gebruik **exacte
  toolnamen** (namen wegen zwaarder dan beschrijvingen).
- **Beschrijf kennisbronnen generiek** — noem ze niet hard op (voorkomt foute info).
- Specificeer **responsformat** (lijst/tabel) en **stijl** ("beknopt", "met bronnen").
- Definieer de **volgorde van acties** bij multistep; voeg expliciet **"must not do"** toe.
- Behandel instructies **als code**: bouw ze incrementeel op en test tussendoor.

→ Wij vatten dit in het [ROCKET-principe](../referentie/rocket-principe.md).

## Kennis & RAG

Bron: [RAG](https://learn.microsoft.com/microsoft-copilot-studio/guidance/retrieval-augmented-generation) ·
[Knowledge](https://learn.microsoft.com/microsoft-copilot-studio/knowledge-copilot-studio) ·
[Connectors: index vs real-time](https://learn.microsoft.com/microsoft-copilot-studio/knowledge-graph-vs-power-platform-connectors).

- **Relevantie boven kwantiteit**; borg **freshness/ownership** en revisiebeheer.
- **Security-trimming**: alleen content die de gebruiker mag zien.
- **SharePoint** voor documentkennis; **Dataverse** voor gestructureerde records
  (met synonyms + glossary, max 15 tabellen). Details: [data-design](data-design.md).

## Tools & acties

Bron: [Agent tools](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-tools) ·
[Well-Architected](https://aka.ms/powa).

- **Least privilege**, valideer tool-output, definieer **fallback**; **audit** elke actie.
- **Responses committen niet automatisch** — de gebruiker bevestigt schrijfacties.

→ Wij borgen dit met de *augment→automate*-ladder + mens-in-de-loop in elke actie-agent.

## Multi-agent

Bron: [Multi-agent patterns](https://learn.microsoft.com/microsoft-copilot-studio/guidance/multi-agent-patterns) ·
[Add other agents](https://learn.microsoft.com/microsoft-copilot-studio/authoring-add-other-agents).

- Start met één agent; **splits pas bij een echt apart domein/governance/herbruik**,
  of bij **>30–40 tools**. Zie [multi-agent-orchestration](multi-agent-orchestration.md).

## Evaluatie

Bron: [Evaluate an agent](https://learn.microsoft.com/microsoft-copilot-studio/agents-experience/analytics-agent-evaluation-intro).

- **Evalueer vóór publiceren**; drie testmethodes (text match, similarity,
  quality/groundedness); baseline + regressie; negatieve tests; tool-use-kwaliteit.

## Governance & ALM

Bron: [Security & governance](https://learn.microsoft.com/microsoft-copilot-studio/security-and-governance) ·
[Zoned governance](https://learn.microsoft.com/microsoft-copilot-studio/guidance/sec-gov-phase2) ·
[ALM](https://learn.microsoft.com/microsoft-copilot-studio/guidance/alm).

- **Zoned governance** (Zone 1/2/3), **3-omgevingen ALM** (dev/test/prod) met
  solutions + environment variables + connection references; **DLP** en **Purview**;
  toegang via **Entra ID-groepen**; monitoring via analytics/App Insights.

> **Let op (deze demo-omgeving):** moderne Copilot Studio-agents round-trippen niet
> betrouwbaar via `pac copilot push` — bouw moderne agents via de **UI**; gebruik
> solutions voor promotie tussen omgevingen.
