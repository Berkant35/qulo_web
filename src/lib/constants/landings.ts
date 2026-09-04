/**
 * The three /features/[slug] landing pages: their SEO metadata and the shape of
 * their body content.
 *
 * Rewritten 2026-09-04. Three things were removed here and in the page body,
 * and none of them should come back:
 *
 *  1. "the world's first quiz-based dating app" / "dünyanın ilk quiz tabanlı
 *     dating uygulamasıdır" and its de/fr/es variants. Nobody can verify a
 *     first-in-the-world claim, so it was replaced by a description of what the
 *     app actually does.
 *  2. "Research shows that over 80% of swipe-based matches never lead to a
 *     lasting connection" and "a decision that typically takes less than a
 *     second" — an unsourced figure and a bare duration dressed as a finding.
 *     The same two claims had already been deleted from the blog. Where the
 *     argument still needed making, it was rewritten qualitatively.
 *  3. Everything the app does not do: ID verification, photo screening,
 *     fake-profile detection, personality measurement, compatibility scores.
 *
 * Only one external figure is used across these pages — the Forbes Health /
 * OnePoll 2024 burnout survey — and it is written out with publisher, year and
 * sample in the same sentence. See FORBES_ONEPOLL_2024 in
 * src/lib/constants/stats.ts. Any new number needs the same treatment or it
 * does not ship.
 *
 * Brand rule: Qulo is the only dating app that may be named on this site.
 * Everything else is "dating apps" or "swipe-based apps".
 */

export interface LandingPage {
  slug: string;
  primaryKeyword: string;
  titles: Record<string, string>;
  descriptions: Record<string, string>;
  keywords: string[];
}

/** A headed bullet: a short label and the sentence under it. */
export interface LandingPoint {
  title: string;
  desc: string;
}

/**
 * The body of one landing page in one locale.
 *
 * `solutionBullets` used to be `string[]` split on the first ": " to find its
 * label. That silently failed wherever the language does not punctuate that
 * way — French spaces its colon, Japanese and Chinese use a full-width one — so
 * the split is gone and the two halves are separate fields.
 */
export interface LandingContent {
  heroTitle: string;
  heroSub: string;
  problemTitle: string;
  problemParagraphs: string[];
  solutionTitle: string;
  solutionBullets: LandingPoint[];
  steps: LandingPoint[];
}

