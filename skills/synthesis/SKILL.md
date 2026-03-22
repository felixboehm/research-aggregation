---
name: synthesis
description: Generate combination strategies, decision trees, and cross-impact analysis from existing knowledge. Use this skill when the user wants combinations, strategies, decision trees, synergies, or asks "what works together?", "which strategies combine well?", "create decision trees", "calculate combination", or "cross-impact analysis".
---

# Synthesis – Combinations, Strategies & Decision Trees

From the Knowledge Graph and Morphological Box, derive combination strategies, Decision Trees, and Cross-Impact analysis.

## Invocation

| Invocation | Action |
|---|---|
| `/synthesis` | Full synthesis: synergies, cross-impact, combinations, decision trees |
| `/synthesis A+B` | Calculate a specific combination of concepts A and B |

## Prerequisites

This skill requires existing synthesis data. Check that `synthesis/graph/nodes.yaml` and `synthesis/graph/edges.yaml` exist. If not: inform the user and suggest `/research TOPIC` first.

## Full Synthesis Procedure

### 1. Identify synergies

- Read `synthesis/graph/edges.yaml`
- Find all edges of type `amplifies`: Which concepts create disproportionate impact together?
- Form chains: A amplifies B amplifies C → three-stage strategy
- Per chain: Describe total effect, summarize prerequisites

### 2. Cross-Impact Analysis

- Select the top-20 concepts by edge count from `synthesis/graph/nodes.yaml`
- For each pair: How does concept A affect the impact of concept B? (-3 to +3)
  - +3 = A strongly amplifies B
  - 0 = no effect
  - -3 = A strongly inhibits B
- Calculate per concept:
  - **Active sum** = sum of row values (lever: high = strong influencer)
  - **Passive sum** = sum of column values (indicator: high = strongly influenced)
  - **Criticality** = active × passive (high = both influences and is influenced)
- Save result as `synthesis/graph/views/cross-impact.md`

### 3. Calculate combinations

For each promising 2-way and 3-way combination:

1. Identify promising pairs from synergy chains and high-criticality concepts
2. Per combination, create a worked example with concrete numbers
3. If the project has domain agents (e.g., `@steuerberater`): have all relevant agents evaluate in parallel
4. Document conflicts between perspectives
5. Assess: prerequisites, mechanism, risks, related decision trees
6. Save as `synthesis/combinations/combi-XX-name.md`

Use the template from `${CLAUDE_PLUGIN_ROOT}/templates/kombination.template.md`.

### 4. Derive Decision Trees

Per main decision (e.g., "Which strategy to pursue?"):

1. Identify the central question
2. Build if-then structure with branches
3. Reference combinations and sources at each leaf
4. Document assumptions and limitations
5. Save as `synthesis/decision-trees/dt-XX-name.md`

Use the template from `${CLAUDE_PLUGIN_ROOT}/templates/decision-tree.template.md`.

### 5. Update research questions

- What remains open after synthesis?
- What new questions did the combination analysis raise?
- Update `synthesis/gaps/research-questions.md`

### Outputs

- `synthesis/combinations/combi-*.md`
- `synthesis/decision-trees/dt-*.md`
- `synthesis/graph/views/cross-impact.md`
- `synthesis/gaps/research-questions.md` (updated)
- `synthesis/runs/DATE-synthesis/run.yaml` + `new-combinations.md` + `insights.md`

## Specific Combination: `/synthesis A+B`

When invoked with specific concepts (e.g., `/synthesis location-strategy+menu-pricing`):

1. Verify both concepts exist as nodes in the graph
2. Check existing edges between them
3. Calculate the specific combination using the template
4. If domain agents exist, have them evaluate
5. Save as `synthesis/combinations/combi-XX-name.md`

## Delegation to @synthesizer

For analytical tasks (graph traversal, pattern recognition, cross-impact calculation), delegate to the `@synthesizer` agent. The agent handles methodology; this skill handles orchestration and file output.

## Important

- All outputs in English
- YAML must be valid (observe required fields, see templates)
- Each run creates an entry under `synthesis/runs/`
- Worked examples with concrete numbers, label assumptions clearly
- Decision Trees with source references
- Distinguish between facts (from graph) and interpretations (from analysis)
