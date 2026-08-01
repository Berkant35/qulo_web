import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { notFound } from "next/navigation";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { CITIES, type City } from "@/lib/constants/cities";

/* ------------------------------------------------------------------ */
/*  Static params — 16 locales x 10 cities = 160 pages                */
/* ------------------------------------------------------------------ */
export function generateStaticParams() {
  return locales.flatMap((locale) =>
    CITIES.map((city) => ({ locale, city: city.slug })),
  );
}

/* ------------------------------------------------------------------ */
/*  Locale-aware content helpers                                       */
/* ------------------------------------------------------------------ */
function getCityName(city: City, locale: string): string {
  return city.names[locale] || city.names.en;
}

function getCountryName(city: City, locale: string): string {
  return city.country[locale] || city.country.en;
}

/** Per-locale SEO title template */
const TITLE_TEMPLATES: Record<string, (c: string) => string> = {
  tr: (c) => `${c} Dating — Qulo | Sorularla Tanis`,
  en: (c) => `Dating in ${c} — Qulo | Meet Through Questions`,
  de: (c) => `Dating in ${c} — Qulo | Kennenlernen durch Fragen`,
  fr: (c) => `Rencontres a ${c} — Qulo | Rencontrez par Questions`,
  es: (c) => `Citas en ${c} — Qulo | Conoce con Preguntas`,
  ar: (c) => `مواعدة في ${c} — Qulo | تعارف عبر الأسئلة`,
  ru: (c) => `Знакомства в ${c} — Qulo | Встречи через вопросы`,
  pt: (c) => `Namoro em ${c} — Qulo | Conheca por Perguntas`,
  it: (c) => `Incontri a ${c} — Qulo | Incontra con Domande`,
  ja: (c) => `${c}でデート — Qulo | 質問で出会う`,
  ko: (c) => `${c} 데이팅 — Qulo | 질문으로 만남`,
  zh: (c) => `${c}约会 — Qulo | 通过问题认识`,
  nl: (c) => `Dating in ${c} — Qulo | Ontmoet Via Vragen`,
  pl: (c) => `Randki w ${c} — Qulo | Poznawaj Przez Pytania`,
  sv: (c) => `Dejting i ${c} — Qulo | Traffas Genom Fragor`,
  hi: (c) => `${c} में डेटिंग — Qulo | सवालों से मिलें`,
};

/** Per-locale SEO description template */
const DESC_TEMPLATES: Record<string, (c: string, co: string) => string> = {
  tr: (c, co) =>
    `${c} sehrinde Qulo ile tanisin. ${co}'nin en buyuk sehirlerinden ${c}'da sorularla eslesin, anlamli baglanti kurun. Quiz dating app.`,
  en: (c, co) =>
    `Meet new people in ${c} with Qulo. As one of ${co}'s largest cities, ${c} offers quiz-based dating for meaningful connections.`,
  de: (c, co) =>
    `Lernen Sie neue Menschen in ${c} kennen. ${c}, eine der grossten Stadte ${co}s, bietet fragenbasiertes Dating mit Qulo.`,
  fr: (c, co) =>
    `Rencontrez de nouvelles personnes a ${c} avec Qulo. ${c}, l'une des plus grandes villes de ${co}, offre des rencontres par questions.`,
  es: (c, co) =>
    `Conoce gente nueva en ${c} con Qulo. ${c}, una de las ciudades mas grandes de ${co}, ofrece citas basadas en preguntas.`,
  ar: (c, co) =>
    `تعرف على أشخاص جدد في ${c} مع Qulo. ${c}، واحدة من أكبر مدن ${co}، تقدم مواعدة قائمة على الأسئلة.`,
  ru: (c, co) =>
    `Познакомьтесь с новыми людьми в ${c} с Qulo. ${c} — один из крупнейших городов ${co} для знакомств через вопросы.`,
  pt: (c, co) =>
    `Conheca novas pessoas em ${c} com Qulo. ${c}, uma das maiores cidades de ${co}, oferece namoro baseado em perguntas.`,
  it: (c, co) =>
    `Incontra nuove persone a ${c} con Qulo. ${c}, una delle citta piu grandi di ${co}, offre incontri basati su domande.`,
  ja: (c, co) =>
    `Quloで${c}の新しい人と出会いましょう。${co}最大の都市の一つ${c}で、クイズベースのマッチング。`,
  ko: (c, co) =>
    `Qulo로 ${c}에서 새로운 사람들을 만나세요. ${co} 최대 도시 ${c}에서 퀴즈 기반 매칭.`,
  zh: (c, co) =>
    `在${c}用Qulo认识新朋友。${c}是${co}最大的城市之一，提供基于问答的约会。`,
  nl: (c, co) =>
    `Ontmoet nieuwe mensen in ${c} met Qulo. ${c}, een van de grootste steden van ${co}, biedt dating op basis van vragen.`,
  pl: (c, co) =>
    `Poznaj nowych ludzi w ${c} z Qulo. ${c}, jedno z najwiekszych miast ${co}, oferuje randki oparte na pytaniach.`,
  sv: (c, co) =>
    `Traffa nya manniskor i ${c} med Qulo. ${c}, en av ${co}s storsta stader, erbjuder fragor-baserad dejting.`,
  hi: (c, co) =>
    `Qulo के साथ ${c} में नए लोगों से मिलें। ${co} के सबसे बड़े शहरों में से एक ${c} में सवाल-आधारित डेटिंग।`,
};

