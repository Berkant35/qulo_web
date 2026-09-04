import type { LandingContent } from "@/lib/constants/landings";

/**
 * Body copy for /[locale]/features/dating-without-swiping, in all 16 locales.
 *
 * Written 2026-09-04 to replace an `isTr ? ... : ...` ternary block that served
 * English to fourteen locales while hreflang promised a translated page.
 *
 * Removed from the previous copy and not to be reinstated:
 *  - "Swipe fatigue has become a phenomenon experienced by over 70% of users"
 *    — no publisher, no sample, no definition of "users".
 *  - "match quality increases 3x" — a made-up multiplier for a quantity the app
 *    does not measure at all.
 *  - "completely eliminates swipe fatigue" — an outcome claim about how people
 *    feel, which nothing here can support.
 *
 * The one figure that survives is the only sourced one available: the Forbes
 * Health / OnePoll 2024 burnout survey (FORBES_ONEPOLL_2024 in
 * src/lib/constants/stats.ts), used in full — publisher, year, sample and
 * figure in the same sentence, in every locale. If a translation cannot carry
 * the whole attribution, drop the figure rather than the attribution.
 *
 * Corrected 2026-09-04: every locale said a member writes "2 to 10" questions.
 * Ten is the Premium ceiling, not the general one. The floor is
 * MIN_REQUIRED_QUESTIONS = 2 and the ceiling is read per plan from the active
 * economy_config_versions row — free 4, Plus 6, Premium 10 — enforced in
 * qulo-server/src/services/question.service.ts. This page addresses a free
 * reader, so it now says two to four. A range ending at ten is never written
 * without naming the paid plan in the same sentence; where the count was
 * incidental the tighter "two to four" is used on its own.
 */
