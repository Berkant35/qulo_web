import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Future faking — big, concrete promises about a shared future, made to
 * fast-track closeness, with nothing behind them.
 *
 * Judgement calls made here, so a later editor does not undo them by accident:
 *
 * - THE TELL IS THE SPINE: promises that are vivid but never acquire a date, a
 *   booking or a cost, and that have evaporated when you reference them weeks
 *   later. Blocks 4 and 6 are both built on it. Keep it if you cut anything.
 * - THE LOVE-BOMBING BOUNDARY is block 2 and is worded to stay distinct from
 *   the love-bombing page, which draws the same line in its own words. The
 *   difference is tense: love bombing floods the present, future faking
 *   mortgages a future that has not been earned. The two often co-occur, and
 *   the entry says so rather than pretending they are alternatives.
 * - NO INTENT CLAIM. Block 1 says explicitly that it is more often someone
 *   meaning it in the moment and never thinking past the feeling than it is
 *   calculation, and block 7 keeps that door open: this measures reliability,
 *   not honesty. That distinction is the whole reason the entry can describe
 *   the behaviour without diagnosing the person. Do not sharpen it into an
 *   accusation.
 * - NO STATISTICS. Nothing quantitative is claimed. The one sourced figure
 *   available (Forbes Health / OnePoll 2024, dating-app burnout) is about a
 *   different subject and is not stretched to fit here.
 * - NO QULO ANGLE. Block 7 is practical, not a pitch: judge by the record of
 *   what actually got done. Nothing about writing quiz questions surfaces an
 *   empty promise, so there is no honest product link to make, and the slug
 *   page already renders a Qulo CTA under the body.
 *
 * Term names: the English loanword across the Latin-script locales, which is
 * what speakers there say. Native or transliterated elsewhere: ar وعود المستقبل
 * الزائفة, ru Фьючер-фейкинг, ja フューチャーフェイキング, ko 퓨처 페이킹,
 * hi फ़्यूचर फेकिंग. zh uses 画大饼 — the everyday Chinese idiom for exactly
 * this, promising a painted pancake nobody ever gets to eat — with the English
 * named in the summary since both circulate.
 */
