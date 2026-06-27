# Qulo Twitter Reklamı (TR, 16:9) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Türkçe, 16:9 (1920×1080), ~30 saniyelik Qulo tanıtım videosunu Remotion ile üretip Twitter'da paylaşıma hazır bir MP4 çıkarmak.

**Architecture:** `entertainment/qulo-tiktok-promos` projesindeki config-driven sahne oynatıcı pattern'i (theme token + `SceneSpec` listesi + `<Sequence>` dizilimi) **yeni izole bir kardeş proje** `entertainment/qulo-twitter-tr/`'de 16:9'a uyarlanır. 6 sahne (Boş Kaos → İki Soru → Qulo Doğuşu → Problem Akışı → Çözüm Anı → Kapanış) tek bir `QuloTwitterAd` composition'ında config'ten okunur. Tüm görseller native React/SVG/CSS animasyon (canlı çekim/Veo yok). Ses (TR VO + müzik) en sonda `<Audio>` katmanı olarak eklenir.

**Tech Stack:** Remotion 4.x, React 19, TypeScript, `@remotion/google-fonts` (Poppins). Render: Remotion'un kendi headless-Chrome → ffmpeg H.264 pipeline'ı.

## Global Constraints

- **Format:** 16:9, **1920×1080**, 30fps, H.264 MP4 — her composition/still bu boyutta.
- **Süre:** 900 frame (30.0 sn @ 30fps).
- **Dil:** Tüm ekran metinleri ve VO **Türkçe**. İngilizce ekran metni YASAK.
- **Elmas YOK:** Hiçbir sahnede yeşil/mor elmas (diamond) görseli kullanılmaz (kullanıcı kararı). Kutlama efektleri yeşil parıltı/spark.
- **Renkler (theme token):** bg `#0D0D0D`, surface `#1A1A1A`, green `#69F0AE`, purple `#BB86FC`, danger `#CF6679`, text `#FFFFFF`, textMuted `#B0B0B0`.
- **Font:** Poppins (`@remotion/google-fonts/Poppins`), display weight 800. Türkçe ı/İ/ç/ğ/ş/ö/ü görsel kontrol edilecek.
- **Kapanış mottosu (locked):** "Doğru soru, doğru insan."
- **Layout sabitleri hardcode edilmez:** boyutlar `theme.composition`'dan okunur.
- **Mevcut 9:16 projesine dokunulmaz:** `entertainment/qulo-tiktok-promos/` ve `entertainment/qulo-stop-swiping/` değiştirilmez; sadece okunur/asset referans alınır.
- **Sahne frame aralıkları (config'te sabit):** S1 0–120, S2 120–270, S3 270–450, S4 450–690, S5 690–810, S6 810–900.

**Verification notu (görsel medya):** Bu bir video projesi; klasik jest unit test uygun değil. Her task'ın "test döngüsü": (1) `npx tsc --noEmit` ile tip kontrolü, (2) `npx remotion still` ile sahnenin anahtar frame'inde PNG render edilip hata olmadan görüntü ürettiğinin doğrulanması, (3) Remotion Studio'da gözle kontrol. Bu üçü, bu medyumun dürüst doğrulamasıdır.

---

### Task 1: Proje iskeleti + tema + boş composition

**Files:**
- Create: `entertainment/qulo-twitter-tr/package.json`
- Create: `entertainment/qulo-twitter-tr/tsconfig.json`
- Create: `entertainment/qulo-twitter-tr/.gitignore`
- Create: `entertainment/qulo-twitter-tr/remotion.config.ts`
- Create: `entertainment/qulo-twitter-tr/src/theme.ts`
- Create: `entertainment/qulo-twitter-tr/src/types.ts`
- Create: `entertainment/qulo-twitter-tr/src/index.ts`
- Create: `entertainment/qulo-twitter-tr/src/Root.tsx`
- Create: `entertainment/qulo-twitter-tr/src/QuloTwitterAd.tsx`
- Create: `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts`
- Create: `entertainment/qulo-twitter-tr/src/scenes/Placeholder.tsx`
- Create: `entertainment/qulo-twitter-tr/public/brand/qulo_logo.svg` (kopya)

**Interfaces:**
- Produces:
  - `theme` (default export-yok, named) — `theme.composition = {width:1920,height:1080,fps:30}`, `theme.colors`, `theme.fonts`, `theme.safeZone`, `theme.radius`.
  - `type SceneSpec = {component: SceneComponent; startFrame: number; durationFrames: number; props?: Record<string, unknown>}`
  - `type SceneComponent` (union, başlangıçta `'Placeholder'`)
  - `type TwitterConfig = {durationInFrames: number; scenes: SceneSpec[]; audioTracks?: AudioTrack[]}`
  - `twitterConfig: TwitterConfig` — `configs/twitter-tr.config.ts`
  - `QuloTwitterAd` React component — config'i okuyup sahneleri `<Sequence>` ile dizer.
  - Composition id: `QuloTwitterAd`.

- [ ] **Step 1: Logo asset'ini kopyala**

```bash
mkdir -p entertainment/qulo-twitter-tr/public/brand entertainment/qulo-twitter-tr/public/audio entertainment/qulo-twitter-tr/out entertainment/qulo-twitter-tr/src/scenes entertainment/qulo-twitter-tr/src/components entertainment/qulo-twitter-tr/src/configs
cp entertainment/qulo-stop-swiping/public/brand/qulo_logo.svg entertainment/qulo-twitter-tr/public/brand/qulo_logo.svg
ls -la entertainment/qulo-twitter-tr/public/brand/
```
Expected: `qulo_logo.svg` listelenir.

- [ ] **Step 2: package.json yaz**

`entertainment/qulo-twitter-tr/package.json`:
```json
{
  "name": "qulo-twitter-tr",
  "version": "1.0.0",
  "private": true,
  "description": "Qulo Türkçe Twitter reklamı — 16:9, 30sn.",
  "scripts": {
    "studio": "remotion studio src/index.ts",
    "compositions": "remotion compositions src/index.ts",
    "render": "remotion render src/index.ts QuloTwitterAd out/qulo-twitter-tr-30s-16x9.mp4",
    "still": "remotion still src/index.ts QuloTwitterAd",
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
    "typescript": "^5.9.3"
  }
}
```

- [ ] **Step 3: tsconfig.json + .gitignore + remotion.config.ts yaz**

`entertainment/qulo-twitter-tr/tsconfig.json`:
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "jsx": "react-jsx",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "lib": ["DOM", "ES2022"],
    "types": ["node"]
  },
  "include": ["src/**/*", "remotion.config.ts"]
}
```

`entertainment/qulo-twitter-tr/.gitignore`:
```
node_modules
out
*.mp4
.DS_Store
```

`entertainment/qulo-twitter-tr/remotion.config.ts`:
```ts
import {Config} from '@remotion/cli/config';

Config.setVideoImageFormat('jpeg');
Config.setOverwriteOutput(true);
```

- [ ] **Step 4: theme.ts yaz**

`entertainment/qulo-twitter-tr/src/theme.ts`:
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
  },
  fonts: {
    display: `${poppins}, "SF Pro Display", system-ui, sans-serif`,
    body: `${poppins}, "SF Pro Text", system-ui, sans-serif`,
  },
  type: {
    hook: 120,
    title: 92,
    body: 56,
    small: 36,
    weight: 800,
  },
  safeZone: {
    top: 80,
    bottom: 100,
    horizontal: 120,
  },
  radius: {sm: 10, md: 16, lg: 24, xl: 36, pill: 999},
  composition: {
    width: 1920,
    height: 1080,
    fps: 30,
  },
} as const;

export type Theme = typeof theme;
```

- [ ] **Step 5: types.ts yaz**

`entertainment/qulo-twitter-tr/src/types.ts`:
```ts
export type SceneComponent =
  | 'Placeholder'
  | 'S1ChaosCards'
  | 'S2Questions'
  | 'S3QuloReveal'
  | 'S4ProblemFlow'
  | 'S5MatchMoment'
  | 'S6Closing';

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

export type TwitterConfig = {
  durationInFrames: number;
  scenes: SceneSpec[];
  audioTracks?: AudioTrack[];
};
```

- [ ] **Step 6: Placeholder sahnesi yaz**

