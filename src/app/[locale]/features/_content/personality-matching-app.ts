import type { LandingContent } from "@/lib/constants/landings";

/**
 * Body copy for /[locale]/features/personality-matching-app, in all 16 locales.
 *
 * Written 2026-09-04. The previous version of this page was the most
 * over-claimed of the three, and the rewrite is deliberately blunt about the
 * limits: Qulo measures no personality trait and calculates no compatibility
 * score, and every locale says so in the third paragraph and again in the
 * second bullet.
 *
 * Removed and not to be reinstated:
 *  - "Research shows that in long-term relationships, it is personality
 *    compatibility — not physical attraction — that matters most" — an
 *    unattributed finding about relationship outcomes.
 *  - "AI-powered personality analysis" — the app runs no such analysis.
 *  - "Correct answers are proof of real compatibility" — a correct answer shows
 *    that someone knew or worked out the answer, and nothing beyond that. The
 *    page now says exactly that much.
 *  - "the world's first quiz-based dating app" — unverifiable superlative.
 *
 * The page still ranks for "personality matching app" on the honest version of
 * the claim: you decide what a stranger has to know about you, rather than a
 * questionnaire deciding it for you.
 */
export const personalityMatchingApp: Record<string, LandingContent> = {
  en: {
    heroTitle: "Personality Matching App: Matched by Your Own Questions",
    heroSub:
      "Qulo does not test your personality or score it. You write the questions that say something about you, and match with whoever gets them all right.",
    problemTitle: "The Trouble With Matching on Appearance",
    problemParagraphs: [
      "On a swipe-based app, the first decision anyone makes about you comes from a photograph. Whatever you would actually want a stranger to know — what you care about, what you find funny, how you spend a free Saturday — plays no part in it, because none of it is visible in the picture.",
      "The usual remedy is a compatibility questionnaire: answer a fixed list of items, receive a score, get shown people with similar scores. That hands the definition of who you are to whoever wrote the questionnaire, and it produces a number nobody outside the app can check.",
      "Qulo takes a third route, and it is worth stating plainly: Qulo does not measure personality and calculates no compatibility score. What it does is let you write the questions yourself — between two and four of them, up to ten on a paid plan, four options each, with the true answer marked — and a match happens only when someone gets every single one right.",
    ],
    solutionTitle: "You Decide What Counts, Not a Test",
    solutionBullets: [
      {
        title: "Your questions, your subject matter",
        desc: "You choose what a stranger has to know: what you value, how you spend your time, a story only you would tell. Two to four questions — up to ten on a paid plan — four options each.",
      },
      {
        title: "No score, no personality type",
        desc: "Qulo assigns no traits, no categories and no percentages. The only thing measured is whether someone answered correctly.",
      },
      {
        title: "One standard, applied to everyone",
        desc: "Anyone who wants to reach you answers the same set you wrote. Getting all of it right is the whole test.",
      },
      {
        title: "Attention is the signal",
        desc: "One wrong answer ends the attempt, so a match tells you something simple and checkable: this person paid attention to what you said about yourself.",
      },
    ],
    steps: [
      {
        title: "Write questions that say something",
        desc: "Two to four multiple-choice questions about who you are, four options each, with the correct answer marked.",
      },
      {
        title: "Answer someone else's set",
        desc: "Read what they chose to ask. The questions themselves already tell you a good deal about the person who wrote them.",
      },
      {
        title: "Match on a perfect set",
        desc: "Every answer right, and the chat opens. There is no rating to wait for — the answers are the whole thing.",
      },
    ],
  },
  tr: {
    heroTitle: "Kişilik Eşleşme Uygulaması: Kendi Sorularınla Eşleş",
    heroSub:
      "Qulo kişiliğini ölçmez, puanlamaz. Seni anlatan soruları sen yazarsın ve hepsini doğru bilenle eşleşirsin.",
    problemTitle: "Görünüşe Bakarak Eşleştirmenin Sorunu",
    problemParagraphs: [
      "Kaydırma tabanlı bir uygulamada senin hakkındaki ilk karar bir fotoğrafa bakılarak verilir. Bir yabancının senin hakkında bilmesini isteyeceğin şeyler — neye önem verdiğin, neye güldüğün, boş bir cumartesiyi nasıl geçirdiğin — bu kararın hiçbir parçası değildir; çünkü hiçbiri fotoğrafta görünmez.",
      "Alışılmış çözüm bir uyumluluk anketidir: hazır bir soru listesini doldurursun, bir puan alırsın, benzer puanlı insanlar karşına çıkar. Bu, senin kim olduğunun tarifini anketi yazan kişiye devretmek demektir ve ortaya uygulamanın dışından kimsenin doğrulayamayacağı bir sayı çıkar.",
      "Qulo üçüncü bir yol izliyor ve bunu açıkça söylemekte fayda var: Qulo kişilik ölçmez ve herhangi bir uyumluluk puanı hesaplamaz. Yaptığı şey, soruları senin yazmana izin vermektir — 2 ila 4 soru, ücretli planda 10'a kadar, her birinde dört şık ve işaretlenmiş bir doğru cevap — ve eşleşme yalnızca birinin hepsini doğru bilmesiyle gerçekleşir.",
    ],
    solutionTitle: "Neyin Önemli Olduğuna Bir Test Değil, Sen Karar Verirsin",
    solutionBullets: [
      {
        title: "Sorular senin, konu senin",
        desc: "Bir yabancının ne bilmesi gerektiğini sen seçersin: neye değer verdiğini, vaktini nasıl geçirdiğini, yalnızca senin anlatabileceğin bir hikâyeyi. 2 ila 4 soru — ücretli planda 10'a kadar — her birinde dört şık.",
      },
      {
        title: "Puan yok, kişilik tipi yok",
        desc: "Qulo sana özellik atamaz, kategori vermez, yüzde hesaplamaz. Ölçülen tek şey birinin doğru cevaplayıp cevaplamadığıdır.",
      },
      {
        title: "Herkese aynı ölçüt",
        desc: "Sana ulaşmak isteyen herkes senin yazdığın aynı seti çözer. Hepsini doğru bilmek testin tamamıdır.",
      },
      {
        title: "İşaret, gösterilen dikkattir",
        desc: "Tek yanlış cevap denemeyi bitirir; yani bir eşleşme sana basit ve doğrulanabilir bir şey söyler: bu kişi, kendin hakkında yazdıklarına dikkat etmiş.",
      },
    ],
    steps: [
      {
        title: "Bir şey anlatan sorular yaz",
        desc: "Kim olduğunla ilgili 2 ila 4 çoktan seçmeli soru; her birinde dört şık ve işaretlenmiş doğru cevap.",
      },
      {
        title: "Başkasının setini çöz",
        desc: "Neyi sormayı seçtiğini oku. Sorular daha en baştan, onları yazan kişi hakkında epey şey anlatır.",
      },
      {
        title: "Eksiksiz bir setle eşleş",
        desc: "Bütün cevaplar doğruysa sohbet açılır. Beklenecek bir uyum notu yoktur — mesele cevapların kendisidir.",
      },
    ],
  },
  de: {
    heroTitle: "Persönlichkeits-Matching-App: Match über deine eigenen Fragen",
    heroSub:
      "Qulo testet deine Persönlichkeit nicht und bewertet sie nicht. Du schreibst die Fragen, die etwas über dich sagen, und matchst mit dem, der alle richtig hat.",
    problemTitle: "Das Problem am Matching nach Aussehen",
    problemParagraphs: [
      "In einer Swipe-App fällt die erste Entscheidung über dich anhand eines Fotos. Alles, was ein fremder Mensch eigentlich über dich wissen sollte — was dir wichtig ist, worüber du lachst, wie du einen freien Samstag verbringst — spielt dabei keine Rolle, weil nichts davon auf dem Bild zu sehen ist.",
      "Das übliche Gegenmittel ist ein Kompatibilitätsfragebogen: Du beantwortest eine feste Liste, bekommst einen Wert und siehst Menschen mit ähnlichen Werten. Damit überlässt du die Definition dessen, wer du bist, demjenigen, der den Fragebogen geschrieben hat — und heraus kommt eine Zahl, die außerhalb der App niemand überprüfen kann.",
      "Qulo geht einen dritten Weg, und das gehört klar gesagt: Qulo misst keine Persönlichkeit und berechnet keinen Kompatibilitätswert. Es lässt dich die Fragen selbst schreiben — 2 bis 4 Stück, bis zu 10 im kostenpflichtigen Tarif, je vier Möglichkeiten, die zutreffende markiert — und ein Match entsteht nur, wenn jemand jede einzelne richtig hat.",
    ],
    solutionTitle: "Du entscheidest, was zählt — kein Test",
    solutionBullets: [
      {
        title: "Deine Fragen, dein Thema",
        desc: "Du wählst, was ein fremder Mensch wissen muss: was dir wichtig ist, wie du deine Zeit verbringst, eine Geschichte, die nur du erzählen würdest. 2 bis 4 Fragen — bis zu 10 im kostenpflichtigen Tarif — mit je vier Möglichkeiten.",
      },
      {
        title: "Kein Score, kein Persönlichkeitstyp",
        desc: "Qulo vergibt keine Eigenschaften, keine Kategorien und keine Prozentzahlen. Gemessen wird einzig, ob jemand richtig geantwortet hat.",
      },
      {
        title: "Ein Maßstab für alle",
        desc: "Wer dich erreichen will, beantwortet dasselbe Set, das du geschrieben hast. Alles richtig zu haben ist die ganze Prüfung.",
      },
      {
        title: "Das Signal ist Aufmerksamkeit",
        desc: "Eine falsche Antwort beendet den Versuch. Ein Match sagt dir also etwas Einfaches und Überprüfbares: Diese Person hat gelesen, was du über dich geschrieben hast.",
      },
    ],
    steps: [
      {
        title: "Schreib Fragen, die etwas sagen",
        desc: "2 bis 4 Multiple-Choice-Fragen darüber, wer du bist, je vier Möglichkeiten, die richtige markiert.",
      },
      {
        title: "Beantworte das Set einer anderen Person",
        desc: "Lies, was sie zu fragen gewählt hat. Schon die Fragen selbst verraten einiges über die Person, die sie geschrieben hat.",
      },
      {
        title: "Match bei fehlerfreiem Set",
        desc: "Jede Antwort richtig, und der Chat öffnet sich. Auf eine Bewertung wartet niemand — es geht allein um die Antworten.",
      },
    ],
  },
  fr: {
    heroTitle: "App de matching par la personnalité : vos propres questions",
    heroSub:
      "Qulo ne teste pas votre personnalité et ne lui donne aucune note. Vous écrivez les questions qui parlent de vous et matchez avec qui répond juste à toutes.",
    problemTitle: "Le problème du matching sur l'apparence",
    problemParagraphs: [
      "Sur une application à swipe, la première décision prise à votre sujet se fonde sur une photo. Tout ce qu'un inconnu devrait vraiment savoir de vous — ce à quoi vous tenez, ce qui vous fait rire, comment vous passez un samedi libre — n'y entre pour rien, puisque rien de tout cela n'est visible sur l'image.",
      "Le remède habituel est un questionnaire de compatibilité : vous répondez à une liste fixe, vous recevez un score, on vous montre des gens au score voisin. Cela revient à confier la définition de qui vous êtes à celui qui a rédigé le questionnaire, et à produire un chiffre que personne, hors de l'application, ne peut vérifier.",
      "Qulo emprunte une troisième voie, et autant le dire nettement : Qulo ne mesure pas la personnalité et ne calcule aucun score de compatibilité. Ce qu'il fait, c'est vous laisser écrire les questions vous-même — de 2 à 4, jusqu'à 10 avec un abonnement payant, quatre options chacune, la bonne réponse cochée — et le match n'a lieu que si quelqu'un les trouve toutes.",
    ],
    solutionTitle: "C'est vous qui décidez de ce qui compte, pas un test",
    solutionBullets: [
      {
        title: "Vos questions, votre sujet",
        desc: "Vous choisissez ce qu'un inconnu doit savoir : ce à quoi vous tenez, comment vous occupez votre temps, une histoire que vous seul raconteriez. De 2 à 4 questions — jusqu'à 10 avec un abonnement payant —, quatre options chacune.",
      },
      {
        title: "Aucun score, aucun type de personnalité",
        desc: "Qulo n'attribue ni trait, ni catégorie, ni pourcentage. La seule chose mesurée est de savoir si quelqu'un a répondu juste.",
      },
      {
        title: "Une même règle pour tout le monde",
        desc: "Quiconque veut vous atteindre répond à la série que vous avez écrite. Tout trouver, c'est l'épreuve entière.",
      },
      {
        title: "Le signal, c'est l'attention",
        desc: "Une seule erreur met fin à la tentative. Un match vous dit donc quelque chose de simple et de vérifiable : cette personne a prêté attention à ce que vous avez dit de vous.",
      },
    ],
    steps: [
      {
        title: "Écrivez des questions qui disent quelque chose",
        desc: "De 2 à 4 questions à choix multiple sur qui vous êtes, quatre options chacune, la bonne réponse cochée.",
      },
      {
        title: "Répondez à la série de quelqu'un d'autre",
        desc: "Lisez ce qu'il a choisi de demander. Les questions elles-mêmes en disent déjà long sur la personne qui les a écrites.",
      },
      {
        title: "Matchez sur une série parfaite",
        desc: "Toutes les réponses justes, et la conversation s'ouvre. Aucune note à attendre : ce sont les réponses qui font tout.",
      },
    ],
  },
  es: {
    heroTitle: "App de match por personalidad: con tus propias preguntas",
    heroSub:
      "Qulo no evalúa tu personalidad ni la puntúa. Tú escribes las preguntas que hablan de ti y haces match con quien las acierte todas.",
    problemTitle: "El problema de emparejar por apariencia",
    problemParagraphs: [
      "En una app basada en deslizar, la primera decisión que alguien toma sobre ti sale de una foto. Todo lo que de verdad querrías que un desconocido supiera de ti —qué te importa, qué te hace reír, cómo pasas un sábado libre— no interviene para nada, porque nada de eso se ve en la imagen.",
      "El remedio habitual es un cuestionario de compatibilidad: respondes una lista fija, recibes una puntuación y te muestran personas con puntuaciones parecidas. Eso entrega la definición de quién eres a quien redactó el cuestionario y produce un número que fuera de la app nadie puede comprobar.",
      "Qulo toma un tercer camino, y conviene decirlo sin rodeos: Qulo no mide la personalidad ni calcula ninguna puntuación de compatibilidad. Lo que hace es dejar que escribas tú las preguntas —de 2 a 4, hasta 10 con un plan de pago, cuatro opciones cada una y la verdadera marcada— y el match solo ocurre cuando alguien las acierta todas.",
    ],
    solutionTitle: "Decides tú lo que cuenta, no un test",
    solutionBullets: [
      {
        title: "Tus preguntas, tu tema",
        desc: "Eliges qué debe saber un desconocido: qué valoras, cómo empleas tu tiempo, una historia que solo tú contarías. De 2 a 4 preguntas —hasta 10 con un plan de pago—, cuatro opciones cada una.",
      },
      {
        title: "Sin puntuación ni tipo de personalidad",
        desc: "Qulo no asigna rasgos, ni categorías, ni porcentajes. Lo único que se mide es si alguien respondió correctamente.",
      },
      {
        title: "Un mismo listón para todos",
        desc: "Quien quiera llegar a ti responde la misma tanda que tú escribiste. Acertarla entera es toda la prueba.",
      },
      {
        title: "La señal es la atención",
        desc: "Un fallo termina el intento, así que un match te dice algo sencillo y comprobable: esta persona prestó atención a lo que contaste de ti.",
      },
    ],
    steps: [
      {
        title: "Escribe preguntas que digan algo",
        desc: "De 2 a 4 preguntas de opción múltiple sobre quién eres, cuatro opciones cada una y la correcta marcada.",
      },
      {
        title: "Responde la tanda de otra persona",
        desc: "Lee lo que eligió preguntar. Las preguntas ya cuentan bastante sobre quien las escribió.",
      },
      {
        title: "Haz match con una tanda perfecta",
        desc: "Todas las respuestas bien y se abre el chat. No hay ninguna nota que esperar: son las respuestas y nada más.",
      },
    ],
  },
  ar: {
    heroTitle: "تطبيق تطابق بالشخصية: بأسئلتك أنت",
    heroSub:
      "لا يختبر Qulo شخصيتك ولا يمنحها درجة. أنت تكتب الأسئلة التي تحكي عنك، وتتطابق مع من يجيب عنها كلها إجابة صحيحة.",
    problemTitle: "مشكلة التطابق القائم على المظهر",
    problemParagraphs: [
      "في تطبيق يقوم على التمرير، أول قرار يُتخذ بشأنك يأتي من صورة. أما ما تودّ فعلًا أن يعرفه غريب عنك — ما الذي يهمّك، وما الذي يضحكك، وكيف تقضي سبتًا فارغًا — فلا دخل له في ذلك القرار، لأن شيئًا منه لا يظهر في الصورة.",
      "العلاج المعتاد استبيان توافق: تجيب عن قائمة جاهزة، فتحصل على درجة، ثم تُعرض عليك وجوه بدرجات مقاربة. هذا يسلّم تعريف من تكون إلى من كتب الاستبيان، ويخرج برقم لا يستطيع أحد خارج التطبيق التحقق منه.",
      "يسلك Qulo طريقًا ثالثًا، ويجدر قوله بوضوح: Qulo لا يقيس الشخصية ولا يحسب أي درجة توافق. ما يفعله أنه يترك لك كتابة الأسئلة بنفسك — بين سؤالين و4 أسئلة، حتى 10 أسئلة في الخطة المدفوعة، لكل منها أربعة خيارات وإجابة صحيحة محدّدة — ولا يحدث التطابق إلا حين يجيب أحدهم عنها جميعًا إجابة صحيحة.",
    ],
    solutionTitle: "أنت من يقرّر ما يهمّ، لا اختبار جاهز",
    solutionBullets: [
      {
        title: "أسئلتك، وموضوعك",
        desc: "أنت تختار ما ينبغي أن يعرفه الغريب: ما تقدّره، وكيف تمضي وقتك، وحكاية لا يرويها سواك. بين سؤالين و4 أسئلة — حتى 10 أسئلة في الخطة المدفوعة — لكل منها أربعة خيارات.",
      },
      {
        title: "لا درجة ولا نمط شخصية",
        desc: "لا يسند إليك Qulo سمات ولا فئات ولا نسبًا مئوية. الشيء الوحيد المقيس هو ما إذا كانت الإجابة صحيحة.",
      },
      {
        title: "معيار واحد يسري على الجميع",
        desc: "كل من يريد الوصول إليك يجيب عن المجموعة نفسها التي كتبتها. والإجابة الصحيحة عنها كلها هي الاختبار بأكمله.",
      },
      {
        title: "الإشارة هي الانتباه",
        desc: "إجابة خاطئة واحدة تنهي المحاولة، لذا يقول لك التطابق شيئًا بسيطًا يمكن التحقق منه: هذا الشخص انتبه لما قلته عن نفسك.",
      },
    ],
    steps: [
      {
        title: "اكتب أسئلة تقول شيئًا",
        desc: "بين سؤالين و4 أسئلة اختيار من متعدد عمّن أنت، لكل منها أربعة خيارات وإجابة صحيحة محدّدة.",
      },
      {
        title: "أجب عن مجموعة غيرك",
        desc: "اقرأ ما اختار أن يسأل عنه. الأسئلة نفسها تخبرك بالكثير عن كاتبها.",
      },
      {
        title: "تطابَق بمجموعة كاملة",
        desc: "كل الإجابات صحيحة، فتُفتح المحادثة. لا تقييم تنتظره — الإجابات هي كل ما في الأمر.",
      },
    ],
  },
  ru: {
    heroTitle: "Совпадение по личности: по вашим собственным вопросам",
    heroSub:
      "Qulo не тестирует вашу личность и не выставляет ей оценок. Вы пишете вопросы, которые говорят о вас, и совпадаете с тем, кто ответит на все верно.",
    problemTitle: "В чем беда подбора по внешности",
    problemParagraphs: [
      "В приложении со свайпами первое решение о вас принимают по фотографии. Все, что вы на самом деле хотели бы сообщить незнакомому человеку, — что вам важно, над чем вы смеетесь, как проводите свободную субботу — в этом решении не участвует, потому что ничего этого на снимке не видно.",
      "Обычное лекарство — анкета совместимости: вы отвечаете на готовый список, получаете балл, вам показывают людей с похожими баллами. Так определение того, кто вы, отдается автору анкеты, а на выходе получается число, которое за пределами приложения проверить невозможно.",
      "Qulo идет третьим путем, и об этом стоит сказать прямо: Qulo не измеряет личность и не вычисляет никакого показателя совместимости. Он позволяет вам написать вопросы самому — от 2 до 4, до 10 на платном тарифе, по четыре варианта в каждом, с отмеченным верным — и совпадение возникает, только если кто-то ответил верно на все.",
    ],
    solutionTitle: "Что важно, решаете вы, а не тест",
    solutionBullets: [
      {
        title: "Ваши вопросы, ваша тема",
        desc: "Вы выбираете, что незнакомому человеку положено знать: что вам дорого, на что уходит ваше время, история, которую расскажете только вы. От 2 до 4 вопросов — до 10 на платном тарифе — по четыре варианта.",
      },
      {
        title: "Ни балла, ни типа личности",
        desc: "Qulo не приписывает черт, не раздает категорий и не считает процентов. Измеряется только одно: ответил человек верно или нет.",
      },
      {
        title: "Одна мерка для всех",
        desc: "Каждый, кто хочет до вас добраться, отвечает на тот же набор, который написали вы. Ответить на все верно — вот и все испытание.",
      },
      {
        title: "Сигнал — это внимание",
        desc: "Одна ошибка завершает попытку, поэтому совпадение говорит вам нечто простое и проверяемое: этот человек отнесся внимательно к тому, что вы о себе написали.",
      },
    ],
    steps: [
      {
        title: "Напишите вопросы, которые что-то говорят",
        desc: "От 2 до 4 вопросов о том, кто вы, по четыре варианта ответа, верный отмечен.",
      },
      {
        title: "Ответьте на чужой набор",
        desc: "Прочитайте, о чем человек решил спросить. Сами вопросы уже немало рассказывают об их авторе.",
      },
      {
        title: "Совпадение при безошибочном наборе",
        desc: "Все ответы верны — и переписка открыта. Ждать оценки не нужно: дело только в ответах.",
      },
    ],
  },
  pt: {
    heroTitle: "App de match por personalidade: com as suas perguntas",
    heroSub:
      "O Qulo não testa a sua personalidade nem lhe dá nota. Você escreve as perguntas que falam de você e combina com quem acertar todas.",
    problemTitle: "O problema de combinar pela aparência",
    problemParagraphs: [
      "Num app baseado em deslizar, a primeira decisão que alguém toma sobre você vem de uma foto. Tudo o que você realmente gostaria que um desconhecido soubesse — o que lhe importa, o que lhe faz rir, como passa um sábado livre — não entra nessa decisão, porque nada disso aparece na imagem.",
      "O remédio de sempre é um questionário de compatibilidade: você responde a uma lista pronta, recebe uma pontuação e vê pessoas com pontuações parecidas. Isso entrega a definição de quem você é a quem redigiu o questionário e produz um número que, fora do aplicativo, ninguém consegue conferir.",
      "O Qulo segue um terceiro caminho, e vale dizer com todas as letras: o Qulo não mede personalidade e não calcula nenhuma pontuação de compatibilidade. O que ele faz é deixar que você escreva as perguntas — de 2 a 4, até 10 num plano pago, quatro alternativas cada, com a verdadeira marcada — e o match só acontece quando alguém acerta todas.",
    ],
    solutionTitle: "Quem decide o que conta é você, não um teste",
    solutionBullets: [
      {
        title: "Suas perguntas, seu assunto",
        desc: "Você escolhe o que um desconhecido precisa saber: o que valoriza, como ocupa o seu tempo, uma história que só você contaria. De 2 a 4 perguntas — até 10 num plano pago —, quatro alternativas cada.",
      },
      {
        title: "Sem pontuação e sem tipo de personalidade",
        desc: "O Qulo não atribui traços, nem categorias, nem porcentagens. A única coisa medida é se a resposta foi certa.",
      },
      {
        title: "Um mesmo critério para todo mundo",
        desc: "Quem quiser chegar até você responde ao mesmo conjunto que você escreveu. Acertar tudo é a prova inteira.",
      },
      {
        title: "O sinal é a atenção",
        desc: "Um erro encerra a tentativa, então um match diz algo simples e verificável: essa pessoa prestou atenção no que você contou sobre si.",
      },
    ],
    steps: [
      {
        title: "Escreva perguntas que digam algo",
        desc: "De 2 a 4 perguntas de múltipla escolha sobre quem você é, quatro alternativas cada e a correta marcada.",
      },
      {
        title: "Responda ao conjunto de outra pessoa",
        desc: "Leia o que ela escolheu perguntar. As próprias perguntas já contam bastante sobre quem as escreveu.",
      },
      {
        title: "Combine com um conjunto perfeito",
        desc: "Todas as respostas certas e a conversa abre. Não há nota para esperar: são as respostas e nada mais.",
      },
    ],
  },
  it: {
    heroTitle: "App di match per personalità: con le tue domande",
    heroSub:
      "Qulo non ti sottopone a un test di personalità e non le assegna punteggi. Scrivi tu le domande che parlano di te e fai match con chi le indovina tutte.",
    problemTitle: "Il problema del match basato sull'aspetto",
    problemParagraphs: [
      "In un'app costruita sullo swipe, la prima decisione che qualcuno prende su di te nasce da una fotografia. Tutto ciò che vorresti davvero far sapere a uno sconosciuto — a cosa tieni, cosa ti fa ridere, come passi un sabato libero — non vi entra affatto, perché nulla di tutto questo si vede nell'immagine.",
      "Il rimedio abituale è un questionario di compatibilità: rispondi a un elenco prestabilito, ricevi un punteggio, ti vengono mostrate persone con punteggi simili. Così la definizione di chi sei passa a chi ha scritto il questionario, e ne esce un numero che fuori dall'app nessuno può verificare.",
      "Qulo prende una terza strada, e vale la pena dirlo chiaramente: Qulo non misura la personalità e non calcola alcun punteggio di compatibilità. Quello che fa è lasciare che le domande le scriva tu — da 2 a 4, fino a 10 con un piano a pagamento, quattro opzioni ciascuna, con quella vera segnata — e il match avviene solo se qualcuno le indovina tutte.",
    ],
    solutionTitle: "A decidere cosa conta sei tu, non un test",
    solutionBullets: [
      {
        title: "Le tue domande, il tuo argomento",
        desc: "Scegli tu cosa deve sapere uno sconosciuto: a cosa dai valore, come impieghi il tempo, una storia che racconteresti solo tu. Da 2 a 4 domande — fino a 10 con un piano a pagamento —, quattro opzioni ciascuna.",
      },
      {
        title: "Nessun punteggio, nessun tipo di personalità",
        desc: "Qulo non assegna tratti, categorie o percentuali. L'unica cosa misurata è se la risposta è esatta.",
      },
      {
        title: "Un solo metro per tutti",
        desc: "Chi vuole arrivare a te risponde alla stessa serie che hai scritto. Indovinarla tutta è l'intera prova.",
      },
      {
        title: "Il segnale è l'attenzione",
        desc: "Un errore chiude il tentativo, quindi un match ti dice una cosa semplice e verificabile: questa persona ha fatto attenzione a ciò che hai raccontato di te.",
      },
    ],
    steps: [
      {
        title: "Scrivi domande che dicano qualcosa",
        desc: "Da 2 a 4 domande a risposta multipla su chi sei, quattro opzioni ciascuna, con quella corretta segnata.",
      },
      {
        title: "Rispondi alla serie di un altro",
        desc: "Leggi cosa ha scelto di chiedere. Le domande stesse dicono già parecchio di chi le ha scritte.",
      },
      {
        title: "Match con una serie perfetta",
        desc: "Tutte le risposte giuste e la chat si apre. Non c'è nessun voto da attendere: contano solo le risposte.",
      },
    ],
  },
  ja: {
    heroTitle: "性格マッチングアプリ：自分でつくった質問でマッチする",
    heroSub:
      "Quloは性格を検査しませんし、点数もつけません。自分を語る質問を自分で書き、それに全問正解した人とマッチします。",
    problemTitle: "見た目で組み合わせることの難点",
    problemParagraphs: [
      "スワイプ式のアプリでは、あなたについての最初の判断は一枚の写真から下されます。見知らぬ相手に本当に知っておいてほしいこと——何を大切にしているか、何を面白いと思うか、予定のない土曜をどう過ごすか——は、その判断にまったく関与しません。どれも写真には写らないからです。",
      "よくある処方箋は相性診断です。決められた設問に答えると点数が出て、近い点数の人が表示される。しかしそれは、あなたが何者かという定義を設問を書いた誰かに預けることであり、アプリの外の誰にも検証できない数字を生むだけです。",
      "Quloは三つ目の道を取ります。はっきり書いておきます。Quloは性格を測定せず、相性スコアの類も一切算出しません。するのは、質問をあなた自身に書いてもらうことだけです。2〜4問（有料プランなら最大10問）、選択肢は各4つ、正解に印をつける。そして、そのすべてに正解した人が現れたときにだけマッチが成立します。",
    ],
    solutionTitle: "何が大事かを決めるのは、テストではなくあなた",
    solutionBullets: [
      {
        title: "質問もテーマも自分のもの",
        desc: "見知らぬ相手に何を知っていてほしいかを選ぶのはあなたです。大切にしていること、時間の使い方、あなたにしか語れない出来事。質問は2〜4問（有料プランなら最大10問）、選択肢は各4つ。",
      },
      {
        title: "点数も性格タイプもなし",
        desc: "Quloは特性も分類もパーセンテージも与えません。測るのは、正解したかどうかだけです。",
      },
      {
        title: "全員に同じ基準",
        desc: "あなたに届きたい人は、あなたの書いた同じ一組に答えます。すべて正解すること、それが試験のすべてです。",
      },
      {
        title: "しるしになるのは注意深さ",
        desc: "一問でも間違えればそこで終わりなので、マッチが示すのは単純で確かめられることだけです——この人はあなたが自分について書いたことをきちんと見た、ということ。",
      },
    ],
    steps: [
      {
        title: "何かを語る質問を書く",
        desc: "自分が何者かについての選択式の質問を2〜4問。選択肢は各4つ、正解に印をつけます。",
      },
      {
        title: "相手の一組に答える",
        desc: "その人が何を尋ねることにしたのかを読みます。質問そのものが、書いた人についてすでに多くを語っています。",
      },
      {
        title: "全問正解でマッチ",
        desc: "すべての答えが正しければチャットが開きます。待つべき評価はありません。答えがすべてです。",
      },
    ],
  },
  ko: {
    heroTitle: "성향 매칭 앱: 내가 낸 질문으로 매칭됩니다",
    heroSub:
      "Qulo는 성격을 검사하지도, 점수를 매기지도 않습니다. 나를 보여 주는 질문을 직접 쓰고, 그것을 모두 맞힌 사람과 매칭됩니다.",
    problemTitle: "겉모습으로 짝을 짓는 방식의 문제",
    problemParagraphs: [
      "스와이프 기반 앱에서 나에 대한 첫 판단은 사진 한 장에서 나옵니다. 정작 낯선 사람이 알아 주었으면 하는 것들 — 무엇을 중요하게 여기는지, 무엇을 재미있어하는지, 비어 있는 토요일을 어떻게 보내는지 — 은 그 판단에 전혀 들어가지 않습니다. 사진에는 그중 어느 것도 보이지 않으니까요.",
      "흔한 처방은 궁합 설문입니다. 정해진 문항에 답하면 점수가 나오고, 비슷한 점수의 사람이 보입니다. 그러나 그것은 내가 누구인지에 대한 정의를 설문을 쓴 사람에게 넘기는 일이고, 앱 밖에서는 누구도 확인할 수 없는 숫자를 만들어 낼 뿐입니다.",
      "Qulo는 세 번째 길을 택합니다. 분명히 적어 둡니다. Qulo는 성격을 측정하지 않고, 어떤 궁합 점수도 계산하지 않습니다. 하는 일은 질문을 직접 쓰게 하는 것뿐입니다. 2~4개(유료 플랜은 최대 10개), 보기는 각각 네 개, 맞는 것을 정답으로 표시합니다. 그리고 그 전부를 맞힌 사람이 나타났을 때만 매칭이 성립합니다.",
    ],
    solutionTitle: "무엇이 중요한지는 검사가 아니라 내가 정합니다",
    solutionBullets: [
      {
        title: "내 질문, 내 주제",
        desc: "낯선 사람이 무엇을 알아야 하는지 내가 고릅니다. 무엇을 소중히 여기는지, 시간을 어떻게 쓰는지, 나만 할 수 있는 이야기. 질문은 2~4개(유료 플랜은 최대 10개), 보기는 각각 네 개.",
      },
      {
        title: "점수도, 성격 유형도 없음",
        desc: "Qulo는 특성도, 범주도, 백분율도 부여하지 않습니다. 재는 것은 정답을 맞혔는지 여부뿐입니다.",
      },
      {
        title: "모두에게 같은 기준",
        desc: "나에게 닿고 싶은 사람은 내가 쓴 같은 세트를 풉니다. 전부 맞히는 것이 시험의 전부입니다.",
      },
      {
        title: "신호는 주의 깊음입니다",
        desc: "하나만 틀려도 시도는 끝나므로, 매칭이 말해 주는 것은 단순하고 확인 가능한 사실 하나입니다. 이 사람은 내가 나에 대해 쓴 것을 눈여겨봤다는 것.",
      },
    ],
    steps: [
      {
        title: "무언가를 말해 주는 질문을 쓴다",
        desc: "내가 어떤 사람인지에 대한 객관식 질문 2~4개, 보기 각각 네 개, 정답 표시.",
      },
      {
        title: "상대의 세트를 푼다",
        desc: "그 사람이 무엇을 묻기로 했는지 읽습니다. 질문 자체가 이미 쓴 사람에 대해 많은 것을 말해 줍니다.",
      },
      {
        title: "빈틈없는 세트로 매칭",
        desc: "모든 답이 맞으면 대화가 열립니다. 기다릴 점수 같은 건 없습니다. 답이 전부입니다.",
      },
    ],
  },
  zh: {
    heroTitle: "性格匹配应用：用你自己出的题配对",
    heroSub:
      "Qulo 不测试你的性格，也不给它打分。你写下能说明你是谁的问题，与全部答对的人配对。",
    problemTitle: "凭外表配对的麻烦",
    problemParagraphs: [
      "在以滑动为主的应用里，别人对你的第一个判断来自一张照片。而你真正希望陌生人知道的东西——你在意什么，你觉得什么好笑，一个空闲的周六你怎么过——完全不参与这个判断，因为它们在照片里都看不见。",
      "常见的补救办法是一份契合度问卷：回答一串固定题目，得到一个分数，再看到分数相近的人。可这等于把「你是谁」的定义交给了出题的人，并且产出一个应用之外谁也无法核对的数字。",
      "Qulo 走的是第三条路，这一点值得写清楚：Qulo 不测量性格，也不计算任何契合度分数。它做的只是让你自己写题——2 到 4 道（付费方案最多 10 道），每道四个选项，标出真实答案——而只有当有人把它们全部答对时，配对才会成立。",
    ],
    solutionTitle: "由你决定什么算数，而不是一份测试",
    solutionBullets: [
      {
        title: "你的题目，你的题材",
        desc: "由你来选陌生人该知道什么：你看重什么，时间花在哪里，一个只有你会讲的故事。2 到 4 道题，付费方案最多 10 道，每道四个选项。",
      },
      {
        title: "没有分数，也没有性格类型",
        desc: "Qulo 不给你贴特质、分类别或算百分比。被衡量的只有一件事：答得对不对。",
      },
      {
        title: "对所有人同一把尺",
        desc: "想走到你面前的人，答的是同一组你写下的题。全部答对，就是这场考试的全部。",
      },
      {
        title: "信号是用心",
        desc: "错一道就结束，所以一次配对告诉你的是一件简单且可核对的事：这个人认真看了你写下的自己。",
      },
    ],
    steps: [
      {
        title: "写下能说明什么的题",
        desc: "关于你是谁的选择题 2 到 4 道，每道四个选项，并标出正确答案。",
      },
      {
        title: "去答别人的那一组",
        desc: "读一读他选择问什么。题目本身，就已经透露了不少关于出题人的事。",
      },
      {
        title: "一组全对即配对",
        desc: "所有答案都对，对话就打开了。没有什么评分要等——答案就是全部。",
      },
    ],
  },
  nl: {
    heroTitle: "Persoonlijkheids-matchingapp: match via je eigen vragen",
    heroSub:
      "Qulo test je persoonlijkheid niet en geeft er geen cijfer aan. Jij schrijft de vragen die iets over je zeggen en matcht met wie ze allemaal goed heeft.",
    problemTitle: "Het bezwaar tegen matchen op uiterlijk",
    problemParagraphs: [
      "In een app die op swipen draait komt de eerste beslissing over jou uit een foto. Alles wat je een vreemde eigenlijk zou willen laten weten — waar je om geeft, waar je om moet lachen, hoe je een vrije zaterdag doorbrengt — speelt daarin geen enkele rol, want niets daarvan is op het plaatje te zien.",
      "Het gebruikelijke tegengif is een compatibiliteitsvragenlijst: je vult een vaste reeks in, krijgt een score en ziet mensen met een vergelijkbare score. Daarmee geef je de definitie van wie je bent uit handen aan degene die de lijst schreef, en levert het een getal op dat buiten de app niemand kan controleren.",
      "Qulo kiest een derde weg, en dat mag onomwonden gezegd worden: Qulo meet geen persoonlijkheid en berekent geen enkele compatibiliteitsscore. Wat het doet is jou de vragen laten schrijven — 2 tot 4 stuks, tot 10 met een betaald abonnement, vier opties per vraag, met het ware antwoord gemarkeerd — en een match ontstaat alleen als iemand ze allemaal goed heeft.",
    ],
    solutionTitle: "Jij bepaalt wat telt, geen test",
    solutionBullets: [
      {
        title: "Jouw vragen, jouw onderwerp",
        desc: "Jij kiest wat een vreemde moet weten: waar je waarde aan hecht, waar je je tijd aan besteedt, een verhaal dat alleen jij zou vertellen. 2 tot 4 vragen — tot 10 met een betaald abonnement —, vier opties per stuk.",
      },
      {
        title: "Geen score, geen persoonlijkheidstype",
        desc: "Qulo kent geen eigenschappen toe, geen categorieën en geen percentages. Het enige dat gemeten wordt is of iemand goed antwoordde.",
      },
      {
        title: "Eén maatstaf voor iedereen",
        desc: "Wie jou wil bereiken beantwoordt dezelfde set die jij schreef. Alles goed hebben is de hele toets.",
      },
      {
        title: "Aandacht is het signaal",
        desc: "Eén fout antwoord beëindigt de poging, dus een match vertelt je iets eenvoudigs en controleerbaars: deze persoon heeft gelet op wat je over jezelf schreef.",
      },
    ],
    steps: [
      {
        title: "Schrijf vragen die iets zeggen",
        desc: "2 tot 4 meerkeuzevragen over wie je bent, vier opties per vraag, met het juiste antwoord gemarkeerd.",
      },
      {
        title: "Beantwoord de set van iemand anders",
        desc: "Lees wat diegene besloot te vragen. De vragen zelf zeggen al aardig wat over degene die ze schreef.",
      },
      {
        title: "Match op een foutloze set",
        desc: "Elk antwoord goed, en de chat gaat open. Er is geen cijfer om op te wachten — het gaat alleen om de antwoorden.",
      },
    ],
  },
  pl: {
    heroTitle: "Dopasowanie po osobowości: twoje własne pytania",
    heroSub:
      "Qulo nie bada twojej osobowości ani jej nie ocenia. Sam piszesz pytania, które coś o tobie mówią, i łączysz się z tym, kto trafi wszystkie.",
    problemTitle: "Na czym polega kłopot z dobieraniem po wyglądzie",
    problemParagraphs: [
      "W aplikacji opartej na przesuwaniu pierwsza decyzja o tobie zapada na podstawie zdjęcia. Wszystko, o czym naprawdę chciałbyś, żeby obca osoba wiedziała — na czym ci zależy, co cię śmieszy, jak spędzasz wolną sobotę — nie bierze w tej decyzji żadnego udziału, bo nic z tego na zdjęciu nie widać.",
      "Zwykłym lekarstwem jest kwestionariusz zgodności: wypełniasz gotową listę, dostajesz wynik i widzisz ludzi o podobnych wynikach. To oddaje definicję tego, kim jesteś, autorowi kwestionariusza i produkuje liczbę, której poza aplikacją nikt nie może sprawdzić.",
      "Qulo idzie trzecią drogą i warto powiedzieć to wprost: Qulo nie mierzy osobowości i nie wylicza żadnego wskaźnika zgodności. Robi tyle, że pozwala ci samemu napisać pytania — od 2 do 4, do 10 w planie płatnym, po cztery odpowiedzi w każdym, z zaznaczoną prawdziwą — a dopasowanie następuje tylko wtedy, gdy ktoś trafi je wszystkie.",
    ],
    solutionTitle: "O tym, co się liczy, decydujesz ty, a nie test",
    solutionBullets: [
      {
        title: "Twoje pytania, twój temat",
        desc: "Sam wybierasz, co obca osoba ma wiedzieć: co cenisz, na co idzie twój czas, historia, którą opowiedziałbyś tylko ty. Od 2 do 4 pytań — do 10 w planie płatnym — po cztery odpowiedzi.",
      },
      {
        title: "Bez wyniku i bez typu osobowości",
        desc: "Qulo nie przypisuje cech, kategorii ani procentów. Mierzy się tylko jedno: czy odpowiedź była poprawna.",
      },
      {
        title: "Jedna miara dla wszystkich",
        desc: "Każdy, kto chce do ciebie dotrzeć, odpowiada na ten sam zestaw, który napisałeś. Trafienie całości to cały egzamin.",
      },
      {
        title: "Sygnałem jest uwaga",
        desc: "Jedna pomyłka kończy próbę, więc dopasowanie mówi ci rzecz prostą i sprawdzalną: ta osoba zwróciła uwagę na to, co napisałeś o sobie.",
      },
    ],
    steps: [
      {
        title: "Napisz pytania, które coś mówią",
        desc: "Od 2 do 4 pytań wielokrotnego wyboru o tym, kim jesteś, po cztery odpowiedzi, z zaznaczoną poprawną.",
      },
      {
        title: "Odpowiedz na czyjś zestaw",
        desc: "Przeczytaj, o co ta osoba postanowiła zapytać. Same pytania mówią już sporo o tym, kto je napisał.",
      },
      {
        title: "Dopasowanie przy bezbłędnym zestawie",
        desc: "Każda odpowiedź poprawna i czat się otwiera. Nie ma oceny, na którą trzeba czekać — liczą się wyłącznie odpowiedzi.",
      },
    ],
  },
  sv: {
    heroTitle: "Matchningsapp för personlighet: dina egna frågor",
    heroSub:
      "Qulo testar inte din personlighet och sätter inget betyg på den. Du skriver frågorna som säger något om dig och matchar med den som har alla rätt.",
    problemTitle: "Problemet med att matcha på utseende",
    problemParagraphs: [
      "I en app som bygger på svep fattas det första beslutet om dig utifrån ett foto. Allt du egentligen skulle vilja att en främling visste — vad du bryr dig om, vad du tycker är roligt, hur du tillbringar en ledig lördag — spelar ingen roll där, eftersom inget av det syns på bilden.",
      "Den vanliga motmedicinen är ett kompatibilitetsformulär: du svarar på en fast lista, får en poäng och visas personer med liknande poäng. Därmed lämnar du över definitionen av vem du är till den som skrev formuläret, och resultatet blir en siffra som ingen utanför appen kan kontrollera.",
      "Qulo tar en tredje väg, och det tål att sägas rakt ut: Qulo mäter ingen personlighet och räknar inte fram någon kompatibilitetspoäng. Det appen gör är att låta dig skriva frågorna själv — 2 till 4 stycken, upp till 10 med ett betalt abonnemang, fyra alternativ var, med det sanna markerat — och en matchning uppstår bara när någon har varenda en rätt.",
    ],
    solutionTitle: "Du avgör vad som räknas, inte ett test",
    solutionBullets: [
      {
        title: "Dina frågor, ditt ämne",
        desc: "Du väljer vad en främling ska veta: vad du värderar, vad din tid går till, en historia bara du skulle berätta. 2 till 4 frågor — upp till 10 med ett betalt abonnemang — fyra alternativ var.",
      },
      {
        title: "Ingen poäng, ingen personlighetstyp",
        desc: "Qulo tilldelar inga egenskaper, inga kategorier och inga procenttal. Det enda som mäts är om någon svarade rätt.",
      },
      {
        title: "Samma måttstock för alla",
        desc: "Den som vill nå dig svarar på samma omgång som du skrivit. Att ha allt rätt är hela provet.",
      },
      {
        title: "Signalen är uppmärksamhet",
        desc: "Ett fel svar avslutar försöket, så en matchning säger dig något enkelt och kontrollerbart: den här personen läste vad du skrev om dig själv.",
      },
    ],
    steps: [
      {
        title: "Skriv frågor som säger något",
        desc: "2 till 4 flervalsfrågor om vem du är, fyra alternativ var, med det rätta svaret markerat.",
      },
      {
        title: "Svara på någon annans omgång",
        desc: "Läs vad hen valde att fråga om. Frågorna i sig säger redan en hel del om den som skrev dem.",
      },
      {
        title: "Matcha på en felfri omgång",
        desc: "Varje svar rätt, och chatten öppnas. Det finns inget betyg att vänta på — det handlar bara om svaren.",
      },
    ],
  },
  hi: {
    heroTitle: "पर्सनैलिटी मैचिंग ऐप: अपने ही सवालों से मैच",
    heroSub:
      "Qulo आपके व्यक्तित्व की जाँच नहीं करता और न उसे कोई अंक देता है। आप अपने बारे में सवाल लिखते हैं और जो सब सही करे, उससे मैच होता है।",
    problemTitle: "शक्ल देखकर जोड़ी बनाने की दिक़्क़त",
    problemParagraphs: [
      "स्वाइप पर चलने वाले ऐप में आपके बारे में पहला फ़ैसला एक तस्वीर से होता है। जो कुछ आप सचमुच चाहेंगे कि कोई अजनबी आपके बारे में जाने — आपको किसकी परवाह है, आपको क्या हास्यास्पद लगता है, ख़ाली शनिवार आप कैसे बिताते हैं — उस फ़ैसले में उसका कोई हिस्सा नहीं होता, क्योंकि इनमें से कुछ भी तस्वीर में नहीं दिखता।",
      "आम इलाज एक अनुकूलता प्रश्नावली है: तय सवालों के जवाब दीजिए, एक स्कोर पाइए, मिलते-जुलते स्कोर वाले लोग देखिए। पर इससे आप कौन हैं, इसकी परिभाषा उस व्यक्ति के हाथ चली जाती है जिसने प्रश्नावली लिखी — और नतीजा एक ऐसा आँकड़ा होता है जिसे ऐप के बाहर कोई जाँच नहीं सकता।",
      "Qulo तीसरा रास्ता लेता है, और इसे साफ़ कह देना बेहतर है: Qulo व्यक्तित्व नहीं मापता और कोई अनुकूलता स्कोर नहीं निकालता। वह इतना ही करता है कि सवाल आपसे लिखवाता है — 2 से 4 सवाल, भुगतान वाली योजना में 10 तक, हर एक में चार विकल्प, सही जवाब चिह्नित — और मैच सिर्फ़ तब होता है जब कोई उन सबका सही जवाब दे।",
    ],
    solutionTitle: "क्या मायने रखता है, यह कोई टेस्ट नहीं, आप तय करते हैं",
    solutionBullets: [
      {
        title: "सवाल आपके, विषय आपका",
        desc: "अजनबी को क्या जानना चाहिए, यह आप चुनते हैं: आप किसे अहमियत देते हैं, समय कहाँ लगाते हैं, वह क़िस्सा जो सिर्फ़ आप सुनाएँगे। 2 से 4 सवाल — भुगतान वाली योजना में 10 तक — हर एक में चार विकल्प।",
      },
      {
        title: "न स्कोर, न व्यक्तित्व का कोई प्रकार",
        desc: "Qulo न कोई गुण चिपकाता है, न श्रेणी देता है, न प्रतिशत निकालता है। मापी जाने वाली एकमात्र चीज़ यह है कि जवाब सही था या नहीं।",
      },
      {
        title: "सबके लिए एक ही कसौटी",
        desc: "जो भी आप तक पहुँचना चाहता है, वही सेट हल करता है जो आपने लिखा। सबका सही होना ही पूरी परीक्षा है।",
      },
      {
        title: "संकेत है — ध्यान",
        desc: "एक ग़लत जवाब कोशिश ख़त्म कर देता है, इसलिए मैच आपको एक सीधी और जाँची जा सकने वाली बात बताता है: इस व्यक्ति ने आपके लिखे पर ध्यान दिया।",
      },
    ],
    steps: [
      {
        title: "ऐसे सवाल लिखिए जो कुछ कहें",
        desc: "आप कौन हैं, इस पर 2 से 4 बहुविकल्पीय सवाल; हर एक में चार विकल्प और चिह्नित सही जवाब।",
      },
      {
        title: "किसी और का सेट हल कीजिए",
        desc: "पढ़िए कि उसने क्या पूछना चुना। सवाल ख़ुद ही अपने लिखने वाले के बारे में काफ़ी कुछ बता देते हैं।",
      },
      {
        title: "बिना ग़लती वाले सेट पर मैच",
        desc: "हर जवाब सही, और चैट खुल जाती है। किसी रेटिंग का इंतज़ार नहीं — बात सिर्फ़ जवाबों की है।",
      },
    ],
  },
};
