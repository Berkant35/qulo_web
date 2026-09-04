import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Floodlighting — unloading your heaviest personal history very early, before
 * there is enough trust between two people to hold it.
 *
 * Judgement calls a later editor should not undo by accident:
 *
 * - TONE IS GENTLE ON PURPOSE. People floodlight out of a wish to be known
 *   quickly, or to find out early whether someone will stay — not out of
 *   malice. The page says so in block 1 and closes by telling the reader who
 *   recognises themselves that wanting to be seen fast is not a flaw. Do not
 *   rewrite this into a warning-signs page; rule 7 forbids diagnosing, and the
 *   person searching this term at 1am is as often the one who did it as the one
 *   it happened to.
 *
 * - TWO DISTINCTIONS ARE LOAD-BEARING and both live in block 2. Against healthy
 *   openness: the difference is timing and reciprocity, not subject matter, so
 *   the page never says a topic is off limits. Against love bombing: that is
 *   aimed at you (praise, speed, plans), floodlighting is about them and you
 *   are the audience. Collapsing the two would make this page a duplicate of
 *   `love-bombing` and would also misdescribe it as manipulation.
 *
 * - BRENÉ BROWN is named in block 1 as the origin of the word, without a book
 *   title or year — the attribution is accurate at that grain and adding a
 *   citation apparatus would not survive translation into 16 locales. She is a
 *   researcher, not a dating app, so the brand rule does not apply.
 *
 * - NO FIGURES and no Qulo angle. There is no honest link between a question
 *   quiz and how fast someone discloses, so block 7 goes to the reader who
 *   recognises themselves instead.
 *
 * - TERM NAMES. The word is new enough that no language has a settled native
 *   equivalent; ar/ru/ja/ko/hi use the native-script spelling and zh keeps the
 *   Latin form with 情感探照灯 offered in the summary as the gloss.
 */