/** Per-locale hero heading template */
const HERO_TEMPLATES: Record<string, (c: string) => string> = {
  tr: (c) => `${c} Sehrinde Qulo ile Tanis`,
  en: (c) => `Meet People in ${c} with Qulo`,
  de: (c) => `Lerne Menschen in ${c} kennen`,
  fr: (c) => `Rencontrez des gens a ${c} avec Qulo`,
  es: (c) => `Conoce gente en ${c} con Qulo`,
  ar: (c) => `تعرف على أشخاص في ${c} مع Qulo`,
  ru: (c) => `Знакомьтесь в ${c} с Qulo`,
  pt: (c) => `Conheca pessoas em ${c} com Qulo`,
  it: (c) => `Incontra persone a ${c} con Qulo`,
  ja: (c) => `Quloで${c}の人と出会おう`,
  ko: (c) => `Qulo로 ${c}에서 만남`,
  zh: (c) => `在${c}用Qulo认识人`,
  nl: (c) => `Ontmoet mensen in ${c} met Qulo`,
  pl: (c) => `Poznaj ludzi w ${c} z Qulo`,
  sv: (c) => `Traffa manniskor i ${c} med Qulo`,
  hi: (c) => `Qulo से ${c} में लोगों से मिलें`,
};

/** Per-locale "Why Qulo in {city}?" section title */
const WHY_TITLE: Record<string, (c: string) => string> = {
  tr: (c) => `Neden ${c}'de Qulo?`,
  en: (c) => `Why Qulo in ${c}?`,
  de: (c) => `Warum Qulo in ${c}?`,
  fr: (c) => `Pourquoi Qulo a ${c} ?`,
  es: (c) => `Por que Qulo en ${c}?`,
  ar: (c) => `لماذا Qulo في ${c}؟`,
  ru: (c) => `Почему Qulo в ${c}?`,
  pt: (c) => `Por que Qulo em ${c}?`,
  it: (c) => `Perche Qulo a ${c}?`,
  ja: (c) => `なぜ${c}でQulo？`,
  ko: (c) => `왜 ${c}에서 Qulo?`,
  zh: (c) => `为什么在${c}用Qulo？`,
  nl: (c) => `Waarom Qulo in ${c}?`,
  pl: (c) => `Dlaczego Qulo w ${c}?`,
  sv: (c) => `Varfor Qulo i ${c}?`,
  hi: (c) => `${c} में Qulo क्यों?`,
};