`entertainment/qulo-twitter-tr/src/scenes/Placeholder.tsx`:
```tsx
import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';

type Props = {label?: string};

export const Placeholder: React.FC<Props> = ({label = 'Placeholder'}) => {
  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        justifyContent: 'center',
        alignItems: 'center',
        fontFamily: theme.fonts.display,
        color: theme.colors.textMuted,
        fontSize: theme.type.body,
        fontWeight: theme.type.weight,
      }}
    >
      {label}
    </AbsoluteFill>
  );
};
```

- [ ] **Step 7: config yaz (başlangıçta tek placeholder, tam 900 frame)**

`entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts`:
```ts
import type {TwitterConfig} from '../types';

const FPS = 30;
const s = (seconds: number) => Math.round(seconds * FPS);

export const twitterConfig: TwitterConfig = {
  durationInFrames: s(30),
  scenes: [
    {component: 'Placeholder', startFrame: s(0), durationFrames: s(30), props: {label: 'Qulo Twitter Ad — iskelet'}},
  ],
};
```

- [ ] **Step 8: QuloTwitterAd oynatıcısını yaz**

`entertainment/qulo-twitter-tr/src/QuloTwitterAd.tsx`:
```tsx
import {AbsoluteFill, Audio, Sequence, staticFile} from 'remotion';
import {theme} from './theme';
import {twitterConfig} from './configs/twitter-tr.config';
import type {SceneSpec} from './types';
import {Placeholder} from './scenes/Placeholder';

const renderScene = (scene: SceneSpec, idx: number) => {
  const props = (scene.props ?? {}) as Record<string, never>;
  const cast = <T,>() => props as unknown as T;
  switch (scene.component) {
    case 'Placeholder':
      return <Placeholder {...cast<React.ComponentProps<typeof Placeholder>>()} />;
    default:
      throw new Error(`Unknown scene component at index ${idx}: ${scene.component}`);
  }
};

export const QuloTwitterAd: React.FC = () => {
  return (
    <AbsoluteFill style={{background: theme.colors.bg}}>
      {twitterConfig.scenes.map((scene, i) => (
        <Sequence
          key={`${scene.component}-${i}-${scene.startFrame}`}
          from={scene.startFrame}
          durationInFrames={scene.durationFrames}
          name={`${i + 1}. ${scene.component}`}
        >
          {renderScene(scene, i)}
        </Sequence>
      ))}

      {twitterConfig.audioTracks?.map((track, i) => (
        <Sequence key={`audio-${i}`} from={track.startFrame ?? 0} name={`Audio ${i + 1}`}>
          <Audio src={staticFile(track.path)} volume={track.volume ?? 1} startFrom={track.startFrom ?? 0} />
        </Sequence>
      ))}
    </AbsoluteFill>
  );
};
```

- [ ] **Step 9: Root.tsx + index.ts yaz**

`entertainment/qulo-twitter-tr/src/Root.tsx`:
```tsx
import {Composition} from 'remotion';
import {QuloTwitterAd} from './QuloTwitterAd';
import {twitterConfig} from './configs/twitter-tr.config';
import {theme} from './theme';

export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="QuloTwitterAd"
      component={QuloTwitterAd}
      durationInFrames={twitterConfig.durationInFrames}
      fps={theme.composition.fps}
      width={theme.composition.width}
      height={theme.composition.height}
    />
  );
};
```

`entertainment/qulo-twitter-tr/src/index.ts`:
```ts
import {registerRoot} from 'remotion';
import {RemotionRoot} from './Root';

registerRoot(RemotionRoot);
```

- [ ] **Step 10: Bağımlılıkları kur**

Run:
```bash
cd entertainment/qulo-twitter-tr && npm install
```
Expected: `node_modules` oluşur, hata yok.

- [ ] **Step 11: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: çıktı yok, exit 0.

- [ ] **Step 12: Composition kayıtlı mı doğrula**

Run: `cd entertainment/qulo-twitter-tr && npx remotion compositions src/index.ts`
Expected: listede `QuloTwitterAd` görünür, `1920x1080`, `900` frame, `30` fps.

- [ ] **Step 13: İlk still render (duman testi)**

Run: `cd entertainment/qulo-twitter-tr && npx remotion still src/index.ts QuloTwitterAd out/_check_t1.png --frame=10`
Expected: `out/_check_t1.png` oluşur (>5KB). Hata yok.

- [ ] **Step 14: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr
git commit -m "feat(twitter-ad): 16:9 TR reklam projesi iskeleti + config-driven oynatıcı"
```

---

### Task 2: Yardımcı bileşenler — StaggerText + ChaosCard

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/components/StaggerText.tsx`
- Create: `entertainment/qulo-twitter-tr/src/components/ChaosCard.tsx`

**Interfaces:**
- Consumes: `theme` (Task 1).
- Produces:
  - `StaggerText` — `{lines: string[]; startFrame?: number; perLineFrames?: number; fontSize?: number; color?: string; accentColor?: string; align?: 'center'|'left'}`. Her satır sırayla fade+rise ile belirir. `accentColor` verilirse `*...*` arası kelimeler vurgu renginde.
  - `ChaosCard` — `{xStart: number; yStart: number; rotateStart: number; driftX: number; driftY: number; driftRotate: number; appearFrame: number; label: string; widthPx?: number}`. Tinder benzeri kart; `appearFrame`'den sonra sahneye girip drift ile savrulur, üstünde sönük kırmızı ✕.

- [ ] **Step 1: StaggerText yaz**

`entertainment/qulo-twitter-tr/src/components/StaggerText.tsx`:
```tsx
import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Props = {
  lines: string[];
  startFrame?: number;
  perLineFrames?: number;
  fontSize?: number;
  color?: string;
  accentColor?: string;
  align?: 'center' | 'left';
};

const renderLine = (line: string, accentColor?: string) => {
  if (!accentColor) return line;
  // *kelime* → accent renkli
  const parts = line.split(/(\*[^*]+\*)/g);
  return parts.map((p, i) =>
    p.startsWith('*') && p.endsWith('*') ? (
      <span key={i} style={{color: accentColor}}>{p.slice(1, -1)}</span>
    ) : (
      <span key={i}>{p}</span>
    ),
  );
};

export const StaggerText: React.FC<Props> = ({
  lines,
  startFrame = 0,
  perLineFrames = 18,
  fontSize = theme.type.title,
  color = theme.colors.text,
  accentColor,
  align = 'center',
}) => {
  const frame = useCurrentFrame();
  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: align === 'center' ? 'center' : 'flex-start',
        textAlign: align,
        gap: 18,
        fontFamily: theme.fonts.display,
        fontWeight: theme.type.weight,
        fontSize,
        color,
        lineHeight: 1.08,
        letterSpacing: -1.5,
      }}
    >
      {lines.map((line, i) => {
        const t = startFrame + i * perLineFrames;
        const opacity = interpolate(frame, [t, t + 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const y = interpolate(frame, [t, t + 12], [28, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        return (
          <div key={i} style={{opacity, transform: `translateY(${y}px)`, textShadow: '0 8px 32px rgba(0,0,0,0.55)'}}>
            {renderLine(line, accentColor)}
          </div>
        );
      })}
    </div>
  );
};
```

- [ ] **Step 2: ChaosCard yaz**

`entertainment/qulo-twitter-tr/src/components/ChaosCard.tsx`:
```tsx
import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  xStart: number;
  yStart: number;
  rotateStart: number;
  driftX: number;
  driftY: number;
  driftRotate: number;
  appearFrame: number;
  label: string;
  widthPx?: number;
};

export const ChaosCard: React.FC<Props> = ({
  xStart,
  yStart,
  rotateStart,
  driftX,
  driftY,
  driftRotate,
  appearFrame,
  label,
  widthPx = 300,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - appearFrame;

  const enter = spring({frame: local, fps, config: {damping: 14, stiffness: 90}, durationInFrames: 20});
  const drift = interpolate(local, [0, 90], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  const x = xStart + driftX * drift;
  const y = yStart + driftY * drift;
  const rot = rotateStart + driftRotate * drift;
  const opacity = interpolate(local, [0, 8, 70, 90], [0, 1, 1, 0.25], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const xMark = interpolate(local, [10, 22], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  if (local < 0) return null;

  return (
    <div
      style={{
        position: 'absolute',
        left: x,
        top: y,
        width: widthPx,
        height: widthPx * 1.4,
        transform: `rotate(${rot}deg) scale(${enter})`,
        opacity,
        borderRadius: theme.radius.lg,
        background: `linear-gradient(160deg, ${theme.colors.surfaceElevated}, ${theme.colors.surface})`,
        border: `1px solid ${theme.colors.border}`,
        boxShadow: '0 30px 60px rgba(0,0,0,0.55)',
        overflow: 'hidden',
      }}
    >
      <div
        style={{
          position: 'absolute',
          bottom: 0,
          width: '100%',
          padding: '16px 18px',
          background: 'linear-gradient(transparent, rgba(0,0,0,0.6))',
          fontFamily: theme.fonts.display,
          fontWeight: 700,
          fontSize: theme.type.small,
          color: theme.colors.text,
        }}
      >
        {label}
      </div>
      <div
        style={{
          position: 'absolute',
          inset: 0,
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          opacity: xMark * 0.85,
        }}
      >
        <div
          style={{
            fontSize: widthPx * 0.6,
            color: theme.colors.danger,
            fontWeight: 900,
            lineHeight: 1,
            transform: `scale(${0.6 + 0.4 * xMark})`,
          }}
        >
          ✕
        </div>
      </div>
    </div>
  );
};
```

