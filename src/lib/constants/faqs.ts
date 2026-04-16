import type { FAQItem } from "@/components/shared/FAQ";

/**
 * Page-specific FAQ data per slug + locale.
 *
 * Source: Server-side static constants (i18n strings). Used by FAQ component
 * which emits FAQPage JSON-LD for Google rich snippets.
 *
 * Locale fallback: Each lookup falls back to `en` if the requested locale is
 * not present.
 */

export type FAQLocaleMap = Record<string, FAQItem[]>;

/* ------------------------------------------------------------------ */
/*  /features/[slug] FAQs                                              */
/* ------------------------------------------------------------------ */
export const FEATURE_FAQS: Record<string, FAQLocaleMap> = {
  "quiz-dating-app": {
    tr: [
      {
        q: "Quiz dating app nasıl çalışır?",
        a: "Quiz dating app'te kullanıcılar 2-10 soru hazırlar, diğer kullanıcılar bu soruları çözer ve tüm soruları doğru cevaplayanla eşleşme gerçekleşir. Qulo, bu kategorinin dünyadaki ilk örneklerinden biridir.",
      },
      {
        q: "Quiz dating geleneksel swipe'tan daha mı iyi?",
        a: "Araştırmalar swipe eşleşmelerinin sadece %2-5'inin gerçek buluşmalara dönüştüğünü gösteriyor. Quiz dating'de efor gerektiren eşleşme sayesinde bağlantılar daha derin ve kaliteli olur.",
      },
      {
        q: "Qulo quiz dating app ücretsiz mi?",
        a: "Evet, Qulo temel özellikleri ücretsizdir. Plus ve Premium abonelik seçenekleri ek özellikler sunar.",
      },
      {
        q: "Soruları kim hazırlar?",
        a: "Siz kendi sorularınızı hazırlarsınız. Qulo'nun AI destekli soru önerme sistemi de yardımcı olabilir.",
      },
      {
        q: "Quiz dating'de güvenlik nasıl?",
        a: "Qulo'nun efor gerektiren eşleşme sistemi sahte profilleri doğal olarak filtreler. Profil doğrulama, engelleme ve raporlama özellikleri de mevcuttur.",
      },
    ],
    en: [
      {
        q: "How does a quiz dating app work?",
        a: "On a quiz dating app, users create 2-10 questions; other users solve these questions and matching happens only when someone answers them all correctly. Qulo is one of the world's first examples of this category.",
      },
      {
        q: "Is quiz dating better than traditional swiping?",
        a: "Research shows that only 2-5% of swipe matches lead to real-life meetings. With quiz dating, effort-based matching produces deeper, higher-quality connections.",
      },
      {
        q: "Is the Qulo quiz dating app free?",
        a: "Yes, Qulo's core features are free. Plus and Premium subscription tiers offer additional features.",
      },
      {
        q: "Who creates the questions?",
        a: "You create your own questions. Qulo's AI-powered question suggestions can help you craft them.",
      },
      {
        q: "How safe is quiz dating?",
        a: "Qulo's effort-based matching naturally filters out fake profiles. Profile verification, blocking, and reporting features are also available.",
      },
    ],
  },
  "dating-without-swiping": {
    tr: [
      {
        q: "Swipe olmadan dating nasıl olur?",
        a: "Swipe olmadan dating, soru-cevap veya AI eşleşme gibi farklı mekanikler kullanır. Qulo, kullanıcıların sorular aracılığıyla birbirini tanımasını sağlar — swipe'a hiç ihtiyaç yok.",
      },
      {
        q: "Swipe tabanlı olmayan dating app hangileri?",
        a: "Qulo quiz-based, Slowly mektup-based gibi alternatifler vardır. Qulo en kapsamlı soru-cevap sistemini sunar.",
      },
      {
        q: "Swipe yorgunluğu gerçek mi?",
        a: "Evet, araştırmalar kullanıcıların %78'inin dating app'lerden tükenmişlik yaşadığını gösteriyor. Sürekli karar verme zorunluluğu zihinsel yorgunluğa yol açar.",
      },
      {
        q: "Swipe olmadan nasıl eşleşilir?",
        a: "Qulo'da sorularınızı çözen kişiyle eşleşirsiniz. Bu süreç swipe'tan daha anlamlı ve tatmin edicidir.",
      },
      {
        q: "Swipe-free dating app'ler daha az kullanıcıya mı sahip?",
        a: "Tinder gibi dev uygulamalara göre daha küçükler ama hızla büyüyorlar. Kullanıcıların %72'si 'slow dating' yaklaşımını tercih ettiğini belirtiyor.",
      },
    ],
    en: [
      {
        q: "How does dating without swiping work?",
        a: "Dating without swiping uses different mechanics such as Q&A or AI matching. Qulo lets users get to know each other through questions — no swiping needed.",
      },
      {
        q: "Which dating apps are not swipe-based?",
        a: "Alternatives include Qulo (quiz-based) and Slowly (letter-based). Qulo offers the most comprehensive Q&A system.",
      },
      {
        q: "Is swipe fatigue a real thing?",
        a: "Yes — research shows that 78% of users experience burnout from dating apps. The constant need to make decisions leads to mental exhaustion.",
      },
      {
        q: "How do you match without swiping?",
        a: "On Qulo, you match with whoever solves your questions. This process is more meaningful and satisfying than swiping.",
      },
      {
        q: "Do swipe-free dating apps have fewer users?",
        a: "They are smaller than giants like Tinder but growing rapidly. 72% of users say they prefer the 'slow dating' approach.",
      },
    ],
  },
  "personality-matching-app": {
    tr: [
      {
        q: "Kişilik eşleşmesi nasıl çalışır?",
        a: "Kişilik eşleşmesi, kullanıcıların değerleri, yaşam tarzı ve düşünce biçimindeki uyumluluğu ölçer. Qulo bunu sorular aracılığıyla gerçekleştirir — sorularınıza verilen cevaplar kişilik uyumunuzu gösterir.",
      },
      {
        q: "Kişilik testleri gerçekten işe yarar mı?",
        a: "Kişilik uyumluluğu başarılı ilişkilerin 5 temel faktöründen biri. Arthur Aron'un 36 Soru deneyi gibi bilimsel çalışmalar, soruların derin bağlantı kurduğunu kanıtlıyor.",
      },
      {
        q: "Kişilik eşleşme app'leri hangileri?",
        a: "Qulo quiz dating ile kişilik uyumluluğuna odaklanır. eHarmony, OkCupid gibi app'ler de kişilik testi kullanır ama Qulo kullanıcının kendi sorularını hazırlamasına izin verir.",
      },
      {
        q: "Kişilik eşleşmesi görünüşten daha mı önemli?",
        a: "Uzun vadeli ilişkiler için evet. Araştırmalar, kişilik uyumlu çiftlerin daha mutlu ve daha uzun süreli ilişkiler kurduğunu gösteriyor.",
      },
      {
        q: "Qulo kişilik testi yapıyor mu?",
        a: "Qulo geleneksel kişilik testi yerine kendi sorularınızla kendi testinizi oluşturmanıza olanak tanır. Bu daha kişiselleştirilmiş ve etkili.",
      },
    ],
    en: [
      {
        q: "How does personality matching work?",
        a: "Personality matching measures alignment in users' values, lifestyle, and mindset. Qulo achieves this through questions — the answers to your questions reveal personality compatibility.",
      },
      {
        q: "Do personality tests really work?",
        a: "Personality compatibility is one of the 5 core factors of successful relationships. Scientific studies like Arthur Aron's 36 Questions experiment prove that questions can build deep connection.",
      },
      {
        q: "Which apps offer personality matching?",
        a: "Qulo focuses on personality compatibility through quiz dating. Apps like eHarmony and OkCupid also use personality tests, but Qulo lets you create your own questions.",
      },
      {
        q: "Is personality matching more important than looks?",
        a: "For long-term relationships, yes. Research shows that personality-compatible couples have happier, longer-lasting relationships.",
      },
      {
        q: "Does Qulo do a personality test?",
        a: "Instead of a traditional personality test, Qulo lets you build your own test through your own questions. This is more personalized and effective.",
      },
    ],
  },
};

