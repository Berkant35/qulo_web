import type { LandingContent } from "@/lib/constants/landings";

/**
 * Body copy for /[locale]/features/quiz-dating-app, in all 16 locales.
 *
 * Written 2026-09-04 to replace a `getContent()` function built out of
 * `isTr ? "..." : "..."` ternaries, which served English to fourteen locales
 * while hreflang and the canonical URL claimed a translated page.
 *
 * Removed from the previous copy and not to be reinstated:
 *  - "the world's first quiz-based dating app" — unverifiable superlative.
 *  - "Research shows that over 80% of swipe-based matches never lead to a
 *    lasting connection" — no publisher, no sample, no denominator.
 *  - "a decision that typically takes less than a second" — a bare duration
 *    presented as a research finding.
 *  - "AI-powered question suggestions" and the gamification inventory
 *    ("badges, levels and 6 different quiz powers"), which claim more than the
 *    matching mechanic this page is about.
 * The second paragraph now makes the swipe-fatigue argument qualitatively; the
 * one figure the site can source is used on /features/dating-without-swiping,
 * in full, with publisher and sample in the same sentence.
 *
 * Only the mechanic is claimed: 2 to 4 multiple-choice questions with four
 * options each (up to 10 on a paid plan), a correct answer marked by the author, a match only on a
 * perfect set, and optional paid hints. No verification, screening or scoring
 * of any kind is described, because the app does none of it.
 */
