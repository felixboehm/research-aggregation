# Research Aggregation

Claude Code plugin for systematic knowledge aggregation and synthesis.

## What It Does

From a collection of isolated knowledge documents, systematically:
- **Discover connections** (Knowledge Graph with 8 relationship types)
- **Track confidence** (Toulmin-light argumentation with qualifiers and warrants)
- **Build argument chains** (cross-disciplinary synthesis with per-link confidence)
- **Check completeness** (Morphological Box / Zwicky Box)
- **Find gaps** (prioritized research questions)
- **Calculate combinations** (multi-strategy worked examples)
- **Derive decision aids** (Decision Trees)
- **Assess propagation** (trace how new data affects existing claims)

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

On first run, scans all knowledge documents and builds the Knowledge Graph + Morphological Box. On subsequent runs, deepens existing knowledge using discovered skills from installed plugins (e.g., `scientific-skills:literature-review`, `scientific-skills:arxiv-database`) and web research.

### `/analyse` — Knowledge Base Status

Read-only inspection: what is known, what is missing, how complete the graph is. Includes argumentation health and argument chain analysis.

| Invocation | Action |
|---|---|
| `/analyse` | Full status report (graph stats, argumentation health, coverage, gaps, history) |
| `/analyse gaps` | Focus on gap matrix only |
| `/analyse graph` | Focus on knowledge graph statistics only |

### `/assess` — Claim Confidence & Dependency Propagation

Read-only assessment of which claims and argument chains need reassessment after new data arrives.

| Invocation | Action |
|---|---|
| `/assess` | Full assessment of all tracked claims and chains |
| `/assess CLAIM_ID` | Assess a specific claim and its dependents |

### `/synthesis` — Combinations, Decision Trees & Argument Chains

From the Knowledge Graph and Morphological Box, derive strategies, decision aids, and formal argument chains.

| Invocation | Action |
|---|---|
| `/synthesis` | Full synthesis: synergies, cross-impact, combinations, argument chains, decision trees |
| `/synthesis A+B` | Calculate a specific combination of concepts A and B |

## Agent

- **`@researcher`** — Research executor that discovers and uses available skills from installed plugins. Invokes relevant skills (literature review, database searches, etc.) in parallel and consolidates findings.
- **`@synthesizer`** — Meta-analyst for Cross-Impact, Morphology, and Graph analysis. Read-only analytical agent that identifies patterns, synergies, and conflicts.

## Pipeline

```
/research               /analyse              /synthesis             /assess
┌──────────────┐    ┌──────────────┐    ┌──────────────────┐    ┌──────────────┐
│ Scan docs    │    │ Graph stats  │    │ Graph Analysis   │    │ Claim status │
│ Discover     │    │ Arg. health  │    │ Cross-Impact     │    │ Propagation  │
│  skills      │    │ Chain health │    │ Combinations     │    │  tracing     │
│ @researcher  │    │ Coverage %   │    │ Argument Chains  │    │ Chain re-    │
│ Web research │    │ Gap matrix   │    │ Decision Trees   │    │  assessment  │
│              │    │ Run history  │    │                  │    │ Alternative  │
│ → Graph      │    │              │    │ → New Insights   │    │  comparison  │
│ → Zwicky     │    │ → Status     │    │ → Strategies     │    │              │
│ → Knowledge  │    │ → Next steps │    │ → Chains         │    │ → Report     │
└──────────────┘    └──────────────┘    └──────────────────┘    └──────────────┘
    writes              reads               reads + writes           reads
```

## Outputs

All results under `synthesis/` in the target project:

| Directory | Content |
|---|---|
| `graph/` | Knowledge Graph (nodes.yaml, edges.yaml, chains.yaml) |
| `zwicky/` | Morphological Box (dimensions + cells) |
| `combinations/` | Calculated multi-strategy combinations |
| `decision-trees/` | Decision trees |
| `gaps/` | Gap matrix + research questions |
| `runs/` | Run history (deltas, insights, sources) |

## Scientific Methods

- **Morphological Analysis** (Fritz Zwicky) — Systematic combination matrix
- **Knowledge Graph** — Concepts + relationships (8 edge types)
- **Toulmin Argumentation** — Qualifier, warrant, rebuttal, and dependency tracking
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
