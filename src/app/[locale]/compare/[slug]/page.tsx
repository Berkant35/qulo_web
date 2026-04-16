import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { notFound } from "next/navigation";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { locales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { COMPARISONS } from "@/lib/constants/comparisons";

/* ------------------------------------------------------------------ */
/*  Static params — 16 locales x 3 comparisons = 48 pages             */
/* ------------------------------------------------------------------ */
export function generateStaticParams() {
  const params: { locale: string; slug: string }[] = [];
  for (const locale of locales) {
    for (const c of COMPARISONS) {
      params.push({ locale, slug: c.slug });
    }
  }
  return params;
}

/* ------------------------------------------------------------------ */
/*  Metadata                                                           */
/* ------------------------------------------------------------------ */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  const comparison = COMPARISONS.find((c) => c.slug === slug);
  if (!comparison) return {};

  const title = comparison.titles[locale] || comparison.titles.en;
  const description =
    comparison.descriptions[locale] || comparison.descriptions.en;
  const pageUrl = `${SITE_URL}/${locale}/compare/${slug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/compare/${slug}`;
  languages["x-default"] = `${SITE_URL}/tr/compare/${slug}`;

  return {
    title,
    description,
    keywords: comparison.keywords,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: ogLocale,
    },
  };
}

/* ------------------------------------------------------------------ */
/*  Analysis content per comparison (TR + EN)                          */
/* ------------------------------------------------------------------ */
const ANALYSIS: Record<
  string,
  Record<string, { paragraphs: string[]; conclusion: string[] }>
