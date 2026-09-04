import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Match — the moment an app opens a chat between two people.
 *
 * JUDGEMENT CALLS a later editor should not undo by accident:
 *
 * - The definition deliberately reads a match DOWN, not up: it is permission to
 *   talk, not evidence of interest, effort or fit. Every locale keeps that.
 * - The mutual-swipe mechanic is described as "on swipe-based apps", with no app
 *   named — that is the brand rule, not vagueness. `scripts/verify-brand.mjs`
 *   bans only the domain form of this word, not the bare noun, which is why the
 *   term name itself is fine. Do not spell the domain form out anywhere in this
 *   file: the guard scans comments too, and quoting it here fails the build.
 * - Block 2 places Qulo's mechanic (2 to 4 multiple-choice questions on a free
 *   account, up to 10 on a paid plan, all of them correct) beside the generic
 *   one as a factual comparison. It is NOT a pitch, and block 7 was
 *   deliberately kept product-free so this term does not
 *   end on one — the glossary allows at most one in three terms to do that, and
 *   quiz-dating is the one that does.
 * - The Forbes Health / OnePoll burnout figure is cited in full (publisher,
 *   year, sample) in block 7 of every locale. It is the only external figure on
 *   this page; if a translation ever loses the sample size or the publisher,
 *   delete the sentence rather than keeping a bare "78%".
 *
 * TERM NAMES: "match" is the loanword people actually use in de/fr/es/pt/it/nl/
 * pl/sv, so it stays. ru and ar have live native words (совпадение, تطابق) with
 * the loanword also circulating, so the native word is the heading and the
 * summary mentions мэтч / ماتش. ja/ko/hi use the native script rendering of the
 * loanword; zh and tr have genuine native words (配对, eşleşme).
 */
