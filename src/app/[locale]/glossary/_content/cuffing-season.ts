import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Cuffing season — the autumn-to-winter stretch when people pair up for the
 * cold months and drift apart again in spring.
 *
 * LOCALISATION — the whole point of this page. "Cuffing season" is a northern
 * -hemisphere idea built on dark evenings and a cold winter. Several locales do
 * not live in that calendar, and translating the weather literally would be
 * simply false, so those locales say plainly that the term comes from cold
 * northern winters and then describe the local rhythm that actually does the
 * same work:
 *   - pt (Brazil): seasons inverted and no northern winter — the equivalent runs
 *     from the end-of-year holidays to Carnaval, with the southern cold months
 *     of June to August as a second, weaker version.
 *   - es: written for both hemispheres — December holidays across Latin America,
 *     June to August in the Southern Cone, and the northern winter in Spain.
 *   - hi (India): no coupling winter; the equivalent is the wedding season and
 *     the festival gatherings where the questions get asked.
 *   - ar: mild winters, and the rhythm that matches is family gathering season
 *     (Ramadan, Eid, the summer weddings), not the weather.
 *   - zh: the north is genuinely cold, but the driver is Spring Festival —
 *     going home, the matchmaking, the questions — not the temperature.
 * Do not "restore" the weather metaphor in these five locales; it was removed
 * on purpose and putting it back makes the page wrong for its readers.
 * ja/ko keep the winter framing (their winters are cold) but hang it on the
 * local hooks that actually drive it: Christmas as a couples' event and the
 * new-year and holiday visits home.
 *
 * Statistics: none. There is no citable figure for seasonal dating patterns —
 * app-usage spikes get quoted a lot and always trace back to a dating company's
 * own marketing, which cannot be named or cited here. The page therefore
 * describes the pattern without quantifying it, and block 2 states outright
 * that this is a tendency and not a verdict on anyone's relationship.
 *
 * Qulo angle: none. Seasonality has nothing to do with how matching works, and
 * block 7 is used instead for the honest point — the harm is the mismatch of
 * expectations, not the seasonality itself.
 */
