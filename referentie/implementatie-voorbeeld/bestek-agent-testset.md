# Testset — Bestek & Tekeningen-agent

Gebruik deze set in het **Test**-paneel of importeer hem in de **Evaluate**-tab.
Negatieve tests zijn bewust inbegrepen: de agent hoort dan te zeggen dat iets niet
in de bron staat, in plaats van te gokken.

| # | Vraag | Verwacht gedrag | Grader |
|---|---|---|---|
| 1 | Wat is de eis voor brandwerendheid van de woningscheidende wanden? | Correcte WBDBO-eis + bron (bestek §..) | betekenis + bron |
| 2 | Welke Rc-waarde geldt voor de gevel? | Correcte Rc-waarde + bron | betekenis + bron |
| 3 | Wat is de vereiste geluidsisolatie tussen woningen? | Correcte waarde + bron | feit + bron |
| 4 | Welke tegelkleur is voorgeschreven in de badkamer? | "Niet gevonden in het bestek" (indien afwezig) | weigering |
| 5 | Vat alle eisen over de fundering samen | Genummerde lijst met bronnen | betekenis + bron |
| 6 | Klopt de kozijnmaat op tekening met het bestek? | Signaleert (on)gelijkheid, noemt beide bronnen | betekenis |
| 7 | Geef de complete eisenlijst voor dit project | Genummerde, gegroepeerde lijst met bronnen | betekenis + bron |
| 8 | Wie is de aannemer van het naastgelegen project? | "Niet gevonden in de bron" (staat niet in bestek) | weigering |

## Slaag-criteria

- **≥90%** inhoudelijk correct (vragen 1–3, 5–7).
- **100%** bronvermelding bij inhoudelijke antwoorden.
- **0 hallucinaties** op de negatieve tests (4 en 8) — de agent gokt niet.

## Tips

- Test ook **doorvragen** (multi-turn): stel na vraag 5 *"en welke daarvan raken de
  wapening?"* en controleer of de agent de context vasthoudt, met bron.
- Noteer per run de score en herhaal na elke instructie- of kennis-wijziging
  (regressietest).
- De verwachte waarden komen uit het fictieve
  [bestek](../../voorbeelddata/bestek-fictief-project.md) en de
  [tekeninglijst](../../voorbeelddata/tekeninglijst.md); pas ze aan als je eigen
  bronmateriaal gebruikt.
