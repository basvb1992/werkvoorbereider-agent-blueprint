# Multi-agent orchestration — principes & checklist

Onze **Project Coach + 6 kern-sub-agents + Mensen-service** volgen de Microsoft
multi-agent best practices. Bron:
[Multi-agent orchestration patterns and best practices](https://learn.microsoft.com/microsoft-copilot-studio/guidance/multi-agent-patterns)
(bijgewerkt mei 2026).

> **Laatst getoetst:** 2026-07-10.

## De 9 principes

1. **Single-response principle** — alleen de **parent (Project Coach)** antwoordt de
   gebruiker. Sub-agents zijn *onderzoekers*, geen *responders*.
2. **Sub-agent verklaart zijn rol** — elke sub-agent-instructie bevat: *"Je bent een
   sub-agent. Antwoord NIET direct aan de gebruiker; geef je bevindingen terug aan de
   Project Coach."*
3. **Strakke directive taal** — gebruik **MUST / NEVER / ONLY** (zachte taal verliest
   het van systeeminstructies).
4. **1 kennisbron per sub-agent, geen overlap** — anders vindt de één het antwoord en
   voegt de ander niets toe. *(Reden dat we Materialen + Inkoop samenvoegden.)*
5. **Distinct, niet-overlappende descriptions** — zodat de orchestrator correct routeert.
6. **Parent definieert het volledige patroon** — *invoke → wait → combine → respond*.
7. **Parent geeft "geen direct antwoord" mee** in de gedelegeerde taakcontext.
8. **Test met domain-mismatch** — vraag iets buiten elk domein; controleer dat het
   netjes "niet gevonden" oplevert.
9. **Ask vs. inform** — gebruik *ask* als je een antwoord verwacht; *inform* alleen
   voor een eenrichtings-eindbericht.

## Toegepast op de Project Coach

**Project Coach (parent) — instructie (kern):**
```
Jij bent de ENIGE agent die met de gebruiker communiceert.
- Herken het domein van de vraag en delegeer naar de juiste sub-agent
  (invoke → wait → combine → respond).
- Combineer bevindingen tot ÉÉN antwoord. Sub-agents antwoorden NOOIT direct.
- Bij twijfel of buiten elk domein: stel een verduidelijkende vraag; verzin niets.
```

**Elke sub-agent — verplichte rol-declaratie (toevoegen bovenaan de instructies):**
```
Je bent een SUB-AGENT onder de Project Coach.
- Antwoord NOOIT direct aan de gebruiker.
- Doe je werk (zoeken/analyseren binnen jouw domein) en geef je bevindingen
  (met bron) terug aan de Project Coach; die combineert en antwoordt.
```

> In [Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/authoring-add-other-agents)
> zijn dit **connected agents**; de description per sub-agent moet distinct zijn zodat
> routing klopt.

## Quick-reference checklist

- [ ] Parent-instructie: "alleen ik antwoord de gebruiker".
- [ ] Elke sub-agent: "antwoord niet direct".
- [ ] Directive taal (MUST/NEVER/ONLY).
- [ ] Elke sub-agent een unieke, niet-overlappende kennisbron/description.
- [ ] Parent definieert invoke → wait → combine → respond.
- [ ] Getest met domain-mismatch-vragen.
- [ ] Ask vs. inform correct.

## Wanneer splitsen (of juist niet)

- **Splits** bij: apart kennis/tools-domein, andere governance/access, herbruik als
  service, of >30–40 tools/keuzes in de main agent.
- **Niet splitsen** bij overlappende domeinen → dat gaf bij ons routing-verwarring
  (Materialen vs. Inkoop). Zie de
  [decompositie-verantwoording](../referentie/project-coach/architectuur.md#decompositie-verantwoording).
