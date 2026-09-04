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

/**
 * Metadata for the four `/advice` guides. `titles` and `descriptions` feed the
 * `<title>`, the meta description, the Article JSON-LD and the related-guide
 * cards, so every locale that the article body exists in needs an entry here —
 * otherwise a fully translated page ships under an English title.
 *
 * All four guides carry all 16 locales, in the same order as `blog.ts`.
 *
 * Two descriptions were rewritten rather than translated, because they had
 * drifted from what the bodies say:
 *
 *  - `long-distance-relationships` promised "research-backed practical advice"
 *    ("Araştırma destekli pratik öneriler"). The research it referred to was
 *    deleted in the content migration for being unsourced — a Cornell figure
 *    nobody can find, a "joint Stanford and Queen's University study", an "85%
 *    success rate" — and the article now opens by saying plainly that there is
 *    no honest success rate to quote. The description describes the habits,
 *    the difficulties and the when-to-stop section that the guide actually
 *    contains.
 *  - `dating-profile-guide` closed with "The first step to ending singlehood"
 *    ("Bekarlığın sonlanmasının ilk adımı"), an outcome promise that the body
 *    explicitly refuses: "The goal is not more matches … a good profile is
 *    slightly narrowing on purpose." Replaced with what the guide aims at.
 *    (Only `tr` and `en` carried that sentence; `de`, `fr` and `es` are single
 *    sentences that never made the claim and are left as they were.)
 */
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
      ar: "نصائح للموعد الأول: دليل كامل لبداية موفّقة",
      ru: "Советы для первого свидания: полное руководство",
      pt: "Dicas para o primeiro encontro: guia completo",
      it: "Consigli per il primo appuntamento: la guida completa",
      ja: "初デートのコツ：良いスタートを切るための完全ガイド",
      ko: "첫 데이트 팁: 좋은 시작을 위한 완전 가이드",
      zh: "第一次约会指南：如何有个好开始",
      nl: "Tips voor de eerste date: de complete gids",
      pl: "Pierwsza randka: kompletny poradnik na dobry początek",
      sv: "Tips inför första dejten: den kompletta guiden",
      hi: "पहली डेट के टिप्स: अच्छी शुरुआत की पूरी गाइड",
    },
    descriptions: {
      tr: "İlk buluşmanızda ne yapacağınızı, ne konuşacağınızı ve nasıl rahat olacağınızı öğrenin. İlk buluşma tavsiyeleri için kapsamlı rehber.",
      en: "Learn what to do, what to say, and how to relax on your first date. Comprehensive guide for first date tips.",
      de: "Erfahren Sie, was Sie beim ersten Date tun, sagen und wie Sie sich entspannen.",
      fr: "Apprenez quoi faire, quoi dire et comment vous détendre lors de votre premier rendez-vous.",
      es: "Aprende qué hacer, qué decir y cómo relajarte en tu primera cita.",
      ar: "تعلّم ماذا تفعل وماذا تقول وكيف تسترخي في موعدك الأول. دليل شامل لنصائح الموعد الأول.",
      ru: "Что делать, что говорить и как расслабиться на первом свидании. Подробное руководство с советами для первого свидания.",
      pt: "Aprenda o que fazer, o que dizer e como relaxar no primeiro encontro. Guia completo com dicas para o primeiro encontro.",
      it: "Impara cosa fare, cosa dire e come rilassarti al primo appuntamento. Guida completa ai consigli per il primo appuntamento.",
      ja: "初デートで何をして、何を話し、どうリラックスするか。初デートのコツをまとめた完全ガイドです。",
      ko: "첫 데이트에서 무엇을 하고, 무슨 말을 하고, 어떻게 긴장을 풀지 알아보세요. 첫 데이트 팁을 담은 완전 가이드입니다.",
      zh: "第一次约会该做什么、聊什么，以及怎么让自己放松下来。关于第一次约会的完整指南。",
      nl: "Leer wat je doet, wat je zegt en hoe je ontspant op je eerste date. Complete gids met tips voor de eerste date.",
      pl: "Dowiedz się, co robić, co mówić i jak się rozluźnić na pierwszej randce. Kompletny poradnik z poradami na pierwszą randkę.",
      sv: "Lär dig vad du ska göra, vad du ska säga och hur du slappnar av på första dejten. Komplett guide med tips inför första dejten.",
      hi: "पहली डेट पर क्या करें, क्या कहें और कैसे सहज महसूस करें। पहली डेट के टिप्स की पूरी गाइड।",
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
      ar: "كيف تكتب ملفًا شخصيًا رائعًا للمواعدة: دليل خطوة بخطوة",
      ru: "Как написать хорошую анкету для знакомств: пошаговое руководство",
      pt: "Como escrever um ótimo perfil de namoro: guia passo a passo",
      it: "Come scrivere un ottimo profilo di dating: guida passo passo",
      ja: "良いプロフィールの書き方：ステップごとの完全ガイド",
      ko: "좋은 데이팅 프로필 쓰는 법: 단계별 가이드",
      zh: "如何写好交友资料：分步指南",
      nl: "Hoe schrijf je een goed datingprofiel: stap-voor-stap gids",
      pl: "Jak napisać dobry profil randkowy: poradnik krok po kroku",
      sv: "Så skriver du en bra dejtingprofil: steg för steg",
      hi: "अच्छी डेटिंग प्रोफ़ाइल कैसे लिखें: कदम-दर-कदम गाइड",
    },
    descriptions: {
      tr: "Dating profilinizi öne çıkaracak fotoğraflar, bio metni ve sorular için profesyonel ipuçları. Amaç herkesin değil, doğru kişinin ilgisini çekmek.",
      en: "Professional tips for photos, bio text and questions that make your dating profile stand out. Written so the right person leans in, not so everyone does.",
      de: "Professionelle Tipps für Fotos, Bio-Text und Fragen, die Ihr Dating-Profil hervorheben.",
      fr: "Conseils pro pour les photos, le bio et les questions qui font ressortir votre profil.",
      es: "Consejos profesionales para fotos, bio y preguntas que hacen destacar tu perfil.",
      ar: "نصائح احترافية للصور والنبذة والأسئلة التي تجعل ملفك الشخصي يبرز. الهدف أن يقترب الشخص المناسب، لا أن يعجب الجميع.",
      ru: "Профессиональные советы по фотографиям, описанию и вопросам, которые выделят вашу анкету. Цель — понравиться нужному человеку, а не всем сразу.",
      pt: "Dicas profissionais de fotos, bio e perguntas que fazem seu perfil se destacar. O objetivo é atrair a pessoa certa, não todo mundo.",
      it: "Consigli professionali su foto, bio e domande che fanno risaltare il tuo profilo. L'obiettivo è attirare la persona giusta, non tutti.",
      ja: "写真、自己紹介文、質問——プロフィールを際立たせるための具体的なコツ。狙うのは全員ではなく、合う人に届くことです。",
      ko: "사진, 소개글, 질문까지 프로필을 돋보이게 만드는 실전 팁. 모두가 아니라 맞는 사람이 다가오게 쓰는 법.",
      zh: "照片、简介和问题——让你的交友资料脱颖而出的实用建议。目标不是讨好所有人，而是让合适的人靠近。",
      nl: "Professionele tips voor foto's, bio en vragen die je datingprofiel laten opvallen. Bedoeld om de juiste persoon aan te trekken, niet iedereen.",
      pl: "Praktyczne wskazówki dotyczące zdjęć, opisu i pytań, dzięki którym twój profil się wyróżnia. Chodzi o właściwą osobę, a nie o wszystkich.",
      sv: "Professionella tips för bilder, presentation och frågor som får din dejtingprofil att sticka ut. Målet är rätt person, inte alla.",
      hi: "तस्वीरें, बायो और सवाल — आपकी डेटिंग प्रोफ़ाइल को अलग दिखाने के व्यावहारिक सुझाव। मक़सद सबको नहीं, सही इंसान को आकर्षित करना है।",
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
      ar: "15 علامة تحذير في المواعدة عبر الإنترنت: ما يجب أن تعرفه",
      ru: "15 тревожных сигналов в онлайн-знакомствах: что нужно знать",
      pt: "15 sinais de alerta no namoro online: o que você precisa saber",
      it: "15 campanelli d'allarme nel dating online: cosa devi sapere",
      ja: "オンラインの出会いに潜む15の警告サイン：知っておきたいこと",
      ko: "온라인 데이팅의 경고 신호 15가지: 알아 둬야 할 것들",
      zh: "网上交友的 15 个警示信号：你需要知道的事",
      nl: "15 waarschuwingssignalen bij online daten: wat je moet weten",
      pl: "15 sygnałów ostrzegawczych na randkach online: co warto wiedzieć",
      sv: "15 varningssignaler vid nätdejting: det du behöver veta",
      hi: "ऑनलाइन डेटिंग में 15 चेतावनी संकेत: जो आपको पता होने चाहिए",
    },
    descriptions: {
      tr: "Online dating'de karşılaşabileceğiniz 15 uyarı işaretini tanıyın. Dolandırıcılık, manipülasyon ve yıpratıcı davranışlardan kendinizi koruyun.",
      en: "Recognize 15 warning signs you may encounter in online dating. Protect yourself from scams, manipulation and toxic behavior.",
      de: "Erkennen Sie 15 Warnsignale beim Online-Dating. Schützen Sie sich vor Betrug und Manipulation.",
      fr: "Reconnaissez 15 signes d'alerte en dating en ligne. Protégez-vous des arnaques.",
      es: "Reconoce 15 señales de alerta en citas online. Protégete de estafas y manipulación.",
      ar: "تعرّف على 15 علامة تحذير قد تصادفها في المواعدة عبر الإنترنت. احمِ نفسك من الاحتيال والتلاعب والسلوك المؤذي.",
      ru: "Узнайте 15 тревожных сигналов, которые встречаются в онлайн-знакомствах. Защитите себя от мошенничества, манипуляций и токсичного поведения.",
      pt: "Reconheça 15 sinais de alerta que você pode encontrar no namoro online. Proteja-se de golpes, manipulação e comportamento tóxico.",
      it: "Riconosci 15 campanelli d'allarme che puoi incontrare nel dating online. Proteggiti da truffe, manipolazione e comportamenti tossici.",
      ja: "オンラインの出会いで遭遇しうる15の警告サインを見分ける。詐欺、操作的な言動、有害なふるまいから身を守るために。",
      ko: "온라인 데이팅에서 마주칠 수 있는 경고 신호 15가지를 알아보세요. 사기와 조종, 해로운 행동으로부터 스스로를 지키는 법.",
      zh: "认出网上交友中可能遇到的 15 个警示信号。保护自己，远离诈骗、操控和有害的相处方式。",
      nl: "Herken 15 waarschuwingssignalen die je bij online daten kunt tegenkomen. Bescherm jezelf tegen oplichting, manipulatie en toxisch gedrag.",
      pl: "Rozpoznaj 15 sygnałów ostrzegawczych, które możesz spotkać na randkach online. Chroń się przed oszustwami, manipulacją i toksycznymi zachowaniami.",
      sv: "Känn igen 15 varningssignaler du kan möta vid nätdejting. Skydda dig mot bedrägerier, manipulation och destruktivt beteende.",
      hi: "ऑनलाइन डेटिंग में मिल सकने वाले 15 चेतावनी संकेत पहचानिए। ठगी, हेरफेर और नुक़सानदेह बर्ताव से खुद को बचाइए।",
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
      ar: "العلاقات عن بُعد: الدليل الكامل لإنجاحها",
      ru: "Отношения на расстоянии: полное руководство",
      pt: "Relacionamento à distância: o guia completo para fazer dar certo",
      it: "Relazioni a distanza: la guida completa per farla funzionare",
      ja: "遠距離恋愛：続けていくための完全ガイド",
      ko: "장거리 연애: 이어 가기 위한 완전 가이드",
      zh: "异地恋完全指南：怎样才能走下去",
      nl: "Langeafstandsrelaties: de complete gids om het te laten werken",
      pl: "Związek na odległość: kompletny poradnik, jak go utrzymać",
      sv: "Distansförhållanden: den kompletta guiden till att få det att fungera",
      hi: "लंबी दूरी के रिश्ते: इन्हें निभाने की पूरी गाइड",
    },
    descriptions: {
      tr: "Uzak mesafede iletişimi, güveni ve yakınlığı canlı tutan alışkanlıklar. Neyin zorlaştırdığı, gerçekten neyin işe yaradığı ve ne zaman durup yeniden düşünmek gerektiği.",
      en: "Habits that keep communication, trust and closeness alive across the distance. What makes it hard, what actually helps, and when to stop and think again.",
      de: "Gewohnheiten, die Kommunikation, Vertrauen und Nähe über die Entfernung hinweg am Leben halten. Was es schwer macht, was wirklich hilft und wann man innehalten sollte.",
      fr: "Des habitudes qui gardent vivantes la communication, la confiance et l'intimité malgré la distance. Ce qui rend les choses difficiles, ce qui aide vraiment, et quand s'arrêter pour y réfléchir.",
      es: "Hábitos que mantienen vivas la comunicación, la confianza y la cercanía a distancia. Qué lo hace difícil, qué ayuda de verdad y cuándo parar a pensarlo.",
      ar: "عادات تُبقي التواصل والثقة والقرب حيّة رغم المسافة. ما الذي يجعلها صعبة، وما الذي يساعد فعلًا، ومتى يجدر بك التوقف وإعادة التفكير.",
      ru: "Привычки, которые поддерживают общение, доверие и близость на расстоянии. Что делает это трудным, что действительно помогает и когда стоит остановиться и подумать.",
      pt: "Hábitos que mantêm vivas a comunicação, a confiança e a proximidade à distância. O que torna tudo difícil, o que ajuda de verdade e quando parar para repensar.",
      it: "Abitudini che tengono vive comunicazione, fiducia e vicinanza nonostante la distanza. Cosa la rende difficile, cosa aiuta davvero e quando fermarsi a ripensarci.",
      ja: "距離があっても、会話と信頼と親密さを保つための習慣。何が難しくするのか、何が実際に効くのか、そしていつ立ち止まって考え直すべきか。",
      ko: "떨어져 있어도 대화와 신뢰, 가까움을 살아 있게 하는 습관들. 무엇이 어렵게 만들고, 무엇이 실제로 도움이 되며, 언제 멈춰 다시 생각해야 하는지.",
      zh: "在距离之下，仍能让沟通、信任和亲密感活着的那些习惯。什么让它变难，什么真的有用，以及什么时候该停下来重新想一想。",
      nl: "Gewoontes die communicatie, vertrouwen en nabijheid levend houden over afstand. Wat het zwaar maakt, wat echt helpt en wanneer je moet stoppen en opnieuw nadenken.",
      pl: "Nawyki, które utrzymują przy życiu rozmowę, zaufanie i bliskość mimo odległości. Co to utrudnia, co naprawdę pomaga i kiedy warto się zatrzymać.",
      sv: "Vanor som håller samtal, tillit och närhet vid liv trots avståndet. Vad som gör det svårt, vad som faktiskt hjälper och när det är dags att tänka om.",
      hi: "दूरी के बावजूद बातचीत, भरोसा और नज़दीकी को ज़िंदा रखने वाली आदतें। क्या इसे मुश्किल बनाता है, असल में क्या काम आता है, और कब रुककर फिर से सोचना चाहिए।",
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
