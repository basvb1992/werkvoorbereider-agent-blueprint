# Voorbeelddata — fictief bouwproject

Dit is **fictief** oefenmateriaal voor een klein B&U-project, bedoeld om de
blueprint en de [bestek-use-case](../referentie/usecase-bestek/README.md) mee te
oefenen. Alle gegevens zijn verzonnen.

> ⚠️ **Niet gebruiken als echte eisen.** Waarden zijn illustratief en niet
> getoetst aan actuele regelgeving.

## Project

- **Naam:** Woongebouw "De Beemster" — 12 appartementen
- **Opdrachtgever:** (fictief) Woonstichting Noord
- **Contractvorm:** UAV 2012, traditioneel
- **Segment:** B&U-woningbouw

## Bestanden

| Bestand | Wat |
|---|---|
| [bestek-fictief-project.md](bestek-fictief-project.md) | Uittreksel uit het (fictieve) bestek met technische eisen |
| [tekeninglijst.md](tekeninglijst.md) | Tekeningregister met revisies (let op revisiebeheer!) |
| [bbl-fictief.md](bbl-fictief.md) | **Fictieve** Bbl-stijl bouwtechnische eisen (voor de compliance-use-case) |
| [normenregister.md](normenregister.md) | Illustratief NEN-normenregister (alleen verwijzingen; **auteursrecht-notitie**) |

## Hoe gebruik je dit?

1. Neem [bestek-fictief-project.md](bestek-fictief-project.md) als **kennisbron**
   voor een test-agent (upload als bestand, of koppel als knowledge source).
2. Gebruik de testset uit
   [usecase-bestek](../referentie/usecase-bestek/README.md#stap-08--testen) —
   de vragen daar zijn beantwoordbaar met dit bestek.
3. Controleer of de agent **de juiste bron + paragraaf** noemt en bij vraag 4
   ("tegelkleur badkamer") netjes zegt dat het **niet in het bestek staat**.

## Voor de compliance-use-case

1. Neem [bbl-fictief.md](bbl-fictief.md) en [normenregister.md](normenregister.md)
   als **kennisbron** (naast het bestek) voor een test-agent.
2. Gebruik de testset uit
   [usecase-compliance](../referentie/usecase-compliance/README.md#stap-08--testen).
3. Let op de **negatieve tests**: de agent moet (a) NEN-normtekst **weigeren** te
   reproduceren (auteursrecht), (b) bij een versievraag **niet gokken** maar naar
   het bevoegd gezag verwijzen, en (c) een ontbrekende bepaling in het bestek
   **signaleren** in plaats van verzinnen. Elk inhoudelijk antwoord moet
   **bron + artikel + versie** noemen.

> ⚠️ **Auteursrecht & fictie.** `bbl-fictief.md` is verzonnen en niet getoetst;
> het normenregister bevat **geen** normtekst. Gebruik dit uitsluitend als oefening.
