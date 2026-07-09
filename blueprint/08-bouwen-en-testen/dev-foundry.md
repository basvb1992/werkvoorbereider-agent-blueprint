# 🟩 Dev-spoor — Bouwen & testen in Foundry

## Bouwen

1. Implementeer de agent(s) als `agent.yaml` + tools (stap 06–07).
2. Run lokaal en itereer op instructies en tools (zie skill
   **vscode-microsoft-foundry** voor de lokale run-/debug-loop).

## Testen: batch-evaluatie

Foundry ondersteunt **batch-evaluatie** met een dataset en graders:

- Stel een **eval-dataset** samen (de testset uit de [template](template.md)):
  vraag → verwacht antwoord/gedrag.
- Kies **graders**: relevantie/juistheid, groundedness (baseert de agent zich op
  de bron?), en een custom grader die **bronvermelding** en het **weigeren** van
  out-of-source-vragen afdwingt.
- Draai de evaluatie, bekijk scores per case, en itereer.

> Voor de bouw is **groundedness** de belangrijkste grader: meet of het antwoord
> daadwerkelijk uit het bestek/de tekening komt en niet verzonnen is.

## Continue evaluatie

- Zet **continuous evaluation / monitoring** op productie-traces (zie skill
  **microsoft-foundry**) zodat je regressies en hallucinaties in het echt vangt.
- Overweeg de **prompt optimizer / agent optimizer** om instructies te verbeteren
  op basis van faalgevallen.

## Deploy

- Deploy via `azd` (hosted agent). Houd prompts, tools en eval-datasets in de repo.

## Verwijzingen
- Skill: `microsoft-foundry` (batch eval, continuous eval, graders, prompt optimizer, deploy)
- Skill: `vscode-microsoft-foundry` (lokale ontwikkel-/testloop)

➡️ Verder naar [stap 09 — Governance & adoptie »](../09-governance-en-adoptie/)
