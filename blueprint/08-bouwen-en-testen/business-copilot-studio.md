# 🟦 Business-spoor — Bouwen & testen in Copilot Studio

## Bouwen

1. Bouw de agent volgens stap 06–07 in de Copilot Studio UI (instructies, kennis,
   eventueel tools/connected agents).
2. Test interactief in het ingebouwde **Test-paneel** terwijl je bouwt.

## Testen (zonder publiceren)

Copilot Studio biedt evaluatie op **draft**-agents — publiceren is niet nodig:

- **Evaluate-tab:** importeer een testset (CSV) met vragen en verwachte antwoorden,
  kies graders (General quality, Compare meaning, Exact match, …), en draai de evaluatie.
- **Kies graders die passen bij de bouw-use-case:** *Compare meaning* voor eisen,
  en een strenge check op **bronvermelding** en op het **weigeren** van vragen
  buiten de bron.

> Skills die hierbij helpen: `create-eval-set` (genereer testset-CSV),
> `run-eval` (draai evaluatie op draft-agent), `analyze-evals` (analyseer
> geëxporteerde resultaten en stel YAML-fixes voor).

## De edit → test → verbeter-lus

1. Draai de evaluatie → bekijk fails.
2. Pas **instructies**, **kennis** of **tools** aan.
3. Draai opnieuw. Herhaal tot de drempel uit de [template](template.md) gehaald is.

## Promotie naar productie

- Verpak de agent in een **solution** en promoveer via een test- naar
  productieomgeving.
- **Let op:** vanwege de round-trip-beperking van moderne agents is de Copilot
  Studio UI + solutions de betrouwbare weg — niet `pac copilot push` van een
  gewijzigde moderne agent.

## Verwijzingen
- Evaluate-tab: <https://learn.microsoft.com/microsoft-copilot-studio/analytics-evaluate>
- Skills: `create-eval-set`, `run-eval`, `analyze-evals`, `run-tests-kit`

➡️ Verder naar [stap 09 — Governance & adoptie »](../09-governance-en-adoptie/)
