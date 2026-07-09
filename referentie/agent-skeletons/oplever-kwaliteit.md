# Skelet — Oplever & Kwaliteit-agent

1. **Doel** — Helpt het oplever-/revisiedossier samenstellen en restpunten en
   keuringen bewaken.
2. **Fase** — Uitvoering + oplevering.
3. **Kennis/data** — *Automate:* **Field Service** werkorders, service tasks,
   inspecties en customer assets. *Augment:* keuringen, foto's en restpuntenlijsten
   in SharePoint.
4. **Systemen** — **D365 Field Service** (work orders, service tasks, inspections,
   customer assets); restpunten/keuringen in Dataverse of SharePoint.
5. **Tools/acties**
   - *Augment:* open restpunten opvragen, keuringstatus samenvatten, opleverdossier
     samenstellen (met bronnen).
   - *Automate (later, met akkoord):* restpunt/keuring/werkorder vastleggen.
6. **Autonomie & mens-in-de-loop** — *Augment*; vastleggen pas na akkoord van de
   WVB/KAM.
7. **Triggers / voorbeeldvragen** — *"Welke restpunten staan nog open?"* · *"Zijn
   alle keuringen afgerond?"* · *"Stel het opleverdossier voor blok A samen."*
8. **Mock-plan** — Tabel **`Restpunt`** + **`Keuring`** (Dataverse) of
   SharePoint-lijsten. Velden restpunt: *Locatie, Omschrijving, Status,
   Verantwoordelijke, Foto*. Voorbeeldrecords (De Beemster):
   | Locatie | Omschrijving | Status | Verantwoordelijke |
   |---|---|---|---|
   | App. 1.2 woonkamer | Kras op kozijn | Open | Timmerman |
   | Fundering | Keuring wapening | Akkoord | Constructeur |
   | Trappenhuis | Schilderwerk onvolledig | Open | Schilder |
9. **Status** — 🟡 skelet (nog geen diepe use-case). Uit te werken via
   [blueprint 06–08](../../blueprint/06-agent-ontwerp/).
