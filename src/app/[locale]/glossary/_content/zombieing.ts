import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Zombieing — someone who ghosted you reappears months later as if nothing
 * happened.
 *
 * Judgement calls a later editor should not undo by accident:
 *
 * - The boundary this page defends is against `ghosting` (the disappearance
 *   itself) and `orbiting` (watching without ever writing). Zombieing is the
 *   sequel to ghosting: the silence broke, and it broke on their terms. Keep
 *   the "months later, no mention of the gap" detail in every locale — it is
 *   what distinguishes the three.
 *
 * - The decision rule in block 6 is deliberately a question the reader asks,
 *   not a verdict this page hands down. We do not tell anyone whether to reply,
 *   because both answers are legitimate; we give them a test ("ask what
 *   happened, then read the answer") and let them decide. Do not turn it into
 *   "never reply to a zombie" — that is advice this page has no standing to
 *   give, and it is not true.
 *
 * - No statistic. There is no sourced figure on how often people resurface, so
 *   none is claimed. The reasons listed (a lost option elsewhere, a quiet week,
 *   a cleared-out inbox) are offered as ordinary possibilities, not findings.
 *
 * - No Qulo angle. Nothing in the app prevents someone reappearing months
 *   later, so block 7 is spent on the practical point — start from where you
 *   are now, and silence is a complete answer.
 *
 * - Term names. `ru` uses зомбинг, not "зомбирование", which in Russian means
 *   brainwashing and would be read as something else entirely. `zh` uses
 *   诈尸式回归, an expression Chinese speakers already use for exactly this,
 *   with "zombieing" named in the summary. `ja` ゾンビング, `ko` 좀비잉,
 *   `ar` الزومبينغ, `hi` ज़ॉम्बीइंग.
 *
 * - The example month (March) is arbitrary and identical across locales on
 *   purpose, so the sample line reads as a concrete script rather than a
 *   placeholder. In `ar` it is مارس, not آذار, which is regional.
 */
export const zombieing: LocalizedGlossaryEntry = {
  en: {
    term: "Zombieing",
    summary:
      "The return of someone who ghosted you — months later, out of nowhere, with a casual message that acts as if the disappearance never happened.",
    blocks: [
      { type: "h2", text: "Why they come back" },
      { type: "p", text: "The message usually arrives late at night. It says “hey stranger”, or “this is random but you popped into my head”, and it contains no reference at all to the four months of nothing. That part is deliberate. Mentioning the gap means explaining it, and explaining it is the conversation they avoided the first time. Reappearing as though nothing happened is simply the cheapest way back in." },
      { type: "p", text: "The reasons are ordinary and rarely about you. Something they were pursuing elsewhere fell through. A quiet week. A bored scroll through old chats. Sometimes they are clearing out a phone, see your name, and send the same line to everyone on the list. It costs them one sentence and hands the next move to you." },
      { type: "h2", text: "How to read the message you just got" },
      { type: "ul", items: [
        "**No mention of the gap.** Months of silence, and the message opens like an ordinary Tuesday.",
        "**No explanation offered.** Not in the first message, and often not even when you ask directly.",
        "**It asks nothing real.** “Hey stranger”, a reaction to an old story, a one-word question.",
        "**It lands at their convenience.** Late, sudden, and assuming you are still available.",
      ] },
      { type: "h2", accent: "green", text: "Deciding whether to answer" },
      { type: "p", text: "Nothing obliges you to reply, and being pleased to hear from them is not a weakness. One question settles most of it: ask what happened. Not angrily — just “Hey. Honestly, what happened back in March?” Someone worth a second round answers it plainly, maybe awkwardly, and does not make you the difficult one for asking. Someone who jokes it away, changes the subject, or goes quiet again has just shown you the next three weeks." },
      { type: "p", text: "If you do answer, start from where you actually are rather than where you left off. They spent those months somewhere, and so did you. And if you would rather leave it unread, that is a complete answer too. Not replying is not rude — the conversation ended a long time ago, and they were the one who ended it." },
    ],
  },
  tr: {
    term: "Zombieing",
    summary:
      "Seni ghostlayan birinin aylar sonra hiç yoktan geri dönmesi — sanki o kayboluş hiç yaşanmamış gibi, laf arasında atılmış bir mesajla.",
    blocks: [
      { type: "h2", text: "Neden geri dönüyorlar" },
      { type: "p", text: "Mesaj genelde gece geç saatte gelir. “Naber yabancı” ya da “çok alakasız ama aklıma düştün” der ve aradaki dört aya dair tek kelime içermez. Bu kısım bilinçli. Boşluktan söz etmek onu açıklamak demek; açıklamak da ilk seferinde kaçtığı konuşmanın ta kendisi. Hiçbir şey olmamış gibi belirmek, geri dönmenin en ucuz yolu." },
      { type: "p", text: "Sebepler çok sıradan ve çoğu zaman seninle ilgisi yok. Başka yerde peşinde olduğu bir şey yürümemiştir. Sakin bir hafta geçiyordur. Canı sıkkın hâlde eski sohbetleri karıştırıyordur. Bazen telefonunu temizlerken adını görür ve aynı cümleyi listedeki herkese atar. Ona bir cümleye mal olur, sıradaki hamleyi de sana bırakır." },
      { type: "h2", text: "Az önce gelen mesajı nasıl okumalı" },
      { type: "ul", items: [
        "**Aradaki boşluktan hiç söz etmez.** Aylarca sessizlik ve mesaj sıradan bir salı günü gibi başlar.",
        "**Açıklama gelmez.** Ne ilk mesajda, ne de çoğu zaman doğrudan sorduğunda.",
        "**Gerçek bir şey sormaz.** “Naber yabancı”, eski bir paylaşıma tepki, tek kelimelik bir soru.",
        "**Kendi keyfine göre düşer.** Geç saatte, aniden ve senin hâlâ müsait olduğun varsayımıyla.",
      ] },
      { type: "h2", accent: "green", text: "Cevap verip vermemeye nasıl karar verilir" },
      { type: "p", text: "Cevap vermek zorunda değilsin; ondan haber almana sevindiysen de bunda zayıflık yok. Çoğu şeyi tek bir soru çözer: ne olduğunu sor. Kızgın değil, sakin bir şekilde: “Selam. Merak ettim, mart ayında ne oldu?” İkinci bir tura değecek biri bunu düpedüz, belki biraz beceriksizce ama cevaplar; sorduğun için seni zor insan ilan etmez. Şakaya vuran, konuyu değiştiren ya da yine sessizleşen biri sana önümüzdeki üç haftayı göstermiştir." },
      { type: "p", text: "Cevap vereceksen, kaldığın yerden değil, gerçekten bulunduğun yerden başla. O aylarda o da bir yerlerdeydi, sen de. Okumadan bırakmayı tercih ediyorsan bu da eksiksiz bir cevap. Cevap vermemek kabalık değil: konuşma çoktan bitmişti ve bitiren de o." },
    ],
  },
  de: {
    term: "Zombieing",
    summary:
      "Die Rückkehr einer Person, die dich geghostet hat – Monate später, aus dem Nichts, mit einer beiläufigen Nachricht, die tut, als hätte es das Verschwinden nie gegeben.",
    blocks: [
      { type: "h2", text: "Warum sie zurückkommen" },
      { type: "p", text: "Die Nachricht kommt meistens spätabends. Da steht „Hey, lange nichts gehört“ oder „ganz random, aber ich musste an dich denken“ – und kein einziges Wort zu den vier Monaten Funkstille. Das ist Absicht. Die Lücke zu erwähnen hieße, sie zu erklären, und genau dieses Gespräch wurde beim ersten Mal umgangen. Wieder aufzutauchen, als sei nichts gewesen, ist schlicht der billigste Weg zurück." },
      { type: "p", text: "Die Gründe sind banal und haben selten mit dir zu tun. Etwas anderes hat sich zerschlagen. Eine ruhige Woche. Gelangweiltes Scrollen durch alte Chats. Manchmal räumt jemand das Handy auf, sieht deinen Namen und schickt dieselbe Zeile an alle auf der Liste. Es kostet einen Satz und schiebt dir den nächsten Zug zu." },
      { type: "h2", text: "Wie du die Nachricht liest, die gerade kam" },
      { type: "ul", items: [
        "**Kein Wort zur Lücke.** Monate Stille, und die Nachricht beginnt wie an einem normalen Dienstag.",
        "**Keine Erklärung.** Nicht in der ersten Nachricht, und oft auch nicht, wenn du direkt fragst.",
        "**Es wird nichts Echtes gefragt.** „Lange nichts gehört“, eine Reaktion auf eine alte Story, eine Ein-Wort-Frage.",
        "**Sie kommt, wenn es der anderen Person passt.** Spät, plötzlich und mit der Annahme, dass du noch zu haben bist.",
      ] },
      { type: "h2", accent: "green", text: "Antworten oder nicht" },
      { type: "p", text: "Nichts verpflichtet dich zu einer Antwort, und sich zu freuen ist keine Schwäche. Eine Frage klärt das meiste: Frag, was los war. Nicht wütend, einfach „Hey. Ehrlich, was war denn im März?“ Wer eine zweite Runde wert ist, beantwortet das geradeheraus, vielleicht unbeholfen, und macht dich fürs Fragen nicht zum Problem. Wer es wegwitzelt, das Thema wechselt oder wieder verstummt, hat dir gerade die nächsten drei Wochen gezeigt." },
      { type: "p", text: "Wenn du antwortest, fang dort an, wo du wirklich bist, nicht dort, wo ihr aufgehört habt. Diese Monate hat die andere Person irgendwo verbracht – du auch. Und wenn du es lieber ungelesen lässt, ist das ebenfalls eine vollständige Antwort. Nicht zu antworten ist nicht unhöflich: Das Gespräch war längst beendet, und beendet hat es die andere Seite." },
    ],
  },
  fr: {
    term: "Zombieing",
    summary:
      "Le retour d'une personne qui vous avait ghosté : des mois plus tard, sans prévenir, avec un message léger qui fait comme si la disparition n'avait jamais eu lieu.",
    blocks: [
      { type: "h2", text: "Pourquoi ils reviennent" },
      { type: "p", text: "Le message arrive en général tard le soir. Il dit « coucou, ça fait un bail » ou « c'est random, mais j'ai pensé à toi », et ne contient pas un mot sur les quatre mois de silence. Cette absence est volontaire : évoquer le vide, c'est devoir l'expliquer, et cette explication est justement la conversation évitée la première fois. Réapparaître comme si de rien n'était reste le retour le moins coûteux." },
      { type: "p", text: "Les raisons sont banales et rarement liées à vous. Une piste ailleurs qui n'a pas abouti. Une semaine trop calme. Un défilement d'anciennes conversations par ennui. Parfois, la personne fait le ménage dans son téléphone, voit votre nom et envoie la même phrase à toute la liste. Ça lui coûte une ligne et vous laisse le coup suivant." },
      { type: "h2", text: "Comment lire le message que vous venez de recevoir" },
      { type: "ul", items: [
        "**Aucune mention du silence.** Des mois sans rien, et le message s'ouvre comme un mardi ordinaire.",
        "**Aucune explication.** Ni dans le premier message, ni souvent quand vous posez la question.",
        "**Il ne demande rien de réel.** « Ça fait un bail », une réaction à une vieille story, une question d'un mot.",
        "**Il tombe quand ça l'arrange.** Tard, soudain, en supposant que vous êtes toujours disponible.",
      ] },
      { type: "h2", accent: "green", text: "Répondre ou pas" },
      { type: "p", text: "Rien ne vous oblige à répondre, et être content d'avoir des nouvelles n'a rien de faible. Une question tranche l'essentiel : demandez ce qui s'est passé. Sans colère : « Salut. Franchement, il s'est passé quoi en mars ? » Quelqu'un qui mérite un deuxième tour répond simplement, parfois maladroitement, et ne fait pas de vous la personne compliquée. Quelqu'un qui esquive, plaisante ou se tait à nouveau vient de vous montrer les trois semaines à venir." },
      { type: "p", text: "Si vous répondez, partez d'où vous êtes vraiment, pas d'où vous vous étiez arrêtés. L'autre a passé ces mois quelque part, et vous aussi. Et si vous préférez laisser le message non lu, c'est une réponse complète. Ne pas répondre n'est pas impoli : la conversation s'est terminée il y a longtemps, et ce n'est pas vous qui y avez mis fin." },
    ],
  },
  es: {
    term: "Zombieing",
    summary:
      "La reaparición de alguien que te hizo ghosting: meses después, de la nada, con un mensaje casual que actúa como si la desaparición no hubiera existido.",
    blocks: [
      { type: "h2", text: "Por qué vuelven" },
      { type: "p", text: "El mensaje suele llegar de madrugada. Dice «hola, desconocido» o «qué random, pero me acordé de ti», y no menciona ni una vez los cuatro meses de nada. Esa omisión es deliberada: nombrar el hueco obliga a explicarlo, y esa explicación es justo la conversación que se esquivó la primera vez. Reaparecer como si nada es, sencillamente, la vuelta más barata." },
      { type: "p", text: "Los motivos son de lo más corrientes y rara vez tienen que ver contigo. Algo que perseguía en otro sitio no salió. Una semana tranquila. Un rato de aburrimiento repasando chats viejos. A veces está limpiando el teléfono, ve tu nombre y manda la misma frase a toda la lista. Le cuesta una línea y te deja a ti el siguiente movimiento." },
      { type: "h2", text: "Cómo leer el mensaje que acabas de recibir" },
      { type: "ul", items: [
        "**Ni una palabra sobre el hueco.** Meses de silencio y el mensaje arranca como un martes cualquiera.",
        "**No hay explicación.** Ni en el primer mensaje, ni muchas veces cuando preguntas directamente.",
        "**No pregunta nada de verdad.** «Hola, desconocido», una reacción a una historia vieja, una pregunta de una palabra.",
        "**Llega cuando a esa persona le viene bien.** Tarde, de golpe, dando por hecho que sigues disponible.",
      ] },
      { type: "h2", accent: "green", text: "Cómo decidir si contestas" },
      { type: "p", text: "Nada te obliga a responder, y alegrarte de tener noticias no te hace débil. Una sola pregunta resuelve casi todo: pregunta qué pasó. Sin enfado: «Hola. En serio, ¿qué pasó en marzo?» Quien merece una segunda ronda contesta de forma llana, quizá torpe, y no te convierte en la persona complicada por preguntar. Quien lo esquiva, lo convierte en broma o vuelve a callarse acaba de enseñarte cómo serían las próximas tres semanas." },
      { type: "p", text: "Si contestas, empieza desde donde estás de verdad, no desde el punto en que se quedó todo. Esa persona pasó esos meses en algún sitio, y tú también. Y si prefieres dejarlo sin leer, también es una respuesta completa. No contestar no es de mala educación: la conversación terminó hace mucho, y no fuiste tú quien la terminó." },
    ],
  },
  ar: {
    term: "الزومبينغ",
    summary:
      "عودة شخص سبق أن اختفى من حياتك بلا تفسير، بعد شهور وبلا مقدمات، برسالة عابرة تتصرف كأن الاختفاء لم يحدث أصلًا.",
    blocks: [
      { type: "h2", text: "لماذا يعودون" },
      { type: "p", text: "تصل الرسالة عادةً في وقت متأخر من الليل. تقول «أهلًا يا غريب» أو «فجأة خطرت في بالي»، ولا تتضمن كلمة واحدة عن الشهور الأربعة من الصمت. هذا الغياب مقصود: ذكر الفجوة يعني تفسيرها، والتفسير هو بالضبط الحديث الذي تهرّب منه في المرة الأولى. الظهور وكأن شيئًا لم يكن هو أرخص طريق للعودة." },
      { type: "p", text: "الأسباب عادية جدًا ونادرًا ما تتعلق بك. شيء آخر كان يسعى إليه لم ينجح. أسبوع هادئ. تصفّح للمحادثات القديمة بدافع الملل. وأحيانًا يرتّب هاتفه فيرى اسمك، فيرسل الجملة نفسها إلى كل من في القائمة. تكلّفه سطرًا واحدًا، وتضع الخطوة التالية في يدك." },
      { type: "h2", text: "كيف تقرأ الرسالة التي وصلتك للتو" },
      { type: "ul", items: [
        "**لا ذكر للفجوة.** شهور من الصمت، والرسالة تبدأ وكأنه يوم عادي.",
        "**لا تفسير.** لا في الرسالة الأولى، ولا غالبًا حين تسأل مباشرة.",
        "**لا تسأل شيئًا حقيقيًا.** «أهلًا يا غريب»، أو تفاعل مع قصة قديمة، أو سؤال من كلمة واحدة.",
        "**تصل حين يناسبه هو.** متأخرة، ومفاجئة، وتفترض أنك ما زلت متاحًا.",
      ] },
      { type: "h2", accent: "green", text: "كيف تقرر إن كنت سترد" },
      { type: "p", text: "لا شيء يلزمك بالرد، ولا ضعف في أن تسرّك عودته. سؤال واحد يحسم معظم الأمر: اسأله عما جرى. لا بغضب، بل ببساطة: «أهلًا. بصراحة، ماذا حدث في مارس؟». من يستحق جولة ثانية يجيب بوضوح، وربما بارتباك، ولا يجعلك أنت الطرف المتعب لأنك سألت. ومن يحوّل السؤال إلى مزحة أو يغيّر الموضوع أو يصمت من جديد، يكون قد أراك الأسابيع الثلاثة القادمة." },
      { type: "p", text: "إن قررت الرد، فابدأ من حيث أنت فعلًا، لا من حيث توقفتما. لقد قضى تلك الشهور في مكان ما، وأنت أيضًا. وإن فضّلت ترك الرسالة دون قراءة، فهذا ردّ كامل بدوره. عدم الرد ليس قلة ذوق: المحادثة انتهت منذ زمن، وهو من أنهاها." },
    ],
  },
  ru: {
    term: "зомбинг",
    summary:
      "Возвращение человека, который однажды исчез без объяснений: спустя месяцы, внезапно и с лёгким сообщением, будто никакого исчезновения не было.",
    blocks: [
      { type: "h2", text: "Почему они возвращаются" },
      { type: "p", text: "Сообщение обычно приходит поздно вечером. В нём «привет, незнакомец» или «внезапно, но ты мне вспомнился», и ни слова про четыре месяца тишины. Это не случайность: упомянуть паузу — значит объяснить её, а объяснение и есть тот самый разговор, которого человек избежал в первый раз. Появиться как ни в чём не бывало — самый дешёвый способ вернуться." },
      { type: "p", text: "Причины будничные и редко связаны с вами. Что-то другое не сложилось. Тихая неделя. Скучающая прокрутка старых переписок. Иногда человек чистит телефон, видит ваше имя и отправляет одну и ту же строчку всем подряд. Ему это стоит одной фразы, а следующий ход достаётся вам." },
      { type: "h2", text: "Как читать сообщение, которое только что пришло" },
      { type: "ul", items: [
        "**Ни слова про паузу.** Месяцы молчания, а сообщение начинается как обычный вторник.",
        "**Объяснения нет.** Ни в первом сообщении, ни часто даже когда вы спрашиваете прямо.",
        "**Оно ни о чём не спрашивает.** «Привет, незнакомец», реакция на старую историю, вопрос в одно слово.",
        "**Оно приходит, когда удобно ему.** Поздно, неожиданно и с расчётом, что вы всё ещё свободны.",
      ] },
      { type: "h2", accent: "green", text: "Как решить, отвечать ли" },
      { type: "p", text: "Отвечать вы не обязаны, и радоваться весточке — не слабость. Почти всё решает один вопрос: спросите, что произошло. Без злости, просто: «Привет. Честно, что случилось в марте?» Тот, кто стоит второго круга, ответит прямо, пусть и неловко, и не сделает вас неудобным человеком за этот вопрос. Тот, кто отшутится, сменит тему или снова замолчит, только что показал вам следующие три недели." },
      { type: "p", text: "Если отвечаете, начинайте с того, где вы сейчас, а не с того, где остановились. Эти месяцы человек где-то прожил — и вы тоже. А если хочется оставить сообщение непрочитанным, это тоже полноценный ответ. Не отвечать — не грубость: разговор закончился давно, и закончил его не вы." },
    ],
  },
  pt: {
    term: "Zombieing",
    summary:
      "A volta de alguém que sumiu sem explicação: meses depois, do nada, com uma mensagem casual que age como se o desaparecimento nunca tivesse acontecido.",
    blocks: [
      { type: "h2", text: "Por que eles voltam" },
      { type: "p", text: "A mensagem costuma chegar tarde da noite. Vem com um “sumido, tudo bem?” ou “do nada, mas lembrei de você”, e não traz uma linha sequer sobre os quatro meses de silêncio. Essa ausência é proposital: falar do buraco obriga a explicá-lo, e essa explicação é justamente a conversa que foi evitada da primeira vez. Reaparecer como se nada tivesse acontecido é o caminho de volta mais barato." },
      { type: "p", text: "Os motivos são comuns e raramente têm a ver com você. Alguma coisa que a pessoa tentava em outro lugar não deu certo. Uma semana parada. Uma rolagem entediada pelas conversas antigas. Às vezes ela está limpando o celular, vê seu nome e manda a mesma frase para a lista inteira. Custa uma linha e joga o próximo passo no seu colo." },
      { type: "h2", text: "Como ler a mensagem que acabou de chegar" },
      { type: "ul", items: [
        "**Nenhuma menção ao sumiço.** Meses de silêncio e a mensagem começa como uma terça-feira qualquer.",
        "**Nenhuma explicação.** Nem na primeira mensagem, nem muitas vezes quando você pergunta direto.",
        "**Não pergunta nada de verdade.** “Sumido, tudo bem?”, uma reação a um story velho, uma pergunta de uma palavra.",
        "**Chega na hora que é boa para ela.** Tarde, de repente e supondo que você continua disponível.",
      ] },
      { type: "h2", accent: "green", text: "Como decidir se você responde" },
      { type: "p", text: "Nada te obriga a responder, e ficar feliz com a notícia não é fraqueza. Uma pergunta resolve quase tudo: pergunte o que aconteceu. Sem raiva, só: “Oi. Sinceramente, o que rolou em março?” Quem vale um segundo round responde de forma direta, talvez sem jeito, e não te transforma na pessoa complicada por perguntar. Quem transforma em piada, desvia ou some de novo acabou de te mostrar as próximas três semanas." },
      { type: "p", text: "Se for responder, comece de onde você está de verdade, não de onde a conversa parou. A pessoa passou esses meses em algum lugar, e você também. E se preferir deixar sem ler, isso também é uma resposta completa. Não responder não é falta de educação: a conversa acabou faz tempo, e quem acabou com ela não foi você." },
    ],
  },
  it: {
    term: "Zombieing",
    summary:
      "Il ritorno di chi ti aveva fatto ghosting: mesi dopo, dal nulla, con un messaggio leggero che fa finta che la sparizione non sia mai avvenuta.",
    blocks: [
      { type: "h2", text: "Perché tornano" },
      { type: "p", text: "Il messaggio arriva quasi sempre a tarda sera. Dice «ehi, quanto tempo» oppure «così, a caso, mi sei venuto in mente», e non contiene una parola sui quattro mesi di silenzio. Quell'assenza è voluta: nominare il vuoto significa spiegarlo, e la spiegazione è esattamente la conversazione evitata la prima volta. Ricomparire come se niente fosse è semplicemente il rientro che costa meno." },
      { type: "p", text: "I motivi sono banali e raramente riguardano te. Qualcosa che stava seguendo altrove non è andato in porto. Una settimana vuota. Una scorsa annoiata tra le vecchie chat. A volte sta ripulendo il telefono, vede il tuo nome e manda la stessa riga a tutta la lista. Gli costa una frase e lascia a te la mossa successiva." },
      { type: "h2", text: "Come leggere il messaggio appena arrivato" },
      { type: "ul", items: [
        "**Nessun accenno al vuoto.** Mesi di silenzio, e il messaggio si apre come un martedì qualsiasi.",
        "**Nessuna spiegazione.** Né nel primo messaggio, né spesso quando lo chiedi direttamente.",
        "**Non chiede niente di reale.** «Quanto tempo», una reazione a una storia vecchia, una domanda di una parola.",
        "**Arriva quando fa comodo a lui.** Tardi, all'improvviso, dando per scontato che tu sia ancora lì.",
      ] },
      { type: "h2", accent: "green", text: "Come decidere se rispondere" },
      { type: "p", text: "Niente ti obbliga a rispondere, e non è debolezza essere contento di risentirlo. Una domanda risolve quasi tutto: chiedi cosa è successo. Senza rabbia, solo: «Ciao. Sinceramente, cosa è successo a marzo?». Chi merita un secondo giro risponde in modo diretto, magari impacciato, e non ti fa passare per quello difficile perché hai chiesto. Chi ci ride sopra, cambia discorso o sparisce di nuovo ti ha appena mostrato le prossime tre settimane." },
      { type: "p", text: "Se rispondi, parti da dove sei davvero, non da dove vi eravate fermati. Quei mesi lui li ha passati da qualche parte, e tu pure. E se preferisci lasciarlo non letto, anche quella è una risposta completa. Non rispondere non è maleducazione: la conversazione era finita da un pezzo, e non l'hai chiusa tu." },
    ],
  },
  ja: {
    term: "ゾンビング",
    summary:
      "音信不通のまま消えた相手が、数か月後に突然戻ってくること。何事もなかったかのような軽いメッセージで、消えていた期間には一切触れません。",
    blocks: [
      { type: "h2", text: "なぜ戻ってくるのか" },
      { type: "p", text: "メッセージはたいてい夜遅くに届きます。「久しぶり」「急にごめん、ふと思い出して」といった文面で、四か月の空白には一言も触れていません。触れないのは意図的です。空白に触れれば説明が必要になり、その説明こそ最初のときに避けた会話だからです。何もなかったふりで現れるのが、いちばん安く戻れる方法なのです。" },
      { type: "p", text: "理由はごく平凡で、あなたに関することはめったにありません。よそで進めていた話がだめになった。予定のない週だった。退屈まぎれに古いトーク一覧をさかのぼった。連絡先を整理していて名前を見かけ、同じ一文をまとめて全員に送ることもあります。相手の負担は一行、次の一手はあなたに回ってきます。" },
      { type: "h2", text: "届いたばかりのメッセージをどう読むか" },
      { type: "ul", items: [
        "**空白に触れない。** 数か月の沈黙があったのに、ふつうの火曜日のように始まる。",
        "**説明がない。** 最初の一通にも、直接尋ねたときにも出てこないことが多い。",
        "**中身のある問いがない。** 「久しぶり」、古い投稿への反応、ひと言だけの質問。",
        "**相手の都合で届く。** 遅い時間に、突然、あなたがまだ空いている前提で。",
      ] },
      { type: "h2", accent: "green", text: "返すかどうかの決め方" },
      { type: "p", text: "返す義務はありませんし、うれしいと感じたとしても弱さではありません。判断はだいたい一つの質問で足ります——何があったのか聞いてみることです。責める調子ではなく、「久しぶり。正直、3月は何があったの？」で十分です。二度目に値する人は、たとえぎこちなくても正面から答え、聞いたあなたを面倒な人扱いしません。冗談にすり替える人、話をそらす人、また黙る人は、これからの三週間を先に見せてくれたことになります。" },
      { type: "p", text: "返すなら、途切れた地点からではなく、いまの自分の場所から始めてください。その数か月を相手はどこかで過ごし、あなたもどこかで過ごしました。読まずに置いておくほうがいいなら、それも完結した答えです。返さないのは失礼ではありません。会話はずっと前に終わっていて、終わらせたのは相手のほうです。" },
    ],
  },
  ko: {
    term: "좀비잉",
    summary:
      "잠수를 탔던 사람이 몇 달 뒤 갑자기 다시 나타나는 일. 사라졌던 기간은 한마디도 꺼내지 않은 채, 아무 일 없었다는 듯 가벼운 메시지를 보냅니다.",
    blocks: [
      { type: "h2", text: "왜 다시 나타날까" },
      { type: "p", text: "메시지는 보통 늦은 밤에 옵니다. “오랜만이네”, “뜬금없지만 갑자기 생각나서”처럼 시작하고, 넉 달의 공백에 대해서는 한 글자도 없습니다. 그건 일부러 그런 겁니다. 공백을 꺼내면 설명해야 하고, 그 설명이야말로 처음에 피했던 대화이기 때문입니다. 아무 일 없었던 척 등장하는 게 가장 값싼 복귀 방법입니다." },
      { type: "p", text: "이유는 평범하고, 당신과 상관없는 경우가 많습니다. 다른 데서 진행되던 게 틀어졌거나, 한가한 한 주였거나, 심심해서 옛 대화 목록을 넘겨봤거나. 연락처를 정리하다 이름을 보고 명단 전체에 같은 문장을 보내는 경우도 있습니다. 상대에게는 한 줄이지만, 다음 차례는 당신에게 넘어옵니다." },
      { type: "h2", text: "방금 온 메시지를 읽는 법" },
      { type: "ul", items: [
        "**공백 이야기가 없습니다.** 몇 달을 조용하다가, 평범한 화요일처럼 말을 겁니다.",
        "**설명이 없습니다.** 첫 메시지에도 없고, 직접 물어봐도 안 나오는 경우가 많습니다.",
        "**진짜 묻는 게 없습니다.** “오랜만이네”, 오래된 게시물에 남긴 반응, 한 단어짜리 질문.",
        "**상대가 편할 때 옵니다.** 늦은 시간에, 갑자기, 당신이 아직 비어 있다고 가정한 채로.",
      ] },
      { type: "h2", accent: "green", text: "답할지 말지 정하는 법" },
      { type: "p", text: "답할 의무는 없고, 반가웠다고 해서 약한 것도 아닙니다. 질문 하나면 대체로 정리됩니다. 무슨 일이 있었는지 물어보세요. 따지듯이 말고 담담하게. “오랜만이야. 솔직히 3월에 무슨 일 있었어?” 두 번째 기회를 줄 만한 사람은 어색하더라도 곧이곧대로 답하고, 물었다는 이유로 당신을 피곤한 사람 취급하지 않습니다. 농담으로 넘기거나 화제를 돌리거나 다시 조용해지는 사람은, 앞으로의 3주를 미리 보여 준 셈입니다." },
      { type: "p", text: "답하기로 했다면 끊긴 지점이 아니라 지금 당신이 있는 자리에서 시작하세요. 그 몇 달을 상대도 어딘가에서 보냈고, 당신도 그랬습니다. 읽지 않고 두는 편이 낫다면 그것도 완결된 답입니다. 답하지 않는 건 무례가 아닙니다. 대화는 한참 전에 끝났고, 끝낸 사람은 상대였습니다." },
    ],
  },
  zh: {
    term: "诈尸式回归",
    summary:
      "当初玩消失的人隔了几个月突然回头，用一条轻描淡写的消息装作那段消失从没发生过。英文里叫 zombieing。",
    blocks: [
      { type: "h2", text: "他们为什么会回来" },
      { type: "p", text: "消息通常在深夜到达。写着“好久不见”或者“很突然，但我刚想到你”，对那四个月的空白只字不提。不提是故意的：一旦提起空白，就得解释，而那份解释正是他第一次躲开的对话。装作什么都没发生地出现，是成本最低的回来方式。" },
      { type: "p", text: "理由都很普通，而且多半跟你没关系。他在别处推进的事没成。一个闲下来的星期。无聊时翻了翻旧对话。有时候是在清理手机，看到你的名字，就把同一句话群发给名单上的所有人。他只花一句话，下一步却推给了你。" },
      { type: "h2", text: "怎么读刚收到的这条消息" },
      { type: "ul", items: [
        "**只字不提空白。** 沉默了好几个月，开口却像一个普通的星期二。",
        "**没有解释。** 第一条里没有，很多时候你直接问也问不出来。",
        "**没有真正的问题。** “好久不见”、给一条旧动态点个反应、一个词的问句。",
        "**在他方便的时候出现。** 很晚、很突然，并且默认你还空着。",
      ] },
      { type: "h2", accent: "green", text: "怎么决定要不要回" },
      { type: "p", text: "你没有义务回复，而收到消息觉得开心也不是软弱。一个问题基本就能定下来：问他到底发生了什么。不用带火气，就一句：“好久不见。说实话，三月那会儿是怎么了？”值得第二次的人会直接回答，可能有点笨拙，但不会因为你问了就把你说成难搞的人。把它笑过去、绕开话题、或者又安静下去的人，等于提前把接下来的三周演示给你看了。" },
      { type: "p", text: "如果你要回，就从你现在真正所在的位置开始，而不是从当初断掉的地方接着往下。这几个月他在某个地方过着，你也一样。如果你更想让它留着不读，那同样是一个完整的答案。不回不算没礼貌：这段对话早就结束了，而结束它的人不是你。" },
    ],
  },
  nl: {
    term: "Zombieing",
    summary:
      "De terugkeer van iemand die je heeft geghost: maanden later, uit het niets, met een luchtig berichtje dat doet alsof die verdwijning nooit heeft plaatsgevonden.",
    blocks: [
      { type: "h2", text: "Waarom ze terugkomen" },
      { type: "p", text: "Het bericht komt meestal laat op de avond. Er staat “hé vreemdeling” of “random, maar ik moest aan je denken”, en geen woord over die vier maanden niets. Dat is bewust. De stilte noemen betekent haar uitleggen, en die uitleg is precies het gesprek dat de eerste keer werd vermeden. Opduiken alsof er niets is gebeurd, is nu eenmaal de goedkoopste manier om terug te komen." },
      { type: "p", text: "De redenen zijn doodgewoon en gaan zelden over jou. Iets anders liep op niets uit. Een rustige week. Verveeld door oude chats scrollen. Soms ruimt iemand zijn telefoon op, ziet je naam en stuurt dezelfde zin naar iedereen op de lijst. Het kost één regel en legt de volgende zet bij jou neer." },
      { type: "h2", text: "Hoe je het bericht leest dat net binnenkwam" },
      { type: "ul", items: [
        "**Geen woord over de stilte.** Maanden niets, en het bericht begint als een gewone dinsdag.",
        "**Geen uitleg.** Niet in het eerste bericht, en vaak ook niet als je er direct naar vraagt.",
        "**Er wordt niets echts gevraagd.** “Hé vreemdeling”, een reactie op een oud verhaal, een vraag van één woord.",
        "**Het komt wanneer het die ander uitkomt.** Laat, plotseling en in de veronderstelling dat jij nog beschikbaar bent.",
      ] },
      { type: "h2", accent: "green", text: "Beslissen of je antwoordt" },
      { type: "p", text: "Niets verplicht je te antwoorden, en blij zijn met een bericht is geen zwakte. Eén vraag lost het meeste op: vraag wat er is gebeurd. Niet boos, gewoon: “Hé. Eerlijk, wat was er in maart?” Wie een tweede ronde waard is, geeft daar een recht antwoord op, misschien onhandig, en maakt jou niet tot de lastige omdat je het vraagt. Wie het wegwuift, van onderwerp verandert of opnieuw stil valt, heeft je zojuist de komende drie weken laten zien." },
      { type: "p", text: "Antwoord je wel, begin dan waar je nu echt bent, niet waar het ophield. Die maanden heeft de ander ergens doorgebracht, en jij ook. En als je het liever ongelezen laat, is dat net zo goed een compleet antwoord. Niet reageren is niet onbeleefd: het gesprek was allang geëindigd, en niet door jou." },
    ],
  },
  pl: {
    term: "Zombieing",
    summary:
      "Powrót osoby, która wcześniej zniknęła bez słowa: po miesiącach, znienacka i z lekką wiadomością udającą, że tamtego zniknięcia w ogóle nie było.",
    blocks: [
      { type: "h2", text: "Dlaczego wracają" },
      { type: "p", text: "Wiadomość przychodzi zwykle późnym wieczorem. Jest w niej „hej, nieznajomy” albo „totalnie losowo, ale przypomniałeś mi się”, i ani słowa o czterech miesiącach ciszy. To nie przypadek: wspomnieć o luce znaczy ją wyjaśnić, a to wyjaśnienie jest dokładnie tą rozmową, której ta osoba uniknęła za pierwszym razem. Pojawić się jak gdyby nigdy nic to po prostu najtańszy powrót." },
      { type: "p", text: "Powody są zwyczajne i rzadko dotyczą ciebie. Coś, co szło gdzie indziej, się rozsypało. Spokojny tydzień. Znudzone przewijanie starych rozmów. Czasem ktoś porządkuje telefon, widzi twoje imię i wysyła to samo zdanie do całej listy. Kosztuje go jedną linijkę, a następny ruch spada na ciebie." },
      { type: "h2", text: "Jak czytać wiadomość, która właśnie przyszła" },
      { type: "ul", items: [
        "**Ani słowa o przerwie.** Miesiące ciszy, a wiadomość zaczyna się jak zwykły wtorek.",
        "**Brak wyjaśnienia.** Ani w pierwszej wiadomości, ani często wtedy, gdy pytasz wprost.",
        "**Nie pyta o nic prawdziwego.** „Hej, nieznajomy”, reakcja na starą relację, pytanie z jednego słowa.",
        "**Przychodzi, kiedy tamtej osobie pasuje.** Późno, nagle i przy założeniu, że wciąż jesteś dostępny.",
      ] },
      { type: "h2", accent: "green", text: "Jak zdecydować, czy odpisać" },
      { type: "p", text: "Nic cię nie zobowiązuje do odpowiedzi, a radość z tego, że ktoś się odezwał, nie jest słabością. Jedno pytanie załatwia większość sprawy: zapytaj, co się stało. Bez złości, po prostu: „Cześć. Szczerze, co się wydarzyło w marcu?”. Ktoś wart drugiej rundy odpowie wprost, może niezgrabnie, i nie zrobi z ciebie osoby trudnej za samo pytanie. Ktoś, kto obróci to w żart, ucieknie w bok albo znowu zamilknie, właśnie pokazał ci najbliższe trzy tygodnie." },
      { type: "p", text: "Jeśli odpisujesz, zacznij od miejsca, w którym naprawdę jesteś, a nie od tego, gdzie skończyliście. Tamte miesiące ta osoba gdzieś spędziła — ty też. A jeśli wolisz zostawić wiadomość nieprzeczytaną, to również pełna odpowiedź. Brak odpowiedzi to nie brak kultury: rozmowa skończyła się dawno temu i nie ty ją zakończyłeś." },
    ],
  },
  sv: {
    term: "Zombieing",
    summary:
      "Att någon som ghostat dig dyker upp igen — månader senare, från ingenstans, med ett lättsamt meddelande som låtsas att försvinnandet aldrig hände.",
    blocks: [
      { type: "h2", text: "Varför de kommer tillbaka" },
      { type: "p", text: "Meddelandet kommer oftast sent på kvällen. Det står ”hej främling” eller ”helt random, men jag tänkte på dig”, och inte ett ord om de fyra månaderna av ingenting. Det är medvetet. Att nämna luckan innebär att förklara den, och just den förklaringen är samtalet som undveks första gången. Att dyka upp som om inget hänt är helt enkelt den billigaste vägen tillbaka." },
      { type: "p", text: "Skälen är vardagliga och handlar sällan om dig. Något annat som hen höll på med rann ut i sanden. En lugn vecka. Uttråkat bläddrande i gamla chattar. Ibland rensar någon i telefonen, ser ditt namn och skickar samma rad till alla på listan. Det kostar en mening och lämnar nästa drag till dig." },
      { type: "h2", text: "Hur du läser meddelandet som precis kom" },
      { type: "ul", items: [
        "**Inte ett ord om luckan.** Månaders tystnad, och meddelandet börjar som en vanlig tisdag.",
        "**Ingen förklaring.** Inte i första meddelandet, och ofta inte ens när du frågar rakt ut.",
        "**Det frågar ingenting på riktigt.** ”Hej främling”, en reaktion på en gammal story, en fråga på ett ord.",
        "**Det kommer när det passar hen.** Sent, plötsligt och med antagandet att du fortfarande är ledig.",
      ] },
      { type: "h2", accent: "green", text: "Att avgöra om du ska svara" },
      { type: "p", text: "Ingenting tvingar dig att svara, och att bli glad är ingen svaghet. En fråga avgör det mesta: fråga vad som hände. Inte argt, bara ”Hej. Ärligt, vad hände i mars?” Den som är värd en andra runda svarar rakt, kanske klumpigt, och gör dig inte till den jobbiga för att du frågade. Den som skämtar bort det, byter spår eller tystnar igen har just visat dig de närmaste tre veckorna." },
      { type: "p", text: "Svarar du, börja där du faktiskt är, inte där ni slutade. De där månaderna tillbringade hen någonstans, och det gjorde du också. Och vill du hellre låta det ligga oläst är det också ett helt svar. Att inte svara är inte oartigt: samtalet tog slut för länge sedan, och det var inte du som avslutade det." },
    ],
  },
  hi: {
    term: "ज़ॉम्बीइंग",
    summary:
      "जिसने पहले बिना कुछ कहे गायब कर दिया था, उसका महीनों बाद अचानक लौट आना — एक हल्के-से मैसेज के साथ, मानो वह गायब होना कभी हुआ ही न हो।",
    blocks: [
      { type: "h2", text: "वे लौटते क्यों हैं" },
      { type: "p", text: "मैसेज आमतौर पर देर रात आता है। उसमें “बहुत दिन हो गए” या “अचानक तुम्हारी याद आ गई” लिखा होता है, और उन चार महीनों की चुप्पी का एक भी ज़िक्र नहीं होता। यह चुप्पी जान-बूझकर है: उस खाली जगह का नाम लेते ही उसे समझाना पड़ेगा, और वही समझाना वह बातचीत है जिससे पहली बार बचा गया था। कुछ हुआ ही न हो — इस अंदाज़ में लौटना सबसे सस्ता रास्ता है।" },
      { type: "p", text: "वजहें बेहद मामूली होती हैं और अक्सर आपसे जुड़ी ही नहीं होतीं। कहीं और चल रही कोई बात बिगड़ गई। एक खाली हफ़्ता। बोरियत में पुरानी चैट स्क्रॉल करना। कभी-कभी वह फ़ोन साफ़ कर रहा होता है, आपका नाम दिखता है, और वही एक लाइन पूरी सूची को भेज देता है। उसे एक वाक्य लगता है और अगला कदम आपके पाले में आ जाता है।" },
      { type: "h2", text: "अभी-अभी आए मैसेज को कैसे पढ़ें" },
      { type: "ul", items: [
        "**खाली अरसे का ज़िक्र नहीं।** महीनों की चुप्पी, और मैसेज किसी आम मंगलवार जैसा शुरू होता है।",
        "**कोई सफ़ाई नहीं।** न पहले मैसेज में, और अक्सर सीधे पूछने पर भी नहीं।",
        "**कुछ असली नहीं पूछता।** “बहुत दिन हो गए”, किसी पुरानी स्टोरी पर रिएक्शन, एक शब्द का सवाल।",
        "**उसकी सुविधा से आता है।** देर रात, अचानक, और यह मानकर कि आप अब भी खाली हैं।",
      ] },
      { type: "h2", accent: "green", text: "जवाब देना है या नहीं, कैसे तय करें" },
      { type: "p", text: "जवाब देना ज़रूरी नहीं है, और खुशी होना कमज़ोरी नहीं है। ज़्यादातर बात एक सवाल से तय हो जाती है: पूछ लीजिए कि हुआ क्या था। गुस्से में नहीं, सीधे-सादे ढंग से: “सुनो, सच बताओ — मार्च में क्या हुआ था?” जो दूसरा मौका पाने लायक होगा, वह साफ़-साफ़ जवाब देगा, भले थोड़ा अटककर, और पूछने भर से आपको मुश्किल इंसान नहीं बनाएगा। जो हँसी में उड़ा दे, बात घुमा दे या दोबारा चुप हो जाए, उसने अगले तीन हफ़्ते पहले ही दिखा दिए।" },
      { type: "p", text: "अगर जवाब देना ही है, तो वहीं से शुरू कीजिए जहाँ आप सचमुच खड़े हैं, वहाँ से नहीं जहाँ बात रुकी थी। वे महीने उसने कहीं बिताए हैं, और आपने भी। और अगर मैसेज बिना पढ़े छोड़ देना बेहतर लगता है, तो वह भी पूरा जवाब है। जवाब न देना बदतमीज़ी नहीं है: बातचीत बहुत पहले खत्म हो चुकी थी, और खत्म आपने नहीं की थी।" },
    ],
  },
};
