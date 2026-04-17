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
        q: "Swipe-free dating app'ler yeterli mi?",
        a: "Evet — araştırmalar kullanıcıların %72'sinin 'slow dating' yaklaşımını tercih ettiğini gösteriyor. Swipe-free uygulamalar, yüzeysel eşleşme yerine anlamlı bağlantıya odaklanır.",
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
        q: "Are swipe-free dating apps enough?",
        a: "Yes — research shows that 72% of users prefer the 'slow dating' approach. Swipe-free apps focus on meaningful connections rather than superficial matches.",
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
        q: "Kişilik eşleşmesi nasıl uygulanır?",
        a: "Qulo quiz dating ile kişilik uyumluluğuna odaklanır. Kullanıcı kendi sorularını hazırlar, diğer kullanıcılar bu sorulara verdikleri cevaplarla kişilik uyumunu gösterir.",
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
        q: "How is personality matching implemented?",
        a: "Qulo focuses on personality compatibility through quiz dating. You create your own questions, and others reveal compatibility through the answers they give.",
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
      q: "Qulo'nun farkı nedir?",
      a: "Qulo, soru-cevap tabanlı eşleşme sistemiyle farklılaşır. Yüzeysel tercihlere dayalı swipe veya hazır prompt'lar yerine, kendi sorularınızı hazırlayarak gerçek kişilik uyumunu keşfedersiniz.",
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
      q: "What makes Qulo different?",
      a: "Qulo stands apart with its question-based matching system. Instead of swipes based on surface preferences or pre-written prompts, you create your own questions to discover genuine personality fit.",
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

/** Resolve About-page FAQ items with EN fallback. */
export function getAboutFaqs(locale: string): FAQItem[] {
  return ABOUT_FAQS[locale] || ABOUT_FAQS.en || [];
}
