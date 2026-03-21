# Plugin Architecture

## Overview

```
┌──────────────────────────────────────────────────┐
│                  /research Skill                  │
│  (Orchestrator – 3 Phases)                       │
├──────────┬──────────┬────────────────────────────┤
│ Phase 1  │ Phase 2  │ Phase 3                    │
│ BREADTH  │ DEPTH    │ SYNTHESIS                  │
│          │          │                            │
│ Reads    │ WebSearch│ @synthesizer Agent          │
│ wissen/* │ Sources  │ Cross-Impact               │
│          │          │ Combinations               │
│ Creates  │ Extends  │ Decision Trees             │
│ Graph    │ Graph    │                            │
│ Zwicky   │ Knowledge│ Uses domain agents          │
│ Gaps     │          │ (if present in project)    │
└──────┬───┴────┬─────┴──────────┬─────────────────┘
       │        │                │
       ▼        ▼                ▼
┌──────────────────────────────────────────────────┐
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

### Phase 1: Breadth → Aggregation

```
wissen/*.md ──Read──▶ Concept Extraction ──▶ nodes.yaml
                      (Grounded Theory)       edges.yaml
                                              dimensions.yaml
                                              gap-matrix.md
```

The skill reads all knowledge documents, extracts concepts as nodes and their relationships as edges. In parallel, dimensions for the Morphological Box are derived from the data.

### Phase 2: Depth → Deep-Dive

```
gap-matrix.md ──Prioritize──▶ Research Question
                                      │
                                WebSearch / Sources
                                      │
                                      ▼
                              wissen/*.md (extended)
                              nodes.yaml (extended)
                              edges.yaml (extended)
```

Targeted research on prioritized gaps. Results flow back into the knowledge base and the graph.

### Phase 3: Synthesis → Combinatorics

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

Each `/research` run creates an entry under `synthesis/runs/`:

```yaml
# run.yaml
phase: breadth | depth | synthesis
topic: string | null           # For Phase 2: Which topic?
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

After installation, `/research-aggregation:research` is available as a skill.
