import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { FAQ, type FAQItem } from "@/components/shared/FAQ";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { JsonLd } from "@/components/shared/JsonLd";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES, APP_JSON_LD_ID } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

const LABELS: Record<string, { title: string; subtitle: string; mostPopular: string; faqTitle: string; everythingInFree: string; everythingInPlus: string; perMonth: string; forever: string }> = {
  tr: { title: "Fiyatlandırma", subtitle: "Basit, şeffaf fiyatlandırma. Her zaman ücretsiz kullanabilirsin.", mostPopular: "EN POPÜLER", faqTitle: "Sık Sorulan Sorular", everythingInFree: "Free'deki her şey +", everythingInPlus: "Plus'takilerin hepsi +", perMonth: "/ay", forever: "sonsuza kadar" },
  en: { title: "Pricing", subtitle: "Simple, transparent pricing. Always free to start.", mostPopular: "MOST POPULAR", faqTitle: "Frequently Asked Questions", everythingInFree: "Everything in Free +", everythingInPlus: "Everything in Plus +", perMonth: "/month", forever: "forever" },
  de: { title: "Preise", subtitle: "Einfache, transparente Preise. Immer kostenlos starten.", mostPopular: "AM BELIEBTESTEN", faqTitle: "Häufig gestellte Fragen", everythingInFree: "Alles in Free +", everythingInPlus: "Alles in Plus +", perMonth: "/Monat", forever: "für immer" },
  fr: { title: "Tarifs", subtitle: "Tarification simple et transparente.", mostPopular: "LE PLUS POPULAIRE", faqTitle: "Questions fréquemment posées", everythingInFree: "Tout de Free +", everythingInPlus: "Tout de Plus +", perMonth: "/mois", forever: "pour toujours" },
  es: { title: "Precios", subtitle: "Precios simples y transparentes.", mostPopular: "MÁS POPULAR", faqTitle: "Preguntas frecuentes", everythingInFree: "Todo de Free +", everythingInPlus: "Todo de Plus +", perMonth: "/mes", forever: "para siempre" },
  ar: { title: "الأسعار", subtitle: "أسعار بسيطة وواضحة. البداية مجانية دائمًا.", mostPopular: "الأكثر شيوعًا", faqTitle: "الأسئلة الشائعة", everythingInFree: "كل ما في Free +", everythingInPlus: "كل ما في Plus +", perMonth: "/شهر", forever: "للأبد" },
  ru: { title: "Тарифы", subtitle: "Простые и прозрачные тарифы. Начать всегда бесплатно.", mostPopular: "САМЫЙ ПОПУЛЯРНЫЙ", faqTitle: "Частые вопросы", everythingInFree: "Всё из Free +", everythingInPlus: "Всё из Plus +", perMonth: "/мес", forever: "навсегда" },
  pt: { title: "Preços", subtitle: "Preços simples e transparentes. Começar é sempre grátis.", mostPopular: "MAIS POPULAR", faqTitle: "Perguntas frequentes", everythingInFree: "Tudo do Free +", everythingInPlus: "Tudo do Plus +", perMonth: "/mês", forever: "para sempre" },
  it: { title: "Prezzi", subtitle: "Prezzi semplici e trasparenti. Iniziare è sempre gratis.", mostPopular: "PIÙ POPOLARE", faqTitle: "Domande frequenti", everythingInFree: "Tutto di Free +", everythingInPlus: "Tutto di Plus +", perMonth: "/mese", forever: "per sempre" },
  ja: { title: "料金プラン", subtitle: "シンプルで分かりやすい料金。はじめるのはいつでも無料です。", mostPopular: "人気プラン", faqTitle: "よくある質問", everythingInFree: "Free のすべて +", everythingInPlus: "Plus のすべて +", perMonth: "/月", forever: "ずっと無料" },
  ko: { title: "요금제", subtitle: "간단하고 투명한 요금제. 시작은 언제나 무료입니다.", mostPopular: "가장 인기", faqTitle: "자주 묻는 질문", everythingInFree: "Free의 모든 기능 +", everythingInPlus: "Plus의 모든 기능 +", perMonth: "/월", forever: "계속 무료" },
  zh: { title: "价格方案", subtitle: "简单透明的价格。开始使用永远免费。", mostPopular: "最受欢迎", faqTitle: "常见问题", everythingInFree: "包含 Free 的全部 +", everythingInPlus: "包含 Plus 的全部 +", perMonth: "/月", forever: "永久免费" },
  nl: { title: "Prijzen", subtitle: "Eenvoudige, transparante prijzen. Beginnen is altijd gratis.", mostPopular: "MEEST GEKOZEN", faqTitle: "Veelgestelde vragen", everythingInFree: "Alles van Free +", everythingInPlus: "Alles van Plus +", perMonth: "/maand", forever: "altijd" },
  pl: { title: "Cennik", subtitle: "Proste, przejrzyste ceny. Start jest zawsze bezpłatny.", mostPopular: "NAJPOPULARNIEJSZY", faqTitle: "Często zadawane pytania", everythingInFree: "Wszystko z Free +", everythingInPlus: "Wszystko z Plus +", perMonth: "/mies.", forever: "na zawsze" },
  sv: { title: "Priser", subtitle: "Enkla, transparenta priser. Att börja är alltid gratis.", mostPopular: "POPULÄRAST", faqTitle: "Vanliga frågor", everythingInFree: "Allt i Free +", everythingInPlus: "Allt i Plus +", perMonth: "/mån", forever: "för alltid" },
  hi: { title: "कीमतें", subtitle: "आसान और पारदर्शी कीमतें। शुरुआत हमेशा मुफ़्त है।", mostPopular: "सबसे लोकप्रिय", faqTitle: "अक्सर पूछे जाने वाले सवाल", everythingInFree: "Free की सभी सुविधाएँ +", everythingInPlus: "Plus की सभी सुविधाएँ +", perMonth: "/महीना", forever: "हमेशा मुफ़्त" },
};

