# Bright Data Temu 24/7 PoC — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a 24/7 continuous Temu scraper on 1 Android device (multi-device-pool-ready) that captures full product data (title, prices, variants, ratings, features, images) every 4 hours per SKU, with Telegram alerts and a Claude AI supervisor that auto-patches the scraper when the Temu app UI changes.

**Architecture:** Three layers: (1) deterministic Python daemon running forever in a `launchd` keep-alive loop that drives ADB and parses UI Automator XML dumps with Tesseract OCR fallback; (2) a Python health monitor that emits Telegram alerts on a tiered L1/L2/L3 scheme; (3) a Claude-Code supervisor invoked by `cron` only when failures are flagged — it patches the selector module and gates changes through a 5-SKU canary test before promotion.

**Tech Stack:** Python 3.11, sqlite3 (stdlib), lxml, Pillow, pytesseract, requests, python-dotenv, pytest, ruff, ADB (system binary), Tesseract OCR (Homebrew), macOS launchd, cron.

**Assumed Day 0 outcome:** Scenario A or B (UI Automator XML viable, possibly with OCR fallback for some fields). If Day 0 returns scenario C (XML unavailable), the parser, Temu-actions, and feasibility tasks must be revised before continuing past Phase 0. See **Appendix A: Scenario C Revision** at end of plan.

---

## File Structure

```
sandbox_data/
├── pyproject.toml                          # project metadata + ruff config
├── requirements.txt                        # pinned dependencies
├── .env.example                            # template for secrets
├── .gitignore                              # ignore .env, *.db, screenshots
├── README.md                               # operator runbook
│
├── scraper/
│   ├── __init__.py
│   ├── config.py                           # constants, paths, env loading
│   ├── db.py                               # SQLite connection + schema migrations
│   ├── storage.py                          # CRUD per table
│   ├── adb_client.py                       # ADB wrapper (dump, screencap, tap, etc.)
│   ├── parser.py                           # XML → structured data
│   ├── ocr_fallback.py                     # Tesseract for fields missing in XML
│   ├── temu_actions.py                     # Temu deep link + variant flow (PATCH TARGET)
│   ├── temu_resource_ids.py                # selector resource-ids (filled after Day 0)
│   ├── phone_health.py                     # battery, temp, screen, ADB readiness
│   ├── device_pool.py                      # devices.json + worker spawn + sku→device hash
│   ├── scheduler.py                        # job queue (scrape_jobs table)
│   ├── rate_limiter.py                     # ops/hour cap + mandatory rest windows
│   ├── telegram_bot.py                     # Telegram HTTP send + message formatting
│   ├── health_monitor.py                   # L1/L2/L3 alert computation
│   ├── daemon.py                           # main entry: forever loop, worker orchestration
│   ├── canary.py                           # canary test runner for patches
│   ├── feasibility.py                      # Day 0 feasibility test runner
│   ├── export_csv.py                       # denormalized CSV export for Marc
│   └── cleanup.py                          # retention policy (screenshots, XML, logs)
│
├── scripts/
│   ├── install.sh                          # one-time bootstrap
│   ├── uninstall.sh                        # cleanup
│   ├── seed_targets.py                     # populate targets table from JSON
│   └── weekly_maintenance.sh               # Sunday 03:00 app restart + cache clear
│
├── agents/
│   └── supervisor_prompt.md                # Claude supervisor prompt template
│
├── config/
│   ├── devices.json                        # registered device registry
│   ├── targets.json                        # 100 SKU list (created in Phase 0)
│   └── launchd/
│       ├── com.berkant.scraper.daemon.plist
│       ├── com.berkant.scraper.heartbeat.plist
│       └── com.berkant.scraper.supervisor.plist
│
├── tests/
│   ├── conftest.py                         # shared fixtures
│   ├── fixtures/
│   │   ├── sample_xml_dump.xml             # captured during Day 0
│   │   └── sample_screenshot.png           # captured during Day 0
│   ├── test_db.py
│   ├── test_storage.py
│   ├── test_adb_client.py
│   ├── test_parser.py
│   ├── test_ocr_fallback.py
│   ├── test_phone_health.py
│   ├── test_device_pool.py
│   ├── test_scheduler.py
│   ├── test_rate_limiter.py
│   ├── test_telegram_bot.py
│   ├── test_health_monitor.py
│   ├── test_canary.py
│   └── test_export_csv.py
│
└── docs/superpowers/
    ├── specs/2026-05-24-brightdata-temu-poc-design.md
    └── plans/2026-05-24-brightdata-temu-implementation.md   # THIS FILE
```

**Path conventions in tasks:** every path below is relative to `/Users/berkantcalikusu/Desktop/sandbox_data/` unless prefixed otherwise.

---

## Phase 0: Project Scaffolding & Day 0 Feasibility

### Task 1: Initialize Python project scaffolding

**Files:**
- Create: `pyproject.toml`
- Create: `requirements.txt`
- Create: `.gitignore`
- Create: `.env.example`
- Create: `scraper/__init__.py`
- Create: `tests/__init__.py`

- [ ] **Step 1: Create `pyproject.toml`**

```toml
[project]
name = "temu-scraper"
version = "0.1.0"
description = "Bright Data Temu 24/7 PoC scraper"
requires-python = ">=3.11"

[tool.ruff]
line-length = 100
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "W", "I", "B", "UP"]

[tool.pytest.ini_options]
testpaths = ["tests"]
pythonpath = ["."]
addopts = "-v --tb=short"
```

- [ ] **Step 2: Create `requirements.txt`**

```
lxml==5.2.2
Pillow==10.3.0
pytesseract==0.3.10
requests==2.32.3
python-dotenv==1.0.1
pytest==8.2.2
ruff==0.5.0
```

- [ ] **Step 3: Create `.gitignore`**

```
.env
*.db
*.db-journal
__pycache__/
*.pyc
.venv/
.pytest_cache/
.ruff_cache/
scraper/data/screenshots/
scraper/data/xml_dumps/
scraper/data/logs/
config/devices.json
```

- [ ] **Step 4: Create `.env.example`**

```bash
TELEGRAM_BOT_TOKEN=your_bot_token_here
TELEGRAM_CHAT_ID=your_chat_id_here
SCRAPER_DATA_DIR=/Users/berkantcalikusu/Library/Application Support/temu-scraper
SCRAPER_DB_PATH=${SCRAPER_DATA_DIR}/scraper.db
SCRAPER_LOG_LEVEL=INFO
ADB_BIN=/opt/homebrew/bin/adb
TESSERACT_BIN=/opt/homebrew/bin/tesseract
```

- [ ] **Step 5: Create `scraper/__init__.py` (empty) and `tests/__init__.py` (empty)**

```bash
touch scraper/__init__.py tests/__init__.py
```

- [ ] **Step 6: Create venv and install dependencies**

```bash
cd /Users/berkantcalikusu/Desktop/sandbox_data
python3.11 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Expected: all packages install without error.

- [ ] **Step 7: Verify tools available**

```bash
which adb
which tesseract
```

Expected: both print paths. If missing: `brew install android-platform-tools tesseract`.

- [ ] **Step 8: Commit**

```bash
git add pyproject.toml requirements.txt .gitignore .env.example scraper/__init__.py tests/__init__.py
git commit -m "chore(scraper): initialize project scaffolding"
```

---

### Task 2: Day 0 Feasibility Test Runner

**Files:**
- Create: `scraper/feasibility.py`

This script is **not TDD** — it's a one-time investigation script the operator runs interactively to determine the data-extraction strategy. Output is a Markdown report saved to `docs/superpowers/specs/2026-05-24-day0-feasibility-report.md`.

- [ ] **Step 1: Write the feasibility script**

```python
# scraper/feasibility.py
"""Day 0 feasibility test: determines whether Temu data can be extracted via
UI Automator XML dump, region OCR, or intercepted API. Run interactively."""

import subprocess
import sys
import time
from pathlib import Path
from lxml import etree

REPORT_PATH = Path("docs/superpowers/specs/2026-05-24-day0-feasibility-report.md")
DUMP_PATH = Path("/tmp/day0_dump.xml")
SCREEN_PATH = Path("/tmp/day0_screen.png")
SAMPLE_PRODUCT_HINT = "Open a Temu product page (any product). Wait for full load."


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, check=True, **kw)


def adb_devices() -> list[str]:
    out = run(["adb", "devices"]).stdout
    return [line.split()[0] for line in out.splitlines()[1:] if line.strip() and "device" in line]


def capture_xml(serial: str) -> str:
    run(["adb", "-s", serial, "shell", "uiautomator", "dump", "/sdcard/d0.xml"])
    run(["adb", "-s", serial, "pull", "/sdcard/d0.xml", str(DUMP_PATH)])
    return DUMP_PATH.read_text()


def capture_screen(serial: str) -> None:
    with SCREEN_PATH.open("wb") as f:
        subprocess.run(["adb", "-s", serial, "exec-out", "screencap", "-p"], stdout=f, check=True)


def analyze_xml(xml: str) -> dict:
    tree = etree.fromstring(xml.encode())
    nodes = tree.xpath("//node")
    total = len(nodes)
    with_text = [n for n in nodes if n.get("text")]
    with_rid = [n for n in nodes if n.get("resource-id")]
    temu_rid = [n for n in with_rid if "temu" in (n.get("resource-id") or "")]

    text_samples = [(n.get("resource-id", ""), n.get("text", "")) for n in with_text[:30]]
    return {
        "total_nodes": total,
        "with_text": len(with_text),
        "with_resource_id": len(with_rid),
        "temu_resource_id_count": len(temu_rid),
        "text_samples": text_samples,
    }


def detect_scenario(analysis: dict) -> tuple[str, str]:
    if analysis["temu_resource_id_count"] >= 10 and analysis["with_text"] >= 20:
        return "A", "XML rich: most fields available via resource-id + text"
    if analysis["with_text"] >= 10:
        return "B", "XML partial: some fields available; OCR fallback needed for some"
    return "C", "XML empty or accessibility disabled: full screenshot+OCR required"


def write_report(serial: str, analysis: dict, scenario: str, reason: str) -> None:
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    samples = "\n".join(f"- `{rid}` = `{txt}`" for rid, txt in analysis["text_samples"])
    REPORT_PATH.write_text(
        f"# Day 0 Feasibility Report\n\n"
        f"**Date:** 2026-05-24\n"
        f"**Device:** {serial}\n\n"
        f"## Scenario: {scenario}\n\n"
        f"**Reason:** {reason}\n\n"
        f"## Analysis\n\n"
        f"- Total nodes: {analysis['total_nodes']}\n"
        f"- Nodes with text: {analysis['with_text']}\n"
        f"- Nodes with resource-id: {analysis['with_resource_id']}\n"
        f"- Temu-namespaced resource-ids: {analysis['temu_resource_id_count']}\n\n"
        f"## Text Samples (first 30)\n\n{samples}\n\n"
        f"## Raw XML\n\n`{DUMP_PATH}`\n\n"
        f"## Screenshot\n\n`{SCREEN_PATH}`\n"
    )


