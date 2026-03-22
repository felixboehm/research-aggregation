# Tests – Research Aggregation Plugin

## Test Approach

The plugin uses the eval framework from Anthropic's `skill-creator` (github.com/anthropics/skills/skills/skill-creator).

### Test Types

| Type | Files | Validates |
|---|---|---|
| **Trigger Tests** | `eval-sets/trigger.json`, `analyse-trigger.json`, `synthesis-trigger.json` | Skills trigger on correct prompts, not on incorrect ones |
| **Content Tests** | `eval-sets/research-content.json`, `synthese.json` | Correct extraction of concepts, edges, combinations |
| **Structure Validation** | `validate.sh` | YAML syntax, required fields, edge types, referential integrity |

### Test Fixtures

3 mini knowledge documents about "Coffee Shop Business Strategy":
- `fixtures/wissen-a.md` – Location Strategy (foot traffic, rent costs, visibility)
- `fixtures/wissen-b.md` – Menu Optimization (pricing, cost of goods, seasonal items)
- `fixtures/wissen-c.md` – Combined Strategy (location affects menu pricing, synergies, conflicts)

### Expectations

- `erwartungen/graph.yaml` – Expected nodes and edges
- `erwartungen/zwicky.yaml` – Expected dimensions and gaps
- `erwartungen/kombinationen.md` – Expected combinations and conflicts

### Running Tests

```bash
# Structure validation
bash tests/validate.sh synthesis/

# Trigger tests (per skill)
python -m scripts.run_eval --eval-set tests/eval-sets/trigger.json --skill-path skills/research/
python -m scripts.run_eval --eval-set tests/eval-sets/analyse-trigger.json --skill-path skills/analyse/
python -m scripts.run_eval --eval-set tests/eval-sets/synthesis-trigger.json --skill-path skills/synthesis/

# Content tests
python -m scripts.run_eval --eval-set tests/eval-sets/research-content.json --skill-path skills/research/
python -m scripts.run_eval --eval-set tests/eval-sets/synthese.json --skill-path skills/synthesis/
```
