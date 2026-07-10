# Microsoft-alignment — passen we de best practices toe?

Deze matrix toetst de blueprint tegen de officiële Microsoft-guidance. Status:
✅ toegepast · 🟡 deels · ➕ toegevoegd in deze ronde.

> **Laatst getoetst:** 2026-07-10 (Copilot Studio guidance hub, actueel t/m juni 2026).

## Agent Design Framework (10 bouwstenen)

Bron: [Agent Design Framework](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-design-canvas-framework).

| Bouwsteen | Best practice | Waar in de repo | Status |
|---|---|---|---|
| Goal | Jobs-To-Be-Done, meetbaar succes | [stap 00](../blueprint/00-context-en-ambitie/) | ➕ JTBD toegevoegd |
| Triggers | Expliciete trigger per agent | [stap 06](../blueprint/06-agent-ontwerp/) + template | ➕ toegevoegd |
| Tools & integrations | Least privilege, fallback, audit | [stap 03](../blueprint/03-systeem-inventarisatie/)/[07](../blueprint/07-architectuur-en-integratie/) | ✅ |
| Channels | Meet de gebruiker waar hij werkt | [stap 06](../blueprint/06-agent-ontwerp/)/[07](../blueprint/07-architectuur-en-integratie/) | ➕ toegevoegd |
| Knowledge & data | Freshness, security-trimming, structured vs unstructured | [stap 02](../blueprint/02-data-inventarisatie/) + [data-design](data-design.md) | ✅ |
| Flows & orchestration | Human-in-the-loop bij high-impact | augment→automate in alle use-cases | ✅ |
| Instructions & behavior | Rol, sequenced, "must not do" | [ROCKET](../referentie/rocket-principe.md) | ✅ (verrijkt) |
| Agent architecture | Splits op domein, niet per systeem | [decompositie-verantwoording](../referentie/project-coach/architectuur.md#decompositie-verantwoording) | ✅ |
| Governance & risk | Access, guardrails, logging, owner | [stap 09](../blueprint/09-governance-en-adoptie/) | ✅ (verrijkt) |
| Evaluation & optimization | Evalueer als ontwerp, negatieve tests | [stap 08](../blueprint/08-bouwen-en-testen/) | ✅ |

## Business case & planning (ROI)

Bron: [Plan your Copilot Studio projects](https://learn.microsoft.com/microsoft-copilot-studio/guidance/plan-overview) ·
[Measure ROI & business value](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-business-value-overview).

| Best practice | Waar in de repo | Status |
|---|---|---|
| Definieer waarde vóór je bouwt (discovery-vragen) | [stap 00](../blueprint/00-context-en-ambitie/) + [business-case](business-case.md) | ➕ |
| Vier waarde-drivers (efficiency/quality/revenue/strategic) | [business-case](business-case.md) | ➕ |
| Cross-functioneel team + benoemde sponsor | [business-case](business-case.md) + tool-rolbadges | ➕ |
| Prioriteer risico's + workarounds | [stap 05](../blueprint/05-usecase-prioritering/) | ➕ |
| Baseline vastleggen (FTE × uren × tarief) vóór go-live | [stap 00](../blueprint/00-context-en-ambitie/) + [business-case](business-case.md) | ➕ |
| Adoptie-hefbomen (managers eerst, ankertaak, sponsor-cadans) | [stap 09](../blueprint/09-governance-en-adoptie/) + [business-case](business-case.md) | ➕ |
| Meten: Analytics + savings calculator + Viva Insights | [stap 09](../blueprint/09-governance-en-adoptie/) | ➕ |

## Multi-agent orchestration

Bron: [Multi-agent orchestration patterns](https://learn.microsoft.com/microsoft-copilot-studio/guidance/multi-agent-patterns).

| Best practice | Waar | Status |
|---|---|---|
| Single-response principle (alleen parent antwoordt) | [multi-agent-orchestration](multi-agent-orchestration.md) + Project Coach-instructie | ➕ |
| Subagent verklaart zijn rol ("antwoord niet direct") | idem | ➕ |
| Strakke directive taal (MUST/NEVER/ONLY) | [ROCKET](../referentie/rocket-principe.md) | ✅ |
| 1 kennisbron per sub-agent, geen overlap | [decompositie-verantwoording](../referentie/project-coach/architectuur.md#decompositie-verantwoording) (Materialen+Inkoop samengevoegd) | ✅ |
| Distinct, niet-overlappende descriptions | idem | ✅ |
| Splits pas bij >30–40 tools / degradatie | 6 kern + service | ✅ |
| Test met domain-mismatch | negatieve tests in elke use-case | ✅ |

## RAG / kennis

Bron: [RAG in Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/guidance/retrieval-augmented-generation) ·
[Knowledge](https://learn.microsoft.com/microsoft-copilot-studio/knowledge-copilot-studio).

| Best practice | Waar | Status |
|---|---|---|
| Relevance over quantity | [data-design](data-design.md) | ✅ |
| Freshness/ownership/refresh + revisiebeheer | [stap 02](../blueprint/02-data-inventarisatie/) + bestek-use-case | ✅ |
| Security-trimming / permissies | [stap 07](../blueprint/07-architectuur-en-integratie/) | ✅ |
| Dataverse-kennis: synonyms + glossary (max 15 tabellen) | [data-design](data-design.md) | ➕ |
| Citations / bronvermelding verplicht | alle kennis-use-cases | ✅ |

## Governance / ALM / security

Bron: [Zoned governance](https://learn.microsoft.com/microsoft-copilot-studio/guidance/sec-gov-phase2) ·
[ALM](https://learn.microsoft.com/microsoft-copilot-studio/guidance/alm) ·
[Manage checklist](https://learn.microsoft.com/microsoft-copilot-studio/guidance/manage-checklist).

| Best practice | Waar | Status |
|---|---|---|
| Zoned governance (Zone 1/2/3) | [stap 09](../blueprint/09-governance-en-adoptie/) | ➕ |
| 3-omgevingen ALM (dev/test/prod) + solutions + env variables | [stap 09](../blueprint/09-governance-en-adoptie/) | ➕ |
| DLP + Purview (sensitivity labels, audit) | [stap 09](../blueprint/09-governance-en-adoptie/) | ➕ |
| Entra ID-groepen i.p.v. individuen; least privilege; Key Vault | [stap 09](../blueprint/09-governance-en-adoptie/) | ➕ |
| Responses niet auto-committen; mens bevestigt schrijfacties | augment→automate (alle actie-agents) | ✅ |

## Evaluation

Bron: [Evaluate an agent](https://learn.microsoft.com/microsoft-copilot-studio/agents-experience/analytics-agent-evaluation-intro) ·
[metrics](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-business-value-metrics-reference).

| Best practice | Waar | Status |
|---|---|---|
| 3 testmethodes (text match / similarity / quality-groundedness) | [stap 08](../blueprint/08-bouwen-en-testen/) | ➕ |
| Evalueer vóór publish; baseline/regressie/multiturn | [stap 08](../blueprint/08-bouwen-en-testen/) | ✅ |
| Metrics: groundedness, instruction-following, citation accuracy | [stap 08](../blueprint/08-bouwen-en-testen/) | ➕ |
| Negatieve tests (out-of-source, geen gok) | elke use-case | ✅ |
