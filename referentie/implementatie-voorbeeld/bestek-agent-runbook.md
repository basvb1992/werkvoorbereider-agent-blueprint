# Runbook — Bestek & Tekeningen-agent (modern, Copilot Studio)

Bouw in ±1 dagdeel een werkende, gegronde Bestek-agent. Augment/kennis, geen
Dataverse. Vul je eigen omgeving in waar je `<...>` ziet.

## 0. Voorbereiding

1. **Kies je omgeving.** Open [copilotstudio.microsoft.com](https://copilotstudio.microsoft.com)
   en selecteer rechtsboven de juiste **omgeving** (`<jouw-omgeving>`).
2. **Kennisbron klaarzetten.** Kies één van beide:
   - **SharePoint (aanbevolen voor realisme):** maak/gebruik een documentbibliotheek
     en upload het fictieve materiaal (zie hieronder). Onthoud de site-URL.
   - **Bestanden uploaden:** houd de bestanden lokaal klaar om direct in de agent te
     uploaden.

   Gebruik uit [../../voorbeelddata/](../../voorbeelddata/): **bestek-fictief-project**,
   **tekeninglijst**, **normenregister** (en eventueel **bbl-fictief** voor context).
   > Levert de portal een foutmelding op `.md`? Converteer naar **PDF of Word** (de
   > inhoud blijft gelijk) — vraag gerust om een Word/PDF-versie van de voorbeelddata.

## 1. Maak de agent

1. **Create → New agent.** Sla "describe" over en ga naar **Configure / Skip**.
2. **Naam:** `Bestek & Tekeningen`. **Beschrijving:** *"Assistent voor
   werkvoorbereiders: doorzoekt bestek en tekeningen en vat eisen samen met
   bronvermelding."*
3. **Taal:** Nederlands.

## 2. Instructies

Plak de volledige instructie uit **[bestek-agent-instructie.md](bestek-agent-instructie.md)**
in het veld **Instructions**. Die stuurt op: uitsluitend gronden op de bron, altijd
bronvermelding, "niet gevonden" i.p.v. gokken, en geen acties.

## 3. Kennis toevoegen

1. **Knowledge → Add knowledge.**
2. **SharePoint:** plak de site-/bibliotheek-URL. **Of Files:** upload de bestanden
   uit stap 0.
3. Voeg **alleen de actuele, geaccordeerde revisie** toe. **Sluit prijsbladen uit.**
4. Geef de kennisbron een duidelijke naam (bv. *"Bestek De Beemster"*).

## 4. Gronden afdwingen

1. Zet **generative orchestration** aan (standaard bij moderne agents).
2. Zet **"Allow the AI to use general knowledge"** UIT — zo antwoordt de agent
   alleen op basis van de kennisbron (past bij de instructie).

## 5. Conversation starters

Voeg toe (Overview → Conversation starters):

- *"Vat de eisen van dit project samen."*
- *"Wat staat er over brandveiligheid?"*
- *"Welke Rc-waarde geldt voor de gevel?"*
- *"Klopt de kozijnmaat op tekening met het bestek?"*

## 6. Testen

1. Open het **Test**-paneel.
2. Loop de vragen uit **[bestek-agent-testset.md](bestek-agent-testset.md)** af.
3. Controleer per antwoord: **klopt het** + **staat er een bron bij** + bij de
   negatieve test zegt de agent **"niet gevonden in het bestek"** (geen gok).
4. Drempel: ≥90% correct, **100% bronvermelding**, **0 hallucinaties**.
   > Structureler testen? Gebruik de **Evaluate**-tab of de VS Code-skills
   > `create-eval-set` / `run-eval` / `analyze-evals` met de testset.

## 7. Publiceren (optioneel voor de demo)

1. **Publish.**
2. Voeg een kanaal toe: **Teams** of een **demo-/custom website** voor een deelbare
   demo-link.

## 8. Governance quick-check

- **Omgeving:** demo/test met **fictieve** data (geen productie).
- **Toegang:** wie mag de agent gebruiken? (Entra ID-groep, niet individuen.)
- **Grounding:** general knowledge uit; bronvermelding aan.
- **Zone:** IT-begeleide maker (Zone 2). Zie [blueprint 09](../../blueprint/09-governance-en-adoptie/).

## 9. Demo-script (5 minuten)

1. **Context (30s):** "6 werkvoorbereiders, 6–10 uur zoeken per project in bestek."
2. **Vraag 1:** *"Wat is de eis voor brandwerendheid van de woningscheidende wanden?"*
   → toon het antwoord **met bron**.
3. **Vraag 2:** *"Vat de eisen over de fundering samen."* → genummerde lijst + bronnen.
4. **Negatieve test:** *"Welke tegelkleur is voorgeschreven in de badkamer?"* →
   *"niet gevonden in het bestek"* — laat zien dat hij **niet gokt**.
5. **Tegenstrijdigheid:** *"Klopt de kozijnmaat op tekening met het bestek?"* → de
   agent signaleert het verschil en noemt beide bronnen.
6. **Afsluiting (30s):** waarde-driver (efficiency + minder faalkosten), mens
   controleert (augment), volgende use-case = Compliance of Inkoop.

## Volgende stap (later, automate)

Een schrijf-actie tonen (bv. Inkoop) vraagt **Dataverse** + een `pac`-auth in je
omgeving. Dat is Fase C — een apart runbook zodra we die kant op gaan. Onthoud:
de moderne agent zelf blijft in de UI gebouwd; alleen de Dataverse-tabellen en
solution zijn scriptbaar.
