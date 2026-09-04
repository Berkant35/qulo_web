/**
 * UI chrome for /glossary and /glossary/[slug].
 *
 * Kept apart from the term content so the furniture can be translated
 * independently, and complete for all 16 locales — the pages must not fall back
 * to English for anything a reader sees.
 *
 * `question` is the H1 and <title> template. It carries `%s` where the term
 * goes, because "what is X" is phrased differently enough per language that a
 * concatenation would read wrong ("Ghosting nedir?", "Что такое ghosting?",
 * "ghostingとは？").
 *
 * IMPORTANT — every template must be grammatical for EVERY term, because one
 * string is reused across all 27 of them. That rules out any phrasing needing
 * agreement with the noun that follows:
 *
 *  - Korean "%s란?" only works after a vowel; a consonant-final term needs
 *    이란 ("클로킹이란?", not "클로킹란?"). Most Korean loanwords end in a
 *    consonant, so that template was ungrammatical on nearly the whole
 *    glossary. Now "%s 뜻" — no particle alternation, and it is also what
 *    Korean speakers actually type ("고스팅 뜻").
 *  - French "le %s" gives "le orbiting" with no elision, and hard-codes the
 *    masculine. "Que veut dire %s ?" needs no article at all.
 *  - Italian "il %s" gives "il zombieing"; Italian wants `lo` before z-.
 *    "Che cosa significa %s?" sidesteps it.
 *  - Spanish "el %s" hard-codes the masculine and breaks on any feminine term.
 *    "¿Qué significa %s?" does not.
 *
 * The remaining twelve languages need no article before the term, so they are
 * left as the natural "what is X" phrasing. Do not reintroduce an article.
 */
export interface GlossaryLabels {
  hubTitle: string;
  hubIntro: string;
  quickNav: string;
  question: string;
  inShort: string;
  related: string;
  readMore: string;
  backToGlossary: string;
  ctaTitle: string;
  ctaDesc: string;
  ctaLink: string;
}