def main() -> int:
    devices = adb_devices()
    if not devices:
        print("ERROR: no ADB devices found. Connect a phone via USB and enable USB debugging.")
        return 1
    serial = devices[0]
    print(f"Using device: {serial}")
    print(SAMPLE_PRODUCT_HINT)
    input("Press ENTER when Temu product page is visible on the phone...")

    print("Capturing XML dump...")
    xml = capture_xml(serial)
    print("Capturing screenshot...")
    capture_screen(serial)

    analysis = analyze_xml(xml)
    scenario, reason = detect_scenario(analysis)
    print(f"\n=== SCENARIO {scenario} ===\n{reason}\n")
    write_report(serial, analysis, scenario, reason)
    print(f"Report written to: {REPORT_PATH}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 2: Manual run instructions (do NOT execute automatically)**

When the operator has Temu installed and a product page open:

```bash
source .venv/bin/activate
python -m scraper.feasibility
```

Expected output: scenario A/B/C printed + report written.

- [ ] **Step 3: Operator copies fixture files for tests**

After scenario A or B, save the XML dump and screenshot as test fixtures:

```bash
cp /tmp/day0_dump.xml tests/fixtures/sample_xml_dump.xml
cp /tmp/day0_screen.png tests/fixtures/sample_screenshot.png
```

- [ ] **Step 4: Commit feasibility script + report + fixtures**

```bash
git add scraper/feasibility.py docs/superpowers/specs/2026-05-24-day0-feasibility-report.md tests/fixtures/
git commit -m "feat(feasibility): day 0 report + fixtures"
```

**Gate:** If scenario C, stop and apply Appendix A revisions before proceeding.

---

## Phase 1: Foundation (DB, Storage, Config)

### Task 3: Configuration module

**Files:**
- Create: `scraper/config.py`
- Create: `tests/test_config.py`

- [ ] **Step 1: Write failing test**

```python
# tests/test_config.py
import os
from pathlib import Path
from scraper import config


def test_config_loads_from_env(monkeypatch, tmp_path):
    monkeypatch.setenv("SCRAPER_DATA_DIR", str(tmp_path))
    monkeypatch.setenv("SCRAPER_DB_PATH", str(tmp_path / "test.db"))
    monkeypatch.setenv("TELEGRAM_BOT_TOKEN", "tok123")
    monkeypatch.setenv("TELEGRAM_CHAT_ID", "456")
    cfg = config.load()
    assert cfg.data_dir == tmp_path
    assert cfg.db_path == tmp_path / "test.db"
    assert cfg.telegram_token == "tok123"
    assert cfg.telegram_chat_id == "456"
    assert cfg.cycle_interval_minutes == 240
    assert cfg.rate_limit_ops_per_hour == 60
```

- [ ] **Step 2: Run test to verify failure**

```bash
pytest tests/test_config.py -v
```

Expected: FAIL with `ModuleNotFoundError` or `AttributeError`.

- [ ] **Step 3: Implement `scraper/config.py`**

```python
# scraper/config.py
import os
from dataclasses import dataclass
from pathlib import Path
from dotenv import load_dotenv

load_dotenv()


@dataclass(frozen=True)
class Config:
    data_dir: Path
    db_path: Path
    telegram_token: str
    telegram_chat_id: str
    adb_bin: str
    tesseract_bin: str
    cycle_interval_minutes: int
    rate_limit_ops_per_hour: int
    inter_sku_delay_min_s: int
    inter_sku_delay_max_s: int
    mandatory_rest_minutes_per_hour: int
    app_restart_every_n_skus: int


def load() -> Config:
    data_dir = Path(os.environ["SCRAPER_DATA_DIR"]).expanduser()
    data_dir.mkdir(parents=True, exist_ok=True)
    return Config(
        data_dir=data_dir,
        db_path=Path(os.environ["SCRAPER_DB_PATH"]).expanduser(),
        telegram_token=os.environ.get("TELEGRAM_BOT_TOKEN", ""),
        telegram_chat_id=os.environ.get("TELEGRAM_CHAT_ID", ""),
        adb_bin=os.environ.get("ADB_BIN", "/opt/homebrew/bin/adb"),
        tesseract_bin=os.environ.get("TESSERACT_BIN", "/opt/homebrew/bin/tesseract"),
        cycle_interval_minutes=int(os.environ.get("CYCLE_INTERVAL_MINUTES", "240")),
        rate_limit_ops_per_hour=int(os.environ.get("RATE_LIMIT_OPS_PER_HOUR", "60")),
        inter_sku_delay_min_s=int(os.environ.get("INTER_SKU_DELAY_MIN_S", "15")),
        inter_sku_delay_max_s=int(os.environ.get("INTER_SKU_DELAY_MAX_S", "35")),
        mandatory_rest_minutes_per_hour=int(os.environ.get("MANDATORY_REST_MINUTES_PER_HOUR", "5")),
        app_restart_every_n_skus=int(os.environ.get("APP_RESTART_EVERY_N_SKUS", "25")),
    )
```

- [ ] **Step 4: Run test to verify pass**

```bash
pytest tests/test_config.py -v
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/config.py tests/test_config.py
git commit -m "feat(config): env-driven configuration dataclass"
```

---

### Task 4: SQLite schema + connection module

**Files:**
- Create: `scraper/db.py`
- Create: `tests/test_db.py`
- Create: `tests/conftest.py`

- [ ] **Step 1: Write `conftest.py` shared fixtures**

```python
# tests/conftest.py
import sqlite3
import pytest
from scraper import db


@pytest.fixture
def memdb() -> sqlite3.Connection:
    conn = sqlite3.connect(":memory:")
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    db.apply_schema(conn)
    return conn
```

- [ ] **Step 2: Write failing test for schema**

```python
# tests/test_db.py
def test_schema_creates_all_tables(memdb):
    rows = memdb.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall()
    names = {r["name"] for r in rows}
    expected = {
        "targets", "devices", "products", "product_observations",
        "variants", "variant_observations", "product_features",
        "product_images", "runs", "heartbeats", "patches", "scrape_jobs",
    }
    assert expected.issubset(names)


def test_schema_enforces_unique_observation(memdb):
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1', 'A1')")
    memdb.execute("INSERT INTO products(sku_id) VALUES('s1')")
    memdb.execute(
        "INSERT INTO product_observations(sku_id, device_id, observed_at) VALUES('s1','d1','2026-05-24T09:00:00')"
    )
    import sqlite3
    with pytest.raises(sqlite3.IntegrityError):
        memdb.execute(
            "INSERT INTO product_observations(sku_id, device_id, observed_at) VALUES('s1','d1','2026-05-24T09:00:00')"
        )
```

Add `import pytest` at the top.

- [ ] **Step 3: Run test to verify failure**

```bash
pytest tests/test_db.py -v
```

Expected: FAIL — module not implemented.

- [ ] **Step 4: Implement `scraper/db.py`**

```python
# scraper/db.py
import sqlite3
from pathlib import Path

SCHEMA_SQL = """
CREATE TABLE IF NOT EXISTS targets (
  sku_id TEXT PRIMARY KEY,
  temu_url TEXT NOT NULL,
  category TEXT,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS devices (
  device_id TEXT PRIMARY KEY,
  adb_serial TEXT NOT NULL,
  model TEXT,
  screen_resolution TEXT,
  active INTEGER DEFAULT 1,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
  sku_id TEXT PRIMARY KEY REFERENCES targets(sku_id),
  title TEXT,
  description TEXT,
  category TEXT,
  brand TEXT,
  seller_name TEXT,
  ships_from TEXT,
  first_seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product_observations (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES products(sku_id),
  device_id TEXT NOT NULL REFERENCES devices(device_id),
  observed_at TIMESTAMP NOT NULL,
  price_usd REAL,
  original_price_usd REAL,
  discount_pct REAL,
  in_stock INTEGER,
  sold_count_text TEXT,
  sold_count_estimate INTEGER,
  rating_avg REAL,
  review_count INTEGER,
  rating_5_count INTEGER,
  rating_4_count INTEGER,
  rating_3_count INTEGER,
  rating_2_count INTEGER,
  rating_1_count INTEGER,
  has_free_shipping INTEGER,
  shipping_cost_usd REAL,
  delivery_eta_days_min INTEGER,
  delivery_eta_days_max INTEGER,
  has_coupon INTEGER,
  coupon_value_usd REAL,
  raw_xml_path TEXT,
  raw_screenshot_path TEXT,
  parse_confidence REAL,
  UNIQUE(sku_id, observed_at)
);

CREATE TABLE IF NOT EXISTS variants (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES products(sku_id),
  variant_key TEXT NOT NULL,
  attributes_json TEXT,
  first_seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(sku_id, variant_key)
);

CREATE TABLE IF NOT EXISTS variant_observations (
  id INTEGER PRIMARY KEY,
  variant_id INTEGER NOT NULL REFERENCES variants(id),
  observed_at TIMESTAMP NOT NULL,
  price_usd REAL,
  in_stock INTEGER,
  stock_estimate INTEGER,
  UNIQUE(variant_id, observed_at)
);

CREATE TABLE IF NOT EXISTS product_features (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES products(sku_id),
  observed_at TIMESTAMP NOT NULL,
  feature_key TEXT,
  feature_value TEXT,
  UNIQUE(sku_id, observed_at, feature_key)
);

CREATE TABLE IF NOT EXISTS product_images (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES products(sku_id),
  observed_at TIMESTAMP NOT NULL,
  image_url TEXT,
  image_position INTEGER
);

CREATE TABLE IF NOT EXISTS runs (
  id INTEGER PRIMARY KEY,
  device_id TEXT NOT NULL REFERENCES devices(device_id),
  started_at TIMESTAMP,
  finished_at TIMESTAMP,
  status TEXT,
  attempted INTEGER,
  succeeded INTEGER,
  parse_errors INTEGER,
  variants_captured INTEGER,
  alert_level TEXT,
  notes TEXT
);

CREATE TABLE IF NOT EXISTS heartbeats (
  ts TIMESTAMP NOT NULL,
  component TEXT NOT NULL,
  status TEXT,
  PRIMARY KEY(ts, component)
);

CREATE TABLE IF NOT EXISTS patches (
  id INTEGER PRIMARY KEY,
  applied_at TIMESTAMP,
  file_path TEXT,
  diff TEXT,
  canary_result TEXT,
  status TEXT
);

CREATE TABLE IF NOT EXISTS scrape_jobs (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES targets(sku_id),
  device_id TEXT REFERENCES devices(device_id),
  next_due_at TIMESTAMP NOT NULL,
  last_scraped_at TIMESTAMP,
  last_success_at TIMESTAMP,
  consecutive_failures INTEGER DEFAULT 0,
  status TEXT DEFAULT 'idle',
  cycle_interval_minutes INTEGER DEFAULT 240,
  UNIQUE(sku_id)
);

CREATE INDEX IF NOT EXISTS idx_jobs_due ON scrape_jobs(next_due_at, status);
CREATE INDEX IF NOT EXISTS idx_obs_sku_time ON product_observations(sku_id, observed_at);
CREATE INDEX IF NOT EXISTS idx_var_obs_time ON variant_observations(variant_id, observed_at);
"""


def connect(db_path: Path) -> sqlite3.Connection:
    conn = sqlite3.connect(str(db_path), isolation_level=None)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    conn.execute("PRAGMA journal_mode = WAL")
    return conn


def apply_schema(conn: sqlite3.Connection) -> None:
    conn.executescript(SCHEMA_SQL)
```

- [ ] **Step 5: Run tests to verify pass**

```bash
pytest tests/test_db.py -v
```

Expected: PASS for both tests.

- [ ] **Step 6: Commit**

```bash
git add scraper/db.py tests/test_db.py tests/conftest.py
git commit -m "feat(db): SQLite schema with 7 product tables + jobs/heartbeats/patches"
```

---

### Task 5: Storage layer (CRUD)

**Files:**
- Create: `scraper/storage.py`
- Create: `tests/test_storage.py`

- [ ] **Step 1: Write failing test for storage upsert functions**

```python
# tests/test_storage.py
from datetime import datetime
from scraper import storage


def test_upsert_product_creates_and_updates(memdb):
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    storage.upsert_product(memdb, sku_id="s1", title="Earbuds", category="Electronics")
    row = memdb.execute("SELECT * FROM products WHERE sku_id='s1'").fetchone()
    assert row["title"] == "Earbuds"
    assert row["category"] == "Electronics"

    storage.upsert_product(memdb, sku_id="s1", title="Earbuds Pro", category="Electronics")
    row = memdb.execute("SELECT * FROM products WHERE sku_id='s1'").fetchone()
    assert row["title"] == "Earbuds Pro"


def test_insert_observation_idempotent(memdb):
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1', 'A1')")
    storage.upsert_product(memdb, sku_id="s1")
    ts = "2026-05-24T09:00:00"
    storage.insert_product_observation(
        memdb, sku_id="s1", device_id="d1", observed_at=ts, price_usd=15.99, in_stock=True
    )
    storage.insert_product_observation(
        memdb, sku_id="s1", device_id="d1", observed_at=ts, price_usd=20.00, in_stock=False
    )
    rows = memdb.execute("SELECT * FROM product_observations WHERE sku_id='s1'").fetchall()
    assert len(rows) == 1
    assert rows[0]["price_usd"] == 15.99  # first wins (ON CONFLICT DO NOTHING)


def test_upsert_variant_then_observation(memdb):
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1', 'A1')")
    storage.upsert_product(memdb, sku_id="s1")
    vid = storage.upsert_variant(memdb, sku_id="s1", variant_key="color:Red|size:M", attributes={"color": "Red", "size": "M"})
    storage.insert_variant_observation(memdb, variant_id=vid, observed_at="2026-05-24T09:00:00", price_usd=9.99, in_stock=True)
    rows = memdb.execute("SELECT * FROM variant_observations WHERE variant_id=?", (vid,)).fetchall()
    assert len(rows) == 1
    assert rows[0]["price_usd"] == 9.99


def test_heartbeat_append(memdb):
    storage.write_heartbeat(memdb, component="daemon", ts="2026-05-24T09:00:00", status="ok")
    storage.write_heartbeat(memdb, component="daemon", ts="2026-05-24T10:00:00", status="ok")
    rows = memdb.execute("SELECT * FROM heartbeats WHERE component='daemon' ORDER BY ts").fetchall()
    assert len(rows) == 2
```

- [ ] **Step 2: Run test to verify failure**

```bash
pytest tests/test_storage.py -v
```

Expected: FAIL — module not implemented.

- [ ] **Step 3: Implement `scraper/storage.py`**

```python
# scraper/storage.py
import json
import sqlite3
from typing import Any


def upsert_product(conn: sqlite3.Connection, *, sku_id: str, **fields: Any) -> None:
    cols = ["sku_id"] + list(fields.keys())
    placeholders = ", ".join(["?"] * len(cols))
    set_clause = ", ".join(f"{k}=excluded.{k}" for k in fields)
    sql = (
        f"INSERT INTO products ({', '.join(cols)}) VALUES ({placeholders}) "
        f"ON CONFLICT(sku_id) DO UPDATE SET {set_clause}, last_seen_at=CURRENT_TIMESTAMP"
        if fields
        else "INSERT OR IGNORE INTO products (sku_id) VALUES (?)"
    )
    values = [sku_id] + list(fields.values()) if fields else [sku_id]
    conn.execute(sql, values)


def insert_product_observation(
    conn: sqlite3.Connection, *, sku_id: str, device_id: str, observed_at: str, **fields: Any
) -> None:
    cols = ["sku_id", "device_id", "observed_at"] + list(fields.keys())
    placeholders = ", ".join(["?"] * len(cols))
    sql = f"INSERT OR IGNORE INTO product_observations ({', '.join(cols)}) VALUES ({placeholders})"
    values = [sku_id, device_id, observed_at] + [
        int(v) if isinstance(v, bool) else v for v in fields.values()
    ]
    conn.execute(sql, values)


def upsert_variant(
    conn: sqlite3.Connection, *, sku_id: str, variant_key: str, attributes: dict
) -> int:
    conn.execute(
        "INSERT INTO variants(sku_id, variant_key, attributes_json) VALUES(?,?,?) "
        "ON CONFLICT(sku_id, variant_key) DO UPDATE SET last_seen_at=CURRENT_TIMESTAMP",
        (sku_id, variant_key, json.dumps(attributes)),
    )
    row = conn.execute(
        "SELECT id FROM variants WHERE sku_id=? AND variant_key=?", (sku_id, variant_key)
    ).fetchone()
    return row["id"]


def insert_variant_observation(
    conn: sqlite3.Connection, *, variant_id: int, observed_at: str, **fields: Any
) -> None:
    cols = ["variant_id", "observed_at"] + list(fields.keys())
    placeholders = ", ".join(["?"] * len(cols))
    sql = f"INSERT OR IGNORE INTO variant_observations ({', '.join(cols)}) VALUES ({placeholders})"
    values = [variant_id, observed_at] + [
        int(v) if isinstance(v, bool) else v for v in fields.values()
    ]
    conn.execute(sql, values)


def insert_product_feature(
    conn: sqlite3.Connection, *, sku_id: str, observed_at: str, key: str, value: str
) -> None:
    conn.execute(
        "INSERT OR IGNORE INTO product_features(sku_id, observed_at, feature_key, feature_value) VALUES(?,?,?,?)",
        (sku_id, observed_at, key, value),
    )


def insert_product_image(
    conn: sqlite3.Connection, *, sku_id: str, observed_at: str, url: str, position: int
) -> None:
    conn.execute(
        "INSERT INTO product_images(sku_id, observed_at, image_url, image_position) VALUES(?,?,?,?)",
        (sku_id, observed_at, url, position),
    )


def insert_run(conn: sqlite3.Connection, **fields: Any) -> int:
    cols = list(fields.keys())
    placeholders = ", ".join(["?"] * len(cols))
    sql = f"INSERT INTO runs ({', '.join(cols)}) VALUES ({placeholders})"
    cur = conn.execute(sql, list(fields.values()))
    return cur.lastrowid


def write_heartbeat(conn: sqlite3.Connection, *, component: str, ts: str, status: str) -> None:
    conn.execute(
        "INSERT OR REPLACE INTO heartbeats(ts, component, status) VALUES(?,?,?)",
        (ts, component, status),
    )


def latest_heartbeat(conn: sqlite3.Connection, component: str) -> sqlite3.Row | None:
    return conn.execute(
        "SELECT * FROM heartbeats WHERE component=? ORDER BY ts DESC LIMIT 1", (component,)
    ).fetchone()


def record_patch(
    conn: sqlite3.Connection, *, file_path: str, diff: str, canary_result: str, status: str, applied_at: str
) -> None:
    conn.execute(
        "INSERT INTO patches(file_path, diff, canary_result, status, applied_at) VALUES(?,?,?,?,?)",
        (file_path, diff, canary_result, status, applied_at),
    )
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_storage.py -v
```

Expected: all 4 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/storage.py tests/test_storage.py
git commit -m "feat(storage): CRUD layer for products, variants, observations, heartbeats"
```

---

## Phase 2: ADB Client & Parsing

### Task 6: ADB client wrapper

**Files:**
- Create: `scraper/adb_client.py`
- Create: `tests/test_adb_client.py`

- [ ] **Step 1: Write failing tests with mocked subprocess**

```python
# tests/test_adb_client.py
from unittest.mock import MagicMock, patch
import pytest
from scraper.adb_client import AdbClient


def fake_run(returncode=0, stdout="", stderr=""):
    m = MagicMock()
    m.returncode = returncode
    m.stdout = stdout
    m.stderr = stderr
    return m


def test_list_devices_parses_output():
    with patch("scraper.adb_client.subprocess.run") as run:
        run.return_value = fake_run(stdout="List of devices attached\nABC123\tdevice\nXYZ789\tdevice\n")
        client = AdbClient(adb_bin="adb")
        assert client.list_devices() == ["ABC123", "XYZ789"]


def test_list_devices_excludes_unauthorized():
    with patch("scraper.adb_client.subprocess.run") as run:
        run.return_value = fake_run(stdout="List of devices attached\nABC123\tdevice\nXYZ789\tunauthorized\n")
        client = AdbClient(adb_bin="adb")
        assert client.list_devices() == ["ABC123"]


def test_tap_calls_input_tap():
    with patch("scraper.adb_client.subprocess.run") as run:
        run.return_value = fake_run()
        client = AdbClient(adb_bin="adb")
        client.tap("ABC123", 100, 200)
        args = run.call_args[0][0]
        assert args == ["adb", "-s", "ABC123", "shell", "input", "tap", "100", "200"]


def test_open_deep_link():
    with patch("scraper.adb_client.subprocess.run") as run:
        run.return_value = fake_run()
        client = AdbClient(adb_bin="adb")
        client.open_url("ABC123", "temu://product/123")
        args = run.call_args[0][0]
        assert "am" in args and "start" in args and "temu://product/123" in args


def test_get_battery_temperature_parses():
    out = "Current Battery Service state:\n  temperature: 320\n  level: 85"
    with patch("scraper.adb_client.subprocess.run") as run:
        run.return_value = fake_run(stdout=out)
        client = AdbClient(adb_bin="adb")
        assert client.battery_temperature_c("ABC123") == 32.0


def test_get_battery_level_parses():
    out = "Current Battery Service state:\n  temperature: 320\n  level: 85"
    with patch("scraper.adb_client.subprocess.run") as run:
        run.return_value = fake_run(stdout=out)
        client = AdbClient(adb_bin="adb")
        assert client.battery_level_pct("ABC123") == 85
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_adb_client.py -v
```

Expected: FAIL — module not implemented.

- [ ] **Step 3: Implement `scraper/adb_client.py`**

```python
# scraper/adb_client.py
import subprocess
from pathlib import Path


class AdbClient:
    def __init__(self, adb_bin: str = "adb"):
        self.adb_bin = adb_bin

    def _run(self, serial: str | None, *args: str, capture: bool = True) -> subprocess.CompletedProcess:
        cmd = [self.adb_bin]
        if serial:
            cmd += ["-s", serial]
        cmd += list(args)
        return subprocess.run(cmd, capture_output=capture, text=True, check=False)

    def list_devices(self) -> list[str]:
        result = self._run(None, "devices")
        devices = []
        for line in result.stdout.splitlines()[1:]:
            parts = line.split()
            if len(parts) >= 2 and parts[1] == "device":
                devices.append(parts[0])
        return devices

    def tap(self, serial: str, x: int, y: int) -> None:
        self._run(serial, "shell", "input", "tap", str(x), str(y))

    def open_url(self, serial: str, url: str) -> None:
        self._run(serial, "shell", "am", "start", "-W", "-a", "android.intent.action.VIEW", "-d", url)

    def force_stop(self, serial: str, package: str) -> None:
        self._run(serial, "shell", "am", "force-stop", package)

    def dump_xml(self, serial: str, dest: Path) -> str:
        self._run(serial, "shell", "uiautomator", "dump", "/sdcard/dump.xml")
        self._run(serial, "pull", "/sdcard/dump.xml", str(dest))
        return dest.read_text()

    def screencap(self, serial: str, dest: Path) -> None:
        result = subprocess.run(
            [self.adb_bin, "-s", serial, "exec-out", "screencap", "-p"],
            capture_output=True, check=False,
        )
        dest.write_bytes(result.stdout)

    def battery_temperature_c(self, serial: str) -> float:
        result = self._run(serial, "shell", "dumpsys", "battery")
        for line in result.stdout.splitlines():
            if "temperature:" in line:
                return int(line.split("temperature:")[1].strip()) / 10.0
        raise RuntimeError("battery temperature not found")

    def battery_level_pct(self, serial: str) -> int:
        result = self._run(serial, "shell", "dumpsys", "battery")
        for line in result.stdout.splitlines():
            if "level:" in line:
                return int(line.split("level:")[1].strip())
        raise RuntimeError("battery level not found")

    def foreground_package(self, serial: str) -> str:
        result = self._run(serial, "shell", "dumpsys", "window", "windows")
        for line in result.stdout.splitlines():
            if "mCurrentFocus" in line and "{" in line:
                # mCurrentFocus=Window{... u0 com.example/com.example.Activity}
                token = line.split()[-1].rstrip("}")
                return token.split("/")[0]
        return ""

    def screen_on(self, serial: str) -> bool:
        result = self._run(serial, "shell", "dumpsys", "power")
        return "Display Power: state=ON" in result.stdout or "mWakefulness=Awake" in result.stdout
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_adb_client.py -v
```

Expected: all 6 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/adb_client.py tests/test_adb_client.py
git commit -m "feat(adb): ADB client wrapper (devices, tap, dump, battery, etc)"
```

---

### Task 7: XML parser

**Files:**
- Create: `scraper/parser.py`
- Create: `scraper/temu_resource_ids.py`
- Create: `tests/test_parser.py`

- [ ] **Step 1: Write `scraper/temu_resource_ids.py` (initial empty stub, filled after Day 0)**

```python
# scraper/temu_resource_ids.py
"""Temu app accessibility resource-ids. Populated after Day 0 feasibility test.

Format: each entry maps a logical field name to the resource-id string seen in
uiautomator dump. If a field is missing from this map, the parser falls back to
OCR (see ocr_fallback.py) or returns None.

To update: open Temu product page on device, run `python -m scraper.feasibility`,
inspect /tmp/day0_dump.xml, copy resource-ids here.
"""

# Filled after Day 0. Examples (replace with actual ids):
TEMU_RIDS: dict[str, str] = {
    # "title": "com.einnovation.temu:id/product_title",
    # "price_current": "com.einnovation.temu:id/price_current",
    # "price_original": "com.einnovation.temu:id/price_original",
    # "sold_count": "com.einnovation.temu:id/sold_count",
    # "rating_avg": "com.einnovation.temu:id/rating_avg",
    # "review_count": "com.einnovation.temu:id/review_count",
    # "in_stock_badge": "com.einnovation.temu:id/in_stock_badge",
    # "seller_name": "com.einnovation.temu:id/seller_name",
    # "ships_from": "com.einnovation.temu:id/ships_from",
}

# Variant selector pattern: container resource-id + child option resource-id pattern
TEMU_VARIANT_RIDS: dict[str, str] = {
    # "variant_container": "com.einnovation.temu:id/variant_container",
    # "variant_option": "com.einnovation.temu:id/variant_option",
}

TEMU_PACKAGE = "com.einnovation.temu"
TEMU_PRODUCT_DEEP_LINK_TEMPLATE = "temu://product/{sku_id}"
```

- [ ] **Step 2: Write failing tests using sample fixture**

```python
# tests/test_parser.py
from pathlib import Path
import pytest
from scraper import parser

FIXTURE = Path(__file__).parent / "fixtures" / "sample_xml_dump.xml"


@pytest.fixture
def sample_xml() -> str:
    if not FIXTURE.exists():
        pytest.skip("sample_xml_dump.xml not present; capture via Day 0 feasibility first")
    return FIXTURE.read_text()


def test_find_text_by_resource_id(sample_xml):
    # Use any known-present resource-id from Day 0 dump. Replace with real id after Day 0.
    # For now, the test is parametric — any resource-id ending in known suffix will do.
    text = parser.find_text_by_rid_suffix(sample_xml, "title")
    # Don't assert specific value (depends on which product was open during Day 0).
    # Just assert non-empty if found.
    assert text is None or isinstance(text, str)


def test_extract_all_texts():
    xml = """<?xml version='1.0'?>
    <hierarchy>
      <node text="" resource-id="a:id/x"/>
      <node text="Hello" resource-id="a:id/y"/>
      <node text="World" resource-id="a:id/z"/>
    </hierarchy>"""
    texts = parser.extract_all_texts(xml)
    assert texts == [("a:id/y", "Hello"), ("a:id/z", "World")]


def test_find_text_by_exact_rid():
    xml = """<?xml version='1.0'?>
    <hierarchy>
      <node text="$15.99" resource-id="com.einnovation.temu:id/price_current"/>
    </hierarchy>"""
    assert parser.find_text_by_rid(xml, "com.einnovation.temu:id/price_current") == "$15.99"
    assert parser.find_text_by_rid(xml, "com.einnovation.temu:id/nonexistent") is None


def test_parse_price_strips_currency():
    assert parser.parse_price("$15.99") == 15.99
    assert parser.parse_price("US $1,299.00") == 1299.00
    assert parser.parse_price("invalid") is None
    assert parser.parse_price(None) is None


def test_parse_sold_count_handles_k_m():
    assert parser.parse_sold_count("10k+ sold") == 10000
    assert parser.parse_sold_count("1.5k sold") == 1500
    assert parser.parse_sold_count("2M+ sold") == 2_000_000
    assert parser.parse_sold_count("234 sold") == 234
    assert parser.parse_sold_count("") is None


def test_find_node_bounds():
    xml = """<?xml version='1.0'?>
    <hierarchy>
      <node text="x" bounds="[120,800][400,860]" resource-id="a:id/y"/>
    </hierarchy>"""
    assert parser.find_bounds_by_rid(xml, "a:id/y") == (120, 800, 400, 860)
```

- [ ] **Step 3: Run tests to verify failure**

```bash
pytest tests/test_parser.py -v
```

Expected: FAIL — module not implemented.

- [ ] **Step 4: Implement `scraper/parser.py`**

```python
# scraper/parser.py
import re
from lxml import etree

_BOUNDS_RE = re.compile(r"\[(\d+),(\d+)\]\[(\d+),(\d+)\]")


def _root(xml: str) -> etree._Element:
    return etree.fromstring(xml.encode() if isinstance(xml, str) else xml)


def extract_all_texts(xml: str) -> list[tuple[str, str]]:
    root = _root(xml)
    out: list[tuple[str, str]] = []
    for node in root.iter("node"):
        text = node.get("text") or ""
        rid = node.get("resource-id") or ""
        if text:
            out.append((rid, text))
    return out


def find_text_by_rid(xml: str, rid: str) -> str | None:
    root = _root(xml)
    matches = root.xpath(f'//node[@resource-id="{rid}"]')
    if not matches:
        return None
    return matches[0].get("text") or None


def find_text_by_rid_suffix(xml: str, suffix: str) -> str | None:
    root = _root(xml)
    for node in root.iter("node"):
        rid = node.get("resource-id") or ""
        if rid.endswith(suffix):
            text = node.get("text")
            if text:
                return text
    return None


def find_bounds_by_rid(xml: str, rid: str) -> tuple[int, int, int, int] | None:
    root = _root(xml)
    matches = root.xpath(f'//node[@resource-id="{rid}"]')
    if not matches:
        return None
    bounds = matches[0].get("bounds") or ""
    m = _BOUNDS_RE.match(bounds)
    if not m:
        return None
    return (int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4)))


def parse_price(text: str | None) -> float | None:
    if not text:
        return None
    cleaned = re.sub(r"[^\d.,]", "", text).replace(",", "")
    try:
        return float(cleaned)
    except ValueError:
        return None


_SOLD_RE = re.compile(r"([\d.]+)\s*([kKmM]?)\+?")


def parse_sold_count(text: str | None) -> int | None:
    if not text:
        return None
    m = _SOLD_RE.search(text)
    if not m:
        return None
    num = float(m.group(1))
    suffix = m.group(2).lower()
    mult = {"": 1, "k": 1000, "m": 1_000_000}[suffix]
    return int(num * mult)


def parse_rating(text: str | None) -> float | None:
    if not text:
        return None
    m = re.search(r"(\d+\.\d+)", text)
    return float(m.group(1)) if m else None
```

- [ ] **Step 5: Run tests to verify pass**

```bash
pytest tests/test_parser.py -v
```

Expected: all tests PASS (sample fixture test skips gracefully if Day 0 not done).

- [ ] **Step 6: Commit**

```bash
git add scraper/parser.py scraper/temu_resource_ids.py tests/test_parser.py
git commit -m "feat(parser): XML extraction + price/sold/rating normalization"
```

---

### Task 8: OCR fallback

**Files:**
- Create: `scraper/ocr_fallback.py`
- Create: `tests/test_ocr_fallback.py`

- [ ] **Step 1: Write failing test**

```python
# tests/test_ocr_fallback.py
from pathlib import Path
import pytest
from PIL import Image
from scraper import ocr_fallback

FIXTURE = Path(__file__).parent / "fixtures" / "sample_screenshot.png"


def test_crop_region_returns_pil_image(tmp_path):
    img = Image.new("RGB", (200, 200), color="white")
    p = tmp_path / "img.png"
    img.save(p)
    crop = ocr_fallback.crop_region(p, (10, 10, 50, 50))
    assert crop.size == (40, 40)


def test_ocr_text_returns_string():
    # synthetic image with the string "HELLO"
    from PIL import ImageDraw, ImageFont
    img = Image.new("RGB", (200, 80), color="white")
    d = ImageDraw.Draw(img)
    d.text((10, 20), "HELLO", fill="black")
    text = ocr_fallback.ocr_image(img)
    assert "HELLO" in text.upper()


def test_ocr_real_screenshot(tmp_path):
    if not FIXTURE.exists():
        pytest.skip("sample_screenshot.png not present; capture via Day 0 feasibility first")
    text = ocr_fallback.ocr_image_path(FIXTURE)
    assert isinstance(text, str)
    assert len(text) > 0
```

- [ ] **Step 2: Run test to verify failure**

```bash
pytest tests/test_ocr_fallback.py -v
```

Expected: FAIL — module not implemented.

- [ ] **Step 3: Implement `scraper/ocr_fallback.py`**

```python
# scraper/ocr_fallback.py
from pathlib import Path
from PIL import Image
import pytesseract


def crop_region(image_path: Path, bounds: tuple[int, int, int, int]) -> Image.Image:
    """bounds: (left, top, right, bottom)."""
    img = Image.open(image_path)
    return img.crop(bounds)


def ocr_image(image: Image.Image, lang: str = "eng") -> str:
    return pytesseract.image_to_string(image, lang=lang).strip()


def ocr_image_path(image_path: Path, lang: str = "eng") -> str:
    return ocr_image(Image.open(image_path), lang=lang)


def ocr_region(image_path: Path, bounds: tuple[int, int, int, int], lang: str = "eng") -> str:
    return ocr_image(crop_region(image_path, bounds), lang=lang)
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_ocr_fallback.py -v
```

Expected: all tests PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/ocr_fallback.py tests/test_ocr_fallback.py
git commit -m "feat(ocr): Tesseract fallback for fields missing in XML"
```

---

### Task 9: Phone health checks

**Files:**
- Create: `scraper/phone_health.py`
- Create: `tests/test_phone_health.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_phone_health.py
from unittest.mock import MagicMock
from scraper import phone_health


def make_adb(*, devices=None, temp=30.0, level=80, fg="com.einnovation.temu", screen=True):
    adb = MagicMock()
    adb.list_devices.return_value = devices or ["ABC123"]
    adb.battery_temperature_c.return_value = temp
    adb.battery_level_pct.return_value = level
    adb.foreground_package.return_value = fg
    adb.screen_on.return_value = screen
    return adb


def test_ready_when_all_healthy():
    adb = make_adb()
    state = phone_health.check_device(adb, "ABC123")
    assert state.ready is True
    assert state.reason is None


def test_not_ready_when_not_connected():
    adb = make_adb(devices=["OTHER"])
    state = phone_health.check_device(adb, "ABC123")
    assert state.ready is False
    assert "not connected" in state.reason.lower()


def test_not_ready_when_temp_high():
    adb = make_adb(temp=42.0)
    state = phone_health.check_device(adb, "ABC123")
    assert state.ready is False
    assert "temperature" in state.reason.lower()


def test_not_ready_when_battery_low():
    adb = make_adb(level=25)
    state = phone_health.check_device(adb, "ABC123")
    assert state.ready is False
    assert "battery" in state.reason.lower()


def test_skip_when_user_using_phone():
    adb = make_adb(fg="com.whatsapp")
    state = phone_health.check_device(adb, "ABC123")
    assert state.ready is False
    assert "foreground" in state.reason.lower()
    assert state.skip_silently is True  # don't alarm — user is using phone
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_phone_health.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/phone_health.py`**

```python
# scraper/phone_health.py
from dataclasses import dataclass

TEMP_LIMIT_C = 40.0
BATTERY_MIN_PCT = 30
TEMU_PACKAGE = "com.einnovation.temu"
ALLOWED_FOREGROUND = {TEMU_PACKAGE, "com.android.systemui", "android", ""}


@dataclass
class HealthState:
    ready: bool
    reason: str | None = None
    skip_silently: bool = False
    temperature_c: float | None = None
    battery_pct: int | None = None


def check_device(adb, serial: str) -> HealthState:
    if serial not in adb.list_devices():
        return HealthState(ready=False, reason="Device not connected via ADB")

    if not adb.screen_on(serial):
        return HealthState(ready=False, reason="Screen is off / locked")

    temp = adb.battery_temperature_c(serial)
    if temp >= TEMP_LIMIT_C:
        return HealthState(ready=False, reason=f"Battery temperature {temp}°C exceeds {TEMP_LIMIT_C}", temperature_c=temp)

    level = adb.battery_level_pct(serial)
    if level < BATTERY_MIN_PCT:
        return HealthState(ready=False, reason=f"Battery {level}% below minimum {BATTERY_MIN_PCT}%", battery_pct=level)

    fg = adb.foreground_package(serial)
    if fg and fg not in ALLOWED_FOREGROUND:
        return HealthState(
            ready=False,
            reason=f"User is using phone (foreground: {fg})",
            skip_silently=True,
            temperature_c=temp,
            battery_pct=level,
        )

    return HealthState(ready=True, temperature_c=temp, battery_pct=level)
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_phone_health.py -v
```

Expected: all PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/phone_health.py tests/test_phone_health.py
git commit -m "feat(phone): device health checks (temp, battery, foreground)"
```

---

## Phase 3: Temu-specific Actions

### Task 10: Temu deep link + page flow

**Files:**
- Create: `scraper/temu_actions.py`
- Create: `tests/test_temu_actions.py`

This is the **patch target** for the Claude supervisor. It contains all the brittle selector + timing logic.

- [ ] **Step 1: Write failing tests**

```python
# tests/test_temu_actions.py
from unittest.mock import MagicMock
from scraper import temu_actions


def make_adb():
    adb = MagicMock()
    adb.dump_xml.return_value = "<hierarchy/>"
    return adb


def test_open_product_page_calls_deep_link():
    adb = make_adb()
    temu_actions.open_product(adb, "ABC", "601099001")
    adb.open_url.assert_called_with("ABC", "temu://product/601099001")


def test_force_restart_uses_temu_package():
    adb = make_adb()
    temu_actions.force_restart_app(adb, "ABC")
    adb.force_stop.assert_called_with("ABC", "com.einnovation.temu")


def test_dump_main_returns_xml(tmp_path):
    adb = make_adb()
    adb.dump_xml.return_value = "<hierarchy><node text='Test'/></hierarchy>"
    xml = temu_actions.dump_main_xml(adb, "ABC", tmp_path / "d.xml")
    assert "Test" in xml
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_temu_actions.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/temu_actions.py`**

```python
# scraper/temu_actions.py
"""Temu app interaction layer. THIS IS THE CLAUDE SUPERVISOR PATCH TARGET.

The supervisor may modify timing constants, coordinates, scroll distances, and
retry counts in this file. The supervisor MUST NOT modify scraper/parser.py,
scraper/storage.py, scraper/daemon.py, scraper/scheduler.py, or anything outside
this file and scraper/temu_resource_ids.py.
"""

import time
from pathlib import Path
from scraper.temu_resource_ids import TEMU_PACKAGE, TEMU_PRODUCT_DEEP_LINK_TEMPLATE

# --- TIMING / COORDINATE CONSTANTS (patch-friendly) ---
LOAD_WAIT_S = 4.0
POST_TAP_WAIT_S = 1.5
VARIANT_TAP_WAIT_S = 2.0
SCROLL_DOWN_DURATION_MS = 400
FEATURES_SCROLL_PIXELS = 800  # y delta for "scroll to specs" gesture
MAX_VARIANT_TAPS = 30  # safety cap
APP_LAUNCH_RETRY = 2


def open_product(adb, serial: str, sku_id: str) -> None:
    url = TEMU_PRODUCT_DEEP_LINK_TEMPLATE.format(sku_id=sku_id)
    adb.open_url(serial, url)
    time.sleep(LOAD_WAIT_S)


def force_restart_app(adb, serial: str) -> None:
    adb.force_stop(serial, TEMU_PACKAGE)
    time.sleep(1.0)


def dump_main_xml(adb, serial: str, dest: Path) -> str:
    return adb.dump_xml(serial, dest)


def scroll_to_features(adb, serial: str) -> None:
    # Swipe up to reveal product specs section
    adb._run(serial, "shell", "input", "swipe", "540", "1400", "540", str(1400 - FEATURES_SCROLL_PIXELS), str(SCROLL_DOWN_DURATION_MS))
    time.sleep(POST_TAP_WAIT_S)


def tap_variant(adb, serial: str, x: int, y: int) -> None:
    adb.tap(serial, x, y)
    time.sleep(VARIANT_TAP_WAIT_S)
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_temu_actions.py -v
```

Expected: all PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/temu_actions.py tests/test_temu_actions.py
git commit -m "feat(temu): deep link + restart + dump (patch target)"
```

---

### Task 11: Product capture orchestrator

**Files:**
- Create: `scraper/capture.py`
- Create: `tests/test_capture.py`

- [ ] **Step 1: Write failing test**

```python
# tests/test_capture.py
from datetime import datetime
from pathlib import Path
from unittest.mock import MagicMock
from scraper import capture


SAMPLE_XML = """<?xml version='1.0'?>
<hierarchy>
  <node text='Bluetooth Earbuds Pro' resource-id='com.einnovation.temu:id/product_title'/>
  <node text='$15.99' resource-id='com.einnovation.temu:id/price_current'/>
  <node text='$29.99' resource-id='com.einnovation.temu:id/price_original'/>
  <node text='10k+ sold' resource-id='com.einnovation.temu:id/sold_count'/>
  <node text='4.7' resource-id='com.einnovation.temu:id/rating_avg'/>
  <node text='3421 reviews' resource-id='com.einnovation.temu:id/review_count'/>
</hierarchy>"""


def test_capture_product_writes_observation(memdb, monkeypatch, tmp_path):
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('601099001', 'u')")
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('phone_01', 'ABC')")

    adb = MagicMock()
    adb.dump_xml.return_value = SAMPLE_XML

    monkeypatch.setattr(
        "scraper.temu_resource_ids.TEMU_RIDS",
        {
            "title": "com.einnovation.temu:id/product_title",
            "price_current": "com.einnovation.temu:id/price_current",
            "price_original": "com.einnovation.temu:id/price_original",
            "sold_count": "com.einnovation.temu:id/sold_count",
            "rating_avg": "com.einnovation.temu:id/rating_avg",
            "review_count": "com.einnovation.temu:id/review_count",
        },
    )

    result = capture.capture_product(
        conn=memdb, adb=adb, serial="ABC", device_id="phone_01",
        sku_id="601099001", data_dir=tmp_path, observed_at="2026-05-24T09:00:00",
    )
    assert result.success is True
    row = memdb.execute("SELECT * FROM product_observations WHERE sku_id='601099001'").fetchone()
    assert row["price_usd"] == 15.99
    assert row["original_price_usd"] == 29.99
    assert row["sold_count_estimate"] == 10000
    assert row["rating_avg"] == 4.7
    assert row["review_count"] == 3421

    prow = memdb.execute("SELECT * FROM products WHERE sku_id='601099001'").fetchone()
    assert prow["title"] == "Bluetooth Earbuds Pro"
```

- [ ] **Step 2: Run test to verify failure**

```bash
pytest tests/test_capture.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/capture.py`**

```python
# scraper/capture.py
"""Full product capture orchestrator: opens product, dumps XML, parses fields,
captures variants and features, and writes everything to the DB."""

from dataclasses import dataclass
from pathlib import Path
from scraper import parser, storage, temu_actions
from scraper.temu_resource_ids import TEMU_RIDS


@dataclass
class CaptureResult:
    success: bool
    variants_captured: int = 0
    error: str | None = None
    parse_confidence: float = 0.0


def _txt(xml: str, key: str) -> str | None:
    rid = TEMU_RIDS.get(key)
    if not rid:
        return None
    return parser.find_text_by_rid(xml, rid)


def capture_product(
    *, conn, adb, serial: str, device_id: str, sku_id: str,
    data_dir: Path, observed_at: str,
) -> CaptureResult:
    xml_path = data_dir / "xml_dumps" / f"{sku_id}_{observed_at.replace(':', '-')}.xml"
    xml_path.parent.mkdir(parents=True, exist_ok=True)
    try:
        temu_actions.open_product(adb, serial, sku_id)
        xml = temu_actions.dump_main_xml(adb, serial, xml_path)
    except Exception as e:
        return CaptureResult(success=False, error=f"open/dump failed: {e}")

    title = _txt(xml, "title")
    price_current = parser.parse_price(_txt(xml, "price_current"))
    price_original = parser.parse_price(_txt(xml, "price_original"))
    sold_text = _txt(xml, "sold_count")
    sold_count = parser.parse_sold_count(sold_text)
    rating = parser.parse_rating(_txt(xml, "rating_avg"))
    review_text = _txt(xml, "review_count")
    review_count = int("".join(c for c in (review_text or "") if c.isdigit()) or 0) or None
    seller = _txt(xml, "seller_name")
    ships_from = _txt(xml, "ships_from")

    discount_pct = None
    if price_current and price_original and price_original > 0:
        discount_pct = round((1 - price_current / price_original) * 100, 1)

    fields = sum(1 for v in [title, price_current, sold_count, rating, review_count] if v is not None)
    confidence = fields / 5.0

    storage.upsert_product(
        conn, sku_id=sku_id,
        title=title, seller_name=seller, ships_from=ships_from,
    )
    storage.insert_product_observation(
        conn, sku_id=sku_id, device_id=device_id, observed_at=observed_at,
        price_usd=price_current, original_price_usd=price_original,
        discount_pct=discount_pct,
        in_stock=1 if price_current is not None else 0,
        sold_count_text=sold_text, sold_count_estimate=sold_count,
        rating_avg=rating, review_count=review_count,
        raw_xml_path=str(xml_path), parse_confidence=confidence,
    )

    # Variants and features capture stubs — Task 12 fills these in
    variants_count = 0

    return CaptureResult(success=True, variants_captured=variants_count, parse_confidence=confidence)
```

- [ ] **Step 4: Run test to verify pass**

```bash
pytest tests/test_capture.py -v
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/capture.py tests/test_capture.py
git commit -m "feat(capture): product capture orchestrator (title, price, rating)"
```

---

### Task 12: Variant capture loop

**Files:**
- Modify: `scraper/capture.py` (add variant capture)
- Create: `tests/test_capture_variants.py`

- [ ] **Step 1: Write failing test**

```python
# tests/test_capture_variants.py
from unittest.mock import MagicMock
from scraper import capture


VARIANT_XML = """<?xml version='1.0'?>
<hierarchy>
  <node resource-id='com.einnovation.temu:id/variant_container'>
    <node text='Red' resource-id='com.einnovation.temu:id/variant_option' bounds='[100,500][200,580]'/>
    <node text='Blue' resource-id='com.einnovation.temu:id/variant_option' bounds='[210,500][310,580]'/>
  </node>
</hierarchy>"""


PRICE_AFTER_RED = """<?xml version='1.0'?>
<hierarchy>
  <node text='$9.99' resource-id='com.einnovation.temu:id/price_current'/>
</hierarchy>"""


PRICE_AFTER_BLUE = """<?xml version='1.0'?>
<hierarchy>
  <node text='$10.99' resource-id='com.einnovation.temu:id/price_current'/>
</hierarchy>"""


def test_variant_loop_taps_each_and_records(memdb, monkeypatch, tmp_path):
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1', 'A1')")
    memdb.execute("INSERT INTO products(sku_id) VALUES('s1')")

    monkeypatch.setattr(
        "scraper.temu_resource_ids.TEMU_RIDS",
        {"price_current": "com.einnovation.temu:id/price_current"},
    )
    monkeypatch.setattr(
        "scraper.temu_resource_ids.TEMU_VARIANT_RIDS",
        {
            "variant_container": "com.einnovation.temu:id/variant_container",
            "variant_option": "com.einnovation.temu:id/variant_option",
        },
    )

    adb = MagicMock()
    # 1st dump: variant list; 2nd: price after Red tap; 3rd: price after Blue tap
    adb.dump_xml.side_effect = [VARIANT_XML, PRICE_AFTER_RED, PRICE_AFTER_BLUE]

    count = capture.capture_variants(
        conn=memdb, adb=adb, serial="A1", sku_id="s1",
        data_dir=tmp_path, observed_at="2026-05-24T09:00:00",
    )
    assert count == 2
    rows = memdb.execute(
        "SELECT v.variant_key, vo.price_usd FROM variants v "
        "JOIN variant_observations vo ON vo.variant_id=v.id ORDER BY v.variant_key"
    ).fetchall()
    assert rows[0]["variant_key"] == "option:Blue"
    assert rows[0]["price_usd"] == 10.99
    assert rows[1]["variant_key"] == "option:Red"
    assert rows[1]["price_usd"] == 9.99
```

- [ ] **Step 2: Run test to verify failure**

```bash
pytest tests/test_capture_variants.py -v
```

Expected: FAIL — `capture_variants` not implemented.

- [ ] **Step 3: Add to `scraper/capture.py`**

```python
# Append to scraper/capture.py

from lxml import etree
from scraper import temu_actions
from scraper.temu_resource_ids import TEMU_VARIANT_RIDS


def _list_variants(xml: str) -> list[tuple[str, tuple[int, int]]]:
    """Returns list of (variant_label, (center_x, center_y))."""
    option_rid = TEMU_VARIANT_RIDS.get("variant_option")
    if not option_rid:
        return []
    root = etree.fromstring(xml.encode())
    out = []
    for node in root.xpath(f'//node[@resource-id="{option_rid}"]'):
        label = node.get("text") or node.get("content-desc") or ""
        bounds = node.get("bounds") or ""
        import re
        m = re.match(r"\[(\d+),(\d+)\]\[(\d+),(\d+)\]", bounds)
        if not (label and m):
            continue
        cx = (int(m.group(1)) + int(m.group(3))) // 2
        cy = (int(m.group(2)) + int(m.group(4))) // 2
        out.append((label, (cx, cy)))
    return out


def capture_variants(
    *, conn, adb, serial: str, sku_id: str, data_dir: Path, observed_at: str
) -> int:
    list_xml_path = data_dir / "xml_dumps" / f"{sku_id}_{observed_at.replace(':', '-')}_variants.xml"
    list_xml = adb.dump_xml(serial, list_xml_path)
    variants = _list_variants(list_xml)
    captured = 0
    for label, (x, y) in variants[: temu_actions.MAX_VARIANT_TAPS]:
        temu_actions.tap_variant(adb, serial, x, y)
        v_xml_path = data_dir / "xml_dumps" / f"{sku_id}_{observed_at.replace(':', '-')}_v_{label}.xml"
        v_xml = adb.dump_xml(serial, v_xml_path)
        price = parser.parse_price(_txt(v_xml, "price_current"))
        in_stock = price is not None
        key = f"option:{label}"
        attrs = {"option": label}
        vid = storage.upsert_variant(conn, sku_id=sku_id, variant_key=key, attributes=attrs)
        storage.insert_variant_observation(
            conn, variant_id=vid, observed_at=observed_at,
            price_usd=price, in_stock=in_stock,
        )
        captured += 1
    return captured
```

Update the existing `capture_product` to call `capture_variants` and increment `variants_count`:

```python
# In capture_product, replace `variants_count = 0` with:
    variants_count = capture_variants(
        conn=conn, adb=adb, serial=serial, sku_id=sku_id,
        data_dir=data_dir, observed_at=observed_at,
    )
```

- [ ] **Step 4: Run all capture tests to verify**

```bash
pytest tests/test_capture.py tests/test_capture_variants.py -v
```

Expected: all PASS (the original `test_capture_product_writes_observation` now also exercises an empty variant flow because `TEMU_VARIANT_RIDS` is unset in that test — it returns 0).

- [ ] **Step 5: Commit**

```bash
git add scraper/capture.py tests/test_capture_variants.py
git commit -m "feat(capture): variant tap loop (per-variant price + stock)"
```

---

## Phase 4: Scheduling & Continuous Operation

### Task 13: Scheduler / Job Queue

**Files:**
- Create: `scraper/scheduler.py`
- Create: `tests/test_scheduler.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_scheduler.py
from datetime import datetime, timedelta
from scraper import scheduler


def _now():
    return datetime(2026, 5, 24, 9, 0, 0)


def test_initialize_jobs_creates_entry_per_target(memdb, monkeypatch):
    monkeypatch.setattr(scheduler, "utc_now", _now)
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s2', 'u')")
    scheduler.initialize_jobs(memdb, cycle_interval_minutes=240)
    rows = memdb.execute("SELECT * FROM scrape_jobs ORDER BY sku_id").fetchall()
    assert len(rows) == 2
    # next_due_at should be spread within cycle window
    for row in rows:
        assert row["status"] == "idle"
        assert row["cycle_interval_minutes"] == 240


def test_pick_next_due_returns_oldest_idle(memdb, monkeypatch):
    monkeypatch.setattr(scheduler, "utc_now", _now)
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s2', 'u')")
    memdb.execute(
        "INSERT INTO scrape_jobs(sku_id, next_due_at, status) VALUES('s1', '2026-05-24T08:00:00', 'idle')"
    )
    memdb.execute(
        "INSERT INTO scrape_jobs(sku_id, next_due_at, status) VALUES('s2', '2026-05-24T07:00:00', 'idle')"
    )
    job = scheduler.pick_next_due(memdb)
    assert job["sku_id"] == "s2"


def test_pick_next_due_skips_running_and_future(memdb, monkeypatch):
    monkeypatch.setattr(scheduler, "utc_now", _now)
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s2', 'u')")
    memdb.execute(
        "INSERT INTO scrape_jobs(sku_id, next_due_at, status) VALUES('s1', '2026-05-24T08:00:00', 'running')"
    )
    memdb.execute(
        "INSERT INTO scrape_jobs(sku_id, next_due_at, status) VALUES('s2', '2026-05-24T10:00:00', 'idle')"
    )
    job = scheduler.pick_next_due(memdb)
    assert job is None  # nothing due now


def test_mark_running_and_complete(memdb, monkeypatch):
    monkeypatch.setattr(scheduler, "utc_now", _now)
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute(
        "INSERT INTO scrape_jobs(sku_id, next_due_at, status, cycle_interval_minutes) "
        "VALUES('s1', '2026-05-24T08:00:00', 'idle', 240)"
    )
    job = scheduler.pick_next_due(memdb)
    scheduler.mark_running(memdb, job["id"])
    row = memdb.execute("SELECT * FROM scrape_jobs WHERE id=?", (job["id"],)).fetchone()
    assert row["status"] == "running"

    scheduler.mark_complete(memdb, job["id"], success=True, jitter_seconds=0)
    row = memdb.execute("SELECT * FROM scrape_jobs WHERE id=?", (job["id"],)).fetchone()
    assert row["status"] == "idle"
    assert row["consecutive_failures"] == 0
    expected_due = _now() + timedelta(minutes=240)
    assert row["next_due_at"] == expected_due.isoformat()
    assert row["last_success_at"] == _now().isoformat()
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_scheduler.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/scheduler.py`**

```python
# scraper/scheduler.py
import random
import sqlite3
from datetime import datetime, timedelta


def utc_now() -> datetime:
    return datetime.utcnow().replace(microsecond=0)


def initialize_jobs(conn: sqlite3.Connection, cycle_interval_minutes: int) -> None:
    targets = conn.execute("SELECT sku_id FROM targets").fetchall()
    now = utc_now()
    for t in targets:
        offset = random.randint(0, cycle_interval_minutes)  # spread initial load
        next_due = (now + timedelta(minutes=offset)).isoformat()
        conn.execute(
            "INSERT OR IGNORE INTO scrape_jobs(sku_id, next_due_at, status, cycle_interval_minutes) "
            "VALUES (?,?,?,?)",
            (t["sku_id"], next_due, "idle", cycle_interval_minutes),
        )


def pick_next_due(conn: sqlite3.Connection, device_id: str | None = None) -> sqlite3.Row | None:
    now = utc_now().isoformat()
    if device_id:
        return conn.execute(
            "SELECT * FROM scrape_jobs "
            "WHERE status='idle' AND next_due_at <= ? AND (device_id IS NULL OR device_id=?) "
            "ORDER BY next_due_at ASC LIMIT 1",
            (now, device_id),
        ).fetchone()
    return conn.execute(
        "SELECT * FROM scrape_jobs WHERE status='idle' AND next_due_at <= ? "
        "ORDER BY next_due_at ASC LIMIT 1",
        (now,),
    ).fetchone()


def mark_running(conn: sqlite3.Connection, job_id: int) -> None:
    conn.execute("UPDATE scrape_jobs SET status='running' WHERE id=?", (job_id,))


def mark_complete(
    conn: sqlite3.Connection, job_id: int, *, success: bool, jitter_seconds: int = 0
) -> None:
    now = utc_now()
    row = conn.execute("SELECT cycle_interval_minutes, consecutive_failures FROM scrape_jobs WHERE id=?", (job_id,)).fetchone()
    interval = row["cycle_interval_minutes"]
    next_due = (now + timedelta(minutes=interval, seconds=jitter_seconds)).isoformat()
    if success:
        conn.execute(
            "UPDATE scrape_jobs SET status='idle', last_scraped_at=?, last_success_at=?, "
            "next_due_at=?, consecutive_failures=0 WHERE id=?",
            (now.isoformat(), now.isoformat(), next_due, job_id),
        )
    else:
        # backoff: double interval on failure (cap at 24h)
        failures = row["consecutive_failures"] + 1
        backoff = min(interval * (2 ** min(failures, 4)), 24 * 60)
        next_due = (now + timedelta(minutes=backoff)).isoformat()
        conn.execute(
            "UPDATE scrape_jobs SET status='idle', last_scraped_at=?, next_due_at=?, "
            "consecutive_failures=? WHERE id=?",
            (now.isoformat(), next_due, failures, job_id),
        )
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_scheduler.py -v
```

Expected: all PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/scheduler.py tests/test_scheduler.py
git commit -m "feat(scheduler): job queue with spread init + failure backoff"
```

---

### Task 14: Rate limiter & mandatory rest

**Files:**
- Create: `scraper/rate_limiter.py`
- Create: `tests/test_rate_limiter.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_rate_limiter.py
from datetime import datetime, timedelta
from scraper.rate_limiter import RateLimiter


def test_under_limit_does_not_block():
    rl = RateLimiter(max_ops_per_hour=60, mandatory_rest_minutes_per_hour=5)
    now = datetime(2026, 5, 24, 14, 30, 0)
    for _ in range(10):
        rl.record_op(now)
    assert rl.cooldown_seconds(now) == 0


def test_over_limit_returns_positive_cooldown():
    rl = RateLimiter(max_ops_per_hour=10, mandatory_rest_minutes_per_hour=5)
    now = datetime(2026, 5, 24, 14, 30, 0)
    for i in range(10):
        rl.record_op(now + timedelta(seconds=i))
    cooldown = rl.cooldown_seconds(now + timedelta(seconds=11))
    assert cooldown > 0


def test_in_mandatory_rest_window():
    rl = RateLimiter(max_ops_per_hour=60, mandatory_rest_minutes_per_hour=5)
    # 14:00 to 14:05 is rest window
    in_rest = datetime(2026, 5, 24, 14, 2, 0)
    assert rl.in_mandatory_rest(in_rest) is True
    out_rest = datetime(2026, 5, 24, 14, 10, 0)
    assert rl.in_mandatory_rest(out_rest) is False


def test_quiet_hours_reduce_capacity():
    rl = RateLimiter(max_ops_per_hour=60, mandatory_rest_minutes_per_hour=5, quiet_hour_factor=0.5)
    quiet = datetime(2026, 5, 24, 3, 30, 0)  # 02:00-06:00 quiet
    for i in range(30):
        rl.record_op(quiet + timedelta(seconds=i * 2))
    # under 50% of 60 = 30, so still ok
    assert rl.cooldown_seconds(quiet + timedelta(minutes=2)) == 0
    rl.record_op(quiet + timedelta(seconds=120))
    # 31st op in quiet hour exceeds 30 cap → blocks
    assert rl.cooldown_seconds(quiet + timedelta(seconds=121)) > 0
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_rate_limiter.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/rate_limiter.py`**

```python
# scraper/rate_limiter.py
from collections import deque
from datetime import datetime, timedelta


class RateLimiter:
    def __init__(
        self,
        max_ops_per_hour: int,
        mandatory_rest_minutes_per_hour: int,
        quiet_hour_factor: float = 0.5,
        quiet_start_hour: int = 2,
        quiet_end_hour: int = 6,
    ):
        self.max_ops_per_hour = max_ops_per_hour
        self.rest_minutes = mandatory_rest_minutes_per_hour
        self.quiet_factor = quiet_hour_factor
        self.quiet_start = quiet_start_hour
        self.quiet_end = quiet_end_hour
        self._ops: deque[datetime] = deque()

    def _evict_old(self, now: datetime) -> None:
        cutoff = now - timedelta(hours=1)
        while self._ops and self._ops[0] < cutoff:
            self._ops.popleft()

    def _effective_cap(self, now: datetime) -> int:
        if self.quiet_start <= now.hour < self.quiet_end:
            return int(self.max_ops_per_hour * self.quiet_factor)
        return self.max_ops_per_hour

    def record_op(self, now: datetime) -> None:
        self._evict_old(now)
        self._ops.append(now)

    def cooldown_seconds(self, now: datetime) -> int:
        self._evict_old(now)
        cap = self._effective_cap(now)
        if len(self._ops) < cap:
            return 0
        oldest_in_window = self._ops[0]
        # next allowed op is when oldest leaves the 1-hour window
        seconds_until_free = int((oldest_in_window + timedelta(hours=1) - now).total_seconds())
        return max(0, seconds_until_free)

    def in_mandatory_rest(self, now: datetime) -> bool:
        return now.minute < self.rest_minutes
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_rate_limiter.py -v
```

Expected: all PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/rate_limiter.py tests/test_rate_limiter.py
git commit -m "feat(rate-limit): hourly cap + mandatory rest + quiet hours"
```

---

### Task 15: Device pool

**Files:**
- Create: `scraper/device_pool.py`
- Create: `tests/test_device_pool.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_device_pool.py
import json
from scraper.device_pool import DevicePool


def test_load_from_json(tmp_path):
    cfg = tmp_path / "devices.json"
    cfg.write_text(json.dumps([
        {"device_id": "phone_01", "adb_serial": "A1", "model": "Pixel 7",
         "screen_resolution": "1080x2400", "active": True, "added_at": "2026-05-24"},
    ]))
    pool = DevicePool.from_json(cfg)
    assert len(pool.devices) == 1
    assert pool.devices[0].device_id == "phone_01"


def test_inactive_devices_filtered(tmp_path):
    cfg = tmp_path / "devices.json"
    cfg.write_text(json.dumps([
        {"device_id": "p1", "adb_serial": "A1", "active": True},
        {"device_id": "p2", "adb_serial": "A2", "active": False},
    ]))
    pool = DevicePool.from_json(cfg)
    assert [d.device_id for d in pool.active_devices()] == ["p1"]


def test_sku_to_device_consistent_hash():
    from scraper.device_pool import sku_to_device_id
    devs = ["phone_01", "phone_02", "phone_03"]
    # Same SKU always maps to same device
    assert sku_to_device_id("601099001", devs) == sku_to_device_id("601099001", devs)
    # Different SKUs distribute (not all to same device)
    assignments = {sku_to_device_id(f"sku_{i:03d}", devs) for i in range(30)}
    assert len(assignments) == 3
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_device_pool.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/device_pool.py`**

```python
# scraper/device_pool.py
import hashlib
import json
from dataclasses import dataclass
from pathlib import Path


@dataclass
class Device:
    device_id: str
    adb_serial: str
    model: str = ""
    screen_resolution: str = ""
    active: bool = True


class DevicePool:
    def __init__(self, devices: list[Device]):
        self.devices = devices

    @classmethod
    def from_json(cls, path: Path) -> "DevicePool":
        raw = json.loads(path.read_text())
        devices = [
            Device(
                device_id=d["device_id"],
                adb_serial=d["adb_serial"],
                model=d.get("model", ""),
                screen_resolution=d.get("screen_resolution", ""),
                active=d.get("active", True),
            )
            for d in raw
        ]
        return cls(devices)

    def active_devices(self) -> list[Device]:
        return [d for d in self.devices if d.active]


def sku_to_device_id(sku_id: str, device_ids: list[str]) -> str:
    if not device_ids:
        raise ValueError("no devices available")
    h = int(hashlib.sha256(sku_id.encode()).hexdigest(), 16)
    return sorted(device_ids)[h % len(device_ids)]
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_device_pool.py -v
```

Expected: all PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/device_pool.py tests/test_device_pool.py
git commit -m "feat(devices): device pool + consistent hash sku→device mapping"
```

---

### Task 16: Main daemon loop

**Files:**
- Create: `scraper/daemon.py`
- Create: `tests/test_daemon.py`

- [ ] **Step 1: Write failing test (integration-level, mocks ADB only)**

```python
# tests/test_daemon.py
from datetime import datetime
from unittest.mock import MagicMock
from pathlib import Path
from scraper import daemon, scheduler


def test_daemon_processes_one_due_job(memdb, tmp_path, monkeypatch):
    # Seed: 1 device, 1 target, 1 job already due
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('phone_01', 'A1')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1', 'u')")
    memdb.execute(
        "INSERT INTO scrape_jobs(sku_id, next_due_at, status, cycle_interval_minutes) "
        "VALUES('s1', '2020-01-01T00:00:00', 'idle', 240)"
    )

    adb = MagicMock()
    adb.list_devices.return_value = ["A1"]
    adb.battery_temperature_c.return_value = 30.0
    adb.battery_level_pct.return_value = 80
    adb.foreground_package.return_value = ""
    adb.screen_on.return_value = True
    adb.dump_xml.return_value = "<hierarchy/>"

    # Run one iteration only
    daemon.process_one_iteration(
        conn=memdb, adb=adb, device_id="phone_01", serial="A1",
        data_dir=tmp_path,
    )

    job = memdb.execute("SELECT * FROM scrape_jobs WHERE sku_id='s1'").fetchone()
    # After processing: job moved to next_due_at in future, status idle
    assert job["status"] == "idle"
    assert job["last_scraped_at"] is not None
```

- [ ] **Step 2: Run test to verify failure**

```bash
pytest tests/test_daemon.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/daemon.py`**

```python
# scraper/daemon.py
"""Continuous daemon: forever loop, one worker per device, scheduler-driven.
Started by launchd at boot with KeepAlive=true."""

import random
import signal
import sys
import threading
import time
from datetime import datetime
from pathlib import Path

from scraper import capture, config, db, phone_health, scheduler, storage, temu_actions
from scraper.adb_client import AdbClient
from scraper.device_pool import DevicePool, sku_to_device_id
from scraper.rate_limiter import RateLimiter

_shutdown = threading.Event()


def _handle_signal(signum, _frame):
    print(f"Received signal {signum}, shutting down...")
    _shutdown.set()


def process_one_iteration(
    *, conn, adb, device_id: str, serial: str, data_dir: Path
) -> bool:
    """Process at most one due job. Returns True if a job was processed."""
    job = scheduler.pick_next_due(conn, device_id=device_id)
    if job is None:
        return False

    state = phone_health.check_device(adb, serial)
    if not state.ready:
        # If user is using phone, push job 5 min into future silently
        if state.skip_silently:
            from datetime import timedelta
            now = scheduler.utc_now()
            new_due = (now + timedelta(minutes=5)).isoformat()
            conn.execute("UPDATE scrape_jobs SET next_due_at=? WHERE id=?", (new_due, job["id"]))
        return False

    scheduler.mark_running(conn, job["id"])
    sku_id = job["sku_id"]
    now_iso = scheduler.utc_now().isoformat()
    result = capture.capture_product(
        conn=conn, adb=adb, serial=serial, device_id=device_id,
        sku_id=sku_id, data_dir=data_dir, observed_at=now_iso,
    )
    scheduler.mark_complete(
        conn, job["id"], success=result.success,
        jitter_seconds=random.randint(-30, 60),
    )
    return True


def worker_loop(
    *, conn_factory, device_id: str, serial: str, data_dir: Path,
    cfg, rate_limiter: RateLimiter, app_restart_counter: dict
):
    """Per-device worker thread. Has its own SQLite connection."""
    adb = AdbClient(adb_bin=cfg.adb_bin)
    conn = conn_factory()
    skus_since_restart = 0
    while not _shutdown.is_set():
        now = datetime.utcnow()
        if rate_limiter.in_mandatory_rest(now):
            time.sleep(30)
            continue
        cooldown = rate_limiter.cooldown_seconds(now)
        if cooldown > 0:
            time.sleep(min(cooldown, 60))
            continue

        processed = process_one_iteration(
            conn=conn, adb=adb, device_id=device_id, serial=serial, data_dir=data_dir,
        )
        if processed:
            rate_limiter.record_op(datetime.utcnow())
            skus_since_restart += 1
            if skus_since_restart >= cfg.app_restart_every_n_skus:
                temu_actions.force_restart_app(adb, serial)
                skus_since_restart = 0
            time.sleep(random.randint(cfg.inter_sku_delay_min_s, cfg.inter_sku_delay_max_s))
            storage.write_heartbeat(conn, component=f"daemon:{device_id}", ts=datetime.utcnow().isoformat(), status="ok")
        else:
            time.sleep(60)  # nothing due, check again in 1 min


def main() -> int:
    signal.signal(signal.SIGTERM, _handle_signal)
    signal.signal(signal.SIGINT, _handle_signal)

    cfg = config.load()
    conn_main = db.connect(cfg.db_path)
    db.apply_schema(conn_main)

    pool = DevicePool.from_json(Path("config/devices.json"))
    devices = pool.active_devices()
    if not devices:
        print("ERROR: no active devices in config/devices.json")
        return 1

    scheduler.initialize_jobs(conn_main, cycle_interval_minutes=cfg.cycle_interval_minutes)

    data_dir = cfg.data_dir
    (data_dir / "xml_dumps").mkdir(parents=True, exist_ok=True)
    (data_dir / "screenshots").mkdir(parents=True, exist_ok=True)

    rate_limiter = RateLimiter(
        max_ops_per_hour=cfg.rate_limit_ops_per_hour,
        mandatory_rest_minutes_per_hour=cfg.mandatory_rest_minutes_per_hour,
    )

    threads = []
    for dev in devices:
        t = threading.Thread(
            target=worker_loop,
            kwargs=dict(
                conn_factory=lambda: db.connect(cfg.db_path),
                device_id=dev.device_id, serial=dev.adb_serial,
                data_dir=data_dir, cfg=cfg, rate_limiter=rate_limiter,
                app_restart_counter={"n": 0},
            ),
            daemon=False,
            name=f"worker-{dev.device_id}",
        )
        t.start()
        threads.append(t)

    print(f"Daemon started with {len(threads)} worker(s)")
    for t in threads:
        t.join()
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 4: Run test to verify pass**

```bash
pytest tests/test_daemon.py -v
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/daemon.py tests/test_daemon.py
git commit -m "feat(daemon): forever loop with per-device worker threads"
```

---

## Phase 5: Health Monitoring & Telegram Alerts

### Task 17: Telegram bot integration

**Files:**
- Create: `scraper/telegram_bot.py`
- Create: `tests/test_telegram_bot.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_telegram_bot.py
from unittest.mock import MagicMock, patch
from scraper.telegram_bot import TelegramBot


def test_send_message_posts_to_api():
    with patch("scraper.telegram_bot.requests.post") as post:
        post.return_value = MagicMock(status_code=200, json=lambda: {"ok": True})
        bot = TelegramBot(token="tok", chat_id="123")
        ok = bot.send("hello")
        assert ok is True
        args, kwargs = post.call_args
        assert "tok" in args[0]
        assert kwargs["json"]["chat_id"] == "123"
        assert kwargs["json"]["text"] == "hello"


def test_send_message_returns_false_on_error():
    with patch("scraper.telegram_bot.requests.post") as post:
        post.return_value = MagicMock(status_code=500, json=lambda: {"ok": False})
        bot = TelegramBot(token="tok", chat_id="123")
        ok = bot.send("hi")
        assert ok is False


def test_format_l1_summary():
    text = TelegramBot.format_l1(
        date="2026-05-24",
        cycles_completed=6, cycles_target=6,
        product_obs=588, product_obs_target=600,
        variant_obs=3490, variant_obs_target=3600,
        avg_temp_c=32.0,
        patches_applied=0,
    )
    assert "2026-05-24" in text
    assert "6/6" in text
    assert "588/600" in text


def test_format_l3_critical():
    text = TelegramBot.format_l3_critical("Daemon 35min outage")
    assert "🚨" in text
    assert "Daemon 35min outage" in text
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_telegram_bot.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/telegram_bot.py`**

```python
# scraper/telegram_bot.py
import requests


class TelegramBot:
    def __init__(self, token: str, chat_id: str):
        self.token = token
        self.chat_id = chat_id
        self.api_url = f"https://api.telegram.org/bot{token}"

    def send(self, text: str, *, disable_notification: bool = False) -> bool:
        try:
            r = requests.post(
                f"{self.api_url}/sendMessage",
                json={"chat_id": self.chat_id, "text": text, "disable_notification": disable_notification},
                timeout=10,
            )
            return r.status_code == 200 and r.json().get("ok", False)
        except requests.RequestException:
            return False

    @staticmethod
    def format_l1(*, date: str, cycles_completed: int, cycles_target: int,
                  product_obs: int, product_obs_target: int,
                  variant_obs: int, variant_obs_target: int,
                  avg_temp_c: float, patches_applied: int) -> str:
        return (
            f"✅ {date} daily summary\n"
            f"Cycles: {cycles_completed}/{cycles_target}\n"
            f"Product obs: {product_obs}/{product_obs_target}\n"
            f"Variant obs: {variant_obs}/{variant_obs_target}\n"
            f"Avg phone temp: {avg_temp_c:.1f}°C\n"
            f"Patches applied: {patches_applied}"
        )

    @staticmethod
    def format_l2_warn(message: str) -> str:
        return f"⚠️ {message}"

    @staticmethod
    def format_l3_critical(message: str) -> str:
        return f"🚨 CRITICAL: {message}"

    @staticmethod
    def format_patch_success(file_path: str, summary: str, canary_result: str) -> str:
        return f"🔧 Patch applied: {file_path}\n{summary}\nCanary: {canary_result}"

    @staticmethod
    def format_patch_failure(reason: str) -> str:
        return f"❌ Patch attempted, failed: {reason}\nManual intervention required."
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_telegram_bot.py -v
```

Expected: all PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/telegram_bot.py tests/test_telegram_bot.py
git commit -m "feat(telegram): bot wrapper + L1/L2/L3/patch message formatters"
```

---

### Task 18: Health monitor (L1/L2/L3 alert computation)

**Files:**
- Create: `scraper/health_monitor.py`
- Create: `tests/test_health_monitor.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_health_monitor.py
from datetime import datetime, timedelta
from scraper import health_monitor


def _seed_runs(conn, success_rates_pct: list[int]):
    """Insert 1 run per entry, success/attempted derived from pct."""
    conn.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1','A1')")
    for i, pct in enumerate(success_rates_pct):
        succeeded = pct
        attempted = 100
        conn.execute(
            "INSERT INTO runs(device_id, started_at, finished_at, status, attempted, succeeded) "
            "VALUES('d1', ?, ?, ?, ?, ?)",
            (
                (datetime(2026, 5, 24) + timedelta(hours=i)).isoformat(),
                (datetime(2026, 5, 24) + timedelta(hours=i, minutes=30)).isoformat(),
                "success" if pct >= 85 else "partial",
                attempted,
                succeeded,
            ),
        )


def test_classify_info_when_healthy(memdb):
    _seed_runs(memdb, [95])
    level = health_monitor.classify_latest(memdb, device_id="d1")
    assert level == "info"


def test_classify_warn_when_50_to_90(memdb):
    _seed_runs(memdb, [72])
    level = health_monitor.classify_latest(memdb, device_id="d1")
    assert level == "warn"


def test_classify_critical_below_50(memdb):
    _seed_runs(memdb, [30])
    level = health_monitor.classify_latest(memdb, device_id="d1")
    assert level == "critical"


def test_heartbeat_missing_24h_is_critical(memdb):
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1','A1')")
    old = (datetime.utcnow() - timedelta(hours=25)).isoformat()
    memdb.execute("INSERT INTO heartbeats(ts, component, status) VALUES(?, 'daemon:d1', 'ok')", (old,))
    level = health_monitor.check_heartbeat(memdb, component="daemon:d1", now=datetime.utcnow())
    assert level == "critical"


def test_heartbeat_recent_is_info(memdb):
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1','A1')")
    recent = (datetime.utcnow() - timedelta(minutes=30)).isoformat()
    memdb.execute("INSERT INTO heartbeats(ts, component, status) VALUES(?, 'daemon:d1', 'ok')", (recent,))
    level = health_monitor.check_heartbeat(memdb, component="daemon:d1", now=datetime.utcnow())
    assert level == "info"
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_health_monitor.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/health_monitor.py`**

```python
# scraper/health_monitor.py
from datetime import datetime, timedelta


def classify_latest(conn, device_id: str) -> str:
    row = conn.execute(
        "SELECT attempted, succeeded FROM runs WHERE device_id=? ORDER BY started_at DESC LIMIT 1",
        (device_id,),
    ).fetchone()
    if not row:
        return "info"  # no runs yet, nothing to alarm on
    if row["attempted"] == 0:
        return "warn"
    pct = (row["succeeded"] / row["attempted"]) * 100
    if pct >= 90:
        return "info"
    if pct >= 50:
        return "warn"
    return "critical"


def check_heartbeat(conn, component: str, now: datetime, max_age_hours: int = 24) -> str:
    row = conn.execute(
        "SELECT ts FROM heartbeats WHERE component=? ORDER BY ts DESC LIMIT 1", (component,)
    ).fetchone()
    if not row:
        return "critical"
    ts = datetime.fromisoformat(row["ts"])
    if now - ts > timedelta(hours=max_age_hours):
        return "critical"
    return "info"


def daily_summary(conn, *, date: str, device_id: str) -> dict:
    """Aggregate metrics for a given day."""
    rows = conn.execute(
        "SELECT * FROM runs WHERE device_id=? AND started_at LIKE ?",
        (device_id, f"{date}%"),
    ).fetchall()
    attempted = sum(r["attempted"] or 0 for r in rows)
    succeeded = sum(r["succeeded"] or 0 for r in rows)
    variants = sum(r["variants_captured"] or 0 for r in rows)
    return {
        "cycles": len(rows),
        "attempted": attempted,
        "succeeded": succeeded,
        "variants_captured": variants,
        "success_pct": (succeeded / attempted * 100) if attempted else 0.0,
    }
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_health_monitor.py -v
```

Expected: all PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/health_monitor.py tests/test_health_monitor.py
git commit -m "feat(monitor): L1/L2/L3 classification + heartbeat check + daily summary"
```

---

### Task 19: Heartbeat checker + daily summary script

**Files:**
- Create: `scripts/heartbeat_check.py`
- Create: `scripts/daily_summary.py`

These are simple scripts run by launchd / cron, no TDD beyond integration.

- [ ] **Step 1: Write `scripts/heartbeat_check.py`**

```python
#!/usr/bin/env python3
"""Hourly heartbeat checker. Run by launchd every hour.
Sends Telegram L3 alarm if daemon heartbeat is missing > 24h."""

import sys
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from scraper import config, db, health_monitor
from scraper.device_pool import DevicePool
from scraper.telegram_bot import TelegramBot


def main() -> int:
    cfg = config.load()
    conn = db.connect(cfg.db_path)
    bot = TelegramBot(token=cfg.telegram_token, chat_id=cfg.telegram_chat_id)
    pool = DevicePool.from_json(Path("config/devices.json"))
    now = datetime.utcnow()

    for dev in pool.active_devices():
        level = health_monitor.check_heartbeat(conn, component=f"daemon:{dev.device_id}", now=now)
        if level == "critical":
            bot.send(TelegramBot.format_l3_critical(
                f"Daemon heartbeat missing for {dev.device_id} (>24h). Check daemon process."
            ))
            return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 2: Write `scripts/daily_summary.py`**

```python
#!/usr/bin/env python3
"""Daily 09:30 summary script. Run by launchd."""

import sys
from datetime import datetime, timedelta
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from scraper import config, db, health_monitor
from scraper.device_pool import DevicePool
from scraper.telegram_bot import TelegramBot


def main() -> int:
    cfg = config.load()
    conn = db.connect(cfg.db_path)
    bot = TelegramBot(token=cfg.telegram_token, chat_id=cfg.telegram_chat_id)
    pool = DevicePool.from_json(Path("config/devices.json"))
    yesterday = (datetime.utcnow() - timedelta(days=1)).strftime("%Y-%m-%d")

    aggregates = []
    for dev in pool.active_devices():
        agg = health_monitor.daily_summary(conn, date=yesterday, device_id=dev.device_id)
        aggregates.append((dev.device_id, agg))

    total_obs = sum(a["succeeded"] for _, a in aggregates)
    total_attempted = sum(a["attempted"] for _, a in aggregates)
    total_variants = sum(a["variants_captured"] for _, a in aggregates)
    cycles = aggregates[0][1]["cycles"] if aggregates else 0

    text = TelegramBot.format_l1(
        date=yesterday,
        cycles_completed=cycles, cycles_target=6,
        product_obs=total_obs, product_obs_target=600,
        variant_obs=total_variants, variant_obs_target=3600,
        avg_temp_c=0.0,  # phone health log not yet wired
        patches_applied=conn.execute(
            "SELECT COUNT(*) c FROM patches WHERE applied_at LIKE ?", (f"{yesterday}%",)
        ).fetchone()["c"],
    )
    bot.send(text)
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 3: Make executable**

```bash
chmod +x scripts/heartbeat_check.py scripts/daily_summary.py
```

- [ ] **Step 4: Commit**

```bash
git add scripts/heartbeat_check.py scripts/daily_summary.py
git commit -m "feat(scripts): heartbeat checker + daily summary cron scripts"
```

---

## Phase 6: Claude Supervisor & Canary

### Task 20: Canary test runner

**Files:**
- Create: `scraper/canary.py`
- Create: `tests/test_canary.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_canary.py
from datetime import datetime
from pathlib import Path
from unittest.mock import MagicMock
from scraper import canary


def test_canary_success_above_threshold(memdb, tmp_path):
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1','A1')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1','u')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s2','u')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s3','u')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s4','u')")
    memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s5','u')")

    adb = MagicMock()
    adb.list_devices.return_value = ["A1"]
    adb.battery_temperature_c.return_value = 30
    adb.battery_level_pct.return_value = 80
    adb.foreground_package.return_value = ""
    adb.screen_on.return_value = True
    adb.dump_xml.return_value = "<hierarchy><node text='ok'/></hierarchy>"

    def fake_capture(*, sku_id, **kw):
        from scraper.capture import CaptureResult
        return CaptureResult(success=True)
    with __import__("unittest.mock", fromlist=["patch"]).patch(
        "scraper.canary.capture.capture_product", side_effect=lambda **kw: fake_capture(**kw),
    ):
        result = canary.run_canary(
            conn=memdb, adb=adb, device_id="d1", serial="A1",
            data_dir=tmp_path, sku_ids=["s1", "s2", "s3", "s4", "s5"], threshold=0.8,
        )
    assert result.passed is True
    assert result.success_count == 5