- [ ] **Step 3: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: çıktı yok, exit 0. (Bileşenler henüz kullanılmıyor; sadece derlenir.)

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src/components/StaggerText.tsx entertainment/qulo-twitter-tr/src/components/ChaosCard.tsx
git commit -m "feat(twitter-ad): StaggerText + ChaosCard yardimci bilesenleri"
```

---

### Task 3: S1 — Boş Kaos sahnesi (0–4s)

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/scenes/S1ChaosCards.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/QuloTwitterAd.tsx` (import + switch case)
- Modify: `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts` (sahneyi ekle)

**Interfaces:**
- Consumes: `ChaosCard`, `StaggerText` (Task 2), `theme`.
- Produces: `S1ChaosCards` — props yok. 1920×1080 dolu sahne: 6 kart savrulur + altta "Yüzlerce kart." / "Sıfır gerçek eşleşme." yazısı tek tek.

- [ ] **Step 1: S1ChaosCards yaz**

`entertainment/qulo-twitter-tr/src/scenes/S1ChaosCards.tsx`:
```tsx
import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {ChaosCard} from '../components/ChaosCard';
import {StaggerText} from '../components/StaggerText';

const CARDS = [
  {xStart: 760, yStart: 180, rotateStart: -8, driftX: -900, driftY: 120, driftRotate: -40, appearFrame: 0, label: 'Profil'},
  {xStart: 820, yStart: 240, rotateStart: 6, driftX: 1000, driftY: 80, driftRotate: 50, appearFrame: 8, label: 'Profil'},
  {xStart: 780, yStart: 200, rotateStart: -3, driftX: -1100, driftY: -60, driftRotate: -30, appearFrame: 16, label: 'Profil'},
  {xStart: 840, yStart: 260, rotateStart: 10, driftX: 1150, driftY: 160, driftRotate: 60, appearFrame: 24, label: 'Profil'},
  {xStart: 800, yStart: 220, rotateStart: -6, driftX: -1000, driftY: 200, driftRotate: -50, appearFrame: 32, label: 'Profil'},
  {xStart: 810, yStart: 210, rotateStart: 4, driftX: 1080, driftY: -40, driftRotate: 45, appearFrame: 40, label: 'Profil'},
];

export const S1ChaosCards: React.FC = () => {
  return (
    <AbsoluteFill style={{background: `radial-gradient(circle at 50% 35%, ${theme.colors.bgAlt} 0%, ${theme.colors.bg} 70%)`}}>
      {CARDS.map((c, i) => (
        <ChaosCard key={i} {...c} />
      ))}
      <div
        style={{
          position: 'absolute',
          left: 0,
          right: 0,
          bottom: theme.safeZone.bottom + 40,
          display: 'flex',
          justifyContent: 'center',
        }}
      >
        <StaggerText
          lines={['Yüzlerce kart.', 'Sıfır gerçek eşleşme.']}
          startFrame={55}
          perLineFrames={18}
          fontSize={theme.type.title}
          accentColor={theme.colors.danger}
        />
      </div>
    </AbsoluteFill>
  );
};
```
Not: "Sıfır gerçek eşleşme." satırını kırmızı vurgulamak için config'te değil burada `*...*` kullanılmadı; tüm satır beyaz, accent yalnız `*evli*` gibi yerlerde sonraki sahnelerde. S1'de düz beyaz yeterli.

- [ ] **Step 2: Oynatıcıya S1'i bağla**

`QuloTwitterAd.tsx` — import ekle (dosyanın üst import bloğuna):
```tsx
import {S1ChaosCards} from './scenes/S1ChaosCards';
```
`renderScene` switch'ine `default`'tan önce ekle:
```tsx
    case 'S1ChaosCards':
      return <S1ChaosCards />;
```

- [ ] **Step 3: Config'e S1'i koy (placeholder'ı kaldır)**

`configs/twitter-tr.config.ts` içindeki `scenes` dizisini değiştir:
```ts
  scenes: [
    {component: 'S1ChaosCards', startFrame: s(0), durationFrames: s(4)},
    {component: 'Placeholder', startFrame: s(4), durationFrames: s(26), props: {label: 'sonraki sahneler'}},
  ],
```

- [ ] **Step 4: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0.

- [ ] **Step 5: Still render (sahne ortası)**

Run: `cd entertainment/qulo-twitter-tr && npx remotion still src/index.ts QuloTwitterAd out/_check_s1.png --frame=70`
Expected: `out/_check_s1.png` oluşur; kartlar savrulmuş + alt yazı görünür.

- [ ] **Step 6: Studio'da gözle kontrol (manuel)**

Run: `cd entertainment/qulo-twitter-tr && npm run studio`
Kontrol: 0–4s arası kartlar hızlanarak sağa-sola savruluyor, her birinde kırmızı ✕, ~2s'de alt yazı beliriyor. Tarayıcıyı kapat.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src
git commit -m "feat(twitter-ad): S1 bos kaos sahnesi (ucusan kartlar + bos eslesme)"
```

---

### Task 4: S2 — İki Soru sahnesi (4–9s)

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/scenes/S2Questions.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/QuloTwitterAd.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts`

**Interfaces:**
- Consumes: `StaggerText`, `theme`.
- Produces: `S2Questions` — props yok. İki soru sırayla merkezde belirir; ilk soru 0–~2.5s, ikinci soru ~2.5s sonrası.

- [ ] **Step 1: S2Questions yaz**

`entertainment/qulo-twitter-tr/src/scenes/S2Questions.tsx`:
```tsx
import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {StaggerText} from '../components/StaggerText';

export const S2Questions: React.FC = () => {
  const frame = useCurrentFrame();
  // İlk soru: 0–75 frame görünür sonra solar; ikinci soru: 75'ten sonra.
  const q1Opacity = interpolate(frame, [0, 10, 65, 78], [0, 1, 1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const q2Visible = frame >= 75;

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        justifyContent: 'center',
        alignItems: 'center',
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px`,
      }}
    >
      <div style={{position: 'absolute', opacity: q1Opacity, width: '70%', display: 'flex', justifyContent: 'center'}}>
        <StaggerText
          lines={['Bu kısır döngüden', 'sıkılmadınız mı?']}
          startFrame={0}
          perLineFrames={14}
          fontSize={theme.type.title}
        />
      </div>
      {q2Visible ? (
        <div style={{position: 'absolute', width: '78%', display: 'flex', justifyContent: 'center'}}>
          <StaggerText
            lines={['Kriterlerinize gerçekten uyan', 'birini *nasıl* bulursunuz?']}
            startFrame={75}
            perLineFrames={14}
            fontSize={theme.type.title}
            accentColor={theme.colors.green}
          />
        </div>
      ) : null}
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Oynatıcıya bağla**

`QuloTwitterAd.tsx` import:
```tsx
import {S2Questions} from './scenes/S2Questions';
```
switch case:
```tsx
    case 'S2Questions':
      return <S2Questions />;
```

- [ ] **Step 3: Config güncelle**

`configs/twitter-tr.config.ts` `scenes`:
```ts
  scenes: [
    {component: 'S1ChaosCards', startFrame: s(0), durationFrames: s(4)},
    {component: 'S2Questions', startFrame: s(4), durationFrames: s(5)},
    {component: 'Placeholder', startFrame: s(9), durationFrames: s(21), props: {label: 'sonraki sahneler'}},
  ],
```

- [ ] **Step 4: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0.

- [ ] **Step 5: Still render (her iki soru)**

