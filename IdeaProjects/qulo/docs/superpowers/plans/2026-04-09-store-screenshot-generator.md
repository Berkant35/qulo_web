# Store Screenshot Generator Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Next.js web projesine `/store-screenshots` sayfası ekleyerek, manuel PNG'lerden App Store / Play Store pazarlama görselleri üreten basit bir generator oluşturmak.

**Architecture:** Tek bir `page.tsx` client component — dil/ekran/boyut seçicileri + canlı preview + html-to-image export. Ayrı bir JSON dosyasında 16 dile ait metinler. Light Streak template stili (siyah arka plan + çapraz ışık çizgisi).

**Tech Stack:** Next.js 14, React 18, Tailwind CSS, html-to-image, next-intl (mevcut)

---

## File Structure

```
web/
├── public/
│   ├── mockup.png                                    # iPhone frame (skill'den kopyalanacak)
│   └── store-screenshots/                            # Manuel PNG'ler (kullanıcı sağlayacak)
│       ├── discover.png
│       ├── question-create.png
│       ├── chat.png
│       ├── profile.png
│       └── match.png
├── src/
│   ├── app/[locale]/store-screenshots/
│   │   └── page.tsx                                  # Tüm generator tek dosyada (client component)
│   └── data/
│       └── store-screenshot-texts.json               # 5 ekran × 16 dil başlık + açıklama
```

---

### Task 1: html-to-image Kurulumu + Mockup Kopyalama

