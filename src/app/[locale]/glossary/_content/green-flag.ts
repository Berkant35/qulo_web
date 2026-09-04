import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Green flag — a sign that someone is likely to be good to be with.
 *
 * Editorial notes for whoever touches this next:
 * - Same axis as red-flag and beige-flag: red and green are about CONDUCT (how
 *   someone treats you and treats other people), beige is about TEXTURE. Each
 *   file phrases that boundary differently on purpose; do not paste one into
 *   another.
 * - The brief was "be concrete", because almost every list of green flags in
 *   circulation is a list of adjectives. Block 2 says so, and block 4 keeps to
 *   observable actions: repairs after an argument, decent to service staff,
 *   states what they want, words match the calendar. If you edit block 4, keep
 *   every item something a reader could watch happen.
 * - No statistics. The one sourced figure available (78% burnout, Forbes Health
 *   / OnePoll 2024) is about app fatigue and would be filler here.
 * - Block 7 is the only Qulo connection in this batch of four terms (red-flag,
 *   beige-flag and ick all end on something else), and it is a real one: the
 *   product mechanic — you write your own multiple-choice questions, four
 *   options each, author marks the correct answer — is itself a small test of
 *   whether someone writes for the reader or for themselves. The question count
 *   is left out on purpose: a free account writes 2 to 4 and only a paid plan
 *   reaches 10, and neither number says anything about the point being made
 *   here. Never quote the range as 2 to 10 without naming the paid plan in the
 *   same sentence. It deliberately does NOT claim the quiz screens for
 *   character, verifies anyone, or prevents anything.
 * - "Repairs after an argument" is described, not named as a therapy concept.
 *   No attachment styles, no "emotional labour", no diagnosis.
 * - Term names: de/fr/pt/it/nl/sv keep the English loanword because that is what
 *   people say; es/pl/ru/tr/ar/hi/ja/ko use the native form. zh uses 积极信号 to
 *   pair with 危险信号 in red-flag — 绿旗 is not idiomatic for this.
 */
