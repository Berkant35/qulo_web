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
import { BLOG_POSTS } from "@/lib/constants/blog";
import { ArticleBlocks, type LocalizedArticle } from "@/components/blog/ArticleBlocks";
import { JsonLd } from "@/components/shared/JsonLd";
import { whatActuallyPredictsCompatibility } from "./_content/what-actually-predicts-compatibility";
import { psychologyOfTheFirstMessage } from "./_content/psychology-of-the-first-message";
import { theQuestionDeficit } from "./_content/the-question-deficit";
import { datingAppsWithoutSwiping } from "./_content/dating-apps-without-swiping";
import { whatIsSwipeFatigue } from "./_content/what-is-swipe-fatigue";
import { quizDatingFutureOfMatching } from "./_content/quiz-dating-future-of-matching";
import { onlineDatingSafetyTips } from "./_content/online-dating-safety-tips";
import { quizDatingForIntroverts } from "./_content/quiz-dating-for-introverts";
import { datingAppBurnoutSigns } from "./_content/dating-app-burnout-signs";

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
      // Post cover when it has one, site-wide OG image otherwise.
      images: ogImages(post.coverImage, title),
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: ogImages(post.coverImage, title),
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
const READ_LABELS: Record<string, { readTime: string; backToBlog: string; relatedPosts: string }> = {
  tr: { readTime: "dk okuma", backToBlog: "Blog'a Dön", relatedPosts: "Diğer Yazılar" },
  en: { readTime: "min read", backToBlog: "Back to Blog", relatedPosts: "Related Posts" },
  de: { readTime: "Min. Lesezeit", backToBlog: "Zurück zum Blog", relatedPosts: "Weitere Artikel" },
  fr: { readTime: "min de lecture", backToBlog: "Retour au Blog", relatedPosts: "Articles connexes" },
  es: { readTime: "min de lectura", backToBlog: "Volver al Blog", relatedPosts: "Artículos relacionados" },
  ar: { readTime: "دقيقة قراءة", backToBlog: "العودة إلى المدونة", relatedPosts: "مقالات ذات صلة" },
  ru: { readTime: "мин чтения", backToBlog: "Назад в блог", relatedPosts: "Похожие статьи" },
  pt: { readTime: "min de leitura", backToBlog: "Voltar ao Blog", relatedPosts: "Artigos relacionados" },
  it: { readTime: "min di lettura", backToBlog: "Torna al Blog", relatedPosts: "Articoli correlati" },
  ja: { readTime: "分で読めます", backToBlog: "ブログへ戻る", relatedPosts: "関連記事" },
  ko: { readTime: "분 분량", backToBlog: "블로그로 돌아가기", relatedPosts: "관련 글" },
  zh: { readTime: "分钟阅读", backToBlog: "返回博客", relatedPosts: "相关文章" },
  nl: { readTime: "min leestijd", backToBlog: "Terug naar blog", relatedPosts: "Gerelateerde artikelen" },
  pl: { readTime: "min czytania", backToBlog: "Powrót do bloga", relatedPosts: "Powiązane artykuły" },
  sv: { readTime: "min läsning", backToBlog: "Tillbaka till bloggen", relatedPosts: "Relaterade artiklar" },
  hi: { readTime: "मिनट पढ़ें", backToBlog: "ब्लॉग पर वापस", relatedPosts: "संबंधित लेख" },
};

/* ------------------------------------------------------------------ */
/*  Legacy article content components (per-locale JSX, tr + en only)   */
/* ------------------------------------------------------------------ */

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

/**
 * Posts authored as structured data, fully translated into all 16 locales.
 * New posts go here; the switch below is the legacy per-locale JSX pattern kept
 * for the 3 posts still written before `ArticleBlocks` existed.
 */
const STRUCTURED_ARTICLES: Record<string, LocalizedArticle> = {
  "what-actually-predicts-compatibility": whatActuallyPredictsCompatibility,
  "psychology-of-the-first-message": psychologyOfTheFirstMessage,
  "the-question-deficit": theQuestionDeficit,
  "dating-apps-without-swiping": datingAppsWithoutSwiping,
  "what-is-swipe-fatigue": whatIsSwipeFatigue,
  "quiz-dating-future-of-matching": quizDatingFutureOfMatching,
  "online-dating-safety-tips": onlineDatingSafetyTips,
  "quiz-dating-for-introverts": quizDatingForIntroverts,
  "dating-app-burnout-signs": datingAppBurnoutSigns,
};

