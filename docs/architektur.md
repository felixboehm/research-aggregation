# Plugin Architecture

## Overview

```
┌──────────────────────────────────────────────────┐
│                    3 Skills                       │
├────────────────┬───────────────┬─────────────────┤
│  /research     │  /analyse     │  /synthesis      │
│                │               │                  │
│  Gathers NEW   │  Read-only    │  Derives new     │
│  knowledge     │  status &     │  strategies      │
│                │  gap report   │                  │
│  Reads docs    │               │  @synthesizer    │
│  WebSearch     │  Reads        │  Agent           │
│  Sources       │  synthesis/*  │  Cross-Impact    │
│                │               │  Combinations    │
│  Creates/      │  NO writes    │  Decision Trees  │
│  extends       │               │                  │
│  Graph + Docs  │               │  Uses domain     │
│                │               │  agents (if any) │
├────────────────┴───────────────┴─────────────────┤
│              synthesis/ (in target project)       │
│                                                  │
│  graph/          zwicky/         combinations/   │
│  ├─nodes.yaml    ├─dimensions    ├─combi-01.md   │
│  ├─edges.yaml    ├─matrix.md     └─combi-02.md   │
│  └─views/        └─cells/                       │
│                                  decision-trees/ │
│  gaps/           runs/           ├─dt-01.md      │
│  ├─matrix.md     ├─2026-03-21/   └─dt-02.md     │
│  └─questions.md  └─2026-03-22/                   │
└──────────────────────────────────────────────────┘
```

## Data Flow

### /research TOPIC — Idempotent Knowledge Gathering

```
First run (no graph exists):
  wissen/*.md ──Read──▶ Concept Extraction ──▶ nodes.yaml
                        (Grounded Theory)       edges.yaml
                                                dimensions.yaml
                                                gap-matrix.md
                           │
                           ▼
                     WebSearch for TOPIC ──▶ wissen/*.md (new)
                                             nodes.yaml (extended)

Subsequent runs (topic sparse):
  gap-matrix.md ──▶ Broad WebSearch ──▶ wissen/*.md (new)
                    on TOPIC              nodes.yaml (extended)
                                          edges.yaml (extended)

Subsequent runs (topic well-covered):
  gaps/questions.md ──▶ Targeted Deep Research ──▶ wissen/*.md (updated)
                        on specific gaps            nodes.yaml (refined)
                                                    edges.yaml (extended)
```

### /analyse — Read-Only Status Report

```
synthesis/graph/   ──▶ Graph statistics (node/edge counts, density)
synthesis/zwicky/  ──▶ Coverage report (filled vs. unfilled cells)
synthesis/gaps/    ──▶ Prioritized gap list
synthesis/runs/    ──▶ Research history timeline
                          │
                          ▼
                    Suggested next actions
                    (NO file writes)
```

### /synthesis — Combinations & Decision Trees

```
nodes.yaml  ─┐
edges.yaml   ─┼──▶ @synthesizer ──▶ Cross-Impact Matrix
zwicky/      ─┘         │            Synergies + Conflicts
                        │
                        ├──▶ combinations/combi-*.md
                        │    (calculated, all perspectives)
                        │
                        └──▶ decision-trees/dt-*.md
                             (if-then trees)
```

## Knowledge Graph: YAML Schema

### Nodes (`synthesis/graph/nodes.yaml`)

```yaml
nodes:
  - id: string              # Unique ID (kebab-case)
    name: string             # Human-readable name
    type: enum               # strategy | constraint | mechanism |
                             # structure | risk | role
    sources: [string]        # References to wissen/* documents
    references: [string]     # Relevant references (papers, standards, etc.)
    tags: [string]           # Free-text tags for search
    summary: string          # 1 sentence
```

### Edges (`synthesis/graph/edges.yaml`)

```yaml
edges:
  - from: string             # Node ID
    to: string               # Node ID
    type: enum               # supports | conflicts | requires |
                             # amplifies | activates | limits
    strength: enum           # weak | medium | strong
    description: string      # Why does this relationship exist?
    condition: string | null # Under what condition?
```

## Morphological Box: YAML Schema

### Dimensions (`synthesis/zwicky/dimensions.yaml`)

```yaml
dimensions:
  - id: string              # Unique ID
    name: string             # Human-readable name
    options:
      - id: string
        name: string
```

### Cells (`synthesis/zwicky/cells/*.md`)

Each examined combination is documented as its own Markdown file with:
- Chosen options per dimension
- Status (documented / partial / unexplored / contradictory)
- Sources
- Key findings
- Worked example (if quantifiable)
- Conflicts with other cells

## Run Logging

Each skill run creates an entry under `synthesis/runs/`:

```yaml
# run.yaml
skill: research | synthesis
topic: string | null           # For /research: Which topic?
date: ISO-8601
duration_minutes: number
new_nodes: number
new_edges: number
new_cells: number
new_combinations: number
new_research_questions: number
```

Plus `delta.md` (what changed) and `insights.md` (what was surprising / new).

## Plugin Installation

```bash
# Install as Claude Code plugin
claude plugin install research-aggregation

# Or manually link (development)
claude --plugin-dir /path/to/research-aggregation
```

After installation, the following are available:
- `/research-aggregation:research` — research topics
- `/research-aggregation:analyse` — knowledge base status
- `/research-aggregation:synthesis` — combinations & strategies
- `@synthesizer` — meta-analysis agent