function getLabels(locale: string) {
  return LABELS[locale] || LABELS.en;
}

/**
 * Tier feature lists.
 *
 * The question cap is per subscription plan and comes from the active
 * `economy_config_versions` row (`subscriptionLimits[plan].maxQuestions`):
 * free 4, Plus 6, Premium 10. The minimum is 2 for every plan
 * (`MIN_REQUIRED_QUESTIONS` in qulo-server `question.service.ts`). The site
 * used to advertise "2-10 questions" on every tier, which is only true of
 * Premium — do not reinstate a range ending at 10 without naming the plan.
 *
 * "AI question suggestions" was removed: nothing calls a model at request
 * time. The feature reads a pre-built `ai_question_bank` table, so it is a
 * library of ready-made questions written with AI in advance — which is what
 * the bullet now says. It covers all 18 of the app's languages (live table
 * checked 2026-09-14: every locale has 369+ rows).
 */
const FEATURES_FREE: Record<string, string[]> = {
  tr: ["2-4 soru oluşturma", "Günlük 10 eşleşme keşfi", "Mesajlaşma", "Temel filtreleme", "18 dil desteği"],
  en: ["Create 2-4 questions", "10 daily match discoveries", "Messaging", "Basic filters", "18 language support"],
  de: ["2-4 Fragen erstellen", "10 Matches pro Tag", "Messaging", "Grundfilter", "18 Sprachen"],
  fr: ["Créer 2-4 questions", "10 découvertes par jour", "Messagerie", "Filtres de base", "18 langues"],
  es: ["Crear 2-4 preguntas", "10 descubrimientos diarios", "Mensajería", "Filtros básicos", "18 idiomas"],
  ar: ["إنشاء 2-4 أسئلة", "10 اكتشافات تطابق يوميًا", "المراسلة", "فلاتر أساسية", "دعم 18 لغة"],
  ru: ["Создание 2-4 вопросов", "10 подборок совпадений в день", "Сообщения", "Базовые фильтры", "Поддержка 18 языков"],
  pt: ["Criar 2-4 perguntas", "10 descobertas por dia", "Mensagens", "Filtros básicos", "Suporte a 18 idiomas"],
  it: ["Crea 2-4 domande", "10 scoperte al giorno", "Messaggi", "Filtri di base", "Supporto in 18 lingue"],
  ja: ["2〜4問の質問を作成", "1日10件のマッチ候補", "メッセージ", "基本フィルター", "18言語対応"],
  ko: ["질문 2~4개 작성", "하루 10명 매칭 탐색", "메시지", "기본 필터", "18개 언어 지원"],
  zh: ["创建 2-4 个问题", "每天 10 次匹配发现", "消息", "基础筛选", "支持 18 种语言"],
  nl: ["2-4 vragen maken", "10 matchsuggesties per dag", "Berichten", "Basisfilters", "18 talen"],
  pl: ["Tworzenie 2-4 pytań", "10 propozycji dopasowań dziennie", "Wiadomości", "Podstawowe filtry", "18 języków"],
  sv: ["Skapa 2-4 frågor", "10 matchförslag per dag", "Meddelanden", "Grundfilter", "18 språk"],
  hi: ["2-4 सवाल बनाएँ", "रोज़ 10 मैच सुझाव", "मैसेजिंग", "बेसिक फ़िल्टर", "18 भाषाओं का समर्थन"],
};

