# 🟩 Dev-spoor — Architectuur & integratie in Foundry

## Kennis (RAG)

- Bouw een **knowledge index** over bestek/tekeningen/normen (file search).
- Indexeer **alleen actuele, geaccordeerde revisies**; automatiseer het
  verversen bij een nieuwe revisie.
- Houd gevoelige documenten in een aparte, niet-geïndexeerde store.

## Tools / koppelingen

| Systeem | Tool-type |
|---|---|
| Systeem met REST-API | **OpenAPI-tool** |
| Tool die MCP spreekt | **MCP-tool** |
| Eigen logica | **function tool** (code) |
| Dataverse / Power Platform | via connector-/MCP-brug |

## Identiteit & security

- Gebruik **managed identity** / Entra ID voor service-naar-service auth.
- **Least privilege:** scope de rechten per tool tot de use-case.
- Leg secrets in een **Key Vault**, nooit in `agent.yaml` of in de repo
  (zie `.gitignore`).
- Schakel **tracing/logging** in zodat elk antwoord en elke tool-call herleidbaar
  is (voedt evaluatie in stap 08 en governance in stap 09).

## Architectuur als code

- Elke agent = `agent.yaml` in [referentie/project-coach/](../../referentie/project-coach/).
- Infra en deployment via `azd` (zie skill **microsoft-foundry**).
- Versioneer prompts, tools en indices; behandel wijzigingen als PR's.

## Verwijzingen
- Foundry-architectuur & tools: <https://learn.microsoft.com/azure/ai-foundry/>
- Skill: `microsoft-foundry` (knowledge index, tools, RBAC, deploy)

➡️ Verder naar [stap 08 — Bouwen & testen »](../08-bouwen-en-testen/dev-foundry.md)