> = {
  "qulo-vs-tinder": {
    tr: {
      paragraphs: [
        "Tinder, swipe mekanizmasiyla dunya genelinde en cok bilinen dating uygulamasi olma unvanini tasiyor. Ancak bu yuzeysel yaklasim ciddi bir sorun dogurur: ortalama profil inceleme suresi yalnizca 0.5 saniyedir. Kullanicilar cogu zaman fotograf odakli kararlar verir ve bu da anlamli baglantilarin onunu tikayan bir dongu yaratir.",
        "Qulo ise tamamen farkli bir felsefe benimser. Soru-cevap sistemiyle eslesme, her iki tarafin da birbirini tanimak icin gercek bir efor gostermesini gerektirir. 2-10 soru hazirlayarak kisiligini yansitirsin ve ancak tum sorulari dogru cevaplayan kisiyle eslesirsin. Bu sistem, ghosting oranini onemli olcude dusurur.",
        "Tinder'da ghosting orani %80'i asarken, Qulo'da efor gerektiren eslesme sayesinde bu oran cok daha dusuktur. Cunku her iki taraf da eslesmeye ulasmak icin zaman ve dusunce yatiriminda bulunmustur.",
        "Fiyatlandirma acisindan Qulo daha erisilebilir bir model sunar. Temel ozellikler ucretsiz kullanilabilirken, Tinder'da bircok temel ozellik bile premium duvarinin arkasindadir. AI destekli soru olusturma gibi yenilikci ozellikler de Qulo'yu one cikarir.",
      ],
      conclusion: [
        "Tinder, devasa kullanici tabani ve global bilinirligiyle guclu bir platformdur. Hizli ve rahat tanismak isteyenler icin etkili olabilir.",
        "Ancak daha derin, anlamli baglanti ariyorsaniz ve swipe yorgunlugundan biktiyseniz, Qulo'nun soru tabanli yaklasimi size cok daha uygun olacaktir. Kisiligini sorularla ifade et, gercek uyumlulugu kesfet.",
      ],
    },
    en: {
      paragraphs: [
        "Tinder holds the title of being the most widely recognized dating app globally, thanks to its swipe mechanic. However, this superficial approach creates a significant problem: the average profile review time is only 0.5 seconds. Users often make photo-driven decisions, creating a cycle that blocks meaningful connections.",
        "Qulo embraces an entirely different philosophy. Matching through the Q&A system requires both parties to put in genuine effort to get to know each other. You create 2-10 questions reflecting your personality, and you only match with the person who answers all questions correctly. This system significantly reduces the ghosting rate.",
        "While the ghosting rate on Tinder exceeds 80%, it is much lower on Qulo thanks to effort-based matching. Both parties have invested time and thought into reaching the match.",
        "In terms of pricing, Qulo offers a more accessible model. Core features are available for free, while on Tinder many basic features sit behind a premium wall. Innovative features like AI-powered question creation also set Qulo apart.",
      ],
      conclusion: [
        "Tinder is a powerful platform with its massive user base and global recognition. It can be effective for those who want quick, casual connections.",
        "However, if you are looking for deeper, more meaningful connections and are tired of swipe fatigue, Qulo's question-based approach will suit you much better. Express your personality through questions and discover real compatibility.",
      ],
    },
  },
  "qulo-vs-bumble": {
    tr: {
      paragraphs: [
        "Bumble, kadin-oncelikli yaklasimiyla dating dunyasinda onemli bir fark yaratmistir. Kadinlarin ilk mesaji gondermesi gerektigi kurali, istemedik mesajlari azaltir ve daha guvenli bir ortam olusturur. Ancak temelinde hala swipe tabanli bir mekanizma kullanir.",
        "Qulo'da cinsiyet fark etmeksizin herkes esit sansa sahiptir — onemli olan cevaplardir. Sorulari cozme sureci, her iki tarafi da birbirini tanimaya yonlendirir. Bu, Bumble'in cinsiyet odakli kuralinin otesinde, icerigi esas alan bir eslesme sistemidir.",
        "Bumble, dating disinda BFF (arkadaslik) ve Bizz (is aglari) gibi 3 farkli mod sunarak genis bir kullanici kitlesine hitap eder. Qulo ise dating'e odaklanarak bu alanda cok daha derin bir deneyim saglar. Elmas ekonomisi, rozetler, seviyeler ve 6 farkli guc gibi gamification elementleri, eslesme surecini heyecanli tutar.",
        "Fiyatlandirma konusunda Bumble'in premium planlari oldukca pahali olabilir. Qulo ise daha uygun fiyatli planlar sunarak kaliteli ozelliklere erisimi demokratiklestirir.",
      ],
      conclusion: [
        "Bumble, kadinlarin kendini guvende hissettigi ve 3 farkli mod sunan kapsamli bir platformdur. Ozellikle arkadaslik ve is agi arayanlari da kapsayan genis bir vizyona sahiptir.",
        "Eger dating'e odaklanmak, derin baglanti kurmak ve oyunlastirilmis bir deneyim istiyorsaniz, Qulo tam size gore. Swipe yerine sorularin gucuyle tanisin.",
      ],
    },
    en: {
      paragraphs: [
        "Bumble has created a significant difference in the dating world with its women-first approach. The rule requiring women to send the first message reduces unwanted messages and creates a safer environment. However, at its core, it still uses a swipe-based mechanism.",
        "On Qulo, everyone has equal chances regardless of gender — what matters is your answers. The process of solving questions guides both parties to genuinely get to know each other. This is a matching system that goes beyond Bumble's gender-focused rule, centering on actual content.",
        "Bumble appeals to a wide audience by offering 3 different modes beyond dating: BFF (friendship) and Bizz (professional networking). Qulo focuses on dating to provide a much deeper experience in this area. Gamification elements like the diamond economy, badges, levels, and 6 different powers keep the matching process exciting.",
        "When it comes to pricing, Bumble's premium plans can be quite expensive. Qulo offers more affordable plans, democratizing access to quality features.",
      ],
      conclusion: [
        "Bumble is a comprehensive platform where women feel safe and which offers 3 different modes. It has a broad vision that covers those seeking friendship and professional networking as well.",
        "If you want to focus on dating, build deep connections, and enjoy a gamified experience, Qulo is perfect for you. Meet through the power of questions instead of swipes.",
      ],
    },
  },
  "qulo-vs-hinge": {
    tr: {
      paragraphs: [
        "Hinge, \"designed to be deleted\" sloganiyla ciddi iliskilere odaklanan ve prompt tabanli profiller sunan bir dating uygulamasidir. Kullanicilar profil prompt'larina verdikleri cevaplarla kisiliklerini yansitir ve bu prompt'lara \"like\" gondererek ilgi gosterir.",
        "Qulo da ciddi baglantilara odaklanir ama bir adim daha ileri gider. Sadece profil yazmak yerine, aktif soru cozme ile gercek uyumlulugu olcer. Hinge'de bir prompt'a like gonderirsiniz; Qulo'da ise 2-10 soruyu cozerek gercek uyumunuzu kanitlarsiniz. Bu, pasif bir begeni yerine aktif bir katilim gerektirir.",
        "Gamification acisindan Hinge minimal bir yaklasim benimserken, Qulo gelismis bir sistem sunar: elmas ekonomisi, 6 farkli guc (Oracle, Yarila, Gec, Sure Uzat, Ipucu, Hepsini Gec), rozetler ve seviyeler. Bu elementler eslesme surecini bir oyuna donusturerek motivasyonu arttirir.",
        "Ucretsiz kullanim konusunda Hinge oldukca kisitlayicidir — gunluk like siniri ve ozellik kisitlamalari vardir. Qulo ise daha comert bir ucretsiz katman sunarak daha fazla kullanicinin kaliteli deneyim yasamasini saglar.",
      ],
      conclusion: [
        "Hinge, ciddi iliski arayanlari icin guclu bir secenektir. Prompt tabanli profiller, kullanicilarin kisiliklerini daha iyi ifade etmesini saglar ve uygulamanin genel kalitesi yuksektir.",
        "Ancak profil prompt'larindan daha fazlasini istiyorsaniz — gercek uyumlulugu aktif olarak test etmek, gamification ile motivasyonu artirmak ve daha comert bir ucretsiz deneyim yasamak istiyorsaniz — Qulo ideal tercihiniz olacaktir.",
      ],
    },
    en: {
      paragraphs: [
        "Hinge is a dating app that focuses on serious relationships with its \"designed to be deleted\" slogan and offers prompt-based profiles. Users reflect their personality through answers to profile prompts and show interest by sending \"likes\" on these prompts.",
        "Qulo also focuses on serious connections but goes one step further. Instead of just writing a profile, it measures real compatibility through active question solving. On Hinge, you send a like on a prompt; on Qulo, you prove your real compatibility by solving 2-10 questions. This requires active participation rather than a passive like.",
        "In terms of gamification, Hinge takes a minimal approach, while Qulo offers an advanced system: diamond economy, 6 different powers (Oracle, Half, Skip, Time Extend, Hint, Skip All), badges, and levels. These elements turn the matching process into a game, boosting motivation.",
        "Regarding free usage, Hinge is quite restrictive — there are daily like limits and feature restrictions. Qulo offers a more generous free tier, allowing more users to enjoy a quality experience.",
      ],
      conclusion: [
        "Hinge is a strong choice for those seeking serious relationships. Prompt-based profiles allow users to better express their personalities, and the overall quality of the app is high.",
        "However, if you want more than profile prompts — to actively test real compatibility, boost motivation with gamification, and enjoy a more generous free experience — Qulo will be your ideal choice.",
      ],
    },
  },
};