const FEATURES_PLUS: Record<string, string[]> = {
  tr: ["En fazla 6 soru oluşturma", "Sınırsız eşleşme keşfi", "Gelişmiş filtreler", "Boost (günde 1)", "Güçler (günde 3)", "Reklamsız deneyim"],
  en: ["Create up to 6 questions", "Unlimited match discovery", "Advanced filters", "Boost (1/day)", "Powers (3/day)", "Ad-free experience"],
  de: ["Bis zu 6 Fragen erstellen", "Unbegrenzte Matches", "Erweiterte Filter", "Boost (1/Tag)", "Powers (3/Tag)", "Werbefreie Nutzung"],
  fr: ["Créer jusqu'à 6 questions", "Matchs illimités", "Filtres avancés", "Boost (1/jour)", "Pouvoirs (3/jour)", "Sans publicité"],
  es: ["Crear hasta 6 preguntas", "Matches ilimitados", "Filtros avanzados", "Boost (1/día)", "Poderes (3/día)", "Sin anuncios"],
  ar: ["إنشاء حتى 6 أسئلة", "اكتشاف تطابقات بلا حدود", "فلاتر متقدمة", "Boost (1 يوميًا)", "قدرات (3 يوميًا)", "تجربة بدون إعلانات"],
  ru: ["Создание до 6 вопросов", "Неограниченный поиск совпадений", "Расширенные фильтры", "Boost (1/день)", "Силы (3/день)", "Без рекламы"],
  pt: ["Criar até 6 perguntas", "Descoberta ilimitada de matches", "Filtros avançados", "Boost (1/dia)", "Poderes (3/dia)", "Sem anúncios"],
  it: ["Crea fino a 6 domande", "Scoperta illimitata di match", "Filtri avanzati", "Boost (1/giorno)", "Poteri (3/giorno)", "Senza pubblicità"],
  ja: ["最大6問の質問を作成", "マッチ候補は無制限", "詳細フィルター", "ブースト（1日1回）", "パワー（1日3回）", "広告なし"],
  ko: ["질문 최대 6개 작성", "매칭 탐색 무제한", "고급 필터", "부스트 (1일 1회)", "파워 (1일 3회)", "광고 없음"],
  zh: ["创建最多 6 个问题", "无限匹配发现", "高级筛选", "Boost（每天 1 次）", "能力（每天 3 次）", "无广告"],
  nl: ["Tot 6 vragen maken", "Onbeperkt matches ontdekken", "Geavanceerde filters", "Boost (1/dag)", "Powers (3/dag)", "Zonder advertenties"],
  pl: ["Tworzenie do 6 pytań", "Nieograniczone odkrywanie dopasowań", "Filtry zaawansowane", "Boost (1/dzień)", "Moce (3/dzień)", "Bez reklam"],
  sv: ["Skapa upp till 6 frågor", "Obegränsat med matchförslag", "Avancerade filter", "Boost (1/dag)", "Krafter (3/dag)", "Utan annonser"],
  hi: ["6 सवाल तक बनाएँ", "असीमित मैच खोज", "एडवांस्ड फ़िल्टर", "बूस्ट (रोज़ 1)", "पावर (रोज़ 3)", "विज्ञापन नहीं"],
};

