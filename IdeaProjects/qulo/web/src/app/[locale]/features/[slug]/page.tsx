import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import { notFound } from "next/navigation";
import Link from "next/link";
import { Navbar } from "@/components/shared/Navbar";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { FAQ, faqTitle } from "@/components/shared/FAQ";
import { locales } from "@/lib/i18n/config";
import { LANDING_PAGES } from "@/lib/constants/landings";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { getFeatureFaqs } from "@/lib/constants/faqs";

/** Per-locale breadcrumb label for the Features section */
const FEATURES_LABELS: Record<string, string> = {
  tr: "Özellikler", en: "Features", de: "Funktionen", fr: "Fonctionnalités", es: "Características",
  ar: "ميزات", ru: "Функции", pt: "Recursos", it: "Caratteristiche", ja: "機能",
  ko: "기능", zh: "功能", nl: "Functies", pl: "Funkcje", sv: "Funktioner", hi: "विशेषताएं",
};

/* ---------- Static params: 16 locales x 3 slugs = 48 pages ---------- */
export function generateStaticParams() {
  const params: { locale: string; slug: string }[] = [];
  for (const locale of locales) {
    for (const lp of LANDING_PAGES) {
      params.push({ locale, slug: lp.slug });
    }
  }
  return params;
}

/* ---------- Metadata ---------- */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  const landing = LANDING_PAGES.find((lp) => lp.slug === slug);
  if (!landing) return {};

  const title = landing.titles[locale] || landing.titles.en;
  const description = landing.descriptions[locale] || landing.descriptions.en;
  const pageUrl = `${SITE_URL}/${locale}/features/${slug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/features/${slug}`;
  languages["x-default"] = `${SITE_URL}/tr/features/${slug}`;

  return {
    title,
    description,
    keywords: landing.keywords,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: ogLocale,
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
    },
  };
}

/* ---------- Content data per slug ---------- */
interface LandingContent {
  heroTitle: string;
  heroSub: string;
  problemTitle: string;
  problemParagraphs: string[];
  solutionTitle: string;
  solutionBullets: string[];
  steps: { title: string; desc: string }[];
}

