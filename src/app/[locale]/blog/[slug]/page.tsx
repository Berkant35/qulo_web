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
          tanimlamaktadir. Swipe tabanli uygulamalarin ortak noktasi olan bu mekanik, baslangicta
          eglenceli gorunse de zamanla kullanicilari yorucu bir donguye sokmaktadir.
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
        a problem users have felt for years. The swipe mechanic shared by most traditional dating
        apps may seem fun at first, but eventually traps users in an exhausting cycle.
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
          2012&apos;de populerlesen swipe mekanigi, dating sektorunu domine etti ve neredeyse tum
          klasik dating uygulamalari ayni modeli benimsedi. Ancak bu modelin ciddi sorunlari var.
          Arastirmalar, swipe tabanli uygulamalarda yapilan eslesmelerin sadece %2-5&apos;inin
          gercek bir bulusmaya donustugunu gosteriyor.
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
        The swipe mechanic that became popular in 2012 dominated the dating industry, and nearly
        every traditional dating app adopted the same model. However, this model has serious
        problems. Research shows that only 2-5% of matches made on swipe-based apps result in an
        actual date.
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

function DatingBurnoutContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Dating App Tukenmisligi Nedir?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Dating app tukenmisligi (dating app burnout), dating uygulamalarini uzun sure kullanmanin yarattigi
          duygusal, zihinsel ve motivasyonel yorgunluk halidir. Bu durum, uygulamalara karsi ilgi kaybindan
          romantik iliskilere karsi genel bir umursamazliga kadar genis bir spektrumda kendini gosterebilir.
          2020&apos;li yillarin ortalarindan itibaren arastirmacilar bu fenomeni sistematik olarak incelemeye
          baslamistir ve sonuclar carpicidir: dating uygulamasi kullanicilarinin %78&apos;den fazlasi bir
          noktada tukenmislik yasadigini bildirmektedir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Tukenmislik, dating uygulamalarindan tamamen vazgecmeyi gerektirmez. Ancak belirtileri tanimak
          ve dogru adimlari atmak, hem dijital hem de gercek hayattaki iliski deneyiminizi iyilestirmek
          icin kritik oneme sahiptir. Peki dating app burnout&apos;un belirtileri nelerdir ve bu durumdan
          nasil cikarsiniz?
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Belirti 1: Uygulamayi Acmak Istememe</h2>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Nasil Anlarsiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Telefonunuzdaki dating uygulamasi bildirimlerini surekli erteliyorsunuz. Uygulamanin ikonunu
          gordugunuzde icsel bir direnç hissediyorsunuz. Bir zamanlar heyecanla actiginiz uygulama artik
          bir &quot;gorev&quot; gibi hissettiriyor. Bu, dating app tukenmisliginin en erken ve en yaygin
          belirtilerinden biridir.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Neden Olur?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Psikolog Dr. Helen Fisher&apos;a gore, surekli tekrarlayan ve odul vermeyen eylemler zamanla
          &quot;ogrenmis caresizlik&quot; durumuna yol acar. Uygulamada cok zaman harcayip anlamli sonuclar
          alamadiginizda, beyniniz bu eylemi &quot;oduller yetersiz&quot; olarak kodlar ve motivasyon duser.
          Dopamin sisteminiz artik uygulamayi acmayi bir odul olarak degil, bir yuk olarak algilar.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Ne Yapmalisiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Kendinize belirli &quot;dating app saatleri&quot; tanimlayin. Ornegin gunde sadece 15 dakika, belirli
          bir saatte uygulamayi acin. Surekli erisim yerine bilinçli kullanim, tukenmisligi azaltir.
          Ayrica Qulo gibi soru tabanli uygulamalara gecis yapmak, sonsuz kaydirma dongusunu kirarak
          deneyimi daha anlamli hale getirebilir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Belirti 2: Otomatik Swipe Yapma</h2>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Nasil Anlarsiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Profilleri gercekten incelemeden, neredeyse refleks halinde sola veya saga kaydiriyorsunuz.
          Biyografileri okumuyorsunuz. Fotograflara bile dikkatli bakmiyorsunuz. Swipe islemi bir
          &quot;oyun&quot; haline gelmis ve amacini yitirmistir. Bu davranis, dating uygulamalarinda
          &quot;mindless swiping&quot; olarak adlandirilir ve ciddi bir tukenmislik gostergesidir.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Neden Olur?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Arastirmalar, insanlarin bir profil icin harcadigi ortalama surenin 0.5 ila 2 saniye arasinda
          oldugunu gostermektedir. Bu sure icinde anlamli bir degerlendirme yapmak imkansizdir. Beyin,
          asiri bilgi yuklemesiyle basa cikmak icin &quot;otomatik pilot&quot; moduna gecer. Karar verme
          kalitesi duser ve eslesmeler tamamen rastgele hale gelir.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Ne Yapmalisiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Her oturumda kendinize bir limit koyun — ornegin en fazla 10 profil. Her profili en az 10 saniye
          inceleyin. Daha da iyisi, swipe mekanigini tamamen ortadan kaldiran uygulamalara yonelin.
          Qulo&apos;da soru cozme sureci, her etkilesimin bilinçli ve anlamli olmasini garanti eder.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Belirti 3: Mesajlara Cevap Vermekten Kacinma</h2>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Nasil Anlarsiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Eslesme bildirimlerini goruyorsunuz ama cevap vermek icin motivasyonunuz yok. &quot;Sonra
          yazarim&quot; diye erteliyorsunuz ve sonra unutuyorsunuz. Gelen mesajlar birikirken siz
          bunlari acmaktan bile kaciniyorsunuz. Bir zamanlar heyecan veren &quot;Yeni eslesme!&quot;
          bildirimi artik anlamsiz geliyor.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Neden Olur?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Tekrarlayan ve sonucsuz sohbetler, iletisim motivasyonunu dusurur. Arastirmalar, dating
          uygulamalarindaki mesajlasmalarin %90&apos;inin ilk 5 mesaj icinde son bulduğunu gostermektedir.
          Bu oruntu, &quot;ne yazarsam yazayim bir ise yaramayacak&quot; inancini guçlendirir. Psikolojide
          buna &quot;sosyal tukenmislik&quot; denir ve ozellikle icedonuk bireylerde daha siddetli yasanir.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Ne Yapmalisiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Kalite odakli yaklasim benimseyin. Herkese cevap yazmak yerine, gercekten ilginizi ceken
          1-2 kisiye odaklanin ve onlara anlamli mesajlar gonderin. Qulo&apos;nun soru-cevap mekanigi
          bu sorunu dogal olarak cozer: eslesmek icin sorulari cozmek gerektiğinden, her eslesme
          zaten anlamli bir baglanti potansiyeli tasir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Belirti 4: Herkesin Ayni Gorunduğunu Hissetme</h2>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Nasil Anlarsiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Profiller aranizda farklilasmiyor. Herkes ayni pozlarda, ayni filtrelerle, ayni biyografilerle
          gorunuyor. &quot;Seyahat etmeyi, kahve icmeyi ve kosmaya cikmayi seviyorum&quot; cumlesini yuzbininci
          kez okudugunuzu hissediyorsunuz. Bu, dating uygulamalarinda &quot;homojenlik algilama&quot; olarak
          bilinen bir olgudur ve ciddi tukenmislik belirtisidir.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Neden Olur?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bilissel psikolojide &quot;dikkat korlugu&quot; (attentional blindness) kavrami, beyninizin cok
          fazla benzer uyarana maruz kaldiginizda bireysel farkliliklari algilama kapasitesinin dustugunu
          aciklar. Swipe tabanli uygulamalar, profilleri standart bir formatta sundugu icin bireysellik
          kaybolur. Herkes &quot;ayni&quot; gorunmeye baslar cunku beyniniz artik ayrimlari yapamaz.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Ne Yapmalisiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Kisiligin on planda oldugu platformlara gecis yapin. Qulo&apos;da her kullanici benzersiz sorular
          olusturur ve bu sorular kisiyi fotograftan cok daha iyi tanitir. Bir kisinin hazirladigi
          sorular, onun zekasini, mizah anlayisini ve degerlerini yansitir — bu da her profili
          gercekten benzersiz kilar.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Belirti 5: Gercek Hayatta Tanismayi Tercih Etme</h2>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Nasil Anlarsiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          &quot;Keske birisiyle dogal bir sekilde tanisabilsem&quot; diye dusunuyorsunuz. Dating uygulamalarinin
          &quot;dogal olmadigi&quot; hissini surekli yasiyorsunuz. Uygulama uzerinden tanismak yerine tesadufi
          karsilasmalar ozliyorsunuz. Bu duygu tamamen normal ve aslinda saglikli bir icguduyu yansitir.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Neden Olur?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Insan beyni, yuz yuze etkilesimler icin evrilmistir. Sozsel olmayan iletisim (beden dili,
          ses tonu, goz kontagi) bir insani tanima surecinin %65&apos;inden fazlasini olusturur. Dating
          uygulamalari bu zengin iletisim katmanlarini ortadan kaldirir ve tanisma surecini bir
          metin ve fotograf degerlendirmesine indirger. Bu da dogal hissetmeyen, yapay bir deneyim yaratir.
        </p>
        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Ne Yapmalisiniz?</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Gercek hayat tanismalari ile dijital tanismalari birbirinin alternatifi degil, tamamlayicisi
          olarak gorun. Hobi gruplarina katilin, sosyal etkinliklere gidin. Dijital tarafta ise
          etkilesimin daha dogal hissettigi platformlari secin. Qulo&apos;da soru cozmek, bir insanla
          kafede sohbet etmeye benzer bir zihinsel surec yaratir — dolayisiyla dijital ortamda bile
          &quot;gercek&quot; bir tanisma deneyimi sunar.
        </p>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;nun Farki: Tukenmisligi Azaltan Tasarim</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Qulo, dating app tukenmisliginin temel nedenlerini anlayarak tasarlanmistir. Soru tabanli
          eslesme sistemi, swipe mekaniginin yarattigi tum sorunlari kokunden cozer:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Sonsuz kaydirma yok:</strong> Her etkilesim bilinçli ve amacli</li>
          <li><strong className="text-white">Otomatik pilot yok:</strong> Soru cozmek aktif dusunme gerektirir</li>
          <li><strong className="text-white">Anlamli eslesmeler:</strong> Sorularinizi cozen kisi sizinle uyumludur</li>
          <li><strong className="text-white">Dogal sohbet baslangici:</strong> Sorular uzerinden konusmak yapay degil</li>
          <li><strong className="text-white">Benzersiz profiller:</strong> Her kisinin sorulari onu farkli kilar</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Dijital Detoks Onerileri</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Eger dating app tukenmisligi yasiyorsaniz, kisa bir dijital detoks yapmayi dusunun:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Bir hafta tum dating uygulamalarindan mola verin</li>
          <li>Bu surede kendinize odaklanin: spor, hobi, arkadaslar</li>
          <li>Geri dondugunuzde &quot;ne istiyorum?&quot; sorusunu cevaplayin</li>
          <li>Kullandiginiz uygulama sayisini 1-2 ile sinirlayin</li>
          <li>Kalite odakli bir yaklasim benimseyin: daha az swipe, daha cok anlam</li>
        </ul>

        <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
          &quot;Tukenmislik, yanlis insanlari bulmaktan degil — yanlis yontemle aramaktan kaynaklanir.
          Dogru arac, aramayi yeniden keyifli hale getirir.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuc</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Dating app tukenmisligi gercek, yaygin ve ciddiye alinmasi gereken bir olgudur. Ancak bu,
          dijital tanismadan vazgecmeniz gerektigini anlamina gelmez. Tukenmisligin belirtilerini
          tanimak ilk adimdir. Ikinci adim, yaklasimini degistirmektir. Soru tabanli eslesme sistemleri,
          dating deneyimini yuzeysellikten derinlige tasiyarak tukenmisligi dogal olarak azaltir.
          Qulo ile tanismayi yeniden kesfedebilir ve anlamli baglantilar kurabilirsiniz.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">What Is Dating App Burnout?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Dating app burnout is the emotional, mental, and motivational exhaustion caused by prolonged use
        of dating applications. This condition can manifest across a wide spectrum — from losing interest
        in apps to developing a general apathy toward romantic relationships. Since the mid-2020s,
        researchers have been systematically studying this phenomenon, and the results are striking:
        more than 78% of dating app users report experiencing burnout at some point.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Burnout doesn&apos;t mean you need to give up on dating apps entirely. However, recognizing the
        signs and taking the right steps is critically important for improving both your digital and
        real-life relationship experiences. So what are the signs of dating app burnout, and how can
        you break free?
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Sign 1: Dreading Opening the App</h2>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">How to Recognize It</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        You constantly dismiss dating app notifications. You feel an internal resistance when you see
        the app icon on your phone. What once felt exciting now feels like a chore. This is one of
        the earliest and most common signs of dating app burnout. If opening the app feels like a
        task on your to-do list rather than something enjoyable, your brain is sending you a clear signal.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Why It Happens</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        According to psychologist Dr. Helen Fisher, continuously repeating actions that don&apos;t yield
        rewards leads to a state of &quot;learned helplessness.&quot; When you spend significant time on an
        app without meaningful results, your brain codes this activity as &quot;insufficient reward.&quot;
        Your dopamine system begins to perceive opening the app as a burden rather than a reward.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">What to Do</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Set specific &quot;dating app hours&quot; for yourself. For example, open the app for only 15 minutes
        per day at a designated time. Intentional use rather than constant access reduces burnout.
        Additionally, switching to question-based apps like Qulo can break the endless scrolling
        cycle and make the experience more meaningful.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Sign 2: Mindless Swiping</h2>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">How to Recognize It</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        You swipe left or right almost reflexively without actually reviewing profiles. You don&apos;t
        read bios. You barely look at photos. The swiping action has become a game that has lost its
        purpose. This behavior is called &quot;mindless swiping&quot; in dating app culture and is a serious
        indicator of burnout.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Why It Happens</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Research shows that the average time spent on a single profile is between 0.5 and 2 seconds.
        Making a meaningful assessment in this timeframe is impossible. The brain switches to
        &quot;autopilot mode&quot; to cope with information overload. Decision quality drops and matches
        become essentially random. This is a well-documented cognitive phenomenon known as
        decision fatigue.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">What to Do</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Set a limit for each session — for example, a maximum of 10 profiles. Spend at least 10 seconds
        reviewing each profile. Better yet, switch to apps that eliminate the swipe mechanic entirely.
        On Qulo, the question-solving process ensures that every interaction is intentional and meaningful.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Sign 3: Avoiding Responses to Messages</h2>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">How to Recognize It</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        You see match notifications but have no motivation to respond. You tell yourself &quot;I&apos;ll reply
        later&quot; and then forget. Messages pile up while you avoid even opening them. The &quot;New match!&quot;
        notification that once sparked excitement now feels meaningless.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Why It Happens</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Repetitive and fruitless conversations erode communication motivation. Research indicates that
        90% of conversations on dating apps end within the first 5 messages. This pattern reinforces the
        belief that &quot;nothing I write will matter.&quot; In psychology, this is called &quot;social exhaustion&quot;
        and it&apos;s especially intense for introverted individuals who find that tired-of-dating-apps
        feeling overwhelming.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">What to Do</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Adopt a quality-focused approach. Instead of trying to respond to everyone, focus on 1-2 people
        who genuinely interest you and send them meaningful messages. Qulo&apos;s question-answer mechanism
        naturally solves this problem: since solving questions is required to match, every match already
        carries meaningful connection potential.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Sign 4: Everyone Looks the Same</h2>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">How to Recognize It</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Profiles no longer differentiate from one another. Everyone appears with the same poses, same
        filters, same bios. You feel like you&apos;ve read &quot;I love traveling, coffee, and running&quot; for the
        hundred-thousandth time. This is a phenomenon known as &quot;homogeneity perception&quot; in dating apps
        and is a serious sign of burnout.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Why It Happens</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The concept of &quot;attentional blindness&quot; in cognitive psychology explains that when your brain
        is exposed to too many similar stimuli, its capacity to perceive individual differences declines.
        Swipe-based apps present profiles in a standardized format, causing individuality to disappear.
        Everyone starts to &quot;look the same&quot; because your brain can no longer distinguish the differences.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">What to Do</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Switch to platforms where personality takes center stage. On Qulo, each user creates unique
        questions, and these questions introduce the person far better than any photo could. A person&apos;s
        questions reflect their intelligence, sense of humor, and values — making every profile
        genuinely unique and combating that dating app fatigue.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Sign 5: Preferring to Meet in Real Life</h2>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">How to Recognize It</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        You find yourself thinking, &quot;I wish I could just meet someone naturally.&quot; You constantly feel
        that dating apps are &quot;unnatural.&quot; You miss serendipitous encounters rather than app-mediated
        introductions. This feeling is completely normal and actually reflects a healthy instinct.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Why It Happens</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The human brain evolved for face-to-face interactions. Non-verbal communication (body language,
        tone of voice, eye contact) constitutes over 65% of the process of getting to know someone.
        Dating apps strip away these rich communication layers and reduce the acquaintance process to
        text and photo evaluation. This creates an artificial experience that doesn&apos;t feel natural.
      </p>
      <h3 className="text-xl font-semibold text-white mb-3 mt-6">What to Do</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        View real-life and digital dating not as alternatives but as complements. Join hobby groups,
        attend social events. On the digital side, choose platforms where interaction feels more
        natural. Solving questions on Qulo creates a mental process similar to chatting with someone
        at a cafe — thus offering a &quot;real&quot; meeting experience even in a digital environment.
      </p>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">How Qulo Combats Burnout by Design</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Qulo was designed with a deep understanding of what causes dating app burnout. The question-based
        matching system addresses every core issue created by the swipe mechanic:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">No infinite scrolling:</strong> Every interaction is intentional and purposeful</li>
        <li><strong className="text-white">No autopilot:</strong> Solving questions requires active thinking</li>
        <li><strong className="text-white">Meaningful matches:</strong> The person who solves your questions is genuinely compatible</li>
        <li><strong className="text-white">Natural conversation starters:</strong> Talking about questions feels organic, not forced</li>
        <li><strong className="text-white">Unique profiles:</strong> Each person&apos;s questions make them distinctively different</li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Digital Detox Tips</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        If you&apos;re experiencing dating app burnout, consider a short digital detox:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li>Take a one-week break from all dating apps</li>
        <li>During this time, focus on yourself: exercise, hobbies, friends</li>
        <li>When you return, answer the question &quot;what do I actually want?&quot;</li>
        <li>Limit the number of apps you use to 1-2</li>
        <li>Adopt a quality-focused approach: less swiping, more meaning</li>
      </ul>

      <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
        &quot;Burnout doesn&apos;t come from searching for the wrong people — it comes from searching with
        the wrong method. The right tool makes the search enjoyable again.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Dating app burnout is a real, widespread phenomenon that deserves to be taken seriously.
        However, it doesn&apos;t mean you should give up on digital dating entirely. Recognizing the
        signs of burnout is the first step. The second step is changing your approach. Question-based
        matching systems naturally reduce burnout by transforming the dating experience from superficiality
        to depth. With Qulo, you can rediscover the joy of meeting new people and build truly
        meaningful connections.
      </p>
    </>
  );
}

function NoSwipeDatingContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Swipe Mekanizmasinin Tarihi ve Sorunlari</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          2012 yilindan itibaren populerlesen &quot;swipe&quot; mekanigi, dating dunyasinin standart
          etkilesim modeli haline geldi. Sola kaydir &quot;hayir,&quot; saga kaydir &quot;evet&quot; — bu kadar
          basit. Bu mekanik, dating uygulamalarini cok daha erisilebilir kildi ve sektoru milyar
          dolarlik bir endustriye donusturdu. Ancak on yildan fazla bir sure sonra, swipe modelinin
          ciddi yapisal sorunlari artik gormezden gelinemeyecek kadar belirgin.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Arastirmalar, swipe tabanli uygulamalardaki eslesmelerin sadece %2-5&apos;inin gercek bir
          bulusmaya donustugunu gostermektedir. Kullanicilarin %78&apos;i tukenmislik yasadigini,
          %54&apos;u ise uygulamalari kullandiktan sonra kendini daha yalniz hissettigini belirtiyor.
          Bu veriler, swipe mekaniginin temel vaadini — insanlari birlestirmek — yerine getiremedigini
          kanitlamaktadir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe&apos;in temel sorunlari sunlardir: yuzeysellik (karar 0.5-2 saniyede verilir), karar
          yorgunlugu (gunde yuzlerce swipe), dopamin bagimliligi (kumar benzeri degisken odul sistemi),
          ve esitsizlik (ust %10 kullanicilara orantisiz ilgi). Bu sorunlar, swipe olmadan dating
          arayisini hizlandirmistir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Swipe&apos;siz Dating Uygulamasi Alternatifleri</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          2026 itibariyle, swipe mekanigine alternatif sunan bircok yakla im ortaya cikmistir. Bu
          alternatifleri dort ana kategoride inceleyebiliriz:
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Soru Tabanli (Quiz-Based) Dating</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bu modelde kullanicilar kendi sorularini olusturur ve potansiyel eslesmelerin bu sorulari
          cozmesini bekler. Tum sorulari dogru cevaplayan kisiyle eslesme gerceklesir. Bu yaklasim,
          psikolojideki &quot;oz-aciklama teorisi&quot;ne dayanir ve derin baglantilar kurulmasini saglar.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <strong className="text-white">Avantajlari:</strong> Kisilik on planda, anlamli eslesmeler,
          dogal sohbet baslangici, dusuk ghosting orani, her kullaniciya esit sans.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <strong className="text-white">En iyi ornek:</strong> Qulo — 2-10 soru hazirlayarak kendi
          eslesme kriterlerinizi belirlersiniz. Sorularinizi cozen kisiyle eslesirsiniz. Gamification
          ogeleri (elmaslar, seviyeler, gucler) deneyimi eglenceli kilar.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Yavas Dating (Slow Dating)</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Sonsuz profil akisi yerine, gunde sinirli sayida profil sunan uygulamalar. Amac, her profili
          dikkatlice degerlendirmeyi tesvik etmektir. Bu kategori, kalite odakli kullanicilarin
          hiz yerine anlamli eslesme aradigi bir yaklasim sunar.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <strong className="text-white">Avantajlari:</strong> Karar yorgunlugunu azaltir, daha dikkatli
          profil inceleme, kalite odakli.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <strong className="text-white">Dezavantajlari:</strong> Hala fotografa dayali, sinirli havuz,
          sabir gerektiren yavas surec.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Video Oncelikli (Video-First) Dating</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Profil fotografi yerine kisa tanitim videolari kullanan uygulamalar. Kullanicilar, karsi
          tarafin ses tonunu, beden dilini ve enerjisini gorebilir. Snack, Loveflutter gibi uygulamalar
          bu kategoride yer alir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <strong className="text-white">Avantajlari:</strong> Daha gercekci izlenim, catfishing riski azalir,
          enerji uyumu gorulur.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <strong className="text-white">Dezavantajlari:</strong> Kamera korkusu olanlari dislar, icedonukler
          icin zorlayici, hala yuzeysel degerlendirme riski.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. Yapay Zeka Destekli (AI-Powered) Matching</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Kullanici davranislarini, tercihlerini ve mesajlasma oruntulerini analiz ederek uyumluluk
          tahmini yapan AI tabanli sistemler. Iris Dating, Teaser AI gibi uygulamalar bu alanda
          oncudur.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <strong className="text-white">Avantajlari:</strong> Veri odakli eslesme, kullanici davranisina
          gore gelisen oneriler, kisisellestirme.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          <strong className="text-white">Dezavantajlari:</strong> &quot;Kara kutu&quot; algoritmasi (neden
          eslestiginiz belirsiz), gizlilik kaygilari, algoritmik on yargi riski.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Neden Quiz Tabanli Dating One Cikiyor?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Tum alternatifler arasinda quiz tabanli dating, en kapsamli cozumu sunmaktadir. Bunun
          nedenleri sunlardir:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Seffaflik:</strong> Neden eslestiginizi bilirsiniz — sorulara verilen cevaplar sayesinde</li>
          <li><strong className="text-white">Adaletli sistem:</strong> Fiziksel gorunum degil, dusunce yapisi belirleyicidir</li>
          <li><strong className="text-white">Aktif katilim:</strong> Pasif swipe yerine aktif dusunme ve cozme</li>
          <li><strong className="text-white">Eglence faktoru:</strong> Gamification ogeleri deneyimi keyifli kilar</li>
          <li><strong className="text-white">Derin baglantilar:</strong> Sorular, insanlarin gercek yonlerini ortaya koyar</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">2026&apos;da Dating Trendleri</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          2026 yilinda dating sektorunde bazi belirgin trendler one cikmaktadir:
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Gamification</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Oyunlastirma ogeleri (rozet, seviye, odul, meydan okuma) dating deneyimini daha eglenceli
          ve baglayici kilmaktadir. Qulo&apos;nun elmas ekonomisi, guc sistemleri ve seviye mekanikleri
          bu trendin oncu orneklerindendir. Arastirmalar, gamification iceren uygulamalarda kullanici
          bagliliginin %40 daha yuksek oldugunu gostermektedir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">AI Destekli Kisselestirme</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Yapay zeka, soru onerilerinden eslesme optimizasyonuna kadar dating deneyiminin her
          asamasinda rol oynamaktadir. Qulo&apos;nun AI destekli soru onerme sistemi, kullanicilarin
          daha etkili sorular hazirlamasina yardimci olur.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Kisilik Oncelikli Yaklasim</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          &quot;Personality-first dating&quot; hareketi, fiziksel gorunumun otesinde deger, dusunce ve kisilik
          uyumlulugunu on plana cikarmaktadir. Bu trend, ozellikle Z kusagi arasinda hizla
          yayilmaktadir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Hangi Alternatif Size Uygun?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Dogru dating uygulamasini secmek, kisisel tercihlerinize baglidir. Iste bir rehber:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Anlamli baglantilar istiyorsaniz:</strong> Quiz tabanli dating (Qulo) — sorularla derinlikli eslesme</li>
          <li><strong className="text-white">Sabriniz varsa:</strong> Yavas dating — gunde sinirli, kaliteli profiller</li>
          <li><strong className="text-white">Gorsel etkilesim istiyorsaniz:</strong> Video-first dating — canli ve gercekci izlenimler</li>
          <li><strong className="text-white">Teknolojiye guveniyorsaniz:</strong> AI dating — algoritma tabanli eslesme</li>
        </ul>

        <blockquote className="border-l-4 border-qulo-green pl-4 my-8 italic text-qulo-text-secondary">
          &quot;Swipe cagı sona eriyor. 2026&apos;da dating, daha akilli, daha anlamli ve daha insani bir
          hale geliyor.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuc</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe mekanizmasi dating sektorunu demokratiklestirdi, ancak yuzeysellik, tukenmislik ve
          anlamsiz eslesmeler gibi ciddi sorunlar yaratti. 2026&apos;da artik swipe olmadan dating
          mumkun ve giderek daha populer. Soru tabanli, yavas, video oncelikli ve AI destekli
          alternatifler, herkes icin daha iyi bir dating deneyimi vaat ediyor. Qulo, bu
          alternatiflerin en kapsamlisi olarak soru-cevap mekanigini gamification ile
          birlestirerek dating&apos;i yeniden tanimliyor. Swipe&apos;a veda edin, sorularla tanisin.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">The History and Problems of the Swipe Mechanic</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Since 2012, the &quot;swipe&quot; mechanic has become the standard interaction model for the
        dating world. Swipe left for &quot;no,&quot; swipe right for &quot;yes&quot; — that simple. This mechanic
        made dating apps far more accessible and transformed the industry into a multi-billion
        dollar sector. However, after more than a decade, the structural problems of the swipe
        model have become too significant to ignore.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Research shows that only 2-5% of matches on swipe-based apps result in an actual date.
        78% of users report experiencing burnout, and 54% say they feel lonelier after using
        these apps. These statistics prove that the swipe mechanic is failing at its fundamental
        promise — bringing people together.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The core problems with swiping include: superficiality (decisions made in 0.5-2 seconds),
        decision fatigue (hundreds of swipes per day), dopamine addiction (variable reward system
        similar to gambling), and inequality (disproportionate attention to the top 10% of users).
        These issues have accelerated the search for dating apps without swiping.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">No Swipe Dating App Alternatives</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        As of 2026, several approaches have emerged as alternatives to the swipe mechanic. We can
        examine these alternatives in four main categories:
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Question-Based (Quiz-Based) Dating</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        In this model, users create their own questions and wait for potential matches to solve them.
        A match occurs when someone answers all questions correctly. This approach is grounded in
        the psychological theory of &quot;self-disclosure&quot; and enables the formation of deep connections.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <strong className="text-white">Advantages:</strong> Personality first, meaningful matches,
        natural conversation starters, low ghosting rates, equal opportunity for every user.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <strong className="text-white">Best example:</strong> Qulo — you set your own matching criteria
        by creating 2-10 questions. You match with whoever solves your questions. Gamification elements
        (diamonds, levels, powers) make the experience enjoyable.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Slow Dating</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Apps that present a limited number of profiles per day instead of an infinite stream. The goal
        is to encourage careful evaluation of each profile. This category appeals to quality-focused
        users who prefer meaningful matching over speed.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <strong className="text-white">Advantages:</strong> Reduces decision fatigue, more careful
        profile review, quality-focused.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <strong className="text-white">Disadvantages:</strong> Still photo-based, limited pool,
        slow process requiring patience.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Video-First Dating</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Apps that use short introduction videos instead of profile photos. Users can see the other
        person&apos;s tone of voice, body language, and energy. Apps like Snack and Loveflutter fall
        into this category.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <strong className="text-white">Advantages:</strong> More realistic impressions, reduced
        catfishing risk, energy compatibility visible.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <strong className="text-white">Disadvantages:</strong> Excludes camera-shy people, challenging
        for introverts, still risks superficial evaluation.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">4. AI-Powered Matching</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        AI-based systems that analyze user behaviors, preferences, and messaging patterns to predict
        compatibility. Apps like Iris Dating and Teaser AI are pioneers in this space.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <strong className="text-white">Advantages:</strong> Data-driven matching, suggestions that
        improve based on user behavior, personalization.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        <strong className="text-white">Disadvantages:</strong> &quot;Black box&quot; algorithm (unclear why
        you matched), privacy concerns, risk of algorithmic bias.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Why Quiz-Based Dating Stands Out</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Among all alternatives, quiz-based dating offers the most comprehensive solution for those
        seeking a dating app without swiping. Here&apos;s why:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Transparency:</strong> You know why you matched — through answers to questions</li>
        <li><strong className="text-white">Fair system:</strong> Thought patterns determine matches, not physical appearance</li>
        <li><strong className="text-white">Active participation:</strong> Active thinking and solving instead of passive swiping</li>
        <li><strong className="text-white">Fun factor:</strong> Gamification elements make the experience enjoyable</li>
        <li><strong className="text-white">Deep connections:</strong> Questions reveal people&apos;s true selves</li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Dating Trends in 2026</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Several distinct trends are emerging in the dating industry in 2026:
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Gamification</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Game elements (badges, levels, rewards, challenges) are making the dating experience more
        enjoyable and engaging. Qulo&apos;s diamond economy, power systems, and level mechanics are
        leading examples of this trend. Research shows that user engagement is 40% higher in apps
        with gamification features.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">AI-Powered Personalization</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Artificial intelligence is playing a role in every stage of the dating experience, from
        question suggestions to match optimization. Qulo&apos;s AI-powered question suggestion system
        helps users create more effective questions.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Personality-First Approach</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The &quot;personality-first dating&quot; movement prioritizes values, thoughts, and personality
        compatibility beyond physical appearance. This trend is spreading rapidly, especially
        among Gen Z users searching for alternative dating apps.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Which Alternative Is Right for You?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Choosing the right dating app depends on your personal preferences. Here&apos;s a guide:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">If you want meaningful connections:</strong> Quiz-based dating (Qulo) — deep matching through questions</li>
        <li><strong className="text-white">If you have patience:</strong> Slow dating — limited, quality profiles daily</li>
        <li><strong className="text-white">If you prefer visual interaction:</strong> Video-first dating — live and realistic impressions</li>
        <li><strong className="text-white">If you trust technology:</strong> AI dating — algorithm-based matching</li>
      </ul>

      <blockquote className="border-l-4 border-qulo-green pl-4 my-8 italic text-qulo-text-secondary">
        &quot;The age of swiping is ending. In 2026, dating is becoming smarter, more meaningful,
        and more human.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The swipe mechanic democratized the dating industry, but it also created serious problems
        like superficiality, burnout, and meaningless matches. In 2026, dating without swiping
        is not only possible but increasingly popular. Question-based, slow, video-first, and
        AI-powered alternatives promise a better dating experience for everyone. Qulo, as the most
        comprehensive of these alternatives, redefines dating by combining the question-answer
        mechanic with gamification. Say goodbye to swiping, and start meeting through questions.
      </p>
    </>
  );
}

function IntrovertDatingContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Icedonukluk ve Dating Uygulamalari: Neden Zor?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Icedonukluk, nufusun yaklasik %30-50&apos;sini etkileyen bir kisilik ozelligidir. Carl Jung
          tarafindan tanimlanan bu kavram, enerjisini ic dunyasindan alan, derin dusunmeyi ve
          anlamli iliskileri tercih eden bireyleri tanimlar. Icedonukler utangac, sosyal fobi
          yasayan veya insanlardan hoslanmayan kisiler degildir — sadece enerji kaynaklari
          farklidir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Geleneksel dating uygulamalari, buyuk olcude disadonuk iletisim kaliplarina gore
          tasarlanmistir: hizli kararlar, yuzeysel ilk izlenimler, surekli etkilesim baskisi.
          Bu yaklasim, icedonukler icin ozellikle yorucu ve tatmin edici olmayan bir deneyim
          yaratir. Peki icedonukler icin daha iyi bir yol var mi? Quiz dating, tam da bu soruya
          cevap vermektedir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Icedonuklerin Dating App&apos;lerdeki 3 Buyuk Sorunu</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Asiri Uyarilma (Overstimulation)</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Icedonuklerin beyni, disadonuklere kiyasla dissal uyaranlara karsi daha duyarlidir.
          Nörobilimci Dr. Marti Olsen Laney&apos;nin arastirmalarina gore, icedonuklerin beyni asetilkolin
          (derin dusunme ve ic gozlem ile iliskili norotransmitter) agirlikli calisirken, disadonuklerin
          beyni dopamin (heyecan ve yenilik arayan norotransmitter) agirliklidir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe tabanli dating uygulamalari, surekli yeni uyaranlar (fotograflar, profiller,
          bildirimler) bombardimani yapar. Bu, icedonuk beyni icin asiri uyarilma demektir.
          Sonuc: hizli yorulma, karar verememe ve uygulamadan kacma.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Sosyal Tukenme (Social Depletion)</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Icedonukler, sosyal etkilesimlerden sonra enerjilerini yenilemek icin yalniz zamana ihtiyac
          duyar. Dating uygulamalarindaki surekli mesajlasma baskisi, bu yenileme surecini engeller.
          Birden fazla kisiyle ayni anda mesajlasmak, icedonukler icin ozellikle tuketicdir. Her yeni
          sohbet, enerji rezervinden ceker ve zamanla &quot;sosyal batarya&quot; tamamen bosalir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. Yuzeysellik Sorunu</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Icedonukler, yuzeysel sohbetlerden (small talk) hoslanmaz ve anlamli, derin konusmalar
          tercih eder. Ancak dating uygulamalarindaki tipik acilis mesajlari — &quot;Merhaba, nasıl-
          sın?&quot;, &quot;Guzel fotograflar&quot; — tam da icedonuklerin kacindigi yuzeysellik ornekleridir.
          Bu durum, icedonuklerin uygulamalarda asla rahat hissetmemesine ve iletisim baslatmaktan
          kacinmasina yol acar.
        </p>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Quiz Dating Neden Icedonukler Icin Ideal?</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Dusunme Suresi</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe mekanigi anlik kararlar gerektirir — bu, icedonuklerin guclu yani degil. Quiz dating&apos;de
          ise sorulari incelemek, dusunmek ve cevaplamak icin zaman vardir. Icedonukler, derin dusunme
          kapasiteleri sayesinde quiz formatinda cok daha basarilidir. Bir soruyu dikkatle okumak,
          kisi hakkinda dusunmek ve anlamli bir cevap vermek — bu tam olarak icedonuklerin dogal
          iletisim tarzidir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Yazili Ifade Gucu</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Arastirmalar, icedonuklerin yazili iletisimde disadonuklere kiyasla daha basarili
          olduğunu gostermektedir. Susan Cain, &quot;Quiet: The Power of Introverts in a World That
          Can&apos;t Stop Talking&quot; kitabinda, icedonuklerin duygularini ve dusuncelerini yazili olarak
          ifade etmede ustun yeteneklere sahip oldugunu vurgular. Quiz dating, tam da bu gucten
          yararlanir.
        </p>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Derinlik Onceligi</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Icedonukler, az ama derin iliskiler kurarlar. Quiz dating&apos;in &quot;daha az ama daha kaliteli
          eslesme&quot; felsefesi, icedonuklerin iliski yaklasimyla mukemmel bir uyum icindedir. Her
          eslesme, sorulari cozme surecindeki zihinsel yatirim sayesinde zaten derinlikli bir
          baglanti potansiyeli tasir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Qulo&apos;da Icedonuk Stratejileri</h2>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Soru Tipleri</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Icedonukler icin en etkili soru tipleri sunlardir:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Deger bazli sorular:</strong> &quot;Hayatta en cok neye deger verirsin?&quot; — derin kisilik uyumlulugunu olcer</li>
          <li><strong className="text-white">Senaryo sorulari:</strong> &quot;Yagmurlu bir pazar gunu ideal planin ne olur?&quot; — yasam tarzini ortaya koyar</li>
          <li><strong className="text-white">Kultur ve sanat sorulari:</strong> &quot;Son okudugun kitap hangisi?&quot; — entelektuel uyumlulugu olcer</li>
          <li><strong className="text-white">Felsefi sorular:</strong> &quot;Basari sana gore ne demek?&quot; — derinlikli dusunce yapisi gerektiren sorular</li>
        </ul>

        <h3 className="text-xl font-semibold text-white mb-3 mt-6">Tempo Kontrolu</h3>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Qulo&apos;da kendi hizinizda ilerleyebilirsiniz. Gunde kac soru cozeceksiniz, kac kisiyle
          mesajlasacaksiniz — tamamen size kalmis. Bu esneklik, icedonuklerin sosyal enerjilerini
          yonetmelerine olanak tanir. Ayrica soru cozme sureci asenkron oldugu icin, ayni anda
          birden fazla kisiyle canli sohbet etme baskisi yoktur.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Icedonuk-Disadonuk Uyumluluk Miti</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Populer kultur, icedonuklerin disadonuklerle &quot;mukemmel bir denge&quot; olusturdugunu iddia
          eder. Ancak arastirmalar daha nüansli bir tablo ortaya koyar. Psikolog Dr. John Gottman&apos;in
          40 yili askin iliski arastirmalari, basarili iliskilerin kisilik tipinden ziyade paylasilan
          degerler, iletisim uyumu ve karsilikli saygi uzerine kuruldugunu gostermektedir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Quiz dating, bu gercegi yansitir. Sorular, kisilik tipinden bagimsiz olarak deger ve
          dusunce uyumlulugunu olcer. Bir icedonuk baska bir icedonukle de, bir disadonukle de
          mukemmel bir eslesme olabilir — onemli olan cevaplarin uyumudur, kisilik tipinin degil.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Susan Cain&apos;in &quot;Quiet&quot; Kitabindan Ilhamlar</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Susan Cain&apos;in cığır acan kitabi &quot;Quiet&quot;, icedonuklerin toplumda hafife alinan guclerini
          gozler onune serer. Cain&apos;e gore icedonukler:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li>Daha derin dinleme ve empati kapasitesine sahip</li>
          <li>Daha dikkatli ve dusunceli kararlar verir</li>
          <li>Daha sadik ve baglayici iliskiler kurar</li>
          <li>Yaraticilik ve problem cozme konusunda ustundur</li>
        </ul>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bu gucler, quiz dating formatinda parliyarak ortaya cikar. Soru cozmek, tam da icedonuklerin
          ustun oldugu derin dusunme, dikkatli analiz ve anlamli iletisim becerilerini gerektirir.
        </p>

        <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
          &quot;Icedonukler sessiz oldugu icin degil, dinledigi icin gucludur. Quiz dating,
          dinleme ve anlama uzerine kurulu tek dating modelidir.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuc</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Icedonukler icin dating uygulamalari zorlayici olabilir — ancak sorun icedonuklukte degil,
          uygulamalarin tasarimindadir. Swipe tabanli modeller disadonuk iletisim kaliplarina gore
          insa edilmistir ve icedonuklerin guclerini gormezden gelir. Quiz dating, bu dengeyi
          yeniden kurar. Dusunme suresi, yazili ifade gucu ve derinlik onceligi sayesinde quiz
          dating, icedonukler icin mukemmel bir eslesme modeli sunar. Qulo ile kendi hizinizda,
          kendi sorularinizla ve kendi tarzinizda tanisin. Cunku en iyi baglantilar, en cok
          ses cikaranlarla degil — en iyi dinleyenlerle kurulur.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Introversion and Dating Apps: Why Is It So Hard?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Introversion is a personality trait that affects approximately 30-50% of the population.
        Defined by Carl Jung, this concept describes individuals who draw their energy from their
        inner world and prefer deep thinking and meaningful relationships. Introverts are not shy,
        socially anxious, or people who dislike others — they simply have different energy sources.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Traditional dating apps are largely designed around extroverted communication patterns:
        quick decisions, superficial first impressions, and constant interaction pressure. This
        approach creates a particularly exhausting and unsatisfying experience for introverts. Is
        there a better way for introverts? Quiz dating answers exactly this question and represents
        the best dating app for introverts.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">3 Major Problems Introverts Face on Dating Apps</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">1. Overstimulation</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Introverts&apos; brains are more sensitive to external stimuli compared to extroverts. According
        to neuroscientist Dr. Marti Olsen Laney&apos;s research, introverts&apos; brains primarily use
        acetylcholine (a neurotransmitter associated with deep thinking and introspection), while
        extroverts&apos; brains are dopamine-dominant (a neurotransmitter that seeks excitement and novelty).
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Swipe-based dating apps bombard users with constant new stimuli (photos, profiles,
        notifications). For the introvert brain, this means overstimulation. The result: rapid
        fatigue, decision paralysis, and avoidance of the app entirely.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">2. Social Depletion</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Introverts need alone time after social interactions to recharge their energy. The constant
        messaging pressure in dating apps disrupts this recharging process. Messaging multiple people
        simultaneously is particularly draining for introverts. Each new conversation draws from
        their energy reserves, and over time the &quot;social battery&quot; completely drains — a key reason
        introvert dating feels so exhausting.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">3. The Superficiality Problem</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Introverts dislike small talk and prefer meaningful, deep conversations. However, typical
        opening messages on dating apps — &quot;Hey, how are you?&quot;, &quot;Nice photos&quot; — are exactly the
        kind of superficiality introverts avoid. This situation leads to introverts never feeling
        comfortable on apps and avoiding initiating communication altogether.
      </p>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Why Quiz Dating Is Ideal for Introverts</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Thinking Time</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The swipe mechanic requires instant decisions — this is not introverts&apos; strength. In quiz
        dating, there&apos;s time to examine questions, think, and answer. Introverts are far more
        successful in quiz formats thanks to their deep thinking capacity. Carefully reading a
        question, reflecting on the person, and providing a meaningful answer — this is exactly
        introverts&apos; natural communication style, making quiz dating introverts&apos; preferred method.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Written Expression Power</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Research shows that introverts are more successful in written communication compared to
        extroverts. Susan Cain, in her book &quot;Quiet: The Power of Introverts in a World That
        Can&apos;t Stop Talking,&quot; emphasizes that introverts possess superior abilities in expressing
        their feelings and thoughts in writing. Quiz dating leverages exactly this strength.
      </p>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Depth Priority</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Introverts build fewer but deeper relationships. Quiz dating&apos;s &quot;fewer but higher-quality
        matches&quot; philosophy is in perfect alignment with introverts&apos; approach to relationships.
        Every match already carries deep connection potential thanks to the mental investment
        involved in the question-solving process.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Introvert Strategies on Qulo</h2>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Question Types</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        The most effective question types for introverts include:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Value-based questions:</strong> &quot;What do you value most in life?&quot; — measures deep personality compatibility</li>
        <li><strong className="text-white">Scenario questions:</strong> &quot;What&apos;s your ideal plan on a rainy Sunday?&quot; — reveals lifestyle</li>
        <li><strong className="text-white">Culture and art questions:</strong> &quot;What&apos;s the last book you read?&quot; — measures intellectual compatibility</li>
        <li><strong className="text-white">Philosophical questions:</strong> &quot;What does success mean to you?&quot; — requires deep thinking</li>
      </ul>

      <h3 className="text-xl font-semibold text-white mb-3 mt-6">Pace Control</h3>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        On Qulo, you can progress at your own pace. How many questions you solve per day, how many
        people you message — it&apos;s entirely up to you. This flexibility allows introverts to manage
        their social energy. Since the question-solving process is asynchronous, there&apos;s no pressure
        to engage in live conversations with multiple people simultaneously.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">The Introvert-Extrovert Compatibility Myth</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Popular culture claims that introverts and extroverts form a &quot;perfect balance.&quot; However,
        research reveals a more nuanced picture. Psychologist Dr. John Gottman&apos;s 40+ years of
        relationship research shows that successful relationships are built on shared values,
        communication compatibility, and mutual respect rather than personality type.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Quiz dating reflects this reality. Questions measure value and thought compatibility
        regardless of personality type. An introvert can have a perfect match with another
        introvert or with an extrovert — what matters is the alignment of answers, not
        personality type.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Insights from Susan Cain&apos;s &quot;Quiet&quot;</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Susan Cain&apos;s groundbreaking book &quot;Quiet&quot; reveals the undervalued strengths of introverts
        in society. According to Cain, introverts:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li>Have deeper listening and empathy capacity</li>
        <li>Make more careful and thoughtful decisions</li>
        <li>Build more loyal and committed relationships</li>
        <li>Excel in creativity and problem-solving</li>
      </ul>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        These strengths shine brilliantly in the quiz dating format. Solving questions requires
        exactly the deep thinking, careful analysis, and meaningful communication skills at which
        introverts excel.
      </p>

      <blockquote className="border-l-4 border-qulo-purple pl-4 my-8 italic text-qulo-text-secondary">
        &quot;Introverts are powerful not because they&apos;re quiet, but because they listen. Quiz dating
        is the only dating model built on listening and understanding.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Dating apps can be challenging for introverts — but the problem lies not in introversion
        itself, but in app design. Swipe-based models are built around extroverted communication
        patterns and overlook introverts&apos; strengths. Quiz dating restores this balance. With
        thinking time, written expression power, and depth priority, quiz dating offers the
        perfect matching model for introverts. Meet through Qulo at your own pace, with your
        own questions, and in your own style. Because the best connections aren&apos;t made by those
        who make the most noise — they&apos;re made by the best listeners.
      </p>
    </>
  );
}

