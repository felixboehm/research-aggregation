---
name: research
description: Systematic knowledge aggregation and synthesis in 3 phases. Use this skill when the user wants to analyze their knowledge base, find gaps, discover combinations, or conduct deep research. Also for prompts like "what is missing?", "what combinations exist?", "analyze the knowledge base", "find connections", "create a Knowledge Graph", or "which topics are related?".
---

# Research Aggregation

Systematic knowledge aggregation in 3 phases: Breadth → Depth → Synthesis.

## Overview

This skill analyzes a knowledge base (Markdown documents) and produces:
- **Knowledge Graph** (concepts + relationships)
- **Morphological Box** (systematic combination matrix)
- **Gap Matrix** (what is missing?)
- **Combination Strategies** (calculated multi-topic approaches)
- **Decision Trees** (if-then decision trees)

## Invocation Modes

The user can invoke the skill with different arguments:

| Invocation | Action |
|---|---|
| `/research` | Show status, suggest next step |
| `/research breadth` | Phase 1: Aggregation – Graph + Zwicky + Gaps |
| `/research depth TOPIC` | Phase 2: Deep-dive into a topic |
| `/research synthesis` | Phase 3: Combinations + Decision Trees |
| `/research gaps` | Show / update gap matrix |
| `/research combi A+B` | Calculate a specific combination |

## Phase 1: Breadth (Aggregation)

### Goal
Complete extraction of all concepts and relationships from the knowledge base.

### Procedure

1. **Identify knowledge base**
   - Search for `wissen/` or similar directories with Markdown documents
   - If not found: Ask the user for the path

2. **Extract concepts** (Grounded Theory – open coding)
   - Read each document
   - Identify: strategies, mechanisms, constraints, risks, roles
   - Per concept: id, name, type, sources, references, tags, summary

3. **Discover relationships** (Grounded Theory – axial coding)
   - For each concept pair: Is there a relationship?
   - 6 edge types: supports, conflicts, requires, amplifies, activates, limits
   - Per edge: strength (weak/medium/strong), description, condition

4. **Derive dimensions** (selective coding)
   - Form core categories from the concepts → Zwicky dimensions
   - Per dimension: Identify options

5. **Identify gaps**
   - Zwicky matrix: Which cells are covered by documents?
   - Graph: Are there isolated nodes? Missing expected edges?

6. **Save outputs**
   - `synthesis/graph/nodes.yaml`
   - `synthesis/graph/edges.yaml`
   - `synthesis/zwicky/dimensions.yaml`
   - `synthesis/zwicky/matrix.md`
   - `synthesis/gaps/gap-matrix.md`
   - `synthesis/runs/DATE-breadth/run.yaml` + `delta.md` + `insights.md`

Read the templates under `${CLAUDE_PLUGIN_ROOT}/templates/` for the exact formats.

## Phase 2: Depth (Deep-Dive)

### Goal
Targeted deepening of a topic from the gap matrix.

### Procedure

1. If no TOPIC given: Show the top-5 gaps from `synthesis/gaps/gap-matrix.md`
2. Research targeted (WebSearch for authoritative sources, academic papers, industry reports)
3. Integrate results into existing or new knowledge documents
4. Update Knowledge Graph (new nodes/edges)
5. Fill affected Zwicky cells

### Assess Source Quality
- Academic paper > Industry report > Expert analysis > Trade publication > Anecdotal report
- Document each source with date, reference ID, and quality assessment

### Outputs
- Updated/new `wissen/*.md`
- Updated graph
- `synthesis/runs/DATE-depth-TOPIC/run.yaml` + `sources.md` + `insights.md`

## Phase 3: Synthesis (Combinatorics)

### Goal
From the Knowledge Graph and Morphological Box, derive combination strategies and Decision Trees.

### Procedure

1. **Identify synergies**
   - Graph edges of type `amplifies`: Which concepts create disproportionate impact together?
   - Chains: A amplifies B amplifies C → three-stage strategy

2. **Cross-Impact Analysis**
   - For the top-20 concepts: Pairwise impact assessment (-3 to +3)
   - Calculate active/passive sums
   - Result in `synthesis/graph/views/cross-impact.md`

3. **Calculate combinations**
   - For each promising 2-way/3-way combination:
     - Worked example with concrete numbers
     - If the project has domain agents (@steuerberater etc.): Have all evaluate in parallel
     - Document conflicts between perspectives
   - Save as `synthesis/combinations/combi-XX-name.md`

4. **Derive Decision Trees**
   - Per main decision (e.g., "Which location type?")
   - If-then structure with references to combinations and sources
   - Save as `synthesis/decision-trees/dt-XX-name.md`

5. **Update research questions**
   - What remains open? What new questions did the synthesis raise?

### Outputs
- `synthesis/combinations/combi-*.md`
- `synthesis/decision-trees/dt-*.md`
- `synthesis/graph/views/cross-impact.md`
- `synthesis/gaps/research-questions.md` (updated)
- `synthesis/runs/DATE-synthesis/run.yaml` + `new-combinations.md` + `insights.md`

## Create Synthesis Directory

On first invocation: Create the directory structure `synthesis/` in the project root if it does not exist. Also create `synthesis/CLAUDE.md` as an index.

## Important

- All outputs in English
- YAML must be valid (observe required fields, see templates)
- Each run creates an entry under `synthesis/runs/`
- Node IDs in kebab-case, unique
- Edges only with the 6 allowed types
- Worked examples with concrete numbers, label assumptions
- Decision Trees with source references
