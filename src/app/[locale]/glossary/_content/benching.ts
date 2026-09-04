import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Benching — being kept as a backup: warm enough not to leave, never chosen.
 *
 * Judgement calls made here, so a later editor does not undo them by accident:
 *
 * - THE BREADCRUMBING BOUNDARY IS THE POINT OF BLOCK 2 and is worded to stay
 *   distinct from the breadcrumbing page, which draws the same line from the
 *   other side. Benching is about ranking — you sit below someone else's better
 *   option, and the contact exists to keep you available. Breadcrumbing is
 *   about the drip of attention itself, and can happen with nobody else in the
 *   picture. Keep both halves if you shorten this.
 * - NO QULO ANGLE. Block 7 is not a product pitch. Being kept as a backup is a
 *   thing people do to each other everywhere, and nothing about writing quiz
 *   questions prevents it; the slug page already carries a Qulo CTA under the
 *   body, so the entry does not need to sell.
 * - NO STATISTICS. Nothing quantitative is claimed. The one sourced figure
 *   available (Forbes Health / OnePoll 2024, dating-app burnout) is about a
 *   different subject and is deliberately not stretched to fit here.
 * - FAIRNESS CAVEAT IN BLOCK 7 IS DELIBERATE: one quiet fortnight is not a
 *   bench. The tell is months, and that the attention tracks the other
 *   person's options rather than yours. Without it the entry invites readers
 *   to read ordinary hesitancy as a verdict — that is diagnosing, not
 *   describing.
 *
 * Term names: the English loanword in the Latin-script locales, native or
 * transliterated where the language has its own: ar الإبقاء على دكة الاحتياط,
 * ru Бенчинг, ja ベンチング, ko 벤칭, hi बेंचिंग. zh uses 备胎 — the everyday
 * Chinese word for being someone's spare — with the English named in the
 * summary. The ja body nods to キープ and the ko body to 어장관리 for the same
 * reason: those are the words readers there already have for this.
 */
