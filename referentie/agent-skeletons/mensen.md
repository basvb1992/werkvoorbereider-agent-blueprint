# Skelet — Mensen-agent

1. **Doel** — Ondersteunt bemensing: beschikbaarheid, certificaten,
   planningsconflicten en vervanging.
2. **Fase** — Werkvoorbereiding + uitvoering.
3. **Kennis/data** — *Automate:* **Field Service** bookable resources + bookings +
   schedule board. Certificatenregister (Dataverse/SharePoint).
4. **Systemen** — **D365 Field Service** (bookable resources, bookings, schedule
   board, RSO); certificaten in Dataverse of SharePoint.
5. **Tools/acties**
   - *Augment:* zoek beschikbare medewerker, zoek (bijna) verlopen certificaten,
     signaleer planningsconflict.
   - *Automate (met controle):* vervangingsverzoek of boeking als **concept**.
6. **Autonomie & mens-in-de-loop** — *Augment → automate-met-controle*; boekingen/
   vervanging pas na akkoord.
7. **Triggers / voorbeeldvragen** — *"Wie is beschikbaar voor de ruwbouw in week
   26?"* · *"Welke VCA-certificaten verlopen binnenkort?"* · *"Zoek vervanging voor
   Jan (ziek)."*
8. **Mock-plan** — Tabel **`Medewerker`** + **`Boeking`** (Dataverse) of
   SharePoint-lijsten. Velden medewerker: *Naam, Functie, Certificaten,
   Beschikbaar van–tot*. Voorbeeldrecords (fictief):
   | Naam | Functie | Certificaten | Beschikbaar |
   |---|---|---|---|
   | Jan de Vries | Timmerman | VCA (geldig) | wk 24–30 |
   | Piet Bakker | Metselaar | VCA (verloopt wk 27) | wk 25–34 |
   | Sanne Willems | Uitvoerder | VCA-VOL | wk 24–40 |
9. **Status** — ✅ volledig uitgewerkt → [usecase-mensen](../usecase-mensen/README.md). Sluit aan
   op de bestaande **Mensen agent 2.0** in de demo-omgeving.