/* ------------------------------------------------------------------ */
/*  /compare/[slug] FAQs                                               */
/* ------------------------------------------------------------------ */
export const COMPARE_FAQS: Record<string, FAQLocaleMap> = {
  "qulo-vs-tinder": {
    tr: [
      {
        q: "Qulo Tinder'dan daha mı iyi?",
        a: "Qulo ve Tinder farklı ihtiyaçlara hizmet ediyor. Qulo derin bağlantı ararken, Tinder hızlı/geniş havuz için uygun. Swipe yorgunluğu yaşıyorsanız Qulo daha iyi bir seçenek.",
      },
      {
        q: "Qulo Tinder'ın yerini alabilir mi?",
        a: "Qulo ciddi bağlantılar arayan kullanıcılar için Tinder'ın çok daha derin bir alternatifidir. Kullanıcılar her iki platformu birlikte kullanabilir.",
      },
      {
        q: "Tinder'daki ghosting Qulo'da da var mı?",
        a: "Hayır, Qulo'da efor gerektiren eşleşme sistemi ghosting oranını önemli ölçüde azaltır. Tinder'da %80+ olan ghosting oranı Qulo'da çok daha düşüktür.",
      },
      {
        q: "Hangi app daha ucuz — Qulo mu Tinder mı?",
        a: "Qulo'nun temel özellikleri ücretsizdir ve Premium fiyatlandırması Tinder'dan daha uygun. Her iki platformun da ücretsiz + premium seçenekleri var.",
      },
      {
        q: "Tinder'dan Qulo'ya nasıl geçilir?",
        a: "Qulo'yu uygulama mağazasından indirip kayıt olabilirsiniz. İlk sorularınızı hazırlayarak eşleşmeye başlayın — swipe deneyiminden farklı olarak, ilk günden anlamlı bağlantılar kurarsınız.",
      },
    ],
    en: [
      {
        q: "Is Qulo better than Tinder?",
        a: "Qulo and Tinder serve different needs. Qulo is built for deep connection, Tinder for fast/wide reach. If you're feeling swipe fatigue, Qulo is the better choice.",
      },
      {
        q: "Can Qulo replace Tinder?",
        a: "For users seeking serious connections, Qulo is a far deeper alternative to Tinder. Many people use both platforms together.",
      },
      {
        q: "Does ghosting on Tinder also happen on Qulo?",
        a: "No — Qulo's effort-based matching system significantly reduces ghosting. While ghosting rates exceed 80% on Tinder, they are much lower on Qulo.",
      },
      {
        q: "Which app is cheaper — Qulo or Tinder?",
        a: "Qulo's core features are free and its Premium pricing is more affordable than Tinder. Both platforms offer free + premium tiers.",
      },
      {
        q: "How do you switch from Tinder to Qulo?",
        a: "Download Qulo from your app store and sign up. Start matching by creating your first questions — unlike swiping, you build meaningful connections from day one.",
      },
    ],
  },
  "qulo-vs-bumble": {
    tr: [
      {
        q: "Qulo Bumble'dan daha mı iyi?",
        a: "Qulo, dating'e tamamen odaklanmış quiz tabanlı bir deneyim sunar. Bumble kadın-öncelikli kuralı ve çoklu modlarıyla farklılaşır. Soru-cevap ile derin uyumluluk arayanlar için Qulo daha uygundur.",
      },
      {
        q: "Bumble kadın-öncelikli, Qulo nedir?",
        a: "Qulo'da cinsiyet fark etmeksizin herkes eşit şansa sahiptir. Önemli olan sorulara verilen cevaplar — kim hangi soruyu doğru cevaplar, eşleşme öyle gerçekleşir.",
      },
      {
        q: "Qulo'da ilk adım kim atar?",
        a: "Qulo'da ilk adım, sorularınızı çözerek eşleşmeye giden kişiler tarafından atılır. Cinsiyet kuralı yok — uyumluluk kanıtlanınca her iki taraf da sohbete başlayabilir.",
      },
      {
        q: "Bumble BFF ve Bizz gibi modları Qulo'da var mı?",
        a: "Hayır, Qulo dating'e odaklanır. BFF veya Bizz gibi ek modlar yerine, dating deneyiminin derinliğine ve kalitesine yatırım yaparız.",
      },
      {
        q: "Qulo uluslararası mı?",
        a: "Evet, Qulo 16 dil destekler ve dünya çapında kullanılabilir. Türkçe, İngilizce, Almanca, Fransızca, İspanyolca, Arapça, Rusça ve daha fazlası dahil.",
      },
    ],
    en: [
      {
        q: "Is Qulo better than Bumble?",
        a: "Qulo offers a quiz-based experience focused entirely on dating. Bumble differentiates with its women-first rule and multiple modes. For people seeking deep compatibility through Q&A, Qulo is the better fit.",
      },
      {
        q: "Bumble is women-first — what about Qulo?",
        a: "On Qulo, everyone has equal chances regardless of gender. What matters is the answers — matching happens whenever someone answers the questions correctly.",
      },
      {
        q: "Who makes the first move on Qulo?",
        a: "The first move is made by whoever solves your questions to reach a match. No gender rule — once compatibility is proven, either side can start the conversation.",
      },
      {
        q: "Does Qulo have modes like Bumble BFF and Bizz?",
        a: "No — Qulo focuses on dating. Instead of extra modes like BFF or Bizz, we invest in the depth and quality of the dating experience itself.",
      },
      {
        q: "Is Qulo international?",
        a: "Yes — Qulo supports 16 languages and is available worldwide, including Turkish, English, German, French, Spanish, Arabic, Russian and more.",
      },
    ],
  },
  "qulo-vs-hinge": {
    tr: [
      {
        q: "Qulo Hinge'den daha mı iyi?",
        a: "Hinge prompt tabanlı profillerle ciddi ilişki arayanlar için güçlü bir tercih. Qulo ise pasif begeni yerine aktif soru çözme ile uyumluluğu kanıtlar — daha güçlü bir filtreleme.",
      },
      {
        q: "Hinge 'designed to be deleted' diyor — Qulo ne diyor?",
        a: "Qulo, sorularla anlamlı bağlantılar kurmaya odaklanır. Amacımız kullanıcının doğru kişiyle gerçek bir ilişki kurması — hızlı sayıdan çok bağlantı kalitesi önemli.",
      },
      {
        q: "Hinge prompt'lar, Qulo sorular — fark nedir?",
        a: "Hinge prompt'larda kullanıcı kendi cevabını yazar ve karşı taraf bu cevaba 'like' gönderir (pasif beğeni). Qulo'da ise karşı taraf sorularınızı çözerek uyumluluğunu aktif olarak kanıtlar.",
      },
      {
        q: "Qulo ciddi ilişkiler için uygun mu?",
        a: "Evet, Qulo'nun efor gerektiren eşleşme sistemi yüzeysel etkileşimi azaltır ve ciddi ilişki arayanları doğal olarak filtreler. 25K+ kullanıcımızın çoğu uzun vadeli bağlantı arıyor.",
      },
      {
        q: "Hinge ücreti Qulo'dan pahalı mı?",
        a: "Hinge'in premium planları (HingeX, Hinge+) Qulo'dan daha pahalı olabiliyor. Qulo, ücretsiz katmanda da daha cömert günlük limitler sunar.",
      },
    ],
    en: [
      {
        q: "Is Qulo better than Hinge?",
        a: "Hinge is a strong choice for those seeking serious relationships through prompt-based profiles. Qulo proves compatibility with active question solving instead of passive likes — a stronger filter.",
      },
      {
        q: "Hinge says 'designed to be deleted' — what does Qulo say?",
        a: "Qulo focuses on building meaningful connections through questions. Our goal is for users to find a real relationship with the right person — connection quality matters more than quick numbers.",
      },
      {
        q: "Hinge has prompts, Qulo has questions — what's the difference?",
        a: "On Hinge, users write answers to prompts and others send a 'like' on that answer (passive). On Qulo, the other person actively proves compatibility by solving your questions.",
      },
      {
        q: "Is Qulo suitable for serious relationships?",
        a: "Yes — Qulo's effort-based matching reduces superficial interaction and naturally filters for people seeking serious connections. Most of our 25K+ users are looking for long-term bonds.",
      },
      {
        q: "Is Hinge more expensive than Qulo?",
        a: "Hinge's premium tiers (HingeX, Hinge+) can be pricier than Qulo. Qulo also offers more generous daily limits on its free tier.",
      },
    ],
  },
};

