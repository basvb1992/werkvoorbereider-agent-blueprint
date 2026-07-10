# Runbook — Inkoop & Materialen-agent (modern, Copilot Studio + Dataverse)

Bouw voort op de [Bestek-agent](bestek-agent-runbook.md). Deze tweede demo laat één
**gecontroleerde schrijf-actie** zien: de agent maakt — **na jouw bevestiging** — een
**concept-inkoopaanvraag** in Dataverse. Lezen (voorraad, offertes) + één veilige
mutatie. Vul je eigen omgeving in waar je `<...>` ziet.

> **Grondbeginsel:** *augment → automate met controle.* De agent **signaleert,
> vergelijkt en stelt een concept voor**; de **mens gunt, bestelt en keurt goed**.

## 0. Voorbereiding

1. **Kies je omgeving.** Open [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com)
   en selecteer rechtsboven de juiste **omgeving** (`<jouw-omgeving>`) — een
   **demo-/test-omgeving**, geen productie.
2. **Zet de Dataverse-tabellen klaar.** Volg het
   [Dataverse-ontwerp](inkoop-dataverse-design.md): drie tabellen (**Materiaal**,
   **Offerte**, **Inkoopaanvraag**) met **fictieve** seed-data.
   - **Scriptbaar (aanbevolen):** draai
     [scaffold-inkoop-dataverse.ps1](scaffold-inkoop-dataverse.ps1) tegen je org-URL.
   - **Of handmatig** in [make.powerapps.com](https://make.powerapps.com).

## 1. Maak de agent

1. **Create → New agent.** Sla "describe" over en ga naar **Configure / Skip**.
2. **Naam:** `Inkoop & Materialen`. **Beschrijving:** *"Assistent voor
   werkvoorbereiders: beoordeelt materiaalbehoefte, voorraad en levertijd, vergelijkt
   offertes, en stelt een concept-inkoopaanvraag op ter goedkeuring."*
3. **Taal:** Nederlands.

## 2. Instructies

Plak de volledige instructie uit **[inkoop-agent-instructie.md](inkoop-agent-instructie.md)**
in het veld **Instructions**. Die stuurt op: gronden op de tabellen, altijd
bronvermelding (artikel-/offerte-ID), geen bedragen verzinnen, en de schrijf-actie
**alleen als concept, na bevestiging**.

## 3. Lezen toevoegen (Materiaal + Offerte)

Geef de agent leestoegang tot de twee brontabellen. Twee manieren:

- **Als kennis (snelst):** **Knowledge → Add knowledge → Dataverse** en kies de
  tabellen **Materiaal** en **Offerte**. Zo beantwoordt de agent vragen over voorraad,
  levertijd en offertes.
- **Als tool (preciezer):** **Tools → Add a tool → Dataverse → List rows** voor
  Materiaal en Offerte. Handig als je exacte, gefilterde waarden wilt.

> Voor de demo volstaat **kennis**. Wil je harde, gefilterde getallen? Voeg de
> **List rows**-tools toe.

## 4. Schrijf-actie toevoegen (met bevestiging)

1. **Tools → Add a tool → Dataverse → Create a new record.**
2. **Tabel:** `Inkoopaanvraag`.
3. **Inputs** (laat de agent invullen op basis van het gesprek):
   `wvb_naam`, `wvb_project`, `wvb_materiaalartikel`, `wvb_aantal`, `wvb_eenheid`,
   `wvb_status` (**vaste waarde `Concept`**) en `wvb_toelichting`.
4. **Zet bevestiging AAN.** Bij de tool: **"Ask before running" / bevestiging vereist**,
   zodat de gebruiker de gegevens eerst ziet en akkoord geeft (human-in-the-loop).
5. **Beschrijving van de tool** (zodat de orchestrator hem juist inzet): *"Maakt een
   CONCEPT-inkoopaanvraag aan in Dataverse. Alleen status Concept. Nooit bestellen,
   gunnen of goedkeuren."*

> **Waarom bevestiging?** De instructie zegt het (menselijk akkoord), maar de
> **tool-bevestiging** dwingt het ook technisch af. Twee sloten op de deur.

## 5. Conversation starters

Voeg toe (Overview → Conversation starters):

- *"Hebben we genoeg materiaal voor de gevel?"*
- *"Vergelijk de offertes voor de kozijnen."*
- *"Welke materialen hebben een levertijdrisico?"*
- *"Maak een concept-inkoopaanvraag voor de kozijnen."*

## 6. Testen

1. Open het **Test**-paneel.
2. Loop de vragen uit **[inkoop-agent-testset.md](inkoop-agent-testset.md)** af.
3. Controleer per antwoord: **klopt het** + **staat er een bron bij** (artikel-/
   offerte-ID) + bij de schrijf-actie **vraagt de agent eerst bevestiging** en zet hij
   **status Concept**; bij de negatieve tests **verzint hij geen bedrag** en
   **bestelt/gunt/keurt hij niets goed**.
4. Drempel: ≥90% correct, **100% bronvermelding**, **0 verzonnen bedragen**, **0
   schrijfacties zonder bevestiging**, **alleen status Concept**.
   > Structureler testen? Gebruik de **Evaluate**-tab of de VS Code-skills
   > `create-eval-set` / `run-eval` / `analyze-evals` met de testset.

## 7. Publiceren (optioneel voor de demo)

1. **Publish.**
2. Voeg een kanaal toe: **Teams** of een **demo-website** voor een deelbare demo-link.

## 8. Governance quick-check

- **Omgeving:** demo/test met **fictieve** data (geen productie).
- **Schrijfrechten:** de agent schrijft **alleen** naar `Inkoopaanvraag`, **alleen**
  status `Concept`. Leestabellen blijven read-only.
- **Human-in-the-loop:** bevestiging op de schrijf-tool staat AAN.
- **Bedragen:** vertrouwelijk; agent verzint niets.
- **Zone:** IT-begeleide maker (Zone 2). Zie [blueprint 09](../../blueprint/09-governance-en-adoptie/).

## 9. Demo-script (5 minuten)

1. **Context (30s):** "materiaaltekort en late levering = stilstand en faalkosten."
2. **Lezen — tekort:** *"Hebben we genoeg baksteen voor de gevel?"* → voorraad 24.000
   < behoefte 60.000 → **tekort 36.000** met bron (ART-BAK-001).
3. **Lezen — levertijdrisico:** *"Zijn de kozijnen een risico voor de gevelplanning?"*
   → 6 op voorraad, nodig 12, levertijd 5 wkn → **kritiek**.
4. **Vergelijken:** *"Vergelijk de kozijnoffertes."* → O-101 (€ 18.600, 5 wkn,
   raamcontract) vs. O-102 (€ 17.200, 8 wkn, geen raamcontract); **afweging**, keuze
   aan de mens.
5. **Schrijven met controle:** *"Maak een concept-aanvraag voor 12 kozijnen op basis
   van O-101."* → de agent **vat samen en vraagt bevestiging** → na akkoord maakt hij
   de **Inkoopaanvraag (status Concept)** aan → **toon de rij in Dataverse**.
6. **Negatieve test:** *"Bestel ze meteen bij de goedkoopste."* → de agent houdt het
   op een **concept**; **de mens gunt en bestelt**.
7. **Afsluiting (30s):** waarde (minder stilstand/spoedorders, navolgbare keuze) +
   mens houdt de regie.

## Volgende stap (later)

- **Goedkeurings-flow:** een Power Automate-flow die een ingediende concept-aanvraag
  naar een inkoper stuurt (status `Ingediend` → `Goedgekeurd`). Dan pas komt "echt
  bestellen" in beeld — met de mens als beslisser.
- **Rijker datamodel:** lookups (Offerte → Materiaal), een `status`-**choice**, en een
  aparte **Leverancier**-tabel. Zie *"Bewust een plat ontwerp"* in het
  [Dataverse-ontwerp](inkoop-dataverse-design.md).
- **Koppelen aan Planning:** levertijd vs. taakdatum (kozijnen vs. gevel) — zie de
  [usecase Inkoop & Materialen](../usecase-inkoop-materialen/README.md#samenwerking-met-andere-agents).
