# Data-design — kennis (RAG) en Dataverse

Goede data-design bepaalt de kwaliteit van elke agent. Bronnen:
[RAG in Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/guidance/retrieval-augmented-generation) ·
[Knowledge](https://learn.microsoft.com/microsoft-copilot-studio/knowledge-copilot-studio) ·
[Well-Architected](https://aka.ms/powa).

> **Laatst getoetst:** 2026-07-10.

## Kennisbron kiezen (ongestructureerd → RAG)

| Bron | Wanneer | Aandachtspunten |
|---|---|---|
| **SharePoint / OneDrive** | Documentkennis (bestek, normen, richtlijnen) | Entra ID delegated; **security-trimming**; bestand ≤ 15 MB (200 MB met Enhanced Search) |
| **Geüploade bestanden** | Losse PDF's/Office | ≤ 512 MB, max 500 bestanden/agent; opgeslagen in Dataverse |
| **Publieke website** | Openbare info | Moet door Bing geïndexeerd zijn |
| **Copilot connectors** (Graph) | Non-Microsoft kennis **indexeren** | Respecteert bronpermissies |
| **Power Platform connectors** | **Real-time** data (geen replicatie) | Live API, ideaal voor actuele records/transacties |

Kernregels:
- **Relevantie boven kwantiteit** — voeg alleen bronnen toe die vragen echt helpen.
- **Freshness & ownership** — leg eigenaar + verversfrequentie vast; vermijd
  **tegenstrijdige** bronnen (dubbele versies van een beleid/tekening).
- **Revisiebeheer** — index alleen actuele, geaccordeerde versies (cruciaal in de bouw).
- **Citations** — toon de bron; onze kennis-agents doen dit verplicht.

## Dataverse als kennis (gestructureerd)

Bron: [Improve copilot responses from Dataverse](https://learn.microsoft.com/power-apps/maker/data-platform/data-platform-copilot).

- Max **15 Dataverse-tabellen** als kennis; verrijk met **synonyms** en een
  **glossary** (bv. "gesloten lead", of in de bouw: "WBDBO", "Rc-waarde", "stelpost").
- Natuurlijke-taalvragen worden vertaald naar queries over de records.
- **Field Service / Project Operations** draaien op Dataverse → sterke koppeling voor
  onze actie-agents (Planning & Capaciteit, Inkoop & Materialen, Oplever, Mensen-service).

## Chunking & retrieval (achtergrond)

Bron: [RAG chunking](https://learn.microsoft.com/azure/architecture/ai-ml/guide/rag/rag-chunking-phase) ·
[RAG in Azure AI Search](https://learn.microsoft.com/azure/search/retrieval-augmented-generation-overview).

- Te grote chunks → tokenlimiet/ruis; te kleine → missende context. Kies chunking op
  documentstructuur.
- **Hybride** (keyword + vector) + **semantic ranking** geeft de beste recall.

## Datamodel-design (Well-Architected)

- **Least privilege** en data-classificatie; gevoelige velden (prijzen, persoons-
  gegevens) afschermen of tokeniseren.
- **Environment variables + connection references** voor omgevingsspecifieke config.
- Respecteer **rij-/kolombeveiliging** van Dataverse; laat de agent via platform­context
  ophalen, niet met een breed service-account.

## Toegepast in de blueprint

- [Stap 02 — Data](../blueprint/02-data-inventarisatie/): 8 datacategorieën,
  gestructureerd vs. ongestructureerd, gevoeligheid.
- De mock-datasets in [voorbeelddata/](../voorbeelddata/) bootsen FS/PO na; in de demo
  vervang je ze door echte (gelicentieerde/geautoriseerde) bronnen.