Run:
```bash
cd entertainment/qulo-twitter-tr
npx remotion still src/index.ts QuloTwitterAd out/_check_s2a.png --frame=150
npx remotion still src/index.ts QuloTwitterAd out/_check_s2b.png --frame=240
```
Expected: `_check_s2a.png` ilk soruyu, `_check_s2b.png` ikinci soruyu gösterir.

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src
git commit -m "feat(twitter-ad): S2 iki soru sahnesi (sikilma + kriter sorusu)"
```

---

### Task 5: BrainNetwork bileşeni (nöron/line-up animasyonu)

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/components/BrainNetwork.tsx`

**Interfaces:**
- Consumes: `theme`.
- Produces: `BrainNetwork` — `{startFrame?: number; sizePx?: number}`. SVG: düğümler (nöronlar) sırayla parlar, aralarındaki çizgiler `stroke-dashoffset` ile çizilerek bağlanır (zihinsel uyum metaforu).

- [ ] **Step 1: BrainNetwork yaz**

`entertainment/qulo-twitter-tr/src/components/BrainNetwork.tsx`:
```tsx
import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Props = {startFrame?: number; sizePx?: number};

// Basit nöron ağı: normalize (0..1) koordinatlar.
const NODES = [
  {x: 0.2, y: 0.35},
  {x: 0.4, y: 0.2},
  {x: 0.55, y: 0.45},
  {x: 0.35, y: 0.6},
  {x: 0.65, y: 0.7},
  {x: 0.78, y: 0.4},
  {x: 0.5, y: 0.78},
];
const EDGES: Array<[number, number]> = [
  [0, 1], [1, 2], [2, 3], [3, 0], [2, 5], [4, 2], [4, 6], [3, 6], [5, 4],
];

export const BrainNetwork: React.FC<Props> = ({startFrame = 0, sizePx = 620}) => {
  const frame = useCurrentFrame();
  const local = frame - startFrame;
  const S = sizePx;

  return (
    <svg width={S} height={S} viewBox="0 0 1 1" style={{overflow: 'visible'}}>
      {EDGES.map(([a, b], i) => {
        const t = i * 5; // her kenar sırayla
        const progress = interpolate(local, [t, t + 16], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const na = NODES[a];
        const nb = NODES[b];
        return (
          <line
            key={i}
            x1={na.x}
            y1={na.y}
            x2={interpolate(progress, [0, 1], [na.x, nb.x])}
            y2={interpolate(progress, [0, 1], [na.y, nb.y])}
            stroke={theme.colors.green}
            strokeWidth={0.006}
            strokeLinecap="round"
            opacity={0.55 * progress + 0.15}
          />
        );
      })}
      {NODES.map((n, i) => {
        const t = i * 5;
        const pop = interpolate(local, [t, t + 12], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
        const pulse = 1 + 0.15 * Math.sin((local + i * 7) / 6);
        return (
          <circle
            key={i}
            cx={n.x}
            cy={n.y}
            r={0.018 * pop * pulse}
            fill={i % 2 === 0 ? theme.colors.green : theme.colors.purple}
            opacity={pop}
            style={{filter: 'drop-shadow(0 0 6px rgba(105,240,174,0.7))'}}
          />
        );
      })}
    </svg>
  );
};
```

- [ ] **Step 2: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0.

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src/components/BrainNetwork.tsx
git commit -m "feat(twitter-ad): BrainNetwork noron line-up animasyonu"
```

---

### Task 6: PhoneFrame + QuizSolveMini bileşenleri

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/components/PhoneFrame.tsx`
- Create: `entertainment/qulo-twitter-tr/src/components/QuizSolveMini.tsx`

**Interfaces:**
- Consumes: `theme`.
- Produces:
  - `PhoneFrame` — `{children: React.ReactNode; heightPx?: number}`. Portrait telefon çerçevesi (16:9 içinde merkeze/yana yerleştirilebilir); `heightPx` ile ölçeklenir, en-boy 0.49.
  - `QuizSolveMini` — `{question: string; options: string[]; correctIndex: number; startFrame?: number; perItemFrames?: number}`. Telefon ekranı içeriği: soru başlığı + seçenekler; her seçenek sırayla, doğru olan yeşil tick alır.

- [ ] **Step 1: PhoneFrame yaz**

`entertainment/qulo-twitter-tr/src/components/PhoneFrame.tsx`:
```tsx
import {theme} from '../theme';

type Props = {children: React.ReactNode; heightPx?: number};

export const PhoneFrame: React.FC<Props> = ({children, heightPx = 760}) => {
  const h = heightPx;
  const w = Math.round(h * 0.49);
  const bezel = Math.round(h * 0.012);
  const radius = Math.round(h * 0.07);
  return (
    <div
      style={{
        width: w,
        height: h,
        borderRadius: radius,
        background: '#000',
        padding: bezel,
        boxShadow: '0 40px 80px rgba(0,0,0,0.7), 0 0 0 3px #2a2a2a, 0 0 90px rgba(187,134,252,0.22)',
        position: 'relative',
      }}
    >
      <div
        style={{
          width: '100%',
          height: '100%',
          borderRadius: radius - bezel,
          background: theme.colors.bg,
          overflow: 'hidden',
          position: 'relative',
        }}
      >
        {children}
      </div>
    </div>
  );
};
```

- [ ] **Step 2: QuizSolveMini yaz**

`entertainment/qulo-twitter-tr/src/components/QuizSolveMini.tsx`:
```tsx
import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  question: string;
  options: string[];
  correctIndex: number;
  startFrame?: number;
  perItemFrames?: number;
};

export const QuizSolveMini: React.FC<Props> = ({
  question,
  options,
  correctIndex,
  startFrame = 0,
  perItemFrames = 16,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - startFrame;

  return (
    <div style={{padding: 28, height: '100%', display: 'flex', flexDirection: 'column', gap: 18}}>
      <div
        style={{
          fontFamily: theme.fonts.display,
          fontWeight: 700,
          fontSize: 30,
          color: theme.colors.text,
          lineHeight: 1.2,
          marginTop: 24,
        }}
      >
        {question}
      </div>
      <div style={{display: 'flex', flexDirection: 'column', gap: 14, marginTop: 8}}>
        {options.map((opt, i) => {
          const t = i * perItemFrames;
          const appear = interpolate(local, [t, t + 8], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
          const isCorrect = i === correctIndex;
          const checkT = t + 8;
          const check = spring({frame: local - checkT, fps, config: {damping: 12}, durationInFrames: 12});
          const solved = isCorrect && local >= checkT;
          return (
            <div
              key={i}
              style={{
                opacity: appear,
                transform: `translateX(${(1 - appear) * 20}px)`,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                padding: '16px 18px',
                borderRadius: theme.radius.md,
                background: solved ? 'rgba(105,240,174,0.14)' : theme.colors.surface,
                border: `2px solid ${solved ? theme.colors.green : theme.colors.border}`,
                fontFamily: theme.fonts.body,
                fontSize: 24,
                color: theme.colors.text,
              }}
            >
              <span>{opt}</span>
              {solved ? (
                <span style={{color: theme.colors.green, fontSize: 28, transform: `scale(${check})`}}>✓</span>
              ) : null}
            </div>
          );
        })}
      </div>
    </div>
  );
};
```

- [ ] **Step 3: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0.

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src/components/PhoneFrame.tsx entertainment/qulo-twitter-tr/src/components/QuizSolveMini.tsx
git commit -m "feat(twitter-ad): PhoneFrame + QuizSolveMini (tick'lenen sorular)"
```

---

### Task 7: S3 — Qulo Doğuşu sahnesi (9–15s)

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/scenes/S3QuloReveal.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/QuloTwitterAd.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts`

**Interfaces:**
- Consumes: `BrainNetwork` (Task 5), `PhoneFrame`+`QuizSolveMini` (Task 6), `StaggerText`, `theme`, `staticFile` (logo).
- Produces: `S3QuloReveal` — props yok. Sol: logo glow + BrainNetwork + "Qulo geldi. / Kaydırma. Çöz." yazısı. Sağ: PhoneFrame içinde QuizSolveMini tick animasyonu.

- [ ] **Step 1: S3QuloReveal yaz**