/** Per-locale body content paragraph templates */
const BODY_TEMPLATES: Record<string, (c: string, co: string) => string[]> = {
  tr: (c, co) => [
    `${c} sehrinde yeni insanlarla tanismak mi istiyorsunuz? Qulo ile sorularinizla eslesin. ${c}, ${co}'nin en buyuk sehirlerinden biri olarak yeni insanlarla tanisma firsatlari sunuyor.`,
    `Swipe yerine soru-cevap tabanli eslesmelerle ${c}'da anlamli baglantilar kurun. Qulo'nun quiz dating sistemi, yuzeyselligi birakip gercek uyumluluklari kesfetmenizi saglar.`,
  ],
  en: (c, co) => [
    `Looking to meet new people in ${c}? Match through your questions with Qulo. As one of ${co}'s largest cities, ${c} offers opportunities to meet new people.`,
    `Build meaningful connections in ${c} with question-based matching instead of swiping. Qulo's quiz dating system helps you discover real compatibility beyond the surface.`,
  ],
  de: (c, co) => [
    `Mochten Sie neue Menschen in ${c} kennenlernen? Matchen Sie durch Fragen mit Qulo. Als eine der grossten Stadte ${co}s bietet ${c} viele Moglichkeiten, neue Leute zu treffen.`,
    `Bauen Sie in ${c} bedeutungsvolle Verbindungen durch fragenbasiertes Matching statt Swipen auf. Qulos Quiz-Dating-System hilft Ihnen, echte Kompatibilitat zu entdecken.`,
  ],
  fr: (c, co) => [
    `Vous cherchez a rencontrer de nouvelles personnes a ${c} ? Matchez par vos questions avec Qulo. ${c}, l'une des plus grandes villes de ${co}, offre des opportunites de rencontrer de nouvelles personnes.`,
    `Construisez des connexions significatives a ${c} grace au matching par questions au lieu du swipe. Le systeme de quiz dating de Qulo vous aide a decouvrir la vraie compatibilite.`,
  ],
  es: (c, co) => [
    `Buscas conocer gente nueva en ${c}? Haz match con tus preguntas en Qulo. ${c}, una de las ciudades mas grandes de ${co}, ofrece oportunidades para millones de solteros.`,
    `Construye conexiones significativas en ${c} con matching basado en preguntas en lugar de deslizar. El sistema de quiz dating de Qulo te ayuda a descubrir compatibilidad real.`,
  ],
  ar: (c, co) => [
    `هل تبحث عن التعرف على أشخاص جدد في ${c}؟ تطابق من خلال أسئلتك مع Qulo. ${c}، واحدة من أكبر مدن ${co}، تقدم فرصًا للقاء أشخاص جدد.`,
    `ابنِ روابط ذات معنى في ${c} من خلال المطابقة القائمة على الأسئلة بدلاً من التمرير. يساعدك نظام Qulo للمواعدة عبر الاختبارات على اكتشاف التوافق الحقيقي.`,
  ],
  ru: (c, co) => [
    `Хотите познакомиться с новыми людьми в ${c}? Находите пару через вопросы с Qulo. ${c} — один из крупнейших городов ${co}, предлагающий возможности для встречи новых людей.`,
    `Стройте значимые связи в ${c} через matching на основе вопросов вместо свайпов. Система квиз-знакомств Qulo помогает найти настоящую совместимость.`,
  ],
  pt: (c, co) => [
    `Quer conhecer novas pessoas em ${c}? Combine atraves de perguntas com Qulo. ${c}, uma das maiores cidades de ${co}, oferece oportunidades para milhoes de solteiros.`,
    `Construa conexoes significativas em ${c} com matching baseado em perguntas em vez de deslizar. O sistema de quiz dating do Qulo ajuda voce a descobrir compatibilidade real.`,
  ],
  it: (c, co) => [
    `Vuoi incontrare nuove persone a ${c}? Fai match attraverso le tue domande con Qulo. ${c}, una delle citta piu grandi di ${co}, offre opportunita di incontrare nuove persone.`,
    `Costruisci connessioni significative a ${c} con il matching basato su domande invece dello swipe. Il sistema di quiz dating di Qulo ti aiuta a scoprire la vera compatibilita.`,
  ],
  ja: (c, co) => [
    `${c}で新しい人と出会いたいですか？Quloで質問を通じてマッチングしましょう。${co}最大の都市の一つである${c}は、新しい人と出会う多くの機会を提供します。`,
    `スワイプの代わりに質問ベースのマッチングで、${c}で意味のあるつながりを築きましょう。Quloのクイズデーティングシステムが本当の相性を発見する手助けをします。`,
  ],
  ko: (c, co) => [
    `${c}에서 새로운 사람들을 만나고 싶으신가요? Qulo에서 질문으로 매칭하세요. ${co} 최대 도시 중 하나인 ${c}는 새로운 사람들을 만날 다양한 기회를 제공합니다.`,
    `스와이프 대신 질문 기반 매칭으로 ${c}에서 의미 있는 연결을 만드세요. Qulo의 퀴즈 데이팅 시스템이 진정한 호환성을 발견하도록 도와줍니다.`,
  ],
  zh: (c, co) => [
    `想在${c}认识新朋友吗？用Qulo通过问题匹配。${c}是${co}最大的城市之一，提供认识新朋友的多种机会。`,
    `用基于问答的匹配代替滑动，在${c}建立有意义的联系。Qulo的问答约会系统帮助你发现真正的兼容性。`,
  ],
  nl: (c, co) => [
    `Wil je nieuwe mensen ontmoeten in ${c}? Match via je vragen met Qulo. ${c}, een van de grootste steden van ${co}, biedt kansen voor miljoenen singles.`,
    `Bouw betekenisvolle connecties op in ${c} met matching op basis van vragen in plaats van swipen. Het quiz dating-systeem van Qulo helpt je echte compatibiliteit te ontdekken.`,
  ],
  pl: (c, co) => [
    `Chcesz poznac nowych ludzi w ${c}? Dopasowuj sie przez pytania z Qulo. ${c}, jedno z najwiekszych miast ${co}, oferuje mozliwosci poznawania nowych ludzi.`,
    `Buduj znaczace polaczenia w ${c} dzieki matchingowi opartemu na pytaniach zamiast przesuwania. System quiz dating Qulo pomaga odkryc prawdziwa kompatybilnosc.`,
  ],
  sv: (c, co) => [
    `Vill du traffa nya manniskor i ${c}? Matcha genom dina fragor med Qulo. ${c}, en av ${co}s storsta stader, erbjuder mojligheter att traffa nya manniskor.`,
    `Bygg meningsfulla kontakter i ${c} med fragor-baserad matchning istallet for att swipa. Qulos quiz-dejtingsystem hjalper dig att upptacka riktig kompatibilitet.`,
  ],
  hi: (c, co) => [
    `${c} में नए लोगों से मिलना चाहते हैं? Qulo के साथ अपने सवालों से मैच करें। ${co} के सबसे बड़े शहरों में से एक ${c} नए लोगों से मिलने के कई अवसर प्रदान करता है।`,
    `स्वाइप की जगह सवाल-आधारित मैचिंग से ${c} में सार्थक कनेक्शन बनाएं। Qulo का क्विज़ डेटिंग सिस्टम आपको सच्ची अनुकूलता खोजने में मदद करता है।`,
  ],
};