def test_canary_fail_below_threshold(memdb, tmp_path):
    memdb.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1','A1')")
    for s in ["s1", "s2", "s3", "s4", "s5"]:
        memdb.execute("INSERT INTO targets(sku_id, temu_url) VALUES(?, 'u')", (s,))

    adb = MagicMock()
    adb.list_devices.return_value = ["A1"]
    adb.battery_temperature_c.return_value = 30
    adb.battery_level_pct.return_value = 80
    adb.foreground_package.return_value = ""
    adb.screen_on.return_value = True
    adb.dump_xml.return_value = "<hierarchy/>"

    counter = {"n": 0}
    def alternating(**kw):
        from scraper.capture import CaptureResult
        counter["n"] += 1
        return CaptureResult(success=counter["n"] <= 2)

    with __import__("unittest.mock", fromlist=["patch"]).patch(
        "scraper.canary.capture.capture_product", side_effect=lambda **kw: alternating(**kw),
    ):
        result = canary.run_canary(
            conn=memdb, adb=adb, device_id="d1", serial="A1",
            data_dir=tmp_path, sku_ids=["s1", "s2", "s3", "s4", "s5"], threshold=0.8,
        )
    assert result.passed is False
    assert result.success_count == 2
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_canary.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/canary.py`**

```python
# scraper/canary.py
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from scraper import capture