function MatchingScienceContent({ locale }: { locale: string }) {
  if (locale === "tr") {
    return (
      <>
        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Arthur Aron&apos;un 36 Soru Deneyi</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          1997 yilinda sosyal psikolog Arthur Aron ve ekibi, insanlar arasi yakinlik olusumunu
          arastiran cığır acan bir deney gerceklestirdi. Deney basitti: iki yabanci, birbirlerine
          giderek kisisellesen 36 soru sordu ve ardindan 4 dakika boyunca birbirlerinin gozlerinin
          icine bakti. Sonuclar bilim dunyasini sasirtti — katilimcilarin onemli bir kismi,
          yasamlarindaki en yakin iliskilerinkine esit duzeyde yakinlik hissettiklerini bildirdi.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Aron&apos;un 36 soru deneyi, sorularin insanlar arasinda yakinlik yaratmadaki gucunu bilimsel
          olarak kanitladi. Sorular, &quot;Dunyada herhangi biriyle yemek yiyebilseydin kim olurdu?&quot;
          gibi hafif konulardan baslayip &quot;Ailenle ilisgkin nasil?&quot; gibi derin konulara ilerliyordu.
          Bu kademeli derinlesme, katilimcilarin birbirlerine guven duymalarini ve kendilerini
          acmalarini sagladi.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bu deney, soru tabanli eslesmenin bilimsel temelini olusturur. Qulo&apos;nun soru-cevap
          mekanigi, Aron&apos;un kesfettigi bu ilkeyi dijital dating ortamina uyarlamaktadir. Sorular
          sorarak tanismak, bilimsel olarak kanitlanmis en etkili baglanti kurma yontemidir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Oz-Aciklama (Self-Disclosure) Teorisi</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Oz-aciklama teorisi, sosyal psikolojinin en koklü teorilerinden biridir. Sidney Jourard
          tarafindan 1958&apos;de ortaya konan bu teori, insanlarin kendileri hakkinda bilgi paylasiminin
          iliski derinligini belirleyen en onemli faktor oldugunu one surer. Iliskiler, karsilikli
          oz-aciklama sayesinde derinlesir — yani siz kendinizi actikca karsi taraf da kendini acar.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe tabanli dating uygulamalarinda oz-aciklama neredeyse sifirdir. Bir fotograf ve kisa
          bir biyografi, kisi hakkinda cok sinirli bilgi sunar. Quiz dating ise sorular araciligiyla
          dogal bir oz-aciklama sureci baslatir. &quot;Hayatinda en cesaret isteyen sey ne oldu?&quot; gibi
          bir soruyu cevaplamak, otomatik olarak kisisel bir paylasimi tetikler. Bu karsilikli
          paylasim, gercek yakinlik ve guvenin temelini olusturur.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Baglanma Kurami ve Dating</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          John Bowlby&apos;nin baglanma kurami, insan iliskilerinin temelini aciklar. Guvenlı baglanma
          stiline sahip bireyler, saglikli ve uzun sureli iliskiler kurma egilimindedir. Kaygili
          ve kacingan baglanma stilleri ise iliski sorunlarina yol acabilir. Arastirmalar,
          dating uygulamalarinin — ozellikle swipe tabanli olanlarin — kaygili baglanma stilini
          guclendirebildigini gostermektedir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Surekli reddedilme (swipe&apos;ta eslesmeme), belirsizlik (eslesme sonrasi ghosting) ve
          yuzeysellik (fiziksel gorunume dayali degerlendirme) kaygili baglanma oruntulerini
          tetikler. Quiz dating ise daha guvenli bir deneyim sunar: eslesmek icin sorulari cozmek
          gerektiğinden, reddedilme kisisellesmez. &quot;Sorulari cozemedim&quot; ile &quot;Beni begenmediler&quot;
          arasinda onemli bir psikolojik fark vardir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Bilissel Uyumluluk Nedir?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bilissel uyumluluk, iki insanin dusunce sureclerinin, problem cozme yaklasimlarinin ve
          bilgi isleme tarzlarinin benzerligini ifade eder. Arastirmalar, bilissel uyumlulugun
          uzun vadeli iliski basarisinda fiziksel cekicilikten cok daha guclu bir predikter
          oldugunu gostermektedir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Dr. Robert Sternberg&apos;in &quot;Ask Ucgeni&quot; teorisine gore, kalici ask uc bilesenden olusur:
          yakinlik, tutku ve baglilik. Fiziksel cekicilik sadece tutku bilesenini beslerken,
          bilissel uyumluluk hem yakinlik hem de baglilik bilesenlerini guçlendirir. Sorular,
          bilissel uyumlulugu dolaysiz olarak olcer: ayni soruya benzer sekilde yaklasan iki insan,
          buyuk olasilikla bilissel olarak uyumludur.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Neden Fiziksel Cekicilik Yanilticidir?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Fiziksel cekicilik, evrimsel olarak onemli bir sinyal olsa da, modern dating baglam-
          inda yaniltici olabilir. Arastirmalar bunu kanitlar:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Halo etkisi:</strong> Fiziksel olarak cekici buldugumuz insanlara otomatik olarak iyi kisilik ozellikleri atfederiz — bu genellikle yanlistir</li>
          <li><strong className="text-white">Alisma etkisi (Hedonic adaptation):</strong> Fiziksel cekicilige 6-18 ay icinde alisilir, ancak kisilik uyumlulugu zamanla daha onemli hale gelir</li>
          <li><strong className="text-white">Fotograf yanilgisi:</strong> Arastirmalar, fotograflarin bir kisinin gercek cekiciligini %20-30 oraninda yanlis temsil ettiğini gostermektedir</li>
          <li><strong className="text-white">Uzun vadeli tatmin:</strong> Iliski tatmini arastirmalari, 2 yil sonra fiziksel cekiciligin iliski kalitesiyle korelasyonunun neredeyse sifira dustugunu gostermektedir</li>
        </ul>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bu veriler, fotografa dayali eslesmenin temel sinirliligini ortaya koyar. Soru tabanli
          eslesme, bu sinirligu asarak kisilik, degerler ve dusunce uyumunu on plana cikarir.
        </p>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;nun Bilimsel Temelleri</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Qulo&apos;nun soru-cevap tabanli eslesme sistemi, yukarida anlattığımiz bilimsel prensiplerin
          pratik uygulamasidir:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Aron&apos;un 36 Soru ilkesi:</strong> Sorularla tanismak yakinlik yaratir</li>
          <li><strong className="text-white">Oz-aciklama teorisi:</strong> Soru-cevap sureci dogal paylasimi tetikler</li>
          <li><strong className="text-white">Bilissel uyumluluk:</strong> Dogru cevaplar dusunce yapisi benzerlgini gosterir</li>
          <li><strong className="text-white">Yatirim etkisi:</strong> Soru cozmek icin harcanan efor, eslesmeye deger katar</li>
          <li><strong className="text-white">Guvenli baglanma:</strong> Performansa dayali eslesme, kisisel reddedilme hissini azaltir</li>
        </ul>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Sorular Nasil Derinlikli Baglanti Yaratir?</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Norobilimsek arastirmalar, soru sorma ve cevaplama surecinde beyinde ilginc seyler
          oldugunu gostermektedir. Bir soruyu dusunurken prefrontal korteks (karar verme ve
          dusunme bolgesi) aktive olur. Kisisel bir cevap verirken limbik sistem (duygusal
          islem bolgesi) devreye girer. Bu iki bolgenin es zamanli aktivasyonu, &quot;bilissel-
          duygusal entegrasyon&quot; olarak adlandirilir ve derin baglantilarin norolojik temelidir.
        </p>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Swipe yapmak ise yalnizca gorsel islem bolgelerini (oksipital lob) ve hizli karar
          mekanizmalarini (amigdala) aktive eder. Bu, &quot;savaş ya da kac&quot; tepkisine benzer bir
          islem olup derin baglantilar kurmak icin yetersizdir. Soru tabanli etkilesim,
          beyinin tam kapasitesiyle calismesini saglar ve dolayisiyla daha guclu ve kalici
          baglantilar olusturur.
        </p>

        <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Pratik Oneriler: Etkili Soru Hazirlama</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Bilimsel arastirmalar isiginda, etkili sorular hazirlmanin ilkeleri sunlardir:
        </p>
        <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
          <li><strong className="text-white">Acik uclu tercih edin:</strong> &quot;Evet/hayir&quot; sorulari yerine dusunmeye zorlayan sorular sorun</li>
          <li><strong className="text-white">Degerleri hedefleyin:</strong> Kisi hakkinda yuzeysel bilgi degil, temel degerleri ortaya cikaran sorular</li>
          <li><strong className="text-white">Kademeli derinlik:</strong> Hafif konulardan baslayip derin konulara gecis yapin</li>
          <li><strong className="text-white">Senaryolar kullanin:</strong> &quot;X durumunda ne yapardin?&quot; sorulari, davranis kaliplarini ortaya koyar</li>
          <li><strong className="text-white">Kisisel dokunuslar:</strong> Sizi taniyan birinin bilebilecegi sorular ekleyin</li>
        </ul>

        <blockquote className="border-l-4 border-qulo-green pl-4 my-8 italic text-qulo-text-secondary">
          &quot;Bir insani tanimanin en kisa yolu, ona dogru soruyu sormaktir. Bilim bunu kanitliyor,
          Qulo bunu mumkun kiliyor.&quot;
        </blockquote>

        <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Sonuc</h2>
        <p className="text-qulo-text-secondary leading-relaxed mb-4">
          Soru tabanli eslesme, sadece bir fikir degil — onlarca yillik psikoloji ve norobilim
          arastirmasinin destekledigi bilimsel bir yaklasimdir. Arthur Aron&apos;un 36 Soru deneyinden
          oz-aciklama teorisine, baglanma kurainindan bilissel uyumluluk arastirmalarina kadar
          bilim, sorularin fotograflardan cok daha guclu baglantilar kurdugunu kanitlamaktadir.
          Qulo, bu bilimsel temelleri modern dating deneyimine entegre ederek daha anlamli, daha
          derin ve daha surdurulebilir eslesmeler saglamaktadir.
        </p>
      </>
    );
  }

  // English (default fallback)
  return (
    <>
      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Arthur Aron&apos;s 36 Questions Experiment</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        In 1997, social psychologist Arthur Aron and his team conducted a groundbreaking experiment
        investigating the formation of interpersonal closeness. The experiment was simple: two
        strangers asked each other 36 increasingly personal questions, then looked into each
        other&apos;s eyes for 4 minutes. The results astonished the scientific community — a significant
        portion of participants reported feeling a level of closeness comparable to their closest
        relationships in life.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Aron&apos;s 36 questions experiment scientifically proved the power of questions in creating
        intimacy between people. The questions ranged from light topics like &quot;If you could have
        dinner with anyone in the world, who would it be?&quot; to deep subjects like &quot;How do you
        feel about your relationship with your family?&quot; This gradual deepening enabled participants
        to develop trust and open up to each other. This is the scientific foundation of question
        based matching science.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        This experiment forms the scientific basis of question-based matching. Qulo&apos;s question-answer
        mechanism adapts the principle Aron discovered to the digital dating environment. Getting to
        know someone through questions is the most scientifically proven effective method of building
        connections, making 36 questions dating more than just a viral trend — it&apos;s rigorous science.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Self-Disclosure Theory</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Self-disclosure theory is one of the most established theories in social psychology. Proposed
        by Sidney Jourard in 1958, this theory suggests that sharing information about oneself is
        the most important factor determining relationship depth. Relationships deepen through
        reciprocal self-disclosure — as you open up, the other person opens up too.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        In swipe-based dating apps, self-disclosure is virtually zero. A photo and short bio provide
        very limited information about a person. Quiz dating, however, initiates a natural self-
        disclosure process through questions. Answering a question like &quot;What was the bravest thing
        you&apos;ve ever done?&quot; automatically triggers a personal sharing moment. This reciprocal sharing
        forms the foundation of genuine closeness and trust — a core principle in the psychology
        of dating.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Attachment Theory and Dating</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        John Bowlby&apos;s attachment theory explains the foundation of human relationships. Individuals
        with secure attachment styles tend to build healthy, long-lasting relationships. Anxious and
        avoidant attachment styles can lead to relationship problems. Research shows that dating apps
        — especially swipe-based ones — can reinforce anxious attachment patterns.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Constant rejection (not matching on swipes), uncertainty (ghosting after matching), and
        superficiality (appearance-based evaluation) trigger anxious attachment patterns. Quiz dating
        offers a more secure experience: since solving questions is required to match, rejection
        isn&apos;t personalized. There&apos;s a significant psychological difference between &quot;I couldn&apos;t
        solve the questions&quot; and &quot;They didn&apos;t like me.&quot;
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">What Is Cognitive Compatibility?</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Cognitive compatibility refers to the similarity between two people&apos;s thought processes,
        problem-solving approaches, and information processing styles. Research shows that cognitive
        compatibility is a far stronger predictor of long-term relationship success than physical
        attractiveness — a fundamental insight in compatibility science dating.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        According to Dr. Robert Sternberg&apos;s &quot;Triangular Theory of Love,&quot; lasting love consists
        of three components: intimacy, passion, and commitment. Physical attractiveness only
        nourishes the passion component, while cognitive compatibility strengthens both intimacy
        and commitment. Questions directly measure cognitive compatibility: two people who approach
        the same question similarly are very likely cognitively compatible.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Why Physical Attractiveness Is Misleading</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        While physical attractiveness is an evolutionarily important signal, it can be misleading
        in the context of modern dating. Research proves this:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Halo effect:</strong> We automatically attribute positive personality traits to people we find physically attractive — this is often inaccurate</li>
        <li><strong className="text-white">Hedonic adaptation:</strong> People adapt to physical attractiveness within 6-18 months, while personality compatibility becomes more important over time</li>
        <li><strong className="text-white">Photo fallacy:</strong> Research shows that photos misrepresent a person&apos;s actual attractiveness by 20-30%</li>
        <li><strong className="text-white">Long-term satisfaction:</strong> Relationship satisfaction studies show that after 2 years, the correlation between physical attractiveness and relationship quality drops to nearly zero</li>
      </ul>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        These findings reveal the fundamental limitation of photo-based matching. Question-based
        matching transcends this limitation by prioritizing personality, values, and thought compatibility.
      </p>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Qulo&apos;s Scientific Foundation</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Qulo&apos;s question-answer based matching system is the practical application of the scientific
        principles described above:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Aron&apos;s 36 Questions principle:</strong> Getting to know someone through questions creates closeness</li>
        <li><strong className="text-white">Self-disclosure theory:</strong> The Q&amp;A process triggers natural sharing</li>
        <li><strong className="text-white">Cognitive compatibility:</strong> Correct answers indicate similarity in thought patterns</li>
        <li><strong className="text-white">Investment effect:</strong> The effort spent solving questions adds value to the match</li>
        <li><strong className="text-white">Secure attachment:</strong> Performance-based matching reduces the feeling of personal rejection</li>
      </ul>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">How Questions Create Deep Connections</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Neuroscience research shows fascinating things happening in the brain during the question-asking
        and answering process. When contemplating a question, the prefrontal cortex (decision-making and
        thinking region) activates. When giving a personal answer, the limbic system (emotional processing
        region) engages. The simultaneous activation of these two regions is called &quot;cognitive-emotional
        integration&quot; and is the neurological basis of deep connections.
      </p>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Swiping, on the other hand, only activates visual processing areas (occipital lobe) and
        rapid decision mechanisms (amygdala). This is a process similar to the &quot;fight or flight&quot;
        response and is insufficient for building deep connections. Question-based interaction
        enables the brain to operate at full capacity, thereby creating stronger and more lasting bonds.
      </p>

      <h2 className="text-2xl font-bold text-qulo-purple mb-4 mt-10">Practical Tips: Creating Effective Questions</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Based on scientific research, here are the principles for creating effective questions:
      </p>
      <ul className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4">
        <li><strong className="text-white">Prefer open-ended:</strong> Ask questions that provoke thinking rather than yes/no questions</li>
        <li><strong className="text-white">Target values:</strong> Questions that reveal core values, not superficial information about a person</li>
        <li><strong className="text-white">Gradual depth:</strong> Start with light topics and transition to deeper subjects</li>
        <li><strong className="text-white">Use scenarios:</strong> &quot;What would you do in situation X?&quot; questions reveal behavioral patterns</li>
        <li><strong className="text-white">Personal touches:</strong> Add questions that someone who knows you would be able to answer</li>
      </ul>

      <blockquote className="border-l-4 border-qulo-green pl-4 my-8 italic text-qulo-text-secondary">
        &quot;The shortest path to knowing someone is asking them the right question. Science proves it,
        Qulo makes it possible.&quot;
      </blockquote>

      <h2 className="text-2xl font-bold text-qulo-green mb-4 mt-10">Conclusion</h2>
      <p className="text-qulo-text-secondary leading-relaxed mb-4">
        Question-based matching isn&apos;t just an idea — it&apos;s a scientific approach supported by decades
        of psychology and neuroscience research. From Arthur Aron&apos;s 36 Questions experiment to
        self-disclosure theory, from attachment theory to cognitive compatibility research, science
        proves that questions build far stronger connections than photos. Qulo integrates these
        scientific foundations into the modern dating experience, delivering more meaningful, deeper,
        and more sustainable matches.
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
    case "dating-app-burnout-signs":
      return <DatingBurnoutContent locale={locale} />;
    case "dating-apps-without-swiping":
      return <NoSwipeDatingContent locale={locale} />;
    case "quiz-dating-for-introverts":
      return <IntrovertDatingContent locale={locale} />;
    case "science-behind-question-based-matching":
      return <MatchingScienceContent locale={locale} />;
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

      {/* BlogPosting JSON-LD — trusted static constants only.
          BreadcrumbList JSON-LD is rendered by the <Breadcrumb /> component below. */}
      <JsonLd data={blogPostingJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[
              { label: "Blog", href: `/${locale}/blog` },
              { label: title },
            ]}
          />

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
