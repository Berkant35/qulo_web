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
    updatedAt: "2026-09-03",
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
      tr: "Kuru bir selam hiçbir şey istemez, bu yüzden karşılığında da hiçbir şey almaz. Harvard’ın konuşma araştırmaları neyin gerçekten yanıt getirdiğini gösteriyor — ve Qulo bu soruyu her eşleşmenin içine yerleştiriyor.",
      en: "A bare greeting asks for nothing, so it gets nothing back. Harvard’s conversation research shows what actually earns a reply — and how Qulo builds that question into every match.",
      de: "Eine bloße Begrüßung verlangt nichts und bekommt deshalb nichts zurück. Harvards Gesprächsforschung zeigt, was wirklich eine Antwort bringt — und wie Qulo genau diese Frage in jedes Match einbaut.",
      fr: "Une simple salutation ne demande rien, et ne reçoit donc rien en retour. Les recherches de Harvard sur la conversation montrent ce qui déclenche vraiment une réponse — et comment Qulo intègre cette question à chaque match.",
      es: "Un saludo pelado no pide nada, así que no recibe nada. La investigación sobre conversación de Harvard muestra qué sí consigue respuesta — y cómo Qulo integra esa pregunta en cada match.",
      ar: "التحية المجردة لا تطلب شيئًا، ولذلك لا تحصل على شيء. تُظهر أبحاث المحادثة في هارفارد ما الذي يستدعي الرد فعلاً — وكيف يدمج Qulo هذا السؤال في كل تطابق.",
      ru: "Голое приветствие ни о чём не просит — и ничего не получает в ответ. Гарвардские исследования разговоров показывают, что на самом деле приносит ответ, а Qulo встраивает этот вопрос в каждый мэтч.",
      pt: "Um cumprimento seco não pede nada e, por isso, não recebe nada. A pesquisa sobre conversas de Harvard mostra o que de fato gera resposta — e como o Qulo incorpora essa pergunta em cada match.",
      it: "Un saluto secco non chiede nulla, e infatti non ottiene nulla. Le ricerche di Harvard sulla conversazione mostrano che cosa fa davvero arrivare una risposta — e come Qulo integra quella domanda in ogni match.",
      ja: "素っ気ない挨拶は何も求めないから、何も返ってきません。何が返信を引き出すのかをHarvardの会話研究が示します。そして、Quloがその質問をすべてのマッチに組み込んでいる仕組みも解説します。",
      ko: "밋밋한 인사말은 아무것도 요구하지 않기에 아무것도 얻지 못합니다. 무엇이 실제로 답장을 부르는지 하버드의 대화 연구가 보여줍니다. 그리고 Qulo는 그 질문을 모든 매칭에 심어 둡니다.",
      zh: "干巴巴的问候什么也不索取，所以什么也得不到。哈佛的对话研究揭示了究竟什么才能换来回复——以及 Qulo 如何把那个问题内置到每一次配对中。",
      nl: "Een kale begroeting vraagt niets en krijgt dus niets terug. Het gespreksonderzoek van Harvard laat zien wat wél antwoord oplevert — en hoe Qulo die vraag in elke match inbouwt.",
      pl: "Suche powitanie o nic nie prosi, więc nic nie dostaje. Harwardzkie badania nad rozmową pokazują, co naprawdę przynosi odpowiedź — i jak Qulo wbudowuje to pytanie w każde dopasowanie.",
      sv: "En naken hälsning ber inte om något och får därför inget tillbaka. Harvards samtalsforskning visar vad som faktiskt ger svar — och hur Qulo bygger in den frågan i varje matchning.",
      hi: "सूखा-सा अभिवादन कुछ माँगता ही नहीं, इसलिए बदले में कुछ मिलता भी नहीं। Harvard का बातचीत पर शोध बताता है कि जवाब असल में किससे मिलता है — और Qulo उस सवाल को हर मैच में कैसे शामिल करता है।",
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
    ],
  },
  {
    slug: "the-question-deficit",
    publishedAt: "2026-09-01",
    updatedAt: "2026-09-03",
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
      tr: "Karşınızdakinin size karşı meraklı olmadığını düşünerek ayrıldınız. O da tam olarak aynı şeyi düşünerek ayrıldı. İkiniz de samimisiniz — ve bunu açıklayan üç ölçülebilir algı boşluğu var.",
      en: "You left thinking the other person wasn’t curious about you. They left thinking exactly the same about you. Both of you are sincere — and three measurable perception gaps explain why.",
      de: "Du bist gegangen und dachtest, die andere Person sei nicht neugierig auf dich. Sie ist gegangen und dachte genau dasselbe über dich. Ihr seid beide aufrichtig — und drei messbare Wahrnehmungslücken erklären, warum.",
      fr: "Vous êtes reparti en pensant que l’autre n’était pas curieux de vous. L’autre est reparti en pensant exactement la même chose. Vous êtes tous les deux sincères — et trois écarts de perception mesurables l’expliquent.",
      es: "Te fuiste pensando que la otra persona no sentía curiosidad por ti. Ella se fue pensando exactamente lo mismo de ti. Los dos sois sinceros — y tres brechas de percepción medibles lo explican.",
      ar: "غادرتَ وأنت تظن أن الطرف الآخر لم يكن فضوليًا تجاهك، وغادر هو وهو يظن الشيء نفسه تمامًا عنك. كلاكما صادق — وثلاث فجوات إدراكية قابلة للقياس تفسّر السبب.",
      ru: "Вы ушли с мыслью, что собеседнику было неинтересно. Он ушёл ровно с той же мыслью о вас. Вы оба искренни — и это объясняют три измеримых разрыва восприятия.",
      pt: "Você saiu achando que a outra pessoa não tinha curiosidade sobre você. Ela saiu achando exatamente a mesma coisa a seu respeito. Os dois são sinceros — e três lacunas de percepção mensuráveis explicam por quê.",
      it: "Te ne sei andato pensando che l’altra persona non fosse curiosa di te. Lei se n’è andata pensando esattamente lo stesso. Siete entrambi sinceri — e tre divari percettivi misurabili spiegano il perché.",
      ja: "あなたは「相手は自分に興味がなかった」と思って帰りました。相手もまったく同じことを思って帰りました。どちらの気持ちも本心であり、測定可能な3つの認識のズレがその理由を説明します。",
      ko: "당신은 상대가 나에게 관심이 없다고 생각하며 자리를 떴습니다. 상대도 당신에 대해 똑같이 생각하며 자리를 떴습니다. 양쪽 모두 진심이며, 측정 가능한 세 가지 인식 격차가 그 이유를 설명합니다.",
      zh: "你离开时以为对方对你毫无兴趣。对方离开时，想的一模一样。两个人都出自真心——三个可测量的认知落差解释了原因。",
      nl: "Jij ging weg met het idee dat de ander niet nieuwsgierig naar je was. De ander ging weg met precies dezelfde gedachte. Jullie zijn allebei oprecht — en drie meetbare perceptiekloven verklaren waarom.",
      pl: "Wyszedłeś z przekonaniem, że druga osoba nie była ciebie ciekawa. Ona wyszła dokładnie z tym samym przekonaniem o tobie. Oboje jesteście szczerzy — a wyjaśniają to trzy mierzalne luki w postrzeganiu.",
      sv: "Du gick därifrån och trodde att den andra inte var nyfiken på dig. Den andra gick därifrån och trodde exakt samma sak om dig. Ni är båda uppriktiga — och tre mätbara perceptionsglapp förklarar varför.",
      hi: "आप यह सोचकर लौटे कि सामने वाले को आपमें कोई दिलचस्पी नहीं थी। सामने वाला भी ठीक यही सोचकर लौटा। आप दोनों सच्चे हैं — और तीन मापने योग्य धारणा-अंतर इसकी वजह बताते हैं।",
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
        title: "It Doesn't Hurt to Ask: Question-Asking Increases Liking",
        source:
          "Huang, Yeomans, Brooks, Minson & Gino — Journal of Personality and Social Psychology 113(3), 430-452 (2017)",
        url: "https://www.hbs.edu/ris/Publication%20Files/Huang%20et%20al%202017_6945bc5e-3b3e-4c0a-addd-254c9e603c60.pdf",
      },
      {
        title: "Taking turns: Reciprocal self-disclosure promotes liking in initial interactions",
        source:
          "Sprecher, Treger, Wondra, Hilaire & Wallpe — Journal of Experimental Social Psychology (2013)",
        url: "https://www.sciencedirect.com/science/article/abs/pii/S002210311300070X",
      },
      {
        title:
          "The Experimental Generation of Interpersonal Closeness: A Procedure and Some Preliminary Findings",
        source:
          "Aron, Melinat, Aron, Vallone & Bator — Personality and Social Psychology Bulletin 23(4), 363-377 (1997)",
        url: "https://journals.sagepub.com/doi/10.1177/0146167297234003",
      },
    ],
  },
];