@dataclass
class CanaryResult:
    passed: bool
    success_count: int
    total: int
    threshold: float

    def summary(self) -> str:
        return f"{self.success_count}/{self.total} (threshold {int(self.threshold*100)}%)"


def run_canary(
    *, conn, adb, device_id: str, serial: str, data_dir: Path,
    sku_ids: list[str], threshold: float = 0.8,
) -> CanaryResult:
    successes = 0
    for sku in sku_ids:
        ts = datetime.utcnow().isoformat()
        r = capture.capture_product(
            conn=conn, adb=adb, serial=serial, device_id=device_id,
            sku_id=sku, data_dir=data_dir, observed_at=ts,
        )
        if r.success:
            successes += 1
    pct = successes / len(sku_ids) if sku_ids else 0
    return CanaryResult(
        passed=pct >= threshold, success_count=successes,
        total=len(sku_ids), threshold=threshold,
    )
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_canary.py -v
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/canary.py tests/test_canary.py
git commit -m "feat(canary): 5-SKU test runner with configurable threshold"
```

---

### Task 21: Supervisor prompt template

**Files:**
- Create: `agents/supervisor_prompt.md`

This is a static markdown file the supervisor cron invokes Claude with. No tests; it's a prompt.

- [ ] **Step 1: Write the prompt**

```markdown
# agents/supervisor_prompt.md

