# Qulo Instagram Reels Reklamı (Retro Kolaj, TR, 9:16) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** AI-üretimli (Gemini `gemini-3-pro-image`) retro kolaj sticker'larını config-driven Remotion oynatıcısıyla birleştirip ~25 saniyelik, Türkçe, 1080×1920 Instagram Reels reklam MP4'ü ve kapak görselleri üretmek.

**Architecture:** `entertainment/qulo-twitter-tr` projesindeki kanıtlanmış pattern (theme token + `SceneSpec` config + `<Sequence>` oynatıcı) yeni izole kardeş proje `entertainment/qulo-reels-tr/`'de 9:16'ya uyarlanır. AI asset'ler `tools/generate-assets.mjs` script'iyle üretilir (düz yeşil fonda sticker → flood-fill ile şeffaf PNG), kullanıcı onayından sonra sahnelere bağlanır. 5 sahne (Hook → Kurallar → Eleme → Eşleşme → Kapanış) `QuloReelsAd` composition'ında config'ten okunur. Grafik şekiller (halftone, daire, yırtık şerit) SVG/CSS ile Remotion'da çizilir.

**Tech Stack:** Remotion 4.x, React 19, TypeScript, `@remotion/google-fonts` (Poppins), Gemini API (`gemini-3-pro-image`, REST), `pngjs` (arka plan temizleme). Render: Remotion headless-Chrome → ffmpeg H.264.

## Global Constraints

