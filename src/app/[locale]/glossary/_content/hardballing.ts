import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Hardballing — stating what you want from a relationship plainly and early,
 * instead of waiting to find out whether the other person wants the same thing.
 *
 * Judgement calls made here, so a later editor does not undo them by accident:
 *
 * - The page is deliberately not a "how to get commitment" guide. Hardballing
 *   is framed as informing, not negotiating: you state your terms, the other
 *   person states theirs, and an early no counts as a good outcome. Block 5 and
 *   block 6 exist because the obvious failure mode is that this lands as an
 *   ultimatum — the fixes given are timing (not the opening message), one
 *   sentence rather than a speech, no deadline attached to a stranger, and
 *   meaning what you say.
 * - No source is cited in the text. The term is covered as a Gen Z dating trend
 *   by PureWow among other outlets, which is enough to get the meaning right
 *   but is not a statistic, so naming it in the prose would be decoration. No
 *   figure is claimed anywhere on the page.
 * - Block 7 carries the one honest Qulo angle in this batch of four terms
 *   (situationship, talking-stage, soft-launch keep the product out entirely).
 *   The claim is narrow on purpose: writing your own questions *is* a way of
 *   stating what matters to you before the first message. It does not claim
 *   the quiz proves anyone is who they say they are, prevents mismatched
 *   intentions, or verifies anything — see rule 3 of the authoring spec. The
 *   only product mechanics stated are the real ones: 2 to 4 multiple-choice
 *   questions on a free account and up to 10 on a paid plan, four options each,
 *   and a match only on a perfect score. Never write the range as 2 to 10
 *   without naming the paid plan in the same sentence — 10 is the Premium cap,
 *   not what the free reader this copy addresses actually gets.
 * - This page is the far end of the arc that runs situationship (undefined) ->
 *   talking stage (pre-defined) -> hardballing (deliberately defined). Block 1
 *   states the contrast in its own words rather than reusing either page's
 *   phrasing, and neither term is named; the related-term links at the foot of
 *   the page carry the navigation.
 *
 * Term names: the English loanword is what circulates in tr, de, fr, es, pt,
 * it, nl, pl and sv, and ja/ko/ru/hi use the established transliteration. Two
 * exceptions: zh gets "打直球", which is the everyday Chinese phrase for exactly
 * this move and far better than a transliteration, and ar gets the descriptive
 * "المصارحة المبكرة" since no Arabic loanword has settled. Both summaries name
 * the English term so search still lands.
 */