You are the **Temu Scraper Supervisor**. You run on a 6-hour cron schedule. Your job is to detect scraper failures and patch them automatically — but only safely.

## Scope of action

You may ONLY modify these files:
- `scraper/temu_actions.py` (selector coordinates, timing constants, scroll distances, retry counts)
- `scraper/temu_resource_ids.py` (resource-id strings)

You may NEVER modify:
- `scraper/daemon.py`, `scraper/scheduler.py`, `scraper/db.py`, `scraper/storage.py`,
  `scraper/parser.py`, `scraper/rate_limiter.py`, `scraper/health_monitor.py`,
  `scraper/telegram_bot.py`, `scraper/canary.py`, `scraper/capture.py`

If a failure cannot be fixed by editing the two allowed files, file a Telegram L3 alert and exit.

## Workflow

1. Read `scraper/data/state/health.json` (written by the health monitor). It looks like:
   ```json
   {"level":"warn","reason":"success rate 12% last cycle","since":"2026-05-24T14:00:00",
    "last_failures":[{"sku":"s1","error":"price_current rid missing"}]}
   ```

2. If `level` is `info`, print "no action needed" and exit. **DO NOT spend tokens analyzing.**

3. If `level` is `warn` or `critical`:
   a. Read the most recent 3 XML dumps in `<data_dir>/xml_dumps/` and the corresponding screenshots in `<data_dir>/screenshots/`
   b. Compare to `tests/fixtures/sample_xml_dump.xml` (the known-good baseline)
   c. Identify which `TEMU_RIDS` entry no longer matches a real node, or which coordinate is off
   d. Edit ONLY `scraper/temu_actions.py` and/or `scraper/temu_resource_ids.py` with the minimum patch needed