const FEATURES_PREMIUM: Record<string, string[]> = {
  tr: ["En fazla 10 soru oluşturma", "Sınırsız boost", "Sınırsız güç kullanımı", "Profilini görenleri gör", "Hazır soru önerileri kütüphanesi", "Öncelikli destek", "Passport"],
  en: ["Create up to 10 questions", "Unlimited boost", "Unlimited powers", "See who viewed your profile", "Library of ready-made question suggestions", "Priority support", "Passport"],
  de: ["Bis zu 10 Fragen erstellen", "Unbegrenzte Boosts", "Unbegrenzte Powers", "Profil-Besucher sehen", "Bibliothek vorgefertigter Fragenvorschläge", "Premium-Support", "Passport"],
  fr: ["Créer jusqu'à 10 questions", "Boost illimité", "Pouvoirs illimités", "Voir qui a vu votre profil", "Bibliothèque de questions toutes prêtes", "Support prioritaire", "Passport"],
  es: ["Crear hasta 10 preguntas", "Boost ilimitado", "Poderes ilimitados", "Ver quién vio tu perfil", "Biblioteca de preguntas ya escritas", "Soporte prioritario", "Passport"],
  ar: ["إنشاء حتى 10 أسئلة", "Boost بلا حدود", "قدرات بلا حدود", "شاهد من زار ملفك", "مكتبة أسئلة جاهزة", "دعم ذو أولوية", "Passport"],
  ru: ["Создание до 10 вопросов", "Неограниченный boost", "Неограниченные силы", "Кто смотрел ваш профиль", "Библиотека готовых вопросов", "Приоритетная поддержка", "Passport"],
  pt: ["Criar até 10 perguntas", "Boost ilimitado", "Poderes ilimitados", "Veja quem viu seu perfil", "Biblioteca de perguntas prontas", "Suporte prioritário", "Passport"],
  it: ["Crea fino a 10 domande", "Boost illimitato", "Poteri illimitati", "Scopri chi ha visto il tuo profilo", "Libreria di domande pronte", "Supporto prioritario", "Passport"],
  ja: ["最大10問の質問を作成", "ブースト無制限", "パワー無制限", "プロフィールを見た人がわかる", "既製の質問ライブラリ", "優先サポート", "Passport"],
  ko: ["질문 최대 10개 작성", "부스트 무제한", "파워 무제한", "프로필 방문자 보기", "미리 만들어진 질문 라이브러리", "우선 지원", "Passport"],
  zh: ["创建最多 10 个问题", "无限 Boost", "无限能力", "查看谁看过你的资料", "现成问题库", "优先客服", "Passport"],
  nl: ["Tot 10 vragen maken", "Onbeperkt boosten", "Onbeperkte powers", "Zie wie je profiel bekeek", "Bibliotheek met kant-en-klare vragen", "Voorrang bij support", "Passport"],
  pl: ["Tworzenie do 10 pytań", "Nieograniczony boost", "Nieograniczone moce", "Zobacz, kto oglądał Twój profil", "Biblioteka gotowych pytań", "Priorytetowe wsparcie", "Passport"],
  sv: ["Skapa upp till 10 frågor", "Obegränsad boost", "Obegränsade krafter", "Se vem som besökt din profil", "Bibliotek med färdiga frågor", "Prioriterad support", "Passport"],
  hi: ["10 सवाल तक बनाएँ", "असीमित बूस्ट", "असीमित पावर", "देखें किसने आपकी प्रोफ़ाइल देखी", "तैयार सवालों की लाइब्रेरी", "प्राथमिकता वाला सपोर्ट", "Passport"],
};

