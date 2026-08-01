import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { FAQ, type FAQItem } from "@/components/shared/FAQ";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

const LABELS: Record<string, { title: string; subtitle: string; mostPopular: string; faqTitle: string; everythingInFree: string; everythingInPlus: string; perMonth: string; forever: string }> = {
  tr: { title: "Fiyatlandırma", subtitle: "Basit, şeffaf fiyatlandırma. Her zaman ücretsiz kullanabilirsin.", mostPopular: "EN POPÜLER", faqTitle: "Sık Sorulan Sorular", everythingInFree: "Free'deki her şey +", everythingInPlus: "Plus'takilerin hepsi +", perMonth: "/ay", forever: "sonsuza kadar" },
  en: { title: "Pricing", subtitle: "Simple, transparent pricing. Always free to start.", mostPopular: "MOST POPULAR", faqTitle: "Frequently Asked Questions", everythingInFree: "Everything in Free +", everythingInPlus: "Everything in Plus +", perMonth: "/month", forever: "forever" },
  de: { title: "Preise", subtitle: "Einfache, transparente Preise. Immer kostenlos starten.", mostPopular: "AM BELIEBTESTEN", faqTitle: "Häufig gestellte Fragen", everythingInFree: "Alles in Free +", everythingInPlus: "Alles in Plus +", perMonth: "/Monat", forever: "für immer" },
  fr: { title: "Tarifs", subtitle: "Tarification simple et transparente.", mostPopular: "LE PLUS POPULAIRE", faqTitle: "Questions fréquemment posées", everythingInFree: "Tout de Free +", everythingInPlus: "Tout de Plus +", perMonth: "/mois", forever: "pour toujours" },
  es: { title: "Precios", subtitle: "Precios simples y transparentes.", mostPopular: "MÁS POPULAR", faqTitle: "Preguntas frecuentes", everythingInFree: "Todo de Free +", everythingInPlus: "Todo de Plus +", perMonth: "/mes", forever: "para siempre" },
};

function getLabels(locale: string) {
  return LABELS[locale] || LABELS.en;
}

const FEATURES_FREE: Record<string, string[]> = {
  tr: ["2-10 soru oluşturma", "Günlük 10 eşleşme keşfi", "Mesajlaşma", "Temel filtreleme", "16 dil desteği"],
  en: ["Create 2-10 questions", "10 daily match discoveries", "Messaging", "Basic filters", "16 language support"],
  de: ["2-10 Fragen erstellen", "10 Matches pro Tag", "Messaging", "Grundfilter", "16 Sprachen"],
  fr: ["Créer 2-10 questions", "10 découvertes par jour", "Messagerie", "Filtres de base", "16 langues"],
  es: ["Crear 2-10 preguntas", "10 descubrimientos diarios", "Mensajería", "Filtros básicos", "16 idiomas"],
};

const FEATURES_PLUS: Record<string, string[]> = {
  tr: ["Sınırsız eşleşme keşfi", "Gelişmiş filtreler", "Boost (günde 1)", "Güçler (günde 3)", "Reklamsız deneyim"],
  en: ["Unlimited match discovery", "Advanced filters", "Boost (1/day)", "Powers (3/day)", "Ad-free experience"],
  de: ["Unbegrenzte Matches", "Erweiterte Filter", "Boost (1/Tag)", "Powers (3/Tag)", "Werbefreie Nutzung"],
  fr: ["Matchs illimités", "Filtres avancés", "Boost (1/jour)", "Pouvoirs (3/jour)", "Sans publicité"],
  es: ["Matches ilimitados", "Filtros avanzados", "Boost (1/día)", "Poderes (3/día)", "Sin anuncios"],
};

const FEATURES_PREMIUM: Record<string, string[]> = {
  tr: ["Sınırsız boost", "Sınırsız güç kullanımı", "Profilini görenleri gör", "AI soru önerileri", "Öncelikli destek", "Passport"],
  en: ["Unlimited boost", "Unlimited powers", "See who viewed your profile", "AI question suggestions", "Priority support", "Passport"],
  de: ["Unbegrenzte Boosts", "Unbegrenzte Powers", "Profil-Besucher sehen", "KI-Fragenvorschläge", "Premium-Support", "Passport"],
  fr: ["Boost illimité", "Pouvoirs illimités", "Voir qui a vu votre profil", "Suggestions IA", "Support prioritaire", "Passport"],
  es: ["Boost ilimitado", "Poderes ilimitados", "Ver quién vio tu perfil", "Sugerencias IA", "Soporte prioritario", "Passport"],
};