export const greenFlag: LocalizedGlossaryEntry = {
  en: {
    term: "Green flag",
    summary:
      "A sign that someone is likely to be a good partner — usually something small and repeatable, like repairing after an argument, being decent to service staff, or saying plainly what they want instead of leaving you to guess.",
    blocks: [
      { type: "h2", text: "Why the word had to be invented" },
      { type: "p", text: "The green flag arrived as a correction. People had spent years training themselves to scan for danger, and that makes you excellent at spotting what is wrong and blind to what is right. Around 2021 the same quick shorthand spread across social media, pointed the other way. It works because a vocabulary made only of warnings gives you things to run from and nothing to walk toward." },
      { type: "p", text: "Most lists of them are useless, though. \"Communicates well\", \"emotionally available\", \"has healthy boundaries\" — you cannot observe an adjective. A green flag is something a person does: usually unglamorous, and usually visible within the first few weeks if you know what you are looking at." },
      { type: "h2", text: "What one actually looks like" },
      { type: "ul", items: [
        "**They repair:** after an argument they come back, name their part in it and check that you are okay — without being chased",
        "**They are decent when nobody is keeping score:** to the waiter, to the delivery driver, to the person on the phone who got something wrong",
        "**They say what they want:** exclusivity, plans, how often they like to text — stated plainly instead of hinted at and left for you to decode",
        "**Their words and their week agree:** what they said on Tuesday still holds on Saturday, without a reminder",
      ] },
      { type: "h2", accent: "green", text: "What to do with a good sign" },
      { type: "p", text: "Say it out loud. Most people never find out which of their ordinary behaviour landed well, and naming it makes a repeat more likely — \"I liked that you just said what you wanted\" costs nothing. Then check whether you can return it, because this is a shared standard and not a checklist you hold someone to. And give it a few weeks: consistency is the only proof there is, and one exceptional evening is not consistency." },
      { type: "p", text: "One of them shows up before you have even met. On Qulo everyone writes their own multiple-choice questions with four options and marks the right answer. A question a stranger could genuinely work out — about how you think, what you would choose — is a small act of consideration. A question only your best friend could answer is a small wall." },
    ],
  },

  tr: {
    term: "Yeşil bayrak",
    summary:
      "Birinin iyi bir partner olma ihtimalini gösteren işaret: tartışmadan sonra dönüp toparlamak, garsona düzgün davranmak, ne istediğini tahmin ettirmeden söylemek gibi küçük ama tekrarlanan şeyler.",
    blocks: [
      { type: "h2", text: "Bu kelimeye neden ihtiyaç duyuldu?" },
      { type: "p", text: "Yeşil bayrak bir düzeltme olarak geldi. İnsanlar yıllarca kendilerini tehlike aramaya alıştırdı; bu da insanı yanlışı görmekte ustalaştırıp doğruyu görmekte körleştiriyor. 2021 civarında aynı kısa kalıbın tersi sosyal medyada yayıldı. İşe yaramasının sebebi basit: sadece uyarılardan oluşan bir sözlük kaçılacak şeyler verir, gidilecek bir yer vermez." },
      { type: "p", text: "Ama dolaşan listelerin çoğu işe yaramıyor. \"İletişimi güçlü\", \"duygusal olarak müsait\", \"sınırları sağlıklı\" — sıfat gözlemlenemez. Yeşil bayrak, bir insanın yaptığı bir şeydir: genellikle gösterişsizdir ve ne aradığını biliyorsan ilk birkaç haftada görünür." },
      { type: "h2", text: "Gerçekte neye benziyor?" },
      { type: "ul", items: [
        "**Tamir eder:** tartışmadan sonra geri döner, kendi payını söyler ve iyi misin diye sorar — peşinden koşturmadan",
        "**Kimse not tutmazken de düzgündür:** garsona, kuryeye, telefonda hata yapan görevliye",
        "**Ne istediğini söyler:** ilişkinin adı, planlar, mesajlaşma sıklığı — ima edip çözmeni beklemek yerine açık açık",
        "**Sözüyle haftası uyuşur:** salı günü söylediği şey, hatırlatmaya gerek kalmadan cumartesi de geçerlidir",
      ] },
      { type: "h2", accent: "green", text: "İyi bir işaretle ne yapmalı?" },
      { type: "p", text: "Yüksek sesle söyle. İnsanların çoğu, sıradan davranışlarının hangisinin karşı tarafta iyi bir iz bıraktığını hiç öğrenemez; söylemek o davranışın tekrarlanma ihtimalini artırır. \"Ne istediğini doğrudan söylemen hoşuma gitti\" demek hiçbir şeye mal olmuyor. Sonra aynısını verebiliyor musun diye bak; bunlar ortak bir standart, birine dayatılan bir liste değil. Ve birkaç hafta tanı: tek kanıt tutarlılıktır, tek bir güzel akşam tutarlılık sayılmaz." },
      { type: "p", text: "Bunlardan biri daha tanışmadan görünür. Qulo'da herkes dört seçenekli kendi sorularını yazar ve doğru cevabı işaretler. Bir yabancının gerçekten bulabileceği bir soru — nasıl düşündüğüne, ne seçeceğine dair — küçük bir nezaket jestidir. Sadece en yakın arkadaşının bilebileceği bir soru ise küçük bir duvar." },
    ],
  },

  de: {
    term: "Green Flag",
    summary:
      "Ein Zeichen, dass jemand ein guter Partner sein dürfte: meist etwas Kleines und Wiederholbares — nach dem Streit zurückkommen, zum Servicepersonal anständig sein, klar sagen, was man will.",
    blocks: [
      { type: "h2", text: "Warum es dieses Wort brauchte" },
      { type: "p", text: "Die Green Flag kam als Korrektur. Jahrelang hatten sich alle darauf trainiert, nach Gefahr zu suchen, und das macht dich hervorragend darin, Falsches zu erkennen, und blind für das Richtige. Um 2021 verbreitete sich in sozialen Netzwerken dieselbe schnelle Abkürzung, nur andersherum. Sie funktioniert, weil ein Vokabular aus lauter Warnungen dir nur Dinge gibt, vor denen du wegläufst, und keines, auf das du zugehen kannst." },
      { type: "p", text: "Die meisten Listen taugen trotzdem nichts. \"Kommuniziert gut\", \"emotional verfügbar\", \"hat gesunde Grenzen\" — ein Adjektiv kann man nicht beobachten. Eine Green Flag ist etwas, das jemand tut: meist unspektakulär und meist schon in den ersten Wochen sichtbar, wenn man weiß, worauf man schaut." },
      { type: "h2", text: "Wie eine wirklich aussieht" },
      { type: "ul", items: [
        "**Sie reparieren:** nach dem Streit kommen sie zurück, benennen ihren Anteil und fragen, ob es dir gut geht — ohne dass man sie holen muss",
        "**Sie sind anständig, wenn niemand mitzählt:** zum Kellner, zum Lieferanten, zu der Person am Telefon, die einen Fehler gemacht hat",
        "**Sie sagen, was sie wollen:** Exklusivität, Pläne, wie oft sie schreiben möchten — ausgesprochen statt angedeutet und dir zum Entschlüsseln überlassen",
        "**Wort und Woche passen zusammen:** was am Dienstag gesagt wurde, gilt am Samstag noch, ganz ohne Erinnerung",
      ] },
      { type: "h2", accent: "green", text: "Was du mit einem guten Zeichen machst" },
      { type: "p", text: "Sag es laut. Die meisten Menschen erfahren nie, welches ihrer alltäglichen Verhalten gut angekommen ist, und es auszusprechen macht die Wiederholung wahrscheinlicher — \"Ich fand gut, dass du einfach gesagt hast, was du willst\" kostet nichts. Prüfe dann, ob du dasselbe zurückgeben kannst: Das hier ist ein gemeinsamer Maßstab, keine Checkliste, die du jemandem vorhältst. Und gib ihm ein paar Wochen: Der einzige Beweis ist Beständigkeit, und ein besonders schöner Abend ist keine." },
      { type: "p", text: "Eines davon zeigt sich, bevor ihr euch überhaupt getroffen habt. Auf Qulo schreibt jede und jeder eigene Fragen mit vier Antwortmöglichkeiten und markiert die richtige. Eine Frage, die eine fremde Person tatsächlich lösen kann — wie du denkst, was du wählen würdest —, ist eine kleine Aufmerksamkeit. Eine Frage, die nur deine beste Freundin beantworten könnte, ist eine kleine Mauer." },
    ],
  },

  fr: {
    term: "Green flag",
    summary:
      "Un signe qu'une personne fera sans doute un bon partenaire : souvent quelque chose de petit et répétable — revenir après une dispute, être correct avec les serveurs, dire clairement ce qu'elle veut.",
    blocks: [
      { type: "h2", text: "Pourquoi ce mot est apparu" },
      { type: "p", text: "Le green flag est arrivé comme une correction. On s'était entraîné pendant des années à chercher le danger, ce qui rend excellent pour repérer ce qui cloche et aveugle à ce qui va bien. Vers 2021, la même formule rapide s'est répandue sur les réseaux, mais retournée. Elle fonctionne parce qu'un vocabulaire fait uniquement d'alertes ne donne que des choses à fuir, jamais une direction." },
      { type: "p", text: "La plupart des listes restent pourtant inutiles. \"Communique bien\", \"émotionnellement disponible\", \"a des limites saines\" : un adjectif ne s'observe pas. Un green flag est quelque chose qu'une personne fait, souvent sans éclat, souvent visible dès les premières semaines quand on sait quoi regarder." },
      { type: "h2", text: "À quoi ça ressemble vraiment" },
      { type: "ul", items: [
        "**Elle répare :** après une dispute, elle revient, nomme sa part et vérifie que tu vas bien — sans qu'on aille la chercher",
        "**Elle est correcte quand personne ne compte les points :** le serveur, le livreur, la personne au téléphone qui s'est trompée",
        "**Elle dit ce qu'elle veut :** l'exclusivité, les projets, le rythme des messages — annoncés, pas suggérés et laissés à décrypter",
        "**Ses paroles et sa semaine concordent :** ce qui a été dit mardi tient encore samedi, sans rappel",
      ] },
      { type: "h2", accent: "green", text: "Que faire d'un bon signe" },
      { type: "p", text: "Dis-le à voix haute. La plupart des gens ne sauront jamais lequel de leurs gestes ordinaires a fait mouche, et le nommer augmente les chances qu'il revienne — \"j'ai aimé que tu dises simplement ce que tu voulais\" ne coûte rien. Ensuite, demande-toi si tu peux le rendre : c'est une exigence partagée, pas une liste qu'on impose à l'autre. Et laisse passer quelques semaines : la seule preuve, c'est la constance, et une soirée exceptionnelle n'en est pas une." },
      { type: "p", text: "L'un d'eux apparaît même avant la rencontre. Sur Qulo, chacun écrit ses propres questions à quatre réponses et coche la bonne. Une question qu'un inconnu peut vraiment résoudre — sur ta façon de penser, sur ce que tu choisirais — est une petite attention. Une question que seule ta meilleure amie pourrait deviner est un petit mur." },
    ],
  },

  es: {
    term: "Bandera verde",
    summary:
      "Una señal de que alguien tiene pinta de ser buena pareja: casi siempre algo pequeño y repetible — volver después de una discusión, tratar bien a quien te sirve la mesa, decir lo que quiere sin que tengas que adivinarlo.",
    blocks: [
      { type: "h2", text: "Por qué hizo falta la palabra" },
      { type: "p", text: "La bandera verde llegó como corrección. Llevábamos años entrenándonos para buscar peligro, y eso te vuelve buenísimo detectando lo que está mal y ciego para lo que está bien. Hacia 2021 se extendió por las redes el mismo atajo rápido, pero al revés. Funciona porque un vocabulario hecho solo de avisos te da cosas de las que huir y ninguna hacia la que ir." },
      { type: "p", text: "Aun así, casi todas las listas sirven de poco. \"Se comunica bien\", \"está disponible emocionalmente\", \"tiene límites sanos\": un adjetivo no se puede observar. Una bandera verde es algo que la persona hace, normalmente sin brillo y normalmente visible en las primeras semanas si sabes qué mirar." },
      { type: "h2", text: "Cómo es una de verdad" },
      { type: "ul", items: [
        "**Repara:** después de una discusión vuelve, dice cuál fue su parte y comprueba que estés bien — sin que haya que ir a buscarle",
        "**Es decente cuando nadie lleva la cuenta:** con el camarero, con el repartidor, con quien se equivoca al teléfono",
        "**Dice lo que quiere:** exclusividad, planes, cada cuánto le gusta escribir — dicho, no insinuado para que lo descifres tú",
        "**Sus palabras y su semana coinciden:** lo que dijo el martes sigue en pie el sábado, sin recordatorios",
      ] },
      { type: "h2", accent: "green", text: "Qué hacer con una buena señal" },
      { type: "p", text: "Dilo en voz alta. Casi nadie llega a saber cuál de sus gestos corrientes cayó bien, y nombrarlo hace más probable que se repita: \"me gustó que dijeras directamente lo que querías\" no cuesta nada. Después mira si tú puedes devolverlo, porque esto es un estándar compartido y no una lista que se le exige a alguien. Y dale unas semanas: la única prueba es la constancia, y una noche brillante no lo es." },
      { type: "p", text: "Una de ellas aparece incluso antes de conoceros. En Qulo cada persona escribe sus propias preguntas de cuatro opciones y marca la correcta. Una pregunta que un desconocido pueda resolver de verdad — sobre cómo piensas, sobre qué elegirías — es un gesto de consideración. Una que solo acertaría tu mejor amiga es un pequeño muro." },
    ],
  },

  ar: {
    term: "علم أخضر",
    summary:
      "إشارة إلى أن الشخص قد يكون شريكًا جيدًا: غالبًا شيء صغير ومتكرر — أن يعود بعد الخلاف، وأن يعامل العاملين باحترام، وأن يقول ما يريده بدل أن تخمّنه أنت.",
    blocks: [
      { type: "h2", text: "لماذا احتجنا هذه الكلمة" },
      { type: "p", text: "جاء العلم الأخضر تصحيحًا. أمضى الناس سنوات يدرّبون أنفسهم على البحث عن الخطر، وهذا يجعلك بارعًا في رؤية الخطأ أعمى عن الصواب. وحوالي عام 2021 انتشر على الشبكات الاختصار نفسه لكن مقلوبًا. ينفع لأن قاموسًا كله تحذيرات يمنحك أشياء تهرب منها، ولا يمنحك وجهة تمشي نحوها." },
      { type: "p", text: "مع ذلك أغلب القوائم بلا فائدة. \"يتواصل جيدًا\"، \"متاح عاطفيًا\"، \"لديه حدود صحية\" — الصفة لا تُلاحَظ. العلم الأخضر شيء يفعله الشخص: غالبًا بلا بريق، وغالبًا يظهر في الأسابيع الأولى إن كنت تعرف إلى ماذا تنظر." },
      { type: "h2", text: "كيف يبدو فعلًا" },
      { type: "ul", items: [
        "**يرمّم:** بعد الشجار يعود، ويسمّي نصيبه من الخطأ، ويطمئن عليك — دون أن تلاحقه",
        "**مهذّب حين لا أحد يحسب النقاط:** مع النادل، ومع عامل التوصيل، ومع من أخطأ على الهاتف",
        "**يقول ما يريد:** الارتباط، والخطط، وكم يحب أن يتراسل — قولًا صريحًا لا تلميحًا تفكّه أنت",
        "**كلامه وأسبوعه متطابقان:** ما قاله الثلاثاء ما زال قائمًا السبت، بلا تذكير",
      ] },
      { type: "h2", accent: "green", text: "ماذا تفعل بالإشارة الجيدة" },
      { type: "p", text: "قلها بصوت مسموع. معظم الناس لا يعرفون أبدًا أي تصرّف عادي منهم وقع موقعًا حسنًا، وتسميته تزيد احتمال تكراره؛ جملة مثل \"أعجبني أنك قلت ما تريده مباشرة\" لا تكلّف شيئًا. ثم انظر هل تستطيع أن تردّ المثل، فهذا معيار مشترك لا قائمة تفرضها على أحد. وامنحه بضعة أسابيع: الدليل الوحيد هو الثبات، وليلة واحدة رائعة ليست ثباتًا." },
      { type: "p", text: "واحدة من هذه الإشارات تظهر قبل أن تلتقيا أصلًا. في Qulo يكتب كل شخص أسئلته الخاصة بأربعة خيارات ويحدّد الإجابة الصحيحة. سؤال يستطيع غريب أن يستنتجه فعلًا — عن طريقة تفكيرك أو عمّا ستختاره — لفتة اهتمام صغيرة. وسؤال لا يعرفه إلا أقرب أصدقائك جدار صغير." },
    ],
  },

  ru: {
    term: "Зелёный флаг",
    summary:
      "Признак того, что человек, скорее всего, будет хорошим партнёром: обычно что-то небольшое и повторяющееся — вернуться после ссоры, вежливо говорить с официантом, прямо сказать, чего он хочет.",
    blocks: [
      { type: "h2", text: "Зачем понадобилось такое слово" },
      { type: "p", text: "Зелёный флаг появился как поправка. Люди годами тренировались высматривать опасность, а это делает вас отличным в распознавании плохого и слепым к хорошему. Примерно к 2021 году в соцсетях разошлось то же короткое выражение, только вывернутое наизнанку. Оно работает, потому что словарь из одних предупреждений даёт только то, от чего бежать, и ничего, к чему идти." },
      { type: "p", text: "Но большинство списков бесполезны. \"Хорошо общается\", \"эмоционально доступен\", \"здоровые границы\" — прилагательное нельзя увидеть. Зелёный флаг — это то, что человек делает: обычно ничем не эффектное и обычно заметное в первые же недели, если знать, куда смотреть." },
      { type: "h2", text: "Как он выглядит на самом деле" },
      { type: "ul", items: [
        "**Он чинит:** после ссоры возвращается, называет свою часть вины и спрашивает, как вы — без того, чтобы за ним бегали",
        "**Он нормальный, когда никто не считает очки:** с официантом, с курьером, с человеком на телефоне, который ошибся",
        "**Он говорит, чего хочет:** отношения, планы, как часто ему нравится переписываться — вслух, а не намёком, который вам предстоит расшифровать",
        "**Слова и неделя совпадают:** сказанное во вторник в силе и в субботу, без напоминаний",
      ] },
      { type: "h2", accent: "green", text: "Что делать с хорошим знаком" },
      { type: "p", text: "Скажите вслух. Большинство людей так и не узнают, какое их обычное поведение было замечено, а названное вслух повторяется чаще: \"мне понравилось, что ты просто сказал, чего хочешь\" не стоит ничего. Потом проверьте, можете ли вы ответить тем же: это общий стандарт, а не список требований к другому. И дайте паре недель пройти: единственное доказательство — постоянство, а один прекрасный вечер постоянством не является." },
      { type: "p", text: "Один такой знак виден ещё до встречи. В Qulo каждый пишет свои собственные вопросы с четырьмя вариантами и отмечает правильный. Вопрос, который незнакомый человек действительно может разгадать — о том, как вы думаете, что бы вы выбрали, — это маленькая внимательность. Вопрос, который знает только ваша лучшая подруга, — маленькая стена." },
    ],
  },

  pt: {
    term: "Green flag",
    summary:
      "Um sinal de que a pessoa tem tudo para ser boa companhia: quase sempre algo pequeno e repetível — voltar depois de uma briga, tratar bem quem atende, dizer o que quer sem deixar você adivinhando.",
    blocks: [
      { type: "h2", text: "Por que a palavra precisou existir" },
      { type: "p", text: "A green flag apareceu como correção. Passamos anos treinando o olho para o perigo, e isso deixa a pessoa ótima em ver o que está errado e cega para o que está certo. Por volta de 2021 o mesmo atalho rápido se espalhou nas redes, só que virado do avesso. Funciona porque um vocabulário feito só de alertas dá coisas para fugir e nenhuma para ir atrás." },
      { type: "p", text: "Ainda assim, quase toda lista é inútil. \"Se comunica bem\", \"está disponível emocionalmente\", \"tem limites saudáveis\": adjetivo não se observa. Uma green flag é algo que a pessoa faz, geralmente sem brilho e geralmente visível nas primeiras semanas, se você souber o que olhar." },
      { type: "h2", text: "Como é uma de verdade" },
      { type: "ul", items: [
        "**Repara:** depois de uma briga volta, diz qual foi a parte dela e pergunta se você está bem — sem precisar ser buscada",
        "**É decente quando ninguém está contando pontos:** com o garçom, com o entregador, com quem errou no telefone",
        "**Diz o que quer:** exclusividade, planos, o quanto gosta de trocar mensagens — falado, não insinuado para você decifrar",
        "**A fala e a semana batem:** o que foi dito na terça continua de pé no sábado, sem lembrete",
      ] },
      { type: "h2", accent: "green", text: "O que fazer com um bom sinal" },
      { type: "p", text: "Fale em voz alta. Quase ninguém descobre qual dos seus gestos comuns caiu bem, e dizer isso aumenta a chance de acontecer de novo — \"gostei de você ter dito direto o que queria\" não custa nada. Depois veja se você consegue devolver, porque isso é um padrão de mão dupla, não uma lista que se cobra do outro. E dê algumas semanas: a única prova é a constância, e uma noite excepcional não é constância." },
      { type: "p", text: "Um deles aparece antes mesmo de vocês se encontrarem. No Qulo cada pessoa escreve as próprias perguntas de quatro alternativas e marca a certa. Uma pergunta que um estranho consegue mesmo deduzir — sobre como você pensa, sobre o que escolheria — é um pequeno gesto de consideração. Uma que só a sua melhor amiga acertaria é um pequeno muro." },
    ],
  },

  it: {
    term: "Green flag",
    summary:
      "Un segno che una persona sarà probabilmente un buon partner: quasi sempre qualcosa di piccolo e ripetibile — tornare dopo un litigio, trattare bene chi ti serve al tavolo, dire chiaramente cosa vuole.",
    blocks: [
      { type: "h2", text: "Perché è servita questa parola" },
      { type: "p", text: "La green flag è arrivata come correzione. Per anni ci siamo allenati a cercare il pericolo, e questo rende bravissimi a vedere ciò che non va e ciechi davanti a ciò che va bene. Verso il 2021 sui social si è diffusa la stessa scorciatoia, ma rovesciata. Funziona perché un vocabolario fatto solo di allarmi ti dà cose da cui scappare e nessuna verso cui andare." },
      { type: "p", text: "La maggior parte degli elenchi però non serve. \"Comunica bene\", \"è disponibile emotivamente\", \"ha confini sani\": un aggettivo non si osserva. Una green flag è qualcosa che una persona fa: di solito senza scenografia e di solito visibile nelle prime settimane, se sai cosa guardare." },
      { type: "h2", text: "Com'è fatta davvero" },
      { type: "ul", items: [
        "**Ripara:** dopo un litigio torna, dice qual è stata la sua parte e controlla che tu stia bene — senza che tu debba andarla a cercare",
        "**È corretta quando nessuno tiene il punteggio:** con il cameriere, con il fattorino, con chi al telefono ha sbagliato",
        "**Dice cosa vuole:** esclusività, programmi, quanto le piace scriversi — detto, non alluso e lasciato a te da decifrare",
        "**Le parole e la settimana coincidono:** quello che ha detto martedì vale ancora sabato, senza promemoria",
      ] },
      { type: "h2", accent: "green", text: "Cosa fare con un buon segnale" },
      { type: "p", text: "Dillo ad alta voce. Quasi nessuno scopre quale dei suoi gesti ordinari è arrivato bene, e nominarlo rende più probabile che si ripeta: \"mi è piaciuto che tu abbia detto subito cosa volevi\" non costa niente. Poi guarda se sai restituirlo, perché questo è uno standard condiviso e non una lista da imporre. E lascia passare qualche settimana: l'unica prova è la costanza, e una serata eccezionale non lo è." },
      { type: "p", text: "Uno di questi segnali si vede prima ancora di incontrarsi. Su Qulo ognuno scrive le proprie domande con quattro risposte e segna quella giusta. Una domanda che uno sconosciuto può davvero risolvere — su come ragioni, su cosa sceglieresti — è una piccola gentilezza. Una che saprebbe solo la tua migliore amica è un piccolo muro." },
    ],
  },

  ja: {
    term: "グリーンフラッグ",
    summary:
      "その人がいい相手になりそうだと分かる合図。けんかのあとに自分から戻ってくる、店員に丁寧に接する、してほしいことを察させずに言う——たいてい小さくて繰り返される行動です。",
    blocks: [
      { type: "h2", text: "なぜこの言葉が必要だったか" },
      { type: "p", text: "グリーンフラッグは修正として現れました。長いあいだ人は危険を探す訓練ばかりしてきて、その結果、悪いところを見つけるのは得意なのに、よいところにはほとんど気づけなくなりました。2021年ごろ、同じ手軽な言い方を裏返した表現がSNSで広がります。警告だけでできた語彙は、逃げる先しか教えてくれず、向かう先を教えてくれないからです。" },
      { type: "p", text: "とはいえ、出回っているリストの多くは役に立ちません。「コミュニケーションが上手」「感情的に開かれている」「境界線が健全」——形容詞は観察できません。グリーンフラッグはその人が実際にすることで、たいてい地味で、見る場所さえ分かっていれば最初の数週間で見えてきます。" },
      { type: "h2", text: "実際にはどんな形をしているか" },
      { type: "ul", items: [
        "**修復する:** けんかのあとに自分から戻り、自分の非を口にし、あなたの様子を確かめる——追いかけなくても",
        "**点数を数える人がいない場面でも礼儀正しい:** 店員に、配達員に、電話口で間違えた担当者に",
        "**望みを言葉にする:** 交際の形、予定、連絡の頻度——ほのめかして解読させるのではなく、そのまま言う",
        "**言葉と一週間が一致する:** 火曜に言ったことが、催促なしで土曜にもそのまま生きている",
      ] },
      { type: "h2", accent: "green", text: "よい合図を見つけたら" },
      { type: "p", text: "口に出して言ってください。自分のどのふるまいが相手に届いたのか、たいていの人は最後まで知りません。言葉にすると、その行動はもう一度起きやすくなります。「してほしいことをはっきり言ってくれてよかった」と言うのはただですみます。そのうえで、同じことを自分も返せるか確かめてください。これは共通の基準で、相手に突きつけるチェックリストではありません。そして数週間は待つこと。証拠になるのは一貫性だけで、特別な一晩は一貫性ではありません。" },
      { type: "p", text: "そのうちの一つは、会う前から見えます。Quloでは全員が四択の質問を自分で書き、正解を設定します。初対面の人でも考えれば解ける質問——あなたの考え方や、選びそうなもの——は、小さな心配りです。親友にしか分からない質問は、小さな壁です。" },
    ],
  },

  ko: {
    term: "그린 플래그",
    summary:
      "이 사람이 좋은 상대일 가능성을 보여주는 신호. 다툰 뒤 먼저 돌아와 수습하기, 종업원에게 예의 바르기, 원하는 것을 짐작하게 하지 않고 말하기처럼 작고 반복되는 행동입니다.",
    blocks: [
      { type: "h2", text: "왜 이 말이 필요했나" },
      { type: "p", text: "그린 플래그는 교정으로 등장했습니다. 사람들은 오랫동안 위험만 찾도록 자신을 훈련시켰고, 그러면 잘못된 것은 잘 보이지만 괜찮은 것은 보이지 않게 됩니다. 2021년 무렵 같은 표현을 뒤집은 말이 소셜 미디어에 퍼졌습니다. 경고만 있는 어휘는 도망칠 곳만 알려줄 뿐 걸어갈 방향은 알려주지 않기 때문입니다." },
      { type: "p", text: "그래도 떠도는 목록 대부분은 쓸모가 없습니다. \"소통을 잘한다\", \"정서적으로 열려 있다\", \"경계가 건강하다\" — 형용사는 관찰할 수 없습니다. 그린 플래그는 그 사람이 실제로 하는 행동이고, 대개 화려하지 않으며, 무엇을 볼지 알면 첫 몇 주 안에 드러납니다." },
      { type: "h2", text: "실제 모습은 이렇습니다" },
      { type: "ul", items: [
        "**복구합니다:** 다툰 뒤 먼저 돌아와 자기 몫을 말하고 당신이 괜찮은지 확인합니다 — 쫓아가지 않아도",
        "**점수를 세는 사람이 없을 때도 예의 바릅니다:** 종업원에게, 배달 기사에게, 전화로 실수한 상담원에게",
        "**원하는 것을 말합니다:** 관계의 형태, 계획, 연락 빈도 — 눈치채게 하는 대신 그대로 말합니다",
        "**말과 한 주가 맞아떨어집니다:** 화요일에 한 말이 토요일에도, 상기시키지 않아도 그대로 유효합니다",
      ] },
      { type: "h2", accent: "green", text: "좋은 신호를 만나면" },
      { type: "p", text: "소리 내어 말하세요. 자기 어떤 행동이 상대에게 좋게 닿았는지 대부분은 끝내 모릅니다. 말해주면 그 행동은 다시 나올 가능성이 커집니다. \"원하는 걸 바로 말해줘서 좋았어\"라는 말은 비용이 들지 않습니다. 그다음에는 같은 것을 돌려줄 수 있는지 보세요. 이것은 함께 지키는 기준이지 상대에게 들이대는 목록이 아닙니다. 그리고 몇 주는 두고 보세요. 증거가 되는 것은 일관성뿐이고, 특별했던 하루는 일관성이 아닙니다." },
      { type: "p", text: "그중 하나는 만나기도 전에 보입니다. Qulo에서는 누구나 4지선다 질문을 직접 쓰고 정답을 정합니다. 처음 보는 사람도 곰곰이 생각하면 맞힐 수 있는 질문 — 당신의 생각 방식, 당신이 고를 법한 것 — 은 작은 배려입니다. 가장 친한 친구만 알 수 있는 질문은 작은 벽입니다." },
    ],
  },

  zh: {
    term: "积极信号",
    summary:
      "说明这个人可能是好伴侣的迹象：通常是很小又会重复出现的行为——吵完架主动回来收拾、对服务人员有礼貌、把想要什么直接说出来而不让你猜。",
    blocks: [
      { type: "h2", text: "为什么需要这个说法" },
      { type: "p", text: "它是作为一种纠正出现的。人们花了很多年训练自己盯着危险看，结果特别擅长发现哪里不对，却看不见哪里挺好。二〇二一年前后，同一种简短说法被翻了个面，在社交平台上流行起来。它有用，是因为只有警告的词汇只能告诉你往哪儿逃，不能告诉你往哪儿走。" },
      { type: "p", text: "不过大多数清单没什么用。“会沟通”“情绪稳定”“边界健康”——形容词是没法观察的。积极信号是一个人做出来的事，通常并不好看，但只要知道该看什么，头几周就能看见。" },
      { type: "h2", text: "它真实的样子" },
      { type: "ul", items: [
        "**他会修补：**吵完架主动回来，说出自己那部分不对，再确认你还好不好——不用你去找他",
        "**没人记分的时候也讲礼貌：**对服务员、外卖员，对电话那头弄错事情的人",
        "**他会说自己想要什么：**关系的名分、计划、多久联系一次——直接说，而不是暗示让你去猜",
        "**说过的话和这一周对得上：**周二说的事，不用提醒，周六依然算数",
      ] },
      { type: "h2", accent: "green", text: "遇到好信号该怎么做" },
      { type: "p", text: "说出来。大多数人一辈子都不知道自己哪个平常举动被对方记住了，说出来会让它更容易再发生。“你直接说你想要什么，我很喜欢”这句话不花一分钱。然后看看你能不能也做到，因为这是两个人共同的标准，不是拿来要求对方的清单。再给它几周时间：唯一的证据是稳定，一个格外美好的夜晚不算稳定。" },
      { type: "p", text: "其中一个信号，在你们见面之前就看得到。在 Qulo，每个人自己写四选一的题目并设定正确答案。一个陌生人认真想就能答出来的问题——关于你怎么想、你会选什么——是一点小小的体贴。只有你最好的朋友才知道答案的问题，则是一堵小小的墙。" },
    ],
  },

  nl: {
    term: "Green flag",
    summary:
      "Een teken dat iemand waarschijnlijk een goede partner is: meestal iets kleins en herhaalbaars — terugkomen na ruzie, netjes zijn tegen de ober, zeggen wat diegene wil in plaats van jou te laten raden.",
    blocks: [
      { type: "h2", text: "Waarom dit woord nodig was" },
      { type: "p", text: "De green flag kwam als correctie. Mensen hadden zichzelf jarenlang getraind om naar gevaar te speuren, en daar word je uitstekend van in het zien van wat mis is en blind voor wat goed gaat. Rond 2021 verspreidde dezelfde snelle uitdrukking zich omgekeerd op sociale media. Ze werkt omdat een woordenschat van louter waarschuwingen je alleen dingen geeft om van weg te lopen, en niets om naartoe te gaan." },
      { type: "p", text: "Toch zijn de meeste lijstjes waardeloos. \"Communiceert goed\", \"emotioneel beschikbaar\", \"gezonde grenzen\" — een bijvoeglijk naamwoord kun je niet waarnemen. Een green flag is iets wat iemand doet: meestal onspectaculair en meestal al in de eerste weken zichtbaar, als je weet waar je naar kijkt." },
      { type: "h2", text: "Hoe er eentje er echt uitziet" },
      { type: "ul", items: [
        "**Diegene herstelt:** na ruzie komt hij terug, benoemt zijn eigen aandeel en vraagt of het goed met je gaat — zonder dat je erachteraan moet",
        "**Netjes als niemand de punten telt:** tegen de ober, de bezorger, degene aan de telefoon die iets fout deed",
        "**Zegt wat hij wil:** exclusiviteit, plannen, hoe vaak hij graag appt — uitgesproken, niet gehint en aan jou overgelaten",
        "**Woorden en week kloppen met elkaar:** wat dinsdag gezegd is, geldt zaterdag nog, zonder herinnering",
      ] },
      { type: "h2", accent: "green", text: "Wat je met een goed teken doet" },
      { type: "p", text: "Zeg het hardop. De meeste mensen komen nooit te weten welk gewoon gedrag van hen goed viel, en het benoemen maakt herhaling waarschijnlijker — \"ik vond het fijn dat je gewoon zei wat je wilde\" kost niets. Kijk daarna of je het kunt teruggeven, want dit is een gedeelde maatstaf en geen lijstje dat je iemand voorhoudt. En geef het een paar weken: het enige bewijs is bestendigheid, en één uitzonderlijke avond is dat niet." },
      { type: "p", text: "Eén ervan zie je al voor de eerste ontmoeting. Op Qulo schrijft iedereen eigen vragen met vier antwoorden en markeert het juiste. Een vraag die een onbekende echt kan uitpuzzelen — over hoe je denkt, wat je zou kiezen — is een kleine attentie. Een vraag die alleen je beste vriendin goed heeft, is een muurtje." },
    ],
  },

  pl: {
    term: "Zielona flaga",
    summary:
      "Znak, że ktoś zapowiada się na dobrego partnera: zwykle coś drobnego i powtarzalnego — wraca po kłótni, jest przyzwoity wobec obsługi, mówi wprost, czego chce, zamiast kazać ci zgadywać.",
    blocks: [
      { type: "h2", text: "Skąd potrzeba takiego słowa" },
      { type: "p", text: "Zielona flaga pojawiła się jako korekta. Przez lata trenowaliśmy się w wypatrywaniu zagrożeń, a to czyni człowieka świetnym w dostrzeganiu tego, co złe, i ślepym na to, co dobre. Około 2021 roku w mediach społecznościowych rozeszło się to samo krótkie określenie, tylko odwrócone. Działa, bo słownik złożony wyłącznie z ostrzeżeń daje rzeczy, od których się ucieka, i żadnej, do której można iść." },
      { type: "p", text: "Mimo to większość list jest bezużyteczna. \"Dobrze się komunikuje\", \"jest dostępny emocjonalnie\", \"ma zdrowe granice\" — przymiotnika nie da się zaobserwować. Zielona flaga to coś, co człowiek robi: zwykle bez efektów specjalnych i zwykle widoczne w pierwszych tygodniach, jeśli wiesz, na co patrzysz." },
      { type: "h2", text: "Jak wygląda naprawdę" },
      { type: "ul", items: [
        "**Naprawia:** po kłótni wraca, nazywa swój udział i sprawdza, czy wszystko u ciebie w porządku — bez ganiania za nim",
        "**Jest przyzwoity, gdy nikt nie liczy punktów:** wobec kelnera, kuriera, osoby przy telefonie, która się pomyliła",
        "**Mówi, czego chce:** wyłączność, plany, jak często lubi pisać — powiedziane wprost, nie zasugerowane do rozszyfrowania",
        "**Słowa i tydzień się zgadzają:** to, co powiedział we wtorek, obowiązuje w sobotę, bez przypominania",
      ] },
      { type: "h2", accent: "green", text: "Co zrobić z dobrym znakiem" },
      { type: "p", text: "Powiedz to na głos. Większość ludzi nigdy się nie dowie, które ich zwykłe zachowanie trafiło, a nazwanie zwiększa szansę, że się powtórzy — \"podobało mi się, że po prostu powiedziałeś, czego chcesz\" nic nie kosztuje. Potem sprawdź, czy potrafisz to odwzajemnić, bo to wspólny standard, a nie lista wymagań wobec kogoś. I daj temu kilka tygodni: jedynym dowodem jest konsekwencja, a jeden wyjątkowy wieczór nią nie jest." },
      { type: "p", text: "Jeden z tych znaków widać jeszcze przed spotkaniem. W Qulo każdy pisze własne pytania z czterema odpowiedziami i zaznacza właściwą. Pytanie, które obca osoba naprawdę może rozwiązać — o to, jak myślisz i co byś wybrał — to drobny gest uwagi. Pytanie, które zna tylko twoja najlepsza przyjaciółka, to mały mur." },
    ],
  },

  sv: {
    term: "Green flag",
    summary:
      "Ett tecken på att någon troligen blir en bra partner: oftast något litet och återkommande — kommer tillbaka efter ett gräl, är hygglig mot serveringspersonalen, säger vad hen vill i stället för att låta dig gissa.",
    blocks: [
      { type: "h2", text: "Varför ordet behövdes" },
      { type: "p", text: "Green flag kom som en korrigering. Vi hade tränat oss i åratal på att leta efter fara, och det gör en utmärkt på att se vad som är fel och blind för vad som är bra. Runt 2021 spreds samma snabba uttryck på sociala medier, fast vänt åt andra hållet. Det fungerar för att ett ordförråd av bara varningar ger dig saker att fly från och ingenting att gå mot." },
      { type: "p", text: "Ändå är de flesta listor värdelösa. \"Kommunicerar bra\", \"känslomässigt tillgänglig\", \"har sunda gränser\" — ett adjektiv går inte att observera. En green flag är något en person gör: oftast odramatiskt och oftast synligt redan de första veckorna om du vet vad du tittar efter." },
      { type: "h2", text: "Hur en faktiskt ser ut" },
      { type: "ul", items: [
        "**Hen reparerar:** efter ett gräl kommer hen tillbaka, säger vad som var hens del och kollar att du mår bra — utan att behöva jagas",
        "**Hygglig när ingen räknar poäng:** mot servitören, mot budet, mot personen i telefon som gjorde fel",
        "**Säger vad hen vill ha:** exklusivitet, planer, hur ofta hen gillar att skriva — sagt rakt ut i stället för antytt och lämnat åt dig att tyda",
        "**Ord och vecka stämmer överens:** det som sades på tisdagen gäller fortfarande på lördagen, utan påminnelse",
      ] },
      { type: "h2", accent: "green", text: "Vad du gör med ett bra tecken" },
      { type: "p", text: "Säg det högt. De flesta får aldrig veta vilket av deras vardagliga beteenden som landade bra, och att sätta ord på det gör det mer sannolikt att det upprepas — \"jag gillade att du bara sa vad du ville ha\" kostar ingenting. Se sedan efter om du kan ge tillbaka detsamma, för det här är en gemensam måttstock och ingen checklista att hålla någon till. Och ge det några veckor: det enda beviset är uthållighet, och en enda lysande kväll är inte det." },
      { type: "p", text: "Ett av tecknen syns redan innan ni har träffats. På Qulo skriver alla egna frågor med fyra svarsalternativ och markerar rätt svar. En fråga som en främling faktiskt kan resonera sig fram till — om hur du tänker, vad du skulle välja — är en liten omtanke. En fråga som bara din bästa vän kan svara på är en liten mur." },
    ],
  },

  hi: {
    term: "ग्रीन फ्लैग",
    summary:
      "इस बात का संकेत कि यह इंसान अच्छा साथी हो सकता है: आमतौर पर छोटी और बार-बार दोहराई जाने वाली बातें — झगड़े के बाद ख़ुद लौटकर सुलझाना, वेटर के साथ शालीनता, और जो चाहिए उसे बिना अंदाज़ा लगवाए कह देना।",
    blocks: [
      { type: "h2", text: "यह शब्द ज़रूरी क्यों हुआ" },
      { type: "p", text: "ग्रीन फ्लैग एक सुधार की तरह आया। लोगों ने सालों तक ख़ुद को ख़तरा ढूँढ़ने की ट्रेनिंग दी, और इससे इंसान ग़लत चीज़ पहचानने में माहिर और सही चीज़ देखने में अंधा हो जाता है। 2021 के आसपास यही छोटा-सा मुहावरा उल्टा करके सोशल मीडिया पर फैल गया। यह काम करता है क्योंकि सिर्फ़ चेतावनियों से बनी शब्दावली भागने की जगहें देती है, जाने की दिशा नहीं।" },
      { type: "p", text: "फिर भी ज़्यादातर सूचियाँ बेकार हैं। \"अच्छा संवाद करता है\", \"भावनात्मक रूप से उपलब्ध है\", \"स्वस्थ सीमाएँ हैं\" — विशेषण को देखा नहीं जा सकता। ग्रीन फ्लैग वह है जो इंसान करता है: अक्सर बिना चमक-दमक के, और अगर आपको पता हो कि क्या देखना है तो पहले कुछ हफ़्तों में ही दिख जाता है।" },
      { type: "h2", text: "असल में यह दिखता कैसा है" },
      { type: "ul", items: [
        "**वह मरम्मत करता है:** झगड़े के बाद ख़ुद लौटता है, अपनी ग़लती का हिस्सा कहता है और पूछता है कि आप ठीक हैं या नहीं — पीछे भागना नहीं पड़ता",
        "**जब कोई हिसाब नहीं रख रहा, तब भी शालीन:** वेटर के साथ, डिलीवरी वाले के साथ, फ़ोन पर ग़लती करने वाले कर्मचारी के साथ",
        "**जो चाहिए, वह कहता है:** रिश्ते का नाम, योजनाएँ, कितनी बार बात करना पसंद है — इशारों में नहीं, सीधे शब्दों में",
        "**बात और हफ़्ता मेल खाते हैं:** मंगलवार को कही बात शनिवार को भी, बिना याद दिलाए, कायम रहती है",
      ] },
      { type: "h2", accent: "green", text: "अच्छे संकेत का क्या करें" },
      { type: "p", text: "उसे कह दीजिए। ज़्यादातर लोगों को कभी पता ही नहीं चलता कि उनका कौन-सा साधारण काम सामने वाले को अच्छा लगा, और कह देने से वह दोबारा होने की संभावना बढ़ जाती है — \"तुमने सीधे कह दिया कि तुम्हें क्या चाहिए, यह मुझे अच्छा लगा\" कहने में कुछ ख़र्च नहीं होता। फिर देखिए कि आप वही लौटा सकते हैं या नहीं, क्योंकि यह दोनों पर लागू पैमाना है, किसी पर थोपी गई सूची नहीं। और कुछ हफ़्ते दीजिए: सबूत सिर्फ़ निरंतरता है, एक शानदार शाम नहीं।" },
      { type: "p", text: "इनमें से एक संकेत मिलने से पहले ही दिख जाता है। Qulo पर हर कोई चार विकल्पों वाले अपने सवाल लिखता है और सही जवाब चुनता है। ऐसा सवाल जिसे कोई अनजान इंसान सचमुच सोचकर हल कर सके — आप कैसे सोचते हैं, क्या चुनेंगे — एक छोटा-सा ख़याल है। जिसका जवाब सिर्फ़ आपकी सबसे अच्छी दोस्त जानती हो, वह एक छोटी दीवार है।" },
    ],
  },
};
