export interface BlogPost {
  slug: string;
  publishedAt: string;
  /**
   * Date of the last substantive content revision (ISO date). Omit until the
   * post is genuinely revised — `dateModified` falls back to `publishedAt`, and
   * bumping the date without changing the content is a worthless freshness
   * signal that search engines can detect.
   */
  updatedAt?: string;
  readingTime: number;
  titles: Record<string, string>;
  excerpts: Record<string, string>;
  keywords: string[];
  /**
   * Optional cover image path relative to /public (e.g. "/images/blog/foo.png").
   * Backward-compatible: older posts omit it and simply render no cover.
   */
  coverImage?: string;
  /**
   * Optional academic / source citations. When present they are rendered as a
   * "References" section under the article and emitted in the BlogPosting
   * JSON-LD `citation` field (strengthens E-E-A-T for research-backed posts).
   */
  citations?: { title: string; source: string; url: string }[];
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
      en: "Why Introverts Are Choosing Quiz Dating Over Swipe Apps",
      de: "Warum Introvertierte Quiz-Dating gegenüber Swipe-Apps bevorzugen",
      fr: "Pourquoi les introvertis préfèrent le quiz dating aux apps de swipe",
      es: "Por qué los introvertidos eligen el quiz dating sobre las apps de swipe",
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
  {
    slug: "what-actually-predicts-compatibility",
    publishedAt: "2026-07-18",
    readingTime: 9,
    titles: {
      tr: "Aşkı 'Tipiniz' Belirlemez: Uyumluluğu Gerçekte Ne Öngörür?",
      en: "Your 'Type' Doesn't Predict Love: What Actually Predicts Compatibility",
      de: "Dein „Typ“ sagt keine Liebe voraus: Was wirklich über Kompatibilität entscheidet",
      fr: "Votre « type » ne prédit pas l'amour : ce qui prédit vraiment la compatibilité",
      es: "Tu «tipo» no predice el amor: qué predice de verdad la compatibilidad",
      ar: "\"نمطك المفضّل\" لا يتنبّأ بالحب: ما الذي يتنبّأ فعلاً بالتوافق",
      ru: "Ваш «тип» не предсказывает любовь: что на самом деле предсказывает совместимость",
      pt: "Seu \"tipo\" não prevê o amor: o que realmente prevê a compatibilidade",
      it: "Il tuo «tipo» non predice l'amore: cosa predice davvero la compatibilità",
      ja: "「好みのタイプ」は恋を予測しない――本当に相性を決めるものとは",
      ko: "당신의 '이상형'은 사랑을 예측하지 못한다: 진짜로 궁합을 결정하는 것",
      zh: "你的「理想型」预测不了爱情：真正决定契合度的是什么",
      nl: "Je \"type\" voorspelt geen liefde: wat compatibiliteit echt voorspelt",
      pl: "Twój „typ” nie przewiduje miłości: co naprawdę przewiduje zgodność",
      sv: "Din \"typ\" förutsäger inte kärlek: vad som faktiskt förutsäger kompatibilitet",
      hi: "आपका 'टाइप' प्यार की भविष्यवाणी नहीं करता: असल में अनुकूलता का पता किससे चलता है",
    },
    excerpts: {
      tr: "Onlarca yıllık ilişki bilimi net: ne istediğinizi sandığınız 'tip', kiminle bağ kuracağınızı öngörmüyor. Peki uyumluluğu gerçekte ne belirliyor — ve bu neden çoğu dating uygulamasının baştan yanlış kurulduğu anlamına geliyor?",
      en: "Decades of relationship science are clear: the 'type' you think you want doesn't predict who you'll actually connect with. So what really predicts compatibility — and why does it mean most dating apps are built backwards?",
      de: "Jahrzehnte der Beziehungsforschung sind eindeutig: Der „Typ“, von dem du glaubst, ihn zu wollen, sagt nicht voraus, mit wem du dich tatsächlich verbindest. Was sagt Kompatibilität also wirklich voraus — und warum bedeutet das, dass die meisten Dating-Apps verkehrt herum gebaut sind?",
      fr: "Des décennies de science des relations sont claires : le « type » que vous croyez désirer ne prédit pas avec qui vous vous connecterez vraiment. Alors qu'est-ce qui prédit réellement la compatibilité — et pourquoi cela signifie-t-il que la plupart des applications de rencontre sont construites à l'envers ?",
      es: "Décadas de ciencia de las relaciones lo dejan claro: el «tipo» que crees querer no predice con quién conectarás en realidad. Entonces, ¿qué predice de verdad la compatibilidad? ¿Y por qué eso significa que la mayoría de las apps de citas están construidas al revés?",
      ar: "عقودٌ من علم العلاقات تقول بوضوح: \"النمط\" الذي تظنّ أنك تريده لا يتنبّأ بمن ستنسجم معه فعلاً. فما الذي يتنبّأ حقاً بالتوافق — ولماذا يعني ذلك أن معظم تطبيقات المواعدة مبنيّة بالمقلوب؟",
      ru: "Десятилетия науки об отношениях говорят однозначно: «тип», который вы, как вам кажется, хотите, не предсказывает, с кем вы на самом деле сблизитесь. Так что же действительно предсказывает совместимость — и почему из этого следует, что большинство приложений для знакомств устроены задом наперёд?",
      pt: "Décadas de ciência dos relacionamentos são claras: o \"tipo\" que você acha que quer não prevê com quem você vai realmente se conectar. Então o que de fato prevê a compatibilidade — e por que isso significa que a maioria dos apps de namoro foi construída de trás para frente?",
      it: "Decenni di scienza delle relazioni parlano chiaro: il «tipo» che credi di volere non predice con chi entrerai davvero in sintonia. Allora cosa predice realmente la compatibilità — e perché questo significa che la maggior parte delle app di dating è costruita al contrario?",
      ja: "数十年にわたる恋愛心理学の結論ははっきりしています。あなたが求めていると思い込んでいる「タイプ」は、実際に惹かれ合う相手を予測しません。では、本当に相性を決めるものは何か――そしてなぜ、それはほとんどのマッチングアプリが逆向きに作られていることを意味するのでしょうか。",
      ko: "수십 년간의 관계 심리학이 내린 결론은 분명합니다. 당신이 원한다고 믿는 '이상형'은 실제로 마음이 통할 상대를 예측하지 못합니다. 그렇다면 진짜로 궁합을 결정하는 것은 무엇이며, 왜 그것은 대부분의 데이팅 앱이 거꾸로 설계되어 있음을 뜻할까요?",
      zh: "数十年的关系科学结论明确：你以为自己想要的那种「理想型」，并不能预测你真正会与谁产生共鸣。那么，究竟是什么真正决定了契合度——又为什么这意味着大多数交友软件的设计方向从一开始就反了？",
      nl: "Decennia aan relatiewetenschap zijn duidelijk: het \"type\" waarvan je denkt dat je het wilt, voorspelt niet met wie je echt een klik krijgt. Dus wat voorspelt compatibiliteit werkelijk — en waarom betekent dat dat de meeste datingapps verkeerd om zijn gebouwd?",
      pl: "Dziesięciolecia nauki o relacjach mówią jasno: „typ”, którego — jak ci się wydaje — pragniesz, nie przewiduje, z kim naprawdę się zwiążesz. Co więc naprawdę przewiduje zgodność — i dlaczego oznacza to, że większość aplikacji randkowych jest zbudowana na odwrót?",
      sv: "Decennier av relationsforskning är tydliga: den \"typ\" du tror att du vill ha förutsäger inte vem du faktiskt får kontakt med. Så vad förutsäger egentligen kompatibilitet — och varför innebär det att de flesta dejtingappar är byggda bakvänt?",
      hi: "रिश्तों पर दशकों के शोध की बात साफ है: जिस 'टाइप' को आप चाहते हैं, वह यह तय नहीं करता कि आप असल में किससे जुड़ेंगे। तो फिर अनुकूलता की भविष्यवाणी सचमुच किससे होती है — और इसका मतलब यह क्यों है कि ज़्यादातर डेटिंग ऐप उल्टे बने हुए हैं?",
    },
    keywords: [
      "what predicts compatibility",
      "does your type matter",
      "ideal partner preferences",
      "can you predict attraction",
      "why dating apps dont work",
      "uyumluluk bilimi",
      "aşkı ne belirler",
      "eş seçimi psikolojisi",
    ],
    citations: [
      {
        title:
          "Machine learning uncovers the most robust self-report predictors of relationship quality across 43 longitudinal couples studies",
        source: "Joel, Eastwick et al. — PNAS (2020)",
        url: "https://www.pnas.org/doi/10.1073/pnas.1917036117",
      },
      {
        title:
          "Sex differences in mate preferences revisited: Do people know what they initially desire in a romantic partner?",
        source: "Eastwick & Finkel — Journal of Personality and Social Psychology (2008)",
        url: "https://faculty.wcas.northwestern.edu/eli-finkel/documents/EastwickFinkel2008_JPSP.pdf",
      },
      {
        title: "Online Dating: A Critical Analysis From the Perspective of Psychological Science",
        source: "Finkel, Eastwick, Karney, Reis & Sprecher — Psychological Science in the Public Interest (2012)",
        url: "https://journals.sagepub.com/doi/10.1177/1529100612436522",
      },
      {
        title: "From Looking for Love to Swiping the Field: Online Dating in the U.S.",
        source: "Pew Research Center (2023)",
        url: "https://www.pewresearch.org/internet/2023/02/02/from-looking-for-love-to-swiping-the-field-online-dating-in-the-u-s/",
      },
    ],
  },
  {
    slug: "psychology-of-the-first-message",
    publishedAt: "2026-07-20",
    readingTime: 8,
    coverImage: "/images/blog/psychology-of-the-first-message.png",
    titles: {
      tr: "“Selam” Neden Cevapsız Kalır: Yanıt Alan İlk Mesajın Psikolojisi",
      en: "Why “Hey” Gets Ignored: The Psychology of a First Message That Gets a Reply",
      de: "Warum „Hey“ ignoriert wird: Die Psychologie einer ersten Nachricht, die eine Antwort bekommt",
      fr: "Pourquoi « Hey » reste sans réponse : la psychologie d'un premier message qui fait mouche",
      es: "Por qué un \"hey\" se ignora: la psicología del primer mensaje que sí recibe respuesta",
      ar: "لماذا يُتجاهَل \"مرحبًا\"؟ سيكولوجية الرسالة الأولى التي تحصل على رد",
      ru: "Почему «привет» остаётся без ответа: психология первого сообщения, на которое отвечают",
      pt: "Por que \"oi\" é ignorado: a psicologia da primeira mensagem que recebe resposta",
      it: "Perché \"hey\" viene ignorato: la psicologia di un primo messaggio che ottiene risposta",
      ja: "なぜ「やあ」は無視されるのか──返信がもらえるファーストメッセージの心理学",
      ko: "\"안녕\"이 무시당하는 이유: 답장을 받는 첫 메시지의 심리학",
      zh: "为什么「嗨」会被无视：能收到回复的第一条消息背后的心理学",
      nl: "Waarom 'Hey' wordt genegeerd: de psychologie van een eerste bericht dat wél antwoord krijgt",
      pl: "Dlaczego „hej” jest ignorowane: psychologia pierwszej wiadomości, która dostaje odpowiedź",
      sv: "Därför ignoreras \"hej\": psykologin bakom ett första meddelande som får svar",
      hi: "\"Hey\" को क्यों नज़रअंदाज़ किया जाता है: जवाब पाने वाले पहले मैसेज का मनोविज्ञान",
    },
    excerpts: {
      tr: "Yarım milyondan fazla ilk mesajın verisi ve Harvard’ın konuşma araştırmaları aynı noktada buluşuyor: selamlar görmezden geliniyor, sorular yanıt alıyor. İşte sohbet başlatmanın psikolojisi — ve Qulo’nun bunu her eşleşmeye nasıl yerleştirdiği.",
      en: "Data from over half a million first messages and Harvard’s conversation research agree: greetings get ignored, questions get replies. Here’s the psychology of starting a conversation — and how Qulo builds it into every match.",
      de: "Daten aus über einer halben Million erster Nachrichten und Harvards Gesprächsforschung sind sich einig: Begrüßungen werden ignoriert, Fragen bekommen Antworten. Hier ist die Psychologie des Gesprächsanfangs — und wie Qulo sie in jedes Match einbaut.",
      fr: "Les données de plus d'un demi-million de premiers messages et les recherches de Harvard sur la conversation convergent : les salutations sont ignorées, les questions obtiennent des réponses. Voici la psychologie du premier contact — et comment Qulo l'intègre à chaque match.",
      es: "Los datos de más de medio millón de primeros mensajes y la investigación sobre conversación de Harvard coinciden: los saludos se ignoran, las preguntas reciben respuesta. Esta es la psicología de empezar una conversación — y cómo Qulo la integra en cada match.",
      ar: "بيانات أكثر من نصف مليون رسالة أولى وأبحاث المحادثة في هارفارد تتفق على أمر واحد: التحيات تُتجاهَل، والأسئلة تحصل على ردود. إليك سيكولوجية بدء المحادثة — وكيف يدمجها Qulo في كل تطابق.",
      ru: "Данные более чем полумиллиона первых сообщений и гарвардские исследования разговоров сходятся в одном: приветствия игнорируют, на вопросы отвечают. Вот психология начала разговора — и то, как Qulo встраивает её в каждый мэтч.",
      pt: "Os dados de mais de meio milhão de primeiras mensagens e a pesquisa sobre conversas de Harvard concordam: cumprimentos são ignorados, perguntas recebem respostas. Aqui está a psicologia de começar uma conversa — e como o Qulo a incorpora em cada match.",
      it: "I dati di oltre mezzo milione di primi messaggi e le ricerche di Harvard sulla conversazione concordano: i saluti vengono ignorati, le domande ottengono risposte. Ecco la psicologia di come iniziare una conversazione — e come Qulo la integra in ogni match.",
      ja: "50万件を超えるファーストメッセージのデータとHarvardの会話研究が一致して示すのは、挨拶は無視され、質問は返信をもらえるということ。会話の始め方の心理学と、Quloがそれをすべてのマッチに組み込んでいる仕組みを解説します。",
      ko: "50만 건이 넘는 첫 메시지 데이터와 하버드의 대화 연구가 같은 결론을 내립니다: 인사말은 무시당하고, 질문은 답장을 받습니다. 대화를 시작하는 심리학, 그리고 Qulo가 이를 모든 매칭에 어떻게 녹여냈는지 소개합니다.",
      zh: "来自五十多万条第一条消息的数据与哈佛的对话研究得出了同一个结论：打招呼会被无视，提问才会得到回复。这就是开启一段对话的心理学——以及 Qulo 如何把它内置到每一次配对中。",
      nl: "Data van meer dan een half miljoen eerste berichten en het gespreksonderzoek van Harvard wijzen dezelfde kant op: begroetingen worden genegeerd, vragen krijgen antwoord. Dit is de psychologie achter het beginnen van een gesprek — en hoe Qulo die in elke match inbouwt.",
      pl: "Dane z ponad pół miliona pierwszych wiadomości i harwardzkie badania nad rozmową są zgodne: powitania są ignorowane, pytania dostają odpowiedzi. Oto psychologia rozpoczynania rozmowy — i to, jak Qulo wbudowuje ją w każde dopasowanie.",
      sv: "Data från över en halv miljon första meddelanden och Harvards samtalsforskning är överens: hälsningar ignoreras, frågor får svar. Här är psykologin bakom att inleda ett samtal — och hur Qulo bygger in den i varje matchning.",
      hi: "पाँच लाख से ज़्यादा पहले मैसेजों का डेटा और Harvard का बातचीत पर शोध एक ही बात कहते हैं: सिर्फ़ अभिवादन नज़रअंदाज़ होते हैं, सवालों को जवाब मिलता है। यहाँ है बातचीत शुरू करने का मनोविज्ञान — और Qulo इसे हर मैच में कैसे शामिल करता है।",
    },
    keywords: [
      "first message dating app",
      "best opening lines online dating",
      "how to start a conversation on a dating app",
      "why questions get more replies",
      "dating app opener psychology",
      "ilk mesaj ne yazmalı",
      "sohbet başlatma psikolojisi",
    ],
    citations: [
      {
        title: "It Doesn't Hurt to Ask: Question-Asking Increases Liking",
        source:
          "Huang, Yeomans, Brooks, Minson & Gino — Journal of Personality and Social Psychology (2017)",
        url: "https://www.hbs.edu/ris/Publication%20Files/Huang%20et%20al%202017_6945bc5e-3b3e-4c0a-addd-254c9e603c60.pdf",
      },
      {
        title: "Taking turns: Reciprocal self-disclosure promotes liking in initial interactions",
        source:
          "Sprecher, Treger, Wondra, Hilaire & Wallpe — Journal of Experimental Social Psychology (2013)",
        url: "https://www.sciencedirect.com/science/article/abs/pii/S002210311300070X",
      },
      {
        title: "Hinge's month-long experiment testing ~100 opening lines",
        source: "Hinge (2015), reported by International Business Times",
        url: "https://www.ibtimes.com/best-opening-line-dating-apps-hinge-analyzed-100-responses-its-not-hey-whats-2112058",
      },
      {
        title: "Exactly What To Say In A First Message (analysis of 500,000+ first messages)",
        source: "OkCupid OkTrends — Christian Rudder (2009), archived",
        url: "https://gwern.net/doc/psychology/okcupid/exactlywhattosayinafirstmessage.html",
      },
    ],
  },
  {
    slug: "the-question-deficit",
    publishedAt: "2026-09-01",
    readingTime: 6,
    titles: {
      tr: "Soru Açığı: Neden İkiniz de Karşınızdakini İlgisiz Sanarak Ayrıldınız",
      en: "The Question Deficit: Why You Both Left Thinking the Other One Wasn't Curious",
      de: "Das Fragedefizit: Warum ihr beide dachtet, die andere Person sei nicht neugierig",
      fr: "Le déficit de questions : pourquoi vous êtes repartis tous les deux en pensant que l'autre n'était pas curieux",
      es: "El déficit de preguntas: por qué los dos os fuisteis pensando que el otro no tenía curiosidad",
      ar: "عجز الأسئلة: لماذا غادر كلاكما وهو يظن أن الآخر لم يكن فضوليًا",
      ru: "Дефицит вопросов: почему вы оба ушли с мыслью, что другому неинтересно",
      pt: "O déficit de perguntas: por que vocês dois saíram achando que o outro não tinha curiosidade",
      it: "Il deficit di domande: perché ve ne siete andati entrambi pensando che l'altro non fosse curioso",
      ja: "質問の欠乏──なぜ二人とも「相手は自分に興味がなかった」と思って帰るのか",
      ko: "질문 결핍: 왜 두 사람 모두 상대가 나에게 관심이 없었다고 생각하며 돌아갔을까",
      zh: "提问赤字：为什么你们俩都以为对方对自己毫无兴趣",
      nl: "Het vragentekort: waarom jullie allebei dachten dat de ander niet nieuwsgierig was",
      pl: "Deficyt pytań: dlaczego oboje wyszliście z przekonaniem, że druga osoba nie była ciekawa",
      sv: "Frågeunderskottet: varför ni båda gick därifrån och trodde att den andra inte var nyfiken",
      hi: "सवालों की कमी: आप दोनों यह सोचकर क्यों लौटे कि सामने वाले को कोई दिलचस्पी नहीं थी",
    },
    excerpts: {
      tr: "Hinge yaklaşık 30.000 kişiye sordu: %62'si ilk buluşmada yeterince soru sorduğunu söyledi, ama yalnızca %30'u karşısındakinin sorduğunu hissetti. İki taraf da samimi — ve bunu açıklayan üç ölçülebilir algı boşluğu var.",
      en: "Hinge asked around 30,000 daters. 62% said they ask enough questions on a first date; only 30% felt their date did. Both halves are sincere — and three measurable perception gaps explain why.",
      de: "Hinge befragte rund 30.000 Dating-Nutzer. 62% sagten, sie stellen beim ersten Date genug Fragen; nur 30% fanden, ihr Date tue das. Beide Hälften sind aufrichtig — und drei messbare Wahrnehmungslücken erklären, warum.",
      fr: "Hinge a interrogé environ 30 000 célibataires. 62% disent poser assez de questions lors d'un premier rendez-vous ; seuls 30% estiment que leur rendez-vous en pose. Les deux moitiés sont sincères — et trois écarts de perception mesurables l'expliquent.",
      es: "Hinge preguntó a unas 30.000 personas. El 62% dijo que hace suficientes preguntas en una primera cita; solo el 30% sintió que su cita las hacía. Ambas mitades son sinceras — y tres brechas de percepción medibles lo explican.",
      ar: "استطلع Hinge آراء نحو 30,000 شخص. قال 62% إنهم يطرحون أسئلة كافية في الموعد الأول، لكن 30% فقط شعروا بأن الطرف الآخر يفعل ذلك. كلا الطرفين صادق — وثلاث فجوات إدراكية قابلة للقياس تفسّر السبب.",
      ru: "Hinge опросил около 30 000 человек. 62% сказали, что задают достаточно вопросов на первом свидании; лишь 30% почувствовали, что вопросы задавали им. Обе половины искренни — и это объясняют три измеримых разрыва восприятия.",
      pt: "O Hinge entrevistou cerca de 30.000 pessoas. 62% disseram fazer perguntas suficientes num primeiro encontro; apenas 30% sentiram que o seu par fazia. As duas metades são sinceras — e três lacunas de percepção mensuráveis explicam por quê.",
      it: "Hinge ha intervistato circa 30.000 persone. Il 62% dice di fare abbastanza domande al primo appuntamento; solo il 30% sente che l'altro le faccia. Entrambe le metà sono sincere — e tre divari percettivi misurabili spiegano il perché.",
      ja: "Hingeが約3万人に尋ねた結果、62%が「初デートで十分に質問している」と答えた一方、相手が質問してくれていると感じた人は30%だけだった。どちらの答えも本心であり、測定可能な3つの認識のズレがその理由を説明する。",
      ko: "Hinge가 약 3만 명에게 물었습니다. 62%는 첫 데이트에서 충분히 질문한다고 답했지만, 상대가 그렇다고 느낀 사람은 30%뿐이었습니다. 양쪽 모두 진심이며, 측정 가능한 세 가지 인식 격차가 그 이유를 설명합니다.",
      zh: "Hinge 调查了约三万名用户。62% 认为自己在初次约会时问了足够多的问题，却只有 30% 觉得对方在提问。两个答案都出自真心——三个可测量的认知落差解释了原因。",
      nl: "Hinge ondervroeg zo'n 30.000 daters. 62% zegt genoeg vragen te stellen op een eerste date; slechts 30% vond dat hun date dat deed. Beide helften zijn oprecht — en drie meetbare perceptiekloven verklaren waarom.",
      pl: "Hinge zapytał około 30 000 osób. 62% twierdzi, że zadaje wystarczająco dużo pytań na pierwszej randce; tylko 30% czuło, że pyta ich partner. Obie połowy są szczere — a wyjaśniają to trzy mierzalne luki w postrzeganiu.",
      sv: "Hinge frågade omkring 30 000 dejtare. 62% sa att de ställer tillräckligt med frågor på en första dejt; bara 30% upplevde att deras dejt gjorde det. Båda hälfterna är uppriktiga — och tre mätbara perceptionsglapp förklarar varför.",
      hi: "Hinge ने लगभग 30,000 लोगों से पूछा। 62% ने कहा कि वे पहली डेट पर पर्याप्त सवाल पूछते हैं, लेकिन सिर्फ़ 30% को लगा कि उनके डेट ने पूछे। दोनों पक्ष सच्चे हैं — और तीन मापने योग्य धारणा-अंतर इसकी वजह बताते हैं।",
    },
    keywords: [
      "question deficit",
      "my date didn't ask me anything",
      "why doesn't he ask me questions",
      "dating conversation gap",
      "liking gap dating",
      "buluşmada soru sormak",
      "karşımdaki bana soru sormadı",
      "soru açığı",
    ],
    citations: [
      {
        title: "2025 Gen Z D.A.T.E. Report",
        source: "Hinge — 19 November 2025, ~30,000 daters surveyed worldwide",
        url: "https://hinge.co/newsroom/2025-GenZ-Report",
      },
      {
        title: "The Liking Gap in Conversations: Do People Like Us More Than We Think?",
        source:
          "Boothby, Cooney, Sandstrom & Clark — Psychological Science 29(11), 1742-1756 (2018)",
        url: "https://clarkrelationshiplab.yale.edu/sites/default/files/files/BoothbyCooneySandstromClark2018.pdf",
      },
      {
        title: "It Doesn't Hurt to Ask: Question-Asking Increases Liking",
        source:
          "Huang, Yeomans, Brooks, Minson & Gino — Journal of Personality and Social Psychology 113(3), 430-452 (2017)",
        url: "https://www.hbs.edu/ris/Publication%20Files/Huang%20et%20al%202017_6945bc5e-3b3e-4c0a-addd-254c9e603c60.pdf",
      },
    ],
  },
];
