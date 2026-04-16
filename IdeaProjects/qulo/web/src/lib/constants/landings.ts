export interface LandingPage {
  slug: string;
  primaryKeyword: string;
  titles: Record<string, string>;
  descriptions: Record<string, string>;
  keywords: string[];
}

export const LANDING_PAGES: LandingPage[] = [
  {
    slug: "quiz-dating-app",
    primaryKeyword: "quiz dating app",
    titles: {
      tr: "Quiz Dating App — Sorularla Eşleş | Qulo",
      en: "Quiz Dating App — Match Through Questions | Qulo",
      de: "Quiz Dating App — Matche durch Fragen | Qulo",
      fr: "App de Quiz Dating — Matchez par Questions | Qulo",
      es: "App de Quiz Dating — Haz Match con Preguntas | Qulo",
    },
    descriptions: {
      tr: "Qulo, dünyanın ilk quiz tabanlı dating uygulamasıdır. Swipe yerine sorularla eşleş, anlamlı bağlantılar kur. Ücretsiz indir.",
      en: "Qulo is the world's first quiz-based dating app. Match through questions instead of swiping. Build meaningful connections. Download free.",
      de: "Qulo ist die weltweit erste Quiz-basierte Dating-App. Matche durch Fragen statt Swipen.",
      fr: "Qulo est la première app de dating basée sur les quiz. Matchez par questions au lieu de swiper.",
      es: "Qulo es la primera app de citas basada en quiz. Haz match con preguntas en vez de deslizar.",
    },
    keywords: [
      "quiz dating app",
      "question based dating",
      "quiz dating",
      "soru tabanlı dating",
      "dating quiz app",
    ],
  },
  {
    slug: "dating-without-swiping",
    primaryKeyword: "dating without swiping",
    titles: {
      tr: "Swipe Olmadan Dating — Alternatif Tanışma | Qulo",
      en: "Dating Without Swiping — The Alternative Way to Meet | Qulo",
      de: "Dating ohne Swipen — Die alternative Art sich kennenzulernen | Qulo",
      fr: "Dating sans Swipe — L'alternative pour se rencontrer | Qulo",
      es: "Citas sin Deslizar — La forma alternativa de conocer | Qulo",
    },
    descriptions: {
      tr: "Swipe'dan bıktıysanız Qulo'yu deneyin. Sorularla eşleşin, yüzeysel kaydırmaya son verin. Swipe olmadan dating mümkün.",
      en: "Tired of swiping? Try Qulo. Match through questions, end superficial scrolling. Dating without swiping is possible.",
      de: "Genug vom Swipen? Probieren Sie Qulo. Matchen durch Fragen statt oberflächliches Wischen.",
      fr: "Marre de swiper ? Essayez Qulo. Matchez par questions, fini le défilement superficiel.",
      es: "¿Cansado de deslizar? Prueba Qulo. Haz match con preguntas, adiós al scroll superficial.",
    },
    keywords: [
      "dating without swiping",
      "no swipe dating",
      "swipe olmadan dating",
      "alternative dating app",
      "anti-swipe dating",
    ],
  },
  {
    slug: "personality-matching-app",
    primaryKeyword: "personality matching app",
    titles: {
      tr: "Kişilik Eşleşme Uygulaması — Uyumlu Eşini Bul | Qulo",
      en: "Personality Matching App — Find Your Compatible Match | Qulo",
      de: "Persönlichkeits-Matching-App — Finde dein kompatibles Match | Qulo",
      fr: "App de Matching par Personnalité — Trouvez votre match compatible | Qulo",
      es: "App de Matching por Personalidad — Encuentra tu match compatible | Qulo",
    },
    descriptions: {
      tr: "Qulo, kişilik uyumluluk testleri ile eşleşme yapan dating uygulamasıdır. Görünüş değil, düşünce yapısı önemli.",
      en: "Qulo is a dating app that matches based on personality compatibility. Looks don't matter, mindset does.",
      de: "Qulo ist eine Dating-App, die auf Persönlichkeitskompatibilität basiert.",
      fr: "Qulo est une app de dating qui matche sur la compatibilité de personnalité.",
      es: "Qulo es una app de citas que hace match basándose en la compatibilidad de personalidad.",
    },
    keywords: [
      "personality matching app",
      "compatibility dating",
      "personality dating app",
      "kişilik eşleşme",
      "uyumluluk testi dating",
    ],
  },
];