/* ------------------------------------------------------------------ */
/*  JSON-LD helper — renders static, trusted i18n data only            */
/* ------------------------------------------------------------------ */
function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      /* Safe: data is built from static constants, no user input */
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

/* ------------------------------------------------------------------ */
/*  Feature value display helpers                                      */
/* ------------------------------------------------------------------ */
const VALUE_LABELS: Record<string, Record<string, string>> = {
  tr: {
    quiz: "Quiz Tabanli",
    swipe: "Swipe",
    deep: "Derin",
    surface: "Yuzeysel",
    moderate: "Orta",
    "moderate-deep": "Orta-Derin",
    low: "Dusuk",
    high: "Yuksek",
    yes: "Evet",
    limited: "Sinirli",
    basic: "Temel",
    growing: "Buyuyor",
    massive: "Cok Buyuk",
    both: "Her Iki Taraf",
    women: "Sadece Kadinlar",
    advanced: "Gelismis",
    affordable: "Uygun Fiyatli",
    expensive: "Pahali",
    dating: "Dating",
    "dating+bff+bizz": "Dating + BFF + Bizz",
    "prompts+likes": "Prompt + Like",
    serious: "Ciddi",
    natural: "Dogal",
    prompted: "Prompt Tabanli",
    generous: "Comert",
    minimal: "Minimal",
  },
  en: {
    quiz: "Quiz-Based",
    swipe: "Swipe",
    deep: "Deep",
    surface: "Surface",
    moderate: "Moderate",
    "moderate-deep": "Moderate-Deep",
    low: "Low",
    high: "High",
    yes: "Yes",
    limited: "Limited",
    basic: "Basic",
    growing: "Growing",
    massive: "Massive",
    both: "Both Sides",
    women: "Women Only",
    advanced: "Advanced",
    affordable: "Affordable",
    expensive: "Expensive",
    dating: "Dating",
    "dating+bff+bizz": "Dating + BFF + Bizz",
    "prompts+likes": "Prompts + Likes",
    serious: "Serious",
    natural: "Natural",
    prompted: "Prompt-Based",
    generous: "Generous",
    minimal: "Minimal",
  },
};

