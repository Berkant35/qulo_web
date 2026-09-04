import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Orbiting — they stopped talking to you but keep watching everything you post.
 *
 * Judgement calls a later editor should not undo by accident:
 *
 * - The point the page is built around is the contradiction: the silence says
 *   one thing and the attention says the opposite, on the same screen, every
 *   day. That is what separates orbiting from `ghosting` (silence and absence),
 *   `cloaking` (silence and erasure) and `zombieing` (silence, then a message).
 *   Every locale states it in its own words in block 2 and returns to it in
 *   block 7. Keep the contradiction, not the phrasing.
 *
 * - "A view carries no information about what anyone wants" is the load-bearing
 *   line. It is the thing the reader searching at 1am is getting wrong, and it
 *   is why block 6 names posting-for-an-audience-of-one as the option that does
 *   not work. Do not soften it into "maybe they still care".
 *
 * - No app, feature or platform is named, in any locale — no story/close-friends
 *   feature by its branded name, no network. Mute, restrict, block and story
 *   views are described generically because every network has them.
 *
 * - No statistic. Nothing sourced exists on how common this is, so nothing is
 *   claimed, and the burnout figure from `ghosting` is not recycled here.
 *
 * - No Qulo angle. A quiz cannot stop anyone watching from a distance, and
 *   orbiting mostly happens on social networks rather than in a dating app at
 *   all. Block 7 is spent on the useful distinction between attention and
 *   intention instead.
 *
 * - Term names. Loanword in most locales; `ar` الأوربيتينغ, `ru` орбитинг,
 *   `ja` オービティング, `ko` 오르비팅, `hi` ऑर्बिटिंग, and `zh` 绕圈式关注,
 *   built on the same X式Y pattern as the other zh terms in this cluster, with
 *   "orbiting" named in the summary.
 */
