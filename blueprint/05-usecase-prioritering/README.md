# Stap 05 — Use-case prioritering

> **Resultaat van deze stap:** een *prioriteitsmatrix* en de keuze van 1–3
> use-cases om mee te starten.

## Doel

Je hebt nu taken (stap 01), data (02), systemen (03) en processen (04). Tijd om
te kiezen **waar je begint**. Niet alles tegelijk: kies use-cases met hoge
**waarde** en hoge **haalbaarheid** — de quick wins.

## Scoren op twee assen

Geef elke kandidaat-use-case een score 1–5 op:

**Waarde** — hoeveel levert het op?
- Tijdsbesparing × frequentie × aantal WVB's
- Kwaliteit / minder faalkosten
- Risicoreductie (gemiste eis, te weinig materiaal)

**Haalbaarheid** — hoe makkelijk te bouwen?
- Is de data beschikbaar en schoon? (stap 02)
- Is er een koppeling? (stap 03) — *kennisbron* is makkelijker dan *actie*
- Augment (makkelijker) vs. automate (moeilijker, meer governance)

```mermaid
quadrantChart
  title Waarde vs. Haalbaarheid
  x-axis Lage haalbaarheid --> Hoge haalbaarheid
  y-axis Lage waarde --> Hoge waarde
  quadrant-1 Quick wins (start hier)
  quadrant-2 Grote projecten (later)
  quadrant-3 Vermijden
  quadrant-4 Nice to have
  Bestek doorzoeken: [0.8, 0.85]
  Bouwbesluit Q&A: [0.75, 0.7]
  Inkoopschema genereren: [0.45, 0.8]
  Meer-/minderwerk: [0.4, 0.75]
  Opleverdossier: [0.55, 0.5]
```

## Invulvragen

1. **Kandidaten** — Welke use-cases volgen uit stap 01 en 04?
2. **Waarde-score** — 1–5, met korte onderbouwing.
3. **Haalbaarheid-score** — 1–5, met korte onderbouwing.
4. **Type** — Augment of automate?
5. **Startkeuze** — Welke 1–3 begin je mee? Waarom?

## Voorbeeld uit de bouw

> Kandidaten: bestek doorzoeken (W5/H4), Bouwbesluit-Q&A (W4/H4), inkoopschema
> genereren (W5/H2 — koppeling nog niet klaar), meer-/minderwerk (W4/H2).
> **Startkeuze:** begin met **"bestek doorzoeken & eisen samenvatten"** — hoogste
> waarde, goed haalbaar (kennisbron, augment, geen schrijfkoppeling). Bouwbesluit-Q&A
> als tweede. Inkoopschema volgt zodra de 4PS/Dataverse-koppeling er is.

## Valkuilen

- **Beginnen met automate.** Automatiseren zonder eerst vertrouwen op te bouwen
  met augment loopt vaak stuk op governance en data-kwaliteit.
- **Te veel tegelijk.** Eén goede eerste use-case > vijf halve.
- **Waarde niet onderbouwd.** Zonder cijfers uit stap 01 wordt prioritering een
  onderbuikgevoel.

## Ingevuld referentievoorbeeld

Onze rode draad kiest **"bestek doorzoeken & eisen samenvatten"** als eerste,
volledig uitgewerkt in [referentie/usecase-bestek/](../../referentie/usecase-bestek/).
De bredere set (alle sub-agents) staat in
[referentie/project-coach/sub-agents.md](../../referentie/project-coach/sub-agents.md).

---

➡️ Vul de [template](template.md) in en ga door naar
[stap 06 — Agent-ontwerp »](../06-agent-ontwerp/)
