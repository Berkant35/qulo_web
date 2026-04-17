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
import { COUNTRIES, type Country } from "@/lib/constants/countries";
import { CITIES } from "@/lib/constants/cities";

/* ------------------------------------------------------------------ */
/*  Static params — 16 locales x 10 countries = 160 pages              */
/* ------------------------------------------------------------------ */
export function generateStaticParams() {
  return locales.flatMap((locale) =>
    COUNTRIES.map((country) => ({ locale, slug: country.slug })),
  );
}

/* ------------------------------------------------------------------ */
/*  Locale-aware content helpers                                       */
/* ------------------------------------------------------------------ */
function getCountryName(country: Country, locale: string): string {
  return country.names[locale] || country.names.en;
}

function getTopCities(country: Country, locale: string): string {
  return country.topCities[locale] || country.topCities.en;
}

/** Per-locale SEO title template */
const TITLE_TEMPLATES: Record<string, (c: string) => string> = {
  tr: (c) => `${c} Dating — Qulo | Sorularla Tanis`,
  en: (c) => `Dating in ${c} — Qulo | Meet Through Questions`,
  de: (c) => `Dating in ${c} — Qulo | Kennenlernen durch Fragen`,
  fr: (c) => `Rencontres en ${c} — Qulo | Rencontrez par Questions`,
  es: (c) => `Citas en ${c} — Qulo | Conoce con Preguntas`,
  ar: (c) => `مواعدة في ${c} — Qulo | تعارف عبر الأسئلة`,
  ru: (c) => `Знакомства в ${c} — Qulo | Встречи через вопросы`,
  pt: (c) => `Namoro em ${c} — Qulo | Conheca por Perguntas`,
  it: (c) => `Incontri in ${c} — Qulo | Incontra con Domande`,
  ja: (c) => `${c}でデート — Qulo | 質問で出会う`,
  ko: (c) => `${c} 데이팅 — Qulo | 질문으로 만남`,
  zh: (c) => `${c}约会 — Qulo | 通过问题认识`,
  nl: (c) => `Dating in ${c} — Qulo | Ontmoet Via Vragen`,
  pl: (c) => `Randki w ${c} — Qulo | Poznawaj Przez Pytania`,
  sv: (c) => `Dejting i ${c} — Qulo | Traffas Genom Fragor`,
  hi: (c) => `${c} में डेटिंग — Qulo | सवालों से मिलें`,
};

/** Per-locale SEO description template */
const DESC_TEMPLATES: Record<string, (c: string, p: string) => string> = {
  tr: (c, p) =>
    `${c}'de ${p} nufuslu pazarda Qulo ile tanisin. Soru-cevap tabanli yeni nesil dating uygulamasiyla anlamli baglanti kurun.`,
  en: (c, p) =>
    `Meet new people in ${c} with Qulo. With ${p} population, ${c} offers quiz-based dating for meaningful connections.`,
  de: (c, p) =>
    `Lernen Sie neue Menschen in ${c} kennen. Mit ${p} Einwohnern bietet ${c} fragenbasiertes Dating mit Qulo.`,
  fr: (c, p) =>
    `Rencontrez de nouvelles personnes en ${c} avec Qulo. Avec ${p} habitants, ${c} offre des rencontres par questions.`,
  es: (c, p) =>
    `Conoce gente nueva en ${c} con Qulo. Con ${p} habitantes, ${c} ofrece citas basadas en preguntas.`,
  ar: (c, p) =>
    `تعرف على أشخاص جدد في ${c} مع Qulo. بسكان ${p}، تقدم ${c} مواعدة قائمة على الأسئلة.`,
  ru: (c, p) =>
    `Познакомьтесь с новыми людьми в ${c} с Qulo. С населением ${p}, ${c} предлагает знакомства через вопросы.`,
  pt: (c, p) =>
    `Conheca novas pessoas em ${c} com Qulo. Com ${p} habitantes, ${c} oferece namoro baseado em perguntas.`,
  it: (c, p) =>
    `Incontra nuove persone in ${c} con Qulo. Con ${p} abitanti, ${c} offre incontri basati su domande.`,
  ja: (c, p) =>
    `Quloで${c}の新しい人と出会いましょう。人口${p}の${c}でクイズベースのマッチング。`,
  ko: (c, p) =>
    `Qulo로 ${c}에서 새로운 사람들을 만나세요. 인구 ${p}의 ${c}에서 퀴즈 기반 매칭.`,
  zh: (c, p) =>
    `在${c}用Qulo认识新朋友。${c}人口${p}，提供基于问答的约会。`,
  nl: (c, p) =>
    `Ontmoet nieuwe mensen in ${c} met Qulo. Met ${p} inwoners biedt ${c} dating op basis van vragen.`,
  pl: (c, p) =>
    `Poznaj nowych ludzi w ${c} z Qulo. Z populacja ${p}, ${c} oferuje randki oparte na pytaniach.`,
  sv: (c, p) =>
    `Traffa nya manniskor i ${c} med Qulo. Med ${p} invanare erbjuder ${c} fragor-baserad dejting.`,
  hi: (c, p) =>
    `Qulo के साथ ${c} में नए लोगों से मिलें। ${p} आबादी के साथ ${c} सवाल-आधारित डेटिंग प्रदान करता है।`,
};