`entertainment/qulo-twitter-tr/src/scenes/S3QuloReveal.tsx`:
```tsx
import {AbsoluteFill, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig, Img} from 'remotion';
import {theme} from '../theme';
import {BrainNetwork} from '../components/BrainNetwork';
import {PhoneFrame} from '../components/PhoneFrame';
import {QuizSolveMini} from '../components/QuizSolveMini';
import {StaggerText} from '../components/StaggerText';

export const S3QuloReveal: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const logoScale = spring({frame, fps, from: 0.5, to: 1, config: {damping: 13}, durationInFrames: 24});
  const glow = interpolate(frame, [0, 20], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const phoneIn = spring({frame: frame - 30, fps, from: 0, to: 1, config: {damping: 16}, durationInFrames: 24});

  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(circle at 30% 40%, rgba(105,240,174,0.10), ${theme.colors.bg} 60%)`,
        flexDirection: 'row',
        alignItems: 'center',
        padding: `0 ${theme.safeZone.horizontal}px`,
      }}
    >
      {/* Sol kolon */}
      <div style={{flex: 1, display: 'flex', flexDirection: 'column', gap: 28, position: 'relative'}}>
        <div style={{position: 'absolute', top: -120, left: -40, opacity: 0.6}}>
          <BrainNetwork startFrame={6} sizePx={560} />
        </div>
        <div style={{display: 'flex', alignItems: 'center', gap: 24, transform: `scale(${logoScale})`, transformOrigin: 'left center'}}>
          <Img
            src={staticFile('brand/qulo_logo.svg')}
            style={{width: 240, filter: `drop-shadow(0 0 ${20 * glow}px rgba(105,240,174,${0.6 * glow}))`}}
          />
        </div>
        <StaggerText
          lines={['Qulo geldi.', 'Kaydırma. *Çöz.*']}
          startFrame={18}
          perLineFrames={14}
          fontSize={theme.type.title}
          accentColor={theme.colors.green}
          align="left"
        />
        <div style={{marginTop: 8}}>
          <StaggerText
            lines={['Sorunu sor. Çözen eşleşir.']}
            startFrame={50}
            fontSize={theme.type.body}
            color={theme.colors.textMuted}
            align="left"
          />
        </div>
      </div>

      {/* Sağ kolon — telefon */}
      <div style={{flex: 1, display: 'flex', justifyContent: 'center', opacity: phoneIn, transform: `translateY(${(1 - phoneIn) * 40}px)`}}>
        <PhoneFrame heightPx={820}>
          <QuizSolveMini
            question="Bir ilişkide senin için en önemli şey ne?"
            options={['Dürüstlük', 'Macera', 'Sadakat', 'Mizah']}
            correctIndex={0}
            startFrame={36}
            perItemFrames={16}
          />
        </PhoneFrame>
      </div>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Oynatıcıya bağla**

`QuloTwitterAd.tsx` import:
```tsx
import {S3QuloReveal} from './scenes/S3QuloReveal';
```
switch case:
```tsx
    case 'S3QuloReveal':
      return <S3QuloReveal />;
```

- [ ] **Step 3: Config güncelle**

`configs/twitter-tr.config.ts` `scenes`:
```ts
  scenes: [
    {component: 'S1ChaosCards', startFrame: s(0), durationFrames: s(4)},
    {component: 'S2Questions', startFrame: s(4), durationFrames: s(5)},
    {component: 'S3QuloReveal', startFrame: s(9), durationFrames: s(6)},
    {component: 'Placeholder', startFrame: s(15), durationFrames: s(15), props: {label: 'sonraki sahneler'}},
  ],
```

- [ ] **Step 4: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0.

- [ ] **Step 5: Still render (logo+brain+tick)**

Run:
```bash
cd entertainment/qulo-twitter-tr
npx remotion still src/index.ts QuloTwitterAd out/_check_s3a.png --frame=300
npx remotion still src/index.ts QuloTwitterAd out/_check_s3b.png --frame=420
```
Expected: `_check_s3a.png` logo+beyin+telefon erken; `_check_s3b.png` tick'lenmiş seçenekler (Dürüstlük ✓).

- [ ] **Step 6: Studio gözle kontrol (manuel)** — logo glow ile beliriyor, beyin çizgileri bağlanıyor, telefonda doğru cevap yeşil tick alıyor.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src
git commit -m "feat(twitter-ad): S3 Qulo dogusu (logo glow + beyin + tick'lenen sorular)"
```

---

### Task 8: ProblemFlow bileşeni + S4 sahnesi (15–23s)

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/components/ProblemRow.tsx`
- Create: `entertainment/qulo-twitter-tr/src/scenes/S4ProblemFlow.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/QuloTwitterAd.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts`

**Interfaces:**
- Consumes: `StaggerText`, `theme`.
- Produces:
  - `ProblemRow` — `{text: string; appearFrame: number; solveFrame: number}`. Kırmızı problem cümlesi kayarak girer; `solveFrame`'de üstüne yeşil ✓ damgalanır, cümle griye solar (üstü çizili).
  - `S4ProblemFlow` — props yok. 3 problem ardı ardına + kapanış "Hepsi tek bir doğru soruyla elenir."

- [ ] **Step 1: ProblemRow yaz**

`entertainment/qulo-twitter-tr/src/components/ProblemRow.tsx`:
```tsx
import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {text: string; appearFrame: number; solveFrame: number};

export const ProblemRow: React.FC<Props> = ({text, appearFrame, solveFrame}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const appear = interpolate(frame, [appearFrame, appearFrame + 10], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const solved = frame >= solveFrame;
  const check = spring({frame: frame - solveFrame, fps, config: {damping: 12}, durationInFrames: 12});
  const dim = interpolate(frame, [solveFrame, solveFrame + 12], [1, 0.45], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <div
      style={{
        opacity: appear * dim,
        transform: `translateX(${(1 - appear) * -40}px)`,
        display: 'flex',
        alignItems: 'center',
        gap: 24,
        padding: '22px 30px',
        borderRadius: theme.radius.lg,
        background: solved ? 'rgba(105,240,174,0.08)' : 'rgba(207,102,121,0.12)',
        border: `2px solid ${solved ? theme.colors.green : theme.colors.danger}`,
        fontFamily: theme.fonts.display,
        fontWeight: 700,
        fontSize: theme.type.body,
        color: theme.colors.text,
        textDecoration: solved ? 'line-through' : 'none',
        textDecorationColor: theme.colors.textMuted,
      }}
    >
      <span style={{flex: 1}}>{text}</span>
      {solved ? (
        <span style={{color: theme.colors.green, fontSize: theme.type.title, transform: `scale(${check})`}}>✓</span>
      ) : (
        <span style={{color: theme.colors.danger, fontSize: theme.type.title}}>✕</span>
      )}
    </div>
  );
};
```

- [ ] **Step 2: S4ProblemFlow yaz**

`entertainment/qulo-twitter-tr/src/scenes/S4ProblemFlow.tsx`:
```tsx
import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {ProblemRow} from '../components/ProblemRow';

// Sahne yerel frame (S4 = 240 frame, 8s).
const PROBLEMS = [
  {text: 'Sevgili sandığın kişi evli çıktı.', appearFrame: 8, solveFrame: 55},
  {text: 'İlk buluşmada centilmen, sonra maço.', appearFrame: 38, solveFrame: 85},
  {text: 'Egosuz sanmıştın… değilmiş.', appearFrame: 68, solveFrame: 115},
];

export const S4ProblemFlow: React.FC = () => {
  const frame = useCurrentFrame();
  const closing = interpolate(frame, [150, 165], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        justifyContent: 'center',
        alignItems: 'center',
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px`,
      }}
    >
      <div style={{display: 'flex', flexDirection: 'column', gap: 22, width: '74%'}}>
        {PROBLEMS.map((p, i) => (
          <ProblemRow key={i} {...p} />
        ))}
        <div
          style={{
            marginTop: 28,
            textAlign: 'center',
            opacity: closing,
            transform: `translateY(${(1 - closing) * 20}px)`,
            fontFamily: theme.fonts.display,
            fontWeight: theme.type.weight,
            fontSize: theme.type.title,
            color: theme.colors.green,
          }}
        >
          Hepsi tek bir doğru soruyla elenir.
        </div>
      </div>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 3: Oynatıcıya bağla**

`QuloTwitterAd.tsx` import:
```tsx
import {S4ProblemFlow} from './scenes/S4ProblemFlow';
```
switch case:
```tsx
    case 'S4ProblemFlow':
      return <S4ProblemFlow />;
```

- [ ] **Step 4: Config güncelle**

