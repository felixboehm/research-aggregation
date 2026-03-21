# Research Aggregation: Concept

## Goal

From a collection of isolated knowledge documents, systematically:
1. **Ensure completeness** (what is missing?)
2. **Create depth** (operational details, sources, formulas)
3. **Discover connections** (which topics reinforce/contradict each other?)
4. **Generate new insights** (combinations nobody has explicitly documented)

## Problem Statement

### Problem 1: Isolated Documents
Knowledge documents exist side by side without explicit cross-references. Each document covers a topic in isolation. The connections between topics exist only implicitly.

**Example:** Document A describes "Location Strategy" for a coffee shop (foot traffic, visibility, rent). Document B describes "Menu Optimization" (pricing, cost of goods). Both are individually correct, but nobody has analyzed the combination A+B — even though location directly affects optimal menu pricing (high-rent locations need higher-margin items).

### Problem 2: No Systematic Depth
Research is ad-hoc. Documents touch many topics but rarely go into operational depth (concrete formulas, benchmarks, thresholds, authoritative sources).

**Example:** "Choose a location with high foot traffic" is stated in the document — but how high? What is the minimum viable foot traffic per hour? What is the rent-to-revenue ratio threshold?

### Problem 3: No Combinatorics
The magic lies in combining strategies. These combinations are not documented, not calculated, and contradictions are not resolved.

### Problem 4: No Gap Awareness
There is no systematic overview of which topic combinations have been explored and which have not. Gaps are discovered randomly, not systematically.

## Solution: 3-Phase Pipeline

```
Phase 1: BREADTH (Aggregation)
├── Read all knowledge documents
├── Extract concepts → Knowledge Graph (nodes + edges)
├── Identify dimensions → Morphological Box
├── Check coverage → Gap matrix
└── Result: Complete picture of documented knowledge

Phase 2: DEPTH (Deep-Dive)
├── Prioritized gaps from Phase 1
├── Targeted research (WebSearch, authoritative sources)
├── Add operational details (formulas, sources, thresholds)
├── Extend Knowledge Graph
└── Result: Deepened, source-backed knowledge base

Phase 3: SYNTHESIS (Combinatorics)
├── Graph analysis: Identify synergies and conflicts
├── Cross-Impact Analysis: Find lever concepts
├── Calculate combinations (worked examples)
├── Derive Decision Trees
└── Result: New insights, strategies, decision aids
```

## Scientific Methods

See `methoden.md` for details on:
- Morphological Analysis (Fritz Zwicky)
- Knowledge Graphs and Cross-Impact Analysis (Gordon/Helmer)
- Systematic Literature Review (adapted)
- Grounded Theory (Glaser/Strauss, adapted)
- Meta-Analysis

## What This Plugin Is NOT

- Not a substitute for domain expertise — it structures knowledge but does not evaluate domain-specific content
- Not an automatic research bot — deep research requires human guidance
- Not a one-shot tool — the pipeline is iterative, each run improves the picture
