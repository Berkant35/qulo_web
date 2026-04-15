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
  {
    slug: "dating-app-burnout-signs",
    publishedAt: "2026-04-15",
    readingTime: 5,
    titles: {
      tr: "Dating Uygulama Tükenmişliğinin 5 Belirtisi (Ve Ne Yapmalısınız)",
      en: "5 Signs You Have Dating App Burnout (And What to Do About It)",
      de: "5 Anzeichen für Dating-App-Burnout (Und was Sie dagegen tun können)",
      fr: "5 signes de burnout des apps de rencontre (Et que faire)",
      es: "5 señales de agotamiento por apps de citas (Y qué hacer al respecto)",
    },
    excerpts: {
      tr: "Dating uygulamalarından tükenmişlik mi hissediyorsunuz? İşte dating app burnout'un 5 belirtisi ve bu döngüden çıkmanın yolları.",
      en: "Feeling burned out from dating apps? Here are 5 signs of dating app burnout and ways to break free from the cycle.",
      de: "Fühlen Sie sich von Dating-Apps ausgebrannt? Hier sind 5 Anzeichen und Wege aus dem Kreislauf.",
      fr: "Vous vous sentez épuisé par les apps de rencontre ? Voici 5 signes et comment en sortir.",
      es: "¿Te sientes agotado por las apps de citas? Aquí hay 5 señales y cómo romper el ciclo.",
    },
    keywords: ["dating app burnout", "dating app tükenmişlik", "tired of dating apps", "dating app fatigue", "dating burnout signs"],
  },
  {
    slug: "dating-apps-without-swiping",
    publishedAt: "2026-04-16",
    readingTime: 8,
    titles: {
      tr: "Swipe Olmadan Dating: 2026 Tam Rehberi",
      en: "Dating Apps Without Swiping: A Complete Guide for 2026",
      de: "Dating-Apps ohne Swipen: Ein vollständiger Leitfaden für 2026",
      fr: "Apps de rencontre sans swipe : Guide complet 2026",
      es: "Apps de citas sin deslizar: Guía completa 2026",
    },
    excerpts: {
      tr: "Swipe mekanizmasından bıktıysanız alternatifiniz var. Soru tabanlı, yapay zeka destekli ve etkileşim odaklı dating uygulamalarının tam rehberi.",
      en: "Tired of the swipe mechanic? You have alternatives. A complete guide to question-based, AI-powered, and interaction-focused dating apps.",
      de: "Genug vom Wischen? Es gibt Alternativen. Ein Leitfaden zu fragenbasierten Dating-Apps.",
      fr: "Marre de swiper ? Vous avez des alternatives. Guide des apps de rencontre basées sur les questions.",
      es: "¿Cansado de deslizar? Tienes alternativas. Guía de apps de citas basadas en preguntas.",
    },
    keywords: ["dating app without swiping", "no swipe dating app", "alternative dating apps", "swipe olmadan dating", "dating apps 2026"],
  },
  {
    slug: "quiz-dating-for-introverts",
    publishedAt: "2026-04-16",
    readingTime: 6,
    titles: {
      tr: "İçe Dönükler İçin Quiz Dating: Neden Mükemmel Bir Eşleşme?",
      en: "Why Introverts Are Choosing Quiz Dating Apps Over Tinder",
      de: "Warum Introvertierte Quiz-Dating-Apps Tinder vorziehen",
      fr: "Pourquoi les introvertis préfèrent le quiz dating à Tinder",
      es: "Por qué los introvertidos eligen apps de quiz dating sobre Tinder",
    },
    excerpts: {
      tr: "İçe dönük biri olarak dating uygulamaları sizi bunaltıyor mu? Quiz dating'in neden içe dönükler için ideal olduğunu ve Qulo'nun nasıl fark yarattığını keşfedin.",
      en: "Do dating apps overwhelm you as an introvert? Discover why quiz dating is ideal for introverts and how Qulo makes a difference.",
      de: "Überfordern Dating-Apps Sie als Introvertierte? Entdecken Sie, warum Quiz-Dating ideal ist.",
      fr: "Les apps de rencontre vous submergent en tant qu'introverti ? Découvrez le quiz dating.",
      es: "¿Las apps de citas te abruman como introvertido? Descubre el quiz dating.",
    },
    keywords: ["dating app for introverts", "introvert dating", "quiz dating introverts", "içe dönükler için dating", "best dating app introverts"],
  },
  {
    slug: "science-behind-question-based-matching",
    publishedAt: "2026-04-16",
    readingTime: 7,
    titles: {
      tr: "Soru Tabanlı Eşleşmenin Arkasındaki Bilim: Neden Sorular Fotoğraflardan Daha İyi?",
      en: "The Science Behind Question-Based Matching: Why Questions Beat Photos",
      de: "Die Wissenschaft hinter fragenbasiertem Matching: Warum Fragen besser sind als Fotos",
      fr: "La science du matching par questions : Pourquoi les questions battent les photos",
      es: "La ciencia detrás del matching por preguntas: Por qué las preguntas ganan a las fotos",
    },
    excerpts: {
      tr: "Psikoloji araştırmaları, soruların yüzeysel çekicilikten çok daha güçlü bağlantılar kurduğunu kanıtlıyor. İşte soru tabanlı eşleşmenin bilimsel temelleri.",
      en: "Psychology research proves that questions build much stronger connections than superficial attraction. Here's the scientific foundation of question-based matching.",
      de: "Psychologische Forschung beweist, dass Fragen stärkere Verbindungen aufbauen als oberflächliche Anziehung.",
      fr: "La recherche en psychologie prouve que les questions créent des connexions plus fortes que l'attraction superficielle.",
      es: "La investigación psicológica demuestra que las preguntas crean conexiones más fuertes que la atracción superficial.",
    },
    keywords: ["question based matching science", "compatibility science dating", "psychology of dating", "36 questions dating", "dating bilimi"],
  },
];
