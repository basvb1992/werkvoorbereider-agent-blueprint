# 🟦 Business-spoor — Architectuur & integratie in Copilot Studio

## Kennisbronnen koppelen

| Bron in de bouw | Copilot Studio knowledge |
|---|---|
| Bestek / tekeningen (PDF) | SharePoint-site of geüploade bestanden |
| Normen / interne richtlijnen | SharePoint of publieke website |
| Gestructureerde projectdata | Dataverse-tabellen |

- Koppel **alleen de projectmap met actuele, geaccordeerde revisies**.
- Zet gevoelige mappen (prijzen, contracten) **niet** als knowledge source.

## Acties koppelen

| Systeem | Bouwsteen |
|---|---|
| 4PS Construct (Dynamics 365) | Dataverse-tools / Dataverse-connector |
| Overige systemen met API | Power Platform-connector of **custom connector** |
| Tools die MCP spreken | **MCP-tool** |
| Automatiseringen | **Power Automate flow** als tool |

## Security & governance

- **Identiteit:** de agent draait onder Entra ID; authenticatie kan
  *end-user* (agent handelt namens de gebruiker, respecteert diens rechten) of
  via een service-verbinding. Kies end-user waar mogelijk voor least privilege.
- **DLP-beleid** van je Power Platform-omgeving beperkt welke connectors samen
  gebruikt mogen worden — stem dit af met je Power Platform-beheerder.
- **Omgevingen (environments):** ontwikkel in een test-/dev-omgeving, promoveer
  via solutions naar productie.

## Praktijk-let op (ALM van moderne agents)

> **Moderne Copilot Studio-agents round-trippen niet betrouwbaar via `pac copilot
> push`.** Behandel de Copilot Studio UI als de bron van waarheid voor het
> agent-ontwerp. Gebruik solutions voor promotie tussen omgevingen, en de CLI
> voor inspectie/clone — niet voor het terugschrijven van gewijzigde moderne agents.

## Verwijzingen
- Knowledge sources: <https://learn.microsoft.com/microsoft-copilot-studio/knowledge-copilot-studio>
- Tools/acties: <https://learn.microsoft.com/microsoft-copilot-studio/advanced-plugin-actions>
- DLP & environments: <https://learn.microsoft.com/power-platform/admin/wp-data-loss-prevention>

➡️ Verder naar [stap 08 — Bouwen & testen »](../08-bouwen-en-testen/business-copilot-studio.md)
