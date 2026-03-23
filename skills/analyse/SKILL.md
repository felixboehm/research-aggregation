---
name: analyse
description: Analyse (or analyze) the knowledge base status. Read-only inspection of what is known, what is missing, and how complete the knowledge graph is. Includes argumentation health and argument chain analysis. Use this skill when the user asks "what do we know?", "what is missing?", "show gaps", "knowledge base status", "analyze the knowledge base", "analyse my research", "how complete is the knowledge base?", "show coverage", or "argumentation health".
---

# Analyse – Knowledge Base Status

Read-only inspection of the current knowledge base. Reports what is known, what is missing, and suggests next actions. **This skill never writes files.**

## Invocation

| Invocation | Action |
|---|---|
| `/analyse` or `/analyze` | Full status report |
| `/analyse gaps` | Focus on gap matrix only |
| `/analyse graph` | Focus on knowledge graph statistics only |

## Procedure

### 1. Check if synthesis data exists

- Look for `synthesis/graph/nodes.yaml` and `synthesis/graph/edges.yaml`
- If not found: Report that no research has been conducted yet, suggest `/research TOPIC` to start

### 2. Knowledge Graph Statistics

Read `synthesis/graph/nodes.yaml` and `synthesis/graph/edges.yaml`:

- **Node counts**: Total nodes, by type (strategy, mechanism, constraint, risk, role, structure)
- **Edge counts**: Total edges, by type (supports, conflicts, requires, amplifies, activates, limits, backs, rebuts)
- **Connectivity**: Isolated nodes (0 edges), bridge nodes (connect clusters), most-connected nodes (top 5)
- **Edge density**: edges / (nodes × (nodes-1) / 2) — how interconnected is the graph?

### 3. Argumentation Health

If any nodes have `qualifier` set (i.e., they are tracked claims):

- **Claims by qualifier level**: Count distribution across gesichert / hoch / mittel / niedrig / spekulativ
- **Unsupported claims** (red flag): Claims with `qualifier` set but no `backs` edges pointing to them — no formal evidence trail
- **Claims without rebuttal** (yellow flag): Claims with `qualifier` set but `rebuttal` is null — untested assumptions
- **Untested claims** (actionable): Claims with `validates_with` set but qualifier still niedrig or spekulativ — we know how to test but haven't
- **Edges without warrant**: Count of edges (especially `backs` and `rebuts`) where `warrant` is null — unexplained relationships
- **Stale claims**: Claims whose qualifier has not changed despite dependent data (backing/rebutting nodes) being updated

If no nodes have `qualifier` set, skip this section silently.

### 4. Argument Chain Health

If `synthesis/graph/chains.yaml` exists:

- **Chains by provenance**: Count of literature / synthesis / hypothesis chains
- **Composite qualifier distribution**: Count across gesichert / hoch / mittel / niedrig / spekulativ
- **Weakest links**: List the weakest links across all chains — these are the top research priorities
- **Chains without alternatives** (single-explanation risk): Chains where `alternatives` is empty
- **Cross-disciplinary innovation score**: Chains crossing 3+ disciplines (most novel insights)
- **Alternative chain comparison**: Where alternatives exist, show relative qualifier ranking

If no chains exist, skip this section silently.

### 5. Morphological Box Coverage

Read `synthesis/zwicky/dimensions.yaml` and `synthesis/zwicky/matrix.md`:

- **Dimensions**: List all dimensions with option counts
- **Coverage**: Filled cells vs. unfilled cells (percentage)
- **Sparse dimensions**: Dimensions with fewer than 2 options (need research)

### 6. Gap Analysis

Read `synthesis/gaps/gap-matrix.md` and `synthesis/gaps/research-questions.md` (if exists):

- **Gap counts**: HIGH / MEDIUM / LOW priority gaps
- **Top 5 gaps**: Show the highest-priority gaps with their research questions
- **Open research questions**: List unresolved questions from previous runs

### 7. Research History

Read `synthesis/runs/` directory:

- **Run timeline**: List all runs with date, type, and key insights
- **Last run**: When was the last research conducted?
- **Trend**: Is knowledge growing? (compare node/edge counts across runs if delta files exist)

### 8. Suggested Next Actions

Based on the analysis, suggest concrete next steps:

- If many HIGH gaps exist: "Consider `/research TOPIC` for: X, Y, Z"
- If graph is sparse: "The graph has few connections. Consider researching bridging topics."
- If coverage is high: "Knowledge base is well-covered. Consider `/synthesis` to derive strategies."
- If no synthesis has been done: "Consider `/synthesis` to generate combinations and decision trees."
- If unsupported claims exist: "Consider adding `backs` edges to formalize evidence trails for: X, Y, Z"
- If chains have validated weakest links: "Consider `/assess` to check if chain confidence can be upgraded"
- If many claims lack rebuttals: "Consider defining rebuttal conditions — what would invalidate these claims?"

## Output Format

Structure the report clearly with sections. Use tables for statistics. Example:

```
## Knowledge Base Status

### Graph: 24 nodes, 31 edges
| Type | Count |
|---|---|
| strategy | 8 |
| mechanism | 6 |
| ... | ... |

Edge density: 0.11 (sparse — many potential connections unexplored)
Isolated nodes: node-x, node-y

### Coverage: 67% (18/27 cells filled)
Sparse dimensions: "Regulatory Framework" (1 option)

### Top Gaps (3 HIGH, 5 MEDIUM, 2 LOW)
1. [HIGH] Regulatory compliance in EU markets → "What are the key regulatory barriers?"
2. [HIGH] Supply chain resilience → "How do different suppliers compare on reliability?"
3. ...

### Last Research: 2026-03-20 (depth: supply-chain)
Trend: +4 nodes, +7 edges since previous run

### Suggested Next Steps
- `/research regulatory-compliance` — highest-priority gap
- `/synthesis` — enough data to generate initial combinations
```

## Important

- This skill is **read-only** — it never creates or modifies files
- All output in English
- Distinguish between facts (from data) and suggestions (your recommendations)
- If synthesis data is incomplete or missing, say so clearly rather than guessing