const FAQ_DATA_PRICING: Record<string, FAQItem[]> = {
  tr: [
    { q: "Qulo ücretsiz mi?", a: "Evet, Qulo Free tier her zaman ücretsizdir. Sorular oluşturabilir, eşleşebilir ve mesajlaşabilirsiniz." },
    { q: "İstediğim zaman iptal edebilir miyim?", a: "Evet, Plus veya Premium aboneliğinizi istediğiniz zaman iptal edebilirsiniz. Dönem sonuna kadar kullanmaya devam edersiniz." },
    { q: "Free ile Plus arasındaki fark nedir?", a: "Plus sınırsız eşleşme keşfi, gelişmiş filtreler, günlük boost ve güç kullanımı sunar. Free tier günlük sınırlamalarla çalışır." },
    { q: "Para iade garantisi var mı?", a: "App Store ve Google Play'in standart iade politikaları geçerlidir. İlk 14 gün içinde platform üzerinden iade talep edebilirsiniz." },
    { q: "Plus ile Premium arasındaki fark?", a: "Premium sınırsız boost ve güç, profil ziyaretçileri görme, AI soru önerileri ve Passport (farklı şehirlerde eşleşme) özelliklerini içerir." },
  ],
  en: [
    { q: "Is Qulo free?", a: "Yes, Qulo's Free tier is free forever. You can create questions, match, and message without paying." },
    { q: "Can I cancel anytime?", a: "Yes, you can cancel your Plus or Premium subscription anytime. You'll continue to have access until the end of your billing period." },
    { q: "What's the difference between Free and Plus?", a: "Plus offers unlimited match discovery, advanced filters, daily boosts and power uses. Free tier works with daily limits." },
    { q: "Is there a refund policy?", a: "Standard App Store and Google Play refund policies apply. You can request a refund within 14 days through the platform." },
    { q: "What's the difference between Plus and Premium?", a: "Premium includes unlimited boost and powers, seeing profile visitors, AI question suggestions, and Passport (matching in different cities)." },
  ],
};

export async function generateMetadata({ params }: { params: Promise<{ locale: string }> }): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.pricing?.[locale] || PAGE_SEO.pricing?.en || { title: "Pricing — Qulo", description: "Qulo pricing plans" };
  const pageUrl = `${SITE_URL}/${locale}/pricing`;
  const ogLocale = OG_LOCALES[locale] || "en_US";
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/pricing`;
  languages["x-default"] = `${SITE_URL}/tr/pricing`;

  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: seo.title, description: seo.description, url: pageUrl, siteName: SITE_NAME, type: "website", locale: ogLocale, images: ogImages() },
    twitter: { card: "summary_large_image", title: seo.title, description: seo.description, images: ogImages() },
  };
}

/**
 * JSON-LD for Product schema — built from static server constants only, no user input.
 * Enables Google rich snippets with price + star rating in search results.
 */
function ProductJsonLd() {
  const json = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "Product",
    name: "Qulo Dating App",
    description: "Question-based dating app with Free, Plus, and Premium tiers",
    image: `${SITE_URL}/images/og-image.png`,
    brand: { "@type": "Brand", name: "Qulo" },
    offers: [
      { "@type": "Offer", name: "Free", price: "0", priceCurrency: "USD", availability: "https://schema.org/InStock" },
      { "@type": "Offer", name: "Plus", price: "4.99", priceCurrency: "USD", availability: "https://schema.org/InStock" },
      { "@type": "Offer", name: "Premium", price: "9.99", priceCurrency: "USD", availability: "https://schema.org/InStock" },
    ],
  });
  return (
    <script
      type="application/ld+json"
      // eslint-disable-next-line react/no-danger
      dangerouslySetInnerHTML={{ __html: json }}
    />
  );
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
      <ProductJsonLd />

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
                <StoreButtons />
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
                <StoreButtons />
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
                <StoreButtons />
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
