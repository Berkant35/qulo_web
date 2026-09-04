import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Talking stage — the stretch after matching and before anything is called
 * dating.
 *
 * Judgement calls made here, so a later editor does not undo them by accident:
 *
 * - "A few weeks, and by a few meetings it has done its job" is offered as a
 *   rule of thumb, not a rule. No source measures the natural length of a
 *   talking stage, so the page never states a duration as fact; block 2 frames
 *   it by what the phase is *for*, and the two-month mark in block 4 is written
 *   as a prompt to notice, not a deadline.
 * - No statistics anywhere. The Forbes Health / OnePoll burnout figure is about
 *   dating-app burnout and would be padding on this page, so it is not used.
 * - No Qulo angle. A talking stage happens on every app and off all of them,
 *   and nothing about writing questions shortens it, so block 7 is a reader
 *   takeaway instead: "talking" is not a status the other person has agreed to,
 *   and a stage that never ends becomes an undefined arrangement nobody chose.
 *   That last sentence is the deliberate hinge to `situationship.ts`; the
 *   forward hinge to `hardballing.ts` is block 6's "say what you would like it
 *   to be". Neither term is named in the body — the related-term links at the
 *   foot of the page carry the navigation.
 * - Block 6 says the app rewards staying inside it. That is a statement about
 *   how messaging products are built in general, not a competitor claim, and it
 *   applies to Qulo too.
 *
 * Term names: de and ar have real native words for this phase
 * ("Kennenlernphase", "مرحلة التعارف"), ru describes it ("Стадия общения"), and
 * ko and zh have exact everyday equivalents ("썸 타는 단계", "暧昧期"), so those
 * win and the summary carries the English loanword. Everywhere else the English
 * phrase is genuinely what people say, including tr, es, it, pl and sv.
 * Note zh: this page is "暧昧期" (the period) while situationship is
 * "暧昧关系" (the standing arrangement) — the two summaries keep them apart.
 */