/* ------------------------------------------------------------------ */
/*  /about FAQs                                                        */
/* ------------------------------------------------------------------ */
export const ABOUT_FAQS: FAQLocaleMap = {
  tr: [
    {
      q: "Qulo nedir?",
      a: "Qulo, swipe yerine soru-cevap sistemi kullanan yeni nesil dating uygulamasıdır. Kullanıcılar 2-10 soru hazırlar, doğru cevaplayanla eşleşir.",
    },
    {
      q: "Qulo hangi ülkelerde kullanılıyor?",
      a: "Qulo dünya çapında kullanılabilir ve 16 dil destekler: Türkçe, İngilizce, Almanca, Fransızca, İspanyolca, Arapça, Rusça ve daha fazlası.",
    },
    {
      q: "Qulo'yu kim kurdu?",
      a: "Qulo, dating sektöründe tecrübeli girişimciler tarafından İstanbul'da kuruldu. Amacımız swipe yorgunluğuna derin bağlantılarla çözüm sunmak.",
    },
    {
      q: "Qulo ne zaman kuruldu?",
      a: "Qulo 2026'da kuruldu ve hızla uluslararası bir dating platformuna dönüştü.",
    },
    {
      q: "Qulo'nun rakiplerden farkı nedir?",
      a: "Qulo, soru-cevap tabanlı eşleşme sistemiyle tek başına öncü. Tinder/Bumble/Hinge swipe veya prompt kullanırken, Qulo kendi sorularınızı hazırlamanıza izin verir.",
    },
  ],
  en: [
    {
      q: "What is Qulo?",
      a: "Qulo is a next-generation dating app that uses a Q&A system instead of swiping. Users create 2-10 questions and match with whoever answers them correctly.",
    },
    {
      q: "In which countries is Qulo available?",
      a: "Qulo is available worldwide and supports 16 languages: Turkish, English, German, French, Spanish, Arabic, Russian and more.",
    },
    {
      q: "Who founded Qulo?",
      a: "Qulo was founded in Istanbul by entrepreneurs experienced in the dating industry. Our goal is to solve swipe fatigue through deep connections.",
    },
    {
      q: "When was Qulo founded?",
      a: "Qulo was founded in 2026 and quickly grew into an international dating platform.",
    },
    {
      q: "What makes Qulo different from competitors?",
      a: "Qulo is a pioneer with its question-based matching system. While Tinder/Bumble/Hinge use swipes or prompts, Qulo lets you create your own questions.",
    },
  ],
};

/**
 * Resolve FAQ items for a slug + locale with EN fallback.
 * Returns empty array if the slug is unknown.
 */
export function getFeatureFaqs(slug: string, locale: string): FAQItem[] {
  const map = FEATURE_FAQS[slug];
  if (!map) return [];
  return map[locale] || map.en || [];
}

/** Resolve compare-page FAQ items with EN fallback. */
export function getCompareFaqs(slug: string, locale: string): FAQItem[] {
  const map = COMPARE_FAQS[slug];
  if (!map) return [];
  return map[locale] || map.en || [];
}

/** Resolve About-page FAQ items with EN fallback. */
export function getAboutFaqs(locale: string): FAQItem[] {
  return ABOUT_FAQS[locale] || ABOUT_FAQS.en || [];
}
