# Skelet — Planning-agent

1. **Doel** — Helpt de uitvoeringsplanning opstellen en bewaken; signaleert
   mijlpalen, kritieke pad en afwijkingen.
2. **Fase** — Werkvoorbereiding + uitvoering.
3. **Kennis/data** — *Automate:* projectplanning in **Project Operations** (WBS,
   taken, mijlpalen, %-gereed). *Augment (optioneel):* planningsexport/weekplanning
   in SharePoint.
4. **Systemen** — **D365 Project Operations** (projecten, projecttaken/WBS,
   mijlpalen); raakvlak **Field Service** schedule board (bemensing).
5. **Tools/acties**
   - *Augment:* planning lezen, komende mijlpalen/kritieke pad tonen, weekstatus
     samenvatten, afwijking t.o.v. baseline signaleren.
   - *Automate (later, met akkoord):* taakstatus/%-gereed of einddatum bijwerken.
6. **Autonomie & mens-in-de-loop** — *Augment*; planning bijwerken alleen met
   expliciet akkoord van de WVB/planner.
7. **Triggers / voorbeeldvragen** — *"Loopt de ruwbouw op schema?"* · *"Welke
   mijlpalen komen de komende 2 weken?"* · *"Waar zit vertraging in de planning?"*
8. **Mock-plan** — Tabel **`Projecttaak`** (Dataverse) of SharePoint-lijst
   **"Projecttaken"**. Velden: *Taak, Fase, Start, Eind, %gereed, Status,
   Afhankelijk van*. Voorbeeldrecords (De Beemster):
   | Taak | Fase | Start | Eind | %gereed | Status |
   |---|---|---|---|---|---|
   | Fundering | Ruwbouw | 06-01 | 06-14 | 100% | Gereed |
   | Wanden begane grond | Ruwbouw | 06-16 | 06-30 | 60% | In uitvoering |
   | Gevel + kozijnen | Gevel | 07-01 | 07-18 | 0% | Gepland |
   | Afbouw | Afbouw | 07-21 | 08-15 | 0% | Gepland |
   | Oplevering | Oplevering | 08-18 | 08-22 | 0% | Gepland |
9. **Status** — 🟡 skelet (nog geen diepe use-case). Uit te werken via
   [blueprint 06–08](../../blueprint/06-agent-ontwerp/).
