import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { notFound } from "next/navigation";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { locales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { BLOG_POSTS } from "@/lib/constants/blog";

/* ------------------------------------------------------------------ */
/*  Static params                                                      */
/* ------------------------------------------------------------------ */
export function generateStaticParams() {
  const params: { locale: string; slug: string }[] = [];
  for (const locale of locales) {
    for (const post of BLOG_POSTS) {
      params.push({ locale, slug: post.slug });
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
  const post = BLOG_POSTS.find((p) => p.slug === slug);
  if (!post) return {};

  const title = post.titles[locale] || post.titles.en;
  const description = post.excerpts[locale] || post.excerpts.en;
  const pageUrl = `${SITE_URL}/${locale}/blog/${slug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/blog/${slug}`;
  languages["x-default"] = `${SITE_URL}/tr/blog/${slug}`;

  return {
    title: `${title} — Qulo Blog`,
    description,
    keywords: post.keywords,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: ogLocale,
      publishedTime: post.publishedAt,
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
    },
  };
}

/* ------------------------------------------------------------------ */
/*  Helpers                                                            */
/* ------------------------------------------------------------------ */
function formatDate(iso: string, locale: string): string {
  const d = new Date(iso);
  const localeMap: Record<string, string> = {
    tr: "tr-TR", en: "en-US", de: "de-DE", fr: "fr-FR", es: "es-ES",
    ar: "ar-SA", ja: "ja-JP", ko: "ko-KR", zh: "zh-CN", ru: "ru-RU",
    pt: "pt-BR", it: "it-IT", nl: "nl-NL", pl: "pl-PL", sv: "sv-SE", hi: "hi-IN",
  };
  try {
    return d.toLocaleDateString(localeMap[locale] || "en-US", {
      year: "numeric", month: "long", day: "numeric",
    });
  } catch {
    return iso;
  }
}

/**
 * JSON-LD helper — renders structured data from static server constants.
 * No user input is involved; all values come from hardcoded blog.ts / metadata.ts.
 */
function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

const READ_LABELS: Record<string, { readTime: string; backToBlog: string; relatedPosts: string }> = {
  tr: { readTime: "dk okuma", backToBlog: "Blog'a Don", relatedPosts: "Diger Yazilar" },
  en: { readTime: "min read", backToBlog: "Back to Blog", relatedPosts: "Related Posts" },
  de: { readTime: "Min. Lesezeit", backToBlog: "Zuruck zum Blog", relatedPosts: "Weitere Artikel" },
  fr: { readTime: "min de lecture", backToBlog: "Retour au Blog", relatedPosts: "Articles connexes" },
  es: { readTime: "min de lectura", backToBlog: "Volver al Blog", relatedPosts: "Articulos relacionados" },
};

/* ------------------------------------------------------------------ */
/*  Article content components                                         */
/* ------------------------------------------------------------------ */

function SwipeFatigueContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Swipe Yorgunlugu Nedir?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe yorgunlugu, dating uygulamalarinda surekli profillere bakarak sola veya saga kaydirma
          eyleminin yarattigi zihinsel ve duygusal tukenmislik halidir. Bu terim ilk olarak 2020&apos;li
          yillarda populerlesmis olsa da, aslinda insanlarin yillardir hissettigi bir sorunu
          tanimlamaktadir. Tinder, Bumble, Hinge gibi uygulamalarin ortak noktasi olan swipe
          mekanigi, baslangicta eglenceli gorunse de zamanla kullanicilari yorucu bir donguye
          sokmaktadir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Arastirmalar, ortalama bir dating uygulamasi kullanicisinin gunde yaklasik 30-40 dakika
          harcadigini ve bu surede 100&apos;den fazla profile baktigini gostermektedir. Bu durum, beyinde
          asiri uyarilmaya ve sonunda karar verme kapasitesinin dusmesine yol acmaktadir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Swipe Yorgunlugu Neden Olusur?</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Karar Yorgunlugu (Decision Fatigue)</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Insan beyni gunde yaklasik 35.000 karar vermektedir. Dating uygulamalarinda her swipe bir
          karardir ve surekli &quot;evet&quot; ya da &quot;hayir&quot; demek beynin karar verme kapasitesini tuketir.
          Psikolog Barry Schwartz&apos;in &quot;Secim Paradoksu&quot; teorisine gore, cok fazla secenek sunuldugunda
          insanlar daha az tatmin olur ve karar veremez hale gelir. Bu durum dating uygulamalarinda
          &quot;bir sonraki daha iyi olabilir&quot; dusuncesiyle kendini gosterir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Dopamin Dongusu ve Bagimlilik</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe mekanigi, kumar makineleriyle benzer bir dopamin dongusu yaratir. Her swipe&apos;ta
          &quot;acaba bu kisi beni begenecek mi?&quot; belirsizligi beyinde dopamin salgilanmasina neden olur.
          Bu degisken odul sistemi, kullaniciyi uygulamada tutarken ayni zamanda duygusal
          tukenmislige yol acar. Eslesme geldiginde kisa sureli bir mutluluk hissedilir, ancak bu
          his hizla kaybolur ve dongu yeniden baslar.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Yuzeysellik ve Derinlik Eksikligi</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Geleneksel swipe tabanli uygulamalarda karar verme sureci buyuk olcude fiziksel gorunume
          dayalidir. Bir profil ortalama 0.5-2 saniye incelenmektedir. Bu sure icinde bir insanin
          kisiliginin, degerlerinin, mizah anlayisinin veya yasam gorusunun anlamli bir sekilde
          degerlendirilmesi neredeyse imkansizdir. Sonuc olarak eslesmeler yuzeysel kalir ve gercek
          baglantilar olusmaz.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Ghosting ve Iletisim Sorunlari</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe kulturu, insanlari &quot;tek kullanimlik&quot; gibi gormemize yol acmistir. Eslesme sonrasi
          mesajlasmalarin buyuk cogunlugu birkac mesaj sonra son bulur. Ghosting (aniden iletisimi
          kesmek) orani dating uygulamalarinda %80&apos;in uzerindedir. Bu durum, kullanicilarda reddedilme
          korkusu ve guvensizlik duygularini artirir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Istatistiklerle Swipe Yorgunlugu</h2>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Dating uygulamasi kullanicilarinin <strong className="text-white">%78&apos;i</strong> bir noktada tukenmislik hissettigini belirtiyor</li>
          <li>Kullanicilarin <strong className="text-white">%54&apos;u</strong> uygulamalardan sonra kendini daha yalniz hissediyor</li>
          <li>Eslesmelerin sadece <strong className="text-white">%2-5&apos;i</strong> gercek bir bulusmaya donusuyor</li>
          <li>Ortalama bir kullanici eslesme icin <strong className="text-white">115 swipe</strong> yapiyor</li>
          <li>Erkek kullanicilarin <strong className="text-white">%50&apos;si</strong> neredeyse hic eslesme almiyor</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;nun Cozumu: Soru Tabanli Eslesme</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Qulo, dating uygulamalarindaki temel sorunu kokunden cozmek icin tasarlandi. Swipe yerine
          soru-cevap tabanli bir eslesme sistemi kullanarak yuzeysellik ortadan kaldirır ve anlamli
          baglantilar kurmanizi saglar.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Nasil Calisir?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Qulo&apos;da 2 ila 10 arasinda soru hazirlarsiniz. Bu sorular sizin kisiliginizi, ilgi
          alanlarinizi ve degerlerinizi yansitir. Diger kullanicilar sizin sorularinizi cozmeye
          calisir. Tum sorularinizi dogru cevaplayan kisiyle eslesirsiniz. Bu sistem sayesinde
          eslesen kisinin sizinle gercekten uyumlu oldugunu bilirsiniz.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Neden Daha Iyi?</h3>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Daha az ama daha kaliteli eslesmeler:</strong> Herkes eslesmez, ama eslesenler gercekten uyumludur</li>
          <li><strong className="text-white">Kisilik on planda:</strong> Fiziksel gorunum yerine dusunce yapisi ve degerler eslesme kriterlerinizdir</li>
          <li><strong className="text-white">Eglenceli surec:</strong> Soru cozmek, sonsuz swipe yapmaktan cok daha keyiflidir</li>
          <li><strong className="text-white">Ghosting orani dusuk:</strong> Efor sarfederek eslesen insanlar, iletisimi surdurme konusunda daha isteklidir</li>
        </ul>

        <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
          &quot;Bir insani tanimak icin sordugunuz sorular, yuzlerce swipe&apos;tan daha degerlidir.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Quiz Dating Nasil Farkli?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Quiz dating, geleneksel dating app modellerinden temel olarak farklidir. Swipe tabanli
          uygulamalar &quot;gormek&quot; uzerine kuruluyken, quiz dating &quot;anlamak&quot; uzerine kuruludur. Birini
          tanimak icin ona sorular sormak, insan iliskilerinin en dogal yoludur. Qulo bu dogal
          sureci dijital ortama tasir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Geleneksel dating uygulamalarinda eslesme kriterleri genellikle fiziksel cekicilik, yas ve
          konum ile sinirlidir. Qulo&apos;da ise eslesme, sorulariniza verilen cevaplarin dogruluguna
          dayanir. Bu da demektir ki eslestiginiz kisi sizin dusunce yapisinizi, ilgi alanlarinizi
          veya degerlerinizi gercekten anliyor demektir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Swipe Yorgunlugundan Kurtulmanin Yollari</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Eger swipe yorgunlugu yasiyorsaniz, iste size bazi oneriler:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Gunluk uygulama kullanim surenizi sinirlayin</li>
          <li>Profillere daha dikkatli bakin, otomatik swipe yapmaktan kacinin</li>
          <li>Biyografileri okumaya zaman ayirin</li>
          <li>Eslesmelerinizle gercekten iletisim kurmaya calisin</li>
          <li>Alternatif eslesme yontemlerini deneyin — <strong className="text-white">Qulo gibi soru tabanli uygulamalar</strong> swipe dongusunden kurtulmanizi saglar</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuc</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe yorgunlugu, modern dating kulturunun en buyuk sorunlarindan biridir. Sonsuz profil
          akisi, karar yorgunlugu ve yuzeysel eslesmeler insanlari tuketmektedir. Ancak bu sorunun
          cozumu, dating uygulamalarindan tamamen vazgecmek degildir. Cozum, eslesme yontemini
          degistirmektir. Qulo, sorularla tanismanin daha anlamli, daha eglenceli ve daha
          surdurulebilir bir yol oldugunu kanitlamaktadir.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">What is Swipe Fatigue?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Swipe fatigue is the mental and emotional exhaustion caused by endlessly swiping through
        profiles on dating apps. While the term gained popularity in the early 2020s, it describes
        a problem users have felt for years. The swipe mechanic shared by Tinder, Bumble, Hinge,
        and similar apps may seem fun at first, but eventually traps users in an exhausting cycle.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Research shows that the average dating app user spends approximately 30-40 minutes per day
        and reviews over 100 profiles during that time. This leads to overstimulation in the brain
        and a gradual decline in decision-making capacity.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Why Does Swipe Fatigue Happen?</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Decision Fatigue</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The human brain makes approximately 35,000 decisions per day. On dating apps, every swipe
        is a decision, and constantly saying &quot;yes&quot; or &quot;no&quot; depletes the brain&apos;s decision-making
        capacity. According to psychologist Barry Schwartz&apos;s &quot;Paradox of Choice&quot; theory, when
        presented with too many options, people become less satisfied and more indecisive. In dating
        apps, this manifests as the persistent thought that &quot;the next one might be better.&quot;
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. The Dopamine Loop and Addiction</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The swipe mechanic creates a dopamine loop similar to slot machines. With each swipe, the
        uncertainty of &quot;will this person like me back?&quot; triggers dopamine release in the brain. This
        variable reward system keeps users engaged while simultaneously causing emotional burnout.
        When a match arrives, there&apos;s a brief burst of happiness, but it quickly fades and the cycle
        restarts.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Superficiality and Lack of Depth</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        In traditional swipe-based apps, the decision-making process is largely based on physical
        appearance. A profile is reviewed for an average of 0.5-2 seconds. Within this timeframe,
        making a meaningful assessment of someone&apos;s personality, values, sense of humor, or worldview
        is virtually impossible. As a result, matches remain superficial and genuine connections
        rarely form.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Ghosting and Communication Breakdowns</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Swipe culture has led us to view people as &quot;disposable.&quot; The vast majority of post-match
        conversations end after just a few messages. Ghosting rates on dating apps exceed 80%. This
        increases feelings of rejection and insecurity among users.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Swipe Fatigue by the Numbers</h2>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">78%</strong> of dating app users report experiencing burnout at some point</li>
        <li><strong className="text-white">54%</strong> of users feel lonelier after using apps</li>
        <li>Only <strong className="text-white">2-5%</strong> of matches result in an actual date</li>
        <li>The average user makes <strong className="text-white">115 swipes</strong> per match</li>
        <li><strong className="text-white">50%</strong> of male users receive almost no matches</li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;s Solution: Question-Based Matching</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Qulo was designed to solve the fundamental problem with dating apps from the ground up.
        By using a question-and-answer based matching system instead of swiping, it eliminates
        superficiality and enables you to build meaningful connections.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">How Does It Work?</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        On Qulo, you create between 2 and 10 questions. These questions reflect your personality,
        interests, and values. Other users attempt to answer your questions. You match with the
        person who answers all your questions correctly. This system ensures that the person you
        match with is genuinely compatible with you.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Why Is It Better?</h3>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Fewer but higher-quality matches:</strong> Not everyone matches, but those who do are truly compatible</li>
        <li><strong className="text-white">Personality first:</strong> Thought patterns and values are your matching criteria, not physical appearance</li>
        <li><strong className="text-white">Enjoyable process:</strong> Answering questions is far more engaging than endless swiping</li>
        <li><strong className="text-white">Lower ghosting rates:</strong> People who invest effort in matching are more likely to maintain communication</li>
      </ul>

      <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
        &quot;The questions you ask to get to know someone are worth more than hundreds of swipes.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">How Is Quiz Dating Different?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Quiz dating fundamentally differs from traditional dating app models. While swipe-based apps
        are built around &quot;seeing,&quot; quiz dating is built around &quot;understanding.&quot; Asking questions to
        get to know someone is the most natural way of forming human connections. Qulo brings this
        natural process into the digital space.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        In traditional dating apps, matching criteria are typically limited to physical attractiveness,
        age, and location. On Qulo, matching is based on the accuracy of answers to your questions.
        This means the person you match with truly understands your mindset, interests, or values.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">How to Overcome Swipe Fatigue</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        If you&apos;re experiencing swipe fatigue, here are some suggestions:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li>Limit your daily app usage time</li>
        <li>Look at profiles more carefully — avoid auto-swiping</li>
        <li>Take time to read bios</li>
        <li>Make genuine efforts to communicate with your matches</li>
        <li>Try alternative matching methods — <strong className="text-white">question-based apps like Qulo</strong> help you break free from the swipe cycle</li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Swipe fatigue is one of the biggest problems in modern dating culture. The endless stream of
        profiles, decision fatigue, and superficial matches are wearing people down. But the solution
        isn&apos;t to give up on dating apps entirely. The solution is to change the matching method.
        Qulo proves that meeting through questions is a more meaningful, more enjoyable, and more
        sustainable path to genuine connection.
      </p>
    </>
  );
}

function QuizDatingContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Geleneksel Dating Uygulamalarinin Sinirliliklari</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Son on yilda dating uygulamalari milyonlarca insanin tanisma bicimini kokten degistirdi.
          Tinder&apos;in 2012&apos;de baslattigi swipe mekanigi, dating sektorunu domine etti ve neredeyse
          tum rakipler ayni modeli benimsedi. Ancak bu modelin ciddi sorunlari var. Arastirmalar,
          swipe tabanli uygulamalarda yapilan eslesmelerin sadece %2-5&apos;inin gercek bir bulusmaya
          donustugunu gosteriyor.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe mekaniginin temel sorunu, insanlari bir fotograf ve birkac satir biyografiyle
          degerlendirmeye zorlamasidir. Bu yaklasim, insanlari &quot;urun katalogu&quot; gibi sunarak
          derinlikli baglantilar olusmasini engeller. Kullanicilar zamanla &quot;swipe yorgunlugu&quot;
          yasar ve uygulamayi terk eder ya da duygusal olarak kopuk bir sekilde kullanmaya devam
          eder.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Quiz Dating Konsepti: Yeni Bir Paradigma</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Quiz dating, eslesme surecini tamamen yeniden tanimlayan bir yaklasimdir. Temel fikir
          basittir: bir insani tanimak istiyorsaniz, ona fotograflarina degil, dusuncelerine bakin.
          Quiz dating&apos;de kullanicilar kendi sorularini olusturur ve potansiyel eslesmelerin bu
          sorulari cozmesini bekler. Dogru cevaplar uyumluluk gostergesidir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bu yaklasim, psikolojide &quot;oz-aciklama&quot; (self-disclosure) teorisine dayanir. Arastirmacilar
          Arthur Aron ve ekibi, insanlarin birbirlerine anlamli sorular sordugunda daha derin
          baglantilar kurdugunu kanitlamistir. Aron&apos;un unlu &quot;36 Soru&quot; deneyi, iki yabancinin
          birbirine giderek daha kisisel sorular sorarak yakinlasabilecegini gostermistir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Neden Sorular Daha Iyi Eslesme Saglar?</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Bilissel Uyumluluk</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Sorular, iki insanin dusunce yapisinin ne kadar uyumlu oldugunu ortaya koyar. Ayni
          soruya ayni cevabi veren iki insan, buyuk olasilikla benzer dunya gorusune, degerlere
          ve yasam tercihlerine sahiptir. Bu, yuzeysel cekiciligin otesinde gercek bir uyumluluk
          gostergesidir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Aktif Katilim</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe yapmak pasif bir eylemdir — sadece fotograflara tepki verirsiniz. Soru cozmek ise
          aktif bir katilim gerektirir. Bu aktif katilim, daha fazla zihinsel yatirim yapilmasini
          saglar ve eslesen kisilerin birbirine daha bagli hissetmesine yol acar. Psikolojide buna
          &quot;yatirim etkisi&quot; (investment effect) denir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Anlamli Sohbet Baslangici</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Geleneksel uygulamalarda en buyuk sorunlardan biri &quot;ne yazacagimi bilmiyorum&quot; durumudur.
          Quiz dating&apos;de sorular dogal bir sohbet baslangici saglar. &quot;Su soruya verdigin cevap
          cok ilgincti, neden oyle dusunuyorsun?&quot; gibi bir acilis, &quot;merhaba&quot;dan cok daha etkilidir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Kisilik Oncelikli Filtreleme</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Sorular, gorunusten bagimsiz olarak kisilik uyumlulugunu olcer. Bu, herkes icin daha adil
          bir sistem yaratir. Geleneksel uygulamalarda &quot;ust %10&quot; kullanicilar neredeyse tum
          ilgiyi alirken, quiz dating&apos;de herkesin esit sansi vardir — onemli olan cevaplarinizidir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Kisilik Testleri ve Uyumluluk Bilimi</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Kisilik uyumlulugu arastirmalari, basarili iliskilerin bes temel faktore dayandigini
          gostermektedir: benzer degerler, iletisim tarzi uyumu, catisma cozme becerileri, yasam
          hedefleri ve duygusal zeka uyumu. Geleneksel dating uygulamalari bu faktorlerin hicbirini
          olcmezken, soru-cevap tabanli sistemler bunlarin bircogunu dolayli olarak degerlendirir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Ornegin, &quot;Hafta sonu planlarinizda beklenmedik bir degisiklik olsa ne yaparsiniz?&quot; sorusu,
          bir insanin esneklik duzeyini, catisma cozme yaklasimini ve yasam tarzini tek bir cevapla
          ortaya koyar. Bu tur sorular, saatlerce konusmadan elde edilemeyecek bilgileri saniyeler
          icinde sunar.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Qulo&apos;da Soru Hazirlama Rehberi</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Etkili sorular hazirlamak, kaliteli eslesmelerin anahtaridir. Iste Qulo&apos;da soru
          hazirlarken dikkat etmeniz gerekenler:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Cesitli konularda sorun:</strong> Muzik, seyahat, yasam felsefesi, mizah — farkli alanlardan sorular daha kapsamli bir uyumluluk resmi cizer</li>
          <li><strong className="text-white">Cok kolay veya cok zor sorulardan kacinin:</strong> Herkesin bilebilecegi sorular filtreleme yapmaz, kimsenin bilemeyecegi sorular ise eslesme olasiligini dusurur</li>
          <li><strong className="text-white">Kisisel dokunuslar ekleyin:</strong> &quot;En sevdigim sehir hangisidir?&quot; gibi sorular, cevap verenin sizi ne kadar tandigini olcer</li>
          <li><strong className="text-white">Duzenli olarak guncelleyin:</strong> Zamanla degisen ilgi alanlarinizi yansitacak sekilde sorularinizi yenileyin</li>
          <li><strong className="text-white">2 ile 10 soru arasi optimum:</strong> Cok az soru yeterli filtreleme yapmaz, cok fazla soru eslesme olasiligini dusurur</li>
        </ul>

        <blockquote className="border-l-4 border-qulo-green pl-4 my-8 italic text-qulo-text-secondary">
          &quot;Dogru soruyu sormak, dogru insani bulmak demektir. Qulo&apos;da eslesme, bir tesaduf degil — bilincli bir kesiftir.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Quiz Dating&apos;in Gelecegi</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Dating sektoru bir donum noktasinda. Kullanicilar artik yuzeysel eslesmelerden daha
          fazlasini istiyor. Quiz dating, bu talebi karsilayan yenilikci bir yaklasimdir. AI
          teknolojileriyle birlestirildiginde — ornegin Qulo&apos;nun akilli soru onerme sistemi —
          quiz dating deneyimi daha da kisisellesiyor ve etkili hale geliyor.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Gelecekte dating uygulamalarinin cogunun bir sekilde soru-cevap veya etkilesim tabanli
          eslesme mekanikleri benimsemesi beklenmektedir. Qulo, bu trendin oncusu olarak sektorde
          yeni bir standart belirlemeyi hedeflemektedir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuc: Eslesmenin Gelecegi Sorularda</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe tabanli eslesme modeli, dating sektorune buyuk bir yenilik getirdi ancak
          sinirliliklari artik acikca goruluyor. Quiz dating, daha derin, daha anlamli ve daha
          surdurulebilir baglantilar kurmanin yoludur. Qulo ile ilk sorunuzu olusturun ve
          eslesmenin gelecegini deneyimleyin.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">The Limitations of Traditional Dating Apps</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Over the past decade, dating apps have fundamentally changed how millions of people meet.
        The swipe mechanic introduced by Tinder in 2012 dominated the dating industry, and nearly
        every competitor adopted the same model. However, this model has serious problems. Research
        shows that only 2-5% of matches made on swipe-based apps result in an actual date.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The fundamental problem with the swipe mechanic is that it forces us to evaluate people
        based on a photo and a few lines of bio. This approach presents people like a &quot;product
        catalog,&quot; preventing the formation of deep connections. Users eventually experience
        &quot;swipe fatigue&quot; and either abandon the app or continue using it in an emotionally
        disconnected way.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">The Quiz Dating Concept: A New Paradigm</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Quiz dating is an approach that completely redefines the matching process. The core idea
        is simple: if you want to know someone, look at their thoughts, not their photos. In quiz
        dating, users create their own questions and wait for potential matches to solve them.
        Correct answers indicate compatibility.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        This approach is grounded in the psychological theory of &quot;self-disclosure.&quot; Researchers
        Arthur Aron and his team proved that people form deeper connections when they ask each
        other meaningful questions. Aron&apos;s famous &quot;36 Questions&quot; experiment showed that two
        strangers can become close by asking increasingly personal questions.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Why Do Questions Create Better Matches?</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Cognitive Compatibility</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Questions reveal how compatible two people&apos;s thought processes are. Two people who give
        the same answer to the same question likely share similar worldviews, values, and life
        preferences. This is a genuine indicator of compatibility that goes beyond superficial
        attraction.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Active Participation</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Swiping is a passive action — you&apos;re merely reacting to photos. Answering questions requires
        active participation. This active engagement leads to greater mental investment and makes
        matched individuals feel more connected to each other. In psychology, this is called the
        &quot;investment effect.&quot;
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Meaningful Conversation Starters</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        One of the biggest problems with traditional apps is the &quot;I don&apos;t know what to write&quot;
        situation. In quiz dating, questions provide a natural conversation starter. An opening
        like &quot;Your answer to that question was really interesting — why do you think that way?&quot;
        is far more effective than just &quot;hi.&quot;
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Personality-First Filtering</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Questions measure personality compatibility regardless of appearance. This creates a fairer
        system for everyone. While the &quot;top 10%&quot; of users receive almost all the attention on
        traditional apps, in quiz dating everyone has an equal chance — what matters is your answers.
      </p>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Personality Tests and the Science of Compatibility</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Personality compatibility research shows that successful relationships are built on five
        key factors: shared values, communication style alignment, conflict resolution skills,
        life goals, and emotional intelligence compatibility. Traditional dating apps measure none
        of these factors, while question-based systems indirectly assess many of them.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        For example, the question &quot;What would you do if your weekend plans changed unexpectedly?&quot;
        reveals a person&apos;s flexibility, conflict resolution approach, and lifestyle in a single
        answer. Questions like these deliver insights in seconds that couldn&apos;t be obtained through
        hours of conversation.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Guide to Creating Questions on Qulo</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Creating effective questions is the key to quality matches. Here&apos;s what to keep in mind
        when crafting questions on Qulo:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Ask about various topics:</strong> Music, travel, life philosophy, humor — questions from different areas paint a more comprehensive compatibility picture</li>
        <li><strong className="text-white">Avoid too-easy or too-hard questions:</strong> Questions everyone knows won&apos;t filter effectively; questions nobody can answer reduce matching odds</li>
        <li><strong className="text-white">Add personal touches:</strong> Questions like &quot;What&apos;s my favorite city?&quot; measure how well the answerer knows you</li>
        <li><strong className="text-white">Update regularly:</strong> Refresh your questions to reflect your evolving interests</li>
        <li><strong className="text-white">2 to 10 questions is optimal:</strong> Too few won&apos;t filter enough; too many will reduce matching probability</li>
      </ul>

      <blockquote className="border-l-4 border-qulo-green pl-4 my-8 italic text-qulo-text-secondary">
        &quot;Asking the right question means finding the right person. On Qulo, matching isn&apos;t a coincidence — it&apos;s a conscious discovery.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">The Future of Quiz Dating</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The dating industry is at a turning point. Users now want more than superficial matches.
        Quiz dating is an innovative approach that meets this demand. When combined with AI
        technology — such as Qulo&apos;s smart question suggestion system — the quiz dating experience
        becomes even more personalized and effective.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        In the future, most dating apps are expected to adopt some form of question-based or
        interaction-based matching mechanics. As a pioneer of this trend, Qulo aims to set a new
        standard in the industry.
      </p>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion: The Future of Matching Is in Questions</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The swipe-based matching model brought a major innovation to the dating industry, but its
        limitations are now clearly visible. Quiz dating is the path to building deeper, more
        meaningful, and more sustainable connections. Create your first question on Qulo and
        experience the future of matching.
      </p>
    </>
  );
}

function SafetyTipsContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Neden Online Dating Guvenligi Onemli?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Online dating, milyonlarca insanin hayat arkadasini bulmasina yardimci olmustur. Ancak
          dijital tanisma ortami, bazi riskleri de beraberinde getirir. Sahte profiller, dolandiricilik
          girisimleri ve kisisel guvenlik tehditleri, bilincli kullanicilar tarafindan kolayca
          onlenebilir. Bu rehber, online dating deneyiminizi guvenli ve keyifli tutmaniz icin
          bilmeniz gereken her seyi kapsamaktadir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Istatistiklere gore, dating uygulamasi kullanicilarinin yaklasik %53&apos;u en az bir kez
          profil bilgilerinde yalan soyleyen biriyle karsilasmistir. Ayrica romance scam (ask
          dolandiricilik) vakalari her yil artmaktadir. Ancak dogru onlemleri aldiginizda, online
          dating oldukca guvenli bir deneyim olabilir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">10 Altin Kural</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Profil Fotograflarinizi Akillica Secin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Profil fotograflariniz sizi tanitirken, kisisel guvenliginizi de korumalidir. Ev adresinizi,
          is yerinizi veya duzenli olarak gittiginiz yerleri belli edecek fotograflar kullanmaktan
          kacinin. Arabanizin plakasi, evinizdeki adres etiketi veya is kartiniz gibi detaylar
          fotograflarda gorunmemelidir. Genel ve taninabilir arka planlar yerine, notr ortamlari
          tercih edin.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Kisisel Bilgilerinizi Koruyun</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Ilk mesajlasmalarda tam adinizi, ev adresinizi, is adresinizi veya finansal bilgilerinizi
          paslasmayin. Soyadiniz bile sizin hakkinizda sosyal medya uzerinden cok fazla bilgiye
          ulasilmasina yol acabilir. Guven insa edilene kadar sadece ilk adinizi kullanin ve
          detayli kisisel bilgileri yuz yuze paylasmayi tercih edin.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Uygulama Ici Mesajlasmayi Tercih Edin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Tanisma surecinin basinda kisisel telefon numaranizi veya sosyal medya hesaplarinizi
          paylasmaktan kacinin. Dating uygulamalari genellikle mesaj filtreleme ve raporlama
          ozellikleri sunar. Bu ozellikler, sorunlu davranislari tespit etmenize ve gerekirse
          kullaniciyi engellemenize yardimci olur. Kisisel iletisim bilgilerinizi ancak birkac
          goruntulu arama veya yuz yuze bulusma sonrasi paylasin.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Ilk Bulusmada Halka Acik Yerler Secin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Ilk bulusmaniz her zaman halka acik, kalabalik bir yerde olmalidir. Kafeler, restoranlar
          ve alisveris merkezleri iyi seceneklerdir. Karsi tarafin evinize gelmesini veya sizi
          evine davet etmesini kabul etmeyin. Kendiniz ulasabileceginiz bir konum secin —
          karsi tarafin aracina binmek ilk bulusma icin uygun degildir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">5. Bir Yakininizi Bilgilendirin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bulusmaya gitmeden once guvendiginiz bir arkadasiniza veya aile uyenize bulusma
          detaylarini (yer, saat, karsi tarafin adi) bildirin. Bulusma sirasinda periyodik olarak
          mesaj atin veya &quot;guvenlik check-in&quot; zamani ayarlayin. Bazi uygulamalar bu amacla
          yerlesik guvenlik ozellikleri sunar.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">6. Goruntulu Arama ile Dogrulayin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Yuz yuze bulusmadan once en az bir goruntulu arama yapin. Bu, karsi tarafin profil
          fotograflariyla uyumlu oldugunu dogrulamanizi saglar. Catfishing (sahte profil) vakalarinin
          cogu goruntulu arama asamasinda ortaya cikar. Goruntulu aramayi surekli reddeden birisi
          ciddi bir uyari isaretidir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">7. Alkol ve Madde Tuketimine Dikkat Edin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Ilk bulusmalarda alkol tuketimini minimum tutun veya tamamen kacinin. Alkol karar verme
          yetinizi olumsuz etkiler ve potansiyel riskleri fark etmenizi zorlastirir. Iceceginizi
          her zaman kendiniz siparis edin ve gozunuzun onunde hazirlanmasini saglayin. Iceceginizi
          asla basibosbirakin.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">8. Finansal Tuzaklara Dusmeyin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Tanisma surecinde para istemek veya finansal bilgi talep etmek en yaygin dolandiricilik
          yontemlerinden biridir. Henuz tanismadiginiz birine asla para gondermeyin, banka
          bilgilerinizi paylasmayin veya finansal yardim tekliflerini kabul etmeyin. &quot;Acil durum&quot;
          bahane eden para talepleri, tanisma surecinin hangi asamasinda olursa olsun red flag&apos;tir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">9. Red Flag&apos;leri Taniyin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bazi davranislar ciddi uyari isaretleridir ve gormezden gelinmemelidir:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Hizla &quot;asik oldugunu&quot; iddia etmek (love bombing)</li>
          <li>Surekli goruntulu aramayi reddetmek</li>
          <li>Finansal bilgi veya para istemek</li>
          <li>Kontrolcu davranislar sergilemek (surekli nerede oldugunuzu sormak)</li>
          <li>Gecmisi hakkinda tutarsiz bilgiler vermek</li>
          <li>Sosyal medya hesabi olmamak veya cok yeni bir hesap</li>
          <li>Bulusma yerini surekli degistirmek veya izole yerleri tercih etmek</li>
        </ul>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">10. Uygulamanin Guvenlik Ozelliklerini Kullanin</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Guvenilir dating uygulamalari engelleme, raporlama ve profil dogrulama gibi guvenlik
          ozellikleri sunar. Rahatsiz edici bir davranisla karsilastiginizda tereddut etmeden
          bu ozellikleri kullanin. Qulo gibi uygulamalar, guvenligi temel bir ozellik olarak
          sunar ve kullanicilari korumak icin surekli olarak guvenlik altyapisini guclendirir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Qulo&apos;nun Guvenlik Ozellikleri</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Qulo, kullanici guvenligini en ust duzeyde tutmak icin tasarlanmistir. Iste Qulo&apos;nun
          sundugu guvenlik ozellikleri:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Profil dogrulama:</strong> Kullanicilarin gercek kisiler oldugunu dogrulayan sistem</li>
          <li><strong className="text-white">Engelleme ve raporlama:</strong> Tek dokunusla kullanici engelleme ve uygunsuz davranis raporlama</li>
          <li><strong className="text-white">Sifreli mesajlasma:</strong> Tum mesajlar sifrelenerek korunur</li>
          <li><strong className="text-white">Soru tabanli filtreleme:</strong> Swipe tabanli uygulamalarin aksine, Qulo&apos;da eslesmek efor gerektirir — bu da spam ve sahte profilleri dogal olarak filtreler</li>
        </ul>

        <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
          &quot;Guvenlik bir ozellik degil, bir haktir. Qulo&apos;da guvenliginiz her zaman onceligimizdir.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuc: Guvenle Tanisin</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Online dating, dogru yaklasimla guvenli ve keyifli bir deneyim olabilir. Bu 10 altin
          kurali hatirlayarak ve sagduyunuzu kullanarak, potansiyel riskleri minimize edebilir ve
          anlamli baglantilar kurabilirsiniz. Unutmayin: guvenliginiz her zaman romantizmden
          once gelir. Qulo ile guvenle tanisin, sorularla eslesin.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Why Is Online Dating Safety Important?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Online dating has helped millions of people find their partners. However, the digital
        dating environment also comes with certain risks. Fake profiles, scam attempts, and personal
        safety threats can be easily prevented by informed users. This guide covers everything you
        need to know to keep your online dating experience safe and enjoyable.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        According to statistics, approximately 53% of dating app users have encountered someone
        who lied in their profile information at least once. Additionally, romance scam cases are
        increasing every year. However, when you take the right precautions, online dating can be
        a very safe experience.
      </p>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">10 Golden Rules</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Choose Your Profile Photos Wisely</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Your profile photos should introduce you while also protecting your personal safety. Avoid
        using photos that reveal your home address, workplace, or places you regularly visit. Details
        like your car&apos;s license plate, address labels at home, or business cards should not be
        visible in photos. Prefer neutral settings over recognizable locations.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Protect Your Personal Information</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        During initial conversations, don&apos;t share your full name, home address, work address, or
        financial information. Even your last name can lead to extensive information about you
        through social media. Use only your first name until trust is established, and prefer
        sharing detailed personal information face to face.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Prefer In-App Messaging</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Avoid sharing your personal phone number or social media accounts early in the getting-to-know
        process. Dating apps typically offer message filtering and reporting features. These features
        help you detect problematic behavior and block users if necessary. Share personal contact
        information only after several video calls or in-person meetings.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Choose Public Places for First Dates</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Your first date should always be in a public, busy place. Cafes, restaurants, and shopping
        centers are good options. Don&apos;t accept invitations to their home or allow them to come to
        yours. Choose a location you can get to on your own — getting in the other person&apos;s car
        is not appropriate for a first date.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">5. Inform Someone You Trust</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Before going on a date, share the details (location, time, the other person&apos;s name) with
        a trusted friend or family member. Send periodic messages during the date or set up a
        &quot;safety check-in&quot; time. Some apps offer built-in safety features for this purpose.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">6. Verify Through Video Calls</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Have at least one video call before meeting in person. This allows you to verify that the
        other person matches their profile photos. Most catfishing cases are revealed during the
        video call stage. Someone who consistently refuses video calls is a serious red flag.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">7. Be Cautious with Alcohol and Substances</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Keep alcohol consumption to a minimum on first dates or avoid it entirely. Alcohol negatively
        affects your decision-making ability and makes it harder to notice potential risks. Always
        order your own drinks and make sure they are prepared in your line of sight. Never leave
        your drink unattended.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">8. Don&apos;t Fall for Financial Traps</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Asking for money or requesting financial information during the getting-to-know process is
        one of the most common scam methods. Never send money to someone you haven&apos;t met in person,
        don&apos;t share banking information, and don&apos;t accept financial assistance offers. Money requests
        using &quot;emergency&quot; excuses are a red flag regardless of the stage of your relationship.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">9. Recognize Red Flags</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Certain behaviors are serious warning signs that should not be ignored:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li>Claiming to be &quot;in love&quot; very quickly (love bombing)</li>
        <li>Consistently refusing video calls</li>
        <li>Requesting financial information or money</li>
        <li>Displaying controlling behavior (constantly asking where you are)</li>
        <li>Providing inconsistent information about their past</li>
        <li>Having no social media accounts or very new accounts</li>
        <li>Constantly changing meeting locations or preferring isolated places</li>
      </ul>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">10. Use the App&apos;s Safety Features</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Trustworthy dating apps offer safety features such as blocking, reporting, and profile
        verification. Don&apos;t hesitate to use these features when you encounter disturbing behavior.
        Apps like Qulo offer safety as a core feature and continuously strengthen their security
        infrastructure to protect users.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Qulo&apos;s Safety Features</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Qulo is designed to maintain the highest level of user safety. Here are the safety features
        Qulo offers:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Profile verification:</strong> A system that verifies users are real people</li>
        <li><strong className="text-white">Blocking and reporting:</strong> One-tap user blocking and inappropriate behavior reporting</li>
        <li><strong className="text-white">Encrypted messaging:</strong> All messages are encrypted and protected</li>
        <li><strong className="text-white">Question-based filtering:</strong> Unlike swipe-based apps, matching on Qulo requires effort — naturally filtering spam and fake profiles</li>
      </ul>

      <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
        &quot;Safety is not a feature — it&apos;s a right. Your safety is always our priority at Qulo.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion: Date Safely</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Online dating can be a safe and enjoyable experience with the right approach. By remembering
        these 10 golden rules and using common sense, you can minimize potential risks and build
        meaningful connections. Remember: your safety always comes before romance. Meet safely
        with Qulo, match through questions.
      </p>
    </>
  );
}