export const cuffingSeason: LocalizedGlossaryEntry = {
  en: {
    term: "Cuffing season",
    summary:
      "The stretch from autumn to late winter when people who were happy on their own start looking for someone to spend the cold months with, and drift apart again once the weather turns.",
    blocks: [
      { type: "h2", text: "Where the term comes from" },
      { type: "p", text: "It comes from being cuffed — handcuffed, tied to someone — and it names a pattern people noticed long before there was a word for it. The clocks change, the evenings go dark early, social life moves indoors, and the calendar fills with occasions where arriving alone is its own small event. Wanting company in November is not a character flaw. It is a season with a lot of gravity." },
      { type: "p", text: "The other half of the pattern is spring. Light evenings come back, plans move outside, and a relationship built mostly on weather and convenience runs out of reasons. That is a tendency, not a rule about anybody: plenty of people meet in November and are still together years later. It describes the season, not your relationship." },
      { type: "h2", text: "How you recognise it" },
      { type: "ul", items: [
        "**The interest arrived with the cold.** Someone who was unavailable all summer is suddenly texting every evening.",
        "**Everything happens indoors.** No daylight, no friends, no plans that involve other people.",
        "**Nothing is scheduled past the holidays.** Talk of the future stops at a certain point in the calendar.",
        "**The enthusiasm cools as the weather warms.** Replies get shorter as the evenings get longer.",
      ] },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Ask early and plainly what they are looking for. One sentence does it — you are not conducting an interview, and the answer is far more useful in week two than in month four. Then watch what gets scheduled rather than what gets said: a daytime plan, an introduction to a friend, something booked three weeks out. And do not end something good on a theory about the calendar. Ask instead." },
      { type: "p", text: "There is nothing wrong with wanting company for one winter, as long as both people know that is what it is. Almost all the damage here comes from the mismatch, not the seasonality — one person is choosing a partner while the other is choosing a season. Said out loud in October, that is a workable arrangement. Discovered in March, it is a bad ending." },
    ],
  },

  tr: {
    term: "Cuffing season",
    summary:
      "Sonbaharla birlikte başlayıp kışın sonuna kadar süren dönem: tek başına gayet iyi olan insanlar soğuk aylar için birini arar, hava ısınınca da yollar yeniden ayrılır.",
    blocks: [
      { type: "h2", text: "Terim nereden geliyor" },
      { type: "p", text: "İngilizcede kelepçelenmek anlamına gelen cuff'tan geliyor: birine bağlanmak. Adı konmadan çok önce fark edilmiş bir kalıbı anlatıyor. Günler kısalır, hava erken kararır, sosyal hayat kapalı mekânlara taşınır ve takvim, yalnız gitmenin başlı başına mesele olduğu davetlerle dolar. Kasımda birinin yanında olmasını istemek karakter zaafı değil; ağırlığı olan bir mevsim sadece." },
      { type: "p", text: "Kalıbın diğer yarısı bahar. Akşamlar uzar, planlar dışarı taşar ve büyük ölçüde havaya ve kolaylığa dayanan ilişkinin gerekçeleri biter. Bu bir eğilim, kimse hakkında bir hüküm değil: kasımda tanışıp yıllar sonra hâlâ birlikte olan bir sürü insan var. Anlatılan şey mevsim, senin ilişkin değil." },
      { type: "h2", text: "Nasıl anlarsın" },
      { type: "ul", items: [
        "**İlgi soğuklarla birlikte geldi.** Bütün yaz ortalıkta olmayan biri birden her akşam yazıyor.",
        "**Her şey kapalı mekânda oluyor.** Gündüz yok, arkadaş yok, başka insanların olduğu bir plan yok.",
        "**Yılbaşından ötesine hiçbir şey konmuyor.** Gelecekten söz etmek takvimin belli bir noktasında duruyor.",
        "**Hava ısındıkça heves soğuyor.** Akşamlar uzarken cevaplar kısalıyor.",
      ] },
      { type: "h2", accent: "green", text: "Ne yapmalı" },
      { type: "p", text: "Ne aradığını erkenden ve açıkça sor. Tek cümle yeter; sorgu yapmıyorsun ve bu cevabın ikinci haftadaki değeri, dördüncü aydakinden çok daha yüksek. Sonra söylenene değil, takvime yazılana bak: gündüz bir plan, bir arkadaşla tanıştırma, üç hafta sonrasına alınmış bir bilet. Ve takvim üzerine kurduğun bir teori yüzünden iyi giden bir şeyi bitirme; bitirmek yerine sor." },
      { type: "p", text: "Bir kış boyunca birinin yanında olmasını istemekte yanlış bir şey yok, yeter ki iki taraf da bunun bu olduğunu bilsin. Buradaki zararın neredeyse tamamı mevsimden değil, beklentilerin uyuşmamasından çıkıyor: biri bir partner seçerken diğeri bir mevsim seçiyor. Ekimde açıkça söylenirse yürüyebilir bir anlaşma. Martta fark edilirse kötü bir son." },
    ],
  },

  de: {
    term: "Cuffing Season",
    summary:
      "Die Phase vom Herbst bis zum Spätwinter, in der Menschen, denen allein bislang gut ging, jemanden für die kalten Monate suchen — und sich im Frühjahr wieder aus dem Weg gehen.",
    blocks: [
      { type: "h2", text: "Woher der Begriff kommt" },
      { type: "p", text: "Er kommt vom englischen cuff, Handschelle: an jemanden gebunden sein. Beschrieben wird ein Muster, das Leuten lange vor dem Wort aufgefallen ist. Die Uhr wird umgestellt, es ist früh dunkel, das Leben verlagert sich nach drinnen, und der Kalender füllt sich mit Anlässen, bei denen allein zu erscheinen selbst ein kleines Ereignis ist. Im November Gesellschaft zu wollen, ist kein Charakterfehler, sondern eine Jahreszeit mit viel Schwerkraft." },
      { type: "p", text: "Die andere Hälfte des Musters ist das Frühjahr. Die Abende werden hell, die Pläne wandern nach draußen, und einer Beziehung, die vor allem aus Wetter und Bequemlichkeit bestand, gehen die Gründe aus. Das ist eine Tendenz und kein Urteil über irgendwen: Viele lernen sich im November kennen und sind Jahre später noch zusammen. Beschrieben wird die Jahreszeit, nicht deine Beziehung." },
      { type: "h2", text: "Woran du es erkennst" },
      { type: "ul", items: [
        "**Das Interesse kam mit der Kälte.** Wer den ganzen Sommer nicht erreichbar war, schreibt plötzlich jeden Abend.",
        "**Alles findet drinnen statt.** Kein Tageslicht, keine Freunde, keine Pläne, in denen andere Menschen vorkommen.",
        "**Nach den Feiertagen steht nichts im Kalender.** Zukunftsreden hören an einem bestimmten Datum auf.",
        "**Die Begeisterung kühlt ab, während es wärmer wird.** Die Antworten werden kürzer, je länger die Abende werden.",
      ] },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Frag früh und geradeheraus, was die andere Person sucht. Ein Satz reicht — das ist kein Verhör, und die Antwort nützt dir in Woche zwei weit mehr als in Monat vier. Achte danach eher darauf, was verabredet wird, als darauf, was gesagt wird: ein Plan bei Tageslicht, ein Treffen mit Freunden, etwas, das drei Wochen im Voraus gebucht ist. Und beende nichts Gutes wegen einer Theorie über den Kalender. Frag lieber nach." },
      { type: "p", text: "Es ist völlig in Ordnung, für einen Winter Gesellschaft zu wollen, solange beide wissen, dass es genau das ist. Fast der ganze Schaden entsteht aus dem Missverhältnis, nicht aus der Saison: Die eine Person sucht einen Menschen, die andere eine Jahreszeit. Im Oktober ausgesprochen ist das eine funktionierende Abmachung. Im März entdeckt ist es ein schlechtes Ende." },
    ],
  },

  fr: {
    term: "Cuffing season",
    summary:
      "La période qui va de l'automne à la fin de l'hiver, quand des gens très bien seuls se mettent à chercher quelqu'un pour les mois froids — et s'éloignent de nouveau au retour des beaux jours.",
    blocks: [
      { type: "h2", text: "D'où vient l'expression" },
      { type: "p", text: "Elle vient de l'anglais cuff, la menotte : être attaché à quelqu'un. Elle nomme un phénomène repéré bien avant d'avoir un nom. On change d'heure, la nuit tombe tôt, la vie sociale rentre à l'intérieur et le calendrier se remplit d'occasions où arriver seul devient en soi un petit événement. Vouloir de la compagnie en novembre n'est pas un défaut de caractère : c'est une saison qui a beaucoup de gravité." },
      { type: "p", text: "L'autre moitié du phénomène, c'est le printemps. Les soirées s'éclairent, les projets sortent dehors, et une relation bâtie surtout sur la météo et la commodité n'a plus de raisons. C'est une tendance, pas un verdict sur qui que ce soit : beaucoup de gens se rencontrent en novembre et sont encore ensemble des années plus tard. On décrit la saison, pas votre histoire." },
      { type: "h2", text: "Comment le reconnaître" },
      { type: "ul", items: [
        "**L'intérêt est arrivé avec le froid.** Quelqu'un d'injoignable tout l'été écrit soudain tous les soirs.",
        "**Tout se passe à l'intérieur.** Pas de lumière du jour, pas d'amis, aucun projet impliquant d'autres personnes.",
        "**Rien n'est prévu après les fêtes.** Les projets d'avenir s'arrêtent à une date précise du calendrier.",
        "**L'enthousiasme refroidit quand il fait plus doux.** Les réponses raccourcissent à mesure que les soirées s'allongent.",
      ] },
      { type: "h2", accent: "green", text: "Ce que vous pouvez faire" },
      { type: "p", text: "Demandez tôt et simplement ce que la personne cherche. Une phrase suffit : ce n'est pas un interrogatoire, et la réponse vaut bien plus en deuxième semaine qu'au quatrième mois. Ensuite, regardez ce qui se planifie plutôt que ce qui se dit : un projet en plein jour, une présentation à des amis, une réservation à trois semaines. Et n'arrêtez pas quelque chose de bien à cause d'une théorie sur le calendrier. Posez la question." },
      { type: "p", text: "Vouloir de la compagnie le temps d'un hiver n'a rien de honteux, tant que les deux savent que c'est de cela qu'il s'agit. Presque tout le mal vient du décalage, pas de la saison : l'un choisit une personne, l'autre choisit une période. Dit clairement en octobre, c'est un arrangement viable. Découvert en mars, c'est une mauvaise fin." },
    ],
  },

  es: {
    term: "Cuffing season",
    summary:
      "La temporada en que gente que estaba bien sola busca a alguien para pasar los meses fríos y se separa cuando cambia el tiempo; el término nace de los inviernos del norte, así que en buena parte de América Latina el equivalente son las fiestas de fin de año.",
    blocks: [
      { type: "h2", text: "De dónde viene el término" },
      { type: "p", text: "Viene del inglés cuff, esposar: quedar atado a alguien. Nació en Estados Unidos y el norte de Europa, donde el otoño trae noches largas, la vida social se mete en casa y el calendario se llena de ocasiones en las que llegar solo es en sí mismo un acontecimiento. Buscar compañía cuando anochece a las seis no es un defecto de carácter: es una estación con mucha gravedad." },
      { type: "p", text: "Por eso conviene traducir el calendario, no el clima. En España el patrón encaja tal cual. En gran parte de América Latina no hay invierno que empuje a nadie, y el equivalente es diciembre: Navidad, fin de año, la familia reunida y la pregunta de siempre; en enero cada quien vuelve a lo suyo. En el Cono Sur el frío llega entre junio y agosto y el ciclo simplemente se corre de mes." },
      { type: "h2", text: "Cómo reconocerlo" },
      { type: "ul", items: [
        "**El interés apareció con la temporada.** Alguien ilocalizable durante meses escribe de pronto todas las noches.",
        "**Todo pasa puertas adentro.** Nada de luz del día, nada de amigos, ningún plan con más gente.",
        "**No hay nada agendado después de las fiestas.** Hablar del futuro se detiene en un punto exacto del calendario.",
        "**El entusiasmo baja cuando la temporada termina.** Las respuestas se acortan a medida que pasa la fecha.",
      ] },
      { type: "h2", accent: "green", text: "Qué puedes hacer" },
      { type: "p", text: "Pregunta pronto y sin rodeos qué está buscando. Con una frase basta: no es un interrogatorio, y esa respuesta vale mucho más en la segunda semana que en el cuarto mes. Después fíjate en lo que se agenda más que en lo que se dice: un plan de día, una presentación a sus amigos, algo reservado para dentro de tres semanas. Y no cortes algo que va bien por una teoría sobre el calendario: pregunta." },
      { type: "p", text: "No tiene nada de malo querer compañía durante una temporada, siempre que las dos personas sepan que es eso. Casi todo el daño sale del desajuste, no de la estacionalidad: uno está eligiendo pareja y el otro está eligiendo unos meses. Dicho en voz alta al principio, es un acuerdo que funciona. Descubierto al final, es un mal cierre." },
    ],
  },

  ar: {
    term: "موسم الارتباط المؤقت",
    summary:
      "الفترة التي يبحث فيها من كان مرتاحًا وحده عن رفيق لبضعة أشهر ثم يفترقان بانتهائها. المصطلح الإنجليزي cuffing season وُلد في شتاء الشمال البارد، وما يقابله عربيًا هو مواسم اجتماع العائلة.",
    blocks: [
      { type: "h2", text: "من أين جاء المصطلح" },
      { type: "p", text: "أصله من الكلمة الإنجليزية cuff أي القيد: أن ترتبط بأحدهم. ظهر في الولايات المتحدة وشمال أوروبا، حيث يجلب الخريف ليلًا طويلًا، وتنتقل الحياة الاجتماعية إلى داخل البيوت، ويمتلئ التقويم بمناسبات يصبح فيها الحضور وحيدًا حدثًا بحد ذاته. الرغبة في صحبة أحدهم في تلك الشهور ليست عيبًا في الطباع، بل موسم له جاذبية ثقيلة." },
      { type: "p", text: "لكن الطقس في معظم البلدان العربية لا يصنع هذا الضغط؛ الشتاء قصير ومعتدل، وما يقابله هنا هو موسم اجتماع العائلة لا موسم البرد. رمضان والعيد، الأعراس التي تتكاثف في الصيف والإجازات، والأسئلة التي تأتي مع كل مائدة عن موعد الارتباط. تتصاعد الرغبة في وجود شخص إلى جانبك قبل هذه المواسم، وتهدأ بعد انفضاضها. هذا وصف لميل عام لا حكم على علاقة أحد." },
      { type: "h2", text: "كيف تعرفه" },
      { type: "ul", items: [
        "**الاهتمام جاء مع الموسم.** شخص كان بعيدًا شهورًا صار يراسلك كل مساء فجأة.",
        "**كل شيء يحدث بعيدًا عن الناس.** لا لقاءات نهارية، ولا أصدقاء، ولا خطة يشترك فيها أحد غيركما.",
        "**لا شيء محجوز بعد موسم المناسبات.** الحديث عن المستقبل يتوقف عند نقطة محددة في التقويم.",
        "**يبرد الحماس بانتهاء الموسم.** الردود تقصر بمجرد أن تمر المناسبات.",
      ] },
      { type: "h2", accent: "green", text: "ما الذي يمكن فعله" },
      { type: "p", text: "اسأل مبكرًا وبوضوح عمّا يبحث عنه الطرف الآخر. جملة واحدة تكفي؛ هذا ليس تحقيقًا، وقيمة الإجابة في الأسبوع الثاني أكبر بكثير منها في الشهر الرابع. ثم راقب ما يُحجز في التقويم لا ما يُقال: موعد نهاري، تعارف مع الأصدقاء، خطة بعد ثلاثة أسابيع. ولا تُنهِ علاقة جيدة بناءً على نظرية عن التقويم؛ اسأل بدل أن تفترض." },
      { type: "p", text: "لا عيب في أن يرغب أحدهم برفقة موسم واحد، ما دام الطرفان يعرفان أن هذا هو الاتفاق. الضرر كله تقريبًا يأتي من اختلاف التوقعات لا من الموسمية نفسها: أحدهما يختار شريكًا والآخر يختار بضعة شهور. قيلت هذه الحقيقة في بدايتها فهي ترتيب صريح يمكن العيش معه، واكتُشفت في نهايتها فهي نهاية موجعة." },
    ],
  },

  ru: {
    term: "Каффинг-сезон",
    summary:
      "Отрезок с осени до конца зимы, когда людям, которым прекрасно жилось одним, вдруг нужен кто-то на холодные месяцы, а весной они расходятся снова.",
    blocks: [
      { type: "h2", text: "Откуда взялось название" },
      { type: "p", text: "От английского cuff — наручник, то есть быть к кому-то пристёгнутым. Название появилось недавно, а само явление замечали задолго до него. Темнеет рано, жизнь перебирается в помещения, а календарь заполняется поводами, на которых прийти одному — уже само по себе событие. Хотеть, чтобы рядом кто-то был в ноябре, — не изъян характера, а сезон с большой силой притяжения." },
      { type: "p", text: "Вторая половина этого узора — весна. Вечера светлеют, планы выходят на улицу, и у отношений, державшихся в основном на погоде и удобстве, заканчиваются причины. Это тенденция, а не приговор кому бы то ни было: множество пар знакомятся в ноябре и через годы всё ещё вместе. Речь о сезоне, а не о ваших отношениях." },
      { type: "h2", text: "Как это распознать" },
      { type: "ul", items: [
        "**Интерес пришёл вместе с холодами.** Человек, недоступный всё лето, вдруг пишет каждый вечер.",
        "**Всё происходит дома.** Ни дневного света, ни друзей, ни планов, где есть кто-то ещё.",
        "**После новогодних праздников не запланировано ничего.** Разговоры о будущем упираются в определённую дату.",
        "**Энтузиазм остывает по мере потепления.** Ответы короче ровно настолько, насколько длиннее вечера.",
      ] },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Спросите рано и прямо, что человек ищет. Хватит одной фразы: это не допрос, а на второй неделе такой ответ полезнее, чем на четвёртом месяце. Дальше смотрите не на слова, а на то, что попадает в календарь: дневная встреча, знакомство с друзьями, что-то забронированное на три недели вперёд. И не заканчивайте хорошее из-за теории про календарь — лучше спросите." },
      { type: "p", text: "Нет ничего дурного в желании провести вместе одну зиму, если оба понимают, что договорённость именно такая. Почти весь вред идёт от расхождения ожиданий, а не от сезонности: один выбирает человека, другой выбирает сезон. Сказанное вслух в октябре, это рабочее соглашение. Обнаруженное в марте — плохой финал." },
    ],
  },

  pt: {
    term: "Cuffing season",
    summary:
      "A temporada em que gente que estava bem sozinha procura alguém para atravessar alguns meses e se afasta quando ela acaba. O termo vem dos invernos frios do hemisfério norte; no Brasil, o equivalente vai das festas de fim de ano ao Carnaval.",
    blocks: [
      { type: "h2", text: "De onde vem o termo" },
      { type: "p", text: "Vem do inglês cuff, algema: ficar preso a alguém. Nasceu nos Estados Unidos e no norte da Europa, onde o outono traz noite às quatro da tarde, a vida social se recolhe para dentro de casa e o calendário enche de ocasiões em que chegar sozinho já é um acontecimento. Querer companhia em novembro, ali, não é defeito de caráter: é uma estação com muita gravidade." },
      { type: "p", text: "No Brasil o calendário é outro, e traduzir o frio ao pé da letra não faz sentido. O que corresponde é a corrida do fim de ano: dezembro, ceia, réveillon, a família reunida perguntando por que você veio sozinho — e depois aquela ideia bem conhecida de que namoro de fim de ano dura até o Carnaval, quando tudo se dispersa de novo. No Sul, o frio de junho a agosto faz uma versão mais fraca da mesma coisa." },
      { type: "h2", text: "Como perceber" },
      { type: "ul", items: [
        "**O interesse apareceu junto com a temporada.** Alguém sumido o ano inteiro começa a mandar mensagem toda noite.",
        "**Tudo acontece a portas fechadas.** Nada de programa de dia, de amigos, de plano com outras pessoas.",
        "**Não há nada marcado depois das festas.** Falar de futuro para numa data específica do calendário.",
        "**O entusiasmo esfria quando a temporada passa.** As respostas encurtam assim que o Carnaval se aproxima.",
      ] },
      { type: "h2", accent: "green", text: "O que dá para fazer" },
      { type: "p", text: "Pergunte cedo e sem rodeio o que a pessoa está procurando. Uma frase resolve: não é interrogatório, e essa resposta vale muito mais na segunda semana do que no quarto mês. Depois repare no que entra na agenda, não no que é dito: um programa de dia, uma apresentação aos amigos, algo marcado para daqui a três semanas. E não termine uma coisa boa por causa de uma teoria sobre o calendário — pergunte." },
      { type: "p", text: "Não há nada de errado em querer companhia por uma temporada, desde que os dois saibam que o combinado é esse. Quase todo o estrago vem do desencontro, não da sazonalidade: uma pessoa está escolhendo um par e a outra está escolhendo alguns meses. Dito em voz alta lá no começo, é um acerto que funciona. Descoberto no fim, é um término ruim." },
    ],
  },

  it: {
    term: "Cuffing season",
    summary:
      "Il periodo che va dall'autunno alla fine dell'inverno, quando chi stava benissimo da solo si mette a cercare qualcuno per i mesi freddi e poi, con il bel tempo, si allontana di nuovo.",
    blocks: [
      { type: "h2", text: "Da dove viene l'espressione" },
      { type: "p", text: "Viene dall'inglese cuff, manetta: essere legati a qualcuno. Dà un nome a un fenomeno notato molto prima che una parola esistesse. Si cambia l'ora, fa buio presto, la vita sociale rientra in casa e il calendario si riempie di occasioni in cui presentarsi da soli è già di per sé un evento. Volere compagnia a novembre non è un difetto: è una stagione con parecchia forza di gravità." },
      { type: "p", text: "L'altra metà del fenomeno è la primavera. Le sere si allungano, i programmi tornano all'aperto e una relazione costruita soprattutto sul freddo e sulla comodità resta senza motivi. È una tendenza, non un verdetto su nessuno: tantissime persone si conoscono a novembre e anni dopo stanno ancora insieme. Si sta descrivendo la stagione, non la vostra storia." },
      { type: "h2", text: "Come riconoscerla" },
      { type: "ul", items: [
        "**L'interesse è arrivato con il freddo.** Chi era irreperibile tutta l'estate all'improvviso scrive ogni sera.",
        "**Succede tutto in casa.** Niente luce del giorno, niente amici, nessun programma che coinvolga altre persone.",
        "**Dopo le feste non c'è niente in calendario.** I discorsi sul futuro si fermano a una certa data.",
        "**L'entusiasmo si raffredda mentre fuori si scalda.** Le risposte si accorciano man mano che le sere si allungano.",
      ] },
      { type: "h2", accent: "green", text: "Cosa puoi fare" },
      { type: "p", text: "Chiedi presto e senza giri che cosa sta cercando. Basta una frase: non è un interrogatorio, e quella risposta vale molto di più alla seconda settimana che al quarto mese. Poi guarda che cosa finisce in agenda più di quello che viene detto: un programma di giorno, la presentazione a un amico, qualcosa prenotato fra tre settimane. E non chiudere una cosa che funziona per una teoria sul calendario: chiedi." },
      { type: "p", text: "Non c'è niente di male nel volere compagnia per un inverno, purché entrambi sappiano che l'accordo è quello. Quasi tutto il danno nasce dal disallineamento, non dalla stagionalità: uno sta scegliendo una persona, l'altro sta scegliendo dei mesi. Detto a ottobre, è un patto che regge. Scoperto a marzo, è un finale brutto." },
    ],
  },

  ja: {
    term: "カフィングシーズン",
    summary:
      "秋から冬の終わりにかけて、ひとりで平気だった人が寒い季節を一緒に過ごす相手を探し、春になるとまた離れていく時期のこと。英語の cuffing season から来ています。",
    blocks: [
      { type: "h2", text: "この言葉の出どころ" },
      { type: "p", text: "英語の cuff（手錠）から来ていて、誰かにつながれている状態を指します。言葉ができるずっと前から知られていた流れに名前がついただけです。日が短くなり、暗くなるのが早くなり、人づきあいは屋内に移り、カレンダーはひとりで行くこと自体が一つの出来事になる予定で埋まります。十一月に誰かにそばにいてほしいと思うのは性格の欠点ではなく、引力の強い季節があるというだけの話です。" },
      { type: "p", text: "日本ではこの引力がクリスマスと年末年始に集中します。イルミネーションの予定、帰省先で必ず出る「相手はいるの」という質問、年越しをどう過ごすか。そして春になると、明るい夜が戻り、予定は外に出て、寒さと都合でできていた関係は理由を失います。これはあくまで傾向で、誰かの関係についての判定ではありません。十一月に出会って何年も続く人はいくらでもいます。" },
      { type: "h2", text: "こんなときは" },
      { type: "ul", items: [
        "**寒くなってから急に距離が縮まった。** 夏のあいだ音沙汰がなかった人が、毎晩連絡してくる。",
        "**会うのはいつも屋内。** 昼間の予定もなければ、友人に会わせる気配もない。",
        "**年末年始の先に予定がない。** 将来の話が、カレンダーのある一点で止まる。",
        "**暖かくなるにつれて熱が下がる。** 日が長くなるほど、返信は短くなっていく。",
      ] },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "相手が何を求めているのかを、早い段階でまっすぐ聞いてください。一文で足りますし、尋問ではありません。同じ答えでも、二週目に聞けるかどうかで価値がまるで違います。そのあとは、言われたことより予定に入るものを見ます。昼間の約束、友人への紹介、三週間先の予約。そしてカレンダーについての推測だけで、うまくいっているものを終わらせないでください。終わらせる前に聞けば済みます。" },
      { type: "p", text: "ひと冬のあいだ一緒にいたい、という望み自体は悪いものではありません。二人ともそれが前提だと分かっているなら。ここでの痛みはほとんど、季節性ではなくすれ違いから来ます。片方は相手を選んでいて、もう片方は季節を選んでいる。十月に言葉にしておけば成り立つ約束ですが、三月に気づけば、それはただの後味の悪い終わり方になります。" },
    ],
  },

  ko: {
    term: "커핑 시즌",
    summary:
      "가을부터 늦겨울까지, 혼자서도 잘 지내던 사람들이 추운 몇 달을 함께 보낼 상대를 찾고 봄이 오면 다시 멀어지는 시기를 가리키는 말입니다.",
    blocks: [
      { type: "h2", text: "이 말은 어디서 왔나" },
      { type: "p", text: "영어 cuff, 즉 수갑에서 왔습니다. 누군가에게 묶여 있는 상태라는 뜻이죠. 이름이 붙기 훨씬 전부터 사람들이 알아채고 있던 흐름에 단어가 생긴 것뿐입니다. 해가 짧아지고 저녁이 일찍 어두워지면 모임은 실내로 옮겨 가고, 달력은 혼자 가면 그 자체가 사건이 되는 자리로 채워집니다. 십일월에 곁에 누가 있었으면 하는 마음은 성격의 결함이 아니라, 중력이 센 계절이 있다는 뜻입니다." },
      { type: "p", text: "한국에서는 이 중력이 크리스마스와 연말에 몰립니다. 거리의 불빛, 연말 약속, 그리고 명절에 어김없이 돌아오는 만나는 사람 있느냐는 질문. 그러다 봄이 오면 저녁이 밝아지고 약속은 밖으로 나가며, 추위와 편의로 지탱되던 관계는 이유를 잃습니다. 이건 경향일 뿐 누구의 연애에 대한 판정이 아닙니다. 십일월에 만나 몇 해째 함께인 사람도 아주 많습니다." },
      { type: "h2", text: "이런 신호가 보이면" },
      { type: "ul", items: [
        "**추워지면서 갑자기 가까워졌습니다.** 여름 내내 연락이 없던 사람이 매일 저녁 메시지를 보냅니다.",
        "**만남은 늘 실내입니다.** 낮 약속도, 친구를 소개할 기미도 없습니다.",
        "**연말 이후로는 아무 계획이 없습니다.** 미래 이야기가 달력의 어느 지점에서 멈춥니다.",
        "**날이 풀리면서 열기가 식습니다.** 해가 길어질수록 답장은 짧아집니다.",
      ] },
      { type: "h2", accent: "green", text: "어떻게 하면 좋을까" },
      { type: "p", text: "상대가 무엇을 원하는지 이르게, 그리고 담백하게 물어보세요. 한 문장이면 충분하고 취조도 아닙니다. 같은 대답이라도 둘째 주에 듣는 것과 넉 달 뒤에 듣는 것은 값이 다릅니다. 그다음에는 말보다 일정에 들어가는 것을 보세요. 낮에 잡는 약속, 친구에게 소개하는 자리, 삼 주 뒤로 예약해 둔 무언가. 그리고 달력에 관한 추측만으로 잘 가고 있는 관계를 끝내지는 마세요. 끝내는 대신 물으면 됩니다." },
      { type: "p", text: "한 계절만 함께 있고 싶다는 마음 자체는 잘못이 아닙니다. 두 사람 모두 그게 전제라는 걸 알고 있다면요. 여기서 생기는 상처는 거의 전부 계절이 아니라 어긋난 기대에서 옵니다. 한쪽은 사람을 고르고 있는데 다른 한쪽은 몇 달을 고르고 있는 것이죠. 시월에 소리 내어 말하면 굴러가는 약속이고, 삼월에 알게 되면 뒷맛이 나쁜 결말입니다." },
    ],
  },

  zh: {
    term: "抱团过冬期",
    summary:
      "本来一个人过得挺好的人开始找伴、季节一过又各奔东西的那段时间。英文 cuffing season 说的是北方寒冬，在中国真正起作用的其实是春节前后那一段。",
    blocks: [
      { type: "h2", text: "这个说法从哪儿来" },
      { type: "p", text: "英文里 cuff 是手铐，意思是被拴在某个人身边。它出自美国和北欧：入秋以后天黑得早，社交活动全都挪进室内，日历上排满了一个人出席就显得突兀的场合。在那样的地方，十一月想身边有个人，不是性格有问题，只是那个季节的引力太大。" },
      { type: "p", text: "在中国，北方冬天确实冷，但真正把人往一起推的是春节。回家过年、亲戚追问、被安排的相亲、朋友圈里成双成对的年夜饭，压力从腊月开始积累。过完节，各自回到自己的城市，靠年节和便利撑起来的关系就没了理由。这是一种普遍倾向，不是对谁的感情下判断——年前认识、多年以后还在一起的人也很多。" },
      { type: "h2", text: "怎么看出来" },
      { type: "ul", items: [
        "**热情是跟着节点一起来的。** 大半年没消息的人，忽然每天晚上都发消息。",
        "**见面永远关起门来。** 没有白天的安排，没有朋友，没有第三个人在场的计划。",
        "**过完年之后什么都没约。** 关于将来的话，说到日历上某一天就停住了。",
        "**节一过热度就降。** 越往后回复越短，最后不了了之。",
      ] },
      { type: "h2", accent: "green", text: "可以怎么处理" },
      { type: "p", text: "早一点、直接一点问对方在找什么。一句话就够，这不是审问；同样一个答案，第二周听到和第四个月听到，价值完全不同。之后看进日历的事情，而不是嘴上说的话：白天的约会、把你介绍给朋友、三周之后的票。也别因为一套关于日历的推测，就把本来不错的关系掐掉——问一句比猜半年划算。" },
      { type: "p", text: "只想有人陪着过一个节庆季，本身没什么不对，前提是两个人都清楚这就是约定。这里的伤害几乎全来自错位，而不是季节本身：一个人在挑伴侣，另一个人在挑一段时间。年前就说清楚，那是个能过日子的安排；节后才发现，就只是个难看的收场。" },
    ],
  },

  nl: {
    term: "Cuffing season",
    summary:
      "De periode van het najaar tot laat in de winter waarin mensen die prima alleen waren iemand zoeken voor de koude maanden, en in het voorjaar weer uit elkaar drijven.",
    blocks: [
      { type: "h2", text: "Waar de term vandaan komt" },
      { type: "p", text: "Hij komt van het Engelse cuff, handboei: aan iemand vastzitten. De term is nieuw, het patroon niet. De klok gaat terug, het wordt vroeg donker, het sociale leven verplaatst zich naar binnen en de agenda vult zich met gelegenheden waarbij alleen aankomen op zichzelf al iets betekent. In november gezelschap willen is geen karakterfout, maar een seizoen met veel zwaartekracht." },
      { type: "p", text: "De andere helft van het patroon is het voorjaar. De avonden worden licht, plannen gaan weer naar buiten en een relatie die vooral op weer en gemak was gebouwd raakt door haar redenen heen. Dat is een tendens en geen oordeel over wie dan ook: heel veel mensen ontmoeten elkaar in november en zijn jaren later nog samen. Het beschrijft het seizoen, niet jouw relatie." },
      { type: "h2", text: "Hoe je het herkent" },
      { type: "ul", items: [
        "**De belangstelling kwam met de kou.** Iemand die de hele zomer onbereikbaar was, appt ineens elke avond.",
        "**Alles gebeurt binnen.** Geen daglicht, geen vrienden, geen plannen waar andere mensen bij zijn.",
        "**Na de feestdagen staat er niets.** Praten over later houdt op bij een bepaalde datum.",
        "**Het enthousiasme koelt af terwijl het warmer wordt.** De antwoorden worden korter naarmate de avonden langer worden.",
      ] },
      { type: "h2", accent: "green", text: "Wat je kunt doen" },
      { type: "p", text: "Vraag vroeg en gewoon rechtstreeks wat iemand zoekt. Eén zin volstaat: dit is geen verhoor, en dat antwoord is in week twee veel meer waard dan in maand vier. Kijk daarna naar wat er in de agenda komt in plaats van naar wat er gezegd wordt: een plan overdag, een kennismaking met vrienden, iets dat over drie weken geboekt staat. En stop niet met iets goeds vanwege een theorie over de kalender. Vraag het gewoon." },
      { type: "p", text: "Er is niets mis met gezelschap willen voor één winter, zolang beiden weten dat dat de afspraak is. Bijna alle schade komt uit het verschil in verwachting, niet uit het seizoen: de een kiest een partner, de ander kiest een paar maanden. In oktober hardop gezegd is dat een werkbare afspraak. In maart ontdekt is het een naar einde." },
    ],
  },

  pl: {
    term: "Cuffing season",
    summary:
      "Okres od jesieni do późnej zimy, kiedy ludzie, którym było dobrze samym, zaczynają szukać kogoś na zimne miesiące, a wiosną znowu się od siebie oddalają.",
    blocks: [
      { type: "h2", text: "Skąd wzięło się to określenie" },
      { type: "p", text: "Pochodzi od angielskiego cuff, czyli kajdanek: być do kogoś przypiętym. Nazwa jest nowa, samo zjawisko znacznie starsze. Zmienia się czas, ciemno robi się wcześnie, życie towarzyskie przenosi się do środka, a kalendarz zapełnia się okazjami, na których przyjście samemu jest już wydarzeniem. Chcieć w listopadzie mieć kogoś obok to nie wada charakteru, tylko pora roku o dużej sile ciążenia." },
      { type: "p", text: "Druga połowa tego wzoru to wiosna. Wieczory się rozjaśniają, plany wychodzą na zewnątrz, a związkowi zbudowanemu głównie na pogodzie i wygodzie kończą się powody. To tendencja, a nie wyrok na kimkolwiek: mnóstwo osób poznaje się w listopadzie i po latach nadal jest razem. Opisujemy porę roku, nie twój związek." },
      { type: "h2", text: "Po czym to poznasz" },
      { type: "ul", items: [
        "**Zainteresowanie pojawiło się razem z chłodem.** Ktoś nieuchwytny przez całe lato nagle pisze co wieczór.",
        "**Wszystko dzieje się w czterech ścianach.** Żadnego dnia, żadnych znajomych, żadnych planów z innymi ludźmi.",
        "**Po świętach nie ma nic w kalendarzu.** Rozmowy o przyszłości urywają się na konkretnej dacie.",
        "**Zapał stygnie, kiedy się ociepla.** Odpowiedzi robią się krótsze, im dłuższe stają się wieczory.",
      ] },
      { type: "h2", accent: "green", text: "Co można z tym zrobić" },
      { type: "p", text: "Zapytaj wcześnie i wprost, czego ta osoba szuka. Wystarczy jedno zdanie: to nie przesłuchanie, a ta sama odpowiedź w drugim tygodniu jest warta znacznie więcej niż w czwartym miesiącu. Potem patrz na to, co trafia do kalendarza, a nie na to, co zostaje powiedziane: plan za dnia, poznanie znajomych, coś zarezerwowanego za trzy tygodnie. I nie kończ czegoś dobrego przez teorię o kalendarzu — po prostu zapytaj." },
      { type: "p", text: "Nie ma nic złego w chęci przetrwania jednej zimy z kimś, dopóki oboje wiedzą, że taka jest umowa. Prawie cała szkoda bierze się z rozjazdu oczekiwań, a nie z sezonowości: jedna osoba wybiera partnera, druga wybiera kilka miesięcy. Powiedziane głośno w październiku, jest to układ, który działa. Odkryte w marcu, jest to zły koniec." },
    ],
  },

  sv: {
    term: "Cuffing season",
    summary:
      "Sträckan från höst till sen vinter då människor som mått bra själva börjar söka någon att ta sig igenom de mörka månaderna med, och glider isär igen när ljuset kommer tillbaka.",
    blocks: [
      { type: "h2", text: "Varifrån uttrycket kommer" },
      { type: "p", text: "Det kommer från engelskans cuff, handfängsel: att sitta fast i någon. Ordet är nytt, mönstret är det inte. Klockan ställs om, mörkret faller vid fyra, umgänget flyttar inomhus och kalendern fylls med tillfällen där det i sig är en händelse att komma ensam. Att vilja ha sällskap i november är ingen karaktärsbrist utan en årstid med ovanligt stark dragningskraft." },
      { type: "p", text: "Den andra halvan av mönstret är våren. Kvällarna ljusnar, planerna flyttar ut och ett förhållande som mest byggde på mörker och bekvämlighet får slut på skäl. Det är en tendens, inte en dom över någon: massor av människor träffas i november och är tillsammans flera år senare. Det beskriver årstiden, inte ditt förhållande." },
      { type: "h2", text: "Så känner du igen det" },
      { type: "ul", items: [
        "**Intresset kom med kylan.** Någon som var oanträffbar hela sommaren skriver plötsligt varje kväll.",
        "**Allt sker inomhus.** Inget dagsljus, inga vänner, inga planer där andra människor ingår.",
        "**Efter helgerna står ingenting i kalendern.** Pratet om framtiden tar slut vid ett visst datum.",
        "**Entusiasmen svalnar när det blir varmare.** Svaren blir kortare i takt med att kvällarna blir ljusare.",
      ] },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Fråga tidigt och rakt vad personen är ute efter. En mening räcker: det är inget förhör, och svaret är långt mer värt i vecka två än i månad fyra. Titta sedan på vad som hamnar i kalendern snarare än på vad som sägs: en plan på dagtid, ett möte med vänner, något bokat tre veckor fram. Och avsluta inte något bra på grund av en teori om kalendern — fråga i stället." },
      { type: "p", text: "Det är inget fel med att vilja ha sällskap genom en vinter, så länge båda vet att det är det överenskommelsen handlar om. Nästan all skada kommer ur att förväntningarna går isär, inte ur årstiden: den ena väljer en partner, den andra väljer några månader. Sagt högt i oktober är det en fungerande uppgörelse. Upptäckt i mars är det ett dåligt slut." },
    ],
  },

  hi: {
    term: "कफ़िंग सीज़न",
    summary:
      "वह मौसम जब अकेले ठीक-ठाक चल रहे लोग कुछ महीनों के लिए साथी ढूँढ़ने लगते हैं और मौसम बदलते ही अलग हो जाते हैं। अंग्रेज़ी शब्द उत्तरी सर्दियों से आया है; भारत में यही काम शादी-ब्याह का सीज़न करता है।",
    blocks: [
      { type: "h2", text: "यह शब्द आया कहाँ से" },
      { type: "p", text: "अंग्रेज़ी के cuff यानी हथकड़ी से — किसी के साथ बँध जाना। यह अमेरिका और उत्तरी यूरोप की देन है, जहाँ पतझड़ के बाद शाम चार बजे ही अँधेरा हो जाता है, मेल-मिलाप घरों के भीतर सिमट आता है और कैलेंडर ऐसे मौक़ों से भर जाता है जहाँ अकेले पहुँचना अपने आप में एक ख़बर बन जाता है। वहाँ नवंबर में किसी का साथ चाहना कोई कमज़ोरी नहीं, बस एक भारी खिंचाव वाला मौसम है।" },
      { type: "p", text: "भारत में सर्दी इस तरह किसी को जोड़े नहीं बनवाती, इसलिए मौसम का सीधा अनुवाद यहाँ बेमानी है। जो चीज़ यही काम करती है वह है शादियों का सीज़न और उससे जुड़े त्योहार — नवंबर से फ़रवरी और फिर गर्मियों की लगन, दिवाली और शादियों की भीड़, रिश्तेदारों की वही रटी-रटाई पूछताछ। जैसे-जैसे ये तारीख़ें पास आती हैं, साथी की तलाश तेज़ होती है; सीज़न निकल जाने पर वही रिश्ते ढीले पड़ जाते हैं। यह एक आम रुझान है, किसी के रिश्ते पर फ़ैसला नहीं।" },
      { type: "h2", text: "कैसे पहचानें" },
      { type: "ul", items: [
        "**दिलचस्पी सीज़न के साथ आई।** महीनों ग़ायब रहा इंसान अचानक हर शाम मैसेज करने लगे।",
        "**सब कुछ बंद दरवाज़ों के पीछे।** न दिन में कोई प्लान, न दोस्तों से मिलवाना, न किसी तीसरे की मौजूदगी।",
        "**सीज़न के बाद कुछ तय नहीं।** आगे की बातें कैलेंडर की एक तारीख़ पर आकर रुक जाती हैं।",
        "**मौसम निकलते ही जोश ठंडा।** जैसे-जैसे शादियों का दौर बीतता है, जवाब छोटे होते जाते हैं।",
      ] },
      { type: "h2", accent: "green", text: "इसका क्या करें" },
      { type: "p", text: "शुरू में ही सीधे-सीधे पूछ लीजिए कि सामने वाला क्या ढूँढ़ रहा है। एक वाक्य काफ़ी है; यह पूछताछ नहीं है, और वही जवाब दूसरे हफ़्ते में जितने काम का है, चौथे महीने में उतना नहीं रहता। उसके बाद कही गई बातों से ज़्यादा इस पर ध्यान दीजिए कि कैलेंडर में क्या दर्ज हो रहा है: दिन का कोई प्लान, दोस्तों से मिलवाना, तीन हफ़्ते बाद की कोई बुकिंग। और कैलेंडर की किसी थ्योरी के भरोसे अच्छी चल रही बात को ख़त्म मत कीजिए — पूछ लेना सस्ता पड़ता है।" },
      { type: "p", text: "कुछ महीनों का साथ चाहने में कोई बुराई नहीं, बशर्ते दोनों को पता हो कि तय यही हुआ है। यहाँ की लगभग सारी तकलीफ़ मौसम से नहीं, उम्मीदों के फ़र्क़ से आती है: एक इंसान जीवनसाथी चुन रहा होता है और दूसरा कुछ महीने। शुरू में साफ़ कह दिया जाए तो यह चल जाने वाली बात है; आख़िर में पता चले तो बस एक बुरा अंत।" },
    ],
  },
};
