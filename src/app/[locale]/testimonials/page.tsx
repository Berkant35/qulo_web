import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { TESTIMONIALS } from "@/lib/constants/testimonials";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

const LABELS: Record<string, { title: string; subtitle: string; ratingText: string; ctaTitle: string; ctaDesc: string }> = {
  tr: { title: "Kullanıcılar Ne Diyor?", subtitle: "Gerçek kullanıcı deneyimleri", ratingText: "1247 kullanıcı değerlendirmesi", ctaTitle: "Kendi Deneyimini Yaşa", ctaDesc: "Qulo'yu ücretsiz indir ve sorularla eşleş." },
  en: { title: "What Users Say", subtitle: "Real user experiences", ratingText: "1247 user reviews", ctaTitle: "Experience It Yourself", ctaDesc: "Download Qulo free and start matching through questions." },
  de: { title: "Was Nutzer sagen", subtitle: "Echte Nutzererfahrungen", ratingText: "1247 Nutzerbewertungen", ctaTitle: "Selbst erleben", ctaDesc: "Qulo kostenlos herunterladen." },
  fr: { title: "Ce que disent les utilisateurs", subtitle: "Expériences utilisateurs réelles", ratingText: "1247 avis utilisateurs", ctaTitle: "Faites votre propre expérience", ctaDesc: "Téléchargez Qulo gratuitement." },
  es: { title: "Qué dicen los usuarios", subtitle: "Experiencias reales de usuarios", ratingText: "1247 opiniones de usuarios", ctaTitle: "Vive tu propia experiencia", ctaDesc: "Descarga Qulo gratis." },
};

function getLabels(locale: string) {
  return LABELS[locale] || LABELS.en;
}

function formatDate(iso: string, locale: string): string {
  const d = new Date(iso);
  const localeMap: Record<string, string> = {
    tr: "tr-TR", en: "en-US", de: "de-DE", fr: "fr-FR", es: "es-ES",
  };
  try {
    return d.toLocaleDateString(localeMap[locale] || "en-US", { year: "numeric", month: "long", day: "numeric" });
  } catch {
    return iso;
  }
}

export async function generateMetadata({ params }: { params: Promise<{ locale: string }> }): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.testimonials?.[locale] || PAGE_SEO.testimonials?.en || { title: "Reviews — Qulo", description: "Real user reviews" };
  const pageUrl = `${SITE_URL}/${locale}/testimonials`;
  const ogLocale = OG_LOCALES[locale] || "en_US";
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/testimonials`;
  languages["x-default"] = `${SITE_URL}/tr/testimonials`;

  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: seo.title, description: seo.description, url: pageUrl, siteName: SITE_NAME, type: "website", locale: ogLocale },
    twitter: { card: "summary_large_image", title: seo.title, description: seo.description },
  };
}

function Stars({ rating }: { rating: number }) {
  return (
    <div className="flex gap-0.5" aria-label={`${rating} out of 5 stars`}>
      {[1, 2, 3, 4, 5].map((n) => (
        <span key={n} className={n <= rating ? "text-qulo-green" : "text-white/20"} aria-hidden="true">
          ★
        </span>
      ))}
    </div>
  );
}

export default async function TestimonialsPage({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  const L = getLabels(locale);

  // ItemList + Review JSON-LD from static server constants — trusted data, same pattern as other pages.
  const reviewsJson = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "ItemList",
    name: "Qulo User Reviews",
    itemListElement: TESTIMONIALS.map((t, i) => ({
      "@type": "ListItem",
      position: i + 1,
      item: {
        "@type": "Review",
        itemReviewed: { "@type": "SoftwareApplication", name: "Qulo" },
        reviewRating: { "@type": "Rating", ratingValue: t.rating, bestRating: 5 },
        author: { "@type": "Person", name: t.name },
        reviewBody: t.quotes[locale] || t.quotes.en,
        datePublished: t.datePublished,
      },
    })),
  });

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <script
        type="application/ld+json"
        // eslint-disable-next-line react/no-danger
        dangerouslySetInnerHTML={{ __html: reviewsJson }}
      />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-6xl mx-auto">
          <Breadcrumb locale={locale} items={[{ label: L.title }]} />

          <header className="text-center mb-12">
            <h1 className="text-4xl sm:text-5xl font-bold mb-3">{L.title}</h1>
            <p className="text-qulo-text-secondary text-lg mb-4">{L.subtitle}</p>
            <div className="flex items-center justify-center gap-3">
              <div className="text-5xl font-black text-qulo-green">4.8</div>
              <div className="text-left">
                <Stars rating={5} />
                <p className="text-xs text-qulo-text-secondary mt-1">{L.ratingText}</p>
              </div>
            </div>
          </header>

          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6 mb-16">
            {TESTIMONIALS.map((t) => (
              <article
                key={t.id}
                className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6"
                aria-label={`Review by ${t.name}`}
              >
                <div className="flex items-center gap-3 mb-4">
                  <div
                    className="w-10 h-10 rounded-full flex items-center justify-center text-sm font-bold text-white shrink-0"
                    style={{ background: "linear-gradient(135deg, #BB86FC, #69F0AE)" }}
                    aria-hidden="true"
                  >
                    {t.initials}
                  </div>
                  <div className="min-w-0">
                    <p className="text-sm font-semibold text-white truncate">{t.name}</p>
                    <p className="text-xs text-qulo-text-secondary truncate">
                      {t.city} • {t.age}
                    </p>
                  </div>
                </div>
                <div className="mb-3">
                  <Stars rating={t.rating} />
                </div>
                <blockquote className="text-sm text-qulo-text-secondary leading-relaxed italic mb-4">
                  &ldquo;{t.quotes[locale] || t.quotes.en}&rdquo;
                </blockquote>
                <time dateTime={t.datePublished} className="text-[10px] text-qulo-text-secondary/60">
                  {formatDate(t.datePublished, locale)}
                </time>
              </article>
            ))}
          </div>

          <section className="text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10">
            <h2 className="text-2xl font-bold text-white mb-3">{L.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-6">{L.ctaDesc}</p>
            <div className="flex justify-center">
              <StoreButtons />
            </div>
          </section>
        </div>
      </div>

      <Footer />
    </main>
  );
}
