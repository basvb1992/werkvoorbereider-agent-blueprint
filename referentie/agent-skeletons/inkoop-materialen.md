# Skelet — Inkoop & Materialen-agent

> Samenvoeging van de voormalige **Materialen**- en **Inkoop/Leveranciers**-skeletons
> (één inkoop-/materiaaldomein). Zie de
> [decompositie-verantwoording](../project-coach/architectuur.md#decompositie-verantwoording).

1. **Doel** — Ondersteunt het volledige inkoop-/materiaalproces: behoefte,
   voorraad, levertijd, offertes en leveranciers.
2. **Fase** — Werkvoorbereiding + uitvoering.
3. **Kennis/data** — *Automate:* **Field Service** producten/voorraad/magazijnen +
   **Project Operations** leveranciers/inkoop/estimates. *Augment:* materiaalstaten en
   offertes in SharePoint.
4. **Systemen** — **D365 Field Service** (voorraad) + **D365 Project Operations**
   (inkoop/estimates/leveranciers); offertes/materiaalstaten in SharePoint.
5. **Tools/acties**
   - *Augment:* voorraad/levertijd checken, tekort signaleren, offertes normaliseren
     en vergelijken, concept-bestellijst/offerteaanvraag opstellen.
   - *Automate (later, met akkoord):* bestelregel/PO registreren.
6. **Autonomie & mens-in-de-loop** — *Augment*; de mens **gunt en bestelt**. De agent
   **noemt geen prijzen** (calculator/inkoop beprijst).
7. **Triggers / voorbeeldvragen** — *"Hebben we genoeg baksteen voor de gevel?"* ·
   *"Wat is de levertijd van de kozijnen?"* · *"Vergelijk de kozijnoffertes."*
8. **Mock-plan** — Tabellen **`Materiaal`** (Field Service) + **`Leverancier`** /
   **`Offerte`** (Project Operations/SharePoint). Zie
   [materialen-voorraad](../../voorbeelddata/materialen-voorraad-fictief.md) en
   [offertes-leveranciers](../../voorbeelddata/offertes-leveranciers-fictief.md).
9. **Status** — ✅ volledig uitgewerkt → [usecase-inkoop-materialen](../usecase-inkoop-materialen/README.md).
   Sluit aan op de bestaande **Materialen agent** in de demo-omgeving.