- **Format:** 9:16, **1080×1920**, 30fps, H.264 MP4. Süre **750 frame (25.0 sn)**.
- **Sahne frame aralıkları (config'te sabit):** S1 0–90, S2 90–270, S3 270–510, S4 510–660, S5 660–750.
- **Dil:** Tüm ekran metinleri Türkçe. İngilizce ekran metni YASAK.
- **Elmas görseli YASAK.** Kutlama = yeşil spark/konfeti şekiller.
- **AI görsellerde metin/harf/logo/watermark/UI YASAK** — prompt'lara gömülü; tüm yazı Remotion'dan.
- **İnsanlar:** modern giyim/saç, çekici, tamamen giyinik, policy-güvenli; figürler siyah-beyaz fotoğraf + kalın beyaz kontur (sticker), kıyafatte yeşil renk YASAK (chroma temizliği için).
- **Renkler (theme token):** bg `#0D0D0D`, green `#69F0AE`, purple `#BB86FC`, danger `#CF6679`, text `#FFFFFF`, paper `#F2EDE4`.
- **Font:** Poppins (`@remotion/google-fonts/Poppins`); ı/İ/ç/ğ/ş/ö/ü still'lerde görsel kontrol edilir.
- **Reels güvenli bölge:** alt 260px + üst 140px + yatay 70px — kritik metin/figür bu alanlara taşmaz (`theme.safeZone`).
- **Kapanış mottosu (locked):** "Doğru soru, doğru insan."
- **Mevcut projelere dokunulmaz:** `qulo-twitter-tr`, `qulo-tiktok-promos`, `qulo-stop-swiping` sadece okunur/kopya kaynağıdır.
- **`GEMINI_API_KEY`** env'den okunur; hiçbir dosyaya/commit'e key yazılmaz.
- **Doğrulama döngüsü (her sahne task'ında):** `npx tsc --noEmit` → `npx remotion still` anahtar frame PNG → PNG'yi gözle kontrol → commit. Klasik unit test bu medyum için uygun değil; bu üçlü dürüst doğrulamadır.
- **Git notu:** monorepo git kökü ev dizini olduğu için git komutları yavaş — Bash çağrılarında timeout ≥300000 ms kullan; `index.lock` hatasında önce sürecin bitmesini bekle.

---

### Task 1: Proje iskeleti + tema + config-driven oynatıcı (Placeholder ile)

**Files:**
- Create: `entertainment/qulo-reels-tr/package.json`
- Create: `entertainment/qulo-reels-tr/tsconfig.json`
- Create: `entertainment/qulo-reels-tr/.gitignore`
- Create: `entertainment/qulo-reels-tr/remotion.config.ts`
- Create: `entertainment/qulo-reels-tr/src/theme.ts`
- Create: `entertainment/qulo-reels-tr/src/types.ts`
- Create: `entertainment/qulo-reels-tr/src/index.ts`
- Create: `entertainment/qulo-reels-tr/src/Root.tsx`
- Create: `entertainment/qulo-reels-tr/src/QuloReelsAd.tsx`
- Create: `entertainment/qulo-reels-tr/src/configs/reels-tr.config.ts`
- Create: `entertainment/qulo-reels-tr/src/scenes/Placeholder.tsx`
- Create: `entertainment/qulo-reels-tr/public/brand/qulo_logo.svg` (kopya)

**Interfaces:**
- Produces:
  - `theme` — `theme.composition = {width:1080, height:1920, fps:30}`, `theme.colors` (paper dahil), `theme.fonts`, `theme.type = {hook:84, title:64, body:42, small:28, weight:800}`, `theme.safeZone = {top:140, bottom:260, horizontal:70}`, `theme.radius`.
  - `type SceneComponent` (union; başlangıçta `'Placeholder'`, sonraki task'larda sahne adları eklenir)
  - `type SceneSpec = {component: SceneComponent; startFrame: number; durationFrames: number; props?: Record<string, unknown>}`
  - `type AudioTrack = {path: string; volume?: number; startFrom?: number; startFrame?: number}`
  - `type ReelsConfig = {durationInFrames: number; scenes: SceneSpec[]; audioTracks?: AudioTrack[]}`
  - `reelsConfig: ReelsConfig` — `configs/reels-tr.config.ts`
  - `QuloReelsAd` component; Composition id: `QuloReelsAd`.

- [ ] **Step 1: Dizinleri oluştur, logoyu kopyala**

```bash
cd entertainment && mkdir -p qulo-reels-tr/public/brand qulo-reels-tr/public/ai qulo-reels-tr/public/audio qulo-reels-tr/out qulo-reels-tr/src/scenes qulo-reels-tr/src/components qulo-reels-tr/src/configs qulo-reels-tr/tools/raw qulo-reels-tr/prompts
cp qulo-twitter-tr/public/brand/qulo_logo.svg qulo-reels-tr/public/brand/qulo_logo.svg
ls qulo-reels-tr/public/brand/
```
Expected: `qulo_logo.svg` listelenir.

- [ ] **Step 2: package.json, tsconfig.json, .gitignore, remotion.config.ts yaz**

`entertainment/qulo-reels-tr/package.json`:
```json
{
  "name": "qulo-reels-tr",
  "version": "1.0.0",
  "private": true,
  "description": "Qulo Türkçe Instagram Reels reklamı — 9:16, 25sn, retro kolaj.",
  "scripts": {
    "studio": "remotion studio src/index.ts",
    "compositions": "remotion compositions src/index.ts",
    "render": "remotion render src/index.ts QuloReelsAd out/qulo-reels-tr-25s-9x16.mp4",
    "still": "remotion still src/index.ts QuloReelsAd",
    "assets": "node tools/generate-assets.mjs",
    "typecheck": "tsc --noEmit"
  },
  "license": "UNLICENSED",
  "dependencies": {
    "@remotion/cli": "^4.0.437",
    "@remotion/google-fonts": "^4.0.437",
    "@remotion/media": "^4.0.437",
    "react": "^19.2.4",
    "react-dom": "^19.2.4",
    "remotion": "^4.0.437"
  },
  "devDependencies": {
    "@types/react": "^19.2.14",
    "@types/react-dom": "^19.2.3",
    "pngjs": "^7.0.0",
    "typescript": "^5.9.3"
  }
}
```

`entertainment/qulo-reels-tr/tsconfig.json` — `qulo-twitter-tr/tsconfig.json` ile birebir aynı içerik (target ES2022, jsx react-jsx, strict, include `src/**/*` + `remotion.config.ts`).

`entertainment/qulo-reels-tr/.gitignore`:
```
node_modules
out
*.mp4
.DS_Store
public/audio
tools/raw
```

`entertainment/qulo-reels-tr/remotion.config.ts`:
```ts
import {Config} from '@remotion/cli/config';

Config.setVideoImageFormat('jpeg');
Config.setOverwriteOutput(true);
```

- [ ] **Step 3: theme.ts yaz**

`entertainment/qulo-reels-tr/src/theme.ts`:
```ts
import {loadFont} from '@remotion/google-fonts/Poppins';

const {fontFamily: poppins} = loadFont('normal', {
  weights: ['400', '500', '600', '700', '800', '900'],
});

export const theme = {
  colors: {
    bg: '#0D0D0D',
    bgAlt: '#1A1A1A',
    surface: '#1A1A1A',
    surfaceElevated: '#242424',
    green: '#69F0AE',
    greenDark: '#4CAF50',
    purple: '#BB86FC',
    danger: '#CF6679',
    text: '#FFFFFF',
    textMuted: '#B0B0B0',
    textHint: '#666666',
    border: '#2A2A2A',
    paper: '#F2EDE4',
    paperInk: '#171717',
  },
  fonts: {
    display: `${poppins}, "SF Pro Display", system-ui, sans-serif`,
    body: `${poppins}, "SF Pro Text", system-ui, sans-serif`,
  },
  type: {
    hook: 84,
    title: 64,
    body: 42,
    small: 28,
    weight: 800,
  },
  safeZone: {
    top: 140,
    bottom: 260,
    horizontal: 70,
  },
  radius: {sm: 10, md: 16, lg: 24, xl: 36, pill: 999},
  composition: {
    width: 1080,
    height: 1920,
    fps: 30,
  },
} as const;

export type Theme = typeof theme;
```

- [ ] **Step 4: types.ts, config, oynatıcı, Placeholder, Root, index yaz**

`entertainment/qulo-reels-tr/src/types.ts`:
```ts
export type SceneComponent = 'Placeholder';

export type SceneSpec = {
  component: SceneComponent;
  startFrame: number;
  durationFrames: number;
  props?: Record<string, unknown>;
};

export type AudioTrack = {
  path: string;
  volume?: number;
  startFrom?: number;
  startFrame?: number;
};

export type ReelsConfig = {
  durationInFrames: number;
  scenes: SceneSpec[];
  audioTracks?: AudioTrack[];
};
```

`entertainment/qulo-reels-tr/src/configs/reels-tr.config.ts`:
```ts
import type {ReelsConfig} from '../types';

const FPS = 30;
export const s = (seconds: number) => Math.round(seconds * FPS);

export const reelsConfig: ReelsConfig = {
  durationInFrames: s(25),
  scenes: [
    {component: 'Placeholder', startFrame: s(0), durationFrames: s(25)},
  ],
  audioTracks: [],
};
```

`entertainment/qulo-reels-tr/src/scenes/Placeholder.tsx`:
```tsx
import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';

export const Placeholder: React.FC = () => (
  <AbsoluteFill
    style={{
      background: theme.colors.bg,
      justifyContent: 'center',
      alignItems: 'center',
      fontFamily: theme.fonts.display,
      fontSize: theme.type.title,
      color: theme.colors.textMuted,
    }}
  >
    Sahne bekleniyor…
  </AbsoluteFill>
);
```

`entertainment/qulo-reels-tr/src/QuloReelsAd.tsx`:
```tsx
import {AbsoluteFill, Audio, Sequence, staticFile} from 'remotion';
import {theme} from './theme';
import {reelsConfig} from './configs/reels-tr.config';
import type {SceneSpec} from './types';
import {Placeholder} from './scenes/Placeholder';

const renderScene = (scene: SceneSpec, idx: number) => {
  switch (scene.component) {
    case 'Placeholder':
      return <Placeholder />;
    default:
      throw new Error(`Unknown scene component at index ${idx}: ${scene.component}`);
  }
};

export const QuloReelsAd: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg}}>
      {reelsConfig.scenes.map((scene, i) => (
        <Sequence
          key={`${scene.component}-${i}-${scene.startFrame}`}
          from={scene.startFrame}
          durationInFrames={scene.durationFrames}
          name={`${i + 1}. ${scene.component}`}
        >
          {renderScene(scene, i)}
        </Sequence>
      ))}

      {reelsConfig.audioTracks?.map((track, i) => (
        <Sequence key={`audio-${i}`} from={track.startFrame ?? 0} name={`Audio ${i + 1}`}>
          <Audio src={staticFile(track.path)} volume={track.volume ?? 1} startFrom={track.startFrom ?? 0} />
        </Sequence>
      ))}
    </AbsoluteFill>
  );
};
```

`entertainment/qulo-reels-tr/src/Root.tsx`:
```tsx
import {Composition} from 'remotion';
import {QuloReelsAd} from './QuloReelsAd';
import {reelsConfig} from './configs/reels-tr.config';
import {theme} from './theme';

export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="QuloReelsAd"
      component={QuloReelsAd}
      durationInFrames={reelsConfig.durationInFrames}
      fps={theme.composition.fps}
      width={theme.composition.width}
      height={theme.composition.height}
    />
  );
};
```

`entertainment/qulo-reels-tr/src/index.ts`:
```ts
import {registerRoot} from 'remotion';
import {RemotionRoot} from './Root';

registerRoot(RemotionRoot);
```

- [ ] **Step 5: Kur ve doğrula**

```bash
cd entertainment/qulo-reels-tr && npm install && npx tsc --noEmit && npx remotion compositions src/index.ts
```
Expected: install hatasız; tsc sessiz; compositions çıktısında `QuloReelsAd 1080x1920 30fps 750 frames`.

```bash
cd entertainment/qulo-reels-tr && npx remotion still src/index.ts QuloReelsAd out/task1_placeholder.png --frame=10
```
Expected: PNG üretilir; koyu zeminde "Sahne bekleniyor…" yazısı. PNG'yi Read ile aç, gözle doğrula.

- [ ] **Step 6: Commit**

```bash
git add entertainment/qulo-reels-tr && git commit -m "feat(reels-ad): 9:16 Reels projesi iskeleti + config-driven oynatici"
```

---

### Task 2: AI asset üretim aracı (`tools/generate-assets.mjs` + manifest)

**Files:**
- Create: `entertainment/qulo-reels-tr/tools/assets.manifest.mjs`
- Create: `entertainment/qulo-reels-tr/tools/generate-assets.mjs`
- Create: `entertainment/qulo-reels-tr/prompts/characters.md` (dokümantasyon)

**Interfaces:**
- Consumes: `GEMINI_API_KEY` env değişkeni; `pngjs` (Task 1'de kuruldu).
- Produces:
  - CLI: `node tools/generate-assets.mjs --list | --all | <id...> [--keep-bg] [--dry-run]`
  - Ham çıktı: `tools/raw/<id>.png` (yeşil fonlu, git-ignored); temiz çıktı: `public/ai/<id>.png` (şeffaf PNG).
  - Manifest id'leri: `w1_hook`, `w1_point`, `m1`, `m2`, `m3` (Task 3'te üretilecek).

- [ ] **Step 1: Manifest yaz**

`entertainment/qulo-reels-tr/tools/assets.manifest.mjs`:
```js
// Her asset: id, prompt (kişiye özgü kısım), aspectRatio, referenceOf (opsiyonel — karakter tutarlılığı).
// STYLE_SUFFIX her prompt'un sonuna eklenir; kolaj sticker dilini ve yasakları sabitler.

export const STYLE_SUFFIX =
  ' Retro 1960s editorial magazine cut-out collage style with a modern twist: the person is MODERN, wearing contemporary 2020s fashion with a modern hairstyle. Black-and-white photographic figure, cut out as a sticker with a thick solid white contour outline tracing the silhouette. Full body visible head to shoes, photorealistic fashion-editorial quality, attractive and charismatic, fully clothed, tasteful. The figure is isolated on a solid pure green (#00FF00) background, nothing else in frame, figure does not touch image edges. No text, no letters, no numbers, no logos, no watermarks, no UI elements. Clothing must not contain any green colors.';

export const MANIFEST = [
  {
    id: 'w1_hook',
    aspectRatio: '2:3',
    prompt:
      'A very attractive stylish young woman in her mid-20s, confident power pose with one hand on her hip, slight knowing smile, chic tailored outfit, looking straight at the camera.',
  },
  {
    id: 'w1_point',
    aspectRatio: '2:3',
    referenceOf: 'w1_hook',
    prompt:
      'The SAME woman as in the reference image — identical face, identical hairstyle, identical outfit. She now holds a large marker pen raised as if writing on an invisible board, playful confident expression, body turned slightly sideways.',
  },
  {
    id: 'm1',
    aspectRatio: '2:3',
    prompt:
      'A handsome well-groomed young man in his late 20s, modern smart-casual outfit (open collar shirt, chinos), confident smile, mid-stride walking pose facing the camera.',
  },
  {
    id: 'm2',
    aspectRatio: '2:3',
    prompt:
      'A handsome athletic young man in his mid-20s, stylish modern streetwear (bomber jacket, sneakers), waving hello with one hand, friendly grin.',
  },
  {
    id: 'm3',
    aspectRatio: '2:3',
    prompt:
      'A very charming handsome young man in his late 20s, stylish modern casual blazer over a t-shirt, warm genuine smile, presenting a small bouquet of flowers towards the camera.',
  },
];
```

- [ ] **Step 2: generate-assets.mjs yaz**

`entertainment/qulo-reels-tr/tools/generate-assets.mjs`:
```js
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
```

- [ ] **Step 3: prompts/characters.md yaz (dokümantasyon)**

`entertainment/qulo-reels-tr/prompts/characters.md`:
```markdown
# Karakter Prompt'ları

Kaynak of truth: `tools/assets.manifest.mjs` (STYLE_SUFFIX + MANIFEST).
Üretim: `GEMINI_API_KEY="..." node tools/generate-assets.mjs --all`
Yeniden üretim: `node tools/generate-assets.mjs m2` (beğenilmeyen id).

- w1_hook — kadın, özgüvenli poz (S1, S3, S4)
- w1_point — aynı kadın, yazma jesti (S2) — w1_hook referanslı
- m1/m2/m3 — üç erkek aday (S3 eleme + m3 S4 eşleşme)

Kurallar: modern giyim, S/B fotoğraf + beyaz kontur, düz yeşil fon (#00FF00),
metin/logo/watermark yok, kıyafette yeşil yok, tamamen giyinik/policy-güvenli.
```

- [ ] **Step 4: Doğrula (API'siz)**

```bash
cd entertainment/qulo-reels-tr && node tools/generate-assets.mjs --list && node tools/generate-assets.mjs --all --dry-run && (unset GEMINI_API_KEY; node tools/generate-assets.mjs w1_hook; echo "exit:$?")
```
Expected: `--list` 5 id basar; `--dry-run` 5 asset özetler, API çağrısı yapmaz; key'siz çağrı "HATA: GEMINI_API_KEY tanımlı değil" + exit:1.

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-reels-tr/tools entertainment/qulo-reels-tr/prompts && git commit -m "feat(reels-ad): Gemini asset uretim araci (sticker + arka plan temizleme)"
```

---

### Task 3: AI asset'lerin üretimi + kullanıcı onay kapısı ⚠️ İNTERAKTİF

**Files:**
- Create: `entertainment/qulo-reels-tr/public/ai/w1_hook.png`, `w1_point.png`, `m1.png`, `m2.png`, `m3.png`

**Interfaces:**
- Consumes: Task 2 CLI'ı; `GEMINI_API_KEY` (kullanıcının ortamında tanımlı olmalı).
- Produces: Sahne task'larının kullanacağı 5 şeffaf PNG sticker (`public/ai/<id>.png`).

**Not:** Bu task kullanıcı onayı gerektirir — subagent'a delege EDİLMEZ, ana session'da koşulur. Görseller onaylanmadan sonraki sahne task'larında kullanılmaz. Her üretim ~$0.15-0.25 maliyetlidir; toplu yeniden üretimden kaçın, sadece reddedilen id'yi yeniden üret.

- [ ] **Step 1: Referanssız asset'leri üret** — `w1_hook m1 m2 m3`

```bash
cd entertainment/qulo-reels-tr && node tools/generate-assets.mjs w1_hook m1 m2 m3
```
Expected: 4 satır `✓`; `public/ai/` altında 4 şeffaf PNG.

- [ ] **Step 2: Referanslı asset'i üret** — `w1_point` (w1_hook hazır olduktan sonra)

```bash
cd entertainment/qulo-reels-tr && node tools/generate-assets.mjs w1_point
```
Expected: `✓ tools/raw/w1_point.png + public/ai/w1_point.png`.

- [ ] **Step 3: Görselleri kullanıcıya sun**

Her PNG'yi Read tool ile aç ve kontrol et: (a) arka plan gerçekten şeffaf mı (yeşil kalıntı yok), (b) beyaz kontur sağlam mı, (c) figür modern giyimli/çekici/policy-güvenli mi, (d) w1_point'teki kadın w1_hook'takiyle aynı kişi mi. Sonra kullanıcıya göster ve onay iste. Reddedilen id: `node tools/generate-assets.mjs <id>` ile yeniden üret, tekrar sun.

- [ ] **Step 4: Onaylı asset'leri commit'le**

```bash
git add entertainment/qulo-reels-tr/public/ai && git commit -m "feat(reels-ad): onayli AI sticker asset'leri (kadin 2 poz + 3 erkek)"
```

---

### Task 4: Kolaj bileşenleri (CollageSticker, CollageShapes, QuestionCard, StaggerText, MatchSpark)

**Files:**
- Create: `entertainment/qulo-reels-tr/src/components/CollageSticker.tsx`
- Create: `entertainment/qulo-reels-tr/src/components/CollageShapes.tsx`
- Create: `entertainment/qulo-reels-tr/src/components/QuestionCard.tsx`
- Create: `entertainment/qulo-reels-tr/src/components/StaggerText.tsx` (kopya)
- Create: `entertainment/qulo-reels-tr/src/components/MatchSpark.tsx`

**Interfaces:**
- Consumes: `theme`, `public/ai/*.png` (Task 3).
- Produces (sahne task'larının kullanacağı imzalar):
  - `CollageSticker: React.FC<{src: string; width: number; x: number; y: number; enterFrame?: number; baseRotate?: number; sway?: boolean; tearFrame?: number; flip?: boolean}>` — `x,y` sticker merkezinin koordinatı; `tearFrame` verilirse o frame'de yırtılıp düşer.
  - `CollageShapes: React.FC<{variant: 'hook' | 'rules' | 'elimination' | 'match'; enterFrame?: number}>` — dekoratif SVG/CSS katmanı.
  - `QuestionCard: React.FC<{text: string; x: number; y: number; width?: number; rotate?: number; enterFrame?: number; state?: 'neutral' | 'correct' | 'wrong'; stateFrame?: number}>` — kağıt kart; typewriter metin; tick/çarpı rozeti.
  - `StaggerText: React.FC<{lines: string[]; startFrame?: number; perLineFrames?: number; fontSize?: number; color?: string; accentColor?: string; align?: 'center' | 'left'}>` — `*kelime*` accent renkli.
  - `MatchSpark: React.FC<{startFrame?: number; label?: string}>`.

- [ ] **Step 1: StaggerText'i kopyala**

```bash
cp entertainment/qulo-twitter-tr/src/components/StaggerText.tsx entertainment/qulo-reels-tr/src/components/StaggerText.tsx
```
İçerik değişmez (theme'den okunduğu için 9:16'da da çalışır).

- [ ] **Step 2: CollageSticker.tsx yaz**

```tsx
import {Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';

type Props = {
  src: string;
  width: number;
  x: number;
  y: number;
  enterFrame?: number;
  baseRotate?: number;
  sway?: boolean;
  tearFrame?: number;
  flip?: boolean;
};

export const CollageSticker: React.FC<Props> = ({
  src,
  width,
  x,
  y,
  enterFrame = 0,
  baseRotate = 0,
  sway = true,
  tearFrame,
  flip = false,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - enterFrame;
  if (local < 0) return null;

  // Yapıştırma: büyükten küçülerek "şap" diye oturur.
  const scale = spring({frame: local, fps, from: 1.5, to: 1, config: {damping: 13, stiffness: 190}, durationInFrames: 14});
  const enterOpacity = interpolate(local, [0, 5], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const swayDeg = sway ? Math.sin(frame / 22) * 1.4 : 0;

  // Yırtılıp düşme.
  let fallY = 0;
  let fallRot = 0;
  let fallOpacity = 1;
  if (tearFrame !== undefined && frame >= tearFrame) {
    const t = frame - tearFrame;
    fallY = 1.9 * t * t;
    fallRot = t * 3.2;
    fallOpacity = interpolate(t, [18, 34], [1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  }

  return (
    <div
      style={{
        position: 'absolute',
        left: x - width / 2,
        top: y - width, // figürler ~2:3 → yükseklik ≈ width * 1.5; merkezleme sahnede x,y ile ayarlanır
        width,
        transform: `translateY(${fallY}px) rotate(${baseRotate + swayDeg + fallRot}deg) scale(${scale}) ${flip ? 'scaleX(-1)' : ''}`,
        opacity: enterOpacity * fallOpacity,
      }}
    >
      <Img
        src={staticFile(src)}
        style={{width: '100%', filter: 'drop-shadow(0 20px 34px rgba(0,0,0,0.5))'}}
      />
    </div>
  );
};
```

- [ ] **Step 3: CollageShapes.tsx yaz**

```tsx
import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Variant = 'hook' | 'rules' | 'elimination' | 'match';
type Props = {variant: Variant; enterFrame?: number};

const Halftone: React.FC<{x: number; y: number; size: number; color: string; opacity: number}> = ({x, y, size, color, opacity}) => {
  const n = 6;
  const gap = size / n;
  return (
    <svg style={{position: 'absolute', left: x, top: y}} width={size} height={size} opacity={opacity}>
      {Array.from({length: n * n}, (_, i) => {
        const cx = (i % n) * gap + gap / 2;
        const row = Math.floor(i / n);
        return <circle key={i} cx={cx} cy={row * gap + gap / 2} r={Math.max(2, (gap / 2.7) * (1 - row * 0.1))} fill={color} />;
      })}
    </svg>
  );
};

const Ring: React.FC<{x: number; y: number; size: number; color: string; opacity: number; strokeWidth?: number}> = ({x, y, size, color, opacity, strokeWidth = 14}) => (
  <svg style={{position: 'absolute', left: x, top: y}} width={size} height={size} opacity={opacity}>
    <circle cx={size / 2} cy={size / 2} r={size / 2 - strokeWidth} fill="none" stroke={color} strokeWidth={strokeWidth} />
  </svg>
);

const Blob: React.FC<{x: number; y: number; size: number; color: string; opacity: number}> = ({x, y, size, color, opacity}) => (
  <div style={{position: 'absolute', left: x, top: y, width: size, height: size, borderRadius: '50%', background: color, opacity}} />
);

const TornStrip: React.FC<{x: number; y: number; width: number; height: number; rotate: number; opacity: number}> = ({x, y, width, height, rotate, opacity}) => (
  <div
    style={{
      position: 'absolute',
      left: x,
      top: y,
      width,
      height,
      background: theme.colors.paper,
      opacity,
      transform: `rotate(${rotate}deg)`,
      clipPath:
        'polygon(0% 8%, 6% 0%, 15% 10%, 26% 2%, 38% 12%, 52% 3%, 63% 11%, 77% 1%, 88% 9%, 100% 4%, 100% 92%, 93% 100%, 81% 90%, 68% 99%, 55% 89%, 41% 98%, 29% 90%, 16% 99%, 7% 91%, 0% 97%)',
    }}
  />
);

export const CollageShapes: React.FC<Props> = ({variant, enterFrame = 0}) => {
  const frame = useCurrentFrame();
  const pop = (delay: number) =>
    interpolate(frame, [enterFrame + delay, enterFrame + delay + 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  if (variant === 'hook') {
    return (
      <div style={{position: 'absolute', inset: 0}}>
        <Halftone x={60} y={180} size={260} color={theme.colors.green} opacity={0.75 * pop(0)} />
        <Halftone x={780} y={1450} size={240} color={theme.colors.purple} opacity={0.7 * pop(6)} />
        <Ring x={800} y={300} size={220} color={theme.colors.purple} opacity={0.9 * pop(3)} />
        <Blob x={-90} y={1180} size={280} color={theme.colors.purple} opacity={0.55 * pop(8)} />
        <TornStrip x={120} y={880} width={840} height={560} rotate={-4} opacity={0.16 * pop(2)} />
      </div>
    );
  }
  if (variant === 'rules') {
    return (
      <div style={{position: 'absolute', inset: 0}}>
        <Halftone x={790} y={200} size={220} color={theme.colors.purple} opacity={0.7 * pop(0)} />
        <Ring x={60} y={1400} size={180} color={theme.colors.green} opacity={0.85 * pop(4)} />
        <Blob x={880} y={1050} size={200} color={theme.colors.green} opacity={0.35 * pop(6)} />
      </div>
    );
  }
  if (variant === 'elimination') {
    return (
      <div style={{position: 'absolute', inset: 0}}>
        <Halftone x={70} y={1420} size={220} color={theme.colors.green} opacity={0.6 * pop(0)} />
        <Ring x={820} y={240} size={190} color={theme.colors.danger} opacity={0.65 * pop(3)} />
        <Blob x={-70} y={300} size={220} color={theme.colors.purple} opacity={0.4 * pop(5)} />
      </div>
    );
  }
  // match
  return (
    <div style={{position: 'absolute', inset: 0}}>
      <Halftone x={70} y={220} size={240} color={theme.colors.green} opacity={0.8 * pop(0)} />
      <Halftone x={790} y={1420} size={240} color={theme.colors.green} opacity={0.8 * pop(2)} />
      <Ring x={90} y={1350} size={200} color={theme.colors.purple} opacity={0.9 * pop(4)} />
      <Ring x={800} y={330} size={170} color={theme.colors.green} opacity={0.9 * pop(6)} />
    </div>
  );
};
```

- [ ] **Step 4: QuestionCard.tsx yaz**

```tsx
import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type State = 'neutral' | 'correct' | 'wrong';
type Props = {
  text: string;
  x: number;
  y: number;
  width?: number;
  rotate?: number;
  enterFrame?: number;
  state?: State;
  stateFrame?: number;
};

const StateBadge: React.FC<{state: State; visible: number}> = ({state, visible}) => {
  if (state === 'neutral') return null;
  const color = state === 'correct' ? theme.colors.greenDark : theme.colors.danger;
  const glyph = state === 'correct' ? 'M5 13l4 4L19 7' : 'M6 6l12 12M18 6L6 18';
  return (
    <div
      style={{
        position: 'absolute',
        right: -28,
        top: -28,
        width: 76,
        height: 76,
        borderRadius: '50%',
        background: color,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        transform: `scale(${visible})`,
        boxShadow: '0 10px 24px rgba(0,0,0,0.4)',
      }}
    >
      <svg width={40} height={40} viewBox="0 0 24 24" fill="none" stroke="#FFF" strokeWidth={3.4} strokeLinecap="round">
        <path d={glyph} />
      </svg>
    </div>
  );
};

export const QuestionCard: React.FC<Props> = ({
  text,
  x,
  y,
  width = 660,
  rotate = 0,
  enterFrame = 0,
  state = 'neutral',
  stateFrame = 0,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - enterFrame;
  if (local < 0) return null;

  const enter = spring({frame: local, fps, from: 0, to: 1, config: {damping: 13, stiffness: 160}, durationInFrames: 14});
  const chars = Math.round(interpolate(local, [6, 26], [0, text.length], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'}));
  const badgeScale = spring({frame: frame - stateFrame, fps, from: 0, to: 1, config: {damping: 10, stiffness: 200}, durationInFrames: 12});

  return (
    <div
      style={{
        position: 'absolute',
        left: x - width / 2,
        top: y,
        width,
        padding: '30px 38px',
        background: theme.colors.paper,
        color: theme.colors.paperInk,
        borderRadius: 14,
        fontFamily: theme.fonts.body,
        fontWeight: 600,
        fontSize: theme.type.body,
        lineHeight: 1.25,
        transform: `rotate(${rotate}deg) scale(${enter})`,
        opacity: enter,
        boxShadow: '0 16px 30px rgba(0,0,0,0.45)',
      }}
    >
      {text.slice(0, chars)}
      <StateBadge state={frame >= stateFrame ? state : 'neutral'} visible={frame >= stateFrame ? badgeScale : 0} />
    </div>
  );
};
```

- [ ] **Step 5: MatchSpark.tsx yaz** (`qulo-twitter-tr/src/components/MatchPop.tsx`'in 1080 genişliğe ölçeklenmiş hali)

```tsx
import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {startFrame?: number; label?: string};

const SPARKS = Array.from({length: 12}, (_, i) => (i * 360) / 12);

export const MatchSpark: React.FC<Props> = ({startFrame = 0, label = 'Eşleşme!'}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - startFrame;
  if (local < 0) return null;

  const scale = spring({frame: local, fps, from: 0.3, to: 1, config: {damping: 11, stiffness: 140}, durationInFrames: 20});
  const glow = interpolate(local, [0, 16], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const sparkDist = interpolate(local, [4, 30], [0, 190], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const sparkOpacity = interpolate(local, [4, 18, 36], [0, 1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <div style={{position: 'relative', display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
      <div
        style={{
          position: 'absolute',
          width: 430,
          height: 430,
          borderRadius: '50%',
          background: `radial-gradient(circle, rgba(105,240,174,${0.35 * glow}), transparent 65%)`,
        }}
      />
      {SPARKS.map((deg, i) => (
        <div
          key={i}
          style={{
            position: 'absolute',
            width: 8,
            height: 24,
            borderRadius: 4,
            background: i % 2 === 0 ? theme.colors.green : theme.colors.purple,
            opacity: sparkOpacity,
            transform: `rotate(${deg}deg) translateY(-${sparkDist}px)`,
          }}
        />
      ))}
      <div
        style={{
          transform: `scale(${scale})`,
          fontFamily: theme.fonts.display,
          fontWeight: 900,
          fontSize: theme.type.hook,
          color: theme.colors.green,
          textShadow: '0 8px 40px rgba(105,240,174,0.5)',
          letterSpacing: -2,
        }}
      >
        {label}
      </div>
    </div>
  );
};
```

- [ ] **Step 6: Tip kontrolü + commit**

```bash
cd entertainment/qulo-reels-tr && npx tsc --noEmit
```
Expected: hata yok. (Görsel doğrulama sahne task'larında yapılır.)

```bash
git add entertainment/qulo-reels-tr/src/components && git commit -m "feat(reels-ad): kolaj bilesenleri (sticker, shapes, question card, match spark)"
```

---

### Task 5: S1 Hook sahnesi (0–90)

**Files:**
- Create: `entertainment/qulo-reels-tr/src/scenes/S1Hook.tsx`
- Modify: `entertainment/qulo-reels-tr/src/types.ts` (union'a `'S1Hook'` ekle)
- Modify: `entertainment/qulo-reels-tr/src/configs/reels-tr.config.ts`
- Modify: `entertainment/qulo-reels-tr/src/QuloReelsAd.tsx` (switch'e case)

**Interfaces:**
- Consumes: `CollageSticker`, `CollageShapes`, `StaggerText`, `public/ai/w1_hook.png`.
- Produces: `S1Hook` React component.

- [ ] **Step 1: S1Hook.tsx yaz**

```tsx
import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {StaggerText} from '../components/StaggerText';

export const S1Hook: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="hook" />
      <CollageSticker src="ai/w1_hook.png" width={720} x={540} y={1620} enterFrame={4} baseRotate={-2} />
      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 40,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['Sana ulaşmak', 'bu kadar *kolay* olmamalı.']}
          startFrame={12}
          fontSize={theme.type.hook}
          accentColor={theme.colors.green}
        />
      </div>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: types + config + oynatıcıya bağla**

`types.ts`: `export type SceneComponent = 'Placeholder' | 'S1Hook';`

`reels-tr.config.ts` scenes:
```ts
  scenes: [
    {component: 'S1Hook', startFrame: s(0), durationFrames: s(3)},
    {component: 'Placeholder', startFrame: s(3), durationFrames: s(22)},
  ],
```

`QuloReelsAd.tsx`: `import {S1Hook} from './scenes/S1Hook';` + switch'e `case 'S1Hook': return <S1Hook />;`

- [ ] **Step 3: Doğrula**

```bash
cd entertainment/qulo-reels-tr && npx tsc --noEmit && npx remotion still src/index.ts QuloReelsAd out/task5_s1_f70.png --frame=70
```
Expected: tsc sessiz; PNG'de kadın sticker (şeffaf kenar, beyaz kontur), şekiller, iki satır hook metni (Türkçe karakterler doğru, "kolay" yeşil). Metin üst safe zone'un altında, figür alt 260px'e taşmıyor. PNG'yi Read ile gözle kontrol et.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-reels-tr/src && git commit -m "feat(reels-ad): S1 hook sahnesi (kadin sticker + kolaj sekiller)"
```

---

### Task 6: S2 Kurallar sahnesi (90–270)

**Files:**
- Create: `entertainment/qulo-reels-tr/src/scenes/S2Rules.tsx`
- Modify: `types.ts`, `reels-tr.config.ts`, `QuloReelsAd.tsx` (aynı bağlama kalıbı)

**Interfaces:**
- Consumes: `CollageSticker`, `CollageShapes`, `QuestionCard`, `StaggerText`, `public/ai/w1_point.png`.
- Produces: `S2Rules` component; **soru metinleri (S3 de aynılarını kullanır):** `SORULAR = ['Pazar sabahı planın ne?', 'Kedi mi köpek mi?', 'İlk buluşmada nereye gideriz?']` — `src/configs/questions.ts` dosyasından export edilir.

- [ ] **Step 1: questions.ts yaz**

`entertainment/qulo-reels-tr/src/configs/questions.ts`:
```ts
export const SORULAR = [
  'Pazar sabahı planın ne?',
  'Kedi mi köpek mi?',
  'İlk buluşmada nereye gideriz?',
] as const;
```

- [ ] **Step 2: S2Rules.tsx yaz**

```tsx
import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {SORULAR} from '../configs/questions';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {StaggerText} from '../components/StaggerText';

export const S2Rules: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="rules" />
      <CollageSticker src="ai/w1_point.png" width={560} x={300} y={1660} enterFrame={0} baseRotate={2} />
      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 30,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['2-10 soru.', 'Kuralları *sen* koy.']}
          startFrame={4}
          fontSize={theme.type.title}
          accentColor={theme.colors.purple}
        />
      </div>
      {SORULAR.map((q, i) => (
        <QuestionCard
          key={q}
          text={q}
          x={620}
          y={640 + i * 190}
          width={640}
          rotate={i % 2 === 0 ? -2 : 2}
          enterFrame={40 + i * 40}
        />
      ))}
    </AbsoluteFill>
  );
};
```

- [ ] **Step 3: Bağla** — `types.ts` union'a `'S2Rules'`; config:
```ts
    {component: 'S1Hook', startFrame: s(0), durationFrames: s(3)},
    {component: 'S2Rules', startFrame: s(3), durationFrames: s(6)},
    {component: 'Placeholder', startFrame: s(9), durationFrames: s(16)},
```
`QuloReelsAd.tsx` switch'e `case 'S2Rules'`.

- [ ] **Step 4: Doğrula**

```bash
cd entertainment/qulo-reels-tr && npx tsc --noEmit && npx remotion still src/index.ts QuloReelsAd out/task6_s2_f240.png --frame=240
```
Expected: kadın (yazma pozu) solda, 3 soru kartı tam yazılmış, başlık iki satır. Kartlar sağ kenardan taşmıyor. Gözle kontrol.

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-reels-tr/src && git commit -m "feat(reels-ad): S2 kurallar sahnesi (soru kartlari + kadin ikinci poz)"
```

---

### Task 7: S3 Eleme sahnesi (270–510)

**Files:**
- Create: `entertainment/qulo-reels-tr/src/scenes/S3Elimination.tsx`
- Modify: `types.ts`, `reels-tr.config.ts`, `QuloReelsAd.tsx`

**Interfaces:**
- Consumes: `CollageSticker` (tearFrame ile), `QuestionCard` (state/stateFrame), `CollageShapes`, `StaggerText`, `SORULAR`, `public/ai/m1.png m2.png m3.png w1_hook.png`.
- Produces: `S3Elimination` component. Round zamanlaması: round i başlangıcı `30 + i * 70` (i=0,1,2); yanlışlarda çarpı `start+34`, yırtılma `start+44`; m3'te tick `start+34`.

- [ ] **Step 1: S3Elimination.tsx yaz**

```tsx
import {AbsoluteFill, Sequence} from 'remotion';
import {theme} from '../theme';
import {SORULAR} from '../configs/questions';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {QuestionCard} from '../components/QuestionCard';
import {StaggerText} from '../components/StaggerText';

const ROUNDS = [
  {src: 'ai/m1.png', question: SORULAR[0], correct: false},
  {src: 'ai/m2.png', question: SORULAR[1], correct: false},
  {src: 'ai/m3.png', question: SORULAR[2], correct: true},
] as const;

const roundStart = (i: number) => 30 + i * 70;

export const S3Elimination: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="elimination" />
      {/* Kadın küçük "jüri" olarak solda sabit */}
      <CollageSticker src="ai/w1_hook.png" width={300} x={190} y={1700} enterFrame={0} baseRotate={-3} sway={false} />
      <div
        style={{
          position: 'absolute',
          top: theme.safeZone.top + 20,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
          padding: `0 ${theme.safeZone.horizontal}px`,
        }}
      >
        <StaggerText
          lines={['Yanlış cevap?', '*Elenirsin.*']}
          startFrame={4}
          fontSize={theme.type.title}
          accentColor={theme.colors.danger}
        />
      </div>
      {ROUNDS.map((round, i) => {
        const start = roundStart(i);
        return (
          <Sequence key={round.src} from={start} name={`Round ${i + 1}`}>
            <CollageSticker
              src={round.src}
              width={560}
              x={640}
              y={1680}
              enterFrame={0}
              baseRotate={i % 2 === 0 ? 3 : -3}
              tearFrame={round.correct ? undefined : 44}
            />
            <QuestionCard
              text={round.question}
              x={540}
              y={560}
              width={680}
              rotate={i % 2 === 0 ? -2 : 2}
              enterFrame={4}
              state={round.correct ? 'correct' : 'wrong'}
              stateFrame={34}
            />
          </Sequence>
        );
      })}
    </AbsoluteFill>
  );
};
```
Not: `Sequence` içindeki `CollageSticker`/`QuestionCard` frame'leri Sequence-lokal çalışır (`useCurrentFrame` Sequence içinde sıfırlanır) — `tearFrame: 44` round başlangıcına göredir. Yanlış roundlarda kart, sonraki round'un Sequence'i başlamadan (70 frame) düşer; `durationInFrames` verilmediği için önceki round görünür kalabilir — her `Sequence`'e `durationInFrames={i === 2 ? 240 - start : 70}` ekle (m3 sahne sonuna kadar kalır).

Düzeltilmiş Sequence satırı:
```tsx
          <Sequence key={round.src} from={start} durationInFrames={i === 2 ? 240 - start : 70} name={`Round ${i + 1}`}>
```

- [ ] **Step 2: Bağla** — union'a `'S3Elimination'`; config:
```ts
    {component: 'S2Rules', startFrame: s(3), durationFrames: s(6)},
    {component: 'S3Elimination', startFrame: s(9), durationFrames: s(8)},
    {component: 'Placeholder', startFrame: s(17), durationFrames: s(8)},
```
Switch'e case.

- [ ] **Step 3: Doğrula (3 anahtar frame)**

```bash
cd entertainment/qulo-reels-tr && npx tsc --noEmit \
  && npx remotion still src/index.ts QuloReelsAd out/task7_s3_m1_x.png --frame=$((270 + 30 + 40)) \
  && npx remotion still src/index.ts QuloReelsAd out/task7_s3_m1_fall.png --frame=$((270 + 30 + 58)) \
  && npx remotion still src/index.ts QuloReelsAd out/task7_s3_m3_tick.png --frame=$((270 + 170 + 45))
```
Expected: ilk PNG'de m1 + kırmızı çarpı rozeti; ikincide m1 düşerken (aşağı kaymış/dönmüş); üçüncüde m3 + yeşil tick. Her birinde kadın solda, başlık üstte. Gözle kontrol.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-reels-tr/src && git commit -m "feat(reels-ad): S3 eleme sahnesi (yanlis cevap yirtilip duser)"
```

---

### Task 8: S4 Eşleşme sahnesi (510–660)

**Files:**
- Create: `entertainment/qulo-reels-tr/src/scenes/S4Match.tsx`
- Modify: `types.ts`, `reels-tr.config.ts`, `QuloReelsAd.tsx`

**Interfaces:**
- Consumes: `CollageSticker`, `CollageShapes`, `MatchSpark`, `public/ai/w1_hook.png m3.png`.
- Produces: `S4Match` component.

- [ ] **Step 1: S4Match.tsx yaz**

```tsx
import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {CollageShapes} from '../components/CollageShapes';
import {CollageSticker} from '../components/CollageSticker';
import {MatchSpark} from '../components/MatchSpark';

export const S4Match: React.FC = () => {
  const frame = useCurrentFrame();
  // İki figür kenarlardan merkeze kayar.
  const slide = interpolate(frame, [0, 24], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const womanX = interpolate(slide, [0, 1], [40, 330]);
  const manX = interpolate(slide, [0, 1], [1040, 750]);

  return (
    <AbsoluteFill style={{background: theme.colors.bg, overflow: 'hidden'}}>
      <CollageShapes variant="match" />
      <CollageSticker src="ai/w1_hook.png" width={520} x={womanX} y={1660} enterFrame={0} baseRotate={-2} />
      <CollageSticker src="ai/m3.png" width={520} x={manX} y={1660} enterFrame={0} baseRotate={2} flip />
      <div
        style={{
          position: 'absolute',
          top: 560,
          left: 0,
          width: '100%',
          display: 'flex',
          justifyContent: 'center',
        }}
      >
        <MatchSpark startFrame={26} label="Eşleşme!" />
      </div>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Bağla** — union'a `'S4Match'`; config:
```ts
    {component: 'S3Elimination', startFrame: s(9), durationFrames: s(8)},
    {component: 'S4Match', startFrame: s(17), durationFrames: s(5)},
    {component: 'Placeholder', startFrame: s(22), durationFrames: s(3)},
```
Switch'e case.

- [ ] **Step 3: Doğrula**

```bash
cd entertainment/qulo-reels-tr && npx tsc --noEmit && npx remotion still src/index.ts QuloReelsAd out/task8_s4_f560.png --frame=560
```
Expected: iki figür merkezde yan yana (erkek aynalı), aralarında/üstlerinde yeşil "Eşleşme!" + spark'lar. Elmas görseli YOK. Gözle kontrol.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-reels-tr/src && git commit -m "feat(reels-ad): S4 eslesme sahnesi (iki sticker + match spark)"
```

---

### Task 9: S5 Kapanış sahnesi (660–750) + Placeholder'ı kaldır

**Files:**
- Create: `entertainment/qulo-reels-tr/src/components/StoreBadges.tsx` (kopya)
- Create: `entertainment/qulo-reels-tr/src/scenes/S5Closing.tsx`
- Modify: `types.ts` (union'dan `'Placeholder'` çıkar, `'S5Closing'` ekle), `reels-tr.config.ts`, `QuloReelsAd.tsx` (Placeholder import/case sil)
- Delete: `entertainment/qulo-reels-tr/src/scenes/Placeholder.tsx`

**Interfaces:**
- Consumes: `StaggerText`, `StoreBadges`, `public/brand/qulo_logo.svg`.
- Produces: `S5Closing`; final `SceneComponent` union: `'S1Hook' | 'S2Rules' | 'S3Elimination' | 'S4Match' | 'S5Closing'`.

- [ ] **Step 1: StoreBadges'i kopyala**

```bash
cp entertainment/qulo-twitter-tr/src/components/StoreBadges.tsx entertainment/qulo-reels-tr/src/components/StoreBadges.tsx
```
İçerik değişmez (theme token'larından okunur; 1080 genişlikte iki rozet yan yana sığar: 2×280 + 28 gap < 1080 − 2×70).

- [ ] **Step 2: S5Closing.tsx yaz**

```tsx
import {AbsoluteFill, Img, spring, staticFile, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';
import {StaggerText} from '../components/StaggerText';
import {StoreBadges} from '../components/StoreBadges';

export const S5Closing: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const logoScale = spring({frame, fps, from: 0.5, to: 1, config: {damping: 12, stiffness: 150}, durationInFrames: 18});

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        alignItems: 'center',
        justifyContent: 'center',
        gap: 56,
        paddingBottom: theme.safeZone.bottom,
      }}
    >
      <Img
        src={staticFile('brand/qulo_logo.svg')}
        style={{width: 280, transform: `scale(${logoScale})`, filter: 'drop-shadow(0 0 60px rgba(105,240,174,0.35))'}}
      />
      <StaggerText
        lines={['Doğru soru,', '*doğru insan.*']}
        startFrame={10}
        fontSize={theme.type.title}
        accentColor={theme.colors.green}
      />
      <StoreBadges startFrame={30} />
    </AbsoluteFill>
  );
};
```

- [ ] **Step 3: Bağla ve Placeholder'ı kaldır**

Final `types.ts` union:
```ts
export type SceneComponent = 'S1Hook' | 'S2Rules' | 'S3Elimination' | 'S4Match' | 'S5Closing';
```
Final config scenes:
```ts
  scenes: [
    {component: 'S1Hook', startFrame: s(0), durationFrames: s(3)},
    {component: 'S2Rules', startFrame: s(3), durationFrames: s(6)},
    {component: 'S3Elimination', startFrame: s(9), durationFrames: s(8)},
    {component: 'S4Match', startFrame: s(17), durationFrames: s(5)},
    {component: 'S5Closing', startFrame: s(22), durationFrames: s(3)},
  ],
```
`QuloReelsAd.tsx`: Placeholder import/case silinir, `S5Closing` case eklenir. `rm entertainment/qulo-reels-tr/src/scenes/Placeholder.tsx`.

- [ ] **Step 4: Doğrula**

```bash
cd entertainment/qulo-reels-tr && npx tsc --noEmit && npx remotion still src/index.ts QuloReelsAd out/task9_s5_f720.png --frame=720
```
Expected: logo + motto (doğru Türkçe karakterler, "doğru insan." yeşil) + iki store rozeti; hepsi alt safe zone'un üstünde. Gözle kontrol.

- [ ] **Step 5: Commit**

```bash
git add -A entertainment/qulo-reels-tr/src && git commit -m "feat(reels-ad): S5 kapanis (logo + motto + store badge), placeholder kaldirildi"
```

---

### Task 10: Ses + final render + kapak görselleri + README

**Files:**
- Create: `entertainment/qulo-reels-tr/public/audio/music_25s.mp3` (kopya, git-ignored)
- Modify: `entertainment/qulo-reels-tr/src/configs/reels-tr.config.ts` (audioTracks)
- Create: `entertainment/qulo-reels-tr/prompts/elevenlabs-vo-tr.md`
- Create: `entertainment/qulo-reels-tr/README.md`
- Output: `out/qulo-reels-tr-25s-9x16.mp4`, `out/cover_9x16.png`, `out/cover_4x5.png`

**Interfaces:**
- Consumes: tüm sahneler; `qulo-twitter-tr/public/audio/music_30s.mp3` (diskte mevcut, git-ignored).
- Produces: paylaşıma hazır MP4 + 2 kapak PNG.

- [ ] **Step 1: Müzik bed'i kopyala ve config'e ekle**

```bash
cp entertainment/qulo-twitter-tr/public/audio/music_30s.mp3 entertainment/qulo-reels-tr/public/audio/music_25s.mp3
```
Config `audioTracks`:
```ts
  audioTracks: [
    // Müzik-only (VO yok). VO eklenirse müzik 0.30'a çekilip vo_tr_final.mp3 volume 1.0 eklenecek.
    {path: 'audio/music_25s.mp3', volume: 0.65, startFrame: 0},
  ],
```
Not: kompozisyon 750 frame'de bittiği için 30sn'lik müzik otomatik 25sn'de kesilir.

- [ ] **Step 2: VO script'ini yaz (opsiyonel kullanım için)**

`entertainment/qulo-reels-tr/prompts/elevenlabs-vo-tr.md`:
```markdown
# ElevenLabs TR VO — Qulo Reels (25sn)

Ses: genç kadın, özgüvenli, hafif alaycı-eğlenceli ton. Hız: doğal-hızlı.

| Sahne | Zaman | Replik |
|-------|-------|--------|
| S1 | 0.5–2.8s | "Sana ulaşmak bu kadar kolay olmamalı." |
| S2 | 3.5–8.5s | "Qulo'da kurallar senin: iki ila on soru sor." |
| S3 | 9.5–16.5s | "Yanlış cevaplayan... elenir." |
| S4 | 17.5–21.5s | "Doğru cevaplayan? Eşleşir." |
| S5 | 22–24.5s | "Qulo. Doğru soru, doğru insan." |

Üretimden sonra: dosyayı `public/audio/vo_tr_final.mp3` olarak kaydet,
config'te müzik volume'unu 0.30'a çek ve VO track'i ekle.
```

- [ ] **Step 3: README.md yaz**

`entertainment/qulo-reels-tr/README.md`:
```markdown
# Qulo Instagram Reels Reklamı — TR, 9:16, 25sn, Retro Kolaj

AI-üretimli kolaj sticker'ları (Gemini gemini-3-pro-image) + Remotion animasyon.

## Spec & Plan
- Spec: `docs/superpowers/specs/2026-07-11-qulo-reels-tr-collage-ad-design.md`
- Plan: `docs/superpowers/plans/2026-07-11-qulo-reels-tr-collage-ad.md`

## Komutlar
- `npm install` — bağımlılıklar
- `npm run studio` — canlı önizleme
- `GEMINI_API_KEY="..." npm run assets -- --all` — AI sticker üretimi (bkz. prompts/characters.md)
- `npm run render` — final MP4 (out/qulo-reels-tr-25s-9x16.mp4)

## Sahneler (config: src/configs/reels-tr.config.ts)
1. S1 Hook (0–3s) — "Sana ulaşmak bu kadar kolay olmamalı."
2. S2 Kurallar (3–9s) — "2-10 soru. Kuralları sen koy."
3. S3 Eleme (9–17s) — yanlış cevap → sticker yırtılıp düşer
4. S4 Eşleşme (17–22s) — doğru cevaplayan + "Eşleşme!"
5. S5 Kapanış (22–25s) — logo + "Doğru soru, doğru insan." + store badge

## Instagram upload notu
- Reels reklam: MP4 H.264, 1080×1920, ≤30sn — uyumlu.
- Kapaklar: out/cover_9x16.png (Reels), out/cover_4x5.png (feed önizleme).
- Ses kapalı autoplay'de mesaj ekran yazılarıyla tam taşınır.
```

- [ ] **Step 4: Final render + kapaklar**

```bash
cd entertainment/qulo-reels-tr && npx tsc --noEmit && npm run render
```
Expected: `out/qulo-reels-tr-25s-9x16.mp4` (750 frame, sessiz değil — müzikli).

```bash
cd entertainment/qulo-reels-tr \
  && npx remotion still src/index.ts QuloReelsAd out/cover_9x16.png --frame=70 \
  && ffmpeg -y -i out/cover_9x16.png -vf "crop=1080:1350:0:220" out/cover_4x5.png
```
Expected: iki kapak PNG. `cover_9x16.png` = S1 hook anı (kadın + metin tam görünür).

- [ ] **Step 5: Uçtan uca gözle kontrol**

MP4'ten 5 sahnenin ortasından frame çek ve incele:
```bash
cd entertainment/qulo-reels-tr && for f in 45 180 380 585 720; do ffmpeg -y -i out/qulo-reels-tr-25s-9x16.mp4 -vf "select=eq(n\,$f)" -vframes 1 out/check_$f.png; done
```
Her PNG'yi Read ile aç: Türkçe karakterler, safe zone ihlali yok, elmas yok, geçişler tutarlı. Videoyu kullanıcıya sun (dosya yolu + QuickTime ile açma komutu), onayını al.

- [ ] **Step 6: Commit**

```bash
git add entertainment/qulo-reels-tr && git commit -m "feat(reels-ad): ses + final render + kapak gorselleri + README"
```

---

## Self-Review Notları

- **Spec coverage:** Senaryo tablosundaki 5 sahne → Task 5-9; asset akışı → Task 2-3; kolaj/policy/elmas/dil kuralları → Global Constraints + prompt'lar; kapak görselleri → Task 10; hata durumları (429, eksik asset) → Task 2 script'i (başarısız id listesi + tekrar çalıştırma); "eksik asset'te placeholder gradient" spec maddesi, Task 3'ün sahnelerden ÖNCE koşulmasıyla gereksizleşti — sahneler ancak onaylı asset'lerle yazılır.
- **Tip tutarlılığı:** `CollageSticker` props'ları Task 4'te tanımlanıp Task 5/7/8'de aynı imzayla kullanılıyor; `SORULAR` Task 6'da üretilip Task 7'de tüketiliyor; `s()` helper config'ten export ediliyor.
- **Placeholder taraması:** Tüm kod blokları tam; "TBD/TODO" yok. Ses dosyası kopyası diskte mevcut kaynaktan (`music_30s.mp3`) alınıyor; yoksa Task 10 Step 1'de kullanıcıdan müzik dosyası istenir.
