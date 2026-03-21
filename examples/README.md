# Usage Examples

Each example contains a 3-document knowledge base that demonstrates the plugin's ability to discover connections, synergies, conflicts, and gaps.

| Example | Domain | Documents | Key Insight |
|---|---|---|---|
| [Biology](biology/) | Cancer Drug Resistance | Tumor microenvironment, resistance mechanisms, combination therapies | Hypoxia drives both resistance AND immune evasion — temporal sequencing of anti-VEGF + chemo + immunotherapy is critical |
| [Physics](physics/) | Renewable Energy Grid | Solar fundamentals, battery storage, grid integration | Adding demand response to solar+battery is the cheapest marginal improvement (5-year payback on increment) |
| [Chemistry](chemistry/) | Sustainable Polymers | Biodegradable polymers, mechanical properties, combined design | Properties that make polymers useful are the same ones that slow degradation — blending resolves this trade-off |

## Structure

Each example follows the same pattern:

```
example/
├── README.md      # Expected outputs + key insights
├── wissen-a.md    # Topic A (isolated)
├── wissen-b.md    # Topic B (isolated)
└── wissen-c.md    # Combined A+B (synergies, conflicts, worked example)
```

Document C always demonstrates what the plugin should discover automatically from documents A and B — plus additional insights that emerge from the combination.

## Running an Example

```bash
# Point the plugin at an example knowledge base
/research breadth examples/biology/

# Or deep-dive into a specific gap
/research depth "marine degradation of PLA:PHA blends"

# Generate combinations and decision trees
/research synthesis
```
