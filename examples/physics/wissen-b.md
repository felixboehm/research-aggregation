# Battery Storage Systems

## 1. Lithium-Ion Batteries

### Chemistry Variants
| Chemistry | Energy Density | Cycle Life | Cost (2025) | Best For |
|---|---|---|---|---|
| NMC (Nickel-Manganese-Cobalt) | 150–250 Wh/kg | 2,000–4,000 | $130–180/kWh | EVs, compact residential |
| LFP (Lithium Iron Phosphate) | 90–160 Wh/kg | 4,000–8,000 | $80–120/kWh | Grid storage, safety-critical |
| NCA (Nickel-Cobalt-Aluminum) | 200–300 Wh/kg | 1,500–3,000 | $140–200/kWh | High-performance EVs |

### Round-Trip Efficiency
- DC round-trip: **92–96%** (charge → store → discharge)
- AC round-trip (including inverter losses): **85–90%**
- Degrades with age: ~0.5% efficiency loss per 1,000 cycles

## 2. Flow Batteries

### Vanadium Redox Flow Battery (VRFB)
- Energy and power are **independently scalable** (bigger tank = more energy, bigger stack = more power)
- Round-trip efficiency: **70–80%** (lower than Li-ion)
- Cycle life: **>15,000 cycles** (effectively unlimited for grid applications)
- Cost: $300–500/kWh (declining, but higher than LFP)
- **Advantage**: No degradation of electrolyte — can last 20+ years

### Best Application
Flow batteries excel at **long-duration storage** (4–12 hours), where Li-ion's cost advantage disappears. For durations beyond 8 hours, VRFB has lower LCOS (Levelized Cost of Storage).

## 3. Degradation

### Calendar Aging
- Batteries degrade even when idle: **1–3% capacity loss per year**
- Accelerated by high temperature and high state of charge
- **Best practice**: Store at 50% SoC in cool environment

### Cycle Aging
- Each full charge/discharge cycle causes ~0.01–0.02% capacity loss
- Depth of discharge (DoD) matters: Limiting to 80% DoD extends life by ~40%
- C-rate: Fast charging (>1C) accelerates degradation

## 4. System Sizing

### Residential (paired with solar)
```
Rule of thumb: Battery capacity (kWh) ≈ Daily consumption (kWh) × 0.5–0.8
Example: 15 kWh/day consumption → 8–12 kWh battery
```

### Grid-Scale
- **Peaking/frequency regulation**: 1–2 hour duration, high power
- **Load shifting**: 4 hour duration (most common utility deployment)
- **Seasonal storage**: 100+ hours — not economical with batteries (hydrogen or pumped hydro)