export const futureFaking: LocalizedGlossaryEntry = {
  en: {
    term: "Future faking",
    summary:
      "Big, vivid promises about a shared future — a trip, moving in together, meeting the family — used to fast-track closeness, with nothing behind them and no date ever attached.",
    blocks: [
      { type: "h2", text: "Why a promise moves faster than a plan" },
      { type: "p", text: "People commit to imagined futures. Being written into someone's next year is about the strongest signal of seriousness we have, and unlike an actual plan it costs the speaker nothing to say. That is why it can be handed out so early. Sometimes it is calculated. More often the person means every word in the moment and simply never thinks past the feeling — which is not a kinder outcome for whoever is waiting." },
      { type: "p", text: "It travels with love bombing and is often mistaken for it. **The difference is the tense.** Love bombing floods the present with attention that is happening right now. Future faking mortgages a future nobody has earned yet: you spend real time, real choices and sometimes real money against the promise, and the bill only arrives when the date never comes." },
      { type: "h2", text: "How to recognise it" },
      {
        type: "ul",
        items: [
          "The plans are rich in detail and never acquire a date, a booking or a cost.",
          "You mention one weeks later and it has evaporated: no memory of it, no follow-up, sometimes mild irritation that you asked.",
          "The promises get bigger right after friction — an argument, or the moment you start pulling back.",
          "Anything that would mean doing something this week sits in a vague later: in the spring, once work calms down.",
        ],
      },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Make one promise smaller and nearer. Not the trip to the coast — a Saturday, this month, actually booked. Say it lightly: let's put a date on it. What happens next is the whole answer, and you get it without ever having to argue about what somebody meant. In the meantime, decide by what has happened rather than what has been described. Don't turn things down, move money or rearrange your year around a plan with no date on it." },
      { type: "p", text: "Plenty of people say these things, mean them completely, and then do not do them. That is still worth knowing when nobody was lying: it tells you about reliability rather than honesty, and you live with the reliability either way. The record of what actually got done is the part you can count on, and it spares you the argument about intent." },
    ],
  },
  tr: {
    term: "Future faking",
    summary:
      "Bir tatil, birlikte taşınmak, aileyle tanışmak gibi büyük ve capcanlı vaatlerle yakınlığı hızlandırmak; arkasında hiçbir niyet olmayan ve hiçbir zaman tarihi konmayan sözler.",
    blocks: [
      { type: "h2", text: "Bir vaat neden bir plandan hızlı yol alır?" },
      { type: "p", text: "İnsan hayal edilen geleceklere bağlanır. Birinin gelecek yılının içine yazılmak, elimizdeki en güçlü ciddiyet sinyallerinden biridir ve gerçek bir planın aksine söyleyene hiçbir şeye mal olmaz. Bu yüzden bu kadar erken dağıtılabilir. Bazen hesaplıdır. Ama çoğu zaman kişi o an her kelimesine inanır ve duygunun ötesini hiç düşünmez — ki bu, bekleyen taraf için daha iyi bir sonuç değildir." },
      { type: "p", text: "Çoğu zaman sevgi bombardımanıyla birlikte gelir ve onunla karıştırılır. **Fark, zaman kipinde.** Sevgi bombardımanı bugünü, şu anda olup biten ilgiyle doldurur. Future faking ise henüz hak edilmemiş bir geleceği ipotek eder: gerçek zamanınızı, gerçek tercihlerinizi, bazen gerçek paranızı o vaadin karşılığında harcarsınız ve fatura, tarih hiç gelmediğinde çıkar." },
      { type: "h2", text: "Nasıl anlaşılır?" },
      {
        type: "ul",
        items: [
          "Planlar ayrıntı bakımından zengindir ama hiçbir zaman tarih, rezervasyon ya da bütçe kazanmaz.",
          "Haftalar sonra açtığınızda buharlaşmıştır: ne hatırlanır, ne devamı gelir, bazen sorduğunuz için hafif bir sitem gelir.",
          "Vaatler, sürtüşmenin hemen ardından büyür: bir tartışmadan sonra ya da siz geri çekilmeye başladığınız anda.",
          "Bu hafta bir şey yapmayı gerektiren ne varsa belirsiz bir sonraya kayar: baharda, bu yoğunluk geçince.",
        ],
      },
      { type: "h2", accent: "green", text: "Ne yapabilirsiniz?" },
      { type: "p", text: "Vaatlerden birini küçültüp yakınlaştırın. Sahildeki tatil değil: bu ay, bir cumartesi, gerçekten ayarlanmış hâliyle. Hafifçe söyleyin: hadi buna bir tarih koyalım. Bundan sonra olan şey cevabın tamamıdır ve bunu, kimsenin neyi kastettiğini tartışmadan öğrenirsiniz. O zamana kadar anlatılana göre değil, olana göre karar verin. Tarihi olmayan bir plan için başka şeyleri geri çevirmeyin, para taşımayın, yılınızı yeniden dizmeyin." },
      { type: "p", text: "Çok sayıda insan bunları söyler, söylerken de tamamen inanır ve sonra yapmaz. Kimse yalan söylememiş olsa bile bunu bilmek işinize yarar: bu size dürüstlük hakkında değil, güvenilirlik hakkında bilgi verir; ve nasıl olsa birlikte yaşayacağınız şey güvenilirliktir. Gerçekten yapılmış olanların kaydı güvenebileceğiniz kısımdır ve sizi niyet tartışmasından kurtarır." },
    ],
  },
  de: {
    term: "Future Faking",
    summary:
      "Große, sehr konkrete Versprechen über eine gemeinsame Zukunft — eine Reise, zusammenziehen, die Familie kennenlernen — mit denen Nähe beschleunigt wird, ohne dass etwas dahintersteckt und ohne dass je ein Datum dazukommt.",
    blocks: [
      { type: "h2", text: "Warum ein Versprechen schneller wirkt als ein Plan" },
      { type: "p", text: "Menschen binden sich an vorgestellte Zukünfte. In das nächste Jahr von jemandem hineingeschrieben zu werden, ist ungefähr das stärkste Ernsthaftigkeitssignal, das wir haben — und anders als ein echter Plan kostet es die sprechende Person nichts. Deshalb kann es so früh verteilt werden. Manchmal ist es Kalkül. Häufiger meint jemand im Moment jedes Wort und denkt einfach nie über das Gefühl hinaus. Für die wartende Person ist das kein besseres Ergebnis." },
      { type: "p", text: "Es tritt oft gemeinsam mit Lovebombing auf und wird damit verwechselt. **Der Unterschied liegt in der Zeitform.** Lovebombing flutet die Gegenwart mit Aufmerksamkeit, die gerade jetzt stattfindet. Future Faking verpfändet eine Zukunft, die noch niemand verdient hat: Du gibst echte Zeit, echte Entscheidungen und manchmal echtes Geld gegen das Versprechen aus, und die Rechnung kommt erst, wenn das Datum ausbleibt." },
      { type: "h2", text: "Woran du es erkennst" },
      {
        type: "ul",
        items: [
          "Die Pläne sind reich an Details und bekommen nie ein Datum, eine Buchung oder einen Preis.",
          "Du sprichst sie Wochen später an, und sie sind verdunstet: keine Erinnerung, kein Anschluss, manchmal leichte Gereiztheit über die Frage.",
          "Die Versprechen werden größer, sobald es knirscht — nach einem Streit oder in dem Moment, in dem du dich zurückziehst.",
          "Alles, wofür man diese Woche etwas tun müsste, liegt in einem vagen Später: im Frühling, wenn der Stress vorbei ist.",
        ],
      },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Mach ein Versprechen kleiner und näher. Nicht die Reise ans Meer — ein Samstag, diesen Monat, tatsächlich gebucht. Sag es leicht: Lass uns ein Datum dafür festhalten. Was danach passiert, ist die ganze Antwort, und du bekommst sie, ohne je darüber streiten zu müssen, wie etwas gemeint war. Bis dahin entscheide nach dem, was passiert ist, nicht nach dem, was beschrieben wurde. Sag nichts ab, verschiebe kein Geld und räum dein Jahr nicht um für einen Plan ohne Datum." },
      { type: "p", text: "Viele Menschen sagen so etwas, meinen es vollkommen ernst und tun es dann nicht. Auch wenn niemand gelogen hat, ist das wissenswert: Es sagt etwas über Verlässlichkeit, nicht über Ehrlichkeit — und mit der Verlässlichkeit lebst du so oder so. Worauf du dich stützen kannst, ist die Liste dessen, was tatsächlich passiert ist. Sie erspart dir die Debatte über Absichten." },
    ],
  },
  fr: {
    term: "Future faking",
    summary:
      "De grandes promesses très concrètes sur un avenir commun — un voyage, emménager ensemble, rencontrer la famille — utilisées pour accélérer l'intimité, sans rien derrière et sans qu'aucune date n'y soit jamais accolée.",
    blocks: [
      { type: "h2", text: "Pourquoi une promesse va plus vite qu'un projet" },
      { type: "p", text: "On s'attache à des avenirs imaginés. Être inscrit dans l'année prochaine de quelqu'un est à peu près le signal de sérieux le plus fort dont nous disposions, et contrairement à un vrai projet, cela ne coûte rien à celui qui le dit. C'est pourquoi cela peut être distribué si tôt. Parfois c'est calculé. Plus souvent, la personne pense chaque mot sur le moment et ne réfléchit jamais au-delà de l'émotion, ce qui n'est pas un meilleur sort pour celui qui attend." },
      { type: "p", text: "Cela accompagne souvent le love bombing et on les confond. **La différence tient au temps du verbe.** Le love bombing inonde le présent d'une attention qui a lieu maintenant. Le future faking hypothèque un avenir que personne n'a encore mérité : vous dépensez du temps réel, des choix réels et parfois de l'argent réel en échange de la promesse, et la facture n'arrive que le jour où la date, elle, n'arrive pas." },
      { type: "h2", text: "Comment le reconnaître" },
      {
        type: "ul",
        items: [
          "Les projets sont riches en détails et n'obtiennent jamais de date, de réservation ni de budget.",
          "Vous en reparlez des semaines plus tard et tout s'est évaporé : aucun souvenir, aucune suite, parfois un léger agacement que vous ayez demandé.",
          "Les promesses grandissent juste après une friction : une dispute, ou le moment où vous commencez à prendre du recul.",
          "Tout ce qui demanderait d'agir cette semaine est renvoyé à un plus tard flou : au printemps, quand le travail se calmera.",
        ],
      },
      { type: "h2", accent: "green", text: "Que faire" },
      { type: "p", text: "Rendez une promesse plus petite et plus proche. Pas le voyage au bord de la mer : un samedi, ce mois-ci, réellement réservé. Dites-le légèrement : mettons une date dessus. Ce qui suit constitue toute la réponse, et vous l'obtenez sans jamais avoir à débattre de ce que quelqu'un voulait dire. En attendant, décidez d'après ce qui s'est produit, pas d'après ce qui a été décrit. Ne refusez rien, ne déplacez pas d'argent et ne réorganisez pas votre année autour d'un projet sans date." },
      { type: "p", text: "Beaucoup de gens disent ces choses, les pensent entièrement, puis ne les font pas. Cela reste utile à savoir même si personne n'a menti : cela vous renseigne sur la fiabilité plutôt que sur la sincérité, et c'est avec la fiabilité que vous vivrez de toute façon. Ce sur quoi vous pouvez compter, c'est la liste de ce qui a réellement eu lieu. Elle vous épargne la discussion sur les intentions." },
    ],
  },
  es: {
    term: "Future faking",
    summary:
      "Promesas grandes y muy detalladas sobre un futuro en común — un viaje, irse a vivir juntos, conocer a la familia — usadas para acelerar la intimidad, sin nada detrás y sin que nunca se les ponga fecha.",
    blocks: [
      { type: "h2", text: "Por qué una promesa avanza más rápido que un plan" },
      { type: "p", text: "Las personas se comprometen con futuros imaginados. Aparecer escrito en el año que viene de alguien es más o menos la señal de seriedad más fuerte que tenemos y, a diferencia de un plan de verdad, a quien lo dice no le cuesta nada. Por eso puede repartirse tan pronto. A veces hay cálculo. Más a menudo la persona cree cada palabra en ese momento y sencillamente no piensa más allá de la emoción, que no es un desenlace mejor para quien espera." },
      { type: "p", text: "Suele venir junto al bombardeo de amor y se confunde con él. **La diferencia está en el tiempo verbal.** El bombardeo de amor inunda el presente con atención que está ocurriendo ahora mismo. El future faking hipoteca un futuro que nadie se ha ganado todavía: gastas tiempo real, decisiones reales y a veces dinero real a cuenta de la promesa, y la factura solo llega cuando la fecha no llega nunca." },
      { type: "h2", text: "Cómo reconocerlo" },
      {
        type: "ul",
        items: [
          "Los planes están llenos de detalles y nunca consiguen una fecha, una reserva ni un precio.",
          "Lo mencionas semanas después y se ha evaporado: ni recuerdo, ni continuación, a veces un poco de fastidio porque preguntaste.",
          "Las promesas se agrandan justo después de un roce: una discusión, o el momento en que empiezas a apartarte.",
          "Todo lo que exigiría hacer algo esta semana queda en un más adelante difuso: en primavera, cuando baje el trabajo.",
        ],
      },
      { type: "h2", accent: "green", text: "Qué puedes hacer" },
      { type: "p", text: "Haz que una promesa sea más pequeña y más cercana. No el viaje a la costa: un sábado, este mes, reservado de verdad. Dilo con ligereza: pongámosle fecha. Lo que ocurra después es toda la respuesta, y la consigues sin tener que discutir nunca sobre qué quiso decir alguien. Mientras tanto, decide por lo que ha pasado y no por lo que te han contado. No rechaces cosas, no muevas dinero ni recoloques tu año alrededor de un plan sin fecha." },
      { type: "p", text: "Mucha gente dice estas cosas, las siente por completo y luego no las hace. Aunque nadie haya mentido, conviene saberlo: te habla de fiabilidad más que de sinceridad, y con la fiabilidad vas a convivir igualmente. Lo que sí puedes usar es el registro de lo que de verdad ocurrió, y te ahorra la discusión sobre las intenciones." },
    ],
  },
  ar: {
    term: "وعود المستقبل الزائفة",
    summary:
      "وعود كبيرة وحيّة عن مستقبل مشترك — سفرة، سكن مشترك، التعرّف إلى العائلة — تُستخدم لتسريع القرب، من دون نيّة خلفها ومن دون أن يُحدَّد لها موعد أبدًا.",
    blocks: [
      { type: "h2", text: "لماذا يمضي الوعد أسرع من الخطة" },
      { type: "p", text: "نحن نلتزم بمستقبلات متخيَّلة. أن يكتبك أحدهم داخل عامه المقبل هو تقريبًا أقوى إشارة جدّية نملكها، وعلى عكس الخطة الحقيقية لا يكلّف قائلها شيئًا. لذلك يمكن توزيعه مبكرًا جدًا. أحيانًا يكون الأمر محسوبًا. والأكثر شيوعًا أن الشخص يعني كل كلمة في تلك اللحظة، ثم لا يفكّر أبعد من الشعور نفسه — وهذه ليست نتيجة ألطف لمن ينتظر." },
      { type: "p", text: "غالبًا ما يأتي مع قصف الحب ويُخلَط به. **الفرق في الزمن.** قصف الحب يغرق الحاضر باهتمام يحدث الآن. أمّا هذا فيرهن مستقبلًا لم يستحقّه أحد بعد: تنفق وقتًا حقيقيًا وخيارات حقيقية وأحيانًا مالًا حقيقيًا مقابل الوعد، ولا تصل الفاتورة إلا حين لا يأتي الموعد أبدًا." },
      { type: "h2", text: "كيف تتعرّف عليه" },
      {
        type: "ul",
        items: [
          "الخطط غنية بالتفاصيل، ولا تحصل أبدًا على تاريخ أو حجز أو تكلفة.",
          "تذكّر بها بعد أسابيع فتجدها تبخّرت: لا ذاكرة لها ولا متابعة، وأحيانًا انزعاج خفيف لأنك سألت.",
          "تكبر الوعود مباشرة بعد أي احتكاك: بعد خلاف، أو في اللحظة التي تبدأ فيها بالانسحاب.",
          "كل ما يتطلّب فعل شيء هذا الأسبوع يُرحَّل إلى «لاحقًا» غامض: في الربيع، بعد أن يهدأ العمل.",
        ],
      },
      { type: "h2", accent: "green", text: "ماذا يمكنك أن تفعل" },
      { type: "p", text: "اجعل وعدًا واحدًا أصغر وأقرب. لا رحلة الساحل، بل يوم سبت في هذا الشهر، محجوز فعلًا. قلها بخفّة: لنضع لها تاريخًا. ما يحدث بعد ذلك هو الجواب كلّه، وتحصل عليه من دون أي جدال حول ما كان يقصده أحد. وإلى أن يحين ذلك، قرّر بناءً على ما حدث لا على ما وُصف لك. لا ترفض فرصًا، ولا تحرّك أموالًا، ولا تعِد ترتيب سنتك حول خطة بلا تاريخ." },
      { type: "p", text: "كثيرون يقولون هذا الكلام ويعنونه تمامًا، ثم لا يفعلونه. تستحق معرفة ذلك حتى لو لم يكذب أحد: فهو يخبرك عن الاعتمادية لا عن الصدق، ومع الاعتمادية ستعيش في الحالتين. ما يمكنك الاتّكاء عليه هو سجل ما تحقّق فعلًا، وهو يوفّر عليك النقاش حول النوايا." },
    ],
  },
  ru: {
    term: "Фьючер-фейкинг",
    summary:
      "Крупные, живые обещания об общем будущем — поездка, съехаться, познакомиться с семьёй, — которыми ускоряют сближение, хотя за ними ничего нет и дата к ним так и не появляется.",
    blocks: [
      { type: "h2", text: "Почему обещание действует быстрее плана" },
      { type: "p", text: "Люди привязываются к воображаемому будущему. Оказаться вписанным в чей-то следующий год — пожалуй, самый сильный сигнал серьёзности, какой у нас есть, и, в отличие от настоящего плана, говорящему он ничего не стоит. Поэтому его можно раздавать так рано. Иногда это расчёт. Чаще человек в ту минуту верит каждому своему слову и просто не заглядывает дальше чувства — для того, кто ждёт, это не более мягкий исход." },
      { type: "p", text: "Часто идёт рука об руку с лав-бомбингом, и их путают. **Разница во времени глагола.** Лав-бомбинг заливает настоящее вниманием, которое происходит прямо сейчас. Фьючер-фейкинг закладывает будущее, которого никто ещё не заслужил: вы тратите настоящее время, настоящие решения, иногда настоящие деньги под это обещание, а счёт приходит только тогда, когда дата так и не наступает." },
      { type: "h2", text: "Как это распознать" },
      {
        type: "ul",
        items: [
          "Планы богаты подробностями и никогда не обзаводятся датой, бронью или ценой.",
          "Через несколько недель вы напоминаете — а всё испарилось: ни памяти об этом, ни продолжения, иногда лёгкое раздражение, что вы спросили.",
          "Обещания становятся крупнее сразу после трения: после ссоры или в момент, когда вы начинаете отстраняться.",
          "Всё, ради чего пришлось бы что-то сделать на этой неделе, отодвигается в расплывчатое потом: весной, когда схлынет работа.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Сделайте одно обещание меньше и ближе. Не поездка к морю, а суббота в этом месяце, действительно забронированная. Скажите это легко: давай поставим дату. То, что случится дальше, и есть весь ответ, и вы получите его, ни разу не поспорив о том, что кто-то имел в виду. А пока решайте по тому, что произошло, а не по тому, что вам описали. Не отказывайтесь от других планов, не двигайте деньги и не перекраивайте год под план без даты." },
      { type: "p", text: "Многие говорят такие вещи, верят в них целиком, а потом не делают. Это стоит знать, даже если никто не лгал: речь идёт о надёжности, а не о честности, и жить вам всё равно придётся с надёжностью. Опереться можно на список того, что действительно случилось, — он избавляет от спора о намерениях." },
    ],
  },
  pt: {
    term: "Future faking",
    summary:
      "Promessas grandes e cheias de detalhes sobre um futuro a dois — uma viagem, morar junto, conhecer a família — usadas para acelerar a intimidade, sem nada por trás e sem nunca ganhar uma data.",
    blocks: [
      { type: "h2", text: "Por que uma promessa anda mais rápido que um plano" },
      { type: "p", text: "As pessoas se apegam a futuros imaginados. Aparecer escrito no ano que vem de alguém é mais ou menos o sinal de seriedade mais forte que existe e, diferente de um plano de verdade, não custa nada a quem fala. É por isso que dá para distribuir tão cedo. Às vezes há cálculo. Mais frequentemente a pessoa acredita em cada palavra naquele instante e simplesmente não pensa além do sentimento, o que não é um desfecho melhor para quem espera." },
      { type: "p", text: "Costuma vir junto com o love bombing e é confundido com ele. **A diferença está no tempo verbal.** O love bombing inunda o presente com uma atenção que está acontecendo agora. O future faking hipoteca um futuro que ninguém conquistou ainda: você gasta tempo real, escolhas reais e às vezes dinheiro real por conta da promessa, e a conta só chega quando a data nunca vem." },
      { type: "h2", text: "Como reconhecer" },
      {
        type: "ul",
        items: [
          "Os planos são cheios de detalhes e nunca ganham data, reserva nem preço.",
          "Você comenta semanas depois e evaporou: nenhuma lembrança, nenhum desdobramento, às vezes uma leve irritação por você ter perguntado.",
          "As promessas ficam maiores logo depois de um atrito: uma discussão, ou o momento em que você começa a se afastar.",
          "Tudo que exigiria fazer algo nesta semana fica num depois vago: na primavera, quando o trabalho acalmar.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer" },
      { type: "p", text: "Torne uma promessa menor e mais próxima. Não a viagem para o litoral: um sábado, neste mês, realmente reservado. Diga de leve: vamos marcar uma data para isso. O que acontece em seguida é a resposta inteira, e você a recebe sem nunca precisar discutir o que alguém quis dizer. Enquanto isso, decida pelo que aconteceu, não pelo que foi descrito. Não recuse coisas, não mexa em dinheiro nem reorganize o seu ano em torno de um plano sem data." },
      { type: "p", text: "Muita gente diz essas coisas, sente cada palavra e depois não faz. Vale saber mesmo quando ninguém mentiu: isso fala de confiabilidade, não de honestidade, e é com a confiabilidade que você vai conviver de qualquer jeito. O que dá para usar é o registro do que realmente aconteceu, e ele poupa a discussão sobre intenções." },
    ],
  },
  it: {
    term: "Future faking",
    summary:
      "Promesse grandi e piene di dettagli su un futuro insieme — un viaggio, andare a convivere, conoscere la famiglia — usate per accelerare l'intimità, senza nulla dietro e senza che ci si metta mai una data.",
    blocks: [
      { type: "h2", text: "Perché una promessa corre più di un piano" },
      { type: "p", text: "Le persone si legano a futuri immaginati. Essere scritti dentro l'anno prossimo di qualcuno è più o meno il segnale di serietà più forte che abbiamo e, a differenza di un piano vero, a chi lo dice non costa niente. Per questo può essere distribuito così presto. A volte è calcolo. Più spesso la persona crede a ogni parola in quel momento e semplicemente non pensa oltre l'emozione, che non è un esito migliore per chi resta ad aspettare." },
      { type: "p", text: "Arriva spesso insieme al love bombing e viene confuso con esso. **La differenza sta nel tempo verbale.** Il love bombing allaga il presente con attenzioni che stanno accadendo adesso. Il future faking ipoteca un futuro che nessuno si è ancora guadagnato: spendi tempo vero, scelte vere e a volte soldi veri sul conto della promessa, e il conto arriva soltanto quando la data non arriva mai." },
      { type: "h2", text: "Come riconoscerlo" },
      {
        type: "ul",
        items: [
          "I piani sono ricchi di dettagli e non ottengono mai una data, una prenotazione o un costo.",
          "Ne parli settimane dopo ed è evaporato: nessun ricordo, nessun seguito, a volte un po' di fastidio perché hai chiesto.",
          "Le promesse si ingrandiscono subito dopo un attrito: una lite, o il momento in cui inizi a tirarti indietro.",
          "Tutto ciò che richiederebbe di fare qualcosa questa settimana finisce in un poi indefinito: in primavera, quando il lavoro si calma.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa fare" },
      { type: "p", text: "Rendi una promessa più piccola e più vicina. Non il viaggio al mare: un sabato, questo mese, prenotato davvero. Dillo con leggerezza: mettiamoci una data. Quello che succede dopo è tutta la risposta, e la ottieni senza dover mai discutere su cosa intendesse qualcuno. Nel frattempo decidi in base a ciò che è successo, non a ciò che ti è stato descritto. Non rinunciare a cose, non spostare soldi e non riorganizzare il tuo anno attorno a un piano senza data." },
      { type: "p", text: "Molte persone dicono queste cose, ci credono davvero e poi non le fanno. Vale la pena saperlo anche quando nessuno ha mentito: parla di affidabilità più che di sincerità, e con l'affidabilità ci convivi comunque. Quello su cui puoi contare è l'elenco di ciò che è stato fatto davvero, e ti risparmia la discussione sulle intenzioni." },
    ],
  },
  ja: {
    term: "フューチャーフェイキング",
    summary:
      "旅行、同居、家族への紹介といった、具体的で大きな未来の約束を並べて距離を一気に縮めようとすること。中身は伴わず、日付がつくこともありません。",
    blocks: [
      { type: "h2", text: "約束が計画より速く効く理由" },
      { type: "p", text: "人は想像された未来に本気になります。誰かの来年の予定のなかに自分が書き込まれることは、真剣さのいちばん強い合図に近いものです。しかも本物の計画と違って、口にする側には何の負担もありません。だからこんなに早い時期から配れてしまいます。計算ずくのこともあります。ただ、それ以上に多いのは、その瞬間は一言一句本気で、感情の先を考えないというかたちです。待つ側にとって、こちらが優しい結末というわけでもありません。" },
      { type: "p", text: "ラブボミングと同時に現れやすく、混同もされます。**違いは時制です。**ラブボミングは、いま起きている好意で現在をあふれさせます。フューチャーフェイキングは、まだ誰も手に入れていない未来を担保に入れます。あなたは本物の時間、本物の選択、ときには本物のお金をその約束のために使い、日付がついに来なかったときになって請求書が届きます。" },
      { type: "h2", text: "見分け方" },
      {
        type: "ul",
        items: [
          "話は細部まで生き生きしているのに、日付も予約も費用も最後までつかない。",
          "数週間後に触れると消えている。覚えていないし、続きもなく、聞いたことに少し不機嫌になることさえある。",
          "もめごとの直後に約束が大きくなる。口論のあとや、こちらが引き始めた瞬間。",
          "今週なにかしなければならない話は、すべて曖昧な「あとで」に置かれる。春になったら、仕事が落ち着いたら。",
        ],
      },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "約束をひとつ、小さく近くしてみてください。海辺の旅行ではなく、今月の土曜日、実際に予約された形で。軽く言えば十分です。日付を決めてしまおう、と。そのあと何が起きるかが答えのすべてで、しかも誰が何を意図していたかを争わずに手に入ります。それまでは、語られたことではなく起きたことで判断してください。日付のない計画のために、何かを断ったり、お金を動かしたり、一年の予定を組み替えたりしないことです。" },
      { type: "p", text: "こうしたことを口にし、心から本気で、それでもやらない人はたくさんいます。誰も嘘をついていなくても、知っておく価値はあります。それは誠実さではなく信頼できるかどうかの話で、結局あなたが付き合うのはそちらだからです。頼りになるのは、実際に行われたことの記録だけです。それがあれば、本心をめぐる言い争いをせずに済みます。" },
    ],
  },
  ko: {
    term: "퓨처 페이킹",
    summary:
      "여행, 함께 살기, 가족 소개처럼 크고 구체적인 미래의 약속으로 친밀함을 앞당기지만, 그 뒤에는 아무 실체가 없고 날짜도 끝내 붙지 않는 일을 말합니다.",
    blocks: [
      { type: "h2", text: "약속이 계획보다 빠르게 움직이는 이유" },
      { type: "p", text: "사람은 상상된 미래에 마음을 겁니다. 누군가의 내년 안에 내 이름이 적히는 일은 우리가 가진 가장 강한 진심의 신호에 가깝습니다. 게다가 진짜 계획과 달리 말하는 쪽에는 아무 비용도 들지 않습니다. 그래서 이렇게 이른 시기에도 나눠 줄 수 있습니다. 계산일 때도 있습니다. 그보다 훨씬 흔한 건 그 순간에는 한 마디 한 마디가 진심인데 감정 너머를 전혀 생각하지 않는 경우입니다. 기다리는 쪽에게 더 나은 결말은 아닙니다." },
      { type: "p", text: "러브 바밍과 함께 나타나기 쉽고 서로 혼동되기도 합니다. **차이는 시제에 있습니다.** 러브 바밍은 지금 벌어지는 관심으로 현재를 가득 채웁니다. 퓨처 페이킹은 아직 아무도 얻지 못한 미래를 담보로 잡습니다. 당신은 진짜 시간과 진짜 선택, 때로는 진짜 돈을 그 약속에 걸어 두고, 청구서는 날짜가 끝내 오지 않았을 때에야 도착합니다." },
      { type: "h2", text: "어떻게 알아볼까" },
      {
        type: "ul",
        items: [
          "계획은 세부까지 생생한데 날짜도, 예약도, 비용도 끝내 붙지 않습니다.",
          "몇 주 뒤에 꺼내면 증발해 있습니다. 기억도 없고, 이어지는 것도 없고, 물어봤다고 살짝 언짢아하기도 합니다.",
          "마찰 직후에 약속이 커집니다. 다툰 뒤나, 당신이 물러서기 시작한 바로 그때.",
          "이번 주에 뭔가 해야 하는 일은 전부 막연한 나중으로 갑니다. 봄에, 일이 좀 잦아들면.",
        ],
      },
      { type: "h2", accent: "green", text: "무엇을 하면 좋을까" },
      { type: "p", text: "약속 하나를 더 작고 더 가깝게 만들어 보세요. 바다로 가는 여행 말고, 이번 달 토요일, 실제로 예약된 형태로요. 가볍게 말하면 됩니다. 우리 날짜부터 잡자. 그다음에 벌어지는 일이 답의 전부이고, 누가 무슨 뜻이었는지 다툴 필요도 없습니다. 그때까지는 들은 이야기가 아니라 일어난 일로 판단하세요. 날짜 없는 계획을 위해 다른 걸 거절하거나, 돈을 옮기거나, 한 해의 일정을 다시 짜지는 마시고요." },
      { type: "p", text: "이런 말을 하고, 그 순간 온 마음으로 믿고, 그러고는 하지 않는 사람이 많습니다. 아무도 거짓말을 하지 않았더라도 알아 둘 가치가 있습니다. 이건 정직함이 아니라 신뢰할 수 있는지에 대한 이야기이고, 어차피 당신이 함께 살아갈 건 그쪽이니까요. 기댈 수 있는 건 실제로 이루어진 일의 기록뿐이고, 그 덕분에 속마음을 두고 벌이는 말싸움을 하지 않아도 됩니다." },
    ],
  },
  zh: {
    term: "画大饼",
    summary:
      "用旅行、同居、见家人这类既具体又宏大的未来承诺，把亲密关系往前赶，可承诺背后什么都没有，也永远定不下日期。英文叫 future faking。",
    blocks: [
      { type: "h2", text: "为什么承诺比计划走得快" },
      { type: "p", text: "人会为想象中的未来投入。被写进别人明年的日程里，差不多是我们能给出的最强的认真信号；而和真正的计划不同，说出口的人一分力气都不用花。所以它可以在很早的时候就被大方地派发出去。有时候确实是算计。更多的时候，那个人在说的当下每个字都是真心的，只是从来没想过感觉之后的事——对等着的人来说，这并不是更温柔的结果。" },
      { type: "p", text: "它常常和爱情轰炸一起出现，也常被混为一谈。**区别在时态。**爱情轰炸把此刻正在发生的热情灌满现在。画大饼抵押的是一个还没有人挣到手的将来：你拿真实的时间、真实的取舍，有时还有真实的钱，押在那个承诺上，而账单要等到日期始终没来的时候才寄到。" },
      { type: "h2", text: "怎么看出来" },
      {
        type: "ul",
        items: [
          "计划的细节很丰富，却始终没有日期、没有预订、没有花费。",
          "几周后你提起来，它已经蒸发了：不记得，没有下文，有时还因为你问了而略显不耐烦。",
          "一有摩擦，承诺就变大：吵完架之后，或者你开始往后退的那一刻。",
          "凡是这周就得动手的事，都被推到一个含糊的以后：等到春天，等这阵忙完。",
        ],
      },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "把其中一个承诺变小、变近。不是去海边那趟旅行，而是这个月的某个周六，真的订好。语气放轻：我们把日期定下来吧。接下来发生的事就是全部答案，而且你不用为谁是什么意思争论一场。在那之前，按已经发生的事来判断，而不是按被描述过的事。别为一个没有日期的计划推掉别的安排、挪动钱，或者重排自己一整年。" },
      { type: "p", text: "很多人说这些话时是完全当真的，然后就是没做。哪怕没人撒谎，这件事也值得知道：它说的是靠不靠得住，而不是诚不诚实，而你要一起过日子的恰恰是前者。真正能依靠的，是那份实际做成了什么的记录，它也替你省下了一场关于心意的争论。" },
    ],
  },
  nl: {
    term: "Future faking",
    summary:
      "Grote, levendige beloften over een gezamenlijke toekomst — een reis, samenwonen, de familie ontmoeten — waarmee intimiteit wordt versneld, zonder dat er iets achter zit en zonder dat er ooit een datum bij komt.",
    blocks: [
      { type: "h2", text: "Waarom een belofte sneller gaat dan een plan" },
      { type: "p", text: "Mensen binden zich aan verbeelde toekomsten. Ingeschreven staan in iemands volgende jaar is ongeveer het sterkste signaal van ernst dat we hebben, en anders dan een echt plan kost het degene die het zegt helemaal niets. Daarom kan het zo vroeg worden uitgedeeld. Soms is het berekend. Vaker meent iemand op dat moment elk woord en denkt eenvoudigweg nooit verder dan het gevoel, wat voor degene die wacht geen vriendelijker afloop is." },
      { type: "p", text: "Het komt vaak samen met lovebombing voor en wordt daarmee verward. **Het verschil zit in de tijd.** Lovebombing overspoelt het heden met aandacht die nu gebeurt. Future faking verpandt een toekomst die nog niemand verdiend heeft: je geeft echte tijd, echte keuzes en soms echt geld uit op krediet van de belofte, en de rekening komt pas als de datum nooit komt." },
      { type: "h2", text: "Hoe je het herkent" },
      {
        type: "ul",
        items: [
          "De plannen zitten vol details en krijgen nooit een datum, een boeking of een prijs.",
          "Je noemt er weken later een en die is verdampt: geen herinnering, geen vervolg, soms lichte irritatie dat je ernaar vraagt.",
          "De beloften worden groter vlak na wrijving: na een ruzie, of op het moment dat jij je terugtrekt.",
          "Alles waarvoor je deze week iets zou moeten doen, ligt in een vaag later: in het voorjaar, als het rustiger wordt op het werk.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je kunt doen" },
      { type: "p", text: "Maak één belofte kleiner en dichterbij. Niet de reis naar de kust, maar een zaterdag, deze maand, echt geboekt. Zeg het licht: laten we er een datum op zetten. Wat daarna gebeurt is het hele antwoord, en je krijgt het zonder ooit te hoeven bakkeleien over hoe iets bedoeld was. Ondertussen: beslis op wat er gebeurd is, niet op wat er beschreven is. Zeg niets af, verschuif geen geld en zet je jaar niet om voor een plan zonder datum." },
      { type: "p", text: "Genoeg mensen zeggen dit soort dingen, menen ze volledig en doen ze vervolgens niet. Ook als er niemand loog is dat het weten waard: het zegt iets over betrouwbaarheid en niet over eerlijkheid, en met die betrouwbaarheid leef je hoe dan ook. Waar je op kunt bouwen is de lijst van wat er werkelijk gebeurd is. Die bespaart je de discussie over bedoelingen." },
    ],
  },
  pl: {
    term: "Future faking",
    summary:
      "Wielkie, barwne obietnice wspólnej przyszłości — podróż, zamieszkanie razem, poznanie rodziny — używane, żeby przyspieszyć bliskość, choć nic za nimi nie stoi i nigdy nie dostają daty.",
    blocks: [
      { type: "h2", text: "Dlaczego obietnica działa szybciej niż plan" },
      { type: "p", text: "Ludzie przywiązują się do wyobrażonych przyszłości. Zostać wpisanym w czyjś przyszły rok to bodaj najsilniejszy sygnał powagi, jaki mamy, a w odróżnieniu od prawdziwego planu mówiącego nic nie kosztuje. Dlatego można to rozdawać tak wcześnie. Czasem jest w tym wyrachowanie. Częściej człowiek w tamtej chwili wierzy w każde słowo i po prostu nie myśli dalej niż uczucie, co dla czekającego wcale nie jest łagodniejszym zakończeniem." },
      { type: "p", text: "Często przychodzi razem z love bombingiem i bywa z nim mylone. **Różnica leży w czasie gramatycznym.** Love bombing zalewa teraźniejszość uwagą, która dzieje się właśnie teraz. Future faking zastawia przyszłość, na którą nikt jeszcze nie zapracował: wydajesz prawdziwy czas, prawdziwe wybory, czasem prawdziwe pieniądze na poczet obietnicy, a rachunek przychodzi dopiero wtedy, gdy data nigdy nie nadchodzi." },
      { type: "h2", text: "Jak to rozpoznać" },
      {
        type: "ul",
        items: [
          "Plany są pełne szczegółów i nigdy nie dostają daty, rezerwacji ani kosztu.",
          "Wracasz do tego po tygodniach, a wszystko wyparowało: żadnej pamięci, żadnego ciągu dalszego, czasem lekkie zniecierpliwienie, że pytasz.",
          "Obietnice rosną tuż po zgrzycie: po kłótni albo w chwili, gdy zaczynasz się wycofywać.",
          "Wszystko, co wymagałoby zrobienia czegoś w tym tygodniu, ląduje w mglistym później: na wiosnę, jak minie młyn w pracy.",
        ],
      },
      { type: "h2", accent: "green", text: "Co możesz zrobić" },
      { type: "p", text: "Zrób jedną obietnicę mniejszą i bliższą. Nie wyjazd nad morze, tylko sobota w tym miesiącu, naprawdę zarezerwowana. Powiedz to lekko: ustalmy datę. To, co stanie się potem, jest całą odpowiedzią, a dostajesz ją bez ani jednej kłótni o to, co ktoś miał na myśli. W międzyczasie decyduj na podstawie tego, co się wydarzyło, a nie tego, co zostało opisane. Nie odmawiaj innych rzeczy, nie przesuwaj pieniędzy i nie przestawiaj roku pod plan bez daty." },
      { type: "p", text: "Wielu ludzi mówi takie rzeczy, w pełni je czuje, a potem ich nie robi. Warto to wiedzieć, nawet gdy nikt nie kłamał: mówi to o niezawodności, a nie o uczciwości, a z niezawodnością i tak będziesz żyć. Oprzeć się da na spisie tego, co naprawdę się wydarzyło, i oszczędza on kłótni o intencje." },
    ],
  },
  sv: {
    term: "Future faking",
    summary:
      "Stora, målande löften om en gemensam framtid — en resa, att flytta ihop, att träffa familjen — som används för att snabba på närheten, utan något bakom sig och utan att någonsin få ett datum.",
    blocks: [
      { type: "h2", text: "Varför ett löfte går fortare än en plan" },
      { type: "p", text: "Människor binder sig vid inbillade framtider. Att bli inskriven i någons nästa år är ungefär den starkaste allvarssignal vi har, och till skillnad från en riktig plan kostar den ingenting för den som säger den. Därför kan den delas ut så tidigt. Ibland är det uträknat. Oftare menar personen varje ord i stunden och tänker helt enkelt aldrig längre än känslan, vilket inte är ett snällare slut för den som väntar." },
      { type: "p", text: "Det kommer ofta tillsammans med love bombing och förväxlas med det. **Skillnaden ligger i tempus.** Love bombing översvämmar nuet med uppmärksamhet som pågår just nu. Future faking intecknar en framtid som ingen ännu förtjänat: du gör av med riktig tid, riktiga val och ibland riktiga pengar mot löftet, och notan kommer först när datumet aldrig gör det." },
      { type: "h2", text: "Så känner du igen det" },
      {
        type: "ul",
        items: [
          "Planerna är rika på detaljer och får aldrig ett datum, en bokning eller en kostnad.",
          "Du tar upp något veckor senare och det har dunstat bort: inget minne av det, ingen fortsättning, ibland lätt irritation över att du frågade.",
          "Löftena blir större direkt efter en gnissling: efter ett gräl, eller i stunden då du börjar dra dig undan.",
          "Allt som skulle kräva att man gjorde något den här veckan ligger i ett vagt sedan: till våren, när det lugnat ner sig på jobbet.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Gör ett av löftena mindre och närmare. Inte resan till kusten — en lördag, den här månaden, faktiskt bokad. Säg det lätt: vi sätter ett datum. Det som händer sedan är hela svaret, och du får det utan att någonsin behöva bråka om hur något var menat. Under tiden: bestäm utifrån vad som har hänt, inte utifrån vad som har beskrivits. Tacka inte nej till annat, flytta inte pengar och lägg inte om ditt år för en plan utan datum." },
      { type: "p", text: "Många säger sådant här, menar varje ord och gör det sedan inte. Det är värt att veta även när ingen ljög: det säger något om pålitlighet snarare än om ärlighet, och det är pålitligheten du lever med hur som helst. Det du kan luta dig mot är listan över vad som faktiskt blev av, och den besparar dig diskussionen om avsikter." },
    ],
  },
  hi: {
    term: "फ़्यूचर फेकिंग",
    summary:
      "एक यात्रा, साथ रहने या परिवार से मिलवाने जैसे बड़े और बिलकुल ठोस दिखते वादे, जिनसे नज़दीकी जल्दी बढ़ाई जाती है — पर उनके पीछे कोई इरादा नहीं होता और उन पर तारीख़ कभी नहीं पड़ती।",
    blocks: [
      { type: "h2", text: "वादा योजना से तेज़ क्यों चलता है" },
      { type: "p", text: "लोग कल्पना किए गए भविष्य से जुड़ जाते हैं। किसी के अगले साल में अपना नाम लिखा देखना गंभीरता का शायद सबसे तगड़ा संकेत है, और असली योजना के उलट कहने वाले का इसमें कुछ भी ख़र्च नहीं होता। इसीलिए यह इतनी जल्दी बाँटा जा सकता है। कभी-कभी इसमें हिसाब होता है। पर उससे कहीं ज़्यादा बार वह इंसान उस पल हर शब्द में सच्चा होता है और भावना के आगे कभी सोचता ही नहीं — इंतज़ार करने वाले के लिए यह कोई नरम अंजाम नहीं है।" },
      { type: "p", text: "यह अक्सर लव बॉम्बिंग के साथ आता है और उसी समझ लिया जाता है। **फ़र्क़ काल का है।** लव बॉम्बिंग वर्तमान को उस ध्यान से भर देता है जो अभी घट रहा है। फ़्यूचर फेकिंग उस भविष्य को गिरवी रखता है जो अभी किसी ने कमाया ही नहीं: आप असली वक़्त, असली फ़ैसले और कभी-कभी असली पैसा उस वादे के भरोसे लगाते हैं, और बिल तब आता है जब वह तारीख़ कभी आती ही नहीं।" },
      { type: "h2", text: "कैसे पहचानें" },
      {
        type: "ul",
        items: [
          "योजनाओं में ब्योरा भरपूर होता है, पर तारीख़, बुकिंग या ख़र्च कभी नहीं जुड़ता।",
          "हफ़्तों बाद आप ज़िक्र करते हैं और वह हवा हो चुकी होती है: न याद, न आगे की बात, कभी-कभी पूछने पर हल्की झुँझलाहट।",
          "किसी खटपट के तुरंत बाद वादे बड़े हो जाते हैं: बहस के बाद, या जिस पल आप पीछे हटने लगते हैं।",
          "जिस भी बात के लिए इसी हफ़्ते कुछ करना पड़े, वह एक धुँधले बाद में चली जाती है: बसंत में, जब काम का दबाव घट जाए।",
        ],
      },
      { type: "h2", accent: "green", text: "क्या किया जा सकता है" },
      { type: "p", text: "किसी एक वादे को छोटा और नज़दीक कर दीजिए। समंदर की वह यात्रा नहीं — इसी महीने का एक शनिवार, सचमुच बुक किया हुआ। हल्के से कह दीजिए: चलो इस पर एक तारीख़ डाल लेते हैं। इसके बाद जो होता है वही पूरा जवाब है, और वह आपको इस बहस के बिना मिल जाता है कि किसका मतलब क्या था। तब तक जो बताया गया उससे नहीं, जो हुआ उससे तय कीजिए। बिना तारीख़ वाली योजना के लिए न कुछ ठुकराइए, न पैसा हिलाइए, न अपना पूरा साल दोबारा जमाइए।" },
      { type: "p", text: "बहुत से लोग ये बातें कहते हैं, पूरे दिल से कहते हैं, और फिर करते नहीं। किसी ने झूठ न भी बोला हो, तब भी यह जानना काम का है: यह ईमानदारी नहीं, भरोसेमंदी के बारे में बताता है, और साथ तो आपको भरोसेमंदी के ही रहना है। जिस पर टिका जा सकता है वह है असल में हुए कामों का हिसाब — और वही आपको नीयत पर होने वाली बहस से बचा देता है।" },
    ],
  },
};
