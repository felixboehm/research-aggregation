---
name: assess
description: Assess claim confidence and trace dependency propagation. Read-only inspection that shows which claims and argument chains need reassessment after new data arrives. Use this skill when the user asks "assess claims", "which claims changed?", "what needs reassessment?", "trace dependencies", "propagate confidence", "reassess", or "check claim status".
---

# Assess – Dependency Propagation & Confidence Reassessment

Read-only inspection that traces how new data affects existing claims and argument chains. Shows which claims need reassessment and in which direction. **This skill never writes files.**

## Invocation

| Invocation | Action |
|---|---|
| `/assess` | Full assessment of all tracked claims and chains |
| `/assess CLAIM_ID` | Assess a specific claim and its dependents |

## Procedure

### 1. Check prerequisites

- Read `synthesis/graph/nodes.yaml`, `synthesis/graph/edges.yaml`
- Read `synthesis/graph/chains.yaml` (if exists)
- If no graph exists: report that no research has been conducted yet, suggest `/research TOPIC`
- If no nodes have `qualifier` set: report that no claims are being tracked yet, explain how to add qualifier fields

### 2. Identify tracked claims

Find all nodes where `qualifier` is not null. These are the claims being tracked.

### 3. Analyse backing and rebuttal for each claim

For each tracked claim:
1. Find all `backs` edges where the claim is the `to` node — these are its supporting evidence
2. Find all `rebuts` edges where the claim is the `to` node — these are counter-evidence
3. Check backing nodes: have any backing nodes had their qualifier updated? Are there new `backs` edges since the last assessment?
4. Check for new `rebuts` edges

### 4. Determine reassessment direction

For each affected claim, assess:
- **↑ Strengthened** — new backing evidence added, or existing backing qualifier improved
- **↓ Weakened** — new rebuttal added, or existing backing qualifier degraded
- **⚠ Conflicted** — both new backing and new rebuttal exist (needs human judgment)
- **→ Stable** — no changes to backing or rebuttal

### 5. Trace downstream propagation

Follow the dependency chain:
1. Find all `backs` edges where the affected claim is the `from` node
2. These downstream claims inherit uncertainty — if claim A backs claim B, and A's qualifier drops, B should be reassessed too
3. Continue recursively until no more downstream claims
4. Present the full propagation tree

### 6. Reassess argument chains

If `synthesis/graph/chains.yaml` exists:
1. For each chain, re-evaluate link qualifiers based on current node/edge qualifiers
2. Recompute `composite_qualifier` using weakest-link logic (min of all link qualifiers)
3. Flag chains where:
   - The weakest link has been validated (composite qualifier can rise)
   - A link has been rebutted (chain may need revision or retirement)
   - The weakest link has shifted to a different link
4. Compare alternative chains — if one alternative gained confidence relative to another, flag it

### 7. Generate propagation report

Output a structured report with:

```
## Claim Assessment Report

### Claims Needing Reassessment

| Claim | Current Qualifier | Direction | Reason |
|---|---|---|---|
| [claim-id] | mittel | ↓ | New rebuttal: [rebutter-id] |
| [claim-id] | hoch | ↑ | Backing [backer-id] upgraded to gesichert |

### Propagation Tree

claim-a (mittel → ?)
├── backs → claim-b (hoch — reassess: backing weakened)
│   └── backs → claim-d (mittel — reassess: transitive)
└── backs → claim-c (niedrig — reassess: backing weakened)

### Chain Reassessment

| Chain | Previous Composite | New Composite | Changed Link | Action |
|---|---|---|---|---|
| chain-xx | niedrig | mittel | link-3 validated | ↑ Upgrade |
| chain-yy | mittel | ? | link-2 rebutted | ⚠ Review |

### Alternative Chain Comparison

| Observation | Chain A | Chain B | Shift |
|---|---|---|---|
| [what both explain] | chain-xx (mittel) | chain-yy (niedrig→?) | A now stronger |
```

### 8. Suggest actions

Based on the assessment:
- Claims with ↓ direction: "Consider lowering qualifier for [claim-id] based on [reason]"
- Claims with ↑ direction: "Consider upgrading qualifier for [claim-id] — backing now stronger"
- Claims with ⚠: "Human judgment needed for [claim-id] — conflicting evidence"
- Chains with validated weakest links: "Chain [chain-id] bottleneck resolved — composite qualifier can rise"
- Chains with rebutted links: "Chain [chain-id] needs revision — link [link] has been challenged"
- Unsupported claims: "Claims with no `backs` edges: [list] — these have no formal evidence trail"

## Important

- This skill is **read-only** — it never creates or modifies files
- The user decides whether to update qualifiers based on the assessment
- All output in English
- If no claims have qualifiers set, explain the Toulmin feature and how to start using it
- If no chains exist, skip chain assessment sections
- Distinguish between facts (from data) and suggestions (your recommendations)
