# Documenten in SharePoint — kennis + document-automatisering (demo)

De **documentlaag** van de demo. Waar **Dataverse** de *gestructureerde* kant is
(voorraad, offertes, inkoopaanvragen — zie [inkoop-dataverse-design.md](inkoop-dataverse-design.md)),
is **SharePoint** de *ongestructureerde* kant: bestek, tekeningen, contracten,
vergunningen en projectdocumentatie. Samen laten ze het hele blueprint-datamodel zien.

> **Doel van deze toevoeging:** laten zien hoe SharePoint in de demo past — als
> **kennisbron** (augment) én als **document-automatisering** (automate met controle) —
> met een mappenstructuur die 1-op-1 op de zes WVB-domeinen mapt.

> **Placeholders:** vul overal je eigen **site-/bibliotheek-URL** in (`<sharepoint-site>`).
> Zet **géén** echte site-URL's, tenant-/omgevings-ID's in deze (publieke) repo.

## Twee rollen, één documentlaag

| Rol | Wat | Demo |
|---|---|---|
| **Augment (lezen)** | De agent doorzoekt documenten en antwoordt **met bronvermelding** (RAG) | **A** — SharePoint-bibliotheek als kennis op de **Bestek-agent** |
| **Automate (schrijven, met controle)** | De agent zet — **na bevestiging** — de **projectmap-structuur** klaar | **B** — projectmappen aanmaken via connector of flow |

## Mappenstructuur (voorbeeld) — mapt op de 6 domeinen

Zo lijnen de SharePoint-mappen uit met de sub-agents uit de
[architectuur](../project-coach/architectuur.md):

```
/Projecten/<Project>/
  01 Contract & Voorwaarden      ← GEVOELIG: uitsluiten van de kennisindex
  02 Bestek & Tekeningen         ← kennis voor de Bestek-agent (alleen geaccordeerde revisie)
  03 Vergunningen & Compliance   ← kennis voor de Compliance-agent
  04 Inkoop & Offertes           ← GEVOELIG (prijzen): uitsluiten van de kennisindex
  05 Planning & Capaciteit
  06 Meer- en minderwerk
  07 Oplevering & Kwaliteit
```

> **Waarom deze indeling?** Elke map heeft één duidelijke eigenaar-agent, en de
> **gevoelige** mappen (contract, prijzen/offertes) staan apart zodat je ze
> eenvoudig **buiten de kennisindex** houdt (zie Governance).

## A. SharePoint als kennisbron (Bestek-agent) — *augment*

De [Bestek & Tekeningen-agent](bestek-agent-runbook.md) gebruikt nu geüploade
bestanden. Vervang die door — of vul aan met — de **SharePoint-documentbibliotheek**
voor meer realisme (echte documenten, klikbare bron, altijd de laatste versie).

1. Open in [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com) de
   **Bestek & Tekeningen**-agent (juiste omgeving `<jouw-omgeving>`).
2. **Knowledge → Add knowledge → SharePoint.**
3. Plak de URL van **`02 Bestek & Tekeningen`** (of de site-/bibliotheek-URL).
   Wijs **alleen de map met de geaccordeerde revisie** aan.