/** Per-locale hero heading template */
const HERO_TEMPLATES: Record<string, (c: string) => string> = {
  tr: (c) => `${c} icinde Qulo ile Tanis`,
  en: (c) => `Meet with Qulo in ${c}`,
  de: (c) => `Lerne Menschen in ${c} mit Qulo kennen`,
  fr: (c) => `Rencontrez avec Qulo en ${c}`,
  es: (c) => `Conoce con Qulo en ${c}`,
  ar: (c) => `تعرف مع Qulo في ${c}`,
  ru: (c) => `Знакомьтесь с Qulo в ${c}`,
  pt: (c) => `Conheca com Qulo em ${c}`,
  it: (c) => `Incontra con Qulo in ${c}`,
  ja: (c) => `Quloで${c}の人と出会おう`,
  ko: (c) => `Qulo로 ${c}에서 만남`,
  zh: (c) => `在${c}用Qulo认识`,
  nl: (c) => `Ontmoet met Qulo in ${c}`,
  pl: (c) => `Poznawaj z Qulo w ${c}`,
  sv: (c) => `Traffas med Qulo i ${c}`,
  hi: (c) => `Qulo से ${c} में मिलें`,
};

/** Per-locale "Why Qulo in {country}?" section title */
const WHY_TITLE: Record<string, (c: string) => string> = {
  tr: (c) => `Neden ${c}'de Qulo?`,
  en: (c) => `Why Qulo in ${c}?`,
  de: (c) => `Warum Qulo in ${c}?`,
  fr: (c) => `Pourquoi Qulo en ${c} ?`,
  es: (c) => `Por que Qulo en ${c}?`,
  ar: (c) => `لماذا Qulo في ${c}؟`,
  ru: (c) => `Почему Qulo в ${c}?`,
  pt: (c) => `Por que Qulo em ${c}?`,
  it: (c) => `Perche Qulo in ${c}?`,
  ja: (c) => `なぜ${c}でQulo？`,
  ko: (c) => `왜 ${c}에서 Qulo?`,
  zh: (c) => `为什么在${c}用Qulo？`,
  nl: (c) => `Waarom Qulo in ${c}?`,
  pl: (c) => `Dlaczego Qulo w ${c}?`,
  sv: (c) => `Varfor Qulo i ${c}?`,
  hi: (c) => `${c} में Qulo क्यों?`,
};