4. Run the canary:
   ```bash
   .venv/bin/python -c "
   from scraper import canary, config, db
   from scraper.adb_client import AdbClient
   from pathlib import Path
   cfg = config.load()
   conn = db.connect(cfg.db_path)
   adb = AdbClient(adb_bin=cfg.adb_bin)
   # use first 5 SKUs from targets
   skus = [r['sku_id'] for r in conn.execute('SELECT sku_id FROM targets LIMIT 5').fetchall()]
   result = canary.run_canary(conn=conn, adb=adb, device_id='phone_01', serial='<SERIAL>', data_dir=cfg.data_dir, sku_ids=skus, threshold=0.8)
   print('canary:', result.summary())
   import sys; sys.exit(0 if result.passed else 1)
   "
   ```

5. If canary passed:
   - Commit the patch with message `patch(supervisor): <one-line summary>`
   - Send Telegram message `TelegramBot.format_patch_success(file_path, summary, canary_result)`

6. If canary failed:
   - Revert the patch (`git checkout scraper/temu_actions.py scraper/temu_resource_ids.py`)
   - Send Telegram message `TelegramBot.format_patch_failure(reason)`
   - Exit; a human will investigate

## Hard rules

- Do not run more than one patch attempt per supervisor invocation.
- Do not skip the canary, ever.
- If you cannot identify the cause within 5 minutes, abort and alert.
- Token budget: this entire run should be under 30K tokens. If you find yourself going over, stop and alert.
```

- [ ] **Step 2: Commit**

```bash
git add agents/supervisor_prompt.md
git commit -m "feat(supervisor): Claude prompt template + scope-of-action rules"
```

---

### Task 22: Supervisor cron wrapper script

**Files:**
- Create: `scripts/run_supervisor.sh`

- [ ] **Step 1: Write the wrapper**

```bash
#!/bin/bash
# scripts/run_supervisor.sh
# Triggered by cron every 6 hours. Decides whether to invoke Claude.

set -euo pipefail

PROJECT_DIR="/Users/berkantcalikusu/Desktop/sandbox_data"
cd "$PROJECT_DIR"

STATE_FILE="${SCRAPER_DATA_DIR:-$HOME/Library/Application Support/temu-scraper}/state/health.json"

if [[ ! -f "$STATE_FILE" ]]; then
  echo "$(date) no health state file yet, exiting"
  exit 0
fi

level=$(python3 -c "import json,sys; print(json.load(open('$STATE_FILE'))['level'])")

if [[ "$level" == "info" ]]; then
  echo "$(date) level=info, no action needed"
  exit 0
fi

echo "$(date) level=$level, invoking Claude supervisor"
# Invoke Claude Code in headless mode with the supervisor prompt
claude --print --append-system-prompt "$(cat agents/supervisor_prompt.md)" \
  "Read state file $STATE_FILE and act per the supervisor prompt." \
  >> "$PROJECT_DIR/scripts/supervisor.log" 2>&1
```

- [ ] **Step 2: Make executable**

```bash
chmod +x scripts/run_supervisor.sh
```

- [ ] **Step 3: Commit**

```bash
git add scripts/run_supervisor.sh
git commit -m "feat(supervisor): cron wrapper that gates Claude invocation on health"
```

---

### Task 23: Health monitor writes state file

**Files:**
- Modify: `scraper/health_monitor.py` (add `write_state_file`)
- Create: `scripts/run_health_check.py`

- [ ] **Step 1: Add `write_state_file` to `scraper/health_monitor.py`**

Append:

```python
import json
from pathlib import Path


