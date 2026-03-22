import puppeteer from 'puppeteer-core';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const outputDir = path.join(__dirname, 'output14');
if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true });
const templateMap = { square: 'templates/square_v14.html', portrait: 'templates/portrait_v14.html', landscape: 'templates/landscape_v14.html' };
const ads = [
  { id: 1, template: 'square', width: 1080, height: 1080, output_name: '01_square_en_v14' },
  { id: 2, template: 'square', width: 1080, height: 1080, output_name: '02_square_tr_v14' },
  { id: 3, template: 'square', width: 1080, height: 1080, output_name: '03_square_de_v14' },
  { id: 4, template: 'square', width: 1080, height: 1080, output_name: '04_square_es_v14' },
  { id: 5, template: 'square', width: 1080, height: 1080, output_name: '05_square_fr_v14' },
  { id: 6, template: 'square', width: 1080, height: 1080, output_name: '06_square_it_v14' },
  { id: 7, template: 'square', width: 1080, height: 1080, output_name: '07_square_pt_v14' },
  { id: 8, template: 'square', width: 1080, height: 1080, output_name: '08_square_global_v14' },
  { id: 9, template: 'portrait', width: 1080, height: 1350, output_name: '09_portrait_en_v14' },
  { id: 10, template: 'portrait', width: 1080, height: 1350, output_name: '10_portrait_tr_v14' },
  { id: 11, template: 'portrait', width: 1080, height: 1350, output_name: '11_portrait_global_v14' },
  { id: 12, template: 'portrait', width: 1080, height: 1350, output_name: '12_portrait_en_v14' },
  { id: 13, template: 'portrait', width: 1080, height: 1350, output_name: '13_portrait_global_v14' },
  { id: 14, template: 'portrait', width: 1080, height: 1350, output_name: '14_portrait_en_v14' },
  { id: 15, template: 'landscape', width: 1200, height: 628, output_name: '15_landscape_tr_v14' },
  { id: 16, template: 'landscape', width: 1200, height: 628, output_name: '16_landscape_en_v14' },
  { id: 17, template: 'landscape', width: 1200, height: 628, output_name: '17_landscape_global_v14' },
  { id: 18, template: 'landscape', width: 1200, height: 628, output_name: '18_landscape_en_v14' },
  { id: 19, template: 'landscape', width: 1200, height: 628, output_name: '19_landscape_global_v14' },
  { id: 20, template: 'landscape', width: 1200, height: 628, output_name: '20_landscape_global_v14' },
];
async function run() {
  const browser = await puppeteer.launch({ executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome', headless: true, args: ['--no-sandbox', '--disable-gpu', '--hide-scrollbars'] });
  for (const ad of ads) {
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
  console.log(`\nDone! ${ads.length} ads rendered to ${outputDir}`);
}
run().catch(console.error);
