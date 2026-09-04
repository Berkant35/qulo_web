import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Breadcrumbing — occasional contact kept just frequent enough to hold someone's
 * interest, while nothing ever moves forward.
 *
 * Judgement calls made here, so a later editor does not undo them by accident:
 *
 * - NO QULO ANGLE. Block 7 is deliberately not a product pitch. Breadcrumbing
 *   happens after two people are already talking, on any platform including
 *   this one, and a question quiz does nothing to prevent it — claiming
 *   otherwise would be false. The slug page already renders a Qulo CTA below
 *   the body, so the reader gets the product without the body overclaiming.
 * - NO STATISTICS. The one sourced figure available (Forbes Health / OnePoll
 *   2024 burnout) is about dating-app burnout, not about this behaviour, so it
 *   is not cited here. Do not add "most people" or "studies show" to make the
 *   body feel more authoritative.
 * - NO INTENT CLAIM. The body says explicitly that there is usually no scheme
 *   behind it (indecision, flattery, boredom). That is on purpose: describing
 *   the behaviour is allowed, diagnosing the person is not.
 * - The busy-person contrast is the spine of the whole entry — the difference
 *   is direction, not frequency. If you shorten this file, keep that.
 *
 * Term names: an English loanword in every Latin-script locale, which is what
 * speakers actually say. Native renderings where the language really has one:
 * ar نثر الفتات, ru Бредкрамбинг, ja ブレッドクラミング, ko 브레드크럼빙,
 * zh 撒面包屑, hi ब्रेडक्रंबिंग. The ar and zh summaries name the English term
 * as well, because both circulate there.
 */
