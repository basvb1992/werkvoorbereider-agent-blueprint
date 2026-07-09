# Project Coach — architectuur (referentie)

Dit document is het ingevulde resultaat van blueprint-stap 00, 01, 03 en 07 voor
onze rode-draad-casus. Het beschrijft de multi-agent architectuur van een
werkvoorbereidingsagent.

---

## Contextprofiel

*(ingevuld voorbeeld bij [blueprint stap 00](../../blueprint/00-context-en-ambitie/))*

- **Bedrijf:** fictieve middelgrote **B&U-aannemer** (woning- en utiliteitsbouw).
- **Aantal werkvoorbereiders:** 6.
- **Rolinvulling:** alle fasen — overdracht, werkvoorbereiding,
  uitvoeringsbegeleiding, oplevering.
- **Digitaliseringsniveau:** *gevorderd* — 4PS Construct (ERP), IBIS (calculatie),
  Revit (BIM), veel Excel en Outlook.
- **Ambitie:** starten met **assisteren** (sneller door bestek/tekeningen), daarna
  **automatiseren** (inkoopschema, meer-/minderwerk).
- **Succesmaat:** elke WVB bespaart ~3 uur/week zoek- en overtypwerk; minder
  faalkosten door gemiste eisen.

---

## Taken-canvas

*(ingevuld voorbeeld bij [blueprint stap 01](../../blueprint/01-rol-en-taakanalyse/))*

| Taak | Fase | Frequentie | Tijd/keer | Pijn | Waarde | Data/systemen |
|---|---|---|---|---|---|---|
| Bestek & tekeningen bestuderen | overdracht | per project | 6-10 u | 4 | 5 | bestek PDF, tekeningen, DMS |
| Hoeveelheden uittrekken | werkvoorbereiding | per project | 4-8 u | 4 | 5 | tekeningen, BIM, calc |
| Inkoopschema opstellen | werkvoorbereiding | per project | 4-6 u | 3 | 5 | planning, hoeveelheden, ERP |
| Offertes vergelijken | werkvoorbereiding | wekelijks | 1-2 u | 3 | 4 | offertes (PDF), ERP |
| Meer-/minderwerk behandelen | uitvoering | wekelijks | 1-3 u | 4 | 4 | wijzigingen, tekeningen, ERP |
| Bemensing/planning arbeid | uitvoering | wekelijks | 1-2 u | 3 | 4 | rooster, certificaten |
| Opleverdossier samenstellen | oplevering | per project | 4-8 u | 3 | 3 | keuringen, revisies, foto's |

**Top-taken (pijn × waarde):** bestek bestuderen, hoeveelheden uittrekken,
meer-/minderwerk. → gekozen eerste use-case: **bestek bestuderen** (hoogste
waarde, best haalbaar; zie [stap 05](../../blueprint/05-usecase-prioritering/)).

---

## Multi-agent architectuur

We kiezen het **orchestrator + sub-agents**-patroon. De **Project Coach** is het
eerste aanspreekpunt voor de werkvoorbereider en routeert vragen naar de juiste
gespecialiseerde sub-agent.

```mermaid
flowchart TD
  WVB[Werkvoorbereider] --> UI[Teams / Copilot]
  UI --> PC[Project Coach\norchestrator]
  PC --> BA[Bestek & Tekeningen]
  PC --> ME[Mensen]
  PC --> MA[Materialen]
  PC --> PL[Planning]
  PC --> IN[Inkoop/Leveranciers]
  PC --> CO[Compliance/Regelgeving]
  PC --> MM[Meer-/minderwerk]
  PC --> OP[Oplever & Kwaliteit]
  BA --> K[(Kennis: bestek, tekeningen, normen)]
  MA --> D[(ERP / Dataverse)]
  ME --> D
```

**Waarom multi-agent?**

- Elk domein (mensen, materialen, bestek, …) heeft eigen data, systemen en regels.
- Sub-agents kunnen **los** worden ontwikkeld, getest en verbeterd.
- De werkvoorbereider heeft **één** ingang (de Coach) en hoeft niet te weten welke
  agent wat doet.

**Project Coach — rol & instructie (samengevat):**

- Herkent op basis van de vraag *welk domein* het betreft.
- Zet de vraag door naar de juiste sub-agent (connected agent / tool call).
- Voegt antwoorden samen en houdt projectcontext (welk project, welke fase).
- Vraagt om verduidelijking bij twijfel; verzint nooit een antwoord zelf.

De volledige sub-agent-catalogus staat in [sub-agents.md](sub-agents.md).

---

## Integratiematrix

*(ingevuld voorbeeld bij [blueprint stap 03](../../blueprint/03-systeem-inventarisatie/))*

| Systeem | Functie | Data (cat.) | Integratievorm | Rechten | Voor welke sub-agent |
|---|---|---|---|---|---|
| SharePoint (projectmap) | DMS | A, H | export / knowledge source | lezen | Bestek & Tekeningen |
| 4PS Construct (Dynamics 365) | ERP | B, C, D | Dataverse | lezen (later schrijven) | Materialen, Inkoop |
| Rooster/HR-systeem | Bemensing | — | connector / Dataverse | lezen | Mensen |
| IBIS | Calculatie | B, C | export | interpreteren | Materialen, Meer-/minderwerk |
| Revit / BIM-server | BIM | A, C | export (IFC) | interpreteren | Bestek, Materialen |
| Bouwapp / Dalux | Bouwplaats | G | connector (indien beschikbaar) | lezen | Oplever & Kwaliteit |

**Least privilege:** de Bestek & Tekeningen-agent krijgt alleen-lezen toegang tot
de projectmap met **actuele, geaccordeerde revisies**. Prijsbladen en contracten
staan in een aparte, niet-geïndexeerde map.

---

## Platformkeuze

- **Business-spoor (Copilot Studio):** Project Coach + sub-agents als
  **connected agents**; kennis via SharePoint/Dataverse; acties via
  Dataverse-/Power Platform-connectors en MCP.
- **Dev-spoor (Foundry):** elke agent als `agent.yaml`; orchestrator roept
  sub-agents aan als tools; kennis via knowledge index (file search).

> Beide sporen kunnen naast elkaar bestaan: begin low-code met de bestek-agent in
> Copilot Studio, en bouw diepere integraties (bijv. hoeveelheden uit BIM) in
> Foundry.

Zie de sub-agent-catalogus in [sub-agents.md](sub-agents.md) en de volledige
uitwerking van de eerste use-case in
[../usecase-bestek/README.md](../usecase-bestek/README.md).
