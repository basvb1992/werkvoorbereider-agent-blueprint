# Dataverse-ontwerp — overige automate-agents

Datamodel voor de resterende automate-agents van het Werkvoorbereider Agent Team:
**Planning**, **Mensen**, **Oplever & Kwaliteit** en **Meer-/minderwerk**. Zelfde
**platte** aanpak als [inkoop-dataverse-design.md](inkoop-dataverse-design.md)
(tekst/getal/memo, geen lookups/choices) — volledig scriptbaar en makkelijk voor de
agent-tools.

> **Klaarzetten:** [scaffold-agents-dataverse.ps1](scaffold-agents-dataverse.ps1)
> (idempotent, Web API) maakt alle tabellen + fictieve seed-data (project "De Beemster").
> Data is **fictief**; gebruik een demo-/test-omgeving.

## Tabellen (prefix `wvb_`)

### Planning — `wvb_projecttaak` (lezen; Planning bezit het schema)
Primair `wvb_naam` (taaknaam) · `wvb_taaknummer` · `wvb_fase` · `wvb_project` ·
`wvb_start` · `wvb_eind` · `wvb_gereed` (getal %) · `wvb_status` ·
`wvb_afhankelijkvan`. **Seed:** T01–T07 (T02 op 60%, kritiek-pad-oefening).

### Mensen — `wvb_medewerker` (lezen)
`wvb_naam` · `wvb_medewerkernummer` · `wvb_functie` · `wvb_certificaat` ·
`wvb_certificaatstatus` · `wvb_beschikbaarheid`. **Seed:** M01–M05 (M02 VCA verloopt wk 27).

### Mensen — `wvb_boeking` (lezen + **schrijven**: concept-boeking)
`wvb_naam` · `wvb_medewerker` · `wvb_project` · `wvb_weken` · `wvb_rol` ·
`wvb_status` (**Concept** bij de agent) · `wvb_toelichting`. **Seed:** 3 bevestigde boekingen.

### Oplever — `wvb_restpunt` (lezen + **schrijven**: status/concept)
`wvb_naam` · `wvb_restpuntnummer` · `wvb_locatie` · `wvb_omschrijving` ·
`wvb_status` · `wvb_verantwoordelijke`. **Seed:** R01–R04 (R01–R03 open).

### Oplever — `wvb_keuring` (lezen)
`wvb_naam` (onderdeel) · `wvb_resultaat` · `wvb_datum`. **Seed:** 3 keuringen
(woningscheidende wand = **nog uit te voeren**, blokkerend).

### Meer-/minderwerk — `wvb_wijzigingsverzoek` (lezen + **schrijven**: concept-onderbouwing)
`wvb_naam` (WV-nummer) · `wvb_omschrijving` · `wvb_aard` (Meerwerk/Minderwerk/Geen) ·
`wvb_status` · `wvb_onderbouwing` · `wvb_bron` · `wvb_aangevraagddoor`.
**Seed:** WV-2026-001 (meer), -002 (minder), -003 (geen — negatieve test).

## Schrijf-contracten (guardrails)

Elke schrijf-actie volgt hetzelfde principe als Inkoop: **mens-in-de-lus**.

| Agent | Schrijf-actie | Regel |
|---|---|---|
| Mensen | Concept-**boeking**/vervanging in `wvb_boeking` | status **Concept**; ná bevestiging; **plant/bevestigt niet** definitief |
| Oplever | Concept-**opleverdossier** / restpunt-notitie | signaleert blokkerende keuring; **verklaart nooit zelf opgeleverd** |
| Meer-/minderwerk | Concept-**onderbouwing** in `wvb_wijzigingsverzoek` | signaleert meer/minder/geen **met bron**; **verzint geen bedragen**; **stelt niet vast** |
| Planning | (optioneel) taak-voortgang bijwerken | signaleert kritiek-pad-risico; **verzet nooit zelf de opleverdatum** |

## Bouwen

De **agents + tools** bouw je in de Copilot Studio-UI (moderne agents; geen `pac
copilot push`). Per agent: één **List rows**-tool (lezen) + waar van toepassing één
**Add a new row** / **Update a row**-tool (schrijven, **met bevestiging**).
Zie de per-agent build-kits en het generieke [inkoop-agent-runbook.md](inkoop-agent-runbook.md).

> **Tip uit de Inkoop-bouw:** zet op de Dataverse-tools **Environment = AI** en
> **Table = AI** (de gepinde waarde "(Current)" gaf `null`), en geef de agent in de
> instructie de **logische tabel-/veldnamen** mee zodat hij niet hoeft te raden.