export const hardballing: LocalizedGlossaryEntry = {
  en: {
    term: "Hardballing",
    summary:
      "Saying plainly and early what you want from a relationship — something serious, something casual, marriage, no kids — instead of waiting months to find out whether the other person wants the same thing.",
    blocks: [
      { type: "h2", text: "Why people started doing it" },
      {
        type: "p",
        text: "For about a decade the safest way to date was to seem unbothered. Wanting something specific looked like pressure, so people learned to keep it vague and find out later. Later turned out to be expensive: months in, someone finally admits they were never looking for the same thing. Hardballing is the correction. It treats what you are looking for as an opening fact rather than a late reveal.",
      },
      {
        type: "p",
        text: "The hard part is the clarity, not the pressure. You state your own terms and let the other person state theirs; nobody is being asked to agree to anything. That makes an early no a good outcome rather than a rejection — it costs one evening instead of half a year. Done properly it is generous: you are handing someone the information they need to opt out.",
      },
      { type: "h2", text: "What it actually sounds like" },
      {
        type: "ul",
        items: [
          "It is about you: \"I'm looking for something serious\", not \"are you going to commit?\"",
          "It is said once, early, and then the conversation carries on as normal.",
          "It leaves room for a different answer — you are informing, not negotiating.",
          "It names what you want, not a list of requirements the other person has to meet.",
        ],
      },
      { type: "h2", text: "How to say it without it landing as an ultimatum", accent: "green" },
      {
        type: "p",
        text: "Timing does most of the work. Not the opening message — there is nothing to be clear about yet, and a stranger reads it as a demand. Once a real conversation exists, one sentence about yourself is enough, and then let it sit; repeating it turns information into pressure. Do not attach a deadline to someone you have just met. And say only what you actually mean: a want you drop two weeks later teaches them not to believe you.",
      },
      {
        type: "p",
        text: "Writing your own questions does the same job, earlier. On Qulo each member writes **2 to 4 multiple-choice questions, four options each** — up to 10 on a paid plan — and a match only happens when someone gets every one right — so what you care about is on the table before the first message. A question is the quieter way of saying it.",
      },
    ],
  },

  tr: {
    term: "Hardballing",
    summary:
      "İlişkiden ne istediğini baştan ve açıkça söylemek — ciddi bir şey, hafif bir şey, evlilik, çocuk istememek — karşı tarafın aynı şeyi isteyip istemediğini aylar sonra öğrenmek yerine.",
    blocks: [
      { type: "h2", text: "Bu neden ortaya çıktı" },
      {
        type: "p",
        text: "Yaklaşık on yıl boyunca en güvenli flört yöntemi, hiçbir şey umurunda değilmiş gibi görünmekti. Belirli bir şey istemek baskı gibi duruyordu; herkes muğlak kalmayı ve gerisini sonra öğrenmeyi öğrendi. Sonrası pahalıya patladı: aylar geçtikten sonra biri çıkıp aslında hiç aynı şeyi aramadığını söylüyordu. Hardballing bunun düzeltmesi. Ne aradığını en sonda açılan bir kart değil, en baştaki bir bilgi sayıyor.",
      },
      {
        type: "p",
        text: "Buradaki sertlik baskı değil, netlik. Kendi şartını söylersin, karşı taraf da kendisininkini söyler; kimseden bir şeye evet demesi istenmez. Bu yüzden erken gelen bir hayır, reddedilmek değil iyi bir sonuçtur: yarım yıl yerine bir akşama mal olur. Doğru yapıldığında cömert bir şeydir — karşındakine vazgeçebilmesi için gereken bilgiyi verirsin.",
      },
      { type: "h2", text: "Kulağa gerçekte nasıl gelir" },
      {
        type: "ul",
        items: [
          "Konu sensin: \"Ciddi bir şey arıyorum\" dersin, \"sen bağlanacak mısın?\" değil.",
          "Bir kez ve erken söylenir; sonra sohbet olağan şekilde devam eder.",
          "Farklı bir cevaba yer bırakır — bilgi verirsin, pazarlık etmezsin.",
          "Ne istediğini söyler; karşı tarafın karşılaması gereken bir liste okumaz.",
        ],
      },
      { type: "h2", text: "Ültimatom gibi durmadan nasıl söylenir", accent: "green" },
      {
        type: "p",
        text: "İşin çoğunu zamanlama halleder. İlk mesaj değil — henüz netleşecek bir şey yok ve tanımadığı biri bunu talep gibi okur. Gerçek bir sohbet kurulduğunda kendinle ilgili tek bir cümle yeter; sonra bırak öylece dursun. Tekrarlamak bilgiyi baskıya çevirir. Yeni tanıştığın birine süre koyma. Bir de sadece gerçekten kastettiğini söyle: iki hafta sonra vazgeçtiğin bir istek, karşındakine sana inanmamayı öğretir.",
      },
      {
        type: "p",
        text: "Kendi sorularını yazmak da aynı işi, daha erken yapar. Qulo'da herkes **dört seçenekli 2 ila 4 soru** yazar — ücretli planda 10'a kadar — ve biri ancak hepsini doğru bilirse eşleşme olur — yani senin için önemli olan şey, ilk mesajdan önce ortadadır. Soru, bunu söylemenin daha sessiz yoludur.",
      },
    ],
  },

  de: {
    term: "Hardballing",
    summary:
      "Früh und unmissverständlich sagen, was man von einer Beziehung will — etwas Ernstes, etwas Lockeres, Ehe, keine Kinder — statt monatelang herauszufinden, ob das Gegenüber dasselbe sucht.",
    blocks: [
      { type: "h2", text: "Warum das aufkam" },
      {
        type: "p",
        text: "Ungefähr ein Jahrzehnt lang war die sicherste Art zu daten, unbeeindruckt zu wirken. Etwas Bestimmtes zu wollen sah nach Druck aus, also blieben alle vage und fanden es später heraus. Später war teuer: Nach Monaten gibt jemand zu, nie dasselbe gesucht zu haben. Hardballing ist die Korrektur. Was man sucht, wird zur Eröffnungsinformation statt zur späten Enthüllung.",
      },
      {
        type: "p",
        text: "Hart ist daran die Klarheit, nicht der Druck. Du nennst deine Bedingungen, die andere Person nennt ihre; niemand soll irgendetwas zusagen. Damit ist ein frühes Nein ein gutes Ergebnis und keine Abfuhr — es kostet einen Abend statt eines halben Jahres. Richtig gemacht ist es großzügig: Du gibst jemandem die Information, mit der er aussteigen kann.",
      },
      { type: "h2", text: "Wie es tatsächlich klingt" },
      {
        type: "ul",
        items: [
          "Es geht um dich: \"Ich suche etwas Ernstes\", nicht \"willst du dich festlegen?\"",
          "Es wird einmal gesagt, früh, und danach läuft das Gespräch ganz normal weiter.",
          "Es lässt Raum für eine andere Antwort — du informierst, du verhandelst nicht.",
          "Es benennt deinen Wunsch, keine Liste von Anforderungen an die andere Person.",
        ],
      },
      { type: "h2", text: "Wie es nicht als Ultimatum ankommt", accent: "green" },
      {
        type: "p",
        text: "Das meiste macht der Zeitpunkt. Nicht die erste Nachricht — es gibt noch nichts zu klären, und eine fremde Person liest es als Forderung. Sobald ein echtes Gespräch läuft, reicht ein einziger Satz über dich; danach lass ihn stehen. Wiederholung macht aus Information Druck. Setz jemandem, den du gerade kennengelernt hast, keine Frist. Und sag nur, was du wirklich meinst: Ein Wunsch, den du zwei Wochen später fallen lässt, bringt dem anderen bei, dir nicht zu glauben.",
      },
      {
        type: "p",
        text: "Eigene Fragen zu schreiben tut dasselbe, nur früher. Bei Qulo schreibt jedes Mitglied **2 bis 4 Fragen mit je vier Antwortmöglichkeiten**, im kostenpflichtigen Tarif bis zu 10, und ein Match entsteht nur, wenn jemand alle richtig beantwortet — was dir wichtig ist, liegt also schon vor der ersten Nachricht auf dem Tisch. Eine Frage ist die leisere Art, das zu sagen.",
      },
    ],
  },

  fr: {
    term: "Hardballing",
    summary:
      "Dire clairement et tôt ce qu'on attend d'une relation — quelque chose de sérieux, de léger, un mariage, pas d'enfants — au lieu d'attendre des mois pour découvrir si l'autre veut la même chose.",
    blocks: [
      { type: "h2", text: "Pourquoi ça a commencé" },
      {
        type: "p",
        text: "Pendant une dizaine d'années, la façon la plus sûre de dater était d'avoir l'air détaché. Vouloir quelque chose de précis passait pour de la pression, alors tout le monde est resté vague, quitte à découvrir plus tard. Plus tard coûtait cher : au bout de plusieurs mois, quelqu'un finit par avouer qu'il ne cherchait pas du tout la même chose. Le hardballing corrige ça : ce que vous cherchez devient une information d'ouverture.",
      },
      {
        type: "p",
        text: "Ce qui est dur, c'est la clarté, pas la pression. Vous énoncez vos conditions et l'autre énonce les siennes ; personne n'est prié d'accepter quoi que ce soit. Un non précoce devient donc un bon résultat plutôt qu'un rejet : il coûte une soirée et non six mois. Bien fait, c'est généreux — vous donnez à l'autre de quoi se retirer.",
      },
      { type: "h2", text: "À quoi ça ressemble vraiment" },
      {
        type: "ul",
        items: [
          "Ça parle de vous : \"je cherche quelque chose de sérieux\", pas \"tu comptes t'engager ?\"",
          "Ça se dit une fois, tôt, puis la conversation reprend normalement.",
          "Ça laisse la place à une autre réponse : vous informez, vous ne négociez pas.",
          "Ça nomme votre envie, pas une liste d'exigences que l'autre devrait remplir.",
        ],
      },
      { type: "h2", text: "Comment le dire sans que ce soit un ultimatum", accent: "green" },
      {
        type: "p",
        text: "Le timing fait presque tout. Pas dans le premier message : il n'y a encore rien à clarifier, et un inconnu y lit une exigence. Une fois qu'une vraie conversation existe, une seule phrase sur vous suffit ; ensuite, laissez-la vivre. La répéter transforme l'information en pression. N'imposez pas de délai à quelqu'un que vous venez de rencontrer. Et ne dites que ce que vous pensez vraiment : une envie abandonnée deux semaines plus tard apprend à l'autre à ne pas vous croire.",
      },
      {
        type: "p",
        text: "Écrire ses propres questions fait la même chose, plus tôt. Sur Qulo, chaque membre rédige **de 2 à 4 questions à quatre réponses**, jusqu'à 10 avec un abonnement payant, et on ne se matche qu'en répondant juste à toutes — ce qui compte pour vous est donc posé avant le premier message. Une question est la façon la plus discrète de le dire.",
      },
    ],
  },

  es: {
    term: "Hardballing",
    summary:
      "Decir pronto y sin rodeos qué quieres de una relación — algo serio, algo ligero, casarte, no tener hijos — en lugar de esperar meses para descubrir si la otra persona quiere lo mismo.",
    blocks: [
      { type: "h2", text: "Por qué empezó a hacerse" },
      {
        type: "p",
        text: "Durante casi una década, la forma más segura de ligar era parecer indiferente. Querer algo concreto sonaba a presión, así que todo el mundo aprendió a quedarse en lo vago y averiguarlo después. Después salía caro: pasados unos meses, alguien admite que nunca buscó lo mismo. El hardballing corrige eso. Convierte lo que buscas en un dato de partida y no en una revelación tardía.",
      },
      {
        type: "p",
        text: "Lo duro aquí es la claridad, no la presión. Tú dices lo tuyo y la otra persona dice lo suyo; a nadie se le pide que acepte nada. Por eso un no temprano es un buen resultado y no un rechazo: cuesta una noche en vez de medio año. Bien hecho es generoso — le entregas a alguien la información que necesita para bajarse.",
      },
      { type: "h2", text: "Cómo suena en realidad" },
      {
        type: "ul",
        items: [
          "Habla de ti: \"busco algo serio\", no \"¿vas a comprometerte?\"",
          "Se dice una vez, pronto, y después la conversación sigue como si nada.",
          "Deja sitio a otra respuesta: informas, no negocias.",
          "Nombra lo que quieres, no una lista de requisitos que el otro debe cumplir.",
        ],
      },
      { type: "h2", text: "Cómo decirlo sin que suene a ultimátum", accent: "green" },
      {
        type: "p",
        text: "El momento hace casi todo el trabajo. En el primer mensaje no: todavía no hay nada que aclarar y un desconocido lo lee como una exigencia. Cuando ya existe una conversación de verdad, basta una frase sobre ti; luego déjala estar. Repetirla convierte la información en presión. No le pongas plazos a alguien que acabas de conocer. Y di solo lo que de verdad piensas: un deseo que abandonas dos semanas después enseña al otro a no creerte.",
      },
      {
        type: "p",
        text: "Escribir tus propias preguntas hace lo mismo, antes. En Qulo cada persona escribe **entre 2 y 4 preguntas de cuatro opciones**, hasta 10 con un plan de pago, y solo hay match si alguien las acierta todas — así que lo que te importa está sobre la mesa antes del primer mensaje. Una pregunta es la manera más discreta de decirlo.",
      },
    ],
  },

  ar: {
    term: "المصارحة المبكرة",
    summary:
      "أن تقول مبكرًا وبوضوح ما تريده من العلاقة — شيئًا جادًّا أو خفيفًا، زواجًا، أو ألّا يكون هناك أطفال — بدل انتظار شهور لتكتشف إن كان الطرف الآخر يريد الشيء نفسه. تُعرف بالإنجليزية بـ hardballing.",
    blocks: [
      { type: "h2", text: "لماذا بدأ الناس يفعلون ذلك" },
      {
        type: "p",
        text: "طوال عقد تقريبًا، كانت أأمن طريقة للمواعدة هي أن تبدو غير مبالٍ. أن تريد شيئًا محدَّدًا بدا وكأنه ضغط، فتعلّم الجميع البقاء في العموميات واكتشاف الباقي لاحقًا. و«لاحقًا» كانت مكلفة: بعد شهور يعترف أحدهم بأنه لم يكن يبحث عن الشيء نفسه أصلًا. هذه العادة هي التصحيح: ما تبحث عنه يصير معلومة في البداية لا مفاجأة في النهاية.",
      },
      {
        type: "p",
        text: "الشدّة هنا في الوضوح لا في الضغط. تقول شروطك ويقول الآخر شروطه، ولا يُطلب من أحد أن يوافق على شيء. لذلك يصبح الرفض المبكر نتيجة جيدة لا صدمة: يكلّفك أمسية بدل نصف سنة. وحين يُفعل بشكل صحيح يكون كرمًا — فأنت تعطي الطرف الآخر ما يحتاجه كي ينسحب.",
      },
      { type: "h2", text: "كيف تبدو فعلًا حين تُقال" },
      {
        type: "ul",
        items: [
          "الحديث عنك أنت: «أبحث عن شيء جاد»، لا «هل ستلتزم؟».",
          "تُقال مرة واحدة ومبكرًا، ثم يمضي الحديث بشكل طبيعي.",
          "تترك مجالًا لجواب مختلف: أنت تُخبر ولا تفاوض.",
          "تسمّي ما تريده أنت، لا قائمة شروط على الآخر أن يستوفيها.",
        ],
      },
      { type: "h2", text: "كيف تقولها دون أن تبدو إنذارًا", accent: "green" },
      {
        type: "p",
        text: "التوقيت يقوم بمعظم العمل. ليس في أول رسالة — لا شيء يحتاج إلى توضيح بعد، والغريب سيقرأها مطلبًا. وحين تنشأ محادثة حقيقية، تكفي جملة واحدة عن نفسك، ثم اتركها. تكرارها يحوّل المعلومة إلى ضغط. لا تضع مهلة زمنية لشخص قابلته للتوّ. وقل فقط ما تعنيه حقًا: رغبة تتخلى عنها بعد أسبوعين تعلّم الآخر ألا يصدّقك.",
      },
      {
        type: "p",
        text: "كتابة أسئلتك الخاصة تفعل الشيء نفسه لكن أبكر. في Qulo يكتب كل عضو **من سؤالين إلى 4 أسئلة، بأربعة خيارات لكل سؤال**، وحتى 10 أسئلة في الخطة المدفوعة، ولا يحدث التطابق إلا إذا أجاب أحدهم عنها كلها إجابة صحيحة — أي أن ما يهمّك يكون مطروحًا قبل أول رسالة. السؤال طريقة أهدأ لقول ذلك.",
      },
    ],
  },

  ru: {
    term: "Хардболлинг",
    summary:
      "Привычка сразу и прямо говорить, чего вы хотите от отношений — серьёзного, лёгкого, брака, отсутствия детей, — вместо того чтобы полгода выяснять, хочет ли того же другой человек.",
    blocks: [
      { type: "h2", text: "Почему так стали делать" },
      {
        type: "p",
        text: "Лет десять самым безопасным способом знакомиться было выглядеть равнодушным. Хотеть чего-то определённого казалось давлением, поэтому все держались общих слов и оставляли выяснение на потом. Потом выходило дорого: через несколько месяцев человек признаётся, что вообще искал другое. Хардболлинг — поправка к этому. То, что вы ищете, становится вводной информацией, а не поздним откровением.",
      },
      {
        type: "p",
        text: "Жёсткость здесь в ясности, а не в давлении. Вы называете свои условия, другой называет свои; никого не просят на что-то соглашаться. Поэтому раннее «нет» — хороший исход, а не отказ: он стоит одного вечера вместо полугода. Сделанное правильно, это щедрость: вы даёте человеку то, с чем он может спокойно уйти.",
      },
      { type: "h2", text: "Как это звучит на самом деле" },
      {
        type: "ul",
        items: [
          "Речь о вас: «я ищу серьёзные отношения», а не «ты собираешься определяться?».",
          "Это говорится один раз и рано, а дальше разговор идёт как обычно.",
          "Это оставляет место для другого ответа: вы сообщаете, а не торгуетесь.",
          "Это называет ваше желание, а не список требований к другому человеку.",
        ],
      },
      { type: "h2", text: "Как сказать это, чтобы не прозвучало ультиматумом", accent: "green" },
      {
        type: "p",
        text: "Бо́льшую часть работы делает момент. Не первое сообщение: прояснять пока нечего, и незнакомый человек прочтёт это как требование. Когда появился настоящий разговор, хватит одной фразы о себе — и дальше к ней не возвращайтесь. Повтор превращает информацию в давление. Не ставьте сроков тому, кого только что встретили. И говорите только то, что действительно имеете в виду: желание, от которого вы откажетесь через две недели, учит человека вам не верить.",
      },
      {
        type: "p",
        text: "Свои вопросы работают так же, только раньше. В Qulo каждый пишет **от 2 до 4 вопросов с четырьмя вариантами ответа**, на платном тарифе до 10, и мэтч случается, только если человек ответил верно на все, — важное для вас оказывается на столе ещё до первого сообщения. Вопрос — более тихий способ это сказать.",
      },
    ],
  },

  pt: {
    term: "Hardballing",
    summary:
      "Dizer com clareza e cedo o que você quer de um relacionamento — algo sério, algo leve, casamento, nada de filhos — em vez de esperar meses para descobrir se a outra pessoa quer o mesmo.",
    blocks: [
      { type: "h2", text: "Por que isso começou" },
      {
        type: "p",
        text: "Durante quase uma década, o jeito mais seguro de se relacionar era parecer despreocupado. Querer algo específico soava como pressão, então todo mundo aprendeu a ficar no vago e descobrir depois. Depois saía caro: passados alguns meses, alguém admite que nunca procurou a mesma coisa. O hardballing é a correção. Transforma o que você procura em informação de abertura, não em revelação tardia.",
      },
      {
        type: "p",
        text: "O que é duro aqui é a clareza, não a pressão. Você diz os seus termos e a outra pessoa diz os dela; ninguém está sendo convidado a concordar com nada. Por isso um não logo no começo é um bom resultado e não uma rejeição: custa uma noite em vez de meio ano. Bem feito, é generoso — você entrega a informação que permite alguém sair.",
      },
      { type: "h2", text: "Como isso soa na prática" },
      {
        type: "ul",
        items: [
          "Fala de você: \"eu quero algo sério\", não \"você vai se comprometer?\"",
          "É dito uma vez, cedo, e depois a conversa segue normalmente.",
          "Deixa espaço para outra resposta: você informa, não negocia.",
          "Nomeia o que você quer, não uma lista de exigências que o outro precisa cumprir.",
        ],
      },
      { type: "h2", text: "Como dizer sem soar como ultimato", accent: "green" },
      {
        type: "p",
        text: "O tempo certo faz quase todo o trabalho. Não na primeira mensagem: ainda não há nada a esclarecer e um desconhecido lê aquilo como cobrança. Quando já existe uma conversa de verdade, basta uma frase sobre você; depois, deixe estar. Repetir transforma informação em pressão. Não coloque prazo em alguém que você acabou de conhecer. E diga só o que você realmente pensa: um desejo abandonado duas semanas depois ensina o outro a não acreditar em você.",
      },
      {
        type: "p",
        text: "Escrever as próprias perguntas faz a mesma coisa, mais cedo. No Qulo cada pessoa escreve **de 2 a 4 perguntas com quatro alternativas**, até 10 num plano pago, e só há match se alguém acertar todas — ou seja, o que importa para você já está na mesa antes da primeira mensagem. Uma pergunta é o jeito mais silencioso de dizer isso.",
      },
    ],
  },

  it: {
    term: "Hardballing",
    summary:
      "Dire presto e con chiarezza che cosa si vuole da una relazione — qualcosa di serio, qualcosa di leggero, il matrimonio, niente figli — invece di scoprire dopo mesi se l'altra persona vuole lo stesso.",
    blocks: [
      { type: "h2", text: "Perché si è cominciato a farlo" },
      {
        type: "p",
        text: "Per una decina d'anni il modo più sicuro di frequentare qualcuno era sembrare indifferenti. Volere qualcosa di preciso pareva pressione, così tutti restavano sul vago e rimandavano la scoperta. Il dopo costava caro: a mesi di distanza qualcuno ammette che non cercava affatto la stessa cosa. L'hardballing è la correzione: quello che cerchi diventa un'informazione d'apertura, non una rivelazione tardiva.",
      },
      {
        type: "p",
        text: "La durezza sta nella chiarezza, non nella pressione. Tu dici le tue condizioni e l'altra persona dice le sue; a nessuno viene chiesto di accettare niente. Per questo un no precoce è un buon esito e non un rifiuto: costa una serata invece di sei mesi. Fatto bene è generoso — dai all'altro l'informazione che gli serve per tirarsi indietro.",
      },
      { type: "h2", text: "Come suona davvero" },
      {
        type: "ul",
        items: [
          "Parla di te: \"cerco una cosa seria\", non \"tu hai intenzione di impegnarti?\"",
          "Si dice una volta sola, presto, e poi la conversazione riprende normale.",
          "Lascia spazio a una risposta diversa: stai informando, non stai trattando.",
          "Nomina quello che vuoi, non un elenco di requisiti che l'altro deve soddisfare.",
        ],
      },
      { type: "h2", text: "Come dirlo senza che sembri un ultimatum", accent: "green" },
      {
        type: "p",
        text: "Quasi tutto lo fa il momento. Non il primo messaggio: non c'è ancora niente da chiarire e uno sconosciuto lo legge come una pretesa. Quando esiste una conversazione vera, basta una frase su di te; poi lasciala lì. Ripeterla trasforma l'informazione in pressione. Non mettere scadenze a chi hai appena conosciuto. E di' solo quello che pensi davvero: un desiderio che abbandoni due settimane dopo insegna all'altro a non crederti.",
      },
      {
        type: "p",
        text: "Scrivere le proprie domande fa la stessa cosa, prima. Su Qulo ogni iscritto scrive **da 2 a 4 domande a quattro opzioni**, fino a 10 con un piano a pagamento, e il match arriva solo se qualcuno le indovina tutte — quello che ti sta a cuore è sul tavolo prima del primo messaggio. Una domanda è il modo più silenzioso per dirlo.",
      },
    ],
  },

  ja: {
    term: "ハードボーリング",
    summary:
      "恋愛に何を求めているのかを最初にはっきり言葉にするやり方。真剣な関係か気軽な関係か、結婚したいのか、子どもは望まないのか——相手も同じかを何か月もかけて探らずに、先に伝えてしまう。",
    blocks: [
      { type: "h2", text: "なぜ広がったのか" },
      {
        type: "p",
        text: "この十年ほど、いちばん安全な振る舞いは「気にしていないふり」でした。はっきり何かを望むことは圧に見えたので、みんな曖昧なままにして、答えは後で知ればいいことにした。その「後で」が高くつきました。何か月もたってから、実は最初から求めているものが違ったと打ち明けられる。ハードボーリングはその修正です。何を求めているかを、遅れて出す札ではなく最初の情報として扱います。",
      },
      {
        type: "p",
        text: "きついのは明確さであって、圧ではありません。自分の条件を言い、相手も自分の条件を言う。誰も何かに同意させられてはいません。だから早い段階のノーは拒絶ではなく良い結果です。半年ではなく一晩で済む。うまくやれば、これはむしろ親切です。相手に降りるための材料を渡しているのですから。",
      },
      { type: "h2", text: "実際にはどんな言い方になるか" },
      {
        type: "ul",
        items: [
          "主語は自分。「真剣な関係を探しています」であって、「あなたは本気になれるの」ではない。",
          "早い段階で一度だけ言い、そのあとは会話がふつうに続く。",
          "違う答えの余地を残す。交渉ではなく、情報を渡しているだけ。",
          "自分の望みを言う。相手が満たすべき条件リストを読み上げない。",
        ],
      },
      { type: "h2", text: "最後通牒に聞こえないようにするには", accent: "green" },
      {
        type: "p",
        text: "ほとんどはタイミングで決まります。最初のメッセージでは駄目です。まだはっきりさせるものがなく、見知らぬ相手には要求として届きます。会話が成り立ってから、自分についての一文で十分。あとは繰り返さないこと。繰り返した瞬間に、情報は圧に変わります。会ったばかりの人に期限をつけないこと。そして本当に思っていることだけを言うこと。二週間後に引っ込める望みは、相手に信じなくていいと教えてしまいます。",
      },
      {
        type: "p",
        text: "自分で質問を書くことも、同じ働きをもっと早い段階でします。Qulo では一人ひとりが**四択の質問を2問から4問**（有料プランなら最大10問）つくり、そのすべてに正解した相手とだけマッチします。つまり自分が大事にしていることは、最初のメッセージより前に置かれている。質問は、それを静かに言う方法です。",
      },
    ],
  },

  ko: {
    term: "하드볼링",
    summary:
      "연애에서 무엇을 원하는지를 처음부터 분명히 말해 두는 방식. 진지한 관계인지 가벼운 관계인지, 결혼 생각이 있는지, 아이는 원하지 않는지를 몇 달 뒤에 확인하는 대신 먼저 꺼낸다.",
    blocks: [
      { type: "h2", text: "왜 이런 흐름이 생겼나" },
      {
        type: "p",
        text: "지난 십여 년 동안 가장 안전한 연애 태도는 별로 신경 쓰지 않는 사람처럼 보이는 것이었습니다. 무언가를 분명히 원하면 압박처럼 보였기 때문에, 다들 애매하게 두고 나중에 알아보기로 했습니다. 그 나중이 비쌌습니다. 몇 달이 지나서야 애초에 찾던 게 서로 달랐다는 말이 나옵니다. 하드볼링은 그 교정입니다. 무엇을 찾고 있는지를 늦게 꺼내는 패가 아니라 처음의 정보로 다룹니다.",
      },
      {
        type: "p",
        text: "여기서 단단한 것은 명확함이지 압박이 아닙니다. 나는 내 조건을 말하고 상대는 자기 조건을 말합니다. 누구에게도 동의를 요구하지 않습니다. 그래서 이른 거절은 상처가 아니라 좋은 결과입니다. 반년이 아니라 하룻저녁이면 끝나니까요. 제대로 하면 오히려 너그러운 일입니다. 상대가 빠져나갈 수 있는 정보를 건네는 셈이니까요.",
      },
      { type: "h2", text: "실제로는 어떤 말투인가" },
      {
        type: "ul",
        items: [
          "주어가 나다. 「나는 진지한 관계를 찾고 있어」이지 「너는 진지해질 거야?」가 아니다.",
          "이른 시점에 한 번만 말하고, 그다음 대화는 평소처럼 흘러간다.",
          "다른 대답이 나올 자리를 남긴다. 협상이 아니라 정보 전달이다.",
          "내가 원하는 것을 말한다. 상대가 충족해야 할 조건 목록을 읽지 않는다.",
        ],
      },
      { type: "h2", text: "최후통첩처럼 들리지 않게 하려면", accent: "green" },
      {
        type: "p",
        text: "대부분은 시점이 결정합니다. 첫 메시지는 아닙니다. 아직 분명히 할 것도 없고, 낯선 사람에게는 요구로 읽힙니다. 진짜 대화가 생긴 다음, 나에 대한 한 문장이면 충분합니다. 그리고 다시 꺼내지 마세요. 반복하는 순간 정보는 압박이 됩니다. 방금 만난 사람에게 기한을 붙이지 마세요. 그리고 진심인 것만 말하세요. 2주 뒤에 접는 바람은 상대에게 나를 믿지 말라고 가르칩니다.",
      },
      {
        type: "p",
        text: "직접 질문을 쓰는 것도 같은 일을 더 일찍 합니다. Qulo에서는 각자 **사지선다 질문을 2~4개**(유료 플랜에서는 최대 10개) 만들고, 전부 맞힌 사람하고만 매칭됩니다 — 내가 중요하게 여기는 것이 첫 메시지보다 먼저 놓이는 셈입니다. 질문은 그것을 조용히 말하는 방법입니다.",
      },
    ],
  },

  zh: {
    term: "打直球",
    summary:
      "在感情里早早把自己想要什么说清楚——认真的关系、轻松的关系、结婚、不要小孩——而不是花几个月去试探对方要的是不是同一件事。英文里叫 hardballing。",
    blocks: [
      { type: "h2", text: "为什么会流行起来" },
      {
        type: "p",
        text: "过去十来年，最安全的姿态是显得不在乎。明确地想要什么会被当成施压，于是大家都学会含糊其辞，把答案留到以后。以后很贵：几个月过去，才有人承认自己从来就不是在找同一样东西。打直球是对这件事的纠正——把你在找什么当成开场的信息，而不是压箱底的答案。",
      },
      {
        type: "p",
        text: "这里的硬指的是清楚，不是压力。你说你的条件，对方说对方的，谁都没有被要求答应什么。所以早早得到一个“不”是好结果，不是被拒绝：代价是一个晚上，而不是半年。做得好，它其实很厚道——你把可以让对方退出的信息先给了他。",
      },
      { type: "h2", text: "真正说出口时是什么样子" },
      {
        type: "ul",
        items: [
          "主语是你自己：“我在找一段认真的关系”，而不是“你会不会定下来”。",
          "早一点说，只说一次，然后对话照常继续。",
          "留下不同答案的余地：你是在告知，不是在谈判。",
          "说的是你想要什么，而不是一张对方必须达标的清单。",
        ],
      },
      { type: "h2", text: "怎么说才不像最后通牒", accent: "green" },
      {
        type: "p",
        text: "时机决定了大半。别放在第一条消息里：还没有什么需要澄清，陌生人只会读成要求。等到真的聊起来了，关于自己的一句话就够，说完就放下。重复一次，信息就变成了压力。也别给刚认识的人设期限。还有，只说你真的当真的事——两周后就收回的愿望，会教对方不必相信你。",
      },
      {
        type: "p",
        text: "自己出题其实在做同一件事，只是更早。在 Qulo，每个人写 **2 到 4 道四选一的题**（付费方案最多 10 道），只有全部答对的人才会和你配对——也就是说，你在意的东西在第一条消息之前就已经摆在那里了。一道题，是把它说出口的更安静的方式。",
      },
    ],
  },

  nl: {
    term: "Hardballing",
    summary:
      "Vroeg en zonder omhaal zeggen wat je van een relatie wilt — iets serieus, iets luchtigs, trouwen, geen kinderen — in plaats van maanden wachten om te ontdekken of de ander hetzelfde wil.",
    blocks: [
      { type: "h2", text: "Waarom mensen dit gingen doen" },
      {
        type: "p",
        text: "Ongeveer tien jaar lang was de veiligste manier van daten: doen alsof het je weinig deed. Iets specifieks willen leek op druk, dus bleef iedereen vaag en kwam de rest later wel. Later bleek duur: na maanden geeft iemand toe dat hij nooit hetzelfde zocht. Hardballing is de correctie. Wat je zoekt wordt openingsinformatie in plaats van een late onthulling.",
      },
      {
        type: "p",
        text: "Het harde eraan is de duidelijkheid, niet de druk. Jij noemt jouw voorwaarden, de ander die van hem; niemand wordt gevraagd ergens mee akkoord te gaan. Daardoor is een vroeg nee een goede uitkomst en geen afwijzing: het kost één avond in plaats van een halfjaar. Goed gedaan is het royaal — je geeft iemand de informatie om af te haken.",
      },
      { type: "h2", text: "Hoe het echt klinkt" },
      {
        type: "ul",
        items: [
          "Het gaat over jou: \"ik zoek iets serieus\", niet \"ga jij je binden?\"",
          "Het wordt één keer gezegd, vroeg, en daarna loopt het gesprek gewoon door.",
          "Het laat ruimte voor een ander antwoord: je informeert, je onderhandelt niet.",
          "Het benoemt wat jij wilt, geen lijst eisen waaraan de ander moet voldoen.",
        ],
      },
      { type: "h2", text: "Hoe je het zegt zonder ultimatum", accent: "green" },
      {
        type: "p",
        text: "Het moment doet bijna al het werk. Niet in het eerste bericht: er valt nog niets te verduidelijken, en een vreemde leest het als een eis. Zodra er een echt gesprek is, volstaat één zin over jezelf; laat hem daarna liggen. Herhalen maakt van informatie druk. Zet iemand die je net kent geen deadline. En zeg alleen wat je echt meent: een wens die je twee weken later loslaat, leert de ander je niet te geloven.",
      },
      {
        type: "p",
        text: "Je eigen vragen schrijven doet hetzelfde, alleen eerder. Bij Qulo schrijft ieder lid **2 tot 4 vragen met vier antwoorden**, tot 10 met een betaald abonnement, en er ontstaat pas een match als iemand ze allemaal goed heeft — wat jij belangrijk vindt ligt dus vóór het eerste bericht op tafel. Een vraag is de stillere manier om dat te zeggen.",
      },
    ],
  },

  pl: {
    term: "Hardballing",
    summary:
      "Mówienie wcześnie i wprost, czego się chce od związku — czegoś poważnego, czegoś lekkiego, małżeństwa, braku dzieci — zamiast czekać miesiącami, czy druga osoba chce tego samego.",
    blocks: [
      { type: "h2", text: "Skąd się to wzięło" },
      {
        type: "p",
        text: "Przez jakieś dziesięć lat najbezpieczniejszą postawą było udawanie, że ci nie zależy. Chcieć czegoś konkretnego wyglądało na presję, więc wszyscy trzymali się ogólników i odkładali resztę na później. To później bywało drogie: po kilku miesiącach ktoś przyznaje, że nigdy nie szukał tego samego. Hardballing to poprawka. To, czego szukasz, staje się informacją na wejściu, a nie późnym wyznaniem.",
      },
      {
        type: "p",
        text: "Twarda jest tu jasność, nie nacisk. Ty mówisz swoje warunki, druga osoba swoje; nikt nie jest proszony, żeby się na cokolwiek zgodzić. Dlatego wczesne nie to dobry wynik, a nie odrzucenie: kosztuje jeden wieczór zamiast pół roku. Zrobione dobrze, jest hojne — dajesz komuś informację, dzięki której może się wycofać.",
      },
      { type: "h2", text: "Jak to naprawdę brzmi" },
      {
        type: "ul",
        items: [
          "Mówisz o sobie: \"szukam czegoś poważnego\", a nie \"zamierzasz się zaangażować?\"",
          "Pada raz, wcześnie, a potem rozmowa toczy się normalnie.",
          "Zostawia miejsce na inną odpowiedź: informujesz, nie negocjujesz.",
          "Nazywa to, czego chcesz, a nie listę wymagań do spełnienia przez drugą stronę.",
        ],
      },
      { type: "h2", text: "Jak to powiedzieć, żeby nie zabrzmiało jak ultimatum", accent: "green" },
      {
        type: "p",
        text: "Najwięcej robi moment. Nie w pierwszej wiadomości: nie ma jeszcze czego wyjaśniać, a obca osoba przeczyta to jak żądanie. Kiedy jest już prawdziwa rozmowa, wystarczy jedno zdanie o sobie; potem zostaw je w spokoju. Powtarzanie zamienia informację w nacisk. Nie stawiaj terminów komuś, kogo dopiero poznałaś. I mów tylko to, co naprawdę myślisz: pragnienie porzucone dwa tygodnie później uczy drugą stronę, żeby ci nie wierzyć.",
      },
      {
        type: "p",
        text: "Pisanie własnych pytań robi to samo, tylko wcześniej. W Qulo każdy układa **od 2 do 4 pytań z czterema odpowiedziami**, w planie płatnym do 10, i dopasowanie następuje tylko wtedy, gdy ktoś trafi we wszystkie — to, co dla ciebie ważne, leży więc na stole przed pierwszą wiadomością. Pytanie to cichszy sposób, żeby to powiedzieć.",
      },
    ],
  },

  sv: {
    term: "Hardballing",
    summary:
      "Att tidigt och rakt säga vad man vill ha av en relation — något seriöst, något lätt, giftermål, inga barn — i stället för att lägga månader på att ta reda på om den andra vill samma sak.",
    blocks: [
      { type: "h2", text: "Varför folk började med det" },
      {
        type: "p",
        text: "I ungefär ett decennium var det säkraste sättet att dejta att verka oberörd. Att vilja något bestämt såg ut som press, så alla höll sig vaga och tänkte ta reda på resten senare. Senare blev dyrt: efter månader erkänner någon att hen aldrig sökte samma sak. Hardballing är rättelsen. Det du söker blir en öppningsuppgift i stället för ett sent avslöjande.",
      },
      {
        type: "p",
        text: "Det hårda är tydligheten, inte pressen. Du säger dina villkor och den andra sina; ingen ombeds gå med på något. Därför är ett tidigt nej ett bra utfall och inget avslag — det kostar en kväll i stället för ett halvår. Gjort på rätt sätt är det generöst: du ger någon den uppgift som gör att hen kan tacka nej.",
      },
      { type: "h2", text: "Hur det faktiskt låter" },
      {
        type: "ul",
        items: [
          "Det handlar om dig: \"jag söker något seriöst\", inte \"tänker du binda dig?\"",
          "Det sägs en gång, tidigt, och sedan fortsätter samtalet som vanligt.",
          "Det lämnar plats för ett annat svar: du informerar, du förhandlar inte.",
          "Det namnger vad du vill ha, inte en lista med krav den andra ska uppfylla.",
        ],
      },
      { type: "h2", text: "Så säger du det utan att det blir ett ultimatum", accent: "green" },
      {
        type: "p",
        text: "Tajmningen gör det mesta av jobbet. Inte i första meddelandet: det finns ännu inget att klargöra, och en främling läser det som ett krav. När ett riktigt samtal väl finns räcker en enda mening om dig själv; låt den sedan ligga. Att upprepa den gör om uppgift till press. Sätt ingen tidsgräns på någon du just har träffat. Och säg bara det du faktiskt menar — en önskan du släpper två veckor senare lär den andra att inte tro på dig.",
      },
      {
        type: "p",
        text: "Att skriva egna frågor gör samma sak, fast tidigare. På Qulo skriver varje medlem **2 till 4 frågor med fyra svarsalternativ**, upp till 10 med ett betalt abonnemang, och en matchning blir bara av om någon har alla rätt — det du bryr dig om ligger alltså framme redan före första meddelandet. En fråga är det tystare sättet att säga det.",
      },
    ],
  },

  hi: {
    term: "हार्डबॉलिंग",
    summary:
      "रिश्ते से आप क्या चाहते हैं, यह शुरू में ही साफ कह देना — कुछ गंभीर, कुछ हल्का, शादी, बच्चे नहीं — बजाय इसके कि महीनों बाद पता चले कि सामने वाला वही चाहता था या नहीं।",
    blocks: [
      { type: "h2", text: "यह चलन शुरू क्यों हुआ" },
      {
        type: "p",
        text: "करीब एक दशक तक सबसे सुरक्षित तरीका यही माना गया कि आप बेपरवाह दिखें। कुछ ठोस चाहना दबाव जैसा लगता था, इसलिए लोगों ने गोल-मोल रहना और बाकी बाद में जान लेना सीख लिया। वह “बाद में” महंगा पड़ा: कई महीने बीतने पर कोई मानता है कि वह कभी वही ढूंढ ही नहीं रहा था। हार्डबॉलिंग इसी की सुधार है — आप क्या ढूंढ रहे हैं, यह अब शुरुआत की जानकारी है, आखिर में खुलने वाला राज नहीं।",
      },
      {
        type: "p",
        text: "यहां सख्ती साफगोई की है, दबाव की नहीं। आप अपनी शर्त कहते हैं, सामने वाला अपनी; किसी से कुछ मान लेने को नहीं कहा जा रहा। इसीलिए शुरू में मिला “ना” ठुकराया जाना नहीं, अच्छा नतीजा है: एक शाम की कीमत, छह महीने की नहीं। ठीक से किया जाए तो यह उदारता है — आप सामने वाले को वह जानकारी दे रहे हैं जिससे वह पीछे हट सके।",
      },
      { type: "h2", text: "असल में यह सुनाई कैसा देता है" },
      {
        type: "ul",
        items: [
          "बात आपकी होती है: “मुझे कुछ गंभीर चाहिए”, न कि “तुम कमिट करोगे या नहीं?”।",
          "एक बार, शुरू में कहा जाता है; उसके बाद बातचीत सामान्य चलती रहती है।",
          "दूसरे जवाब की जगह छोड़ता है — आप जानकारी दे रहे हैं, मोलभाव नहीं कर रहे।",
          "आप अपनी चाहत बताते हैं, सामने वाले के लिए शर्तों की सूची नहीं पढ़ते।",
        ],
      },
      { type: "h2", text: "इसे अल्टीमेटम बनने से कैसे बचाएं", accent: "green" },
      {
        type: "p",
        text: "ज्यादातर काम सही वक्त करता है। पहले मैसेज में नहीं — अभी साफ करने को कुछ है ही नहीं, और अजनबी इसे मांग की तरह पढ़ेगा। जब असली बातचीत बन जाए, तब अपने बारे में एक वाक्य काफी है; फिर उसे छोड़ दीजिए। दोहराते ही जानकारी दबाव बन जाती है। अभी-अभी मिले व्यक्ति पर समय-सीमा मत रखिए। और वही कहिए जो सच में सोचते हैं: दो हफ्ते बाद छोड़ दी गई चाहत सामने वाले को यही सिखाती है कि आप पर भरोसा न करे।",
      },
      {
        type: "p",
        text: "अपने सवाल लिखना भी यही काम करता है, बस पहले कर देता है। Qulo पर हर व्यक्ति **चार-विकल्प वाले 2 से 4 सवाल** लिखता है — भुगतान वाली योजना में 10 तक — और मैच तभी होता है जब कोई सारे सवाल सही कर दे — यानी आपके लिए जो मायने रखता है, वह पहले मैसेज से पहले ही सामने रख दिया जाता है। सवाल, उसे कहने का ज्यादा शांत तरीका है।",
      },
    ],
  },
};
