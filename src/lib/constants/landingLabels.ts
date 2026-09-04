/**
 * UI chrome for the /features hub and the three landing pages under it.
 *
 * Split out from the pages themselves on 2026-09-04. Both pages used to carry
 * `isTr ? "..." : "..."` for every fixed string, so fourteen locales got
 * English section headings under a translated <h1>, and the Turkish half was
 * ASCII-stripped ("Ozellikler", "Nasil Calisir?"). Content and furniture are
 * translated separately, in the same way ANSWER_LABELS works for /answers.
 *
 * `hubIntro` used to advertise "AI question suggestions". This page set now
 * describes only the matching mechanic the three landing pages are about.
 */
export interface LandingLabels {
  /** Breadcrumb label and hub eyebrow for the Features section. */
  section: string;
  hubTitle: string;
  hubIntro: string;
  howItWorks: string;
  ctaTitle: string;
  ctaDesc: string;
  navAbout: string;
  navCities: string;
  navFeatures: string;
}

export const LANDING_LABELS: Record<string, LandingLabels> = {
  en: {
    section: "Features",
    hubTitle: "What Qulo Does Differently",
    hubIntro:
      "Three pages on one mechanic: you write two to four questions about yourself — up to ten on a paid plan, and someone matches with you by getting every one of them right.",
    howItWorks: "How It Works",
    ctaTitle: "Download Qulo, free",
    ctaDesc:
      "Write your questions, answer someone else's, and match on a perfect set.",
    navAbout: "About",
    navCities: "Dating in Cities",
    navFeatures: "All Features",
  },
  tr: {
    section: "Özellikler",
    hubTitle: "Qulo Neyi Farklı Yapıyor?",
    hubIntro:
      "Tek bir mekaniğin üç sayfası: kendin hakkında 2 ila 4 soru yazarsın — ücretli planda 10'a kadar, biri hepsini doğru bilerek seninle eşleşir.",
    howItWorks: "Nasıl Çalışır?",
    ctaTitle: "Qulo'yu ücretsiz indir",
    ctaDesc:
      "Sorularını yaz, başkasının sorularını çöz ve eksiksiz bir setle eşleş.",
    navAbout: "Hakkında",
    navCities: "Şehirlerde Tanışma",
    navFeatures: "Tüm Özellikler",
  },
  de: {
    section: "Funktionen",
    hubTitle: "Was Qulo anders macht",
    hubIntro:
      "Drei Seiten über eine Mechanik: Du schreibst 2 bis 4 Fragen über dich — bis zu 10 im kostenpflichtigen Tarif, und jemand matcht mit dir, indem er jede einzelne richtig hat.",
    howItWorks: "So funktioniert es",
    ctaTitle: "Qulo kostenlos herunterladen",
    ctaDesc:
      "Schreib deine Fragen, beantworte die von jemand anderem und matche mit einem fehlerfreien Set.",
    navAbout: "Über uns",
    navCities: "Dating in Städten",
    navFeatures: "Alle Funktionen",
  },
  fr: {
    section: "Fonctionnalités",
    hubTitle: "Ce que Qulo fait autrement",
    hubIntro:
      "Trois pages sur un seul mécanisme : vous écrivez de 2 à 4 questions sur vous — jusqu'à 10 avec un abonnement payant, et on matche avec vous en les trouvant toutes.",
    howItWorks: "Comment ça marche",
    ctaTitle: "Téléchargez Qulo, gratuitement",
    ctaDesc:
      "Écrivez vos questions, répondez à celles d'une autre personne et matchez sur une série parfaite.",
    navAbout: "À propos",
    navCities: "Rencontres par ville",
    navFeatures: "Toutes les fonctionnalités",
  },
  es: {
    section: "Características",
    hubTitle: "Qué hace Qulo de otra manera",
    hubIntro:
      "Tres páginas sobre un mismo mecanismo: escribes de 2 a 4 preguntas sobre ti — hasta 10 con un plan de pago y alguien hace match contigo acertándolas todas.",
    howItWorks: "Cómo funciona",
    ctaTitle: "Descarga Qulo gratis",
    ctaDesc:
      "Escribe tus preguntas, responde las de otra persona y haz match con una tanda perfecta.",
    navAbout: "Sobre nosotros",
    navCities: "Citas por ciudad",
    navFeatures: "Todas las características",
  },
  ar: {
    section: "الميزات",
    hubTitle: "ما الذي يفعله Qulo على نحو مختلف",
    hubIntro:
      "ثلاث صفحات عن آلية واحدة: تكتب بين سؤالين و4 أسئلة عن نفسك — حتى 10 أسئلة في الخطة المدفوعة، ويتطابق معك من يجيب عنها كلها إجابة صحيحة.",
    howItWorks: "كيف يعمل",
    ctaTitle: "حمّل Qulo مجانًا",
    ctaDesc:
      "اكتب أسئلتك، وأجب عن أسئلة غيرك، وتطابَق بمجموعة كاملة الصحّة.",
    navAbout: "عن التطبيق",
    navCities: "التعارف في المدن",
    navFeatures: "كل الميزات",
  },
  ru: {
    section: "Функции",
    hubTitle: "Что Qulo делает иначе",
    hubIntro:
      "Три страницы об одной механике: вы пишете от 2 до 4 вопросов о себе — до 10 на платном тарифе, и совпадение возникает у того, кто ответит верно на все.",
    howItWorks: "Как это работает",
    ctaTitle: "Скачайте Qulo бесплатно",
    ctaDesc:
      "Напишите свои вопросы, ответьте на чужие и совпадите на безошибочном наборе.",
    navAbout: "О приложении",
    navCities: "Знакомства по городам",
    navFeatures: "Все функции",
  },
  pt: {
    section: "Recursos",
    hubTitle: "O que o Qulo faz de outro jeito",
    hubIntro:
      "Três páginas sobre um mesmo mecanismo: você escreve de 2 a 4 perguntas sobre si — até 10 num plano pago, e alguém combina com você acertando todas.",
    howItWorks: "Como funciona",
    ctaTitle: "Baixe o Qulo de graça",
    ctaDesc:
      "Escreva as suas perguntas, responda às de outra pessoa e combine com um conjunto perfeito.",
    navAbout: "Sobre",
    navCities: "Encontros por cidade",
    navFeatures: "Todos os recursos",
  },
  it: {
    section: "Caratteristiche",
    hubTitle: "Che cosa fa Qulo in modo diverso",
    hubIntro:
      "Tre pagine su un unico meccanismo: scrivi da 2 a 4 domande su di te — fino a 10 con un piano a pagamento, e fa match con te chi le indovina tutte.",
    howItWorks: "Come funziona",
    ctaTitle: "Scarica Qulo gratis",
    ctaDesc:
      "Scrivi le tue domande, rispondi a quelle di un altro e fai match con una serie perfetta.",
    navAbout: "Chi siamo",
    navCities: "Incontri per città",
    navFeatures: "Tutte le caratteristiche",
  },
  ja: {
    section: "機能",
    hubTitle: "Quloがほかと違うところ",
    hubIntro:
      "ひとつの仕組みについての3ページ。自分について2〜4問（有料プランなら最大10問）の質問を書き、そのすべてに正解した人とマッチします。",
    howItWorks: "使い方",
    ctaTitle: "Quloを無料でダウンロード",
    ctaDesc:
      "自分の質問を書き、誰かの質問に答え、全問正解でマッチしましょう。",
    navAbout: "Quloについて",
    navCities: "都市別の出会い",
    navFeatures: "すべての機能",
  },
  ko: {
    section: "기능",
    hubTitle: "Qulo가 다르게 하는 것",
    hubIntro:
      "하나의 방식에 대한 세 페이지. 나에 대한 질문을 2~4개(유료 플랜은 최대 10개) 쓰고, 그것을 모두 맞힌 사람과 매칭됩니다.",
    howItWorks: "이렇게 작동합니다",
    ctaTitle: "Qulo 무료로 내려받기",
    ctaDesc:
      "내 질문을 쓰고, 상대의 질문에 답하고, 빈틈없는 세트로 매칭되세요.",
    navAbout: "소개",
    navCities: "도시별 만남",
    navFeatures: "모든 기능",
  },
  zh: {
    section: "功能",
    hubTitle: "Qulo 有什么不一样",
    hubIntro:
      "围绕同一套机制的三个页面：你写下关于自己的 2 到 4 道题（付费方案最多 10 道），别人全部答对才与你配对。",
    howItWorks: "运作方式",
    ctaTitle: "免费下载 Qulo",
    ctaDesc: "写下你的题目，去答别人的题，用一组全对的答案配对。",
    navAbout: "关于",
    navCities: "各城市交友",
    navFeatures: "全部功能",
  },
  nl: {
    section: "Functies",
    hubTitle: "Wat Qulo anders doet",
    hubIntro:
      "Drie pagina's over één mechaniek: je schrijft 2 tot 4 vragen over jezelf — tot 10 met een betaald abonnement, en iemand matcht met jou door ze allemaal goed te hebben.",
    howItWorks: "Hoe het werkt",
    ctaTitle: "Download Qulo, gratis",
    ctaDesc:
      "Schrijf je vragen, beantwoord die van een ander en match op een foutloze set.",
    navAbout: "Over ons",
    navCities: "Daten per stad",
    navFeatures: "Alle functies",
  },
  pl: {
    section: "Funkcje",
    hubTitle: "Co Qulo robi inaczej",
    hubIntro:
      "Trzy strony o jednym mechanizmie: piszesz od 2 do 4 pytań o sobie — do 10 w planie płatnym, a dopasowuje się z tobą ten, kto trafi wszystkie.",
    howItWorks: "Jak to działa",
    ctaTitle: "Pobierz Qulo za darmo",
    ctaDesc:
      "Napisz swoje pytania, odpowiedz na cudze i dopasuj się bezbłędnym zestawem.",
    navAbout: "O nas",
    navCities: "Randki w miastach",
    navFeatures: "Wszystkie funkcje",
  },
  sv: {
    section: "Funktioner",
    hubTitle: "Det Qulo gör annorlunda",
    hubIntro:
      "Tre sidor om en och samma mekanik: du skriver 2 till 4 frågor om dig själv — upp till 10 med ett betalt abonnemang, och den som har alla rätt matchar med dig.",
    howItWorks: "Så fungerar det",
    ctaTitle: "Ladda ner Qulo gratis",
    ctaDesc:
      "Skriv dina frågor, svara på någon annans och matcha på en felfri omgång.",
    navAbout: "Om oss",
    navCities: "Dejting i städer",
    navFeatures: "Alla funktioner",
  },
  hi: {
    section: "विशेषताएं",
    hubTitle: "Qulo क्या अलग करता है",
    hubIntro:
      "एक ही तरीक़े पर तीन पन्ने: आप अपने बारे में 2 से 4 सवाल लिखते हैं — भुगतान वाली योजना में 10 तक, और जो उन सबका सही जवाब दे, उससे मैच होता है।",
    howItWorks: "यह कैसे काम करता है",
    ctaTitle: "Qulo मुफ़्त डाउनलोड कीजिए",
    ctaDesc:
      "अपने सवाल लिखिए, किसी और के सवाल हल कीजिए और बिना ग़लती वाले सेट पर मैच पाइए।",
    navAbout: "परिचय",
    navCities: "शहरों में डेटिंग",
    navFeatures: "सभी विशेषताएं",
  },
};

/** Resolve the label set for a locale, falling back to English. */
export function landingLabels(locale: string): LandingLabels {
  return LANDING_LABELS[locale] || LANDING_LABELS.en;
}