/** Per-locale body content paragraphs */
const BODY_TEMPLATES: Record<string, (c: string, p: string) => string[]> = {
  tr: (c, p) => [
    `${c}'de yeni insanlarla tanismak ister misiniz? ${c}, ${p} nufusuyla dating uygulamalari icin buyuk bir potansiyel pazar.`,
    `Swipe tabanli uygulamalar yerine Qulo, soru-cevap sistemiyle daha derin baglantilar kurmanizi saglar. Yuzeyselligi birakip ${c}'de gercek uyumluluklari kesfedin.`,
  ],
  en: (c, p) => [
    `Looking to meet new people in ${c}? With a population of ${p}, ${c} is a large potential market for dating apps.`,
    `Instead of swipe-based apps, Qulo helps you build deeper connections through its question-and-answer system. Move beyond the surface and discover real compatibility in ${c}.`,
  ],
  de: (c, p) => [
    `Moechten Sie neue Menschen in ${c} kennenlernen? Mit einer Bevolkerung von ${p} ist ${c} ein grosser potenzieller Markt fur Dating-Apps.`,
    `Statt Swipe-basierter Apps hilft Qulo Ihnen, durch sein Frage-Antwort-System tiefere Verbindungen aufzubauen. Entdecken Sie echte Kompatibilitat in ${c}.`,
  ],
  fr: (c, p) => [
    `Vous cherchez a rencontrer de nouvelles personnes en ${c} ? Avec une population de ${p}, ${c} est un grand marche potentiel pour les apps de dating.`,
    `Au lieu d'apps basees sur le swipe, Qulo vous aide a construire des connexions plus profondes grace a son systeme de questions-reponses. Decouvrez une vraie compatibilite en ${c}.`,
  ],
  es: (c, p) => [
    `Buscas conocer gente nueva en ${c}? Con una poblacion de ${p}, ${c} es un gran mercado potencial para apps de citas.`,
    `En lugar de apps basadas en deslizar, Qulo te ayuda a construir conexiones mas profundas con su sistema de preguntas y respuestas. Descubre la compatibilidad real en ${c}.`,
  ],
  ar: (c, p) => [
    `هل تبحث عن التعرف على أشخاص جدد في ${c}؟ بسكان يبلغ ${p}، تعد ${c} سوقًا محتملاً كبيرًا لتطبيقات المواعدة.`,
    `بدلاً من التطبيقات القائمة على التمرير، يساعدك Qulo على بناء روابط أعمق من خلال نظام الأسئلة والأجوبة. اكتشف التوافق الحقيقي في ${c}.`,
  ],
  ru: (c, p) => [
    `Хотите познакомиться с новыми людьми в ${c}? С населением ${p} ${c} представляет собой огромный потенциальный рынок для приложений знакомств.`,
    `Вместо свайп-приложений Qulo помогает вам строить более глубокие связи через систему вопросов и ответов. Откройте настоящую совместимость в ${c}.`,
  ],
  pt: (c, p) => [
    `Quer conhecer pessoas novas em ${c}? Com uma populacao de ${p}, ${c} e um grande mercado potencial para apps de namoro.`,
    `Em vez de apps baseados em deslizar, o Qulo ajuda voce a construir conexoes mais profundas com seu sistema de perguntas e respostas. Descubra a compatibilidade real em ${c}.`,
  ],
  it: (c, p) => [
    `Vuoi incontrare nuove persone in ${c}? Con una popolazione di ${p}, ${c} e un grande mercato potenziale per le app di incontri.`,
    `Invece di app basate sullo swipe, Qulo ti aiuta a costruire connessioni piu profonde con il suo sistema di domande e risposte. Scopri la vera compatibilita in ${c}.`,
  ],
  ja: (c, p) => [
    `${c}で新しい人と出会いたいですか？人口${p}の${c}は、デートアプリにとって大きな潜在市場です。`,
    `スワイプベースのアプリの代わりに、Quloは質問と回答のシステムを通じてより深いつながりを築くお手伝いをします。${c}で本当の相性を発見しましょう。`,
  ],
  ko: (c, p) => [
    `${c}에서 새로운 사람들을 만나고 싶으신가요? ${p} 인구를 가진 ${c}는 데이팅 앱에 큰 잠재 시장입니다.`,
    `스와이프 기반 앱 대신, Qulo는 질문-답변 시스템을 통해 더 깊은 연결을 구축하도록 도와줍니다. ${c}에서 진정한 호환성을 발견하세요.`,
  ],
  zh: (c, p) => [
    `想在${c}认识新朋友吗？${c}人口${p}，是约会应用的巨大潜在市场。`,
    `与其使用基于滑动的应用，Qulo通过问答系统帮助你建立更深层次的联系。在${c}发现真正的兼容性。`,
  ],
  nl: (c, p) => [
    `Wil je nieuwe mensen ontmoeten in ${c}? Met een bevolking van ${p} is ${c} een grote potentiele markt voor datingapps.`,
    `In plaats van swipe-gebaseerde apps helpt Qulo je diepere connecties op te bouwen via zijn vraag-antwoord-systeem. Ontdek echte compatibiliteit in ${c}.`,
  ],
  pl: (c, p) => [
    `Chcesz poznac nowych ludzi w ${c}? Z populacja ${p}, ${c} to duzy potencjalny rynek dla aplikacji randkowych.`,
    `Zamiast aplikacji opartych na przesuwaniu, Qulo pomaga budowac glebsze polaczenia poprzez system pytan i odpowiedzi. Odkryj prawdziwa kompatybilnosc w ${c}.`,
  ],
  sv: (c, p) => [
    `Vill du traffa nya manniskor i ${c}? Med en befolkning pa ${p} ar ${c} en stor potentiell marknad for dejtingappar.`,
    `Istallet for swipe-baserade appar hjalper Qulo dig att bygga djupare kontakter genom sitt fraga-svar-system. Upptack riktig kompatibilitet i ${c}.`,
  ],
  hi: (c, p) => [
    `क्या आप ${c} में नए लोगों से मिलना चाहते हैं? ${p} आबादी के साथ ${c} डेटिंग ऐप्स के लिए एक बड़ा संभावित बाज़ार है।`,
    `स्वाइप-आधारित ऐप्स के बजाय, Qulo अपने सवाल-जवाब प्रणाली के माध्यम से गहरे कनेक्शन बनाने में मदद करता है। ${c} में वास्तविक अनुकूलता की खोज करें।`,
  ],
};

