#!/usr/bin/env node
// Qulo Reels TR — AI sticker üretimi (Gemini gemini-3-pro-image / Nano Banana Pro).
// Kullanım:
//   node tools/generate-assets.mjs --list            # asset id'lerini göster
//   node tools/generate-assets.mjs w1_hook m1        # seçili asset'leri üret
//   node tools/generate-assets.mjs --all             # hepsini üret (referanslılar, referansları hazırsa)
//   ... [--keep-bg]  arka planı temizleme (debug)
//   ... [--dry-run]  API'ye gitmeden isteği özetle
import {readFileSync, writeFileSync, existsSync} from 'node:fs';
import {PNG} from 'pngjs';
import {MANIFEST, STYLE_SUFFIX} from './assets.manifest.mjs';

const API =
  'https://generativelanguage.googleapis.com/v1beta/models/gemini-3-pro-image:generateContent';

const args = process.argv.slice(2);
const flags = new Set(args.filter((a) => a.startsWith('--')));
const ids = args.filter((a) => !a.startsWith('--'));

if (flags.has('--list')) {
  for (const a of MANIFEST) {
    console.log(`${a.id}${a.referenceOf ? ` (ref: ${a.referenceOf})` : ''}`);
  }
  process.exit(0);
}

const KEY = process.env.GEMINI_API_KEY;
if (!KEY && !flags.has('--dry-run')) {
  console.error(
    'HATA: GEMINI_API_KEY tanımlı değil.\n' +
      'aistudio.google.com/api-keys üzerinden key alıp şu şekilde çalıştır:\n' +
      '  GEMINI_API_KEY="..." node tools/generate-assets.mjs --all',
  );
  process.exit(1);
}

const selected = flags.has('--all')
  ? MANIFEST
  : MANIFEST.filter((a) => ids.includes(a.id));
if (selected.length === 0) {
  console.error('Asset seçilmedi. --list ile id\'leri gör.');
  process.exit(1);
}

// Kenarlardan flood-fill: yeşile yakın piksellerin alpha'sını sıfırla.
// Sadece kenarlardan erişilebilen yeşil alan silinir; figür içi korunur.
const isGreen = (data, i) =>
  data[i + 1] > 140 && data[i + 1] > data[i] * 1.6 && data[i + 1] > data[i + 2] * 1.6;

const removeBackground = (buf) => {
  const png = PNG.sync.read(buf);
  const {width, height, data} = png;
  const visited = new Uint8Array(width * height);
  const queue = [];
  for (let x = 0; x < width; x++) {
    queue.push(x, x + (height - 1) * width);
  }
  for (let y = 0; y < height; y++) {
    queue.push(y * width, width - 1 + y * width);
  }
  while (queue.length > 0) {
    const p = queue.pop();
    if (visited[p]) continue;
    visited[p] = 1;
    const i = p * 4;
    if (!isGreen(data, i)) continue;
    data[i + 3] = 0;
    const x = p % width;
    const y = (p / width) | 0;
    if (x > 0) queue.push(p - 1);
    if (x < width - 1) queue.push(p + 1);
    if (y > 0) queue.push(p - width);
    if (y < height - 1) queue.push(p + width);
  }
  // Kontur kenarındaki yeşil sızıntıyı yumuşat: şeffaf komşusu olan yeşilimsi pikselleri de sil.
  for (let p = 0; p < width * height; p++) {
    const i = p * 4;
    if (data[i + 3] === 0) continue;
    const x = p % width;
    const y = (p / width) | 0;
    const neighbors = [p - 1, p + 1, p - width, p + width].filter(
      (n) => n >= 0 && n < width * height && Math.abs((n % width) - x) <= 1,
    );
    const nearTransparent = neighbors.some((n) => data[n * 4 + 3] === 0);
    if (nearTransparent && data[i + 1] > data[i] * 1.2 && data[i + 1] > data[i + 2] * 1.2) {
      data[i + 3] = 0;
    }
  }
  return PNG.sync.write(png);
};

const generateOne = async (asset) => {
  const parts = [];
  if (asset.referenceOf) {
    const refPath = `tools/raw/${asset.referenceOf}.png`;
    if (!existsSync(refPath)) {
      throw new Error(`Referans bulunamadı: ${refPath} — önce ${asset.referenceOf} üret.`);
    }
    parts.push({
      inlineData: {mimeType: 'image/png', data: readFileSync(refPath).toString('base64')},
    });
  }
  parts.push({text: asset.prompt + STYLE_SUFFIX});

  const body = {
    contents: [{parts}],
    generationConfig: {
      responseModalities: ['IMAGE'],
      imageConfig: {aspectRatio: asset.aspectRatio, imageSize: '2K'},
    },
  };

  if (flags.has('--dry-run')) {
    console.log(`[dry-run] ${asset.id}: aspect=${asset.aspectRatio} ref=${asset.referenceOf ?? '-'}`);
    console.log(`  prompt: ${asset.prompt.slice(0, 100)}…`);
    return;
  }

  console.log(`Üretiliyor: ${asset.id} …`);
  const res = await fetch(API, {
    method: 'POST',
    headers: {'Content-Type': 'application/json', 'X-goog-api-key': KEY},
    body: JSON.stringify(body),
  });
  const json = await res.json();
  if (json.error) {
    throw new Error(`${asset.id}: API ${json.error.code} — ${json.error.message.slice(0, 200)}`);
  }
  const img = json.candidates?.[0]?.content?.parts?.find((p) => p.inlineData);
  if (!img) {
    throw new Error(`${asset.id}: yanıt içinde görsel yok.`);
  }
  const raw = Buffer.from(img.inlineData.data, 'base64');
  writeFileSync(`tools/raw/${asset.id}.png`, raw);
  const out = flags.has('--keep-bg') ? raw : removeBackground(raw);
  writeFileSync(`public/ai/${asset.id}.png`, out);
  console.log(`  ✓ tools/raw/${asset.id}.png + public/ai/${asset.id}.png (${(out.length / 1024) | 0} KB)`);
};

const failed = [];
for (const asset of selected) {
  try {
    await generateOne(asset);
  } catch (e) {
    failed.push(asset.id);
    console.error(`  ✗ ${e.message}`);
  }
}
if (failed.length > 0) {
  console.error(`\nBaşarısız: ${failed.join(', ')} — aynı id'lerle tekrar çalıştırılabilir.`);
  process.exit(1);
}
console.log('\nTamamlandı. Görselleri gözden geçirip beğenmediklerini aynı id ile yeniden üret.');
