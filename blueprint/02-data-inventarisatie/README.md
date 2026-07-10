# Stap 02 — Data-inventarisatie

> **Resultaat van deze stap:** een *data-register* dat per databron vastlegt wat
> het is, waar het staat, welk formaat en hoe gevoelig.

## Doel

Een agent is zo goed als de data die hij mag gebruiken. Breng in kaart welke
data de taken uit [stap 01](../01-rol-en-taakanalyse/) raken. Het onderscheid
**gestructureerd vs. ongestructureerd** is bepalend:

- **Ongestructureerd** (bestek-PDF, tekeningen, mail, notulen) → geschikt als
  *kennisbron* (de agent zoekt en vat samen, met bronvermelding).
- **Gestructureerd** (ERP-records, begroting, planning) → geschikt voor *acties*
  (de agent leest/schrijft records via een koppeling).

## De 8 datacategorieën van de werkvoorbereider

Loop ze langs en noteer wat voor jou relevant is:

| # | Categorie | Voorbeelden |
|---|---|---|
| A | Ontwerp & contract | Bestek (STABU/RAW), tekeningen, BIM/IFC, contract & voorwaarden, contractplanning |
| B | Calculatie & kosten | Inschrijf-/werkbegroting, eenheidsprijzen, meer-/minderwerk |
| C | Hoeveelheden & materiaal | Hoeveelhedenstaat, stuklijsten, wapening-/zaagstaten, bestellijsten |
| D | Inkoop & partners | Leveranciers/onderaannemers, offertes, raamcontracten, inkoopschema |
| E | Planning & voortgang | Uitvoerings-/weekplanning, leverschema, mijlpalen, voortgangsrapportages |
| F | Regelgeving & compliance | Bbl/Bouwbesluit, NEN, omgevingsvergunning, RI&E/V&G, BENG/MPG/stikstof |
| G | Uitvoering & bouwplaats | Werkbonnen, uren, dagrapporten, keuringen, foto's, restpunten |
| H | Communicatie & administratie | Mail, notulen, wijzigingsverzoeken, correspondentie directie |

## Invulvragen (per databron)

1. **Bron** — Welke data? (bv. "bestek", "materiaalstaat")
2. **Categorie** — A t/m H.
3. **Locatie** — Waar staat het? (SharePoint, ERP, Excel op schijf, mailbox, BIM-server)
4. **Formaat** — PDF, DWG, IFC, Excel, database, mail.
5. **Structuur** — Gestructureerd / semi / ongestructureerd.
6. **Kwaliteit** — Actueel, compleet, betrouwbaar? Revisiebeheer?
7. **Toegankelijkheid** — Kan de agent erbij? (API, export, alleen handmatig)
8. **Gevoeligheid** — Vertrouwelijk (prijzen, contracten, persoonsgegevens)? Wie mag dit zien?

## Voorbeeld uit de bouw

> Voor de use-case "bestek doorzoeken" zijn de relevante bronnen: **bestek**
> (categorie A, PDF, ongestructureerd, in SharePoint, vertrouwelijk),
> **tekeningen** (A, PDF/DWG, ongestructureerd, in Bouwapp), en **contract**
> (A, PDF). Kwaliteit is wisselend: revisies van tekeningen worden niet altijd
> netjes bijgehouden — belangrijk aandachtspunt, want de agent mag nooit een
> verouderde revisie als waarheid presenteren.

## Valkuilen

- **Vervuilde kennisbron.** Verouderde revisies of dubbele documenten leiden tot
  foute antwoorden. Ruim op vóór je indexeert.
- **Gevoeligheid onderschat.** Prijzen, onderaannemerscontracten en
  persoonsgegevens vragen om toegangsbeperking (zie [stap 07](../07-architectuur-en-integratie/)).
- **"Alles indexeren".** Meer data ≠ beter. Begin met de bronnen die de gekozen
  use-case echt nodig heeft.

> **Data-design & RAG:** voor kennisbron-keuze (SharePoint/Dataverse/connectors),
> freshness, security-trimming en Dataverse-synonyms/glossary — zie
> [best-practices/data-design.md](../../best-practices/data-design.md).

## Ingevuld referentievoorbeeld

Zie het data-register in
[referentie/usecase-bestek/README.md](../../referentie/usecase-bestek/README.md#stap-02--data)
en het fictieve bronmateriaal in [voorbeelddata/](../../voorbeelddata/).

---

➡️ Vul de [template](template.md) in en ga door naar
[stap 03 — Systeem-inventarisatie »](../03-systeem-inventarisatie/)
