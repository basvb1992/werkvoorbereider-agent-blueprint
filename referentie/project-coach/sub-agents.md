# Sub-agent-catalogus (referentie)

De **Project Coach** coördineert onderstaande gespecialiseerde sub-agents. Alle
agents zijn hier **globaal opgezet** (doel, scope, kennis, tools, autonomie); de
**Bestek & Tekeningen**-agent is volledig uitgewerkt in
[../usecase-bestek/README.md](../usecase-bestek/README.md). Consistente **skeletons**
per agent (met mock-plan voor de demo) staan in [../agent-skeletons/](../agent-skeletons/).

| Sub-agent | Status | Kern |
|---|---|---|
| Bestek & Tekeningen | ✅ uitgewerkt | Eisen uit bestek/tekeningen zoeken en samenvatten |
| Mensen | ✅ uitgewerkt | Bemensing, certificaten, beschikbaarheid, vervanging |
| Materialen | ✅ uitgewerkt | Materialen, hoeveelheden, bestellingen |
| Planning | ✅ uitgewerkt | Uitvoeringsplanning, mijlpalen, voortgang |
| Inkoop / Leveranciers | ✅ uitgewerkt | Offertes aanvragen/vergelijken, onderaannemers |
| Compliance / Regelgeving | ✅ uitgewerkt | Bbl/Bouwbesluit, NEN, vergunningen, V&G |
| Meer-/minderwerk | ✅ uitgewerkt | Wijzigingen detecteren en onderbouwen |
| Oplever & Kwaliteit | ✅ uitgewerkt | Restpunten, opleverdossier |

---

## ✅ Bestek & Tekeningen (uitgewerkt)

- **Doel:** doorzoekt bestek en tekeningen en stelt een eisenlijst op met
  bronverwijzingen.
- **Doet niet:** bestellen, wijzigen, oordelen over regelgeving.
- **Kennis:** bestek-PDF, tekeninglijst, contract (actuele revisie).
- **Tools:** geen (alleen kennis / RAG).
- **Autonomie:** *augment* — stelt concept voor, WVB controleert.
- **Volledig uitgewerkt:** zie [usecase-bestek »](../usecase-bestek/README.md).

## ✅ Mensen (uitgewerkt)

> **Skelet:** [agent-skeletons/mensen.md](../agent-skeletons/mensen.md) · **Volledig uitgewerkt:** [usecase-mensen »](../usecase-mensen/README.md)

- **Doel:** ondersteunt bemensing van projecten — beschikbaarheid,
  certificaten/diploma's, planningsconflicten, vervangingsverzoeken.
- **Kennis/data:** rooster/HR, certificatenregister.
- **Tools:** zoek beschikbare medewerker, zoek verlopende certificaten, zoek
  planningsconflicten, vervangingsverzoek aanmaken/bijwerken.
- **Autonomie:** augment → automate-met-controle (bv. vervangingsverzoek als
  concept).
- **Integratie:** ERP/HR via Dataverse/connector.

## ✅ Materialen (uitgewerkt)

> **Skelet:** [agent-skeletons/materialen.md](../agent-skeletons/materialen.md) · **Volledig uitgewerkt:** [usecase-materialen »](../usecase-materialen/README.md)

- **Doel:** ondersteunt materiaal- en inkoopvragen — hoeveelheden, bestellijsten,
  voorraad, levertijden.
- **Kennis/data:** materiaalstaten, ERP (artikelen, orders).
- **Tools:** materiaal opzoeken, bestelregel voorstellen, levertijd checken.
- **Autonomie:** augment → automate-met-controle.
- **Integratie:** 4PS/Dataverse.

## ✅ Planning (uitgewerkt)

> **Skelet:** [agent-skeletons/planning.md](../agent-skeletons/planning.md) · **Volledig uitgewerkt:** [usecase-planning »](../usecase-planning/README.md)

- **Doel:** helpt de uitvoeringsplanning op te stellen en te bewaken; signaleert
  mijlpalen en afwijkingen.
- **Kennis/data:** planning (MS Project/Primavera/KYP export), voortgang.
- **Tools (later):** planning lezen, afwijking signaleren.
- **Autonomie:** augment.
- **Uit te werken via:** [blueprint stappen 06-08](../../blueprint/06-agent-ontwerp/).

## ✅ Inkoop / Leveranciers (uitgewerkt)

> **Skelet:** [agent-skeletons/inkoop-leveranciers.md](../agent-skeletons/inkoop-leveranciers.md) · **Volledig uitgewerkt:** [usecase-inkoop »](../usecase-inkoop/README.md)

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

## ✅ Meer-/minderwerk (uitgewerkt)

- **Doel:** signaleert afwijkingen t.o.v. contract/bestek en stelt een
  concept-onderbouwing (meer- of minderwerk) op met bronnen.
- **Kennis/data:** contract, bestek, wijzigingsverzoeken, actuele tekeningrevisies.
- **Tools:** geen (kennis / RAG). *(Registreren/beprijzen = latere automate-stap.)*
- **Autonomie:** augment, **mens beslist en beprijst**. **Let op:** signaleren ≠
  vaststellen; agent noemt **geen bedragen**.
- **Volledig uitgewerkt:** zie [usecase-meerminderwerk »](../usecase-meerminderwerk/README.md).

## ✅ Oplever & Kwaliteit (uitgewerkt)

> **Skelet:** [agent-skeletons/oplever-kwaliteit.md](../agent-skeletons/oplever-kwaliteit.md) · **Volledig uitgewerkt:** [usecase-oplever »](../usecase-oplever/README.md)

- **Doel:** helpt het oplever-/revisiedossier samen te stellen en restpunten te
  bewaken.
- **Kennis/data:** keuringen, revisies, foto's, restpuntenlijsten.
- **Tools (later):** restpunten opvragen, dossier samenstellen.
- **Autonomie:** augment.

---

## Hoe werk je een skelet verder uit?

Elk skelet doorloopt dezelfde route als de bestek-agent:
[stap 06 Agent-ontwerp](../../blueprint/06-agent-ontwerp/) →
[stap 07 Architectuur](../../blueprint/07-architectuur-en-integratie/) →
[stap 08 Bouwen & testen](../../blueprint/08-bouwen-en-testen/) →
[stap 09 Governance](../../blueprint/09-governance-en-adoptie/).
Gebruik de [agent-spec-template](../../blueprint/06-agent-ontwerp/template.md).