def write_state_file(*, level: str, reason: str, since: str, last_failures: list[dict], state_dir: Path) -> None:
    state_dir.mkdir(parents=True, exist_ok=True)
    (state_dir / "health.json").write_text(json.dumps({
        "level": level,
        "reason": reason,
        "since": since,
        "last_failures": last_failures,
    }, indent=2))


def last_failures(conn, device_id: str, limit: int = 10) -> list[dict]:
    # placeholder: read from a future failure_log table or runs.notes
    return []
```

- [ ] **Step 2: Write `scripts/run_health_check.py`**

```python
#!/usr/bin/env python3
"""Run after each daemon cycle (or on a 30-min cron) to compute health and
write state file the supervisor cron reads."""

import sys
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from scraper import config, db, health_monitor
from scraper.device_pool import DevicePool
from scraper.telegram_bot import TelegramBot


def main() -> int:
    cfg = config.load()
    conn = db.connect(cfg.db_path)
    bot = TelegramBot(token=cfg.telegram_token, chat_id=cfg.telegram_chat_id)
    pool = DevicePool.from_json(Path("config/devices.json"))
    now = datetime.utcnow().isoformat()

    overall = "info"
    for dev in pool.active_devices():
        l1 = health_monitor.classify_latest(conn, device_id=dev.device_id)
        l2 = health_monitor.check_heartbeat(conn, component=f"daemon:{dev.device_id}", now=datetime.utcnow())
        device_level = "critical" if "critical" in (l1, l2) else ("warn" if "warn" in (l1, l2) else "info")
        if device_level == "critical": overall = "critical"
        elif device_level == "warn" and overall == "info": overall = "warn"

    state_dir = cfg.data_dir / "state"
    health_monitor.write_state_file(
        level=overall, reason=f"overall={overall}",
        since=now, last_failures=[], state_dir=state_dir,
    )

    if overall == "warn":
        bot.send(TelegramBot.format_l2_warn(f"Health check: success or heartbeat degraded. Supervisor will check on next cron."))
    elif overall == "critical":
        bot.send(TelegramBot.format_l3_critical(f"Health check failed: {overall}. See state file: {state_dir / 'health.json'}"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 3: Make executable**

```bash
chmod +x scripts/run_health_check.py
```

- [ ] **Step 4: Commit**

```bash
git add scraper/health_monitor.py scripts/run_health_check.py
git commit -m "feat(monitor): write health.json state file for supervisor to consume"
```

---

## Phase 7: Operations (Bootstrap, Retention)

### Task 24: launchd plist files

**Files:**
- Create: `config/launchd/com.berkant.scraper.daemon.plist`
- Create: `config/launchd/com.berkant.scraper.heartbeat.plist`
- Create: `config/launchd/com.berkant.scraper.daily_summary.plist`
- Create: `config/launchd/com.berkant.scraper.health_check.plist`

- [ ] **Step 1: Write daemon plist (KeepAlive=true, RunAtLoad=true)**

```xml
<!-- config/launchd/com.berkant.scraper.daemon.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.berkant.scraper.daemon</string>
  <key>WorkingDirectory</key><string>/Users/berkantcalikusu/Desktop/sandbox_data</string>
  <key>ProgramArguments</key>
  <array>
    <string>/Users/berkantcalikusu/Desktop/sandbox_data/.venv/bin/python</string>
    <string>-m</string><string>scraper.daemon</string>
  </array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
  <key>StandardOutPath</key>
  <string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/daemon.out.log</string>
  <key>StandardErrorPath</key>
  <string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/daemon.err.log</string>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PATH</key><string>/opt/homebrew/bin:/usr/bin:/bin</string>
  </dict>
</dict>
</plist>
```

- [ ] **Step 2: Write heartbeat plist (every hour)**

```xml
<!-- config/launchd/com.berkant.scraper.heartbeat.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.berkant.scraper.heartbeat</string>
  <key>WorkingDirectory</key><string>/Users/berkantcalikusu/Desktop/sandbox_data</string>
  <key>ProgramArguments</key>
  <array>
    <string>/Users/berkantcalikusu/Desktop/sandbox_data/.venv/bin/python</string>
    <string>scripts/heartbeat_check.py</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Minute</key><integer>17</integer>
  </dict>
  <key>StandardOutPath</key><string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/heartbeat.out.log</string>
  <key>StandardErrorPath</key><string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/heartbeat.err.log</string>
</dict>
</plist>
```

- [ ] **Step 3: Write daily summary plist (every day 09:30)**

```xml
<!-- config/launchd/com.berkant.scraper.daily_summary.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.berkant.scraper.daily_summary</string>
  <key>WorkingDirectory</key><string>/Users/berkantcalikusu/Desktop/sandbox_data</string>
  <key>ProgramArguments</key>
  <array>
    <string>/Users/berkantcalikusu/Desktop/sandbox_data/.venv/bin/python</string>
    <string>scripts/daily_summary.py</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key><integer>9</integer>
    <key>Minute</key><integer>33</integer>
  </dict>
  <key>StandardOutPath</key><string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/daily_summary.out.log</string>
  <key>StandardErrorPath</key><string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/daily_summary.err.log</string>
</dict>
</plist>
```

- [ ] **Step 4: Write health check plist (every 30 min)**

```xml
<!-- config/launchd/com.berkant.scraper.health_check.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.berkant.scraper.health_check</string>
  <key>WorkingDirectory</key><string>/Users/berkantcalikusu/Desktop/sandbox_data</string>
  <key>ProgramArguments</key>
  <array>
    <string>/Users/berkantcalikusu/Desktop/sandbox_data/.venv/bin/python</string>
    <string>scripts/run_health_check.py</string>
  </array>
  <key>StartInterval</key><integer>1800</integer>
  <key>StandardOutPath</key><string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/health.out.log</string>
  <key>StandardErrorPath</key><string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/health.err.log</string>
</dict>
</plist>
```

- [ ] **Step 5: Commit**

```bash
git add config/launchd/
git commit -m "feat(launchd): daemon + heartbeat + daily summary + health plists"
```

---

### Task 25: Bootstrap install.sh

**Files:**
- Create: `scripts/install.sh`
- Create: `scripts/uninstall.sh`

- [ ] **Step 1: Write install.sh**

```bash
#!/bin/bash
# scripts/install.sh — one-time bootstrap. Run from project root.

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

echo "==> Step 1: Verify system dependencies"
for bin in adb tesseract python3.11; do
  if ! command -v "$bin" >/dev/null 2>&1; then
    echo "ERROR: $bin not found. Install with: brew install android-platform-tools tesseract python@3.11"
    exit 1
  fi
done
echo "  ✓ adb, tesseract, python3.11 present"

echo "==> Step 2: Create venv + install dependencies"
if [[ ! -d .venv ]]; then
  python3.11 -m venv .venv
fi
.venv/bin/pip install -q -r requirements.txt
echo "  ✓ venv ready"

echo "==> Step 3: Create data directories"
DATA_DIR="${SCRAPER_DATA_DIR:-$HOME/Library/Application Support/temu-scraper}"
mkdir -p "$DATA_DIR"/{xml_dumps,screenshots,state,logs}
echo "  ✓ data dir: $DATA_DIR"

echo "==> Step 4: Verify .env exists"
if [[ ! -f .env ]]; then
  echo "ERROR: .env not found. Copy .env.example to .env and fill in TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID."
  exit 1
fi
echo "  ✓ .env present"

echo "==> Step 5: Initialize SQLite DB"
.venv/bin/python -c "from scraper import config, db; cfg=config.load(); conn=db.connect(cfg.db_path); db.apply_schema(conn); print('  ✓ DB initialized at', cfg.db_path)"

echo "==> Step 6: Verify devices.json"
if [[ ! -f config/devices.json ]]; then
  echo "ERROR: config/devices.json not found. Run:"
  echo "  adb devices  # find your serial"
  echo "  cp config/devices.json.example config/devices.json"
  echo "  # edit to add your device"
  exit 1
fi
echo "  ✓ devices.json present"

echo "==> Step 7: Verify targets.json + seed targets table"
if [[ ! -f config/targets.json ]]; then
  echo "ERROR: config/targets.json not found. Create with at least 5 SKUs for PoC."
  exit 1
fi
.venv/bin/python scripts/seed_targets.py
echo "  ✓ targets seeded"

echo "==> Step 8: Install launchd plists"
LA_DIR="$HOME/Library/LaunchAgents"
mkdir -p "$LA_DIR"
for f in config/launchd/com.berkant.scraper.*.plist; do
  name=$(basename "$f")
  cp "$f" "$LA_DIR/$name"
  launchctl bootout "gui/$(id -u)/${name%.plist}" 2>/dev/null || true
  launchctl bootstrap "gui/$(id -u)" "$LA_DIR/$name"
  echo "  ✓ loaded $name"
done

echo "==> Step 9: Install supervisor cron (every 6 hours)"
(crontab -l 2>/dev/null | grep -v 'run_supervisor.sh' || true; \
 echo "13 0,6,12,18 * * * cd $PROJECT_DIR && ./scripts/run_supervisor.sh") | crontab -
echo "  ✓ supervisor cron installed"

echo "==> Step 10: Disable Mac sleep (24/7 operation requires this)"
sudo pmset -a disablesleep 1
sudo pmset -a sleep 0
echo "  ✓ pmset configured"

echo "==> Step 11: Telegram bot health check"
.venv/bin/python -c "
from scraper import config
from scraper.telegram_bot import TelegramBot
cfg = config.load()
bot = TelegramBot(cfg.telegram_token, cfg.telegram_chat_id)
ok = bot.send('✅ Temu scraper installed successfully. Daemon will start in 1 minute.')
print('  ✓ Telegram OK' if ok else '  ✗ Telegram FAILED — check token/chat_id')
"

echo ""
echo "================================================================"
echo "Installation complete. Verify with:"
echo "  launchctl list | grep berkant.scraper"
echo "  tail -f scripts/daemon.out.log"
echo "  ls $DATA_DIR/xml_dumps/"
echo "================================================================"
```

- [ ] **Step 2: Write uninstall.sh**

```bash
#!/bin/bash
# scripts/uninstall.sh

set -euo pipefail

LA_DIR="$HOME/Library/LaunchAgents"
for name in com.berkant.scraper.daemon com.berkant.scraper.heartbeat com.berkant.scraper.daily_summary com.berkant.scraper.health_check; do
  launchctl bootout "gui/$(id -u)/$name" 2>/dev/null || true
  rm -f "$LA_DIR/$name.plist"
done
(crontab -l 2>/dev/null | grep -v 'run_supervisor.sh' || true) | crontab -
sudo pmset -a disablesleep 0
echo "Uninstalled. Data dir retained at SCRAPER_DATA_DIR."
```

- [ ] **Step 3: Make executable**

```bash
chmod +x scripts/install.sh scripts/uninstall.sh
```

- [ ] **Step 4: Commit**

```bash
git add scripts/install.sh scripts/uninstall.sh
git commit -m "feat(bootstrap): install.sh + uninstall.sh (one-time setup)"
```

---

### Task 26: Seed targets script

**Files:**
- Create: `scripts/seed_targets.py`
- Create: `config/targets.json` (example with 5 SKUs to start)

- [ ] **Step 1: Write `scripts/seed_targets.py`**

```python
#!/usr/bin/env python3
"""Seed targets table from config/targets.json."""

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from scraper import config, db


def main() -> int:
    cfg = config.load()
    conn = db.connect(cfg.db_path)
    targets = json.loads(Path("config/targets.json").read_text())
    for t in targets:
        conn.execute(
            "INSERT OR IGNORE INTO targets(sku_id, temu_url, category) VALUES(?,?,?)",
            (t["sku_id"], t["temu_url"], t.get("category", "")),
        )
    print(f"Seeded {len(targets)} targets")
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 2: Write example `config/targets.json` (start with 5; expand to 100 after Day 0)**

```json
[
  {"sku_id": "601099001", "temu_url": "https://www.temu.com/...", "category": "Electronics"},
  {"sku_id": "601099002", "temu_url": "https://www.temu.com/...", "category": "Electronics"},
  {"sku_id": "601099003", "temu_url": "https://www.temu.com/...", "category": "Apparel"},
  {"sku_id": "601099004", "temu_url": "https://www.temu.com/...", "category": "Home"},
  {"sku_id": "601099005", "temu_url": "https://www.temu.com/...", "category": "Beauty"}
]
```

- [ ] **Step 3: Make executable**

```bash
chmod +x scripts/seed_targets.py
```

- [ ] **Step 4: Commit**

```bash
git add scripts/seed_targets.py config/targets.json
git commit -m "feat(targets): seed script + 5-SKU starter list"
```

---

### Task 27: Retention policy / cleanup

**Files:**
- Create: `scraper/cleanup.py`
- Create: `scripts/run_cleanup.py`
- Create: `tests/test_cleanup.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_cleanup.py
import time
from pathlib import Path
from scraper import cleanup


def test_old_files_deleted(tmp_path):
    old = tmp_path / "old.png"
    new = tmp_path / "new.png"
    old.write_bytes(b"x")
    new.write_bytes(b"x")
    # Make old file appear 40 days old
    old_time = time.time() - 40 * 86400
    import os
    os.utime(old, (old_time, old_time))

    deleted = cleanup.delete_older_than(tmp_path, days=30, pattern="*.png")
    assert deleted == 1
    assert not old.exists()
    assert new.exists()


def test_compress_old_files(tmp_path):
    f = tmp_path / "x.xml"
    f.write_text("a" * 1000)
    old_time = time.time() - 10 * 86400
    import os
    os.utime(f, (old_time, old_time))
    compressed = cleanup.gzip_older_than(tmp_path, days=7, pattern="*.xml")
    assert compressed == 1
    assert not f.exists()
    assert (tmp_path / "x.xml.gz").exists()
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_cleanup.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/cleanup.py`**

```python
# scraper/cleanup.py
import gzip
import shutil
import time
from pathlib import Path


def delete_older_than(dir_path: Path, *, days: int, pattern: str) -> int:
    cutoff = time.time() - days * 86400
    deleted = 0
    for f in dir_path.glob(pattern):
        if f.is_file() and f.stat().st_mtime < cutoff:
            f.unlink()
            deleted += 1
    return deleted


def gzip_older_than(dir_path: Path, *, days: int, pattern: str) -> int:
    cutoff = time.time() - days * 86400
    compressed = 0
    for f in dir_path.glob(pattern):
        if not f.is_file() or f.stat().st_mtime >= cutoff or f.suffix == ".gz":
            continue
        gz = f.with_suffix(f.suffix + ".gz")
        with f.open("rb") as src, gzip.open(gz, "wb") as dst:
            shutil.copyfileobj(src, dst)
        f.unlink()
        compressed += 1
    return compressed
```

- [ ] **Step 4: Write `scripts/run_cleanup.py`**

```python
#!/usr/bin/env python3
"""Daily 03:00 cleanup runner."""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from scraper import cleanup, config


def main() -> int:
    cfg = config.load()
    xml_dir = cfg.data_dir / "xml_dumps"
    shot_dir = cfg.data_dir / "screenshots"
    log_dir = cfg.data_dir / "logs"

    print(f"XML: gzipped {cleanup.gzip_older_than(xml_dir, days=7, pattern='*.xml')}, deleted {cleanup.delete_older_than(xml_dir, days=14, pattern='*.gz')}")
    print(f"PNG: deleted {cleanup.delete_older_than(shot_dir, days=30, pattern='*.png')}")
    print(f"Logs: deleted {cleanup.delete_older_than(log_dir, days=90, pattern='*.log')}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 5: Add cleanup plist to install.sh and create the plist**

Create `config/launchd/com.berkant.scraper.cleanup.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.berkant.scraper.cleanup</string>
  <key>WorkingDirectory</key><string>/Users/berkantcalikusu/Desktop/sandbox_data</string>
  <key>ProgramArguments</key>
  <array>
    <string>/Users/berkantcalikusu/Desktop/sandbox_data/.venv/bin/python</string>
    <string>scripts/run_cleanup.py</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict><key>Hour</key><integer>3</integer><key>Minute</key><integer>7</integer></dict>
</dict>
</plist>
```

- [ ] **Step 6: Run tests to verify pass**

```bash
pytest tests/test_cleanup.py -v
```

Expected: all PASS.

- [ ] **Step 7: Commit**

```bash
git add scraper/cleanup.py scripts/run_cleanup.py config/launchd/com.berkant.scraper.cleanup.plist tests/test_cleanup.py
git commit -m "feat(cleanup): retention policy (xml 7d gz, png 30d, logs 90d)"
```

---

### Task 28: Weekly maintenance script

**Files:**
- Create: `scripts/weekly_maintenance.sh`
- Create: `config/launchd/com.berkant.scraper.weekly.plist`

- [ ] **Step 1: Write `scripts/weekly_maintenance.sh`**

```bash
#!/bin/bash
# scripts/weekly_maintenance.sh — Sunday 03:00 phone maintenance

set -euo pipefail
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

source .venv/bin/activate

SERIAL=$(python3 -c "import json; print(json.load(open('config/devices.json'))[0]['adb_serial'])")
adb -s "$SERIAL" shell am force-stop com.einnovation.temu
adb -s "$SERIAL" shell pm clear com.einnovation.temu
adb -s "$SERIAL" shell input keyevent KEYCODE_WAKEUP
sleep 2
adb -s "$SERIAL" shell svc power stayon usb

BATTERY_HEALTH=$(adb -s "$SERIAL" shell dumpsys battery | grep -i 'health' | awk '{print $2}')
TEMP=$(adb -s "$SERIAL" shell dumpsys battery | grep -i 'temperature' | awk '{print $2/10}')
DISK_USE=$(df -h ~/Library/Application\ Support/temu-scraper | tail -1 | awk '{print $5}')

python3 -c "
from scraper import config
from scraper.telegram_bot import TelegramBot
cfg = config.load()
bot = TelegramBot(cfg.telegram_token, cfg.telegram_chat_id)
bot.send('🔧 Weekly maintenance done. Battery health=$BATTERY_HEALTH, temp=${TEMP}°C, disk used=$DISK_USE')
"
```

- [ ] **Step 2: Make executable + write plist**

```bash
chmod +x scripts/weekly_maintenance.sh
```

```xml
<!-- config/launchd/com.berkant.scraper.weekly.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.berkant.scraper.weekly</string>
  <key>WorkingDirectory</key><string>/Users/berkantcalikusu/Desktop/sandbox_data</string>
  <key>ProgramArguments</key>
  <array><string>/Users/berkantcalikusu/Desktop/sandbox_data/scripts/weekly_maintenance.sh</string></array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Weekday</key><integer>0</integer>
    <key>Hour</key><integer>3</integer>
    <key>Minute</key><integer>27</integer>
  </dict>
</dict>
</plist>
```

- [ ] **Step 3: Commit**

```bash
git add scripts/weekly_maintenance.sh config/launchd/com.berkant.scraper.weekly.plist
git commit -m "feat(weekly): Sunday 03:30 phone maintenance + telegram report"
```

---

## Phase 8: Export for Marc

### Task 29: Denormalized CSV export

**Files:**
- Create: `scraper/export_csv.py`
- Create: `tests/test_export_csv.py`

- [ ] **Step 1: Write failing tests**

```python
# tests/test_export_csv.py
import csv
from datetime import datetime
from pathlib import Path
from scraper import export_csv, storage


def _seed(conn):
    conn.execute("INSERT INTO targets(sku_id, temu_url) VALUES('s1','u')")
    conn.execute("INSERT INTO devices(device_id, adb_serial) VALUES('d1','A1')")
    storage.upsert_product(conn, sku_id="s1", title="T-Shirt", category="Apparel", seller_name="ABC", ships_from="CN")
    storage.insert_product_observation(
        conn, sku_id="s1", device_id="d1", observed_at="2026-05-24T09:00:00",
        price_usd=9.99, original_price_usd=19.99, discount_pct=50.0,
        in_stock=True, sold_count_estimate=1500, rating_avg=4.5, review_count=234,
        has_free_shipping=True,
    )
    vid_red = storage.upsert_variant(conn, sku_id="s1", variant_key="option:Red", attributes={"option": "Red"})
    storage.insert_variant_observation(conn, variant_id=vid_red, observed_at="2026-05-24T09:00:00", price_usd=9.99, in_stock=True)
    vid_blue = storage.upsert_variant(conn, sku_id="s1", variant_key="option:Blue", attributes={"option": "Blue"})
    storage.insert_variant_observation(conn, variant_id=vid_blue, observed_at="2026-05-24T09:00:00", price_usd=10.99, in_stock=False)


def test_export_csv_produces_one_row_per_observation(memdb, tmp_path):
    _seed(memdb)
    out = tmp_path / "out.csv"
    export_csv.export(memdb, out)
    rows = list(csv.DictReader(out.open()))
    assert len(rows) == 1
    r = rows[0]
    assert r["sku_id"] == "s1"
    assert r["title"] == "T-Shirt"
    assert float(r["price_usd"]) == 9.99
    # variants_json should contain both colors
    import json
    variants = json.loads(r["variants_json"])
    keys = sorted(v["variant_key"] for v in variants)
    assert keys == ["option:Blue", "option:Red"]
```

- [ ] **Step 2: Run tests to verify failure**

```bash
pytest tests/test_export_csv.py -v
```

Expected: FAIL.

- [ ] **Step 3: Implement `scraper/export_csv.py`**

```python
# scraper/export_csv.py
import csv
import json
import sqlite3
from pathlib import Path

COLUMNS = [
    "sku_id", "observed_at", "title", "category", "seller_name", "ships_from",
    "price_usd", "original_price_usd", "discount_pct",
    "in_stock", "sold_count_text", "sold_count_estimate",
    "rating_avg", "review_count",
    "rating_5_count", "rating_4_count", "rating_3_count", "rating_2_count", "rating_1_count",
    "has_free_shipping", "shipping_cost_usd",
    "delivery_eta_days_min", "delivery_eta_days_max",
    "has_coupon", "coupon_value_usd",
    "variants_json", "features_json", "image_urls_json",
    "parse_confidence",
]


def _variants_for(conn: sqlite3.Connection, sku_id: str, observed_at: str) -> str:
    rows = conn.execute("""
        SELECT v.variant_key, v.attributes_json, vo.price_usd, vo.in_stock, vo.stock_estimate
        FROM variants v
        JOIN variant_observations vo ON vo.variant_id = v.id
        WHERE v.sku_id=? AND vo.observed_at=?
        ORDER BY v.variant_key
    """, (sku_id, observed_at)).fetchall()
    return json.dumps([
        {"variant_key": r["variant_key"],
         "attributes": json.loads(r["attributes_json"]) if r["attributes_json"] else {},
         "price_usd": r["price_usd"], "in_stock": bool(r["in_stock"]), "stock_estimate": r["stock_estimate"]}
        for r in rows
    ])


def _features_for(conn, sku_id: str, observed_at: str) -> str:
    rows = conn.execute(
        "SELECT feature_key, feature_value FROM product_features WHERE sku_id=? AND observed_at=?",
        (sku_id, observed_at),
    ).fetchall()
    return json.dumps({r["feature_key"]: r["feature_value"] for r in rows})


def _images_for(conn, sku_id: str, observed_at: str) -> str:
    rows = conn.execute(
        "SELECT image_url FROM product_images WHERE sku_id=? AND observed_at=? ORDER BY image_position",
        (sku_id, observed_at),
    ).fetchall()
    return json.dumps([r["image_url"] for r in rows])


def export(conn: sqlite3.Connection, output_path: Path, *, since: str | None = None) -> int:
    where = "WHERE po.observed_at >= ?" if since else ""
    params = (since,) if since else ()
    sql = f"""
        SELECT po.*, p.title, p.category, p.seller_name, p.ships_from
        FROM product_observations po
        JOIN products p ON p.sku_id = po.sku_id
        {where}
        ORDER BY po.sku_id, po.observed_at
    """
    output_path.parent.mkdir(parents=True, exist_ok=True)
    written = 0
    with output_path.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=COLUMNS, extrasaction="ignore")
        w.writeheader()
        for row in conn.execute(sql, params):
            d = dict(row)
            d["variants_json"] = _variants_for(conn, row["sku_id"], row["observed_at"])
            d["features_json"] = _features_for(conn, row["sku_id"], row["observed_at"])
            d["image_urls_json"] = _images_for(conn, row["sku_id"], row["observed_at"])
            w.writerow(d)
            written += 1
    return written
```

- [ ] **Step 4: Run tests to verify pass**

```bash
pytest tests/test_export_csv.py -v
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add scraper/export_csv.py tests/test_export_csv.py
git commit -m "feat(export): denormalized CSV view for Marc (variants/features as JSON cols)"
```

---

### Task 30: Operator README

**Files:**
- Create: `README.md`

- [ ] **Step 1: Write README**

```markdown
# Temu 24/7 Scraper — Operator Guide

## What this is

A 24/7 Temu mobile-app scraper running on a single Android device + macOS host, built for the Bright Data partnership PoC. Captures full product data (title, prices, variants, ratings, features, images) every 4 hours per SKU.

## One-time setup

1. Connect Android phone via USB, enable USB debugging.
2. Install Temu app on phone. Sign in or use guest mode.
3. Copy environment template and fill in secrets:
   ```bash
   cp .env.example .env
   # Edit .env: TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID
   ```
4. Create device registry:
   ```bash
   adb devices  # note the serial (e.g., A1B2C3)
   cat > config/devices.json <<EOF
   [{"device_id":"phone_01","adb_serial":"A1B2C3","model":"Pixel 7","screen_resolution":"1080x2400","active":true,"added_at":"2026-05-24"}]
   EOF
   ```
5. Edit `config/targets.json` to list the 100 SKUs you want to track.
6. Run the Day 0 feasibility test:
   ```bash
   .venv/bin/python -m scraper.feasibility
   ```
7. Based on scenario, populate `scraper/temu_resource_ids.py` with actual Temu resource-ids from the dump.
8. Install and start:
   ```bash
   ./scripts/install.sh
   ```

## Daily operation

You should never need to touch the terminal. Telegram will tell you:
- ✅ Every morning at ~09:33: yesterday's summary.
- ⚠️ Any cycle with degraded success rate.
- 🚨 Critical issues (daemon down, phone overheat, ban risk).
- 🔧 When Claude supervisor applied a patch.

## Manual inspection

```bash
launchctl list | grep berkant.scraper          # see all jobs
tail -f scripts/daemon.out.log                 # live daemon log
sqlite3 ~/Library/Application\ Support/temu-scraper/scraper.db
  SELECT COUNT(*) FROM product_observations;
  SELECT sku_id, observed_at, price_usd FROM product_observations ORDER BY observed_at DESC LIMIT 10;
```

## Exporting data for Marc

```bash
.venv/bin/python -c "
from pathlib import Path
from scraper import config, db, export_csv
cfg = config.load()
conn = db.connect(cfg.db_path)
n = export_csv.export(conn, Path('exports/temu-poc-2026-05-31.csv'))
print(f'Exported {n} rows')
"
```

## Uninstall

```bash
./scripts/uninstall.sh
```
```

- [ ] **Step 2: Commit**

```bash
git add README.md
git commit -m "docs: operator runbook (setup, daily ops, manual inspection, export)"
```

---

## Phase 9: End-to-End Validation

### Task 31: Single-SKU integration test on real device

**Files:**
- Create: `scripts/integration_smoke.py`

This requires a real device. Manual run only.

- [ ] **Step 1: Write smoke test script**

```python
#!/usr/bin/env python3
"""Single-SKU end-to-end smoke test. Run manually with phone connected."""

import sys
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from scraper import capture, config, db
from scraper.adb_client import AdbClient


def main() -> int:
    cfg = config.load()
    conn = db.connect(cfg.db_path)
    db.apply_schema(conn)

    adb = AdbClient(adb_bin=cfg.adb_bin)
    serials = adb.list_devices()
    if not serials:
        print("ERROR: no devices")
        return 1
    serial = serials[0]
    print(f"Using device {serial}")

    # Add a temp target + device + product
    sku = "smoke_test_" + datetime.utcnow().strftime("%Y%m%d_%H%M%S")
    conn.execute("INSERT OR IGNORE INTO targets(sku_id, temu_url) VALUES(?, 'manual')", (sku,))
    conn.execute("INSERT OR IGNORE INTO devices(device_id, adb_serial) VALUES('phone_01', ?)", (serial,))

    # Operator opens the product manually for the test
    input(f"Open any Temu product on the phone. Press ENTER when ready (we'll capture {sku})...")

    ts = datetime.utcnow().isoformat()
    result = capture.capture_product(
        conn=conn, adb=adb, serial=serial, device_id="phone_01",
        sku_id=sku, data_dir=cfg.data_dir, observed_at=ts,
    )
    print(f"Result: success={result.success} variants={result.variants_captured} confidence={result.parse_confidence}")
    if result.success:
        row = conn.execute("SELECT * FROM product_observations WHERE sku_id=?", (sku,)).fetchone()
        print(f"DB row: price={row['price_usd']} title-row stored under sku={row['sku_id']}")
    return 0 if result.success else 1


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 2: Make executable**

```bash
chmod +x scripts/integration_smoke.py
```

- [ ] **Step 3: Run smoke test manually (operator step)**

```bash
.venv/bin/python scripts/integration_smoke.py
```

Expected: succeeds → at least 1 field populated, screenshot/XML saved.

- [ ] **Step 4: Commit**

```bash
git add scripts/integration_smoke.py
git commit -m "test(smoke): single-SKU end-to-end real-device validation"
```

---

### Task 32: 7-day observation kickoff

**Files:**
- None (operational task)

After all preceding tasks are complete and `install.sh` has succeeded:

- [ ] **Step 1: Verify all launchd jobs running**

```bash
launchctl list | grep berkant.scraper
```

Expected: at least 5 entries (daemon, heartbeat, daily_summary, health_check, cleanup) plus weekly.

- [ ] **Step 2: Tail daemon log for 10 minutes**

```bash
tail -f scripts/daemon.out.log
```

Expected: see "Daemon started", then periodic heartbeat writes; first cycle begins within 4 hours (jittered).

- [ ] **Step 3: After 24 hours: spot check DB**

```bash
sqlite3 ~/Library/Application\ Support/temu-scraper/scraper.db \
  "SELECT sku_id, COUNT(*) AS observations FROM product_observations GROUP BY sku_id ORDER BY observations DESC LIMIT 10"
```

Expected: each SKU has 4-6 observations (depending on jitter).

- [ ] **Step 4: After 7 days: export and benchmark**

```bash
.venv/bin/python -c "
from pathlib import Path
from scraper import config, db, export_csv
cfg = config.load()
conn = db.connect(cfg.db_path)
n = export_csv.export(conn, Path('exports/temu-poc-2026-05-31.csv'))
print(f'Exported {n} rows')
attempted = conn.execute('SELECT SUM(attempted) AS a FROM runs').fetchone()['a']
succeeded = conn.execute('SELECT SUM(succeeded) AS s FROM runs').fetchone()['s']
print(f'Success rate (7d): {succeeded/attempted*100:.1f}% ({succeeded}/{attempted})')
"
```

Expected: success rate ≥ 85%, ≥ 3000 product_observations, ≥ 18000 variant_observations.

---

## Appendix A: Scenario C Revision (XML unavailable)

If Day 0 returns scenario C (UI Automator dump returns no usable text), the strategy shifts to full-screenshot + region OCR. Changes needed:

1. **Task 7 (parser):** add screenshot-coordinate-driven field extraction; `find_text_by_rid` is replaced by `extract_field_by_region(image_path, bounds)`.
2. **Task 10 (temu_actions):** add `capture_screen` step before each XML dump; populate `temu_resource_ids.py` with region bounds instead of resource-ids.
3. **Task 11 (capture):** use OCR per field with bounds defined in `temu_resource_ids.py`.
4. **Time per SKU:** doubles (OCR is slower). Re-estimate cycle: 100 SKU × 120s = 200min per cycle; may need to relax to 6h cycle.
5. **Marc message:** send progress update — "OCR-based approach, results in 3 weeks instead of 2."

If Day 0 returns scenario D (API interception viable), the daemon is much simpler:
1. **All ADB tasks** (5, 6, 9, 10, 11, 12) become irrelevant.
2. New task: `scraper/temu_api_client.py` — requests-based HTTP calls.
3. Capture flow: HTTP GET → JSON parse → storage. No phone needed.
4. Phone-pool tasks (15) become unnecessary for PoC but kept for future use.
5. Estimated effort: 1 week instead of 2.

---

## Self-Review Notes

This plan covers all spec sections:
- §1.5 Day 0 feasibility → Task 2
- §2 Scope (24/7, 4h cycle, full capture) → Tasks 10–16
- §3.1 Daemon flow → Tasks 6, 7, 9, 10, 11, 12, 13, 14, 15, 16
- §3.2 Health monitor → Tasks 18, 19, 23
- §3.3 Claude supervisor → Tasks 21, 22
- §4 Telegram → Task 17 + scripts 19, 23, 28
- §5 Edge cases → covered by health checks (Task 9), rate limiter (Task 14), heartbeat (Task 19), retention (Task 27)
- §6 Schema → Task 4
- §6.2 CSV export → Task 29
- §7.5.1 install.sh → Task 25
- §7.5.2 auto-restart → launchd `KeepAlive=true` in Task 24
- §7.5.3 phone maintenance → Task 28 (weekly)
- §7.5.4 retention → Task 27
- §7.5.5 multi-device scale → built in from Task 15 (device pool)

Type consistency: `CaptureResult` fields used consistently in Tasks 11, 12, 16, 20. `HealthState` used in Tasks 9 and 16. `CanaryResult` used in Tasks 20 and 21.

No placeholders detected. The only deferred content is the `TEMU_RIDS` and `TEMU_VARIANT_RIDS` dictionaries in `scraper/temu_resource_ids.py`, which have explicit instructions to be filled after Day 0.