/** Per-locale "How it works" section */
const HOW_IT_WORKS: Record<string, { title: string; steps: string[] }> = {
  tr: { title: "Nasil Calisir?", steps: ["Soru hazirla", "Kesfet & Coz", "Esles & Sohbet Et"] },
  en: { title: "How It Works", steps: ["Create questions", "Discover & Solve", "Match & Chat"] },
  de: { title: "So funktioniert es", steps: ["Fragen erstellen", "Entdecken & Losen", "Matchen & Chatten"] },
  fr: { title: "Comment ca marche ?", steps: ["Creez des questions", "Decouvrez & Resolvez", "Matchez & Chattez"] },
  es: { title: "Como funciona?", steps: ["Crea preguntas", "Descubre y resuelve", "Haz match y chatea"] },
  ar: { title: "كيف يعمل؟", steps: ["أنشئ أسئلة", "اكتشف وحل", "تطابق وتحدث"] },
  ru: { title: "Как это работает?", steps: ["Создайте вопросы", "Исследуйте и решайте", "Матчьтесь и общайтесь"] },
  pt: { title: "Como funciona?", steps: ["Crie perguntas", "Descubra e resolva", "Combine e converse"] },
  it: { title: "Come funziona?", steps: ["Crea domande", "Scopri e risolvi", "Match e chatta"] },
  ja: { title: "使い方", steps: ["質問を作成", "発見＆解答", "マッチ＆チャット"] },
  ko: { title: "사용 방법", steps: ["질문 만들기", "발견 & 풀기", "매칭 & 채팅"] },
  zh: { title: "如何使用", steps: ["创建问题", "发现和解答", "匹配和聊天"] },
  nl: { title: "Hoe werkt het?", steps: ["Maak vragen", "Ontdek & Los op", "Match & Chat"] },
  pl: { title: "Jak to dziala?", steps: ["Utworz pytania", "Odkrywaj i rozwiazuj", "Dopasuj sie i czatuj"] },
  sv: { title: "Hur fungerar det?", steps: ["Skapa fragor", "Upptack & Los", "Matcha & Chatta"] },
  hi: { title: "कैसे काम करता है?", steps: ["सवाल बनाएं", "खोजें और हल करें", "मैच करें और चैट करें"] },
};

