# Research Aggregation Plugin

Systematic knowledge aggregation and synthesis for knowledge-base projects.

## Core Principle

From isolated knowledge documents, systematically generate connections, combinations, and new insights.

## Skills

- `/research-aggregation:research` – Idempotent topic research (broad if new, deeper if knowledge exists)
- `/research-aggregation:analyse` – Read-only knowledge base status, gap analysis, coverage report
- `/research-aggregation:synthesis` – Combinations, decision trees, cross-impact analysis from existing knowledge

## Agents

- `@researcher` – Discovers and uses available skills from installed plugins for parallel research
- `@synthesizer` – Meta-analyst for Cross-Impact, Morphology, and Graph analysis

## Outputs

All results are stored under `synthesis/` in the target project:
- `graph/` – Knowledge Graph (nodes + edges in YAML)
- `zwicky/` – Morphological Box (dimensions + cells)
- `combinations/` – Calculated multi-strategy combinations
- `decision-trees/` – Decision trees
- `gaps/` – Gap matrix + research questions
- `runs/` – Run history with deltas and insights

## Language

All documents and communication in **English**.
