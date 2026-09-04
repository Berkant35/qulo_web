import type { FAQItem } from "@/components/shared/FAQ";

/**
 * Page-specific FAQ data per slug + locale.
 *
 * Source: Server-side static constants (i18n strings). Used by the FAQ
 * component, which emits FAQPage JSON-LD for Google rich snippets.
 *
 * Every set here carries all 16 locales, with the same questions in the same
 * order in each. That is not cosmetic. Because these strings are marked up as
 * FAQPage, a missing locale did not degrade to "no rich result" — it handed
 * crawlers English questions and answers on a page whose hreflang, canonical
 * and `<html lang>` all declared another language. Marked-up content in the
 * wrong language is a false statement in a format designed to be trusted, so
 * the `en` fallback below is a guard against a mistyped locale key, not a
 * translation strategy. Adding a locale means adding it to every set.
 */

export type FAQLocaleMap = Record<string, FAQItem[]>;

/**
 * FAQs shown on the three /features/[slug] landing pages, in all 16 locales.
 *
 * Rewritten 2026-09-04 alongside the page bodies. The previous version carried
 * five separate hard-rule breaches, all of which were rendered into FAQPage
 * JSON-LD and therefore offered to search engines as facts:
 *  - "Qulo is one of the world's first examples of this category" — an
 *    unverifiable superlative.
 *  - "only 2-5% of swipe matches lead to real-life meetings", "72% of users
 *    prefer the 'slow dating' approach", "personality compatibility is one of
 *    the 5 core factors of successful relationships" and "personality-
 *    compatible couples have happier, longer-lasting relationships" — four
 *    figures and findings with no publisher, sample or citation between them.
 *  - "78% of users experience burnout" — the right figure with its attribution
 *    stripped off. It is kept here only in full: Forbes Health / OnePoll, 2024,
 *    1,000 US adults who had used a dating app in the past year. See
 *    FORBES_ONEPOLL_2024 in src/lib/constants/stats.ts.
 *  - A second dating app named by brand. Qulo is the only dating app that may
 *    be named on this site; everything else is "dating apps".
 *  - "Profile verification", "naturally filters out fake profiles" and
 *    "AI-powered question suggestions" — features the app does not have.
 *
 * What is left describes only the mechanic: 2 to 4 multiple-choice questions on
 * a free account (up to 10 on a paid plan) with four options each, an
 * author-marked correct answer, a match only on a perfect set, and optional
 * paid hints.
 *
 * The range was corrected on 2026-09-04. "2 to 10" is the Premium ceiling: the
 * active economy_config_versions row caps free at 4, Plus at 6 and Premium at
 * 10, enforced in qulo-server question.service.ts. Quoting the paid ceiling to
 * a free reader was a false claim, and FAQPage markup handed it to crawlers as
 * structured fact. A range ending at 10 may only appear alongside the plan
 * that grants it.
 */