**Files:**
- Modify: `web/package.json`
- Create: `web/public/mockup.png` (skill'den kopyala)
- Create: `web/public/store-screenshots/` (boş dizin, placeholder ile)

- [ ] **Step 1: html-to-image paketini kur**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web && npm install html-to-image
```

- [ ] **Step 2: Mockup PNG'yi kopyala**

```bash
cp /Users/berkantcalikusu/IdeaProjects/qulo/.claude/skills/app-store-screenshots/mockup.png /Users/berkantcalikusu/IdeaProjects/qulo/web/public/mockup.png
```

- [ ] **Step 3: Store screenshots dizinini oluştur**

```bash
mkdir -p /Users/berkantcalikusu/IdeaProjects/qulo/web/public/store-screenshots
```

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add web/package.json web/package-lock.json web/public/mockup.png
git commit -m "feat(web): add html-to-image dependency and phone mockup asset"
```

---

### Task 2: Screenshot Metinleri JSON Dosyası

**Files:**
- Create: `web/src/data/store-screenshot-texts.json`

- [ ] **Step 1: Metin dosyasını oluştur**

5 ekran × 16 dil. Her ekran için kısa başlık + açıklama. Metinler reklam odaklı — UI açıklaması değil, duygu/sonuç satışı.

```json
{
  "discover": {
    "tr": { "title": "Sorularla Tanış", "subtitle": "Cevaplar seni doğru kişiye götürür" },
    "en": { "title": "Meet Through\nQuestions", "subtitle": "Answers lead you to the right person" },
    "de": { "title": "Triff dich\ndurch Fragen", "subtitle": "Antworten führen dich zur richtigen Person" },
    "fr": { "title": "Rencontrez par\nles questions", "subtitle": "Les réponses mènent à la bonne personne" },
    "es": { "title": "Conoce a través\nde preguntas", "subtitle": "Las respuestas te llevan a la persona correcta" },
    "ar": { "title": "تعرّف من خلال\nالأسئلة", "subtitle": "الإجابات تقودك للشخص المناسب" },
    "ru": { "title": "Знакомьтесь\nчерез вопросы", "subtitle": "Ответы ведут к нужному человеку" },
    "pt": { "title": "Conheça através\nde perguntas", "subtitle": "As respostas levam à pessoa certa" },
    "it": { "title": "Incontra tramite\ndomande", "subtitle": "Le risposte ti portano alla persona giusta" },
    "ja": { "title": "質問で\n出会おう", "subtitle": "答えが正しい人へ導く" },
    "ko": { "title": "질문으로\n만나요", "subtitle": "답이 올바른 사람에게 이끕니다" },
    "zh": { "title": "通过问题\n认识", "subtitle": "答案引导你找到对的人" },
    "nl": { "title": "Ontmoet via\nvragen", "subtitle": "Antwoorden leiden je naar de juiste persoon" },
    "pl": { "title": "Poznaj przez\npytania", "subtitle": "Odpowiedzi prowadzą do właściwej osoby" },
    "sv": { "title": "Möt genom\nfrågor", "subtitle": "Svaren leder dig till rätt person" },
    "hi": { "title": "सवालों से\nमिलिए", "subtitle": "जवाब आपको सही व्यक्ति तक ले जाते हैं" }
  },
  "question-create": {
    "tr": { "title": "Soruları Sen\nYarat", "subtitle": "Kendi tarzını yansıt, seni anlasınlar" },
    "en": { "title": "Create Your\nOwn Questions", "subtitle": "Reflect your style, let them understand you" },
    "de": { "title": "Erstelle deine\neigenen Fragen", "subtitle": "Zeig deinen Stil, lass dich verstehen" },
    "fr": { "title": "Créez vos\npropres questions", "subtitle": "Reflétez votre style, faites-vous comprendre" },
    "es": { "title": "Crea tus\npropias preguntas", "subtitle": "Refleja tu estilo, que te entiendan" },
    "ar": { "title": "أنشئ أسئلتك\nالخاصة", "subtitle": "عبّر عن أسلوبك، دعهم يفهمونك" },
    "ru": { "title": "Создавайте свои\nвопросы", "subtitle": "Покажите свой стиль, пусть вас поймут" },
    "pt": { "title": "Crie suas\npróprias perguntas", "subtitle": "Reflita seu estilo, deixe-os entender você" },
    "it": { "title": "Crea le tue\ndomande", "subtitle": "Rifletti il tuo stile, fatti capire" },
    "ja": { "title": "自分だけの\n質問を作ろう", "subtitle": "あなたのスタイルを映し出そう" },
    "ko": { "title": "나만의\n질문 만들기", "subtitle": "당신의 스타일을 반영하세요" },
    "zh": { "title": "创建你的\n专属问题", "subtitle": "展现你的风格，让他们了解你" },
    "nl": { "title": "Maak je\neigen vragen", "subtitle": "Weerspiegel je stijl, laat je begrijpen" },
    "pl": { "title": "Twórz własne\npytania", "subtitle": "Pokaż swój styl, pozwól się zrozumieć" },
    "sv": { "title": "Skapa dina\negna frågor", "subtitle": "Spegla din stil, låt dem förstå dig" },
    "hi": { "title": "अपने खुद के\nसवाल बनाएं", "subtitle": "अपनी शैली दिखाएं, खुद को समझाएं" }
  },
  "chat": {
    "tr": { "title": "Sohbete\nDal", "subtitle": "Eşleşme anından itibaren konuş" },
    "en": { "title": "Dive Into\nConversation", "subtitle": "Start talking from the moment you match" },
    "de": { "title": "Tauche ein\nins Gespräch", "subtitle": "Sprich ab dem Moment des Matchs" },
    "fr": { "title": "Plongez dans\nla conversation", "subtitle": "Parlez dès le match" },
    "es": { "title": "Sumérgete en\nla conversación", "subtitle": "Habla desde el momento del match" },
    "ar": { "title": "انغمس في\nالمحادثة", "subtitle": "ابدأ الحديث من لحظة التوافق" },
    "ru": { "title": "Погрузитесь\nв разговор", "subtitle": "Начните общение с момента совпадения" },
    "pt": { "title": "Mergulhe na\nconversa", "subtitle": "Comece a falar desde o match" },
    "it": { "title": "Immergiti nella\nconversazione", "subtitle": "Parla dal momento del match" },
    "ja": { "title": "会話に\n飛び込もう", "subtitle": "マッチした瞬間から話そう" },
    "ko": { "title": "대화에\n빠져보세요", "subtitle": "매칭 순간부터 대화하세요" },
    "zh": { "title": "投入\n对话", "subtitle": "从匹配那刻起开始交流" },
    "nl": { "title": "Duik in\nhet gesprek", "subtitle": "Praat vanaf het moment van een match" },
    "pl": { "title": "Zanurz się\nw rozmowie", "subtitle": "Rozmawiaj od momentu dopasowania" },
    "sv": { "title": "Dyk in i\nsamtalet", "subtitle": "Börja prata från matchögonblicket" },
    "hi": { "title": "बातचीत में\nडूब जाइए", "subtitle": "मैच होते ही बात करना शुरू करें" }
  },
  "profile": {
    "tr": { "title": "Kendini\nGöster", "subtitle": "Profilin senin hikâyen" },
    "en": { "title": "Show Who\nYou Are", "subtitle": "Your profile is your story" },
    "de": { "title": "Zeig wer\ndu bist", "subtitle": "Dein Profil ist deine Geschichte" },
    "fr": { "title": "Montrez qui\nvous êtes", "subtitle": "Votre profil est votre histoire" },
    "es": { "title": "Muestra quién\neres", "subtitle": "Tu perfil es tu historia" },
    "ar": { "title": "أظهر من\nأنت", "subtitle": "ملفك الشخصي هو قصتك" },
    "ru": { "title": "Покажите кто\nвы есть", "subtitle": "Ваш профиль — ваша история" },
    "pt": { "title": "Mostre quem\nvocê é", "subtitle": "Seu perfil é sua história" },
    "it": { "title": "Mostra chi\nsei", "subtitle": "Il tuo profilo è la tua storia" },
    "ja": { "title": "自分を\n見せよう", "subtitle": "プロフィールはあなたの物語" },
    "ko": { "title": "나를\n보여주세요", "subtitle": "프로필은 당신의 이야기입니다" },
    "zh": { "title": "展示\n你自己", "subtitle": "你的个人资料就是你的故事" },
    "nl": { "title": "Laat zien\nwie je bent", "subtitle": "Je profiel is je verhaal" },
    "pl": { "title": "Pokaż kim\njesteś", "subtitle": "Twój profil to Twoja historia" },
    "sv": { "title": "Visa vem\ndu är", "subtitle": "Din profil är din berättelse" },
    "hi": { "title": "दिखाएं कि\nआप कौन हैं", "subtitle": "आपकी प्रोफ़ाइल आपकी कहानी है" }
  },
  "match": {
    "tr": { "title": "Doğru Cevap,\nDoğru Kişi", "subtitle": "Sorular çözdükçe bağlantı kur" },
    "en": { "title": "Right Answer,\nRight Person", "subtitle": "Solve questions, build connections" },
    "de": { "title": "Richtige Antwort,\nrichtige Person", "subtitle": "Löse Fragen, baue Verbindungen auf" },
    "fr": { "title": "Bonne réponse,\nbonne personne", "subtitle": "Résolvez les questions, créez des liens" },
    "es": { "title": "Respuesta correcta,\npersona correcta", "subtitle": "Resuelve preguntas, crea conexiones" },
    "ar": { "title": "إجابة صحيحة،\nشخص مناسب", "subtitle": "حل الأسئلة، ابنِ روابط" },
    "ru": { "title": "Правильный ответ,\nправильный человек", "subtitle": "Решайте вопросы, стройте связи" },
    "pt": { "title": "Resposta certa,\npessoa certa", "subtitle": "Resolva perguntas, crie conexões" },
    "it": { "title": "Risposta giusta,\npersona giusta", "subtitle": "Risolvi domande, crea connessioni" },
    "ja": { "title": "正しい答え、\n正しい人", "subtitle": "問題を解いて繋がろう" },
    "ko": { "title": "맞는 답,\n맞는 사람", "subtitle": "질문을 풀고 인연을 만드세요" },
    "zh": { "title": "对的答案，\n对的人", "subtitle": "解答问题，建立联系" },
    "nl": { "title": "Juist antwoord,\njuiste persoon", "subtitle": "Los vragen op, bouw connecties" },
    "pl": { "title": "Dobra odpowiedź,\ndobra osoba", "subtitle": "Rozwiązuj pytania, buduj więzi" },
    "sv": { "title": "Rätt svar,\nrätt person", "subtitle": "Lös frågor, bygg kontakter" },
    "hi": { "title": "सही जवाब,\nसही इंसान", "subtitle": "सवाल हल करें, रिश्ते बनाएं" }
  }
}
```

- [ ] **Step 2: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add web/src/data/store-screenshot-texts.json
git commit -m "feat(web): add store screenshot texts for 16 locales"
```

---

### Task 3: Store Screenshots Generator Sayfası

**Files:**
- Create: `web/src/app/[locale]/store-screenshots/page.tsx`

Bu task'ın tamamı tek bir dosya. Client component olarak yazılacak.

- [ ] **Step 1: page.tsx oluştur**

Aşağıdaki yapıyı içerecek:

```tsx
"use client";

import { useState, useRef, useCallback } from "react";
import { toPng } from "html-to-image";
import texts from "@/data/store-screenshot-texts.json";

// ─── Constants ────────────────────────────────────────────
const SCREENS = ["discover", "question-create", "chat", "profile", "match"] as const;
type Screen = (typeof SCREENS)[number];

const SCREEN_LABELS: Record<Screen, string> = {
  discover: "Discover",
  "question-create": "Question Create",
  chat: "Chat",
  profile: "Profile",
  match: "Match",
};

const LOCALES = [
  "tr", "en", "de", "fr", "es", "ar", "ru",
  "pt", "it", "ja", "ko", "zh", "nl", "pl", "sv", "hi",
] as const;
type Locale = (typeof LOCALES)[number];

const RTL_LOCALES = new Set<string>(["ar"]);

const IPHONE_W = 1320;
const IPHONE_H = 2868;

const SIZES = [
  { label: 'iPhone 6.7"', w: 1320, h: 2868 },
  { label: 'iPhone 6.5"', w: 1284, h: 2778 },
  { label: 'iPhone 5.5"', w: 1242, h: 2208 },
  { label: 'iPad 12.9" (6th)', w: 2064, h: 2752 },
  { label: 'iPad 12.9" (3rd)', w: 2048, h: 2732 },
  { label: "Google Play", w: 1080, h: 1920 },
] as const;

// Phone mockup measurements
const MK_W = 1022;
const MK_H = 2082;
const SC_L = (52 / MK_W) * 100;
const SC_T = (46 / MK_H) * 100;
const SC_W = (918 / MK_W) * 100;
const SC_H = (1990 / MK_H) * 100;
const SC_RX = (126 / 918) * 100;
const SC_RY = (126 / 1990) * 100;

// ─── Phone Component ─────────────────────────────────────
function Phone({ src, alt, style, className = "" }: {
  src: string; alt: string; style?: React.CSSProperties; className?: string;
}) {
  return (
    <div className={`relative ${className}`}
      style={{ aspectRatio: `${MK_W}/${MK_H}`, ...style }}>
      <img src="/mockup.png" alt=""
        className="block w-full h-full" draggable={false} />
      <div className="absolute z-10 overflow-hidden"
        style={{
          left: `${SC_L}%`, top: `${SC_T}%`,
          width: `${SC_W}%`, height: `${SC_H}%`,
          borderRadius: `${SC_RX}% / ${SC_RY}%`,
        }}>
        <img src={src} alt={alt}
          className="block w-full h-full object-cover object-top"
          draggable={false} />
      </div>
    </div>
  );
}

// ─── Screenshot Canvas ───────────────────────────────────
// Her screenshot bu bileşen içinde render edilir (export + preview)
function ScreenshotCanvas({
  screen, locale, canvasRef, isExport = false,
}: {
  screen: Screen; locale: Locale;
  canvasRef?: React.Ref<HTMLDivElement>; isExport?: boolean;
}) {
  const t = (texts as any)[screen]?.[locale] ?? (texts as any)[screen]?.["en"];
  const isRtl = RTL_LOCALES.has(locale);
  const W = IPHONE_W;
  const H = IPHONE_H;

  return (
    <div
      ref={canvasRef}
      dir={isRtl ? "rtl" : "ltr"}
      style={{
        width: W,
        height: H,
        background: "#050508",
        position: isExport ? "absolute" : "relative",
        left: isExport ? -9999 : undefined,
        overflow: "hidden",
        fontFamily: "var(--font-inter), system-ui, sans-serif",
      }}
    >
      {/* Light Streak */}
      <div style={{
        position: "absolute",
        top: "20%",
        left: isRtl ? undefined : "-20%",
        right: isRtl ? "-20%" : undefined,
        width: "140%",
        height: 3,
        background: "linear-gradient(90deg, transparent 0%, rgba(102,126,234,0.5) 30%, rgba(118,75,162,0.5) 70%, transparent 100%)",
        transform: `rotate(${isRtl ? "35deg" : "-35deg"})`,
        filter: "blur(1px)",
      }} />
      <div style={{
        position: "absolute",
        top: "22%",
        left: isRtl ? undefined : "-20%",
        right: isRtl ? "-20%" : undefined,
        width: "140%",
        height: 60,
        background: "linear-gradient(90deg, transparent 0%, rgba(102,126,234,0.04) 30%, rgba(118,75,162,0.04) 70%, transparent 100%)",
        transform: `rotate(${isRtl ? "35deg" : "-35deg"})`,
        filter: "blur(25px)",
      }} />

      {/* Phone — centered, slightly below middle */}
      <div style={{
        position: "absolute",
        bottom: 0,
        left: "50%",
        transform: "translateX(-50%) translateY(12%)",
        width: "82%",
        zIndex: 1,
      }}>
        <Phone
          src={`/store-screenshots/${screen}.png`}
          alt={screen}
        />
      </div>

      {/* Title + Subtitle — top area */}
      <div style={{
        position: "absolute",
        top: W * 0.12,
        left: 0,
        right: 0,
        textAlign: "center",
        padding: `0 ${W * 0.08}px`,
        zIndex: 2,
      }}>
        <h2 style={{
          fontSize: W * 0.09,
          fontWeight: 700,
          color: "#FFFFFF",
          lineHeight: 1.05,
          letterSpacing: -0.5,
          margin: 0,
          whiteSpace: "pre-line",
        }}>
          {t.title}
        </h2>
        <p style={{
          fontSize: W * 0.032,
          fontWeight: 300,
          color: "rgba(255,255,255,0.4)",
          letterSpacing: 0.5,
          marginTop: W * 0.025,
        }}>
          {t.subtitle}
        </p>
      </div>
    </div>
  );
}

// ─── Main Page ───────────────────────────────────────────
export default function StoreScreenshotsPage() {
  const [locale, setLocale] = useState<Locale>("en");
  const [screen, setScreen] = useState<Screen>("discover");
  const [sizeIdx, setSizeIdx] = useState(0);
  const [exporting, setExporting] = useState(false);
  const exportRef = useRef<HTMLDivElement>(null);

  const selectedSize = SIZES[sizeIdx];

  // Preview scale — fit 1320x2868 into ~360px wide preview
  const previewScale = 360 / IPHONE_W;

  const exportSingle = useCallback(async () => {
    if (!exportRef.current || exporting) return;
    setExporting(true);
    try {
      const el = exportRef.current;
      el.style.left = "0px";
      el.style.opacity = "1";
      el.style.zIndex = "-1";

      const opts = { width: IPHONE_W, height: IPHONE_H, pixelRatio: 1, cacheBust: true };

      // Double-call trick for font rendering
      await toPng(el, opts);
      const dataUrl = await toPng(el, opts);

      el.style.left = "-9999px";
      el.style.opacity = "";
      el.style.zIndex = "";

      // Resize to target size if different
      const { w, h } = selectedSize;
      if (w === IPHONE_W && h === IPHONE_H) {
        // Direct download
        const link = document.createElement("a");
        link.download = `${screen}-${locale}-${w}x${h}.png`;
        link.href = dataUrl;
        link.click();
      } else {
        // Resize via canvas
        const img = new Image();
        img.onload = () => {
          const canvas = document.createElement("canvas");
          canvas.width = w;
          canvas.height = h;
          const ctx = canvas.getContext("2d")!;
          ctx.drawImage(img, 0, 0, w, h);
          const link = document.createElement("a");
          link.download = `${screen}-${locale}-${w}x${h}.png`;
          link.href = canvas.toDataURL("image/png");
          link.click();
        };
        img.src = dataUrl;
      }
    } finally {
      setExporting(false);
    }
  }, [screen, locale, selectedSize, exporting]);

  const exportAll = useCallback(async () => {
    if (exporting) return;
    setExporting(true);
    try {
      for (const s of SCREENS) {
        // We need to change screen, wait for render, then export
        // For simplicity, export current locale × all screens at current size
        // This requires re-rendering each screen — handled by updating state sequentially
      }
    } finally {
      setExporting(false);
    }
    // Note: Bulk export will be a simple loop with setState + setTimeout
    // Implementation detail — keep simple, user triggers one-by-one if needed
  }, [exporting]);

  return (
    <div className="min-h-screen bg-qulo-bg text-white p-8">
      <h1 className="text-2xl font-bold mb-6">Store Screenshot Generator</h1>

      {/* Controls */}
      <div className="flex flex-wrap gap-4 mb-8">
        {/* Locale selector */}
        <div>
          <label className="text-xs text-qulo-text-muted block mb-1">Language</label>
          <select
            value={locale}
            onChange={(e) => setLocale(e.target.value as Locale)}
            className="bg-qulo-bg-card border border-white/10 rounded px-3 py-2 text-sm"
          >
            {LOCALES.map((l) => (
              <option key={l} value={l}>{l.toUpperCase()}</option>
            ))}
          </select>
        </div>

        {/* Screen selector */}
        <div>
          <label className="text-xs text-qulo-text-muted block mb-1">Screen</label>
          <div className="flex gap-1">
            {SCREENS.map((s) => (
              <button
                key={s}
                onClick={() => setScreen(s)}
                className={`px-3 py-2 text-sm rounded transition-colors ${
                  screen === s
                    ? "bg-qulo-purple text-white"
                    : "bg-qulo-bg-card text-qulo-text-secondary hover:bg-qulo-bg-surface"
                }`}
              >
                {SCREEN_LABELS[s]}
              </button>
            ))}
          </div>
        </div>

        {/* Size selector */}
        <div>
          <label className="text-xs text-qulo-text-muted block mb-1">Export Size</label>
          <select
            value={sizeIdx}
            onChange={(e) => setSizeIdx(Number(e.target.value))}
            className="bg-qulo-bg-card border border-white/10 rounded px-3 py-2 text-sm"
          >
            {SIZES.map((s, i) => (
              <option key={i} value={i}>{s.label} ({s.w}×{s.h})</option>
            ))}
          </select>
        </div>

        {/* Export button */}
        <div className="flex items-end">
          <button
            onClick={exportSingle}
            disabled={exporting}
            className="px-6 py-2 bg-qulo-purple hover:bg-qulo-purple-dark rounded text-sm font-medium transition-colors disabled:opacity-50"
          >
            {exporting ? "Exporting..." : "Export PNG"}
          </button>
        </div>
      </div>

      {/* Preview */}
      <div className="border border-white/10 rounded-xl p-4 inline-block bg-qulo-bg-card">
        <div style={{
          width: IPHONE_W * previewScale,
          height: IPHONE_H * previewScale,
          overflow: "hidden",
        }}>
          <div style={{
            transform: `scale(${previewScale})`,
            transformOrigin: "top left",
          }}>
            <ScreenshotCanvas screen={screen} locale={locale} />
          </div>
        </div>
      </div>

      {/* Offscreen export container */}
      <ScreenshotCanvas
        screen={screen}
        locale={locale}
        canvasRef={exportRef}
        isExport
      />
    </div>
  );
}
```

- [ ] **Step 2: Dev server'da test et**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web && npm run dev
```

Tarayıcıda `http://localhost:3000/en/store-screenshots` aç. Kontrol et:
- Dil seçici çalışıyor mu
- Ekran seçici çalışıyor mu
- Preview render ediliyor mu (screenshot PNG'leri olmadan telefon çerçevesi görünmeli)
- RTL (ar) seçildiğinde light streak yönü değişiyor mu

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add web/src/app/\\[locale\\]/store-screenshots/page.tsx
git commit -m "feat(web): add store screenshot generator page with Light Streak template"
```

---

### Task 4: Test + Son Doğrulama

**Files:**
- Tüm dosyalar mevcut

- [ ] **Step 1: Placeholder screenshot ekle (test amaçlı)**

Test için basit bir placeholder PNG oluştur veya mevcut bir ekran görüntüsünü `web/public/store-screenshots/discover.png` olarak kopyala.

- [ ] **Step 2: Full flow test**

1. `http://localhost:3000/en/store-screenshots` aç
2. Dil değiştir → başlık/açıklama değişmeli
3. Ekran değiştir → telefondaki screenshot değişmeli
4. "ar" seç → RTL layout olmalı
5. "Export PNG" tıkla → PNG dosyası indirilmeli
6. Farklı boyut seç → export'ta o boyutta olmalı

- [ ] **Step 3: Commit (varsa fix)**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add -A web/
git commit -m "fix(web): store screenshot generator adjustments"
```
