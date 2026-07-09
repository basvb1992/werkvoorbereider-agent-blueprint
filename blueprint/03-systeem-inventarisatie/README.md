# Stap 03 — Systeem-inventarisatie

> **Resultaat van deze stap:** een *systeem-/integratiematrix* die per systeem
> vastlegt hoe (en of) een agent ermee kan koppelen.

## Doel

Bepaal met welke systemen de agent moet praten en — belangrijker — *hoe*.
De integratievorm bepaalt of de agent kan **lezen**, **schrijven** of alleen
**interpreteren** (via geëxporteerde bestanden). Dit stuurt direct
[stap 06](../06-agent-ontwerp/) en [stap 07](../07-architectuur-en-integratie/).

## Systemen in de Nederlandse bouwpraktijk

| Domein | Voorbeeldsystemen |
|---|---|
| ERP / bouwadministratie | 4PS Construct (Dynamics 365), Metacom, Bouw7, Syntess |
| Calculatie | IBIS-TRAD / IBIS 4All, Cordel, KUBUS |
| Planning | MS Project, Primavera P6, Asta Powerproject, KYP Project |
| BIM / CAD | Revit, Navisworks, Solibri, Tekla, Stabicad |
| Bouwplaats / DMS | Dalux, Ed Controls, Snagstream, Bouwapp, Relatics |
| Field service & projecten (Dataverse) | **Dynamics 365 Field Service**, **Dynamics 365 Project Operations** |
| Kantoor | Microsoft 365 (Excel, Outlook, SharePoint, Teams) |

> **Dynamics 365 op Dataverse:** Field Service (werkorders, resources, voorraad,
> assets) en Project Operations (projecten, WBS, budget, change orders) draaien op
> **Dataverse** en zijn daardoor sterk koppelbaar aan Copilot Studio-agents — ideaal
> voor de *actie*-agents (Planning, Mensen, Materialen, Oplever). Zie de
> [agent-skeletons](../../referentie/agent-skeletons/README.md).

## Integratievormen (van sterk naar zwak gekoppeld)

| Vorm | Wat het betekent | Agent kan | Microsoft-bouwsteen |
|---|---|---|---|
| **API / Connector** | Systeem biedt een programmatische koppeling | Lezen én schrijven, real-time | [Power Platform connector](https://learn.microsoft.com/connectors/), custom connector |
| **MCP-server** | Systeem/tool spreekt Model Context Protocol | Lezen/acties via tools | MCP-tool in Copilot Studio / Foundry |
| **Dataverse** | Data staat (ook) in Dataverse | Lezen/schrijven | Native Dataverse-koppeling |
| **Bestandsexport** | Alleen export (Excel/PDF/IFC) | Interpreteren (kennisbron) | Bestand als knowledge source |
| **Geen koppeling** | Handmatig knippen/plakken | Niets automatisch | — |

> **Tip:** 4PS Construct draait op Dynamics 365/Dataverse — vaak goed koppelbaar.
> Veel calculatie- en BIM-tools bieden alleen export → geschikt als kennisbron,
> niet voor acties.

## Invulvragen (per systeem)

1. **Systeem** — Naam + functie.
2. **Data erin** — Welke data uit [stap 02](../02-data-inventarisatie/) leeft hier?
3. **Integratievorm** — API/connector · MCP · Dataverse · export · geen.
4. **Authenticatie** — Hoe logt de agent in? (service-account, OAuth, Entra ID)
5. **Rechten** — Welke rechten heeft de agent nodig? (alleen lezen? schrijven?)
6. **Beheer** — Wie beheert het systeem? Wie moet akkoord geven voor koppeling?

## Voorbeeld uit de bouw

> Voor "bestek doorzoeken" is er geen schrijfactie nodig: de bron is de
> **bestek-PDF in SharePoint** → integratievorm *bestandsexport / knowledge
> source*. Authenticatie via **Entra ID** met alleen-lezen rechten op de
> projectmap. Later, voor "inkoopschema genereren", is wél een schrijfkoppeling
> naar **4PS/Dataverse** nodig — daarvoor een service-account met beperkte rechten.

## Valkuilen

- **Aannemen dat alles een API heeft.** Veel bouwsoftware biedt alleen export.
  Ontwerp daaromheen.
- **Te ruime rechten.** Geef de agent alleen wat de use-case nodig heeft
  (least privilege) — cruciaal in [stap 07](../07-architectuur-en-integratie/).
- **Vergeten wie beheert.** Zonder akkoord van de systeembeheerder loopt de
  koppeling later vast.

## Ingevuld referentievoorbeeld

Zie de integratiematrix in
[referentie/project-coach/architectuur.md](../../referentie/project-coach/architectuur.md#integratiematrix).

---

➡️ Vul de [template](template.md) in en ga door naar
[stap 04 — Proces-mapping »](../04-proces-mapping/)