/** Word count of a structured article, or undefined for legacy JSX posts. */
function structuredWordCount(slug: string, locale: string): number | undefined {
  const blocks = STRUCTURED_ARTICLES[slug]?.[locale] ?? STRUCTURED_ARTICLES[slug]?.en;
  if (!blocks) return undefined;

  return blocks.reduce((total, block) => {
    const text = block.type === "ul" ? block.items.join(" ") : block.text;
    return total + text.split(/\s+/).filter(Boolean).length;
  }, 0);
}

function BlogContent({ slug, locale }: { slug: string; locale: string }) {
  const article = STRUCTURED_ARTICLES[slug];
  if (article) {
    return <ArticleBlocks blocks={article[locale] || article.en} />;
  }

  switch (slug) {
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
  const wordCount = structuredWordCount(slug, locale);

  // BlogPosting JSON-LD
  const blogPostingJsonLd = {
    "@context": "https://schema.org",
    "@type": "BlogPosting",
    headline: title,
    description: excerpt,
    datePublished: post.publishedAt,
    dateModified: post.updatedAt ?? post.publishedAt,
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
    // Omitted rather than guessed for legacy JSX posts whose body isn't data.
    ...(wordCount ? { wordCount } : {}),
    inLanguage: locale,
    ...(post.coverImage ? { image: `${SITE_URL}${post.coverImage}` } : {}),
    ...(post.citations && post.citations.length > 0
      ? {
          citation: post.citations.map((c) => ({
            "@type": "CreativeWork",
            name: c.title,
            url: c.url,
          })),
        }
      : {}),
  };

  const REFERENCE_LABELS: Record<string, string> = {
    tr: "Kaynakça", en: "References", de: "Quellen", fr: "Références", es: "Referencias",
    ar: "المراجع", ru: "Источники", pt: "Referências", it: "Riferimenti", ja: "参考文献",
    ko: "참고 문헌", zh: "参考文献", nl: "Bronnen", pl: "Źródła", sv: "Källor", hi: "संदर्भ",
  };
  const referencesLabel = REFERENCE_LABELS[locale] || REFERENCE_LABELS.en;

  const CTA_LABELS: Record<string, { ctaTitle: string; ctaDesc: string }> = {
    tr: { ctaTitle: "Qulo'yu İndir", ctaDesc: "Sorularla tanışmanın yeni yolunu keşfet. Hemen dene, ücretsiz!" },
    en: { ctaTitle: "Download Qulo", ctaDesc: "Discover the new way to meet through questions. Try it now, for free!" },
    de: { ctaTitle: "Qulo herunterladen", ctaDesc: "Entdecken Sie den neuen Weg, sich durch Fragen kennenzulernen." },
    fr: { ctaTitle: "Télécharger Qulo", ctaDesc: "Découvrez la nouvelle façon de se rencontrer par les questions." },
    es: { ctaTitle: "Descargar Qulo", ctaDesc: "Descubre la nueva forma de conocerse a través de preguntas." },
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

          {/* References — rendered from trusted static blog.ts constants only */}
          {post.citations && post.citations.length > 0 && (
            <section className="mt-14 pt-8 border-t border-white/[0.08]">
              <h2 className="text-xl font-bold text-white mb-5">{referencesLabel}</h2>
              <ol className="list-decimal list-inside space-y-3 text-sm text-qulo-text-secondary">
                {post.citations.map((c) => (
                  <li key={c.url}>
                    <a
                      href={c.url}
                      target="_blank"
                      rel="noopener noreferrer nofollow"
                      className="text-qulo-purple hover:underline"
                    >
                      {c.title}
                    </a>
                    <span className="text-qulo-text-secondary/70"> — {c.source}</span>
                  </li>
                ))}
              </ol>
            </section>
          )}

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