/* ------------------------------------------------------------------ */
/*  Content router                                                     */
/* ------------------------------------------------------------------ */
function BlogContent({ slug, locale }: { slug: string; locale: string }) {
  switch (slug) {
    case "what-is-swipe-fatigue":
      return <SwipeFatigueContent locale={locale} />;
    case "quiz-dating-future-of-matching":
      return <QuizDatingContent locale={locale} />;
    case "online-dating-safety-tips":
      return <SafetyTipsContent locale={locale} />;
    default:
      return null;
  }
}

/* ------------------------------------------------------------------ */
/*  Page component                                                     */
/* ------------------------------------------------------------------ */
export default async function BlogPostPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const post = BLOG_POSTS.find((p) => p.slug === slug);
  if (!post) notFound();

  const title = post.titles[locale] || post.titles.en;
  const excerpt = post.excerpts[locale] || post.excerpts.en;
  const labels = READ_LABELS[locale] || READ_LABELS.en;

  const otherPosts = BLOG_POSTS.filter((p) => p.slug !== slug);

  // BlogPosting JSON-LD
  const blogPostingJsonLd = {
    "@context": "https://schema.org",
    "@type": "BlogPosting",
    headline: title,
    description: excerpt,
    datePublished: post.publishedAt,
    dateModified: post.publishedAt,
    author: {
      "@type": "Organization",
      name: SITE_NAME,
      url: SITE_URL,
    },
    publisher: {
      "@type": "Organization",
      name: SITE_NAME,
      url: SITE_URL,
      logo: {
        "@type": "ImageObject",
        url: `${SITE_URL}/images/og-image.png`,
      },
    },
    mainEntityOfPage: {
      "@type": "WebPage",
      "@id": `${SITE_URL}/${locale}/blog/${slug}`,
    },
    keywords: post.keywords.join(", "),
    wordCount: 1500,
    inLanguage: locale,
  };

  // BreadcrumbList JSON-LD
  const breadcrumbJsonLd = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      { "@type": "ListItem", position: 1, name: "Qulo", item: `${SITE_URL}/${locale}` },
      { "@type": "ListItem", position: 2, name: "Blog", item: `${SITE_URL}/${locale}/blog` },
      { "@type": "ListItem", position: 3, name: title, item: `${SITE_URL}/${locale}/blog/${slug}` },
    ],
  };

  const CTA_LABELS: Record<string, { ctaTitle: string; ctaDesc: string }> = {
    tr: { ctaTitle: "Qulo'yu Indir", ctaDesc: "Sorularla tanismanin yeni yolunu kesfet. Hemen dene, ucretsiz!" },
    en: { ctaTitle: "Download Qulo", ctaDesc: "Discover the new way to meet through questions. Try it now, for free!" },
    de: { ctaTitle: "Qulo herunterladen", ctaDesc: "Entdecken Sie den neuen Weg, sich durch Fragen kennenzulernen." },
    fr: { ctaTitle: "Telecharger Qulo", ctaDesc: "Decouvrez la nouvelle facon de se rencontrer par les questions." },
    es: { ctaTitle: "Descargar Qulo", ctaDesc: "Descubre la nueva forma de conocerse a traves de preguntas." },
  };

  const cta = CTA_LABELS[locale] || CTA_LABELS.en;

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* BlogPosting + Breadcrumb JSON-LD — trusted static constants only */}
      <JsonLd data={blogPostingJsonLd} />
      <JsonLd data={breadcrumbJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
          {/* Back to blog */}
          <nav className="mb-8">
            <Link
              href={`/${locale}/blog`}
              className="text-sm text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              &larr; {labels.backToBlog}
            </Link>
          </nav>

          {/* Article header */}
          <header className="mb-10">
            <div className="flex items-center gap-3 text-xs text-qulo-text-secondary mb-4">
              <time dateTime={post.publishedAt}>
                {formatDate(post.publishedAt, locale)}
              </time>
              <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-purple/50" />
              <span>
                {post.readingTime} {labels.readTime}
              </span>
            </div>
            <h1 className="text-3xl sm:text-4xl font-bold leading-tight mb-4">
              {title}
            </h1>
            <p className="text-lg text-qulo-text-secondary leading-relaxed">
              {excerpt}
            </p>
            <div className="mt-4 flex flex-wrap gap-2">
              {post.keywords.map((kw) => (
                <span
                  key={kw}
                  className="text-[10px] px-2 py-0.5 rounded-full border border-white/[0.08] text-qulo-text-secondary"
                >
                  {kw}
                </span>
              ))}
            </div>
          </header>

          {/* Divider */}
          <div
            className="w-full h-px mb-10"
            style={{
              background: "linear-gradient(90deg, transparent 0%, rgba(187,134,252,0.3) 50%, transparent 100%)",
            }}
            aria-hidden="true"
          />

          {/* Article body */}
          <article className="prose-qulo">
            <BlogContent slug={slug} locale={locale} />
          </article>

          {/* CTA Section */}
          <section className="mt-16 text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10">
            <h2 className="text-2xl font-bold text-white mb-3">{cta.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-6">{cta.ctaDesc}</p>
            <div className="flex justify-center">
              <StoreButtons />
            </div>
          </section>

          {/* Related posts */}
          {otherPosts.length > 0 && (
            <section className="mt-16">
              <h2 className="text-xl font-bold text-white mb-6">{labels.relatedPosts}</h2>
              <div className="space-y-4">
                {otherPosts.map((rp) => (
                  <Link
                    key={rp.slug}
                    href={`/${locale}/blog/${rp.slug}`}
                    className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-5 hover:border-qulo-purple/30 hover:bg-white/[0.05] transition-all duration-200"
                  >
                    <h3 className="text-sm font-semibold text-white mb-1">
                      {rp.titles[locale] || rp.titles.en}
                    </h3>
                    <p className="text-xs text-qulo-text-secondary line-clamp-2">
                      {rp.excerpts[locale] || rp.excerpts.en}
                    </p>
                  </Link>
                ))}
              </div>
            </section>
          )}
        </div>
      </div>

      <Footer />
    </main>
  );
}