export const benching: LocalizedGlossaryEntry = {
  en: {
    term: "Benching",
    summary:
      "Being kept as a backup: warm enough that you don't leave, never quite chosen, while the other person keeps their attention on the options they would rather have.",
    blocks: [
      { type: "h2", text: "Where the bench comes from" },
      { type: "p", text: "The word comes from team sport. A squad player is kept fit, kept close and kept ready, and never actually put on the pitch. Dating borrowed the image for the same arrangement: enough contact to keep you available, not enough to make you the plan. Usually it comes from wanting insurance rather than wanting you — company if the preferred option falls through, and no awkward conversation in the meantime." },
      { type: "p", text: "It is easy to confuse with breadcrumbing, and the signs do overlap. The difference is what the contact is for. Breadcrumbing is about the drip itself: attention with no destination, which can happen with nobody else in the picture. **Benching is about ranking.** You are somewhere on a list, below whoever they are currently hoping for, and the messages exist to keep you there." },
      { type: "h2", text: "How to recognise it" },
      {
        type: "ul",
        items: [
          "Attention arrives when their other options go quiet — a slow week for them is a good week for you.",
          "Invitations come last-minute far more often than they come planned.",
          "Warm in private, and more or less invisible in the rest of their life.",
          "Every step forward is postponed rather than refused: not right now, after this busy patch.",
        ],
      },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Ask for one ordinary thing a chosen person gets: a plan made a week ahead, a Saturday rather than a Tuesday at eleven, an evening with one of their friends. Keep it light — it is a request, not a summit about the relationship. Then look honestly at your own calendar. How many evenings do you hold free for someone who has never held one free for you? Your availability is the thing being used, and it is also the part you control." },
      { type: "p", text: "You do not need anyone to admit to anything. Stop holding the space and it resolves itself: either they notice and come forward, or it ends quietly without a fight. One slow fortnight is not a bench, though. What makes it a pattern is months of it, and the fact that the warmth moves with their other options rather than with anything you do." },
    ],
  },
  tr: {
    term: "Benching",
    summary:
      "Yedekte tutulmak: ayrılmayacağınız kadar sıcak ama hiçbir zaman gerçekten seçilmeyen bir yerde durmak; karşı taraf asıl istediği seçenekleri kollarken sizi elinin altında bırakır.",
    blocks: [
      { type: "h2", text: "Yedek kulübesi benzetmesi nereden geliyor?" },
      { type: "p", text: "Kelime takım sporundan geliyor. Kadro oyuncusu formda tutulur, yakında tutulur, hazır tutulur ama sahaya hiç çıkarılmaz. Flörtte de aynı düzeni anlatıyor: sizi ulaşılabilir tutmaya yetecek kadar temas, sizi asıl plan yapmaya yetmeyecek kadar az. Çoğu zaman arkasında sizi istemek değil, garanti isteme vardır — tercih edilen seçenek tutmazsa bir arkadaş, o zamana kadar da hiç zor bir konuşma yok." },
      { type: "p", text: "Breadcrumbing ile karıştırmak kolaydır, işaretler de örtüşür. Fark, temasın ne işe yaradığında. Breadcrumbing damlanın kendisiyle ilgilidir: varış noktası olmayan bir ilgi, ki ortada başka kimse olmadan da yaşanabilir. **Benching ise sıralamayla ilgilidir.** Bir listede bir yerdesinizdir, o an umut bağladığı kişinin altında, ve mesajlar sizi orada tutmak için vardır." },
      { type: "h2", text: "Nasıl anlaşılır?" },
      {
        type: "ul",
        items: [
          "İlgi, onun diğer seçenekleri sustuğunda gelir; onun boş haftası sizin iyi haftanız olur.",
          "Davetler planlanmış olmaktan çok son dakika gelir.",
          "Baş başayken sıcaktır, hayatının geri kalanında neredeyse görünmezsinizdir.",
          "Her adım reddedilmez, ertelenir: şimdi olmaz, bu yoğunluk geçsin.",
        ],
      },
      { type: "h2", accent: "green", text: "Ne yapabilirsiniz?" },
      { type: "p", text: "Seçilmiş bir insanın doğal olarak aldığı sıradan tek bir şey isteyin: bir hafta önceden yapılmış bir plan, gece on birde değil cumartesi bir buluşma, arkadaşlarından biriyle bir akşam. Hafif tutun; bu bir istek, ilişki zirvesi değil. Sonra kendi takviminize dürüstçe bakın. Sizin için hiç akşam boşaltmamış birine kaç akşamınızı boş tutuyorsunuz? Kullanılan şey müsaitliğiniz ve kontrol edebildiğiniz kısım da tam olarak o." },
      { type: "p", text: "Kimsenin bir şeyi itiraf etmesine ihtiyacınız yok. Yer açmayı bırakın, durum kendiliğinden çözülür: ya fark edip öne çıkar ya da kavgasız sessizce biter. Ama sakin geçen iki hafta yedek kulübesi demek değildir. Bunu bir örüntü yapan şey, aylarca sürmesi ve sıcaklığın sizin yaptıklarınıza değil, onun diğer seçeneklerine göre inip çıkmasıdır." },
    ],
  },
  de: {
    term: "Benching",
    summary:
      "Als Reserve gehalten werden: warm genug, dass man bleibt, nie wirklich gewählt, während die andere Person weiter auf die Optionen setzt, die sie lieber hätte.",
    blocks: [
      { type: "h2", text: "Woher das Bild von der Ersatzbank kommt" },
      { type: "p", text: "Das Wort kommt aus dem Mannschaftssport. Ein Kaderspieler wird fit gehalten, nah gehalten, bereit gehalten — und nie eingewechselt. Beim Daten beschreibt es dieselbe Anordnung: gerade genug Kontakt, damit du verfügbar bleibst, zu wenig, damit du der Plan wirst. Meist geht es weniger um dich als um eine Absicherung: Gesellschaft, falls die bevorzugte Option platzt, und bis dahin kein unangenehmes Gespräch." },
      { type: "p", text: "Mit Breadcrumbing wird das leicht verwechselt, und die Anzeichen überschneiden sich. Der Unterschied liegt darin, wozu der Kontakt dient. Beim Breadcrumbing geht es um das Tröpfeln selbst: Aufmerksamkeit ohne Ziel, die es auch geben kann, wenn sonst niemand im Spiel ist. **Beim Benching geht es um eine Rangfolge.** Du stehst irgendwo auf einer Liste, unter der Person, auf die gerade gehofft wird, und die Nachrichten halten dich dort." },
      { type: "h2", text: "Woran du es erkennst" },
      {
        type: "ul",
        items: [
          "Aufmerksamkeit kommt, wenn es bei den anderen Optionen still wird — eine ruhige Woche dort ist eine gute Woche für dich.",
          "Einladungen kommen viel öfter kurzfristig als geplant.",
          "Warm zu zweit und im übrigen Leben so gut wie unsichtbar.",
          "Jeder Schritt nach vorn wird nicht abgelehnt, sondern verschoben: gerade nicht, nach dem Stress.",
        ],
      },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Bitte um eine gewöhnliche Sache, die eine gewählte Person selbstverständlich bekommt: eine Verabredung eine Woche im Voraus, einen Samstag statt Dienstag um elf, einen Abend mit einer Freundin oder einem Freund von ihr. Halte es leicht — das ist eine Bitte, kein Gipfeltreffen. Und sieh dir ehrlich deinen eigenen Kalender an. Wie viele Abende hältst du frei für jemanden, der nie einen für dich frei gehalten hat? Benutzt wird deine Verfügbarkeit, und genau die liegt bei dir." },
      { type: "p", text: "Niemand muss dir etwas eingestehen. Hör auf, Platz freizuhalten, und die Sache klärt sich von selbst: Entweder es fällt auf und jemand tritt vor, oder es endet leise ohne Streit. Zwei ruhige Wochen sind aber noch keine Ersatzbank. Zum Muster wird es über Monate — und daran, dass die Wärme sich nach den anderen Optionen richtet und nicht nach dem, was du tust." },
    ],
  },
  fr: {
    term: "Benching",
    summary:
      "Être gardé en réserve : assez de chaleur pour que vous restiez, jamais vraiment choisi, pendant que l'autre continue de miser sur les options qu'il préférerait.",
    blocks: [
      { type: "h2", text: "D'où vient l'image du banc de touche" },
      { type: "p", text: "Le mot vient des sports collectifs. Un joueur du groupe est entretenu, gardé près du terrain, gardé prêt — et jamais envoyé jouer. En amour, cela décrit le même arrangement : assez de contact pour que vous restiez disponible, pas assez pour que vous deveniez le projet. Il s'agit le plus souvent d'une assurance plutôt que d'un désir : de la compagnie si l'option préférée tombe à l'eau, et aucune conversation gênante entre-temps." },
      { type: "p", text: "On le confond facilement avec le breadcrumbing, et les signes se recoupent. La différence tient à ce que sert le contact. Le breadcrumbing porte sur le goutte-à-goutte lui-même : de l'attention sans destination, possible même sans personne d'autre dans le décor. **Le benching porte sur un classement.** Vous êtes quelque part sur une liste, en dessous de celui ou celle qu'on espère, et les messages servent à vous y maintenir." },
      { type: "h2", text: "Comment le reconnaître" },
      {
        type: "ul",
        items: [
          "L'attention revient quand ses autres options se taisent : une semaine creuse pour lui est une bonne semaine pour vous.",
          "Les invitations arrivent bien plus souvent à la dernière minute que prévues à l'avance.",
          "Chaleureux en tête-à-tête, et quasiment invisible dans le reste de sa vie.",
          "Chaque pas en avant n'est pas refusé mais reporté : pas maintenant, après cette période chargée.",
        ],
      },
      { type: "h2", accent: "green", text: "Que faire" },
      { type: "p", text: "Demandez une chose ordinaire qu'une personne choisie obtient sans y penser : un rendez-vous fixé une semaine à l'avance, un samedi plutôt qu'un mardi à onze heures du soir, une soirée avec un de ses amis. Restez léger : c'est une demande, pas un sommet sur la relation. Puis regardez honnêtement votre agenda. Combien de soirées gardez-vous libres pour quelqu'un qui n'en a jamais gardé une pour vous ? C'est votre disponibilité qui est utilisée, et c'est aussi la part qui dépend de vous." },
      { type: "p", text: "Vous n'avez besoin d'aucun aveu. Cessez de réserver la place et la situation se règle seule : soit on s'en aperçoit et on avance, soit cela s'éteint sans dispute. Deux semaines calmes ne font pas un banc de touche, cela dit. Ce qui en fait un schéma, c'est la durée, et le fait que la chaleur suive ses autres options plutôt que ce que vous faites, vous." },
    ],
  },
  es: {
    term: "Benching",
    summary:
      "Quedarse en el banquillo: con la calidez justa para no irte, sin ser nunca la opción elegida, mientras la otra persona sigue pendiente de quien de verdad preferiría.",
    blocks: [
      { type: "h2", text: "De dónde viene la imagen del banquillo" },
      { type: "p", text: "La palabra viene del deporte de equipo. Al jugador de la plantilla se le mantiene en forma, cerca y listo, y nunca se le saca al campo. En las relaciones describe el mismo arreglo: contacto suficiente para que sigas disponible, no tanto como para convertirte en el plan. Casi siempre nace de querer un seguro más que de quererte a ti: compañía si la opción preferida se cae, y ninguna conversación incómoda por el camino." },
      { type: "p", text: "Se confunde fácilmente con el breadcrumbing, y las señales se solapan. La diferencia está en para qué sirve el contacto. El breadcrumbing tiene que ver con el goteo en sí: atención sin destino, que puede darse aunque no haya nadie más en escena. **El benching tiene que ver con un orden de preferencia.** Estás en algún punto de una lista, por debajo de quien ahora mismo espera, y los mensajes existen para mantenerte ahí." },
      { type: "h2", text: "Cómo reconocerlo" },
      {
        type: "ul",
        items: [
          "La atención aparece cuando sus otras opciones se apagan: una semana floja para esa persona es una buena semana para ti.",
          "Las invitaciones llegan de un día para otro mucho más a menudo que planificadas.",
          "Cálido en privado y prácticamente invisible en el resto de su vida.",
          "Ningún paso adelante se rechaza, se aplaza: ahora no, cuando pase esta racha de trabajo.",
        ],
      },
      { type: "h2", accent: "green", text: "Qué puedes hacer" },
      { type: "p", text: "Pide una cosa normal que recibe cualquiera a quien se elige: un plan hecho con una semana de antelación, un sábado en lugar de un martes a las once, una noche con alguno de sus amigos. Que sea ligero: es una petición, no una cumbre sobre la relación. Después mira tu propia agenda con honestidad. ¿Cuántas noches dejas libres para alguien que no ha dejado ninguna libre por ti? Lo que se está usando es tu disponibilidad, y esa parte sí depende de ti." },
      { type: "p", text: "No necesitas que nadie admita nada. Deja de reservar el hueco y la situación se resuelve sola: o lo nota y da un paso, o se apaga sin discusión. Eso sí, dos semanas tranquilas no son un banquillo. Lo que lo convierte en un patrón es que dure meses y que el calor suba y baje con sus otras opciones, no con lo que haces tú." },
    ],
  },
  ar: {
    term: "الإبقاء على دكة الاحتياط",
    summary:
      "دفء يكفي لئلّا ترحل، من دون أن تُختار فعلًا، بينما يواصل الطرف الآخر انتظار خيار يفضّله عليك. ويُعرف بالإنجليزية باسم benching.",
    blocks: [
      { type: "h2", text: "من أين جاءت صورة دكة الاحتياط" },
      { type: "p", text: "الكلمة مأخوذة من الرياضات الجماعية. لاعب الاحتياط يُبقى لائقًا، وقريبًا، وجاهزًا، ولا يُدفع به إلى الملعب أبدًا. وفي العلاقات تصف الترتيب نفسه: تواصل يكفي لتبقى متاحًا، ولا يكفي لتصبح الخطة. غالبًا لا يكون الدافع رغبةً فيك بل رغبةً في ضمانة: رفقة إن فشل الخيار المفضّل، وبلا حديث محرج في الأثناء." },
      { type: "p", text: "من السهل الخلط بينه وبين نثر الفتات، والعلامات تتداخل فعلًا. الفرق في الغاية من التواصل. نثر الفتات يتعلّق بالتقطير نفسه: اهتمام بلا وجهة، وقد يحدث من دون وجود أي شخص آخر في الصورة. **أمّا هذا فيتعلّق بالترتيب**: أنت في مكان ما على قائمة، تحت من يعلّق عليه آماله الآن، والرسائل موجودة لتبقيك هناك." },
      { type: "h2", text: "كيف تتعرّف عليه" },
      {
        type: "ul",
        items: [
          "الاهتمام يصلك حين تهدأ خياراته الأخرى؛ أسبوعه الفارغ هو أسبوعك الجيد.",
          "الدعوات تأتي في اللحظة الأخيرة أكثر بكثير ممّا تأتي مرتّبة مسبقًا.",
          "دافئ في الخاص، وشبه غائب عن بقية حياته.",
          "لا خطوة إلى الأمام تُرفض، بل تُؤجَّل: ليس الآن، بعد أن ينتهي هذا الازدحام.",
        ],
      },
      { type: "h2", accent: "green", text: "ماذا يمكنك أن تفعل" },
      { type: "p", text: "اطلب شيئًا عاديًا ينالُه أي شخص مختار: موعد يُحدَّد قبل أسبوع، سهرة يوم سبت بدل مكالمة ليلية متأخّرة، أمسية مع أحد أصدقائه. اجعل الطلب خفيفًا؛ فهو طلب لا قمّة لمناقشة العلاقة. ثم انظر إلى مفكرتك بصدق: كم مساءً تُبقيه فارغًا لشخص لم يُفرِغ لك مساءً واحدًا؟ ما يُستخدم هنا هو إتاحتك لنفسك، وهي بالضبط الجزء الذي تملك التحكّم فيه." },
      { type: "p", text: "لا تحتاج إلى اعتراف من أحد. توقّف عن حجز المكان وسيحلّ الأمر نفسه بنفسه: إمّا أن ينتبه ويتقدّم، وإمّا أن ينطفئ بهدوء بلا خصام. لكن أسبوعين هادئين ليسا دكة احتياط. ما يجعله نمطًا هو أن يستمرّ شهورًا، وأن يرتفع الدفء وينخفض تبعًا لخياراته الأخرى لا تبعًا لما تفعله أنت." },
    ],
  },
  ru: {
    term: "Бенчинг",
    summary:
      "Положение запасного: тепла ровно столько, чтобы вы не ушли, но выбирают всё-таки не вас — человек продолжает рассчитывать на тех, кто ему интереснее.",
    blocks: [
      { type: "h2", text: "Откуда взялась скамейка запасных" },
      { type: "p", text: "Слово пришло из командного спорта. Игрока держат в форме, держат рядом, держат готовым — и на поле не выпускают. В отношениях это описывает ту же схему: контакта хватает, чтобы вы оставались доступны, и не хватает, чтобы вы стали планом. Обычно за этим стоит не желание быть с вами, а желание подстраховаться: компания на случай, если предпочтительный вариант сорвётся, и никакого неловкого разговора до тех пор." },
      { type: "p", text: "Это легко перепутать с бредкрамбингом, и признаки действительно пересекаются. Разница в том, зачем нужен контакт. Бредкрамбинг — про сам ручеёк внимания, у которого нет пункта назначения; он возможен и тогда, когда никого другого рядом нет. **Бенчинг — про очерёдность.** Вы где-то в списке, ниже того, на кого сейчас надеются, и сообщения существуют, чтобы удерживать вас там." },
      { type: "h2", text: "Как это распознать" },
      {
        type: "ul",
        items: [
          "Внимание появляется, когда затихают другие варианты: пустая неделя у него — хорошая неделя у вас.",
          "Приглашения гораздо чаще возникают в последний момент, чем планируются заранее.",
          "Тепло наедине и почти полная невидимость в остальной его жизни.",
          "Ни один шаг вперёд не отклоняют, его откладывают: не сейчас, вот пройдёт запара.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Попросите об одной обычной вещи, которую выбранный человек получает не задумываясь: встреча, назначенная за неделю, суббота вместо вторника в одиннадцать вечера, вечер с кем-то из его друзей. Держите это легко — это просьба, а не саммит об отношениях. Потом честно посмотрите в свой календарь. Сколько вечеров вы держите свободными для того, кто ни одного не освободил для вас? Используют вашу доступность, и именно она в вашей власти." },
      { type: "p", text: "Вам не нужно ничьё признание. Перестаньте держать место, и всё разрешится само: либо это заметят и сделают шаг, либо всё тихо закончится без ссоры. Но две спокойные недели — ещё не скамейка. Закономерностью это делают месяцы и то, что тепло поднимается и падает вслед за его другими вариантами, а не за тем, что делаете вы." },
    ],
  },
  pt: {
    term: "Benching",
    summary:
      "Ficar no banco de reservas: calor suficiente para você não ir embora, sem nunca ser a escolha, enquanto a outra pessoa segue de olho em quem realmente prefere.",
    blocks: [
      { type: "h2", text: "De onde vem a imagem do banco" },
      { type: "p", text: "A palavra vem do esporte coletivo. O jogador do elenco é mantido em forma, mantido por perto, mantido pronto — e nunca entra em campo. No namoro descreve o mesmo arranjo: contato suficiente para você continuar disponível, insuficiente para você virar o plano. Quase sempre nasce da vontade de ter um seguro, não de ter você: companhia caso a opção preferida não dê certo, e nenhuma conversa desconfortável nesse meio-tempo." },
      { type: "p", text: "É fácil confundir com breadcrumbing, e os sinais se sobrepõem mesmo. A diferença está no que o contato serve. O breadcrumbing tem a ver com o gotejamento em si: atenção sem destino, que pode acontecer sem mais ninguém em cena. **O benching tem a ver com ordem de preferência.** Você está em algum ponto de uma lista, abaixo de quem a pessoa espera no momento, e as mensagens existem para te manter ali." },
      { type: "h2", text: "Como reconhecer" },
      {
        type: "ul",
        items: [
          "A atenção aparece quando as outras opções esfriam: a semana fraca dela é a sua semana boa.",
          "Os convites chegam em cima da hora muito mais vezes do que combinados com antecedência.",
          "Caloroso a sós e praticamente invisível no resto da vida dela.",
          "Nenhum passo à frente é recusado, é adiado: agora não, quando essa correria passar.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer" },
      { type: "p", text: "Peça uma coisa comum que quem é escolhido recebe sem pedir: um programa marcado com uma semana de antecedência, um sábado em vez de uma terça às onze da noite, uma noite com algum amigo dela. Mantenha leve: é um pedido, não uma cúpula sobre a relação. Depois olhe a sua própria agenda com honestidade. Quantas noites você deixa livres para alguém que nunca deixou uma livre por você? O que está sendo usado é a sua disponibilidade, e essa parte é justamente a que você controla." },
      { type: "p", text: "Você não precisa que ninguém admita nada. Pare de guardar o espaço e a coisa se resolve sozinha: ou a pessoa percebe e dá um passo, ou acaba em silêncio, sem briga. Mas duas semanas paradas não são um banco de reservas. O que faz disso um padrão é durar meses e o calor subir e descer conforme as outras opções dela, não conforme o que você faz." },
    ],
  },
  it: {
    term: "Benching",
    summary:
      "Restare in panchina: calore quanto basta per non andartene, senza essere mai la scelta, mentre l'altra persona continua a puntare su chi preferirebbe davvero.",
    blocks: [
      { type: "h2", text: "Da dove arriva l'immagine della panchina" },
      { type: "p", text: "La parola viene dallo sport di squadra. Il giocatore in rosa viene tenuto in forma, tenuto vicino, tenuto pronto — e non entra mai in campo. Nelle frequentazioni descrive lo stesso accordo: contatto quanto basta perché tu resti disponibile, non abbastanza perché tu diventi il programma. Di solito nasce dal volere una garanzia più che dal volere te: compagnia se l'opzione preferita salta, e nessuna conversazione scomoda nel frattempo." },
      { type: "p", text: "Si confonde facilmente con il breadcrumbing, e i segnali in effetti si sovrappongono. La differenza sta in che cosa serve il contatto. Il breadcrumbing riguarda il gocciolare in sé: attenzione senza destinazione, che può esserci anche senza nessun altro in scena. **Il benching riguarda una graduatoria.** Sei da qualche parte in un elenco, sotto la persona su cui si sta sperando adesso, e i messaggi servono a tenerti lì." },
      { type: "h2", text: "Come riconoscerlo" },
      {
        type: "ul",
        items: [
          "L'attenzione arriva quando le sue altre opzioni si spengono: una settimana vuota per lei è una buona settimana per te.",
          "Gli inviti arrivano all'ultimo momento molto più spesso di quanto vengano organizzati.",
          "Caldo in privato e praticamente invisibile nel resto della sua vita.",
          "Nessun passo avanti viene rifiutato, viene rimandato: non adesso, quando finisce questo periodo.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa fare" },
      { type: "p", text: "Chiedi una cosa normale che chi viene scelto ottiene senza doverla chiedere: un programma fissato con una settimana di anticipo, un sabato invece di un martedì alle undici di sera, una serata con un suo amico. Tienila leggera: è una richiesta, non un vertice sulla relazione. Poi guarda con onestà la tua agenda. Quante sere tieni libere per chi non ne ha mai tenuta libera una per te? Quello che viene usato è la tua disponibilità, ed è anche la parte che dipende da te." },
      { type: "p", text: "Non ti serve che nessuno ammetta niente. Smetti di tenere lo spazio e la cosa si risolve da sola: o se ne accorge e si fa avanti, o finisce in silenzio senza litigi. Due settimane tranquille però non sono una panchina. A farne uno schema sono i mesi, e il fatto che il calore salga e scenda insieme alle sue altre opzioni e non a quello che fai tu." },
    ],
  },
  ja: {
    term: "ベンチング",
    summary:
      "いわゆる「キープ」に近い状態のこと。離れずにいられる程度の温かさは向けられるのに選ばれることはなく、相手はより望んでいる相手のほうを見続けています。",
    blocks: [
      { type: "h2", text: "なぜ「ベンチ」なのか" },
      { type: "p", text: "言葉の出どころはチームスポーツです。控えの選手はコンディションを保たれ、近くに置かれ、いつでも出られる状態にされて、それでもピッチには立たせてもらえません。恋愛でも同じ配置を指します。こちらが連絡の取れる相手であり続ける程度の接触はあり、本命の予定になるほどの接触はない。多くは「あなたが欲しい」ではなく「保険が欲しい」から始まります。本命が流れたときの相手が確保でき、その間は気まずい話をしなくて済むからです。" },
      { type: "p", text: "ブレッドクラミングと混同されやすく、実際に兆候も重なります。違いは、その連絡が何のためにあるかです。ブレッドクラミングは滴り落ちる連絡そのものの話で、行き先がない好意を指し、ほかに誰もいなくても起こります。**ベンチングは順位の話です。**あなたはリストのどこかにいて、いま相手が期待している人の下にいて、メッセージはあなたをそこに留めておくために送られます。" },
      { type: "h2", text: "見分け方" },
      {
        type: "ul",
        items: [
          "相手のほかの選択肢が静かになると連絡が来る。相手の暇な週が、あなたの良い週になる。",
          "誘いは前もって決まるより、直前に来ることのほうがずっと多い。",
          "二人のときは温かいのに、相手の生活のほかの場面ではほぼ存在していない。",
          "前に進む話は断られるのではなく、先送りされる。いまは無理、この忙しさが落ち着いたら。",
        ],
      },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "選ばれている人なら当たり前に手に入る、ごく普通のことをひとつ頼んでみてください。一週間前に決める予定、夜十一時の連絡ではなく土曜日、相手の友人と会う夜。軽く言えば十分です。これはお願いであって、関係についての首脳会談ではありません。そのうえで自分の予定表を正直に見てください。あなたのために一晩も空けたことのない人のために、何回空けているでしょうか。使われているのはあなたの空き時間で、そこだけは自分で決められます。" },
      { type: "p", text: "誰かに認めてもらう必要はありません。空けておくのをやめれば、話は自然に片づきます。気づいて前に出てくるか、争いもなく静かに終わるかのどちらかです。ただし、連絡の少ない二週間はベンチではありません。それを傾向にするのは何か月という長さと、温度があなたの行動ではなく相手のほかの選択肢に合わせて上下していることです。" },
    ],
  },
  ko: {
    term: "벤칭",
    summary:
      "흔히 말하는 어장관리와 겹치는 자리로, 떠나지 않을 만큼의 다정함은 받지만 선택은 받지 못한 채 상대가 더 원하는 사람을 계속 살피는 상황을 말합니다.",
    blocks: [
      { type: "h2", text: "왜 하필 벤치일까" },
      { type: "p", text: "단어는 팀 스포츠에서 왔습니다. 후보 선수는 몸 상태를 유지하고, 가까이 두고, 언제든 뛸 수 있게 두면서도 정작 경기장에는 들여보내지 않습니다. 연애에서도 같은 배치를 가리킵니다. 당신이 연락되는 사람으로 남을 만큼의 접촉은 있고, 본 계획이 될 만큼의 접촉은 없습니다. 대개는 당신을 원해서가 아니라 보험을 원해서 시작됩니다. 원하던 쪽이 어긋났을 때의 상대가 확보되고, 그때까지 불편한 대화도 없으니까요." },
      { type: "p", text: "브레드크럼빙과 헷갈리기 쉽고 신호도 실제로 겹칩니다. 차이는 그 연락이 무엇을 위한 것인가에 있습니다. 브레드크럼빙은 흘려보내는 관심 자체에 관한 말입니다. 목적지가 없는 다정함이고, 다른 사람이 아무도 없어도 일어납니다. **벤칭은 순위에 관한 말입니다.** 당신은 어떤 목록의 어딘가, 상대가 지금 기대하는 사람 아래에 있고, 메시지는 당신을 거기에 붙잡아 두기 위해 옵니다." },
      { type: "h2", text: "어떻게 알아볼까" },
      {
        type: "ul",
        items: [
          "상대의 다른 선택지가 조용해질 때 연락이 옵니다. 그 사람의 한산한 주가 당신의 좋은 주가 됩니다.",
          "약속은 미리 잡히기보다 갑자기 잡히는 경우가 훨씬 많습니다.",
          "둘이 있을 때는 다정한데, 그 사람의 나머지 삶에서는 거의 보이지 않습니다.",
          "앞으로 나아가는 이야기는 거절되지 않고 미뤄집니다. 지금은 말고, 이 바쁜 시기만 지나면.",
        ],
      },
      { type: "h2", accent: "green", text: "무엇을 하면 좋을까" },
      { type: "p", text: "선택받은 사람이라면 당연히 얻는 평범한 것 하나를 청해 보세요. 일주일 전에 잡는 약속, 밤 열한 시의 연락이 아니라 토요일, 그 사람 친구와 함께하는 저녁. 가볍게 말하면 됩니다. 이건 부탁이지 관계 정상회담이 아닙니다. 그다음에는 자신의 일정을 정직하게 보세요. 당신을 위해 저녁 한 번 비운 적 없는 사람을 위해 몇 번을 비워 두었나요. 쓰이고 있는 건 당신의 시간이고, 그 부분만큼은 당신이 정할 수 있습니다." },
      { type: "p", text: "누구의 인정도 필요하지 않습니다. 자리를 비워 두기를 멈추면 상황은 저절로 정리됩니다. 알아채고 앞으로 나오거나, 다툼 없이 조용히 끝나거나 둘 중 하나입니다. 다만 조용한 2주가 곧 벤치는 아닙니다. 이것을 패턴으로 만드는 건 몇 달이라는 시간과, 온도가 당신이 하는 일이 아니라 상대의 다른 선택지를 따라 오르내린다는 사실입니다." },
    ],
  },
  zh: {
    term: "备胎",
    summary:
      "对方给的温度刚好够你不离开，却从来不会真正选你，同时继续等着他更想要的人。英文里叫 benching，也就是被放在替补席上。",
    blocks: [
      { type: "h2", text: "为什么说是替补席" },
      { type: "p", text: "这个说法来自团队运动。替补球员被养着状态、留在身边、随时待命，可就是不派上场。放到感情里是同样的安排：联系多到足以让你随叫随到，少到不足以让你成为正式计划。多数时候，他要的不是你，而是一份保险——万一心里那个人没成，还有人陪着，而在那之前也不用进行一场尴尬的对话。" },
      { type: "p", text: "它很容易和撒面包屑弄混，信号确实有重叠。区别在于这些联系是为了什么。撒面包屑说的是那点断断续续的关注本身，是没有去处的好意，哪怕身边根本没有别人也会发生。**备胎说的是排序**：你在一张名单上的某个位置，排在他当下真正期待的人后面，而那些消息存在的意义，就是把你留在那个位置上。" },
      { type: "h2", text: "怎么看出来" },
      {
        type: "ul",
        items: [
          "他别的选项一安静，消息就来了；他空的那一周，就是你以为很好的那一周。",
          "邀约多半是临时起意，很少是提前约好的。",
          "私下里很热络，在他生活的其他场合几乎看不到你。",
          "任何往前一步的事都不是被拒绝，而是被推迟：现在不行，等这阵忙完。",
        ],
      },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "提一件被选中的人本来就会得到的普通事：提前一周定下的约、周六而不是周二晚上十一点、和他某个朋友一起吃顿饭。语气放轻，这是一个请求，不是关系峰会。然后诚实地看看自己的日程：你为一个从没为你空出过晚上的人，空出了多少个晚上？被使用的是你的时间，而这恰恰是你自己能决定的部分。" },
      { type: "p", text: "你不需要谁承认什么。别再替他留位置，事情自己就会有结果：他要么察觉到并往前走一步，要么安安静静地结束，不用吵。不过安静的两个星期还算不上替补席。让它成为一种模式的，是持续了好几个月，以及那份热度跟着他的其他选项起落，而不是跟着你做了什么。" },
    ],
  },
  nl: {
    term: "Benching",
    summary:
      "Als reserve gehouden worden: warm genoeg om te blijven, nooit echt gekozen, terwijl de ander blijft mikken op de opties die hij liever zou hebben.",
    blocks: [
      { type: "h2", text: "Waar het beeld van de reservebank vandaan komt" },
      { type: "p", text: "Het woord komt uit de teamsport. Een speler uit de selectie wordt fit gehouden, dichtbij gehouden, klaargehouden — en komt nooit het veld in. In het daten beschrijft het dezelfde opstelling: genoeg contact om beschikbaar te blijven, te weinig om het plan te worden. Meestal komt het voort uit het willen van een zekerheidje in plaats van het willen van jou: gezelschap als de favoriete optie afvalt, en tot die tijd geen ongemakkelijk gesprek." },
      { type: "p", text: "Het wordt makkelijk verward met breadcrumbing, en de signalen overlappen ook echt. Het verschil zit in waar het contact voor dient. Breadcrumbing gaat over het druppelen zelf: aandacht zonder bestemming, die er ook kan zijn als er verder niemand in beeld is. **Benching gaat over rangorde.** Je staat ergens op een lijstje, onder degene op wie nu gehoopt wordt, en de berichten zijn er om je daar te houden." },
      { type: "h2", text: "Hoe je het herkent" },
      {
        type: "ul",
        items: [
          "De aandacht komt als de andere opties stil vallen: een rustige week bij hem is een goede week bij jou.",
          "Uitnodigingen komen veel vaker op het laatste moment dan gepland.",
          "Warm onder vier ogen en zo goed als onzichtbaar in de rest van zijn leven.",
          "Geen stap vooruit wordt geweigerd, alles wordt uitgesteld: nu even niet, na deze drukke periode.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je kunt doen" },
      { type: "p", text: "Vraag om één gewone dingetje dat iemand die gekozen is vanzelf krijgt: een afspraak die een week van tevoren staat, een zaterdag in plaats van een dinsdag om elf uur, een avond met een vriend van hem. Houd het licht: het is een verzoek, geen top over de relatie. Kijk daarna eerlijk naar je eigen agenda. Hoeveel avonden houd je vrij voor iemand die er nooit een voor jou vrijhield? Wat gebruikt wordt is jouw beschikbaarheid, en dat is precies het stuk dat jij bepaalt." },
      { type: "p", text: "Je hebt niemands bekentenis nodig. Stop met plek vrijhouden en het lost zichzelf op: of het valt op en iemand zet een stap, of het eindigt stil, zonder ruzie. Twee rustige weken zijn trouwens nog geen reservebank. Wat er een patroon van maakt, is dat het maanden duurt en dat de warmte meebeweegt met zijn andere opties in plaats van met wat jij doet." },
    ],
  },
  pl: {
    term: "Benching",
    summary:
      "Bycie trzymanym na ławce rezerwowych: dość ciepła, żeby nie odejść, ale nigdy wybór numer jeden, podczas gdy druga osoba wciąż liczy na kogoś, kogo wolałaby bardziej.",
    blocks: [
      { type: "h2", text: "Skąd wzięła się ławka rezerwowych" },
      { type: "p", text: "Słowo pochodzi ze sportów drużynowych. Zawodnika z kadry utrzymuje się w formie, trzyma blisko i w gotowości, a na boisko nigdy nie wypuszcza. W randkowaniu opisuje ten sam układ: kontaktu jest tyle, żebyś pozostał dostępny, i za mało, żebyś stał się planem. Zwykle nie chodzi o chęć bycia z tobą, tylko o zabezpieczenie: towarzystwo, gdyby preferowana opcja się nie udała, a do tego czasu żadnej niewygodnej rozmowy." },
      { type: "p", text: "Łatwo pomylić to z breadcrumbingiem i sygnały rzeczywiście się pokrywają. Różnica polega na tym, czemu ten kontakt służy. Breadcrumbing dotyczy samego sączenia uwagi: sympatii bez celu, która zdarza się nawet wtedy, gdy nikogo innego nie ma w polu widzenia. **Benching dotyczy kolejności.** Jesteś gdzieś na liście, poniżej osoby, na którą ktoś właśnie liczy, a wiadomości istnieją po to, żeby cię tam utrzymać." },
      { type: "h2", text: "Jak to rozpoznać" },
      {
        type: "ul",
        items: [
          "Uwaga pojawia się, gdy inne opcje milkną: jego pusty tydzień to twój dobry tydzień.",
          "Zaproszenia przychodzą na ostatnią chwilę znacznie częściej niż z wyprzedzeniem.",
          "Ciepło w cztery oczy i niemal całkowita nieobecność w reszcie jego życia.",
          "Żaden krok naprzód nie zostaje odrzucony, tylko przełożony: nie teraz, jak minie ten młyn.",
        ],
      },
      { type: "h2", accent: "green", text: "Co możesz zrobić" },
      { type: "p", text: "Poproś o jedną zwyczajną rzecz, którą osoba wybrana dostaje bez proszenia: spotkanie umówione tydzień wcześniej, sobotę zamiast wtorku o jedenastej wieczorem, wieczór z kimś z jego znajomych. Powiedz to lekko — to prośba, a nie szczyt w sprawie relacji. Potem uczciwie spójrz na własny kalendarz. Ile wieczorów trzymasz wolnych dla kogoś, kto nie zwolnił ani jednego dla ciebie? Używana jest twoja dostępność i akurat ona zależy od ciebie." },
      { type: "p", text: "Nie potrzebujesz niczyjego przyznania się. Przestań trzymać miejsce, a sprawa rozwiąże się sama: albo ktoś to zauważy i zrobi krok, albo wszystko wygaśnie po cichu, bez kłótni. Dwa spokojne tygodnie to jednak jeszcze nie ławka. Wzorcem czynią to miesiące i to, że ciepło rośnie i opada wraz z jego innymi opcjami, a nie z tym, co robisz ty." },
    ],
  },
  sv: {
    term: "Benching",
    summary:
      "Att hållas som reserv: precis så mycket värme att du stannar, men aldrig att bli vald, medan den andra fortsätter satsa på dem hen hellre vill ha.",
    blocks: [
      { type: "h2", text: "Varifrån bilden av bänken kommer" },
      { type: "p", text: "Ordet kommer från lagsporten. En spelare i truppen hålls i form, hålls nära och hålls redo — och släpps aldrig in på planen. I dejtandet beskriver det samma upplägg: tillräckligt med kontakt för att du ska vara tillgänglig, för lite för att du ska bli planen. Oftast handlar det om att vilja ha en försäkring snarare än att vilja ha dig: sällskap om det förstahandsvalet spricker, och inget obekvämt samtal under tiden." },
      { type: "p", text: "Det förväxlas lätt med breadcrumbing, och tecknen går verkligen i varandra. Skillnaden ligger i vad kontakten är till för. Breadcrumbing handlar om själva droppandet: uppmärksamhet utan destination, som kan finnas även om ingen annan är med i bilden. **Benching handlar om rangordning.** Du står någonstans på en lista, under den som hen just nu hoppas på, och meddelandena finns för att hålla dig kvar där." },
      { type: "h2", text: "Så känner du igen det" },
      {
        type: "ul",
        items: [
          "Uppmärksamheten kommer när de andra alternativen tystnar: en lugn vecka för hen är en bra vecka för dig.",
          "Inbjudningar dyker upp i sista stund betydligt oftare än de planeras.",
          "Varm på tu man hand och i stort sett osynlig i resten av hens liv.",
          "Inget steg framåt nekas, allt skjuts upp: inte nu, när det här ruschet lagt sig.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Be om en enda vanlig sak som den som är vald får utan att fråga: en plan gjord en vecka i förväg, en lördag i stället för en tisdag klockan elva, en kväll med någon av hens vänner. Håll det lätt — det är en fråga, inte ett toppmöte om relationen. Titta sedan ärligt i din egen kalender. Hur många kvällar håller du fria för någon som aldrig hållit en fri för dig? Det som används är din tillgänglighet, och det är också den del du styr över." },
      { type: "p", text: "Du behöver ingens erkännande. Sluta hålla platsen ledig så löser det sig av sig självt: antingen märks det och någon tar ett steg, eller så tar det slut i tysthet utan bråk. Två lugna veckor är dock ingen bänk. Det som gör det till ett mönster är månaderna, och att värmen följer hens andra alternativ i stället för det du gör." },
    ],
  },
  hi: {
    term: "बेंचिंग",
    summary:
      "इतनी गर्मजोशी कि आप चले न जाएँ, पर चुना कभी नहीं जाना — सामने वाला आपको हाथ में रखता है और उन विकल्पों पर टिका रहता है जो उसे ज़्यादा पसंद हैं।",
    blocks: [
      { type: "h2", text: "बेंच वाली उपमा कहाँ से आई" },
      { type: "p", text: "शब्द टीम खेलों से आया है। रिज़र्व खिलाड़ी को फ़िट रखा जाता है, पास रखा जाता है, तैयार रखा जाता है — और मैदान पर कभी नहीं उतारा जाता। रिश्तों में भी यही व्यवस्था है: इतना संपर्क कि आप उपलब्ध बने रहें, इतना नहीं कि आप असली योजना बन जाएँ। ज़्यादातर इसकी जड़ आपको चाहना नहीं, बल्कि एक बीमा चाहना होती है — पसंदीदा विकल्प बिगड़ जाए तो साथ मौजूद रहे, और तब तक कोई असहज बातचीत भी न करनी पड़े।" },
      { type: "p", text: "इसे ब्रेडक्रंबिंग समझ लेना आसान है और संकेत सचमुच मिलते-जुलते हैं। फ़र्क़ इसमें है कि वह संपर्क किस काम आ रहा है। ब्रेडक्रंबिंग उस टपकते ध्यान की बात है जिसका कोई ठिकाना नहीं होता, और वह तब भी हो सकता है जब तस्वीर में कोई तीसरा न हो। **बेंचिंग क्रम की बात है।** आप किसी सूची में कहीं हैं, उस व्यक्ति से नीचे जिस पर अभी उम्मीद टिकी है, और मैसेज इसीलिए आते हैं कि आप वहीं बने रहें।" },
      { type: "h2", text: "कैसे पहचानें" },
      {
        type: "ul",
        items: [
          "ध्यान तब आता है जब उसके बाक़ी विकल्प चुप हो जाते हैं; उसका ख़ाली हफ़्ता आपका अच्छा हफ़्ता बन जाता है।",
          "बुलावे पहले से तय होने के बजाय अक्सर ऐन वक़्त पर आते हैं।",
          "अकेले में गर्मजोशी, और उसकी बाक़ी ज़िंदगी में आप लगभग अदृश्य।",
          "आगे बढ़ने वाली हर बात मना नहीं की जाती, टाल दी जाती है: अभी नहीं, यह व्यस्तता निकल जाए तब।",
        ],
      },
      { type: "h2", accent: "green", text: "क्या किया जा सकता है" },
      { type: "p", text: "एक साधारण चीज़ माँगिए जो चुने हुए इंसान को यूँ ही मिल जाती है: एक हफ़्ता पहले तय हुई मुलाक़ात, मंगलवार रात ग्यारह बजे नहीं बल्कि शनिवार, उसके किसी दोस्त के साथ एक शाम। बात हल्की रखिए — यह एक गुज़ारिश है, रिश्ते पर शिखर वार्ता नहीं। फिर ईमानदारी से अपना कैलेंडर देखिए। जिसने आपके लिए एक शाम नहीं छोड़ी, उसके लिए आपने कितनी शामें ख़ाली रखी हैं? यहाँ इस्तेमाल आपकी उपलब्धता की हो रही है, और यही हिस्सा आपके अपने हाथ में है।" },
      { type: "p", text: "आपको किसी के क़ुबूल करने की ज़रूरत नहीं। जगह ख़ाली रखना बंद कीजिए, बात अपने आप सुलझ जाएगी: या तो उसे एहसास होगा और वह आगे आएगा, या सब चुपचाप बिना झगड़े ख़त्म हो जाएगा। हाँ, दो शांत हफ़्ते बेंच नहीं होते। इसे पैटर्न बनाती है महीनों की लंबाई, और यह कि गर्माहट आपके किए पर नहीं, उसके दूसरे विकल्पों पर घटती-बढ़ती है।" },
    ],
  },
};