export const LANDING_PAGES: LandingPage[] = [
  {
    slug: "quiz-dating-app",
    primaryKeyword: "quiz dating app",
    titles: {
      tr: "Quiz Dating App — Sorularla Eşleş | Qulo",
      en: "Quiz Dating App — Match Through Questions | Qulo",
      de: "Quiz-Dating-App — Durch Fragen matchen | Qulo",
      fr: "App de dating quiz — Matchez grâce aux questions | Qulo",
      es: "App de citas tipo quiz — Haz match con preguntas | Qulo",
      ar: "تطبيق مواعدة بالأسئلة — تطابَق عبر الإجابات | Qulo",
      ru: "Дейтинг-приложение с вопросами — совпадение через ответы | Qulo",
      pt: "App de encontros em formato quiz — Combine pelas perguntas | Qulo",
      it: "App di dating a quiz — Trova il match con le domande | Qulo",
      ja: "クイズ型デーティングアプリ — 質問に答えてマッチ | Qulo",
      ko: "퀴즈형 데이팅 앱 — 질문으로 매칭 | Qulo",
      zh: "答题式交友应用 — 用问题配对 | Qulo",
      nl: "Quiz-datingapp — Match via vragen | Qulo",
      pl: "Randkowa aplikacja z quizem — dopasowanie przez pytania | Qulo",
      sv: "Quiz-dejtingapp — Matcha genom frågor | Qulo",
      hi: "क्विज़ डेटिंग ऐप — सवालों से मैच | Qulo",
    },
    descriptions: {
      tr: "Qulo'da birinin kendisi hakkında yazdığı 2-4 soruyu cevaplarsın. Hepsini doğru bilirsen eşleşirsin — kaydırma yok. Ücretsiz indir.",
      en: "On Qulo you answer the two to four questions someone wrote about themselves. Get every one right and you match — no swiping. Free to download.",
      de: "Bei Qulo beantwortest du die 2 bis 4 Fragen, die jemand über sich geschrieben hat. Alle richtig, und ihr matcht — ohne Swipen. Kostenlos.",
      fr: "Sur Qulo, vous répondez aux 2 à 4 questions qu'une personne a écrites sur elle-même. Tout juste, et c'est un match — sans swipe. Gratuit.",
      es: "En Qulo respondes las 2 a 4 preguntas que alguien escribió sobre sí mismo. Acierta todas y hay match, sin deslizar. Descarga gratis.",
      ar: "في Qulo تجيب عن الأسئلة التي كتبها شخص عن نفسه، وعددها من 2 إلى 4. أجب عنها كلها إجابة صحيحة فيحدث التطابق — بلا تمرير. التحميل مجاني.",
      ru: "В Qulo вы отвечаете на 2–4 вопроса, которые человек написал о себе. Все ответы верны — есть совпадение. Без свайпов. Бесплатно.",
      pt: "No Qulo você responde às 2 a 4 perguntas que alguém escreveu sobre si. Acertou todas, deu match — sem deslizar. Download gratuito.",
      it: "Su Qulo rispondi alle 2-4 domande che una persona ha scritto su di sé. Se le indovini tutte, è match — senza swipe. Download gratuito.",
      ja: "Quloでは、相手が自分について書いた2〜4問に答えます。全問正解でマッチ。スワイプはありません。無料でダウンロードできます。",
      ko: "Qulo에서는 상대가 자신에 대해 쓴 2~4개의 질문에 답합니다. 모두 맞히면 매칭됩니다. 스와이프는 없고, 다운로드는 무료입니다.",
      zh: "在 Qulo，你回答对方为自己写下的 2 到 4 道题。全部答对即配对，无需滑动。免费下载。",
      nl: "Op Qulo beantwoord je de 2 tot 4 vragen die iemand over zichzelf schreef. Alles goed en je hebt een match — zonder swipen. Gratis.",
      pl: "W Qulo odpowiadasz na 2–4 pytania, które ktoś napisał o sobie. Wszystkie poprawnie — jest dopasowanie. Bez przesuwania. Za darmo.",
      hi: "Qulo पर आप वे 2 से 4 सवाल हल करते हैं जो किसी ने अपने बारे में लिखे हैं। सब सही, तो मैच — बिना स्वाइप। मुफ़्त डाउनलोड।",
      sv: "På Qulo svarar du på de 2 till 4 frågor någon skrivit om sig själv. Alla rätt ger en matchning — utan svep. Ladda ner gratis.",
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
      tr: "Swipe Olmadan Tanışma — Kaydırmasız Dating | Qulo",
      en: "Dating Without Swiping — Another Way to Meet | Qulo",
      de: "Dating ohne Swipen — Eine andere Art, sich kennenzulernen | Qulo",
      fr: "Rencontres sans swipe — Une autre façon de se rencontrer | Qulo",
      es: "Citas sin deslizar — Otra forma de conocerse | Qulo",
      ar: "مواعدة بلا تمرير — طريقة أخرى للتعارف | Qulo",
      ru: "Знакомства без свайпов — другой способ встретиться | Qulo",
      pt: "Encontros sem deslizar — Outra forma de se conhecer | Qulo",
      it: "Dating senza swipe — Un altro modo di conoscersi | Qulo",
      ja: "スワイプしない出会い — もうひとつの方法 | Qulo",
      ko: "스와이프 없는 만남 — 또 다른 방법 | Qulo",
      zh: "不用滑动的交友 — 另一种认识方式 | Qulo",
      nl: "Daten zonder swipen — Een andere manier om elkaar te leren kennen | Qulo",
      pl: "Randki bez przesuwania — inny sposób poznawania się | Qulo",
      sv: "Dejta utan att svepa — ett annat sätt att mötas | Qulo",
      hi: "बिना स्वाइप डेटिंग — मिलने का दूसरा तरीका | Qulo",
    },
    descriptions: {
      tr: "Qulo'da kaydırılacak bir deste yok. Birinin kendisi hakkında yazdığı soruları cevaplarsın; hepsi doğruysa eşleşirsin. Ücretsiz indir.",
      en: "Qulo has no swipe deck. You answer the questions someone wrote about themselves, and a perfect score is the match. Free to download.",
      de: "Qulo hat keinen Swipe-Stapel. Du beantwortest die Fragen, die jemand über sich geschrieben hat — alle richtig, und ihr matcht. Kostenlos.",
      fr: "Qulo n'a pas de pile de profils à swiper. Vous répondez aux questions qu'une personne a écrites sur elle-même : sans faute, c'est un match.",
      es: "Qulo no tiene mazo de perfiles para deslizar. Respondes las preguntas que alguien escribió sobre sí mismo: sin fallos, hay match. Gratis.",
      ar: "لا يوجد في Qulo رصّة بطاقات للتمرير. تجيب عن الأسئلة التي كتبها شخص عن نفسه، وإجابة كاملة الصحّة هي التطابق. التحميل مجاني.",
      ru: "В Qulo нет колоды профилей для свайпа. Вы отвечаете на вопросы, которые человек написал о себе: все верно — есть совпадение. Бесплатно.",
      pt: "O Qulo não tem baralho de perfis para deslizar. Você responde às perguntas que alguém escreveu sobre si: tudo certo, deu match. Grátis.",
      it: "Qulo non ha un mazzo di profili da scorrere. Rispondi alle domande che una persona ha scritto su di sé: tutte giuste, è match. Gratis.",
      ja: "Quloにスワイプするカードの山はありません。相手が自分について書いた質問に答え、全問正解ならマッチです。無料でダウンロードできます。",
      ko: "Qulo에는 넘길 카드 더미가 없습니다. 상대가 자신에 대해 쓴 질문에 답하고, 모두 맞히면 매칭됩니다. 무료로 내려받으세요.",
      zh: "Qulo 没有可滑动的卡片堆。你回答对方为自己写下的问题，全部答对就是配对。免费下载。",
      nl: "Qulo heeft geen stapel om doorheen te swipen. Je beantwoordt de vragen die iemand over zichzelf schreef: alles goed is de match. Gratis.",
      pl: "W Qulo nie ma talii profili do przesuwania. Odpowiadasz na pytania, które ktoś napisał o sobie: komplet trafień to dopasowanie. Za darmo.",
      sv: "Qulo har ingen kortlek att svepa igenom. Du svarar på frågorna någon skrivit om sig själv: alla rätt är matchningen. Ladda ner gratis.",
      hi: "Qulo में स्वाइप करने के लिए कार्ड का ढेर नहीं है। आप वे सवाल हल करते हैं जो किसी ने अपने बारे में लिखे हैं; सब सही, तो मैच। मुफ़्त।",
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
      tr: "Kişilik Eşleşme Uygulaması — Kendi Sorularınla Eşleş | Qulo",
      en: "Personality Matching App — Matched by Your Own Questions | Qulo",
      de: "Persönlichkeits-Matching-App — Match über deine eigenen Fragen | Qulo",
      fr: "App de matching par la personnalité — Vos propres questions | Qulo",
      es: "App de match por personalidad — Con tus propias preguntas | Qulo",
      ar: "تطبيق تطابق بالشخصية — بأسئلتك أنت | Qulo",
      ru: "Приложение для совпадения по личности — по вашим вопросам | Qulo",
      pt: "App de match por personalidade — Com as suas perguntas | Qulo",
      it: "App di match per personalità — Con le tue domande | Qulo",
      ko: "성향 매칭 앱 — 내가 낸 질문으로 매칭 | Qulo",
      ja: "性格マッチングアプリ — 自分でつくった質問でマッチ | Qulo",
      zh: "性格匹配应用 — 用你自己的问题配对 | Qulo",
      nl: "Persoonlijkheids-matchingapp — Match via je eigen vragen | Qulo",
      pl: "Aplikacja dopasowania po osobowości — twoje własne pytania | Qulo",
      sv: "Matchningsapp för personlighet — dina egna frågor | Qulo",
      hi: "पर्सनैलिटी मैचिंग ऐप — अपने ही सवालों से मैच | Qulo",
    },
    descriptions: {
      tr: "Qulo kişilik testi yapmaz, puan hesaplamaz. Seni anlatan soruları sen yazarsın; hepsini doğru bilenle eşleşirsin. Ücretsiz indir.",
      en: "Qulo runs no personality test and calculates no score. You write the questions that say something about you, and match with whoever gets them all right.",
      de: "Qulo macht keinen Persönlichkeitstest und berechnet keinen Score. Du schreibst die Fragen, die etwas über dich sagen — wer alle richtig hat, matcht.",
      fr: "Qulo ne fait passer aucun test de personnalité et ne calcule aucun score. Vous écrivez les questions qui parlent de vous ; qui répond juste matche.",
      es: "Qulo no hace test de personalidad ni calcula puntuaciones. Tú escribes las preguntas que hablan de ti y haces match con quien las acierte todas.",
      ar: "لا يجري Qulo اختبار شخصية ولا يحسب أي درجة. أنت تكتب الأسئلة التي تحكي عنك، وتتطابق مع من يجيب عنها كلها إجابة صحيحة.",
      ru: "Qulo не проводит тест личности и не считает баллы. Вы пишете вопросы, которые говорят о вас, и совпадаете с тем, кто ответит на все верно.",
      pt: "O Qulo não aplica teste de personalidade nem calcula pontuação. Você escreve as perguntas que falam de você e combina com quem acertar todas.",
      it: "Qulo non somministra test di personalità né calcola punteggi. Scrivi tu le domande che parlano di te e fai match con chi le indovina tutte.",
      ja: "Quloは性格テストを行わず、スコアも算出しません。自分を語る質問を自分で書き、それに全問正解した人とマッチします。",
      ko: "Qulo는 성격 검사를 하지 않고 점수도 매기지 않습니다. 나를 보여 주는 질문을 직접 쓰고, 그것을 모두 맞힌 사람과 매칭됩니다.",
      zh: "Qulo 不做性格测试，也不计算分数。你自己写下能说明你是谁的问题，与全部答对的人配对。",
      nl: "Qulo doet geen persoonlijkheidstest en berekent geen score. Jij schrijft de vragen die iets over je zeggen; wie ze allemaal goed heeft, matcht.",
      pl: "Qulo nie przeprowadza testu osobowości ani nie liczy punktów. Sam piszesz pytania, które coś o tobie mówią, i łączysz się z tym, kto trafi wszystkie.",
      sv: "Qulo gör inget personlighetstest och räknar ingen poäng. Du skriver frågorna som säger något om dig och matchar med den som har alla rätt.",
      hi: "Qulo कोई पर्सनैलिटी टेस्ट नहीं लेता और न कोई स्कोर निकालता है। आप अपने बारे में सवाल लिखते हैं और जो सब सही करे, उससे मैच होता है।",
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
