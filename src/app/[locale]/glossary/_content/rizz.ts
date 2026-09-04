import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Rizz — charisma in flirting: the knack of making a conversation land.
 *
 * Judgement calls a later editor should not undo by accident:
 *
 * - THE ONE ATTRIBUTED FACT is Oxford University Press naming rizz its word of
 *   the year in 2023, and the publisher is named in the same sentence as the
 *   claim. That is a dictionary decision, not a statistic about people, so it
 *   needs no `StatSource`. Everything else here is qualitative on purpose:
 *   there is no "X% of daters say", no "studies show that eye contact…", and
 *   none should be added without a named primary source.
 *
 * - THE ARGUMENT IS THAT SCRIPTED OPENERS ARE THE WEAK FORM. The page says
 *   rizz is mostly attention and timing, and that the internet's line-collecting
 *   version is the least effective one. This is the honest reading of the term
 *   and it is also what makes the page useful rather than another list of
 *   openers. Do not turn block 4 into example pickup lines — that would
 *   contradict the body and make the page exactly what it argues against.
 *
 * - BLOCK 7 IS THE CHATFISHING PAIRING, not a product pitch: an outsourced
 *   opener is not rizz, because the charm belongs to whatever wrote it. Qulo is
 *   deliberately not mentioned anywhere on this page. Under the one-in-three
 *   rule the Qulo angle is spent on `catfishing` in this batch of terms, and
 *   there is no honest link between a question quiz and personal charisma.
 *
 * - TERM NAMES. There is no native word for this in any of the 16 languages, so
 *   ar/ru/ja/ko/hi use the native-script spelling readers actually type, and
 *   ja/ko keep the Latin form in parentheses because リズ and 리즈 both collide
 *   with common existing words. zh keeps the Latin "Rizz": no Chinese rendering
 *   has settled, and 撩人魅力 is a gloss rather than a name, so it appears in
 *   the summary instead.
 */