export const quizDatingApp: Record<string, LandingContent> = {
  en: {
    heroTitle: "Quiz Dating App: Match by Answering Questions",
    heroSub:
      "Instead of swiping past a photo, you answer the questions someone wrote about themselves. Get every one right and you match.",
    problemTitle: "Why a Photograph Is Not Much to Go On",
    problemParagraphs: [
      "Swipe-based dating apps ask you to decide about a person from a photograph and a line or two of text. Speed is the whole design: the deck is built so that you can get through hundreds of profiles in an evening. What it cannot give you is anything you would actually want to know about the person behind the picture.",
      "So the effort goes into sorting faces rather than into meeting anyone. A long session can end with a list of matches and not one conversation worth having, because nothing in the process ever asked either of you to say something real. That is what people mean by burnout — not too little choice, but far too much of it and nothing to choose on.",
      "A quiz dating app moves the first filter. On Qulo, every profile carries between two and four multiple-choice questions that the member wrote about themselves, up to ten on a paid plan — four options each, one of them true. You do not swipe on those questions. You answer them, and answering all of them correctly is what creates the match.",
    ],
    solutionTitle: "How Qulo Works Instead",
    solutionBullets: [
      {
        title: "Questions you write yourself",
        desc: "Two to four multiple-choice questions — up to ten on a paid plan — four options each, and you mark the option that is true about you.",
      },
      {
        title: "All correct, or no match",
        desc: "There is no partial credit, no percentage and no ranking. Someone reaches you by getting every question right.",
      },
      {
        title: "Effort instead of speed",
        desc: "A set of questions takes minutes rather than an instant, so whoever gets through it has actually read what you wrote.",
      },
      {
        title: "Hints are optional",
        desc: "Paid hints exist for anyone stuck on a question. Nobody needs them: a full set can be solved, and a match made, without spending anything.",
      },
    ],
    steps: [
      {
        title: "Write your questions",
        desc: "Two to four multiple-choice questions about yourself. Give each one four options and mark the correct answer.",
      },
      {
        title: "Answer someone else's",
        desc: "Open a profile and work through the questions that person wrote. Read them carefully — one wrong answer ends the attempt.",
      },
      {
        title: "Get them all right and match",
        desc: "A perfect set opens the conversation. That is the whole condition for matching on Qulo.",
      },
    ],
  },
  tr: {
    heroTitle: "Quiz Dating App: Soruları Cevaplayarak Eşleş",
    heroSub:
      "Fotoğrafı kaydırıp geçmek yerine, karşındakinin kendisi hakkında yazdığı soruları cevaplarsın. Hepsini doğru bilirsen eşleşirsin.",
    problemTitle: "Bir Fotoğraf Karar Vermek İçin Neden Yetmez?",
    problemParagraphs: [
      "Kaydırma tabanlı dating uygulamaları, bir insan hakkında bir fotoğrafa ve bir iki satır yazıya bakarak karar vermeni ister. Tasarımın tamamı hız üzerine kuruludur: deste, bir akşamda yüzlerce profili geçebilesin diye yapılmıştır. Veremediği tek şey, fotoğrafın arkasındaki kişi hakkında gerçekten merak ettiğin şeylerdir.",
      "Böylece emek, biriyle tanışmaya değil yüzleri ayıklamaya gider. Uzun bir oturumun sonunda elinde bir eşleşme listesi olur ama konuşmaya değer tek bir sohbet çıkmaz; çünkü süreç hiçbir aşamada ikinizden de gerçek bir şey söylemenizi istememiştir. İnsanların tükenmişlik dediği şey budur: seçenek azlığı değil, seçenek bolluğu ve seçmek için elinde hiçbir şey olmaması.",
      "Quiz dating app, ilk filtrenin yerini değiştirir. Qulo'da her profilde, kişinin kendisi hakkında yazdığı 2 ila 4 çoktan seçmeli soru bulunur, ücretli planda 10'a kadar — her birinin dört şıkkı vardır, biri doğrudur. Bu soruları kaydırıp geçmezsin, cevaplarsın. Eşleşmeyi yaratan da hepsini doğru cevaplamandır.",
    ],
    solutionTitle: "Qulo Bunun Yerine Nasıl Çalışıyor?",
    solutionBullets: [
      {
        title: "Soruları sen yazarsın",
        desc: "2 ila 4 çoktan seçmeli soru — ücretli planda 10'a kadar — her birinde dört şık; senin hakkında doğru olan şıkkı sen işaretlersin.",
      },
      {
        title: "Ya hepsi doğru, ya eşleşme yok",
        desc: "Kısmi puan, yüzde ya da sıralama yoktur. Sana ulaşmanın tek yolu bütün soruları doğru bilmektir.",
      },
      {
        title: "Hız değil, emek",
        desc: "Bir soru setini çözmek bir anda değil dakikalar içinde olur; yani karşına çıkan kişi yazdıklarını gerçekten okumuştur.",
      },
      {
        title: "İpuçları isteğe bağlı",
        desc: "Bir soruda takılan için ücretli ipuçları var. Kimse mecbur değil: tek kuruş harcamadan bütün seti çözüp eşleşebilirsin.",
      },
    ],
    steps: [
      {
        title: "Sorularını yaz",
        desc: "Kendin hakkında 2 ila 4 çoktan seçmeli soru hazırla. Her birine dört şık ver ve doğru cevabı işaretle.",
      },
      {
        title: "Başkasının sorularını çöz",
        desc: "Bir profili aç ve o kişinin yazdığı soruları baştan sona cevapla. Dikkatli oku — tek yanlış cevap denemeyi bitirir.",
      },
      {
        title: "Hepsini doğru bil ve eşleş",
        desc: "Eksiksiz bir set sohbeti açar. Qulo'da eşleşmenin koşulu bundan ibarettir.",
      },
    ],
  },
  de: {
    heroTitle: "Quiz-Dating-App: Matchen, indem du Fragen beantwortest",
    heroSub:
      "Statt an einem Foto vorbeizuwischen, beantwortest du die Fragen, die jemand über sich geschrieben hat. Alle richtig, und ihr matcht.",
    problemTitle: "Warum ein Foto eine dünne Entscheidungsgrundlage ist",
    problemParagraphs: [
      "Swipe-basierte Dating-Apps verlangen, dass du über einen Menschen anhand eines Fotos und ein, zwei Zeilen Text entscheidest. Tempo ist das ganze Konzept: Der Stapel ist so gebaut, dass du an einem Abend Hunderte Profile schaffst. Was er dir nicht geben kann, ist irgendetwas, das du über die Person hinter dem Bild wirklich wissen möchtest.",
      "Die Mühe fließt also ins Sortieren von Gesichtern statt ins Kennenlernen. Eine lange Sitzung endet mit einer Liste von Matches und keinem einzigen Gespräch, das sich gelohnt hätte — weil der Ablauf zu keinem Zeitpunkt von einem von euch verlangt hat, etwas Echtes zu sagen. Genau das meinen Leute mit Erschöpfung: nicht zu wenig Auswahl, sondern viel zu viel davon und nichts, wonach man wählen könnte.",
      "Eine Quiz-Dating-App verschiebt den ersten Filter. Bei Qulo trägt jedes Profil 2 bis 4 Multiple-Choice-Fragen, die das Mitglied selbst über sich geschrieben hat, bis zu 10 im kostenpflichtigen Tarif — je vier Antwortmöglichkeiten, eine davon stimmt. Über diese Fragen wischst du nicht. Du beantwortest sie, und alle richtig zu beantworten ist das, was das Match erzeugt.",
    ],
    solutionTitle: "Wie Qulo es stattdessen macht",
    solutionBullets: [
      {
        title: "Fragen, die du selbst schreibst",
        desc: "2 bis 4 Multiple-Choice-Fragen — bis zu 10 im kostenpflichtigen Tarif — mit je vier Möglichkeiten, und du markierst die, die auf dich zutrifft.",
      },
      {
        title: "Alles richtig oder kein Match",
        desc: "Es gibt keine Teilpunkte, keine Prozentzahl und kein Ranking. Zu dir kommt nur, wer jede Frage richtig hat.",
      },
      {
        title: "Aufwand statt Tempo",
        desc: "Ein Fragenset dauert Minuten statt einen Augenblick — wer es schafft, hat also tatsächlich gelesen, was du geschrieben hast.",
      },
      {
        title: "Hinweise sind freiwillig",
        desc: "Für alle, die bei einer Frage hängen, gibt es kostenpflichtige Hinweise. Nötig sind sie nicht: Ein ganzes Set lässt sich lösen und ein Match schließen, ohne einen Cent auszugeben.",
      },
    ],
    steps: [
      {
        title: "Schreib deine Fragen",
        desc: "2 bis 4 Multiple-Choice-Fragen über dich. Gib jeder vier Antwortmöglichkeiten und markiere die richtige.",
      },
      {
        title: "Beantworte die von jemand anderem",
        desc: "Öffne ein Profil und arbeite dich durch die Fragen dieser Person. Lies genau — eine falsche Antwort beendet den Versuch.",
      },
      {
        title: "Alles richtig, und ihr matcht",
        desc: "Ein fehlerfreies Set öffnet das Gespräch. Mehr braucht ein Match bei Qulo nicht.",
      },
    ],
  },
  fr: {
    heroTitle: "App de dating quiz : matchez en répondant aux questions",
    heroSub:
      "Au lieu de balayer une photo, vous répondez aux questions qu'une personne a écrites sur elle-même. Aucune erreur, et c'est un match.",
    problemTitle: "Pourquoi une photo ne suffit pas à décider",
    problemParagraphs: [
      "Les applications de rencontre à swipe vous demandent de trancher sur quelqu'un à partir d'une photo et d'une ou deux lignes de texte. Toute la conception vise la vitesse : la pile est faite pour que vous puissiez enchaîner des centaines de profils en une soirée. Ce qu'elle ne peut pas vous donner, c'est ce que vous voudriez vraiment savoir de la personne derrière l'image.",
      "L'effort part donc dans le tri des visages plutôt que dans la rencontre. Une longue session se termine avec une liste de matchs et pas une conversation qui vaille la peine, parce qu'à aucun moment le processus n'a demandé à l'un ou à l'autre de dire quelque chose de vrai. C'est ce que les gens appellent l'épuisement : non pas trop peu de choix, mais bien trop, et rien sur quoi choisir.",
      "Une app de dating quiz déplace le premier filtre. Sur Qulo, chaque profil porte de 2 à 4 questions à choix multiple que la personne a écrites sur elle-même, jusqu'à 10 avec un abonnement payant — quatre options chacune, dont une vraie. Ces questions, on ne les balaie pas : on y répond, et c'est le fait d'y répondre entièrement juste qui crée le match.",
    ],
    solutionTitle: "Ce que Qulo fait à la place",
    solutionBullets: [
      {
        title: "Des questions que vous écrivez vous-même",
        desc: "De 2 à 4 questions à choix multiple — jusqu'à 10 avec un abonnement payant —, quatre options chacune, et vous cochez celle qui est vraie à votre sujet.",
      },
      {
        title: "Tout juste, ou pas de match",
        desc: "Pas de points partiels, pas de pourcentage, pas de classement. On vous atteint en trouvant chaque réponse.",
      },
      {
        title: "De l'attention plutôt que de la vitesse",
        desc: "Une série de questions prend quelques minutes et non un instant : qui arrive au bout a réellement lu ce que vous avez écrit.",
      },
      {
        title: "Les indices sont facultatifs",
        desc: "Des indices payants existent pour qui bloque sur une question. Personne n'en a besoin : on peut résoudre une série entière et matcher sans rien dépenser.",
      },
    ],
    steps: [
      {
        title: "Écrivez vos questions",
        desc: "De 2 à 4 questions à choix multiple sur vous. Donnez quatre options à chacune et cochez la bonne réponse.",
      },
      {
        title: "Répondez à celles d'une autre personne",
        desc: "Ouvrez un profil et parcourez les questions qu'elle a écrites. Lisez bien : une seule erreur met fin à la tentative.",
      },
      {
        title: "Tout juste, et vous matchez",
        desc: "Une série sans faute ouvre la conversation. C'est toute la condition pour matcher sur Qulo.",
      },
    ],
  },
  es: {
    heroTitle: "App de citas tipo quiz: haz match respondiendo preguntas",
    heroSub:
      "En lugar de deslizar una foto, respondes las preguntas que alguien escribió sobre sí mismo. Si aciertas todas, hay match.",
    problemTitle: "Por qué una foto es poca base para decidir",
    problemParagraphs: [
      "Las apps de citas basadas en deslizar te piden decidir sobre una persona a partir de una foto y una o dos líneas de texto. Todo el diseño busca velocidad: el mazo está hecho para que pases cientos de perfiles en una noche. Lo que no puede darte es nada de lo que de verdad querrías saber sobre quien está detrás de la imagen.",
      "Así, el esfuerzo se va en clasificar caras en vez de en conocer a alguien. Una sesión larga termina con una lista de matches y ni una conversación que valga la pena, porque en ningún momento el proceso os pidió a ninguno de los dos decir algo real. Eso es lo que la gente llama agotamiento: no falta de opciones, sino demasiadas y nada con lo que elegir.",
      "Una app de citas tipo quiz cambia de sitio el primer filtro. En Qulo cada perfil lleva entre 2 y 4 preguntas de opción múltiple que esa persona escribió sobre sí misma, hasta 10 con un plan de pago: cuatro opciones cada una y solo una verdadera. Esas preguntas no se deslizan, se responden, y acertarlas todas es lo que crea el match.",
    ],
    solutionTitle: "Cómo funciona Qulo en su lugar",
    solutionBullets: [
      {
        title: "Preguntas que escribes tú",
        desc: "De 2 a 4 preguntas de opción múltiple — hasta 10 con un plan de pago —, cuatro opciones cada una, y tú marcas la que es cierta sobre ti.",
      },
      {
        title: "Todas bien, o no hay match",
        desc: "No hay puntuación parcial, ni porcentaje, ni ranking. A ti se llega acertando todas y cada una de las preguntas.",
      },
      {
        title: "Esfuerzo en lugar de velocidad",
        desc: "Resolver una tanda lleva minutos y no un instante, así que quien llega hasta ti ha leído de verdad lo que escribiste.",
      },
      {
        title: "Las pistas son opcionales",
        desc: "Hay pistas de pago para quien se atasca en una pregunta. Nadie las necesita: se puede resolver una tanda entera y hacer match sin gastar nada.",
      },
    ],
    steps: [
      {
        title: "Escribe tus preguntas",
        desc: "De 2 a 4 preguntas de opción múltiple sobre ti. Dale cuatro opciones a cada una y marca la respuesta correcta.",
      },
      {
        title: "Responde las de otra persona",
        desc: "Abre un perfil y recorre las preguntas que escribió. Léelas con calma: un fallo termina el intento.",
      },
      {
        title: "Acierta todas y haz match",
        desc: "Una tanda perfecta abre la conversación. Esa es toda la condición para hacer match en Qulo.",
      },
    ],
  },
  ar: {
    heroTitle: "تطبيق مواعدة بالأسئلة: تطابَق بالإجابة الصحيحة",
    heroSub:
      "بدل تمرير الصورة، تجيب عن الأسئلة التي كتبها شخص عن نفسه. أجب عنها كلها إجابة صحيحة فيحدث التطابق.",
    problemTitle: "لماذا لا تكفي صورة واحدة لاتخاذ قرار؟",
    problemParagraphs: [
      "تطلب منك تطبيقات المواعدة القائمة على التمرير أن تحكم على إنسان انطلاقًا من صورة وسطرين من النص. التصميم كله قائم على السرعة: رصّة البطاقات مصنوعة لتمرّ على مئات الملفات في أمسية واحدة. أما ما لا تستطيع تقديمه فهو أي شيء ترغب فعلًا في معرفته عن الشخص الذي خلف الصورة.",
      "هكذا يذهب الجهد إلى فرز الوجوه لا إلى التعارف. تنتهي جلسة طويلة بقائمة تطابقات ومن دون محادثة واحدة تستحق، لأن المسار لم يطلب من أي منكما في أي لحظة أن يقول شيئًا حقيقيًا. هذا ما يسمّيه الناس إنهاكًا: لا قلّة في الخيارات، بل فيض منها ولا شيء تختار على أساسه.",
      "تطبيق المواعدة بالأسئلة ينقل الفلتر الأول من مكانه. في Qulo يحمل كل ملف بين سؤالين و4 أسئلة اختيار من متعدد كتبها صاحبه عن نفسه، حتى 10 أسئلة في الخطة المدفوعة، لكل سؤال أربعة خيارات واحد منها صحيح. أنت لا تمرّر هذه الأسئلة، بل تجيب عنها، والإجابة الصحيحة عنها جميعًا هي ما يصنع التطابق.",
    ],
    solutionTitle: "كيف يعمل Qulo بدلًا من ذلك",
    solutionBullets: [
      {
        title: "أسئلة تكتبها بنفسك",
        desc: "بين سؤالين و4 أسئلة اختيار من متعدد — حتى 10 أسئلة في الخطة المدفوعة — لكل منها أربعة خيارات، وأنت تحدّد الخيار الصحيح عنك.",
      },
      {
        title: "إجابات كاملة أو لا تطابق",
        desc: "لا درجات جزئية ولا نسبة مئوية ولا ترتيب. يصل إليك من يجيب عن كل سؤال إجابة صحيحة.",
      },
      {
        title: "جهد بدل سرعة",
        desc: "حلّ مجموعة أسئلة يستغرق دقائق لا لحظة، أي أن من يجتازها قد قرأ فعلًا ما كتبته.",
      },
      {
        title: "التلميحات اختيارية",
        desc: "هناك تلميحات مدفوعة لمن يتعثّر عند سؤال. لا أحد مضطر إليها: يمكن حلّ المجموعة كاملة وتحقيق التطابق دون إنفاق أي مبلغ.",
      },
    ],
    steps: [
      {
        title: "اكتب أسئلتك",
        desc: "بين سؤالين و4 أسئلة اختيار من متعدد عن نفسك. امنح كل سؤال أربعة خيارات وحدّد الإجابة الصحيحة.",
      },
      {
        title: "أجب عن أسئلة غيرك",
        desc: "افتح ملفًا وامضِ في الأسئلة التي كتبها صاحبه. اقرأ بتمعّن، فإجابة خاطئة واحدة تنهي المحاولة.",
      },
      {
        title: "أجب عنها كلها وتطابَق",
        desc: "مجموعة كاملة الصحّة تفتح المحادثة. هذا كل شرط التطابق في Qulo.",
      },
    ],
  },
  ru: {
    heroTitle: "Дейтинг-приложение с вопросами: совпадение через ответы",
    heroSub:
      "Вместо того чтобы смахивать фотографию, вы отвечаете на вопросы, которые человек написал о себе. Все ответы верны — это совпадение.",
    problemTitle: "Почему фотографии мало, чтобы решить",
    problemParagraphs: [
      "Приложения со свайпами предлагают судить о человеке по фотографии и паре строк текста. Вся конструкция построена на скорости: колода сделана так, чтобы за вечер вы успели просмотреть сотни анкет. Чего она дать не может — так это того, что вам на самом деле хотелось бы знать о человеке за снимком.",
      "В итоге силы уходят на сортировку лиц, а не на знакомство. Долгий вечер заканчивается списком совпадений и ни одним разговором, ради которого стоило бы задержаться, потому что процесс ни разу не потребовал ни от кого из вас сказать что-то настоящее. Это и называют выгоранием: не нехватка выбора, а его избыток и отсутствие оснований для выбора.",
      "Дейтинг с вопросами переносит первый фильтр в другое место. В Qulo в каждой анкете есть от 2 до 4 вопросов с вариантами ответа, которые человек написал о себе (до 10 на платном тарифе): по четыре варианта, один из них верный. Эти вопросы не смахивают — на них отвечают, и совпадение возникает только тогда, когда все ответы верны.",
    ],
    solutionTitle: "Как вместо этого работает Qulo",
    solutionBullets: [
      {
        title: "Вопросы, которые вы пишете сами",
        desc: "От 2 до 4 вопросов — до 10 на платном тарифе — с четырьмя вариантами ответа каждый; верный вариант отмечаете вы.",
      },
      {
        title: "Все верно — или совпадения нет",
        desc: "Нет ни частичного зачета, ни процентов, ни рейтинга. До вас доходит тот, кто ответил верно на каждый вопрос.",
      },
      {
        title: "Усилие вместо скорости",
        desc: "Набор вопросов занимает минуты, а не мгновение, так что дошедший до конца действительно прочитал написанное вами.",
      },
      {
        title: "Подсказки — по желанию",
        desc: "Для тех, кто застрял на вопросе, есть платные подсказки. Они никому не обязательны: набор можно пройти целиком и совпасть, не потратив ничего.",
      },
    ],
    steps: [
      {
        title: "Напишите свои вопросы",
        desc: "От 2 до 4 вопросов о себе с вариантами ответа. Дайте каждому четыре варианта и отметьте верный.",
      },
      {
        title: "Ответьте на чужие",
        desc: "Откройте анкету и пройдите вопросы, которые написал этот человек. Читайте внимательно: одна ошибка завершает попытку.",
      },
      {
        title: "Ответьте верно на все и совпадите",
        desc: "Безошибочный набор открывает переписку. Это и есть все условие совпадения в Qulo.",
      },
    ],
  },
  pt: {
    heroTitle: "App de encontros em formato quiz: combine respondendo perguntas",
    heroSub:
      "Em vez de deslizar sobre uma foto, você responde às perguntas que alguém escreveu sobre si. Acertou todas, deu match.",
    problemTitle: "Por que uma foto é pouco para decidir",
    problemParagraphs: [
      "Os apps de encontros baseados em deslizar pedem que você decida sobre uma pessoa a partir de uma foto e de uma ou duas linhas de texto. O projeto inteiro é feito de velocidade: o baralho existe para que você atravesse centenas de perfis numa noite. O que ele não consegue dar é justamente aquilo que você gostaria de saber sobre quem está atrás da imagem.",
      "Assim o esforço vai para separar rostos, não para conhecer alguém. Uma sessão longa termina com uma lista de matches e nenhuma conversa que valha a pena, porque em momento algum o processo pediu que qualquer um de vocês dissesse algo verdadeiro. É a isso que as pessoas chamam de esgotamento: não falta de opções, mas opções demais e nada em que se apoiar para escolher.",
      "Um app de encontros em formato quiz muda o lugar do primeiro filtro. No Qulo, cada perfil traz de 2 a 4 perguntas de múltipla escolha que a própria pessoa escreveu sobre si, até 10 num plano pago — quatro alternativas em cada uma, sendo uma verdadeira. Essas perguntas não se deslizam: respondem-se, e acertar todas é o que cria o match.",
    ],
    solutionTitle: "Como o Qulo funciona no lugar disso",
    solutionBullets: [
      {
        title: "Perguntas escritas por você",
        desc: "De 2 a 4 perguntas de múltipla escolha — até 10 num plano pago —, quatro alternativas cada, e você marca a que é verdadeira a seu respeito.",
      },
      {
        title: "Tudo certo, ou nada de match",
        desc: "Não há acerto parcial, porcentagem nem ranking. Chega até você quem acertar cada uma das perguntas.",
      },
      {
        title: "Esforço em vez de velocidade",
        desc: "Um conjunto de perguntas leva minutos, não um instante — quem chega ao fim leu de fato o que você escreveu.",
      },
      {
        title: "As dicas são opcionais",
        desc: "Existem dicas pagas para quem empaca numa pergunta. Ninguém precisa delas: dá para resolver um conjunto inteiro e dar match sem gastar nada.",
      },
    ],
    steps: [
      {
        title: "Escreva suas perguntas",
        desc: "De 2 a 4 perguntas de múltipla escolha sobre você. Dê quatro alternativas a cada uma e marque a resposta certa.",
      },
      {
        title: "Responda às de outra pessoa",
        desc: "Abra um perfil e percorra as perguntas que aquela pessoa escreveu. Leia com atenção: um erro encerra a tentativa.",
      },
      {
        title: "Acerte todas e combine",
        desc: "Um conjunto perfeito abre a conversa. É essa a única condição para dar match no Qulo.",
      },
    ],
  },
  it: {
    heroTitle: "App di dating a quiz: il match arriva dalle risposte",
    heroSub:
      "Invece di scorrere una foto, rispondi alle domande che una persona ha scritto su di sé. Se le indovini tutte, è match.",
    problemTitle: "Perché una fotografia è poco su cui decidere",
    problemParagraphs: [
      "Le app di incontri basate sullo swipe ti chiedono di decidere su una persona guardando una foto e una o due righe di testo. Tutto il progetto punta sulla velocità: il mazzo è fatto perché tu possa attraversare centinaia di profili in una sera. Quello che non può darti è proprio ciò che vorresti sapere di chi sta dietro l'immagine.",
      "Così la fatica va a smistare volti, non a conoscere qualcuno. Una sessione lunga finisce con una lista di match e nemmeno una conversazione che valga la pena, perché in nessun momento il meccanismo ha chiesto a uno dei due di dire qualcosa di vero. È questo che le persone chiamano esaurimento: non poca scelta, ma troppa e nulla su cui basarla.",
      "Un'app di dating a quiz sposta il primo filtro. Su Qulo ogni profilo porta da 2 a 4 domande a risposta multipla che la persona ha scritto su di sé, fino a 10 con un piano a pagamento: quattro opzioni ciascuna, una sola vera. Quelle domande non si scorrono, si risolvono, ed è l'averle indovinate tutte a creare il match.",
    ],
    solutionTitle: "Come funziona invece Qulo",
    solutionBullets: [
      {
        title: "Domande che scrivi tu",
        desc: "Da 2 a 4 domande a risposta multipla — fino a 10 con un piano a pagamento —, quattro opzioni ciascuna, e sei tu a segnare quella vera su di te.",
      },
      {
        title: "Tutte giuste, o niente match",
        desc: "Non esistono punteggi parziali, percentuali o classifiche. Ti raggiunge chi indovina ogni singola domanda.",
      },
      {
        title: "Impegno al posto della velocità",
        desc: "Una serie di domande richiede minuti e non un istante: chi arriva in fondo ha davvero letto quello che hai scritto.",
      },
      {
        title: "Gli aiuti sono facoltativi",
        desc: "Per chi si blocca su una domanda esistono aiuti a pagamento. Non servono a nessuno: una serie intera si può risolvere, e il match ottenere, senza spendere nulla.",
      },
    ],
    steps: [
      {
        title: "Scrivi le tue domande",
        desc: "Da 2 a 4 domande a risposta multipla su di te. Dai quattro opzioni a ognuna e segna la risposta corretta.",
      },
      {
        title: "Rispondi a quelle di un altro",
        desc: "Apri un profilo e affronta le domande che quella persona ha scritto. Leggi bene: un errore chiude il tentativo.",
      },
      {
        title: "Indovinale tutte e fai match",
        desc: "Una serie senza errori apre la conversazione. Su Qulo la condizione per il match è tutta qui.",
      },
    ],
  },
  ja: {
    heroTitle: "クイズ型デーティングアプリ：質問に答えてマッチする",
    heroSub:
      "写真をスワイプして流す代わりに、相手が自分について書いた質問に答えます。全問正解すればマッチです。",
    problemTitle: "写真一枚では判断材料が少なすぎる",
    problemParagraphs: [
      "スワイプ型のデーティングアプリは、一枚の写真と一、二行の文章だけで人を判断するよう求めます。設計の中心にあるのは速さで、一晩に何百ものプロフィールをめくれるようにカードの山が作られています。その代わり、写真の向こうにいる人について本当に知りたいことは何ひとつ渡してくれません。",
      "こうして労力は、人と出会うことではなく顔をより分けることに使われます。長い時間をかけても残るのはマッチの一覧だけで、続けたいと思える会話はひとつもない。どの段階でも、二人のどちらかに本当のことを言わせる仕組みがなかったからです。人が疲れたと言うのはこの状態のことで、選択肢が少ないのではなく、多すぎるうえに選ぶ手がかりがないのです。",
      "クイズ型デーティングアプリは、最初のふるいの位置を変えます。Quloではどのプロフィールにも、その人が自分について書いた2〜4問（有料プランなら最大10問）の選択式の質問があります。選択肢は各4つで、正解はひとつ。この質問はスワイプするものではなく、答えるものです。そしてすべてに正解することが、そのままマッチになります。",
    ],
    solutionTitle: "Quloはその代わりにこう動く",
    solutionBullets: [
      {
        title: "質問は自分で書く",
        desc: "自分についての選択式の質問を2〜4問（有料プランなら最大10問）。それぞれに選択肢を4つ用意し、本当のものに印をつけます。",
      },
      {
        title: "全問正解か、マッチなしか",
        desc: "部分点も、パーセンテージも、順位もありません。あなたに届くのは、すべての質問に正解した人だけです。",
      },
      {
        title: "速さではなく手間",
        desc: "ひと組の質問を解くには一瞬ではなく数分かかります。つまり最後まで来た人は、あなたの書いたものを実際に読んでいます。",
      },
      {
        title: "ヒントは任意",
        desc: "質問で行き詰まった人のために有料のヒントがあります。必要ではありません。一円も使わずに全問を解き、マッチすることができます。",
      },
    ],
    steps: [
      {
        title: "自分の質問を書く",
        desc: "自分についての選択式の質問を2〜4問つくります。それぞれに選択肢を4つ与え、正解に印をつけます。",
      },
      {
        title: "相手の質問に答える",
        desc: "プロフィールを開き、その人が書いた質問を順に解きます。よく読んでください。一問でも間違えるとそこで終わりです。",
      },
      {
        title: "全問正解してマッチ",
        desc: "誤りのない一組が会話を開きます。Quloでマッチする条件はそれだけです。",
      },
    ],
  },
  ko: {
    heroTitle: "퀴즈형 데이팅 앱: 질문에 답해서 매칭되는 방식",
    heroSub:
      "사진을 밀어 넘기는 대신, 상대가 자신에 대해 쓴 질문에 답합니다. 모두 맞히면 매칭됩니다.",
    problemTitle: "사진 한 장으로 결정하기에는 근거가 너무 적다",
    problemParagraphs: [
      "스와이프 방식의 데이팅 앱은 사진 한 장과 한두 줄의 소개만 보고 사람을 판단하라고 합니다. 설계 전체가 속도를 위한 것이라, 하룻밤에 수백 개의 프로필을 넘길 수 있도록 카드 더미가 만들어져 있습니다. 다만 사진 뒤에 있는 사람에 대해 정작 알고 싶은 것은 하나도 알려 주지 못합니다.",
      "그래서 힘은 누군가를 만나는 데가 아니라 얼굴을 골라내는 데 쓰입니다. 오래 붙잡고 있어도 남는 것은 매칭 목록뿐이고, 이어 가고 싶은 대화는 하나도 없습니다. 어느 단계에서도 둘 중 누구에게든 진짜 이야기를 하게 만드는 장치가 없었기 때문입니다. 사람들이 지쳤다고 말하는 상태가 바로 이것입니다. 선택지가 부족한 게 아니라 너무 많고, 고를 근거가 없는 것입니다.",
      "퀴즈형 데이팅 앱은 첫 번째 거름망의 자리를 옮깁니다. Qulo에서는 모든 프로필에 그 사람이 자신에 대해 쓴 2~4개(유료 플랜은 최대 10개)의 객관식 질문이 있습니다. 보기는 각각 네 개이고 정답은 하나입니다. 이 질문은 밀어 넘기는 것이 아니라 푸는 것이며, 전부 맞히는 일이 곧 매칭입니다.",
    ],
    solutionTitle: "Qulo는 대신 이렇게 작동합니다",
    solutionBullets: [
      {
        title: "질문은 직접 씁니다",
        desc: "나에 대한 객관식 질문 2~4개, 유료 플랜에서는 최대 10개. 각 질문에 보기를 네 개 두고, 실제로 맞는 것을 정답으로 표시합니다.",
      },
      {
        title: "전부 정답이거나, 매칭 없음",
        desc: "부분 점수도, 백분율도, 순위도 없습니다. 모든 질문을 맞힌 사람만 나에게 닿습니다.",
      },
      {
        title: "속도가 아니라 공",
        desc: "질문 한 세트를 푸는 데는 순간이 아니라 몇 분이 걸립니다. 끝까지 온 사람은 내가 쓴 것을 실제로 읽었다는 뜻입니다.",
      },
      {
        title: "힌트는 선택 사항",
        desc: "질문에서 막힌 사람을 위한 유료 힌트가 있습니다. 꼭 필요하지는 않습니다. 한 푼도 쓰지 않고 한 세트를 다 풀어 매칭될 수 있습니다.",
      },
    ],
    steps: [
      {
        title: "내 질문을 쓴다",
        desc: "나에 대한 객관식 질문을 2~4개 만듭니다. 각각 보기를 네 개 주고 정답을 표시합니다.",
      },
      {
        title: "상대의 질문을 푼다",
        desc: "프로필을 열고 그 사람이 쓴 질문을 차례로 풉니다. 꼼꼼히 읽으세요. 하나만 틀려도 시도는 거기서 끝납니다.",
      },
      {
        title: "모두 맞히고 매칭된다",
        desc: "빈틈없는 한 세트가 대화를 엽니다. Qulo에서 매칭의 조건은 그것뿐입니다.",
      },
    ],
  },
  zh: {
    heroTitle: "答题式交友应用：靠答对题来配对",
    heroSub:
      "你不再滑动照片，而是回答对方为自己写下的问题。全部答对，就是配对。",
    problemTitle: "一张照片能提供的判断依据太少",
    problemParagraphs: [
      "滑动式交友应用要你凭一张照片和一两行文字对一个人下判断。整套设计都是为了速度：卡片堆的存在，就是让你一晚上翻完几百份资料。它唯独给不了你真正想知道的东西——照片背后的那个人究竟是什么样。",
      "于是力气都花在筛脸上，而不是认识人。一场长时间的翻找结束后，你手里只有一串配对，却没有一段值得继续的对话，因为整个流程从未要求你们中的任何一方说点真实的东西。人们所说的倦怠正是这种状态：不是选择太少，而是选择太多，却没有可依据的东西。",
      "答题式交友应用把第一道筛子换了位置。在 Qulo，每份资料都带着本人为自己写下的 2 到 4 道选择题（付费方案最多 10 道），每题四个选项，其中一个是真的。这些题目不是用来滑走的，而是用来回答的；全部答对，配对就成立。",
    ],
    solutionTitle: "Qulo 用的是另一套做法",
    solutionBullets: [
      {
        title: "题目由你自己出",
        desc: "关于你的选择题 2 到 4 道，付费方案最多 10 道，每道四个选项，由你标出符合自己的那一个。",
      },
      {
        title: "全对，否则不配对",
        desc: "没有部分得分，没有百分比，也没有排名。能走到你面前的，是把每一道题都答对的人。",
      },
      {
        title: "用心力代替速度",
        desc: "做完一组题需要几分钟而不是一瞬间，所以走到最后的人，确实读过你写的内容。",
      },
      {
        title: "提示是可选的",
        desc: "有付费提示，给卡在某道题上的人。它并非必需：一组题可以完整答完并配对成功，一分钱也不用花。",
      },
    ],
    steps: [
      {
        title: "写下你的题目",
        desc: "关于自己的选择题 2 到 4 道。每道给出四个选项，并标出正确答案。",
      },
      {
        title: "去答别人的题",
        desc: "打开一份资料，逐题回答那个人写下的问题。仔细读——错一道，这次尝试就结束了。",
      },
      {
        title: "全部答对即配对",
        desc: "一组无误的答案打开对话。这就是在 Qulo 配对的全部条件。",
      },
    ],
  },
  nl: {
    heroTitle: "Quiz-datingapp: matchen door vragen te beantwoorden",
    heroSub:
      "In plaats van een foto weg te swipen beantwoord je de vragen die iemand over zichzelf schreef. Alles goed, en je hebt een match.",
    problemTitle: "Waarom een foto weinig houvast geeft",
    problemParagraphs: [
      "Datingapps die op swipen draaien vragen je om over een mens te beslissen op basis van één foto en een of twee regels tekst. Snelheid is het hele ontwerp: de stapel is zo gebouwd dat je op een avond honderden profielen doorkomt. Wat hij je niet kan geven, is precies datgene wat je over de persoon achter de foto zou willen weten.",
      "De moeite gaat dus naar het sorteren van gezichten in plaats van naar het ontmoeten van iemand. Een lange sessie eindigt met een lijst matches en geen enkel gesprek dat de moeite waard is, want nergens in het proces werd van een van jullie gevraagd iets echts te zeggen. Dat is wat mensen uitputting noemen: niet te weinig keuze, maar veel te veel keuze en niets om op te kiezen.",
      "Een quiz-datingapp verplaatst de eerste filter. Op Qulo draagt elk profiel 2 tot 4 meerkeuzevragen die het lid zelf over zich schreef, tot 10 met een betaald abonnement — vier opties per vraag, waarvan er één klopt. Die vragen swipe je niet weg. Je beantwoordt ze, en ze allemaal goed hebben is wat de match maakt.",
    ],
    solutionTitle: "Hoe Qulo het in plaats daarvan doet",
    solutionBullets: [
      {
        title: "Vragen die je zelf schrijft",
        desc: "2 tot 4 meerkeuzevragen — tot 10 met een betaald abonnement —, vier opties per stuk, en jij markeert de optie die over jou klopt.",
      },
      {
        title: "Alles goed, of geen match",
        desc: "Er is geen deelscore, geen percentage en geen ranglijst. Bij jou komt wie elke vraag goed heeft.",
      },
      {
        title: "Moeite in plaats van snelheid",
        desc: "Een set vragen kost minuten en geen moment, dus wie er doorheen komt heeft echt gelezen wat je schreef.",
      },
      {
        title: "Hints zijn optioneel",
        desc: "Er bestaan betaalde hints voor wie op een vraag vastloopt. Niemand heeft ze nodig: een hele set is op te lossen, en een match te maken, zonder iets uit te geven.",
      },
    ],
    steps: [
      {
        title: "Schrijf je vragen",
        desc: "2 tot 4 meerkeuzevragen over jezelf. Geef er vier opties bij en markeer het juiste antwoord.",
      },
      {
        title: "Beantwoord die van een ander",
        desc: "Open een profiel en werk de vragen door die diegene schreef. Lees goed — één fout antwoord beëindigt de poging.",
      },
      {
        title: "Alles goed en je matcht",
        desc: "Een foutloze set opent het gesprek. Meer is er voor een match op Qulo niet nodig.",
      },
    ],
  },
  pl: {
    heroTitle: "Randkowa aplikacja z quizem: dopasowanie przez odpowiedzi",
    heroSub:
      "Zamiast przesuwać zdjęcie, odpowiadasz na pytania, które ktoś napisał o sobie. Wszystkie trafione — jest dopasowanie.",
    problemTitle: "Dlaczego zdjęcie to za mało, żeby zdecydować",
    problemParagraphs: [
      "Aplikacje randkowe oparte na przesuwaniu każą ci rozstrzygnąć o człowieku na podstawie zdjęcia i dwóch linijek tekstu. Cały projekt jest o szybkości: talia powstała po to, żebyś w jeden wieczór przewinął setki profili. Nie potrafi za to dać ci niczego, co naprawdę chciałbyś wiedzieć o osobie stojącej za zdjęciem.",
      "Wysiłek idzie więc w sortowanie twarzy, a nie w poznawanie kogokolwiek. Długi wieczór kończy się listą dopasowań i ani jedną rozmową wartą kontynuowania, bo na żadnym etapie mechanizm nie kazał żadnemu z was powiedzieć czegoś prawdziwego. To właśnie ludzie nazywają wypaleniem: nie brak wyboru, ale jego nadmiar i brak czegokolwiek, na czym można by ten wybór oprzeć.",
      "Aplikacja z quizem przenosi pierwsze sito gdzie indziej. W Qulo każdy profil ma od 2 do 4 pytań wielokrotnego wyboru, które ta osoba napisała o sobie, a w planie płatnym do 10 — po cztery odpowiedzi w każdym, jedna prawdziwa. Tych pytań się nie przesuwa, tylko na nie odpowiada, a trafienie wszystkich to właśnie dopasowanie.",
    ],
    solutionTitle: "Jak zamiast tego działa Qulo",
    solutionBullets: [
      {
        title: "Pytania, które piszesz sam",
        desc: "Od 2 do 4 pytań wielokrotnego wyboru — do 10 w planie płatnym — po cztery odpowiedzi w każdym, a prawdziwą zaznaczasz ty.",
      },
      {
        title: "Komplet albo nic",
        desc: "Nie ma punktów częściowych, procentów ani rankingu. Dociera do ciebie ten, kto trafi każde pytanie.",
      },
      {
        title: "Wysiłek zamiast tempa",
        desc: "Zestaw pytań zajmuje minuty, a nie chwilę — kto przez niego przejdzie, naprawdę przeczytał to, co napisałeś.",
      },
      {
        title: "Podpowiedzi są opcjonalne",
        desc: "Dla tych, którzy utkną na pytaniu, są płatne podpowiedzi. Nikt ich nie potrzebuje: cały zestaw da się rozwiązać i dopasować bez wydawania złotówki.",
      },
    ],
    steps: [
      {
        title: "Napisz swoje pytania",
        desc: "Od 2 do 4 pytań wielokrotnego wyboru o sobie. Daj każdemu cztery odpowiedzi i zaznacz poprawną.",
      },
      {
        title: "Odpowiedz na cudze",
        desc: "Otwórz profil i przejdź pytania, które napisała ta osoba. Czytaj uważnie — jedna pomyłka kończy próbę.",
      },
      {
        title: "Trafisz wszystkie, jest dopasowanie",
        desc: "Bezbłędny zestaw otwiera rozmowę. Na tym kończy się cały warunek dopasowania w Qulo.",
      },
    ],
  },
  sv: {
    heroTitle: "Quiz-dejtingapp: matcha genom att svara rätt",
    heroSub:
      "I stället för att svepa förbi ett foto svarar du på frågorna någon skrivit om sig själv. Alla rätt, och ni matchar.",
    problemTitle: "Varför ett foto är tunt beslutsunderlag",
    problemParagraphs: [
      "Dejtingappar byggda på svep ber dig avgöra en människa utifrån ett foto och ett par rader text. Hela konstruktionen handlar om tempo: kortleken finns för att du ska hinna igenom hundratals profiler på en kväll. Det den inte kan ge dig är någonting du faktiskt skulle vilja veta om personen bakom bilden.",
      "Kraften går alltså åt till att sortera ansikten i stället för att möta någon. En lång session slutar med en lista matchningar och inte ett enda samtal värt att fortsätta, eftersom processen aldrig bad någon av er att säga något på riktigt. Det är detta folk kallar utmattning: inte för lite val, utan alldeles för mycket och ingenting att välja på.",
      "En quiz-dejtingapp flyttar det första filtret. På Qulo bär varje profil 2 till 4 flervalsfrågor som personen själv skrivit om sig, upp till 10 med ett betalt abonnemang — fyra alternativ var, ett av dem sant. De frågorna sveper man inte förbi. Man svarar på dem, och att ha alla rätt är det som skapar matchningen.",
    ],
    solutionTitle: "Så gör Qulo i stället",
    solutionBullets: [
      {
        title: "Frågor du skriver själv",
        desc: "2 till 4 flervalsfrågor — upp till 10 med ett betalt abonnemang — med fyra alternativ vardera, och du markerar det som stämmer om dig.",
      },
      {
        title: "Alla rätt, annars ingen matchning",
        desc: "Det finns inga delpoäng, ingen procentsats och ingen rangordning. Fram till dig kommer den som har varje fråga rätt.",
      },
      {
        title: "Möda i stället för fart",
        desc: "En omgång frågor tar minuter och inte ett ögonblick, så den som tar sig igenom har verkligen läst det du skrivit.",
      },
      {
        title: "Ledtrådar är frivilliga",
        desc: "Det finns betalda ledtrådar för den som kör fast på en fråga. Ingen behöver dem: en hel omgång går att lösa, och en matchning att få, utan att lägga en krona.",
      },
    ],
    steps: [
      {
        title: "Skriv dina frågor",
        desc: "2 till 4 flervalsfrågor om dig själv. Ge var och en fyra alternativ och markera det rätta svaret.",
      },
      {
        title: "Svara på någon annans",
        desc: "Öppna en profil och ta dig igenom frågorna den personen skrivit. Läs noga — ett fel svar avslutar försöket.",
      },
      {
        title: "Alla rätt, och ni matchar",
        desc: "En felfri omgång öppnar samtalet. Mer krävs inte för en matchning på Qulo.",
      },
    ],
  },
  hi: {
    heroTitle: "क्विज़ डेटिंग ऐप: सवालों के सही जवाब से मैच",
    heroSub:
      "तस्वीर को स्वाइप करके आगे बढ़ने के बजाय आप वे सवाल हल करते हैं जो सामने वाले ने अपने बारे में लिखे हैं। सब सही, तो मैच।",
    problemTitle: "एक तस्वीर फ़ैसला करने के लिए क्यों काफ़ी नहीं",
    problemParagraphs: [
      "स्वाइप पर चलने वाले डेटिंग ऐप आपसे कहते हैं कि एक तस्वीर और एक-दो पंक्तियों से किसी इंसान के बारे में तय कर लीजिए। पूरा ढाँचा रफ़्तार के लिए बना है: कार्डों का ढेर इसलिए है कि आप एक शाम में सैकड़ों प्रोफ़ाइल पार कर जाएँ। जो वह नहीं दे सकता, वह ठीक वही है जो आप तस्वीर के पीछे बैठे इंसान के बारे में सचमुच जानना चाहेंगे।",
      "इसलिए मेहनत किसी से मिलने में नहीं, चेहरे छाँटने में लगती है। लंबी बैठक के बाद हाथ में मैचों की एक सूची होती है और एक भी बातचीत नहीं जिसे आगे बढ़ाया जाए, क्योंकि इस प्रक्रिया ने कभी आप दोनों में से किसी से कुछ असली कहने को नहीं कहा। लोग जिसे थकान कहते हैं, वह यही है: विकल्पों की कमी नहीं, बल्कि उनकी भरमार और चुनने के लिए कोई आधार न होना।",
      "क्विज़ डेटिंग ऐप पहली छलनी की जगह बदल देता है। Qulo पर हर प्रोफ़ाइल में उस व्यक्ति के अपने लिखे 2 से 4 बहुविकल्पीय सवाल होते हैं, भुगतान वाली योजना में 10 तक — हर सवाल में चार विकल्प, जिनमें एक सही। इन सवालों को स्वाइप नहीं किया जाता, हल किया जाता है; और सबका सही जवाब देना ही मैच बनाता है।",
    ],
    solutionTitle: "Qulo इसकी जगह कैसे काम करता है",
    solutionBullets: [
      {
        title: "सवाल आप ख़ुद लिखते हैं",
        desc: "अपने बारे में 2 से 4 बहुविकल्पीय सवाल — भुगतान वाली योजना में 10 तक — हर एक में चार विकल्प, और सही विकल्प आप ख़ुद चुनते हैं।",
      },
      {
        title: "सब सही, वरना मैच नहीं",
        desc: "न आंशिक अंक, न प्रतिशत, न कोई रैंकिंग। आप तक वही पहुँचता है जो हर सवाल सही करे।",
      },
      {
        title: "रफ़्तार नहीं, मेहनत",
        desc: "एक सेट हल करने में पल नहीं, कुछ मिनट लगते हैं — यानी जो अंत तक पहुँचा, उसने आपका लिखा सचमुच पढ़ा है।",
      },
      {
        title: "संकेत लेना मर्ज़ी की बात है",
        desc: "किसी सवाल पर अटकने वालों के लिए सशुल्क संकेत मौजूद हैं। ज़रूरी वे किसी के लिए नहीं: पूरा सेट बिना एक पैसा ख़र्च किए हल करके मैच किया जा सकता है।",
      },
    ],
    steps: [
      {
        title: "अपने सवाल लिखिए",
        desc: "अपने बारे में 2 से 4 बहुविकल्पीय सवाल बनाइए। हर एक को चार विकल्प दीजिए और सही जवाब चिह्नित कीजिए।",
      },
      {
        title: "किसी और के सवाल हल कीजिए",
        desc: "कोई प्रोफ़ाइल खोलिए और उस व्यक्ति के लिखे सवाल एक-एक कर हल कीजिए। ध्यान से पढ़िए — एक ग़लत जवाब कोशिश ख़त्म कर देता है।",
      },
      {
        title: "सब सही कीजिए और मैच पाइए",
        desc: "बिना ग़लती वाला सेट बातचीत खोल देता है। Qulo पर मैच की शर्त बस इतनी है।",
      },
    ],
  },
};
