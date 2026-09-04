import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Situationship — a connection with the shape of a relationship and no agreed
 * name for it.
 *
 * Judgement calls made here, so a later editor does not undo them by accident:
 *
 * - The page deliberately refuses to treat a situationship as a pathology. The
 *   dominant framing online is "you are being used"; that is a diagnosis, not a
 *   definition, and rule 7 of the authoring spec forbids it. Block 2 says
 *   plainly that many are honest, and the whole page turns on the *asymmetry*
 *   (two people in different stories) rather than on blame.
 * - No statistics. There is no sourced figure for how common situationships
 *   are, how long they last or what share end badly, so none is claimed. The
 *   Forbes Health / OnePoll burnout number is about dating-app burnout and
 *   would have been padding here, so it is not used.
 * - No Qulo angle. Situationships happen offline, at work and between people
 *   who met twenty years ago; a question quiz does not prevent one, so block 7
 *   is a reader takeaway instead. It points forward to hardballing (say what
 *   you want early) without naming the term, which is the arc this page shares
 *   with `talking-stage.ts` and `hardballing.ts`. The related-terms links at
 *   the foot of the page carry the navigation.
 *
 * Term names: the English loanword is what speakers actually use in tr, de, fr,
 * es, pt, it, nl, pl and sv, so it is kept. ar, ru, zh and hi get the native
 * rendering that actually circulates (zh "暧昧关系" is the standard phrase, not
 * a coinage); ja and ko use the established katakana/hangul transliterations.
 * Where the native word wins, the summary mentions the English one.
 */