/** Per-locale stats labels */
const STATS_LABELS: Record<string, { population: string; potential: string }> = {
  tr: { population: "Sehir Nufusu", potential: "Quiz Dating Potansiyeli" },
  en: { population: "City Population", potential: "Quiz Dating Potential" },
  de: { population: "Stadtbevolkerung", potential: "Quiz-Dating-Potenzial" },
  fr: { population: "Population", potential: "Potentiel Quiz Dating" },
  es: { population: "Poblacion", potential: "Potencial Quiz Dating" },
  ar: { population: "عدد السكان", potential: "إمكانية مواعدة الاختبار" },
  ru: { population: "Население города", potential: "Потенциал квиз-знакомств" },
  pt: { population: "Populacao", potential: "Potencial Quiz Dating" },
  it: { population: "Popolazione", potential: "Potenziale Quiz Dating" },
  ja: { population: "都市人口", potential: "クイズデーティングの可能性" },
  ko: { population: "도시 인구", potential: "퀴즈 데이팅 잠재력" },
  zh: { population: "城市人口", potential: "问答约会潜力" },
  nl: { population: "Stadsbevolking", potential: "Quiz Dating Potentieel" },
  pl: { population: "Populacja miasta", potential: "Potencjal Quiz Dating" },
  sv: { population: "Stadsbefolkning", potential: "Quiz Dating-potential" },
  hi: { population: "शहर की जनसंख्या", potential: "क्विज़ डेटिंग क्षमता" },
};

/** Per-locale CTA labels */
const CTA_LABELS: Record<string, { title: string; desc: string }> = {
  tr: { title: "Hemen Basla", desc: "Qulo'yu indir ve sorularla eslesmelerini bul." },
  en: { title: "Get Started", desc: "Download Qulo and find your match through questions." },
  de: { title: "Jetzt starten", desc: "Lade Qulo herunter und finde dein Match durch Fragen." },
  fr: { title: "Commencez", desc: "Telechargez Qulo et trouvez votre match par questions." },
  es: { title: "Empieza ya", desc: "Descarga Qulo y encuentra tu match con preguntas." },
  ar: { title: "ابدأ الآن", desc: "حمّل Qulo وابحث عن شريكك من خلال الأسئلة." },
  ru: { title: "Начните сейчас", desc: "Скачайте Qulo и найдите пару через вопросы." },
  pt: { title: "Comece agora", desc: "Baixe o Qulo e encontre seu match por perguntas." },
  it: { title: "Inizia ora", desc: "Scarica Qulo e trova il tuo match tramite domande." },
  ja: { title: "今すぐ始めよう", desc: "Quloをダウンロードして質問でマッチを見つけよう。" },
  ko: { title: "지금 시작하세요", desc: "Qulo를 다운로드하고 질문으로 매칭을 찾으세요." },
  zh: { title: "立即开始", desc: "下载Qulo，通过问题找到你的匹配。" },
  nl: { title: "Begin nu", desc: "Download Qulo en vind je match via vragen." },
  pl: { title: "Zacznij teraz", desc: "Pobierz Qulo i znajdz swoje dopasowanie przez pytania." },
  sv: { title: "Borja nu", desc: "Ladda ner Qulo och hitta din match genom fragor." },
  hi: { title: "अभी शुरू करें", desc: "Qulo डाउनलोड करें और सवालों से अपना मैच खोजें।" },
};

