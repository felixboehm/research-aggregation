---
name: research
description: Research a topic by gathering knowledge from existing documents and web sources. Integrates findings into the knowledge base. Use this skill when the user wants to research, investigate, learn about, or deepen understanding of a specific topic. Also for "research X", "find out about X", "what do experts say about X", "deepen my knowledge on X", or "explore topic X".
---

# Research – Knowledge Gathering & Integration

Actively research a topic: scan existing knowledge documents, discover and use available research skills from installed plugins, search the web for new sources, and integrate findings into the knowledge base. Idempotent — automatically adapts based on how much is already known.

## Invocation

| Invocation | Action |
|---|---|
| `/research TOPIC` | Research a topic — broad if new, deeper if knowledge exists |
| `/research` (no args) | Suggest what to research next based on current gaps |

## `/research TOPIC` — Idempotent Research

### Step 1: Assess knowledge state

Check the current state of knowledge about TOPIC:

1. Does `synthesis/graph/nodes.yaml` exist?
2. Does TOPIC match any existing node IDs or names? (fuzzy match — "battery" matches "battery-storage")
3. How many edges connect to TOPIC-related nodes?
4. Is TOPIC mentioned in `synthesis/gaps/gap-matrix.md` or `synthesis/gaps/research-questions.md`?

### Step 1.5: Discover available research skills

Before researching, check if other installed plugins provide skills that can help gather knowledge on TOPIC.

1. **Scan for installed skills** — run a single Grep to find all skill descriptions:
   ```
   Grep(pattern="^description:", path="~/.claude/plugins/cache/", glob="**/SKILL.md", output_mode="content")
   ```
   Also check the project's `.claude/skills/*/SKILL.md` for local skills.

2. **Match relevant skills** — from the discovered descriptions, select skills relevant to TOPIC:
   - **Generic research skills** (useful for any topic): skills with names/descriptions matching literature-review, research-lookup, brainstorming, hypothesis-generation, web-search, etc.
   - **Domain-specific skills**: skills whose description matches TOPIC's domain (e.g., `pubmed-database` for biomedical topics, `arxiv-database` for physics/CS, `fred-economic-data` for economics)

3. **Extract qualified names** — from each file path, derive the invocation name:
   - Plugin name: the directory segment after `cache/{repo-name}/` (e.g., `scientific-skills`)
   - Skill name: the parent directory of SKILL.md (e.g., `literature-review`)
   - Qualified name: `{plugin-name}:{skill-name}` (e.g., `scientific-skills:literature-review`)

4. **Apply rules**:
   - **Skip own skills**: exclude anything from the `research-aggregation` plugin (prevent recursion)
   - **Flag API requirements**: if a skill's frontmatter contains `compatibility:`, note it — the skill may need API keys
   - **Cap at 5 skills** maximum to avoid context bloat

5. **If no relevant skills found**: proceed with web-only research (current behavior). This is fine — skill discovery is an enhancement, not a requirement.

### Step 2: Adapt behavior based on state

#### A) No graph exists (first run ever)

This is the initial knowledge base setup. Perform a full scan:

1. **Identify knowledge base**
   - Search for `wissen/` or similar directories with Markdown documents
   - If not found: Ask the user for the path

2. **Extract concepts** (Grounded Theory — open coding)
   - Read each document
   - Identify: strategies, mechanisms, constraints, risks, roles
   - Per concept: id, name, type, sources, references, tags, summary

3. **Discover relationships** (Grounded Theory — axial coding)
   - For each concept pair: Is there a relationship?
   - 6 edge types: supports, conflicts, requires, amplifies, activates, limits
   - Per edge: strength (weak/medium/strong), description, condition

4. **Derive dimensions** (selective coding)
   - Form core categories from the concepts → Zwicky dimensions
   - Per dimension: Identify options

5. **Identify gaps**
   - Zwicky matrix: Which cells are covered by documents?
   - Graph: Are there isolated nodes? Missing expected edges?

6. **Save initial outputs**
   - `synthesis/graph/nodes.yaml`
   - `synthesis/graph/edges.yaml`
   - `synthesis/zwicky/dimensions.yaml`
   - `synthesis/zwicky/matrix.md`
   - `synthesis/gaps/gap-matrix.md`

