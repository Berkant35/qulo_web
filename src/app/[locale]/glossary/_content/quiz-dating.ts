import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Quiz dating — matching by answering questions rather than by judging photos.
 *
 * This is the term Qulo itself sits under, so it is the one page where an
 * overstated claim would do the most damage. JUDGEMENT CALLS:
 *
 * - The legacy copy called Qulo "the pioneer of the quiz dating concept". That
 *   claim is REMOVED and must not come back: it is unverifiable, and block 1
 *   contradicts it outright by dating question-based matching to punched-card
 *   computer dating in the 1960s. Block 7 says in every locale that Qulo is one
 *   app built this way, "not the first and not the only one". Deleting that
 *   qualifier would reinstate exactly the claim this file was written to drop.
 * - Blocks 0 to 6 describe the APPROACH, with no product in them. Qulo appears
 *   only in block 7, as one implementation. Keep that order.
 * - Mechanics stated are the real ones: 2 to 4 multiple-choice questions on a
 *   free account and up to 10 on a paid plan (10 is the Premium cap, never the
 *   figure to quote on its own), four options each, the author marks the
 *   correct answer, a solver matches only on a clean sweep, and paid hints
 *   exist. Nothing else may be added — there is no
 *   ID verification, no photo screening, no fake-profile detection and no
 *   moderation team, so block 7 closes by saying the questions verify nobody's
 *   identity, only their attention. That sentence is load-bearing.
 * - No external figure is cited here. The burnout survey fits the `match` and
 *   `swipe-fatigue` pages better than this one, and rule 2 says cite in full or
 *   not at all — "fatigue" in block 2 is therefore written as a motivation, not
 *   as a statistic.
 *
 * TERM NAMES: there is no settled loanword for this concept in most languages,
 * so each locale gets a plain descriptive phrase in its own words rather than a
 * forced calque of the English. de and ja/ko/zh compound naturally and do so.
 */