export const orbiting: LocalizedGlossaryEntry = {
  en: {
    term: "Orbiting",
    summary:
      "Staying in someone's digital orbit after cutting off contact — no replies and no conversation, but every story watched and the occasional old post liked.",
    blocks: [
      { type: "h2", text: "The silence that keeps watching" },
      { type: "p", text: "They stopped talking to you. They did not stop looking. Every story gets a view, an old photo picks up a like, and their little circle sits at the top of your list most mornings. Nothing is ever said. Orbiting is what happens when someone wants out of the conversation but not out of your life — or when they never made a decision at all, and watching costs them nothing." },
      { type: "p", text: "That is what makes it hard to sit with. A clean disappearance is at least legible. Here the silence says this is over and the attention says I am still here, on the same screen, every day. So you start hunting for a message inside a story view. There is not one in there. A view carries no information about what anyone wants." },
      { type: "h2", text: "How to recognise it" },
      { type: "ul", items: [
        "**Views without words.** First on every story, silent in every inbox.",
        "**Likes on the old stuff.** A photo from last year, a post they would have to scroll a long way to find.",
        "**Nothing when it matters.** You post something big and the watching still never turns into a sentence.",
        "**It restarts when you go quiet.** You stop posting, and they turn up somewhere else — a follow, a reaction.",
      ] },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "You have three options and all of them are fine. Ask directly: one message, “You're around but you're not talking to me. What's going on?” Mute or restrict them, which ends the daily appearance without the announcement a block makes. Or block, if the low hum is genuinely costing you something. The one thing that does not work is the fourth option everyone tries: posting for an audience of one and reading the view list for a verdict." },
      { type: "p", text: "And try not to read attention as intention. Someone can watch you for months with no plan to ever say anything, because looking is easy and speaking is not. If you want to know where you stand, asking is the only reliable way — and more silence after you ask is an answer too, just not the one you were hoping for." },
    ],
  },
  tr: {
    term: "Orbiting",
    summary:
      "İletişimi kesen birinin senin dijital yörüngende kalmaya devam etmesi — ne cevap var ne sohbet, ama her hikâye izlenmiş ve arada eski bir paylaşım beğenilmiş.",
    blocks: [
      { type: "h2", text: "İzlemeye devam eden sessizlik" },
      { type: "p", text: "Seninle konuşmayı bıraktı ama bakmayı bırakmadı. Her hikâyende adı görünüyor, eski bir fotoğrafa beğeni geliyor, sabahları listenin başında yine o küçük halka duruyor. Tek kelime yok. Orbiting, birinin sohbetten çıkmak isteyip hayatından çıkmak istemediği yerde oluyor — ya da hiç karar vermediği yerde, çünkü izlemenin ona bir bedeli yok." },
      { type: "p", text: "Zor olan tam da bu. Temiz bir kayboluş en azından okunabilir. Burada sessizlik “bu bitti” derken ilgi “ben hâlâ buradayım” diyor; aynı ekranda, her gün. Sen de bir hikâye izlenmesinin içinde mesaj aramaya başlıyorsun. Orada mesaj yok. Bir izlenme, kimsenin ne istediğine dair hiçbir bilgi taşımaz." },
      { type: "h2", text: "Nasıl anlaşılır" },
      { type: "ul", items: [
        "**Kelimesiz izlemeler.** Her hikâyede ilk sırada, her sohbette sessiz.",
        "**Eskilere beğeni.** Geçen yıldan bir fotoğraf, bulmak için epey aşağı inmesi gereken bir paylaşım.",
        "**Önemli anda hiçbir şey yok.** Büyük bir şey paylaşıyorsun ve o izleme yine bir cümleye dönüşmüyor.",
        "**Sen susunca yeniden başlıyor.** Paylaşmayı bırakıyorsun, o başka bir yerde beliriyor: bir takip, bir tepki.",
      ] },
      { type: "h2", accent: "green", text: "Ne yapmalı" },
      { type: "p", text: "Üç seçeneğin var ve üçü de gayet meşru. Doğrudan sor: tek mesaj, “Ortalıktasın ama benimle konuşmuyorsun. Ne oluyor?” Sessize al ya da kısıtla; günlük görünmesi biter, engellemenin verdiği ilan havası da olmaz. Ya da engelle, bu alçak uğultu sana gerçekten bir şeye mal oluyorsa. İşe yaramayan tek şey, herkesin denediği dördüncü seçenek: tek kişilik bir seyirci için paylaşım yapıp izlenme listesinden hüküm okumaya çalışmak." },
      { type: "p", text: "Bir de ilgiyi niyet diye okumamaya çalış. Biri seni aylarca izleyebilir ve tek kelime etmeye hiç niyeti olmayabilir; çünkü bakmak kolay, konuşmak değil. Nerede durduğunu öğrenmek istiyorsan tek güvenilir yol sormak — sorduktan sonra gelen sessizlik de bir cevaptır, sadece umduğun cevap değildir." },
    ],
  },
  de: {
    term: "Orbiting",
    summary:
      "In der digitalen Umlaufbahn von jemandem zu bleiben, mit dem der Kontakt abgebrochen ist – keine Antworten, kein Gespräch, aber jede Story gesehen und ab und zu ein altes Bild geliket.",
    blocks: [
      { type: "h2", text: "Die Stille, die weiter zusieht" },
      { type: "p", text: "Diese Person hat aufgehört zu schreiben. Aufgehört zu schauen hat sie nicht. Jede Story bekommt einen Aufruf, ein altes Foto ein Like, und morgens steht der kleine Kreis wieder ganz oben in deiner Liste. Gesagt wird nie etwas. Orbiting passiert, wenn jemand aus dem Gespräch raus will, aber nicht aus deinem Leben – oder wenn nie eine Entscheidung fiel und Zuschauen einfach nichts kostet." },
      { type: "p", text: "Genau das macht es so schwer auszuhalten. Ein sauberes Verschwinden ist wenigstens eindeutig. Hier sagt die Stille „das ist vorbei“ und die Aufmerksamkeit sagt „ich bin noch da“, auf demselben Bildschirm, jeden Tag. Also fängst du an, in einem Story-Aufruf nach einer Nachricht zu suchen. Da ist keine drin. Ein Aufruf sagt nichts darüber, was jemand will." },
      { type: "h2", text: "Woran du es erkennst" },
      { type: "ul", items: [
        "**Aufrufe ohne Worte.** Ganz vorn bei jeder Story, stumm in jedem Chat.",
        "**Likes auf Altes.** Ein Foto von letztem Jahr, ein Beitrag, für den man weit scrollen muss.",
        "**Nichts, wenn es zählt.** Du postest etwas Großes, und aus dem Zuschauen wird trotzdem kein Satz.",
        "**Es fängt wieder an, wenn du still wirst.** Du postest nicht mehr, und die Person taucht woanders auf – ein Follow, eine Reaktion.",
      ] },
      { type: "h2", accent: "green", text: "Was du dagegen tun kannst" },
      { type: "p", text: "Du hast drei Möglichkeiten, und alle drei sind in Ordnung. Frag direkt: eine Nachricht, „Du bist da, redest aber nicht mit mir. Was ist los?“ Stummschalten oder einschränken – das tägliche Auftauchen hört auf, ohne die Ansage, die ein Blockieren ist. Oder blockieren, wenn dieses leise Dauerrauschen dich wirklich etwas kostet. Was nicht funktioniert, ist die vierte Variante, die alle probieren: für ein Publikum von einer Person posten und die Aufrufliste nach einem Urteil absuchen." },
      { type: "p", text: "Und versuch, Aufmerksamkeit nicht als Absicht zu lesen. Jemand kann dir monatelang zusehen, ohne je vorzuhaben, etwas zu sagen – Schauen ist leicht, Reden nicht. Wenn du wissen willst, woran du bist, ist Fragen der einzige verlässliche Weg. Und Schweigen nach dieser Frage ist auch eine Antwort, nur nicht die erhoffte." },
    ],
  },
  fr: {
    term: "Orbiting",
    summary:
      "Le fait de rester dans l'orbite numérique de quelqu'un après avoir coupé le contact : aucune réponse, aucune conversation, mais chaque story vue et un vieux post aimé de temps en temps.",
    blocks: [
      { type: "h2", text: "Le silence qui continue de regarder" },
      { type: "p", text: "Cette personne a cessé de vous parler. Elle n'a pas cessé de regarder. Chaque story récolte une vue, une vieille photo un like, et son petit cercle se retrouve en haut de votre liste presque tous les matins. Rien n'est jamais dit. L'orbiting arrive quand quelqu'un veut sortir de la conversation mais pas de votre vie — ou quand aucune décision n'a jamais été prise, et que regarder ne coûte rien." },
      { type: "p", text: "C'est précisément ce qui rend la chose difficile. Une disparition nette est au moins lisible. Ici, le silence dit « c'est fini » et l'attention dit « je suis encore là », sur le même écran, tous les jours. Alors vous cherchez un message à l'intérieur d'une vue de story. Il n'y en a pas. Une vue ne dit rien de ce que l'autre veut." },
      { type: "h2", text: "Comment le reconnaître" },
      { type: "ul", items: [
        "**Des vues, jamais de mots.** En tête de chaque story, muet dans toutes les conversations.",
        "**Des likes sur du vieux.** Une photo de l'an dernier, un post qu'il faut aller chercher loin.",
        "**Rien quand ça compte.** Vous publiez quelque chose d'important et le regard ne devient toujours pas une phrase.",
        "**Ça repart quand vous vous taisez.** Vous arrêtez de publier, la personne réapparaît ailleurs : un abonnement, une réaction.",
      ] },
      { type: "h2", accent: "green", text: "Quoi faire" },
      { type: "p", text: "Vous avez trois options, toutes légitimes. Demander franchement : un message, « Tu es là mais tu ne me parles pas. Il se passe quoi ? » Mettre en sourdine ou restreindre : l'apparition quotidienne s'arrête sans la déclaration que constitue un blocage. Ou bloquer, si ce bruit de fond vous coûte réellement quelque chose. Ce qui ne marche pas, c'est la quatrième option que tout le monde essaie : publier pour un public d'une seule personne et lire la liste des vues comme un verdict." },
      { type: "p", text: "Et essayez de ne pas confondre attention et intention. On peut vous regarder pendant des mois sans jamais avoir l'intention de parler, parce que regarder est facile et parler ne l'est pas. Pour savoir où vous en êtes, demander reste la seule méthode fiable — et le silence qui suit la question est lui aussi une réponse, simplement pas celle que vous espériez." },
    ],
  },
  es: {
    term: "Orbiting",
    summary:
      "Quedarse en la órbita digital de alguien después de cortar el contacto: ni respuestas ni conversación, pero todas las historias vistas y algún «me gusta» en publicaciones viejas.",
    blocks: [
      { type: "h2", text: "El silencio que sigue mirando" },
      { type: "p", text: "Dejó de hablarte. No dejó de mirarte. Cada historia suma una visita, una foto antigua recibe un «me gusta» y su circulito aparece arriba de tu lista casi todas las mañanas. Nunca se dice nada. El orbiting pasa cuando alguien quiere salir de la conversación pero no de tu vida, o cuando nunca tomó ninguna decisión y mirar no le cuesta nada." },
      { type: "p", text: "Eso es justo lo difícil de llevar. Una desaparición limpia al menos se entiende. Aquí el silencio dice «esto se acabó» y la atención dice «sigo aquí», en la misma pantalla, todos los días. Y entonces empiezas a buscar un mensaje dentro de una visita a una historia. Ahí no hay ninguno. Una visita no dice nada sobre lo que alguien quiere." },
      { type: "h2", text: "Cómo reconocerlo" },
      { type: "ul", items: [
        "**Visitas sin palabras.** El primero en cada historia, mudo en todos los chats.",
        "**«Me gusta» en lo viejo.** Una foto del año pasado, una publicación que hay que bajar mucho para encontrar.",
        "**Nada cuando importa.** Publicas algo grande y ese mirar sigue sin convertirse en una frase.",
        "**Vuelve a empezar cuando te callas.** Dejas de publicar y aparece en otro sitio: un seguimiento, una reacción.",
      ] },
      { type: "h2", accent: "green", text: "Qué hacer" },
      { type: "p", text: "Tienes tres opciones y las tres valen. Preguntar directamente: un mensaje, «Estás por ahí pero no me hablas. ¿Qué pasa?». Silenciar o restringir: se acaba la aparición diaria sin el anuncio que supone bloquear. O bloquear, si ese ruido de fondo de verdad te está costando algo. Lo que no funciona es la cuarta opción que prueba todo el mundo: publicar para un público de una sola persona y leer la lista de visitas como si fuera un veredicto." },
      { type: "p", text: "Y procura no leer la atención como intención. Alguien puede mirarte durante meses sin ninguna intención de decir nada, porque mirar es fácil y hablar no. Si quieres saber en qué punto estás, preguntar es el único camino fiable, y el silencio que llega después de preguntar también es una respuesta: solo que no la que esperabas." },
    ],
  },
  ar: {
    term: "الأوربيتينغ",
    summary:
      "أن يبقى شخص في مدارك الرقمي بعد أن قطع التواصل معك؛ لا ردود ولا حديث، لكنه يشاهد كل قصة ويضع إعجابًا على منشور قديم بين حين وآخر.",
    blocks: [
      { type: "h2", text: "الصمت الذي يواصل المشاهدة" },
      { type: "p", text: "توقف عن الكلام معك، لكنه لم يتوقف عن النظر. كل قصة تنشرها تحصل على مشاهدة منه، وصورة قديمة تنال إعجابًا، ودائرته الصغيرة تتصدّر قائمتك في معظم الصباحات. ولا يُقال شيء أبدًا. الأوربيتينغ يحدث حين يريد أحدهم الخروج من المحادثة دون الخروج من حياتك، أو حين لا يتخذ قرارًا من الأساس لأن المشاهدة لا تكلّفه شيئًا." },
      { type: "p", text: "وهذا تحديدًا ما يصعب احتماله. الاختفاء التام مفهوم على الأقل. أما هنا فالصمت يقول «انتهى الأمر» والانتباه يقول «ما زلت هنا»، على الشاشة نفسها، كل يوم. فتبدأ بالبحث عن رسالة داخل مشاهدة قصة. لا رسالة هناك؛ المشاهدة لا تحمل أي معلومة عمّا يريده صاحبها." },
      { type: "h2", text: "كيف تتعرّف عليه" },
      { type: "ul", items: [
        "**مشاهدات بلا كلمات.** أول من يشاهد كل قصة، وصامت في كل محادثة.",
        "**إعجابات بالقديم.** صورة من العام الماضي، أو منشور يحتاج نزولًا طويلًا للوصول إليه.",
        "**لا شيء حين يهمّ الأمر.** تنشر شيئًا مهمًا، وتبقى المشاهدة مشاهدة ولا تتحول إلى جملة.",
        "**يعود كلما صمتَّ أنت.** تتوقف عن النشر، فيظهر في مكان آخر: متابعة جديدة أو تفاعل.",
      ] },
      { type: "h2", accent: "green", text: "ماذا تفعل حيال ذلك" },
      { type: "p", text: "أمامك ثلاثة خيارات، وكلها مقبولة. أن تسأل مباشرة برسالة واحدة: «أنت موجود لكنك لا تكلّمني. ما الذي يحدث؟». أو أن تكتم حسابه أو تقيّده، فيتوقف الظهور اليومي دون الإعلان الذي يحمله الحظر. أو أن تحظره، إن كان هذا الضجيج الخافت يكلّفك شيئًا فعلًا. الشيء الوحيد الذي لا ينفع هو الخيار الرابع الذي يجرّبه الجميع: أن تنشر لجمهور من شخص واحد وتقرأ قائمة المشاهدات كأنها حكم." },
      { type: "p", text: "وحاول ألا تقرأ الاهتمام على أنه نية. قد يشاهدك أحدهم شهورًا دون أي نية للكلام، لأن النظر سهل والكلام ليس كذلك. إن أردت أن تعرف موقعك، فالسؤال هو الطريق الموثوق الوحيد — والصمت الذي يلي سؤالك جواب أيضًا، لكنه ليس الجواب الذي كنت تتمناه." },
    ],
  },
  ru: {
    term: "орбитинг",
    summary:
      "Ситуация, когда человек оборвал общение, но остался в вашей цифровой орбите: ни ответов, ни разговора, зато просмотрены все истории и время от времени поставлен лайк старой записи.",
    blocks: [
      { type: "h2", text: "Молчание, которое продолжает смотреть" },
      { type: "p", text: "Разговаривать он перестал. Смотреть — нет. Каждая история собирает его просмотр, старое фото получает лайк, а маленький кружок по утрам снова стоит в начале вашего списка. И ни одного слова. Орбитинг случается, когда человек хочет выйти из переписки, но не из вашей жизни, — или когда он вообще не принял решения, потому что смотреть ничего не стоит." },
      { type: "p", text: "Именно это тяжело выдерживать. Чистое исчезновение хотя бы читается однозначно. Здесь молчание говорит «всё кончено», а внимание говорит «я всё ещё тут», на том же экране, каждый день. И вы начинаете искать сообщение внутри просмотра истории. Его там нет. Просмотр не несёт никакой информации о том, чего человек хочет." },
      { type: "h2", text: "Как это распознать" },
      { type: "ul", items: [
        "**Просмотры без слов.** Первый в каждой истории и молчит во всех переписках.",
        "**Лайки на старом.** Фото годовой давности, запись, до которой надо долго листать.",
        "**Ничего в важный момент.** Вы публикуете что-то большое, а просмотр так и не превращается во фразу.",
        "**Всё начинается заново, когда затихаете вы.** Перестаёте выкладывать — и человек появляется в другом месте: подписка, реакция.",
      ] },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "У вас три варианта, и все три нормальные. Спросить прямо — одно сообщение: «Ты рядом, но не разговариваешь со мной. Что происходит?» Отключить уведомления или ограничить: ежедневное появление прекращается без заявления, которым выглядит блокировка. Или заблокировать, если этот тихий фон действительно чего-то вам стоит. Не работает только четвёртый вариант, который пробуют все: выкладывать посты для аудитории из одного человека и читать список просмотров как приговор." },
      { type: "p", text: "И постарайтесь не принимать внимание за намерение. Человек может смотреть на вас месяцами, вовсе не собираясь ничего говорить: смотреть легко, говорить — нет. Если хотите знать, на каком вы свете, спросить — единственный надёжный способ. А молчание после вопроса тоже ответ, просто не тот, на который вы надеялись." },
    ],
  },
  pt: {
    term: "Orbiting",
    summary:
      "Continuar na órbita digital de alguém depois de cortar o contato: sem respostas e sem conversa, mas com todos os stories vistos e uma curtida ocasional em posts antigos.",
    blocks: [
      { type: "h2", text: "O silêncio que continua olhando" },
      { type: "p", text: "A pessoa parou de falar com você. Não parou de olhar. Cada story ganha uma visualização, uma foto antiga recebe uma curtida e a bolinha dela aparece no topo da sua lista quase toda manhã. Nunca se diz nada. O orbiting acontece quando alguém quer sair da conversa mas não da sua vida — ou quando nunca tomou decisão nenhuma, porque olhar não custa nada." },
      { type: "p", text: "É isso que é difícil de aguentar. Um sumiço limpo pelo menos se entende. Aqui o silêncio diz “acabou” e a atenção diz “ainda estou aqui”, na mesma tela, todo dia. Aí você começa a procurar uma mensagem dentro de uma visualização de story. Não tem nenhuma ali. Uma visualização não carrega nenhuma informação sobre o que a pessoa quer." },
      { type: "h2", text: "Como reconhecer" },
      { type: "ul", items: [
        "**Visualizações sem palavras.** Primeiro em todo story, calado em toda conversa.",
        "**Curtidas no que é velho.** Uma foto do ano passado, um post que exige rolar bastante para achar.",
        "**Nada quando importa.** Você posta algo grande e aquele olhar continua sem virar uma frase.",
        "**Recomeça quando você se cala.** Você para de postar e a pessoa aparece em outro canto: um seguir, uma reação.",
      ] },
      { type: "h2", accent: "green", text: "O que fazer com isso" },
      { type: "p", text: "Você tem três opções e as três são válidas. Perguntar direto: uma mensagem, “Você está por aí mas não fala comigo. O que está rolando?” Silenciar ou restringir: acaba a aparição diária sem o anúncio que um bloqueio faz. Ou bloquear, se esse zumbido baixo está mesmo te custando alguma coisa. O que não funciona é a quarta opção que todo mundo tenta: postar para uma plateia de uma pessoa só e ler a lista de visualizações como se fosse um veredito." },
      { type: "p", text: "E tente não ler atenção como intenção. Alguém pode te olhar por meses sem nenhum plano de dizer qualquer coisa, porque olhar é fácil e falar não é. Se você quer saber em que pé está, perguntar é o único caminho confiável — e o silêncio depois da pergunta também é uma resposta, só que não a que você queria." },
    ],
  },
  it: {
    term: "Orbiting",
    summary:
      "Restare nell'orbita digitale di qualcuno dopo aver chiuso il contatto: nessuna risposta e nessuna conversazione, ma tutte le storie viste e qualche like sui post vecchi.",
    blocks: [
      { type: "h2", text: "Il silenzio che continua a guardare" },
      { type: "p", text: "Ha smesso di parlarti. Non ha smesso di guardare. Ogni storia raccoglie una visualizzazione, una foto vecchia prende un like, e quel cerchietto sta in cima alla tua lista quasi ogni mattina. Non viene detto mai niente. L'orbiting succede quando una persona vuole uscire dalla conversazione ma non dalla tua vita — o quando non ha mai preso nessuna decisione, perché guardare non le costa nulla." },
      { type: "p", text: "È proprio questo che è difficile da reggere. Una sparizione netta almeno si legge. Qui il silenzio dice «è finita» e l'attenzione dice «ci sono ancora», sullo stesso schermo, tutti i giorni. Così ti metti a cercare un messaggio dentro la visualizzazione di una storia. Lì dentro non c'è. Una visualizzazione non dice niente su cosa vuole quella persona." },
      { type: "h2", text: "Come riconoscerlo" },
      { type: "ul", items: [
        "**Visualizzazioni senza parole.** Primo in ogni storia, muto in ogni chat.",
        "**Like sulle cose vecchie.** Una foto dell'anno scorso, un post da andare a cercare in fondo.",
        "**Niente quando conta.** Pubblichi qualcosa di importante e quel guardare non diventa comunque una frase.",
        "**Riparte quando smetti tu.** Non pubblichi più e ricompare da un'altra parte: un follow, una reazione.",
      ] },
      { type: "h2", accent: "green", text: "Cosa puoi farci" },
      { type: "p", text: "Hai tre possibilità e vanno bene tutte. Chiedere in modo diretto: un messaggio, «Ci sei ma non mi parli. Che succede?». Silenziare o limitare: la comparsa quotidiana finisce senza l'annuncio che un blocco porta con sé. Oppure bloccare, se quel ronzio di fondo ti sta davvero costando qualcosa. Quello che non funziona è la quarta opzione che provano tutti: pubblicare per un pubblico di una persona sola e leggere la lista delle visualizzazioni come un verdetto." },
      { type: "p", text: "E prova a non scambiare l'attenzione per intenzione. Una persona può guardarti per mesi senza avere alcuna intenzione di dire qualcosa, perché guardare è facile e parlare no. Se vuoi sapere a che punto sei, chiedere resta l'unico modo affidabile — e anche il silenzio dopo la domanda è una risposta, solo non quella che speravi." },
    ],
  },
  ja: {
    term: "オービティング",
    summary:
      "連絡を絶った相手が、SNS上の距離だけは保ち続けること。返信も会話もないのに、ストーリーは毎回見られ、古い投稿にときどき「いいね」がつきます。",
    blocks: [
      { type: "h2", text: "見ることだけをやめない沈黙" },
      { type: "p", text: "話しかけてはこないのに、見るのはやめません。ストーリーには毎回その名前が並び、古い写真に「いいね」がつき、朝いちばんのリストの先頭にはあの丸いアイコンがいます。それでも言葉は一度も来ません。オービティングは、会話からは抜けたいけれど、あなたの世界からは抜けたくない人に起こります。あるいは、そもそも何も決めていない人に。見るだけなら何の負担もないからです。" },
      { type: "p", text: "つらいのはまさにそこです。きれいに消えてくれれば、意味はひとつに読めます。ところがここでは、沈黙が「終わった」と言い、注目が「まだいるよ」と言う。同じ画面の上で、毎日です。だからストーリーの閲覧履歴の中にメッセージを探し始めます。そこには入っていません。閲覧は、相手が何を望んでいるかを何ひとつ伝えないからです。" },
      { type: "h2", text: "見分け方" },
      { type: "ul", items: [
        "**言葉のない閲覧。** どのストーリーでも上位に並び、トークでは無言。",
        "**古い投稿への「いいね」。** 去年の写真、かなりさかのぼらないと出てこない投稿。",
        "**肝心なときに何もない。** 大きな報告を出しても、見るだけで一文にはならない。",
        "**こちらが黙ると再開する。** 投稿をやめると、別の場所に現れる——フォロー、リアクション。",
      ] },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "選べる道は三つあり、どれを選んでも構いません。直接聞く——「見てはいるのに話しかけてこないよね。どうしたの？」の一通。ミュートや制限をかける——毎日の登場は止まり、ブロックのような宣言にはなりません。あるいはブロックする——この低い雑音が本当に消耗になっているなら。うまくいかないのは、みんなが試す四つ目です。たった一人の観客のために投稿し、閲覧履歴から判定を読み取ろうとすること。" },
      { type: "p", text: "そして、注目を意思と読み替えないでください。話す気がまったくないまま、何か月も見続けることは十分にありえます。見るのは簡単で、話すのは簡単ではないからです。自分の立ち位置を知りたいなら、確実な方法は尋ねることだけです。尋ねたあとの沈黙もまた答えで、ただ望んでいた答えではないだけです。" },
    ],
  },
  ko: {
    term: "오르비팅",
    summary:
      "연락은 끊었으면서 SNS 주변에는 계속 머무는 일. 답장도 대화도 없지만 스토리는 매번 보고, 가끔 오래된 게시물에 좋아요를 누릅니다.",
    blocks: [
      { type: "h2", text: "보는 것만은 멈추지 않는 침묵" },
      { type: "p", text: "말은 걸지 않는데 보는 건 멈추지 않습니다. 스토리마다 그 이름이 뜨고, 오래된 사진에 좋아요가 눌리고, 아침이면 목록 맨 앞에 그 동그란 아이콘이 있습니다. 그런데 한마디도 오지 않습니다. 오르비팅은 대화에서는 빠지고 싶지만 당신의 세계에서는 빠지고 싶지 않은 사람에게 일어납니다. 혹은 아무것도 정하지 않은 사람에게요. 보는 데는 아무 비용이 들지 않으니까요." },
      { type: "p", text: "견디기 힘든 지점이 정확히 거기입니다. 깨끗하게 사라지면 뜻이라도 하나로 읽힙니다. 여기서는 침묵이 “끝났다”라고 말하고, 관심이 “아직 있어”라고 말합니다. 같은 화면 위에서, 매일. 그래서 스토리 조회 목록 안에서 메시지를 찾기 시작합니다. 거기엔 없습니다. 조회 기록은 상대가 무엇을 원하는지 아무것도 알려 주지 않습니다." },
      { type: "h2", text: "어떻게 알아볼까" },
      { type: "ul", items: [
        "**말 없는 조회.** 스토리마다 맨 위에 있고, 대화창에서는 아무 말이 없습니다.",
        "**오래된 것에 눌린 좋아요.** 작년 사진, 한참 내려야 나오는 게시물.",
        "**정작 중요한 순간엔 없습니다.** 큰 소식을 올려도 그 시선은 끝내 한 문장이 되지 않습니다.",
        "**당신이 조용해지면 다시 시작됩니다.** 게시를 멈추면 다른 데서 나타납니다 — 팔로우, 반응.",
      ] },
      { type: "h2", accent: "green", text: "그래서 뭘 하면 되나" },
      { type: "p", text: "선택지는 세 개고, 셋 다 괜찮습니다. 직접 묻기 — “보고는 있는데 말은 안 걸더라. 무슨 일이야?” 한 통이면 됩니다. 음소거하거나 제한하기 — 매일의 등장이 멈추고, 차단처럼 선언이 되지도 않습니다. 아니면 차단하기 — 이 낮은 소음이 정말로 당신을 갉아먹고 있다면요. 통하지 않는 건 다들 시도하는 네 번째입니다. 관객 한 명을 위해 게시물을 올리고, 조회 목록에서 판정을 읽어내려는 일이요." },
      { type: "p", text: "그리고 관심을 의도로 읽지 않으려 애써 보세요. 아무 말도 할 생각 없이 몇 달을 지켜보는 일은 얼마든지 가능합니다. 보는 건 쉽고 말하는 건 어렵기 때문입니다. 지금 어떤 사이인지 알고 싶다면 믿을 만한 방법은 묻는 것뿐입니다. 묻고 난 뒤의 침묵도 답이고, 다만 바라던 답이 아닐 뿐입니다." },
    ],
  },
  zh: {
    term: "绕圈式关注",
    summary:
      "把联系断掉之后，仍然留在你的社交圈边上：不回消息、不说话，却每条动态都看，偶尔还给旧帖点个赞。英文里叫 orbiting。",
    blocks: [
      { type: "h2", text: "只剩下看的那种沉默" },
      { type: "p", text: "他不再跟你说话，却没有停止看。每条动态都有他的浏览记录，去年的照片被点了个赞，早上打开列表，那个小圆圈还排在最前面。可是一句话也没有。绕圈式关注发生在这样的人身上：想退出对话，却不想退出你的生活；或者压根没做过任何决定，反正看一眼不花什么力气。" },
      { type: "p", text: "难受的正是这一点。干脆地消失至少还读得懂。这里，沉默说的是“已经结束了”，而关注说的是“我还在”，就在同一个屏幕上，天天如此。于是你开始在一条浏览记录里找一句话。那里面没有。一次浏览不携带任何关于对方想要什么的信息。" },
      { type: "h2", text: "怎么认出来" },
      { type: "ul", items: [
        "**只看不说。** 每条动态他都在最前面，每个聊天框里他都不出声。",
        "**给旧内容点赞。** 去年的照片，一条要往下翻很久才能找到的帖子。",
        "**关键时刻什么都没有。** 你发了一件大事，那份注视依然没变成一句话。",
        "**你一安静，它就重新开始。** 你不发动态了，他就换个地方出现：一次关注，一个表情。",
      ] },
      { type: "h2", accent: "green", text: "该怎么办" },
      { type: "p", text: "你有三个选择，三个都没问题。直接问：一条消息，“你人一直在，但从来不跟我讲话。到底怎么了？”把他静音或者设为限制：每天的出现就停了，又不像拉黑那样等于发了个公告。或者拉黑，如果这点低频噪音真的在消耗你。唯一不管用的，是所有人都试过的第四种：为一个人发动态，然后从浏览列表里读判决。" },
      { type: "p", text: "另外，别把注意力当成心意。一个人完全可能看你好几个月，却从来没打算开口，因为看很容易，开口不容易。想知道自己站在什么位置，唯一可靠的办法就是问。问完之后的沉默同样是答案，只是不是你希望的那一个。" },
    ],
  },
  nl: {
    term: "Orbiting",
    summary:
      "In iemands digitale baan blijven hangen nadat het contact is verbroken: geen antwoorden en geen gesprek, maar elk verhaal bekeken en af en toe een oude post geliket.",
    blocks: [
      { type: "h2", text: "De stilte die blijft kijken" },
      { type: "p", text: "Diegene praat niet meer met je. Kijken doet die persoon nog wel. Elk verhaal krijgt een weergave, een oude foto een like, en dat kringetje staat bijna elke ochtend bovenaan je lijst. Er wordt nooit iets gezegd. Orbiting gebeurt als iemand uit het gesprek wil, maar niet uit je leven — of als er nooit een besluit is genomen en kijken nu eenmaal niets kost." },
      { type: "p", text: "Precies dat maakt het zo lastig. Een schoon verdwijnen is tenminste eenduidig. Hier zegt de stilte “dit is voorbij” en zegt de aandacht “ik ben er nog”, op hetzelfde scherm, elke dag. Dus ga je in een weergave naar een bericht zoeken. Dat zit er niet in. Een weergave zegt niets over wat iemand wil." },
      { type: "h2", text: "Hoe je het herkent" },
      { type: "ul", items: [
        "**Weergaven zonder woorden.** Vooraan bij elk verhaal, stil in elk gesprek.",
        "**Likes op oude dingen.** Een foto van vorig jaar, een post waar je ver voor moet scrollen.",
        "**Niets als het ertoe doet.** Je post iets groots en dat kijken wordt nog steeds geen zin.",
        "**Het begint opnieuw als jij stil wordt.** Je post niets meer en diegene duikt elders op: een volgverzoek, een reactie.",
      ] },
      { type: "h2", accent: "green", text: "Wat je eraan kunt doen" },
      { type: "p", text: "Je hebt drie opties en alle drie zijn prima. Direct vragen: één bericht, “Je bent er wel, maar je praat niet met me. Wat is er?” Dempen of beperken: het dagelijkse opduiken stopt, zonder de aankondiging die blokkeren is. Of blokkeren, als dat lage geruis je echt iets kost. Wat niet werkt is de vierde optie die iedereen probeert: posten voor een publiek van één en de weergavelijst lezen als een oordeel." },
      { type: "p", text: "En probeer aandacht niet te lezen als bedoeling. Iemand kan maanden meekijken zonder ooit van plan te zijn iets te zeggen, want kijken is makkelijk en praten niet. Wil je weten waar je aan toe bent, dan is vragen de enige betrouwbare weg — en stilte na die vraag is ook een antwoord, alleen niet het antwoord waarop je hoopte." },
    ],
  },
  pl: {
    term: "Orbiting",
    summary:
      "Pozostawanie na cyfrowej orbicie kogoś po zerwaniu kontaktu: żadnych odpowiedzi i żadnej rozmowy, ale każda relacja obejrzana i od czasu do czasu polubiony stary post.",
    blocks: [
      { type: "h2", text: "Cisza, która wciąż patrzy" },
      { type: "p", text: "Przestał do ciebie pisać. Patrzeć nie przestał. Każda relacja ma jego wyświetlenie, stare zdjęcie dostaje polubienie, a to małe kółko prawie co rano stoi na początku twojej listy. I ani słowa. Orbiting zdarza się, gdy ktoś chce wyjść z rozmowy, ale nie z twojego życia — albo gdy w ogóle nie podjął decyzji, bo patrzenie nic nie kosztuje." },
      { type: "p", text: "I właśnie to jest trudne do zniesienia. Czyste zniknięcie da się przynajmniej odczytać. Tutaj cisza mówi „to koniec”, a uwaga mówi „nadal tu jestem”, na tym samym ekranie, codziennie. Więc zaczynasz szukać wiadomości w środku jednego wyświetlenia relacji. Tam jej nie ma. Wyświetlenie nie niesie żadnej informacji o tym, czego ktoś chce." },
      { type: "h2", text: "Po czym to poznać" },
      { type: "ul", items: [
        "**Wyświetlenia bez słów.** Pierwszy przy każdej relacji, niemy w każdej rozmowie.",
        "**Polubienia starych rzeczy.** Zdjęcie sprzed roku, post, do którego trzeba długo przewijać.",
        "**Nic wtedy, gdy to ważne.** Wrzucasz coś dużego, a to patrzenie i tak nie zamienia się w zdanie.",
        "**Zaczyna się od nowa, gdy milkniesz.** Przestajesz wrzucać, a on pojawia się gdzie indziej: obserwacja, reakcja.",
      ] },
      { type: "h2", accent: "green", text: "Co z tym zrobić" },
      { type: "p", text: "Masz trzy wyjścia i wszystkie są w porządku. Zapytać wprost: jedna wiadomość, „Jesteś, ale ze mną nie rozmawiasz. O co chodzi?”. Wyciszyć albo ograniczyć — codzienne pojawianie się znika bez tego ogłoszenia, jakim jest blokada. Albo zablokować, jeśli ten cichy szum naprawdę cię kosztuje. Nie działa tylko czwarta opcja, którą próbują wszyscy: wrzucać treści dla widowni jednej osoby i czytać listę wyświetleń jak wyrok." },
      { type: "p", text: "I postaraj się nie czytać uwagi jako zamiaru. Ktoś może patrzeć na ciebie miesiącami, nie mając zamiaru nic powiedzieć, bo patrzeć jest łatwo, a mówić nie. Jeśli chcesz wiedzieć, na czym stoisz, jedynym pewnym sposobem jest zapytać — a cisza po tym pytaniu też jest odpowiedzią, tylko nie tą, na którą liczyłeś." },
    ],
  },
  sv: {
    term: "Orbiting",
    summary:
      "Att stanna kvar i någons digitala omloppsbana efter att kontakten är bruten: inga svar och inget samtal, men varje story sedd och ett gammalt inlägg gillat då och då.",
    blocks: [
      { type: "h2", text: "Tystnaden som fortsätter titta" },
      { type: "p", text: "Hen slutade prata med dig. Hen slutade inte titta. Varje story får en visning, ett gammalt foto en gilla-markering, och den lilla ringen ligger högst upp i din lista nästan varje morgon. Inget sägs någonsin. Orbiting händer när någon vill ut ur samtalet men inte ur ditt liv — eller när inget beslut någonsin fattades, och att titta inte kostar något." },
      { type: "p", text: "Det är precis det som är svårt att stå ut med. Ett rent försvinnande går åtminstone att läsa. Här säger tystnaden ”det här är över” och uppmärksamheten säger ”jag är kvar”, på samma skärm, varje dag. Så du börjar leta efter ett meddelande inuti en storyvisning. Det finns inget där. En visning bär ingen information om vad någon vill." },
      { type: "h2", text: "Hur du känner igen det" },
      { type: "ul", items: [
        "**Visningar utan ord.** Först på varje story, tyst i varje chatt.",
        "**Gillanden på gammalt.** Ett foto från förra året, ett inlägg man måste scrolla långt för att hitta.",
        "**Ingenting när det räknas.** Du lägger upp något stort och tittandet blir ändå aldrig en mening.",
        "**Det börjar om när du tystnar.** Du slutar lägga upp saker, och hen dyker upp någon annanstans — en följning, en reaktion.",
      ] },
      { type: "h2", accent: "green", text: "Vad du gör åt det" },
      { type: "p", text: "Du har tre alternativ och alla tre är okej. Fråga rakt ut: ett meddelande, ”Du finns där men pratar inte med mig. Vad är det som händer?” Tysta eller begränsa — den dagliga närvaron upphör utan det utrop som en blockering innebär. Eller blockera, om det låga bruset faktiskt kostar dig något. Det som inte funkar är det fjärde alternativet alla testar: att lägga upp saker för en publik på en person och läsa visningslistan som en dom." },
      { type: "p", text: "Och försök att inte läsa uppmärksamhet som avsikt. Någon kan titta på dig i månader utan minsta plan på att säga något, för att titta är lätt och prata är det inte. Vill du veta var ni står är att fråga den enda pålitliga vägen — och tystnad efter frågan är också ett svar, bara inte det du hoppades på." },
    ],
  },
  hi: {
    term: "ऑर्बिटिंग",
    summary:
      "बात करना बंद कर देने के बाद भी किसी का आपके सोशल दायरे में मंडराते रहना — न जवाब, न बातचीत, लेकिन हर स्टोरी देखी हुई और बीच-बीच में किसी पुरानी पोस्ट पर लाइक।",
    blocks: [
      { type: "h2", text: "वह चुप्पी जो देखती रहती है" },
      { type: "p", text: "उसने बात करना बंद कर दिया, देखना बंद नहीं किया। हर स्टोरी पर उसका नाम दिखता है, किसी पुरानी तस्वीर पर लाइक आ जाता है, और सुबह लिस्ट में सबसे आगे वही छोटा-सा घेरा होता है। मगर कहा कुछ नहीं जाता। ऑर्बिटिंग तब होती है जब कोई बातचीत से निकलना चाहता है पर आपकी ज़िंदगी से नहीं — या जब उसने कोई फ़ैसला लिया ही नहीं, क्योंकि देखने में कुछ खर्च नहीं होता।" },
      { type: "p", text: "मुश्किल ठीक यही है। साफ़-साफ़ गायब हो जाना कम-से-कम एक ही मतलब देता है। यहाँ चुप्पी कहती है “सब खत्म” और ध्यान कहता है “मैं अब भी हूँ” — उसी स्क्रीन पर, हर दिन। तो आप एक स्टोरी व्यू के भीतर कोई संदेश ढूँढ़ने लगते हैं। वहाँ कोई संदेश नहीं है। व्यू यह नहीं बताता कि सामने वाला चाहता क्या है।" },
      { type: "h2", text: "इसे कैसे पहचानें" },
      { type: "ul", items: [
        "**बिना शब्दों के व्यू।** हर स्टोरी में सबसे ऊपर, हर चैट में चुप।",
        "**पुरानी चीज़ों पर लाइक।** पिछले साल की तस्वीर, वह पोस्ट जिस तक पहुँचने के लिए काफ़ी नीचे जाना पड़े।",
        "**जब मायने रखता है, तब कुछ नहीं।** आप कोई बड़ी बात पोस्ट करते हैं और वह देखना फिर भी एक वाक्य नहीं बनता।",
        "**आपके चुप होते ही फिर शुरू।** आप पोस्ट करना बंद करते हैं और वह कहीं और दिख जाता है — एक फ़ॉलो, एक रिएक्शन।",
      ] },
      { type: "h2", accent: "green", text: "इसका क्या करें" },
      { type: "p", text: "आपके पास तीन रास्ते हैं और तीनों ठीक हैं। सीधे पूछ लीजिए: एक मैसेज, “तुम आसपास तो हो, पर मुझसे बात नहीं करते। बात क्या है?” म्यूट या रिस्ट्रिक्ट कर दीजिए — रोज़ का दिखना बंद हो जाएगा और ब्लॉक जैसी घोषणा भी नहीं होगी। या ब्लॉक कर दीजिए, अगर यह धीमी-सी घरघराहट सचमुच आपको खर्च कर रही है। जो काम नहीं करता वह चौथा तरीक़ा है जो सब आज़माते हैं: एक ही दर्शक के लिए पोस्ट करना और व्यू लिस्ट में फ़ैसला ढूँढ़ना।" },
      { type: "p", text: "और ध्यान को इरादा मत पढ़िए। कोई महीनों तक आपको देख सकता है और कुछ कहने का इरादा उसका कभी न हो, क्योंकि देखना आसान है, कहना नहीं। आप कहाँ खड़े हैं, यह जानने का भरोसेमंद रास्ता सिर्फ़ पूछना है — और पूछने के बाद आई चुप्पी भी एक जवाब है, बस वह नहीं जिसकी आप उम्मीद कर रहे थे।" },
    ],
  },
};