export const talkingStage: LocalizedGlossaryEntry = {
  en: {
    term: "Talking stage",
    summary:
      "The stretch between matching and calling it dating, when two people message constantly, may already be meeting up, and still describe each other as someone they are just talking to.",
    blocks: [
      { type: "h2", text: "Where the talking stage came from" },
      {
        type: "p",
        text: "Dating apps stretched the front end of a relationship out. You can be in conversation with several people at once, none of it costs anything yet, and nobody wants to claim more than is true. So a holding word appeared. Saying you are talking to someone announces interest without announcing a decision. Older generations had the same phase; it simply had no name, so nobody had to defend how long theirs was lasting.",
      },
      {
        type: "p",
        text: "Used well, it is the most useful part of dating. Nothing is decided, so you find out how someone talks when there is nothing to perform: what they do when a plan falls through, whether they ask you anything back. A few weeks does that job. Once you have met a few times, the stage has told you what it can.",
      },
      { type: "h2", text: "When it has stopped being a stage" },
      {
        type: "ul",
        items: [
          "It has run past a couple of months and neither of you has used a different word.",
          "The messaging is constant but the meeting is always next week.",
          "You describe them differently depending on which friend is asking.",
          "Every time it moves a step forward, one of you retreats back into the chat.",
        ],
      },
      { type: "h2", text: "How to move it along", accent: "green" },
      {
        type: "p",
        text: "Make one plan with an actual date on it, in the coming week, not \"soon\". Move the conversation off the app early — the app rewards staying inside it. Ask something you genuinely want to know instead of the funniest thing you can think of. And after the third time you meet, if it is still called talking, say what you would like it to be. One awkward minute is cheaper than four more months.",
      },
      {
        type: "p",
        text: "\"Talking\" is not a status the other person has agreed to either — they may be further ahead than you assume, or well behind. A stage that never ends stops being a stage: it becomes an undefined arrangement neither of you chose, and by then the conversation weighs far more than it did in week three.",
      },
    ],
  },

  tr: {
    term: "Talking stage",
    summary:
      "Eşleşmeyle flörtün adının konması arasındaki dönem: sürekli mesajlaşılır, hatta buluşulur, ama karşı taraf hâlâ \"konuştuğum biri\" diye anlatılır.",
    blocks: [
      { type: "h2", text: "Bu dönem nereden çıktı" },
      {
        type: "p",
        text: "Dating uygulamaları ilişkinin başlangıç kısmını uzattı. Aynı anda birkaç kişiyle konuşabiliyorsun, henüz hiçbirinin bir bedeli yok ve kimse olduğundan fazlasını iddia etmek istemiyor. Böylece bir ara kelime doğdu: \"konuşuyoruz\". İlgiyi duyurur ama kararı duyurmaz. Bu aşama eski kuşaklarda da vardı; sadece adı yoktu, o yüzden kimse ne kadar sürdüğünü savunmak zorunda kalmıyordu.",
      },
      {
        type: "p",
        text: "İyi kullanıldığında flörtün en işe yarar kısmı burasıdır. Hiçbir şey karara bağlanmadığı için karşındakinin rol yapmadığı hâlini görürsün: plan bozulunca ne yapıyor, sana da bir şey soruyor mu. Birkaç hafta bunu göstermeye yeter. Birkaç kez buluştuysanız, bu dönem söyleyeceğini zaten söylemiştir.",
      },
      { type: "h2", text: "Ne zaman dönem olmaktan çıkar" },
      {
        type: "ul",
        items: [
          "Birkaç ayı geçti ve ikiniz de hâlâ başka bir kelime kullanmadınız.",
          "Mesajlaşma kesintisiz, buluşma ise hep gelecek hafta.",
          "Hangi arkadaşın sorduğuna göre onu farklı anlatıyorsun.",
          "İş her ileri gittiğinde biriniz geri çekilip sohbete sığınıyor.",
        ],
      },
      { type: "h2", text: "Nasıl ilerletirsin", accent: "green" },
      {
        type: "p",
        text: "\"Yakında\" değil, önümüzdeki hafta içinde tarihi belli tek bir plan yap. Sohbeti erkenden uygulamanın dışına taşı; uygulama içinde kalmayı ödüllendirir. Aklına gelen en esprili şey yerine gerçekten merak ettiğin şeyi sor. Üçüncü buluşmadan sonra hâlâ \"konuşuyoruz\" deniyorsa, bunun ne olmasını istediğini söyle. Bir dakikalık tuhaflık, dört ay daha beklemekten ucuza gelir.",
      },
      {
        type: "p",
        text: "\"Konuşuyoruz\" karşı tarafın da onayladığı bir statü değil; sandığından daha ileride ya da çok daha geride olabilir. Bitmeyen bir dönem dönem olarak kalmaz: kimsenin seçmediği adsız bir düzene dönüşür ve o noktada konuşmak, üçüncü haftakinden çok daha ağırdır.",
      },
    ],
  },

  de: {
    term: "Kennenlernphase",
    summary:
      "Die Zeit zwischen Match und der Entscheidung, es Beziehung zu nennen: Man schreibt ständig, trifft sich vielleicht schon — und spricht vom anderen trotzdem nur als jemandem, mit dem man gerade schreibt. Englisch: talking stage.",
    blocks: [
      { type: "h2", text: "Woher diese Phase kommt" },
      {
        type: "p",
        text: "Dating-Apps haben den Anfang einer Beziehung in die Länge gezogen. Man kann mit mehreren Menschen gleichzeitig im Gespräch sein, nichts davon kostet bisher etwas, und niemand will mehr behaupten, als wahr ist. Also entstand ein Zwischenwort. Zu sagen, man schreibe gerade mit jemandem, meldet Interesse an, ohne eine Entscheidung anzumelden. Frühere Generationen hatten dieselbe Phase — sie hatte nur keinen Namen.",
      },
      {
        type: "p",
        text: "Gut genutzt ist das der brauchbarste Teil des Datings. Es ist nichts entschieden, also siehst du, wie jemand redet, wenn nichts vorgeführt werden muss: was passiert, wenn ein Plan platzt, ob überhaupt zurückgefragt wird. Ein paar Wochen erledigen diese Arbeit. Nach ein paar Treffen hat die Phase gesagt, was sie sagen kann.",
      },
      { type: "h2", text: "Wann sie aufgehört hat, eine Phase zu sein" },
      {
        type: "ul",
        items: [
          "Es läuft seit über zwei Monaten und keiner von euch hat ein anderes Wort benutzt.",
          "Geschrieben wird ununterbrochen, getroffen wird sich immer nächste Woche.",
          "Du beschreibst die Person unterschiedlich, je nachdem, welche Freundin fragt.",
          "Sobald es einen Schritt vorangeht, zieht sich eine oder einer in den Chat zurück.",
        ],
      },
      { type: "h2", text: "Wie du weiterkommst", accent: "green" },
      {
        type: "p",
        text: "Mach einen einzigen Plan mit einem echten Datum in der kommenden Woche, nicht \"bald\". Hol das Gespräch früh aus der App heraus; die App belohnt es, drin zu bleiben. Frag etwas, das du wirklich wissen willst, statt des witzigsten Satzes, der dir einfällt. Und wenn es nach dem dritten Treffen immer noch Kennenlernphase heißt: Sag, was du dir wünschst. Eine unangenehme Minute ist billiger als vier weitere Monate.",
      },
      {
        type: "p",
        text: "\"Wir schreiben halt\" ist auch kein Status, dem die andere Person zugestimmt hätte — sie kann weiter sein, als du denkst, oder deutlich weniger weit. Eine Phase, die nie endet, bleibt keine Phase: Sie wird zu einem namenlosen Arrangement, das keiner gewählt hat, und dann ist das Gespräch schwerer als in Woche drei.",
      },
    ],
  },

  fr: {
    term: "Talking stage",
    summary:
      "La période entre le match et le moment où l'on ose dire qu'on est ensemble : on s'écrit sans arrêt, on se voit peut-être déjà, et on parle encore de l'autre comme de quelqu'un à qui on parle.",
    blocks: [
      { type: "h2", text: "D'où vient cette période" },
      {
        type: "p",
        text: "Les applis ont allongé le début des histoires. On peut discuter avec plusieurs personnes à la fois, rien ne coûte encore rien, et personne ne veut annoncer plus que ce qui est vrai. Un mot d'attente est donc apparu. Dire qu'on parle à quelqu'un signale l'intérêt sans signaler une décision. Les générations précédentes connaissaient la même phase : elle n'avait simplement pas de nom, donc personne n'avait à justifier sa durée.",
      },
      {
        type: "p",
        text: "Bien utilisée, c'est la partie la plus utile du dating. Rien n'est décidé, donc vous voyez comment quelqu'un parle quand il n'y a rien à jouer : ce qu'il fait quand un plan tombe à l'eau, s'il vous pose des questions en retour. Quelques semaines suffisent. Après plusieurs rencontres, cette phase a dit ce qu'elle avait à dire.",
      },
      { type: "h2", text: "Quand ce n'est plus une période" },
      {
        type: "ul",
        items: [
          "Ça dure depuis plus de deux mois et aucun de vous n'a employé un autre mot.",
          "Les messages sont continus, mais se voir, c'est toujours la semaine prochaine.",
          "Vous décrivez cette personne différemment selon l'ami qui vous pose la question.",
          "Dès que ça avance d'un cran, l'un de vous se replie dans la conversation écrite.",
        ],
      },
      { type: "h2", text: "Comment faire avancer les choses", accent: "green" },
      {
        type: "p",
        text: "Proposez un seul plan avec une vraie date dans la semaine qui vient, pas un \"bientôt\". Sortez tôt de l'appli ; l'appli récompense ceux qui y restent. Posez une question qui vous intéresse vraiment plutôt que la phrase la plus drôle possible. Et après le troisième rendez-vous, si on en est encore au talking stage, dites ce que vous aimeriez que ce soit. Une minute gênante coûte moins cher que quatre mois de plus.",
      },
      {
        type: "p",
        text: "\"On se parle\" n'est pas non plus un statut que l'autre a validé : cette personne peut être plus avancée que vous ne croyez, ou nettement moins. Une phase qui ne finit jamais cesse d'être une phase : elle devient un arrangement sans nom que personne n'a choisi, et la conversation pèse alors bien plus qu'en troisième semaine.",
      },
    ],
  },

  es: {
    term: "Talking stage",
    summary:
      "El tramo entre el match y el momento de llamarlo salir juntos: os escribís sin parar, quizá ya quedáis, y aún describís al otro como alguien con quien simplemente habláis.",
    blocks: [
      { type: "h2", text: "De dónde salió esta etapa" },
      {
        type: "p",
        text: "Las apps alargaron el principio de las historias. Puedes estar hablando con varias personas a la vez, todavía no cuesta nada, y nadie quiere anunciar más de lo que es cierto. Así apareció una palabra de espera. Decir que hablas con alguien señala interés sin señalar una decisión. Las generaciones anteriores tenían la misma fase; sencillamente no tenía nombre, así que nadie debía justificar cuánto duraba.",
      },
      {
        type: "p",
        text: "Bien usada, es la parte más útil de conocer a alguien. No hay nada decidido, así que ves cómo habla esa persona cuando no tiene que actuar: qué hace si un plan se cae, si te pregunta algo de vuelta. Unas semanas bastan para eso. Cuando ya habéis quedado varias veces, la etapa ya ha dicho lo que podía decir.",
      },
      { type: "h2", text: "Cuándo deja de ser una etapa" },
      {
        type: "ul",
        items: [
          "Lleva más de un par de meses y ninguno de los dos ha usado otra palabra.",
          "Los mensajes son constantes, pero quedar siempre es la semana que viene.",
          "Describes a esa persona de forma distinta según qué amiga pregunte.",
          "Cada vez que avanza un paso, uno de los dos se repliega al chat.",
        ],
      },
      { type: "h2", text: "Cómo hacer que avance", accent: "green" },
      {
        type: "p",
        text: "Propón un solo plan con fecha real en los próximos días, no un \"a ver cuándo\". Saca la conversación de la app pronto; la app premia quedarse dentro. Pregunta algo que de verdad quieras saber en lugar de lo más ingenioso que se te ocurra. Y si después de la tercera vez que quedáis sigue llamándose talking stage, di qué te gustaría que fuera. Un minuto incómodo sale más barato que cuatro meses más.",
      },
      {
        type: "p",
        text: "\"Estamos hablando\" tampoco es un estado que la otra persona haya aceptado: puede ir más adelantada de lo que crees, o bastante más atrás. Una etapa que no termina deja de ser etapa: se convierte en un acuerdo sin nombre que nadie eligió, y para entonces la conversación pesa mucho más que en la tercera semana.",
      },
    ],
  },

  ar: {
    term: "مرحلة التعارف",
    summary:
      "المرحلة بين التطابق وبين تسمية ما بينكما علاقة: تتراسلان بلا توقّف، وربما تلتقيان فعلًا، ومع ذلك يظل الآخر مجرد شخص «نتحدّث معه». تُعرف بالإنجليزية بـ talking stage.",
    blocks: [
      { type: "h2", text: "من أين جاءت هذه المرحلة" },
      {
        type: "p",
        text: "أطالت تطبيقات المواعدة بداية أي علاقة. يمكنك أن تتحدث مع عدة أشخاص في الوقت نفسه، ولا شيء من ذلك يكلّف شيئًا بعد، ولا أحد يريد أن يدّعي أكثر مما هو صحيح. فظهرت كلمة انتظار: أن تقول إنك «تتحدث مع أحدهم» يعلن الاهتمام دون أن يعلن قرارًا. الأجيال السابقة عرفت المرحلة نفسها، لكنها لم تكن تحمل اسمًا يُسأل عن طوله.",
      },
      {
        type: "p",
        text: "حين تُستعمل جيدًا تكون أنفع جزء في التعارف. لا شيء محسوم بعد، فترى كيف يتحدث الشخص حين لا يوجد ما يُمثَّل: ماذا يفعل إذا أُلغي موعد، وهل يسألك أنت أيضًا. أسابيع قليلة تكفي لذلك. وبعد عدة لقاءات تكون المرحلة قد قالت كل ما تستطيع قوله.",
      },
      { type: "h2", text: "متى تتوقف عن كونها مرحلة" },
      {
        type: "ul",
        items: [
          "مضى أكثر من شهرين ولم يستخدم أيٌّ منكما كلمة أخرى.",
          "الرسائل متواصلة، أما اللقاء فدائمًا في الأسبوع القادم.",
          "تصف هذا الشخص وصفًا مختلفًا بحسب الصديق الذي يسأل.",
          "كلما تقدّمت الأمور خطوة، انسحب أحدكما إلى المحادثة المكتوبة.",
        ],
      },
      { type: "h2", text: "كيف تمضي بها إلى الأمام", accent: "green" },
      {
        type: "p",
        text: "اقترح خطة واحدة بتاريخ حقيقي خلال الأسبوع المقبل، لا «قريبًا». أخرج الحديث من التطبيق مبكرًا؛ التطبيق يكافئ البقاء داخله. اسأل عمّا تريد معرفته حقًا بدل أطرف جملة تخطر لك. وإذا بقي الأمر بعد اللقاء الثالث بلا اسم، فقل ما الذي تتمنى أن يكون. دقيقة محرجة أرخص من أربعة أشهر إضافية.",
      },
      {
        type: "p",
        text: "عبارة «نتحدث فقط» ليست حالة وافق عليها الطرف الآخر أيضًا؛ قد يكون أبعد مما تظن، أو أقلّ بكثير. والمرحلة التي لا تنتهي تكفّ عن كونها مرحلة: تتحول إلى ترتيب بلا اسم لم يختره أحد، ويصبح الحديث عندها أثقل مما كان في الأسبوع الثالث.",
      },
    ],
  },

  ru: {
    term: "Стадия общения",
    summary:
      "Период между мэтчем и словом «встречаемся»: вы переписываетесь без остановки, возможно уже видитесь, но всё ещё называете человека тем, с кем просто общаетесь. По-английски — talking stage.",
    blocks: [
      { type: "h2", text: "Откуда взялась эта стадия" },
      {
        type: "p",
        text: "Приложения растянули начало отношений. Можно одновременно переписываться с несколькими людьми, всё это пока ничего не стоит, и никто не хочет заявлять больше, чем есть. Так появилось промежуточное слово. Сказать «мы просто общаемся» — значит обозначить интерес, не обозначая решения. У прежних поколений была та же стадия, просто у неё не было названия, и никому не приходилось объяснять, почему она затянулась.",
      },
      {
        type: "p",
        text: "Если пользоваться ею с умом, это самая полезная часть знакомства. Ничего не решено, поэтому видно, как человек говорит, когда не нужно ничего изображать: что он делает, если план сорвался, спрашивает ли что-то в ответ. Нескольких недель на это хватает. После пары-тройки встреч стадия уже сказала всё, что могла.",
      },
      { type: "h2", text: "Когда это перестало быть стадией" },
      {
        type: "ul",
        items: [
          "Идёт больше двух месяцев, и ни один из вас не употребил другое слово.",
          "Переписка непрерывная, а встреча всегда «на следующей неделе».",
          "Вы описываете этого человека по-разному, смотря кто из друзей спросил.",
          "Как только всё продвигается на шаг, один из вас отступает обратно в чат.",
        ],
      },
      { type: "h2", text: "Как сдвинуть это с места", accent: "green" },
      {
        type: "p",
        text: "Договоритесь об одной встрече с конкретной датой на ближайшую неделю, а не «как-нибудь». Уводите разговор из приложения пораньше: приложение вознаграждает тех, кто остаётся внутри. Спросите то, что вам правда интересно, вместо самой остроумной фразы. И если после третьей встречи это по-прежнему называется «общаемся», скажите, чем вы хотели бы это видеть. Одна неловкая минута дешевле ещё четырёх месяцев.",
      },
      {
        type: "p",
        text: "«Мы общаемся» — не тот статус, на который согласился и другой человек: он может быть дальше, чем вам кажется, или заметно позади. Стадия, которая не кончается, перестаёт быть стадией: она превращается в безымянную договорённость, которую никто не выбирал, и разговор к тому моменту тяжелее, чем на третьей неделе.",
      },
    ],
  },

  pt: {
    term: "Talking stage",
    summary:
      "O intervalo entre o match e o momento de chamar de namoro: vocês trocam mensagens o tempo todo, talvez já se encontrem, e ainda descrevem o outro como alguém com quem estão só conversando.",
    blocks: [
      { type: "h2", text: "De onde veio essa fase" },
      {
        type: "p",
        text: "Os aplicativos esticaram o começo das histórias. Dá para estar conversando com várias pessoas ao mesmo tempo, nada disso custa nada ainda, e ninguém quer anunciar mais do que é verdade. Então surgiu uma palavra de espera. Dizer que você está conversando com alguém sinaliza interesse sem sinalizar decisão. As gerações anteriores tinham a mesma fase; ela só não tinha nome, então ninguém precisava justificar a duração.",
      },
      {
        type: "p",
        text: "Bem usada, é a parte mais útil de conhecer alguém. Nada está decidido, então você vê como a pessoa fala quando não há nada a encenar: o que faz quando um plano cai, se ela te pergunta algo de volta. Algumas semanas dão conta disso. Depois de alguns encontros, a fase já disse o que tinha para dizer.",
      },
      { type: "h2", text: "Quando deixa de ser uma fase" },
      {
        type: "ul",
        items: [
          "Já passou de dois meses e nenhum dos dois usou outra palavra.",
          "As mensagens são constantes, mas o encontro é sempre semana que vem.",
          "Você descreve a pessoa de um jeito diferente dependendo de qual amigo pergunta.",
          "Toda vez que avança um passo, um de vocês recua para o chat.",
        ],
      },
      { type: "h2", text: "Como fazer andar", accent: "green" },
      {
        type: "p",
        text: "Marque um único encontro com data de verdade na semana que vem, não um \"qualquer dia\". Tire a conversa do aplicativo cedo; o aplicativo premia quem fica dentro dele. Pergunte algo que você realmente quer saber em vez da frase mais engraçada que conseguir. E se depois do terceiro encontro ainda for talking stage, diga o que você gostaria que fosse. Um minuto constrangedor sai mais barato que mais quatro meses.",
      },
      {
        type: "p",
        text: "\"A gente só conversa\" também não é um status que a outra pessoa aprovou: ela pode estar mais adiante do que você imagina, ou bem atrás. Uma fase que nunca acaba deixa de ser fase: vira um arranjo sem nome que ninguém escolheu, e aí a conversa pesa muito mais do que pesaria na terceira semana.",
      },
    ],
  },

  it: {
    term: "Talking stage",
    summary:
      "Il tratto fra il match e il momento in cui la si chiama storia: ci si scrive di continuo, magari ci si vede già, e l'altra persona resta soltanto qualcuno con cui si sta parlando.",
    blocks: [
      { type: "h2", text: "Da dove arriva questa fase" },
      {
        type: "p",
        text: "Le app hanno allungato l'inizio delle storie. Puoi parlare con più persone insieme, niente costa ancora niente e nessuno vuole dichiarare più di quanto sia vero. Così è comparsa una parola di attesa: dire che stai parlando con qualcuno segnala l'interesse senza segnalare una decisione. Le generazioni precedenti avevano la stessa fase, solo che non aveva un nome e nessuno doveva giustificarne la durata.",
      },
      {
        type: "p",
        text: "Usata bene, è la parte più utile del conoscersi. Non c'è niente di deciso, quindi vedi come parla una persona quando non deve recitare: che cosa fa se salta un programma, se ti chiede qualcosa a sua volta. Qualche settimana basta. Dopo un paio di incontri, la fase ha già detto quello che poteva.",
      },
      { type: "h2", text: "Quando smette di essere una fase" },
      {
        type: "ul",
        items: [
          "Va avanti da più di due mesi e nessuno dei due ha usato un'altra parola.",
          "I messaggi sono continui, ma vedersi è sempre la settimana prossima.",
          "Descrivi quella persona in modo diverso a seconda dell'amica che te lo chiede.",
          "Ogni volta che si fa un passo avanti, uno dei due si ritira nella chat.",
        ],
      },
      { type: "h2", text: "Come farla muovere", accent: "green" },
      {
        type: "p",
        text: "Proponi un solo programma con una data vera nella settimana che viene, non un generico prima o poi. Porta la conversazione fuori dall'app presto: l'app premia chi ci resta dentro. Chiedi qualcosa che vuoi davvero sapere invece della battuta migliore che ti viene in mente. E se dopo il terzo incontro si chiama ancora talking stage, di' che cosa vorresti che diventasse. Un minuto imbarazzante costa meno di altri quattro mesi.",
      },
      {
        type: "p",
        text: "Anche \"ci stiamo parlando\" non è uno stato che l'altra persona ha approvato: può essere più avanti di quanto pensi, o parecchio indietro. Una fase che non finisce smette di essere una fase: diventa un accordo senza nome che nessuno ha scelto, e a quel punto la conversazione pesa molto più che alla terza settimana.",
      },
    ],
  },

  ja: {
    term: "トーキングステージ",
    summary:
      "マッチしてから「付き合っている」と言うまでの期間。毎日のように連絡を取り、会っていることさえあるのに、相手のことはまだ「話している人」と説明している状態。",
    blocks: [
      { type: "h2", text: "この期間が生まれた理由" },
      {
        type: "p",
        text: "アプリは、関係の入り口をずいぶん長くしました。同時に何人かと話していられるし、まだ何のコストも生じていないし、誰も事実以上のことを名乗りたくない。そこで、待つための言葉が生まれました。「いま話している人がいる」と言えば、関心は伝わるのに決断は伝わりません。上の世代にも同じ時期はありました。ただ名前がなかったので、長引いても説明を求められなかっただけです。",
      },
      {
        type: "p",
        text: "うまく使えば、ここは出会いのいちばん役に立つ部分です。何も決まっていないから、演じる必要のない相手の話し方が見えます。予定が流れたときにどうするか、こちらにも質問を返してくるか。数週間あれば十分わかります。何度か会ったなら、この期間は言えることをもう言い終えています。",
      },
      { type: "h2", text: "もう「期間」ではなくなったサイン" },
      {
        type: "ul",
        items: [
          "二か月以上たっているのに、お互いまだ別の言葉を使っていない。",
          "連絡は途切れないのに、会うのはいつも来週。",
          "どの友だちに聞かれたかで、相手の説明のしかたが変わる。",
          "一歩進むたびに、どちらかがチャットの中に引き返す。",
        ],
      },
      { type: "h2", text: "先に進めるには", accent: "green" },
      {
        type: "p",
        text: "「そのうち」ではなく、来週の具体的な日付が入った予定をひとつ立ててください。会話は早めにアプリの外へ。アプリは中に留まることを後押しします。いちばん面白い一言よりも、本当に知りたいことを聞くこと。三回目に会っても呼び名が変わらないなら、自分はどうしたいのかを言葉にしてください。気まずい一分は、あと四か月より安上がりです。",
      },
      {
        type: "p",
        text: "「話しているだけ」というのは、相手が同意した肩書きでもありません。思っているより先に進んでいることも、ずっと後ろにいることもある。終わらない期間は期間ではなくなります。誰も選んでいない名前のない関係に変わり、そのころには三週目より話が重くなっています。",
      },
    ],
  },

  ko: {
    term: "썸 타는 단계",
    summary:
      "매칭 이후 연애라고 부르기 전까지의 구간. 매일 연락하고 이미 만나기도 하지만, 서로를 아직 「그냥 연락하는 사람」이라고 설명하는 상태.",
    blocks: [
      { type: "h2", text: "이 단계는 어디서 왔나" },
      {
        type: "p",
        text: "앱은 관계의 초입을 길게 늘여 놓았습니다. 여러 사람과 동시에 대화할 수 있고, 아직 아무 대가도 치르지 않았고, 누구도 사실 이상을 주장하고 싶어 하지 않습니다. 그래서 기다림의 단어가 생겼습니다. 「요즘 연락하는 사람 있어」라고 하면 관심은 알리되 결정은 알리지 않게 되니까요. 윗세대에도 같은 시기가 있었습니다. 다만 이름이 없어서 길어져도 해명할 일이 없었을 뿐입니다.",
      },
      {
        type: "p",
        text: "잘 쓰면 이 구간은 연애에서 가장 쓸모 있는 부분입니다. 정해진 게 없으니 상대가 꾸미지 않을 때 어떻게 말하는지가 보입니다. 약속이 어그러졌을 때 어떻게 하는지, 나에게도 질문을 되돌려 주는지. 몇 주면 충분히 알 수 있습니다. 몇 번 만났다면 이 단계는 할 수 있는 말을 이미 다 한 셈입니다.",
      },
      { type: "h2", text: "더 이상 단계가 아닐 때" },
      {
        type: "ul",
        items: [
          "두 달이 넘었는데 둘 다 다른 단어를 써 본 적이 없다.",
          "연락은 끊이지 않는데 만나는 건 늘 다음 주다.",
          "어떤 친구가 묻느냐에 따라 그 사람을 다르게 설명한다.",
          "한 걸음 나아갈 때마다 둘 중 하나가 다시 채팅 안으로 물러난다.",
        ],
      },
      { type: "h2", text: "어떻게 진전시킬까", accent: "green" },
      {
        type: "p",
        text: "「언제 한번」이 아니라 다음 주 안의 날짜가 박힌 약속을 하나 잡으세요. 대화는 일찍 앱 밖으로 옮기세요. 앱은 안에 머무는 쪽을 부추깁니다. 제일 재치 있는 말보다 정말 궁금한 것을 물어보세요. 세 번째로 만난 뒤에도 여전히 이름이 없다면, 이 관계가 무엇이 되기를 바라는지 말하세요. 어색한 1분이 넉 달보다 쌉니다.",
      },
      {
        type: "p",
        text: "「그냥 연락하는 사이」도 상대가 동의한 상태는 아닙니다. 생각보다 앞서 있을 수도, 훨씬 뒤에 있을 수도 있습니다. 끝나지 않는 단계는 단계가 아니게 됩니다. 아무도 고르지 않은 이름 없는 관계로 바뀌고, 그때쯤이면 대화는 3주 차보다 훨씬 무거워집니다.",
      },
    ],
  },

  zh: {
    term: "暧昧期",
    summary:
      "从配对到愿意称之为恋爱之间的那段时间：天天聊天，甚至已经见过面，却仍然把对方形容成“只是在聊的人”。",
    blocks: [
      { type: "h2", text: "这段时期是怎么来的" },
      {
        type: "p",
        text: "交友软件把一段关系的开头拉长了。你可以同时和好几个人在聊，目前谁都没有付出什么，也没有人愿意宣称超过事实的东西。于是出现了一个过渡的说法：说“最近在跟一个人聊”，表明了兴趣，却不表明决定。上一辈也有同样的阶段，只是没有名字，所以没人需要解释它为什么这么久。",
      },
      {
        type: "p",
        text: "用得好的话，这是认识一个人最有用的部分。什么都没定下来，所以你能看到对方不需要表演时的样子：计划泡汤时他怎么处理，他会不会也反过来问你。几周就够看清楚了。如果已经见过几次，这个阶段能告诉你的，基本都告诉你了。",
      },
      { type: "h2", text: "什么时候它不再是一个阶段" },
      {
        type: "ul",
        items: [
          "已经超过两个月，你们谁都没有换过另一个说法。",
          "消息从不间断，见面却永远是下周。",
          "不同的朋友问起时，你对他的描述并不一样。",
          "每往前一步，就有一个人退回到聊天框里。",
        ],
      },
      { type: "h2", text: "怎么往前推一步", accent: "green" },
      {
        type: "p",
        text: "约一次有具体日期的见面，就在下一周，别说“改天”。早点把对话挪出软件；软件本身在奖励你留在里面。问你真正想知道的事，而不是你能想到的最俏皮的一句。第三次见面之后如果还叫“在聊”，就说出你希望它变成什么。尴尬一分钟，比再等四个月便宜。",
      },
      {
        type: "p",
        text: "“我们只是在聊”也不是对方点头同意过的状态：他可能比你以为的走得更远，也可能远远落在后面。一个永远不结束的阶段就不再是阶段了——它会变成一段没人选择过的、没有名字的关系，到那时再开口，比第三周难得多。",
      },
    ],
  },

  nl: {
    term: "Talking stage",
    summary:
      "De periode tussen de match en het moment dat je het daten noemt: je appt onophoudelijk, ziet elkaar misschien al, en beschrijft de ander nog steeds als iemand met wie je gewoon praat.",
    blocks: [
      { type: "h2", text: "Waar deze fase vandaan komt" },
      {
        type: "p",
        text: "Apps hebben het begin van een relatie flink opgerekt. Je kunt met meerdere mensen tegelijk in gesprek zijn, het kost nog niets, en niemand wil meer beweren dan waar is. Zo ontstond een tussenwoord. Zeggen dat je met iemand praat meldt interesse zonder een beslissing te melden. Vorige generaties hadden precies dezelfde fase, alleen zonder naam, dus niemand hoefde uit te leggen waarom die zo lang duurde.",
      },
      {
        type: "p",
        text: "Goed gebruikt is dit het nuttigste stuk van daten. Er is niets besloten, dus je ziet hoe iemand praat als er niets te presteren valt: wat er gebeurt als een plan afketst, of er iets teruggevraagd wordt. Een paar weken doen dat werk. Na een paar keer afspreken heeft de fase gezegd wat ze zeggen kon.",
      },
      { type: "h2", text: "Wanneer het geen fase meer is" },
      {
        type: "ul",
        items: [
          "Het loopt langer dan twee maanden en geen van beiden heeft een ander woord gebruikt.",
          "Het appen is constant, maar afspreken is altijd volgende week.",
          "Je beschrijft die persoon anders, afhankelijk van welke vriendin het vraagt.",
          "Elke keer dat het een stap verder gaat, trekt een van jullie zich terug in de chat.",
        ],
      },
      { type: "h2", text: "Hoe je verder komt", accent: "green" },
      {
        type: "p",
        text: "Maak één afspraak met een echte datum in de komende week, geen \"binnenkort\". Haal het gesprek vroeg uit de app; de app beloont binnen blijven. Vraag iets wat je echt wilt weten in plaats van de grappigste zin die je kunt bedenken. En als het na de derde keer afspreken nog steeds talking stage heet: zeg wat je zou willen dat het is. Eén ongemakkelijke minuut is goedkoper dan vier maanden extra.",
      },
      {
        type: "p",
        text: "\"We praten gewoon\" is ook geen status waar de ander mee ingestemd heeft — die kan verder zijn dan je denkt, of juist een stuk minder ver. Een fase die nooit eindigt blijft geen fase: het wordt een naamloze afspraak die niemand gekozen heeft, en dan is het gesprek zwaarder dan in week drie.",
      },
    ],
  },

  pl: {
    term: "Talking stage",
    summary:
      "Odcinek między dopasowaniem a nazwaniem tego chodzeniem ze sobą: piszecie bez przerwy, może już się spotykacie, a drugą osobę wciąż opisujesz jako kogoś, z kim po prostu rozmawiasz.",
    blocks: [
      { type: "h2", text: "Skąd wzięła się ta faza" },
      {
        type: "p",
        text: "Aplikacje rozciągnęły początek relacji. Można rozmawiać z kilkoma osobami naraz, nic to jeszcze nie kosztuje, a nikt nie chce ogłaszać więcej, niż jest prawdą. Tak powstało słowo na przeczekanie. Powiedzieć, że z kimś rozmawiasz, to zgłosić zainteresowanie bez zgłaszania decyzji. Starsze pokolenia miały tę samą fazę, tyle że bez nazwy, więc nikt nie musiał tłumaczyć, czemu tak długo trwa.",
      },
      {
        type: "p",
        text: "Dobrze wykorzystana, to najbardziej przydatny fragment poznawania kogoś. Nic nie jest ustalone, więc widzisz, jak ktoś mówi, kiedy nie musi niczego odgrywać: co robi, gdy plan się sypie, czy pyta cię o cokolwiek z powrotem. Kilka tygodni na to wystarczy. Po paru spotkaniach ta faza powiedziała już, co miała do powiedzenia.",
      },
      { type: "h2", text: "Kiedy to przestaje być faza" },
      {
        type: "ul",
        items: [
          "Trwa dłużej niż dwa miesiące i żadne z was nie użyło innego słowa.",
          "Pisanie jest nieprzerwane, a spotkanie zawsze wypada w przyszłym tygodniu.",
          "Opisujesz tę osobę inaczej w zależności od tego, która koleżanka pyta.",
          "Za każdym razem, gdy robi się krok naprzód, jedno z was wycofuje się do czatu.",
        ],
      },
      { type: "h2", text: "Jak ruszyć z miejsca", accent: "green" },
      {
        type: "p",
        text: "Umów jedno spotkanie z konkretną datą w najbliższym tygodniu, nie \"kiedyś tam\". Wyprowadź rozmowę z aplikacji wcześnie; aplikacja nagradza tych, którzy w niej zostają. Zapytaj o coś, co naprawdę chcesz wiedzieć, zamiast o najzabawniejsze, co przyjdzie ci do głowy. A jeśli po trzecim spotkaniu to nadal talking stage, powiedz, czym chciałabyś, żeby to było. Jedna niezręczna minuta kosztuje mniej niż cztery kolejne miesiące.",
      },
      {
        type: "p",
        text: "\"Po prostu rozmawiamy\" też nie jest statusem, na który druga osoba się zgodziła: może być dalej, niż zakładasz, albo znacznie z tyłu. Faza, która się nie kończy, przestaje być fazą — zmienia się w bezimienny układ, którego nikt nie wybrał, a rozmowa waży wtedy o wiele więcej niż w trzecim tygodniu.",
      },
    ],
  },

  sv: {
    term: "Talking stage",
    summary:
      "Sträckan mellan matchningen och att kalla det för dejtande: ni skriver oavbrutet, ses kanske redan, och beskriver ändå den andra som någon ni bara pratar med.",
    blocks: [
      { type: "h2", text: "Varför den här fasen finns" },
      {
        type: "p",
        text: "Apparna har töjt ut början på en relation. Du kan ha flera samtal igång samtidigt, inget av det kostar något än, och ingen vill påstå mer än vad som är sant. Så uppstod ett väntande ord. Att säga att du pratar med någon signalerar intresse utan att signalera ett beslut. Tidigare generationer hade samma fas — den saknade bara namn, så ingen behövde försvara hur länge den pågick.",
      },
      {
        type: "p",
        text: "Använd rätt är det den nyttigaste delen av att dejta. Ingenting är bestämt, så du ser hur någon pratar när det inte finns något att spela: vad som händer när en plan spricker, om du får någon fråga tillbaka. Några veckor räcker för det. Efter ett par träffar har fasen sagt det den kan säga.",
      },
      { type: "h2", text: "När det har slutat vara en fas" },
      {
        type: "ul",
        items: [
          "Det har pågått i över två månader och ingen av er har använt ett annat ord.",
          "Skrivandet är oavbrutet, men träffen ligger alltid nästa vecka.",
          "Du beskriver personen olika beroende på vilken vän som frågar.",
          "Varje gång det tar ett steg framåt drar sig någon av er tillbaka in i chatten.",
        ],
      },
      { type: "h2", text: "Hur du får det att röra sig", accent: "green" },
      {
        type: "p",
        text: "Boka en enda träff med ett riktigt datum inom den närmaste veckan, inte ett \"snart\". Flytta samtalet ut ur appen tidigt; appen belönar dem som stannar kvar. Fråga något du faktiskt vill veta i stället för det roligaste du kommer på. Och om det efter tredje träffen fortfarande heter talking stage: säg vad du skulle vilja att det var. En obekväm minut är billigare än fyra månader till.",
      },
      {
        type: "p",
        text: "\"Vi bara pratar\" är inte heller en status den andra har godkänt — hen kan vara längre fram än du tror, eller en bra bit efter. En fas som aldrig tar slut förblir ingen fas: den blir en namnlös uppgörelse som ingen har valt, och då väger samtalet mycket mer än det gjorde vecka tre.",
      },
    ],
  },

  hi: {
    term: "टॉकिंग स्टेज",
    summary:
      "मैच होने से लेकर इसे डेटिंग कहने तक का दौर: बातचीत लगातार चलती है, मुलाकात भी हो चुकी होती है, फिर भी सामने वाले को “बस बात हो रही है” कहकर बताया जाता है।",
    blocks: [
      { type: "h2", text: "यह दौर आया कहां से" },
      {
        type: "p",
        text: "ऐप्स ने रिश्ते की शुरुआत को लंबा खींच दिया। आप एक साथ कई लोगों से बात कर सकते हैं, अभी किसी का कोई मोल नहीं चुकाया गया है, और कोई भी सच से ज्यादा दावा नहीं करना चाहता। इसलिए इंतजार का एक शब्द बन गया। यह कहना कि “किसी से बात चल रही है”, दिलचस्पी बता देता है, फैसला नहीं। पहले की पीढ़ियों में भी यही दौर था, बस उसका नाम नहीं था, इसलिए किसी को उसकी लंबाई की सफाई नहीं देनी पड़ती थी।",
      },
      {
        type: "p",
        text: "ठीक से इस्तेमाल हो तो यह किसी को जानने का सबसे काम का हिस्सा है। कुछ तय नहीं है, इसलिए दिखता है कि जब कुछ दिखाना नहीं होता तो सामने वाला कैसे बात करता है: प्लान टूटने पर वह क्या करता है, आपसे भी कुछ पूछता है या नहीं। कुछ हफ्ते इसके लिए काफी हैं। दो-तीन मुलाकातों के बाद यह दौर अपनी बात कह चुका होता है।",
      },
      { type: "h2", text: "यह दौर कब दौर नहीं रह जाता" },
      {
        type: "ul",
        items: [
          "दो महीने से ज्यादा हो गए और आप दोनों ने कोई दूसरा शब्द इस्तेमाल नहीं किया।",
          "मैसेज लगातार आते-जाते हैं, पर मिलना हमेशा अगले हफ्ते है।",
          "कौन दोस्त पूछ रहा है, उसी हिसाब से आप उसका जिक्र अलग-अलग तरह से करते हैं।",
          "जब भी बात एक कदम आगे बढ़ती है, आप में से कोई एक चैट में लौट जाता है।",
        ],
      },
      { type: "h2", text: "इसे आगे कैसे बढ़ाएं", accent: "green" },
      {
        type: "p",
        text: "“कभी मिलते हैं” नहीं, अगले हफ्ते की एक तारीख तय कीजिए। बातचीत को जल्दी ऐप से बाहर ले जाइए; ऐप के अंदर बने रहने का इनाम ऐप ही देता है। सबसे चुटीली बात के बजाय वह पूछिए जो आप सचमुच जानना चाहते हैं। और तीसरी मुलाकात के बाद भी अगर इसे “बस बात हो रही है” ही कहा जा रहा है, तो बता दीजिए कि आप इसे क्या बनाना चाहते हैं। एक असहज मिनट, चार और महीनों से सस्ता पड़ता है।",
      },
      {
        type: "p",
        text: "“बस बात हो रही है” वह दर्जा भी नहीं है जिस पर सामने वाले ने हामी भरी हो — वह आपकी सोच से आगे भी हो सकता है और काफी पीछे भी। जो दौर कभी खत्म नहीं होता, वह दौर रहता ही नहीं: वह बिना नाम का ऐसा इंतजाम बन जाता है जिसे किसी ने चुना नहीं, और तब बात करना तीसरे हफ्ते से कहीं ज्यादा भारी हो जाता है।",
      },
    ],
  },
};
