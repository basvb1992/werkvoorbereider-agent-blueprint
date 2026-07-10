# Materialen & voorraad (FICTIEF) — Woongebouw "De Beemster"

> ⚠️ **FICTIEF EN ILLUSTRATIEF.** Verzonnen materiaal-/voorraaddata om de
> [Inkoop & Materialen-use-case](../referentie/usecase-inkoop-materialen/README.md) mee te oefenen.
> Bootst **Field Service** producten/voorraad/magazijnen na; in de demo als
> Dataverse-tabel **`Materiaal`** of SharePoint-lijst **"Materialen"**.

| Artikel | Eenheid | Voorraad | Magazijn | Levertijd | Nodig (De Beemster) |
|---|---|---|---|---|---|
| Baksteen roodbruin genuanceerd | 1000 st | 24.000 | Centraal | 2 wkn | 60.000 |
| Metselmortel | zak | 800 | Centraal | 1 wk | 650 |
| HR++ beglazing | m² | 0 | — | 4 wkn | 210 |
| Hardhouten kozijn 1.800×2.400 | st | 6 | Centraal | 5 wkn | 12 |
| Beton C30/37 | m³ | op bestelling | — | 1 dag | 140 |
| Wapeningsstaal | ton | 3 | Centraal | 1 wk | 2,4 |

> *Oefenpunten:*
> - **Baksteen:** voorraad 24.000 < behoefte 60.000 → tekort **signaleren**.
> - **HR++ beglazing:** voorraad 0, levertijd 4 wkn → tijdig bestellen i.v.m. gevel.
> - **Kozijnen:** slechts 6 op voorraad, nodig 12, levertijd 5 wkn → **kritiek** voor
>   de gevelplanning (raakt Planning-agent).
>
> Een goede Materialen-agent **signaleert** tekorten en levertijdrisico's en stelt
> een **concept**-bestellijst voor; hij **bestelt niet zelf** en **noemt geen
> prijzen** (dat doet de calculator/inkoop).