export const floodlighting: LocalizedGlossaryEntry = {
  en: {
    term: "Floodlighting",
    summary:
      "Unloading your heaviest history — trauma, diagnoses, the whole story of an ex — very early on, before there is enough trust between two people to hold it.",
    blocks: [
      { type: "h2", text: "Why people do it" },
      { type: "p", text: "The name comes from the light: everything switched on at once, nothing left in shadow. The researcher Brené Brown used it for vulnerability turned into a spotlight — telling someone the hardest things not to get closer, but to see what they do with it. On a dating app it usually comes from a decent place. A wish to be known quickly, and exhaustion: if this is going to end it, better tonight than in four months." },
      { type: "p", text: "It is not the same as being open. Openness moves in step with the other person and leaves room for them to answer; floodlighting arrives all at once and does not. It is also not love bombing, though the intensity feels similar. **Love bombing is aimed at you** — the praise, the speed, the plans. **Floodlighting is about them**, and you are the audience." },
      { type: "h2", text: "What it feels like from your side" },
      { type: "ul", items: [
        "The heaviest material arrives in the first hour or two, unprompted and in full detail.",
        "It runs as a monologue: no pause for you, no question about anything on your side.",
        "You feel cast in a role — therapist, witness, the one who is going to stay.",
        "The warmth cools sharply if you answer with less intensity than was expected.",
      ] },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "You do not owe a matching confession, and you do not have to vanish either. Warm and honest works: thank them for trusting you, say it sounds like a lot, and say you would like to get to know them slowly. **Then change the pace rather than the person.** If they can slow down with you, this is probably fine. If a careful answer gets read as rejection, that is useful information too." },
      { type: "p", text: "If you are the one who floodlights, try giving the headline and stopping — a hard couple of years, a complicated family — then let them ask. Being known takes longer than being told. The closeness is not in the story; it gets built while the story comes out, in turns. Wanting to be seen fast is not a flaw. Only the timing hurts." },
    ],
  },
  tr: {
    term: "Floodlighting",
    summary:
      "En ağır geçmişini — travmayı, teşhisleri, bütün bir eski ilişki hikâyesini — daha aranızda onu taşıyacak güven kurulmadan, çok erken boşaltmak.",
    blocks: [
      { type: "h2", text: "İnsanlar bunu neden yapar?" },
      { type: "p", text: "Adı ışıktan geliyor: her şey aynı anda açık, gölgede hiçbir şey kalmıyor. Araştırmacı Brené Brown bu kelimeyi, projektöre dönüşmüş kırılganlık için kullanmıştı — en zor şeyleri yakınlaşmak için değil, karşıdaki onunla ne yapacak diye görmek için anlatmak. Flört uygulamalarında genelde iyi bir yerden çıkıyor. Hızlıca tanınma isteği ve yorgunluk: madem bu ilişkiyi bitirecek, dört ay sonra değil bu akşam bitsin." },
      { type: "p", text: "Bu, açık olmakla aynı şey değil. Açıklık karşındakiyle aynı adımda ilerler ve ona cevap verecek yer bırakır; floodlighting hepsi birden gelir, yer bırakmaz. Aşk bombardımanı da değil, yoğunluğu benzese bile. **Aşk bombardımanı sana yöneliktir** — övgüler, hız, planlar. **Floodlighting ise onunla ilgilidir**, sen seyircisin." },
      { type: "h2", text: "Senin tarafından nasıl görünür?" },
      { type: "ul", items: [
        "En ağır kısım daha ilk bir iki saatte, sen sormadan ve bütün ayrıntılarıyla geliyor.",
        "Monolog gibi akıyor: sana duraklama yok, senin tarafından hiçbir şey sorulmuyor.",
        "Bir role yerleştirildiğini hissediyorsun — terapist, tanık, kalacak olan kişi.",
        "Beklenenden daha düşük bir yoğunlukla karşılık verdiğinde sıcaklık birden düşüyor.",
      ] },
      { type: "h2", accent: "green", text: "Ne yapmalı?" },
      { type: "p", text: "Ne aynı ağırlıkta bir itiraf borcun var ne de ortadan kaybolman gerekiyor. Sıcak ve dürüst olan işe yarar: güvendiği için teşekkür et, bunun ağır bir yük olduğunu söyle ve onu yavaş yavaş tanımak istediğini ekle. **Sonra kişiyi değil, temposunu değiştir.** Seninle birlikte yavaşlayabiliyorsa mesele yok. Dikkatli bir cevabı reddedilme sayıyorsa, o da işine yarayacak bir bilgi." },
      { type: "p", text: "Bunu yapan sensen, başlığı söyleyip durmayı dene — zor geçen birkaç yıl, karışık bir aile — sonra sormalarını bekle. Tanınmak, anlatmaktan daha uzun sürer. Yakınlık hikâyenin içinde değil; hikâye sırayla dökülürken kurulur. Hızla görülmek istemek kusur değil. Canı yakan sadece zamanlama." },
    ],
  },
  de: {
    term: "Floodlighting",
    summary:
      "Die schwerste eigene Geschichte — Traumata, Diagnosen, die ganze Erzählung über eine Ex — sehr früh ausschütten, bevor genug Vertrauen da ist, um sie zu tragen.",
    blocks: [
      { type: "h2", text: "Warum Menschen das tun" },
      { type: "p", text: "Der Name kommt vom Licht: alles gleichzeitig an, nichts bleibt im Schatten. Die Forscherin Brené Brown benutzte ihn für Verletzlichkeit, die zum Scheinwerfer wird — die schwersten Dinge zu erzählen, nicht um näher zu kommen, sondern um zu sehen, was der andere damit macht. In einer Dating-App kommt es meist aus einem anständigen Impuls. Aus dem Wunsch, schnell gekannt zu werden, und aus Erschöpfung: Wenn das hier ohnehin das Ende ist, dann lieber heute als in vier Monaten." },
      { type: "p", text: "Es ist nicht dasselbe wie Offenheit. Offenheit geht im Schritt des anderen und lässt Raum für eine Antwort; Floodlighting kommt auf einmal und lässt diesen Raum nicht. Es ist auch kein Lovebombing, obwohl die Intensität ähnlich wirkt. **Lovebombing richtet sich an dich** — das Lob, das Tempo, die Pläne. **Floodlighting handelt von der anderen Person**, und du bist das Publikum." },
      { type: "h2", text: "Wie es sich von deiner Seite anfühlt" },
      { type: "ul", items: [
        "Das Schwerste kommt in der ersten oder zweiten Stunde, ungefragt und in voller Ausführlichkeit.",
        "Es läuft als Monolog: keine Pause für dich, keine Frage nach irgendetwas auf deiner Seite.",
        "Du fühlst dich in eine Rolle gesetzt — Therapeut, Zeuge, die Person, die bleiben wird.",
        "Die Wärme kühlt schlagartig ab, wenn du mit weniger Intensität antwortest als erwartet.",
      ] },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Du schuldest kein Geständnis derselben Größe, und verschwinden musst du auch nicht. Warm und ehrlich funktioniert: Bedank dich für das Vertrauen, sag, dass das nach viel klingt, und sag, dass du die Person gern langsam kennenlernen möchtest. **Ändere danach das Tempo, nicht den Menschen.** Wer mit dir langsamer werden kann, mit dem ist es vermutlich in Ordnung. Wird eine behutsame Antwort als Zurückweisung gelesen, ist auch das eine brauchbare Information." },
      { type: "p", text: "Und wenn du derjenige bist, der floodlightet: Sag die Überschrift und hör dort auf — ein paar harte Jahre, eine komplizierte Familie — und lass den anderen fragen. Gekannt zu werden dauert länger, als es zu erzählen. Die Nähe steckt nicht in der Geschichte; sie entsteht, während die Geschichte abwechselnd herauskommt. Schnell gesehen werden zu wollen ist kein Fehler. Weh tut nur das Timing." },
    ],
  },
  fr: {
    term: "Floodlighting",
    summary:
      "Déverser très tôt son histoire la plus lourde — traumatismes, diagnostics, le récit complet d'un ex — avant qu'il y ait entre vous assez de confiance pour la porter.",
    blocks: [
      { type: "h2", text: "Pourquoi on fait ça" },
      { type: "p", text: "Le nom vient de la lumière : tout allumé d'un coup, plus rien dans l'ombre. La chercheuse Brené Brown l'employait pour la vulnérabilité transformée en projecteur — raconter le plus dur non pas pour se rapprocher, mais pour voir ce que l'autre en fera. Sur une appli de rencontre, cela part presque toujours d'un bon endroit. L'envie d'être connu vite, et la fatigue : si ça doit tout arrêter, autant ce soir que dans quatre mois." },
      { type: "p", text: "Ce n'est pas la même chose que la sincérité. La sincérité avance au rythme de l'autre et lui laisse de la place pour répondre ; le floodlighting arrive d'un bloc et n'en laisse pas. Ce n'est pas non plus du love bombing, même si l'intensité s'y ressemble. **Le love bombing vous vise, vous** : les compliments, la vitesse, les projets. **Le floodlighting parle d'eux**, et vous êtes le public." },
      { type: "h2", text: "Ce que ça donne de votre côté" },
      { type: "ul", items: [
        "Le plus lourd arrive dans la première heure ou deux, sans qu'on l'ait demandé et en détail.",
        "Cela se déroule en monologue : aucune pause pour vous, aucune question sur votre côté.",
        "Vous vous sentez casté dans un rôle — thérapeute, témoin, celui qui va rester.",
        "La chaleur retombe d'un coup si vous répondez avec moins d'intensité que prévu.",
      ] },
      { type: "h2", accent: "green", text: "Que faire" },
      { type: "p", text: "Vous ne devez pas une confidence de même poids, et vous n'avez pas non plus à disparaître. Chaleureux et honnête, cela suffit : remerciez pour la confiance, dites que cela fait beaucoup, dites que vous aimeriez apprendre à les connaître lentement. **Changez ensuite le rythme, pas la personne.** Si elle peut ralentir avec vous, tout va probablement bien. Si une réponse prudente est lue comme un rejet, c'est aussi une information utile." },
      { type: "p", text: "Et si c'est vous qui faites ça, essayez de donner le titre et de vous arrêter là — deux années difficiles, une famille compliquée — puis laissez l'autre demander. Être connu prend plus de temps qu'être raconté. La proximité n'est pas dans l'histoire ; elle se construit pendant qu'elle sort, chacun son tour. Vouloir être vu vite n'est pas un défaut. Il n'y a que le moment qui fasse mal." },
    ],
  },
  es: {
    term: "Floodlighting",
    summary:
      "Soltar muy pronto la historia más pesada que llevas — traumas, diagnósticos, el relato entero de un ex — antes de que haya entre los dos confianza suficiente para sostenerla.",
    blocks: [
      { type: "h2", text: "Por qué se hace" },
      { type: "p", text: "El nombre viene de la luz: todo encendido a la vez, nada en penumbra. La investigadora Brené Brown lo usó para la vulnerabilidad convertida en foco — contar lo más duro no para acercarse, sino para ver qué hace el otro con ello. En una app de citas suele salir de un buen sitio. Ganas de que te conozcan rápido, y cansancio: si esto lo va a romper, mejor esta noche que dentro de cuatro meses." },
      { type: "p", text: "No es lo mismo que ser abierto. La apertura avanza al paso del otro y le deja sitio para responder; el floodlighting llega de golpe y no lo deja. Tampoco es bombardeo de amor, aunque la intensidad se parezca. **El bombardeo de amor apunta hacia ti**: los halagos, la velocidad, los planes. **El floodlighting trata de esa persona**, y tú eres el público." },
      { type: "h2", text: "Cómo se siente desde tu lado" },
      { type: "ul", items: [
        "Lo más pesado aparece en la primera hora o dos, sin que lo pidas y con todo detalle.",
        "Va como un monólogo: ninguna pausa para ti, ninguna pregunta sobre tu parte.",
        "Sientes que te asignan un papel — terapeuta, testigo, la persona que se va a quedar.",
        "El calor se enfría de golpe si respondes con menos intensidad de la esperada.",
      ] },
      { type: "h2", accent: "green", text: "Qué hacer" },
      { type: "p", text: "No debes una confesión del mismo tamaño, y tampoco tienes que desaparecer. Cálido y honesto funciona: agradece la confianza, di que suena a mucho y di que te gustaría conocerle despacio. **Después cambia el ritmo, no a la persona.** Si puede ir más lento contigo, probablemente todo esté bien. Si una respuesta cuidadosa se lee como rechazo, eso también es información útil." },
      { type: "p", text: "Y si quien hace esto eres tú, prueba a dar el titular y parar — un par de años duros, una familia complicada — y deja que pregunten. Que te conozcan tarda más que contarlo. La cercanía no está en la historia; se construye mientras la historia sale, por turnos. Querer que te vean rápido no es un defecto. Lo que duele es el momento." },
    ],
  },
  ar: {
    term: "فلودلايتنغ",
    summary:
      "أن تُفرغ أثقل ما في تاريخك — الصدمات والتشخيصات وحكاية علاقة سابقة كاملة — في وقت مبكر جدًا، قبل أن تنشأ بينكما ثقة تكفي لحمل ذلك.",
    blocks: [
      { type: "h2", text: "لماذا يفعل الناس ذلك؟" },
      { type: "p", text: "الاسم مأخوذ من الضوء: كل شيء مضاء دفعة واحدة، ولا شيء يبقى في الظل. استخدمته الباحثة بريني براون للتعبير عن الهشاشة حين تتحول إلى كشّاف — أن تروي أصعب ما لديك لا لتقترب، بل لترى ماذا سيفعل الآخر بما رويت. وفي تطبيقات التعارف غالبًا ما ينبع من نيّة طيبة: رغبة في أن تُعرَف بسرعة، وإرهاق يقول إن كان هذا سينهي الأمر، فليكن الليلة لا بعد أربعة أشهر." },
      { type: "p", text: "هذا ليس الانفتاح نفسه. الانفتاح يسير بخطى الطرف الآخر ويترك له مساحة للرد؛ أما هذا فيصل دفعة واحدة ولا يترك شيئًا. وهو ليس قصفًا بالحب أيضًا، وإن تشابهت الحدّة. **القصف بالحب موجّه إليك أنت** — المديح والسرعة والخطط. **أما الفلودلايتنغ فيدور حوله هو**، وأنت الجمهور." },
      { type: "h2", text: "كيف يبدو الأمر من جهتك" },
      { type: "ul", items: [
        "الأثقل يصل في الساعة الأولى أو الثانية، من دون أن تسأل وبكل التفاصيل.",
        "يمضي كأنه مونولوج: لا توقّف من أجلك، ولا سؤال عن جهتك أنت.",
        "تشعر أنك وُضعت في دور — معالج، أو شاهد، أو الشخص الذي سيبقى.",
        "يبرد الدفء فجأة إن جاء ردّك أقل حدّة مما كان متوقعًا.",
      ] },
      { type: "h2", accent: "green", text: "ماذا تفعل" },
      { type: "p", text: "أنت لست مدينًا باعتراف بالحجم نفسه، ولست مضطرًا للاختفاء كذلك. الدفء والصدق يكفيان: اشكره على ثقته، قل إن هذا يبدو ثقيلًا، وقل إنك تودّ التعرف عليه على مهل. **ثم غيّر الإيقاع لا الشخص.** إن استطاع أن يبطئ معك فالأمر على الأرجح بخير. وإن قُرئ ردّك الحذر على أنه رفض، فتلك أيضًا معلومة مفيدة." },
      { type: "p", text: "وإن كنت أنت من يفعل ذلك، جرّب أن تقول العنوان وتتوقف — سنتان صعبتان، عائلة معقّدة — ثم دع الآخر يسأل. أن تُعرَف يستغرق وقتًا أطول من أن تُخبِر. القرب ليس في الحكاية؛ إنه يُبنى بينما تخرج الحكاية بالتناوب. الرغبة في أن تُرى بسرعة ليست عيبًا. التوقيت وحده هو ما يؤلم." },
    ],
  },
  ru: {
    term: "Флудлайтинг",
    summary:
      "Вывалить самую тяжёлую часть своей истории — травмы, диагнозы, всю сагу про бывшего — слишком рано, когда доверия между двумя людьми ещё недостаточно, чтобы это выдержать.",
    blocks: [
      { type: "h2", text: "Почему так делают" },
      { type: "p", text: "Название пришло от света: включено сразу всё, в тени не остаётся ничего. Исследовательница Брене Браун использовала это слово для уязвимости, превращённой в прожектор, — рассказать самое трудное не для того, чтобы стать ближе, а чтобы посмотреть, что человек с этим сделает. В приложении знакомств за этим обычно стоит вполне понятное чувство. Желание быть узнанным быстро и усталость: если это всё равно всё закончит, пусть лучше сегодня, чем через четыре месяца." },
      { type: "p", text: "Это не то же самое, что открытость. Открытость идёт в ногу с собеседником и оставляет ему место для ответа; флудлайтинг приходит целиком и места не оставляет. И это не бомбардировка любовью, хотя по накалу похоже. **Бомбардировка любовью направлена на вас** — похвалы, скорость, планы. **Флудлайтинг же о них самих**, а вы зрительный зал." },
      { type: "h2", text: "Как это ощущается с вашей стороны" },
      { type: "ul", items: [
        "Самое тяжёлое появляется в первый час или два, без вопроса с вашей стороны и со всеми подробностями.",
        "Это идёт монологом: ни паузы для вас, ни вопроса о том, что происходит у вас.",
        "Вы чувствуете, что вас назначили на роль — терапевта, свидетеля, того, кто останется.",
        "Тепло резко спадает, если вы отвечаете с меньшим накалом, чем от вас ждали.",
      ] },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Вы не обязаны отвечать признанием того же веса и не обязаны исчезать. Работает тёплое и честное: поблагодарите за доверие, скажите, что это звучит тяжело, и скажите, что хотели бы узнавать человека постепенно. **А потом меняйте темп, а не человека.** Если он может замедлиться вместе с вами, скорее всего, всё в порядке. Если же осторожный ответ прочитан как отказ, это тоже полезные сведения." },
      { type: "p", text: "А если так делаете вы, попробуйте назвать заголовок и остановиться — пара тяжёлых лет, сложная семья — и дайте собеседнику спросить. Быть узнанным дольше, чем быть рассказанным. Близость не в самой истории; она строится, пока история выходит наружу, по очереди. Хотеть, чтобы вас увидели быстро, — не изъян. Больно делает только время." },
    ],
  },
  pt: {
    term: "Floodlighting",
    summary:
      "Despejar cedo demais a parte mais pesada da própria história — traumas, diagnósticos, a saga inteira de um ex — antes que exista entre os dois confiança suficiente para sustentar aquilo.",
    blocks: [
      { type: "h2", text: "Por que as pessoas fazem isso" },
      { type: "p", text: "O nome vem da luz: tudo aceso de uma vez, nada deixado na sombra. A pesquisadora Brené Brown usou a palavra para a vulnerabilidade virada holofote — contar o mais difícil não para chegar perto, mas para ver o que o outro faz com aquilo. Num app de relacionamento costuma nascer de um lugar decente. Vontade de ser conhecido depressa, e cansaço: se isso vai acabar com tudo, melhor hoje do que daqui a quatro meses." },
      { type: "p", text: "Não é a mesma coisa que ser aberto. A abertura anda no passo da outra pessoa e deixa espaço para ela responder; o floodlighting chega inteiro e não deixa. Também não é love bombing, embora a intensidade pareça. **O love bombing é apontado para você** — os elogios, a velocidade, os planos. **O floodlighting é sobre a outra pessoa**, e você é a plateia." },
      { type: "h2", text: "Como parece do seu lado" },
      { type: "ul", items: [
        "O material mais pesado chega na primeira hora ou duas, sem você pedir e com todos os detalhes.",
        "Corre como monólogo: nenhuma pausa para você, nenhuma pergunta sobre o seu lado.",
        "Você sente que foi escalado para um papel — terapeuta, testemunha, quem vai ficar.",
        "O calor esfria de repente se você responde com menos intensidade do que se esperava.",
      ] },
      { type: "h2", accent: "green", text: "O que fazer" },
      { type: "p", text: "Você não deve uma confissão do mesmo tamanho, e também não precisa sumir. Caloroso e honesto funciona: agradeça a confiança, diga que parece muita coisa e diga que gostaria de conhecer a pessoa devagar. **Depois mude o ritmo, não a pessoa.** Se ela conseguir desacelerar com você, provavelmente está tudo bem. Se uma resposta cuidadosa for lida como rejeição, isso também é informação útil." },
      { type: "p", text: "E se quem faz isso é você, tente dar a manchete e parar — alguns anos difíceis, uma família complicada — e deixe perguntarem. Ser conhecido demora mais do que ser contado. A proximidade não está na história; ela se constrói enquanto a história sai, em turnos. Querer ser visto rápido não é defeito. Só o tempo é que dói." },
    ],
  },
  it: {
    term: "Floodlighting",
    summary:
      "Scaricare troppo presto la parte più pesante della propria storia — traumi, diagnosi, il racconto completo di un ex — prima che tra due persone ci sia abbastanza fiducia per reggerla.",
    blocks: [
      { type: "h2", text: "Perché le persone lo fanno" },
      { type: "p", text: "Il nome viene dalla luce: tutto acceso in una volta, niente lasciato in ombra. La ricercatrice Brené Brown lo usava per la vulnerabilità trasformata in faro — raccontare le cose più dure non per avvicinarsi, ma per vedere che cosa ne fa l'altro. Su un'app di incontri nasce quasi sempre da un posto onesto. La voglia di essere conosciuti in fretta e la stanchezza: se deve finire per questo, meglio stasera che fra quattro mesi." },
      { type: "p", text: "Non è la stessa cosa dell'apertura. L'apertura procede al passo dell'altro e gli lascia spazio per rispondere; il floodlighting arriva tutto insieme e quello spazio non lo lascia. E non è nemmeno love bombing, anche se l'intensità si somiglia. **Il love bombing è puntato su di te** — gli elogi, la velocità, i progetti. **Il floodlighting parla di loro**, e tu sei il pubblico." },
      { type: "h2", text: "Come si sente dal tuo lato" },
      { type: "ul", items: [
        "La parte più pesante arriva nella prima ora o due, senza che tu l'abbia chiesta e in ogni dettaglio.",
        "Procede come un monologo: nessuna pausa per te, nessuna domanda su quello che c'è dalla tua parte.",
        "Ti senti assegnato a un ruolo — terapeuta, testimone, quello che resterà.",
        "Il calore si raffredda di colpo se rispondi con meno intensità di quanta ne fosse attesa.",
      ] },
      { type: "h2", accent: "green", text: "Che cosa fare" },
      { type: "p", text: "Non devi una confessione dello stesso peso, e non devi nemmeno sparire. Caldo e onesto funziona: ringrazia per la fiducia, di' che sembra tanto e di' che ti piacerebbe conoscerlo con calma. **Poi cambia il ritmo, non la persona.** Se riesce a rallentare insieme a te, probabilmente va bene così. Se una risposta prudente viene letta come rifiuto, anche quella è un'informazione utile." },
      { type: "p", text: "E se sei tu a farlo, prova a dare il titolo e a fermarti — un paio di anni duri, una famiglia complicata — e poi lascia che ti chiedano. Essere conosciuti richiede più tempo che essere raccontati. La vicinanza non sta nella storia; si costruisce mentre la storia esce, a turno. Voler essere visti in fretta non è un difetto. A fare male è solo il momento." },
    ],
  },
  ja: {
    term: "フラッドライティング",
    summary:
      "トラウマや診断、元恋人の顛末といった重い過去を、それを受け止められるだけの信頼がまだ育っていない段階で一気に打ち明けてしまうこと。",
    blocks: [
      { type: "h2", text: "なぜそうしてしまうのか" },
      { type: "p", text: "名前は照明から来ています。全部いっぺんに点けて、影をひとつも残さない。研究者のブレネー・ブラウンは、サーチライトのようになった弱さを指してこの言葉を使いました。いちばん重い話を、近づくためではなく、相手がそれをどう扱うか見るために差し出す。マッチングアプリでは、たいてい悪意ではありません。早く分かってほしいという気持ちと、疲れです。どうせこれで終わるなら、四か月後より今夜のほうがいい、と。" },
      { type: "p", text: "これは率直さとは別ものです。率直さは相手の歩調に合わせ、返事をする余白を残します。フラッドライティングは一度に届き、その余白を残しません。ラブボミングとも違います。強さは似ていても、**ラブボミングはあなたに向かっています**。褒め言葉、速さ、これからの計画。**フラッドライティングは相手自身の話で**、あなたは観客です。" },
      { type: "h2", text: "こちら側から見るとどうなるか" },
      { type: "ul", items: [
        "いちばん重い部分が、最初の一、二時間のうちに、聞いてもいないのに細部まで出てくる。",
        "モノローグとして進む。こちらのための間がなく、こちら側について何も尋ねられない。",
        "役を割り当てられた感じがする。カウンセラー、証人、あるいは「残るはずの人」。",
        "期待されたより弱い温度で返すと、温かさが急に引く。",
      ] },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "同じ重さの告白を返す義理はありませんし、黙って消える必要もありません。温かく正直に伝えれば十分です。話してくれてありがとう、それは大変だったね、ゆっくり知っていきたい。**そのうえで、人ではなくテンポのほうを変えます。** 一緒に速度を落とせる相手なら、たぶん大丈夫です。慎重な返事を拒絶と受け取られたなら、それもまた役に立つ情報です。" },
      { type: "p", text: "自分がやってしまう側なら、見出しだけ言って止めてみてください。しんどい数年があった、家族が少し複雑だ。そこから先は相手に尋ねさせる。分かってもらうには、話すよりも時間がかかります。親しさは話の中にはなく、話が交互に出てくるあいだに積まれていきます。早く見てほしいと願うことは欠点ではありません。痛いのは時期だけです。" },
    ],
  },
  ko: {
    term: "플러드라이팅",
    summary:
      "트라우마나 진단, 전 연인의 전말 같은 가장 무거운 과거를, 그것을 감당할 만한 신뢰가 아직 생기기 전에 한꺼번에 쏟아내는 일.",
    blocks: [
      { type: "h2", text: "왜 그렇게 될까" },
      { type: "p", text: "이름은 조명에서 왔습니다. 한꺼번에 다 켜서 그늘을 하나도 남기지 않는 것. 연구자 브레네 브라운은 서치라이트가 되어버린 취약함을 가리키며 이 말을 썼습니다. 가장 어려운 이야기를 가까워지려고가 아니라, 상대가 그걸로 무엇을 하는지 보려고 꺼내는 것이죠. 데이팅 앱에서는 대개 나쁜 마음이 아닙니다. 빨리 알려지고 싶은 마음, 그리고 지침입니다. 어차피 이걸로 끝날 거라면 넉 달 뒤보다 오늘 밤이 낫다는 것." },
      { type: "p", text: "이건 솔직함과 다릅니다. 솔직함은 상대의 보폭에 맞춰 가고 대답할 여백을 남깁니다. 플러드라이팅은 한꺼번에 도착하고 그 여백을 남기지 않습니다. 러브바밍과도 다릅니다. 강도는 비슷해 보여도, **러브바밍은 당신을 향합니다.** 칭찬, 속도, 앞으로의 계획. **플러드라이팅은 그 사람 자신의 이야기이고**, 당신은 관객입니다." },
      { type: "h2", text: "당신 쪽에서는 이렇게 느껴집니다" },
      { type: "ul", items: [
        "가장 무거운 이야기가 첫 한두 시간 안에, 묻지도 않았는데 세세하게 나옵니다.",
        "독백처럼 흘러갑니다. 당신을 위한 쉼표도, 당신 쪽에 대한 질문도 없습니다.",
        "어떤 역할에 배정된 느낌이 듭니다. 상담자, 증인, 끝까지 남을 사람.",
        "기대만큼 강하게 반응하지 않으면 온기가 갑자기 식습니다.",
      ] },
      { type: "h2", accent: "green", text: "그래서 어떻게 하나" },
      { type: "p", text: "같은 무게의 고백을 돌려줄 의무는 없고, 사라질 필요도 없습니다. 따뜻하고 솔직하면 됩니다. 믿고 말해줘서 고맙다고, 많이 무거운 이야기 같다고, 천천히 알아가고 싶다고 말하세요. **그다음엔 사람이 아니라 속도를 바꾸세요.** 함께 느려질 수 있는 사람이라면 아마 괜찮습니다. 조심스러운 대답이 거절로 읽힌다면, 그것도 쓸모 있는 정보입니다." },
      { type: "p", text: "하는 쪽이 당신이라면, 제목만 말하고 멈춰 보세요. 힘든 몇 년이 있었다고, 가족이 조금 복잡하다고. 그다음은 상대가 묻게 두세요. 알려지는 데는 말하는 것보다 오래 걸립니다. 가까움은 이야기 안에 있지 않고, 이야기가 번갈아 나오는 동안 쌓입니다. 빨리 보이고 싶은 마음은 흠이 아닙니다. 아픈 건 시기뿐입니다." },
    ],
  },
  zh: {
    term: "Floodlighting",
    summary:
      "在两个人之间还没有足够信任托住之前，就把最沉重的过往——创伤、诊断、前任的整段故事——一次性倒出来；中文可以叫情感探照灯。",
    blocks: [
      { type: "h2", text: "人为什么会这样" },
      { type: "p", text: "这个名字来自灯：一次全打开，不留一点阴影。研究者布琳·布朗用它形容变成探照灯的脆弱——把最难开口的事说出来，不是为了靠近，而是想看看对方会怎么处理。在交友软件上，它多半出于善意：想被人快点认识，加上一种疲惫——反正这事迟早会把关系压垮，那就今晚，别拖到四个月后。" },
      { type: "p", text: "这和坦诚不是一回事。坦诚跟着对方的步子走，留出让人回应的空隙；而这种倾诉一次到位，不留空隙。它也不是爱情轰炸，尽管强度看着相似。**爱情轰炸是冲着你来的**——夸奖、速度、对未来的安排。**这种倾诉说的是他自己**，你是观众。" },
      { type: "h2", text: "从你这一侧看是什么样" },
      { type: "ul", items: [
        "最沉的部分在头一两个小时就到了，没人问，细节还很全。",
        "整段像独白：没有留给你的停顿，也没有一句问到你这边。",
        "你感觉被安排了一个角色——心理咨询师、见证人，或者那个会留下来的人。",
        "如果你的回应没有对方期待的那么强烈，热度会突然降下去。",
      ] },
      { type: "h2", accent: "green", text: "该怎么办" },
      { type: "p", text: "你不欠一份同等分量的坦白，也不必就此消失。温和而诚实就够了：谢谢对方愿意说，讲一句这听起来很不容易，再说你想慢慢认识他。**接下来要改的是节奏，不是这个人。** 如果他能跟着你慢下来，多半没问题。如果一个谨慎的回应被读成了拒绝，那也是有用的信息。" },
      { type: "p", text: "如果这样做的是你，试着只给一个标题就停住——过去两年不太好过，家里有点复杂——剩下的让对方来问。被了解，比被讲述要慢得多。亲近不在故事里，它是在故事一来一往地说出来的过程中攒起来的。想被快点看见并不是缺点，疼的只是时机。" },
    ],
  },
  nl: {
    term: "Floodlighting",
    summary:
      "Je zwaarste geschiedenis — trauma's, diagnoses, het hele verhaal over een ex — heel vroeg uitstorten, voordat er tussen twee mensen genoeg vertrouwen is om dat te dragen.",
    blocks: [
      { type: "h2", text: "Waarom mensen dit doen" },
      { type: "p", text: "De naam komt van het licht: alles tegelijk aan, niets blijft in de schaduw. Onderzoeker Brené Brown gebruikte het voor kwetsbaarheid die een schijnwerper wordt — de zwaarste dingen vertellen niet om dichterbij te komen, maar om te zien wat de ander ermee doet. Op een datingapp komt het meestal uit een fatsoenlijke hoek. De wens om snel gekend te worden, en uitputting: als dit het toch afbreekt, dan liever vanavond dan over vier maanden." },
      { type: "p", text: "Het is niet hetzelfde als open zijn. Openheid loopt in de pas met de ander en laat ruimte om te antwoorden; floodlighting komt in één keer en laat die ruimte niet. Het is ook geen love bombing, al lijkt de intensiteit erop. **Love bombing is op jou gericht** — de complimenten, het tempo, de plannen. **Floodlighting gaat over hen**, en jij bent het publiek." },
      { type: "h2", text: "Hoe het van jouw kant voelt" },
      { type: "ul", items: [
        "Het zwaarste komt in het eerste uur of twee, ongevraagd en tot in detail.",
        "Het loopt als een monoloog: geen pauze voor jou, geen vraag over iets aan jouw kant.",
        "Je voelt je in een rol gezet — therapeut, getuige, degene die blijft.",
        "De warmte koelt scherp af als je met minder intensiteit antwoordt dan werd verwacht.",
      ] },
      { type: "h2", accent: "green", text: "Wat je eraan kunt doen" },
      { type: "p", text: "Je bent geen bekentenis van hetzelfde gewicht verschuldigd, en verdwijnen hoeft ook niet. Warm en eerlijk werkt: bedank voor het vertrouwen, zeg dat het veel klinkt, en zeg dat je die persoon graag langzaam wilt leren kennen. **Verander daarna het tempo, niet de persoon.** Kan iemand met jou vertragen, dan zit het waarschijnlijk goed. Wordt een voorzichtig antwoord gelezen als afwijzing, dan is dat ook bruikbare informatie." },
      { type: "p", text: "En als jij degene bent die dit doet: probeer de kop te geven en daar te stoppen — een paar zware jaren, een ingewikkelde familie — en laat de ander vragen. Gekend worden duurt langer dan verteld worden. De nabijheid zit niet in het verhaal; die wordt gebouwd terwijl het verhaal om beurten naar buiten komt. Snel gezien willen worden is geen gebrek. Alleen de timing doet pijn." },
    ],
  },
  pl: {
    term: "Floodlighting",
    summary:
      "Wyrzucenie z siebie najcięższej części swojej historii — traum, diagnoz, całej opowieści o byłym — bardzo wcześnie, zanim między dwojgiem ludzi jest dość zaufania, by to unieść.",
    blocks: [
      { type: "h2", text: "Dlaczego ludzie tak robią" },
      { type: "p", text: "Nazwa pochodzi od światła: wszystko zapalone naraz, nic nie zostaje w cieniu. Badaczka Brené Brown używała tego słowa dla bezbronności zamienionej w reflektor — opowiadania najtrudniejszych rzeczy nie po to, by się zbliżyć, ale by zobaczyć, co druga osoba z tym zrobi. W aplikacji randkowej zwykle bierze się to z przyzwoitego miejsca. Z pragnienia, żeby ktoś szybko cię poznał, i ze zmęczenia: skoro to i tak wszystko zakończy, lepiej dziś niż za cztery miesiące." },
      { type: "p", text: "To nie to samo co otwartość. Otwartość idzie w rytmie drugiej osoby i zostawia jej miejsce na odpowiedź; floodlighting przychodzi w całości i tego miejsca nie zostawia. Nie jest też bombardowaniem miłością, choć natężenie bywa podobne. **Bombardowanie miłością celuje w ciebie** — komplementy, tempo, plany. **Floodlighting dotyczy tej osoby**, a ty jesteś publicznością." },
      { type: "h2", text: "Jak to wygląda z twojej strony" },
      { type: "ul", items: [
        "Najcięższe rzeczy przychodzą w pierwszej godzinie albo dwóch, bez pytania i ze wszystkimi szczegółami.",
        "Idzie to jak monolog: żadnej pauzy dla ciebie, żadnego pytania o twoją stronę.",
        "Czujesz się obsadzony w roli — terapeuty, świadka, tego, kto zostanie.",
        "Ciepło gwałtownie stygnie, jeśli odpowiesz z mniejszą intensywnością, niż oczekiwano.",
      ] },
      { type: "h2", accent: "green", text: "Co z tym zrobić" },
      { type: "p", text: "Nie jesteś winien wyznania tej samej wagi i nie musisz też znikać. Ciepło i szczerze wystarczy: podziękuj za zaufanie, powiedz, że to brzmi jak dużo, i powiedz, że chciałbyś poznawać tę osobę powoli. **Potem zmień tempo, a nie człowieka.** Jeśli potrafi zwolnić razem z tobą, prawdopodobnie jest dobrze. Jeśli ostrożna odpowiedź zostanie odczytana jako odrzucenie, to również użyteczna informacja." },
      { type: "p", text: "A jeśli to ty tak robisz, spróbuj podać nagłówek i się zatrzymać — kilka trudnych lat, skomplikowana rodzina — a potem pozwól, żeby cię dopytali. Bycie poznanym trwa dłużej niż bycie opowiedzianym. Bliskość nie leży w historii; buduje się, kiedy historia wychodzi na zmianę. Chcieć być szybko zobaczonym to nie wada. Boli tylko moment." },
    ],
  },
  sv: {
    term: "Floodlighting",
    summary:
      "Att vräka ur sig sin tyngsta historia — trauman, diagnoser, hela berättelsen om ett ex — väldigt tidigt, innan det finns nog med tillit mellan två personer för att bära den.",
    blocks: [
      { type: "h2", text: "Varför människor gör det" },
      { type: "p", text: "Namnet kommer från ljuset: allt tänt på en gång, inget kvar i skugga. Forskaren Brené Brown använde ordet om sårbarhet som blivit strålkastare — att berätta det svåraste inte för att komma nära, utan för att se vad den andra gör med det. På en dejtingapp kommer det oftast från ett hyggligt ställe. En önskan att bli känd fort, och trötthet: ska det här ändå ta slut av det, hellre i kväll än om fyra månader." },
      { type: "p", text: "Det är inte samma sak som att vara öppen. Öppenhet går i takt med den andra och lämnar plats för svar; floodlighting kommer på en gång och lämnar ingen plats. Det är inte heller love bombing, även om intensiteten liknar. **Love bombing riktas mot dig** — berömmet, farten, planerna. **Floodlighting handlar om dem**, och du är publiken." },
      { type: "h2", text: "Så känns det från ditt håll" },
      { type: "ul", items: [
        "Det tyngsta kommer under den första timmen eller två, obett och i full detalj.",
        "Det går som en monolog: ingen paus för dig, ingen fråga om något på din sida.",
        "Du känner dig placerad i en roll — terapeut, vittne, den som ska stanna.",
        "Värmen svalnar tvärt om du svarar med mindre intensitet än vad som väntades.",
      ] },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Du är ingen bekännelse av samma tyngd skyldig, och du behöver inte försvinna heller. Varmt och ärligt räcker: tacka för förtroendet, säg att det låter som mycket och säg att du vill lära känna personen långsamt. **Ändra sedan takten, inte människan.** Kan den andra sakta ner tillsammans med dig är det förmodligen bra. Läses ett försiktigt svar som avvisande är även det användbar information." },
      { type: "p", text: "Och är det du som gör det: pröva att ge rubriken och stanna där — ett par tunga år, en trasslig familj — och låt den andra fråga. Att bli känd tar längre tid än att bli berättad. Närheten ligger inte i historien; den byggs medan historien kommer ut, växelvis. Att vilja bli sedd fort är inget fel. Det är bara tajmingen som gör ont." },
    ],
  },
  hi: {
    term: "फ़्लडलाइटिंग",
    summary:
      "अपने सबसे भारी अतीत — सदमे, बीमारियों की जानकारी, किसी पुराने रिश्ते की पूरी कहानी — को बहुत जल्दी उँडेल देना, जब तक दोनों के बीच उसे थामने लायक भरोसा बना ही नहीं होता।",
    blocks: [
      { type: "h2", text: "लोग ऐसा क्यों करते हैं" },
      { type: "p", text: "नाम रोशनी से आया है: सब कुछ एक साथ जला दिया जाए, कहीं कोई छाया न बचे। शोधकर्ता ब्रेने ब्राउन ने इस शब्द का इस्तेमाल उस कमज़ोरी के लिए किया जो सर्चलाइट बन जाती है — सबसे कठिन बातें पास आने के लिए नहीं, बल्कि यह देखने के लिए बताना कि सामने वाला उनका क्या करता है। डेटिंग ऐप पर इसके पीछे अक्सर बुरी नीयत नहीं होती। जल्दी जान लिए जाने की चाह होती है, और थकान: अगर इसी से बात टूटनी है, तो चार महीने बाद के बजाय आज रात ही सही।" },
      { type: "p", text: "यह खुलेपन जैसा नहीं है। खुलापन सामने वाले की चाल से चलता है और उसे जवाब देने की जगह छोड़ता है; फ़्लडलाइटिंग एक ही बार में आती है और वह जगह नहीं छोड़ती। यह लव बॉम्बिंग भी नहीं है, भले तीव्रता मिलती-जुलती लगे। **लव बॉम्बिंग आपकी तरफ़ तनी होती है** — तारीफ़, रफ़्तार, आगे की योजनाएँ। **फ़्लडलाइटिंग उनके अपने बारे में है**, और आप दर्शक हैं।" },
      { type: "h2", text: "आपकी तरफ़ से यह कैसा लगता है" },
      { type: "ul", items: [
        "सबसे भारी हिस्सा पहले एक-दो घंटे में ही, बिना पूछे और पूरे ब्योरे के साथ आ जाता है।",
        "यह एकालाप की तरह चलता है: आपके लिए कोई ठहराव नहीं, आपकी तरफ़ का कोई सवाल नहीं।",
        "लगता है आपको कोई भूमिका सौंप दी गई है — काउंसलर, गवाह, या वह जो टिका रहेगा।",
        "अगर आपका जवाब उम्मीद से कम गहरा हो, तो गर्मजोशी एकदम ठंडी पड़ जाती है।",
      ] },
      { type: "h2", accent: "green", text: "क्या करें" },
      { type: "p", text: "आप पर उतने ही भारी किसी इक़बालिया बयान का क़र्ज़ नहीं है, और ग़ायब हो जाना भी ज़रूरी नहीं। गर्मजोशी और ईमानदारी काफ़ी है: भरोसे के लिए शुक्रिया कहिए, कहिए कि यह बहुत कुछ लगता है, और कहिए कि आप उन्हें धीरे-धीरे जानना चाहेंगे। **फिर इंसान नहीं, रफ़्तार बदलिए।** अगर वे आपके साथ धीमे हो सकते हैं, तो शायद सब ठीक है। और अगर एक सँभला हुआ जवाब अस्वीकार समझ लिया जाए, तो वह भी काम की जानकारी है।" },
      { type: "p", text: "और अगर यह आप करते हैं, तो सिर्फ़ शीर्षक कहकर रुक जाइए — कुछ साल भारी बीते, परिवार थोड़ा उलझा हुआ है — बाक़ी उन्हें पूछने दीजिए। जाना जाना, बता देने से ज़्यादा वक़्त लेता है। नज़दीकी कहानी में नहीं होती; वह तब बनती है जब कहानी बारी-बारी से बाहर आती है। जल्दी देखे जाने की चाह कोई कमी नहीं। तकलीफ़ सिर्फ़ वक़्त की होती है।" },
    ],
  },
};