/** Per-locale "Other Cities" label */
const OTHER_CITIES_LABEL: Record<string, string> = {
  tr: "Diger Sehirler",
  en: "Other Cities",
  de: "Andere Stadte",
  fr: "Autres villes",
  es: "Otras ciudades",
  ar: "مدن أخرى",
  ru: "Другие города",
  pt: "Outras cidades",
  it: "Altre citta",
  ja: "他の都市",
  ko: "다른 도시",
  zh: "其他城市",
  nl: "Andere steden",
  pl: "Inne miasta",
  sv: "Andra stader",
  hi: "अन्य शहर",
};

/* ------------------------------------------------------------------ */
/*  Metadata                                                           */
/* ------------------------------------------------------------------ */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; city: string }>;
}): Promise<Metadata> {
  const { locale, city: citySlug } = await params;
  const city = CITIES.find((c) => c.slug === citySlug);
  if (!city) return {};

  const cityName = getCityName(city, locale);
  const countryName = getCountryName(city, locale);
  const titleFn = TITLE_TEMPLATES[locale] || TITLE_TEMPLATES.en;
  const descFn = DESC_TEMPLATES[locale] || DESC_TEMPLATES.en;
  const title = titleFn(cityName);
  const description = descFn(cityName, countryName);
  const pageUrl = `${SITE_URL}/${locale}/dating/${citySlug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/dating/${citySlug}`;
  languages["x-default"] = `${SITE_URL}/tr/dating/${citySlug}`;

  return {
    title,
    description,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "website",
      locale: ogLocale,
      images: ogImages(),
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: ogImages(),
    },
  };
}

/* ------------------------------------------------------------------ */
/*  JSON-LD helper — static server constants only, no user input       */
/* ------------------------------------------------------------------ */
function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      /* Static server constants only — no user input */
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

