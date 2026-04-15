export interface BlogPost {
  slug: string;
  publishedAt: string;
  readingTime: number;
  titles: Record<string, string>;
  excerpts: Record<string, string>;
  keywords: string[];
}

export const BLOG_POSTS: BlogPost[] = [
  {
    slug: "what-is-swipe-fatigue",
    publishedAt: "2026-04-10",
    readingTime: 5,
    titles: {
      tr: "Swipe Yorgunluğu Nedir ve Neden Herkes Bundan Şikayetçi?",
      en: "What is Swipe Fatigue and Why is Everyone Tired of It?",
      de: "Was ist Swipe-Müdigkeit und warum hat jeder genug davon?",
      fr: "Qu'est-ce que la fatigue du swipe et pourquoi tout le monde en a marre ?",
      es: "¿Qué es el cansancio del swipe y por qué todos están hartos?",
    },
    excerpts: {
      tr: "Dating uygulamalarında sürekli sola-sağa kaydırma yorgunluğu yaşıyorsanız yalnız değilsiniz. Swipe yorgunluğu nedir, neden oluşur ve Qulo bu sorunu nasıl çözer?",
      en: "If you're tired of endlessly swiping left and right on dating apps, you're not alone. What is swipe fatigue, why does it happen, and how does Qulo solve it?",
      de: "Wenn Sie es leid sind, endlos auf Dating-Apps zu wischen, sind Sie nicht allein.",
      fr: "Si vous en avez marre de swiper sans fin sur les apps de rencontre, vous n'êtes pas seul.",
      es: "Si estás cansado de deslizar sin fin en las apps de citas, no estás solo.",
    },
    keywords: ["swipe fatigue", "dating app burnout", "swipe yorgunluğu", "dating app tükenmişlik"],
  },
  {
    slug: "quiz-dating-future-of-matching",
    publishedAt: "2026-04-12",
    readingTime: 6,
    titles: {
      tr: "Quiz Dating: Eşleşmenin Geleceği Sorularda mı?",
      en: "Quiz Dating: Is the Future of Matching in Questions?",
      de: "Quiz-Dating: Liegt die Zukunft des Matchings in Fragen?",
      fr: "Quiz Dating : L'avenir du matching repose-t-il sur les questions ?",
      es: "Quiz Dating: ¿El futuro del matching está en las preguntas?",
    },
    excerpts: {
      tr: "Swipe tabanlı eşleşmeler yüzeysel kalırken, soru-cevap tabanlı dating yeni bir trend olarak yükseliyor. Quiz dating nedir ve neden daha derin bağlantılar kurmanızı sağlar?",
      en: "While swipe-based matching remains superficial, question-based dating is rising as a new trend. What is quiz dating and why does it lead to deeper connections?",
      de: "Während Swipe-basiertes Matching oberflächlich bleibt, steigt fragenbasiertes Dating als neuer Trend auf.",
      fr: "Tandis que le matching basé sur le swipe reste superficiel, le dating par questions monte en tant que nouvelle tendance.",
      es: "Mientras que el matching basado en swipe sigue siendo superficial, las citas basadas en preguntas surgen como nueva tendencia.",
    },
    keywords: ["quiz dating", "question based dating", "soru cevap dating", "quiz dating app"],
  },
  {
    slug: "online-dating-safety-tips",
    publishedAt: "2026-04-14",
    readingTime: 7,
    titles: {
      tr: "Online Dating Güvenlik Rehberi: 10 Altın Kural",
      en: "Online Dating Safety Guide: 10 Golden Rules",
      de: "Online-Dating-Sicherheitsratgeber: 10 goldene Regeln",
      fr: "Guide de sécurité du dating en ligne : 10 règles d'or",
      es: "Guía de seguridad en citas online: 10 reglas de oro",
    },
    excerpts: {
      tr: "Online tanışma güvenli olabilir — doğru adımları atarsanız. İşte dating uygulamalarında kendinizi korumanız için bilmeniz gereken 10 altın kural.",
      en: "Online dating can be safe — if you take the right steps. Here are 10 golden rules you need to know to protect yourself on dating apps.",
      de: "Online-Dating kann sicher sein — wenn Sie die richtigen Schritte unternehmen.",
      fr: "Les rencontres en ligne peuvent être sûres — si vous prenez les bonnes mesures.",
      es: "Las citas en línea pueden ser seguras — si tomas las medidas correctas.",
    },
    keywords: ["online dating safety", "dating app security", "online dating güvenlik", "dating güvenli mi"],
  },
];