export const FEATURE_FAQS: Record<string, FAQLocaleMap> = {
  "quiz-dating-app": {
    en: [
      { q: "How does a quiz dating app work?", a: "Each member writes 2 to 4 multiple-choice questions about themselves — up to 10 on a paid plan — four options each, and marks the correct one. Other people answer them, and a match happens only when someone gets every question right." },
      { q: "Is Qulo free?", a: "The core loop is free: write questions, answer other people's, match and chat. Plus and Premium are optional subscriptions, and hints are optional too — you can match without spending anything." },
      { q: "Who writes the questions?", a: "You do. You choose the subject, write the four options and mark which one is true about you." },
      { q: "What happens if I get an answer wrong?", a: "The attempt ends there. There is no partial credit: matching on Qulo takes a perfect set." },
    ],
    tr: [
      { q: "Quiz dating app nasıl çalışır?", a: "Herkes kendisi hakkında 2 ila 4 çoktan seçmeli soru yazar — ücretli planlarda 10'a kadar — her birine dört şık verir ve doğru olanı işaretler. Başkaları bu soruları cevaplar; eşleşme ancak biri hepsini doğru bildiğinde gerçekleşir." },
      { q: "Qulo ücretsiz mi?", a: "Temel döngü ücretsiz: soru yaz, başkalarının sorularını çöz, eşleş ve sohbet et. Plus ile Premium isteğe bağlı aboneliklerdir, ipuçları da isteğe bağlıdır — hiçbir şey harcamadan eşleşebilirsin." },
      { q: "Soruları kim yazar?", a: "Sen yazarsın. Konuyu sen seçersin, dört şıkkı sen yazarsın ve hangisinin senin için doğru olduğunu sen işaretlersin." },
      { q: "Bir soruyu yanlış cevaplarsam ne olur?", a: "Deneme orada biter. Kısmi puan yoktur: Qulo'da eşleşmek için setin tamamı doğru olmalıdır." },
    ],
    de: [
      { q: "Wie funktioniert eine Quiz-Dating-App?", a: "Jedes Mitglied schreibt 2 bis 4 Multiple-Choice-Fragen über sich — mit einem bezahlten Abo bis zu 10 —, je vier Möglichkeiten, und markiert die richtige. Andere beantworten sie, und ein Match entsteht nur, wenn jemand jede Frage richtig hat." },
      { q: "Ist Qulo kostenlos?", a: "Der Kernablauf ist kostenlos: Fragen schreiben, die anderer beantworten, matchen und chatten. Plus und Premium sind optionale Abos, Hinweise ebenfalls freiwillig — matchen kannst du, ohne etwas auszugeben." },
      { q: "Wer schreibt die Fragen?", a: "Du selbst. Du wählst das Thema, schreibst die vier Möglichkeiten und markierst, welche auf dich zutrifft." },
      { q: "Was passiert bei einer falschen Antwort?", a: "Der Versuch endet dort. Es gibt keine Teilpunkte: Für ein Match bei Qulo muss das ganze Set stimmen." },
    ],
    fr: [
      { q: "Comment fonctionne une app de dating quiz ?", a: "Chaque membre écrit de 2 à 4 questions à choix multiple sur lui-même — jusqu'à 10 avec un abonnement payant —, quatre options chacune, et coche la bonne. Les autres y répondent, et le match n'a lieu que si quelqu'un trouve toutes les réponses." },
      { q: "Qulo est-il gratuit ?", a: "La boucle principale est gratuite : écrire ses questions, répondre à celles des autres, matcher et discuter. Plus et Premium sont des abonnements facultatifs, les indices aussi — on peut matcher sans rien dépenser." },
      { q: "Qui écrit les questions ?", a: "Vous. Vous choisissez le sujet, vous écrivez les quatre options et vous cochez celle qui est vraie à votre sujet." },
      { q: "Que se passe-t-il si je me trompe ?", a: "La tentative s'arrête là. Il n'y a pas de points partiels : matcher sur Qulo demande une série sans faute." },
    ],
    es: [
      { q: "¿Cómo funciona una app de citas tipo quiz?", a: "Cada persona escribe de 2 a 4 preguntas de opción múltiple sobre sí misma —hasta 10 con una suscripción de pago—, con cuatro opciones cada una, y marca la correcta. Las demás las responden, y solo hay match si alguien las acierta todas." },
      { q: "¿Qulo es gratis?", a: "El ciclo básico es gratuito: escribir preguntas, responder las de otros, hacer match y chatear. Plus y Premium son suscripciones opcionales, y las pistas también — puedes hacer match sin gastar nada." },
      { q: "¿Quién escribe las preguntas?", a: "Tú. Eliges el tema, escribes las cuatro opciones y marcas cuál es cierta sobre ti." },
      { q: "¿Qué pasa si fallo una respuesta?", a: "El intento termina ahí. No hay acierto parcial: hacer match en Qulo exige una tanda perfecta." },
    ],
    ar: [
      { q: "كيف يعمل تطبيق المواعدة بالأسئلة؟", a: "يكتب كل عضو من سؤالين إلى أربعة أسئلة اختيار من متعدد عن نفسه — وحتى عشرة أسئلة مع اشتراك مدفوع — لكل سؤال أربعة خيارات، ويحدّد الصحيح منها. يجيب الآخرون عنها، ولا يحدث التطابق إلا بالإجابة الصحيحة عن كل سؤال." },
      { q: "هل Qulo مجاني؟", a: "الدورة الأساسية مجانية: تكتب أسئلتك، وتجيب عن أسئلة غيرك، وتتطابق وتتحادث. Plus وPremium اشتراكان اختياريان، والتلميحات اختيارية كذلك — يمكنك التطابق دون إنفاق شيء." },
      { q: "من يكتب الأسئلة؟", a: "أنت. تختار الموضوع، وتكتب الخيارات الأربعة، وتحدّد أيها الصحيح عنك." },
      { q: "ماذا يحدث إن أخطأت في إجابة؟", a: "تنتهي المحاولة عند تلك النقطة. لا توجد درجات جزئية: التطابق في Qulo يتطلب مجموعة كاملة الصحّة." },
    ],
    ru: [
      { q: "Как работает дейтинг-приложение с вопросами?", a: "Каждый пишет о себе от 2 до 4 вопросов с четырьмя вариантами ответа и отмечает верный, а с платной подпиской вопросов может быть до 10. Другие отвечают на них, и совпадение возникает, только если человек ответил верно на все." },
      { q: "Qulo бесплатный?", a: "Основной цикл бесплатен: написать вопросы, ответить на чужие, совпасть и переписываться. Plus и Premium — необязательные подписки, подсказки тоже необязательны: совпасть можно, не потратив ничего." },
      { q: "Кто пишет вопросы?", a: "Вы сами. Вы выбираете тему, пишете четыре варианта и отмечаете тот, который верен про вас." },
      { q: "Что будет, если ответить неверно?", a: "Попытка на этом заканчивается. Частичного зачета нет: совпадение в Qulo требует безошибочного набора." },
    ],
    pt: [
      { q: "Como funciona um app de encontros em formato quiz?", a: "Cada pessoa escreve de 2 a 4 perguntas de múltipla escolha sobre si — até 10 com uma assinatura paga —, quatro alternativas cada, e marca a certa. As outras respondem, e o match só acontece quando alguém acerta todas." },
      { q: "O Qulo é gratuito?", a: "O ciclo principal é gratuito: escrever perguntas, responder às dos outros, dar match e conversar. Plus e Premium são assinaturas opcionais, e as dicas também — dá para dar match sem gastar nada." },
      { q: "Quem escreve as perguntas?", a: "Você. Escolhe o assunto, escreve as quatro alternativas e marca qual é verdadeira a seu respeito." },
      { q: "O que acontece se eu errar uma resposta?", a: "A tentativa termina ali. Não há acerto parcial: dar match no Qulo exige um conjunto perfeito." },
    ],
    it: [
      { q: "Come funziona un'app di dating a quiz?", a: "Ogni persona scrive da 2 a 4 domande a risposta multipla su di sé — fino a 10 con un abbonamento a pagamento —, quattro opzioni ciascuna, e segna quella giusta. Gli altri rispondono, e il match avviene solo se qualcuno le indovina tutte." },
      { q: "Qulo è gratuito?", a: "Il ciclo principale è gratuito: scrivere domande, rispondere a quelle degli altri, fare match e chattare. Plus e Premium sono abbonamenti facoltativi, e anche gli aiuti lo sono: si può fare match senza spendere nulla." },
      { q: "Chi scrive le domande?", a: "Le scrivi tu. Scegli l'argomento, scrivi le quattro opzioni e segni quella vera su di te." },
      { q: "Cosa succede se sbaglio una risposta?", a: "Il tentativo finisce lì. Non esistono punteggi parziali: per fare match su Qulo serve una serie perfetta." },
    ],
    ja: [
      { q: "クイズ型デーティングアプリはどう動きますか？", a: "各自が自分について選択式の質問を2〜4問書き（有料プランなら最大10問）、選択肢を4つ用意して正解に印をつけます。ほかの人がそれに答え、すべて正解したときだけマッチが成立します。" },
      { q: "Quloは無料ですか？", a: "基本の流れは無料です。質問を書き、他人の質問に答え、マッチしてチャットできます。PlusとPremiumは任意の定額プランで、ヒントも任意です。一円も使わずにマッチできます。" },
      { q: "質問は誰が書きますか？", a: "あなた自身です。題材を選び、選択肢を4つ書き、自分について正しいものに印をつけます。" },
      { q: "答えを間違えるとどうなりますか？", a: "そこで終了です。部分点はありません。Quloでマッチするには全問正解が必要です。" },
    ],
    ko: [
      { q: "퀴즈형 데이팅 앱은 어떻게 작동하나요?", a: "각자 자신에 대한 객관식 질문을 2~4개 쓰고(유료 플랜은 최대 10개), 보기를 네 개씩 두고 정답을 표시합니다. 다른 사람이 그 질문에 답하고, 모두 맞혔을 때만 매칭됩니다." },
      { q: "Qulo는 무료인가요?", a: "핵심 흐름은 무료입니다. 질문을 쓰고, 남의 질문에 답하고, 매칭되어 대화할 수 있습니다. Plus와 Premium은 선택 구독이고 힌트도 선택입니다. 한 푼 쓰지 않고 매칭될 수 있습니다." },
      { q: "질문은 누가 쓰나요?", a: "본인이 씁니다. 주제를 고르고, 보기 네 개를 쓰고, 자신에게 맞는 것을 정답으로 표시합니다." },
      { q: "답을 틀리면 어떻게 되나요?", a: "시도는 거기서 끝납니다. 부분 점수는 없습니다. Qulo에서 매칭되려면 한 세트를 모두 맞혀야 합니다." },
    ],
    zh: [
      { q: "答题式交友应用怎么运作？", a: "每个人写下关于自己的 2 到 4 道选择题（付费方案最多 10 道），每道四个选项，并标出正确答案。别人来作答，只有全部答对才会配对成功。" },
      { q: "Qulo 免费吗？", a: "核心流程免费：出题、答别人的题、配对、聊天。Plus 和 Premium 是可选订阅，提示也是可选的——不花钱同样可以配对。" },
      { q: "题目由谁来写？", a: "由你自己写。你挑题材，写四个选项，并标出哪一个符合你。" },
      { q: "答错了会怎样？", a: "这次尝试就此结束。没有部分得分：在 Qulo 配对需要一组全对的答案。" },
    ],
    nl: [
      { q: "Hoe werkt een quiz-datingapp?", a: "Ieder lid schrijft 2 tot 4 meerkeuzevragen over zichzelf — met een betaald abonnement tot 10 —, vier opties per vraag, en markeert het juiste antwoord. Anderen beantwoorden ze, en er ontstaat pas een match als iemand alles goed heeft." },
      { q: "Is Qulo gratis?", a: "De kern is gratis: vragen schrijven, die van anderen beantwoorden, matchen en chatten. Plus en Premium zijn optionele abonnementen en hints zijn ook optioneel — matchen kan zonder iets uit te geven." },
      { q: "Wie schrijft de vragen?", a: "Jij. Je kiest het onderwerp, schrijft de vier opties en markeert welke over jou klopt." },
      { q: "Wat gebeurt er bij een fout antwoord?", a: "De poging stopt daar. Er is geen deelscore: matchen op Qulo vraagt een foutloze set." },
    ],
    pl: [
      { q: "Jak działa randkowa aplikacja z quizem?", a: "Każdy pisze o sobie od 2 do 4 pytań wielokrotnego wyboru — w płatnej subskrypcji nawet 10 — po cztery odpowiedzi w każdym, i zaznacza poprawną. Inni na nie odpowiadają, a dopasowanie następuje tylko przy komplecie trafień." },
      { q: "Czy Qulo jest darmowe?", a: "Podstawowy obieg jest darmowy: piszesz pytania, odpowiadasz na cudze, dopasowujesz się i rozmawiasz. Plus i Premium to opcjonalne subskrypcje, podpowiedzi też są opcjonalne — można dopasować się bez wydawania grosza." },
      { q: "Kto pisze pytania?", a: "Ty. Wybierasz temat, piszesz cztery odpowiedzi i zaznaczasz tę, która jest o tobie prawdziwa." },
      { q: "Co się dzieje przy błędnej odpowiedzi?", a: "Próba kończy się w tym miejscu. Nie ma punktów częściowych: dopasowanie w Qulo wymaga bezbłędnego zestawu." },
    ],
    sv: [
      { q: "Hur fungerar en quiz-dejtingapp?", a: "Varje medlem skriver 2 till 4 flervalsfrågor om sig själv — upp till 10 med ett betalt abonnemang —, fyra alternativ var, och markerar det rätta. Andra svarar på dem, och en matchning uppstår bara när någon har alla rätt." },
      { q: "Är Qulo gratis?", a: "Kärnan är gratis: skriva frågor, svara på andras, matcha och chatta. Plus och Premium är frivilliga abonnemang, och ledtrådar är också frivilliga — du kan matcha utan att lägga en krona." },
      { q: "Vem skriver frågorna?", a: "Det gör du. Du väljer ämne, skriver de fyra alternativen och markerar vilket som stämmer om dig." },
      { q: "Vad händer om jag svarar fel?", a: "Försöket tar slut där. Det finns inga delpoäng: en matchning på Qulo kräver en felfri omgång." },
    ],
    hi: [
      { q: "क्विज़ डेटिंग ऐप कैसे काम करता है?", a: "हर सदस्य अपने बारे में 2 से 4 बहुविकल्पीय सवाल लिखता है — सशुल्क प्लान पर 10 तक — हर सवाल में चार विकल्प देता है और सही विकल्प चिह्नित करता है। दूसरे लोग उन्हें हल करते हैं, और मैच सिर्फ़ तभी होता है जब कोई सब सही करे।" },
      { q: "क्या Qulo मुफ़्त है?", a: "मुख्य चक्र मुफ़्त है: सवाल लिखिए, दूसरों के सवाल हल कीजिए, मैच पाइए और बात कीजिए। Plus और Premium वैकल्पिक सब्सक्रिप्शन हैं, संकेत भी वैकल्पिक हैं — बिना कुछ ख़र्च किए मैच हो सकता है।" },
      { q: "सवाल कौन लिखता है?", a: "आप ख़ुद। विषय आप चुनते हैं, चार विकल्प आप लिखते हैं और कौन-सा आपके बारे में सही है, यह आप चिह्नित करते हैं।" },
      { q: "जवाब ग़लत हो जाए तो क्या होता है?", a: "कोशिश वहीं ख़त्म हो जाती है। आंशिक अंक नहीं मिलते: Qulo पर मैच के लिए पूरा सेट सही चाहिए।" },
    ],
  },
  "dating-without-swiping": {
    en: [
      { q: "How do you match without swiping?", a: "You open a profile and answer the questions that person wrote about themselves: 2 to 4 of them, or up to 10 if they are on a paid plan. Answering all of them correctly is the match — there is nothing to swipe." },
      { q: "Is swipe fatigue a real thing?", a: "It is a widely reported complaint. In a 2024 Forbes Health / OnePoll survey of 1,000 US adults who had used a dating app in the past year, 78% said they felt burned out by dating apps." },
      { q: "Does Qulo have a swipe deck at all?", a: "No. There is no left or right, and no queue of profiles to clear before you can do anything else." },
      { q: "Does answering questions take longer than swiping?", a: "Yes — minutes rather than a moment. That is the trade: fewer decisions in an evening, each one made with something to go on." },
    ],
    tr: [
      { q: "Kaydırmadan nasıl eşleşilir?", a: "Bir profili açar ve o kişinin kendisi hakkında yazdığı soruları cevaplarsın: 2 ila 4 soru, ücretli plandaysa 10'a kadar. Hepsini doğru cevaplamak eşleşmenin kendisidir — kaydırılacak bir şey yoktur." },
      { q: "Kaydırma yorgunluğu gerçek mi?", a: "Sık dile getirilen bir şikâyet. Forbes Health / OnePoll'un 2024'te, son bir yılda dating uygulaması kullanmış 1.000 ABD'li yetişkinle yaptığı ankette katılımcıların %78'i dating uygulamalarından tükenmiş hissettiğini söyledi." },
      { q: "Qulo'da hiç kaydırma destesi var mı?", a: "Yok. Sağ ya da sol yok; başka bir şey yapabilmek için önce bitirmen gereken bir profil kuyruğu da yok." },
      { q: "Soru çözmek kaydırmaktan uzun sürmüyor mu?", a: "Evet, bir an değil dakikalar sürüyor. Takas bu: bir akşamda daha az karar, ama her biri elinde bir şey varken verilmiş." },
    ],
    de: [
      { q: "Wie matcht man ohne zu swipen?", a: "Du öffnest ein Profil und beantwortest die Fragen, die diese Person über sich geschrieben hat: 2 bis 4, mit einem bezahlten Abo bis zu 10. Alle richtig zu haben ist das Match — es gibt nichts zu wischen." },
      { q: "Gibt es Swipe-Müdigkeit wirklich?", a: "Sie ist eine oft geäußerte Klage. In einer Umfrage von Forbes Health / OnePoll aus dem Jahr 2024 unter 1.000 Erwachsenen in den USA, die im Vorjahr eine Dating-App genutzt hatten, gaben 78 % an, sich davon ausgebrannt zu fühlen." },
      { q: "Gibt es bei Qulo überhaupt einen Swipe-Stapel?", a: "Nein. Es gibt kein Links und kein Rechts und keine Profil-Warteschlange, die du erst abarbeiten müsstest." },
      { q: "Dauert Fragenbeantworten nicht länger als Swipen?", a: "Ja, Minuten statt eines Moments. Das ist der Tausch: weniger Entscheidungen an einem Abend, jede davon mit einer Grundlage." },
    ],
    fr: [
      { q: "Comment matcher sans swiper ?", a: "Vous ouvrez un profil et répondez aux questions que la personne a écrites sur elle-même : de 2 à 4, ou jusqu'à 10 si elle a un abonnement payant. Les trouver toutes, c'est le match : il n'y a rien à balayer." },
      { q: "La fatigue du swipe existe-t-elle vraiment ?", a: "C'est une plainte très répandue. Dans une enquête Forbes Health / OnePoll de 2024 auprès de 1 000 adultes américains ayant utilisé une application de rencontre dans l'année, 78 % se disaient épuisés par ces applications." },
      { q: "Y a-t-il une pile à swiper sur Qulo ?", a: "Non. Ni gauche ni droite, et aucune file de profils à écouler avant de pouvoir faire autre chose." },
      { q: "Répondre à des questions prend-il plus de temps que swiper ?", a: "Oui : quelques minutes plutôt qu'un instant. C'est l'échange — moins de décisions dans une soirée, chacune prise avec de quoi décider." },
    ],
    es: [
      { q: "¿Cómo se hace match sin deslizar?", a: "Abres un perfil y respondes las preguntas que esa persona escribió sobre sí misma: de 2 a 4, o hasta 10 si tiene una suscripción de pago. Acertarlas todas es el match: no hay nada que deslizar." },
      { q: "¿El cansancio de deslizar existe de verdad?", a: "Es una queja muy extendida. En una encuesta de Forbes Health / OnePoll de 2024 a 1.000 adultos estadounidenses que habían usado una app de citas en el último año, el 78 % dijo sentirse agotado por ellas." },
      { q: "¿Qulo tiene algún mazo que deslizar?", a: "No. No hay izquierda ni derecha, ni una cola de perfiles que haya que despachar antes de poder hacer otra cosa." },
      { q: "¿Responder preguntas lleva más tiempo que deslizar?", a: "Sí: minutos en lugar de un instante. Ese es el cambio — menos decisiones por noche, y cada una tomada con algo en lo que apoyarse." },
    ],
    ar: [
      { q: "كيف يحدث التطابق بلا تمرير؟", a: "تفتح ملفًا وتجيب عن الأسئلة التي كتبها صاحبه عن نفسه، وعددها من 2 إلى 4، أو حتى 10 إن كان مشتركًا في خطة مدفوعة. الإجابة الصحيحة عنها كلها هي التطابق نفسه — لا شيء تمرّره." },
      { q: "هل إنهاك التمرير حقيقي؟", a: "إنه شكوى واسعة الانتشار. في استطلاع لـ Forbes Health / OnePoll عام 2024 شمل 1000 بالغ أمريكي استخدموا تطبيق مواعدة خلال العام السابق، قال 78% إنهم يشعرون بالإنهاك من هذه التطبيقات." },
      { q: "هل في Qulo رصّة تمرير أصلًا؟", a: "لا. لا يمين ولا يسار، ولا طابور ملفات عليك إنهاؤه قبل أن تفعل شيئًا آخر." },
      { q: "ألا يستغرق حلّ الأسئلة وقتًا أطول من التمرير؟", a: "بلى، دقائق بدل لحظة. هذه هي المقايضة: قرارات أقل في الأمسية، وكل قرار مبني على شيء ملموس." },
    ],
    ru: [
      { q: "Как совпасть без свайпов?", a: "Вы открываете анкету и отвечаете на вопросы, которые человек написал о себе: их от 2 до 4, а с платной подпиской — до 10. Ответить верно на все — это и есть совпадение; свайпать нечего." },
      { q: "Усталость от свайпов действительно существует?", a: "Это часто высказываемая жалоба. В опросе Forbes Health / OnePoll 2024 года среди 1000 взрослых американцев, пользовавшихся дейтинг-приложением за прошедший год, 78% сказали, что чувствуют от них выгорание." },
      { q: "В Qulo вообще есть колода для свайпа?", a: "Нет. Нет ни влево, ни вправо, и нет очереди анкет, которую нужно разобрать, прежде чем делать что-то еще." },
      { q: "Отвечать на вопросы дольше, чем свайпать?", a: "Да, минуты вместо мгновения. Это и есть обмен: за вечер решений меньше, но каждое принимается, имея на что опереться." },
    ],
    pt: [
      { q: "Como se dá match sem deslizar?", a: "Você abre um perfil e responde às perguntas que a pessoa escreveu sobre si: de 2 a 4, ou até 10 se ela tiver uma assinatura paga. Acertar todas é o match — não há nada para deslizar." },
      { q: "O cansaço de deslizar existe mesmo?", a: "É uma queixa muito comum. Numa pesquisa da Forbes Health / OnePoll de 2024 com 1.000 adultos dos EUA que haviam usado um app de encontros no último ano, 78% disseram sentir-se esgotados por esses aplicativos." },
      { q: "O Qulo tem algum baralho para deslizar?", a: "Não. Não existe esquerda nem direita, nem uma fila de perfis a vencer antes de poder fazer outra coisa." },
      { q: "Responder perguntas demora mais que deslizar?", a: "Sim: minutos em vez de um instante. É essa a troca — menos decisões numa noite, cada uma tomada com algo em que se apoiar." },
    ],
    it: [
      { q: "Come si fa match senza swipe?", a: "Apri un profilo e rispondi alle domande che quella persona ha scritto su di sé: da 2 a 4, o fino a 10 se ha un abbonamento a pagamento. Indovinarle tutte è il match: non c'è nulla da scorrere." },
      { q: "La stanchezza da swipe esiste davvero?", a: "È una lamentela molto diffusa. In un sondaggio Forbes Health / OnePoll del 2024 su 1.000 adulti statunitensi che avevano usato un'app di incontri nell'ultimo anno, il 78% ha detto di sentirsi esaurito da queste app." },
      { q: "Su Qulo esiste un mazzo da scorrere?", a: "No. Non c'è sinistra né destra, e nessuna fila di profili da smaltire prima di poter fare altro." },
      { q: "Rispondere alle domande richiede più tempo dello swipe?", a: "Sì: minuti invece di un istante. È questo lo scambio — meno decisioni in una serata, ognuna presa avendo qualcosa su cui basarsi." },
    ],
    ja: [
      { q: "スワイプせずにどうやってマッチするのですか？", a: "プロフィールを開き、その人が自分について書いた2〜4問（有料プランなら最大10問）に答えます。すべて正解することがマッチそのものです。スワイプするものはありません。" },
      { q: "スワイプ疲れは本当にあるのですか？", a: "広く語られている不満です。Forbes Health / OnePollが2024年に、過去1年間にデーティングアプリを使った米国の成人1,000人を対象に行った調査では、78%がこうしたアプリに燃え尽きを感じると答えました。" },
      { q: "Quloにスワイプするカードの山はありますか？", a: "ありません。左も右もなく、何かを始める前に片づけなければならないプロフィールの行列もありません。" },
      { q: "質問に答えるのはスワイプより時間がかかりませんか？", a: "かかります。一瞬ではなく数分です。それが交換条件で、一晩の判断は減る代わりに、判断材料のある状態で決められます。" },
    ],
    ko: [
      { q: "스와이프 없이 어떻게 매칭되나요?", a: "프로필을 열고 그 사람이 자신에 대해 쓴 2~4개(유료 플랜이면 최대 10개)의 질문에 답합니다. 전부 맞히는 것이 곧 매칭이고, 밀어 넘길 것은 없습니다." },
      { q: "스와이프 피로가 정말 있나요?", a: "널리 언급되는 불만입니다. Forbes Health / OnePoll이 2024년에 지난 1년간 데이팅 앱을 쓴 미국 성인 1,000명에게 물었을 때 78%가 그런 앱에 소진감을 느낀다고 답했습니다." },
      { q: "Qulo에 스와이프 카드 더미가 있나요?", a: "없습니다. 왼쪽도 오른쪽도 없고, 다른 걸 하기 전에 먼저 치워야 할 프로필 대기열도 없습니다." },
      { q: "질문에 답하는 게 스와이프보다 오래 걸리지 않나요?", a: "오래 걸립니다. 순간이 아니라 몇 분입니다. 그것이 교환 조건입니다. 하룻저녁의 판단은 줄지만, 판단할 근거를 갖고 정하게 됩니다." },
    ],
    zh: [
      { q: "不滑动要怎么配对？", a: "你打开一份资料，回答对方为自己写下的 2 到 4 道题（对方使用付费方案时最多 10 道）。全部答对就是配对本身——没有可滑的东西。" },
      { q: "滑动带来的倦怠是真的吗？", a: "这是被广泛提到的抱怨。Forbes Health / OnePoll 在 2024 年针对 1,000 名过去一年用过交友应用的美国成年人所做的调查中，78% 的人表示对这类应用感到倦怠。" },
      { q: "Qulo 里到底有没有滑动卡片堆？", a: "没有。没有左右，也没有一列必须先清完才能做别的事的资料队列。" },
      { q: "答题不是比滑动更花时间吗？", a: "确实更花时间，是几分钟而不是一瞬间。这就是交换：一个晚上做的决定更少，但每个决定都有依据。" },
    ],
    nl: [
      { q: "Hoe match je zonder te swipen?", a: "Je opent een profiel en beantwoordt de vragen die diegene over zichzelf schreef: 2 tot 4, of tot 10 met een betaald abonnement. Ze allemaal goed hebben is de match — er valt niets te swipen." },
      { q: "Bestaat swipemoeheid echt?", a: "Het is een veelgehoorde klacht. In een onderzoek van Forbes Health / OnePoll uit 2024 onder 1.000 Amerikaanse volwassenen die het afgelopen jaar een datingapp gebruikten, zei 78% zich erdoor opgebrand te voelen." },
      { q: "Heeft Qulo eigenlijk een swipestapel?", a: "Nee. Er is geen links of rechts, en geen rij profielen die je eerst moet wegwerken." },
      { q: "Kost vragen beantwoorden niet meer tijd dan swipen?", a: "Ja, minuten in plaats van een moment. Dat is de ruil: minder beslissingen op een avond, en elk ervan met iets om op af te gaan." },
    ],
    pl: [
      { q: "Jak dopasować się bez przesuwania?", a: "Otwierasz profil i odpowiadasz na pytania, które ta osoba napisała o sobie: od 2 do 4, a przy płatnej subskrypcji nawet 10. Trafienie wszystkich to samo dopasowanie — nie ma czego przesuwać." },
      { q: "Czy zmęczenie przesuwaniem naprawdę istnieje?", a: "To często zgłaszana skarga. W badaniu Forbes Health / OnePoll z 2024 roku wśród 1000 dorosłych Amerykanów, którzy w ostatnim roku korzystali z aplikacji randkowej, 78% stwierdziło, że czuje się nimi wypalonych." },
      { q: "Czy w Qulo jest w ogóle talia do przesuwania?", a: "Nie. Nie ma lewej ani prawej strony, ani kolejki profili, którą trzeba najpierw opróżnić." },
      { q: "Czy odpowiadanie na pytania trwa dłużej niż przesuwanie?", a: "Tak, minuty zamiast chwili. Na tym polega wymiana: mniej decyzji w ciągu wieczoru, ale każda podjęta na jakiejś podstawie." },
    ],
    sv: [
      { q: "Hur matchar man utan att svepa?", a: "Du öppnar en profil och svarar på de frågor personen skrivit om sig själv: 2 till 4, eller upp till 10 med ett betalt abonnemang. Att ha alla rätt är matchningen — det finns ingenting att svepa." },
      { q: "Finns svepströtthet på riktigt?", a: "Det är ett ofta framfört klagomål. I en undersökning från Forbes Health / OnePoll 2024 bland 1 000 vuxna i USA som använt en dejtingapp det senaste året uppgav 78 % att de kände sig utbrända av dem." },
      { q: "Har Qulo någon svepkortlek alls?", a: "Nej. Det finns inget vänster eller höger, och ingen kö av profiler att beta av innan du kan göra något annat." },
      { q: "Tar det inte längre att svara på frågor än att svepa?", a: "Jo, minuter i stället för ett ögonblick. Det är bytet: färre beslut på en kväll, och vart och ett fattat med något att gå på." },
    ],
    hi: [
      { q: "बिना स्वाइप किए मैच कैसे होता है?", a: "आप कोई प्रोफ़ाइल खोलते हैं और उस व्यक्ति के अपने बारे में लिखे सवाल हल करते हैं: 2 से 4, और सशुल्क प्लान पर 10 तक। सबका सही जवाब देना ही मैच है — स्वाइप करने को कुछ नहीं होता।" },
      { q: "क्या स्वाइप की थकान सचमुच होती है?", a: "यह व्यापक रूप से कही जाने वाली शिकायत है। Forbes Health / OnePoll के 2024 के सर्वेक्षण में, जिसमें पिछले साल डेटिंग ऐप इस्तेमाल कर चुके 1,000 अमेरिकी वयस्क शामिल थे, 78% ने कहा कि वे इनसे थक चुके हैं।" },
      { q: "क्या Qulo में स्वाइप वाला ढेर है ही?", a: "नहीं। न बाएँ, न दाएँ; और कुछ और करने से पहले निपटाने के लिए प्रोफ़ाइलों की कोई क़तार भी नहीं।" },
      { q: "क्या सवाल हल करने में स्वाइप से ज़्यादा समय नहीं लगता?", a: "लगता है — पल भर नहीं, कुछ मिनट। सौदा यही है: एक शाम में फ़ैसले कम, पर हर फ़ैसला किसी आधार पर।" },
    ],
  },
  "personality-matching-app": {
    en: [
      { q: "Does Qulo run a personality test?", a: "No. Qulo measures no personality trait and calculates no compatibility score. You write your own questions, and someone matches by answering all of them correctly." },
      { q: "What does matching on questions actually tell you?", a: "The questions you choose to ask already say something about you, and a correct answer shows the other person read them carefully. Qulo claims nothing beyond that." },
      { q: "What should I ask about?", a: "Whatever you would want a stranger to know: what you value, how you spend your time, a story only you would tell. Two to four questions, four options each." },
      { q: "Is there a compatibility score?", a: "No. There are no traits, categories or percentages — the only thing recorded is whether every answer was right." },
    ],
    tr: [
      { q: "Qulo kişilik testi yapıyor mu?", a: "Hayır. Qulo hiçbir kişilik özelliğini ölçmez ve uyumluluk puanı hesaplamaz. Sorularını sen yazarsın ve biri hepsini doğru cevaplayarak seninle eşleşir." },
      { q: "Sorularla eşleşmek aslında ne söylüyor?", a: "Sormayı seçtiğin sorular zaten senin hakkında bir şey söyler; doğru cevap da karşı tarafın onları dikkatle okuduğunu gösterir. Qulo bunun ötesinde bir iddiada bulunmuyor." },
      { q: "Ne sormalıyım?", a: "Bir yabancının senin hakkında bilmesini isteyeceğin her şeyi: neye değer verdiğini, vaktini nasıl geçirdiğini, yalnızca senin anlatabileceğin bir hikâyeyi. 2 ila 4 soru, her birinde dört şık." },
      { q: "Bir uyumluluk puanı var mı?", a: "Yok. Ne özellik, ne kategori, ne yüzde — kaydedilen tek şey bütün cevapların doğru olup olmadığı." },
    ],
    de: [
      { q: "Macht Qulo einen Persönlichkeitstest?", a: "Nein. Qulo misst kein Persönlichkeitsmerkmal und berechnet keinen Kompatibilitätswert. Du schreibst deine eigenen Fragen, und jemand matcht, indem er sie alle richtig beantwortet." },
      { q: "Was sagt ein Match über Fragen wirklich aus?", a: "Schon die Fragen, die du stellst, sagen etwas über dich, und eine richtige Antwort zeigt, dass die andere Person sie aufmerksam gelesen hat. Mehr behauptet Qulo nicht." },
      { q: "Wonach soll ich fragen?", a: "Nach allem, was ein fremder Mensch über dich wissen sollte: was dir wichtig ist, wie du deine Zeit verbringst, eine Geschichte, die nur du erzählen würdest. 2 bis 4 Fragen mit je vier Möglichkeiten." },
      { q: "Gibt es einen Kompatibilitätswert?", a: "Nein. Es gibt keine Eigenschaften, Kategorien oder Prozentzahlen — festgehalten wird nur, ob jede Antwort richtig war." },
    ],
    fr: [
      { q: "Qulo fait-il passer un test de personnalité ?", a: "Non. Qulo ne mesure aucun trait de personnalité et ne calcule aucun score de compatibilité. Vous écrivez vos propres questions, et on matche avec vous en y répondant toutes juste." },
      { q: "Que dit vraiment un match obtenu par des questions ?", a: "Les questions que vous choisissez de poser disent déjà quelque chose de vous, et une bonne réponse montre que l'autre les a lues attentivement. Qulo ne prétend rien de plus." },
      { q: "Sur quoi devrais-je interroger ?", a: "Sur tout ce qu'un inconnu devrait savoir de vous : ce à quoi vous tenez, comment vous occupez votre temps, une histoire que vous seul raconteriez. De 2 à 4 questions, quatre options chacune." },
      { q: "Y a-t-il un score de compatibilité ?", a: "Non. Ni traits, ni catégories, ni pourcentages : la seule chose enregistrée est de savoir si toutes les réponses étaient justes." },
    ],
    es: [
      { q: "¿Qulo hace un test de personalidad?", a: "No. Qulo no mide ningún rasgo de personalidad ni calcula puntuaciones de compatibilidad. Tú escribes tus preguntas y alguien hace match respondiéndolas todas bien." },
      { q: "¿Qué dice de verdad un match hecho con preguntas?", a: "Las preguntas que eliges hacer ya dicen algo de ti, y una respuesta correcta demuestra que la otra persona las leyó con atención. Qulo no afirma nada más allá de eso." },
      { q: "¿Sobre qué debería preguntar?", a: "Sobre lo que querrías que un desconocido supiera: qué valoras, cómo empleas tu tiempo, una historia que solo tú contarías. De 2 a 4 preguntas, cuatro opciones cada una." },
      { q: "¿Hay una puntuación de compatibilidad?", a: "No. No hay rasgos, ni categorías, ni porcentajes: lo único que se registra es si todas las respuestas fueron correctas." },
    ],
    ar: [
      { q: "هل يجري Qulo اختبار شخصية؟", a: "لا. لا يقيس Qulo أي سمة شخصية ولا يحسب أي درجة توافق. أنت تكتب أسئلتك، ويتطابق معك من يجيب عنها كلها إجابة صحيحة." },
      { q: "ماذا يقول التطابق القائم على الأسئلة فعلًا؟", a: "الأسئلة التي تختار طرحها تقول شيئًا عنك أصلًا، والإجابة الصحيحة تُظهر أن الطرف الآخر قرأها بتمعّن. ولا يدّعي Qulo أكثر من ذلك." },
      { q: "عمّ ينبغي أن أسأل؟", a: "عن كل ما تودّ أن يعرفه غريب عنك: ما تقدّره، وكيف تمضي وقتك، وحكاية لا يرويها سواك. من سؤالين إلى أربعة، لكل منها أربعة خيارات." },
      { q: "هل توجد درجة توافق؟", a: "لا. لا سمات ولا فئات ولا نسب مئوية — الشيء الوحيد المسجَّل هو ما إذا كانت كل الإجابات صحيحة." },
    ],
    ru: [
      { q: "Qulo проводит тест личности?", a: "Нет. Qulo не измеряет ни одной черты личности и не считает показателей совместимости. Вы пишете свои вопросы, и совпадение получает тот, кто ответит верно на все." },
      { q: "О чем на самом деле говорит совпадение по вопросам?", a: "Сами вопросы, которые вы решили задать, уже кое-что о вас говорят, а верный ответ показывает, что человек прочитал их внимательно. Большего Qulo не утверждает." },
      { q: "О чем спрашивать?", a: "О том, что вы хотели бы сообщить незнакомому человеку: что вам дорого, на что уходит ваше время, история, которую расскажете только вы. От 2 до 4 вопросов, по четыре варианта." },
      { q: "Есть ли показатель совместимости?", a: "Нет. Ни черт, ни категорий, ни процентов — фиксируется только то, все ли ответы оказались верными." },
    ],
    pt: [
      { q: "O Qulo aplica um teste de personalidade?", a: "Não. O Qulo não mede nenhum traço de personalidade nem calcula pontuação de compatibilidade. Você escreve as suas perguntas e alguém combina com você acertando todas." },
      { q: "O que um match por perguntas realmente diz?", a: "As perguntas que você escolhe fazer já dizem algo sobre você, e uma resposta certa mostra que a outra pessoa as leu com atenção. O Qulo não afirma nada além disso." },
      { q: "Sobre o que devo perguntar?", a: "Sobre o que você gostaria que um desconhecido soubesse: o que valoriza, como ocupa o seu tempo, uma história que só você contaria. De 2 a 4 perguntas, quatro alternativas cada." },
      { q: "Existe uma pontuação de compatibilidade?", a: "Não. Não há traços, categorias nem porcentagens: a única coisa registrada é se todas as respostas estavam certas." },
    ],
    it: [
      { q: "Qulo somministra un test di personalità?", a: "No. Qulo non misura alcun tratto di personalità e non calcola punteggi di compatibilità. Scrivi tu le tue domande, e fa match chi risponde correttamente a tutte." },
      { q: "Che cosa dice davvero un match ottenuto con le domande?", a: "Le domande che scegli di porre dicono già qualcosa di te, e una risposta esatta mostra che l'altra persona le ha lette con attenzione. Qulo non pretende nulla di più." },
      { q: "Su che cosa dovrei chiedere?", a: "Su ciò che vorresti che uno sconosciuto sapesse: a cosa tieni, come impieghi il tempo, una storia che racconteresti solo tu. Da 2 a 4 domande, quattro opzioni ciascuna." },
      { q: "Esiste un punteggio di compatibilità?", a: "No. Non ci sono tratti, categorie o percentuali: l'unica cosa registrata è se tutte le risposte erano giuste." },
    ],
    ja: [
      { q: "Quloは性格テストを行いますか？", a: "行いません。Quloは性格特性を測定せず、相性スコアも算出しません。質問は自分で書き、それに全問正解した人とマッチします。" },
      { q: "質問によるマッチは実際に何を示すのですか？", a: "何を尋ねるかを選んだ時点で、その質問はすでにあなたを語っています。そして正解は、相手がそれをよく読んだことを示します。Quloはそれ以上のことは主張しません。" },
      { q: "何について尋ねればいいですか？", a: "見知らぬ相手に知っておいてほしいことなら何でも。大切にしていること、時間の使い方、あなたにしか語れない出来事。質問は2〜4問、選択肢は各4つです。" },
      { q: "相性スコアはありますか？", a: "ありません。特性も分類もパーセンテージもなく、記録されるのは全問正解だったかどうかだけです。" },
    ],
    ko: [
      { q: "Qulo는 성격 검사를 하나요?", a: "하지 않습니다. Qulo는 어떤 성격 특성도 측정하지 않고 궁합 점수도 계산하지 않습니다. 질문은 본인이 쓰고, 그것을 모두 맞힌 사람과 매칭됩니다." },
      { q: "질문으로 매칭된다는 건 실제로 무엇을 말해 주나요?", a: "무엇을 묻기로 했는지가 이미 나를 보여 주고, 정답은 상대가 그것을 꼼꼼히 읽었음을 보여 줍니다. Qulo는 그 이상을 주장하지 않습니다." },
      { q: "무엇에 대해 물어야 하나요?", a: "낯선 사람이 알아 주었으면 하는 것이면 무엇이든. 무엇을 소중히 여기는지, 시간을 어떻게 쓰는지, 나만 할 수 있는 이야기. 질문 2~4개, 보기는 각각 네 개." },
      { q: "궁합 점수가 있나요?", a: "없습니다. 특성도, 범주도, 백분율도 없습니다. 기록되는 것은 모든 답이 맞았는지 여부뿐입니다." },
    ],
    zh: [
      { q: "Qulo 会做性格测试吗？", a: "不会。Qulo 不测量任何性格特质，也不计算契合度分数。题目由你自己写，谁把它们全部答对，就与谁配对。" },
      { q: "靠答题配对，实际上说明了什么？", a: "你选择问什么，本身就已经在说明你是谁；而答对则说明对方认真读过。除此之外，Qulo 不作任何声称。" },
      { q: "我该问些什么？", a: "凡是你希望陌生人知道的：你看重什么，时间花在哪里，一个只有你会讲的故事。2 到 4 道题，每道四个选项。" },
      { q: "有契合度分数吗？", a: "没有。没有特质、类别或百分比——被记录的只有一件事：是否每道题都答对了。" },
    ],
    nl: [
      { q: "Doet Qulo een persoonlijkheidstest?", a: "Nee. Qulo meet geen enkele persoonlijkheidstrek en berekent geen compatibiliteitsscore. Je schrijft je eigen vragen, en iemand matcht door ze allemaal goed te beantwoorden." },
      { q: "Wat zegt een match op vragen eigenlijk?", a: "De vragen die je kiest zeggen al iets over jou, en een goed antwoord laat zien dat de ander ze aandachtig heeft gelezen. Meer beweert Qulo niet." },
      { q: "Waarover moet ik vragen stellen?", a: "Over alles wat je een vreemde zou willen laten weten: waar je waarde aan hecht, waar je je tijd aan besteedt, een verhaal dat alleen jij zou vertellen. 2 tot 4 vragen, vier opties per stuk." },
      { q: "Is er een compatibiliteitsscore?", a: "Nee. Er zijn geen eigenschappen, categorieën of percentages — het enige dat wordt vastgelegd is of elk antwoord goed was." },
    ],
    pl: [
      { q: "Czy Qulo przeprowadza test osobowości?", a: "Nie. Qulo nie mierzy żadnej cechy osobowości i nie wylicza wskaźnika zgodności. Sam piszesz swoje pytania, a dopasowuje się ten, kto odpowie poprawnie na wszystkie." },
      { q: "Co właściwie mówi dopasowanie oparte na pytaniach?", a: "Już same pytania, które postanowiłeś zadać, coś o tobie mówią, a poprawna odpowiedź pokazuje, że druga osoba przeczytała je uważnie. Niczego więcej Qulo nie twierdzi." },
      { q: "O co powinienem pytać?", a: "O wszystko, o czym chciałbyś, żeby obca osoba wiedziała: co cenisz, na co idzie twój czas, historia, którą opowiedziałbyś tylko ty. Od 2 do 4 pytań, po cztery odpowiedzi." },
      { q: "Czy jest jakiś wynik zgodności?", a: "Nie. Nie ma cech, kategorii ani procentów — zapisywane jest tylko to, czy wszystkie odpowiedzi były poprawne." },
    ],
    sv: [
      { q: "Gör Qulo ett personlighetstest?", a: "Nej. Qulo mäter inget personlighetsdrag och räknar inte fram någon kompatibilitetspoäng. Du skriver dina egna frågor, och den som svarar rätt på allihop matchar." },
      { q: "Vad säger en matchning byggd på frågor egentligen?", a: "Frågorna du väljer att ställa säger redan något om dig, och ett rätt svar visar att den andra läste dem noga. Mer än så påstår Qulo inte." },
      { q: "Vad ska jag fråga om?", a: "Om det du skulle vilja att en främling visste: vad du värderar, vad din tid går till, en historia bara du skulle berätta. 2 till 4 frågor, fyra alternativ var." },
      { q: "Finns det någon kompatibilitetspoäng?", a: "Nej. Det finns inga egenskaper, kategorier eller procenttal — det enda som noteras är om varje svar var rätt." },
    ],
    hi: [
      { q: "क्या Qulo कोई पर्सनैलिटी टेस्ट लेता है?", a: "नहीं। Qulo किसी व्यक्तित्व गुण को नहीं मापता और न कोई अनुकूलता स्कोर निकालता है। सवाल आप ख़ुद लिखते हैं, और जो उन सबका सही जवाब दे, उससे मैच होता है।" },
      { q: "सवालों पर हुआ मैच असल में क्या बताता है?", a: "आपने क्या पूछना चुना, यही अपने आप में आपके बारे में कुछ कहता है; और सही जवाब दिखाता है कि सामने वाले ने उसे ध्यान से पढ़ा। इससे आगे Qulo कोई दावा नहीं करता।" },
      { q: "मुझे किस बारे में पूछना चाहिए?", a: "जो कुछ आप चाहेंगे कि कोई अजनबी जाने: आप किसे अहमियत देते हैं, समय कहाँ लगाते हैं, वह क़िस्सा जो सिर्फ़ आप सुनाएँगे। 2 से 4 सवाल, हर एक में चार विकल्प।" },
      { q: "क्या कोई अनुकूलता स्कोर होता है?", a: "नहीं। न गुण, न श्रेणियाँ, न प्रतिशत — दर्ज सिर्फ़ यह होता है कि हर जवाब सही था या नहीं।" },
    ],
  },
};
/* ------------------------------------------------------------------ */
/*  /about FAQs                                                        */
/* ------------------------------------------------------------------ */
/**
 * FAQs shown on /[locale]/about, in all 16 locales.
 *
 * Rewritten 2026-09-04 for the same reason as FEATURE_FAQS above: the set
 * carried `tr` and `en` only, and fourteen locales were served the English
 * questions and answers inside FAQPage JSON-LD, on pages whose hreflang,
 * canonical and `<html lang>` all promised another language.
 *
 * Three claims went with the rewrite and should not come back:
 *  - "founded in Istanbul by entrepreneurs experienced in the dating industry"
 *    — the site's own Terms and Privacy Policy name one independent developer,
 *    so the plural and the industry background were both invented.
 *  - "quickly grew into an international dating platform" — growth stated as
 *    fact, with nothing behind it.
 *  - "available worldwide" — replaced by the checkable version: wherever the
 *    two app stores are.
 *
 * The founding year (2026) matches foundingDate on /press and the Organization
 * JSON-LD; change them together or not at all.
 */
