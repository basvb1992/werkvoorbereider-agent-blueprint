# Skelet — Inkoop / Leveranciers-agent

1. **Doel** — Ondersteunt het inkoopproces: offertes aanvragen en vergelijken,
   onderaannemers selecteren.
2. **Fase** — Werkvoorbereiding.
3. **Kennis/data** — *Augment:* offertes (PDF) en raamcontracten in SharePoint.
   *Automate:* leveranciers en project-inkoop/estimates in **Project Operations**.
4. **Systemen** — **D365 Project Operations** (project-inkoop, estimates);
   leveranciers/onderaannemers in Dataverse.
5. **Tools/acties**
   - *Augment:* offerteaanvraag als concept opstellen, offertes normaliseren en
     vergelijken (kwalitatief), leveranciers per discipline opzoeken.
   - *Automate (later, met akkoord):* inkoopaanvraag/PO registreren.
6. **Autonomie & mens-in-de-loop** — *Augment*; de mens **gunt** en bestelt.
   Bedragen worden **niet verzonnen** — beprijzing via calculator/eenheidsprijzen.
7. **Triggers / voorbeeldvragen** — *"Vergelijk de offertes voor de kozijnen."* ·
   *"Stel een offerteaanvraag op voor het metselwerk."* · *"Welke leveranciers
   hebben we voor beglazing?"*
8. **Mock-plan** — SharePoint-lijsten **"Leveranciers"** + **"Offertes"** (of
   Dataverse). Velden leverancier: *Naam, Discipline, Contact, Raamcontract*.
   Velden offerte: *Leverancier, Post, Bedrag (FICTIEF), Geldig tot*.
   Voorbeeldrecords (fictief):
   | Leverancier | Discipline | Raamcontract |
   |---|---|---|
   | Kozijnfabriek Noord | Kozijnen | Ja |
   | Metselbedrijf Zuid | Metselwerk | Nee |
   | GlasCentrale BV | Beglazing | Ja |
9. **Status** — 🟡 skelet (nog geen diepe use-case). Uit te werken via
   [blueprint 06–08](../../blueprint/06-agent-ontwerp/).
