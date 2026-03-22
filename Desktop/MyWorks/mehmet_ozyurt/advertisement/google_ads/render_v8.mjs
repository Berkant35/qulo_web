import puppeteer from 'puppeteer-core';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const config = JSON.parse(fs.readFileSync(path.join(__dirname, 'config.json'), 'utf-8'));
const outputDir = path.join(__dirname, 'output8');
if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true });
const templateMap = { square: 'templates/square_v8.html', portrait: 'templates/portrait_v8.html', landscape: 'templates/landscape_v8.html' };
async function run() {
  const browser = await puppeteer.launch({ executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome', headless: true, args: ['--no-sandbox', '--disable-gpu', '--hide-scrollbars'] });
  for (const ad of config.ads) {
    const page = await browser.newPage();
    await page.setViewport({ width: ad.width, height: ad.height, deviceScaleFactor: 1 });
    await page.goto(`file://${path.join(__dirname, templateMap[ad.template])}#ad=${ad.id}`, { waitUntil: 'networkidle0' });
    await page.waitForFunction(() => document.fonts.ready.then(() => true), { timeout: 5000 }).catch(() => {});
    await new Promise(r => setTimeout(r, 500));
    await page.screenshot({ path: path.join(outputDir, `${ad.output_name}.png`), clip: { x: 0, y: 0, width: ad.width, height: ad.height } });
    const sizeKB = Math.round(fs.statSync(path.join(outputDir, `${ad.output_name}.png`)).size / 1024);
    console.log(`[${sizeKB > 500 ? 'ERROR' : sizeKB > 150 ? 'WARN' : 'OK'}] Ad ${ad.id}: ${ad.output_name}.png (${sizeKB}KB)`);
    await page.close();
  }
  await browser.close();
}
run().catch(console.error);