export const datingWithoutSwiping: Record<string, LandingContent> = {
  en: {
    heroTitle: "Dating Without Swiping: Another Way to Meet",
    heroSub:
      "There is no deck to flick through. You answer the questions someone wrote about themselves, and a perfect score is the match.",
    problemTitle: "Swipe Fatigue Is a Real Complaint",
    problemParagraphs: [
      "In a 2024 Forbes Health / OnePoll survey of 1,000 US adults who had used a dating app in the past year, 78% reported feeling burned out by dating apps. The complaint is rarely that the apps do nothing at all — it is that using them starts to feel like unpaid shift work.",
      "A swipe deck is built to produce exactly that feeling. It is an endless queue of tiny decisions, each made on almost no information, and nothing you learn in one of them helps you with the next. The effort never accumulates. You can put an hour in and come away with nothing you did not have at the start, except a slightly longer list of names.",
      "Dating without swiping means the first thing you do about a person is not a verdict. On Qulo it is a set of questions they wrote about themselves — between two and four of them, up to ten on a paid plan, four options each — and the only way past that set is to answer all of it correctly.",
    ],
    solutionTitle: "A Dating App With No Swipe Deck",
    solutionBullets: [
      {
        title: "Nothing to swipe",
        desc: "There is no left and no right. You open a profile and you answer what that person asked.",
      },
      {
        title: "Written by them, not picked from a list",
        desc: "Every member writes their own two to four multiple-choice questions — up to ten on a paid plan — and marks the true answer, so what you are asked is what they thought was worth knowing about them.",
      },
      {
        title: "A perfect score or nothing",
        desc: "You match by getting every question right. There is no half-match and no waiting to find out whether they swiped back.",
      },
      {
        title: "Slower on purpose",
        desc: "A set of questions takes minutes rather than a moment. Fewer decisions in an evening, and each one worth more.",
      },
    ],
    steps: [
      {
        title: "Write your own set",
        desc: "Two to four multiple-choice questions about yourself, four options each, with the correct one marked.",
      },
      {
        title: "Read instead of swiping",
        desc: "Open someone's profile and answer what they actually asked. There is no deck to get through first.",
      },
      {
        title: "All correct, and you are matched",
        desc: "A full set of right answers opens the conversation. Nothing else does.",
      },
    ],
  },
  tr: {
    heroTitle: "Swipe Olmadan Tanışma: Başka Bir Yol",
    heroSub:
      "Kaydırılacak bir deste yok. Karşındakinin kendisi hakkında yazdığı soruları cevaplarsın; hepsi doğruysa eşleşirsin.",
    problemTitle: "Kaydırma Yorgunluğu Gerçek Bir Şikâyet",
    problemParagraphs: [
      "Forbes Health / OnePoll'un 2024'te, son bir yıl içinde bir dating uygulaması kullanmış 1.000 ABD'li yetişkinle yaptığı ankette katılımcıların %78'i dating uygulamalarından tükenmiş hissettiğini söyledi. Şikâyet genellikle uygulamaların hiç işe yaramadığı değil; kullanmanın bir süre sonra ücretsiz vardiyaya benzemesi.",
      "Kaydırma destesi tam da bu hissi üretmek üzere kurulmuştur. Neredeyse hiçbir bilgiye dayanmayan, ucu açık bir küçük kararlar kuyruğudur; birinde öğrendiğin şey diğerinde işine yaramaz. Emek hiçbir yerde birikmez. Bir saatini verip başladığın yerden farksız kalkarsın — elinde sadece biraz daha uzun bir isim listesi vardır.",
      "Swipe olmadan tanışmak, bir insan hakkında yaptığın ilk şeyin bir hüküm olmaması demek. Qulo'da bu ilk şey, o kişinin kendisi hakkında yazdığı bir soru setidir — 2 ila 4 soru, ücretli planda 10'a kadar, her birinde dört şık — ve o seti geçmenin tek yolu hepsini doğru cevaplamaktır.",
    ],
    solutionTitle: "Kaydırma Destesi Olmayan Bir Dating Uygulaması",
    solutionBullets: [
      {
        title: "Kaydırılacak bir şey yok",
        desc: "Sağ da yok, sol da. Bir profili açarsın ve o kişinin sorduğunu cevaplarsın.",
      },
      {
        title: "Hazır listeden seçilmiş değil, kendi yazdığı",
        desc: "Herkes kendi 2-4 çoktan seçmeli sorusunu — ücretli planda 10'a kadar — yazar ve doğru cevabı işaretler; yani sana sorulan şey, onun kendisi hakkında bilinmeye değer bulduğu şeydir.",
      },
      {
        title: "Ya tamamı doğru ya hiç",
        desc: "Bütün soruları doğru bilerek eşleşirsin. Yarım eşleşme yoktur, karşı tarafın da kaydırıp kaydırmadığını bekleme yoktur.",
      },
      {
        title: "Bilerek daha yavaş",
        desc: "Bir soru seti bir an değil dakikalar alır. Bir akşamda daha az karar verirsin ama her biri daha çok şey ifade eder.",
      },
    ],
    steps: [
      {
        title: "Kendi setini yaz",
        desc: "Kendin hakkında 2 ila 4 çoktan seçmeli soru; her birinde dört şık ve işaretlenmiş bir doğru cevap.",
      },
      {
        title: "Kaydırmak yerine oku",
        desc: "Birinin profilini aç ve gerçekten ne sorduğuna cevap ver. Önce aşman gereken bir deste yok.",
      },
      {
        title: "Hepsi doğruysa eşleştiniz",
        desc: "Eksiksiz doğru bir set sohbeti açar. Başka hiçbir şey açmaz.",
      },
    ],
  },
  de: {
    heroTitle: "Dating ohne Swipen: eine andere Art, sich zu begegnen",
    heroSub:
      "Es gibt keinen Stapel zum Durchwischen. Du beantwortest die Fragen, die jemand über sich geschrieben hat — alle richtig, und ihr matcht.",
    problemTitle: "Swipe-Müdigkeit ist eine reale Klage",
    problemParagraphs: [
      "In einer Umfrage von Forbes Health / OnePoll aus dem Jahr 2024 unter 1.000 Erwachsenen in den USA, die im Jahr zuvor eine Dating-App genutzt hatten, gaben 78 % an, sich von Dating-Apps ausgebrannt zu fühlen. Die Klage lautet selten, die Apps würden gar nichts bringen — sondern dass ihre Nutzung sich nach unbezahlter Schichtarbeit anfühlt.",
      "Ein Swipe-Stapel ist gebaut, um genau dieses Gefühl zu erzeugen. Er ist eine endlose Schlange winziger Entscheidungen, jede auf fast keiner Grundlage getroffen, und nichts, was du bei einer lernst, hilft dir bei der nächsten. Der Aufwand summiert sich nie. Du kannst eine Stunde investieren und mit nichts herausgehen, das du vorher nicht hattest — außer einer etwas längeren Namensliste.",
      "Dating ohne Swipen heißt, dass das Erste, was du über einen Menschen tust, kein Urteil ist. Bei Qulo ist es ein Fragenset, das diese Person über sich geschrieben hat — 2 bis 4 Fragen, im kostenpflichtigen Tarif bis zu 10, mit je vier Möglichkeiten — und der einzige Weg daran vorbei führt über lauter richtige Antworten.",
    ],
    solutionTitle: "Eine Dating-App ohne Swipe-Stapel",
    solutionBullets: [
      {
        title: "Nichts zum Wischen",
        desc: "Es gibt kein Links und kein Rechts. Du öffnest ein Profil und beantwortest, was diese Person gefragt hat.",
      },
      {
        title: "Selbst geschrieben, nicht aus einer Liste gewählt",
        desc: "Jedes Mitglied schreibt seine eigenen 2 bis 4 Multiple-Choice-Fragen — im kostenpflichtigen Tarif bis zu 10 — und markiert die richtige Antwort. Gefragt wird also das, was die Person selbst für wissenswert hielt.",
      },
      {
        title: "Alles richtig oder gar nichts",
        desc: "Du matchst, indem du jede Frage richtig hast. Es gibt kein halbes Match und kein Warten darauf, ob zurückgewischt wurde.",
      },
      {
        title: "Absichtlich langsamer",
        desc: "Ein Fragenset dauert Minuten statt eines Moments. Weniger Entscheidungen an einem Abend, und jede davon mehr wert.",
      },
    ],
    steps: [
      {
        title: "Schreib dein eigenes Set",
        desc: "2 bis 4 Multiple-Choice-Fragen über dich, je vier Möglichkeiten, die richtige markiert.",
      },
      {
        title: "Lies, statt zu wischen",
        desc: "Öffne ein Profil und beantworte, was die Person tatsächlich gefragt hat. Es gibt keinen Stapel, den du vorher durchgehen müsstest.",
      },
      {
        title: "Alles richtig, und ihr habt ein Match",
        desc: "Ein vollständig richtiges Set öffnet das Gespräch. Sonst nichts.",
      },
    ],
  },
  fr: {
    heroTitle: "Rencontres sans swipe : une autre façon de se rencontrer",
    heroSub:
      "Il n'y a pas de pile à faire défiler. Vous répondez aux questions qu'une personne a écrites sur elle-même : sans faute, c'est un match.",
    problemTitle: "La fatigue du swipe est une plainte réelle",
    problemParagraphs: [
      "Dans une enquête Forbes Health / OnePoll de 2024 menée auprès de 1 000 adultes américains ayant utilisé une application de rencontre dans l'année écoulée, 78 % déclaraient se sentir épuisés par ces applications. Le reproche n'est presque jamais qu'elles ne servent à rien : c'est que les utiliser finit par ressembler à un travail posté non payé.",
      "Une pile de profils à swiper est faite pour produire exactement cette sensation. C'est une file interminable de décisions minuscules, prises sur presque rien, et ce que vous apprenez de l'une ne vous sert jamais pour la suivante. L'effort ne s'accumule pas. Vous pouvez y passer une heure et en ressortir sans rien que vous n'aviez déjà, sinon une liste de prénoms un peu plus longue.",
      "Les rencontres sans swipe, cela veut dire que la première chose que vous faites d'une personne n'est pas un verdict. Sur Qulo, c'est une série de questions qu'elle a écrites sur elle-même — de 2 à 4, jusqu'à 10 avec un abonnement payant, quatre options chacune — et le seul moyen de la franchir est d'y répondre entièrement juste.",
    ],
    solutionTitle: "Une app de rencontre sans pile à swiper",
    solutionBullets: [
      {
        title: "Rien à balayer",
        desc: "Il n'y a ni gauche ni droite. Vous ouvrez un profil et vous répondez à ce que la personne a demandé.",
      },
      {
        title: "Écrites par elle, pas choisies dans une liste",
        desc: "Chaque membre écrit ses propres 2 à 4 questions à choix multiple — jusqu'à 10 avec un abonnement payant — et coche la bonne réponse : on vous demande donc ce que cette personne jugeait digne d'être su d'elle.",
      },
      {
        title: "Sans faute, ou rien",
        desc: "Vous matchez en trouvant chaque réponse. Il n'y a pas de demi-match, ni d'attente pour savoir si l'autre a swipé aussi.",
      },
      {
        title: "Plus lent, volontairement",
        desc: "Une série de questions prend quelques minutes plutôt qu'un instant. Moins de décisions dans une soirée, et chacune vaut davantage.",
      },
    ],
    steps: [
      {
        title: "Écrivez votre série",
        desc: "De 2 à 4 questions à choix multiple sur vous, quatre options chacune, la bonne réponse cochée.",
      },
      {
        title: "Lisez au lieu de swiper",
        desc: "Ouvrez le profil de quelqu'un et répondez à ce qu'il a réellement demandé. Aucune pile à traverser d'abord.",
      },
      {
        title: "Tout juste, et vous matchez",
        desc: "Une série entièrement correcte ouvre la conversation. Rien d'autre ne l'ouvre.",
      },
    ],
  },
  es: {
    heroTitle: "Citas sin deslizar: otra forma de conocerse",
    heroSub:
      "No hay mazo que recorrer. Respondes las preguntas que alguien escribió sobre sí mismo y, si las aciertas todas, hay match.",
    problemTitle: "El cansancio de deslizar es una queja real",
    problemParagraphs: [
      "En una encuesta de Forbes Health / OnePoll de 2024 a 1.000 adultos estadounidenses que habían usado una app de citas en el último año, el 78 % dijo sentirse agotado por las apps de citas. La queja casi nunca es que no sirvan para nada: es que usarlas acaba pareciéndose a un turno de trabajo no pagado.",
      "Un mazo de perfiles para deslizar está hecho para producir justo esa sensación. Es una cola interminable de decisiones mínimas, tomadas casi sin información, y lo que aprendes en una no te sirve para la siguiente. El esfuerzo nunca se acumula. Puedes dedicarle una hora y salir sin nada que no tuvieras antes, salvo una lista de nombres algo más larga.",
      "Tener citas sin deslizar significa que lo primero que haces con una persona no es un veredicto. En Qulo es una tanda de preguntas que esa persona escribió sobre sí misma —de 2 a 4, hasta 10 con un plan de pago, con cuatro opciones cada una— y la única manera de pasarla es acertarla entera.",
    ],
    solutionTitle: "Una app de citas sin mazo que deslizar",
    solutionBullets: [
      {
        title: "Nada que deslizar",
        desc: "No hay izquierda ni derecha. Abres un perfil y respondes a lo que esa persona preguntó.",
      },
      {
        title: "Escritas por ella, no elegidas de una lista",
        desc: "Cada persona escribe sus propias 2 a 4 preguntas de opción múltiple —hasta 10 con un plan de pago— y marca la respuesta verdadera: lo que te preguntan es lo que consideró que valía la pena saber de ella.",
      },
      {
        title: "Todas bien, o nada",
        desc: "Haces match acertando cada pregunta. No hay medio match ni espera para ver si la otra persona también deslizó.",
      },
      {
        title: "Más lento a propósito",
        desc: "Una tanda de preguntas lleva minutos en lugar de un instante. Menos decisiones por noche, y cada una vale más.",
      },
    ],
    steps: [
      {
        title: "Escribe tu tanda",
        desc: "De 2 a 4 preguntas de opción múltiple sobre ti, cuatro opciones cada una y la correcta marcada.",
      },
      {
        title: "Lee en vez de deslizar",
        desc: "Abre el perfil de alguien y responde a lo que realmente preguntó. No hay ningún mazo que atravesar antes.",
      },
      {
        title: "Todas bien y estáis emparejados",
        desc: "Una tanda entera acertada abre la conversación. Ninguna otra cosa la abre.",
      },
    ],
  },
  ar: {
    heroTitle: "مواعدة بلا تمرير: طريقة أخرى للتعارف",
    heroSub:
      "لا توجد رصّة بطاقات تمرّ عليها. تجيب عن الأسئلة التي كتبها شخص عن نفسه، والإجابة الكاملة الصحّة هي التطابق.",
    problemTitle: "إنهاك التمرير شكوى حقيقية",
    problemParagraphs: [
      "في استطلاع أجرته Forbes Health / OnePoll عام 2024 شمل 1000 بالغ في الولايات المتحدة استخدموا تطبيق مواعدة خلال العام السابق، قال 78% منهم إنهم يشعرون بالإنهاك من تطبيقات المواعدة. والشكوى نادرًا ما تكون أن هذه التطبيقات بلا فائدة، بل أن استعمالها يصبح أشبه بمناوبة عمل بلا أجر.",
      "رصّة التمرير مصمّمة لتوليد هذا الشعور بالضبط. إنها طابور لا ينتهي من قرارات صغيرة تُتخذ من دون معلومات تقريبًا، وما تتعلّمه في أحدها لا يفيدك في الذي يليه. الجهد لا يتراكم أبدًا. قد تمضي فيها ساعة ثم تخرج من دون شيء لم يكن معك أصلًا، سوى قائمة أسماء أطول قليلًا.",
      "المواعدة بلا تمرير تعني أن أول ما تفعله تجاه إنسان ليس حكمًا عليه. في Qulo هو مجموعة أسئلة كتبها عن نفسه — من سؤالين إلى أربعة، وحتى عشرة في الخطة المدفوعة، لكل منها أربعة خيارات — والسبيل الوحيد لتجاوزها هو الإجابة عنها كلها إجابة صحيحة.",
    ],
    solutionTitle: "تطبيق مواعدة بلا رصّة تمرير",
    solutionBullets: [
      {
        title: "لا شيء تمرّره",
        desc: "لا يمين ولا يسار. تفتح ملفًا وتجيب عمّا سأله صاحبه.",
      },
      {
        title: "من كتابته هو، لا مختارة من قائمة جاهزة",
        desc: "كل عضو يكتب أسئلته الخاصة، من سؤالين إلى أربعة وحتى عشرة في الخطة المدفوعة، ويحدّد الإجابة الصحيحة؛ فما يُسأل عنه هو ما رآه هو جديرًا بأن يُعرَف عنه.",
      },
      {
        title: "إجابات كاملة أو لا شيء",
        desc: "تتطابق بالإجابة الصحيحة عن كل سؤال. لا يوجد نصف تطابق، ولا انتظار لمعرفة إن كان الطرف الآخر قد مرّر بدوره.",
      },
      {
        title: "أبطأ عن قصد",
        desc: "مجموعة الأسئلة تستغرق دقائق لا لحظة. قرارات أقل في الأمسية، وكل واحد منها أثمن.",
      },
    ],
    steps: [
      {
        title: "اكتب مجموعتك",
        desc: "من سؤالين إلى أربعة أسئلة اختيار من متعدد عن نفسك، لكل منها أربعة خيارات وإجابة صحيحة محدّدة.",
      },
      {
        title: "اقرأ بدل أن تمرّر",
        desc: "افتح ملف شخص وأجب عمّا سأله فعلًا. لا توجد رصّة عليك اجتيازها أولًا.",
      },
      {
        title: "أجب عنها كلها، فتتطابقان",
        desc: "مجموعة إجابات صحيحة بالكامل تفتح المحادثة. ولا شيء غيرها يفتحها.",
      },
    ],
  },
  ru: {
    heroTitle: "Знакомства без свайпов: другой способ встретиться",
    heroSub:
      "Нет колоды, которую нужно перелистывать. Вы отвечаете на вопросы, которые человек написал о себе, и совпадение дают только верные ответы.",
    problemTitle: "Усталость от свайпов — реальная жалоба",
    problemParagraphs: [
      "В опросе Forbes Health / OnePoll 2024 года, в котором участвовали 1000 взрослых американцев, пользовавшихся дейтинг-приложением в течение предыдущего года, 78% сказали, что чувствуют выгорание от таких приложений. Жалуются редко на то, что приложения совсем не работают, — жалуются на то, что пользование ими начинает напоминать неоплачиваемую смену.",
      "Колода для свайпов устроена так, чтобы создавать именно это ощущение. Это бесконечная очередь крошечных решений, принимаемых почти без информации, и то, что вы поняли в одном, никак не помогает в следующем. Усилие не накапливается. Можно потратить час и выйти без единой новой вещи, кроме чуть более длинного списка имен.",
      "Знакомства без свайпов означают, что первое, что вы делаете по отношению к человеку, — это не приговор. В Qulo это набор вопросов, которые он написал о себе: от 2 до 4 вопросов, до 10 на платном тарифе, по четыре варианта в каждом, и пройти этот набор можно только ответив на все верно.",
    ],
    solutionTitle: "Дейтинг-приложение без колоды для свайпа",
    solutionBullets: [
      {
        title: "Свайпать нечего",
        desc: "Нет ни влево, ни вправо. Вы открываете анкету и отвечаете на то, о чем человек спросил.",
      },
      {
        title: "Написано им, а не выбрано из списка",
        desc: "Каждый пишет свои 2–4 вопроса с вариантами ответа — до 10 на платном тарифе — и отмечает верный, так что спрашивают вас именно о том, что человек счел о себе важным.",
      },
      {
        title: "Все верно — или ничего",
        desc: "Совпадение дает только полностью верный набор ответов. Половинчатых совпадений нет, и ждать ответного свайпа не приходится.",
      },
      {
        title: "Медленнее — намеренно",
        desc: "Набор вопросов занимает минуты, а не мгновение. За вечер решений меньше, но каждое весит больше.",
      },
    ],
    steps: [
      {
        title: "Составьте свой набор",
        desc: "От 2 до 4 вопросов о себе с четырьмя вариантами ответа в каждом и отмеченным верным.",
      },
      {
        title: "Читайте вместо того, чтобы свайпать",
        desc: "Откройте чью-то анкету и ответьте на то, о чем этот человек действительно спросил. Никакой колоды проходить не нужно.",
      },
      {
        title: "Все верно — и вы совпали",
        desc: "Полностью верный набор открывает переписку. Больше ее ничто не открывает.",
      },
    ],
  },
  pt: {
    heroTitle: "Encontros sem deslizar: outra forma de se conhecer",
    heroSub:
      "Não há baralho para percorrer. Você responde às perguntas que alguém escreveu sobre si, e acertar todas é o match.",
    problemTitle: "O cansaço de deslizar é uma queixa real",
    problemParagraphs: [
      "Numa pesquisa da Forbes Health / OnePoll de 2024 com 1.000 adultos dos Estados Unidos que haviam usado um app de encontros no ano anterior, 78% disseram sentir-se esgotados por esses aplicativos. A queixa quase nunca é que eles não funcionem: é que usá-los passa a parecer um turno de trabalho não remunerado.",
      "O baralho de perfis existe justamente para produzir essa sensação. É uma fila interminável de decisões minúsculas, tomadas quase sem informação, e o que você aprende numa delas não ajuda em nada na seguinte. O esforço nunca se acumula. Dá para passar uma hora ali e sair sem nada que já não tivesse, a não ser uma lista de nomes um pouco mais longa.",
      "Ter encontros sem deslizar significa que a primeira coisa que você faz diante de uma pessoa não é um veredito. No Qulo é um conjunto de perguntas que ela escreveu sobre si — de 2 a 4, até 10 em um plano pago, com quatro alternativas cada — e a única forma de passar por ele é acertar tudo.",
    ],
    solutionTitle: "Um app de encontros sem baralho para deslizar",
    solutionBullets: [
      {
        title: "Não há nada para deslizar",
        desc: "Não existe esquerda nem direita. Você abre um perfil e responde ao que aquela pessoa perguntou.",
      },
      {
        title: "Escritas por ela, não escolhidas de uma lista",
        desc: "Cada pessoa escreve as suas próprias 2 a 4 perguntas de múltipla escolha — até 10 em um plano pago — e marca a resposta verdadeira: o que perguntam a você é o que ela achou que valia a pena saber a seu respeito.",
      },
      {
        title: "Tudo certo, ou nada",
        desc: "O match vem de acertar cada pergunta. Não existe meio match nem espera para saber se a outra pessoa também deslizou.",
      },
      {
        title: "Mais devagar de propósito",
        desc: "Um conjunto de perguntas leva minutos em vez de um instante. Menos decisões numa noite, e cada uma valendo mais.",
      },
    ],
    steps: [
      {
        title: "Escreva o seu conjunto",
        desc: "De 2 a 4 perguntas de múltipla escolha sobre você, quatro alternativas cada e a correta marcada.",
      },
      {
        title: "Leia em vez de deslizar",
        desc: "Abra o perfil de alguém e responda ao que a pessoa de fato perguntou. Não há baralho para atravessar antes.",
      },
      {
        title: "Tudo certo, e vocês combinaram",
        desc: "Um conjunto inteiramente correto abre a conversa. Nada mais abre.",
      },
    ],
  },
  it: {
    heroTitle: "Dating senza swipe: un altro modo di conoscersi",
    heroSub:
      "Non c'è nessun mazzo da scorrere. Rispondi alle domande che una persona ha scritto su di sé, e il match arriva solo se le indovini tutte.",
    problemTitle: "La stanchezza da swipe è una lamentela reale",
    problemParagraphs: [
      "In un sondaggio Forbes Health / OnePoll del 2024 condotto su 1.000 adulti statunitensi che avevano usato un'app di incontri nell'anno precedente, il 78% ha dichiarato di sentirsi esaurito dalle app di incontri. La lamentela quasi mai è che non servano a niente: è che usarle finisce per somigliare a un turno di lavoro non pagato.",
      "Il mazzo da scorrere è costruito per produrre esattamente quella sensazione. È una fila infinita di decisioni minuscole, prese quasi senza informazioni, e ciò che impari in una non ti serve nella successiva. La fatica non si accumula mai. Puoi passarci un'ora e uscirne senza nulla che non avessi già, a parte una lista di nomi un po' più lunga.",
      "Fare dating senza swipe significa che la prima cosa che fai davanti a una persona non è un verdetto. Su Qulo è una serie di domande che ha scritto su di sé — da 2 a 4, fino a 10 con un piano a pagamento, quattro opzioni ciascuna — e l'unico modo per superarla è rispondere correttamente a tutte.",
    ],
    solutionTitle: "Un'app di incontri senza mazzo da scorrere",
    solutionBullets: [
      {
        title: "Non c'è niente da scorrere",
        desc: "Non esiste una sinistra né una destra. Apri un profilo e rispondi a ciò che quella persona ha chiesto.",
      },
      {
        title: "Scritte da lei, non scelte da un elenco",
        desc: "Ogni persona scrive le proprie 2-4 domande a risposta multipla — fino a 10 con un piano a pagamento — e segna quella vera: ti viene chiesto ciò che lei ha ritenuto valesse la pena sapere di sé.",
      },
      {
        title: "Tutte giuste, o niente",
        desc: "Il match nasce dall'indovinare ogni domanda. Non c'è mezzo match né l'attesa di sapere se anche l'altro ha scorso a destra.",
      },
      {
        title: "Più lento di proposito",
        desc: "Una serie di domande richiede minuti e non un istante. Meno decisioni in una serata, e ognuna vale di più.",
      },
    ],
    steps: [
      {
        title: "Scrivi la tua serie",
        desc: "Da 2 a 4 domande a risposta multipla su di te, quattro opzioni ciascuna e quella corretta segnata.",
      },
      {
        title: "Leggi invece di scorrere",
        desc: "Apri il profilo di qualcuno e rispondi a ciò che ha davvero chiesto. Non c'è nessun mazzo da attraversare prima.",
      },
      {
        title: "Tutte giuste, e avete fatto match",
        desc: "Una serie interamente corretta apre la conversazione. Nient'altro la apre.",
      },
    ],
  },
  ja: {
    heroTitle: "スワイプしない出会い：もうひとつの方法",
    heroSub:
      "めくるカードの山はありません。相手が自分について書いた質問に答え、すべて正解したときだけマッチします。",
    problemTitle: "スワイプ疲れは実際に語られている不満",
    problemParagraphs: [
      "Forbes Health / OnePollが2024年に、過去1年間にデーティングアプリを使った米国の成人1,000人を対象に行った調査では、78%がデーティングアプリに燃え尽きを感じると答えました。不満の中身は「まったく役に立たない」ではなく、「使っていると無給のシフト勤務のように感じてくる」というものです。",
      "スワイプのカードの山は、まさにその感覚を生むように作られています。ほとんど情報のないまま下す小さな判断が延々と並び、ひとつで得たことが次の役に立つことはありません。労力はどこにも積み上がりません。一時間費やしても、少し長くなった名前の一覧のほかには、始める前と何も変わらないまま終わります。",
      "スワイプしない出会いとは、ある人に対して最初にすることが「値踏み」ではない、ということです。Quloでは、それはその人が自分について書いた質問のひと組です。2〜4問、有料プランなら最大10問。選択肢は各4つ。この組を越える方法は、すべてに正解することだけです。",
    ],
    solutionTitle: "スワイプするカードの山がないデーティングアプリ",
    solutionBullets: [
      {
        title: "スワイプするものがない",
        desc: "左も右もありません。プロフィールを開き、その人が尋ねたことに答えます。",
      },
      {
        title: "既製の一覧からではなく、本人が書いたもの",
        desc: "全員が自分で2〜4問（有料プランなら最大10問）の選択式の質問を書き、正解に印をつけます。つまり尋ねられるのは、その人が自分について知られる価値があると考えたことです。",
      },
      {
        title: "全問正解か、何もなしか",
        desc: "すべての質問に正解することでマッチします。半分のマッチはなく、相手もスワイプしたかどうかを待つ時間もありません。",
      },
      {
        title: "あえて遅く",
        desc: "ひと組の質問には一瞬ではなく数分かかります。一晩の判断の数は減り、その一つひとつの重みが増します。",
      },
    ],
    steps: [
      {
        title: "自分の一組をつくる",
        desc: "自分についての選択式の質問を2〜4問。選択肢は各4つ、正解に印をつけます。",
      },
      {
        title: "スワイプせずに読む",
        desc: "誰かのプロフィールを開き、その人が実際に尋ねたことに答えます。先に片づけるべきカードの山はありません。",
      },
      {
        title: "全問正解でマッチ成立",
        desc: "すべて正しい一組が会話を開きます。それ以外の道はありません。",
      },
    ],
  },
  ko: {
    heroTitle: "스와이프 없는 만남: 또 다른 방법",
    heroSub:
      "넘길 카드 더미가 없습니다. 상대가 자신에 대해 쓴 질문에 답하고, 전부 맞혔을 때만 매칭됩니다.",
    problemTitle: "스와이프 피로는 실제로 나오는 불만입니다",
    problemParagraphs: [
      "Forbes Health / OnePoll이 2024년에 지난 1년간 데이팅 앱을 사용한 미국 성인 1,000명을 대상으로 진행한 설문에서 78%가 데이팅 앱에 소진감을 느낀다고 답했습니다. 불만의 내용은 앱이 아무 소용이 없다는 것이 아니라, 쓰다 보면 무급 교대 근무처럼 느껴진다는 것입니다.",
      "스와이프 카드 더미는 바로 그 느낌을 만들어 내도록 설계돼 있습니다. 정보가 거의 없는 상태에서 내리는 작은 판단이 끝없이 이어지고, 하나에서 얻은 것이 다음에 도움이 되지도 않습니다. 노력이 쌓이지 않습니다. 한 시간을 쏟아도 시작할 때와 달라진 것은 조금 길어진 이름 목록뿐입니다.",
      "스와이프 없는 만남이란, 어떤 사람에 대해 처음 하는 일이 판정이 아니라는 뜻입니다. Qulo에서 그 처음은 상대가 자신에 대해 쓴 질문 한 세트입니다. 2~4개, 유료 플랜에서는 최대 10개, 보기는 각각 네 개. 이 세트를 지나는 방법은 전부 맞히는 것뿐입니다.",
    ],
    solutionTitle: "넘길 카드 더미가 없는 데이팅 앱",
    solutionBullets: [
      {
        title: "밀어 넘길 것이 없습니다",
        desc: "왼쪽도 오른쪽도 없습니다. 프로필을 열고, 그 사람이 물은 것에 답합니다.",
      },
      {
        title: "목록에서 고른 게 아니라 직접 쓴 질문",
        desc: "모든 회원이 자기 질문 2~4개(유료 플랜에서는 최대 10개)를 직접 쓰고 정답을 표시합니다. 그래서 받는 질문은 그 사람이 자신에 대해 알 만하다고 여긴 것입니다.",
      },
      {
        title: "전부 정답이거나, 아무것도 없거나",
        desc: "모든 질문을 맞혀야 매칭됩니다. 절반의 매칭은 없고, 상대도 밀었는지 기다릴 일도 없습니다.",
      },
      {
        title: "일부러 느리게",
        desc: "질문 한 세트에는 순간이 아니라 몇 분이 듭니다. 하룻저녁의 판단은 줄고, 하나하나의 무게는 커집니다.",
      },
    ],
    steps: [
      {
        title: "내 세트를 만든다",
        desc: "나에 대한 객관식 질문 2~4개, 각각 보기 네 개, 정답 표시까지.",
      },
      {
        title: "밀어 넘기는 대신 읽는다",
        desc: "누군가의 프로필을 열고 그 사람이 실제로 물은 것에 답합니다. 먼저 넘겨야 할 더미는 없습니다.",
      },
      {
        title: "전부 맞히면 매칭",
        desc: "빠짐없이 맞힌 한 세트가 대화를 엽니다. 다른 길은 없습니다.",
      },
    ],
  },
  zh: {
    heroTitle: "不用滑动的交友：另一种认识方式",
    heroSub:
      "没有可翻的卡片堆。你回答对方为自己写下的问题，只有全部答对才算配对。",
    problemTitle: "滑动带来的倦怠是真实的抱怨",
    problemParagraphs: [
      "在 Forbes Health / OnePoll 于 2024 年针对 1,000 名过去一年用过交友应用的美国成年人所做的调查中，78% 的人表示对交友应用感到倦怠。抱怨的内容很少是「完全没用」，而是「用着用着，像在上一个没有工资的班」。",
      "滑动卡片堆正是为制造这种感受而设计的。它是一条没有尽头的小决定队列，每个决定几乎都建立在没有信息的基础上，而你在其中一个里学到的东西，对下一个毫无帮助。力气从不累积。你可以在里面耗上一小时，走出来时除了一份稍长的名字清单，和进去时并无两样。",
      "不用滑动的交友，意味着你对一个人做的第一件事不是下判断。在 Qulo，那第一件事是他为自己写下的一组问题——2 到 4 道，付费方案最多 10 道，每道四个选项——而通过这一组的唯一方式，是全部答对。",
    ],
    solutionTitle: "一款没有滑动卡片堆的交友应用",
    solutionBullets: [
      {
        title: "没有可滑的东西",
        desc: "没有左，也没有右。你打开一份资料，回答那个人提出的问题。",
      },
      {
        title: "本人写的，不是从清单里挑的",
        desc: "每个人都自己写下 2 到 4 道选择题（付费方案最多 10 道）并标出正确答案，所以你被问到的，正是他认为值得被了解的部分。",
      },
      {
        title: "全对，或者什么都没有",
        desc: "答对每一道题才算配对。没有一半的配对，也不必等着看对方有没有回滑。",
      },
      {
        title: "有意放慢",
        desc: "一组题需要几分钟而不是一瞬间。一个晚上做的决定更少，每一个却更有分量。",
      },
    ],
    steps: [
      {
        title: "写下你自己的一组题",
        desc: "关于自己的选择题 2 到 4 道，每道四个选项，并标出正确答案。",
      },
      {
        title: "去读，而不是去滑",
        desc: "打开某人的资料，回答他真正提出的问题。不需要先翻过一堆卡片。",
      },
      {
        title: "全部答对，就配对成功",
        desc: "一组毫无差错的答案打开对话。除此之外，没有别的路。",
      },
    ],
  },
  nl: {
    heroTitle: "Daten zonder swipen: een andere manier om elkaar te ontmoeten",
    heroSub:
      "Er is geen stapel om doorheen te gaan. Je beantwoordt de vragen die iemand over zichzelf schreef, en alleen alles goed is een match.",
    problemTitle: "Swipemoeheid is een echte klacht",
    problemParagraphs: [
      "In een onderzoek van Forbes Health / OnePoll uit 2024 onder 1.000 Amerikaanse volwassenen die het jaar ervoor een datingapp hadden gebruikt, zei 78% zich opgebrand te voelen door datingapps. De klacht is zelden dat de apps helemaal niets opleveren — het is dat het gebruik ervan gaat voelen als een onbetaalde dienst.",
      "Een swipestapel is gebouwd om precies dat gevoel op te wekken. Het is een eindeloze rij minuscule beslissingen, elk genomen op vrijwel niets, en wat je bij de ene leert helpt je bij de volgende niet. De moeite stapelt zich nooit op. Je kunt er een uur in steken en er niets aan overhouden wat je nog niet had, behalve een iets langere lijst namen.",
      "Daten zonder swipen betekent dat het eerste wat je over een mens doet geen oordeel is. Op Qulo is het een set vragen die diegene over zichzelf schreef — 2 tot 4 stuks, tot 10 met een betaald abonnement, vier opties per vraag — en de enige manier erlangs is ze allemaal goed beantwoorden.",
    ],
    solutionTitle: "Een datingapp zonder swipestapel",
    solutionBullets: [
      {
        title: "Niets om te swipen",
        desc: "Er is geen links en geen rechts. Je opent een profiel en beantwoordt wat diegene heeft gevraagd.",
      },
      {
        title: "Zelf geschreven, niet uit een lijst gekozen",
        desc: "Ieder lid schrijft zijn eigen 2 tot 4 meerkeuzevragen — tot 10 met een betaald abonnement — en markeert het juiste antwoord, dus je krijgt gevraagd wat diegene zelf de moeite waard vond om over zich te laten weten.",
      },
      {
        title: "Alles goed, of niets",
        desc: "Je matcht door elke vraag goed te hebben. Er is geen halve match en geen wachten of de ander ook terugswipete.",
      },
      {
        title: "Met opzet langzamer",
        desc: "Een set vragen kost minuten in plaats van een moment. Minder beslissingen op een avond, en elk ervan weegt zwaarder.",
      },
    ],
    steps: [
      {
        title: "Schrijf je eigen set",
        desc: "2 tot 4 meerkeuzevragen over jezelf, vier opties per vraag, met het juiste antwoord gemarkeerd.",
      },
      {
        title: "Lees in plaats van swipen",
        desc: "Open iemands profiel en beantwoord wat diegene werkelijk vroeg. Er is geen stapel die je eerst door moet.",
      },
      {
        title: "Alles goed, en jullie matchen",
        desc: "Een volledig goede set opent het gesprek. Iets anders doet dat niet.",
      },
    ],
  },
  pl: {
    heroTitle: "Randki bez przesuwania: inny sposób poznawania się",
    heroSub:
      "Nie ma talii do przewijania. Odpowiadasz na pytania, które ktoś napisał o sobie, a dopasowanie daje tylko komplet trafień.",
    problemTitle: "Zmęczenie przesuwaniem to realna skarga",
    problemParagraphs: [
      "W badaniu Forbes Health / OnePoll z 2024 roku, przeprowadzonym wśród 1000 dorosłych Amerykanów, którzy w ciągu poprzedniego roku korzystali z aplikacji randkowej, 78% stwierdziło, że czuje się wypalonych aplikacjami randkowymi. Skarga rzadko brzmi tak, że aplikacje w ogóle nie działają — brzmi tak, że korzystanie z nich zaczyna przypominać nieopłacaną zmianę.",
      "Talia do przesuwania jest zbudowana dokładnie po to, żeby wywoływać to uczucie. To niekończąca się kolejka drobnych decyzji podejmowanych niemal bez informacji, a to, czego dowiadujesz się przy jednej, nie pomaga przy następnej. Wysiłek nigdy się nie kumuluje. Możesz spędzić przy tym godzinę i wyjść bez niczego, czego nie miałeś wcześniej, poza nieco dłuższą listą imion.",
      "Randki bez przesuwania oznaczają, że pierwszą rzeczą, jaką robisz wobec człowieka, nie jest wyrok. W Qulo jest to zestaw pytań, które ta osoba napisała o sobie — od 2 do 4, do 10 w płatnym planie, po cztery odpowiedzi w każdym — a jedyny sposób, by przez niego przejść, to trafić wszystkie.",
    ],
    solutionTitle: "Aplikacja randkowa bez talii do przesuwania",
    solutionBullets: [
      {
        title: "Nie ma czego przesuwać",
        desc: "Nie ma lewej ani prawej strony. Otwierasz profil i odpowiadasz na to, o co ta osoba zapytała.",
      },
      {
        title: "Napisane przez nią, nie wybrane z listy",
        desc: "Każdy pisze własne 2–4 pytania wielokrotnego wyboru — do 10 w płatnym planie — i zaznacza prawdziwą odpowiedź, więc pytają cię o to, co ta osoba uznała za warte wiedzenia o sobie.",
      },
      {
        title: "Komplet albo nic",
        desc: "Dopasowanie daje trafienie każdego pytania. Nie ma połowicznych dopasowań ani czekania, czy druga strona też przesunęła.",
      },
      {
        title: "Wolniej, i to celowo",
        desc: "Zestaw pytań zajmuje minuty, a nie chwilę. Mniej decyzji w ciągu wieczoru, ale każda warta więcej.",
      },
    ],
    steps: [
      {
        title: "Napisz własny zestaw",
        desc: "Od 2 do 4 pytań wielokrotnego wyboru o sobie, po cztery odpowiedzi w każdym, z zaznaczoną poprawną.",
      },
      {
        title: "Czytaj, zamiast przesuwać",
        desc: "Otwórz czyjś profil i odpowiedz na to, o co ta osoba naprawdę zapytała. Nie ma talii, którą trzeba najpierw przejść.",
      },
      {
        title: "Komplet trafień i jest dopasowanie",
        desc: "W pełni poprawny zestaw otwiera rozmowę. Nic innego jej nie otwiera.",
      },
    ],
  },
  sv: {
    heroTitle: "Dejta utan att svepa: ett annat sätt att mötas",
    heroSub:
      "Det finns ingen kortlek att bläddra igenom. Du svarar på frågorna någon skrivit om sig själv, och bara alla rätt ger en matchning.",
    problemTitle: "Svepströtthet är ett verkligt klagomål",
    problemParagraphs: [
      "I en undersökning från Forbes Health / OnePoll 2024 bland 1 000 vuxna i USA som använt en dejtingapp under det gångna året uppgav 78 % att de kände sig utbrända av dejtingappar. Klagomålet är sällan att apparna inte ger något alls — det är att användandet börjar kännas som ett obetalt arbetspass.",
      "En svepkortlek är byggd för att framkalla just den känslan. Den är en oändlig kö av små beslut, vart och ett fattat på nästan ingenting, och det du lär dig i det ena hjälper dig inte i det nästa. Mödan lagras aldrig. Du kan lägga en timme där och gå därifrån utan något du inte redan hade, bortsett från en aning längre namnlista.",
      "Att dejta utan att svepa betyder att det första du gör med en människa inte är en dom. På Qulo är det en omgång frågor som personen skrivit om sig själv — 2 till 4 stycken, upp till 10 med ett betalabonnemang, med fyra alternativ var — och enda vägen förbi den är att svara rätt på allihop.",
    ],
    solutionTitle: "En dejtingapp utan svepkortlek",
    solutionBullets: [
      {
        title: "Ingenting att svepa",
        desc: "Det finns inget vänster och inget höger. Du öppnar en profil och svarar på det personen har frågat.",
      },
      {
        title: "Skrivna av hen, inte valda ur en lista",
        desc: "Varje medlem skriver sina egna 2 till 4 flervalsfrågor — upp till 10 med ett betalabonnemang — och markerar det sanna svaret, så det du får frågan om är det personen själv tyckte var värt att veta.",
      },
      {
        title: "Alla rätt, annars ingenting",
        desc: "Du matchar genom att ha varje fråga rätt. Det finns ingen halv matchning och ingen väntan på om den andra svepte tillbaka.",
      },
      {
        title: "Långsammare med flit",
        desc: "En omgång frågor tar minuter i stället för ett ögonblick. Färre beslut på en kväll, och vart och ett värt mer.",
      },
    ],
    steps: [
      {
        title: "Skriv din egen omgång",
        desc: "2 till 4 flervalsfrågor om dig själv, fyra alternativ var, med det rätta markerat.",
      },
      {
        title: "Läs i stället för att svepa",
        desc: "Öppna någons profil och svara på det hen faktiskt frågade. Det finns ingen kortlek att ta sig igenom först.",
      },
      {
        title: "Alla rätt, och ni är matchade",
        desc: "En helt riktig omgång öppnar samtalet. Ingenting annat gör det.",
      },
    ],
  },
  hi: {
    heroTitle: "बिना स्वाइप डेटिंग: मिलने का दूसरा तरीका",
    heroSub:
      "पलटने के लिए कोई ढेर नहीं है। आप वे सवाल हल करते हैं जो किसी ने अपने बारे में लिखे हैं, और मैच सिर्फ़ तभी होता है जब सब सही हों।",
    problemTitle: "स्वाइप की थकान सचमुच सुनी जाने वाली शिकायत है",
    problemParagraphs: [
      "Forbes Health / OnePoll के 2024 के सर्वेक्षण में, जिसमें पिछले एक साल में डेटिंग ऐप इस्तेमाल कर चुके 1,000 अमेरिकी वयस्क शामिल थे, 78% ने कहा कि वे डेटिंग ऐप्स से थक चुके हैं। शिकायत यह नहीं होती कि ऐप बिलकुल काम नहीं करते, बल्कि यह कि उन्हें चलाना कुछ समय बाद बिना वेतन की शिफ़्ट जैसा लगने लगता है।",
      "स्वाइप वाला ढेर ठीक यही अनुभव पैदा करने के लिए बनाया गया है। यह छोटे-छोटे फ़ैसलों की कभी न ख़त्म होने वाली क़तार है, हर फ़ैसला लगभग बिना किसी जानकारी के; और एक में जो समझ आता है, वह अगले में काम नहीं आता। मेहनत कहीं जमा नहीं होती। आप एक घंटा लगाकर भी वहीं खड़े रहते हैं जहाँ से शुरू किया था — बस नामों की सूची थोड़ी लंबी हो जाती है।",
      "बिना स्वाइप डेटिंग का मतलब है कि किसी इंसान को लेकर आप जो पहला काम करते हैं, वह फ़ैसला सुनाना नहीं है। Qulo पर वह पहला काम उस व्यक्ति के अपने लिखे सवालों का एक सेट है — 2 से 4 सवाल, सशुल्क प्लान पर 10 तक, हर एक में चार विकल्प — और उस सेट को पार करने का एक ही तरीक़ा है: सबका सही जवाब।",
    ],
    solutionTitle: "बिना स्वाइप ढेर वाला डेटिंग ऐप",
    solutionBullets: [
      {
        title: "स्वाइप करने को कुछ नहीं",
        desc: "न बाएँ, न दाएँ। आप प्रोफ़ाइल खोलते हैं और उस व्यक्ति ने जो पूछा है, उसका जवाब देते हैं।",
      },
      {
        title: "सूची से चुने नहीं, उसी के लिखे",
        desc: "हर व्यक्ति अपने 2 से 4 बहुविकल्पीय सवाल (सशुल्क प्लान पर 10 तक) ख़ुद लिखता है और सही जवाब चिह्नित करता है — यानी आपसे वही पूछा जाता है जो उसने अपने बारे में जानने लायक़ समझा।",
      },
      {
        title: "सब सही, वरना कुछ नहीं",
        desc: "हर सवाल सही करने पर ही मैच होता है। आधा मैच नहीं होता, और यह इंतज़ार भी नहीं कि सामने वाले ने भी स्वाइप किया या नहीं।",
      },
      {
        title: "जान-बूझकर धीमा",
        desc: "सवालों का एक सेट पल भर नहीं, कुछ मिनट लेता है। एक शाम में फ़ैसले कम होते हैं, पर हर फ़ैसले का वज़न ज़्यादा।",
      },
    ],
    steps: [
      {
        title: "अपना सेट लिखिए",
        desc: "अपने बारे में 2 से 4 बहुविकल्पीय सवाल, हर एक में चार विकल्प और एक चिह्नित सही जवाब।",
      },
      {
        title: "स्वाइप करने के बजाय पढ़िए",
        desc: "किसी की प्रोफ़ाइल खोलिए और उसने असल में जो पूछा है, उसका जवाब दीजिए। पहले पार करने के लिए कोई ढेर नहीं है।",
      },
      {
        title: "सब सही, और मैच हो गया",
        desc: "पूरी तरह सही सेट बातचीत खोल देता है। और कुछ नहीं खोलता।",
      },
    ],
  },
};
