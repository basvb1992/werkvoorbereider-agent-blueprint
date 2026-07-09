# Template — Agent-spec (stap 06)

> Eén spec per agent (of sub-agent). Herhaal voor elke agent in je systeem.

## Agent: <naam>

### 1. Doel & scope
- **Doet wél:** <...>
- **Doet niet:** <...>

### 2. Instructies (systeeminstructie / gedrag)
> Schrijf de instructie zoals de agent hem krijgt. Denk aan: taal, toon,
> verplichte bronvermelding, wat te doen bij twijfel, wat NOOIT te doen.
```
<instructie-tekst>
```

### 3. Kennis (knowledge sources)
| Bron | Formaat | Locatie | Opmerking |
|---|---|---|---|
| <bestek> | PDF | SharePoint | alleen laatste revisie |

### 4. Tools / acties
| Actie | Systeem | Lezen/schrijven | Mens-akkoord nodig? |
|---|---|---|---|
| <geen / record aanmaken> | <ERP> | <schrijven> | <ja> |

### 5. Triggers
- <hoe wordt de agent aangeroepen? vraag van gebruiker / conversation starter / door orchestrator>

### 6. Autonomie & mens-in-de-loop
- **Niveau:** < augment (mens beslist) | automate met controle | automate >
- **Controlemoment:** <waar keurt een mens goed?>

### Positie in het systeem
- [ ] Zelfstandige agent
- [ ] Sub-agent onder orchestrator (<Project Coach>)

### Gekozen spoor
- [ ] 🟦 Copilot Studio  · [ ] 🟩 Foundry
