import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Beige flag — a harmless, distinctive quirk: neither a warning nor a
 * recommendation.
 *
 * Editorial notes for whoever touches this next:
 * - The term genuinely has two meanings and the page covers both rather than
 *   picking the tidier one. Original sense (2022, short video): a dating profile
 *   so generic it tells you nothing. Drifted sense (from 2023 on, now dominant):
 *   a partner's endearing oddity. Block 2 states the drift explicitly and says
 *   context decides. Do not "fix" this into a single definition — the reader
 *   arriving here has probably met one sense and been confused by the other.
 * - Same axis as red-flag and green-flag, phrased differently here on purpose:
 *   red and green are about CONDUCT, beige is about TEXTURE. That distinction is
 *   the first bullet in block 4 and the closing point in block 7, which is the
 *   most useful thing on the page: people file real conduct problems under
 *   "that's just his thing". Keep it.
 * - Block 7 is not a Qulo pitch. There is no honest link between this term and
 *   the question mechanic, so the space goes to the misuse warning instead. Of
 *   the four terms in this batch only green-flag ends on the product.
 * - No statistics. The 78% burnout figure (Forbes Health / OnePoll, 2024) is
 *   about app fatigue and does not belong here.
 * - Term names: the loanword is what people say in de/fr/pt/it/nl/sv; es/pl/ru/
 *   tr/ar/hi/ja/ko take the native colour word. zh uses 米色信号 to sit beside
 *   危险信号 (red-flag) and 积极信号 (green-flag), and the zh body refers to the
 *   other two by those same names so the three-way distinction survives.
 * - The example quirks are localised, not translated: the cat-narrator survives
 *   everywhere, but the little verbal tic before standing up is a different word
 *   in each language and was chosen per locale.
 */
