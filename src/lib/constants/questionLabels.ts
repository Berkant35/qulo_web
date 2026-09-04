/**
 * UI chrome for /[locale]/questions — the guide to writing dating-app questions.
 *
 * Kept apart from the two things it wraps: the guidance body
 * (`src/app/[locale]/questions/_content/writing-questions.ts`) and the 22
 * worked examples (`EXAMPLE_QUESTIONS`, generated from the app's own
 * per-market question library). All three are translated independently, and
 * all three must be complete for every locale — nothing on this page may fall
 * back to English under an `hreflang` that promises otherwise.
 *
 * `categories` is keyed by the slugs in `QUESTION_CATEGORIES`, so a heading
 * must describe the questions actually filed beneath it rather than the slug
 * in the abstract. Two that are easy to get wrong:
 *
 *  - `film` holds television as much as cinema in several markets — Arabic
 *    asks about a مسلسل, Japanese about ジブリ映画 and a home-viewing genre — so
 *    the heading names both.
 *  - `fun` is not "fun questions" as a quality judgement; it is the leftover
 *    category (superpowers, lottery wins, which animal you would be). Every
 *    locale reads as "just for fun" rather than as a claim that the other ten
 *    categories are not.
 *
 * `ctaDesc` states the real question limits: 2 to 4 on the free plan, up to 10
 * on a paid one. Every locale names the paid plan in the same sentence as the
 * ceiling — `npm run verify:claims` fails the build on a bare 2-to-10 range,
 * because the site spent months quoting the Premium number to free readers.
 */
export interface QuestionLabels {
  /** H1. Something a person would actually search for, per language. */
  title: string;
  /** One or two sentences under the H1. Also the meta description. */
  intro: string;
  /** The 11 category headings, keyed by the slugs below. */
  categories: Record<string, string>;
  /** Label above a question's four options, e.g. "Options". */
  optionsLabel: string;
  /** Heading over the examples section. */
  examplesHeading: string;
  ctaTitle: string;
  ctaDesc: string;
  ctaLink: string;
}

