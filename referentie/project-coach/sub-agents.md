# Sub-agent-catalogus (referentie)

De **Project Coach** coördineert onderstaande gespecialiseerde sub-agents. Alle
agents zijn hier **globaal opgezet** (doel, scope, kennis, tools, autonomie); de
**Bestek & Tekeningen**-agent is volledig uitgewerkt in
[../usecase-bestek/README.md](../usecase-bestek/README.md).

| Sub-agent | Status | Kern |
|---|---|---|
| Bestek & Tekeningen | ✅ uitgewerkt | Eisen uit bestek/tekeningen zoeken en samenvatten |
| Mensen | 🔵 bestaand | Bemensing, certificaten, beschikbaarheid, vervanging |
| Materialen | 🔵 bestaand | Materialen, hoeveelheden, bestellingen |
| Planning | ⚪ stub | Uitvoeringsplanning, mijlpalen, voortgang |
| Inkoop / Leveranciers | ⚪ stub | Offertes aanvragen/vergelijken, onderaannemers |
| Compliance / Regelgeving | ✅ uitgewerkt | Bbl/Bouwbesluit, NEN, vergunningen, V&G |
| Meer-/minderwerk | ⚪ stub | Wijzigingen detecteren en onderbouwen |
| Oplever & Kwaliteit | ⚪ stub | Restpunten, opleverdossier |

---

## ✅ Bestek & Tekeningen (uitgewerkt)

- **Doel:** doorzoekt bestek en tekeningen en stelt een eisenlijst op met
  bronverwijzingen.
- **Doet niet:** bestellen, wijzigen, oordelen over regelgeving.
- **Kennis:** bestek-PDF, tekeninglijst, contract (actuele revisie).
- **Tools:** geen (alleen kennis / RAG).
- **Autonomie:** *augment* — stelt concept voor, WVB controleert.
- **Volledig uitgewerkt:** zie [usecase-bestek »](../usecase-bestek/README.md).

## 🔵 Mensen (bestaand)

- **Doel:** ondersteunt bemensing van projecten — beschikbaarheid,
  certificaten/diploma's, planningsconflicten, vervangingsverzoeken.
- **Kennis/data:** rooster/HR, certificatenregister.
- **Tools:** zoek beschikbare medewerker, zoek verlopende certificaten, zoek
  planningsconflicten, vervangingsverzoek aanmaken/bijwerken.
- **Autonomie:** augment → automate-met-controle (bv. vervangingsverzoek als
  concept).
- **Integratie:** ERP/HR via Dataverse/connector.

## 🔵 Materialen (bestaand)

- **Doel:** ondersteunt materiaal- en inkoopvragen — hoeveelheden, bestellijsten,
  voorraad, levertijden.
- **Kennis/data:** materiaalstaten, ERP (artikelen, orders).
- **Tools:** materiaal opzoeken, bestelregel voorstellen, levertijd checken.
- **Autonomie:** augment → automate-met-controle.
- **Integratie:** 4PS/Dataverse.

## ⚪ Planning (stub)

- **Doel:** helpt de uitvoeringsplanning op te stellen en te bewaken; signaleert
  mijlpalen en afwijkingen.
- **Kennis/data:** planning (MS Project/Primavera/KYP export), voortgang.
- **Tools (later):** planning lezen, afwijking signaleren.
- **Autonomie:** augment.
- **Uit te werken via:** [blueprint stappen 06-08](../../blueprint/06-agent-ontwerp/).

## ⚪ Inkoop / Leveranciers (stub)

- **Doel:** ondersteunt het inkoopproces — offertes aanvragen, vergelijken,
  onderaannemers selecteren.
- **Kennis/data:** offertes (PDF), leveranciers/onderaannemers, raamcontracten.
- **Tools (later):** offerte-aanvraag opstellen, offertes normaliseren/vergelijken.
- **Autonomie:** augment (concept-mails), mens gunt.

## ✅ Compliance / Regelgeving (uitgewerkt)

- **Doel:** beantwoordt vragen over Bbl/Bouwbesluit, NEN-normen, vergunningen en
  V&G — altijd met bron + artikel + versie.
- **Kennis/data:** regelgeving en interne richtlijnen (kennisbron); normenregister
  (alleen verwijzingen).
- **Tools:** geen (kennis / RAG).
- **Autonomie:** augment, **expert-in-de-loop**. **Let op:** indicatief, geen
  juridisch eindoordeel; NEN-normtekst niet reproduceren (auteursrecht);
  versie/ingangsdatum verplicht.
- **Volledig uitgewerkt:** zie [usecase-compliance »](../usecase-compliance/README.md).

## ⚪ Meer-/minderwerk (stub)

- **Doel:** detecteert afwijkingen t.o.v. contract/bestek en helpt meer-/minderwerk
  te onderbouwen.
- **Kennis/data:** contract, bestek, wijzigingsverzoeken, calculatie.
- **Tools (later):** wijziging registreren, onderbouwing/brief opstellen.
- **Autonomie:** augment (concept), mens accordeert.

## ⚪ Oplever & Kwaliteit (stub)

- **Doel:** helpt het oplever-/revisiedossier samen te stellen en restpunten te
  bewaken.
- **Kennis/data:** keuringen, revisies, foto's, restpuntenlijsten.
- **Tools (later):** restpunten opvragen, dossier samenstellen.
- **Autonomie:** augment.

---

## Hoe werk je een stub verder uit?

Elke stub doorloopt dezelfde route als de bestek-agent:
[stap 06 Agent-ontwerp](../../blueprint/06-agent-ontwerp/) →
[stap 07 Architectuur](../../blueprint/07-architectuur-en-integratie/) →
[stap 08 Bouwen & testen](../../blueprint/08-bouwen-en-testen/) →
[stap 09 Governance](../../blueprint/09-governance-en-adoptie/).
Gebruik de [agent-spec-template](../../blueprint/06-agent-ontwerp/template.md).