`configs/twitter-tr.config.ts` `scenes`:
```ts
  scenes: [
    {component: 'S1ChaosCards', startFrame: s(0), durationFrames: s(4)},
    {component: 'S2Questions', startFrame: s(4), durationFrames: s(5)},
    {component: 'S3QuloReveal', startFrame: s(9), durationFrames: s(6)},
    {component: 'S4ProblemFlow', startFrame: s(15), durationFrames: s(8)},
    {component: 'Placeholder', startFrame: s(23), durationFrames: s(7), props: {label: 'sonraki sahneler'}},
  ],
```

- [ ] **Step 5: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0.

- [ ] **Step 6: Still render**

Run:
```bash
cd entertainment/qulo-twitter-tr
npx remotion still src/index.ts QuloTwitterAd out/_check_s4a.png --frame=520
npx remotion still src/index.ts QuloTwitterAd out/_check_s4b.png --frame=680
```
Expected: `_check_s4a.png` problemler kırmızı/çözülürken; `_check_s4b.png` hepsi ✓ + "Hepsi tek bir doğru soruyla elenir." yeşil.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src
git commit -m "feat(twitter-ad): S4 problem akisi (kirmizi problem -> yesil tick eleme)"
```

---

### Task 9: MatchPop bileşeni + S5 sahnesi (23–27s)

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/components/MatchPop.tsx`
- Create: `entertainment/qulo-twitter-tr/src/scenes/S5MatchMoment.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/QuloTwitterAd.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts`

**Interfaces:**
- Consumes: `PhoneFrame`, `QuizSolveMini`, `theme`. **Elmas YOK** — kutlama yeşil parıltı + spark div'leri.
- Produces:
  - `MatchPop` — `{startFrame?: number; label?: string}`. Merkez "Eşleşme!" yazısı spring ile büyür + radyal yeşil glow + dışa açılan spark çizgileri.
  - `S5MatchMoment` — props yok. Telefonda tüm tick'ler yeşil → ortada MatchPop + altta "Doğru soruyu soran, doğru insanı bulur."

- [ ] **Step 1: MatchPop yaz**

`entertainment/qulo-twitter-tr/src/components/MatchPop.tsx`:
```tsx
import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {startFrame?: number; label?: string};

const SPARKS = Array.from({length: 12}, (_, i) => (i * 360) / 12);

export const MatchPop: React.FC<Props> = ({startFrame = 0, label = 'Eşleşme!'}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const local = frame - startFrame;
  if (local < 0) return null;

  const scale = spring({frame: local, fps, from: 0.3, to: 1, config: {damping: 11, stiffness: 140}, durationInFrames: 20});
  const glow = interpolate(local, [0, 16], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const sparkDist = interpolate(local, [4, 30], [0, 220], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  const sparkOpacity = interpolate(local, [4, 18, 36], [0, 1, 0], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <div style={{position: 'relative', display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
      <div
        style={{
          position: 'absolute',
          width: 520,
          height: 520,
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
            height: 26,
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

- [ ] **Step 2: S5MatchMoment yaz**

`entertainment/qulo-twitter-tr/src/scenes/S5MatchMoment.tsx`:
```tsx
import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {PhoneFrame} from '../components/PhoneFrame';
import {QuizSolveMini} from '../components/QuizSolveMini';
import {MatchPop} from '../components/MatchPop';
import {StaggerText} from '../components/StaggerText';

export const S5MatchMoment: React.FC = () => {
  const frame = useCurrentFrame();
  const phoneFade = interpolate(frame, [40, 55], [1, 0.25], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(circle at 50% 45%, rgba(105,240,174,0.08), ${theme.colors.bg} 60%)`,
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      <div style={{position: 'absolute', opacity: phoneFade}}>
        <PhoneFrame heightPx={720}>
          <QuizSolveMini
            question="Hayalindeki ilk buluşma nasıl olurdu?"
            options={['Sahilde yürüyüş', 'Konser', 'Kahve & sohbet', 'Yemek']}
            correctIndex={2}
            startFrame={0}
            perItemFrames={9}
          />
        </PhoneFrame>
      </div>
      <div style={{position: 'absolute'}}>
        <MatchPop startFrame={45} />
      </div>
      <div style={{position: 'absolute', bottom: theme.safeZone.bottom + 20, width: '70%', display: 'flex', justifyContent: 'center'}}>
        <StaggerText
          lines={['Doğru soruyu soran, *doğru insanı* bulur.']}
          startFrame={70}
          fontSize={theme.type.body}
          accentColor={theme.colors.green}
        />
      </div>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 3: Oynatıcıya bağla**

`QuloTwitterAd.tsx` import:
```tsx
import {S5MatchMoment} from './scenes/S5MatchMoment';
```
switch case:
```tsx
    case 'S5MatchMoment':
      return <S5MatchMoment />;
```

- [ ] **Step 4: Config güncelle**

`configs/twitter-tr.config.ts` `scenes`:
```ts
  scenes: [
    {component: 'S1ChaosCards', startFrame: s(0), durationFrames: s(4)},
    {component: 'S2Questions', startFrame: s(4), durationFrames: s(5)},
    {component: 'S3QuloReveal', startFrame: s(9), durationFrames: s(6)},
    {component: 'S4ProblemFlow', startFrame: s(15), durationFrames: s(8)},
    {component: 'S5MatchMoment', startFrame: s(23), durationFrames: s(4)},
    {component: 'Placeholder', startFrame: s(27), durationFrames: s(3), props: {label: 'kapanis'}},
  ],
```

- [ ] **Step 5: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0.

- [ ] **Step 6: Still render**

Run: `cd entertainment/qulo-twitter-tr && npx remotion still src/index.ts QuloTwitterAd out/_check_s5.png --frame=750`
Expected: "Eşleşme!" pop'u + yeşil glow + spark'lar + alt yazı; **elmas yok**.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src
git commit -m "feat(twitter-ad): S5 cozum ani (match pop + yesil spark, elmas yok)"
```

---

### Task 10: StoreBadges + S6 Kapanış sahnesi (27–30s)

**Files:**
- Create: `entertainment/qulo-twitter-tr/src/components/StoreBadges.tsx`
- Create: `entertainment/qulo-twitter-tr/src/scenes/S6Closing.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/QuloTwitterAd.tsx`
- Modify: `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts`

**Interfaces:**
- Consumes: `theme`, `staticFile` (logo).
- Produces:
  - `StoreBadges` — `{startFrame?: number}`. App Store + Google Play stilize badge butonları (self-contained, kod ile; resmi PNG sonradan değiştirilebilir).
  - `S6Closing` — props yok. Ortada logo + motto "Doğru soru, doğru insan." + StoreBadges.

- [ ] **Step 1: StoreBadges yaz**

`entertainment/qulo-twitter-tr/src/components/StoreBadges.tsx`:
```tsx
import {interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

type Props = {startFrame?: number};

const Badge: React.FC<{top: string; bottom: string; glyph: string}> = ({top, bottom, glyph}) => (
  <div
    style={{
      display: 'flex',
      alignItems: 'center',
      gap: 16,
      padding: '16px 28px',
      borderRadius: theme.radius.md,
      background: '#000',
      border: '1px solid #333',
      minWidth: 280,
    }}
  >
    <div style={{fontSize: 44, lineHeight: 1, color: theme.colors.text}}>{glyph}</div>
    <div style={{display: 'flex', flexDirection: 'column', fontFamily: theme.fonts.body, color: theme.colors.text}}>
      <span style={{fontSize: 18, opacity: 0.8}}>{top}</span>
      <span style={{fontSize: 30, fontWeight: 700}}>{bottom}</span>
    </div>
  </div>
);

export const StoreBadges: React.FC<Props> = ({startFrame = 0}) => {
  const frame = useCurrentFrame();
  const appear = interpolate(frame, [startFrame, startFrame + 14], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});
  return (
    <div style={{display: 'flex', gap: 28, opacity: appear, transform: `translateY(${(1 - appear) * 24}px)`}}>
      <Badge top="App Store'dan" bottom="İndir" glyph=""></Badge>
      <Badge top="Google Play'den" bottom="İndir" glyph="▶"></Badge>
    </div>
  );
};
```
Not: Resmi Apple/Google badge PNG'leri elde edilirse `public/brand/badges/` altına konup `<Img>` ile değiştirilebilir (marka guideline uyumu için tercih edilir). Bu kod-tabanlı versiyon ilk render'ı bloklamadan ilerletir.

- [ ] **Step 2: S6Closing yaz**

`entertainment/qulo-twitter-tr/src/scenes/S6Closing.tsx`:
```tsx
import {AbsoluteFill, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig, Img} from 'remotion';
import {theme} from '../theme';
import {StoreBadges} from '../components/StoreBadges';

export const S6Closing: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const logoScale = spring({frame, fps, from: 0.6, to: 1, config: {damping: 13}, durationInFrames: 20});
  const motto = interpolate(frame, [20, 34], [0, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(circle at 50% 45%, rgba(105,240,174,0.08), ${theme.colors.bg} 65%)`,
        justifyContent: 'center',
        alignItems: 'center',
        gap: 40,
      }}
    >
      <Img
        src={staticFile('brand/qulo_logo.svg')}
        style={{width: 360, transform: `scale(${logoScale})`, filter: 'drop-shadow(0 0 30px rgba(105,240,174,0.4))'}}
      />
      <div
        style={{
          opacity: motto,
          transform: `translateY(${(1 - motto) * 18}px)`,
          fontFamily: theme.fonts.display,
          fontWeight: theme.type.weight,
          fontSize: theme.type.title,
          color: theme.colors.text,
          letterSpacing: -1.5,
        }}
      >
        Doğru soru, doğru insan.
      </div>
      <StoreBadges startFrame={40} />
    </AbsoluteFill>
  );
};
```

- [ ] **Step 3: Oynatıcıya bağla + Placeholder importunu kaldır**

`QuloTwitterAd.tsx`:
- `import {Placeholder} from './scenes/Placeholder';` satırını sil.
- `import {S6Closing} from './scenes/S6Closing';` ekle.
- switch'teki `case 'Placeholder':` bloğunu sil, yerine:
```tsx
    case 'S6Closing':
      return <S6Closing />;