7. **Then research TOPIC** — continue with web research (see section B or C below, depending on how much was found in the docs)

Read the templates under `${CLAUDE_PLUGIN_ROOT}/templates/` for the exact output formats.

#### B) TOPIC is new or sparse (< 2 nodes, < 3 edges about TOPIC)

Broad research to establish knowledge:

1. **Skill-assisted research** (if relevant skills were discovered in Step 1.5)
   - Spawn the `@researcher` agent with TOPIC and the list of discovered skills
   - The agent invokes each skill in parallel and consolidates findings
   - If a skill fails (missing API key, error), the agent logs it and continues
2. **Web research** — search for authoritative sources on TOPIC to complement skill results
   - Focus on aspects NOT already covered by skill-based research
   - Academic papers, industry reports, expert analyses
   - Assess source quality: Academic paper > Industry report > Expert analysis > Trade publication > Anecdotal report
   - Document each source with date, reference ID, and quality assessment
3. **Create knowledge documents** — write new `wissen/*.md` files with findings from both skill and web research
4. **Update graph** — add new nodes and edges to existing graph
5. **Update Zwicky** — add new options to relevant dimensions, or create new dimensions
6. **Update gaps** — re-assess gap matrix with new knowledge

#### C) TOPIC is well-covered (>= 2 nodes, >= 3 edges)

Targeted deep research to fill specific gaps:

1. **Check gaps** — read `synthesis/gaps/gap-matrix.md` and `synthesis/gaps/research-questions.md` for open questions about TOPIC
2. **Skill-assisted deep research** (if relevant skills were discovered in Step 1.5)
   - Spawn the `@researcher` agent with TOPIC, the open research questions, and the list of discovered skills
   - Database and search skills are especially useful for answering specific questions (e.g., `arxiv-database` for finding papers, `pubmed-database` for biomedical evidence)
   - The agent returns consolidated findings with source quality assessments
3. **Web research** — search for specific answers to remaining open questions
   - Follow references from existing sources
   - Look for contrasting viewpoints and recent developments
   - Assess source quality (same hierarchy as section B)
4. **Update existing nodes** — add new references, refine summaries
5. **Add new edges** — document relationships discovered through deeper understanding
6. **Fill Zwicky cells** — address specific unfilled cells related to TOPIC

### Step 3: Log the run

Every invocation creates a run entry:
- `synthesis/runs/DATE-research-TOPIC/run.yaml`
- `synthesis/runs/DATE-research-TOPIC/sources.md` (sources found and quality assessment)
- `synthesis/runs/DATE-research-TOPIC/insights.md` (key findings and surprises)

The `run.yaml` must include a `discovered-skills` section when skills were scanned:

```yaml
discovered-skills:
  - name: scientific-skills:literature-review
    relevance: "Systematic literature review for TOPIC"
    used: true
    result: "Found 12 relevant papers"
  - name: scientific-skills:perplexity-search
    relevance: "AI-powered web search"
    used: false
    reason: "Requires OPENROUTER_API_KEY"
```

If no skills were discovered, set `discovered-skills: []`.

## `/research` (no args) — Suggest Next Topics

When invoked without a topic:

1. **If no graph exists**: scan all knowledge documents, build the graph, then list the topics found and suggest which to research further
2. **If graph exists**: read `synthesis/gaps/gap-matrix.md` and the graph, then suggest the top 3–5 topics worth researching next, ordered by priority
3. Keep output brief and actionable — this is NOT a full status report (use `/analyse` for that)

## Create Synthesis Directory

On first invocation: Create the directory structure `synthesis/` in the project root if it does not exist. Also create `synthesis/CLAUDE.md` as an index.

## Important

- All outputs in English
- YAML must be valid (observe required fields, see templates)
- Each run creates an entry under `synthesis/runs/`
- Node IDs in kebab-case, unique
- Edges only with the 8 allowed types: supports, conflicts, requires, amplifies, activates, limits, backs, rebuts
- Source quality must be assessed and documented
- When deepening: preserve existing nodes/edges, add to them — never delete or overwrite previous research