function getValueLabel(value: string, locale: string): string {
  const labels = VALUE_LABELS[locale] || VALUE_LABELS.en;
  return labels[value] || value;
}

/* ------------------------------------------------------------------ */
/*  i18n labels                                                        */
/* ------------------------------------------------------------------ */
const SECTION_LABELS: Record<string, Record<string, string>> = {
  feature: {
    tr: "Ozellik",
    en: "Feature",
    de: "Funktion",
    fr: "Fonctionnalite",
    es: "Caracteristica",
  },
  detailedAnalysis: {
    tr: "Detayli Analiz",
    en: "Detailed Analysis",
    de: "Detaillierte Analyse",
    fr: "Analyse detaillee",
    es: "Analisis detallado",
  },
  conclusion: {
    tr: "Sonuc: Hangisi Size Uygun?",
    en: "Conclusion: Which One is Right for You?",
    de: "Fazit: Welche ist die Richtige fur Sie?",
    fr: "Conclusion : Lequel vous convient ?",
    es: "Conclusion: Cual es adecuada para ti?",
  },
  comparison2026: {
    tr: "Detayli 2026 karsilastirmasi",
    en: "Detailed 2026 comparison",
    de: "Detaillierter 2026 Vergleich",
    fr: "Comparaison detaillee 2026",
    es: "Comparacion detallada 2026",
  },
  otherComparisons: {
    tr: "Diger Karsilastirmalar",
    en: "Other Comparisons",
    de: "Andere Vergleiche",
    fr: "Autres comparaisons",
    es: "Otras comparaciones",
  },
  downloadCta: {
    tr: "Qulo'yu simdi indir ve sorularla tanism.",
    en: "Download Qulo now and meet through questions.",
    de: "Lade Qulo jetzt herunter und triff dich durch Fragen.",
    fr: "Telechargez Qulo maintenant et rencontrez par les questions.",
    es: "Descarga Qulo ahora y conoce a traves de preguntas.",
  },
};

function label(key: string, locale: string): string {
  const map = SECTION_LABELS[key];
  if (!map) return key;
  return map[locale] || map.en || key;
}