```

- [ ] **Step 4: Config güncelle (tüm sahneler, placeholder yok)**

`configs/twitter-tr.config.ts` `scenes`:
```ts
  scenes: [
    {component: 'S1ChaosCards', startFrame: s(0), durationFrames: s(4)},
    {component: 'S2Questions', startFrame: s(4), durationFrames: s(5)},
    {component: 'S3QuloReveal', startFrame: s(9), durationFrames: s(6)},
    {component: 'S4ProblemFlow', startFrame: s(15), durationFrames: s(8)},
    {component: 'S5MatchMoment', startFrame: s(23), durationFrames: s(4)},
    {component: 'S6Closing', startFrame: s(27), durationFrames: s(3)},
  ],
```
Ayrıca `types.ts`'ten `'Placeholder'` union üyesini sil ve `scenes/Placeholder.tsx` dosyasını sil:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git rm entertainment/qulo-twitter-tr/src/scenes/Placeholder.tsx
```
`types.ts` `SceneComponent` union'dan `| 'Placeholder'` satırını çıkar.

- [ ] **Step 5: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0 (Placeholder referansı kalmamalı).

- [ ] **Step 6: Still render**

Run: `cd entertainment/qulo-twitter-tr && npx remotion still src/index.ts QuloTwitterAd out/_check_s6.png --frame=870`
Expected: logo + "Doğru soru, doğru insan." + iki store badge.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src
git commit -m "feat(twitter-ad): S6 kapanis (logo + motto + store badge'leri), placeholder kaldirildi"
```

---

### Task 11: Sessiz tam render + timing doğrulama

**Files:**
- Modify: (gerekirse) `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts` (timing ince ayar)

**Interfaces:**
- Consumes: tüm sahneler (Task 3–10).
- Produces: `out/qulo-twitter-tr-30s-16x9-silent.mp4` — sessiz tam video (ses Task 13'te eklenir).

- [ ] **Step 1: Tam sessiz render**

Run:
```bash
cd entertainment/qulo-twitter-tr
npx remotion render src/index.ts QuloTwitterAd out/qulo-twitter-tr-30s-16x9-silent.mp4
```
Expected: render tamamlanır, hata yok, `out/qulo-twitter-tr-30s-16x9-silent.mp4` oluşur.

- [ ] **Step 2: Çıktı metadata doğrula**

Run:
```bash
cd entertainment/qulo-twitter-tr
ls -lh out/qulo-twitter-tr-30s-16x9-silent.mp4
ffprobe -v error -select_streams v:0 -show_entries stream=width,height,r_frame_rate -show_entries format=duration -of default=noprint_wrappers=1 out/qulo-twitter-tr-30s-16x9-silent.mp4
```
Expected: width=1920, height=1080, r_frame_rate=30/1, duration≈30.0, boyut > 2MB.

- [ ] **Step 3: Sahne geçişlerini gözle kontrol (manuel)**

Videoyu aç (`open out/qulo-twitter-tr-30s-16x9-silent.mp4`). Kontrol listesi:
- 0–4s kart kaosu hook tutuyor mu
- 4–9s iki soru okunuyor mu
- 9–15s Qulo reveal + tick net mi
- 15–23s 3 problem ritmik elenip "Hepsi tek bir doğru soruyla elenir." çıkıyor mu
- 23–27s "Eşleşme!" pop'u (elmas yok)
- 27–30s logo + motto + badge'ler okunuyor mu
- Hiçbir yerde İngilizce metin / elmas görseli YOK

Sorun olan sahnenin frame aralığını not et; gerekiyorsa config'te `startFrame`/`durationFrames` ±15 frame ayarla (toplam 900 frame korunmalı; bir sahneyi uzatırsan komşusunu kısalt) ve Step 1'i tekrarla.

- [ ] **Step 4: Commit (config ayarı yapıldıysa)**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts
git commit -m "fix(twitter-ad): sahne timing ince ayari (sessiz render dogrulamasi)"
```
(Ayar gerekmediyse bu adımı atla.)

---

### Task 12: Türkçe karakter (ı/İ) render kontrolü

**Files:**
- (Gerekirse) `entertainment/qulo-twitter-tr/src/theme.ts` (font fallback)

**Interfaces:**
- Consumes: tüm metin sahneleri.
- Produces: Türkçe glyph doğrulaması; gerekirse font düzeltmesi.

- [ ] **Step 1: Türkçe-yoğun frame still'leri**

Run:
```bash
cd entertainment/qulo-twitter-tr
npx remotion still src/index.ts QuloTwitterAd out/_tr_s2.png --frame=240
npx remotion still src/index.ts QuloTwitterAd out/_tr_s4.png --frame=680
npx remotion still src/index.ts QuloTwitterAd out/_tr_s6.png --frame=870
```
Expected: PNG'lerde "sıkılmadınız", "çıktı", "değilmiş", "Doğru" kelimelerinde ı/İ/ç/ğ/ş doğru görünür (noktasız ı vs noktalı i ayrımı net).

- [ ] **Step 2: Görsel doğrula (manuel)** — PNG'leri aç, Türkçe karakterler bozuk/eksik değilse Task tamam.

- [ ] **Step 3: (Yalnız sorun varsa) Font fallback uygula**

Sorun varsa `theme.ts`'te Poppins import'unu Montserrat ile değiştir:
```ts
import {loadFont} from '@remotion/google-fonts/Montserrat';
```
ve `loadFont`'taki weight listesini aynı bırak. Step 1'i tekrarla.

- [ ] **Step 4: Commit (değişiklik yapıldıysa)**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/src/theme.ts
git commit -m "fix(twitter-ad): Turkce glyph icin font fallback"
```
(Değişiklik gerekmediyse atla.)

---

### Task 13: Ses entegrasyonu (TR VO + müzik) + final render

**Files:**
- Create: `entertainment/qulo-twitter-tr/prompts/elevenlabs-vo-tr.md`
- Create: `entertainment/qulo-twitter-tr/public/audio/vo_tr_final.mp3` (kullanıcı üretir)
- Create: `entertainment/qulo-twitter-tr/public/audio/music_30s.mp3` (kullanıcı üretir/seçer)
- Modify: `entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts` (audioTracks)

**Interfaces:**
- Consumes: `twitterConfig` (audioTracks alanı — Task 1'de tanımlı).
- Produces: `out/qulo-twitter-tr-30s-16x9.mp4` — sesli final.

- [ ] **Step 1: VO script dosyasını yaz**

`entertainment/qulo-twitter-tr/prompts/elevenlabs-vo-tr.md`:
```markdown
# Qulo Twitter Reklamı — Türkçe Voiceover Script

**Ses:** Türkçe, kendinden emin & sıcak ton, orta tempo. İki ses dene (1 kadın + 1 erkek), render'da seç.
**Çıktı:** public/audio/vo_tr_final.mp3 — 30sn, sessizlikle padlenmiş.