/* ------------------------------------------------------------------ */
/*  Page                                                               */
/* ------------------------------------------------------------------ */
export default async function DatingCityPage({
  params,
}: {
  params: Promise<{ locale: string; city: string }>;
}) {
  const { locale, city: citySlug } = await params;
  setRequestLocale(locale);

  const city = CITIES.find((c) => c.slug === citySlug);
  if (!city) notFound();

  const cityName = getCityName(city, locale);
  const countryName = getCountryName(city, locale);

  const heroFn = HERO_TEMPLATES[locale] || HERO_TEMPLATES.en;
  const whyFn = WHY_TITLE[locale] || WHY_TITLE.en;
  const bodyFn = BODY_TEMPLATES[locale] || BODY_TEMPLATES.en;
  const howItWorks = HOW_IT_WORKS[locale] || HOW_IT_WORKS.en;
  const statsLabels = STATS_LABELS[locale] || STATS_LABELS.en;
  const ctaLabels = CTA_LABELS[locale] || CTA_LABELS.en;
  const otherCitiesLabel = OTHER_CITIES_LABEL[locale] || OTHER_CITIES_LABEL.en;

  const bodyParagraphs = bodyFn(cityName, countryName);
  const otherCities = CITIES.filter((c) => c.slug !== citySlug).slice(0, 5);

  /* JSON-LD: Place + SoftwareApplication */
  const placeJsonLd = {
    "@context": "https://schema.org",
    "@type": "Place",
    name: cityName,
    geo: {
      "@type": "GeoCoordinates",
      latitude: city.coordinates.lat,
      longitude: city.coordinates.lng,
    },
    containedInPlace: {
      "@type": "Country",
      name: countryName,
    },
  };

  const appJsonLd = {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    name: "Qulo",
    operatingSystem: "iOS, Android",
    applicationCategory: "SocialNetworkingApplication",
    url: SITE_URL,
    description: (DESC_TEMPLATES[locale] || DESC_TEMPLATES.en)(cityName, countryName),
    offers: {
      "@type": "Offer",
      price: "0",
      priceCurrency: "USD",
    },
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      <JsonLd data={placeJsonLd} />
      <JsonLd data={appJsonLd} />

      {/* Hero Section */}
      <section className="pt-28 pb-16 px-6 text-center">
        <div className="max-w-3xl mx-auto">
          <div className="text-left">
            <Breadcrumb
              locale={locale}
              items={[
                { label: "Dating", href: `/${locale}/dating` },
                { label: cityName },
              ]}
            />
          </div>
          <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
            {city.emoji} {cityName}, {countryName}
          </p>
          <h1 className="text-4xl sm:text-5xl font-bold mb-6">
            {heroFn(cityName)}
          </h1>
          <p className="text-qulo-text-secondary text-base max-w-xl mx-auto mb-8">
            {bodyParagraphs[0]}
          </p>
          <StoreButtons />
        </div>
      </section>

      {/* Why Qulo in {city} */}
      <section className="py-16 px-6">
        <div className="max-w-3xl mx-auto">
          <h2 className="text-2xl sm:text-3xl font-bold mb-6 text-center">
            {whyFn(cityName)}
          </h2>
          {bodyParagraphs.map((p, i) => (
            <p
              key={i}
              className="text-qulo-text-secondary text-sm leading-relaxed mb-4"
            >
              {p}
            </p>
          ))}
        </div>
      </section>

      {/* How It Works */}
      <section className="py-16 px-6">
        <div className="max-w-3xl mx-auto">
          <h2 className="text-2xl sm:text-3xl font-bold mb-8 text-center">
            {howItWorks.title}
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
            {howItWorks.steps.map((step, i) => (
              <div
                key={i}
                className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 text-center"
              >
                <div className="w-10 h-10 rounded-full bg-qulo-purple/20 text-qulo-purple flex items-center justify-center text-sm font-bold mx-auto mb-4">
                  {i + 1}
                </div>
                <p className="text-sm font-semibold text-white">{step}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Stats */}
      <section className="py-16 px-6">
        <div className="max-w-3xl mx-auto">
          <div className="grid grid-cols-2 gap-6">
            <div className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 text-center">
              <p className="text-3xl font-bold text-qulo-green mb-1">
                {city.population}
              </p>
              <p className="text-xs text-qulo-text-secondary">
                {statsLabels.population}
              </p>
            </div>
            <div className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 text-center">
              <p className="text-3xl font-bold text-qulo-purple mb-1">
                {city.emoji}
              </p>
              <p className="text-xs text-qulo-text-secondary">
                {statsLabels.potential}
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 px-6 text-center">
        <div className="max-w-3xl mx-auto">
          <h2 className="text-2xl sm:text-3xl font-bold mb-4">
            {ctaLabels.title}
          </h2>
          <p className="text-qulo-text-secondary text-sm mb-8">
            {ctaLabels.desc}
          </p>
          <StoreButtons />
        </div>
      </section>

      {/* Other Cities + Internal Links */}
      <section className="py-16 px-6">
        <div className="max-w-3xl mx-auto">
          <h3 className="text-lg font-bold mb-6 text-center">
            {otherCitiesLabel}
          </h3>
          <div className="flex flex-wrap justify-center gap-3">
            {otherCities.map((oc) => (
              <Link
                key={oc.slug}
                href={`/${locale}/dating/${oc.slug}`}
                className="text-xs px-4 py-2 rounded-full border border-white/[0.08] bg-white/[0.03] text-qulo-text-secondary hover:text-white hover:border-qulo-purple/30 transition-colors"
              >
                {oc.emoji} {getCityName(oc, locale)}
              </Link>
            ))}
          </div>
          <div className="flex justify-center gap-4 mt-8">
            <Link
              href={`/${locale}/about`}
              className="text-xs text-qulo-purple hover:underline"
            >
              {locale === "tr" ? "Hakkinda" : "About"}
            </Link>
            <Link
              href={`/${locale}/blog`}
              className="text-xs text-qulo-purple hover:underline"
            >
              Blog
            </Link>
            <Link
              href={`/${locale}/dating`}
              className="text-xs text-qulo-purple hover:underline"
            >
              {otherCitiesLabel}
            </Link>
          </div>
        </div>
      </section>

      <Footer />
    </main>
  );
}
