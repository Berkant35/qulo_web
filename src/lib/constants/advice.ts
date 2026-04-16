export interface AdviceGuide {
  slug: string;
  category: string;
  publishedAt: string;
  readingTime: number;
  emoji: string;
  titles: Record<string, string>;
  descriptions: Record<string, string>;
  keywords: string[];
}

export const ADVICE_GUIDES: AdviceGuide[] = [
  {
    slug: "first-date-tips",
    category: "dating-basics",
    publishedAt: "2026-04-16",
    readingTime: 8,
    emoji: "☕",
    titles: {
      tr: "İlk Buluşma Tavsiyeleri: Mükemmel Bir Başlangıç İçin Rehber",
      en: "First Date Tips: The Complete Guide to a Perfect Start",
      de: "Tipps für das erste Date: Der komplette Leitfaden",
      fr: "Conseils pour un premier rendez-vous : Guide complet",
      es: "Consejos para la primera cita: Guía completa",
    },
    descriptions: {
      tr: "İlk buluşmanızda ne yapacağınızı, ne konuşacağınızı ve nasıl rahat olacağınızı öğrenin. İlk buluşma tavsiyeleri için kapsamlı rehber.",
      en: "Learn what to do, what to say, and how to relax on your first date. Comprehensive guide for first date tips.",
      de: "Erfahren Sie, was Sie beim ersten Date tun, sagen und wie Sie sich entspannen.",
      fr: "Apprenez quoi faire, quoi dire et comment vous détendre lors de votre premier rendez-vous.",
      es: "Aprende qué hacer, qué decir y cómo relajarte en tu primera cita.",
    },
    keywords: [
      "first date tips",
      "ilk buluşma tavsiyeleri",
      "first date ideas",
      "what to do on first date",
      "ilk buluşma ne konuşulur",
    ],
  },
  {
    slug: "dating-profile-guide",
    category: "profile",
    publishedAt: "2026-04-16",
    readingTime: 10,
    emoji: "📸",
    titles: {
      tr: "Harika Bir Dating Profili Nasıl Yazılır: Adım Adım Rehber",
      en: "How to Write a Great Dating Profile: Step-by-Step Guide",
      de: "Wie man ein großartiges Dating-Profil schreibt: Schritt-für-Schritt",
      fr: "Comment écrire un super profil de dating : Guide étape par étape",
      es: "Cómo escribir un gran perfil de citas: Guía paso a paso",
    },
    descriptions: {
      tr: "Dating profilinizi öne çıkaracak fotoğraflar, bio metni ve sorular için profesyonel ipuçları. Bekarlığın sonlanmasının ilk adımı.",
      en: "Professional tips for photos, bio text and questions that make your dating profile stand out. The first step to ending singlehood.",
      de: "Professionelle Tipps für Fotos, Bio-Text und Fragen, die Ihr Dating-Profil hervorheben.",
      fr: "Conseils pro pour les photos, le bio et les questions qui font ressortir votre profil.",
      es: "Consejos profesionales para fotos, bio y preguntas que hacen destacar tu perfil.",
    },
    keywords: [
      "dating profile tips",
      "dating profili yazma",
      "dating bio examples",
      "how to make dating profile",
      "dating profil örnekleri",
    ],
  },
  {
    slug: "red-flags-online-dating",
    category: "safety",
    publishedAt: "2026-04-16",
    readingTime: 9,
    emoji: "🚩",
    titles: {
      tr: "Online Dating'de 15 Kırmızı Bayrak: Bilmeniz Gerekenler",
      en: "15 Red Flags in Online Dating: What You Need to Know",
      de: "15 Warnsignale beim Online-Dating: Was Sie wissen müssen",
      fr: "15 drapeaux rouges dans le dating en ligne : Ce qu'il faut savoir",
      es: "15 banderas rojas en citas online: Lo que necesitas saber",
    },
    descriptions: {
      tr: "Online dating'de karşılaşabileceğiniz 15 uyarı işaretini tanıyın. Dolandırıcılık, manipülasyon ve toxic davranışlardan kendinizi koruyun.",
      en: "Recognize 15 warning signs you may encounter in online dating. Protect yourself from scams, manipulation and toxic behavior.",
      de: "Erkennen Sie 15 Warnsignale beim Online-Dating. Schützen Sie sich vor Betrug und Manipulation.",
      fr: "Reconnaissez 15 signes d'alerte en dating en ligne. Protégez-vous des arnaques.",
      es: "Reconoce 15 señales de alerta en citas online. Protégete de estafas y manipulación.",
    },
    keywords: [
      "red flags dating",
      "dating red flags",
      "online dating scams",
      "kırmızı bayrak dating",
      "dating uyarı işaretleri",
    ],
  },
  {
    slug: "long-distance-relationships",
    category: "relationships",
    publishedAt: "2026-04-16",
    readingTime: 11,
    emoji: "✈️",
    titles: {
      tr: "Uzak Mesafe İlişkiler: Başarılı Olmanın Tam Rehberi",
      en: "Long Distance Relationships: The Complete Guide to Success",
      de: "Fernbeziehungen: Der komplette Erfolgsleitfaden",
      fr: "Relations à distance : Guide complet du succès",
      es: "Relaciones a distancia: Guía completa del éxito",
    },
    descriptions: {
      tr: "Uzak mesafe ilişkilerde iletişim, güven ve yakınlığı korumanın kanıtlanmış yolları. Araştırma destekli pratik öneriler.",
      en: "Proven ways to maintain communication, trust and intimacy in long distance relationships. Research-backed practical advice.",
      de: "Bewährte Wege, um Kommunikation, Vertrauen und Nähe in Fernbeziehungen zu bewahren.",
      fr: "Méthodes éprouvées pour maintenir la communication, la confiance et l'intimité.",
      es: "Formas probadas de mantener comunicación, confianza e intimidad en relaciones a distancia.",
    },
    keywords: [
      "long distance relationship tips",
      "uzak mesafe ilişki",
      "LDR advice",
      "how to maintain long distance",
      "uzak mesafe ilişki nasıl yürür",
    ],
  },
];
