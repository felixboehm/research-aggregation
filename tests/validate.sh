#!/usr/bin/env bash
# Structure validation for Research Aggregation outputs
# Usage: bash validate.sh <synthesis-directory>

set -euo pipefail

SYNTHESIS_DIR="${1:?Usage: validate.sh <synthesis-directory>}"
ERRORS=0
WARNINGS=0

echo "=== Research Aggregation: Structure Validation ==="
echo "Directory: $SYNTHESIS_DIR"
echo ""

# --- Directory structure ---
echo "--- Directory Structure ---"
for dir in graph zwicky gaps runs; do
  if [ -d "$SYNTHESIS_DIR/$dir" ]; then
    echo "  OK: $dir/ exists"
  else
    echo "  FAIL: $dir/ missing"
    ((ERRORS++))
  fi
done

# --- YAML validation ---
echo ""
echo "--- YAML Validation ---"
for yaml_file in "$SYNTHESIS_DIR"/graph/*.yaml "$SYNTHESIS_DIR"/zwicky/*.yaml; do
  if [ -f "$yaml_file" ]; then
    if python3 -c "import yaml; yaml.safe_load(open('$yaml_file'))" 2>/dev/null; then
      echo "  OK: $(basename "$yaml_file") – valid YAML"
    else
      echo "  FAIL: $(basename "$yaml_file") – invalid YAML"
      ((ERRORS++))
    fi
  fi
done

# --- Node required fields ---
echo ""
echo "--- Node Required Fields ---"
NODES_FILE="$SYNTHESIS_DIR/graph/nodes.yaml"
if [ -f "$NODES_FILE" ]; then
  for field in id name type sources summary; do
    count=$(python3 -c "
import yaml
data = yaml.safe_load(open('$NODES_FILE'))
nodes = data.get('nodes', [])
missing = [k.get('id','?') for k in nodes if '$field' not in k]
print(len(missing))
if missing: print('  Missing in:', ', '.join(missing[:5]))
" 2>/dev/null || echo "ERROR")
    if [ "$count" = "0" ]; then
      echo "  OK: All nodes have '$field'"
    else
      echo "  FAIL: $count nodes without '$field'"
      ((ERRORS++))
    fi
  done
else
  echo "  WARN: nodes.yaml not found"
  ((WARNINGS++))
fi

# --- Edge types ---
echo ""
echo "--- Edge Types ---"
EDGES_FILE="$SYNTHESIS_DIR/graph/edges.yaml"
ALLOWED_TYPES="supports conflicts requires amplifies activates limits backs rebuts"
if [ -f "$EDGES_FILE" ]; then
  invalid=$(python3 -c "
import yaml
data = yaml.safe_load(open('$EDGES_FILE'))
edges = data.get('edges', [])
allowed = set('$ALLOWED_TYPES'.split())
invalid = [k.get('type','?') for k in edges if k.get('type') not in allowed]
print(len(invalid))
if invalid: print('  Invalid types:', ', '.join(set(invalid)))
" 2>/dev/null || echo "ERROR")
  if [ "$invalid" = "0" ]; then
    echo "  OK: All edge types are valid"
  else
    echo "  FAIL: $invalid edges with invalid type"
    ((ERRORS++))
  fi
else
  echo "  WARN: edges.yaml not found"
  ((WARNINGS++))
fi

# --- Argument chain validation ---
echo ""
echo "--- Argument Chains ---"
CHAINS_FILE="$SYNTHESIS_DIR/graph/chains.yaml"
if [ -f "$CHAINS_FILE" ]; then
  if python3 -c "import yaml; yaml.safe_load(open('$CHAINS_FILE'))" 2>/dev/null; then
    echo "  OK: chains.yaml – valid YAML"
  else
    echo "  FAIL: chains.yaml – invalid YAML"
    ((ERRORS++))
  fi
  for field in id name claim provenance links composite_qualifier; do
    count=$(python3 -c "
import yaml
data = yaml.safe_load(open('$CHAINS_FILE'))
chains = data.get('chains', [])
missing = [c.get('id','?') for c in chains if '$field' not in c]
print(len(missing))
if missing: print('  Missing in:', ', '.join(missing[:5]))
" 2>/dev/null || echo "ERROR")
    if [ "$count" = "0" ]; then
      echo "  OK: All chains have '$field'"
    else
      echo "  FAIL: $count chains without '$field'"
      ((ERRORS++))
    fi
  done
else
  echo "  INFO: chains.yaml not found (optional)"
fi

# --- Referential integrity ---
echo ""
echo "--- Referential Integrity ---"
if [ -f "$NODES_FILE" ] && [ -f "$EDGES_FILE" ]; then
  broken=$(python3 -c "
import yaml
nodes = yaml.safe_load(open('$NODES_FILE')).get('nodes', [])
edges = yaml.safe_load(open('$EDGES_FILE')).get('edges', [])
ids = {k['id'] for k in nodes}
broken = [(e.get('from','?'), e.get('to','?')) for e in edges if e.get('from') not in ids or e.get('to') not in ids]
print(len(broken))
for b in broken[:5]: print(f'  {b[0]} -> {b[1]}')
" 2>/dev/null || echo "ERROR")
  if [ "$broken" = "0" ]; then
    echo "  OK: All edges reference existing nodes"
  else
    echo "  FAIL: $broken edges with missing node references"
    ((ERRORS++))
  fi
fi

# --- Summary ---
echo ""
echo "=== Result ==="
echo "Errors: $ERRORS | Warnings: $WARNINGS"
if [ "$ERRORS" -gt 0 ]; then
  echo "FAILED: Validation failed"
  exit 1
else
  echo "PASSED: Validation successful"
  exit 0
fi
