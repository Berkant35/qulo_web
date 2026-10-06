import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, readdirSync } from 'node:fs';

const DIR = new URL('../src/lib/i18n/dictionaries/', import.meta.url);
const files = readdirSync(DIR).filter((f) => f.endsWith('.json'));
const load = (f) => JSON.parse(readFileSync(new URL(f, DIR), 'utf8'));

test('18 sözlüğün privacyPolicy anahtarları en ile birebir aynı ve boş değil', () => {
  assert.equal(files.length, 18);
  const enKeys = Object.keys(load('en.json').privacyPolicy).sort();
  for (const f of files) {
    const pp = load(f).privacyPolicy;
    assert.deepEqual(Object.keys(pp).sort(), enKeys, `${f} anahtar seti farklı`);
    for (const [k, v] of Object.entries(pp)) assert.ok(String(v).trim().length > 0, `${f}.${k} boş`);
  }
});

test('eşleşme tercihi bölümü (KVKK m.6) her dilde var', () => {
  for (const f of files) {
    const pp = load(f).privacyPolicy;
    assert.ok(pp.matchPreferenceTitle && pp.matchPreference, `${f} matchPreference bölümü eksik`);
    assert.ok(pp.matchPreference.includes('2026-10-v1'), `${f} rıza kaydı sürümü (2026-10-v1) eksik`);
  }
});

test('profil etiketleri bölümü (identityLabels) her dilde var ve identity_labels sürümünü taşır', () => {
  for (const f of files) {
    const pp = load(f).privacyPolicy;
    assert.ok(pp.identityLabelsTitle && pp.identityLabels, `${f} identityLabels bölümü eksik`);
    assert.ok(pp.identityLabels.includes('2026-10-v1'), `${f} sürüm etiketi yok`);
  }
});