export const quizDating: LocalizedGlossaryEntry = {
  en: {
    term: "Quiz dating",
    summary:
      "A way of meeting people online where the first filter is a set of questions you have to answer correctly, rather than photos you scroll past. Access to a conversation is earned by paying attention instead of by being picked.",
    blocks: [
      { type: "h2", text: "Where the idea comes from" },
      { type: "p", text: "Matching by question is older than the smartphone. Computer dating in the 1960s ran on punched-card questionnaires, and personality quizzes have been bolted onto dating services ever since. What changed is what the questions are for. In the older model, a service collected your answers and sorted you into a pool. In the newer one, the questions are written by the person you are trying to reach, and answering them is how you reach them." },
      { type: "p", text: "The pull now is fatigue. Deciding on faces is fast, endless and oddly tiring, and a question interrupts that loop by asking something of whoever wants your attention. It costs a few seconds and a little thought. That small cost is the whole point: it filters for effort, which a photograph cannot do." },
      { type: "h2", text: "What it looks like in practice" },
      { type: "ul", items: [
        "The first thing on a profile is something to answer, not only something to look at.",
        "The message box opens after the answers, not before them.",
        "The questions were written by a person rather than picked from a template, so they say something either way.",
        "A wrong answer costs you the opening, which is what makes getting in worth anything.",
      ] },
      { type: "h2", accent: "green", text: "How to write questions worth answering" },
      { type: "p", text: "Good ones sit between obvious and impossible. If anyone could guess it, it filters nothing; if only your sister would know it, nobody gets through. Aim for something a person who actually read your profile would land on. Concrete beats clever: a real habit, a real opinion, a real preference. And write questions you would enjoy being asked back, because the answers are the first thing you will end up talking about." },
      { type: "p", text: "Qulo is one app built this way — not the first and not the only one. You write between 2 and 4 multiple-choice questions with four options each — up to 10 on a paid plan — and mark the correct answer; someone reaches you only by getting every one of them right, and paid hints exist for solvers who get stuck. None of that verifies who anyone is. It shows they read what you wrote." },
    ],
  },
  tr: {
    term: "Soru tabanlı tanışma",
    summary:
      "İnsanlarla internette tanışmanın, ilk filtresi kaydırılıp geçilen fotoğraflar değil doğru cevaplanması gereken sorular olan biçimi. Sohbete erişim beğenilerek değil, dikkat gösterilerek kazanılır.",
    blocks: [
      { type: "h2", text: "Fikir nereden geliyor" },
      { type: "p", text: "Soruyla eşleşme akıllı telefondan eski. 1960'ların bilgisayarlı tanıştırma servisleri delikli kartlara basılmış anketlerle çalışıyordu ve o günden beri tanışma servislerine kişilik testleri iliştirilip duruyor. Değişen şey, soruların ne işe yaradığı. Eski modelde servis cevaplarınızı toplar ve sizi bir havuza yerleştirirdi. Yeni modelde soruları ulaşmaya çalıştığınız kişi yazıyor ve o kişiye ulaşmanın yolu onları cevaplamak." },
      { type: "p", text: "Bugün çeken şey yorgunluk. Yüzlere karar vermek hızlı, sonsuz ve tuhaf biçimde yorucudur; bir soru ise dikkatinizi isteyen kişiden bir şey isteyerek bu döngüyü keser. Birkaç saniyeye ve azıcık düşünmeye mal olur. Asıl mesele de o küçük bedeldir: emeğe göre eler, ki bir fotoğraf bunu yapamaz." },
      { type: "h2", text: "Pratikte neye benziyor" },
      { type: "ul", items: [
        "Profilde ilk karşınıza çıkan şey sadece bakılacak değil, cevaplanacak bir şeydir.",
        "Mesaj kutusu cevaplardan önce değil, sonra açılır.",
        "Sorular şablondan seçilmiş değil, bir insan tarafından yazılmıştır; yani her hâlükârda bir şey anlatır.",
        "Yanlış cevap açılışı kaybettirir; içeri girmeyi bir şeye değer kılan da budur.",
      ] },
      { type: "h2", accent: "green", text: "Cevaplanmaya değer soru nasıl yazılır" },
      { type: "p", text: "İyi sorular apaçık ile imkânsız arasında durur. Herkesin bilebileceği bir soru hiçbir şey elemez; yalnızca kız kardeşinizin bilebileceği bir soruysa kimseyi geçirmez. Profilinizi gerçekten okuyan birinin bulabileceği bir şeyi hedefleyin. Somut olan, zekice olandan iyidir: gerçek bir alışkanlık, gerçek bir fikir, gerçek bir tercih. Ve size de sorulmasından hoşlanacağınız sorular yazın; çünkü ilk konuşacağınız şey o cevaplar olacak." },
      { type: "p", text: "Qulo bu şekilde kurulmuş uygulamalardan biri — ilki değil, tek örneği de değil. Her biri dört şıklı 2 ila 4 çoktan seçmeli soru yazar ve doğru şıkkı işaretlersiniz — ücretli planda 10 soruya kadar; karşınızdaki size ancak hepsini doğru bilerek ulaşır ve takılan çözücüler için ücretli ipuçları vardır. Bunların hiçbiri kimsenin kim olduğunu doğrulamaz. Yalnızca yazdıklarınızı okuduğunu gösterir." },
    ],
  },
  de: {
    term: "Quiz-Dating",
    summary:
      "Eine Art, sich online kennenzulernen, bei der am Anfang keine Fotos zum Durchwischen stehen, sondern Fragen, die richtig beantwortet werden müssen. Zugang zum Gespräch verdient man sich durch Aufmerksamkeit, nicht dadurch, ausgewählt zu werden.",
    blocks: [
      { type: "h2", text: "Woher die Idee kommt" },
      { type: "p", text: "Über Fragen zu matchen ist älter als das Smartphone. Die Computer-Partnervermittlung der 1960er lief über Fragebögen auf Lochkarten, und seither hängen Persönlichkeitstests an Vermittlungsdiensten. Geändert hat sich, wozu die Fragen da sind. Im alten Modell sammelte ein Dienst deine Antworten und sortierte dich in einen Pool. Im neuen schreibt die Person die Fragen, die du erreichen willst, und sie zu beantworten ist der Weg zu ihr." },
      { type: "p", text: "Der Reiz heute ist die Erschöpfung. Über Gesichter zu entscheiden geht schnell, hört nie auf und ermüdet seltsam stark. Eine Frage unterbricht diese Schleife, weil sie etwas von der Person verlangt, die deine Aufmerksamkeit möchte. Sie kostet ein paar Sekunden und etwas Nachdenken. Genau dieser kleine Preis ist der Punkt: Er filtert nach Mühe, und das kann ein Foto nicht." },
      { type: "h2", text: "Wie es in der Praxis aussieht" },
      { type: "ul", items: [
        "Das Erste im Profil ist etwas zum Beantworten, nicht nur etwas zum Anschauen.",
        "Das Nachrichtenfeld öffnet sich nach den Antworten, nicht davor.",
        "Die Fragen hat eine Person geschrieben und nicht aus einer Vorlage gewählt, also sagen sie so oder so etwas aus.",
        "Eine falsche Antwort kostet dich den Einstieg, und genau das macht das Hineinkommen überhaupt erst wertvoll.",
      ] },
      { type: "h2", accent: "green", text: "Wie man Fragen schreibt, die man gern beantwortet" },
      { type: "p", text: "Gute Fragen liegen zwischen offensichtlich und unmöglich. Was jeder erraten kann, filtert nichts; was nur deine Schwester weiß, lässt niemanden durch. Ziel ist etwas, worauf jemand kommt, der dein Profil wirklich gelesen hat. Konkret schlägt geistreich: eine echte Gewohnheit, eine echte Meinung, eine echte Vorliebe. Und schreib Fragen, die du selbst gern gestellt bekämst — über die Antworten redet ihr am Ende als Erstes." },
      { type: "p", text: "Qulo ist eine so gebaute App — nicht die erste und nicht die einzige. Du schreibst zwischen 2 und 4 Multiple-Choice-Fragen mit je vier Antwortmöglichkeiten und markierst die richtige, im kostenpflichtigen Tarif sind es bis zu 10; jemand erreicht dich nur, wenn er jede einzelne trifft, und für festgefahrene Rätselnde gibt es kostenpflichtige Hinweise. Nichts davon prüft, wer jemand ist. Es zeigt, dass gelesen wurde, was du geschrieben hast." },
    ],
  },
  fr: {
    term: "Rencontre par questions",
    summary:
      "Une manière de faire connaissance en ligne où le premier filtre n'est pas une série de photos à faire défiler mais des questions auxquelles il faut répondre juste. L'accès à la conversation se gagne par l'attention, pas en étant choisi.",
    blocks: [
      { type: "h2", text: "D'où vient l'idée" },
      { type: "p", text: "Se rencontrer par questions est plus ancien que le smartphone. Les agences informatisées des années 1960 fonctionnaient avec des questionnaires sur cartes perforées, et depuis, les tests de personnalité n'ont jamais quitté les services de rencontre. Ce qui a changé, c'est à quoi servent les questions. Dans l'ancien modèle, un service collectait vos réponses et vous rangeait dans un vivier. Dans le nouveau, les questions sont écrites par la personne que vous voulez joindre, et y répondre est précisément la façon de la joindre." },
      { type: "p", text: "Ce qui attire aujourd'hui, c'est la lassitude. Trancher sur des visages est rapide, sans fin et étrangement fatigant ; une question casse la boucle en demandant quelque chose à celui qui veut votre attention. Cela coûte quelques secondes et un peu de réflexion. Ce petit coût est tout l'intérêt : il filtre sur l'effort, ce qu'une photo ne peut pas faire." },
      { type: "h2", text: "À quoi ça ressemble concrètement" },
      { type: "ul", items: [
        "La première chose sur un profil est quelque chose à résoudre, pas seulement à regarder.",
        "La fenêtre de message s'ouvre après les réponses, pas avant.",
        "Les questions ont été écrites par quelqu'un et non piochées dans un modèle : dans tous les cas, elles disent quelque chose.",
        "Une mauvaise réponse vous coûte l'ouverture, et c'est ce qui donne de la valeur au fait d'entrer.",
      ] },
      { type: "h2", accent: "green", text: "Comment écrire des questions qui donnent envie" },
      { type: "p", text: "Les bonnes se situent entre l'évidence et l'impossible. Si n'importe qui devine, la question ne filtre rien ; si seule votre sœur connaît la réponse, personne ne passe. Visez ce que trouverait quelqu'un qui a vraiment lu votre profil. Le concret bat le malin : une habitude réelle, une opinion réelle, une préférence réelle. Et écrivez des questions que vous aimeriez qu'on vous pose, car ces réponses seront votre premier sujet de conversation." },
      { type: "p", text: "Qulo est une application construite ainsi — ni la première ni la seule. Vous écrivez de 2 à 4 questions à choix multiples, quatre réponses chacune, et vous cochez la bonne — jusqu'à 10 questions avec un abonnement payant ; on ne vous joint qu'en les trouvant toutes, et des indices payants existent pour ceux qui bloquent. Rien de tout cela ne vérifie l'identité de qui que ce soit. Cela montre qu'on a lu ce que vous avez écrit." },
    ],
  },
  es: {
    term: "Citas basadas en preguntas",
    summary:
      "Una forma de conocer gente en internet donde el primer filtro no son fotos que deslizas, sino preguntas que hay que acertar. El acceso a la conversación se gana prestando atención, no siendo elegido.",
    blocks: [
      { type: "h2", text: "De dónde viene la idea" },
      { type: "p", text: "Emparejar mediante preguntas es más antiguo que el móvil. Las agencias informatizadas de los años sesenta funcionaban con cuestionarios en tarjetas perforadas, y desde entonces los tests de personalidad no se han despegado de los servicios de citas. Lo que cambió es para qué sirven las preguntas. En el modelo antiguo, un servicio recogía tus respuestas y te colocaba en un grupo. En el nuevo, las preguntas las escribe la persona a la que quieres llegar, y responderlas es la manera de llegar hasta ella." },
      { type: "p", text: "Lo que atrae ahora es el cansancio. Decidir sobre caras es rápido, interminable y extrañamente agotador; una pregunta rompe ese bucle porque le pide algo a quien quiere tu atención. Cuesta unos segundos y algo de pensar. Ese pequeño coste es justo la gracia: filtra por esfuerzo, y eso una foto no puede hacerlo." },
      { type: "h2", text: "Cómo se ve en la práctica" },
      { type: "ul", items: [
        "Lo primero de un perfil es algo que responder, no solo algo que mirar.",
        "La caja de mensajes se abre después de las respuestas, no antes.",
        "Las preguntas las escribió una persona y no salieron de una plantilla, así que dicen algo de todos modos.",
        "Fallar te cuesta la entrada, y eso es lo que hace que entrar valga algo.",
      ] },
      { type: "h2", accent: "green", text: "Cómo escribir preguntas que merezca la pena responder" },
      { type: "p", text: "Las buenas quedan entre lo obvio y lo imposible. Si la acierta cualquiera, no filtra nada; si solo la sabe tu hermana, no pasa nadie. Apunta a algo que sacaría alguien que leyó de verdad tu perfil. Lo concreto gana a lo ingenioso: una costumbre real, una opinión real, una preferencia real. Y escribe preguntas que te gustaría que te hicieran, porque esas respuestas serán lo primero de lo que acabaréis hablando." },
      { type: "p", text: "Qulo es una app construida así: ni la primera ni la única. Escribes entre 2 y 4 preguntas de opción múltiple con cuatro opciones cada una y marcas la correcta — hasta 10 con un plan de pago; alguien llega hasta ti solo si las acierta todas, y hay pistas de pago para quien se atasca. Nada de eso verifica quién es nadie. Muestra que ha leído lo que escribiste." },
    ],
  },
  ar: {
    term: "المواعدة بالأسئلة",
    summary:
      "طريقة للتعارف عبر الإنترنت يكون فيها الفلتر الأول أسئلة يجب الإجابة عنها إجابة صحيحة، لا صورًا تُمرَّر بالإبهام. الوصول إلى المحادثة يُكتسب بالانتباه لا بأن يقع عليك الاختيار.",
    blocks: [
      { type: "h2", text: "من أين جاءت الفكرة" },
      { type: "p", text: "المطابقة عبر الأسئلة أقدم من الهاتف الذكي. كانت خدمات التعارف الحاسوبية في الستينيات تعمل باستبيانات على بطاقات مثقوبة، ومنذ ذلك الحين لم تفارق اختبارات الشخصية خدمات التعارف. ما تغيّر هو الغرض من الأسئلة. في النموذج القديم كانت الخدمة تجمع إجاباتك وتضعك في مجموعة. في النموذج الأحدث، يكتب الأسئلةَ الشخصُ الذي تحاول الوصول إليه، والإجابة عنها هي طريقك إليه." },
      { type: "p", text: "ما يجذب اليوم هو الإرهاق. الحكم على الوجوه سريع ولا ينتهي ومتعب بشكل غريب، والسؤال يقطع هذه الحلقة لأنه يطلب شيئًا ممن يريد انتباهك. يكلّف ثوانٍ قليلة وقليلًا من التفكير. هذه الكلفة الصغيرة هي المقصد كله: إنها تُصفّي على أساس الجهد، وهو ما لا تقدر عليه صورة." },
      { type: "h2", text: "كيف يبدو الأمر عمليًا" },
      { type: "ul", items: [
        "أول ما تجده في الملف شيء يُجاب عنه، لا شيء يُنظر إليه فقط.",
        "صندوق الرسائل يُفتح بعد الإجابات لا قبلها.",
        "الأسئلة كتبها إنسان ولم تُختَر من قالب جاهز، لذا فهي تقول شيئًا في الحالتين.",
        "الإجابة الخاطئة تكلّفك الدخول، وهذا بالضبط ما يجعل الدخول ذا قيمة.",
      ] },
      { type: "h2", accent: "green", text: "كيف تكتب أسئلة تستحق الإجابة" },
      { type: "p", text: "الأسئلة الجيدة تقع بين البديهي والمستحيل. ما يخمّنه أي أحد لا يُصفّي شيئًا، وما لا تعرفه إلا أختك لا يمرّ منه أحد. استهدف ما يصل إليه من قرأ ملفك فعلًا. الملموس أفضل من الذكي: عادة حقيقية، رأي حقيقي، تفضيل حقيقي. واكتب أسئلة يسعدك أن تُسأل مثلها، لأن تلك الإجابات ستكون أول ما تتحدثان عنه." },
      { type: "p", text: "Qulo تطبيق مبني على هذا النحو — ليس الأول ولا الوحيد. تكتب بين سؤالين و4 أسئلة اختيار من متعدد — وحتى 10 أسئلة في الخطة المدفوعة — لكل سؤال أربعة خيارات، وتحدد الإجابة الصحيحة؛ ولا يصل إليك أحد إلا بإصابتها كلها، وهناك تلميحات مدفوعة لمن يتعثر. لا شيء من ذلك يتحقق من هوية أحد. إنه يُظهر فقط أنه قرأ ما كتبته." },
    ],
  },
  ru: {
    term: "Знакомства по вопросам",
    summary:
      "Способ знакомиться в интернете, где первый фильтр — не фотографии, которые пролистывают, а вопросы, на которые нужно ответить правильно. Доступ к разговору зарабатывают вниманием, а не тем, что тебя выбрали.",
    blocks: [
      { type: "h2", text: "Откуда взялась идея" },
      { type: "p", text: "Подбор по вопросам старше смартфона. Компьютерные службы знакомств 1960-х работали на анкетах с перфокартами, и с тех пор тесты личности так и остались приделаны к сервисам знакомств. Изменилось то, зачем нужны вопросы. В старой модели сервис собирал ваши ответы и определял вас в общий пул. В новой вопросы пишет тот человек, до которого вы хотите добраться, и ответить на них — и есть способ до него добраться." },
      { type: "p", text: "Сегодня к этому тянет от усталости. Решать по лицам быстро, бесконечно и странным образом утомительно, а вопрос разрывает этот круг, потому что требует чего-то от того, кому нужно ваше внимание. Он стоит нескольких секунд и небольшого раздумья. В этой маленькой цене весь смысл: она отбирает по усилию, чего фотография не умеет." },
      { type: "h2", text: "Как это выглядит на практике" },
      { type: "ul", items: [
        "Первое в анкете — то, на что нужно ответить, а не только то, на что нужно посмотреть.",
        "Поле для сообщения открывается после ответов, а не до них.",
        "Вопросы написал человек, а не выбрал из шаблона, так что они всё равно о чём-то говорят.",
        "Неверный ответ стоит вам входа, и именно поэтому вход вообще чего-то стоит.",
      ] },
      { type: "h2", accent: "green", text: "Как писать вопросы, на которые хочется ответить" },
      { type: "p", text: "Хорошие лежат между очевидным и невозможным. Если угадает любой, вопрос ничего не отсеивает; если знает только ваша сестра, не пройдёт никто. Целитесь в то, до чего дойдёт человек, действительно прочитавший вашу анкету. Конкретное лучше остроумного: настоящая привычка, настоящее мнение, настоящее предпочтение. И пишите вопросы, которые вам самим приятно было бы получить, — с этих ответов начнётся разговор." },
      { type: "p", text: "Qulo — одно из приложений, устроенных так, не первое и не единственное. Вы пишете от 2 до 4 вопросов с четырьмя вариантами ответа и отмечаете правильный, на платном тарифе — до 10; до вас доберутся, только ответив верно на все, а для застрявших есть платные подсказки. Ничто из этого не подтверждает, кто человек такой. Это показывает, что он прочитал написанное вами." },
    ],
  },
  pt: {
    term: "Encontros por perguntas",
    summary:
      "Um jeito de conhecer gente na internet em que o primeiro filtro não são fotos que você desliza, mas perguntas que precisa acertar. O acesso à conversa se ganha prestando atenção, não sendo escolhido.",
    blocks: [
      { type: "h2", text: "De onde vem a ideia" },
      { type: "p", text: "Combinar por perguntas é mais antigo que o smartphone. Os serviços de namoro computadorizados dos anos 1960 funcionavam com questionários em cartões perfurados, e desde então os testes de personalidade nunca saíram de perto. O que mudou foi para que servem as perguntas. No modelo antigo, o serviço juntava suas respostas e o encaixava num grupo. No mais recente, as perguntas são escritas pela pessoa que você quer alcançar, e respondê-las é o jeito de chegar até ela." },
      { type: "p", text: "O que atrai agora é o cansaço. Decidir por rostos é rápido, interminável e estranhamente exaustivo; uma pergunta corta esse ciclo porque cobra algo de quem quer sua atenção. Custa alguns segundos e um pouco de reflexão. Esse custo pequeno é o ponto inteiro: ele filtra por esforço, coisa que uma foto não faz." },
      { type: "h2", text: "Como isso aparece na prática" },
      { type: "ul", items: [
        "A primeira coisa de um perfil é algo para responder, não apenas algo para olhar.",
        "A caixa de mensagem abre depois das respostas, não antes.",
        "As perguntas foram escritas por uma pessoa e não tiradas de um modelo, então dizem algo de qualquer jeito.",
        "Errar custa a abertura, e é isso que faz entrar valer alguma coisa.",
      ] },
      { type: "h2", accent: "green", text: "Como escrever perguntas que valem a resposta" },
      { type: "p", text: "As boas ficam entre o óbvio e o impossível. Se qualquer um adivinha, não filtra nada; se só sua irmã sabe, ninguém passa. Mire em algo que alguém que leu mesmo o seu perfil conseguiria. Concreto ganha de esperto: um hábito real, uma opinião real, uma preferência real. E escreva perguntas que você gostaria que fizessem a você, porque essas respostas vão ser o primeiro assunto." },
      { type: "p", text: "O Qulo é um app construído assim — não o primeiro e não o único. Você escreve de 2 a 4 perguntas de múltipla escolha com quatro opções cada e marca a correta — até 10 num plano pago; alguém chega até você apenas acertando todas, e existem dicas pagas para quem trava. Nada disso confirma quem a pessoa é. Mostra que ela leu o que você escreveu." },
    ],
  },
  it: {
    term: "Incontri basati su domande",
    summary:
      "Un modo di conoscersi online in cui il primo filtro non sono foto da scorrere ma domande a cui bisogna rispondere correttamente. L'accesso alla conversazione si guadagna con l'attenzione, non facendosi scegliere.",
    blocks: [
      { type: "h2", text: "Da dove arriva l'idea" },
      { type: "p", text: "Abbinarsi tramite domande è più vecchio dello smartphone. Le agenzie computerizzate degli anni Sessanta funzionavano con questionari su schede perforate, e da allora i test di personalità non hanno più abbandonato i servizi di incontri. Ciò che è cambiato è a cosa servono le domande. Nel vecchio modello un servizio raccoglieva le tue risposte e ti collocava in un bacino. In quello nuovo le domande le scrive la persona che vuoi raggiungere, e risponderci è il modo per raggiungerla." },
      { type: "p", text: "Oggi ad attirare è la stanchezza. Decidere sui volti è rapido, infinito e stranamente faticoso; una domanda spezza il ciclo perché chiede qualcosa a chi vuole la tua attenzione. Costa qualche secondo e un minimo di pensiero. Quel piccolo costo è tutto il senso: filtra in base all'impegno, cosa che una foto non può fare." },
      { type: "h2", text: "Come si presenta nella pratica" },
      { type: "ul", items: [
        "La prima cosa di un profilo è qualcosa a cui rispondere, non solo qualcosa da guardare.",
        "La casella dei messaggi si apre dopo le risposte, non prima.",
        "Le domande le ha scritte una persona e non sono prese da un modello, quindi dicono qualcosa comunque.",
        "Sbagliare ti costa l'ingresso, ed è proprio questo a rendere l'ingresso qualcosa che vale.",
      ] },
      { type: "h2", accent: "green", text: "Come scrivere domande che vale la pena risolvere" },
      { type: "p", text: "Le buone stanno tra l'ovvio e l'impossibile. Se la indovina chiunque non filtra niente; se la sa solo tua sorella non passa nessuno. Punta a qualcosa a cui arriverebbe chi ha davvero letto il tuo profilo. Il concreto batte il brillante: un'abitudine vera, un'opinione vera, una preferenza vera. E scrivi domande che ti farebbe piacere ricevere, perché quelle risposte saranno il primo argomento." },
      { type: "p", text: "Qulo è una delle app costruite così: non la prima e non l'unica. Scrivi da 2 a 4 domande a risposta multipla con quattro opzioni ciascuna e segni quella giusta — fino a 10 con un piano a pagamento; qualcuno ti raggiunge solo indovinandole tutte, e per chi si blocca esistono indizi a pagamento. Niente di tutto ciò verifica chi sia una persona. Mostra che ha letto quello che hai scritto." },
    ],
  },
  ja: {
    term: "クイズ型マッチング",
    summary:
      "ネットで人と出会うときの最初のふるいが、指で流していく写真ではなく、正しく答えなければならない質問になっている方式。会話への入り口は、選ばれることではなく、注意を払うことで手に入る。",
    blocks: [
      { type: "h2", text: "この発想はどこから来たのか" },
      { type: "p", text: "質問で引き合わせる仕組みは、スマートフォンより古い。1960年代のコンピュータ結婚相談所はパンチカードの質問票で動いていたし、それ以来ずっと、出会いのサービスには性格テストがくっついてきた。変わったのは、質問が何のためにあるかだ。古い型では、サービスが答えを集めてあなたを候補の集団に振り分けた。新しい型では、質問を書くのはあなたが届きたい相手であり、それに答えることが相手に届く方法そのものになる。" },
      { type: "p", text: "いま人を引き寄せているのは疲れだ。顔で判断する作業は速く、終わりがなく、妙に消耗する。質問はその輪を断ち切る。あなたの注意を求める側に、何かを求め返すからだ。かかるのは数秒と、少しの思考。この小さな負担こそが要点で、写真にはできない「手間によるふるい分け」がここで起きる。" },
      { type: "h2", text: "実際にはどう見えるか" },
      { type: "ul", items: [
        "プロフィールで最初に出てくるのは、眺めるものではなく答えるものだ。",
        "メッセージ欄が開くのは、答えたあとであって、その前ではない。",
        "質問はテンプレートから選ばれたものではなく人が書いたものなので、外しても当てても何かが伝わる。",
        "間違えれば入り口を失う。だからこそ、入れたことに意味が生まれる。",
      ] },
      { type: "h2", accent: "green", text: "答える気になる質問の書き方" },
      { type: "p", text: "良い質問は、当たり前と不可能のあいだにある。誰でも当てられる質問は何もふるい落とさないし、姉妹しか知らない質問では誰も通れない。プロフィールをちゃんと読んだ人ならたどり着ける、そのあたりを狙う。気の利いた質問より具体的な質問がいい。本当の習慣、本当の意見、本当の好み。そして、自分が聞かれても嬉しい質問を書くこと。最初に話す話題は、その答えになるからだ。" },
      { type: "p", text: "Qulo はこの作りのアプリの一つで、最初でも唯一でもない。四択の質問を2問から4問（有料プランなら最大10問）書き、正解を自分で決める。相手はその全問に正解したときだけあなたに届き、行き詰まった解答者のために有料のヒントがある。これで誰かの身元が確認されるわけではない。示されるのは、あなたの書いたものを読んだという事実だけだ。" },
    ],
  },
  ko: {
    term: "퀴즈형 매칭",
    summary:
      "온라인에서 사람을 만날 때 첫 관문이 넘겨 보는 사진이 아니라 정확히 맞혀야 하는 질문인 방식. 대화로 들어가는 문은 선택받아서가 아니라 주의를 기울여서 열린다.",
    blocks: [
      { type: "h2", text: "이 발상은 어디에서 왔을까" },
      { type: "p", text: "질문으로 짝을 맞추는 방식은 스마트폰보다 오래됐다. 1960년대 컴퓨터 중매 서비스는 천공 카드 설문지로 돌아갔고, 그 뒤로도 성격 검사는 늘 만남 서비스에 붙어 다녔다. 달라진 것은 질문이 무엇을 위한 것이냐다. 옛 방식에서는 서비스가 답을 모아 당신을 어떤 후보군에 배정했다. 새로운 방식에서는 당신이 닿고 싶은 사람이 직접 질문을 쓰고, 그 질문을 푸는 일이 곧 그 사람에게 닿는 방법이 된다." },
      { type: "p", text: "지금 사람들을 끄는 것은 피로다. 얼굴로 판단하는 일은 빠르고 끝이 없으며 이상하게 지친다. 질문은 그 고리를 끊는다. 당신의 관심을 원하는 쪽에도 무언가를 요구하기 때문이다. 몇 초와 약간의 생각이 든다. 바로 그 작은 비용이 핵심이다. 사진은 할 수 없는 일, 즉 들인 노력으로 거르는 일이 여기서 일어난다." },
      { type: "h2", text: "실제로는 이렇게 보인다" },
      { type: "ul", items: [
        "프로필에서 처음 만나는 것은 바라볼 것이 아니라 답할 것이다.",
        "메시지 창은 답을 맞힌 뒤에 열린다. 그 전이 아니다.",
        "질문은 템플릿에서 고른 것이 아니라 사람이 쓴 것이라, 맞히든 틀리든 무언가를 말해 준다.",
        "틀리면 입구를 잃는다. 그래서 들어가는 일에 값이 생긴다.",
      ] },
      { type: "h2", accent: "green", text: "풀 만한 질문은 어떻게 쓸까" },
      { type: "p", text: "좋은 질문은 뻔함과 불가능 사이에 있다. 누구나 맞히는 질문은 아무것도 거르지 못하고, 언니만 아는 질문은 아무도 통과시키지 못한다. 프로필을 실제로 읽은 사람이라면 도달할 만한 지점을 노리자. 재치보다 구체가 낫다. 진짜 습관, 진짜 의견, 진짜 취향. 그리고 나도 받아 보고 싶은 질문을 쓰자. 결국 처음 나눌 이야기가 그 답이 될 테니까." },
      { type: "p", text: "Qulo는 이렇게 만들어진 앱 가운데 하나다. 처음도 아니고 유일하지도 않다. 사지선다 질문을 2~4개(유료 플랜에서는 최대 10개) 쓰고 정답을 직접 표시하면, 상대는 그 전부를 맞혔을 때만 당신에게 닿는다. 막힌 사람을 위한 유료 힌트도 있다. 이 가운데 무엇도 그 사람이 누구인지 확인해 주지는 않는다. 당신이 쓴 것을 읽었다는 사실을 보여 줄 뿐이다." },
    ],
  },
  zh: {
    term: "答题匹配",
    summary:
      "一种在网上认识人的方式：第一道门槛不是一张张滑过去的照片，而是必须答对的题目。进入对话的资格靠用心换来，而不是靠被人挑中。",
    blocks: [
      { type: "h2", text: "这个想法从哪里来" },
      { type: "p", text: "用问题来配对，比智能手机还要老。1960年代的电脑征友服务靠打孔卡问卷运转，此后性格测验就一直挂在各种交友服务上。变的是问题的用途。旧模式里，服务收走你的答案，把你归进某个人群。新模式里，题目由你想接近的那个人亲手写下，答对题目就是接近他的方式本身。" },
      { type: "p", text: "如今真正吸引人的是疲惫。靠脸做判断又快又没完没了，而且累得出奇；一道题打断了这个循环，因为它反过来向想要你注意力的人提出要求。它花掉几秒钟和一点思考。这点小小的代价正是全部意义所在：它按投入的心思筛人，而照片做不到这一点。" },
      { type: "h2", text: "在实际使用中是什么样子" },
      { type: "ul", items: [
        "资料页上最先出现的是一道要回答的题，而不只是可以看的东西。",
        "输入框是在答完题之后才打开，而不是之前。",
        "题目是真人写的，不是从模板里挑的，所以无论答对答错都透露了些什么。",
        "答错就失去这次机会，而这正是进得去才有价值的原因。",
      ] },
      { type: "h2", accent: "green", text: "怎么写出值得回答的题目" },
      { type: "p", text: "好题目落在“显而易见”和“绝无可能”之间。谁都猜得到的题筛不掉任何人；只有你姐姐知道答案的题，谁也进不来。目标是让一个真的读过你资料的人能想到。具体胜过机灵：一个真实的习惯、一个真实的观点、一个真实的偏好。也写一些你自己乐意被问到的题，因为这些答案就是你们最先聊起来的东西。" },
      { type: "p", text: "Qulo 是按这种方式做的应用之一——不是最早的，也不是唯一的。你写2到4道四选一的题目并标出正确答案（付费方案最多10道）；对方必须全部答对才能联系到你，卡住的答题者可以购买提示。这些都不能核实一个人究竟是谁，它只说明对方读过你写的东西。" },
    ],
  },
  nl: {
    term: "Daten met vragen",
    summary:
      "Een manier om online mensen te leren kennen waarbij de eerste filter geen foto's zijn die je wegveegt, maar vragen die je goed moet beantwoorden. Toegang tot een gesprek verdien je met aandacht, niet doordat je uitgekozen wordt.",
    blocks: [
      { type: "h2", text: "Waar het idee vandaan komt" },
      { type: "p", text: "Matchen via vragen is ouder dan de smartphone. Computerbemiddeling in de jaren zestig draaide op vragenlijsten op ponskaarten, en sindsdien hangen persoonlijkheidstests aan datingdiensten vast. Wat veranderde, is waar de vragen voor dienen. In het oude model verzamelde een dienst je antwoorden en zette je in een groep. In het nieuwe schrijft de persoon die je wilt bereiken de vragen, en ze beantwoorden ís de manier om die persoon te bereiken." },
      { type: "p", text: "Wat nu trekt, is de vermoeidheid. Beslissen op gezichten gaat snel, houdt nooit op en put vreemd genoeg uit. Een vraag doorbreekt die lus, omdat ze iets vraagt van wie jouw aandacht wil. Ze kost een paar seconden en een beetje nadenken. Precies dat kleine prijskaartje is het punt: het filtert op moeite, en dat kan een foto niet." },
      { type: "h2", text: "Hoe het er in de praktijk uitziet" },
      { type: "ul", items: [
        "Het eerste op een profiel is iets om te beantwoorden, niet alleen iets om naar te kijken.",
        "Het berichtenvak gaat open ná de antwoorden, niet ervoor.",
        "De vragen zijn door een mens geschreven en niet uit een sjabloon geplukt, dus ze zeggen sowieso iets.",
        "Een fout antwoord kost je de opening, en juist dat maakt binnenkomen iets waard.",
      ] },
      { type: "h2", accent: "green", text: "Hoe je vragen schrijft die het beantwoorden waard zijn" },
      { type: "p", text: "De goede zitten tussen voor de hand liggend en onmogelijk. Wat iedereen raadt, filtert niets; wat alleen je zus weet, laat niemand door. Mik op iets waar iemand op komt die je profiel echt gelezen heeft. Concreet wint van gevat: een echte gewoonte, een echte mening, een echte voorkeur. En schrijf vragen die je zelf leuk zou vinden om te krijgen, want die antwoorden zijn het eerste waar je het over hebt." },
      { type: "p", text: "Qulo is een app die zo werkt — niet de eerste en niet de enige. Je schrijft 2 tot 4 meerkeuzevragen met elk vier opties en markeert het juiste antwoord — tot 10 met een betaald abonnement; iemand bereikt jou alleen door ze allemaal goed te hebben, en er zijn betaalde hints voor wie vastloopt. Niets daarvan verifieert wie iemand is. Het laat zien dat diegene las wat jij schreef." },
    ],
  },
  pl: {
    term: "Randkowanie przez pytania",
    summary:
      "Sposób poznawania ludzi w sieci, w którym pierwszym filtrem nie są przewijane zdjęcia, tylko pytania, na które trzeba odpowiedzieć poprawnie. Dostęp do rozmowy zdobywa się uwagą, a nie tym, że ktoś nas wybrał.",
    blocks: [
      { type: "h2", text: "Skąd wziął się ten pomysł" },
      { type: "p", text: "Dobieranie się przez pytania jest starsze niż smartfon. Komputerowe biura matrymonialne lat sześćdziesiątych działały na ankietach z kart perforowanych, a testy osobowości od tamtej pory nie odkleiły się od serwisów randkowych. Zmieniło się to, po co są pytania. W starym modelu serwis zbierał twoje odpowiedzi i wrzucał cię do puli. W nowym pytania pisze osoba, do której chcesz dotrzeć, a odpowiedzenie na nie jest właśnie sposobem, by do niej dotrzeć." },
      { type: "p", text: "Dziś przyciąga zmęczenie. Decydowanie po twarzach jest szybkie, nieskończone i dziwnie wyczerpujące, a pytanie przerywa tę pętlę, bo czegoś wymaga od kogoś, kto chce twojej uwagi. Kosztuje kilka sekund i odrobinę myślenia. Ten drobny koszt jest całym sensem: filtruje po wysiłku, czego zdjęcie nie potrafi." },
      { type: "h2", text: "Jak to wygląda w praktyce" },
      { type: "ul", items: [
        "Pierwsze, co widzisz w profilu, to coś do rozwiązania, a nie tylko do obejrzenia.",
        "Okno wiadomości otwiera się po odpowiedziach, nie przed nimi.",
        "Pytania napisał człowiek, a nie wybrał je z szablonu, więc tak czy inaczej coś mówią.",
        "Zła odpowiedź kosztuje cię wejście i właśnie dlatego wejście cokolwiek znaczy.",
      ] },
      { type: "h2", accent: "green", text: "Jak pisać pytania warte odpowiedzi" },
      { type: "p", text: "Dobre leżą między oczywistym a niemożliwym. Jeśli zgadnie każdy, pytanie nic nie filtruje; jeśli wie tylko twoja siostra, nie przejdzie nikt. Celuj w to, na co wpadnie ktoś, kto naprawdę przeczytał twój profil. Konkret bije błyskotliwość: prawdziwy nawyk, prawdziwa opinia, prawdziwa preferencja. I pisz pytania, które sam chciałbyś dostać, bo od tych odpowiedzi zacznie się rozmowa." },
      { type: "p", text: "Qulo to jedna z aplikacji zbudowanych w ten sposób — nie pierwsza i nie jedyna. Piszesz od 2 do 4 pytań wielokrotnego wyboru, każde z czterema odpowiedziami, i zaznaczasz poprawną — w planie płatnym do 10; ktoś dociera do ciebie tylko wtedy, gdy trafi we wszystkie, a dla zaciętych są płatne podpowiedzi. Nic z tego nie potwierdza, kim ktoś jest. Pokazuje, że przeczytał to, co napisałeś." },
    ],
  },
  sv: {
    term: "Dejting med frågor",
    summary:
      "Ett sätt att lära känna människor på nätet där det första filtret inte är bilder man sveper förbi, utan frågor man måste svara rätt på. Tillträdet till ett samtal förtjänas med uppmärksamhet, inte genom att bli utvald.",
    blocks: [
      { type: "h2", text: "Varifrån idén kommer" },
      { type: "p", text: "Att matcha genom frågor är äldre än smarttelefonen. Sextiotalets datorförmedling byggde på frågeformulär på hålkort, och sedan dess har personlighetstest suttit fast vid dejtingtjänster. Det som har ändrats är vad frågorna är till för. I den äldre modellen samlade en tjänst in dina svar och sorterade in dig i en pool. I den nyare skrivs frågorna av personen du försöker nå, och att svara på dem är själva sättet att nå fram." },
      { type: "p", text: "Det som lockar nu är tröttheten. Att avgöra utifrån ansikten går fort, tar aldrig slut och är märkligt tröttsamt. En fråga bryter den slingan genom att kräva något av den som vill ha din uppmärksamhet. Den kostar några sekunder och lite eftertanke. Just den lilla kostnaden är hela poängen: den filtrerar på ansträngning, vilket ett foto inte kan." },
      { type: "h2", text: "Hur det ser ut i praktiken" },
      { type: "ul", items: [
        "Det första i en profil är något att svara på, inte bara något att titta på.",
        "Meddelanderutan öppnas efter svaren, inte före.",
        "Frågorna är skrivna av en människa och inte hämtade ur en mall, så de säger något oavsett.",
        "Ett fel svar kostar dig öppningen, och det är just det som gör att det betyder något att komma in.",
      ] },
      { type: "h2", accent: "green", text: "Så skriver du frågor värda att svara på" },
      { type: "p", text: "De bra ligger mellan självklart och omöjligt. Det som vem som helst gissar filtrerar ingenting; det bara din syster vet släpper inte igenom någon. Sikta på något som en person som faktiskt läst din profil skulle komma fram till. Konkret slår spirituellt: en riktig vana, en riktig åsikt, en riktig preferens. Och skriv frågor du själv skulle gilla att få, för det är svaren ni börjar prata om." },
      { type: "p", text: "Qulo är en app byggd så här — inte den första och inte den enda. Du skriver mellan 2 och 4 flervalsfrågor med fyra alternativ vardera och markerar rätt svar — upp till 10 med ett betalt abonnemang; någon når dig bara genom att pricka in alla, och det finns betalda ledtrådar för den som kör fast. Inget av det verifierar vem någon är. Det visar att personen läst det du skrev." },
    ],
  },
  hi: {
    term: "सवालों से डेटिंग",
    summary:
      "ऑनलाइन लोगों से मिलने का ऐसा तरीक़ा जिसमें पहली छलनी स्क्रॉल की जाने वाली तस्वीरें नहीं, बल्कि वे सवाल हैं जिनका सही जवाब देना ज़रूरी है। बातचीत तक पहुँच चुने जाने से नहीं, ध्यान देने से मिलती है।",
    blocks: [
      { type: "h2", text: "यह विचार आया कहाँ से" },
      { type: "p", text: "सवालों के ज़रिये जोड़ी मिलाना स्मार्टफ़ोन से भी पुराना है। 1960 के दशक की कंप्यूटर डेटिंग सेवाएँ छिद्रित कार्डों पर छपे सवालनामों से चलती थीं, और तब से डेटिंग सेवाओं के साथ व्यक्तित्व परीक्षण चिपके ही रहे। जो बदला, वह यह है कि सवाल किस काम आते हैं। पुराने मॉडल में सेवा आपके जवाब इकट्ठा करती और आपको किसी समूह में डाल देती थी। नए मॉडल में सवाल वही इंसान लिखता है जिस तक आप पहुँचना चाहते हैं, और उन्हें हल करना ही उस तक पहुँचने का रास्ता है।" },
      { type: "p", text: "आज खींचती है थकान। चेहरों पर फ़ैसला करना तेज़ है, कभी ख़त्म नहीं होता और अजीब तरह से थका देता है। एक सवाल इस चक्र को तोड़ देता है, क्योंकि जो आपका ध्यान चाहता है उससे भी कुछ माँगता है। इसमें कुछ सेकंड और थोड़ा सोचना लगता है। यही छोटी-सी क़ीमत पूरी बात है: यह मेहनत के आधार पर छाँटती है, और तस्वीर यह नहीं कर सकती।" },
      { type: "h2", text: "व्यवहार में यह कैसा दिखता है" },
      { type: "ul", items: [
        "प्रोफ़ाइल पर पहली चीज़ जवाब देने के लिए होती है, सिर्फ़ देखने के लिए नहीं।",
        "मैसेज बॉक्स जवाबों के बाद खुलता है, उनसे पहले नहीं।",
        "सवाल किसी टेम्पलेट से नहीं चुने गए, एक इंसान ने लिखे हैं — इसलिए सही हों या ग़लत, कुछ न कुछ बताते ही हैं।",
        "ग़लत जवाब आपसे वह मौक़ा छीन लेता है, और इसी वजह से भीतर पहुँचने की कोई क़ीमत बनती है।",
      ] },
      { type: "h2", accent: "green", text: "जवाब देने लायक़ सवाल कैसे लिखें" },
      { type: "p", text: "अच्छे सवाल ज़ाहिर और नामुमकिन के बीच बैठते हैं। जिसे कोई भी ताड़ ले, वह किसी को नहीं छाँटता; जिसे सिर्फ़ आपकी बहन जानती हो, उससे कोई भीतर नहीं आ पाता। ऐसा कुछ चुनिए जहाँ तक वह इंसान पहुँच जाए जिसने आपकी प्रोफ़ाइल सचमुच पढ़ी हो। चतुराई से बेहतर है ठोस बात: कोई असली आदत, कोई असली राय, कोई असली पसंद। और वैसे सवाल लिखिए जो आपसे पूछे जाएँ तो आपको अच्छा लगे, क्योंकि पहली बातचीत उन्हीं जवाबों पर होगी।" },
      { type: "p", text: "Qulo इसी तरह बना एक ऐप है — न पहला, न इकलौता। आप 2 से 4 बहुविकल्पीय सवाल लिखते हैं, हर सवाल में चार विकल्प, और सही जवाब ख़ुद चुनते हैं — भुगतान वाली योजना में 10 तक; कोई आप तक तभी पहुँचता है जब हर सवाल सही कर दे, और अटक जाने वालों के लिए पैसे देकर मिलने वाले संकेत मौजूद हैं। इनमें से कुछ भी यह नहीं जाँचता कि कोई है कौन। यह बस इतना दिखाता है कि उसने आपका लिखा पढ़ा है।" },
    ],
  },
};