export const ABOUT_FAQS: FAQLocaleMap = {
  en: [
    { q: "What is Qulo?", a: "Qulo is a dating app where you match by answering questions instead of swiping. Every member writes 2 to 4 multiple-choice questions about themselves — up to 10 on a paid plan — four options each, and marks the correct one. You match with whoever gets all of them right." },
    { q: "Where can I use Qulo, and in which languages?", a: "Qulo works wherever the App Store or Google Play is available. The app is in 16 languages: Turkish, English, German, French, Spanish, Arabic, Russian, Portuguese, Italian, Japanese, Korean, Chinese, Dutch, Polish, Swedish and Hindi." },
    { q: "Who is behind Qulo?", a: "Qulo is built and run by Berkant Çalıkuşu, an independent developer based in Istanbul, Turkey, who founded it in 2026. He is also the data controller named in the privacy policy, and questions can go to info@socrepho.com." },
    { q: "What makes Qulo different from other dating apps?", a: "The condition for a match. On a swipe-based app two people match because they liked each other's photos; on Qulo somebody reaches you by answering every question you wrote about yourself correctly. There is no partial credit, no percentage and no ranking." },
  ],
  tr: [
    { q: "Qulo nedir?", a: "Qulo, kaydırmak yerine soru cevaplayarak eşleştiğin bir tanışma uygulamasıdır. Herkes kendisi hakkında 2 ila 4 çoktan seçmeli soru yazar — ücretli planlarda 10'a kadar — her birine dört şık verir ve doğru olanı işaretler. Hepsini doğru bilenle eşleşirsin." },
    { q: "Qulo'yu nerede ve hangi dillerde kullanabilirim?", a: "Qulo, App Store ya da Google Play'in kullanılabildiği her yerde çalışır. Uygulama 16 dilde: Türkçe, İngilizce, Almanca, Fransızca, İspanyolca, Arapça, Rusça, Portekizce, İtalyanca, Japonca, Korece, Çince, Felemenkçe, Lehçe, İsveççe ve Hintçe." },
    { q: "Qulo'nun arkasında kim var?", a: "Qulo'yu İstanbul'da yaşayan bağımsız geliştirici Berkant Çalıkuşu geliştiriyor ve yürütüyor; uygulamayı 2026'da o kurdu. Gizlilik politikasında adı geçen veri sorumlusu da kendisi; sorular için info@socrepho.com adresine yazabilirsin." },
    { q: "Qulo'nun diğer tanışma uygulamalarından farkı ne?", a: "Eşleşmenin koşulu. Swipe tabanlı bir uygulamada iki kişi birbirinin fotoğrafını beğenerek eşleşir; Qulo'da biri sana, kendin hakkında yazdığın soruların hepsini doğru cevaplayarak ulaşır. Kısmi puan, yüzde ya da sıralama yok." },
  ],
  de: [
    { q: "Was ist Qulo?", a: "Qulo ist eine Dating-App, in der du durch das Beantworten von Fragen matchst statt durch Swipen. Jedes Mitglied schreibt 2 bis 4 Multiple-Choice-Fragen über sich — mit einem bezahlten Abo bis zu 10 —, je vier Möglichkeiten, und markiert die richtige. Du matchst mit allen, die sie alle richtig beantworten." },
    { q: "Wo und in welchen Sprachen kann ich Qulo nutzen?", a: "Qulo funktioniert überall dort, wo App Store oder Google Play verfügbar sind. Die App gibt es in 16 Sprachen: Türkisch, Englisch, Deutsch, Französisch, Spanisch, Arabisch, Russisch, Portugiesisch, Italienisch, Japanisch, Koreanisch, Chinesisch, Niederländisch, Polnisch, Schwedisch und Hindi." },
    { q: "Wer steckt hinter Qulo?", a: "Qulo wird von Berkant Çalıkuşu entwickelt und betrieben, einem selbstständigen Entwickler aus Istanbul in der Türkei, der die App 2026 gegründet hat. Er ist auch der in der Datenschutzerklärung genannte Verantwortliche; Fragen gehen an info@socrepho.com." },
    { q: "Was unterscheidet Qulo von anderen Dating-Apps?", a: "Die Bedingung für ein Match. In einer Swipe-App matchen zwei Menschen, weil ihnen die Fotos des anderen gefallen; bei Qulo erreicht dich jemand, indem er jede Frage richtig beantwortet, die du über dich geschrieben hast. Es gibt keine Teilpunkte, keine Prozentzahl und kein Ranking." },
  ],
  fr: [
    { q: "Qu'est-ce que Qulo ?", a: "Qulo est une application de rencontre où l'on matche en répondant à des questions plutôt qu'en swipant. Chaque membre écrit de 2 à 4 questions à choix multiple sur lui-même — jusqu'à 10 avec un abonnement payant —, quatre options chacune, et coche la bonne. Vous matchez avec qui répond juste à toutes." },
    { q: "Où et dans quelles langues puis-je utiliser Qulo ?", a: "Qulo fonctionne partout où l'App Store ou Google Play est disponible. L'application existe en 16 langues : turc, anglais, allemand, français, espagnol, arabe, russe, portugais, italien, japonais, coréen, chinois, néerlandais, polonais, suédois et hindi." },
    { q: "Qui est derrière Qulo ?", a: "Qulo est développée et exploitée par Berkant Çalıkuşu, développeur indépendant établi à Istanbul, en Turquie, qui l'a fondée en 2026. C'est aussi le responsable de traitement indiqué dans la politique de confidentialité ; les questions peuvent être envoyées à info@socrepho.com." },
    { q: "Qu'est-ce qui distingue Qulo des autres applications de rencontre ?", a: "La condition du match. Sur une application à swipe, deux personnes matchent parce qu'elles ont aimé la photo de l'autre ; sur Qulo, on vous atteint en répondant correctement à chaque question que vous avez écrite sur vous. Pas de points partiels, pas de pourcentage, pas de classement." },
  ],
  es: [
    { q: "¿Qué es Qulo?", a: "Qulo es una app de citas en la que haces match respondiendo preguntas en vez de deslizando. Cada persona escribe de 2 a 4 preguntas de opción múltiple sobre sí misma —hasta 10 con una suscripción de pago—, cuatro opciones cada una, y marca la correcta. Haces match con quien las acierte todas." },
    { q: "¿Dónde y en qué idiomas puedo usar Qulo?", a: "Qulo funciona allí donde estén disponibles la App Store o Google Play. La app está en 16 idiomas: turco, inglés, alemán, francés, español, árabe, ruso, portugués, italiano, japonés, coreano, chino, neerlandés, polaco, sueco e hindi." },
    { q: "¿Quién está detrás de Qulo?", a: "Qulo la desarrolla y la gestiona Berkant Çalıkuşu, desarrollador independiente con base en Estambul, Turquía, que la fundó en 2026. Es también el responsable del tratamiento que figura en la política de privacidad, y las dudas se pueden enviar a info@socrepho.com." },
    { q: "¿Qué diferencia a Qulo de otras apps de citas?", a: "La condición del match. En una app de deslizar, dos personas hacen match porque les gusta la foto de la otra; en Qulo alguien llega hasta ti acertando todas las preguntas que escribiste sobre ti. No hay puntuación parcial, ni porcentaje, ni ranking." },
  ],
  ar: [
    { q: "ما هو Qulo؟", a: "Qulo تطبيق مواعدة يحدث فيه التطابق بالإجابة عن الأسئلة بدل التمرير. يكتب كل عضو من سؤالين إلى أربعة أسئلة اختيار من متعدد عن نفسه — وحتى عشرة أسئلة مع اشتراك مدفوع — لكل سؤال أربعة خيارات، ويحدّد الخيار الصحيح. وتتطابق مع من يجيب عنها كلها إجابة صحيحة." },
    { q: "أين يمكنني استخدام Qulo وبأي لغات؟", a: "يعمل Qulo في كل مكان يتوفر فيه App Store أو Google Play. والتطبيق متاح بستّ عشرة لغة: التركية والإنجليزية والألمانية والفرنسية والإسبانية والعربية والروسية والبرتغالية والإيطالية واليابانية والكورية والصينية والهولندية والبولندية والسويدية والهندية." },
    { q: "من يقف خلف Qulo؟", a: "يطوّر Qulo ويديره Berkant Çalıkuşu، وهو مطوّر مستقل مقيم في إسطنبول بتركيا، وقد أسّس التطبيق عام 2026. وهو أيضًا المسؤول عن البيانات المذكور في سياسة الخصوصية، ويمكن إرسال الأسئلة إلى info@socrepho.com." },
    { q: "ما الذي يميّز Qulo عن تطبيقات المواعدة الأخرى؟", a: "شرط التطابق. في تطبيق قائم على التمرير يتطابق شخصان لأن كلًا منهما أعجبته صورة الآخر؛ أما في Qulo فيصل إليك من يجيب إجابة صحيحة عن كل سؤال كتبته عن نفسك. لا درجات جزئية ولا نسبة مئوية ولا ترتيب." },
  ],
  ru: [
    { q: "Что такое Qulo?", a: "Qulo — приложение для знакомств, где совпадение достигается ответами на вопросы, а не свайпами. Каждый пишет от 2 до 4 вопросов о себе с четырьмя вариантами ответа и отмечает верный, а с платной подпиской вопросов может быть до 10. Вы совпадаете с тем, кто ответит верно на все." },
    { q: "Где и на каких языках доступен Qulo?", a: "Qulo работает везде, где доступны App Store или Google Play. Интерфейс приложения переведен на 16 языков: турецкий, английский, немецкий, французский, испанский, арабский, русский, португальский, итальянский, японский, корейский, китайский, нидерландский, польский, шведский и хинди." },
    { q: "Кто стоит за Qulo?", a: "Qulo разрабатывает и ведет Berkant Çalıkuşu, независимый разработчик из Стамбула, Турция, основавший приложение в 2026 году. Он же указан в политике конфиденциальности как оператор данных; вопросы можно писать на info@socrepho.com." },
    { q: "Чем Qulo отличается от других приложений для знакомств?", a: "Условием совпадения. В свайп-приложении двое совпадают, потому что им понравились фотографии друг друга; в Qulo до вас доходит тот, кто верно ответил на каждый ваш вопрос. Ни частичного зачета, ни процентов, ни рейтинга здесь нет." },
  ],
  pt: [
    { q: "O que é o Qulo?", a: "O Qulo é um app de relacionamento em que o match vem de responder perguntas, e não de deslizar. Cada pessoa escreve de 2 a 4 perguntas de múltipla escolha sobre si — até 10 com uma assinatura paga —, quatro alternativas cada, e marca a correta. Você dá match com quem acertar todas." },
    { q: "Onde e em quais idiomas posso usar o Qulo?", a: "O Qulo funciona onde houver App Store ou Google Play. O app está em 16 idiomas: turco, inglês, alemão, francês, espanhol, árabe, russo, português, italiano, japonês, coreano, chinês, neerlandês, polonês, sueco e hindi." },
    { q: "Quem está por trás do Qulo?", a: "O Qulo é desenvolvido e mantido por Berkant Çalıkuşu, desenvolvedor independente sediado em Istambul, na Turquia, que o fundou em 2026. Ele é também o controlador de dados indicado na política de privacidade, e dúvidas podem ir para info@socrepho.com." },
    { q: "O que diferencia o Qulo de outros apps de relacionamento?", a: "A condição do match. Num app de deslizar, duas pessoas combinam porque gostaram da foto uma da outra; no Qulo alguém chega até você acertando cada pergunta que você escreveu sobre si. Não há acerto parcial, porcentagem nem ranking." },
  ],
  it: [
    { q: "Che cos'è Qulo?", a: "Qulo è un'app di incontri in cui si fa match rispondendo a delle domande invece di scorrere i profili. Ogni persona scrive da 2 a 4 domande a risposta multipla su di sé — fino a 10 con un abbonamento a pagamento —, quattro opzioni ciascuna, e segna quella giusta. Fai match con chi le indovina tutte." },
    { q: "Dove e in quali lingue posso usare Qulo?", a: "Qulo funziona ovunque siano disponibili App Store o Google Play. L'app è in 16 lingue: turco, inglese, tedesco, francese, spagnolo, arabo, russo, portoghese, italiano, giapponese, coreano, cinese, olandese, polacco, svedese e hindi." },
    { q: "Chi c'è dietro Qulo?", a: "Qulo è sviluppata e gestita da Berkant Çalıkuşu, sviluppatore indipendente con sede a Istanbul, in Turchia, che l'ha fondata nel 2026. È anche il titolare del trattamento indicato nell'informativa sulla privacy, e le domande si possono inviare a info@socrepho.com." },
    { q: "Che cosa distingue Qulo dalle altre app di incontri?", a: "La condizione del match. In un'app a swipe due persone si trovano perché si sono piaciute in foto; su Qulo qualcuno ti raggiunge indovinando ogni domanda che hai scritto su di te. Non ci sono punteggi parziali, percentuali o classifiche." },
  ],
  ja: [
    { q: "Quloってどんなアプリですか？", a: "Quloは、スワイプではなく質問に答えることでマッチするデーティングアプリです。誰もが自分について選択式の質問を2〜4問書き（有料プランなら最大10問）、それぞれに選択肢を4つ用意して正解に印をつけます。全問正解した人とマッチします。" },
    { q: "Quloはどこで、何語で使えますか？", a: "App StoreまたはGoogle Playが使える場所ならどこでも利用できます。アプリは16の言語に対応しています。トルコ語、英語、ドイツ語、フランス語、スペイン語、アラビア語、ロシア語、ポルトガル語、イタリア語、日本語、韓国語、中国語、オランダ語、ポーランド語、スウェーデン語、ヒンディー語です。" },
    { q: "Quloは誰がつくっているのですか？", a: "トルコ・イスタンブールを拠点とする個人開発者、Berkant Çalıkuşuが開発・運営しています。2026年に立ち上げたのも本人です。プライバシーポリシーに記載されているデータ管理者も同じ人物で、問い合わせは info@socrepho.com までどうぞ。" },
    { q: "Quloはほかのデーティングアプリと何が違うのですか？", a: "マッチの条件です。スワイプ型のアプリでは、互いの写真を気に入った二人がマッチします。Quloでは、あなたが自分について書いた質問にすべて正解した人があなたに届きます。部分点も、パーセンテージも、順位もありません。" },
  ],
  ko: [
    { q: "Qulo는 어떤 앱인가요?", a: "Qulo는 스와이프가 아니라 질문에 답해서 매칭되는 데이팅 앱입니다. 누구나 자신에 대한 객관식 질문을 2~4개 쓰고(유료 플랜은 최대 10개), 각각 보기를 네 개 두고 맞는 것을 정답으로 표시합니다. 그것을 모두 맞힌 사람과 매칭됩니다." },
    { q: "Qulo는 어디서, 어떤 언어로 쓸 수 있나요?", a: "App Store나 Google Play를 이용할 수 있는 곳이면 어디서나 쓸 수 있습니다. 앱은 16개 언어를 지원합니다. 터키어, 영어, 독일어, 프랑스어, 스페인어, 아랍어, 러시아어, 포르투갈어, 이탈리아어, 일본어, 한국어, 중국어, 네덜란드어, 폴란드어, 스웨덴어, 힌디어입니다." },
    { q: "Qulo는 누가 만드나요?", a: "터키 이스탄불에 있는 독립 개발자 Berkant Çalıkuşu가 개발하고 운영하며, 2026년에 이 앱을 시작한 사람도 그입니다. 개인정보 처리방침에 적힌 데이터 관리자도 같은 사람이며, 문의는 info@socrepho.com으로 보내면 됩니다." },
    { q: "Qulo는 다른 데이팅 앱과 무엇이 다른가요?", a: "매칭의 조건이 다릅니다. 스와이프 앱에서는 서로의 사진이 마음에 든 두 사람이 매칭되지만, Qulo에서는 내가 나에 대해 쓴 질문을 모두 맞힌 사람이 나에게 닿습니다. 부분 점수도, 백분율도, 순위도 없습니다." },
  ],
  zh: [
    { q: "Qulo 是什么？", a: "Qulo 是一款靠答题而不是滑动来配对的交友应用。每个人都为自己写 2 到 4 道选择题（付费方案最多 10 道），每题四个选项，并标出正确答案。把这些题全部答对的人，就和你配对。" },
    { q: "Qulo 在哪里、用什么语言可以使用？", a: "只要能用 App Store 或 Google Play 的地方都可以使用。应用支持 16 种语言：土耳其语、英语、德语、法语、西班牙语、阿拉伯语、俄语、葡萄牙语、意大利语、日语、韩语、中文、荷兰语、波兰语、瑞典语和印地语。" },
    { q: "Qulo 背后是谁？", a: "Qulo 由常驻土耳其伊斯坦布尔的独立开发者 Berkant Çalıkuşu 开发和运营，也由他在 2026 年创立。他同时是隐私政策中列明的数据控制者，问题可以发到 info@socrepho.com。" },
    { q: "Qulo 和其他交友应用有什么不同？", a: "不同在配对的条件。在滑动式应用里，两个人因为喜欢彼此的照片而配对；在 Qulo，能走到你面前的，是把你为自己写下的每一道题都答对的人。这里没有部分得分，没有百分比，也没有排名。" },
  ],
  nl: [
    { q: "Wat is Qulo?", a: "Qulo is een datingapp waarin je matcht door vragen te beantwoorden in plaats van te swipen. Iedereen schrijft 2 tot 4 meerkeuzevragen over zichzelf — met een betaald abonnement tot 10 —, vier opties per vraag, en markeert het juiste antwoord. Je matcht met wie ze allemaal goed heeft." },
    { q: "Waar en in welke talen kan ik Qulo gebruiken?", a: "Qulo werkt overal waar de App Store of Google Play beschikbaar is. De app is er in 16 talen: Turks, Engels, Duits, Frans, Spaans, Arabisch, Russisch, Portugees, Italiaans, Japans, Koreaans, Chinees, Nederlands, Pools, Zweeds en Hindi." },
    { q: "Wie zit er achter Qulo?", a: "Qulo wordt gemaakt en beheerd door Berkant Çalıkuşu, een zelfstandige ontwikkelaar in Istanbul, Turkije, die de app in 2026 oprichtte. Hij is ook de verwerkingsverantwoordelijke die in het privacybeleid staat; vragen kunnen naar info@socrepho.com." },
    { q: "Wat maakt Qulo anders dan andere datingapps?", a: "De voorwaarde voor een match. In een swipe-app matchen twee mensen omdat ze elkaars foto leuk vonden; op Qulo bereikt iemand jou door elke vraag die jij over jezelf schreef goed te beantwoorden. Er is geen deelscore, geen percentage en geen ranglijst." },
  ],
  pl: [
    { q: "Czym jest Qulo?", a: "Qulo to aplikacja randkowa, w której dopasowanie powstaje przez odpowiadanie na pytania, a nie przez przesuwanie. Każdy pisze o sobie od 2 do 4 pytań wielokrotnego wyboru — w płatnej subskrypcji nawet 10 — po cztery odpowiedzi w każdym, i zaznacza poprawną. Dopasowujesz się z tym, kto trafi wszystkie." },
    { q: "Gdzie i w jakich językach mogę korzystać z Qulo?", a: "Qulo działa wszędzie tam, gdzie dostępne są App Store lub Google Play. Aplikacja jest w 16 językach: tureckim, angielskim, niemieckim, francuskim, hiszpańskim, arabskim, rosyjskim, portugalskim, włoskim, japońskim, koreańskim, chińskim, niderlandzkim, polskim, szwedzkim i hindi." },
    { q: "Kto stoi za Qulo?", a: "Qulo tworzy i prowadzi Berkant Çalıkuşu, niezależny programista ze Stambułu w Turcji, który założył aplikację w 2026 roku. Jest też administratorem danych wskazanym w polityce prywatności, a pytania można kierować na info@socrepho.com." },
    { q: "Czym Qulo różni się od innych aplikacji randkowych?", a: "Warunkiem dopasowania. W aplikacji z przesuwaniem dwie osoby łączą się, bo spodobały im się zdjęcia; w Qulo dociera do ciebie ten, kto poprawnie odpowie na każde pytanie, które o sobie napisałeś. Nie ma punktów częściowych, procentów ani rankingu." },
  ],
  sv: [
    { q: "Vad är Qulo?", a: "Qulo är en dejtingapp där man matchar genom att svara på frågor i stället för att svepa. Var och en skriver 2 till 4 flervalsfrågor om sig själv — upp till 10 med ett betalt abonnemang —, fyra alternativ vardera, och markerar det rätta svaret. Du matchar med den som får alla rätt." },
    { q: "Var och på vilka språk kan jag använda Qulo?", a: "Qulo fungerar överallt där App Store eller Google Play finns. Appen är på 16 språk: turkiska, engelska, tyska, franska, spanska, arabiska, ryska, portugisiska, italienska, japanska, koreanska, kinesiska, nederländska, polska, svenska och hindi." },
    { q: "Vem står bakom Qulo?", a: "Qulo byggs och drivs av Berkant Çalıkuşu, en oberoende utvecklare i Istanbul i Turkiet, som grundade appen 2026. Han är också den personuppgiftsansvarige som anges i integritetspolicyn, och frågor går till info@socrepho.com." },
    { q: "Vad skiljer Qulo från andra dejtingappar?", a: "Villkoret för en matchning. I en svepapp matchar två personer för att de gillade varandras foton; på Qulo når någon fram till dig genom att svara rätt på varenda fråga du skrivit om dig själv. Det finns inga delpoäng, ingen procentsats och ingen rangordning." },
  ],
  hi: [
    { q: "Qulo क्या है?", a: "Qulo एक डेटिंग ऐप है जिसमें मैच स्वाइप से नहीं, सवालों के जवाब देने से होता है। हर कोई अपने बारे में 2 से 4 बहुविकल्पीय सवाल लिखता है — सशुल्क प्लान पर 10 तक — हर सवाल में चार विकल्प देता है और सही वाला चिह्नित करता है। जो सब सही करे, उससे मैच होता है।" },
    { q: "Qulo कहाँ और किन भाषाओं में इस्तेमाल कर सकते हैं?", a: "जहाँ भी App Store या Google Play उपलब्ध है, वहाँ Qulo चलता है। ऐप 16 भाषाओं में है: तुर्की, अंग्रेज़ी, जर्मन, फ़्रेंच, स्पेनिश, अरबी, रूसी, पुर्तगाली, इतालवी, जापानी, कोरियाई, चीनी, डच, पोलिश, स्वीडिश और हिंदी।" },
    { q: "Qulo के पीछे कौन है?", a: "Qulo को तुर्की के इस्तांबुल में रहने वाले स्वतंत्र डेवलपर Berkant Çalıkuşu बनाते और चलाते हैं, और 2026 में इसकी शुरुआत भी उन्होंने ही की। प्राइवेसी पॉलिसी में दर्ज डेटा कंट्रोलर भी वही हैं, और सवाल info@socrepho.com पर भेजे जा सकते हैं।" },
    { q: "Qulo दूसरी डेटिंग ऐप्स से कैसे अलग है?", a: "मैच की शर्त अलग है। स्वाइप वाली ऐप में दो लोग इसलिए मैच होते हैं कि उन्हें एक-दूसरे की फ़ोटो पसंद आई; Qulo पर आप तक वही पहुँचता है जो आपके अपने बारे में लिखे हर सवाल का सही जवाब दे। यहाँ न आंशिक अंक हैं, न प्रतिशत, न कोई रैंकिंग।" },
  ],
};

/**
 * Resolve FAQ items for a slug + locale. Every set carries all 16 locales, so
 * the `en` fallback should never fire; it stays as a guard against a mistyped
 * locale key silently rendering an empty accordion.
 * Returns an empty array if the slug is unknown.
 */
export function getFeatureFaqs(slug: string, locale: string): FAQItem[] {
  const map = FEATURE_FAQS[slug];
  if (!map) return [];
  return map[locale] || map.en || [];
}

/** Resolve About-page FAQ items, with the same defensive EN fallback. */
export function getAboutFaqs(locale: string): FAQItem[] {
  return ABOUT_FAQS[locale] || ABOUT_FAQS.en || [];
}