| Saniye | Replik |
|---|---|
| 0.5 | Sağa kaydır. |
| 1.5 | Sola kaydır. |
| 2.5 | Sağa, sola… |
| 4.5 | Bu kısır döngüden sıkılmadınız mı? |
| 6.8 | Kriterlerinize gerçekten uyan birini nasıl bulursunuz? |
| 9.5 | Qulo geldi. Artık kaydırmıyorsun — çözüyorsun. |
| 12.5 | Sorunu sor. Çözen eşleşir. |
| 15.5 | Sevgili sandığın evli çıktı. |
| 17.5 | İlk buluşmada centilmen, sonra maço. |
| 19.5 | Egosuz sanmıştın… değilmiş. |
| 21.5 | Qulo'da hepsi tek bir doğru soruyla elenir. |
| 24.0 | Doğru soruyu soran, doğru insanı bulur. |
| 28.0 | Doğru soru, doğru insan. Qulo. |
```

- [ ] **Step 2: (Kullanıcı checkpoint) Ses dosyalarını yerleştir**

Kullanıcı `vo_tr_final.mp3` ve `music_30s.mp3` dosyalarını `entertainment/qulo-twitter-tr/public/audio/` altına koyar. Müzik için `entertainment/assets/` altındaki hazır mp3'ler de değerlendirilebilir (kopyalanır).

Run (doğrula):
```bash
cd entertainment/qulo-twitter-tr && ls -lh public/audio/
```
Expected: `vo_tr_final.mp3` ve `music_30s.mp3` mevcut.

- [ ] **Step 3: Config'e audioTracks ekle**

`configs/twitter-tr.config.ts` — `scenes` dizisinden sonra `durationInFrames`'i koruyarak `audioTracks` alanı ekle:
```ts
  audioTracks: [
    {path: 'audio/music_30s.mp3', volume: 0.35, startFrame: 0},
    {path: 'audio/vo_tr_final.mp3', volume: 1.0, startFrame: 0},
  ],
```

- [ ] **Step 4: Tip kontrolü**

Run: `cd entertainment/qulo-twitter-tr && npm run typecheck`
Expected: exit 0.

- [ ] **Step 5: Final render (sesli)**

Run:
```bash
cd entertainment/qulo-twitter-tr
npx remotion render src/index.ts QuloTwitterAd out/qulo-twitter-tr-30s-16x9.mp4
```
Expected: render tamamlanır, `out/qulo-twitter-tr-30s-16x9.mp4` oluşur.

- [ ] **Step 6: Ses+video doğrula**

Run:
```bash
cd entertainment/qulo-twitter-tr
ffprobe -v error -show_entries stream=codec_type,codec_name -of default=noprint_wrappers=1 out/qulo-twitter-tr-30s-16x9.mp4
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 out/qulo-twitter-tr-30s-16x9.mp4
```
Expected: bir `video` (h264) + bir `audio` (aac) stream; duration≈30.0.

- [ ] **Step 7: Final gözle kontrol (manuel)** — `open out/qulo-twitter-tr-30s-16x9.mp4`: VO sahnelerle senkron mu, müzik dengesi iyi mi, ses kapalıyken yazılar mesajı tam taşıyor mu.

- [ ] **Step 8: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/prompts entertainment/qulo-twitter-tr/src/configs/twitter-tr.config.ts
git commit -m "feat(twitter-ad): TR VO + muzik entegrasyonu + final render"
```
Not: `public/audio/*.mp3` ve `out/*.mp4` `.gitignore`'da; commit'e ses/video binary'leri girmez (kasıtlı).

---

### Task 14: README + Twitter upload hazırlığı

**Files:**
- Create: `entertainment/qulo-twitter-tr/README.md`

**Interfaces:**
- Consumes: tüm pipeline.
- Produces: workflow dokümanı.

- [ ] **Step 1: README yaz**

`entertainment/qulo-twitter-tr/README.md`:
```markdown
# Qulo Twitter Reklamı — TR, 16:9, 30sn

Türkçe, yatay (1920×1080) Qulo tanıtım videosu. Remotion (React → ffmpeg).

## Spec & Plan
- Spec: `docs/superpowers/specs/2026-06-27-twitter-promo-tr-16x9-design.md`
- Plan: `docs/superpowers/plans/2026-06-27-twitter-promo-tr-16x9.md`

## Komutlar
- `npm install` — bağımlılıklar
- `npm run studio` — canlı önizleme
- `npm run compositions` — composition listesi
- `npm run still -- out/frame.png --frame=N` — tek frame PNG
- `npm run render` — final MP4 (out/qulo-twitter-tr-30s-16x9.mp4)

## Sahneler (config: src/configs/twitter-tr.config.ts)
1. S1 Boş Kaos (0–4s) — uçuşan kartlar, sıfır eşleşme
2. S2 İki Soru (4–9s) — sıkılma + kriter sorusu
3. S3 Qulo Doğuşu (9–15s) — logo + beyin + tick'lenen sorular
4. S4 Problem Akışı (15–23s) — 3 Türk problemi → yeşil tick eleme
5. S5 Çözüm Anı (23–27s) — Eşleşme! pop (elmas yok)
6. S6 Kapanış (27–30s) — logo + "Doğru soru, doğru insan." + store badge'leri

## Ses
- `public/audio/vo_tr_final.mp3` (ElevenLabs TR VO — prompts/elevenlabs-vo-tr.md)
- `public/audio/music_30s.mp3` (müzik bed)
- Asset'ler git-ignored; ayrı saklanır.

## Twitter upload notu
- Format: MP4 H.264, 1920×1080, <512MB, <140sn — uyumlu.
- Ses kapalı autoplay'de mesaj yazılarla tam taşınır.
```

- [ ] **Step 2: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-twitter-tr/README.md
git commit -m "docs(twitter-ad): proje README + upload notu"
```

---

## Self-Review

**1. Spec coverage:**
- Format 16:9/1920×1080/30fps/H.264 → Task 1 (composition), Task 11/13 (render+ffprobe). ✓
- Süre 30sn/900 frame → Task 1 config, Task 11 doğrulama. ✓
- Türkçe metin → tüm sahne task'ları; Task 12 glyph kontrolü. ✓
- Elmas YOK → Global Constraints + Task 9 (MatchPop spark, elmas yok) explicit. ✓
- Remotion config-driven → Task 1 (oynatıcı + config + types). ✓
- TR VO + müzik → Task 13. ✓
- Native UI (PhoneFrame/QuizSolve) → Task 6, kullanım Task 7/9. ✓
- Motto "Doğru soru, doğru insan." → Task 10 S6. ✓
- Store badge'leri → Task 10 StoreBadges. ✓
- 6 sahne + frame aralıkları → Task 3,4,7,8,9,10; config her task'ta güncel. ✓
- İzole yeni proje, mevcut 9:16'ya dokunmama → Task 1 ayrı dizin; hiçbir task tiktok-promos'u modify etmiyor. ✓
- Beyin/line-up → Task 5 BrainNetwork. ✓
- Problem akışı kırmızı→yeşil tick → Task 8. ✓
- Riskler (glyph, timing) → Task 11, 12. ✓

**2. Placeholder scan:** Plan içinde "TBD/TODO/sonra" yok; her kod adımı tam kod içeriyor. `Placeholder.tsx` kasıtlı bir iskelet bileşeni (Task 1'de oluşturulur, Task 10'da silinir) — placeholder anti-pattern'i değil, geçici scaffold. ✓

**3. Type consistency:**
- `SceneComponent` union üyeleri (`S1ChaosCards`…`S6Closing`) config'te ve `renderScene` switch'inde birebir aynı. ✓
- `theme.type` (hook/title/body/small/weight) tüm bileşenlerde tutarlı kullanılıyor. ✓
- `theme.composition`, `theme.colors.green/danger/purple/textMuted` adları her yerde aynı. ✓
- `TwitterConfig.audioTracks` Task 1'de tanımlı, Task 13'te kullanılıyor; `AudioTrack` alan adları (`path/volume/startFrame/startFrom`) oynatıcıdaki kullanımla eşleşiyor. ✓
- `QuizSolveMini` props (`question/options/correctIndex/startFrame/perItemFrames`) Task 6 tanımı = Task 7/9 kullanımı. ✓
- `BrainNetwork` props (`startFrame/sizePx`) = Task 7 kullanımı. ✓
- `ChaosCard` props = Task 3 CARDS objesi alanları birebir. ✓

Gap bulunmadı.