export const breadcrumbing: LocalizedGlossaryEntry = {
  en: {
    term: "Breadcrumbing",
    summary:
      "Occasional contact — a like, a late reply, a vague plan that never gets made — sent just often enough to keep someone interested while nothing ever moves forward.",
    blocks: [
      { type: "h2", text: "Why people leave a trail of crumbs" },
      { type: "p", text: "The name comes from the fairy tale: a trail of crumbs, just enough to follow, leading nowhere in particular. Most of the time there is no scheme behind it. Sending a message is cheap; ending something properly is not. Someone who is undecided, quietly flattered, or simply bored can keep a conversation on life support without ever deciding anything. The crumbs cost them a few seconds. They can cost you months." },
      { type: "p", text: "That is also what separates it from someone who is genuinely busy. A busy person is thin on contact but clear on direction: they say when they are free, they apologise, and the plan eventually happens. **Breadcrumbing has the warmth and none of the direction.** Weeks pass, the tone stays lovely, and you are no closer to anything than you were months ago." },
      { type: "h2", text: "How to recognise it" },
      {
        type: "ul",
        items: [
          "The message lands exactly when you were starting to let go of it.",
          "Plans stay abstract — soon, sometime, we should — and never get a day, a place or a time.",
          "Plenty of energy in reactions and emoji, almost none in anything that needs a decision.",
          "You know their jokes by heart and nothing about how their week went.",
        ],
      },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Ask for one specific thing. Not a conversation about what you are to each other, not a long message about how you feel — a day, a place, a time. Thursday, that bar near you, eight. Someone who is genuinely busy will move it rather than dodge it, and offer another date. Someone who is dropping crumbs will go warm and vague again. That is your answer. You only have to ask once." },
      { type: "p", text: "The crumbs are not what wears you down; the waiting is. Every thread left open takes a small share of attention that could go somewhere things actually happen. You can close one without a speech, without an explanation and without a final message. Stopping is allowed, and you are not obliged to announce it." },
    ],
  },
  tr: {
    term: "Breadcrumbing",
    summary:
      "Bir beğeni, geç gelen bir mesaj, hiçbir zaman gerçekleşmeyen belirsiz bir plan: karşıdakinin ilgisini diri tutmaya yetecek kadar temas, ama hiçbir şeyin ilerlemediği bir hâl.",
    blocks: [
      { type: "h2", text: "İnsanlar neden arkalarında kırıntı bırakır?" },
      { type: "p", text: "Adı masaldan geliyor: takip etmeye yetecek kadar ekmek kırıntısı, ama hiçbir yere çıkmayan bir iz. Çoğu zaman arkasında bir hesap yok. Mesaj atmak bedava, bir şeyi düzgünce bitirmek değil. Kararsız olan, ilgiden hoşlanan ya da sadece sıkılmış biri, hiçbir şeye karar vermeden sohbeti suni solunumda tutabilir. Kırıntılar ona birkaç saniyeye mal olur. Size aylara mal olabilir." },
      { type: "p", text: "Gerçekten yoğun olan insanla arasındaki fark da tam burada. Yoğun biri az yazar ama yönü bellidir: ne zaman müsait olduğunu söyler, geciktiyse özür diler ve plan er geç gerçekleşir. **Breadcrumbing'de sıcaklık vardır, yön yoktur.** Haftalar geçer, ton hep tatlıdır ve aylar öncesinde olduğunuz yerden bir adım ileride değilsinizdir." },
      { type: "h2", text: "Nasıl anlaşılır?" },
      {
        type: "ul",
        items: [
          "Mesaj tam da siz vazgeçmeye başladığınız anda gelir.",
          "Planlar hep havada kalır — bir ara, yakında, mutlaka — ama gün, yer ve saat hiç konuşulmaz.",
          "Tepkilerde ve emojilerde enerji doludur; karar gerektiren her şeyde sessizleşir.",
          "Esprilerini ezbere bilirsiniz, haftasının nasıl geçtiğini hiç bilmezsiniz.",
        ],
      },
      { type: "h2", accent: "green", text: "Ne yapabilirsiniz?" },
      { type: "p", text: "Somut tek bir şey isteyin. Ne olduğunuza dair bir konuşma değil, duygularınızı anlatan uzun bir mesaj da değil: bir gün, bir yer, bir saat. Perşembe, size yakın o kafe, sekizde. Gerçekten yoğun olan kişi erteler ama savuşturmaz; başka bir gün önerir. Kırıntı dağıtan kişi yine sıcak ve muğlak bir yere kaçar. Cevabınız budur. Bir kez sormanız yeterli." },
      { type: "p", text: "Asıl yıpratan kırıntılar değil, bekleyiş. Açık kalan her hat, gerçekten bir şeylerin olduğu yere gidebilecek küçük bir dikkat payını alıp götürür. Bunu veda konuşması, açıklama ya da son bir mesaj olmadan kapatabilirsiniz. Durmak da bir seçenek ve bunu ilan etmek zorunda değilsiniz." },
    ],
  },
  de: {
    term: "Breadcrumbing",
    summary:
      "Gelegentlicher Kontakt — ein Like, eine späte Antwort, ein vager Plan, aus dem nie etwas wird — gerade häufig genug, um das Interesse wachzuhalten, während sich nichts weiterentwickelt.",
    blocks: [
      { type: "h2", text: "Warum Menschen eine Spur aus Krumen legen" },
      { type: "p", text: "Der Name stammt aus dem Märchen: eine Spur aus Brotkrumen, gerade genug zum Folgen, die nirgendwohin führt. Meistens steckt keine Absicht dahinter. Eine Nachricht kostet nichts, ein sauberes Ende schon. Wer unsicher ist, wem die Aufmerksamkeit schmeichelt oder wer sich schlicht langweilt, kann ein Gespräch am Leben halten, ohne sich je zu entscheiden. Die Krumen kosten ein paar Sekunden. Dich können sie Monate kosten." },
      { type: "p", text: "Genau daran erkennt man den Unterschied zu jemandem, der wirklich viel zu tun hat. Bei echtem Stress ist der Kontakt dünn, die Richtung aber klar: Es kommt ein Termin, eine Entschuldigung, irgendwann das Treffen. **Beim Breadcrumbing gibt es Wärme ohne Richtung.** Wochen vergehen, der Ton bleibt reizend, und du bist keinen Schritt weiter als vor Monaten." },
      { type: "h2", text: "Woran du es erkennst" },
      {
        type: "ul",
        items: [
          "Die Nachricht kommt genau dann, wenn du innerlich loszulassen beginnst.",
          "Pläne bleiben im Ungefähren — bald, irgendwann, wir müssten mal — nie mit Tag, Ort und Uhrzeit.",
          "Viel Energie in Reaktionen und Emojis, kaum welche in allem, was eine Entscheidung verlangt.",
          "Du kennst die Witze auswendig und weißt nichts darüber, wie die Woche war.",
        ],
      },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Frag nach genau einer konkreten Sache. Kein Gespräch über den Status, kein langer Absatz über deine Gefühle — ein Tag, ein Ort, eine Uhrzeit. Donnerstag, die Bar bei dir, acht. Wer wirklich beschäftigt ist, verschiebt, weicht aber nicht aus, und schlägt einen anderen Termin vor. Wer Krumen streut, wird wieder warm und unverbindlich. Das ist deine Antwort. Einmal fragen reicht." },
      { type: "p", text: "Nicht die Krumen zermürben dich, sondern das Warten. Jeder offene Faden bindet ein wenig Aufmerksamkeit, die sonst dorthin ginge, wo tatsächlich etwas passiert. Du darfst so etwas ohne Ansage beenden, ohne Erklärung und ohne letzte Nachricht. Aufhören ist erlaubt, und ankündigen musst du es niemandem." },
    ],
  },
  fr: {
    term: "Breadcrumbing",
    summary:
      "Des miettes d'attention — un like, une réponse tardive, un projet vague qui ne se concrétise jamais — envoyées juste assez souvent pour entretenir l'intérêt, sans que rien n'avance.",
    blocks: [
      { type: "h2", text: "Pourquoi certains sèment des miettes" },
      { type: "p", text: "Le nom vient du conte : une traînée de miettes, suffisante pour être suivie, qui ne mène nulle part. La plupart du temps, il n'y a aucun calcul derrière. Écrire ne coûte rien, mettre fin à quelque chose proprement, si. Quelqu'un d'hésitant, de flatté ou simplement de désœuvré peut maintenir une conversation sous perfusion sans jamais rien décider. Les miettes lui coûtent quelques secondes. Elles peuvent vous coûter des mois." },
      { type: "p", text: "C'est aussi ce qui le distingue de quelqu'un de réellement débordé. Une personne débordée écrit peu mais garde un cap : elle dit quand elle est libre, elle s'excuse, et le rendez-vous finit par avoir lieu. **Le breadcrumbing, c'est la chaleur sans la direction.** Les semaines passent, le ton reste charmant, et vous n'êtes pas plus avancé qu'il y a des mois." },
      { type: "h2", text: "Comment le reconnaître" },
      {
        type: "ul",
        items: [
          "Le message arrive pile au moment où vous commenciez à lâcher prise.",
          "Les projets restent flous — bientôt, un de ces jours — sans jamais de date, de lieu ni d'heure.",
          "Beaucoup d'énergie dans les réactions et les emojis, très peu dès qu'il faut décider.",
          "Vous connaissez ses blagues par cœur et rien de sa semaine.",
        ],
      },
      { type: "h2", accent: "green", text: "Que faire" },
      { type: "p", text: "Demandez une seule chose précise. Pas une conversation sur ce que vous êtes l'un pour l'autre, pas un long message sur vos sentiments : un jour, un lieu, une heure. Jeudi, le bar près de chez vous, vingt heures. Quelqu'un de débordé décale mais n'esquive pas : il propose une autre date. Quelqu'un qui sème des miettes redevient chaleureux et flou. Voilà votre réponse. Une seule demande suffit." },
      { type: "p", text: "Ce ne sont pas les miettes qui usent, c'est l'attente. Chaque fil laissé ouvert consomme un peu d'attention qui pourrait aller là où il se passe vraiment quelque chose. Vous pouvez le refermer sans discours, sans explication et sans dernier message. Arrêter est une option, et vous n'avez rien à annoncer." },
    ],
  },
  es: {
    term: "Breadcrumbing",
    summary:
      "Migajas de atención — un like, una respuesta tardía, un plan vago que nunca se concreta — enviadas con la frecuencia justa para mantener el interés de alguien mientras nada avanza.",
    blocks: [
      { type: "h2", text: "Por qué alguien va dejando migas" },
      { type: "p", text: "El nombre viene del cuento: un rastro de migas, suficiente para seguirlo, que no lleva a ninguna parte. Casi nunca hay un plan detrás. Escribir no cuesta nada; terminar algo bien, sí. Alguien indeciso, a quien le halaga la atención o que simplemente está aburrido puede mantener una conversación con respiración asistida sin decidir nunca nada. Las migas le cuestan unos segundos. A ti pueden costarte meses." },
      { type: "p", text: "Ahí está también la diferencia con alguien que de verdad está desbordado. Quien tiene poco tiempo escribe poco, pero mantiene el rumbo: dice cuándo está libre, se disculpa y el plan acaba ocurriendo. **El breadcrumbing es calidez sin dirección.** Pasan las semanas, el tono sigue siendo encantador y estás donde estabas hace meses." },
      { type: "h2", text: "Cómo reconocerlo" },
      {
        type: "ul",
        items: [
          "El mensaje llega justo cuando empezabas a soltarlo.",
          "Los planes se quedan en abstracto — pronto, algún día, tenemos que quedar — sin día, lugar ni hora.",
          "Mucha energía en reacciones y emojis, muy poca en cualquier cosa que exija decidir.",
          "Te sabes sus bromas de memoria y no tienes ni idea de cómo le fue la semana.",
        ],
      },
      { type: "h2", accent: "green", text: "Qué puedes hacer" },
      { type: "p", text: "Pide una sola cosa concreta. No una conversación sobre la relación ni un párrafo largo sobre lo que sientes: un día, un sitio, una hora. El jueves, ese bar que te queda cerca, a las ocho. Quien está desbordado lo mueve, pero no lo esquiva: te propone otro día. Quien reparte migas volverá a ser cálido y vago. Esa es tu respuesta. Basta con preguntarlo una vez." },
      { type: "p", text: "Lo que desgasta no son las migas, es la espera. Cada hilo abierto se lleva una parte pequeña de atención que podría ir a donde sí ocurre algo. Puedes cerrarlo sin discurso, sin explicación y sin último mensaje. Parar también vale, y no tienes que anunciarlo." },
    ],
  },
  ar: {
    term: "نثر الفتات",
    summary:
      "تواصل متقطّع — إعجاب هنا، ردّ متأخّر هناك، وموعد مبهم لا يحدث أبدًا — يكفي تمامًا لإبقاء الطرف الآخر مهتمًّا من دون أن يتقدّم شيء. ويُعرف بالإنجليزية باسم breadcrumbing.",
    blocks: [
      { type: "h2", text: "لماذا يترك بعضهم أثرًا من الفتات" },
      { type: "p", text: "الاسم مأخوذ من الحكاية الشعبية: أثر من فتات الخبز يكفي لتتبّعه، لكنه لا يقود إلى أي مكان. في الغالب لا توجد خطة خلف ذلك. إرسال رسالة لا يكلّف شيئًا، أمّا إنهاء علاقة بوضوح فيكلّف الكثير. من كان مترددًا أو مزهوًّا بالاهتمام أو يشعر بالملل يستطيع إبقاء المحادثة على قيد الحياة من دون أن يحسم أي شيء. الفتات يكلّفه ثوانٍ. وقد يكلّفك أنت شهورًا." },
      { type: "p", text: "وهنا بالضبط يظهر الفرق بينه وبين شخص مشغول فعلًا. المشغول قليل الرسائل لكن اتجاهه واضح: يقول متى يكون متفرغًا، ويعتذر إن تأخّر، ثم يحدث اللقاء في النهاية. **أمّا نثر الفتات فدفء بلا اتجاه.** تمرّ الأسابيع، وتبقى النبرة لطيفة، ولا تكون قد تقدّمت خطوة واحدة عمّا كنت عليه قبل شهور." },
      { type: "h2", text: "كيف تتعرّف عليه" },
      {
        type: "ul",
        items: [
          "تصلك الرسالة تحديدًا في اللحظة التي بدأت فيها تتخلّى عن الفكرة.",
          "المواعيد تبقى مبهمة — قريبًا، يومًا ما، لا بدّ أن نلتقي — بلا يوم ولا مكان ولا ساعة.",
          "طاقة عالية في التفاعلات والرموز، ومنخفضة في كل ما يحتاج إلى قرار.",
          "تحفظ نكاته عن ظهر قلب، ولا تعرف شيئًا عن أسبوعه.",
        ],
      },
      { type: "h2", accent: "green", text: "ماذا يمكنك أن تفعل" },
      { type: "p", text: "اطلب شيئًا واحدًا محددًا. لا حديثًا عن طبيعة العلاقة، ولا رسالة طويلة عن مشاعرك: يوم ومكان وساعة. الخميس، المقهى القريب منك، في الثامنة. الشخص المشغول يؤجّل ولا يتهرّب، ويقترح موعدًا آخر. أمّا من ينثر الفتات فسيعود إلى الدفء والغموض معًا، وهذا هو جوابك. يكفي أن تسأل مرة واحدة." },
      { type: "p", text: "ما يرهقك ليس الفتات بل الانتظار. كل خيط مفتوح يأخذ جزءًا صغيرًا من انتباهك كان يمكن أن يذهب إلى مكان يحدث فيه شيء حقيقي. تستطيع إغلاقه بلا خطاب وداع ولا تفسير ولا رسالة أخيرة. التوقّف خيار مشروع، ولست مضطرًّا إلى إعلانه." },
    ],
  },
  ru: {
    term: "Бредкрамбинг",
    summary:
      "Редкие знаки внимания — лайк, запоздалый ответ, расплывчатое «надо как-нибудь встретиться» — которых хватает ровно на то, чтобы удерживать интерес, но не на то, чтобы что-то сдвинулось.",
    blocks: [
      { type: "h2", text: "Почему за человеком тянется дорожка из крошек" },
      { type: "p", text: "Название пришло из сказки: дорожка из хлебных крошек, по которой можно идти, но которая никуда не ведёт. Чаще всего за этим нет никакого умысла. Написать сообщение ничего не стоит, а закончить всё по-человечески — стоит. Тот, кто сомневается, кому приятно внимание или кому просто скучно, может держать переписку на аппарате искусственного дыхания, ничего при этом не решая. Ему крошки стоят пары секунд. Вам они могут стоить месяцев." },
      { type: "p", text: "Именно этим бредкрамбинг отличается от человека, который действительно занят. У занятого мало сообщений, но есть направление: он говорит, когда свободен, извиняется за задержку, и встреча в итоге происходит. **Здесь тепло есть, а направления нет.** Проходят недели, тон остаётся милым, а вы ровно там же, где были несколько месяцев назад." },
      { type: "h2", text: "Как это распознать" },
      {
        type: "ul",
        items: [
          "Сообщение приходит ровно тогда, когда вы начинаете отпускать.",
          "Планы остаются общими словами — скоро, как-нибудь, надо бы — без дня, места и часа.",
          "Много энергии в реакциях и эмодзи и почти никакой там, где нужно решение.",
          "Вы наизусть знаете его шутки и ничего не знаете о том, как прошла его неделя.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Попросите об одной конкретной вещи. Не разговор о том, кто вы друг другу, и не длинное сообщение о чувствах: день, место, час. Четверг, бар рядом с вами, восемь. Занятый человек перенесёт, но не увильнёт — предложит другой день. Тот, кто раздаёт крошки, снова станет тёплым и неопределённым. Это и есть ответ. Спросить достаточно один раз." },
      { type: "p", text: "Изматывают не крошки, а ожидание. Каждая незакрытая переписка забирает немного внимания, которое могло бы уйти туда, где что-то происходит. Закрыть её можно без прощальной речи, без объяснений и без последнего сообщения. Остановиться нормально, и объявлять об этом никому не нужно." },
    ],
  },
  pt: {
    term: "Breadcrumbing",
    summary:
      "Migalhas de atenção — uma curtida, uma resposta atrasada, um plano vago que nunca acontece — enviadas com a frequência exata para manter alguém interessado enquanto nada avança.",
    blocks: [
      { type: "h2", text: "Por que alguém vai deixando migalhas" },
      { type: "p", text: "O nome vem do conto: um rastro de migalhas, suficiente para seguir, que não leva a lugar nenhum. Quase nunca há um plano por trás. Mandar mensagem não custa nada; terminar algo direito, custa. Quem está indeciso, quem gosta da atenção ou quem simplesmente está entediado consegue manter uma conversa na respiração artificial sem decidir coisa alguma. As migalhas custam alguns segundos a essa pessoa. Podem custar meses a você." },
      { type: "p", text: "É aí também que está a diferença para alguém realmente ocupado. Quem está ocupado escreve pouco, mas tem direção: diz quando está livre, pede desculpa pelo atraso e o encontro acaba acontecendo. **O breadcrumbing tem o calor e nenhuma direção.** As semanas passam, o tom continua encantador e você está no mesmo ponto de meses atrás." },
      { type: "h2", text: "Como reconhecer" },
      {
        type: "ul",
        items: [
          "A mensagem chega justamente quando você começava a soltar.",
          "Os planos ficam no abstrato — em breve, qualquer dia, precisamos marcar — sem dia, lugar nem hora.",
          "Muita energia em reações e emojis, quase nenhuma no que exige decisão.",
          "Você sabe as piadas de cor e não faz ideia de como foi a semana da pessoa.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer" },
      { type: "p", text: "Peça uma única coisa concreta. Não uma conversa sobre o que vocês são, nem um parágrafo sobre o que você sente: um dia, um lugar, uma hora. Quinta, aquele bar perto de você, oito da noite. Quem está ocupado remarca, mas não desvia: oferece outra data. Quem distribui migalhas volta a ser caloroso e vago. Essa é a sua resposta. Basta perguntar uma vez." },
      { type: "p", text: "O que desgasta não são as migalhas, é a espera. Cada conversa em aberto consome um pedaço de atenção que poderia ir para onde algo de fato acontece. Dá para encerrar sem discurso, sem explicação e sem última mensagem. Parar é uma opção, e você não precisa anunciar." },
    ],
  },
  it: {
    term: "Breadcrumbing",
    summary:
      "Briciole di attenzione — un like, una risposta in ritardo, un piano vago che non si concretizza mai — mandate quel tanto che basta a tenere viva l'attesa, senza che nulla vada avanti.",
    blocks: [
      { type: "h2", text: "Perché qualcuno lascia una scia di briciole" },
      { type: "p", text: "Il nome viene dalla fiaba: una scia di briciole, abbastanza da seguire, che non porta da nessuna parte. Quasi mai c'è un calcolo dietro. Scrivere non costa niente; chiudere una cosa per bene sì. Chi è indeciso, chi si sente lusingato o chi è semplicemente annoiato può tenere una conversazione in respirazione assistita senza decidere mai nulla. Le briciole gli costano qualche secondo. A te possono costare mesi." },
      { type: "p", text: "È anche così che si vede la differenza con chi è davvero pieno di impegni. Chi ha poco tempo scrive poco, ma tiene una direzione: dice quando è libero, si scusa per il ritardo e prima o poi l'incontro accade. **Il breadcrumbing ha il calore e nessuna direzione.** Passano le settimane, il tono resta gentile e tu sei esattamente dove eri mesi fa." },
      { type: "h2", text: "Come riconoscerlo" },
      {
        type: "ul",
        items: [
          "Il messaggio arriva proprio quando stavi cominciando a lasciar perdere.",
          "I piani restano sul vago — presto, uno di questi giorni — senza giorno, luogo né ora.",
          "Tanta energia nelle reazioni e nelle emoji, pochissima in tutto ciò che richiede una decisione.",
          "Conosci a memoria le sue battute e non sai niente di com'è andata la sua settimana.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa fare" },
      { type: "p", text: "Chiedi una sola cosa concreta. Non un discorso su cosa siete, non un messaggio lungo sui tuoi sentimenti: un giorno, un posto, un'ora. Giovedì, quel bar vicino a te, alle otto. Chi è davvero pieno di impegni sposta ma non schiva: propone un'altra data. Chi lascia briciole tornerà caldo e vago. Quella è la risposta. Basta chiederlo una volta." },
      { type: "p", text: "A logorare non sono le briciole, è l'attesa. Ogni conversazione lasciata aperta si porta via un po' di attenzione che potrebbe andare dove qualcosa succede davvero. Puoi chiuderla senza discorsi, senza spiegazioni e senza un ultimo messaggio. Fermarsi è una possibilità, e non devi annunciarlo a nessuno." },
    ],
  },
  ja: {
    term: "ブレッドクラミング",
    summary:
      "いいね、遅れて届く返信、実現しない曖昧な誘い。相手の関心をつなぎとめるのにちょうど足りるだけの接触を続けながら、関係は一歩も前に進まない状態を指します。",
    blocks: [
      { type: "h2", text: "なぜパンくずだけが落ちていくのか" },
      { type: "p", text: "名前は童話に由来します。たどれるだけのパンくずは落ちているのに、その先には何もない道筋のことです。多くの場合、そこに計算はありません。メッセージを送るのはただ同然ですが、きちんと終わらせるのは骨が折れます。迷っている人、好意を向けられて悪い気がしない人、単に退屈している人は、何ひとつ決めないまま会話を延命させることができます。相手にとっては数秒。あなたにとっては数か月になりかねません。" },
      { type: "p", text: "本当に忙しい人との違いも、まさにここに出ます。忙しい人は連絡こそ少なくても向きがはっきりしています。空いている日を言い、遅れたら謝り、約束はいずれ実現します。**ブレッドクラミングにあるのは温かさだけで、向きがありません。**何週間たっても口調は感じよく、それでも数か月前と同じ場所に立ったままです。" },
      { type: "h2", text: "見分け方" },
      {
        type: "ul",
        items: [
          "こちらがあきらめかけた、ちょうどそのタイミングで連絡が来る。",
          "誘いはいつも「そのうち」「近いうちに」で、日にちも場所も時間も決まらない。",
          "スタンプやリアクションには熱心なのに、決めごとになると急に静かになる。",
          "冗談は覚えているのに、相手の一週間がどうだったかは何も知らない。",
        ],
      },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "具体的なことをひとつだけ提案してください。関係の定義をめぐる話し合いでも、気持ちを綴った長文でもなく、日にちと場所と時間です。木曜、近くのあの店、八時。本当に忙しい人はずらしはしても、かわしはしません。別の日を出してきます。パンくずをまく人は、また温かくて曖昧な返事に戻ります。それが答えです。尋ねるのは一度で十分です。" },
      { type: "p", text: "すり減らすのはパンくずそのものではなく、待っている時間のほうです。開いたままの会話はどれも、本当に何かが起きる場所へ向かうはずだった注意を少しずつ持っていきます。別れの言葉も説明も最後のメッセージもなく、閉じてかまいません。やめるのは自由で、宣言する義務もありません。" },
    ],
  },
  ko: {
    term: "브레드크럼빙",
    summary:
      "좋아요 하나, 늦게 오는 답장, 끝내 잡히지 않는 막연한 약속처럼 관심을 붙잡아 둘 만큼만 연락하면서 관계는 한 걸음도 나아가지 않는 상태를 말합니다.",
    blocks: [
      { type: "h2", text: "왜 부스러기만 흘리는 걸까" },
      { type: "p", text: "이름은 동화에서 왔습니다. 따라갈 수 있을 만큼의 빵 부스러기가 놓여 있지만, 그 끝에는 아무것도 없는 길입니다. 대개는 계략이 아닙니다. 메시지를 보내는 데는 아무 비용이 들지 않지만, 관계를 제대로 끝내는 데는 비용이 듭니다. 마음을 정하지 못했거나, 관심을 받는 게 싫지 않거나, 그냥 심심한 사람은 아무것도 결정하지 않은 채 대화를 연명시킬 수 있습니다. 그 사람에게는 몇 초, 당신에게는 몇 달입니다." },
      { type: "p", text: "정말 바쁜 사람과의 차이도 여기서 드러납니다. 바쁜 사람은 연락이 뜸해도 방향이 분명합니다. 언제 시간이 되는지 말하고, 늦으면 미안하다고 하고, 약속은 결국 성사됩니다. **브레드크럼빙에는 다정함만 있고 방향이 없습니다.** 몇 주가 지나도 말투는 여전히 상냥한데, 당신은 몇 달 전 그 자리에 그대로 서 있습니다." },
      { type: "h2", text: "어떻게 알아볼까" },
      {
        type: "ul",
        items: [
          "마음을 접으려던 바로 그 순간에 연락이 옵니다.",
          "약속은 늘 ‘언젠가’, ‘조만간’에 머물고 날짜와 장소와 시간은 정해지지 않습니다.",
          "이모지와 리액션에는 열심이면서, 결정을 요구하는 일에는 조용해집니다.",
          "농담은 다 외우고 있는데, 그 사람의 한 주가 어땠는지는 전혀 모릅니다.",
        ],
      },
      { type: "h2", accent: "green", text: "무엇을 하면 좋을까" },
      { type: "p", text: "구체적인 것 하나만 제안해 보세요. 우리가 무슨 사이냐는 대화도, 감정을 길게 적은 메시지도 아닙니다. 날짜, 장소, 시간입니다. 목요일, 집 근처 그 카페, 여덟 시. 진짜 바쁜 사람은 미루기는 해도 피하지는 않습니다. 다른 날을 제안합니다. 부스러기를 흘리는 사람은 다시 다정하고 모호한 자리로 돌아갑니다. 그게 답입니다. 한 번만 물어보면 충분합니다." },
      { type: "p", text: "지치게 하는 건 부스러기가 아니라 기다림입니다. 열려 있는 대화 하나하나가, 무언가 실제로 일어나는 쪽으로 갈 수 있었던 관심을 조금씩 가져갑니다. 작별 인사도, 설명도, 마지막 메시지도 없이 닫아도 됩니다. 그만두는 것도 선택이고, 굳이 알릴 필요는 없습니다." },
    ],
  },
  zh: {
    term: "撒面包屑",
    summary:
      "偶尔给一点关注：一个赞、一条迟来的回复、一个永远约不成的模糊计划，刚好够把对方的兴趣吊着，关系却始终原地不动。英文叫 breadcrumbing。",
    blocks: [
      { type: "h2", text: "为什么有人只留下面包屑" },
      { type: "p", text: "名字来自童话：地上撒着刚好够你跟下去的面包屑，可这条路哪儿也不通。多数时候背后并没有什么盘算。发一条消息几乎不花力气，把一段关系体面地结束却很花力气。一个拿不定主意、被人喜欢着挺受用、或者只是无聊的人，可以在什么都不决定的情况下，让这段对话一直吊着一口气。面包屑对他只是几秒钟，对你可能是几个月。" },
      { type: "p", text: "它和真正很忙的人之间的区别也在这里。真的忙的人消息少，但方向清楚：他会说自己哪天有空，迟了会道歉，约会最后也真的会发生。**撒面包屑只有温度，没有方向。**几个星期过去，语气一如既往地好，你却还停在几个月前的位置上。" },
      { type: "h2", text: "怎么看出来" },
      {
        type: "ul",
        items: [
          "你刚要放下这件事，消息就来了。",
          "计划永远停在「改天」「有机会」，从来没有日期、地点和时间。",
          "在点赞和表情上很热情，一到需要做决定的事就安静下来。",
          "你把他的段子背得滚瓜烂熟，却完全不知道他这一周过得怎么样。",
        ],
      },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "只提一件具体的事。不用谈你们算什么关系，也不用写一大段心情：一个日子、一个地点、一个时间。周四，你家附近那家店，八点。真正忙的人会改时间，但不会绕开，他会给你另一个日子。撒面包屑的人会重新变得又热情又含糊，那就是答案。问一次就够了。" },
      { type: "p", text: "真正消耗人的不是面包屑，是等待。每一段没结果又没关掉的对话，都会带走一点本来可以放在真实的事情上的注意力。你可以不发告别、不作解释、不留最后一条消息就把它关掉。停下来是允许的，也不必昭告任何人。" },
    ],
  },
  nl: {
    term: "Breadcrumbing",
    summary:
      "Af en toe een teken van aandacht — een like, een laat antwoord, een vaag plan dat er nooit komt — precies vaak genoeg om iemand geïnteresseerd te houden terwijl er niets vooruitgaat.",
    blocks: [
      { type: "h2", text: "Waarom iemand een spoor van kruimels achterlaat" },
      { type: "p", text: "De naam komt uit het sprookje: een spoor van kruimels, net genoeg om te volgen, dat nergens heen leidt. Meestal zit er geen plan achter. Een bericht sturen kost niets, iets netjes beëindigen wel. Wie twijfelt, wie de aandacht prettig vindt of wie zich gewoon verveelt, kan een gesprek aan de beademing houden zonder ooit iets te beslissen. De kruimels kosten diegene een paar seconden. Jou kunnen ze maanden kosten." },
      { type: "p", text: "Daar zit ook het verschil met iemand die het echt druk heeft. Wie het druk heeft, stuurt weinig maar houdt richting: die zegt wanneer het wel kan, biedt excuses aan voor het uitstel, en de afspraak komt er uiteindelijk. **Breadcrumbing heeft de warmte en geen richting.** De weken gaan voorbij, de toon blijft lief, en je staat nog precies waar je maanden geleden stond." },
      { type: "h2", text: "Hoe je het herkent" },
      {
        type: "ul",
        items: [
          "Het bericht komt precies op het moment dat je het begon los te laten.",
          "Plannen blijven vaag — binnenkort, ooit, we moeten echt eens — zonder dag, plek of tijd.",
          "Veel energie in reacties en emoji, bijna geen in alles wat een besluit vraagt.",
          "Je kent de grappen uit je hoofd en weet niets over hoe de week is geweest.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je kunt doen" },
      { type: "p", text: "Vraag om één concreet ding. Geen gesprek over wat jullie zijn, geen lange tekst over je gevoel: een dag, een plek, een tijd. Donderdag, dat café bij jou, acht uur. Wie het druk heeft verzet het maar ontwijkt het niet en stelt een andere dag voor. Wie kruimels strooit, wordt weer warm en vaag. Dat is je antwoord. Eén keer vragen is genoeg." },
      { type: "p", text: "Niet de kruimels slijten je, het wachten doet dat. Elk open gesprek neemt een beetje aandacht mee die ergens heen kon waar wel iets gebeurt. Je mag het sluiten zonder speech, zonder uitleg en zonder laatste bericht. Stoppen mag, en je hoeft het niet aan te kondigen." },
    ],
  },
  pl: {
    term: "Breadcrumbing",
    summary:
      "Okruchy uwagi — polubienie, spóźniona odpowiedź, mglisty plan, który nigdy się nie ziszcza — wysyłane akurat na tyle często, by podtrzymać czyjeś zainteresowanie, choć nic nie posuwa się naprzód.",
    blocks: [
      { type: "h2", text: "Dlaczego ktoś sypie okruchami" },
      { type: "p", text: "Nazwa pochodzi z baśni: ślad z okruszków, wystarczający, żeby iść, ale prowadzący donikąd. Najczęściej nie ma w tym wyrachowania. Napisanie wiadomości nic nie kosztuje, porządne zakończenie czegoś już tak. Ktoś niezdecydowany, komu schlebia zainteresowanie albo komu jest zwyczajnie nudno, potrafi trzymać rozmowę pod respiratorem, nie decydując o niczym. Jego okruchy kosztują kilka sekund. Ciebie mogą kosztować miesiące." },
      { type: "p", text: "Właśnie tu widać różnicę wobec kogoś naprawdę zajętego. Zajęta osoba pisze rzadko, ale trzyma kierunek: mówi, kiedy ma czas, przeprasza za zwłokę, a spotkanie w końcu się odbywa. **Breadcrumbing to ciepło bez kierunku.** Mijają tygodnie, ton pozostaje miły, a ty jesteś dokładnie tam, gdzie kilka miesięcy temu." },
      { type: "h2", text: "Jak to rozpoznać" },
      {
        type: "ul",
        items: [
          "Wiadomość przychodzi dokładnie wtedy, gdy zaczynasz odpuszczać.",
          "Plany zostają w ogólnikach — wkrótce, kiedyś, musimy się umówić — bez dnia, miejsca i godziny.",
          "Dużo energii w reakcjach i emotkach, prawie zero tam, gdzie trzeba coś ustalić.",
          "Znasz jego żarty na pamięć i nic nie wiesz o tym, jak minął mu tydzień.",
        ],
      },
      { type: "h2", accent: "green", text: "Co możesz zrobić" },
      { type: "p", text: "Poproś o jedną konkretną rzecz. Nie o rozmowę, kim dla siebie jesteście, ani o długi opis uczuć: dzień, miejsce, godzina. Czwartek, ten lokal blisko ciebie, ósma. Osoba naprawdę zajęta przełoży, ale nie ucieknie — zaproponuje inny termin. Osoba sypiąca okruchy znów zrobi się ciepła i nieokreślona. To jest twoja odpowiedź. Wystarczy zapytać raz." },
      { type: "p", text: "Męczą nie okruchy, tylko czekanie. Każdy niezamknięty wątek zabiera trochę uwagi, która mogłaby pójść tam, gdzie coś naprawdę się dzieje. Możesz go zamknąć bez przemowy, bez tłumaczenia i bez ostatniej wiadomości. Przerwanie jest w porządku i nie musisz tego ogłaszać." },
    ],
  },
  sv: {
    term: "Breadcrumbing",
    summary:
      "Enstaka tecken på intresse — en gilla-markering, ett sent svar, en vag plan som aldrig blir av — som skickas precis så ofta att någon hålls kvar, medan ingenting går framåt.",
    blocks: [
      { type: "h2", text: "Varför någon lämnar ett spår av smulor" },
      { type: "p", text: "Namnet kommer från sagan: ett spår av brödsmulor, precis nog att följa, som inte leder någonstans. Oftast finns ingen plan bakom. Att skriva ett meddelande kostar ingenting, att avsluta något ordentligt gör det. Den som tvekar, den som tycker om uppmärksamheten eller den som helt enkelt har tråkigt kan hålla en konversation vid liv utan att någonsin bestämma sig. Smulorna kostar några sekunder. Dig kan de kosta månader." },
      { type: "p", text: "Det är också där skillnaden mot någon som verkligen har mycket att göra syns. Den som har fullt upp hör av sig sällan men har riktning: säger när det går bra, ber om ursäkt för dröjsmålet, och till slut blir det av. **Breadcrumbing har värmen och ingen riktning alls.** Veckorna går, tonen är fortfarande trevlig, och du står kvar där du stod för flera månader sedan." },
      { type: "h2", text: "Så känner du igen det" },
      {
        type: "ul",
        items: [
          "Meddelandet kommer precis när du hade börjat släppa taget.",
          "Planerna stannar i det vaga — snart, någon gång, vi måste ses — utan dag, plats eller tid.",
          "Mycket energi i reaktioner och emojis, nästan ingen i sådant som kräver ett beslut.",
          "Du kan skämten utantill och vet ingenting om hur veckan har varit.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Be om en enda konkret sak. Inget samtal om vad ni är, ingen lång text om känslor: en dag, en plats, en tid. Torsdag, stället nära dig, åtta. Den som har mycket att göra flyttar fram det men smiter inte undan, utan föreslår ett annat datum. Den som strör smulor blir varm och vag igen. Det är ditt svar. Det räcker att fråga en gång." },
      { type: "p", text: "Det är inte smulorna som sliter, det är väntan. Varje öppen tråd tar lite uppmärksamhet som annars kunde gå dit där något faktiskt händer. Du får stänga den utan tal, utan förklaring och utan sista meddelande. Att sluta är tillåtet, och du behöver inte meddela det." },
    ],
  },
  hi: {
    term: "ब्रेडक्रंबिंग",
    summary:
      "कभी-कभार आता एक लाइक, देर से आया जवाब, कभी न बनने वाली धुँधली सी योजना — सामने वाले की दिलचस्पी बनाए रखने भर का संपर्क, जिसमें रिश्ता एक कदम भी आगे नहीं बढ़ता।",
    blocks: [
      { type: "h2", text: "कोई पीछे सिर्फ़ टुकड़े क्यों छोड़ता है" },
      { type: "p", text: "नाम उस परीकथा से आया है जिसमें रोटी के टुकड़ों की एक लकीर होती है — पीछे चलने भर को काफ़ी, पर पहुँचाती कहीं नहीं। ज़्यादातर मामलों में इसके पीछे कोई चाल नहीं होती। मैसेज भेजना मुफ़्त है, किसी बात को ठीक से खत्म करना नहीं। जिसने खुद तय नहीं किया, जिसे यह ध्यान अच्छा लगता है, या जो बस ऊबा हुआ है, वह कुछ भी तय किए बिना बातचीत को ज़िंदा रख सकता है। उसे यह कुछ सेकंड का काम लगता है। आपके महीने चले जाते हैं।" },
      { type: "p", text: "सचमुच व्यस्त इंसान से फ़र्क़ भी यहीं दिखता है। व्यस्त इंसान कम लिखता है, पर उसकी दिशा साफ़ होती है: वह बताता है कि कब फ़ुरसत है, देर होने पर माफ़ी माँगता है, और मुलाक़ात आख़िरकार हो जाती है। **ब्रेडक्रंबिंग में गर्मजोशी है, दिशा नहीं।** हफ़्ते बीतते हैं, लहज़ा वैसा ही प्यारा रहता है, और आप वहीं खड़े हैं जहाँ महीनों पहले थे।" },
      { type: "h2", text: "कैसे पहचानें" },
      {
        type: "ul",
        items: [
          "मैसेज ठीक उसी वक़्त आता है जब आप उम्मीद छोड़ने लगे थे।",
          "योजनाएँ हमेशा अधूरी रहती हैं — जल्दी मिलते हैं, कभी तो मिलेंगे — पर दिन, जगह और समय कभी तय नहीं होता।",
          "रिएक्शन और इमोजी में पूरा जोश, और जहाँ कोई फ़ैसला लेना हो वहाँ चुप्पी।",
          "उनके मज़ाक आपको ज़ुबानी याद हैं, पर उनका हफ़्ता कैसा बीता यह आप नहीं जानते।",
        ],
      },
      { type: "h2", accent: "green", text: "क्या किया जा सकता है" },
      { type: "p", text: "एक ठोस चीज़ माँगिए। रिश्ते की परिभाषा पर बहस नहीं, भावनाओं का लंबा संदेश नहीं — बस एक दिन, एक जगह, एक समय। गुरुवार, आपके पास वाला कैफ़े, आठ बजे। सचमुच व्यस्त इंसान तारीख़ बदलेगा, टालेगा नहीं; वह दूसरा दिन बताएगा। टुकड़े बिखेरने वाला फिर से गर्मजोश और गोल-मोल हो जाएगा। यही आपका जवाब है। एक बार पूछना काफ़ी है।" },
      { type: "p", text: "थकाते टुकड़े नहीं, इंतज़ार थकाता है। हर अधूरी बातचीत आपका थोड़ा-सा ध्यान ले जाती है, जो कहीं असली जगह लग सकता था। इसे बंद करने के लिए न विदाई भाषण चाहिए, न सफ़ाई, न आख़िरी मैसेज। रुक जाना भी एक विकल्प है, और इसकी घोषणा करना ज़रूरी नहीं।" },
    ],
  },
};
