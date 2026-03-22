# Research Aggregation

Claude Code plugin for systematic knowledge aggregation and synthesis.

## What It Does

From a collection of isolated knowledge documents, systematically:
- **Discover connections** (Knowledge Graph with 6 relationship types)
- **Check completeness** (Morphological Box / Zwicky Box)
- **Find gaps** (prioritized research questions)
- **Calculate combinations** (multi-strategy worked examples)
- **Derive decision aids** (Decision Trees)

## Installation

```bash
# From the official marketplace
claude plugin install research-aggregation

# From GitHub
claude plugin marketplace add felixboehm/research-aggregation
claude plugin install research-aggregation:research-aggregation

# For development
claude --plugin-dir /path/to/research-aggregation
```

## Skills

### `/research` — Knowledge Gathering & Integration

Idempotent topic research that adapts based on existing knowledge.

| Invocation | Action |
|---|---|
| `/research TOPIC` | Research a topic — broad if new, deeper if knowledge exists |
| `/research` | Suggest what to research next based on current gaps |

On first run, scans all knowledge documents and builds the Knowledge Graph + Morphological Box. On subsequent runs, deepens existing knowledge with web research.

### `/analyse` — Knowledge Base Status

Read-only inspection: what is known, what is missing, how complete the graph is.

| Invocation | Action |
|---|---|
| `/analyse` | Full status report (graph stats, coverage, gaps, history) |
| `/analyse gaps` | Focus on gap matrix only |
| `/analyse graph` | Focus on knowledge graph statistics only |

### `/synthesis` — Combinations & Decision Trees

From the Knowledge Graph and Morphological Box, derive strategies and decision aids.

| Invocation | Action |
|---|---|
| `/synthesis` | Full synthesis: synergies, cross-impact, combinations, decision trees |
| `/synthesis A+B` | Calculate a specific combination of concepts A and B |

## Agent

- **`@synthesizer`** — Meta-analyst for Cross-Impact, Morphology, and Graph analysis. Read-only analytical agent that identifies patterns, synergies, and conflicts.

## Pipeline

```
/research               /analyse              /synthesis
┌──────────────┐    ┌──────────────┐    ┌──────────────────────┐
│ Scan docs    │    │ Graph stats  │    │ Graph Analysis       │
│ Web research │    │ Coverage %   │    │ Cross-Impact         │
│              │    │ Gap matrix   │    │ Combinations         │
│ → Graph      │    │ Run history  │    │ Decision Trees       │
│ → Zwicky     │    │              │    │                      │
│ → Gaps       │    │ → Status     │    │ → New Insights       │
│ → Knowledge  │    │ → Next steps │    │ → Strategies         │
└──────────────┘    └──────────────┘    └──────────────────────┘
    writes              reads               reads + writes
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

- **Morphological Analysis** (Fritz Zwicky) — Systematic combination matrix
- **Knowledge Graph** — Concepts + relationships (6 edge types)
- **Cross-Impact Analysis** (Gordon/Helmer) — Lever and indicator concepts
- **Grounded Theory** — Bottom-up concept extraction
- **Systematic Literature Review** — Structured deep research

See `docs/methoden.md` for details.

## Testing

```bash
# Structure validation
bash tests/validate.sh synthesis/

# With eval framework
python -m scripts.run_eval --eval-set tests/eval-sets/trigger.json --skill-path skills/research/
```

## License

MIT