function getContent(slug: string, locale: string): LandingContent | null {
  const isTr = locale === "tr";

  if (slug === "quiz-dating-app") {
    return {
      heroTitle: isTr
        ? "Quiz Dating App: Sorularla Esles"
        : "Quiz Dating App: Match Through Questions",
      heroSub: isTr
        ? "Swipe yerine sorularla tanis. Dunyanin ilk quiz tabanli dating uygulamasi Qulo ile anlamli baglantilar kur."
        : "Meet through questions instead of swiping. Build meaningful connections with Qulo, the world's first quiz-based dating app.",
      problemTitle: isTr
        ? "Neden Mevcut Dating Uygulamalari Yetersiz?"
        : "Why Are Current Dating Apps Not Enough?",
      problemParagraphs: isTr
        ? [
            "Geleneksel dating uygulamalari tamamen gorunuse dayali bir eslestirme sistemi kullanir. Bir profil fotografina bakip saga veya sola kaydirirsin \u2014 bu karar genellikle 1 saniyeden kisa surer. Bu yuzeysel yaklasim, gercek uyumluluk yerine anlik cekicilige odaklanir.",
            "Arastirmalar, swipe tabanli eslesmelerin %80'inden fazlasinin kalici bir baglantiya donusmedigini gosteriyor. Kullanicilar yuzlerce eslestirme yapiyor ama neredeyse hicbiri anlamli bir sohbete evrilmiyor. Bu durum 'swipe yorgunlugu' olarak bilinen bir tukenmislik yaratiyor.",
            "Bir quiz dating app olan Qulo, bu sorunu kokunden cozuyor. Fotografa bakmak yerine, karsindaki kisinin sorularini cozersin. Dogru cevaplarsan eslesirsin \u2014 bu da eslesmelerin cok daha anlamli ve kalici olmasini saglar.",
          ]
        : [
            "Traditional dating apps rely on a purely appearance-based matching system. You look at a profile photo and swipe right or left \u2014 a decision that typically takes less than a second. This superficial approach focuses on instant attraction rather than real compatibility.",
            "Research shows that over 80% of swipe-based matches never lead to a lasting connection. Users make hundreds of matches but almost none evolve into meaningful conversations. This creates a burnout known as 'swipe fatigue'.",
            "Qulo, a quiz dating app, solves this problem at its root. Instead of looking at photos, you solve the other person's questions. If you answer correctly, you match \u2014 making connections far more meaningful and lasting.",
          ],
      solutionTitle: isTr ? "Qulo: Quiz Tabanli Eslestirme" : "Qulo: Quiz-Based Matching",
      solutionBullets: isTr
        ? [
            "Soru-cevap tabanli eslestirme: 2-10 kisilik soru hazirla, sorularini dogru cevaplayan kisiyle esles.",
            "AI destekli soru onerileri: Yapay zeka, kisiligini en iyi yansitan quiz sorularini olusturmani saglar.",
            "Gamification sistemi: Elmaslar, rozetler, seviyeler ve 6 farkli quiz gucuyle dating deneyimini oyunlastir.",
            "Derinlikli tanisma: Quiz dating app sayesinde karsindaki kisinin dusunce yapisini, ilgi alanlarini ve degerlerini eslesmeden once kesfet.",
          ]
        : [
            "Question-based matching: Create 2-10 personality questions, match with the person who answers them all correctly.",
            "AI-powered question suggestions: Artificial intelligence helps you create quiz questions that best reflect your personality.",
            "Gamification system: Diamonds, badges, levels and 6 different quiz powers turn the dating experience into a game.",
            "Deep discovery: With the quiz dating app, explore the other person's mindset, interests, and values before matching.",
          ],
      steps: isTr
        ? [
            { title: "Soru Hazirla", desc: "Kisiligini yansitan 2-10 quiz sorusu olustur. AI ile ilgi cekici sorular hazirla." },
            { title: "Kesfet ve Coz", desc: "Diger kullanicilarin quiz sorularini kesfet ve cevapla. Stratejik gucler kullan." },
            { title: "Esles ve Tanis", desc: "Tum sorulari dogru cevapla ve esles. Sohbete basla, gercek baglantini kur." },
          ]
        : [
            { title: "Create Questions", desc: "Build 2-10 quiz questions that reflect your personality. Use AI for engaging questions." },
            { title: "Discover and Solve", desc: "Explore and answer other users' quiz questions. Use strategic powers." },
            { title: "Match and Meet", desc: "Answer all questions correctly and match. Start chatting, build your real connection." },
          ],
    };
  }

  if (slug === "dating-without-swiping") {
    return {
      heroTitle: isTr
        ? "Swipe Olmadan Dating: Alternatif Tanisma Yolu"
        : "Dating Without Swiping: The Alternative Way to Meet",
      heroSub: isTr
        ? "Yuzeysel kaydirmaya son ver. Qulo ile sorularla esles, swipe olmadan anlamli baglantilar kur."
        : "End superficial scrolling. Match through questions with Qulo, build meaningful connections without swiping.",
      problemTitle: isTr
        ? "Swipe Yorgunlugu: Modern Dating'in En Buyuk Sorunu"
        : "Swipe Fatigue: The Biggest Problem in Modern Dating",
      problemParagraphs: isTr
        ? [
            "Her gun milyonlarca insan dating uygulamalarinda saga ve sola kaydiriyor. Bu monoton dongu bir sure sonra tukenmislik hissine yol aciyor. Swipe yorgunlugu, kullanicilarin %70'inden fazlasinin deneyimledigi bir fenomen haline geldi.",
            "Swipe tabanli dating uygulamalari, insanlari birkac fotografa indirger. Biyografiler okunmaz, ortak ilgi alanlari goz ardi edilir. Sonuc? Yuzlerce eslestirme ama sifir anlamli baglanti. Dating without swiping artik bir tercih degil, bir ihtiyac.",
            "Qulo, swipe olmadan dating yapmanin mumkun oldugunu kanit\u0131yor. Fotograflara bakmak yerine sorular cozersin. Bu yaklasim, eslesmelerin kalitesini dramatik sekilde artirir ve swipe yorgunlugunu tamamen ortadan kaldirir.",
          ]
        : [
            "Every day, millions of people swipe right and left on dating apps. This monotonous cycle eventually leads to burnout. Swipe fatigue has become a phenomenon experienced by over 70% of users.",
            "Swipe-based dating apps reduce people to a few photos. Bios go unread, shared interests are ignored. The result? Hundreds of matches but zero meaningful connections. Dating without swiping is no longer a preference \u2014 it is a necessity.",
            "Qulo proves that dating without swiping is possible. Instead of looking at photos, you solve questions. This approach dramatically increases match quality and completely eliminates swipe fatigue.",
          ],
      solutionTitle: isTr
        ? "Qulo: Swipe'siz Dating Deneyimi"
        : "Qulo: The Swipe-Free Dating Experience",
      solutionBullets: isTr
        ? [
            "Sifir swipe mekanizmasi: Saga-sola kaydirma yok. Sorularla tanis, cevaplarla esles.",
            "Kisilik odakli kesfif: Profil fotografi yerine karsindaki kisinin dusunce yapisini kesfet.",
            "Kaliteli eslesmeler: Swipe olmadan dating ile eslestirme kalitesi 3 kat artar. Her eslestirme gercek uyumluluk uzerine kurulu.",
            "Anti-swipe felsefesi: Qulo, swipe yorgunluguna karsi tasarlandi. Hiz degil derinlik onemli.",
          ]
        : [
            "Zero swipe mechanism: No right-left swiping. Meet through questions, match through answers.",
            "Personality-focused discovery: Explore the other person's mindset instead of just their profile photo.",
            "Quality matches: With dating without swiping, match quality increases 3x. Every match is built on real compatibility.",
            "Anti-swipe philosophy: Qulo is designed against swipe fatigue. Depth matters, not speed.",
          ],
      steps: isTr
        ? [
            { title: "Soru Hazirla", desc: "Swipe yerine kisiligini yansitan sorular olustur. 2-10 soru yeterli." },
            { title: "Kesfet ve Coz", desc: "Kaydirma yok \u2014 sorulari oku, dusun ve cevapla. Derinlikli bir tanisma sureci." },
            { title: "Esles ve Tanis", desc: "Dogru cevaplarla esles. Swipe olmadan gercek bir baglanti kur." },
          ]
        : [
            { title: "Create Questions", desc: "Instead of swiping, create questions that reflect your personality. 2-10 questions are enough." },
            { title: "Discover and Solve", desc: "No scrolling \u2014 read questions, think and answer. A deep getting-to-know process." },
            { title: "Match and Meet", desc: "Match through correct answers. Build a real connection without swiping." },
          ],
    };
  }

  if (slug === "personality-matching-app") {
    return {
      heroTitle: isTr
        ? "Kisilik Eslestirme Uygulamasi: Uyumlu Esini Bul"
        : "Personality Matching App: Find Your Compatible Match",
      heroSub: isTr
        ? "Gorunus degil, dusunce yapisi onemli. Qulo, kisilik uyumluluguna dayali eslestirme yapan dating uygulamasidir."
        : "Looks don't matter, mindset does. Qulo is a dating app that matches based on personality compatibility.",
      problemTitle: isTr
        ? "Gorunuse Dayali Eslestirmenin Sorunu"
        : "The Problem With Appearance-Based Matching",
      problemParagraphs: isTr
        ? [
            "Cogu dating uygulamasi eslestirmeyi tamamen fiziksel cekicilige dayandirir. Guzel bir fotograf saga kaydirilir, geri kalan her sey goz ardi edilir. Bu yaklasim, kisilik uyumlulugunu tamamen devre disi birakir.",
            "Arastirmalar, uzun vadeli iliskilerde fiziksel cekiciligin degil, kisilik uyumlulugu belirleyici oldugunu gosteriyor. Benzer degerler, ortak ilgi alanlari ve uyumlu dusunce yapisi \u2014 bunlar kalici bir baglantinin temel taslaridir.",
            "Bir personality matching app olan Qulo, eslestirmeyi kisilik uyumlulugu uzerine kurar. Sorular araciligiyla karsindaki kisinin degerlerini, ilgi alanlarini ve dusunce yapisini kesfedersin. Dogru cevaplar, gercek uyumlulugun kanitidir.",
          ]
        : [
            "Most dating apps base matching entirely on physical attraction. A good photo gets a right swipe, everything else is ignored. This approach completely disables personality compatibility.",
            "Research shows that in long-term relationships, it is personality compatibility \u2014 not physical attraction \u2014 that matters most. Shared values, common interests, and compatible mindsets are the building blocks of lasting connections.",
            "Qulo, a personality matching app, builds matching on personality compatibility. Through questions, you discover the other person's values, interests, and mindset. Correct answers are proof of real compatibility.",
          ],
      solutionTitle: isTr
        ? "Qulo: Kisilik Uyumlulugu Tabanli Dating"
        : "Qulo: Personality Compatibility Dating",
      solutionBullets: isTr
        ? [
            "Kisilik testi formatinda sorular: Her soru, kisiligini yansitan bir pencere. Karsindaki kisiyi derinlemesine tani.",
            "Uyumluluk odakli eslestirme: Tum sorulari dogru cevaplayan kisiyle esles \u2014 bu, gercek kisilik uyumlulugunun kaniti.",
            "AI destekli kisilik analizi: Yapay zeka, kisiligini en iyi yansitan sorulari olusturmani saglar.",
            "Derinlikli profiller: Fotografin otesinde, dusunce yapisini ve degerlerini kesfet.",
          ]
        : [
            "Questions in personality test format: Each question is a window reflecting your personality. Get to know the other person deeply.",
            "Compatibility-focused matching: Match with the person who answers all your questions correctly \u2014 proof of real personality compatibility.",
            "AI-powered personality analysis: AI helps you create questions that best reflect your personality.",
            "Deep profiles: Beyond photos, discover mindsets and values.",
          ],
      steps: isTr
        ? [
            { title: "Kisilik Sorulari Olustur", desc: "Degerlerini ve ilgi alanlarini yansitan 2-10 soru hazirla." },
            { title: "Uyumluluk Testi Coz", desc: "Diger kullanicilarin kisilik sorularini coz ve uyumlulugunu kanitla." },
            { title: "Uyumlu Esinle Tanis", desc: "Kisilik uyumlulugu kanitlanmis eslestirmelerle gercek baglantilar kur." },
          ]
        : [
            { title: "Create Personality Questions", desc: "Build 2-10 questions that reflect your values and interests." },
            { title: "Take the Compatibility Test", desc: "Solve other users' personality questions and prove your compatibility." },
            { title: "Meet Your Compatible Match", desc: "Build real connections with matches proven through personality compatibility." },
          ],
    };
  }

  return null;
}