export const QUESTION_LABELS: Record<string, QuestionLabels> = {
  en: {
    title: "Dating app questions: what to ask and how to write your own",
    intro:
      "On Qulo you match by answering someone else's questions, so the one you write decides who gets through. Here is how to write one that works, with 22 examples.",
    categories: {
      personality: "Personality",
      lifestyle: "Lifestyle",
      travel: "Travel",
      food: "Food",
      music: "Music",
      film: "Film and TV",
      hobby: "Hobbies",
      humor: "Humour",
      sports: "Sport",
      technology: "Technology",
      fun: "Just for fun",
    },
    optionsLabel: "Options",
    examplesHeading: "Example questions by category",
    ctaTitle: "Now write your own",
    ctaDesc:
      "On Qulo you write 2 to 4 questions on the free plan — up to 10 on a paid plan — and match with whoever answers every one of them correctly.",
    ctaLink: "Get Qulo →",
  },
  tr: {
    title: "Tanışma uygulaması soruları: ne sorulur, nasıl yazılır",
    intro:
      "Qulo'da eşleşme, karşındakinin sorularını doğru cevaplamaktan geçer; yazdığın soru kimin geçeceğine karar verir. İşe yarayan soru nasıl yazılır, 22 örnekle.",
    categories: {
      personality: "Kişilik",
      lifestyle: "Yaşam tarzı",
      travel: "Seyahat",
      food: "Yemek",
      music: "Müzik",
      film: "Film ve dizi",
      hobby: "Hobiler",
      humor: "Mizah",
      sports: "Spor",
      technology: "Teknoloji",
      fun: "Sırf eğlence olsun diye",
    },
    optionsLabel: "Seçenekler",
    examplesHeading: "Kategorilere göre örnek sorular",
    ctaTitle: "Sıra kendi sorunda",
    ctaDesc:
      "Qulo'da ücretsiz planda 2 ila 4 soru yazarsın, ücretli planda 10'a kadar. Hepsini doğru bilen kişiyle eşleşirsin.",
    ctaLink: "Qulo'yu indir →",
  },
  de: {
    title: "Fragen für Dating-Apps: was du fragst und wie du eigene schreibst",
    intro:
      "Bei Qulo matchst du, indem du die Fragen anderer richtig beantwortest. Deine Frage entscheidet, wer durchkommt — so schreibst du eine gute, mit 22 Beispielen.",
    categories: {
      personality: "Persönlichkeit",
      lifestyle: "Lebensstil",
      travel: "Reisen",
      food: "Essen",
      music: "Musik",
      film: "Film und Serien",
      hobby: "Hobbys",
      humor: "Humor",
      sports: "Sport",
      technology: "Technik",
      fun: "Einfach zum Spaß",
    },
    optionsLabel: "Antwortoptionen",
    examplesHeading: "Beispielfragen nach Kategorie",
    ctaTitle: "Jetzt deine eigene schreiben",
    ctaDesc:
      "Bei Qulo schreibst du im kostenlosen Tarif 2 bis 4 Fragen, im bezahlten bis zu 10 — und matchst mit allen, die jede davon richtig beantworten.",
    ctaLink: "Qulo holen →",
  },
  fr: {
    title: "Questions à poser sur une app de rencontre — et comment écrire les vôtres",
    intro:
      "Sur Qulo, on matche en répondant juste aux questions de l'autre : la vôtre décide qui passe. Voici comment en écrire une qui fonctionne, avec 22 exemples.",
    categories: {
      personality: "Personnalité",
      lifestyle: "Mode de vie",
      travel: "Voyages",
      food: "Cuisine",
      music: "Musique",
      film: "Films et séries",
      hobby: "Loisirs",
      humor: "Humour",
      sports: "Sport",
      technology: "Technologie",
      fun: "Juste pour le plaisir",
    },
    optionsLabel: "Options",
    examplesHeading: "Exemples de questions par catégorie",
    ctaTitle: "À vous d'écrire les vôtres",
    ctaDesc:
      "Sur Qulo, vous écrivez 2 à 4 questions avec la formule gratuite, jusqu'à 10 avec un abonnement payant, et vous matchez avec ceux qui répondent juste à toutes.",
    ctaLink: "Télécharger Qulo →",
  },
  es: {
    title: "Preguntas para apps de citas: cuáles hacer y cómo escribir las tuyas",
    intro:
      "En Qulo haces match respondiendo bien a las preguntas de otra persona: la tuya decide quién pasa. Así se escribe una que funcione, con 22 ejemplos.",
    categories: {
      personality: "Personalidad",
      lifestyle: "Estilo de vida",
      travel: "Viajes",
      food: "Comida",
      music: "Música",
      film: "Cine y series",
      hobby: "Aficiones",
      humor: "Humor",
      sports: "Deporte",
      technology: "Tecnología",
      fun: "Solo por diversión",
    },
    optionsLabel: "Opciones",
    examplesHeading: "Preguntas de ejemplo por categoría",
    ctaTitle: "Ahora escribe las tuyas",
    ctaDesc:
      "En Qulo escribes de 2 a 4 preguntas en el plan gratuito y hasta 10 en un plan de pago; haces match con quien las acierta todas.",
    ctaLink: "Descargar Qulo →",
  },
  ar: {
    title: "أسئلة تطبيقات المواعدة: ماذا تسأل وكيف تكتب أسئلتك",
    intro:
      "في Qulo يحدث التطابق بالإجابة الصحيحة عن أسئلة الطرف الآخر، فسؤالك هو ما يقرّر من يمرّ. إليك كيف تكتب سؤالاً ناجحاً، مع 22 مثالاً.",
    categories: {
      personality: "الشخصية",
      lifestyle: "نمط الحياة",
      travel: "السفر",
      food: "الطعام",
      music: "الموسيقى",
      film: "الأفلام والمسلسلات",
      hobby: "الهوايات",
      humor: "روح الدعابة",
      sports: "الرياضة",
      technology: "التكنولوجيا",
      fun: "للمتعة فقط",
    },
    optionsLabel: "الخيارات",
    examplesHeading: "أمثلة على الأسئلة حسب الفئة",
    ctaTitle: "الآن اكتب أسئلتك أنت",
    ctaDesc:
      "في Qulo تكتب من سؤالين إلى أربعة أسئلة في الخطة المجانية، وحتى عشرة في خطة مدفوعة، وتتطابق مع من يجيب عنها كلها بشكل صحيح.",
    ctaLink: "حمّل Qulo →",
  },
  ru: {
    title: "Вопросы для приложений знакомств: что спросить и как написать свои",
    intro:
      "В Qulo пара находится через верные ответы на чужие вопросы — ваш вопрос решает, кто пройдёт. Как написать работающий вопрос, плюс 22 примера.",
    categories: {
      personality: "Характер",
      lifestyle: "Образ жизни",
      travel: "Путешествия",
      food: "Еда",
      music: "Музыка",
      film: "Кино и сериалы",
      hobby: "Хобби",
      humor: "Юмор",
      sports: "Спорт",
      technology: "Технологии",
      fun: "Просто для веселья",
    },
    optionsLabel: "Варианты",
    examplesHeading: "Примеры вопросов по категориям",
    ctaTitle: "Теперь напишите свои",
    ctaDesc:
      "В Qulo вы пишете от 2 до 4 вопросов на бесплатном тарифе и до 10 — на платном, а пара находится только с тем, кто ответит верно на все.",
    ctaLink: "Установить Qulo →",
  },
  pt: {
    title: "Perguntas para apps de namoro: o que perguntar e como escrever as suas",
    intro:
      "No Qulo o match acontece quando alguém acerta as suas perguntas: a que você escreve decide quem passa. Veja como escrever uma que funciona, com 22 exemplos.",
    categories: {
      personality: "Personalidade",
      lifestyle: "Estilo de vida",
      travel: "Viagens",
      food: "Comida",
      music: "Música",
      film: "Filmes e séries",
      hobby: "Hobbies",
      humor: "Humor",
      sports: "Esporte",
      technology: "Tecnologia",
      fun: "Só por diversão",
    },
    optionsLabel: "Opções",
    examplesHeading: "Exemplos de perguntas por categoria",
    ctaTitle: "Agora escreva as suas",
    ctaDesc:
      "No Qulo você escreve de 2 a 4 perguntas no plano gratuito e até 10 num plano pago, e dá match com quem acerta todas elas.",
    ctaLink: "Baixar o Qulo →",
  },
  it: {
    title: "Domande per le app di incontri: quali fare e come scrivere le tue",
    intro:
      "Su Qulo si fa match rispondendo bene alle domande dell'altro: la tua decide chi passa. Ecco come scriverne una che funziona, con 22 esempi.",
    categories: {
      personality: "Personalità",
      lifestyle: "Stile di vita",
      travel: "Viaggi",
      food: "Cibo",
      music: "Musica",
      film: "Film e serie",
      hobby: "Hobby",
      humor: "Umorismo",
      sports: "Sport",
      technology: "Tecnologia",
      fun: "Solo per divertimento",
    },
    optionsLabel: "Opzioni",
    examplesHeading: "Domande di esempio per categoria",
    ctaTitle: "Ora scrivi le tue",
    ctaDesc:
      "Su Qulo scrivi da 2 a 4 domande con il piano gratuito e fino a 10 con un piano a pagamento, e fai match con chi le indovina tutte.",
    ctaLink: "Scarica Qulo →",
  },
  ja: {
    title: "マッチングアプリの質問例と、自分で書くときのコツ",
    intro:
      "Quloでは相手の質問に正解してマッチします。あなたが書いた質問が、誰を通すかを決める——うまくいく質問の書き方を、22の例とあわせて。",
    categories: {
      personality: "性格",
      lifestyle: "ライフスタイル",
      travel: "旅行",
      food: "食べもの",
      music: "音楽",
      film: "映画とドラマ",
      hobby: "趣味",
      humor: "ユーモア",
      sports: "スポーツ",
      technology: "テクノロジー",
      fun: "お楽しみ",
    },
    optionsLabel: "選択肢",
    examplesHeading: "カテゴリー別の質問例",
    ctaTitle: "次は自分の質問を",
    ctaDesc:
      "Quloでは無料プランで2〜4問、有料プランなら最大10問の質問を用意し、そのすべてに正解した相手とマッチします。",
    ctaLink: "Quloを入手 →",
  },
  ko: {
    title: "데이팅 앱 질문 예시와 직접 쓰는 법",
    intro:
      "Qulo에서는 상대의 질문을 맞혀야 매칭됩니다. 당신이 쓴 질문이 누가 통과할지를 정하죠. 잘 통하는 질문 쓰는 법과 22가지 예시.",
    categories: {
      personality: "성격",
      lifestyle: "라이프스타일",
      travel: "여행",
      food: "음식",
      music: "음악",
      film: "영화와 드라마",
      hobby: "취미",
      humor: "유머",
      sports: "스포츠",
      technology: "기술",
      fun: "그냥 재미로",
    },
    optionsLabel: "선택지",
    examplesHeading: "카테고리별 질문 예시",
    ctaTitle: "이제 직접 써 볼 차례",
    ctaDesc:
      "Qulo에서는 무료 플랜에서 질문 2~4개, 유료 플랜에서는 최대 10개를 만들고, 그걸 전부 맞힌 사람과 매칭됩니다.",
    ctaLink: "Qulo 받기 →",
  },
  zh: {
    title: "约会应用问什么问题，以及怎么自己写",
    intro:
      "在 Qulo，答对对方的问题才能配对，所以你写的问题决定了谁能通过。这里讲怎么写出管用的问题，并附 22 个示例。",
    categories: {
      personality: "性格",
      lifestyle: "生活方式",
      travel: "旅行",
      food: "美食",
      music: "音乐",
      film: "影视",
      hobby: "爱好",
      humor: "幽默",
      sports: "运动",
      technology: "科技",
      fun: "纯属好玩",
    },
    optionsLabel: "选项",
    examplesHeading: "分类问题示例",
    ctaTitle: "轮到你写了",
    ctaDesc:
      "在 Qulo，免费版可以写 2 到 4 个问题，付费会员最多 10 个，只有全部答对的人才能和你配对。",
    ctaLink: "下载 Qulo →",
  },
  nl: {
    title: "Vragen voor datingapps: wat je vraagt en hoe je ze zelf schrijft",
    intro:
      "Op Qulo match je door de vragen van iemand anders goed te beantwoorden: jouw vraag bepaalt wie erdoor komt. Zo schrijf je er een die werkt, met 22 voorbeelden.",
    categories: {
      personality: "Persoonlijkheid",
      lifestyle: "Levensstijl",
      travel: "Reizen",
      food: "Eten",
      music: "Muziek",
      film: "Films en series",
      hobby: "Hobby's",
      humor: "Humor",
      sports: "Sport",
      technology: "Technologie",
      fun: "Gewoon voor de lol",
    },
    optionsLabel: "Antwoordopties",
    examplesHeading: "Voorbeeldvragen per categorie",
    ctaTitle: "Nu die van jou",
    ctaDesc:
      "Op Qulo schrijf je 2 tot 4 vragen in het gratis plan en tot 10 met een betaald abonnement, en match je met wie ze allemaal goed heeft.",
    ctaLink: "Qulo downloaden →",
  },
  pl: {
    title: "Pytania w aplikacjach randkowych: o co pytać i jak napisać własne",
    intro:
      "W Qulo łączysz się, odpowiadając dobrze na cudze pytania — twoje decyduje, kto przejdzie. Oto jak napisać takie, które działa, plus 22 przykłady.",
    categories: {
      personality: "Charakter",
      lifestyle: "Styl życia",
      travel: "Podróże",
      food: "Jedzenie",
      music: "Muzyka",
      film: "Filmy i seriale",
      hobby: "Hobby",
      humor: "Poczucie humoru",
      sports: "Sport",
      technology: "Technologia",
      fun: "Tak dla zabawy",
    },
    optionsLabel: "Odpowiedzi",
    examplesHeading: "Przykładowe pytania według kategorii",
    ctaTitle: "Teraz napisz własne",
    ctaDesc:
      "W Qulo piszesz od 2 do 4 pytań w planie darmowym i do 10 w planie płatnym, a łączysz się z kimś dopiero wtedy, gdy odpowie dobrze na wszystkie.",
    ctaLink: "Pobierz Qulo →",
  },
  sv: {
    title: "Frågor i dejtingappar: vad du frågar och hur du skriver egna",
    intro:
      "På Qulo matchar du genom att svara rätt på någon annans frågor — din fråga avgör vem som tar sig igenom. Så skriver du en som funkar, med 22 exempel.",
    categories: {
      personality: "Personlighet",
      lifestyle: "Livsstil",
      travel: "Resor",
      food: "Mat",
      music: "Musik",
      film: "Film och serier",
      hobby: "Fritidsintressen",
      humor: "Humor",
      sports: "Sport",
      technology: "Teknik",
      fun: "Bara på skoj",
    },
    optionsLabel: "Svarsalternativ",
    examplesHeading: "Exempelfrågor per kategori",
    ctaTitle: "Nu skriver du dina egna",
    ctaDesc:
      "På Qulo skriver du 2 till 4 frågor i gratisplanen och upp till 10 med ett betalt abonnemang, och matchar med den som svarar rätt på allihop.",
    ctaLink: "Hämta Qulo →",
  },
  hi: {
    title: "डेटिंग ऐप के सवाल: क्या पूछें और अपने सवाल कैसे लिखें",
    intro:
      "Qulo पर मैच तब होता है जब कोई आपके सवालों का सही जवाब दे — यानी आपका सवाल तय करता है कि कौन पहुँचेगा। काम करने वाला सवाल कैसे लिखें, 22 उदाहरणों के साथ।",
    categories: {
      personality: "व्यक्तित्व",
      lifestyle: "जीवनशैली",
      travel: "यात्रा",
      food: "खाना",
      music: "संगीत",
      film: "फ़िल्म और शो",
      hobby: "शौक",
      humor: "हास्य",
      sports: "खेल",
      technology: "तकनीक",
      fun: "बस मज़े के लिए",
    },
    optionsLabel: "विकल्प",
    examplesHeading: "श्रेणी के अनुसार सवालों के उदाहरण",
    ctaTitle: "अब अपने सवाल लिखिए",
    ctaDesc:
      "Qulo पर आप मुफ़्त प्लान में 2 से 4 सवाल लिखते हैं और सशुल्क प्लान में 10 तक; मैच सिर्फ़ उसी से होता है जो सब सही जवाब दे।",
    ctaLink: "Qulo डाउनलोड करें →",
  },
};