// i18n-partial-ok: 2026-09-26 — bu SSS para ve iade iddialari tasiyor (soru ust
// siniri 4/6/10, alt sinir 2, 14 gunluk magaza iade politikasi). 14 dile aceleyle
// cevrilmesi yanlis bir hukuki/fiyat iddiasi yaymak riski demek; ayri bir icerik
// turunde, `verify:claims` ile birlikte yapilacak. Backlog: tasks/todo.md.
const FAQ_DATA_PRICING: Record<string, FAQItem[]> = {
  tr: [
    { q: "Qulo ücretsiz mi?", a: "Evet, Qulo Free tier her zaman ücretsizdir. 2 ila 4 soru oluşturabilir, eşleşebilir ve mesajlaşabilirsiniz." },
    { q: "İstediğim zaman iptal edebilir miyim?", a: "Evet, Plus veya Premium aboneliğinizi istediğiniz zaman iptal edebilirsiniz. Dönem sonuna kadar kullanmaya devam edersiniz." },
    { q: "Free ile Plus arasındaki fark nedir?", a: "Soru sayısı üst sınırı Free'de 4, Plus'ta 6'dır (alt sınır her planda 2). Plus ayrıca sınırsız eşleşme keşfi, gelişmiş filtreler, günlük boost ve güç kullanımı sunar. Free tier günlük sınırlamalarla çalışır." },
    { q: "Para iade garantisi var mı?", a: "App Store ve Google Play'in standart iade politikaları geçerlidir. İlk 14 gün içinde platform üzerinden iade talep edebilirsiniz." },
    { q: "Plus ile Premium arasındaki fark?", a: "Premium soru sınırını 10'a çıkarır (Plus'ta 6) ve sınırsız boost ve güç, profil ziyaretçileri görme, hazır soru önerileri kütüphanesi ve Passport (farklı şehirlerde eşleşme) özelliklerini içerir." },
  ],
  en: [
    { q: "Is Qulo free?", a: "Yes, Qulo's Free tier is free forever. You can write 2 to 4 questions, match, and message without paying." },
    { q: "Can I cancel anytime?", a: "Yes, you can cancel your Plus or Premium subscription anytime. You'll continue to have access until the end of your billing period." },
    { q: "What's the difference between Free and Plus?", a: "The question cap is 4 on Free and 6 on Plus (the minimum is 2 on every plan). Plus also offers unlimited match discovery, advanced filters, daily boosts and power uses. Free tier works with daily limits." },
    { q: "Is there a refund policy?", a: "Standard App Store and Google Play refund policies apply. You can request a refund within 14 days through the platform." },
    { q: "What's the difference between Plus and Premium?", a: "Premium raises the question cap to 10 (6 on Plus) and includes unlimited boost and powers, seeing profile visitors, a library of ready-made question suggestions, and Passport (matching in different cities)." },
  ],
};

export async function generateMetadata({ params }: { params: Promise<{ locale: string }> }): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.pricing?.[locale] || PAGE_SEO.pricing?.en || { title: "Pricing — Qulo", description: "Qulo pricing plans" };
  const pageUrl = `${SITE_URL}/${locale}/pricing`;
  const ogLocale = OG_LOCALES[locale] || "en_US";
  const languages = alternateLanguages("/pricing");

  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: seo.title, description: seo.description, url: pageUrl, siteName: SITE_NAME, type: "website", locale: ogLocale, images: ogImages() },
    twitter: { card: "summary_large_image", title: seo.title, description: seo.description, images: ogImages() },
  };
}

/**
 * JSON-LD for the app's plans — static server constants only, no user input.
 *
 * This used to be `@type: "Product"`. It was wrong twice over:
 *
 *  1. Nothing is sold on this page. Purchases happen inside the app, through
 *     the App Store and Play billing. Google's Product guidance is for pages
 *     where the product can be bought, and marking one up otherwise is what
 *     put this page in the **Merchant listings** report — which then asked for
 *     `shippingDetails` and `hasMerchantReturnPolicy` (reported 2026-09-19,
 *     8 items each). There is nothing to ship and the refund route is the
 *     store's, not ours, so those fields could never be answered honestly.
 *  2. It described the app a second time, as a separate entity from the
 *     site-wide `SoftwareApplication`, with a different offer set — that one
 *     says the app is free, this one said it costs 4.99/9.99. Two entities,
 *     one app, contradicting each other.
 *
 * `SoftwareApplication` is the documented type for an app, and sharing
 * `APP_JSON_LD_ID` with the site-wide declaration makes the two one entity:
 * free to install, with paid tiers. The prices stay because they are true and
 * visible on this page.
 *
 * The old comment also claimed this enabled a star rating. There is no
 * `aggregateRating` here and there must not be one — we have no ratings of our
 * own to report, and store ratings are not ours to mark up.
 */