/* ---------- JSON-LD helper ---------- */
function JsonLd({ data }: { data: object }) {
  /* Static server-only constants (SITE_NAME, SITE_URL, landing titles/descriptions).
     No user input flows into this — safe for structured data injection. */
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

/* ---------- Page component ---------- */
export default async function FeatureLandingPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const landing = LANDING_PAGES.find((lp) => lp.slug === slug);
  if (!landing) notFound();

  const content = getContent(slug, locale);
  if (!content) notFound();

  const isTr = locale === "tr";
  const pageUrl = `${SITE_URL}/${locale}/features/${slug}`;
  const title = landing.titles[locale] || landing.titles.en;
  const description = landing.descriptions[locale] || landing.descriptions.en;

  const jsonLdData = [
    {
      "@context": "https://schema.org",
      "@type": "SoftwareApplication",
      name: SITE_NAME,
      applicationCategory: "SocialNetworkingApplication",
      operatingSystem: "iOS, Android",
      url: SITE_URL,
      description,
      offers: { "@type": "Offer", price: "0", priceCurrency: "USD" },
    },
    {
      "@context": "https://schema.org",
      "@type": "WebPage",
      name: title,
      description,
      url: pageUrl,
      isPartOf: { "@type": "WebSite", name: SITE_NAME, url: SITE_URL },
      about: {
        "@type": "SoftwareApplication",
        name: SITE_NAME,
        applicationCategory: "SocialNetworkingApplication",
      },
    },
  ];

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <JsonLd data={jsonLdData} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">

          <Breadcrumb
            locale={locale}
            items={[
              { label: FEATURES_LABELS[locale] || FEATURES_LABELS.en, href: `/${locale}/features` },
              { label: title },
            ]}
          />

          {/* Hero Section */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {landing.primaryKeyword}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-6 leading-tight">
              {content.heroTitle}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-xl mx-auto mb-8">
              {content.heroSub}
            </p>
            <div className="flex justify-center">
              <StoreButtons />
            </div>
          </header>

          {/* Problem Section */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-purple mb-6">
              {content.problemTitle}
            </h2>
            <article className="space-y-4 text-qulo-text-secondary leading-relaxed text-sm">
              {content.problemParagraphs.map((p, i) => (
                <p key={i}>{p}</p>
              ))}
            </article>
          </section>

          {/* Solution Section */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-green mb-6">
              {content.solutionTitle}
            </h2>
            <ul className="space-y-4">
              {content.solutionBullets.map((bullet, i) => {
                const [title, ...rest] = bullet.split(": ");
                const desc = rest.join(": ");
                return (
                  <li
                    key={i}
                    className="flex items-start gap-4 rounded-xl border border-white/[0.08] bg-white/[0.03] p-5"
                  >
                    <span className="flex-shrink-0 w-8 h-8 rounded-full bg-qulo-green/20 text-qulo-green font-bold text-sm flex items-center justify-center">
                      {i + 1}
                    </span>
                    <div>
                      <p className="text-white font-semibold text-sm">{title}</p>
                      {desc && (
                        <p className="text-qulo-text-secondary text-sm mt-1">{desc}</p>
                      )}
                    </div>
                  </li>
                );
              })}
            </ul>
          </section>

          {/* How It Works Section */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-purple mb-6">
              {isTr ? "Nasil Calisir?" : "How It Works"}
            </h2>
            <ol className="space-y-4">
              {content.steps.map((step, i) => (
                <li
                  key={i}
                  className="flex items-start gap-4 rounded-xl border border-white/[0.08] bg-white/[0.03] p-5"
                >
                  <span className="flex-shrink-0 w-8 h-8 rounded-full bg-qulo-purple/20 text-qulo-purple font-bold text-sm flex items-center justify-center">
                    {i + 1}
                  </span>
                  <div>
                    <p className="text-white font-semibold text-sm">{step.title}</p>
                    <p className="text-qulo-text-secondary text-sm mt-1">{step.desc}</p>
                  </div>
                </li>
              ))}
            </ol>
          </section>

          {/* FAQ Section — page-specific, with FAQPage JSON-LD for rich snippets */}
          {(() => {
            const faqs = getFeatureFaqs(slug, locale);
            return faqs.length > 0 ? (
              <FAQ items={faqs} title={faqTitle(locale)} />
            ) : null;
          })()}

          {/* CTA Section */}
          <section className="text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10 mb-14 mt-16">
            <h2 className="text-2xl font-bold text-white mb-3">
              {isTr ? "Hemen Ucretsiz Indir" : "Download Free Now"}
            </h2>
            <p className="text-qulo-text-secondary text-sm mb-6">
              {isTr
                ? "Qulo'yu indir, sorularla esles ve anlamli baglantilar kur."
                : "Download Qulo, match through questions and build meaningful connections."}
            </p>
            <div className="flex justify-center">
              <StoreButtons />
            </div>
          </section>

          {/* Internal Links */}
          <nav className="flex flex-wrap justify-center gap-4 text-sm">
            <Link
              href={`/${locale}/about`}
              className="text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              {isTr ? "Hakkinda" : "About"}
            </Link>
            <Link
              href={`/${locale}/blog`}
              className="text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              Blog
            </Link>
            <Link
              href={`/${locale}/dating`}
              className="text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              {isTr ? "Sehirlerde Dating" : "Dating in Cities"}
            </Link>
            <Link
              href={`/${locale}/features`}
              className="text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              {isTr ? "Tum Ozellikler" : "All Features"}
            </Link>
          </nav>

        </div>
      </div>
    </main>
  );
}