/** Per-locale "Popular Cities" label */
const POPULAR_CITIES_LABEL: Record<string, string> = {
  tr: "Populer Sehirler", en: "Popular Cities", de: "Beliebte Stadte", fr: "Villes Populaires", es: "Ciudades Populares",
  ar: "المدن الشعبية", ru: "Популярные города", pt: "Cidades Populares", it: "Citta Popolari", ja: "人気の都市",
  ko: "인기 도시", zh: "热门城市", nl: "Populaire steden", pl: "Popularne miasta", sv: "Populara stader", hi: "लोकप्रिय शहर",
};

/** Per-locale "Qulo in these cities" label */
const QULO_CITIES_LABEL: Record<string, string> = {
  tr: "Qulo'da Bu Sehirler", en: "Qulo in These Cities", de: "Qulo in diesen Stadten", fr: "Qulo dans ces villes", es: "Qulo en estas ciudades",
  ar: "Qulo في هذه المدن", ru: "Qulo в этих городах", pt: "Qulo nessas cidades", it: "Qulo in queste citta", ja: "これらの都市のQulo",
  ko: "이 도시의 Qulo", zh: "这些城市的Qulo", nl: "Qulo in deze steden", pl: "Qulo w tych miastach", sv: "Qulo i dessa stader", hi: "इन शहरों में Qulo",
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
const STATS_LABELS: Record<string, { population: string; languages: string }> = {
  tr: { population: "Ulke Nufusu", languages: "Dil Destegi" },
  en: { population: "Country Population", languages: "Languages" },
  de: { population: "Bevolkerung", languages: "Sprachen" },
  fr: { population: "Population", languages: "Langues" },
  es: { population: "Poblacion", languages: "Idiomas" },
  ar: { population: "عدد السكان", languages: "اللغات" },
  ru: { population: "Население", languages: "Языки" },
  pt: { population: "Populacao", languages: "Idiomas" },
  it: { population: "Popolazione", languages: "Lingue" },
  ja: { population: "人口", languages: "言語" },
  ko: { population: "인구", languages: "언어" },
  zh: { population: "人口", languages: "语言" },
  nl: { population: "Bevolking", languages: "Talen" },
  pl: { population: "Populacja", languages: "Jezyki" },
  sv: { population: "Befolkning", languages: "Sprak" },
  hi: { population: "जनसंख्या", languages: "भाषाएं" },
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

/** Per-locale "Other Countries" label */
const OTHER_COUNTRIES_LABEL: Record<string, string> = {
  tr: "Diger Ulkeler", en: "Other Countries", de: "Andere Lander", fr: "Autres pays", es: "Otros paises",
  ar: "دول أخرى", ru: "Другие страны", pt: "Outros paises", it: "Altri paesi", ja: "他の国",
  ko: "다른 국가", zh: "其他国家", nl: "Andere landen", pl: "Inne kraje", sv: "Andra lander", hi: "अन्य देश",
};

/** Per-locale "All Countries" label */
const ALL_COUNTRIES_LABEL: Record<string, string> = {
  tr: "Tum Ulkeler", en: "All Countries", de: "Alle Lander", fr: "Tous les pays", es: "Todos los paises",
  ar: "كل الدول", ru: "Все страны", pt: "Todos os paises", it: "Tutti i paesi", ja: "すべての国",
  ko: "모든 국가", zh: "所有国家", nl: "Alle landen", pl: "Wszystkie kraje", sv: "Alla lander", hi: "सभी देश",
};

/* ------------------------------------------------------------------ */
/*  Metadata                                                           */
/* ------------------------------------------------------------------ */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  const country = COUNTRIES.find((c) => c.slug === slug);
  if (!country) return {};

  const countryName = getCountryName(country, locale);
  const titleFn = TITLE_TEMPLATES[locale] || TITLE_TEMPLATES.en;
  const descFn = DESC_TEMPLATES[locale] || DESC_TEMPLATES.en;
  const title = titleFn(countryName);
  const description = descFn(countryName, country.population);
  const pageUrl = `${SITE_URL}/${locale}/country/${slug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/country/${slug}`;
  languages["x-default"] = `${SITE_URL}/tr/country/${slug}`;

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
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
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
export default async function CountryDetailPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const country = COUNTRIES.find((c) => c.slug === slug);
  if (!country) notFound();

  const countryName = getCountryName(country, locale);
  const topCitiesText = getTopCities(country, locale);

  const heroFn = HERO_TEMPLATES[locale] || HERO_TEMPLATES.en;
  const whyFn = WHY_TITLE[locale] || WHY_TITLE.en;
  const bodyFn = BODY_TEMPLATES[locale] || BODY_TEMPLATES.en;
  const howItWorks = HOW_IT_WORKS[locale] || HOW_IT_WORKS.en;
  const statsLabels = STATS_LABELS[locale] || STATS_LABELS.en;
  const ctaLabels = CTA_LABELS[locale] || CTA_LABELS.en;
  const popularCitiesLabel = POPULAR_CITIES_LABEL[locale] || POPULAR_CITIES_LABEL.en;
  const quloCitiesLabel = QULO_CITIES_LABEL[locale] || QULO_CITIES_LABEL.en;
  const otherCountriesLabel = OTHER_COUNTRIES_LABEL[locale] || OTHER_COUNTRIES_LABEL.en;
  const allCountriesLabel = ALL_COUNTRIES_LABEL[locale] || ALL_COUNTRIES_LABEL.en;

  const bodyParagraphs = bodyFn(countryName, country.population);
  const otherCountries = COUNTRIES.filter((c) => c.slug !== slug).slice(0, 4);

  // Map quloCities slugs to actual City objects (filter out missing)
  const linkedCities = country.quloCities
    .map((citySlug) => CITIES.find((c) => c.slug === citySlug))
    .filter((c): c is NonNullable<typeof c> => Boolean(c));

  /* JSON-LD: Country + SoftwareApplication */
  const countryJsonLd = {
    "@context": "https://schema.org",
    "@type": "Country",
    name: countryName,
    url: `${SITE_URL}/${locale}/country/${slug}`,
  };

  const appJsonLd = {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    name: "Qulo",
    operatingSystem: "iOS, Android",
    applicationCategory: "SocialNetworkingApplication",
    url: SITE_URL,
    description: (DESC_TEMPLATES[locale] || DESC_TEMPLATES.en)(countryName, country.population),
    offers: {
      "@type": "Offer",
      price: "0",
      priceCurrency: "USD",
    },
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      <JsonLd data={countryJsonLd} />
      <JsonLd data={appJsonLd} />

      {/* Hero Section */}
      <section className="pt-28 pb-16 px-6 text-center">
        <div className="max-w-3xl mx-auto">
          <div className="text-left">
            <Breadcrumb
              locale={locale}
              items={[
                { label: allCountriesLabel, href: `/${locale}/country` },
                { label: countryName },
              ]}
            />
          </div>
          <p className="text-6xl mb-4" aria-hidden="true">{country.emoji}</p>
          <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
            {countryName}
          </p>
          <h1 className="text-4xl sm:text-5xl font-bold mb-6">
            {heroFn(countryName)}
          </h1>
          <p className="text-qulo-text-secondary text-base max-w-xl mx-auto mb-8">
            {bodyParagraphs[0]}
          </p>
          <StoreButtons />
        </div>
      </section>

      {/* Why Qulo in {country} */}
      <section className="py-16 px-6">
        <div className="max-w-3xl mx-auto">
          <h2 className="text-2xl sm:text-3xl font-bold mb-6 text-center">
            {whyFn(countryName)}
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

      {/* Popular Cities */}
      <section className="py-16 px-6">
        <div className="max-w-3xl mx-auto">
          <h2 className="text-2xl sm:text-3xl font-bold mb-6 text-center">
            {popularCitiesLabel}
          </h2>
          <p className="text-qulo-text-secondary text-sm text-center mb-8">
            {topCitiesText}
          </p>

          {linkedCities.length > 0 && (
            <>
              <h3 className="text-sm font-semibold text-qulo-purple mb-4 text-center uppercase tracking-[0.15em]">
                {quloCitiesLabel}
              </h3>
              <div className="flex flex-wrap justify-center gap-3">
                {linkedCities.map((city) => (
                  <Link
                    key={city.slug}
                    href={`/${locale}/dating/${city.slug}`}
                    className="text-sm px-5 py-3 rounded-full border border-qulo-purple/30 bg-qulo-purple/10 text-white hover:border-qulo-purple/60 hover:bg-qulo-purple/20 transition-colors"
                  >
                    {city.emoji} {city.names[locale] || city.names.en}
                  </Link>
                ))}
              </div>
            </>
          )}
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
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
            <div className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 text-center">
              <p className="text-3xl font-bold text-qulo-green mb-1">
                {country.population}
              </p>
              <p className="text-xs text-qulo-text-secondary">
                {statsLabels.population}
              </p>
            </div>
            <div className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 text-center">
              <p className="text-3xl font-bold text-qulo-green mb-1">16</p>
              <p className="text-xs text-qulo-text-secondary">
                {statsLabels.languages}
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

      {/* Other Countries + Internal Links */}
      <section className="py-16 px-6">
        <div className="max-w-3xl mx-auto">
          <h3 className="text-lg font-bold mb-6 text-center">
            {otherCountriesLabel}
          </h3>
          <div className="flex flex-wrap justify-center gap-3">
            {otherCountries.map((oc) => (
              <Link
                key={oc.slug}
                href={`/${locale}/country/${oc.slug}`}
                className="text-xs px-4 py-2 rounded-full border border-white/[0.08] bg-white/[0.03] text-qulo-text-secondary hover:text-white hover:border-qulo-purple/30 transition-colors"
              >
                {oc.emoji} {getCountryName(oc, locale)}
              </Link>
            ))}
          </div>
          <div className="flex flex-wrap justify-center gap-4 mt-8">
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
              {locale === "tr" ? "Sehirler" : "Cities"}
            </Link>
            <Link
              href={`/${locale}/country`}
              className="text-xs text-qulo-purple hover:underline"
            >
              {allCountriesLabel}
            </Link>
          </div>
        </div>
      </section>

      <Footer />
    </main>
  );
}