export const situationship: LocalizedGlossaryEntry = {
  en: {
    term: "Situationship",
    summary:
      "A romantic connection with the shape of a relationship and none of the labels — the two people in it have never said out loud what it is, and often avoid the question on purpose.",
    blocks: [
      { type: "h2", text: "Why situationships happen" },
      {
        type: "p",
        text: "Almost nobody sits down and decides to be in one. They form because ambiguity is cheaper than a conversation. Asking what this is means risking an answer you do not want to hear, and while nobody asks, nothing has to end. So the weeks pass, a routine settles in, and the thing quietly becomes real without ever being named. Usually both people are doing this at once, each waiting for the other to go first.",
      },
      {
        type: "p",
        text: "It is worth saying that a situationship is not automatically a bad thing. Plenty of them are honest: two people who want something light, at the same time, with nobody keeping score. The trouble starts when the two of you are in different stories — one enjoying the present, the other paying in advance for a future that was never agreed.",
      },
      { type: "h2", text: "How to tell which one you are in" },
      {
        type: "ul",
        items: [
          "Plans never reach further than a few days out, and never include anyone else from their life.",
          "You have rehearsed the \"what are we\" conversation several times and never had it.",
          "When the subject does come up, it turns into a joke and the conversation moves on.",
          "You have to explain the whole arrangement before a friend can follow what you are describing.",
        ],
      },
      { type: "h2", text: "What to do about it", accent: "green" },
      {
        type: "p",
        text: "You do not need a label to get an answer. Ask one specific question instead of demanding a definition: are you seeing other people, do you want this to go somewhere? Say what you want first — that turns it into an offer rather than a test, and makes an honest answer much easier to give. Pick a calm, ordinary moment rather than the end of a long night, and ask once.",
      },
      {
        type: "p",
        text: "Whatever comes back, you stop paying for a future nobody promised you. And if it is the conversation itself that frightens you, notice this: the alternative is not a heavier talk in six months, it is saying early and out loud what you are looking for.",
      },
    ],
  },

  tr: {
    term: "Situationship",
    summary:
      "İlişkiye benzeyen ama adı konulmamış bir yakınlık: taraflar bunun ne olduğunu hiç açıkça söylememiştir, çoğu zaman da soruyu bilerek açmazlar.",
    blocks: [
      { type: "h2", text: "Neden bu kadar sık oluşuyor" },
      {
        type: "p",
        text: "Kimse oturup buna karar vermez. Belirsizlik, konuşmaktan ucuza geldiği için oluşur. \"Biz neyiz?\" diye sormak, duymak istemediğin cevabı göze almaktır; kimse sormadığı sürece de hiçbir şeyin bitmesi gerekmez. Haftalar geçer, bir düzen oturur, ilişki adı konulmadan gerçek olur. Genelde iki taraf da aynı anda bunu yapar; herkes diğerinin ilk adımı atmasını bekler.",
      },
      {
        type: "p",
        text: "Şunu da söylemek gerek: situationship kendiliğinden kötü bir şey değil. Çoğu gayet dürüsttür — iki kişi aynı anda hafif bir şey ister ve kimse kimseye puan tutmaz. Sorun, ikinizin farklı hikâyelerde olmasıyla başlar: biri anın tadını çıkarırken diğeri hiç konuşulmamış bir gelecek için peşin ödeme yapıyordur.",
      },
      { type: "h2", text: "Hangisinin içinde olduğunu nasıl anlarsın" },
      {
        type: "ul",
        items: [
          "Planlar birkaç günden öteye gitmiyor ve hayatındaki başka kimseyi kapsamıyor.",
          "\"Biz neyiz\" konuşmasını kafanda defalarca prova ettin ama bir kez bile yapmadın.",
          "Konu açıldığında şakaya bağlanıyor ve sohbet hemen başka yere kayıyor.",
          "Bir arkadaşının anlaması için önce bütün düzeneği baştan anlatman gerekiyor.",
        ],
      },
      { type: "h2", text: "Ne yapabilirsin", accent: "green" },
      {
        type: "p",
        text: "Cevap almak için etikete ihtiyacın yok. Tanım istemek yerine tek bir somut soru sor: başkalarıyla görüşüyor musun, bunun bir yere gitmesini istiyor musun? Önce kendi istediğini söyle — bu, soruyu sınav olmaktan çıkarıp teklife dönüştürür ve karşındakinin dürüst cevap vermesini kolaylaştırır. Gecenin sonunu değil, sakin ve sıradan bir anı seç; bir kez sor.",
      },
      {
        type: "p",
        text: "Cevap ne olursa olsun, kimsenin söz vermediği bir gelecek için ödeme yapmayı bırakırsın. Seni asıl korkutan o konuşmanın kendisiyse şunu fark et: alternatif, altı ay sonra daha ağır bir konuşma yapmak değil; ne aradığını en baştan, yüksek sesle söylemek.",
      },
    ],
  },

  de: {
    term: "Situationship",
    summary:
      "Eine Verbindung, die alles von einer Beziehung hat außer dem Namen: Die beiden haben nie ausgesprochen, was das eigentlich ist, und weichen der Frage oft bewusst aus.",
    blocks: [
      { type: "h2", text: "Warum Situationships entstehen" },
      {
        type: "p",
        text: "Kaum jemand entscheidet sich bewusst dafür. Sie entstehen, weil Unklarheit billiger ist als ein Gespräch. Zu fragen, was das hier ist, heißt eine Antwort zu riskieren, die man nicht hören will — und solange niemand fragt, muss auch nichts enden. Die Wochen vergehen, eine Routine stellt sich ein, und die Sache wird echt, ohne je einen Namen bekommen zu haben. Meist tun das beide gleichzeitig und warten aufeinander.",
      },
      {
        type: "p",
        text: "Dabei ist ein Situationship nicht automatisch schlecht. Viele sind völlig ehrlich: zwei Menschen, die zur selben Zeit etwas Leichtes wollen, ohne heimliche Buchführung. Schwierig wird es erst, wenn ihr in verschiedenen Geschichten steckt — die eine genießt die Gegenwart, der andere zahlt im Voraus für eine Zukunft, die nie vereinbart wurde.",
      },
      { type: "h2", text: "Woran du erkennst, in welchem du steckst" },
      {
        type: "ul",
        items: [
          "Pläne reichen nie weiter als ein paar Tage und schließen nie jemanden aus dem übrigen Leben ein.",
          "Du hast das Gespräch über euren Status schon oft im Kopf geprobt und nie geführt.",
          "Kommt die Frage doch auf, wird sie zum Witz gemacht und das Thema gewechselt.",
          "Du musst erst die ganze Konstruktion erklären, bevor eine Freundin versteht, worum es geht.",
        ],
      },
      { type: "h2", text: "Was du tun kannst", accent: "green" },
      {
        type: "p",
        text: "Für eine Antwort brauchst du kein Etikett. Stell statt einer Definition eine konkrete Frage: Triffst du dich auch mit anderen? Willst du, dass daraus etwas wird? Sag zuerst, was du selbst möchtest — das macht daraus ein Angebot statt einer Prüfung und erleichtert eine ehrliche Antwort erheblich. Such dir einen ruhigen, gewöhnlichen Moment, nicht das Ende einer langen Nacht, und frag einmal.",
      },
      {
        type: "p",
        text: "Wie die Antwort auch ausfällt: Du hörst auf, für eine Zukunft zu zahlen, die dir niemand versprochen hat. Und wenn dich schon der Gedanke an dieses Gespräch schreckt, dann merke — die Alternative ist kein schwereres Gespräch in einem halben Jahr, sondern früh und deutlich zu sagen, was du suchst.",
      },
    ],
  },

  fr: {
    term: "Situationship",
    summary:
      "Une histoire qui a toute la forme d'une relation et aucune étiquette : les deux personnes n'ont jamais dit à voix haute ce que c'était, et évitent souvent la question exprès.",
    blocks: [
      { type: "h2", text: "Pourquoi ça arrive" },
      {
        type: "p",
        text: "Presque personne ne choisit délibérément d'y entrer. Ces histoires naissent parce que le flou coûte moins cher qu'une conversation. Demander ce qu'on est, c'est risquer une réponse qu'on ne veut pas entendre — et tant que personne ne demande, rien n'a besoin de s'arrêter. Les semaines passent, une routine s'installe, et la chose devient réelle sans jamais avoir été nommée. Souvent, les deux attendent que l'autre commence.",
      },
      {
        type: "p",
        text: "Il faut le dire : une situationship n'est pas mauvaise en soi. Beaucoup sont parfaitement honnêtes — deux personnes qui veulent quelque chose de léger, au même moment, sans compter les points. Le problème commence quand vous n'êtes pas dans la même histoire : l'une profite du présent, l'autre paie d'avance pour un avenir qui n'a jamais été convenu.",
      },
      { type: "h2", text: "Comment savoir dans laquelle vous êtes" },
      {
        type: "ul",
        items: [
          "Les projets ne dépassent jamais quelques jours et n'incluent jamais personne d'autre de sa vie.",
          "Vous avez répété la conversation sur votre statut dans votre tête sans jamais l'avoir.",
          "Quand la question surgit malgré tout, elle devient une blague et on passe à autre chose.",
          "Il vous faut expliquer tout le montage avant qu'un ami comprenne de quoi vous parlez.",
        ],
      },
      { type: "h2", text: "Que faire", accent: "green" },
      {
        type: "p",
        text: "Pas besoin d'étiquette pour obtenir une réponse. Posez une question précise plutôt que d'exiger une définition : est-ce que tu vois d'autres personnes, est-ce que tu veux que ça aille quelque part ? Dites d'abord ce que vous voulez, vous — ça en fait une proposition plutôt qu'un test, et une réponse sincère devient beaucoup plus simple. Choisissez un moment calme et ordinaire, et demandez une fois.",
      },
      {
        type: "p",
        text: "Quelle que soit la réponse, vous arrêtez de payer pour un avenir que personne ne vous a promis. Et si c'est l'idée même de cette conversation qui vous effraie, remarquez ceci : l'alternative n'est pas une discussion plus lourde dans six mois, c'est dire tôt et clairement ce que vous cherchez.",
      },
    ],
  },

  es: {
    term: "Situationship",
    summary:
      "Un vínculo con toda la forma de una relación y ninguna etiqueta: las dos personas nunca han dicho en voz alta qué es esto y muchas veces esquivan la pregunta a propósito.",
    blocks: [
      { type: "h2", text: "Por qué aparecen" },
      {
        type: "p",
        text: "Casi nadie decide meterse en una. Aparecen porque la ambigüedad sale más barata que una conversación. Preguntar qué sois implica arriesgarse a una respuesta que no quieres oír, y mientras nadie pregunte, nada tiene que terminar. Pasan las semanas, se asienta una rutina y la cosa se vuelve real sin haber sido nombrada nunca. Lo normal es que los dos hagan lo mismo a la vez.",
      },
      {
        type: "p",
        text: "Conviene decirlo: una situationship no es mala por definición. Muchas son honestas — dos personas que quieren algo ligero, al mismo tiempo, sin que nadie lleve las cuentas. El problema empieza cuando cada uno está en una historia distinta: uno disfruta del presente y el otro paga por adelantado un futuro que nadie acordó.",
      },
      { type: "h2", text: "Cómo saber en cuál estás" },
      {
        type: "ul",
        items: [
          "Los planes nunca pasan de unos días y nunca incluyen a nadie más de su vida.",
          "Has ensayado la conversación del \"qué somos\" varias veces y nunca la has tenido.",
          "Cuando el tema sale, se convierte en broma y la conversación cambia de rumbo.",
          "Tienes que explicar todo el montaje antes de que una amiga entienda de qué hablas.",
        ],
      },
      { type: "h2", text: "Qué hacer", accent: "green" },
      {
        type: "p",
        text: "No hace falta una etiqueta para conseguir una respuesta. Haz una pregunta concreta en lugar de pedir una definición: ¿estás viendo a otras personas?, ¿quieres que esto vaya a algún sitio? Di primero lo que quieres tú — así se convierte en una propuesta y no en un examen, y responder con sinceridad resulta mucho más fácil. Elige un momento tranquilo y corriente, y pregunta una vez.",
      },
      {
        type: "p",
        text: "Sea cual sea la respuesta, dejas de pagar por un futuro que nadie te prometió. Y si lo que te da miedo es la conversación misma, fíjate en esto: la alternativa no es una charla más pesada dentro de seis meses, sino decir pronto y en voz alta qué estás buscando.",
      },
    ],
  },

  ar: {
    term: "علاقة غير مُعرَّفة",
    summary:
      "ارتباط له كل ملامح العلاقة وليس له اسم؛ لم يقل الطرفان بصوت عالٍ ما هذا الذي بينهما، وكثيرًا ما يتجنّبان السؤال عمدًا. يسمّيه الناس بالإنجليزية situationship.",
    blocks: [
      { type: "h2", text: "لماذا تنشأ هذه العلاقات" },
      {
        type: "p",
        text: "لا أحد تقريبًا يقرّر الدخول فيها. تنشأ لأن الغموض أرخص من محادثة صريحة: أن تسأل «ما نحن؟» يعني أن تخاطر بجواب لا تريد سماعه، وما دام لم يسأل أحد فلا شيء مضطر إلى الانتهاء. تمرّ الأسابيع، تستقرّ عادة يومية، ويصير الأمر حقيقيًا دون أن يُسمّى. وغالبًا يفعل الطرفان ذلك معًا، كلٌّ ينتظر أن يبدأ الآخر.",
      },
      {
        type: "p",
        text: "ويجب أن يُقال: العلاقة غير المعرَّفة ليست سيئة بالضرورة. كثير منها صادق تمامًا — شخصان يريدان شيئًا خفيفًا في الوقت نفسه، ولا أحد يحسب النقاط. تبدأ المشكلة حين تكونان في حكايتين مختلفتين: أحدكما يستمتع بالحاضر، والآخر يدفع مقدَّمًا ثمن مستقبل لم يُتَّفق عليه أبدًا.",
      },
      { type: "h2", text: "كيف تعرف أيّهما تعيش" },
      {
        type: "ul",
        items: [
          "الخطط لا تتجاوز أيامًا قليلة، ولا تشمل أحدًا آخر من حياته.",
          "تدرّبت على محادثة «ما نحن؟» في رأسك مرارًا ولم تُجرِها ولا مرة.",
          "حين يُطرح الموضوع يتحوّل إلى مزحة ثم ينتقل الحديث إلى شيء آخر.",
          "تحتاج إلى شرح الترتيب كلّه قبل أن يفهم صديقك عمّا تتحدث.",
        ],
      },
      { type: "h2", text: "ما الذي يمكن فعله", accent: "green" },
      {
        type: "p",
        text: "لا تحتاج إلى تسمية كي تحصل على جواب. اسأل سؤالًا محدَّدًا بدل طلب تعريف: هل تقابل أشخاصًا آخرين؟ هل تريد لهذا أن يمضي إلى مكان ما؟ قل أولًا ما تريده أنت — هكذا يصبح السؤال عرضًا لا اختبارًا، ويصير الجواب الصادق أسهل بكثير. اختر لحظة هادئة عادية، لا نهاية سهرة طويلة، واسأل مرة واحدة.",
      },
      {
        type: "p",
        text: "أيًّا كان الجواب، فأنت تتوقّف عن الدفع مقابل مستقبل لم يَعِدك به أحد. وإن كانت فكرة هذه المحادثة نفسها هي ما يخيفك، فانتبه: البديل ليس حديثًا أثقل بعد ستة أشهر، بل أن تقول مبكرًا وبوضوح ما الذي تبحث عنه.",
      },
    ],
  },

  ru: {
    term: "Ситуационшип",
    summary:
      "Связь, у которой есть все черты отношений и нет названия: двое ни разу не проговорили вслух, что это такое, и часто намеренно обходят вопрос стороной.",
    blocks: [
      { type: "h2", text: "Почему так получается" },
      {
        type: "p",
        text: "Почти никто не решает начать такое специально. Всё складывается само, потому что неопределённость обходится дешевле разговора. Спросить «кто мы друг другу» — значит рискнуть услышать ответ, который слышать не хочется, а пока никто не спрашивает, ничему не нужно заканчиваться. Проходят недели, появляется привычный ритм, и всё становится настоящим, так и не получив имени. Обычно оба ждут, что начнёт другой.",
      },
      {
        type: "p",
        text: "Важно сказать: ситуационшип не плох сам по себе. Многие такие истории честные — двоим одновременно хочется чего-то лёгкого, и никто не ведёт счёт. Проблемы начинаются, когда вы находитесь в разных историях: один радуется настоящему, другой заранее платит за будущее, о котором не договаривались.",
      },
      { type: "h2", text: "Как понять, в какой истории вы" },
      {
        type: "ul",
        items: [
          "Планы не уходят дальше пары дней и никогда не включают других людей из его жизни.",
          "Разговор «кто мы» вы много раз проговорили про себя и ни разу не начали вслух.",
          "Когда тема всё же всплывает, её переводят в шутку и меняют разговор.",
          "Чтобы подруга поняла, о чём речь, приходится сначала объяснить всю конструкцию.",
        ],
      },
      { type: "h2", text: "Что с этим делать", accent: "green" },
      {
        type: "p",
        text: "Чтобы получить ответ, ярлык не нужен. Задайте один конкретный вопрос вместо требования определения: ты встречаешься с кем-то ещё? хочешь, чтобы это к чему-то шло? Сначала скажите, чего хотите вы — так вопрос становится предложением, а не проверкой, и честно ответить намного проще. Выберите спокойный обычный момент, а не конец долгого вечера, и спросите один раз.",
      },
      {
        type: "p",
        text: "Каким бы ни был ответ, вы перестаёте платить за будущее, которое вам никто не обещал. А если пугает сам этот разговор, обратите внимание: альтернатива — не более тяжёлая беседа через полгода, а привычка говорить рано и вслух, чего вы ищете.",
      },
    ],
  },

  pt: {
    term: "Situationship",
    summary:
      "Uma ligação com todo o formato de um relacionamento e nenhum rótulo: as duas pessoas nunca disseram em voz alta o que aquilo é e muitas vezes desviam da pergunta de propósito.",
    blocks: [
      { type: "h2", text: "Por que isso acontece" },
      {
        type: "p",
        text: "Quase ninguém decide entrar numa. Elas se formam porque a ambiguidade sai mais barata do que uma conversa. Perguntar o que vocês são é arriscar uma resposta que você não quer ouvir — e enquanto ninguém pergunta, nada precisa acabar. As semanas passam, uma rotina se instala e a coisa vira real sem nunca ter recebido um nome. Normalmente os dois fazem isso ao mesmo tempo, cada um esperando o outro começar.",
      },
      {
        type: "p",
        text: "Vale dizer: situationship não é ruim por definição. Muitas são honestas — duas pessoas que querem algo leve, ao mesmo tempo, sem ninguém contando pontos. O problema começa quando vocês estão em histórias diferentes: uma aproveita o presente, a outra paga adiantado por um futuro que jamais foi combinado.",
      },
      { type: "h2", text: "Como saber em qual você está" },
      {
        type: "ul",
        items: [
          "Os planos nunca passam de alguns dias e nunca incluem mais ninguém da vida dela.",
          "Você já ensaiou a conversa do \"o que somos\" várias vezes e nunca teve essa conversa.",
          "Quando o assunto aparece, vira piada e o papo muda de rumo.",
          "Você precisa explicar o arranjo inteiro antes de um amigo entender do que se trata.",
        ],
      },
      { type: "h2", text: "O que fazer", accent: "green" },
      {
        type: "p",
        text: "Você não precisa de rótulo para conseguir uma resposta. Faça uma pergunta específica em vez de exigir uma definição: você está saindo com outras pessoas? você quer que isso vá para algum lugar? Diga primeiro o que você quer — isso transforma a pergunta em proposta e não em teste, e facilita muito uma resposta sincera. Escolha um momento calmo e comum, e pergunte uma vez.",
      },
      {
        type: "p",
        text: "Seja qual for a resposta, você para de pagar por um futuro que ninguém prometeu. E se o que assusta é a conversa em si, repare: a alternativa não é um papo mais pesado daqui a seis meses, é dizer cedo e em voz alta o que você está procurando.",
      },
    ],
  },

  it: {
    term: "Situationship",
    summary:
      "Un legame che ha tutta la forma di una relazione e nessuna etichetta: i due non si sono mai detti ad alta voce che cosa sia, e spesso evitano la domanda di proposito.",
    blocks: [
      { type: "h2", text: "Perché nascono" },
      {
        type: "p",
        text: "Quasi nessuno decide di entrarci. Nascono perché l'ambiguità costa meno di una conversazione. Chiedere che cosa siamo significa rischiare una risposta che non si vuole sentire, e finché nessuno chiede non deve finire niente. Passano le settimane, si crea un'abitudine e la cosa diventa reale senza essere mai stata nominata. Di solito lo fanno entrambi, ciascuno aspettando che cominci l'altro.",
      },
      {
        type: "p",
        text: "Va detto: una situationship non è brutta per definizione. Molte sono oneste — due persone che vogliono qualcosa di leggero, nello stesso momento, senza tenere il conto. Il problema comincia quando siete dentro due storie diverse: uno si gode il presente, l'altra paga in anticipo un futuro che nessuno ha mai concordato.",
      },
      { type: "h2", text: "Come capire in quale ti trovi" },
      {
        type: "ul",
        items: [
          "I programmi non vanno mai oltre qualche giorno e non coinvolgono mai nessun altro della sua vita.",
          "Hai provato mentalmente il discorso sul \"che cosa siamo\" più volte e non l'hai mai fatto.",
          "Quando l'argomento salta fuori diventa una battuta e si cambia discorso.",
          "Devi spiegare tutto l'impianto prima che un amico capisca di che cosa parli.",
        ],
      },
      { type: "h2", text: "Che cosa puoi fare", accent: "green" },
      {
        type: "p",
        text: "Per avere una risposta non serve un'etichetta. Fai una domanda precisa invece di chiedere una definizione: stai vedendo altre persone? vuoi che questa cosa vada da qualche parte? Di' prima che cosa vuoi tu — così diventa una proposta e non un esame, e rispondere sinceramente è molto più facile. Scegli un momento tranquillo e qualunque, e chiedi una volta sola.",
      },
      {
        type: "p",
        text: "Qualunque sia la risposta, smetti di pagare per un futuro che nessuno ti ha promesso. E se a spaventarti è proprio quella conversazione, nota una cosa: l'alternativa non è un discorso più pesante fra sei mesi, ma dire presto e ad alta voce che cosa cerchi.",
      },
    ],
  },

  ja: {
    term: "シチュエーションシップ",
    summary:
      "恋愛のかたちはあるのに名前だけがない関係。ふたりとも「これは何なのか」を口に出して確かめたことがなく、その質問をわざと避けていることも多い。",
    blocks: [
      { type: "h2", text: "なぜ生まれるのか" },
      {
        type: "p",
        text: "自分から進んで始める人はほとんどいません。曖昧なままでいるほうが、話し合うより安上がりだから生まれます。「私たちは何なの」と聞くのは、聞きたくない答えを引き受けるということでもある。誰も聞かないかぎり、何かが終わる必要もない。そうして週が過ぎ、生活のリズムができ、名前のないまま関係だけが本物になっていきます。たいていは二人とも同じことをしていて、相手が先に切り出すのを待っています。",
      },
      {
        type: "p",
        text: "ただ、シチュエーションシップが必ず悪いわけではありません。正直なものもたくさんあります。ふたりとも同じ時期に軽い関係を望んでいて、どちらも点数をつけていない。問題が始まるのは、ふたりが別々の物語の中にいるときです。片方は今を楽しみ、もう片方は約束されていない未来に前払いしている。",
      },
      { type: "h2", text: "自分がどちらにいるかの見分け方" },
      {
        type: "ul",
        items: [
          "予定はいつも数日先まで。相手の生活にいる他の人が出てくることはない。",
          "「私たちは何なの」という会話を頭の中で何度も練習して、一度もしていない。",
          "話題が出ても冗談にされ、すぐ別の話に移る。",
          "友だちに理解してもらうには、まず関係の仕組みを一から説明しないといけない。",
        ],
      },
      { type: "h2", text: "どうすればいいか", accent: "green" },
      {
        type: "p",
        text: "答えをもらうのに肩書きはいりません。定義を求める代わりに、具体的な質問をひとつだけ。他の人とも会っているのか。この関係を先に進めたいのか。まず自分の望みを先に言うこと。そうすれば質問はテストではなく提案になり、相手も正直に答えやすくなります。飲んだ帰り道ではなく、静かでふつうの時間を選んで、一度だけ聞いてください。",
      },
      {
        type: "p",
        text: "どんな答えでも、誰も約束していない未来への支払いはそこで止まります。もしその会話自体が怖いなら、こう考えてみてください。代わりになるのは半年後のもっと重い話ではなく、何を求めているのかを早いうちに声に出しておくことです。",
      },
    ],
  },

  ko: {
    term: "시추에이션십",
    summary:
      "연애의 형태는 다 갖췄지만 이름만 없는 관계. 두 사람 모두 이게 뭔지 소리 내어 정한 적이 없고, 그 질문을 일부러 피하는 경우도 많다.",
    blocks: [
      { type: "h2", text: "왜 생기는가" },
      {
        type: "p",
        text: "일부러 시작하는 사람은 거의 없습니다. 애매한 상태가 대화보다 싸게 먹히기 때문에 생깁니다. 「우리 뭐야?」라고 묻는 건 듣고 싶지 않은 대답을 감수하는 일이고, 아무도 묻지 않는 한 무엇도 끝날 필요가 없습니다. 몇 주가 지나고 익숙한 리듬이 생기면, 이름 없이도 관계만 진짜가 됩니다. 보통은 둘 다 상대가 먼저 꺼내주기를 기다립니다.",
      },
      {
        type: "p",
        text: "다만 시추에이션십이 그 자체로 나쁜 건 아닙니다. 정직한 경우도 많습니다. 같은 시기에 둘 다 가벼운 관계를 원하고, 아무도 점수를 매기지 않는 사이 말입니다. 문제는 서로 다른 이야기 속에 있을 때 시작됩니다. 한 사람은 현재를 즐기고, 다른 한 사람은 약속된 적 없는 미래에 미리 값을 치르고 있습니다.",
      },
      { type: "h2", text: "어느 쪽인지 알아보는 법" },
      {
        type: "ul",
        items: [
          "약속은 늘 며칠 앞까지만이고, 상대의 다른 사람들이 등장하는 자리는 없다.",
          "「우리 뭐야」라는 대화를 머릿속으로 여러 번 연습했지만 한 번도 하지 않았다.",
          "그 얘기가 나오면 농담으로 넘어가고 화제가 바뀐다.",
          "친구가 이해하려면 관계의 구조부터 처음부터 설명해야 한다.",
        ],
      },
      { type: "h2", text: "어떻게 하면 좋을까", accent: "green" },
      {
        type: "p",
        text: "답을 얻는 데 이름표가 필요하지는 않습니다. 정의를 요구하는 대신 구체적인 질문 하나를 하세요. 다른 사람도 만나고 있는지, 이 관계가 어딘가로 가기를 원하는지. 내가 원하는 걸 먼저 말하세요. 그러면 질문이 시험이 아니라 제안이 되고, 상대도 솔직하게 답하기 훨씬 쉬워집니다. 늦은 밤 끝자락 말고 평범하고 조용한 순간을 골라 한 번만 물어보세요.",
      },
      {
        type: "p",
        text: "어떤 대답이 오든, 아무도 약속하지 않은 미래에 값을 치르는 일은 거기서 끝납니다. 그 대화 자체가 두렵다면 이렇게 생각해 보세요. 대안은 반년 뒤의 더 무거운 대화가 아니라, 무엇을 원하는지 일찍 소리 내어 말해 두는 것입니다.",
      },
    ],
  },

  zh: {
    term: "暧昧关系",
    summary:
      "有恋爱之实却始终没有名分的关系：两个人从没把“我们算什么”说清楚，而且常常刻意绕开这个问题。英文里叫 situationship。",
    blocks: [
      { type: "h2", text: "为什么会变成这样" },
      {
        type: "p",
        text: "几乎没有人是主动选择进入这种关系的。它之所以出现，是因为含糊比一次坦白的对话便宜得多。问“我们算什么”，就意味着要承担一个自己并不想听到的答案；而只要没人问，就没有什么必须结束。几周过去，作息和习惯都对上了，关系没有名字却已经是真的。多数时候两个人都在等对方先开口。",
      },
      {
        type: "p",
        text: "话说回来，暧昧关系本身并不等于坏事。很多是坦诚的：两个人同时都只想要轻松的相处，谁也没在心里记账。真正的麻烦始于你们身处两个不同的故事——一个人享受当下，另一个人却在为从未被承诺的未来提前付款。",
      },
      { type: "h2", text: "怎么判断自己在哪一种里" },
      {
        type: "ul",
        items: [
          "所有安排都不超过几天，也从不涉及对方生活里的其他人。",
          "“我们算什么”这段对话你在心里排练过很多遍，却一次都没说出口。",
          "话题一旦被提起，就被岔成玩笑，然后转开。",
          "要让朋友听懂，你得先把整套关系结构从头解释一遍。",
        ],
      },
      { type: "h2", text: "可以怎么做", accent: "green" },
      {
        type: "p",
        text: "想要答案，并不需要先有名分。别去索取一个定义，问一个具体的问题就行：你还在见别人吗？你希望这段关系走到哪里？先说出你自己想要什么——这样它就成了一个提议，而不是一场考试，对方也更容易诚实回答。挑一个平常、安静的时刻，不要挑夜宵散场那会儿，问一次就够了。",
      },
      {
        type: "p",
        text: "无论答案是什么，你都不必再为一个没人承诺过的未来付款。如果让你害怕的正是这场对话，那就注意一点：替代方案不是半年后一场更沉重的谈话，而是很早就把自己在找什么大声说出来。",
      },
    ],
  },

  nl: {
    term: "Situationship",
    summary:
      "Een band met alle vormen van een relatie en geen enkel label: de twee hebben nooit hardop gezegd wat het is, en ontwijken die vraag vaak met opzet.",
    blocks: [
      { type: "h2", text: "Hoe het zover komt" },
      {
        type: "p",
        text: "Bijna niemand kiest er bewust voor. Ze ontstaan omdat vaagheid goedkoper is dan een gesprek. Vragen wat dit is, betekent een antwoord riskeren dat je liever niet hoort — en zolang niemand vraagt, hoeft er niets te eindigen. De weken gaan voorbij, er ontstaat een ritme, en het wordt echt zonder ooit een naam te krijgen. Meestal wachten allebei tot de ander begint.",
      },
      {
        type: "p",
        text: "En het moet gezegd: een situationship is niet vanzelf slecht. Veel ervan zijn eerlijk — twee mensen die tegelijk iets lichts willen, en niemand houdt bij wie wat gaf. Het wringt pas als jullie in verschillende verhalen zitten: de een geniet van het heden, de ander betaalt vooruit voor een toekomst die nooit is afgesproken.",
      },
      { type: "h2", text: "Hoe je weet in welke je zit" },
      {
        type: "ul",
        items: [
          "Plannen gaan nooit verder dan een paar dagen en betrekken nooit iemand anders uit haar leven.",
          "Je hebt het gesprek over wat jullie zijn vaak in je hoofd geoefend en nooit gevoerd.",
          "Komt het onderwerp toch op tafel, dan wordt het een grap en gaat het over iets anders.",
          "Je moet eerst de hele constructie uitleggen voordat een vriendin snapt waar het over gaat.",
        ],
      },
      { type: "h2", text: "Wat je kunt doen", accent: "green" },
      {
        type: "p",
        text: "Voor een antwoord heb je geen label nodig. Stel één concrete vraag in plaats van een definitie te eisen: zie je ook anderen? Wil je dat dit ergens heen gaat? Zeg eerst wat jij wilt — daarmee wordt het een voorstel in plaats van een test, en wordt eerlijk antwoorden een stuk makkelijker. Kies een rustig, gewoon moment en vraag het één keer.",
      },
      {
        type: "p",
        text: "Wat het antwoord ook is, je stopt met betalen voor een toekomst die niemand je beloofd heeft. En als juist dat gesprek je afschrikt: het alternatief is geen zwaarder gesprek over een halfjaar, maar vroeg en hardop zeggen wat je zoekt.",
      },
    ],
  },

  pl: {
    term: "Situationship",
    summary:
      "Relacja, która ma wszystkie cechy związku i żadnej nazwy: nikt z tej dwójki nigdy nie powiedział na głos, czym to jest, a pytanie bywa omijane celowo.",
    blocks: [
      { type: "h2", text: "Skąd się to bierze" },
      {
        type: "p",
        text: "Prawie nikt nie decyduje się na to świadomie. Takie układy powstają, bo niejasność kosztuje mniej niż rozmowa. Zapytać, czym jesteśmy, to zaryzykować odpowiedź, której nie chce się usłyszeć — a dopóki nikt nie pyta, nic nie musi się kończyć. Mijają tygodnie, wchodzi rutyna i rzecz staje się prawdziwa, choć nigdy nie została nazwana. Zwykle oboje czekają, aż zacznie ta druga osoba.",
      },
      {
        type: "p",
        text: "Trzeba to powiedzieć: situationship nie jest zły z definicji. Wiele takich historii jest uczciwych — dwoje ludzi chce w tym samym czasie czegoś lekkiego i nikt nie liczy punktów. Kłopot zaczyna się wtedy, gdy jesteście w różnych opowieściach: jedno cieszy się teraźniejszością, drugie płaci z góry za przyszłość, której nikt nie obiecał.",
      },
      { type: "h2", text: "Jak poznać, w którym jesteś" },
      {
        type: "ul",
        items: [
          "Plany nie sięgają dalej niż kilka dni i nigdy nie obejmują nikogo innego z jego życia.",
          "Rozmowę o tym, czym jesteście, przećwiczyłaś w głowie wiele razy i nigdy jej nie odbyłaś.",
          "Kiedy temat jednak wypływa, zamienia się w żart i schodzi na coś innego.",
          "Żeby znajoma zrozumiała, musisz najpierw wyjaśnić całą konstrukcję od początku.",
        ],
      },
      { type: "h2", text: "Co można z tym zrobić", accent: "green" },
      {
        type: "p",
        text: "Żeby dostać odpowiedź, nie potrzebujesz etykiety. Zamiast żądać definicji, zadaj jedno konkretne pytanie: widujesz się z kimś jeszcze? chcesz, żeby to gdzieś poszło? Najpierw powiedz, czego chcesz ty — wtedy to propozycja, a nie egzamin, i o wiele łatwiej odpowiedzieć szczerze. Wybierz spokojny, zwyczajny moment, nie koniec długiego wieczoru, i zapytaj raz.",
      },
      {
        type: "p",
        text: "Jakakolwiek będzie odpowiedź, przestajesz płacić za przyszłość, której nikt ci nie obiecał. A jeśli boisz się właśnie tej rozmowy, zauważ: alternatywą nie jest cięższy dialog za pół roku, tylko mówienie wcześnie i na głos, czego szukasz.",
      },
    ],
  },

  sv: {
    term: "Situationship",
    summary:
      "En förbindelse med relationens alla former och ingen etikett: de två har aldrig sagt högt vad det är, och undviker ofta frågan med flit.",
    blocks: [
      { type: "h2", text: "Varför de uppstår" },
      {
        type: "p",
        text: "Nästan ingen väljer det medvetet. De uppstår för att otydlighet är billigare än ett samtal. Att fråga vad det här är innebär att riskera ett svar man inte vill höra — och så länge ingen frågar behöver ingenting ta slut. Veckorna går, en vardag lägger sig till rätta, och saken blir verklig utan att någonsin ha fått ett namn. Oftast väntar båda på att den andra ska börja.",
      },
      {
        type: "p",
        text: "Och det ska sägas: ett situationship är inte dåligt i sig. Många är helt ärliga — två personer som samtidigt vill ha något lätt, och ingen håller räkning. Det skaver först när ni befinner er i olika berättelser: den ena njuter av nuet, den andra betalar i förskott för en framtid som aldrig har avtalats.",
      },
      { type: "h2", text: "Hur du vet vilken du är i" },
      {
        type: "ul",
        items: [
          "Planer sträcker sig aldrig längre än några dagar och rymmer aldrig någon annan ur hennes liv.",
          "Du har repeterat samtalet om vad ni är många gånger och aldrig tagit det.",
          "När frågan ändå dyker upp blir den ett skämt och samtalet byter spår.",
          "Du måste förklara hela upplägget innan en vän förstår vad du pratar om.",
        ],
      },
      { type: "h2", text: "Vad du kan göra", accent: "green" },
      {
        type: "p",
        text: "Du behöver ingen etikett för att få ett svar. Ställ en konkret fråga i stället för att kräva en definition: träffar du andra? vill du att det här ska gå någonstans? Säg först vad du själv vill — då blir det ett erbjudande i stället för ett prov, och mycket lättare att svara ärligt på. Välj ett lugnt, vanligt tillfälle, inte slutet av en lång kväll, och fråga en gång.",
      },
      {
        type: "p",
        text: "Oavsett svaret slutar du betala för en framtid som ingen har lovat dig. Och om det är själva samtalet som skrämmer: alternativet är inte ett tyngre samtal om ett halvår, utan att tidigt och högt säga vad du söker.",
      },
    ],
  },

  hi: {
    term: "सिचुएशनशिप",
    summary:
      "ऐसा रिश्ता जिसमें रिश्ते की हर बात है, बस नाम नहीं: दोनों ने कभी खुलकर नहीं कहा कि यह है क्या, और अक्सर वे यह सवाल जानबूझकर टाल जाते हैं।",
    blocks: [
      { type: "h2", text: "ऐसा होता क्यों है" },
      {
        type: "p",
        text: "कोई तय करके इसमें नहीं उतरता। यह इसलिए बनता है क्योंकि उलझन बनाए रखना बात करने से सस्ता पड़ता है। “हम हैं क्या” पूछने का मतलब है वह जवाब सुनने का जोखिम उठाना जो आप सुनना नहीं चाहते — और जब तक कोई पूछता नहीं, तब तक कुछ खत्म भी नहीं करना पड़ता। हफ्ते बीतते हैं, एक आदत बन जाती है, और बिना नाम के ही रिश्ता सच हो जाता है। आमतौर पर दोनों यही करते हैं और एक-दूसरे के शुरू करने का इंतजार करते हैं।",
      },
      {
        type: "p",
        text: "यह कहना भी जरूरी है कि सिचुएशनशिप अपने आप में बुरा नहीं होता। कई बार यह पूरी तरह ईमानदार होता है — दो लोग एक ही समय पर कुछ हल्का-फुल्का चाहते हैं और कोई हिसाब नहीं रखता। दिक्कत तब शुरू होती है जब आप दोनों अलग-अलग कहानियों में हों: एक आज का मजा ले रहा है, दूसरा उस भविष्य की कीमत पहले ही चुका रहा है जिसका वादा कभी हुआ ही नहीं।",
      },
      { type: "h2", text: "कैसे पहचानें कि आप किसमें हैं" },
      {
        type: "ul",
        items: [
          "प्लान कभी दो-चार दिन से आगे नहीं जाते और उनमें उसकी जिंदगी का कोई और शामिल नहीं होता।",
          "“हम हैं क्या” वाली बात आपने मन में कई बार दोहराई है, कभी की नहीं।",
          "बात उठती भी है तो मजाक में बदल जाती है और विषय पलट जाता है।",
          "दोस्त को समझाने के लिए पहले पूरा ढांचा शुरू से बताना पड़ता है।",
        ],
      },
      { type: "h2", text: "अब क्या करें", accent: "green" },
      {
        type: "p",
        text: "जवाब पाने के लिए किसी लेबल की जरूरत नहीं है। परिभाषा मांगने के बजाय एक सीधा सवाल पूछिए: क्या तुम किसी और से भी मिल रहे हो? क्या तुम चाहते हो कि यह कहीं पहुंचे? पहले अपनी बात रखिए — इससे सवाल इम्तिहान नहीं, एक प्रस्ताव बन जाता है और सच बोलना आसान हो जाता है। देर रात के बजाय कोई शांत, आम-सा पल चुनिए और एक बार पूछिए।",
      },
      {
        type: "p",
        text: "जवाब जो भी हो, आप उस भविष्य की कीमत चुकाना बंद कर देते हैं जिसका वादा किसी ने नहीं किया। और अगर डर इसी बातचीत से लगता है, तो ध्यान दीजिए: विकल्प छह महीने बाद की भारी बातचीत नहीं है — विकल्प यह है कि आप शुरू में ही खुलकर कह दें कि आप क्या ढूंढ रहे हैं।",
      },
    ],
  },
};