export const rizz: LocalizedGlossaryEntry = {
  en: {
    term: "Rizz",
    summary:
      "Charisma aimed at flirting: the knack of making a conversation land, so the other person enjoys being in it and wants it to keep going.",
    blocks: [
      { type: "h2", text: "A new word for an old thing" },
      { type: "p", text: "It is charisma with the ends knocked off — the middle syllable, kept as a word of its own. It spread through streaming and short video around 2021, and Oxford University Press picked it as word of the year in 2023. What it describes is not new at all. Some people are simply easy to talk to, and you come away from ten minutes with them feeling better than you did before." },
      { type: "p", text: "The internet flattened it into openers: lines to memorise, screenshots of a clever first message. That is the weakest version of it. A line is over in one second, and if it misses there is nowhere to go. Attention keeps working all evening. Most of rizz is **hearing what someone actually said and answering that**, plus timing — knowing when to push a joke and when to leave a pause alone." },
      { type: "h2", text: "What it actually looks like" },
      { type: "ul", items: [
        "They catch the small thing you mentioned in passing and bring it back an hour later.",
        "There is room in the conversation — they let a pause sit instead of filling it.",
        "The teasing is light, and it stops the second it stops landing.",
        "The compliments are specific to you, not the kind that would work on anybody.",
      ] },
      { type: "h2", accent: "green", text: "How to get better at it" },
      { type: "p", text: "Stop collecting lines. Ask one more question than feels natural about whatever they lit up over. Read back your last five messages and count how many were about you. **Answer the interesting half of what they said instead of the polite half.** Slower and more specific beats clever almost every time. And if you freeze in text, remember that the same person is often fine in a two-minute voice note." },
      { type: "p", text: "One thing rizz is not: a borrowed opener. If a chatbot wrote the charming message, the charm belongs to the chatbot, and you are still the one who has to show up for the coffee. Send the slightly awkward line that is yours. It travels much better into a real conversation than a perfect one that is not." },
    ],
  },
  tr: {
    term: "Rizz",
    summary:
      "Flörtte işleyen karizma: sohbeti tutturma becerisi; karşındaki konuşmanın içinde olmaktan keyif alır ve devam etmesini ister.",
    blocks: [
      { type: "h2", text: "Eski bir şeyin yeni adı" },
      { type: "p", text: "İngilizce karizma kelimesinin iki ucu kırpılmış hâli: ortadaki hece tek başına kalmış. 2021 civarında yayın ve kısa video dünyasında yayıldı, 2023'te de Oxford University Press yılın kelimesi seçti. Anlattığı şeyse hiç yeni değil. Bazı insanlarla konuşmak kolaydır; onlarla geçen on dakikanın ardından kendini girdiğinden daha iyi hissedersin." },
      { type: "p", text: "İnternet bunu açılış cümlelerine indirdi: ezberlenecek repliklerin, akıllıca ilk mesajların ekran görüntüleri. Oysa en zayıf hâli bu. Bir replik bir saniyede biter ve tutmazsa gidecek yer kalmaz. Dikkat ise bütün akşam çalışır. Rizz'in büyük kısmı **karşındakinin gerçekten ne söylediğini duymak ve ona cevap vermek**, bir de zamanlama: şakayı ne zaman ilerleteceğini, sessizliği ne zaman bırakacağını bilmek." },
      { type: "h2", text: "Gerçekte neye benzer?" },
      { type: "ul", items: [
        "Geçerken söylediğin küçük şeyi yakalar ve bir saat sonra geri getirir.",
        "Sohbette boşluk vardır; sessizliği doldurmak yerine öylece bırakır.",
        "Takılma hafiftir ve tutmadığı anda biter.",
        "İltifat sana özeldir, herkese uyacak cinsten değildir.",
      ] },
      { type: "h2", accent: "green", text: "Nasıl geliştirilir?" },
      { type: "p", text: "Replik biriktirmeyi bırak. Gözlerinin parladığı konuda, doğal gelenden bir soru fazla sor. Son beş mesajını geri oku ve kaçının kendinle ilgili olduğunu say. **Söylediklerinin kibar yarısına değil, ilginç yarısına cevap ver.** Daha yavaş ve daha somut olmak, zeki olmayı neredeyse her seferinde yener. Yazışırken donuyorsan şunu hatırla: aynı kişi iki dakikalık bir sesli mesajda çoğu zaman gayet iyidir." },
      { type: "p", text: "Rizz'in kesinlikle olmadığı bir şey var: ödünç alınmış açılış cümlesi. O etkileyici mesajı bir sohbet botu yazdıysa, etkileyicilik botun olur; kahveye gitmek zorunda olan yine sensin. Biraz beceriksiz ama sana ait olan cümleyi gönder. Gerçek bir sohbete, sana ait olmayan kusursuz cümleden çok daha iyi taşınır." },
    ],
  },
  de: {
    term: "Rizz",
    summary:
      "Charisma im Flirt: die Fähigkeit, ein Gespräch treffen zu lassen, sodass das Gegenüber gern darin ist und will, dass es weitergeht.",
    blocks: [
      { type: "h2", text: "Ein neues Wort für eine alte Sache" },
      { type: "p", text: "Es ist Charisma mit abgeschlagenen Enden — die mittlere Silbe, die als eigenes Wort übrig blieb. Über Streaming und Kurzvideo verbreitete es sich ab etwa 2021, und Oxford University Press kürte es 2023 zum Wort des Jahres. Was es beschreibt, ist überhaupt nicht neu. Mit manchen Menschen redet man einfach leicht, und nach zehn Minuten geht man besser gelaunt weg, als man gekommen ist." },
      { type: "p", text: "Das Internet hat daraus Anmachsprüche gemacht: Zeilen zum Auswendiglernen, Screenshots einer cleveren ersten Nachricht. Das ist die schwächste Form davon. Ein Spruch ist nach einer Sekunde vorbei, und wenn er danebengeht, führt kein Weg weiter. Aufmerksamkeit dagegen wirkt den ganzen Abend. Rizz besteht vor allem darin, **zu hören, was jemand wirklich gesagt hat, und darauf zu antworten** — dazu Timing: wann man einen Witz weitertreibt und wann man eine Pause stehen lässt." },
      { type: "h2", text: "Wie es tatsächlich aussieht" },
      { type: "ul", items: [
        "Sie greifen die Kleinigkeit auf, die du nebenbei erwähnt hast, und bringen sie eine Stunde später zurück.",
        "Im Gespräch ist Platz — eine Pause darf stehen bleiben, statt gefüllt zu werden.",
        "Das Necken bleibt leicht und hört in der Sekunde auf, in der es nicht mehr ankommt.",
        "Die Komplimente gelten dir, nicht der Sorte Kompliment, die bei jedem funktioniert.",
      ] },
      { type: "h2", accent: "green", text: "Wie man besser darin wird" },
      { type: "p", text: "Hör auf, Sprüche zu sammeln. Stell eine Frage mehr, als sich natürlich anfühlt, zu dem Thema, bei dem die Augen aufgegangen sind. Lies deine letzten fünf Nachrichten und zähl, wie viele von dir handelten. **Antworte auf die interessante Hälfte des Gesagten, nicht auf die höfliche.** Langsamer und konkreter schlägt clever fast immer. Und wenn du beim Schreiben erstarrst: dieselbe Person ist in einer Zwei-Minuten-Sprachnachricht oft völlig entspannt." },
      { type: "p", text: "Eines ist Rizz sicher nicht: ein geliehener Einstieg. Wenn ein Chatbot die charmante Nachricht geschrieben hat, gehört der Charme dem Chatbot — zum Kaffee erscheinen musst trotzdem du. Schick den leicht unbeholfenen Satz, der dir gehört. Er trägt in ein echtes Gespräch viel weiter als ein perfekter, der es nicht tut." },
    ],
  },
  fr: {
    term: "Rizz",
    summary:
      "Le charisme appliqué à la drague : l'art de faire mouche dans une conversation, au point que l'autre y prend plaisir et veut la prolonger.",
    blocks: [
      { type: "h2", text: "Un mot neuf pour une chose ancienne" },
      { type: "p", text: "C'est charisma amputé de ses deux bouts : la syllabe du milieu, devenue un mot à part entière. Il s'est répandu par le streaming et la vidéo courte autour de 2021, et Oxford University Press en a fait son mot de l'année en 2023. Ce qu'il décrit n'a rien de nouveau. Avec certaines personnes, parler est simplement facile, et on ressort de dix minutes en meilleure forme qu'en entrant." },
      { type: "p", text: "Internet l'a réduit à des phrases d'accroche : des répliques à retenir, des captures d'un premier message malin. C'est la version la plus faible. Une réplique dure une seconde, et si elle rate il n'y a plus d'issue. L'attention, elle, fonctionne toute la soirée. L'essentiel du rizz consiste à **entendre ce que l'autre a vraiment dit et à y répondre**, plus le timing : savoir quand pousser une blague et quand laisser un silence tranquille." },
      { type: "h2", text: "À quoi ça ressemble vraiment" },
      { type: "ul", items: [
        "Ils attrapent le petit détail que vous avez lâché en passant et le ramènent une heure plus tard.",
        "La conversation a de la place — un silence peut rester là au lieu d'être comblé.",
        "La taquinerie reste légère et s'arrête à la seconde où elle ne prend plus.",
        "Les compliments vous visent vous, pas ceux qui marcheraient sur n'importe qui.",
      ] },
      { type: "h2", accent: "green", text: "Comment progresser" },
      { type: "p", text: "Arrêtez de collectionner les répliques. Posez une question de plus que ce qui semble naturel sur le sujet qui l'a allumé. Relisez vos cinq derniers messages et comptez combien parlaient de vous. **Répondez à la moitié intéressante de ce qui a été dit, pas à la moitié polie.** Plus lent et plus précis bat malin presque à chaque fois. Et si vous vous figez à l'écrit, souvenez-vous que la même personne s'en sort très bien dans un vocal de deux minutes." },
      { type: "p", text: "Une chose que le rizz n'est pas : une accroche empruntée. Si un agent conversationnel a écrit le message charmant, le charme lui appartient, et c'est vous qui devrez tout de même vous présenter au café. Envoyez la phrase un peu maladroite qui est la vôtre. Elle passe bien mieux dans une vraie conversation qu'une phrase parfaite qui ne l'est pas." },
    ],
  },
  es: {
    term: "Rizz",
    summary:
      "Carisma aplicado al ligue: la habilidad de que una conversación funcione, de manera que la otra persona disfruta estando en ella y quiere que siga.",
    blocks: [
      { type: "h2", text: "Una palabra nueva para algo viejo" },
      { type: "p", text: "Es carisma con los extremos recortados: la sílaba del medio, convertida en palabra propia. Se extendió con el streaming y el vídeo corto hacia 2021, y Oxford University Press la eligió palabra del año en 2023. Lo que describe no tiene nada de nuevo. Con algunas personas hablar es simplemente fácil, y sales de diez minutos con ellas mejor de lo que entraste." },
      { type: "p", text: "Internet lo aplanó hasta convertirlo en frases de entrada: réplicas para memorizar, capturas de un primer mensaje ingenioso. Esa es su versión más débil. Una frase dura un segundo y, si falla, no queda a dónde ir. La atención, en cambio, sigue funcionando toda la noche. La mayor parte del rizz consiste en **escuchar lo que la otra persona dijo de verdad y responder a eso**, más el ritmo: saber cuándo empujar una broma y cuándo dejar un silencio en paz." },
      { type: "h2", text: "Cómo se ve en realidad" },
      { type: "ul", items: [
        "Pillan la cosa pequeña que mencionaste de pasada y la traen de vuelta una hora después.",
        "La conversación tiene espacio: dejan que un silencio se quede en lugar de rellenarlo.",
        "El pique es ligero y se corta en el segundo en que deja de funcionar.",
        "Los halagos son específicos para ti, no del tipo que serviría con cualquiera.",
      ] },
      { type: "h2", accent: "green", text: "Cómo mejorar en esto" },
      { type: "p", text: "Deja de coleccionar frases. Haz una pregunta más de las que parecen naturales sobre aquello que le encendió. Relee tus últimos cinco mensajes y cuenta cuántos hablaban de ti. **Responde a la mitad interesante de lo que dijo, no a la mitad educada.** Más lento y más concreto le gana a ingenioso casi siempre. Y si te bloqueas por escrito, recuerda que esa misma persona suele estar bien en un audio de dos minutos." },
      { type: "p", text: "Algo que el rizz no es: una entrada prestada. Si el mensaje encantador lo escribió un chatbot, el encanto es del chatbot, y al café tienes que ir tú igualmente. Manda la frase un poco torpe que sea tuya. Viaja mucho mejor hacia una conversación real que una perfecta que no lo es." },
    ],
  },
  ar: {
    term: "ريز",
    summary:
      "الكاريزما في المغازلة: القدرة على جعل الحديث يُصيب هدفه، فيستمتع الطرف الآخر بوجوده فيه ويرغب في أن يستمر. وتُكتب بالإنجليزية rizz.",
    blocks: [
      { type: "h2", text: "كلمة جديدة لشيء قديم" },
      { type: "p", text: "هي كلمة charisma بعد قصّ طرفيها، فبقي المقطع الأوسط كلمةً قائمة بذاتها. انتشرت عبر البث المباشر والفيديوهات القصيرة حوالي عام 2021، واختارتها دار نشر جامعة أكسفورد كلمةَ العام في 2023. أما ما تصفه فليس جديدًا إطلاقًا. هناك أشخاص يسهل الحديث معهم ببساطة، وتخرج من عشر دقائق معهم في حال أفضل مما دخلت." },
      { type: "p", text: "اختزلها الإنترنت في جُمل افتتاحية: عبارات تُحفظ، ولقطات شاشة لرسالة أولى ذكية. وهذه أضعف صورها. الجملة تنتهي في ثانية، وإن أخفقت فلا مكان تذهب إليه. أما الانتباه فيظل يعمل طوال المساء. معظم الريز هو **أن تسمع ما قاله الآخر فعلًا وتردّ عليه**، إضافة إلى التوقيت: متى تمضي بالمزحة ومتى تترك الصمت في مكانه." },
      { type: "h2", text: "كيف يبدو في الواقع" },
      { type: "ul", items: [
        "يلتقط التفصيلة الصغيرة التي ذكرتها عابرًا، ويعيدها بعد ساعة.",
        "في الحديث متّسع — يترك الصمت يمرّ بدل أن يملأه.",
        "المزاح خفيف، ويتوقف في اللحظة التي يكفّ فيها عن أن يكون لطيفًا.",
        "المجاملات موجّهة إليك أنت، لا من النوع الذي ينجح مع أي أحد.",
      ] },
      { type: "h2", accent: "green", text: "كيف تتحسّن فيه" },
      { type: "p", text: "توقّف عن جمع العبارات. اسأل سؤالًا واحدًا أكثر مما يبدو طبيعيًا عن الشيء الذي أضاء وجهه. أعد قراءة رسائلك الخمس الأخيرة وعُدّ كم واحدة منها كانت عنك. **أجب عن النصف المثير للاهتمام مما قيل، لا عن النصف المهذّب.** الأبطأ والأكثر تحديدًا يتفوق على الذكي في أغلب الأحيان. وإن تجمّدت في الكتابة، تذكّر أن الشخص نفسه غالبًا يكون على طبيعته في رسالة صوتية من دقيقتين." },
      { type: "p", text: "وهناك ما ليس ريزًا بالتأكيد: افتتاحية مستعارة. إذا كتب روبوت المحادثة الرسالة الساحرة، فالسحر له، وأنت من سيجلس على فنجان القهوة في النهاية. أرسل الجملة المرتبكة قليلًا التي تخصّك. إنها تنتقل إلى حديث حقيقي أفضل بكثير من جملة مثالية ليست منك." },
    ],
  },
  ru: {
    term: "Ризз",
    summary:
      "Харизма в флирте: умение вести разговор так, чтобы собеседнику было в нём хорошо и хотелось продолжать.",
    blocks: [
      { type: "h2", text: "Новое слово для старой вещи" },
      { type: "p", text: "Это английское charisma с отрубленными краями — остался средний слог, ставший отдельным словом. Оно разошлось через стримы и короткие видео примерно с 2021 года, а в 2023-м издательство Оксфордского университета назвало его словом года. При этом описывает оно вещь совершенно не новую. С некоторыми людьми просто легко разговаривать, и после десяти минут с ними уходишь в лучшем настроении, чем пришёл." },
      { type: "p", text: "Интернет сплющил всё это до заготовленных фраз: реплики для заучивания, скриншоты остроумного первого сообщения. Это самая слабая версия. Реплика заканчивается за секунду, и если она не зашла, идти некуда. А внимание работает весь вечер. Ризз по большей части — это **услышать, что человек на самом деле сказал, и ответить именно на это**, плюс чувство момента: когда развить шутку, а когда оставить паузу в покое." },
      { type: "h2", text: "Как это выглядит на самом деле" },
      { type: "ul", items: [
        "Он ловит мелочь, которую вы обронили мимоходом, и возвращает её через час.",
        "В разговоре есть воздух — паузе позволяют повисеть, а не затыкают её.",
        "Подтрунивание лёгкое и прекращается в ту секунду, когда перестаёт быть приятным.",
        "Комплименты адресованы именно вам, а не из тех, что подошли бы кому угодно.",
      ] },
      { type: "h2", accent: "green", text: "Как этому научиться" },
      { type: "p", text: "Перестаньте собирать фразы. Задайте на один вопрос больше, чем кажется естественным, о том, от чего у человека загорелись глаза. Перечитайте свои последние пять сообщений и посчитайте, сколько из них были о вас. **Отвечайте на интересную половину сказанного, а не на вежливую.** Медленнее и конкретнее почти всегда выигрывает у остроумнее. А если вы замираете в переписке, вспомните: тот же человек обычно прекрасно звучит в двухминутном голосовом." },
      { type: "p", text: "Чем ризз точно не является, так это одолженным вступлением. Если обаятельное сообщение написал чат-бот, обаяние принадлежит боту, а на кофе всё равно идти вам. Отправьте чуть неуклюжую фразу, которая ваша. В настоящий разговор она переезжает намного лучше, чем безупречная чужая." },
    ],
  },
  pt: {
    term: "Rizz",
    summary:
      "Carisma aplicado à paquera: o jeito de fazer a conversa acertar, de modo que a outra pessoa goste de estar nela e queira que continue.",
    blocks: [
      { type: "h2", text: "Uma palavra nova para uma coisa antiga" },
      { type: "p", text: "É carisma com as pontas cortadas: sobrou a sílaba do meio, virada palavra. Espalhou-se pelas transmissões ao vivo e pelos vídeos curtos por volta de 2021, e a editora da Universidade de Oxford a escolheu palavra do ano em 2023. O que ela descreve não tem nada de novo. Com algumas pessoas conversar é simplesmente fácil, e você sai de dez minutos com elas melhor do que entrou." },
      { type: "p", text: "A internet achatou isso em cantadas: falas para decorar, prints de uma primeira mensagem esperta. Essa é a versão mais fraca. Uma fala acaba em um segundo e, se erra, não sobra para onde ir. A atenção continua funcionando a noite inteira. A maior parte do rizz é **ouvir o que a pessoa realmente disse e responder àquilo**, mais o tempo certo: saber quando levar a piada adiante e quando deixar um silêncio em paz." },
      { type: "h2", text: "Como isso aparece de verdade" },
      { type: "ul", items: [
        "Pega a coisinha que você comentou de passagem e traz de volta uma hora depois.",
        "A conversa tem espaço: deixa um silêncio existir em vez de preencher.",
        "A provocação é leve e para no segundo em que deixa de cair bem.",
        "Os elogios são específicos para você, não do tipo que serviria para qualquer um.",
      ] },
      { type: "h2", accent: "green", text: "Como melhorar nisso" },
      { type: "p", text: "Pare de colecionar cantadas. Faça uma pergunta a mais do que parece natural sobre o assunto que acendeu a pessoa. Releia suas últimas cinco mensagens e conte quantas falavam de você. **Responda à metade interessante do que foi dito, não à metade educada.** Mais devagar e mais específico ganha de esperto quase sempre. E se você trava no texto, lembre que a mesma pessoa costuma ir muito bem num áudio de dois minutos." },
      { type: "p", text: "Uma coisa que rizz não é: uma abertura emprestada. Se foi um chatbot que escreveu a mensagem encantadora, o encanto é dele, e quem tem de aparecer no café continua sendo você. Mande a frase meio desajeitada que é sua. Ela chega muito melhor a uma conversa real do que uma frase perfeita que não é." },
    ],
  },
  it: {
    term: "Rizz",
    summary:
      "Il carisma applicato al corteggiamento: la capacità di far funzionare una conversazione, così che l'altro ci stia volentieri e voglia continuare.",
    blocks: [
      { type: "h2", text: "Una parola nuova per una cosa antica" },
      { type: "p", text: "È charisma con le estremità tagliate: resta la sillaba centrale, diventata parola a sé. Si è diffusa con lo streaming e i video brevi intorno al 2021, e la casa editrice dell'Università di Oxford l'ha eletta parola dell'anno nel 2023. Quello che descrive non è affatto nuovo. Con certe persone parlare è semplicemente facile, e dopo dieci minuti esci meglio di come sei entrato." },
      { type: "p", text: "Internet l'ha appiattita in frasi d'attacco: battute da imparare a memoria, screenshot di un primo messaggio furbo. È la versione più debole. Una battuta finisce in un secondo e, se sbaglia, non porta da nessuna parte. L'attenzione invece lavora tutta la sera. Il rizz è soprattutto **sentire quello che l'altro ha davvero detto e rispondere a quello**, più il tempismo: capire quando spingere una battuta e quando lasciare stare una pausa." },
      { type: "h2", text: "Come si vede davvero" },
      { type: "ul", items: [
        "Coglie la cosa piccola che hai detto di sfuggita e la riporta un'ora dopo.",
        "Nella conversazione c'è spazio: una pausa può restare lì invece di essere riempita.",
        "Lo sfottò è leggero e si ferma nel secondo in cui smette di funzionare.",
        "I complimenti sono specifici per te, non di quelli che andrebbero bene con chiunque.",
      ] },
      { type: "h2", accent: "green", text: "Come diventare più bravi" },
      { type: "p", text: "Smetti di collezionare battute. Fai una domanda in più di quante ne sembrino naturali sull'argomento che gli ha acceso gli occhi. Rileggi i tuoi ultimi cinque messaggi e conta quanti parlavano di te. **Rispondi alla metà interessante di quello che ha detto, non alla metà educata.** Più lento e più concreto batte brillante quasi sempre. E se ti blocchi per iscritto, ricorda che la stessa persona in un vocale di due minuti spesso se la cava benissimo." },
      { type: "p", text: "Una cosa che il rizz non è: un attacco preso in prestito. Se il messaggio affascinante l'ha scritto un chatbot, il fascino è del chatbot, e al caffè devi comunque presentarti tu. Manda la frase un po' impacciata che è tua. In una conversazione vera arriva molto meglio di una perfetta che non ti appartiene." },
    ],
  },
  ja: {
    term: "リズ（rizz）",
    summary:
      "口説くときのカリスマ性。会話をうまく着地させる勘のことで、相手はその時間を楽しみ、もっと続けたいと思う。",
    blocks: [
      { type: "h2", text: "新しい言葉、古い中身" },
      { type: "p", text: "英語の charisma の両端を落として、真ん中の音だけを独立させた言葉です。2021年ごろに配信や短尺動画から広まり、2023年にはオックスフォード大学出版局が「今年の言葉」に選びました。指している中身はまったく新しくありません。話していて単純に楽な人がいて、その人と十分過ごすと、入ってきたときより機嫌よく帰れる。それだけのことです。" },
      { type: "p", text: "ネットはこれを「最初の一言」に押し縮めました。覚えておく決め台詞、気の利いた初回メッセージのスクリーンショット。けれどそれが一番弱い形です。台詞は一秒で終わり、外したら行き先がありません。注意を向けることは一晩じゅう効きます。リズの大半は**相手が実際に言ったことを聞き取って、そこに返すこと**、そして間合いです。冗談をもう一歩進める時と、沈黙をそのままにしておく時を分かること。" },
      { type: "h2", text: "実際にはこう見える" },
      { type: "ul", items: [
        "こちらが何気なく言った小さなことを拾って、一時間後に戻してくる。",
        "会話に余白がある。沈黙を埋めずに、そのまま置いておける。",
        "からかいが軽い。うまくいっていないと分かった瞬間にやめる。",
        "褒め方が自分に向いている。誰にでも通用する種類の褒め言葉ではない。",
      ] },
      { type: "h2", accent: "green", text: "うまくなる方法" },
      { type: "p", text: "決め台詞を集めるのをやめましょう。相手の目が輝いた話題について、自然に思えるより一つ多く質問してみてください。直近の五通を読み返して、自分の話が何通あったか数えてみる。**言われたことの、礼儀正しい半分ではなく面白い半分に返す。** 遅くて具体的なほうが、賢いより強いことがほとんどです。文字だと固まる人も、二分の音声メッセージなら平気だったりします。" },
      { type: "p", text: "リズでは絶対にないものが一つあります。借りてきた第一声です。その魅力的な文章をチャットボットが書いたなら、魅力はボットのもので、コーヒーの席に現れるのは結局あなたです。少しぎこちなくても、自分の言葉を送ってください。自分のものではない完璧な一文より、現実の会話にずっとよく届きます。" },
    ],
  },
  ko: {
    term: "리즈(rizz)",
    summary:
      "연애에서 통하는 매력. 대화를 제대로 안착시키는 감각을 뜻하며, 상대가 그 대화 안에 있는 걸 즐기고 계속하고 싶어지게 만든다.",
    blocks: [
      { type: "h2", text: "새 단어, 오래된 것" },
      { type: "p", text: "영어 charisma의 양끝을 잘라내고 가운데 음절만 남긴 말입니다. 2021년 무렵 스트리밍과 짧은 영상에서 퍼졌고, 2023년에는 옥스퍼드대 출판부가 올해의 단어로 골랐습니다. 가리키는 내용은 전혀 새롭지 않습니다. 어떤 사람과는 그냥 이야기가 쉽고, 10분 있다 나오면 들어갈 때보다 기분이 낫습니다." },
      { type: "p", text: "인터넷은 이걸 첫 멘트로 눌러버렸습니다. 외워 두는 대사, 재치 있는 첫 메시지 캡처. 그게 가장 약한 형태입니다. 대사는 1초면 끝나고, 빗나가면 갈 곳이 없습니다. 반면 주의를 기울이는 일은 저녁 내내 작동합니다. 리즈의 대부분은 **상대가 실제로 한 말을 듣고 거기에 답하는 것**, 그리고 타이밍입니다. 농담을 한 걸음 더 밀 때와 침묵을 그냥 둘 때를 아는 것." },
      { type: "h2", text: "실제로는 이렇게 보입니다" },
      { type: "ul", items: [
        "지나가듯 말한 작은 것을 잡아 두었다가 한 시간 뒤에 다시 꺼냅니다.",
        "대화에 여백이 있습니다. 침묵을 메우지 않고 그대로 둡니다.",
        "장난이 가볍고, 통하지 않는 순간 바로 멈춥니다.",
        "칭찬이 당신에게 맞춰져 있습니다. 아무에게나 먹힐 종류가 아닙니다.",
      ] },
      { type: "h2", accent: "green", text: "어떻게 나아지나" },
      { type: "p", text: "멘트 모으기를 그만두세요. 상대의 눈이 반짝인 주제에 대해, 자연스럽게 느껴지는 것보다 질문 하나를 더 하세요. 최근 다섯 개의 메시지를 다시 읽고 그중 몇 개가 당신 얘기였는지 세어 보세요. **들은 말의 예의 바른 절반이 아니라 흥미로운 절반에 답하세요.** 더 느리고 더 구체적인 쪽이 영리한 쪽을 거의 매번 이깁니다. 글에서 얼어붙는다면, 같은 사람이 2분짜리 음성 메시지에서는 멀쩡한 경우가 많다는 것도 기억하세요." },
      { type: "p", text: "리즈가 확실히 아닌 것 하나. 빌려 온 첫 멘트입니다. 그 매력적인 문장을 챗봇이 썼다면 매력은 챗봇의 것이고, 커피 자리에 나가야 하는 사람은 여전히 당신입니다. 조금 어설퍼도 당신의 문장을 보내세요. 당신 것이 아닌 완벽한 문장보다 실제 대화로 훨씬 잘 옮겨 갑니다." },
    ],
  },
  zh: {
    term: "Rizz",
    summary:
      "调情里的个人魅力，也就是把一段对话说到位的本事：对方待在这段对话里很舒服，还想继续聊下去；中文常译作撩人魅力。",
    blocks: [
      { type: "h2", text: "新词，旧事" },
      { type: "p", text: "它是英文 charisma 砍掉头尾之后剩下的中间那一段，自己独立成了一个词。2021 年前后从直播和短视频里传开，2023 年被牛津大学出版社选为年度词汇。可它说的东西一点也不新。有些人就是好聊，跟他们待十分钟，出来时的心情比进去时要好。" },
      { type: "p", text: "网络把它压扁成了开场白：背下来的台词、一条聪明的第一句话的截图。那是它最弱的形态。台词一秒就结束，说砸了就没有下文；而注意力能管一整晚。Rizz 的大部分，其实是**听清对方真正说了什么，然后回应那一句**，再加上分寸感：什么时候把玩笑再推一步，什么时候让沉默待着。" },
      { type: "h2", text: "真实的样子" },
      { type: "ul", items: [
        "你随口提过的一件小事，他记住了，一小时后又拿回来说。",
        "对话里有留白——沉默可以停在那儿，不必被填满。",
        "玩笑是轻的，一旦对方接不住，立刻就停。",
        "夸的是你这个人，不是那种发给谁都成立的话。",
      ] },
      { type: "h2", accent: "green", text: "怎么变得更好" },
      { type: "p", text: "别再攒台词了。对方眼睛亮起来的那个话题，比你觉得自然的程度多问一个问题。回头读自己最近的五条消息，数数有几条在说你自己。**回应对方话里有意思的那一半，而不是客气的那一半。** 慢一点、具体一点，几乎每次都赢过聪明。如果打字就僵住，记得同一个人发两分钟语音时往往完全正常。" },
      { type: "p", text: "有一样东西肯定不是 rizz：借来的开场白。如果那条迷人的消息是聊天机器人写的，迷人的是机器人，最后要去赴约喝咖啡的还是你。把那句有点笨拙、但属于你的话发出去。它进入真实对话的效果，远好过一句不属于你的完美台词。" },
    ],
  },
  nl: {
    term: "Rizz",
    summary:
      "Charisma in het versieren: het talent om een gesprek te laten aankomen, zodat de ander het fijn vindt om erin te zitten en wil dat het doorgaat.",
    blocks: [
      { type: "h2", text: "Een nieuw woord voor iets ouds" },
      { type: "p", text: "Het is charisma met de uiteinden eraf — de middelste lettergreep, die een woord op zichzelf werd. Het verspreidde zich via streams en korte video rond 2021, en Oxford University Press koos het in 2023 tot woord van het jaar. Wat het beschrijft is helemaal niet nieuw. Met sommige mensen praat je gewoon makkelijk, en na tien minuten loop je vrolijker weg dan je aankwam." },
      { type: "p", text: "Het internet plette het tot openingszinnen: regels om uit je hoofd te leren, screenshots van een slim eerste bericht. Dat is de zwakste vorm. Een zin is na één seconde voorbij, en als hij mist is er geen weg verder. Aandacht werkt de hele avond door. Rizz is vooral **horen wat iemand echt zei en daarop antwoorden**, plus timing: weten wanneer je een grap doorzet en wanneer je een stilte laat staan." },
      { type: "h2", text: "Hoe het er echt uitziet" },
      { type: "ul", items: [
        "Ze pikken het kleine ding op dat je terloops noemde en brengen het een uur later terug.",
        "Er zit ruimte in het gesprek — een stilte mag blijven hangen in plaats van opgevuld te worden.",
        "Het plagen blijft licht en stopt op het moment dat het niet meer aankomt.",
        "De complimenten gaan over jou, niet het soort dat bij iedereen zou werken.",
      ] },
      { type: "h2", accent: "green", text: "Hoe word je er beter in" },
      { type: "p", text: "Stop met zinnen verzamelen. Stel één vraag meer dan natuurlijk voelt over datgene waar de ander van opleefde. Lees je laatste vijf berichten terug en tel hoeveel er over jou gingen. **Antwoord op de interessante helft van wat er is gezegd, niet op de beleefde helft.** Langzamer en concreter wint bijna altijd van gevat. En als je in tekst dichtklapt: dezelfde persoon doet het in een spraakbericht van twee minuten vaak prima." },
      { type: "p", text: "Eén ding is rizz zeker niet: een geleende opening. Als een chatbot dat charmante bericht schreef, is de charme van de chatbot, en jij moet nog steeds op de koffie verschijnen. Stuur de ietwat onhandige zin die van jou is. Die reist veel beter een echt gesprek in dan een perfecte die dat niet is." },
    ],
  },
  pl: {
    term: "Rizz",
    summary:
      "Charyzma w podrywie: umiejętność prowadzenia rozmowy tak, żeby druga osoba dobrze się w niej czuła i chciała, by trwała dalej.",
    blocks: [
      { type: "h2", text: "Nowe słowo na starą rzecz" },
      { type: "p", text: "To angielskie charisma z obciętymi końcami — została środkowa sylaba, która stała się osobnym słowem. Rozeszło się przez transmisje na żywo i krótkie wideo około 2021 roku, a w 2023 wydawnictwo Uniwersytetu Oksfordzkiego uznało je za słowo roku. To, co opisuje, nie jest wcale nowe. Z niektórymi ludźmi rozmawia się po prostu łatwo i po dziesięciu minutach wychodzisz w lepszym humorze, niż wszedłeś." },
      { type: "p", text: "Internet spłaszczył to do tekstów na podryw: kwestii do wykucia, zrzutów ekranu ze sprytną pierwszą wiadomością. To jego najsłabsza wersja. Tekst kończy się po sekundzie i jeśli nie trafi, nie ma dokąd pójść. Uwaga działa przez cały wieczór. Rizz to głównie **usłyszeć, co ktoś naprawdę powiedział, i odpowiedzieć właśnie na to**, plus wyczucie czasu: kiedy pociągnąć żart, a kiedy zostawić ciszę w spokoju." },
      { type: "h2", text: "Jak to naprawdę wygląda" },
      { type: "ul", items: [
        "Wyłapuje drobiazg, który rzuciłeś mimochodem, i wraca do niego godzinę później.",
        "W rozmowie jest miejsce — cisza może zostać, zamiast być zapychana.",
        "Docinki są lekkie i kończą się w sekundzie, w której przestają bawić.",
        "Komplementy są o tobie, a nie z tych, które zadziałałyby na każdego.",
      ] },
      { type: "h2", accent: "green", text: "Jak być w tym lepszym" },
      { type: "p", text: "Przestań zbierać teksty. Zadaj o jedno pytanie więcej, niż wydaje się naturalne, o to, na czym komuś zapaliły się oczy. Przeczytaj swoje ostatnie pięć wiadomości i policz, ile było o tobie. **Odpowiadaj na ciekawą połowę tego, co usłyszałeś, a nie na grzeczną.** Wolniej i konkretniej wygrywa ze sprytnie prawie zawsze. A jeśli w pisaniu się zacinasz, pamiętaj, że ta sama osoba w dwuminutowej wiadomości głosowej zwykle radzi sobie świetnie." },
      { type: "p", text: "Jedno na pewno nie jest rizzem: pożyczone wejście. Jeśli tę czarującą wiadomość napisał chatbot, urok należy do chatbota, a na kawę i tak musisz przyjść ty. Wyślij trochę niezgrabne zdanie, które jest twoje. Do prawdziwej rozmowy przenosi się dużo lepiej niż idealne, które twoje nie jest." },
    ],
  },
  sv: {
    term: "Rizz",
    summary:
      "Karisma i flörtandet: förmågan att få ett samtal att landa, så att den andra trivs i det och vill att det ska fortsätta.",
    blocks: [
      { type: "h2", text: "Ett nytt ord för en gammal sak" },
      { type: "p", text: "Det är engelskans charisma med ändarna avslagna — mittstavelsen, kvar som ett eget ord. Det spreds via strömmar och korta videor runt 2021, och Oxford University Press utsåg det till årets ord 2023. Det som beskrivs är inte nytt alls. Med vissa människor är det bara lätt att prata, och efter tio minuter går man därifrån på bättre humör än man kom." },
      { type: "p", text: "Internet plattade till det till inledningsrepliker: rader att lära sig utantill, skärmdumpar på ett smart första meddelande. Det är den svagaste varianten. En replik är över på en sekund, och missar den finns ingenstans att ta vägen. Uppmärksamhet fungerar hela kvällen. Det mesta av rizz är **att höra vad någon faktiskt sa och svara på just det**, plus känslan för läge: när man driver ett skämt vidare och när man låter en paus vara." },
      { type: "h2", text: "Så ser det ut på riktigt" },
      { type: "ul", items: [
        "De fångar upp den lilla sak du nämnde i förbifarten och tar tillbaka den en timme senare.",
        "Det finns luft i samtalet — en paus får ligga kvar i stället för att fyllas.",
        "Retandet är lätt och slutar i sekunden det slutar landa.",
        "Komplimangerna handlar om dig, inte den sorten som skulle funka på vem som helst.",
      ] },
      { type: "h2", accent: "green", text: "Så blir du bättre på det" },
      { type: "p", text: "Sluta samla repliker. Ställ en fråga mer än vad som känns naturligt om det som fick den andra att tändas. Läs om dina fem senaste meddelanden och räkna hur många som handlade om dig. **Svara på den intressanta halvan av det som sades, inte på den artiga.** Långsammare och mer konkret slår smart nästan varje gång. Och om du låser dig i text: samma person klarar sig ofta utmärkt i ett tvåminuters röstmeddelande." },
      { type: "p", text: "En sak är rizz definitivt inte: en lånad inledning. Skrev en chattbot det charmiga meddelandet tillhör charmen chattboten, och det är ändå du som ska dyka upp på kaffet. Skicka den lite tafatta mening som är din. Den tar sig in i ett riktigt samtal betydligt bättre än en perfekt som inte är det." },
    ],
  },
  hi: {
    term: "रिज़",
    summary:
      "फ़्लर्ट में काम आने वाली कशिश: बातचीत को सही जगह उतारने का हुनर, जिससे सामने वाले को उस बातचीत में रहना अच्छा लगे और वह उसे जारी रखना चाहे।",
    blocks: [
      { type: "h2", text: "पुरानी चीज़ का नया नाम" },
      { type: "p", text: "यह अंग्रेज़ी के charisma के दोनों सिरे काटकर बचा बीच का हिस्सा है, जो अपने आप में एक शब्द बन गया। 2021 के आसपास लाइव स्ट्रीम और छोटे वीडियो से फैला, और 2023 में ऑक्सफ़ोर्ड यूनिवर्सिटी प्रेस ने इसे साल का शब्द चुना। जो चीज़ यह बताता है, वह ज़रा भी नई नहीं। कुछ लोगों से बात करना बस आसान होता है, और उनके साथ दस मिनट बिताकर आप पहले से बेहतर मन के साथ लौटते हैं।" },
      { type: "p", text: "इंटरनेट ने इसे पहली लाइन तक चपटा कर दिया: रटने वाले डायलॉग, किसी चतुर पहले मैसेज के स्क्रीनशॉट। असल में यही इसका सबसे कमज़ोर रूप है। एक लाइन एक सेकंड में ख़त्म हो जाती है, और चूक जाए तो आगे कोई रास्ता नहीं बचता। ध्यान देना पूरी शाम काम करता है। रिज़ का बड़ा हिस्सा है **सामने वाले ने सचमुच जो कहा उसे सुनना और उसी का जवाब देना**, और साथ में समय का अंदाज़ा: मज़ाक को कब आगे बढ़ाना है और चुप्पी को कब रहने देना है।" },
      { type: "h2", text: "असल में यह ऐसा दिखता है" },
      { type: "ul", items: [
        "आपने जो छोटी-सी बात यूँ ही कही थी, वह पकड़ ली जाती है और एक घंटे बाद लौट आती है।",
        "बातचीत में जगह होती है — चुप्पी को भरने के बजाय रहने दिया जाता है।",
        "छेड़ हल्की रहती है और जिस पल असर करना बंद करे, उसी पल रुक जाती है।",
        "तारीफ़ ख़ास आपके लिए होती है, उस किस्म की नहीं जो किसी पर भी चल जाए।",
      ] },
      { type: "h2", accent: "green", text: "इसमें बेहतर कैसे हों" },
      { type: "p", text: "डायलॉग जमा करना बंद कीजिए। जिस बात पर सामने वाले का चेहरा खिला, उसी पर स्वाभाविक लगने से एक सवाल ज़्यादा पूछिए। अपने पिछले पाँच मैसेज दोबारा पढ़िए और गिनिए कि कितने आपके अपने बारे में थे। **जो कहा गया, उसके शिष्ट आधे हिस्से के बजाय दिलचस्प आधे का जवाब दीजिए।** धीमा और ठोस होना, चतुर होने से लगभग हर बार जीतता है। और अगर लिखते समय अटक जाते हैं, तो याद रखिए कि वही इंसान दो मिनट के वॉइस नोट में अक्सर बिल्कुल सहज होता है।" },
      { type: "p", text: "एक चीज़ रिज़ बिल्कुल नहीं है: उधार की पहली लाइन। वह दिलकश मैसेज अगर किसी चैटबॉट ने लिखा है, तो दिलकशी चैटबॉट की हुई, और कॉफ़ी पर पहुँचना फिर भी आपको है। थोड़ी बेढंगी ही सही, अपनी वाली लाइन भेजिए। असली बातचीत तक वह उस बेदाग़ लाइन से कहीं बेहतर पहुँचती है जो आपकी नहीं है।" },
    ],
  },
};
