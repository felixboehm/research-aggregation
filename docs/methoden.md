# Scientific Methods

## 1. Morphological Analysis (Fritz Zwicky, 1967)

### Principle
All relevant dimensions of a problem are identified, their possible options listed, and all combinations systematically explored. Goal: **Force completeness** — no combination overlooked.

### Application in the Plugin
- **Dimensions** are extracted from the knowledge base (e.g., Location Type, Menu Strategy, Pricing Model, Target Audience)
- **Options** per dimension (e.g., Location: Downtown, Suburb, University area, Transit hub)
- **Consistency analysis**: Incompatible combinations are eliminated (e.g., "Premium pricing" conflicts with "University student target audience")
- **Coverage matrix**: Which cells are documented? Which are gaps?

### Reducing Combinatorial Explosion
With 7 dimensions x 5 options = 78,125 theoretical combinations. Reduction through:
1. Consistency filter (eliminate incompatible pairs)
2. Relevance filter (prioritize through test scenario coverage)
3. Cluster analysis (group similar combinations)

→ Typically reduced to 200–500 meaningful combinations, of which 20–50 are high priority.

## 2. Knowledge Graph

### Principle
Concepts are modeled as **nodes**, their relationships as **edges**. Edges have a type, a strength, and optionally a condition.

### Edge Types (8 types)
| Type | Meaning | Example |
|---|---|---|
| `supports` | A makes B more effective | High foot traffic supports premium pricing |
| `conflicts` | A and B collide | Low rent conflicts with high visibility |
| `requires` | A only works with B | Delivery service requires kitchen capacity |
| `amplifies` | A+B > A + B (synergy) | Corner location + outdoor seating |
| `activates` | A unlocks B | Reaching break-even activates expansion planning |
| `limits` | A constrains B | Small kitchen limits menu variety |
| `backs` | A provides evidence for claim B | RCT data backs efficacy claim |
| `rebuts` | A provides counter-evidence against B | New study rebuts dosage recommendation |

### Graph Analysis
- **Centrality**: Which nodes have the most edges? (= key concepts)
- **Clusters**: Which nodes form tightly connected groups?
- **Paths**: What chains of relationships exist? (A → B → C)
- **Bridges**: Which nodes connect otherwise separate clusters?

## 3. Toulmin Argumentation (Stephen Toulmin, 1958)

### Principle
Every claim should be backed by evidence, connected through a **warrant** (the reasoning principle), and accompanied by a **qualifier** (confidence level) and a **rebuttal** (conditions under which the claim fails). This makes reasoning explicit and auditable.

### Application in the Plugin

**Claim-level tracking** (on nodes):
- **Qualifier**: gesichert (established) → hoch → mittel → niedrig → spekulativ (speculative)
- **Claim type**: claim (testable assertion), evidence (data/observation), warrant (reasoning principle)
- **Rebuttal**: What would invalidate this claim?
- **Validates with**: How to test this claim (connects to the iteration cycle)

**Reasoning-level tracking** (on edges):
- **Warrant**: The reasoning principle justifying why the relationship exists
- **Backs/Rebuts**: Specialized edge types for formal evidence trails — `backs` connects evidence to a claim, `rebuts` connects counter-evidence

**Argument chains** (composite objects):
- Multi-step reasoning paths across disciplines: A → B → C → conclusion
- Per-link warrant and qualifier for each step
- **Composite qualifier** = weakest link (a chain is only as strong as its weakest step)
- **Provenance**: literature (found in sources), synthesis (constructed from multiple sources), hypothesis (proposed without direct evidence)
- **Alternatives**: Competing chains explaining the same observation

### Dependency Propagation
When new data arrives (new node, updated qualifier, new backs/rebuts edge):
1. Identify which claims are directly affected
2. Trace downstream via `backs` edges — if claim A backs claim B, a change in A affects B
3. Recompute argument chain composite qualifiers
4. Flag chains where the weakest link has shifted

### Why Toulmin-Light
Full Toulmin (with formal data, warrant, backing, qualifier, rebuttal, claim structure per argument) is heavyweight for small teams. The "light" variant:
- Makes qualifier and warrant **optional fields** on existing schema — no new document types required
- Allows incremental adoption (add qualifiers to key claims first, formalize warrants later)
- Captures 80% of the reasoning benefit with 20% of the modeling effort

## 4. Cross-Impact Analysis (Gordon/Helmer, 1966)

### Principle
For each concept pair: "If A is chosen/active, how does that affect B?" Scale: -3 (strongly negative) to +3 (strongly positive).

### Metrics
- **Active sum** = Sum of all influences FROM a concept → Lever concepts
- **Passive sum** = Sum of all influences ON a concept → Outcome concepts
- **Criticality** = Active x Passive → Key points in the system

### Interpretation
| Active high, Passive low | = **Lever** (change to steer the system) |
| Active low, Passive high | = **Indicator** (observe to understand the system) |
| Active high, Passive high | = **Critical** (key point, handle with care) |
| Active low, Passive low | = **Buffer** (little influence, little influenced) |

## 5. Systematic Literature Review (adapted)

### Protocol for Deep Research
1. **Define research question** (from gap matrix)
2. **Search strategy** (industry reports, academic papers, case studies)
3. **Inclusion/exclusion criteria** (e.g., only peer-reviewed, published after 2020)
4. **Extraction** (concepts, numbers, benchmarks, conditions)
5. **Quality assessment** (Academic paper > Industry report > Expert blog > Anecdote)
6. **Synthesis** (integration into Knowledge Graph and knowledge base)

### Source Quality
| Source | Reliability | Durability |
|---|---|---|
| Academic paper | Very high | Until superseded |
| Industry report | High | Until updated |
| Expert analysis | High | Until new data |
| Trade publication | Medium | Check if current |
| Anecdotal report | Low | Individual case, not generalizable |

## 6. Grounded Theory (Glaser/Strauss, adapted)

### Application in Phase 1
- **Open coding**: Identify all concepts from knowledge documents (bottom-up, not preconceived)
- **Axial coding**: Establish relationships between concepts (edges in the graph)
- **Selective coding**: Identify core categories (become the Zwicky dimensions)

### Principle
The dimensions of the Morphological Box are not imposed top-down, but **emerge from the data**. Initial dimensions are a starting point, validated or adjusted through Phase 1.

## 7. Meta-Analysis (quantitative)

### Application Across Test Scenarios
If the target project has test scenarios:
- Which strategies are recommended most frequently?
- Which deliver the highest effect (median across scenarios)?
- Correlation: Effect vs. risk across all scenarios
- Ranking of strategies by effectiveness and risk
