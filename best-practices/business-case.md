# Business case & waarde — vóór je bouwt

De business-kant van de blueprint: **waarom** bouw je deze agent, **wat is hij
waard**, en hoe zorg je dat hij ook echt gebruikt wordt. Gebaseerd op Microsoft's
guidance *Plan your Copilot Studio projects* en *Measure the ROI and business value
of AI agents*, vertaald naar de bouw.

> **Laatst getoetst aan Microsoft Learn:** 2026-07-10.
> Bronnen: [Plan your projects](https://learn.microsoft.com/microsoft-copilot-studio/guidance/plan-overview) ·
> [Measure ROI & business value](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-business-value-overview) ·
> [Define value before you build](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-business-value-define-value) ·
> [Measure the impact](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-business-value-measure-impact).

## Kernprincipe: definieer waarde vóór je bouwt

> *"The license isn't the investment. Adoption is."* — Microsoft

Bepaal de waarde **voordat** je een agent bouwt, meet vanaf dag 1, en bespreek de
resultaten met een **vaste sponsor**. Zonder die discipline blijf je in
experimenteerstand en kun je later geen geloofwaardig waardeverhaal vertellen.

## De vier waarde-drivers (vertaald naar de bouw)

Elke euro waarde valt in één van vier categorieën. Koppel elke use-case en KPI aan
een driver:

| Waarde-driver | Microsoft | In de bouw (werkvoorbereiding) |
|---|---|---|
| **Efficiency** | Productieve uren terug | Minder zoek-/overtypwerk in bestek, tekeningen, normen; sneller inkoopschema |
| **Quality** | Minder fouten, consistentie, compliance | Minder **faalkosten**, gemiste eisen en verkeerde revisies; consistente oplevering |
| **Revenue** | Omzetgroei | Meer projecten met dezelfde bezetting; snellere/betere calculatie → betere winkans en marge |
| **Strategic** | Wendbaarheid, capaciteit, kennisborging | Doorwerken bij **personeelstekort**; kennis van ervaren WVB's vastleggen; snellere besluiten |

> Tip (Microsoft): organisaties die AI gebruiken om **te veranderen wát ze meten**
> (niet alleen bestaande KPI's verbeteren) halen op termijn sterkere resultaten.

## Bouw je business case op (4 stappen)

1. **Discovery** — kies een **benoemde, hoog-volume taak** (bv. "bestek doorzoeken &
   eisen samenvatten"). Een agent die één concrete taak overneemt toont sneller ROI
   dan "algemene productiviteit". → [stap 01](../blueprint/01-rol-en-taakanalyse/) /
   [05](../blueprint/05-usecase-prioritering/).
2. **Prioriteer** op waarde × haalbaarheid (de grid uit [stap 05](../blueprint/05-usecase-prioritering/)).
3. **Baseline vastleggen (vóór go-live)** — meet de huidige situatie zodat je later
   verschil kunt aantonen. Simpele formule:
   > **Productieve uren/maand = aantal WVB's × uren aan deze taak/week × 4,3**
   > **Waarde = uren × volledig belast uurtarief** (bruto × ~1,3–1,5 voor
   > werkgeverslasten, tools en overhead).
4. **Governance & licenties vooraf** — bepaal het licentie-/verbruiksmodel en de
   governance-guardrails. → [stap 09](../blueprint/09-governance-en-adoptie/).

### Rekenvoorbeeld (fictief)

> 6 werkvoorbereiders besteden elk ~6 uur/week aan zoeken in bestek, tekeningen en
> normen. Baseline = 6 × 6 × 4,3 ≈ **155 uur/maand**. Bij een volledig belast tarief
> van €65/uur is dat ≈ **€10.075/maand** aan tijd die je deels kunt herbesteden aan
> hoger-waardig werk. Vervang de getallen door je eigen cijfers; de structuur blijft.

## Een cross-functioneel team (wie aan tafel)

Microsoft: bouw een team met **business-, technische én governance-expertise** en een
**benoemde sponsor**. Vertaald naar de bouw:

| Rol | Wie | Brengt |
|---|---|---|
| **Sponsor** | Bouwdirecteur / operationeel manager | Mandaat, budget, prioriteit; beoordeelt de resultaten |
| **Business** | Werkvoorbereiders, uitvoerders, projectleiders | Kennis van het werk, de pijn en de waarde |
| **IT / beheer** | IT van het bouwbedrijf of de IT-dienstverlener | Systemen, koppelingen, rechten, governance |
| **Consultant / maker** | Low-code maker of pro-dev | Ontwerp en bouw van de agent |

## Prioriteer risico's + workarounds

Breng hoog-impact-onzekerheden vroeg naar boven en bepaal een praktische workaround,
zodat de bouw doorloopt. Bouw-typische risico's: verouderde revisies, vervuilde
kennisbron, ontbrekende koppeling, gevoelige financiële data. →
[stap 05](../blueprint/05-usecase-prioritering/) / [07](../blueprint/07-architectuur-en-integratie/).
Bron: [Prioritize risks and identify workarounds](https://learn.microsoft.com/microsoft-copilot-studio/guidance/project-planning).

## Adoptie is de investering (niet de licentie)

De grootste hefbomen op ROI (Microsoft, op impact-volgorde):

1. **Rol-gebaseerde training** als voorwaarde; **train managers/uitvoerders eerst**.
2. **Anker elke agent aan één benoemde, hoog-volume taak** (niet "algemene productiviteit").
3. **Zichtbaar voorbeeldgedrag** van leiding — sterkste versneller van routine-gebruik.
4. **Gedeelde prompt-bibliotheek**, maandelijks bijgewerkt op thema's uit de analytics.
5. **Zichtbare guardrails** — vertrouwen groeit met governance die mensen kunnen zien.
6. **Kwartaalritme** — pak elk kwartaal een nieuwe hoog-volume taak, meet 90 dagen
   tegen baseline, bespreek met de **sponsor**, en schaal of stop.

## Waarde groeit in fasen

| Fase | Wat telt | Wat je ziet |
|---|---|---|
| **Dag 1–90** | Adoptie + eerste efficiency | Minder zoekwerk, snellere doorlooptijd. Val niet te vroeg victorie vóór 25% routine-adoptie. |
| **Dag 91–1 jaar** | Kwaliteit + omzet | Minder faalkosten/herstelwerk; werk verschuift naar hoger-waardig. |
| **Jaar 2+** | Strategische waarde | Snellere besluiten, nieuwe capaciteit; waarde stapelt over use-cases. |

## Meten op het Microsoft-platform

- **Copilot Studio Analytics** — engagement, outcomes, tevredenheid, thema's.
- **Savings calculator** (per run/tool) op de Analytics-pagina.
- **Viva Insights — Copilot Studio agents report** (Power BI) — Agent Assisted Hours
  & Value tenant-breed (≥50 Copilot-licenties + 1 gepubliceerde agent in productie).
- Koppel elke KPI terug aan een **waarde-driver** (efficiency/quality/revenue/strategic).

Bron: [Measure the impact](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-business-value-measure-impact) ·
[Tell the value story](https://learn.microsoft.com/microsoft-copilot-studio/guidance/agent-business-value-tell-value-story).

## Waar in de blueprint

| Business-stap | Blueprint |
|---|---|
| Waarde definiëren + sponsor | [stap 00](../blueprint/00-context-en-ambitie/) |
| Hoog-volume taak kiezen + prioriteren | [stap 01](../blueprint/01-rol-en-taakanalyse/) / [05](../blueprint/05-usecase-prioritering/) |
| Risico's + workarounds | [stap 05](../blueprint/05-usecase-prioritering/) / [07](../blueprint/07-architectuur-en-integratie/) |
| Baseline + KPI's | [stap 00](../blueprint/00-context-en-ambitie/) / [08](../blueprint/08-bouwen-en-testen/) |
| Adoptie + meten + sponsor-cadans | [stap 09](../blueprint/09-governance-en-adoptie/) |

> **Illustratief, geen financieel of juridisch advies.** Reken met je eigen cijfers
> en laat aannames toetsen door een bevoegd persoon.
