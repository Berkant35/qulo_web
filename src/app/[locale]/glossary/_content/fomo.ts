import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * FOMO — in dating, the sense that a better option is one more scroll away, and
 * what that does to the conversation you are already in.
 *
 * Statistics: none, deliberately. The obvious temptations here ("most people
 * keep several conversations open", "X% swipe during dates") have no source
 * that survives checking, so the page argues the mechanism instead of quoting
 * numbers. The burnout figure lives on `swipe-fatigue.ts` and is not repeated
 * here — one page, one use, with the full attribution.
 *
 * Qulo angle: none. FOMO is a property of any large queue of people and nothing
 * about a question quiz removes it, so block 7 is used for something the reader
 * can actually apply — that the feeling forecasts nothing, and a smaller,
 * answerable question to replace it with.
 *
 * Term names: FOMO travels as a loanword almost everywhere and is written in
 * Latin script even in ja/hi/ru copy, so those locales keep "FOMO" and gloss it
 * in the summary. zh (错失恐惧), ko (포모) and ar (الخوف من الفوات) have genuine
 * native renderings in circulation and use them, with the English form in
 * brackets since both are read. Do not "fix" the Latin-script ja/hi/ru terms
 * into invented native coinages — that would be less accurate, not more.
 */
export const fomo: LocalizedGlossaryEntry = {
  en: {
    term: "FOMO",
    summary:
      "The nagging sense that someone better is one more scroll away — short for fear of missing out, and the reason so many people stay half-present in the conversation they are already having.",
    blocks: [
      { type: "h2", text: "Why an endless queue produces it" },
      { type: "p", text: "Dating apps present people the way a shop presents stock: a supply that appears to have no bottom. Your mind reads that as abundance, and abundance changes how you value whatever is in front of you. If there is always another profile, the person you are talking to stops feeling like a decision and starts feeling like a placeholder — good for now, pending something better that has not turned up yet." },
      { type: "p", text: "The comparison is rigged, too. You are weighing a real person, with a slow reply and a joke that did not land, against a stranger's best twelve photographs. Nobody survives that on equal footing. The feeling is not information about the person you are talking to; it is a side effect of the queue standing behind them." },
      { type: "h2", text: "How you recognise it" },
      { type: "ul", items: [
        "**You check the app during the date**, or on the way home from it.",
        "**Three conversations, none of them real.** You are holding several people at a shallow depth instead of one at a serious one.",
        "**Plans stay provisional.** You leave Saturday open in case something better appears.",
        "**Small things end it.** A reply that took four hours gets read as proof, because there are forty other options.",
      ] },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Make the choice smaller and more concrete. Pick one or two people and give them a fortnight of proper attention — short enough to feel safe, long enough to tell you something real. Meet in person early, because an actual hour with someone almost always beats an imagined better option. And when the urge to go back to the queue arrives mid-conversation, treat it as a mood passing through, not a verdict you have just reached." },
      { type: "p", text: "It helps to notice what the feeling has actually predicted so far, which is nothing. The endless queue was there last month too, and the month before, and it never delivered the better option it kept promising. Instead of asking whether someone is the best available, try a question you can answer: do you like who you are around them?" },
    ],
  },

  tr: {
    term: "FOMO",
    summary:
      "Bir kaydırma ötede daha iyi biri varmış hissi; İngilizcedeki fear of missing out'un kısaltması ve şu an konuştuğun kişiye yarım yamalak kalmanın en yaygın sebebi.",
    blocks: [
      { type: "h2", text: "Bitmeyen sıra bu hissi nasıl üretiyor" },
      { type: "p", text: "Flört uygulamaları insanları bir vitrindeki stok gibi gösterir: dibi görünmeyen bir arz. Zihin bunu bolluk olarak okur ve bolluk, önündekinin değerini düşürür. Sıradaki profil hep varsa, konuştuğun kişi bir karar olmaktan çıkıp bir yer tutucuya dönüşür: şimdilik iyi, henüz ortaya çıkmamış daha iyisi gelene kadar." },
      { type: "p", text: "Karşılaştırma da hileli zaten. Bir yanda geç cevap yazan, şakası tutmayan gerçek bir insan var; diğer yanda bir yabancının en iyi on iki fotoğrafı. Bu terazide kimse ayakta kalmaz. Yani bu his, konuştuğun kişi hakkında bir bilgi değil; arkasındaki sıranın yan etkisi." },
      { type: "h2", text: "Nasıl anlarsın" },
      { type: "ul", items: [
        "**Buluşma sırasında uygulamayı açıyorsun**, ya da eve dönerken.",
        "**Üç sohbet var, hiçbiri gerçek değil.** Birkaç kişiyi yüzeyde tutuyorsun, bir kişiyle derine inmiyorsun.",
        "**Planlar hep askıda.** Daha iyisi çıkar diye cumartesini boş bırakıyorsun.",
        "**Küçük şeyler bitiriyor.** Dört saat sonra gelen bir cevap kanıt sayılıyor, çünkü kırk seçenek daha var.",
      ] },
      { type: "h2", accent: "green", text: "Ne yapabilirsin" },
      { type: "p", text: "Seçimi küçült ve somutlaştır. Bir ya da iki kişi seç, onlara iki hafta boyunca düzgün bir ilgi ver: kaybolacak kadar uzun değil, bir şey öğretecek kadar da kısa değil. Erken buluş, çünkü biriyle geçirilen gerçek bir saat, hayalindeki daha iyi seçeneği neredeyse her zaman yener. Sohbetin ortasında sıraya dönme dürtüsü geldiğinde de bunu geçip gidecek bir ruh hali say, verilmiş bir karar değil." },
      { type: "p", text: "Bu hissin bugüne kadar neyi doğru tahmin ettiğine bakmak işe yarıyor: hiçbir şeyi. O bitmeyen sıra geçen ay da oradaydı, ondan önceki ay da; sürekli vaat ettiği daha iyisini bir türlü getirmedi. 'Elimdekilerin en iyisi mi?' yerine cevabı olan bir soru sor: onun yanındayken kendini nasıl buluyorsun?" },
    ],
  },

  de: {
    term: "FOMO",
    summary:
      "Das nagende Gefühl, dass die bessere Option nur einen Wisch entfernt wartet — kurz für fear of missing out, und der Grund, warum so viele im laufenden Gespräch nur halb anwesend sind.",
    blocks: [
      { type: "h2", text: "Warum eine endlose Schlange dieses Gefühl erzeugt" },
      { type: "p", text: "Dating-Apps präsentieren Menschen wie ein Laden seine Ware: ein Angebot, das scheinbar keinen Boden hat. Der Kopf liest das als Überfluss, und Überfluss verändert, wie viel einem das wert ist, was gerade vor einem steht. Wenn immer noch ein Profil kommt, fühlt sich die Person im Chat nicht mehr wie eine Entscheidung an, sondern wie ein Platzhalter — gut für jetzt, bis etwas Besseres auftaucht." },
      { type: "p", text: "Der Vergleich ist außerdem manipuliert. Auf der einen Seite steht ein echter Mensch, mit später Antwort und einem Witz, der nicht gezündet hat. Auf der anderen die zwölf besten Fotos einer fremden Person. Das übersteht niemand fair. Das Gefühl sagt nichts über dein Gegenüber aus, es ist ein Nebeneffekt der Schlange dahinter." },
      { type: "h2", text: "Woran du es erkennst" },
      { type: "ul", items: [
        "**Du schaust während des Dates in die App**, oder auf dem Heimweg.",
        "**Drei Gespräche, keins davon echt.** Du hältst mehrere Menschen an der Oberfläche statt einen in der Tiefe.",
        "**Pläne bleiben unverbindlich.** Der Samstag bleibt frei, falls noch etwas Besseres kommt.",
        "**Kleinigkeiten beenden es.** Eine Antwort nach vier Stunden gilt als Beweis, weil vierzig andere Optionen danebenliegen.",
      ] },
      { type: "h2", accent: "green", text: "Was du dagegen tun kannst" },
      { type: "p", text: "Mach die Wahl kleiner und konkreter. Such dir eine oder zwei Personen aus und schenk ihnen zwei Wochen ernsthafte Aufmerksamkeit — kurz genug, dass es sich sicher anfühlt, lang genug, dass du etwas erfährst. Triff dich früh, denn eine echte Stunde mit jemandem schlägt die eingebildete bessere Option fast immer. Und wenn mitten im Gespräch der Drang zur Schlange kommt: eine Stimmung, kein Urteil." },
      { type: "p", text: "Es hilft, sich anzusehen, was dieses Gefühl bisher vorhergesagt hat: nichts. Die endlose Schlange gab es letzten Monat auch, und den Monat davor, und das versprochene Bessere kam nie an. Statt zu fragen, ob jemand das Beste ist, was verfügbar ist, frag etwas Beantwortbares: Magst du, wie du in ihrer Nähe bist?" },
    ],
  },

  fr: {
    term: "FOMO",
    summary:
      "Cette impression tenace que quelqu'un de mieux se trouve un scroll plus loin — abréviation de fear of missing out, et la raison pour laquelle tant de gens ne sont qu'à moitié présents dans la conversation en cours.",
    blocks: [
      { type: "h2", text: "Pourquoi une file sans fin fabrique ce sentiment" },
      { type: "p", text: "Les applis présentent les gens comme un magasin présente son stock : une offre dont on ne voit jamais le fond. L'esprit lit ça comme de l'abondance, et l'abondance change la valeur de ce qu'on a sous les yeux. S'il y a toujours un profil de plus, la personne à qui vous parlez cesse d'être un choix et devient une place gardée au chaud, en attendant mieux." },
      { type: "p", text: "La comparaison est truquée, en plus. D'un côté une vraie personne, avec une réponse tardive et une blague qui tombe à plat ; de l'autre les douze meilleures photos d'un inconnu. Personne ne tient sur cette balance. Ce sentiment ne vous renseigne pas sur la personne en face : c'est un effet secondaire de la file qui se tient derrière elle." },
      { type: "h2", text: "Comment le reconnaître" },
      { type: "ul", items: [
        "**Vous regardez l'appli pendant le rendez-vous**, ou sur le chemin du retour.",
        "**Trois conversations, aucune de vraie.** Vous tenez plusieurs personnes en surface au lieu d'une en profondeur.",
        "**Les plans restent flous.** Vous gardez le samedi libre au cas où mieux se présenterait.",
        "**Un rien suffit à tout arrêter.** Une réponse qui met quatre heures devient une preuve, puisqu'il reste quarante autres options.",
      ] },
      { type: "h2", accent: "green", text: "Ce que vous pouvez faire" },
      { type: "p", text: "Rendez le choix plus petit et plus concret. Prenez une ou deux personnes et accordez-leur quinze jours d'attention réelle : assez court pour être rassurant, assez long pour apprendre quelque chose. Voyez-vous tôt, parce qu'une heure vécue bat presque toujours une meilleure option imaginée. Et quand l'envie de retourner dans la file surgit en pleine conversation, traitez-la comme une humeur de passage, pas comme un verdict." },
      { type: "p", text: "Il est utile de regarder ce que ce sentiment a prédit jusqu'ici : rien. La file infinie était déjà là le mois dernier, et celui d'avant, et elle n'a jamais livré le mieux qu'elle promettait. Plutôt que de vous demander si cette personne est la meilleure disponible, posez une question à laquelle vous pouvez répondre : est-ce que vous vous aimez bien, à côté d'elle ?" },
    ],
  },

  es: {
    term: "FOMO",
    summary:
      "La sensación pegajosa de que alguien mejor está a un scroll de distancia — siglas de fear of missing out, el miedo a perderse algo, y el motivo de estar solo a medias en la conversación que ya tienes.",
    blocks: [
      { type: "h2", text: "Por qué lo produce una fila interminable" },
      { type: "p", text: "Las apps enseñan a las personas como una tienda enseña su stock: una oferta que no parece tener fondo. La cabeza lo lee como abundancia, y la abundancia cambia lo que vale lo que tienes delante. Si siempre hay otro perfil, la persona con la que hablas deja de ser una decisión y pasa a ser un sitio reservado: bien por ahora, a la espera de algo mejor que todavía no ha aparecido." },
      { type: "p", text: "Además, la comparación está trucada. De un lado hay una persona real, que tarda en contestar y suelta un chiste que no hace gracia; del otro, las doce mejores fotos de un desconocido. Nadie sobrevive a esa balanza. La sensación no te informa sobre quien tienes enfrente: es un efecto secundario de la cola que espera detrás." },
      { type: "h2", text: "Cómo reconocerlo" },
      { type: "ul", items: [
        "**Miras la app durante la cita**, o de camino a casa.",
        "**Tres conversaciones y ninguna real.** Sostienes a varias personas en la superficie en vez de a una en serio.",
        "**Los planes quedan en el aire.** Dejas el sábado libre por si sale algo mejor.",
        "**Cualquier detalle lo corta.** Una respuesta que tarda cuatro horas se lee como prueba, porque hay otras cuarenta opciones.",
      ] },
      { type: "h2", accent: "green", text: "Qué puedes hacer" },
      { type: "p", text: "Haz la elección más pequeña y más concreta. Quédate con una o dos personas y dales quince días de atención de verdad: lo bastante corto para no asustar, lo bastante largo para enterarte de algo. Queda pronto, porque una hora real con alguien casi siempre gana a una opción mejor imaginada. Y cuando aparezcan las ganas de volver a la fila en mitad de una conversación, trátalas como un estado de ánimo, no como una conclusión." },
      { type: "p", text: "Ayuda mirar qué ha acertado esta sensación hasta ahora: nada. La fila infinita también estaba el mes pasado, y el anterior, y nunca trajo eso mejor que prometía. En lugar de preguntarte si esa persona es la mejor disponible, hazte una pregunta con respuesta: ¿te gusta cómo eres cuando estás con ella?" },
    ],
  },

  ar: {
    term: "الخوف من الفوات (FOMO)",
    summary:
      "ذلك الإحساس الملحّ بأن شخصًا أفضل ينتظر على بُعد تمريرة واحدة، وهو ما يجعل كثيرين حاضرين بنصف انتباه في المحادثة التي بين أيديهم أصلًا.",
    blocks: [
      { type: "h2", text: "لماذا يولّد الطابور اللانهائي هذا الشعور؟" },
      { type: "p", text: "تعرض تطبيقات المواعدة الناس كما يعرض المتجر بضاعته: مخزون لا يبدو له قاع. العقل يقرأ ذلك على أنه وفرة، والوفرة تغيّر قيمة ما هو أمامك. فما دام هناك ملف آخر دائمًا، يتوقف الشخص الذي تحادثه عن أن يكون قرارًا ويصير مجرد مكان محجوز: جيد الآن، في انتظار أفضل منه لم يظهر بعد." },
      { type: "p", text: "المقارنة نفسها غير عادلة. في كفة إنسان حقيقي يتأخر في الرد وتمرّ نكتته من دون ضحك، وفي الكفة الأخرى أفضل اثنتي عشرة صورة لشخص غريب. لا أحد ينجو من هذه الموازنة. الشعور إذًا ليس معلومة عمّن تحادثه، بل أثر جانبي للطابور الواقف خلفه." },
      { type: "h2", text: "كيف تعرفه" },
      { type: "ul", items: [
        "**تفتح التطبيق أثناء اللقاء نفسه**، أو في طريق العودة منه.",
        "**ثلاث محادثات ولا واحدة حقيقية.** تمسك بعدة أشخاص على السطح بدل شخص واحد بعمق.",
        "**الخطط تبقى مؤجلة.** تترك يوم العطلة فارغًا تحسّبًا لظهور خيار أفضل.",
        "**تفاصيل صغيرة تُنهي الأمر.** رد يتأخر أربع ساعات يُقرأ كدليل، ما دامت هناك أربعون خيارًا آخر.",
      ] },
      { type: "h2", accent: "green", text: "ما الذي يمكنك فعله" },
      { type: "p", text: "اجعل الاختيار أصغر وأكثر تحديدًا. اختر شخصًا أو اثنين وامنحهما أسبوعين من الانتباه الحقيقي: مدة قصيرة بما يكفي كي تشعر بالأمان، وطويلة بما يكفي كي تعرف شيئًا. قابل الشخص مبكرًا، فساعة واقعية مع إنسان تتفوق غالبًا على خيار أفضل متخيَّل. وحين تأتيك الرغبة في العودة إلى الطابور وسط محادثة، عاملها كمزاج عابر لا كحكم توصّلت إليه." },
      { type: "p", text: "من المفيد أن تسأل: ماذا تنبّأ هذا الشعور به حتى الآن؟ لا شيء. الطابور اللانهائي كان موجودًا الشهر الماضي والذي قبله، ولم يسلّمك يومًا ذلك الأفضل الذي يعد به. بدل السؤال عمّا إذا كان هذا الشخص أفضل المتاح، اسأل سؤالًا له إجابة: هل تحب نفسك حين تكون بجانبه؟" },
    ],
  },

  ru: {
    term: "FOMO",
    summary:
      "Навязчивое ощущение, что кто-то получше находится в одном движении пальца отсюда: сокращение от fear of missing out, из-за которого человек лишь наполовину присутствует в уже начатом разговоре.",
    blocks: [
      { type: "h2", text: "Почему бесконечная очередь порождает это чувство" },
      { type: "p", text: "Приложения показывают людей так, как магазин показывает товар: предложение, у которого будто нет дна. Голова читает это как изобилие, а изобилие меняет цену того, что перед вами. Если следующая анкета есть всегда, человек в переписке перестаёт быть выбором и становится временной заглушкой: пока сойдёт, а там появится кто-то получше." },
      { type: "p", text: "Само сравнение к тому же нечестное. На одной чаше живой человек, который ответил через четыре часа и неудачно пошутил, на другой — двенадцать лучших фотографий незнакомца. Такое соотношение не выдерживает никто. Это чувство не сообщает вам ничего о собеседнике: это побочный эффект очереди, стоящей за ним." },
      { type: "h2", text: "Как это распознать" },
      { type: "ul", items: [
        "**Вы открываете приложение прямо на свидании** или по дороге домой с него.",
        "**Три переписки и ни одной настоящей.** Вы держите нескольких людей на поверхности вместо одного всерьёз.",
        "**Планы остаются подвешенными.** Суббота держится свободной на случай, если подвернётся вариант получше.",
        "**Мелочь всё обрывает.** Ответ, пришедший через четыре часа, считается доказательством, ведь рядом ещё сорок вариантов.",
      ] },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Сделайте выбор меньше и конкретнее. Возьмите одного-двух человек и дайте им две недели настоящего внимания: достаточно коротко, чтобы не было страшно, и достаточно долго, чтобы что-то понять. Встречайтесь рано — реальный час с человеком почти всегда сильнее воображаемого лучшего варианта. А когда посреди разговора тянет вернуться в ленту, считайте это настроением, а не выводом." },
      { type: "p", text: "Полезно посмотреть, что это чувство предсказало до сих пор: ничего. Бесконечная очередь была и в прошлом месяце, и в позапрошлом, и обещанного лучшего так и не выдала. Вместо вопроса «лучший ли это из доступных» задайте тот, на который есть ответ: нравится ли вам, какой вы рядом с этим человеком?" },
    ],
  },

  pt: {
    term: "FOMO",
    summary:
      "Aquela sensação insistente de que alguém melhor está a um scroll de distância — sigla de fear of missing out, o medo de estar perdendo algo, e o motivo de tanta gente ficar só pela metade na conversa que já tem.",
    blocks: [
      { type: "h2", text: "Por que uma fila sem fim produz isso" },
      { type: "p", text: "Os aplicativos mostram pessoas como uma loja mostra estoque: uma oferta que parece não ter fundo. A cabeça lê isso como fartura, e fartura muda o valor do que está na sua frente. Se sempre existe mais um perfil, a pessoa com quem você conversa deixa de ser uma escolha e vira um lugar guardado: serve por enquanto, até aparecer algo melhor." },
      { type: "p", text: "A comparação também é desonesta. De um lado, gente de verdade, que demora para responder e conta uma piada que não pega; do outro, as doze melhores fotos de um desconhecido. Ninguém sobrevive a essa balança. A sensação não informa nada sobre quem está do outro lado: é efeito colateral da fila parada atrás dela." },
      { type: "h2", text: "Como perceber" },
      { type: "ul", items: [
        "**Você abre o app durante o encontro**, ou no caminho de volta.",
        "**Três conversas e nenhuma de verdade.** Você segura várias pessoas na superfície em vez de uma a sério.",
        "**Os planos ficam no ar.** O sábado continua livre caso apareça coisa melhor.",
        "**Qualquer detalhe encerra.** Uma resposta que demorou quatro horas vira prova, porque tem outras quarenta opções.",
      ] },
      { type: "h2", accent: "green", text: "O que dá para fazer" },
      { type: "p", text: "Deixe a escolha menor e mais concreta. Fique com uma ou duas pessoas e dê a elas duas semanas de atenção real: curto o bastante para não assustar, longo o bastante para você descobrir alguma coisa. Marque cedo, porque uma hora de verdade com alguém quase sempre ganha de uma opção melhor imaginada. E quando bater a vontade de voltar para a fila no meio da conversa, trate como humor passageiro, não como conclusão." },
      { type: "p", text: "Ajuda olhar o que essa sensação acertou até hoje: nada. A fila infinita estava lá no mês passado e no anterior, e nunca entregou o tal melhor que vivia prometendo. Em vez de perguntar se a pessoa é a melhor disponível, faça uma pergunta que tem resposta: você gosta de quem você é perto dela?" },
    ],
  },

  it: {
    term: "FOMO",
    summary:
      "La sensazione insistente che qualcuno di meglio sia a uno scroll di distanza — sigla di fear of missing out, e il motivo per cui in tanti restano presenti a metà nella conversazione che hanno già.",
    blocks: [
      { type: "h2", text: "Perché una fila infinita la produce" },
      { type: "p", text: "Le app mostrano le persone come un negozio mostra la merce: un'offerta che sembra non avere fondo. La testa lo legge come abbondanza, e l'abbondanza cambia quanto vale ciò che hai davanti. Se c'è sempre un altro profilo, la persona con cui stai parlando smette di essere una scelta e diventa un posto tenuto occupato: va bene per ora, in attesa di qualcosa di meglio." },
      { type: "p", text: "Il confronto poi è truccato. Da una parte una persona vera, che risponde tardi e fa una battuta che non funziona; dall'altra le dodici foto migliori di uno sconosciuto. Su quella bilancia non regge nessuno. La sensazione non ti dice nulla su chi hai di fronte: è un effetto collaterale della fila che gli sta dietro." },
      { type: "h2", text: "Come riconoscerla" },
      { type: "ul", items: [
        "**Guardi l'app durante l'appuntamento**, o mentre torni a casa.",
        "**Tre conversazioni, nessuna vera.** Tieni più persone in superficie invece di una sul serio.",
        "**I piani restano sospesi.** Lasci libero il sabato nel caso saltasse fuori di meglio.",
        "**Basta un niente per chiudere.** Una risposta arrivata dopo quattro ore diventa una prova, perché ci sono altre quaranta opzioni.",
      ] },
      { type: "h2", accent: "green", text: "Cosa puoi fare" },
      { type: "p", text: "Rendi la scelta più piccola e più concreta. Prendi una o due persone e dedica loro due settimane di attenzione vera: abbastanza breve da non spaventare, abbastanza lungo da farti capire qualcosa. Vedetevi presto, perché un'ora reale con qualcuno batte quasi sempre un'opzione migliore immaginata. E quando a metà chat arriva la voglia di tornare in fila, trattala come un umore di passaggio, non come una conclusione." },
      { type: "p", text: "Aiuta guardare che cosa ha previsto finora questa sensazione: niente. La fila infinita c'era anche il mese scorso, e quello prima, e il meglio promesso non è mai arrivato. Invece di chiederti se quella persona sia la migliore disponibile, fatti una domanda con una risposta: ti piaci, quando sei con lei?" },
    ],
  },

  ja: {
    term: "FOMO",
    summary:
      "もっといい人があと一回スクロールした先にいる気がして落ち着かない感覚。fear of missing out（取り残される不安）の略で、いま話している相手に半分しか向き合えなくなる原因です。",
    blocks: [
      { type: "h2", text: "終わらない行列がこの感覚をつくる" },
      { type: "p", text: "マッチングアプリは、店が在庫を並べるように人を並べます。底が見えない供給です。頭はそれを「豊富さ」として受け取り、豊富さは目の前にあるものの価値を下げます。次のプロフィールが必ずあるなら、いま話している相手は選択ではなく仮置きになります。今のところ悪くない、まだ現れていないもっといい誰かが来るまでは、という位置づけです。" },
      { type: "p", text: "比較そのものも不公平です。片方には、返信が遅く、冗談がすべった生身の人がいる。もう片方には、知らない誰かの厳選された十二枚の写真がある。この天秤に耐えられる人はいません。つまりこの感覚は、目の前の相手についての情報ではなく、その後ろに並ぶ行列の副作用です。" },
      { type: "h2", text: "こんなときは起きています" },
      { type: "ul", items: [
        "**デート中にアプリを開いてしまう。** あるいは帰り道の電車の中で。",
        "**会話は三つ、どれも本物ではない。** 一人と深くではなく、何人かと浅く付き合っている。",
        "**予定がいつも仮のまま。** もっといい話が来るかもしれないと、土曜日を空けておく。",
        "**小さなことで終わりにする。** 四時間後の返信が証拠に見えてしまう。ほかに四十人いるからです。",
      ] },
      { type: "h2", accent: "green", text: "できること" },
      { type: "p", text: "選択をもっと小さく、もっと具体的にしてください。一人か二人を選び、二週間だけきちんと向き合ってみる。怖くならない程度に短く、何かがわかる程度には長い期間です。会うのは早めに。実際に過ごした一時間は、想像の中の「もっといい人」にたいてい勝ちます。会話の途中で行列に戻りたくなったら、それは通り過ぎる気分であって、下した結論ではありません。" },
      { type: "p", text: "この感覚がこれまで何を言い当てたかを見てみると、何も言い当てていません。終わらない行列は先月も先々月もそこにあり、約束していた「もっといい人」を一度も渡してくれませんでした。「この人が今いちばん良い相手か」ではなく、答えの出る問いに変えましょう。その人といるときの自分を、あなたは好きですか。" },
    ],
  },

  ko: {
    term: "포모(FOMO)",
    summary:
      "더 나은 사람이 한 번만 더 넘기면 나올 것 같은 찜찜한 기분. fear of missing out의 줄임말이며, 지금 하고 있는 대화에 절반만 머무르게 만드는 이유이기도 합니다.",
    blocks: [
      { type: "h2", text: "끝없는 줄이 이 기분을 만든다" },
      { type: "p", text: "데이팅 앱은 가게가 재고를 진열하듯 사람을 보여 줍니다. 바닥이 보이지 않는 공급입니다. 머리는 그것을 풍족함으로 읽고, 풍족함은 눈앞에 있는 것의 값을 떨어뜨립니다. 다음 프로필이 늘 있다면 지금 대화하는 사람은 결정이 아니라 임시로 채워 둔 자리가 됩니다. 아직 오지 않은 더 나은 누군가를 기다리는 동안 일단 괜찮은 사람인 셈입니다." },
      { type: "p", text: "비교 자체도 공정하지 않습니다. 한쪽에는 답장이 늦고 농담이 빗나간 실제 사람이 있고, 다른 쪽에는 낯선 사람의 가장 잘 나온 사진 열두 장이 있습니다. 이 저울에서 버틸 사람은 없습니다. 그러니 이 기분은 상대에 대한 정보가 아니라, 그 뒤에 서 있는 줄이 만든 부작용입니다." },
      { type: "h2", text: "이렇게 드러납니다" },
      { type: "ul", items: [
        "**데이트 중에 앱을 봅니다.** 아니면 집으로 돌아오는 길에.",
        "**대화는 셋인데 진짜는 없습니다.** 한 사람과 깊게 가는 대신 여러 사람을 얕게 붙잡고 있습니다.",
        "**약속이 늘 임시입니다.** 더 좋은 일이 생길까 봐 토요일을 비워 둡니다.",
        "**사소한 일로 끝냅니다.** 네 시간 걸린 답장이 증거가 됩니다. 다른 선택지가 마흔 개니까요.",
      ] },
      { type: "h2", accent: "green", text: "이렇게 해 보세요" },
      { type: "p", text: "선택을 더 작고 구체적으로 만드세요. 한두 사람을 골라 이 주 동안 제대로 마음을 써 보는 겁니다. 부담스럽지 않을 만큼 짧고, 무언가를 알게 될 만큼은 긴 기간입니다. 만나는 건 이르게 잡으세요. 실제로 보낸 한 시간은 상상 속 더 나은 선택지를 거의 언제나 이깁니다. 대화 도중 줄로 돌아가고 싶어지면, 그건 지나가는 기분이지 내려진 결론이 아닙니다." },
      { type: "p", text: "이 기분이 지금까지 무엇을 맞혔는지 보면 답이 나옵니다. 아무것도 맞히지 못했습니다. 끝없는 줄은 지난달에도, 그 전달에도 있었지만 약속하던 더 나은 사람을 끝내 건네주지 않았습니다. 이 사람이 최선인지 묻는 대신 답할 수 있는 질문을 하세요. 그 사람 곁에 있을 때의 내가 마음에 드나요?" },
    ],
  },

  zh: {
    term: "错失恐惧（FOMO）",
    summary:
      "总觉得更合适的人就在下一次滑动之后的那种不安，英文缩写 FOMO，也是很多人对眼前这段对话只肯投入一半的原因。",
    blocks: [
      { type: "h2", text: "看不到尽头的队列如何制造这种感觉" },
      { type: "p", text: "交友软件展示人的方式，很像商店展示货架：供给看起来没有底。大脑把它读成「多得很」，而「多得很」会拉低眼前这个人的分量。既然永远还有下一份资料，正在聊的人就不再是一个决定，而变成一个暂时占着的位置——先这样，等更好的出现再说。" },
      { type: "p", text: "而且这个比较本身就不公平。一边是活生生的人，回消息慢，讲的笑话没接住；另一边是陌生人挑出来的十二张最好看的照片。这样的天平谁都撑不住。所以这种感觉并不是关于对面那个人的信息，而是他背后那条队列带来的副作用。" },
      { type: "h2", text: "怎么看出来" },
      { type: "ul", items: [
        "**约会当中还在看软件**，或者在回家的路上刷。",
        "**同时聊三个，没有一个是真的。** 你把几个人都停在浅处，而不是跟一个人认真往下走。",
        "**计划一直悬着。** 周六先空着，怕有更好的安排冒出来。",
        "**一点小事就结束。** 隔了四个小时才回的消息被当成证据，因为还有另外四十个选择。",
      ] },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "把选择变小、变具体。挑一两个人，给他们两周认真的注意力——短到不会让你有压力，长到足以看清一些东西。早一点见面，因为真实相处的一个小时，几乎总是胜过想象里那个更好的选项。聊到一半又想回去刷队列时，把它当成一阵情绪，而不是你刚刚得出的结论。" },
      { type: "p", text: "不妨看看这种感觉到目前为止说准过什么：什么都没有。那条看不到尽头的队列上个月在，上上个月也在，它答应的那个更好的人一直没出现。与其问「这是不是现有里最好的」，不如问一个答得上来的问题：跟这个人在一起时的自己，你喜欢吗？" },
    ],
  },

  nl: {
    term: "FOMO",
    summary:
      "Het knagende idee dat iemand beters één scroll verderop wacht — afkorting van fear of missing out, en de reden dat zoveel mensen maar half aanwezig zijn in het gesprek dat ze al voeren.",
    blocks: [
      { type: "h2", text: "Waarom een eindeloze rij dit oplevert" },
      { type: "p", text: "Datingapps laten mensen zien zoals een winkel voorraad laat zien: een aanbod zonder zichtbare bodem. Je hoofd leest dat als overvloed, en overvloed verandert wat je waard vindt wat er voor je staat. Als er altijd nog een profiel is, voelt degene met wie je praat niet als een keuze maar als een plek die warm wordt gehouden, in afwachting van iets beters." },
      { type: "p", text: "De vergelijking is ook oneerlijk. Aan de ene kant een echt mens, dat traag antwoordt en een grap maakt die niet aankomt. Aan de andere kant de twaalf beste foto's van een vreemde. Daar houdt niemand stand. Het gevoel zegt dus niets over de persoon tegenover je; het is een bijwerking van de rij die achter diegene staat." },
      { type: "h2", text: "Hoe je het herkent" },
      { type: "ul", items: [
        "**Je kijkt op de app tijdens de date**, of op de terugweg.",
        "**Drie gesprekken, geen enkel echt.** Je houdt meerdere mensen ondiep vast in plaats van één serieus.",
        "**Plannen blijven vaag.** Je houdt zaterdag vrij voor het geval er iets beters langskomt.",
        "**Een kleinigheid maakt er een eind aan.** Een antwoord na vier uur telt als bewijs, want er zijn nog veertig opties.",
      ] },
      { type: "h2", accent: "green", text: "Wat je eraan kunt doen" },
      { type: "p", text: "Maak de keuze kleiner en concreter. Kies één of twee mensen en geef ze twee weken echte aandacht: kort genoeg om veilig te voelen, lang genoeg om iets te weten te komen. Spreek vroeg af, want een echt uur met iemand wint bijna altijd van een ingebeeld beter alternatief. En als de neiging om terug naar de rij te gaan midden in een gesprek opkomt: dat is een bui, geen oordeel." },
      { type: "p", text: "Het helpt te kijken wat dit gevoel tot nu toe heeft voorspeld: niets. De eindeloze rij was er vorige maand ook, en de maand daarvoor, en het beloofde betere is nooit gekomen. Vraag niet of iemand het beste is dat er is, maar iets waar een antwoord op bestaat: vind je jezelf prettig in hun buurt?" },
    ],
  },

  pl: {
    term: "FOMO",
    summary:
      "Uporczywe wrażenie, że ktoś lepszy jest o jedno przewinięcie dalej — skrót od fear of missing out i powód, dla którego tylu ludzi jest tylko w połowie obecnych w rozmowie, którą już prowadzą.",
    blocks: [
      { type: "h2", text: "Dlaczego bierze się to z nieskończonej kolejki" },
      { type: "p", text: "Aplikacje randkowe pokazują ludzi tak, jak sklep pokazuje towar: podaż, która nie ma widocznego dna. Głowa czyta to jako obfitość, a obfitość zmienia wartość tego, co masz przed sobą. Skoro zawsze jest kolejny profil, osoba, z którą rozmawiasz, przestaje być decyzją i staje się miejscem trzymanym na później: na razie w porządku, do czasu aż pojawi się coś lepszego." },
      { type: "p", text: "Samo porównanie też jest ustawione. Po jednej stronie prawdziwy człowiek, który odpisuje z opóźnieniem i rzuca żart, który nie wypala. Po drugiej dwanaście najlepszych zdjęć obcej osoby. Tego nie wytrzyma nikt. To uczucie nie jest więc informacją o rozmówcy, tylko efektem ubocznym kolejki, która stoi za nim." },
      { type: "h2", text: "Po czym to poznasz" },
      { type: "ul", items: [
        "**Zaglądasz do aplikacji w trakcie randki**, albo w drodze powrotnej.",
        "**Trzy rozmowy i żadna prawdziwa.** Trzymasz kilka osób płytko zamiast jednej na poważnie.",
        "**Plany zostają w zawieszeniu.** Sobota zostaje wolna, na wypadek gdyby trafiło się coś lepszego.",
        "**Drobiazg kończy sprawę.** Odpowiedź po czterech godzinach uchodzi za dowód, bo obok czeka czterdzieści innych opcji.",
      ] },
      { type: "h2", accent: "green", text: "Co możesz z tym zrobić" },
      { type: "p", text: "Zmniejsz wybór i uczyń go konkretnym. Wybierz jedną albo dwie osoby i daj im dwa tygodnie prawdziwej uwagi: dość krótko, żeby było bezpiecznie, i dość długo, żeby czegoś się dowiedzieć. Spotkajcie się wcześnie, bo realna godzina z kimś prawie zawsze wygrywa z wyobrażoną lepszą opcją. A gdy w środku rozmowy przychodzi ochota, żeby wrócić do kolejki, potraktuj to jak nastrój, nie jak wniosek." },
      { type: "p", text: "Warto sprawdzić, co to uczucie do tej pory trafnie przewidziało: nic. Nieskończona kolejka była też w zeszłym miesiącu i miesiąc wcześniej, a obiecanego lepszego nigdy nie dostarczyła. Zamiast pytać, czy ktoś jest najlepszy z dostępnych, zadaj pytanie, na które da się odpowiedzieć: lubisz siebie w towarzystwie tej osoby?" },
    ],
  },

  sv: {
    term: "FOMO",
    summary:
      "Den gnagande känslan av att någon bättre finns en scroll bort — kortform av fear of missing out, och skälet till att så många bara är halvt närvarande i samtalet de redan har.",
    blocks: [
      { type: "h2", text: "Varför en oändlig kö skapar känslan" },
      { type: "p", text: "Dejtingappar visar människor som en butik visar lager: ett utbud utan synlig botten. Huvudet läser det som överflöd, och överflöd förändrar vad det som står framför dig är värt. Om det alltid finns en profil till slutar personen du pratar med att kännas som ett val och blir en plats som hålls varm i väntan på något bättre." },
      { type: "p", text: "Jämförelsen är dessutom riggad. På ena sidan en riktig människa som svarar sent och drar ett skämt som inte landar. På den andra en främlings tolv bästa bilder. Ingen klarar den vågskålen. Känslan är alltså ingen information om den du pratar med, utan en biverkning av kön som står bakom." },
      { type: "h2", text: "Så känner du igen den" },
      { type: "ul", items: [
        "**Du kollar appen under dejten**, eller på vägen hem.",
        "**Tre samtal, inget på riktigt.** Du håller flera personer på ytan i stället för en på allvar.",
        "**Planerna förblir preliminära.** Lördagen står tom ifall något bättre dyker upp.",
        "**En småsak avslutar det.** Ett svar som dröjde fyra timmar räknas som bevis, för det finns fyrtio andra alternativ.",
      ] },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Gör valet mindre och mer konkret. Välj en eller två personer och ge dem två veckors riktig uppmärksamhet: kort nog att kännas tryggt, långt nog att säga dig något. Ses tidigt, för en verklig timme med någon slår nästan alltid ett inbillat bättre alternativ. Och när lusten att gå tillbaka till kön dyker upp mitt i ett samtal — behandla den som ett humör som passerar, inte som en slutsats." },
      { type: "p", text: "Det hjälper att titta på vad känslan hittills har förutsagt: ingenting. Den oändliga kön fanns förra månaden också, och månaden dessförinnan, och det utlovade bättre kom aldrig. I stället för att fråga om någon är det bästa som finns, ställ en fråga som går att svara på: gillar du den du är i den personens sällskap?" },
    ],
  },

  hi: {
    term: "FOMO",
    summary:
      "यह खटकती हुई भावना कि इससे बेहतर कोई बस एक स्क्रॉल दूर है — अंग्रेज़ी के fear of missing out का छोटा रूप, और वजह कि लोग चालू बातचीत में आधा-अधूरा ही मौजूद रहते हैं।",
    blocks: [
      { type: "h2", text: "कभी न ख़त्म होने वाली कतार यह भावना क्यों बनाती है" },
      { type: "p", text: "डेटिंग ऐप लोगों को वैसे ही दिखाते हैं जैसे दुकान अपना स्टॉक दिखाती है — ऐसी सप्लाई जिसका तल दिखता ही नहीं। दिमाग़ इसे भरपूरी की तरह पढ़ता है, और भरपूरी सामने मौजूद चीज़ की क़ीमत घटा देती है। जब अगली प्रोफ़ाइल हमेशा तैयार है, तो जिससे आप बात कर रहे हैं वह एक फ़ैसला नहीं रह जाता, बस एक भरी हुई जगह बन जाता है: फ़िलहाल ठीक है, जब तक कोई बेहतर न आ जाए।" },
      { type: "p", text: "और तुलना भी बेईमान है। एक तरफ़ असली इंसान है, जिसका जवाब देर से आता है और जिसका मज़ाक चल नहीं पाया; दूसरी तरफ़ किसी अजनबी की चुनी हुई बारह सबसे अच्छी तस्वीरें। इस तराज़ू पर कोई नहीं टिकता। यानी यह भावना सामने वाले के बारे में कोई जानकारी नहीं है, उसके पीछे खड़ी कतार का साइड इफ़ेक्ट है।" },
      { type: "h2", text: "कैसे पहचानें" },
      { type: "ul", items: [
        "**मुलाक़ात के बीच में ऐप देखना**, या लौटते वक़्त रास्ते में।",
        "**तीन बातचीत, एक भी असली नहीं।** कई लोगों को ऊपर-ऊपर टिकाए रखना, किसी एक से गहराई में न जाना।",
        "**प्लान हमेशा अधर में।** शनिवार खाली रखना, कहीं इससे अच्छा कुछ न निकल आए।",
        "**छोटी बात पर ख़त्म।** चार घंटे बाद आया जवाब सबूत बन जाता है, क्योंकि चालीस और विकल्प हैं।",
      ] },
      { type: "h2", accent: "green", text: "इसका क्या करें" },
      { type: "p", text: "चुनाव को छोटा और ठोस बनाइए। एक या दो लोगों को चुनिए और उन्हें दो हफ़्ते का सच्चा ध्यान दीजिए — इतना छोटा कि डर न लगे, इतना बड़ा कि कुछ पता चल जाए। मिलना जल्दी तय कीजिए, क्योंकि किसी के साथ बिताया असली एक घंटा कल्पना के बेहतर विकल्प को लगभग हमेशा हरा देता है। और बातचीत के बीच कतार में लौटने का मन करे, तो उसे गुज़रता हुआ मूड मानिए, कोई नतीजा नहीं।" },
      { type: "p", text: "यह देखना भी काम आता है कि आज तक इस भावना ने क्या सही बताया — कुछ भी नहीं। वह अनंत कतार पिछले महीने भी थी, उससे पिछले महीने भी, और जिस बेहतर का वादा करती रही वह कभी नहीं आया। यह पूछने के बजाय कि यह उपलब्ध लोगों में सबसे अच्छा है या नहीं, वह सवाल पूछिए जिसका जवाब है: उनके साथ होते हुए जो आप बनते हैं, वह आपको पसंद है?" },
    ],
  },
};
