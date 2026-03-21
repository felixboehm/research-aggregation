# Research Aggregation

Claude Code Plugin for systematic knowledge aggregation and synthesis.

## What It Does

From a collection of isolated knowledge documents, systematically:
- **Discover connections** (Knowledge Graph with 6 relationship types)
- **Check completeness** (Morphological Box / Zwicky Box)
- **Find gaps** (prioritized research questions)
- **Calculate combinations** (multi-strategy worked examples)
- **Derive decision aids** (Decision Trees)

## Installation

```bash
# Install as plugin
claude plugin install research-aggregation

# Or for development
claude --plugin-dir /path/to/research-aggregation
```

## Usage

```
/research              → Show status + suggest next step
/research breadth      → Phase 1: Aggregate knowledge base
/research depth TOPIC  → Phase 2: Deep-dive into a topic
/research synthesis    → Phase 3: Combinations + Decision Trees
/research gaps         → Show gap matrix
/research combi A+B    → Calculate a specific combination
```

## 3-Phase Pipeline

```
Phase 1: BREADTH         Phase 2: DEPTH           Phase 3: SYNTHESIS
┌──────────────┐    ┌──────────────┐    ┌──────────────────────┐
│ Read         │    │ Research     │    │ Graph Analysis       │
│ documents    │    │ gaps         │    │ Cross-Impact         │
│              │    │              │    │ Combinations         │
│ → Graph      │    │ → Deeper     │    │ Decision Trees       │
│ → Zwicky     │    │   documents  │    │                      │
│ → Gaps       │    │ → Extend     │    │ → New Insights       │
│              │    │   graph      │    │ → Strategies         │
└──────────────┘    └──────────────┘    └──────────────────────┘
```

## Outputs

All results under `synthesis/` in the target project:

| Directory | Content |
|---|---|
| `graph/` | Knowledge Graph (nodes.yaml, edges.yaml) |
| `zwicky/` | Morphological Box (dimensions + cells) |
| `combinations/` | Calculated multi-strategy combinations |
| `decision-trees/` | Decision trees |
| `gaps/` | Gap matrix + research questions |
| `runs/` | Run history (deltas, insights, sources) |

## Scientific Methods

- **Morphological Analysis** (Fritz Zwicky) – Systematic combination matrix
- **Knowledge Graph** – Concepts + relationships (6 edge types)
- **Cross-Impact Analysis** (Gordon/Helmer) – Lever and indicator concepts
- **Grounded Theory** – Bottom-up concept extraction
- **Systematic Literature Review** – Structured deep research

See `docs/methoden.md` for details.

## Testing

```bash
# Structure validation
bash tests/validate.sh synthesis/

# With Anthropic skill-creator eval framework
python -m scripts.run_eval --eval-set tests/eval-sets/trigger.json --skill-path skills/research/
```

## License

MIT