export const GLOSSARY_LABELS: Record<string, GlossaryLabels> = {
  en: {
    hubTitle: "Dating Glossary",
    hubIntro:
      "The words people actually use when they talk about dating, defined plainly. Each term has its own page with what it means, how to spot it and what to do about it.",
    quickNav: "Jump to a letter",
    question: "What is %s?",
    inShort: "In short",
    related: "Related terms",
    readMore: "Read more on this",
    backToGlossary: "All terms",
    ctaTitle: "Tired of guessing where you stand?",
    ctaDesc:
      "On Qulo you write 2 to 4 questions and match with whoever gets them right. No swiping, free to use.",
    ctaLink: "Get Qulo →",
  },
  tr: {
    hubTitle: "Flört Sözlüğü",
    hubIntro:
      "İnsanların flört ederken gerçekten kullandığı kelimeler, sade bir dille. Her terimin kendi sayfası var: ne demek, nasıl anlaşılır, ne yapmalı.",
    quickNav: "Harfe git",
    question: "%s nedir?",
    inShort: "Kısaca",
    related: "İlgili terimler",
    readMore: "Bu konuyu ayrıntılı oku",
    backToGlossary: "Tüm terimler",
    ctaTitle: "Nerede durduğunu tahmin etmekten yorulduysan",
    ctaDesc:
      "Qulo'da 2 ila 4 soru yazarsın, onları doğru bilenle eşleşirsin. Kaydırma yok, kullanımı ücretsiz.",
    ctaLink: "Qulo'yu indir →",
  },
  de: {
    hubTitle: "Dating-Glossar",
    hubIntro:
      "Die Wörter, die beim Daten wirklich benutzt werden – klar erklärt. Jeder Begriff hat eine eigene Seite: was er bedeutet, woran man ihn erkennt und was man tun kann.",
    quickNav: "Zu einem Buchstaben springen",
    question: "Was ist %s?",
    inShort: "Kurz gesagt",
    related: "Verwandte Begriffe",
    readMore: "Mehr dazu lesen",
    backToGlossary: "Alle Begriffe",
    ctaTitle: "Keine Lust mehr zu rätseln, woran du bist?",
    ctaDesc:
      "Bei Qulo schreibst du 2 bis 4 Fragen und matchst mit denen, die sie richtig beantworten. Kein Wischen, kostenlos.",
    ctaLink: "Qulo holen →",
  },
  fr: {
    hubTitle: "Glossaire des rencontres",
    hubIntro:
      "Les mots qu'on emploie vraiment quand on parle de rencontres, expliqués simplement. Chaque terme a sa page : ce qu'il veut dire, comment le repérer, quoi en faire.",
    quickNav: "Aller à une lettre",
    question: "Que veut dire %s ?",
    inShort: "En bref",
    related: "Termes liés",
    readMore: "En lire plus à ce sujet",
    backToGlossary: "Tous les termes",
    ctaTitle: "Marre de deviner où vous en êtes ?",
    ctaDesc:
      "Sur Qulo, vous écrivez 2 à 4 questions et matchez avec ceux qui répondent juste. Sans swipe, gratuit.",
    ctaLink: "Télécharger Qulo →",
  },
  es: {
    hubTitle: "Glosario de citas",
    hubIntro:
      "Las palabras que la gente usa de verdad al hablar de citas, explicadas sin rodeos. Cada término tiene su página: qué significa, cómo detectarlo y qué hacer.",
    quickNav: "Ir a una letra",
    question: "¿Qué significa %s?",
    inShort: "En resumen",
    related: "Términos relacionados",
    readMore: "Leer más sobre esto",
    backToGlossary: "Todos los términos",
    ctaTitle: "¿Cansado de adivinar en qué punto estás?",
    ctaDesc:
      "En Qulo escribes de 2 a 4 preguntas y haces match con quien las acierta. Sin deslizar, gratis.",
    ctaLink: "Descargar Qulo →",
  },
  ar: {
    hubTitle: "قاموس المواعدة",
    hubIntro:
      "الكلمات التي يستخدمها الناس فعلاً عند الحديث عن المواعدة، مشروحة ببساطة. لكل مصطلح صفحته: ماذا يعني، وكيف تلاحظه، وماذا تفعل حياله.",
    quickNav: "انتقل إلى حرف",
    question: "ما معنى %s؟",
    inShort: "باختصار",
    related: "مصطلحات ذات صلة",
    readMore: "اقرأ المزيد حول هذا",
    backToGlossary: "كل المصطلحات",
    ctaTitle: "سئمت من تخمين موقعك في العلاقة؟",
    ctaDesc:
      "في Qulo تكتب من سؤالين إلى أربعة أسئلة وتتطابق مع من يجيب عنها بشكل صحيح. بلا تمرير، والاستخدام مجاني.",
    ctaLink: "حمّل Qulo →",
  },
  ru: {
    hubTitle: "Словарь знакомств",
    hubIntro:
      "Слова, которыми люди действительно описывают знакомства, объяснённые просто. У каждого термина своя страница: что это значит, как это распознать и что с этим делать.",
    quickNav: "Перейти к букве",
    question: "Что такое %s?",
    inShort: "Коротко",
    related: "Похожие термины",
    readMore: "Подробнее об этом",
    backToGlossary: "Все термины",
    ctaTitle: "Устали гадать, на каком вы свете?",
    ctaDesc:
      "В Qulo вы пишете от 2 до 4 вопросов и совпадаете с теми, кто ответил на них верно. Без свайпов, бесплатно.",
    ctaLink: "Установить Qulo →",
  },
  pt: {
    hubTitle: "Glossário de relacionamentos",
    hubIntro:
      "As palavras que as pessoas realmente usam quando falam de paquera, explicadas sem enrolação. Cada termo tem sua página: o que significa, como perceber e o que fazer.",
    quickNav: "Ir para uma letra",
    question: "O que é %s?",
    inShort: "Em resumo",
    related: "Termos relacionados",
    readMore: "Leia mais sobre isso",
    backToGlossary: "Todos os termos",
    ctaTitle: "Cansado de adivinhar em que pé você está?",
    ctaDesc:
      "No Qulo você escreve de 2 a 4 perguntas e dá match com quem acerta todas. Sem deslizar, de graça.",
    ctaLink: "Baixar o Qulo →",
  },
  it: {
    hubTitle: "Glossario degli appuntamenti",
    hubIntro:
      "Le parole che si usano davvero quando si parla di appuntamenti, spiegate in modo chiaro. Ogni termine ha la sua pagina: cosa significa, come riconoscerlo e cosa fare.",
    quickNav: "Vai a una lettera",
    question: "Che cosa significa %s?",
    inShort: "In breve",
    related: "Termini correlati",
    readMore: "Approfondisci",
    backToGlossary: "Tutti i termini",
    ctaTitle: "Stanco di indovinare a che punto sei?",
    ctaDesc:
      "Su Qulo scrivi da 2 a 4 domande e fai match con chi risponde giusto. Niente swipe, gratis.",
    ctaLink: "Scarica Qulo →",
  },
  ja: {
    hubTitle: "恋愛用語集",
    hubIntro:
      "恋愛の話で実際に使われる言葉を、わかりやすく解説します。用語ごとに専用ページがあり、意味・見分け方・対処法をまとめています。",
    quickNav: "頭文字から探す",
    question: "%sとは？",
    inShort: "ひとことで言うと",
    related: "関連する用語",
    readMore: "この話題をもっと読む",
    backToGlossary: "用語一覧",
    ctaTitle: "相手の気持ちを推し量るのに疲れたら",
    ctaDesc:
      "Quloでは2〜4問の質問を用意し、全問正解した相手とマッチします。スワイプなし、無料で使えます。",
    ctaLink: "Quloを入手 →",
  },
  ko: {
    hubTitle: "데이팅 용어 사전",
    hubIntro:
      "연애 이야기에서 실제로 쓰이는 말들을 쉽게 풀어 설명합니다. 용어마다 별도 페이지가 있어 뜻, 알아채는 법, 대처법을 담았습니다.",
    quickNav: "첫 글자로 찾기",
    question: "%s 뜻",
    inShort: "한마디로",
    related: "관련 용어",
    readMore: "이 주제 더 읽기",
    backToGlossary: "전체 용어",
    ctaTitle: "지금 어떤 사이인지 짐작만 하는 게 지쳤다면",
    ctaDesc:
      "Qulo에서는 2~4개의 질문을 만들고, 그걸 모두 맞힌 사람과 매칭됩니다. 스와이프 없이, 무료로.",
    ctaLink: "Qulo 받기 →",
  },
  zh: {
    hubTitle: "约会词汇表",
    hubIntro:
      "人们谈恋爱时真正在用的词，用大白话讲清楚。每个词都有独立页面：什么意思、怎么看出来、该怎么办。",
    quickNav: "按字母跳转",
    question: "%s是什么意思？",
    inShort: "一句话解释",
    related: "相关词条",
    readMore: "延伸阅读",
    backToGlossary: "全部词条",
    ctaTitle: "厌倦了猜对方到底怎么想？",
    ctaDesc:
      "在 Qulo，你写 2 到 4 个问题，全部答对的人才能和你配对。不用左右滑，免费使用。",
    ctaLink: "下载 Qulo →",
  },
  nl: {
    hubTitle: "Datingwoordenboek",
    hubIntro:
      "De woorden die mensen echt gebruiken als het over daten gaat, gewoon uitgelegd. Elke term heeft een eigen pagina: wat het betekent, hoe je het herkent en wat je eraan doet.",
    quickNav: "Spring naar een letter",
    question: "Wat is %s?",
    inShort: "Kort gezegd",
    related: "Verwante termen",
    readMore: "Lees hier meer over",
    backToGlossary: "Alle termen",
    ctaTitle: "Klaar met gissen waar je aan toe bent?",
    ctaDesc:
      "Op Qulo schrijf je 2 tot 4 vragen en match je met wie ze goed beantwoordt. Geen swipen, gratis.",
    ctaLink: "Qulo downloaden →",
  },
  pl: {
    hubTitle: "Słowniczek randkowy",
    hubIntro:
      "Słowa, których ludzie naprawdę używają, mówiąc o randkowaniu, wyjaśnione po ludzku. Każde hasło ma własną stronę: co znaczy, po czym je poznać i co z tym zrobić.",
    quickNav: "Przejdź do litery",
    question: "Co to jest %s?",
    inShort: "W skrócie",
    related: "Powiązane hasła",
    readMore: "Przeczytaj więcej na ten temat",
    backToGlossary: "Wszystkie hasła",
    ctaTitle: "Masz dość zgadywania, na czym stoisz?",
    ctaDesc:
      "W Qulo piszesz od 2 do 4 pytań i łączysz się z tym, kto odpowie na wszystkie dobrze. Bez przesuwania, za darmo.",
    ctaLink: "Pobierz Qulo →",
  },
  sv: {
    hubTitle: "Dejtingordlista",
    hubIntro:
      "Orden folk faktiskt använder när de pratar om dejting, förklarade rakt på sak. Varje ord har en egen sida: vad det betyder, hur du känner igen det och vad du gör åt det.",
    quickNav: "Hoppa till en bokstav",
    question: "Vad är %s?",
    inShort: "Kort sagt",
    related: "Relaterade ord",
    readMore: "Läs mer om det här",
    backToGlossary: "Alla ord",
    ctaTitle: "Trött på att gissa var ni står?",
    ctaDesc:
      "På Qulo skriver du 2 till 4 frågor och matchar med den som svarar rätt på alla. Ingen swipe, gratis.",
    ctaLink: "Hämta Qulo →",
  },
  hi: {
    hubTitle: "डेटिंग शब्दकोश",
    hubIntro:
      "डेटिंग की बातचीत में लोग जो शब्द सचमुच इस्तेमाल करते हैं, आसान भाषा में समझाए गए। हर शब्द का अपना पेज है: इसका मतलब, इसे कैसे पहचानें और क्या करें।",
    quickNav: "अक्षर पर जाएँ",
    question: "%s क्या है?",
    inShort: "संक्षेप में",
    related: "मिलते-जुलते शब्द",
    readMore: "इस पर और पढ़ें",
    backToGlossary: "सभी शब्द",
    ctaTitle: "अंदाज़ा लगाते रहना थका देता है?",
    ctaDesc:
      "Qulo पर आप 2 से 4 सवाल लिखते हैं और जो सब सही जवाब दे, उसी से मैच होता है। कोई स्वाइप नहीं, इस्तेमाल मुफ़्त।",
    ctaLink: "Qulo डाउनलोड करें →",
  },
};