function PlansJsonLd() {
  const data = {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    "@id": APP_JSON_LD_ID,
    name: SITE_NAME,
    applicationCategory: "SocialNetworkingApplication",
    operatingSystem: "iOS, Android",
    description: "Question-based dating app with Free, Plus, and Premium tiers",
    image: `${SITE_URL}/images/og-image.png`,
    offers: [
      { "@type": "Offer", name: "Free", price: "0", priceCurrency: "USD" },
      { "@type": "Offer", name: "Plus", price: "4.99", priceCurrency: "USD" },
      { "@type": "Offer", name: "Premium", price: "9.99", priceCurrency: "USD" },
    ],
  };
  return <JsonLd data={data} />;
}

export default async function PricingPage({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const L = getLabels(locale);
  const freeFeatures = FEATURES_FREE[locale] || FEATURES_FREE.en;
  const plusFeatures = FEATURES_PLUS[locale] || FEATURES_PLUS.en;
  const premiumFeatures = FEATURES_PREMIUM[locale] || FEATURES_PREMIUM.en;
  const faqItems = FAQ_DATA_PRICING[locale] || FAQ_DATA_PRICING.en;

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <PlansJsonLd />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-5xl mx-auto">
          <Breadcrumb locale={locale} items={[{ label: L.title }]} />

          <header className="text-center mb-12">
            <h1 className="text-4xl sm:text-5xl font-bold mb-3">{L.title}</h1>
            <p className="text-qulo-text-secondary text-lg">{L.subtitle}</p>
          </header>

          <div className="grid md:grid-cols-3 gap-6 mb-16">
            {/* Free tier */}
            <div className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-8">
              <h2 className="text-2xl font-bold text-white mb-2">Free</h2>
              <p className="text-4xl font-black text-white mb-1">$0</p>
              <p className="text-xs text-qulo-text-secondary mb-6">{L.forever}</p>
              <ul className="space-y-3 mb-8">
                {freeFeatures.map((f, i) => (
                  <li key={i} className="flex items-start gap-2 text-sm">
                    <span className="text-qulo-green shrink-0" aria-hidden="true">✓</span>
                    <span className="text-qulo-text-secondary">{f}</span>
                  </li>
                ))}
              </ul>
              <div className="flex justify-center">
                <StoreButtons campaign="web-pricing" />
              </div>
            </div>

            {/* Plus tier (most popular) */}
            <div className="relative rounded-2xl border-2 border-qulo-green bg-white/[0.05] p-8">
              <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 rounded-full bg-qulo-green text-qulo-bg text-[10px] font-bold">
                {L.mostPopular}
              </div>
              <h2 className="text-2xl font-bold text-qulo-green mb-2">Plus</h2>
              <p className="text-4xl font-black text-white mb-1">
                $4.99
                <span className="text-base font-normal text-qulo-text-secondary">{L.perMonth}</span>
              </p>
              <p className="text-xs text-qulo-text-secondary mb-6">{L.everythingInFree}</p>
              <ul className="space-y-3 mb-8">
                {plusFeatures.map((f, i) => (
                  <li key={i} className="flex items-start gap-2 text-sm">
                    <span className="text-qulo-green shrink-0" aria-hidden="true">✓</span>
                    <span className="text-qulo-text-secondary">{f}</span>
                  </li>
                ))}
              </ul>
              <div className="flex justify-center">
                <StoreButtons campaign="web-pricing" />
              </div>
            </div>

            {/* Premium tier */}
            <div className="rounded-2xl border border-qulo-purple/40 bg-gradient-to-br from-qulo-purple/10 to-transparent p-8">
              <h2 className="text-2xl font-bold text-qulo-purple mb-2">Premium</h2>
              <p className="text-4xl font-black text-white mb-1">
                $9.99
                <span className="text-base font-normal text-qulo-text-secondary">{L.perMonth}</span>
              </p>
              <p className="text-xs text-qulo-text-secondary mb-6">{L.everythingInPlus}</p>
              <ul className="space-y-3 mb-8">
                {premiumFeatures.map((f, i) => (
                  <li key={i} className="flex items-start gap-2 text-sm">
                    <span className="text-qulo-purple shrink-0" aria-hidden="true">✓</span>
                    <span className="text-qulo-text-secondary">{f}</span>
                  </li>
                ))}
              </ul>
              <div className="flex justify-center">
                <StoreButtons campaign="web-pricing" />
              </div>
            </div>
          </div>

          <FAQ items={faqItems} title={L.faqTitle} />
        </div>
      </div>

      <Footer />
    </main>
  );
}
