# Het ROCKET-principe (voor agent-instructies)

Bij het ontwerpen van de **instructies** van elke agent (blueprint
[stap 06](../blueprint/06-agent-ontwerp/)) gebruiken we **ROCKET** als vast
stramien. Zo zijn de instructies compleet, consistent en toetsbaar.

| Letter | Staat voor | Vraag die het beantwoordt |
|---|---|---|
| **R** | **Role** | Wie is de agent? Welke rol/expertise/persona? |
| **O** | **Objective** | Wat is de concrete opdracht/het doel? |
| **C** | **Context** | Op welke projectcontext, kennisbronnen en systemen baseert de agent zich? |
| **K** | **Key results** | Wat is een goed resultaat? (bronvermelding, geen gok, meetbare output) |
| **E** | **Examples** | Voorbeelden én randgevallen — inclusief wat de agent **niet** doet. |
| **T** | **Tone** | Taal, toon en stijl (NL, bouwtaal, zakelijk, met bronnen). |

> **Let op — interpretatie.** Dit is de gehanteerde invulling van ROCKET. Hanteert
> jouw organisatie een andere betekenis van de letters? Pas hem **hier centraal**
> aan; de use-cases verwijzen naar dit document.

## Aanvullende regels (Microsoft-guidance)

Naast ROCKET gelden de Copilot Studio instructie-best-practices
([bron](https://learn.microsoft.com/microsoft-copilot-studio/guidance/generative-mode-guidance)):

- Gebruik **exacte toolnamen**; beschrijf **kennisbronnen generiek** (niet hard opnoemen).
- Definieer de **volgorde van acties** bij multistep; voeg expliciet **"must not do"** toe.
- Gebruik **directive taal** (MUST/NEVER/ONLY); behandel instructies **als code**
  (bouw incrementeel op, test tussendoor).

**In een multi-agent-opstelling** krijgt elke sub-agent bovenaan een rol-declaratie
(*"Je bent een sub-agent; antwoord niet direct aan de gebruiker"*). Zie
[multi-agent-orchestration](../best-practices/multi-agent-orchestration.md).

Elke uitgewerkte use-case structureert het instructie-blok in stap 06 volgens deze
zes elementen. Zie bijvoorbeeld
[usecase-planning](usecase-planning/README.md#stap-06--agent-ontwerp).
