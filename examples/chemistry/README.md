# Example: Sustainable Polymer Design

Demonstrates how Research Aggregation connects isolated findings across polymer chemistry, environmental science, and manufacturing to discover optimal material strategies.

## Knowledge Base (3 documents)

- `wissen-a.md` – Biodegradable Polymers (PLA, PHA, starch blends, degradation pathways)
- `wissen-b.md` – Mechanical Properties & Processing (tensile strength, barrier properties, extrusion, injection molding)
- `wissen-c.md` – Combined Design Strategies (property-degradation trade-offs, blending, additives)

## Expected Outputs

After `/research breadth`:
- **Nodes**: ~12 concepts (PLA crystallinity, PHA copolymers, plasticizer migration, industrial composting, etc.)
- **Edges**: Crystallinity `conflicts` with biodegradation rate, PHA blending `amplifies` barrier properties
- **Key gap**: Marine degradation of PLA/PHA blends is poorly documented vs. industrial composting

After `/research synthesis`:
- **Combination**: PLA + PHA blend + nucleating agent — balances mechanical strength, processability, and compostability
- **Decision Tree**: "Food contact required? → Yes → Check migration limits → PLA alone or PHA coating"