4. Geef de bron een duidelijke naam (bv. *"Bestek De Beemster (SharePoint)"*).
5. Laat **general knowledge UIT** staan (gronden op alleen de bron) — zie
   [runbook stap 4](bestek-agent-runbook.md#4-gronden-afdwingen).
6. **Test:** stel een bestekvraag → het antwoord verwijst nu naar het **SharePoint-
   document** (klikbare bron).

**Let op (kennisbron-realiteit):**
- **Indexering** kost even tijd na toevoegen; wacht tot de bron "ready" is.
- **Bestandstypen:** PDF/Word/PowerPoint/… werken goed; `.md` niet altijd — gebruik
  PDF/Word (de voorbeelddata kun je als Word/PDF exporteren).
- **Groottelimiet:** ~**15 MB** per bestand (200 MB met Enhanced/Enterprise search).
- **Security-trimming:** de agent toont alleen documenten die de **gebruiker** mag zien.

## B. Projectmap-structuur aanmaken — *automate met controle*

Dezelfde **mens-in-de-lus**-aanpak als de Inkoop-schrijfactie
([inkoop-agent-runbook.md](inkoop-agent-runbook.md)): de agent **stelt de structuur
voor**, **jij bevestigt**, daarna maakt hij de mappen aan. Twee bouwvormen:

> **SharePoint-mapnamen** mogen geen `/ \ : * ? " < > |` bevatten — vandaar
> *"06 Meer- en minderwerk"* (niet "Meer-/minderwerk").

> **Reproduceerbaar klaarzetten (prep):** wil je de structuur én de fictieve
> documenten in één keer neerzetten voor een demo, gebruik dan
> [scaffold-sharepoint-demo.ps1](scaffold-sharepoint-demo.ps1) (Graph). Dat is de
> *admin-prep*; de tool/flow hieronder is de *live agent-actie*.

### B1 — SharePoint-connector als tool (inline, simpel)

- **Tools → Add a tool → SharePoint → Create new folder.**
- De agent maakt per map een `Create new folder` aan onder `/Projecten/<Project>/…`.
- **Zet bevestiging AAN** en beschrijf de tool strak: *"Maakt uitsluitend mappen aan
  onder /Projecten/<Project>. Nooit verwijderen of overschrijven."*
- Voordeel: alles in de agent, geen extra flow. Nadeel: de agent doet meerdere calls
  (één per map) — meer round-trips.

### B2 — Power Automate-flow als tool (aanbevolen, robuust)

Eén flow die de **hele** structuur in één keer aanmaakt vanuit een vast sjabloon:

- **Trigger:** *"When an agent calls the flow"* — input: `projectnaam` (tekst).
- **Actie:** initialiseer een array met de 7 mapnamen; **Apply to each** →
  SharePoint **Create new folder** onder `/Projecten/<projectnaam>/<mapnaam>`.
- **Return:** lijst met aangemaakte mappen (zodat de agent kan terugkoppelen).
- Voeg de flow toe als **tool** in de agent en **zet bevestiging AAN**.

Voordeel: **vast sjabloon** (consistente structuur), **één** bevestiging, één call.
Dit is de nette "automate met controle" voor documentbeheer.

**Guardrails (beide vormen):**
- Alleen aanmaken onder `/Projecten/<Project>/`; **nooit verwijderen/overschrijven**.
- Eerst de structuur **tonen** en **laten bevestigen**; dan pas aanmaken.
- Bestaat de map al? Melden, niet dupliceren.

**Demo:** *"Zet de projectmap op voor 'De Beemster'."* → agent toont de 7 mappen →
**bevestigen** → mappen worden aangemaakt → agent meldt het resultaat.

## C. Hybride — SharePoint ↔ Dataverse (het architectuurverhaal)

De twee lagen versterken elkaar:
- Een **Inkoopaanvraag** (Dataverse) krijgt een **hyperlink naar de offerte-PDF** in
  SharePoint.
- Een **eisen-antwoord** van de Bestek-agent **linkt naar het exacte document**.

Zo doet elke laag waar hij goed in is: **Dataverse = records/automate**,
**SharePoint = documenten/augment**, en de agent(s) orkestreren ertussen.

## Governance

Uit [best-practices/data-design.md](../../best-practices/data-design.md) en
[blueprint 07 — architectuur](../../blueprint/07-architectuur-en-integratie/):

- **Security-trimming** — de agent surfacet alleen wat de gebruiker mag zien (Entra ID delegated).
- **Alleen de geaccordeerde revisie** indexeren (geen verouderde/dubbele bestek-versies).
- **Gevoelige mappen uitsluiten** van de kennisindex: `01 Contract`, `04 Inkoop & Offertes`.
- **Toegang via Entra ID-groepen**, niet per individu.
- **Schrijven (B)** blijft *automate met controle*: mens bevestigt, agent verwijdert niets.

## Demo-script (2 scenario's, ±3 min)

1. **Augment:** *"Wat staat er in het bestek over brandveiligheid?"* → gegrond
   antwoord **met klikbare SharePoint-bron**.
2. **Automate:** *"Zet de projectmap op voor project X."* → agent toont de structuur →
   **bevestigen** → mappen aangemaakt onder `/Projecten/X/`.

## Placeholders

Vul je eigen **site-/bibliotheek-URL** en mapnamen in. Zet **géén** echte site-URL's,
tenant- of omgevings-ID's in deze (publieke) repo.
