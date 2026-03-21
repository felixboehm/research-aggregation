# Example: Cancer Drug Resistance Research

Demonstrates how Research Aggregation connects isolated findings across tumor biology, pharmacology, and genomics to discover combination therapy strategies.

## Knowledge Base (3 documents)

- `wissen-a.md` – Tumor Microenvironment (hypoxia, immune evasion, angiogenesis)
- `wissen-b.md` – Drug Resistance Mechanisms (efflux pumps, target mutations, pathway rewiring)
- `wissen-c.md` – Combination Therapies (synergies, conflicts, clinical evidence)

## Expected Outputs

After `/research breadth`:
- **Nodes**: ~15 concepts (VEGF, P-glycoprotein, PD-L1, hypoxia-inducible factor, etc.)
- **Edges**: Hypoxia `amplifies` drug resistance, anti-angiogenics `conflicts` with immune checkpoint therapy (reduces T-cell infiltration)
- **Key gap**: Hypoxia-targeted agents + immunotherapy combination is partially documented but lacks a worked example

After `/research synthesis`:
- **Combination**: Anti-VEGF + immune checkpoint inhibitor — synergy in normalization window, conflict in long-term vessel pruning
- **Decision Tree**: "Is tumor hypoxic? → Yes → Normalize vasculature first → Then add immunotherapy"
