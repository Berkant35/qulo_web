---
name: economy
description: Economy config watchdog — check health, detect drift, validate boundaries. Use when economy files are edited or on manual /economy invocation.
---

# Economy Watchdog

## Triggered By
- Manual: `/economy` command
- Automatic: Hook fires when economy-related files are edited

## Mode A — Automatic Check (on file edit trigger)

When an economy-related file is edited, check:

1. **Hardcoded detection:** Scan the changed file for new hardcoded diamond amounts, ratios, or limits that should be in economy config
2. **Drift check:** Compare Flutter fallback values in `EconomyConfig.fallback` (qulov2/lib/data/models/economy_config_model.dart) against server's active config (`curl localhost:3001/api/v1/app/economy`)
3. **Migration check:** If new constants are added to any service file, flag them for economy config migration

Report findings to user with actionable suggestions.

## Mode B — Manual Report (`/economy`)

Generate a full economy health report:

1. Fetch active config: `curl -s http://localhost:3001/api/v1/app/economy | jq .`
   - If server unreachable, try Railway: `curl -s https://qulo-server-production.up.railway.app/api/v1/app/economy | jq .`
2. Show current active config version and all values in a formatted table
3. Compare Flutter fallback (`EconomyConfig.fallback` in economy_config_model.dart) vs server config — flag any mismatches
4. Health score: X/Y values synchronized

## Mode C — Safety Boundaries (always active)

These boundaries MUST be enforced when suggesting or reviewing economy config changes:

| Value | Min | Max |
|-------|-----|-----|
| greenDiamondRewardRatio | 0.10 | 0.50 |
| boostCostGreen | 5 | 200 |
| boostDurationMinutes | 5 | 120 |
| greenToPurpleRatio | 1 | 10 |
| dailyDiscovers (free) | 10 | 200 |
| maxQuestions (free) | 2 | 6 |
| dailyUndos (free) | 0 | 5 |
| referralPurple | 5 | 100 |
| questionTimeSeconds | 10 | 120 |
| timeExtendSeconds | 5 | 60 |
| monthlyPurpleBonus (plus) | 100 | 2000 |
| monthlyPurpleBonus (premium) | 500 | 5000 |
| chatQuestionDaily (free) | 1 | 10 |
| chatQuestionUnmatchRisk (free) | 1 | 5 |
| questionCountMultipliers (each) | 0.1 | 3.0 |

If any value is outside boundaries, show a WARNING with explanation of the risk.

## Key Files
- Server config service: `qulo-server/src/services/economy-config.service.ts`
- Zod schema + boundaries: `qulo-server/src/types/economy-config.schema.ts`
- Flutter model + fallback: `qulov2/lib/data/models/economy_config_model.dart`
- Flutter provider: `qulov2/lib/providers/economy_config_provider.dart`
- Server constants (should be empty of economy values): `qulo-server/src/types/index.ts`
- Admin panel: `http://localhost:3001/admin/economy-config`
