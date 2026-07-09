# Skelet — Materialen-agent

1. **Doel** — Ondersteunt materiaal- en voorraadvragen: hoeveelheden, bestellijsten,
   voorraad en levertijden.
2. **Fase** — Werkvoorbereiding + uitvoering.
3. **Kennis/data** — *Automate:* **Field Service** producten, voorraad en
   magazijnen. *Augment:* materiaalstaten/hoeveelhedenstaten in SharePoint.
4. **Systemen** — **D365 Field Service** (products, inventory, warehouses);
   materiaalstaten in SharePoint.
5. **Tools/acties**
   - *Augment:* materiaal opzoeken, voorraad en levertijd checken, bestellijst
     samenvatten.
   - *Automate (later, met akkoord):* bestelregel voorstellen / voorraadmutatie.
6. **Autonomie & mens-in-de-loop** — *Augment → automate-met-controle*; bestellen
   pas na akkoord.
7. **Triggers / voorbeeldvragen** — *"Hebben we genoeg baksteen voor de gevel?"* ·
   *"Wat is de levertijd van de HR++-beglazing?"* · *"Toon de bestellijst voor de
   ruwbouw."*
8. **Mock-plan** — Tabel **`Materiaal`** / **`Voorraad`** (Dataverse) of
   SharePoint-lijst **"Materialen"**. Velden: *Artikel, Eenheid, Voorraad, Magazijn,
   Levertijd*. Voorbeeldrecords (De Beemster):
   | Artikel | Eenheid | Voorraad | Magazijn | Levertijd |
   |---|---|---|---|---|
   | Baksteen roodbruin genuanceerd | 1000 st | 24.000 | Centraal | 2 wkn |
   | HR++ beglazing | m² | 0 | — | 4 wkn |
   | Beton C30/37 | m³ | op bestelling | — | 1 dag |
9. **Status** — ✅ volledig uitgewerkt → [usecase-materialen](../usecase-materialen/README.md). Sluit aan
   op de bestaande **Materialen agent** in de demo-omgeving.
