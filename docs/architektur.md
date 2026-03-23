# Plugin Architecture

## Overview

```
┌────────────────────────────────────────────────────────────────────┐
│                           4 Skills                                 │
├──────────────┬──────────────┬─────────────────┬───────────────────┤
│  /research   │  /analyse    │  /synthesis     │  /assess          │
│              │              │                 │                   │
│  Gathers NEW │  Read-only   │  Derives new    │  Read-only        │
│  knowledge   │  status &    │  strategies     │  claim confidence │
│              │  gap report  │                 │  & propagation    │
│  Reads docs  │  Arg. health │  @synthesizer   │                   │
│  WebSearch   │  Chain health│  Agent          │  Traces backs/    │
│  Sources     │              │  Cross-Impact   │  rebuts edges     │
│              │  Reads       │  Combinations   │  Re-evaluates     │
│  Creates/    │  synthesis/* │  Arg. Chains    │  chains           │
│  extends     │              │  Decision Trees │  Compares         │
│  Graph + Docs│  NO writes   │                 │  alternatives     │
│              │              │  Uses domain    │                   │
│              │              │  agents (if any)│  NO writes        │
├──────────────┴──────────────┴─────────────────┴───────────────────┤
│                  synthesis/ (in target project)                    │
│                                                                   │
│  graph/            zwicky/         combinations/                  │
│  ├─nodes.yaml      ├─dimensions    ├─combi-01.md                 │
│  ├─edges.yaml      ├─matrix.md     └─combi-02.md                 │
│  ├─chains.yaml     └─cells/                                      │
│  └─views/                          decision-trees/                │
│                                    ├─dt-01.md                     │
│  gaps/             runs/           └─dt-02.md                     │
│  ├─matrix.md       ├─2026-03-21/                                 │
│  └─questions.md    └─2026-03-22/                                  │
└───────────────────────────────────────────────────────────────────┘
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
                       Argumentation health (claims, qualifiers, warrants)
                       Argument chain health (provenance, weakest links)
synthesis/zwicky/  ──▶ Coverage report (filled vs. unfilled cells)
synthesis/gaps/    ──▶ Prioritized gap list
synthesis/runs/    ──▶ Research history timeline
                          │
                          ▼
                    Suggested next actions
                    (NO file writes)
```

### /synthesis — Combinations, Decision Trees & Argument Chains

```
nodes.yaml  ─┐
edges.yaml   ─┼──▶ @synthesizer ──▶ Cross-Impact Matrix
zwicky/      ─┘         │            Synergies + Conflicts
                        │
                        ├──▶ combinations/combi-*.md
                        │    (calculated, all perspectives)
                        │
                        ├──▶ chains.yaml
                        │    (argument chains with per-link warrants,
                        │     composite qualifiers, weakest links)
                        │
                        └──▶ decision-trees/dt-*.md
                             (if-then trees with assumption dependencies)
```

### /assess — Claim Confidence & Dependency Propagation

```
nodes.yaml   ─┐
edges.yaml    ─┼──▶ Find tracked claims (qualifier ≠ null)
chains.yaml  ─┘         │
                         ├──▶ Trace backs/rebuts edges per claim
                         │    Identify what changed
                         │
                         ├──▶ Propagation tree
                         │    (downstream claims affected)
                         │
                         ├──▶ Chain reassessment
                         │    (recompute composite qualifiers)
                         │
                         └──▶ Assessment report
                              (NO file writes)
```

## Knowledge Graph: YAML Schema

### Nodes (`synthesis/graph/nodes.yaml`)

```yaml
nodes:
  - id: string              # Unique ID (kebab-case)
    name: string             # Human-readable name
    type: enum               # strategy | constraint | mechanism |
                             # structure | risk | role
    qualifier: enum | null   # gesichert | hoch | mittel | niedrig | spekulativ
                             # (null = not a claim, just a concept)
    claim_type: enum | null  # claim | evidence | warrant (null = standard concept)
    rebuttal: string | null  # What would invalidate this claim?
    validates_with: string | null  # How to test this claim
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
                             # amplifies | activates | limits |
                             # backs | rebuts
    strength: enum           # weak | medium | strong
    description: string      # Why does this relationship exist?
    condition: string | null  # Under what condition?
    warrant: string | null    # Reasoning principle justifying this relationship
```

### Argument Chains (`synthesis/graph/chains.yaml`)

```yaml
chains:
  - id: string              # Unique ID (chain-prefixed, kebab-case)
    name: string             # Human-readable name
    claim: string            # The composite conclusion
    provenance: enum         # literature | synthesis | hypothesis
    links:
      - from: string         # Node ID
        to: string           # Node ID
        edge_id: string | null  # Reference to edge in edges.yaml
        warrant: string      # Why this step follows
        evidence_tier: int   # 1-4
        qualifier: enum      # gesichert | hoch | mittel | niedrig | spekulativ
    composite_qualifier: enum  # min(link qualifiers)
    weakest_link: string     # The bottleneck link
    disciplines: [string]    # Domains this chain crosses
    rebuttal: string         # What would break the chain
    validates_with: string   # How to test the conclusion
    alternatives: [string]   # IDs of alternative chains
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
- `/research-aggregation:analyse` — knowledge base status & argumentation health
- `/research-aggregation:assess` — claim confidence & dependency propagation
- `/research-aggregation:synthesis` — combinations, argument chains & strategies
- `@researcher` — skill-aware parallel research agent
- `@synthesizer` — meta-analysis agent
