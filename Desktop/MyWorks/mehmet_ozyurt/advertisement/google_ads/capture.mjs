import puppeteer from 'puppeteer-core';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const config = JSON.parse(fs.readFileSync(path.join(__dirname, 'config.json'), 'utf-8'));
const outputDir = path.join(__dirname, config.output_dir);
if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true });

// Single ad mode: node capture.mjs --id 5
const singleId = process.argv.includes('--id')
  ? parseInt(process.argv[process.argv.indexOf('--id') + 1])
  : null;

const adsToRender = singleId
  ? config.ads.filter(a => a.id === singleId)
  : config.ads;

if (adsToRender.length === 0) {
  console.error(`Ad ID ${singleId} not found.`);
  process.exit(1);
}

function validateAssets() {
  const missing = [];
  for (const ad of adsToRender) {
    const assets = ad.assets || {};
    for (const [key, val] of Object.entries(assets)) {
      if (key === 'extras' && Array.isArray(val)) {
        val.forEach(p => {
          const full = path.join(__dirname, config.base_asset_path, p);
          if (!fs.existsSync(full)) missing.push(`Ad ${ad.id}: ${p}`);
        });
      } else if (typeof val === 'string') {
        const full = val.startsWith('../../')
          ? path.join(__dirname, val)
          : path.join(__dirname, config.base_asset_path, val);
        if (!fs.existsSync(full)) missing.push(`Ad ${ad.id}: ${val}`);
      }
    }
  }
  if (missing.length > 0) {
    console.error('MISSING ASSETS:');
    missing.forEach(m => console.error(`  - ${m}`));
    process.exit(1);
  }
  console.log(`Asset validation OK (${adsToRender.length} ads)`);
}

const templateMap = {
  square: 'templates/square.html',
  portrait: 'templates/portrait.html',
  landscape: 'templates/landscape.html',
};

async function run() {
  validateAssets();

  const browser = await puppeteer.launch({
    executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    headless: true,
    args: ['--no-sandbox', '--disable-gpu', '--hide-scrollbars'],
  });

  const results = [];

  for (const ad of adsToRender) {
    const page = await browser.newPage();
    await page.setViewport({ width: ad.width, height: ad.height, deviceScaleFactor: 1 });

    const htmlPath = path.join(__dirname, templateMap[ad.template]);
    await page.goto(`file://${htmlPath}#ad=${ad.id}`, { waitUntil: 'networkidle0' });

    // Wait for fonts
    await page.waitForFunction(() => document.fonts.ready.then(() => true), { timeout: 5000 }).catch(() => {});
    await new Promise(r => setTimeout(r, 500));

    const outputPath = path.join(outputDir, `${ad.output_name}.png`);
    await page.screenshot({
      path: outputPath,
      clip: { x: 0, y: 0, width: ad.width, height: ad.height },
    });

    const stats = fs.statSync(outputPath);
    const sizeKB = Math.round(stats.size / 1024);
    const status = sizeKB > 500 ? 'ERROR' : sizeKB > 150 ? 'WARN' : 'OK';
    results.push({ id: ad.id, name: ad.output_name, sizeKB, status, width: ad.width, height: ad.height });

    console.log(`[${status}] Ad ${ad.id}: ${ad.output_name}.png (${sizeKB}KB)`);
    await page.close();
  }

  await browser.close();

  console.log('\n=== REPORT ===');
  console.log(`Total: ${results.length} visuals`);
  console.log(`OK: ${results.filter(r => r.status === 'OK').length}`);
  console.log(`WARN (>150KB): ${results.filter(r => r.status === 'WARN').length}`);
  console.log(`ERROR (>500KB): ${results.filter(r => r.status === 'ERROR').length}`);

  generatePreview(results);
}

function generatePreview(results) {
  const cards = config.ads.map(ad => {
    const r = results.find(r => r.id === ad.id);
    const sizeInfo = r ? `${r.sizeKB}KB — ${r.status}` : 'Not rendered';
    return `
    <div class="card">
      <img src="output/${ad.output_name}.png" alt="Ad ${ad.id}">
      <div class="info">
        <strong>#${ad.id}</strong> ${ad.output_name}<br>
        ${ad.width}x${ad.height} | ${ad.lang} | ${sizeInfo}
      </div>
    </div>`;
  }).join('\n');

  const html = `<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>TabuL Google Ads — Preview</title>
<style>
  body { font-family: system-ui; background: #1a1a2e; color: #fff; padding: 20px; }
  h1 { text-align: center; margin-bottom: 20px; }
  .grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; }
  .card { background: #16213e; border-radius: 12px; overflow: hidden; }
  .card img { width: 100%; display: block; }
  .info { padding: 10px; font-size: 12px; line-height: 1.5; }
</style></head>
<body>
  <h1>TabuL Google Ads — Preview (${results.length} visuals)</h1>
  <div class="grid">${cards}</div>
</body></html>`;

  fs.writeFileSync(path.join(__dirname, 'preview.html'), html);
  console.log('Preview: google_ads/preview.html');
}

run().catch(console.error);