/* ------------------------------------------------------------------ */
/*  Page Component                                                     */
/* ------------------------------------------------------------------ */
export default async function ComparisonPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const comparison = COMPARISONS.find((c) => c.slug === slug);
  if (!comparison) notFound();

  const title = comparison.titles[locale] || comparison.titles.en;
  const analysisLocale = ANALYSIS[slug]?.[locale] ? locale : "en";
  const analysis = ANALYSIS[slug]?.[analysisLocale];
  const otherComparisons = COMPARISONS.filter((c) => c.slug !== slug);

  /* JSON-LD: WebPage + SoftwareApplication — static constants only */
  const jsonLd = [
    {
      "@context": "https://schema.org",
      "@type": "WebPage",
      name: title,
      description:
        comparison.descriptions[locale] || comparison.descriptions.en,
      url: `${SITE_URL}/${locale}/compare/${slug}`,
      inLanguage: locale,
    },
    {
      "@context": "https://schema.org",
      "@type": "SoftwareApplication",
      name: SITE_NAME,
      applicationCategory: "SocialNetworkingApplication",
      operatingSystem: "iOS, Android",
      url: SITE_URL,
      offers: { "@type": "Offer", price: "0", priceCurrency: "USD" },
    },
  ];

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <JsonLd data={jsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-4xl mx-auto">
          {/* -------- Hero -------- */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {label("comparison2026", locale)}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-4 leading-tight">
              <span className="text-qulo-green">Qulo</span>{" "}
              <span className="text-qulo-text-secondary">vs</span>{" "}
              <span className="text-white">
                {comparison.competitorLogo} {comparison.competitor}
              </span>
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-xl mx-auto">
              {comparison.descriptions[locale] ||
                comparison.descriptions.en}
            </p>
          </header>

          {/* -------- Comparison Table -------- */}
          <section className="mb-16">
            <div className="rounded-2xl border border-white/[0.08] overflow-hidden">
              {/* Table Header */}
              <div className="grid grid-cols-3 bg-white/[0.05] border-b border-white/[0.08]">
                <div className="p-4 text-xs font-semibold uppercase tracking-wider text-qulo-text-secondary">
                  {label("feature", locale)}
                </div>
                <div className="p-4 text-center">
                  <span className="text-sm font-bold text-qulo-green">
                    Qulo
                  </span>
                </div>
                <div className="p-4 text-center">
                  <span className="text-sm font-bold text-white">
                    {comparison.competitorLogo} {comparison.competitor}
                  </span>
                </div>
              </div>

              {/* Table Rows */}
              {comparison.features.map((f, i) => (
                <div
                  key={f.key}
                  className={`grid grid-cols-3 border-b border-white/[0.05] ${
                    i % 2 === 0 ? "bg-white/[0.02]" : ""
                  }`}
                >
                  <div className="p-4 text-sm text-white font-medium">
                    {f.labels[locale] || f.labels.en}
                  </div>
                  <div
                    className={`p-4 text-center text-sm font-medium ${
                      f.quloWins
                        ? "text-qulo-green"
                        : "text-qulo-text-secondary"
                    }`}
                  >
                    <span className="flex items-center justify-center gap-1.5">
                      {f.quloWins && (
                        <span className="text-qulo-green text-base" aria-label="advantage">
                          &#10003;
                        </span>
                      )}
                      {getValueLabel(f.qulo, locale)}
                    </span>
                  </div>
                  <div
                    className={`p-4 text-center text-sm font-medium ${
                      !f.quloWins
                        ? "text-qulo-purple"
                        : "text-qulo-text-secondary"
                    }`}
                  >
                    <span className="flex items-center justify-center gap-1.5">
                      {!f.quloWins && (
                        <span className="text-qulo-purple text-base" aria-label="advantage">
                          &#10003;
                        </span>
                      )}
                      {getValueLabel(f.competitor, locale)}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </section>

          {/* -------- Detailed Analysis -------- */}
          {analysis && (
            <section className="mb-16">
              <h2 className="text-2xl font-bold text-qulo-purple mb-6">
                {label("detailedAnalysis", locale)}
              </h2>
              <div className="space-y-4">
                {analysis.paragraphs.map((p, i) => (
                  <p
                    key={i}
                    className="text-qulo-text-secondary leading-relaxed text-sm"
                  >
                    {p}
                  </p>
                ))}
              </div>
            </section>
          )}

          {/* -------- Conclusion -------- */}
          {analysis && (
            <section className="mb-16">
              <h2 className="text-2xl font-bold text-qulo-green mb-6">
                {label("conclusion", locale)}
              </h2>
              <div className="space-y-4">
                {analysis.conclusion.map((p, i) => (
                  <p
                    key={i}
                    className="text-qulo-text-secondary leading-relaxed text-sm"
                  >
                    {p}
                  </p>
                ))}
              </div>
            </section>
          )}

          {/* -------- CTA -------- */}
          <section className="text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10 mb-16">
            <h2 className="text-2xl font-bold text-white mb-3">
              {label("downloadCta", locale)}
            </h2>
            <div className="flex justify-center mt-6">
              <StoreButtons />
            </div>
          </section>

          {/* -------- Other Comparisons -------- */}
          <section className="mb-8">
            <h2 className="text-xl font-bold text-qulo-purple mb-6">
              {label("otherComparisons", locale)}
            </h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {otherComparisons.map((c) => (
                <Link
                  key={c.slug}
                  href={`/${locale}/compare/${c.slug}`}
                  className="rounded-xl border border-white/[0.08] bg-white/[0.03] p-5 hover:bg-white/[0.06] transition-colors group"
                >
                  <span className="text-2xl mr-2">{c.competitorLogo}</span>
                  <span className="text-white font-semibold text-sm group-hover:text-qulo-green transition-colors">
                    Qulo vs {c.competitor}
                  </span>
                  <p className="text-qulo-text-secondary text-xs mt-2 line-clamp-2">
                    {c.descriptions[locale] || c.descriptions.en}
                  </p>
                </Link>
              ))}
            </div>
          </section>

          {/* -------- Internal Links -------- */}
          <nav className="flex flex-wrap gap-3 text-xs text-qulo-text-secondary">
            <Link
              href={`/${locale}/about`}
              className="hover:text-white transition-colors underline underline-offset-4"
            >
              About Qulo
            </Link>
            <Link
              href={`/${locale}/blog`}
              className="hover:text-white transition-colors underline underline-offset-4"
            >
              Blog
            </Link>
            <Link
              href={`/${locale}/features`}
              className="hover:text-white transition-colors underline underline-offset-4"
            >
              Features
            </Link>
            <Link
              href={`/${locale}/compare`}
              className="hover:text-white transition-colors underline underline-offset-4"
            >
              {label("otherComparisons", locale)}
            </Link>
          </nav>
        </div>
      </div>

      <Footer />
    </main>
  );
}