export const match: LocalizedGlossaryEntry = {
  en: {
    term: "Match",
    summary:
      "The moment a dating app lets two people write to each other and opens a chat between them. It is permission to start a conversation and nothing more — not proof of interest, not proof of effort, and no promise that either of you will type.",
    blocks: [
      { type: "h2", text: "Why apps needed a word for it" },
      { type: "p", text: "Before apps, nobody needed a term for the instant two people become reachable to each other — you spoke to someone, or you did not. Apps built a door instead: both sides have to agree before a message can exist at all, and the door needed a name. “Match” comes from the ordinary sense of two things fitting together, and that is exactly where the confusion starts. The word promises fit. The feature delivers access." },
      { type: "p", text: "How the door opens depends on the app. On swipe-based apps, two people each swipe right on the other and the chat unlocks. On Qulo it opens another way: you write between 2 and 4 multiple-choice questions — up to 10 on a paid plan — and someone matches with you only by getting every one of them right. Different doors, same result — a conversation, and nothing decided yet." },
      { type: "h2", text: "Why a full inbox can still feel empty" },
      { type: "ul", items: [
        "The list grows and the conversations do not — matches sit there unopened for days.",
        "You cannot remember why you matched with half of them, and neither can they.",
        "It stalls after two messages, because neither of you had anything specific to say.",
        "Opening the app feels like clearing notifications rather than meeting anyone.",
      ] },
      { type: "h2", accent: "green", text: "What to actually do with one" },
      { type: "p", text: "Treat a match as an opening, not an outcome. Write the same day: the longer it sits, the more it turns into a name neither of you can place. Say something you could only say to that person — a line from their profile, an answer they gave, the reason you stopped scrolling. Generic openers get generic silence. And let go of the ones that never move; a match you never used costs nothing to lose." },
      { type: "p", text: "Collecting them is the trap. A long list reads like proof that things are going well, and usually it is not: a 2024 Forbes Health and OnePoll survey of 1,000 US adults who had used a dating app in the past year found 78% reporting burnout. Five matches you talk to beat fifty you never open." },
    ],
  },
  tr: {
    term: "Eşleşme",
    summary:
      "Bir uygulamanın iki kişinin birbirine yazmasına izin verdiği ve sohbeti açtığı an. Yalnızca konuşma iznidir: ilgi kanıtı değildir, emek kanıtı değildir ve birinizin yazacağının garantisi hiç değildir.",
    blocks: [
      { type: "h2", text: "Uygulamaların neden böyle bir kelimeye ihtiyacı oldu" },
      { type: "p", text: "Uygulamalardan önce, iki kişinin birbirine ulaşabilir hale geldiği anın bir adı yoktu; ya konuşurdunuz ya konuşmazdınız. Uygulamalar araya bir kapı koydu: kimse mesaj atamadan önce iki tarafın da onaylaması gerekiyor. Kapının da bir adı olmalıydı. “Eşleşme” kelimesi birbirine uyan iki şey anlamından geliyor ve kafa karışıklığı tam burada başlıyor. Kelime uyum vaat ediyor; özellik ise sadece erişim veriyor." },
      { type: "p", text: "Kapının nasıl açıldığı uygulamaya göre değişir. Kaydırma temelli uygulamalarda iki kişi de birbirini sağa kaydırır ve sohbet açılır. Qulo'da yol farklı: 2 ila 4 çoktan seçmeli soru yazarsınız — ücretli planda 10'a kadar — ve karşınızdaki ancak hepsini doğru bilirse sizinle eşleşir. Farklı kapılar, aynı sonuç: bir sohbet ve henüz karara bağlanmış hiçbir şey yok." },
      { type: "h2", text: "Dolu bir kutu neden boş hissettirir" },
      { type: "ul", items: [
        "Liste büyür, sohbetler büyümez; eşleşmeler günlerce açılmadan orada durur.",
        "Yarısıyla neden eşleştiğinizi hatırlamazsınız, onlar da hatırlamaz.",
        "İki mesajda tıkanır, çünkü ikinizin de söyleyecek özel bir şeyi yoktur.",
        "Uygulamayı açmak biriyle tanışmaktan çok bildirim temizlemeye benzer.",
      ] },
      { type: "h2", accent: "green", text: "Eşleşmeyle asıl ne yapmalı" },
      { type: "p", text: "Eşleşmeyi bir sonuç değil, açılan bir kapı olarak görün. Aynı gün yazın: bekledikçe karşınızdaki, ikinizin de yerini koyamadığı bir isme dönüşür. Yalnızca ona söylenebilecek bir şey söyleyin: profilindeki bir satır, verdiği bir cevap, kaydırmayı bıraktıran şey. Genel mesajlar genel sessizlikle karşılanır. Yürümeyenleri de bırakın; hiç kullanmadığınız bir eşleşmeyi kaybetmenin bedeli yoktur." },
      { type: "p", text: "Asıl tuzak biriktirmek. Uzun bir liste işlerin yolunda gittiğinin kanıtı gibi okunur, oysa çoğu zaman değildir: Forbes Health ve OnePoll'ün 2024'te, son bir yılda dating uygulaması kullanmış 1.000 ABD'li yetişkinle yaptığı ankette katılımcıların %78'i tükenmişlik bildirdi. Konuştuğunuz beş eşleşme, hiç açmadığınız elli eşleşmeden iyidir." },
    ],
  },
  de: {
    term: "Match",
    summary:
      "Der Augenblick, in dem eine Dating-App zwei Menschen erlaubt, einander zu schreiben, und den Chat öffnet. Es ist die Erlaubnis für ein Gespräch, mehr nicht: kein Beweis für Interesse, kein Beweis für Mühe und keine Zusage, dass jemand tippt.",
    blocks: [
      { type: "h2", text: "Warum Apps ein Wort dafür brauchten" },
      { type: "p", text: "Vor den Apps brauchte niemand einen Begriff für den Moment, in dem zwei Menschen füreinander erreichbar werden — man sprach jemanden an oder eben nicht. Apps bauten stattdessen ein Tor ein: Beide müssen zustimmen, bevor eine Nachricht überhaupt möglich ist, und dieses Tor brauchte einen Namen. „Match“ kommt aus dem gewöhnlichen Sinn von zwei Dingen, die zusammenpassen, und genau da beginnt das Missverständnis. Das Wort verspricht Passung. Die Funktion liefert Zugang." },
      { type: "p", text: "Wie sich das Tor öffnet, hängt von der App ab. Auf Swipe-basierten Apps wischen beide nach rechts, und der Chat geht auf. Auf Qulo läuft es anders: Du schreibst zwischen 2 und 4 Multiple-Choice-Fragen, im kostenpflichtigen Tarif bis zu 10, und jemand matcht mit dir nur, wenn er jede einzelne richtig beantwortet. Andere Türen, gleiches Ergebnis — ein Gespräch, und entschieden ist noch nichts." },
      { type: "h2", text: "Warum sich ein volles Postfach leer anfühlt" },
      { type: "ul", items: [
        "Die Liste wächst, die Gespräche nicht — Matches bleiben tagelang ungeöffnet liegen.",
        "Bei der Hälfte weißt du nicht mehr, warum ihr gematcht habt, und der anderen Seite geht es genauso.",
        "Nach zwei Nachrichten stockt es, weil keiner von beiden etwas Konkretes zu sagen hatte.",
        "Die App zu öffnen fühlt sich an wie Benachrichtigungen wegräumen, nicht wie jemanden kennenlernen.",
      ] },
      { type: "h2", accent: "green", text: "Was du wirklich damit anfängst" },
      { type: "p", text: "Behandle ein Match als Anfang, nicht als Ergebnis. Schreib noch am selben Tag: Je länger es liegen bleibt, desto mehr wird daraus ein Name, den ihr beide nicht mehr einordnen könnt. Sag etwas, das du nur dieser einen Person sagen könntest — eine Zeile aus dem Profil, eine Antwort, den Grund, warum du hängen geblieben bist. Auf Beliebiges folgt beliebiges Schweigen. Und lass ziehen, was sich nie bewegt; ein ungenutztes Match kostet nichts." },
      { type: "p", text: "Das Sammeln ist die Falle. Eine lange Liste liest sich wie ein Beweis, dass es läuft, und meistens stimmt das nicht: In einer Befragung von Forbes Health und OnePoll aus dem Jahr 2024 unter 1.000 US-Erwachsenen, die im Vorjahr eine Dating-App genutzt hatten, berichteten 78 % von Erschöpfung. Fünf Matches, mit denen du redest, sind mehr wert als fünfzig, die du nie öffnest." },
    ],
  },
  fr: {
    term: "Match",
    summary:
      "Le moment où une application autorise deux personnes à s'écrire et ouvre la conversation. C'est une permission de parler, rien de plus : ni preuve d'intérêt, ni preuve d'effort, ni garantie que l'un des deux écrira.",
    blocks: [
      { type: "h2", text: "Pourquoi les applications ont eu besoin d'un mot" },
      { type: "p", text: "Avant les applications, personne n'avait besoin d'un terme pour l'instant où deux personnes deviennent joignables l'une pour l'autre : on s'adressait à quelqu'un, ou non. Les applications ont installé une porte : il faut l'accord des deux avant qu'un message existe, et cette porte devait avoir un nom. « Match » vient du sens ordinaire de deux choses qui vont ensemble, et c'est exactement là que naît le malentendu. Le mot promet un accord. La fonctionnalité donne un accès." },
      { type: "p", text: "La façon dont la porte s'ouvre dépend de l'application. Sur les applications à balayage, chacun glisse vers la droite sur l'autre et la conversation se débloque. Sur Qulo, elle s'ouvre autrement : vous écrivez de 2 à 4 questions à choix multiples, jusqu'à 10 avec un abonnement payant, et quelqu'un ne matche avec vous qu'en répondant juste à toutes. Portes différentes, même résultat : une conversation, et rien de décidé." },
      { type: "h2", text: "Pourquoi une boîte pleine peut sembler vide" },
      { type: "ul", items: [
        "La liste s'allonge, les conversations non : les matchs restent là, jamais ouverts.",
        "Vous ne savez plus pourquoi vous avez matché avec la moitié d'entre eux, et eux non plus.",
        "Ça s'arrête après deux messages, faute d'avoir quelque chose de précis à se dire.",
        "Ouvrir l'application ressemble à vider des notifications plutôt qu'à rencontrer quelqu'un.",
      ] },
      { type: "h2", accent: "green", text: "Quoi en faire, concrètement" },
      { type: "p", text: "Voyez un match comme une ouverture, pas comme un aboutissement. Écrivez dans la journée : plus ça traîne, plus l'autre devient un prénom que personne ne resitue. Dites quelque chose que vous ne pourriez dire qu'à cette personne-là — une ligne de son profil, une réponse qu'elle a donnée, ce qui vous a fait arrêter de faire défiler. Un message passe-partout obtient un silence passe-partout. Et laissez filer ce qui ne bouge jamais." },
      { type: "p", text: "Le piège, c'est de collectionner. Une longue liste ressemble à la preuve que tout va bien, et ce n'est presque jamais le cas : dans une enquête menée en 2024 par Forbes Health et OnePoll auprès de 1 000 adultes américains ayant utilisé une application de rencontre dans l'année, 78 % déclaraient un épuisement. Cinq matchs à qui vous parlez valent mieux que cinquante jamais ouverts." },
    ],
  },
  es: {
    term: "Match",
    summary:
      "El momento en que una app permite que dos personas se escriban y abre el chat entre ellas. Es permiso para hablar y nada más: no demuestra interés, no demuestra esfuerzo y no garantiza que alguien vaya a escribir.",
    blocks: [
      { type: "h2", text: "Por qué las apps necesitaron una palabra" },
      { type: "p", text: "Antes de las apps nadie necesitaba un término para el instante en que dos personas quedan al alcance la una de la otra: le hablabas a alguien o no. Las apps levantaron una puerta: los dos tienen que aceptar antes de que exista un mensaje, y esa puerta necesitaba nombre. “Match” viene del sentido corriente de dos cosas que encajan, y ahí empieza justo el malentendido. La palabra promete encaje. La función da acceso." },
      { type: "p", text: "Cómo se abre la puerta depende de la app. En las apps de deslizar, los dos se deslizan a la derecha y el chat se desbloquea. En Qulo se abre de otra manera: escribes entre 2 y 4 preguntas de opción múltiple, hasta 10 con un plan de pago, y alguien hace match contigo solo si las acierta todas. Puertas distintas, mismo resultado: una conversación y nada decidido todavía." },
      { type: "h2", text: "Por qué una bandeja llena se siente vacía" },
      { type: "ul", items: [
        "La lista crece y las conversaciones no: los matches se quedan ahí sin abrir durante días.",
        "Con la mitad ya no recuerdas por qué hicisteis match, y ellos tampoco.",
        "Todo se atasca al segundo mensaje, porque ninguno tenía nada concreto que decir.",
        "Abrir la app se parece más a despejar notificaciones que a conocer a alguien.",
      ] },
      { type: "h2", accent: "green", text: "Qué hacer de verdad con uno" },
      { type: "p", text: "Trata el match como una puerta abierta, no como un resultado. Escribe el mismo día: cuanto más se enfría, más se convierte en un nombre que ninguno de los dos sabe ubicar. Di algo que solo podrías decirle a esa persona: una línea de su perfil, una respuesta suya, lo que te hizo dejar de deslizar. A un mensaje genérico le contesta un silencio genérico. Y suelta lo que no arranca; un match sin usar no cuesta nada perderlo." },
      { type: "p", text: "Coleccionarlos es la trampa. Una lista larga parece la prueba de que las cosas van bien, y casi nunca lo es: en una encuesta de Forbes Health y OnePoll de 2024 a 1.000 adultos estadounidenses que habían usado una app de citas en el último año, el 78% declaró agotamiento. Cinco matches con los que hablas valen más que cincuenta que nunca abres." },
    ],
  },
  ar: {
    term: "تطابق",
    summary:
      "اللحظة التي يسمح فيها تطبيق المواعدة لشخصين بالكتابة لبعضهما ويفتح المحادثة بينهما، ويسميها الناس عادةً «ماتش». هو إذن بالحديث فقط: ليس دليلًا على اهتمام ولا على جهد، ولا ضمانًا بأن أحدكما سيكتب.",
    blocks: [
      { type: "h2", text: "لماذا احتاجت التطبيقات إلى كلمة لهذا" },
      { type: "p", text: "قبل التطبيقات لم يكن أحد بحاجة إلى اسم للحظة التي يصبح فيها شخصان قادرين على الوصول إلى بعضهما؛ إمّا أن تتحدث إلى أحدهم أو لا. التطبيقات وضعت بابًا بدل ذلك: يجب أن يوافق الطرفان قبل أن توجد رسالة أصلًا، والباب احتاج اسمًا. كلمة «تطابق» جاءت من المعنى العادي لشيئين ينسجمان معًا، ومن هنا تحديدًا يبدأ سوء الفهم. الكلمة تَعِد بالانسجام، أما الميزة فتمنح الوصول." },
      { type: "p", text: "طريقة فتح الباب تختلف من تطبيق لآخر. في التطبيقات القائمة على السحب، يسحب كلٌّ منهما الآخر إلى اليمين فتُفتح المحادثة. في Qulo يُفتح بطريقة أخرى: تكتب بين سؤالين و4 أسئلة اختيار من متعدد، وحتى 10 أسئلة في الخطة المدفوعة، ولا يتطابق معك أحد إلا إذا أجاب عنها جميعًا إجابة صحيحة. أبواب مختلفة والنتيجة واحدة: محادثة، ولا شيء قد حُسم بعد." },
      { type: "h2", text: "لماذا يبدو صندوق ممتلئ فارغًا" },
      { type: "ul", items: [
        "القائمة تطول والمحادثات لا: تبقى التطابقات أيامًا دون أن يفتحها أحد.",
        "لا تتذكر لماذا تطابقت مع نصفهم، وهم أيضًا لا يتذكرون.",
        "يتوقف الكلام بعد رسالتين، لأن لا أحد منكما لديه ما يقوله تحديدًا.",
        "فتح التطبيق يشبه تصفية الإشعارات أكثر مما يشبه التعرّف على أحد.",
      ] },
      { type: "h2", accent: "green", text: "ماذا تفعل بالتطابق فعلًا" },
      { type: "p", text: "تعامل مع التطابق كبداية لا كنتيجة. اكتب في اليوم نفسه؛ كلما طال انتظاره تحوّل إلى اسم لا يستطيع أيٌّ منكما تحديد صاحبه. قل شيئًا لا يمكن أن تقوله إلا لهذا الشخص: سطرًا من ملفه، إجابة كتبها، أو السبب الذي جعلك تتوقف عن التمرير. الرسائل العامة تُقابَل بصمت عام. واترك ما لا يتحرك أبدًا؛ تطابق لم تستعمله لا تخسر شيئًا بفقدانه." },
      { type: "p", text: "الفخ هو الجمع. القائمة الطويلة تُقرأ كدليل على أن الأمور تسير جيدًا، وغالبًا ليست كذلك: في استطلاع أجرته Forbes Health وOnePoll عام 2024 شمل 1000 بالغ أمريكي استخدموا تطبيق مواعدة خلال السنة الماضية، أفاد 78% منهم بالإرهاق. خمسة تطابقات تتحدث معها أفضل من خمسين لا تفتحها أبدًا." },
    ],
  },
  ru: {
    term: "Совпадение",
    summary:
      "Момент, когда приложение разрешает двум людям написать друг другу и открывает чат; в разговоре это называют «мэтч». Это разрешение на диалог, не более: не доказательство интереса, не доказательство усилий и не обещание, что кто-то напишет.",
    blocks: [
      { type: "h2", text: "Зачем приложениям понадобилось слово" },
      { type: "p", text: "До приложений никому не требовалось названия для момента, когда два человека становятся друг другу доступны: с кем-то заговаривали или нет. Приложения вместо этого поставили дверь: пока оба не согласятся, сообщения просто не существует, а двери нужно было имя. Слово «мэтч» пришло из обычного смысла — две вещи подходят друг другу, — и путаница начинается именно здесь. Слово обещает совпадение. Функция выдаёт доступ." },
      { type: "p", text: "Как открывается дверь, зависит от приложения. В приложениях со свайпами оба смахивают вправо, и чат разблокируется. В Qulo она открывается иначе: вы пишете от 2 до 4 вопросов с вариантами ответа, на платном тарифе до 10, и совпадение случится, только если человек ответит правильно на все. Двери разные, итог один — разговор, в котором пока ничего не решено." },
      { type: "h2", text: "Почему полный список ощущается пустым" },
      { type: "ul", items: [
        "Список растёт, а разговоры нет: совпадения лежат неоткрытыми днями.",
        "С половиной из них вы уже не помните, почему совпали, — и они тоже.",
        "Всё глохнет после второго сообщения, потому что ни у кого не было ничего конкретного.",
        "Открыть приложение — это скорее разобрать уведомления, чем с кем-то познакомиться.",
      ] },
      { type: "h2", accent: "green", text: "Что с ним делать на самом деле" },
      { type: "p", text: "Считайте совпадение началом, а не итогом. Напишите в тот же день: чем дольше оно лежит, тем быстрее превращается в имя, которое никто не может вспомнить. Скажите то, что можно сказать только этому человеку: строчку из анкеты, его ответ, причину, по которой вы остановились. На общие слова приходит общее молчание. А то, что не двигается, отпускайте: совпадение, которым вы не воспользовались, не жалко." },
      { type: "p", text: "Ловушка — коллекционировать. Длинный список читается как доказательство, что всё идёт хорошо, и обычно это не так: в опросе Forbes Health и OnePoll 2024 года, охватившем 1000 взрослых американцев, которые за последний год пользовались приложением для знакомств, 78% сообщили о выгорании. Пять совпадений, с которыми вы говорите, лучше пятидесяти неоткрытых." },
    ],
  },
  pt: {
    term: "Match",
    summary:
      "O momento em que um app deixa duas pessoas se escreverem e abre a conversa entre elas. É permissão para conversar e nada além disso: não prova interesse, não prova esforço e não garante que alguém vá escrever.",
    blocks: [
      { type: "h2", text: "Por que os apps precisaram de uma palavra" },
      { type: "p", text: "Antes dos apps, ninguém precisava de um termo para o instante em que duas pessoas ficam ao alcance uma da outra: você falava com alguém ou não falava. Os apps ergueram uma porta: os dois precisam concordar antes que exista qualquer mensagem, e a porta precisava de nome. “Match” vem do sentido comum de duas coisas que se encaixam, e é aí que começa a confusão. A palavra promete encaixe. O recurso entrega acesso." },
      { type: "p", text: "Como a porta abre depende do app. Nos apps de deslizar, os dois deslizam para a direita e o chat libera. No Qulo ela abre de outro jeito: você escreve de 2 a 4 perguntas de múltipla escolha, até 10 num plano pago, e alguém só dá match com você acertando todas. Portas diferentes, mesmo resultado: uma conversa e nada decidido ainda." },
      { type: "h2", text: "Por que uma caixa cheia parece vazia" },
      { type: "ul", items: [
        "A lista cresce e as conversas não: os matches ficam ali sem abrir por dias.",
        "Com metade deles você não lembra por que deu match, e eles também não.",
        "Trava na segunda mensagem, porque nenhum dos dois tinha nada específico a dizer.",
        "Abrir o app parece mais limpar notificações do que conhecer alguém.",
      ] },
      { type: "h2", accent: "green", text: "O que fazer de verdade com um match" },
      { type: "p", text: "Trate o match como uma porta aberta, não como resultado. Escreva no mesmo dia: quanto mais tempo passa, mais ele vira um nome que ninguém consegue situar. Diga algo que só daria para dizer àquela pessoa: uma linha do perfil, uma resposta que ela deu, o motivo de você ter parado de rolar. Mensagem genérica recebe silêncio genérico. E solte o que nunca anda; um match que você nunca usou não custa nada perder." },
      { type: "p", text: "A armadilha é colecionar. Uma lista longa parece prova de que as coisas vão bem, e quase nunca é: numa pesquisa da Forbes Health com a OnePoll em 2024, com 1.000 adultos dos EUA que tinham usado um app de namoro no último ano, 78% relataram esgotamento. Cinco matches com quem você conversa valem mais que cinquenta que você nunca abre." },
    ],
  },
  it: {
    term: "Match",
    summary:
      "Il momento in cui un'app permette a due persone di scriversi e apre la conversazione. È il permesso di parlare, niente di più: non dimostra interesse, non dimostra impegno e non garantisce che qualcuno scriverà.",
    blocks: [
      { type: "h2", text: "Perché alle app serviva una parola" },
      { type: "p", text: "Prima delle app nessuno aveva bisogno di un termine per l'istante in cui due persone diventano raggiungibili: o parlavi con qualcuno o non lo facevi. Le app hanno messo una porta: servono entrambi i sì prima che un messaggio possa esistere, e la porta aveva bisogno di un nome. “Match” viene dal senso comune di due cose che combaciano, ed è esattamente lì che nasce l'equivoco. La parola promette intesa. La funzione consegna accesso." },
      { type: "p", text: "Come si apre la porta dipende dall'app. Nelle app a scorrimento entrambi scorrono a destra e la chat si sblocca. Su Qulo si apre in un altro modo: scrivi da 2 a 4 domande a risposta multipla, fino a 10 con un piano a pagamento, e qualcuno fa match con te solo indovinandole tutte. Porte diverse, stesso risultato: una conversazione, e ancora niente di deciso." },
      { type: "h2", text: "Perché una casella piena sembra vuota" },
      { type: "ul", items: [
        "La lista cresce, le conversazioni no: i match restano lì, non aperti, per giorni.",
        "Di metà di loro non ricordi perché avete fatto match, e nemmeno loro.",
        "Ci si blocca al secondo messaggio, perché nessuno dei due aveva qualcosa di preciso da dire.",
        "Aprire l'app somiglia più a smaltire notifiche che a conoscere qualcuno.",
      ] },
      { type: "h2", accent: "green", text: "Cosa farne davvero" },
      { type: "p", text: "Considera un match un'apertura, non un traguardo. Scrivi in giornata: più resta lì, più diventa un nome che nessuno dei due sa collocare. Di' qualcosa che potresti dire solo a quella persona: una riga del profilo, una risposta che ha dato, il motivo per cui ti sei fermato. A un messaggio qualunque risponde un silenzio qualunque. E lascia andare ciò che non si muove: un match mai usato non costa nulla perderlo." },
      { type: "p", text: "La trappola è collezionarli. Una lista lunga sembra la prova che le cose vanno bene, e quasi mai lo è: in un sondaggio di Forbes Health e OnePoll del 2024 su 1.000 adulti statunitensi che avevano usato un'app di incontri nell'ultimo anno, il 78% ha dichiarato di sentirsi esausto. Cinque match con cui parli valgono più di cinquanta che non apri mai." },
    ],
  },
  ja: {
    term: "マッチ",
    summary:
      "アプリが二人にメッセージのやり取りを許可し、チャットが開く瞬間のこと。会話を始めてよいという許可であって、それ以上ではない。好意の証拠でも努力の証拠でもなく、どちらかが書き出す保証でもない。",
    blocks: [
      { type: "h2", text: "なぜアプリはこの言葉を必要としたのか" },
      { type: "p", text: "アプリ以前は、二人が互いに連絡を取れる状態になった瞬間に名前をつける必要などなかった。声をかけるか、かけないか、それだけだったからだ。アプリは代わりに扉を置いた。どちらもうなずくまでメッセージは存在しないし、その扉には呼び名が要る。「マッチ」は二つのものが合うという普通の意味から来ていて、誤解はまさにそこから始まる。言葉は相性を約束するが、機能が渡すのはアクセスだけだ。" },
      { type: "p", text: "扉の開き方はアプリによって違う。スワイプ型のアプリでは、二人が互いに右へスワイプするとチャットが開く。Qulo では別の開き方をする。自分で2問から4問（有料プランなら最大10問）の選択式の質問を書き、相手はそのすべてに正解したときだけマッチする。扉は違っても結果は同じで、始まるのは会話であり、まだ何も決まってはいない。" },
      { type: "h2", text: "受信箱がいっぱいでも空っぽに感じる理由" },
      { type: "ul", items: [
        "リストは伸びるのに会話は伸びない。マッチが何日も開かれないまま残る。",
        "半分は、なぜマッチしたのか自分も相手も思い出せない。",
        "二往復で止まる。どちらにも具体的に言うことがないからだ。",
        "アプリを開くのが、人と会うというより通知を片づける作業に近い。",
      ] },
      { type: "h2", accent: "green", text: "マッチを実際どう使うか" },
      { type: "p", text: "マッチは結果ではなく入り口だと考える。できればその日のうちに送る。寝かせるほど、互いに顔の浮かばない名前になっていく。その人にしか言えないことを書く。プロフィールの一行、相手の答え、手が止まった理由。当たり障りのない文章には、当たり障りのない沈黙が返ってくる。動かないものは手放していい。使わなかったマッチを失っても、失うものは何もない。" },
      { type: "p", text: "集めることが落とし穴になる。長いリストは順調さの証拠のように見えるが、たいていそうではない。Forbes Health と OnePoll が2024年に、過去1年にマッチングアプリを使った米国の成人1,000人に行った調査では、78%が燃え尽きを報告している。話している5件のほうが、一度も開かない50件よりずっといい。" },
    ],
  },
  ko: {
    term: "매치",
    summary:
      "앱이 두 사람에게 서로 메시지를 보낼 권한을 주고 채팅방을 열어 주는 순간. 말을 걸어도 된다는 허락일 뿐, 호감의 증거도 노력의 증거도 아니고 누군가 먼저 쓴다는 보장도 아니다.",
    blocks: [
      { type: "h2", text: "앱에 왜 이런 단어가 필요했을까" },
      { type: "p", text: "앱이 있기 전에는 두 사람이 서로에게 닿을 수 있게 된 순간을 부를 말이 필요 없었다. 말을 걸거나 걸지 않거나, 둘 중 하나였으니까. 앱은 대신 문을 하나 놓았다. 양쪽이 모두 동의해야 메시지라는 것이 생기고, 그 문에는 이름이 필요했다. 매치라는 말은 두 가지가 서로 맞는다는 평범한 뜻에서 왔고, 오해는 정확히 거기서 시작된다. 단어는 잘 맞음을 약속하지만, 기능이 주는 것은 접근 권한뿐이다." },
      { type: "p", text: "문이 열리는 방식은 앱마다 다르다. 스와이프 기반 앱에서는 두 사람이 서로를 오른쪽으로 넘기면 채팅이 열린다. Qulo에서는 다르게 열린다. 직접 2~4개(유료 플랜에서는 최대 10개)의 객관식 질문을 쓰고, 상대가 그 전부를 맞혔을 때만 매치가 된다. 문은 달라도 결과는 같다. 대화가 시작될 뿐, 아직 정해진 것은 없다." },
      { type: "h2", text: "목록은 가득한데 비어 있게 느껴지는 이유" },
      { type: "ul", items: [
        "목록은 늘어나는데 대화는 늘지 않는다. 매치가 며칠씩 열리지 않은 채 쌓인다.",
        "절반은 왜 매치됐는지 나도 상대도 기억하지 못한다.",
        "두 번째 메시지에서 멈춘다. 서로 구체적으로 할 말이 없었기 때문이다.",
        "앱을 여는 일이 사람을 만나는 일보다 알림을 정리하는 일에 가깝다.",
      ] },
      { type: "h2", accent: "green", text: "매치를 실제로 어떻게 쓸까" },
      { type: "p", text: "매치는 결과가 아니라 열린 문이라고 생각하자. 되도록 그날 안에 말을 걸자. 오래 둘수록 서로 얼굴이 떠오르지 않는 이름이 된다. 그 사람에게만 할 수 있는 말을 하자. 프로필의 한 줄, 상대가 남긴 답, 손이 멈춘 이유 같은 것. 뻔한 인사에는 뻔한 침묵이 돌아온다. 끝내 움직이지 않는 것은 놓아 주자. 쓰지 않은 매치는 잃어도 잃을 게 없다." },
      { type: "p", text: "모으는 것이 함정이다. 긴 목록은 일이 잘 풀리고 있다는 증거처럼 읽히지만 대개는 아니다. Forbes Health와 OnePoll이 2024년에 지난 1년간 데이팅 앱을 써 본 미국 성인 1,000명을 조사한 결과 78%가 번아웃을 겪었다고 답했다. 대화하는 다섯 개가 한 번도 열지 않는 쉰 개보다 낫다." },
    ],
  },
  zh: {
    term: "配对",
    summary:
      "交友软件允许两个人互相发消息、并为他们打开聊天窗口的那一刻。它只是说话的许可，不代表对方有兴趣，也不代表谁付出过什么，更不保证有人会先开口。",
    blocks: [
      { type: "h2", text: "为什么软件需要这么一个词" },
      { type: "p", text: "在软件出现之前，没人需要给“两个人变得能够联系上”的那一刻起名字：要么开口，要么不开口。软件在中间加了一道门，双方都点头之后才存在一条消息，这道门总得有个称呼。配对这个词来自“两样东西刚好合得来”的日常含义，误会正是从这里开始的。词语承诺的是合适，功能给出的只是权限。" },
      { type: "p", text: "门怎么开，取决于软件。在滑动式的软件里，两个人互相向右滑，聊天就解锁了。在 Qulo 上是另一种开法：你自己写2到4道选择题（付费方案最多10道），对方全部答对才会与你配对。门不一样，结果一样——一场对话，并且什么都还没定下来。" },
      { type: "h2", text: "为什么列表满了却仍然觉得空" },
      { type: "ul", items: [
        "名单变长，对话没变多：配对躺在那里好几天没人点开。",
        "有一半你想不起当初为什么配上，对方也想不起来。",
        "聊到第二条就卡住，因为谁都没有具体的话可说。",
        "打开软件更像是在清理通知，而不是在认识人。",
      ] },
      { type: "h2", accent: "green", text: "配对之后到底该做什么" },
      { type: "p", text: "把配对当成一扇门，而不是一个结果。最好当天就发消息，放得越久，对方越会变成一个谁都对不上号的名字。说一句只可能对这个人说的话：资料里的一行字、他写过的一个答案、你停下来的原因。套话换来的只有套话式的沉默。始终不动的就放手，一段没用过的配对，丢了也不可惜。" },
      { type: "p", text: "真正的陷阱是收藏。长长的名单看起来像是一切顺利的证据，但通常不是：Forbes Health 与 OnePoll 在2024年调查了1000名过去一年用过交友软件的美国成年人，其中78%表示感到疲惫。五个真的在聊的，胜过五十个从没点开的。" },
    ],
  },
  nl: {
    term: "Match",
    summary:
      "Het moment waarop een app twee mensen toestemming geeft om elkaar te schrijven en de chat opent. Het is niet meer dan toestemming om te praten: geen bewijs van interesse, geen bewijs van moeite en geen garantie dat iemand begint.",
    blocks: [
      { type: "h2", text: "Waarom apps hier een woord voor nodig hadden" },
      { type: "p", text: "Vóór de apps had niemand een term nodig voor het moment waarop twee mensen elkaar kunnen bereiken: je sprak iemand aan, of niet. Apps zetten er een deur tussen: allebei akkoord, en pas dan bestaat er een bericht. Die deur had een naam nodig. “Match” komt van de gewone betekenis van twee dingen die bij elkaar passen, en precies daar begint de verwarring. Het woord belooft passen. De functie levert toegang." },
      { type: "p", text: "Hoe de deur opengaat, verschilt per app. Bij swipe-apps vegen twee mensen elkaar naar rechts en gaat de chat open. Op Qulo gaat hij anders open: je schrijft 2 tot 4 meerkeuzevragen, tot 10 met een betaald abonnement, en iemand matcht alleen met jou door ze allemaal goed te hebben. Andere deur, dezelfde uitkomst: een gesprek, en verder nog niets." },
      { type: "h2", text: "Waarom een volle lijst leeg aanvoelt" },
      { type: "ul", items: [
        "De lijst groeit, de gesprekken niet: matches blijven dagen ongeopend staan.",
        "Van de helft weet je niet meer waarom je matchte, en zij ook niet.",
        "Na twee berichten stokt het, omdat geen van beiden iets concreets te zeggen had.",
        "De app openen voelt als meldingen wegwerken, niet als iemand leren kennen.",
      ] },
      { type: "h2", accent: "green", text: "Wat je er wél mee doet" },
      { type: "p", text: "Behandel een match als een opening, niet als een uitkomst. Stuur dezelfde dag iets: hoe langer het blijft liggen, hoe meer het een naam wordt die jullie allebei niet meer plaatsen. Zeg iets dat je alleen tegen deze persoon kunt zeggen: een zin uit het profiel, een antwoord dat ze gaf, de reden dat je stopte met scrollen. Op algemeen volgt algemene stilte. En laat los wat nooit beweegt." },
      { type: "p", text: "Verzamelen is de valkuil. Een lange lijst leest als bewijs dat het goed gaat, en dat is het meestal niet: in een onderzoek van Forbes Health en OnePoll uit 2024 onder 1.000 Amerikaanse volwassenen die het afgelopen jaar een datingapp gebruikten, meldde 78% burn-outklachten. Vijf matches waarmee je praat zijn meer waard dan vijftig die je nooit opent." },
    ],
  },
  pl: {
    term: "Match",
    summary:
      "Moment, w którym aplikacja pozwala dwojgu ludziom napisać do siebie i otwiera czat. To wyłącznie zgoda na rozmowę: nie dowód zainteresowania, nie dowód wysiłku i żadna gwarancja, że ktokolwiek się odezwie.",
    blocks: [
      { type: "h2", text: "Dlaczego aplikacje potrzebowały na to słowa" },
      { type: "p", text: "Zanim pojawiły się aplikacje, nikt nie potrzebował nazwy na chwilę, w której dwie osoby stają się dla siebie dostępne: zagadywało się kogoś albo nie. Aplikacje postawiły zamiast tego drzwi: obie strony muszą się zgodzić, zanim w ogóle powstanie wiadomość, a drzwi potrzebowały nazwy. Słowo „match” pochodzi ze zwykłego sensu dwóch rzeczy, które do siebie pasują, i właśnie stąd bierze się nieporozumienie. Słowo obiecuje dopasowanie. Funkcja daje dostęp." },
      { type: "p", text: "To, jak otwierają się drzwi, zależy od aplikacji. W aplikacjach opartych na przesuwaniu obie osoby przesuwają w prawo i czat się odblokowuje. W Qulo otwierają się inaczej: piszesz od 2 do 4 pytań wielokrotnego wyboru, w planie płatnym do 10, a ktoś matchuje z tobą tylko wtedy, gdy odpowie poprawnie na wszystkie. Inne drzwi, ten sam efekt: rozmowa, w której nic jeszcze nie zostało rozstrzygnięte." },
      { type: "h2", text: "Dlaczego pełna lista bywa pusta" },
      { type: "ul", items: [
        "Lista rośnie, rozmowy nie: matche leżą nieotwarte przez wiele dni.",
        "Przy połowie nie pamiętasz już, dlaczego do niego doszło — i druga strona też nie.",
        "Wszystko grzęźnie po drugiej wiadomości, bo nikt nie miał nic konkretnego do powiedzenia.",
        "Otwieranie aplikacji przypomina odklikiwanie powiadomień, a nie poznawanie ludzi.",
      ] },
      { type: "h2", accent: "green", text: "Co z tym naprawdę zrobić" },
      { type: "p", text: "Traktuj match jak otwarte drzwi, nie jak wynik. Napisz tego samego dnia: im dłużej leży, tym bardziej zmienia się w imię, którego żadne z was nie umie umiejscowić. Powiedz coś, co mógłbyś powiedzieć tylko tej osobie: linijkę z jej profilu, jej odpowiedź, powód, dla którego przestałeś przewijać. Na ogólnik przychodzi ogólna cisza. A to, co nigdy nie rusza, po prostu odpuść." },
      { type: "p", text: "Pułapką jest zbieranie. Długa lista wygląda na dowód, że idzie dobrze, a zwykle nim nie jest: w badaniu Forbes Health i OnePoll z 2024 roku, przeprowadzonym wśród 1000 dorosłych Amerykanów, którzy w ciągu ostatniego roku korzystali z aplikacji randkowej, 78% zgłosiło wypalenie. Pięć matchy, z którymi rozmawiasz, jest warte więcej niż pięćdziesiąt nigdy nieotwartych." },
    ],
  },
  sv: {
    term: "Match",
    summary:
      "Ögonblicket då en app låter två personer skriva till varandra och öppnar chatten. Det är tillstånd att prata, inget mer: inget bevis på intresse, inget bevis på ansträngning och ingen garanti för att någon hör av sig.",
    blocks: [
      { type: "h2", text: "Varför apparna behövde ett ord för det" },
      { type: "p", text: "Före apparna behövde ingen ett ord för stunden då två personer blir nåbara för varandra: man tilltalade någon, eller lät bli. Apparna byggde i stället en dörr: båda måste säga ja innan ett meddelande ens finns, och dörren behövde ett namn. “Match” kommer från den vanliga betydelsen av två saker som passar ihop, och det är precis där missförståndet börjar. Ordet lovar passform. Funktionen levererar tillträde." },
      { type: "p", text: "Hur dörren öppnas beror på appen. I swipe-baserade appar sveper båda åt höger och chatten låses upp. På Qulo öppnas den på ett annat sätt: du skriver mellan 2 och 4 flervalsfrågor, upp till 10 med ett betalt abonnemang, och någon matchar med dig bara genom att svara rätt på varenda en. Olika dörrar, samma resultat: ett samtal, och inget avgjort än." },
      { type: "h2", text: "Varför en full lista kan kännas tom" },
      { type: "ul", items: [
        "Listan växer men samtalen gör det inte: matchningar ligger oöppnade i dagar.",
        "Hälften minns du inte varför du matchade med, och de minns inte heller.",
        "Det stannar av efter två meddelanden, för ingen av er hade något konkret att säga.",
        "Att öppna appen känns som att beta av notiser snarare än att träffa någon.",
      ] },
      { type: "h2", accent: "green", text: "Vad man faktiskt gör med en" },
      { type: "p", text: "Se en match som en öppning, inte som ett resultat. Skriv samma dag: ju längre den ligger, desto mer blir den ett namn som ingen av er kan placera. Säg något du bara kunde ha sagt till just den här personen — en rad ur profilen, ett svar hen gav, anledningen till att du slutade scrolla. Allmänna öppningar får allmän tystnad. Och släpp det som aldrig rör sig; en oanvänd matchning kostar inget att förlora." },
      { type: "p", text: "Fällan är att samla på dem. En lång lista läses som bevis på att det går bra, och det gör det sällan: i en undersökning från Forbes Health och OnePoll 2024, bland 1 000 amerikanska vuxna som använt en dejtingapp det senaste året, uppgav 78 % att de kände sig utbrända. Fem matchningar du pratar med slår femtio du aldrig öppnar." },
    ],
  },
  hi: {
    term: "मैच",
    summary:
      "वह पल जब कोई ऐप दो लोगों को एक-दूसरे से बात करने की इजाज़त देता है और चैट खोल देता है। यह सिर्फ़ बात शुरू करने की अनुमति है: न दिलचस्पी का सबूत, न मेहनत का, और न ही इसकी गारंटी कि कोई लिखेगा।",
    blocks: [
      { type: "h2", text: "ऐप्स को इसके लिए एक शब्द क्यों चाहिए था" },
      { type: "p", text: "ऐप्स से पहले किसी को उस पल का नाम रखने की ज़रूरत नहीं थी जब दो लोग एक-दूसरे तक पहुँच सकते हैं: या तो आप किसी से बात करते थे, या नहीं करते थे। ऐप्स ने बीच में एक दरवाज़ा लगा दिया — दोनों की हामी के बिना कोई संदेश होता ही नहीं — और उस दरवाज़े को एक नाम चाहिए था। मैच शब्द दो चीज़ों के आपस में मेल खाने वाले आम मतलब से आया है, और गड़बड़ ठीक यहीं से शुरू होती है। शब्द मेल का वादा करता है, फ़ीचर सिर्फ़ पहुँच देता है।" },
      { type: "p", text: "दरवाज़ा कैसे खुलता है, यह ऐप पर निर्भर करता है। स्वाइप वाले ऐप्स में दोनों एक-दूसरे को दाईं ओर स्वाइप करते हैं और चैट खुल जाती है। Qulo पर वह अलग तरीक़े से खुलता है: आप 2 से 4 बहुविकल्पीय सवाल लिखते हैं, भुगतान वाली योजना में 10 तक, और सामने वाला तभी मैच करता है जब वह हर सवाल सही कर दे। दरवाज़े अलग, नतीजा एक — एक बातचीत, जिसमें अभी कुछ तय नहीं हुआ।" },
      { type: "h2", text: "भरी हुई लिस्ट खाली क्यों लगती है" },
      { type: "ul", items: [
        "लिस्ट बढ़ती है, बातचीत नहीं: मैच कई दिनों तक बिना खुले पड़े रहते हैं।",
        "आधे लोगों के बारे में याद ही नहीं रहता कि मैच क्यों हुआ था — उन्हें भी नहीं।",
        "दूसरे संदेश पर बात अटक जाती है, क्योंकि किसी के पास कहने को कुछ ख़ास नहीं था।",
        "ऐप खोलना किसी से मिलने से ज़्यादा नोटिफ़िकेशन निपटाने जैसा लगता है।",
      ] },
      { type: "h2", accent: "green", text: "मैच का असल में करना क्या है" },
      { type: "p", text: "मैच को नतीजा नहीं, खुला हुआ दरवाज़ा मानिए। उसी दिन संदेश भेजिए; जितना पड़ा रहेगा, वह उतना ही एक ऐसा नाम बन जाएगा जिसे दोनों में से कोई पहचान नहीं पाएगा। ऐसा कुछ कहिए जो सिर्फ़ उसी इंसान से कहा जा सकता हो: प्रोफ़ाइल की एक लाइन, उसका दिया कोई जवाब, या वह वजह जिसने आपको रुकने पर मजबूर किया। घिसे-पिटे संदेश के जवाब में घिसी-पिटी चुप्पी मिलती है। और जो कभी आगे न बढ़े, उसे जाने दीजिए।" },
      { type: "p", text: "असली जाल जमा करने में है। लंबी लिस्ट ऐसी लगती है मानो सब ठीक चल रहा हो, जबकि अक्सर ऐसा नहीं होता: Forbes Health और OnePoll के 2024 के सर्वे में, पिछले एक साल में डेटिंग ऐप इस्तेमाल कर चुके 1,000 अमेरिकी वयस्कों में से 78% ने थकान की बात कही। जिन पाँच से आप बात करते हैं, वे उन पचास से बेहतर हैं जिन्हें आप कभी खोलते ही नहीं।" },
    ],
  },
};
