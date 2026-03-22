# Example: Renewable Energy Grid Integration

Demonstrates how Research Aggregation connects isolated findings across solar physics, battery chemistry, and grid engineering to discover optimal hybrid energy strategies.

## Knowledge Base (3 documents)

- `wissen-a.md` – Solar Energy Fundamentals (irradiance, panel efficiency, degradation, LCOE)
- `wissen-b.md` – Battery Storage Systems (lithium-ion, flow batteries, degradation, round-trip efficiency)
- `wissen-c.md` – Grid Integration Strategies (curtailment, demand response, hybrid systems)

## Expected Outputs

After `/research breadth`:
- **Nodes**: ~12 concepts (LCOE, round-trip efficiency, duck curve, curtailment, demand response, etc.)
- **Edges**: Battery storage `amplifies` solar value, high penetration `conflicts` with grid stability
- **Key gap**: Seasonal storage strategies (summer overproduction → winter deficit) barely documented

After `/research synthesis`:
- **Combination**: Solar + battery + demand response — optimized for peak shaving and self-consumption
- **Decision Tree**: "Grid connection capacity limited? → Yes → Prioritize storage over additional panels"
