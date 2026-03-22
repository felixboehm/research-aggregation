# Grid Integration: Solar + Storage Combined

## 1. The Duck Curve Problem

As solar penetration increases, net load (demand minus solar) creates a "duck curve":
- **Midday**: Solar floods the grid → net load drops to near zero or negative
- **Evening ramp**: Solar drops off → net load spikes within 2–3 hours
- **Magnitude**: California's evening ramp reaches **13 GW in 3 hours** (2024 data)

### How Storage Solves It
Battery storage absorbs midday surplus and discharges during the evening ramp:
- Reduces curtailment (wasted solar)
- Smooths the evening ramp (reduces need for gas peakers)
- **4-hour batteries** cover ~80% of the duck curve problem

## 2. Synergies

### Synergy: Solar + Battery Self-Consumption
- Without battery: Self-consumption rate ~30% (rest exported at low feed-in tariff)
- With battery: Self-consumption rate ~**60–80%** (2–3x improvement)
- Economic value depends on spread between retail electricity price and feed-in tariff

### Synergy: Battery + Demand Response
- Smart appliances (water heater, EV charging, HVAC) shift load to solar peak hours
- Battery provides buffer for imperfect load shifting
- **Combined effect**: Self-consumption can reach **85–95%** with solar + battery + demand response

### Synergy: Oversized Solar + Moderate Battery
- Counter-intuitive: Adding 30% more solar panels is often cheaper than adding 30% more battery
- Excess solar charges battery faster → more cycles → more value from battery investment
- **Sweet spot**: Solar-to-battery ratio of 2.5–3.5:1 (kWp to kWh)

## 3. Conflicts

### Conflict: Battery Cycling vs. Longevity
- Maximizing self-consumption → **more cycles per day** → faster degradation
- Typical residential: 250–350 full equivalent cycles/year
- At 0.02% loss per cycle → **5–7% capacity loss per year** (faster than calendar aging alone)
- **Trade-off**: More aggressive cycling earns more revenue but shortens battery life

### Conflict: Grid Export vs. Self-Consumption
- High feed-in tariffs → better to export (skip battery, save cycle degradation)
- Low feed-in tariffs → better to store and self-consume
- **Tipping point**: When retail price > 2.5x feed-in tariff, self-consumption always wins

### Conflict: Seasonal Mismatch
- Summer: Excess solar, battery fully charged by noon, rest curtailed
- Winter: Insufficient solar, battery rarely fully charged
- **4-hour batteries cannot solve seasonal mismatch** — this requires either:
  - Grid interconnection (import winter power)
  - Seasonal storage (hydrogen, pumped hydro)
  - Oversized solar (economically questionable at 50° latitude)

## 4. Worked Example

**Scenario**: Residential, 50° latitude, 10 kWp solar + 10 kWh LFP battery

| Metric | Solar Only | Solar + Battery | Solar + Battery + DR |
|---|---|---|---|
| Self-consumption | 30% | 65% | 82% |
| Grid import reduction | 35% | 55% | 70% |
| Annual savings | $600 | $1,100 | $1,400 |
| System cost | $8,000 | $16,000 | $17,500 |
| Simple payback | 13.3 years | 14.5 years | 12.5 years |
| LCOE (self-consumed) | $0.04/kWh | $0.07/kWh | $0.065/kWh |

**Key insight**: Adding demand response to solar + battery is the cheapest marginal improvement — $1,500 extra investment yields $300/year additional savings (5-year payback on the increment).