export const beigeFlag: LocalizedGlossaryEntry = {
  en: {
    term: "Beige flag",
    summary:
      "A trait that is neither a warning nor a recommendation — a small, harmless quirk that tells you who someone is without telling you anything about how they will treat you.",
    blocks: [
      { type: "h2", text: "A word that changed meaning in about a year" },
      { type: "p", text: "It started as a complaint about profiles. In 2022 the phrase spread on short video meaning a dating profile that gives you nothing to work with: the same three group photos, a caught fish, \"I love travel and good food\", a height and not much else. Not a warning, not an attraction — just beige. The grievance underneath it was concrete: you can read a hundred of those and learn nothing about anybody." },
      { type: "p", text: "Within months it had drifted. People started using it for a partner's harmless oddities — he narrates what the cat is thinking, she says \"right then\" before standing up — and the tone flipped from dismissive to fond. Both readings are still in circulation, so context decides: about a stranger's profile it usually means dull, about a partner it usually means dear." },
      { type: "h2", text: "How to tell beige from red or green" },
      { type: "ul", items: [
        "**It says nothing about how you will be treated:** that is the whole test — red and green are about conduct, beige is about texture",
        "**It belongs to them alone:** not \"likes coffee\", but grinding the beans the night before so the morning is quieter",
        "**You only see it up close:** it takes a few ordinary weeks, not a first date",
        "**Saying it out loud is fun, not fraught:** you tell them and they laugh; if they get defensive, it was never beige",
      ] },
      { type: "h2", accent: "green", text: "What to do with them" },
      { type: "p", text: "Collect them. How many of someone's beige flags you can name is a decent measure of how much attention you are actually paying, because you notice none of them while you are auditioning a person or performing at them. And on the profile side of the word: a beige profile is not a verdict on a human being. Plenty of interesting people are bad at summarising themselves in three lines. Ask one specific question instead of writing them off." },
      { type: "p", text: "One caution: do not file something as beige to avoid dealing with it. \"He just goes quiet for three days, that's his thing\" is not a quirk. The line is conduct — the moment a habit changes how you are treated, it has moved into red or green, however affectionately you describe it." },
    ],
  },

  tr: {
    term: "Bej bayrak",
    summary:
      "Ne uyarı ne övgü olan bir özellik: birinin sana nasıl davranacağı hakkında hiçbir şey söylemeyen ama onun kim olduğunu ele veren küçük, zararsız bir tuhaflık.",
    blocks: [
      { type: "h2", text: "Bir yılda anlamı değişen bir kelime" },
      { type: "p", text: "Başlangıçta profillere yönelik bir sitemdi. 2022'de kısa videolarla yayıldığında \"eline hiçbir şey vermeyen profil\" demekti: aynı üç kalabalık fotoğraf, tutulmuş bir balık, \"gezmeyi ve yemeyi severim\", bir boy bilgisi ve o kadar. Ne uyarı ne çekim; sadece bej. Altındaki şikâyet somuttu: yüz profile bakıyorsun, kimse hakkında hiçbir şey öğrenemiyorsun." },
      { type: "p", text: "Birkaç ay içinde anlam kaydı. İnsanlar bunu sevgililerinin zararsız tuhaflıkları için kullanmaya başladı — kedinin ne düşündüğünü seslendirmesi, ayağa kalkmadan önce her seferinde \"hadi bakalım\" demesi — ve ton küçümsemeden sevecenliğe döndü. İki kullanım da hâlâ dolaşımda, yani bağlam belirliyor: yabancının profili için genellikle sıkıcı, sevgilin için genellikle tatlı." },
      { type: "h2", text: "Bej mi, kırmızı mı, yeşil mi?" },
      { type: "ul", items: [
        "**Sana nasıl davranılacağı hakkında hiçbir şey söylemez:** bütün ölçüt bu — kırmızı ve yeşil davranışla ilgilidir, bej dokuyla",
        "**Yalnızca ona ait bir ayrıntıdır:** \"kahve sever\" değil; sabah daha sessiz geçsin diye çekirdekleri akşamdan öğütmesi",
        "**Ancak yakından görülür:** ilk buluşmada değil, birkaç sıradan haftanın içinde ortaya çıkar",
        "**Söylemesi eğlencelidir, gergin değil:** söylersin, güler; savunmaya geçiyorsa zaten bej değilmiş",
      ] },
      { type: "h2", accent: "green", text: "Bunlarla ne yapmalı?" },
      { type: "p", text: "Biriktir. Birinin kaç tane bej bayrağını sayabildiğin, ona gerçekte ne kadar dikkat verdiğinin iyi bir ölçüsüdür; çünkü karşındakini sınarken ya da ona bir rol oynarken bunların hiçbirini fark edemezsin. Kelimenin profil tarafına gelince: bej bir profil o insan hakkında bir karar değildir. İlginç insanların çoğu kendini üç satırda anlatmakta kötüdür. Silip geçmek yerine tek bir somut soru sor." },
      { type: "p", text: "Bir uyarı: uğraşmak istemediğin bir şeyi bej rafına kaldırma. \"Üç gün susuyor, huyu böyle\" bir tuhaflık değildir. Sınır davranıştır: bir alışkanlık sana nasıl davranıldığını değiştirmeye başladığı anda, ne kadar sevecen anlatırsan anlat, kırmızıya ya da yeşile geçmiştir." },
    ],
  },

  de: {
    term: "Beige Flag",
    summary:
      "Eine Eigenschaft, die weder Warnung noch Empfehlung ist: eine kleine, harmlose Marotte, die zeigt, wer jemand ist, aber nichts darüber sagt, wie diese Person dich behandeln wird.",
    blocks: [
      { type: "h2", text: "Ein Wort, das in einem Jahr die Bedeutung wechselte" },
      { type: "p", text: "Angefangen hat es als Vorwurf an Profile. 2022 verbreitete sich der Ausdruck in Kurzvideos und meinte ein Dating-Profil, das einem nichts gibt: dieselben drei Gruppenfotos, ein gefangener Fisch, \"Ich liebe Reisen und gutes Essen\", eine Körpergröße und sonst wenig. Keine Warnung, kein Reiz — einfach beige. Die Klage dahinter war konkret: Man kann hundert davon lesen und über niemanden etwas erfahren." },
      { type: "p", text: "Binnen weniger Monate verschob sich das. Leute benutzten es für die harmlosen Eigenheiten ihrer Partner — er spricht aus, was die Katze gerade denkt, sie sagt jedes Mal \"soso\", bevor sie aufsteht — und der Ton kippte von abschätzig zu zärtlich. Beide Lesarten sind im Umlauf, der Zusammenhang entscheidet: beim Profil einer fremden Person heißt es meist langweilig, bei der eigenen meist niedlich." },
      { type: "h2", text: "Beige, Rot oder Grün — wie du es unterscheidest" },
      { type: "ul", items: [
        "**Es sagt nichts darüber, wie du behandelt wirst:** das ist der ganze Test — Rot und Grün betreffen das Verhalten, Beige die Textur",
        "**Es gehört nur dieser einen Person:** nicht \"mag Kaffee\", sondern die Bohnen am Abend mahlen, damit der Morgen leiser ist",
        "**Du siehst es nur aus der Nähe:** dafür braucht es ein paar gewöhnliche Wochen, kein erstes Date",
        "**Es auszusprechen macht Spaß, statt Angst:** du erzählst es, und die Person lacht; wird sie abwehrend, war es nie beige",
      ] },
      { type: "h2", accent: "green", text: "Was du damit machst" },
      { type: "p", text: "Sammle sie. Wie viele Beige Flags du bei jemandem aufzählen kannst, ist ein ganz guter Gradmesser dafür, wie viel Aufmerksamkeit du wirklich schenkst — denn man bemerkt keine einzige, solange man jemanden prüft oder ihm etwas vorspielt. Und was die Profilseite des Wortes angeht: Ein beiges Profil ist kein Urteil über einen Menschen. Viele interessante Leute sind schlecht darin, sich in drei Zeilen zu beschreiben. Stell lieber eine konkrete Frage." },
      { type: "p", text: "Eine Warnung: Sortiere nichts als beige ein, nur um dich nicht damit befassen zu müssen. \"Er schweigt eben drei Tage, das ist halt so\" ist keine Marotte. Die Grenze ist das Verhalten: Sobald eine Gewohnheit verändert, wie du behandelt wirst, ist sie in Rot oder Grün gerutscht, so liebevoll du sie auch beschreibst." },
    ],
  },

  fr: {
    term: "Beige flag",
    summary:
      "Un trait qui n'est ni une alerte ni un argument : une petite bizarrerie inoffensive qui dit qui est la personne, sans rien dire de la façon dont elle te traitera.",
    blocks: [
      { type: "h2", text: "Un mot qui a changé de sens en un an" },
      { type: "p", text: "Au départ, c'était un reproche adressé aux profils. En 2022, l'expression s'est répandue sur les vidéos courtes pour désigner un profil qui ne donne rien : les trois mêmes photos de groupe, un poisson pêché, \"j'aime voyager et bien manger\", une taille et pas grand-chose d'autre. Ni alerte ni attrait — juste beige. Le reproche en dessous était concret : on peut en lire cent et n'apprendre sur personne." },
      { type: "p", text: "En quelques mois, le sens a glissé. Les gens se sont mis à l'employer pour les bizarreries inoffensives de leur partenaire — il fait parler le chat, elle dit \"bon\" avant de se lever — et le ton est passé du dédain à la tendresse. Les deux lectures circulent encore : sur le profil d'un inconnu, ça veut dire fade ; sur son partenaire, ça veut dire attachant." },
      { type: "h2", text: "Beige, rouge ou vert : comment trancher" },
      { type: "ul", items: [
        "**Ça ne dit rien de la façon dont on te traitera :** c'est tout le test — le rouge et le vert parlent de conduite, le beige de texture",
        "**Ça n'appartient qu'à cette personne :** pas \"aime le café\", mais moudre les grains la veille pour que le matin soit plus silencieux",
        "**Ça ne se voit que de près :** il faut quelques semaines ordinaires, pas un premier rendez-vous",
        "**Le dire est drôle, pas délicat :** tu le racontes et la personne rit ; si elle se braque, ce n'était pas beige",
      ] },
      { type: "h2", accent: "green", text: "Qu'en faire" },
      { type: "p", text: "Collectionne-les. Le nombre de beige flags que tu peux citer chez quelqu'un mesure assez bien l'attention que tu lui portes vraiment, parce qu'on n'en remarque aucune tant qu'on fait passer un examen à l'autre ou qu'on joue un rôle devant lui. Côté profils : un profil beige n'est pas un verdict sur une personne. Beaucoup de gens intéressants sont mauvais pour se résumer en trois lignes. Pose une question précise plutôt que de rayer quelqu'un." },
      { type: "p", text: "Une mise en garde : ne range rien en beige pour éviter d'y toucher. \"Il ne parle plus pendant trois jours, c'est comme ça\" n'est pas une bizarrerie. La frontière, c'est la conduite : dès qu'une habitude change la façon dont on te traite, elle est passée en rouge ou en vert, aussi tendrement que tu la racontes." },
    ],
  },

  es: {
    term: "Bandera beige",
    summary:
      "Un rasgo que no es aviso ni argumento a favor: una rareza pequeña e inofensiva que te dice quién es alguien sin decirte nada sobre cómo va a tratarte.",
    blocks: [
      { type: "h2", text: "Una palabra que cambió de sentido en un año" },
      { type: "p", text: "Empezó como un reproche a los perfiles. En 2022 la expresión se extendió por los vídeos cortos para nombrar un perfil que no te da nada: las mismas tres fotos de grupo, un pez recién pescado, \"me encanta viajar y comer bien\", una estatura y poco más. Ni aviso ni atractivo: solo beige. Debajo había una queja concreta: puedes leer cien y no enterarte de nada de nadie." },
      { type: "p", text: "En pocos meses el sentido se desplazó. La gente empezó a usarlo para las rarezas inofensivas de su pareja — él pone voz a lo que piensa el gato, ella dice \"venga\" antes de levantarse — y el tono pasó del desdén al cariño. Las dos lecturas siguen vivas, así que manda el contexto: en el perfil de un desconocido suele significar soso; en tu pareja, entrañable." },
      { type: "h2", text: "Beige, roja o verde: cómo distinguirlas" },
      { type: "ul", items: [
        "**No dice nada sobre cómo te van a tratar:** esa es toda la prueba — la roja y la verde hablan de conducta, la beige de textura",
        "**Es suya y de nadie más:** no \"le gusta el café\", sino moler el grano la noche antes para que la mañana sea más silenciosa",
        "**Solo se ve de cerca:** hacen falta unas semanas normales, no una primera cita",
        "**Contarlo es divertido, no delicado:** se lo dices y se ríe; si se pone a la defensiva, nunca fue beige",
      ] },
      { type: "h2", accent: "green", text: "Qué hacer con ellas" },
      { type: "p", text: "Colecciónalas. Cuántas banderas beige puedes enumerar de alguien mide bastante bien cuánta atención le estás prestando de verdad, porque no detectas ninguna mientras le estás examinando o actuando delante de él. Y en el lado de los perfiles: un perfil beige no es un veredicto sobre una persona. Mucha gente interesante es malísima describiéndose en tres líneas. Haz una pregunta concreta en vez de descartarla." },
      { type: "p", text: "Un aviso: no archives algo como beige para no tener que mirarlo. \"Se calla tres días, es así\" no es una rareza. La frontera es la conducta: en cuanto una costumbre cambia cómo te tratan, ya se ha movido al rojo o al verde, por muy cariñosamente que la cuentes." },
    ],
  },

  ar: {
    term: "علم بيج",
    summary:
      "صفة ليست تحذيرًا ولا ميزة: طبع صغير غير مؤذٍ يخبرك من هو هذا الشخص، ولا يقول شيئًا عن الطريقة التي سيعاملك بها.",
    blocks: [
      { type: "h2", text: "كلمة تغيّر معناها في سنة" },
      { type: "p", text: "بدأت عتابًا على الملفات الشخصية. في 2022 انتشر التعبير في الفيديوهات القصيرة ليصف ملفًا لا يعطيك شيئًا: الصور الجماعية الثلاث نفسها، وسمكة مصطادة، و\"أحب السفر والأكل الجيد\"، ورقم الطول ثم لا شيء تقريبًا. ليس تحذيرًا ولا جاذبية — بيج فقط. والشكوى تحته واضحة: تقرأ مئة ملف ولا تعرف عن أحد شيئًا." },
      { type: "p", text: "وخلال أشهر انزاح المعنى. صار الناس يستعملونه لطباع شركائهم غير المؤذية — يتكلم بلسان القطة، تقول \"يالله\" قبل أن تنهض — وتحوّلت النبرة من الاستخفاف إلى المودّة. القراءتان ما زالتا متداولتين، والسياق هو الذي يحسم: عن ملف شخص غريب تعني مملًا، وعن الشريك تعني محبَّبًا." },
      { type: "h2", text: "بيج أم أحمر أم أخضر؟" },
      { type: "ul", items: [
        "**لا يقول شيئًا عن طريقة معاملتك:** هذا هو الاختبار كله — الأحمر والأخضر عن السلوك، والبيج عن النكهة",
        "**خاص به وحده:** ليس \"يحب القهوة\"، بل يطحن البن ليلًا كي يكون الصباح أهدأ",
        "**لا يُرى إلا من قرب:** يحتاج أسابيع عادية، لا موعدًا أول",
        "**قوله ممتع لا محرج:** تخبره فيضحك؛ وإن اندفع يدافع عن نفسه فلم يكن بيجًا أصلًا",
      ] },
      { type: "h2", accent: "green", text: "ماذا تفعل بها" },
      { type: "p", text: "اجمعها. عدد الأعلام البيج التي تستطيع تعدادها عن شخص ما مقياس جيد لمقدار الانتباه الذي تمنحه فعلًا، لأنك لا تلاحظ واحدة منها وأنت تمتحن الطرف الآخر أو تمثّل أمامه. أما في جانب الملفات الشخصية، فالملف البيج ليس حكمًا على صاحبه: كثير من الناس المشوّقين سيئون في وصف أنفسهم في ثلاثة أسطر. اسأل سؤالًا محددًا بدل أن تشطبه." },
      { type: "p", text: "تنبيه واحد: لا تصنّف شيئًا على أنه بيج لتتجنب مواجهته. \"يصمت ثلاثة أيام، هذه طبيعته\" ليست طرافة. الحدّ هو السلوك: ما إن تغيّر عادةٌ طريقةَ معاملتك حتى تكون انتقلت إلى الأحمر أو الأخضر، مهما رويتها بحنان." },
    ],
  },

  ru: {
    term: "Бежевый флаг",
    summary:
      "Черта, которая не предупреждает и не рекомендует: маленькая безобидная странность, которая говорит, какой человек перед вами, но ничего не говорит о том, как он будет с вами обращаться.",
    blocks: [
      { type: "h2", text: "Слово, которое за год поменяло смысл" },
      { type: "p", text: "Начиналось как претензия к анкетам. В 2022 году выражение разошлось в коротких видео и означало анкету, которая не даёт ровно ничего: те же три групповые фотографии, пойманная рыба, \"люблю путешествия и вкусно поесть\", рост — и почти всё. Не тревога и не притяжение, просто бежевый. Жалоба под этим была понятной: можно пролистать сотню таких и ничего ни о ком не узнать." },
      { type: "p", text: "За несколько месяцев смысл сместился. Люди стали называть так безобидные странности своих партнёров — он озвучивает мысли кота, она говорит \"ну всё\" перед тем, как встать, — и тон сменился с пренебрежительного на нежный. Оба значения живы, решает контекст: про анкету незнакомого человека это чаще \"скучно\", про своего — \"мило\"." },
      { type: "h2", text: "Бежевый, красный или зелёный" },
      { type: "ul", items: [
        "**Ничего не говорит о том, как с вами будут обращаться:** это и есть весь тест — красный и зелёный про поведение, бежевый про фактуру",
        "**Принадлежит только ему одному:** не \"любит кофе\", а мелет зёрна с вечера, чтобы утро было тише",
        "**Виден только вблизи:** нужны несколько обычных недель, а не первое свидание",
        "**Сказать вслух весело, а не страшно:** вы говорите — человек смеётся; если он начинает защищаться, это никогда не было бежевым",
      ] },
      { type: "h2", accent: "green", text: "Что с ними делать" },
      { type: "p", text: "Собирайте их. Сколько чьих-то бежевых флагов вы можете назвать — неплохая мера того, сколько внимания вы на самом деле уделяете: ни одного не заметишь, пока экзаменуешь человека или играешь перед ним роль. Что до анкет, бежевая анкета — не приговор человеку: множество интересных людей просто плохо описывают себя в трёх строках. Задайте один конкретный вопрос вместо того, чтобы вычеркнуть." },
      { type: "p", text: "Одно предостережение: не записывайте что-то в бежевое, чтобы не разбираться. \"Он просто молчит три дня, такой характер\" — не странность. Граница проходит по поведению: как только привычка меняет то, как с вами обращаются, она уже перешла в красное или зелёное, как бы ласково вы её ни описывали." },
    ],
  },

  pt: {
    term: "Beige flag",
    summary:
      "Uma característica que não é alerta nem elogio: uma mania pequena e inofensiva que mostra quem a pessoa é, sem dizer nada sobre como ela vai te tratar.",
    blocks: [
      { type: "h2", text: "Uma palavra que mudou de sentido em um ano" },
      { type: "p", text: "Começou como reclamação sobre perfis. Em 2022 a expressão se espalhou nos vídeos curtos para nomear o perfil que não entrega nada: as mesmas três fotos em grupo, um peixe pescado, \"amo viajar e comer bem\", uma altura e quase nada mais. Não é alerta nem atrativo — é só bege. Por baixo havia uma queixa concreta: dá para ler cem desses e não descobrir nada sobre ninguém." },
      { type: "p", text: "Em poucos meses o sentido escorregou. As pessoas passaram a usar para as esquisitices inofensivas do parceiro — ele dubla o que o gato está pensando, ela fala \"bora\" antes de levantar — e o tom foi do desdém para o carinho. As duas leituras continuam vivas, então o contexto decide: sobre o perfil de um estranho costuma significar sem graça; sobre o parceiro, querido." },
      { type: "h2", text: "Bege, vermelha ou verde: como separar" },
      { type: "ul", items: [
        "**Não diz nada sobre como você vai ser tratado:** o teste é esse — vermelha e verde falam de conduta, bege fala de textura",
        "**É só dela:** não \"gosta de café\", e sim moer os grãos na noite anterior para a manhã ser mais silenciosa",
        "**Só se vê de perto:** exige algumas semanas comuns, não um primeiro encontro",
        "**Falar sobre isso é divertido, não delicado:** você conta e a pessoa ri; se ela se defende, nunca foi bege",
      ] },
      { type: "h2", accent: "green", text: "O que fazer com elas" },
      { type: "p", text: "Colecione. Quantas beige flags você consegue listar de alguém é uma boa medida de quanta atenção você está realmente dando, porque não dá para notar nenhuma enquanto você está avaliando a pessoa ou atuando na frente dela. E do lado dos perfis: um perfil bege não é um veredito sobre quem escreveu. Muita gente interessante é péssima em se resumir em três linhas. Faça uma pergunta específica em vez de descartar." },
      { type: "p", text: "Um aviso: não arquive nada como bege só para não lidar com aquilo. \"Ele fica três dias sem falar, é o jeito dele\" não é mania. A fronteira é a conduta: no instante em que um hábito muda como você é tratado, ele já passou para o vermelho ou para o verde, por mais carinhosa que seja a descrição." },
    ],
  },

  it: {
    term: "Beige flag",
    summary:
      "Un tratto che non è né un allarme né un punto a favore: una piccola stranezza innocua che ti dice chi è una persona senza dirti nulla su come ti tratterà.",
    blocks: [
      { type: "h2", text: "Una parola che ha cambiato senso in un anno" },
      { type: "p", text: "È nata come rimprovero ai profili. Nel 2022 l'espressione si è diffusa nei video brevi per indicare un profilo che non ti dà niente: le solite tre foto di gruppo, un pesce appena pescato, \"amo viaggiare e mangiare bene\", un'altezza e poco altro. Non un allarme, non un richiamo — solo beige. Sotto c'era una lamentela precisa: puoi leggerne cento e non sapere niente di nessuno." },
      { type: "p", text: "Nel giro di pochi mesi il senso è scivolato. La gente ha iniziato a usarla per le stranezze innocue del partner — lui doppia i pensieri del gatto, lei dice \"allora\" prima di alzarsi — e il tono è passato dallo sfottò all'affetto. Entrambe le letture circolano ancora, quindi decide il contesto: sul profilo di uno sconosciuto vuol dire insipido, sul proprio partner vuol dire caro." },
      { type: "h2", text: "Beige, rossa o verde: come distinguerle" },
      { type: "ul", items: [
        "**Non dice nulla su come verrai trattato:** il test è tutto qui — rosso e verde riguardano la condotta, il beige la consistenza",
        "**È solo sua:** non \"gli piace il caffè\", ma macinare i chicchi la sera prima perché la mattina sia più silenziosa",
        "**Si vede solo da vicino:** servono qualche settimana normale, non un primo appuntamento",
        "**Dirlo è divertente, non delicato:** glielo racconti e ride; se si mette sulla difensiva, non era beige",
      ] },
      { type: "h2", accent: "green", text: "Cosa farne" },
      { type: "p", text: "Collezionale. Quante beige flag sai elencare di una persona misura piuttosto bene quanta attenzione le stai davvero dando, perché non ne noti nessuna finché la stai esaminando o le stai recitando davanti. Sul versante dei profili, invece, un profilo beige non è un verdetto su chi l'ha scritto: molte persone interessanti sono pessime a riassumersi in tre righe. Fai una domanda precisa invece di cancellarla." },
      { type: "p", text: "Un avvertimento: non archiviare qualcosa come beige per non doverci pensare. \"Sta zitto tre giorni, è fatto così\" non è una stranezza. Il confine è la condotta: nel momento in cui un'abitudine cambia il modo in cui vieni trattato, è già passata al rosso o al verde, per quanto teneramente la racconti." },
    ],
  },

  ja: {
    term: "ベージュフラッグ",
    summary:
      "警告でもおすすめでもない特徴。その人らしさは伝わるのに、あなたがどう扱われるかについては何も教えてくれない、無害で小さな癖のことです。",
    blocks: [
      { type: "h2", text: "一年で意味が変わった言葉" },
      { type: "p", text: "もとはプロフィールへの文句でした。2022年にショート動画で広まったときは、読んでも何も分からないプロフィールを指していました。同じ集合写真が三枚、釣った魚、「旅行とおいしいものが好き」、身長、あとはほとんど何もなし。危険でも魅力でもなく、ただベージュ。その下にあった不満ははっきりしています。百人分読んでも、誰のことも分からない。" },
      { type: "p", text: "数か月で意味がずれました。人々は恋人の無害な癖を指してこの言葉を使い始めます。猫の気持ちを勝手に代弁する、立ち上がる前に必ず「よし」と言う。調子は見下しから愛情に変わりました。両方の意味がまだ生きているので、文脈が決めます。知らない人のプロフィールなら「退屈」、恋人のことなら「かわいい」。" },
      { type: "h2", text: "ベージュか、赤か、緑か" },
      { type: "ul", items: [
        "**あなたの扱われ方について何も語らない:** 判定はこれだけ——赤と緑は行動の話、ベージュは手ざわりの話",
        "**その人だけのもの:** 「コーヒーが好き」ではなく、朝を静かにするために豆を前の晩に挽いておくこと",
        "**近くでしか見えない:** 初デートではなく、ふつうの数週間が要る",
        "**口に出すのが楽しい、気まずくない:** 伝えると笑う。むきになるなら、それは最初からベージュではない",
      ] },
      { type: "h2", accent: "green", text: "見つけたらどうするか" },
      { type: "p", text: "集めてください。相手のベージュフラッグをいくつ挙げられるかは、実際どれだけ相手を見ているかの目安になります。審査しているあいだも、自分を演じているあいだも、こういう細部には気づけないからです。プロフィールのほうの意味については、ベージュな自己紹介はその人への判決ではありません。面白い人ほど三行で自分を説明するのが下手だったりします。切り捨てる前に、具体的な質問を一つしてみてください。" },
      { type: "p", text: "ひとつだけ注意を。向き合いたくないことをベージュの棚に上げないこと。「三日黙るのはこの人の個性だから」は癖ではありません。線引きは行動です。ある習慣があなたの扱われ方を変え始めた時点で、どれだけ愛おしく語っても、それは赤か緑に移っています。" },
    ],
  },

  ko: {
    term: "베이지 플래그",
    summary:
      "경고도 추천도 아닌 특징. 그 사람이 어떤 사람인지는 알려주지만, 당신을 어떻게 대할지에 대해서는 아무것도 말해주지 않는 작고 무해한 버릇입니다.",
    blocks: [
      { type: "h2", text: "1년 만에 뜻이 바뀐 말" },
      { type: "p", text: "처음에는 프로필에 대한 불평이었습니다. 2022년 짧은 영상으로 퍼졌을 때는 읽어도 아무것도 알 수 없는 프로필을 뜻했습니다. 똑같은 단체 사진 세 장, 낚은 물고기, \"여행과 맛있는 음식을 좋아합니다\", 키, 그리고 거의 끝. 위험도 매력도 아닌, 그냥 베이지. 그 밑에 깔린 불만은 분명했습니다. 백 개를 읽어도 누구에 대해서도 알게 되는 것이 없다는 것." },
      { type: "p", text: "몇 달 만에 뜻이 미끄러졌습니다. 사람들은 연인의 무해한 버릇을 가리키는 데 쓰기 시작했습니다. 고양이의 속마음을 대신 말해준다든가, 일어서기 전에 꼭 \"자, 그럼\" 하고 말한다든가. 어조는 비웃음에서 애정으로 바뀌었습니다. 두 용법 모두 살아 있어서 맥락이 결정합니다. 모르는 사람의 프로필이면 대개 심심하다는 뜻, 연인이면 대개 귀엽다는 뜻입니다." },
      { type: "h2", text: "베이지인가, 빨강인가, 초록인가" },
      { type: "ul", items: [
        "**당신이 어떻게 대우받을지에 대해 아무 말도 하지 않습니다:** 판별은 이것뿐입니다 — 빨강과 초록은 행동에 관한 것이고, 베이지는 결에 관한 것입니다",
        "**그 사람만의 것입니다:** \"커피를 좋아한다\"가 아니라, 아침이 조용하도록 전날 밤에 원두를 갈아두는 것",
        "**가까이서만 보입니다:** 첫 데이트가 아니라 평범한 몇 주가 필요합니다",
        "**말하는 것이 즐겁지 조심스럽지 않습니다:** 말해주면 웃습니다. 방어적으로 나온다면 애초에 베이지가 아니었습니다",
      ] },
      { type: "h2", accent: "green", text: "그것으로 무엇을 할까" },
      { type: "p", text: "모으세요. 어떤 사람의 베이지 플래그를 몇 개나 댈 수 있는지는 당신이 실제로 얼마나 보고 있는지를 재는 괜찮은 척도입니다. 상대를 시험하는 동안에도, 상대 앞에서 연기하는 동안에도 이런 것은 눈에 들어오지 않으니까요. 프로필 쪽 의미라면, 베이지한 자기소개는 그 사람에 대한 판결이 아닙니다. 재미있는 사람일수록 세 줄로 자기를 설명하는 데 서툴기도 합니다. 지워버리기 전에 구체적인 질문 하나를 던져보세요." },
      { type: "p", text: "한 가지 주의. 마주하기 싫은 일을 베이지 칸에 넣지 마세요. \"사흘 말을 안 하는 건 원래 성격이야\"는 버릇이 아닙니다. 경계는 행동입니다. 어떤 습관이 당신이 받는 대우를 바꾸기 시작한 순간, 아무리 다정하게 설명해도 그것은 빨강이나 초록으로 넘어간 것입니다." },
    ],
  },

  zh: {
    term: "米色信号",
    summary:
      "既不是警告也不是加分项的特点：一个无伤大雅的小怪癖，只说明这个人是什么样的人，不说明他会怎么对你。",
    blocks: [
      { type: "h2", text: "一年之内意思就变了的词" },
      { type: "p", text: "它最早是对交友资料的抱怨。二〇二二年在短视频里流行时，指的是那种读完什么也没得到的资料：同样三张合照、一条刚钓上来的鱼、“喜欢旅行和美食”、一个身高，然后几乎就没了。既不危险也不吸引，就是米色。抱怨其实很具体：你翻一百份，谁也没认识。" },
      { type: "p", text: "几个月后，词义就滑走了。人们开始用它形容伴侣身上无害的小怪癖——他会替猫配音，她站起来之前一定要说一声“好嘞”——语气也从嫌弃变成了偏爱。两种用法现在都还在，所以要看语境：说陌生人的资料，通常是无趣；说自己的伴侣，通常是可爱。" },
      { type: "h2", text: "米色、危险，还是积极" },
      { type: "ul", items: [
        "**它不告诉你会被怎样对待：**判断标准只有这一条——危险信号和积极信号讲的是行为，米色讲的是质地",
        "**只属于他一个人：**不是“喜欢喝咖啡”，而是前一晚就把豆子磨好，好让早晨安静一点",
        "**只有靠近了才看得见：**它需要几个平常的星期，而不是一次初次见面",
        "**说出来是好笑的，不是尴尬的：**你告诉他，他会笑；如果他开始辩解，那本来就不是米色",
      ] },
      { type: "h2", accent: "green", text: "该拿它们怎么办" },
      { type: "p", text: "把它们收集起来。你能数出一个人多少个米色信号，其实是在衡量你到底有多认真地看着他，因为你在考察对方、或者在对方面前演的时候，是看不见这些细节的。至于资料那一层意思：一份米色的自我介绍并不是对一个人的判决，很多有意思的人恰恰不擅长用三行字描述自己。与其划掉，不如问一个具体的问题。" },
      { type: "p", text: "一个提醒：别把不想面对的事归进米色。“他就是会三天不说话，性格如此”不是怪癖。分界线就在这里：当一个习惯开始改变你被对待的方式，无论你说得多温柔，它都已经属于危险信号或积极信号那一类了。" },
    ],
  },

  nl: {
    term: "Beige flag",
    summary:
      "Een trekje dat geen waarschuwing en geen pluspunt is: een kleine, onschuldige eigenaardigheid die laat zien wie iemand is, zonder iets te zeggen over hoe die persoon jou zal behandelen.",
    blocks: [
      { type: "h2", text: "Een woord dat in een jaar van betekenis wisselde" },
      { type: "p", text: "Het begon als kritiek op profielen. In 2022 verspreidde de uitdrukking zich via korte video's en betekende ze: een profiel waar je niets aan hebt. Dezelfde drie groepsfoto's, een gevangen vis, \"hou van reizen en lekker eten\", een lengte en verder weinig. Geen waarschuwing, geen aantrekkingskracht — gewoon beige. De klacht eronder was concreet: je kunt er honderd lezen en niemand leren kennen." },
      { type: "p", text: "Binnen een paar maanden verschoof het. Mensen gingen het gebruiken voor de onschuldige eigenaardigheden van hun partner — hij praat namens de kat, zij zegt \"kom op\" voor ze opstaat — en de toon ging van laatdunkend naar liefdevol. Beide lezingen bestaan nog, dus de context beslist: over het profiel van een vreemde betekent het meestal saai, over je eigen partner meestal schattig." },
      { type: "h2", text: "Beige, rood of groen: hoe je het scheidt" },
      { type: "ul", items: [
        "**Het zegt niets over hoe jij behandeld wordt:** dat is de hele test — rood en groen gaan over gedrag, beige over textuur",
        "**Het is alleen van deze persoon:** niet \"houdt van koffie\", maar de bonen 's avonds malen zodat de ochtend stiller is",
        "**Je ziet het alleen van dichtbij:** het kost een paar gewone weken, geen eerste date",
        "**Het benoemen is leuk, niet beladen:** je vertelt het en diegene lacht; wordt hij defensief, dan was het nooit beige",
      ] },
      { type: "h2", accent: "green", text: "Wat je ermee doet" },
      { type: "p", text: "Verzamel ze. Hoeveel beige flags je van iemand kunt opnoemen is een aardige maat voor hoeveel aandacht je werkelijk geeft, want je merkt er geen enkele op zolang je iemand beoordeelt of zelf een rol speelt. En aan de profielkant: een beige profiel is geen oordeel over een mens. Veel interessante mensen zijn juist slecht in zichzelf samenvatten in drie regels. Stel één concrete vraag in plaats van iemand af te strepen." },
      { type: "p", text: "Eén waarschuwing: berg niets op als beige om er niets mee te hoeven. \"Hij zwijgt nu eenmaal drie dagen, dat is zijn ding\" is geen eigenaardigheid. De grens is gedrag: zodra een gewoonte verandert hoe jij behandeld wordt, is ze naar rood of groen verschoven, hoe liefdevol je het ook vertelt." },
    ],
  },

  pl: {
    term: "Beżowa flaga",
    summary:
      "Cecha, która nie jest ani ostrzeżeniem, ani zaletą: drobne, nieszkodliwe dziwactwo, które mówi, kim ktoś jest, i nic nie mówi o tym, jak będzie cię traktować.",
    blocks: [
      { type: "h2", text: "Słowo, które w rok zmieniło znaczenie" },
      { type: "p", text: "Zaczęło się jako pretensja do profili. W 2022 roku określenie rozeszło się w krótkich filmikach i znaczyło: profil, z którego nic nie wynika. Te same trzy zdjęcia grupowe, złowiona ryba, \"kocham podróże i dobre jedzenie\", wzrost i niewiele więcej. Ani ostrzeżenie, ani powab — po prostu beż. Pod spodem była konkretna skarga: można przejrzeć sto takich i nie dowiedzieć się o nikim niczego." },
      { type: "p", text: "W kilka miesięcy znaczenie się przesunęło. Ludzie zaczęli tak mówić o nieszkodliwych dziwactwach swoich partnerów — podkłada głos kotu, mówi \"no dobra\", zanim wstanie — a ton zmienił się z lekceważącego na czuły. Oba użycia wciąż krążą, więc rozstrzyga kontekst: o profilu obcej osoby znaczy zwykle nudny, o własnym partnerze zwykle uroczy." },
      { type: "h2", text: "Beżowa, czerwona czy zielona?" },
      { type: "ul", items: [
        "**Nic nie mówi o tym, jak będą cię traktować:** na tym polega cały test — czerwona i zielona dotyczą postępowania, beżowa faktury",
        "**Należy tylko do tej osoby:** nie \"lubi kawę\", tylko miele ziarna wieczorem, żeby poranek był cichszy",
        "**Widać ją tylko z bliska:** potrzeba kilku zwyczajnych tygodni, nie pierwszej randki",
        "**Mówi się o niej z uśmiechem, nie z napięciem:** opowiadasz, a druga osoba się śmieje; jeśli zaczyna się bronić, to nigdy nie było beżowe",
      ] },
      { type: "h2", accent: "green", text: "Co z nimi zrobić" },
      { type: "p", text: "Zbieraj je. To, ile czyichś beżowych flag potrafisz wymienić, jest całkiem niezłą miarą tego, ile uwagi naprawdę poświęcasz, bo żadnej nie zauważysz, dopóki kogoś egzaminujesz albo odgrywasz przed nim rolę. A po stronie profili: beżowy profil nie jest wyrokiem na człowieka — wiele ciekawych osób po prostu kiepsko streszcza się w trzech linijkach. Zadaj jedno konkretne pytanie, zamiast skreślać." },
      { type: "p", text: "Jedno ostrzeżenie: nie wrzucaj czegoś do beżu, żeby się tym nie zajmować. \"On po prostu milczy trzy dni, taki już jest\" to nie dziwactwo. Granicą jest postępowanie: w chwili, gdy nawyk zmienia sposób, w jaki cię traktują, przeszedł już do czerwieni albo do zieleni, nawet jeśli mówisz o nim najczulej." },
    ],
  },

  sv: {
    term: "Beige flag",
    summary:
      "Ett drag som varken är en varning eller ett plus: en liten, ofarlig egenhet som visar vem någon är, utan att säga något om hur personen kommer att behandla dig.",
    blocks: [
      { type: "h2", text: "Ett ord som bytte betydelse på ett år" },
      { type: "p", text: "Det började som en anmärkning mot profiler. 2022 spreds uttrycket i korta videor och betydde en profil som inte ger dig något: samma tre gruppbilder, en fångad fisk, \"älskar att resa och äta gott\", en längd och sedan knappt mer. Varken varning eller lockelse — bara beige. Klagomålet under det var konkret: du kan läsa hundra sådana och inte lära känna någon." },
      { type: "p", text: "Inom några månader gled betydelsen. Folk började använda det om partnerns ofarliga egenheter — han lägger ord i kattens mun, hon säger \"jaha\" innan hon reser sig — och tonen gick från nedlåtande till öm. Båda läsningarna lever kvar, så sammanhanget avgör: om en främlings profil betyder det oftast trist, om den egna partnern oftast gulligt." },
      { type: "h2", text: "Beige, röd eller grön?" },
      { type: "ul", items: [
        "**Det säger ingenting om hur du kommer att behandlas:** där ligger hela testet — rött och grönt handlar om uppförande, beige om struktur",
        "**Det tillhör bara den personen:** inte \"gillar kaffe\", utan att mala bönorna kvällen innan så att morgonen blir tystare",
        "**Det syns bara på nära håll:** det krävs några vanliga veckor, inte en första dejt",
        "**Att säga det högt är roligt, inte känsligt:** du berättar och personen skrattar; går hen i försvar var det aldrig beige",
      ] },
      { type: "h2", accent: "green", text: "Vad du gör med dem" },
      { type: "p", text: "Samla på dem. Hur många beige flags du kan räkna upp om någon är ett hyfsat mått på hur mycket uppmärksamhet du faktiskt ger, för man lägger inte märke till en enda medan man förhör någon eller spelar en roll inför hen. Och på profilsidan: en beige presentation är ingen dom över en människa — många intressanta personer är usla på att sammanfatta sig på tre rader. Ställ en konkret fråga i stället för att stryka någon." },
      { type: "p", text: "En varning: lägg inte undan något som beige för att slippa ta i det. \"Han tystnar i tre dagar, sådan är han\" är ingen egenhet. Gränsen går vid uppförande: i samma stund som en vana förändrar hur du blir behandlad har den flyttat till rött eller grönt, hur ömt du än beskriver den." },
    ],
  },

  hi: {
    term: "बेज फ्लैग",
    summary:
      "ऐसी बात जो न चेतावनी है न सिफ़ारिश: एक छोटी, हानिरहित आदत जो बताती है कि इंसान कैसा है, पर यह नहीं बताती कि वह आपके साथ कैसा बर्ताव करेगा।",
    blocks: [
      { type: "h2", text: "एक साल में जिसका मतलब बदल गया" },
      { type: "p", text: "शुरुआत प्रोफ़ाइल पर शिकायत के तौर पर हुई। 2022 में जब यह शब्द छोटे वीडियो पर फैला, तो इसका मतलब था ऐसी प्रोफ़ाइल जिससे कुछ हाथ न लगे: वही तीन ग्रुप फ़ोटो, पकड़ी हुई मछली, \"घूमना और अच्छा खाना पसंद है\", एक हाइट और बस। न ख़तरा, न आकर्षण — सिर्फ़ बेज। इसके नीचे शिकायत साफ़ थी: सौ प्रोफ़ाइल पढ़ लीजिए, किसी के बारे में कुछ पता नहीं चलेगा।" },
      { type: "p", text: "कुछ ही महीनों में मतलब खिसक गया। लोग इसे अपने साथी की हानिरहित अजीब आदतों के लिए इस्तेमाल करने लगे — वह बिल्ली की तरफ़ से बोलता है, वह उठने से पहले हर बार \"अच्छा तो\" कहती है — और लहजा तंज़ से बदलकर प्यार का हो गया। दोनों मतलब आज भी चलते हैं, इसलिए संदर्भ तय करता है: अजनबी की प्रोफ़ाइल के लिए आमतौर पर नीरस, अपने साथी के लिए आमतौर पर प्यारा।" },
      { type: "h2", text: "बेज, लाल या हरा — कैसे पहचानें" },
      { type: "ul", items: [
        "**यह नहीं बताती कि आपके साथ कैसा बर्ताव होगा:** पूरी कसौटी यही है — लाल और हरा बर्ताव के बारे में हैं, बेज बनावट के बारे में",
        "**यह सिर्फ़ उसकी अपनी है:** \"कॉफ़ी पसंद है\" नहीं, बल्कि सुबह शांत रहे इसलिए रात को ही कॉफ़ी पीस कर रख देना",
        "**यह पास से ही दिखती है:** पहली मुलाक़ात में नहीं, कुछ आम हफ़्तों में",
        "**इसे कहने में मज़ा है, झिझक नहीं:** आप बताते हैं और वह हँस देता है; अगर वह सफ़ाई देने लगे तो वह कभी बेज थी ही नहीं",
      ] },
      { type: "h2", accent: "green", text: "इनका क्या करें" },
      { type: "p", text: "इन्हें जमा कीजिए। किसी के कितने बेज फ्लैग आप गिना सकते हैं, यह इस बात का ठीक-ठाक पैमाना है कि आप उसे सचमुच कितना देख रहे हैं — क्योंकि जब तक आप सामने वाले की परीक्षा ले रहे हैं या उसके सामने कोई रूप धर रहे हैं, ये बारीकियाँ दिखती ही नहीं। और प्रोफ़ाइल वाले मतलब पर: बेज प्रोफ़ाइल इंसान पर फ़ैसला नहीं है — कई दिलचस्प लोग तीन पंक्तियों में ख़ुद को बताने में कमज़ोर होते हैं। काट देने के बजाय एक ठोस सवाल पूछिए।" },
      { type: "p", text: "एक चेतावनी: जिस बात का सामना नहीं करना, उसे बेज के ख़ाने में मत डालिए। \"वह तीन दिन बात नहीं करता, बस ऐसा ही है\" कोई मामूली आदत नहीं है। रेखा बर्ताव पर है: जिस पल कोई आदत यह बदलने लगे कि आपके साथ कैसा सुलूक होता है, आप उसे कितने ही प्यार से बताएँ, वह लाल या हरे में जा चुकी है।" },
    ],
  },
};
