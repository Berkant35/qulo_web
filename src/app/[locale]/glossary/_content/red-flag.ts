import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Red flag — a warning sign in someone's conduct, as opposed to a difference in
 * taste. Written as the "warning" corner of the red/green/beige set.
 *
 * Editorial notes for whoever touches this next:
 * - The three flag terms share one axis and must keep it: red and green are
 *   about CONDUCT (how someone treats you and treats other people), beige is
 *   about TEXTURE (who they are, with no bearing on treatment). Each file
 *   states that boundary in its own words; do not paste one into another.
 * - The brief was explicitly "useful rather than paranoid", so block 2 says out
 *   loud that the internet has inflated the term to cover ordinary human
 *   imperfection. Keep it. Removing it turns this page into the thing it is
 *   criticising.
 * - No statistics here. The one sourced figure available (78% burnout, Forbes
 *   Health / OnePoll 2024) is about app fatigue and has nothing to do with
 *   warning signs, so citing it here would have been decoration. Do not add a
 *   bare "studies show" to fill the gap.
 * - Block 7 is NOT a product pitch. It is the opposite: it states plainly that
 *   Qulo has no identity checks and no photo screening, because a page about
 *   spotting danger is the exact place a reader might assume an app is doing
 *   that work for them. Of the four terms written in this batch only green-flag
 *   ends on a Qulo connection.
 * - Deliberately no clinical vocabulary (narcissist, gaslighting, abuser). These
 *   are descriptions of behaviour; the reader is being helped to notice, not to
 *   diagnose. The "uncomfortable vs unsafe" split in block 7 carries the safety
 *   point without a diagnosis.
 * - Term names: de/fr/pt/it/nl/sv keep the English loanword because that is what
 *   people actually say there; es/pl/ru/tr/ar/hi/ja/ko use the native form with
 *   the English one mentioned in the body. zh uses 危险信号 — 红旗 in Chinese is
 *   a positive/patriotic image and would read as the opposite of the term.
 */
export const redFlag: LocalizedGlossaryEntry = {
  en: {
    term: "Red flag",
    summary:
      "A warning sign in how someone behaves — a pattern in the way they treat you and treat other people, serious enough to tell you something about the future, not just a habit you happen to dislike.",
    blocks: [
      { type: "h2", text: "Where the phrase comes from" },
      { type: "p", text: "A red flag on a beach, a railway line or a race track means the same thing everywhere: stop, something here can hurt you. The phrase moved into therapy rooms, then into ordinary conversation, and by the late 2010s it had become the internet's favourite shorthand for anything off-putting in a date. It caught on because it does something genuinely useful — it turns a slow, vague feeling into two words you can say out loud to a friend." },
      { type: "p", text: "Then it inflated. Comment threads now hand out red flags for lowercase texting, an empty bookshelf, an unmade bed, still living with parents. None of that predicts anything. Everyone carries habits somebody else would find odd, and anyone you are drawn to will have some. The signs that earn the word are about conduct: how you are treated, and how people who can do nothing for them are treated." },
      { type: "h2", text: "How to tell a warning from a difference" },
      { type: "ul", items: [
        "**A pattern, not a moment:** one bad evening is a bad evening; the same behaviour for the third time is information",
        "**How they treat people who cannot help them:** waiters, delivery drivers, their own family, an ex they have nothing left to gain from",
        "**What happens when you say no:** a small boundary is the cheapest test there is, and sulking, negotiating or punishing is a complete answer",
        "**Who is at fault in their stories:** if every ex was crazy, every boss unfair and every friend disloyal, you are hearing about the one person present in all of it",
      ] },
      { type: "h2", accent: "green", text: "What to do when you see one" },
      { type: "p", text: "Say it to yourself in plain words first — not \"he's toxic\", but \"he goes quiet for two days whenever I disagree with him\". The plain version is the one you can check, and it is the one you can say to them. Say it once and watch what happens next. Someone who can take responsibility does it quickly and without a performance. Someone who cannot will have you apologising within a minute. You are collecting information, not building a case." },
      { type: "p", text: "Keep two things separate: uncomfortable and unsafe. Some signs are worth a conversation, some are worth leaving without one, and you never owe anybody proof. Do not hand the judgement to an app either. Qulo has no identity checks and no photo screening; getting your questions right shows someone read what you wrote, nothing more." },
    ],
  },

  tr: {
    term: "Kırmızı bayrak",
    summary:
      "Birinin davranışındaki uyarı işareti: sana ve çevresindekilere nasıl davrandığına dair, geleceğe dair fikir veren bir örüntü — hoşuna gitmeyen sıradan bir alışkanlık değil.",
    blocks: [
      { type: "h2", text: "Bu söz nereden geliyor?" },
      { type: "p", text: "Sahildeki, demiryolundaki ya da yarış pistindeki kırmızı bayrak hep aynı şeyi söyler: dur, burada canın yanabilir. Söz önce terapi diline, sonra günlük konuşmaya geçti; 2010'ların sonunda internetin bir insanda rahatsız edici bulduğu her şey için kullandığı kısayol oldu. İngilizce hâliyle \"red flag\" olarak da dolaşıyor. Tutmasının sebebi basit: yavaş yavaş biriken belirsiz bir hissi, arkadaşına söyleyebileceğin iki kelimeye çeviriyor." },
      { type: "p", text: "Sonra enflasyona uğradı. Bugün küçük harfle mesaj atmak, evinde kitaplık olmaması, ailesiyle yaşamak bile kırmızı bayrak sayılıyor. Bunların hiçbiri bir şey öngörmüyor. Herkesin bir başkasına tuhaf gelecek alışkanlıkları var; hoşlandığın insanın da olacak. Bu sözü hak eden işaretler davranışla ilgilidir: sana nasıl davrandığı ve kendisine hiçbir faydası olmayacak insanlara nasıl davrandığı." },
      { type: "h2", text: "Uyarı mı, sadece farklılık mı?" },
      { type: "ul", items: [
        "**Tek an değil, örüntü:** kötü bir akşam kötü bir akşamdır; aynı davranışın üçüncü tekrarı bilgidir",
        "**Kendisine faydası olmayanlara davranışı:** garson, kurye, kendi ailesi, artık bir beklentisi kalmadığı bir eski sevgili",
        "**\"Hayır\" dediğinde olanlar:** küçük bir sınır en ucuz testtir; küsmek, pazarlık etmek ya da cezalandırmak eksiksiz bir cevaptır",
        "**Anlattığı hikâyelerde suçlu kim:** bütün eskileri deli, bütün patronları haksız, bütün arkadaşları vefasızsa hepsinde ortak olan tek kişiyi dinliyorsun",
      ] },
      { type: "h2", accent: "green", text: "Gördüğünde ne yapmalı?" },
      { type: "p", text: "Önce kendine sade bir dille söyle: \"toksik biri\" değil, \"ona katılmadığım her seferinde iki gün susuyor\". Sade hâli hem kontrol edebileceğin hem de karşına geçip söyleyebileceğin hâldir. Bir kez söyle ve sonrasını izle. Sorumluluk alabilen biri bunu hızlıca ve gösteri yapmadan yapar; alamayan biri bir dakika içinde özür dileyeni sen yapar. Dosya hazırlamıyorsun, bilgi topluyorsun." },
      { type: "p", text: "İki şeyi ayrı tut: rahatsız edici olan ve güvenli olmayan. Bazı işaretler bir konuşmayı hak eder, bazıları konuşmadan gitmeyi; kimseye kanıt borcun yok. Bu kararı bir uygulamaya da devretme. Qulo'da kimlik doğrulama ya da fotoğraf denetimi yok; birinin sorularını doğru bilmesi yalnızca yazdıklarını okuduğunu gösterir." },
    ],
  },

  de: {
    term: "Red Flag",
    summary:
      "Ein Warnsignal im Verhalten einer Person: ein Muster darin, wie sie dich und andere behandelt, und keine Marotte, die dir zufällig nicht gefällt.",
    blocks: [
      { type: "h2", text: "Woher der Begriff kommt" },
      { type: "p", text: "Eine rote Flagge am Strand, an der Bahnstrecke oder an der Rennstrecke bedeutet überall dasselbe: Halt, hier kann dir etwas passieren. Der Begriff wanderte erst in die Therapiesprache, dann in den Alltag, und Ende der 2010er war er die liebste Abkürzung des Internets für alles, was an einem Date stört. Er hat sich durchgesetzt, weil er etwas leistet: Er macht aus einem langsamen, diffusen Gefühl zwei Wörter, die man aussprechen kann." },
      { type: "p", text: "Dann kam die Inflation. In Kommentarspalten wird heute alles zur Red Flag: Nachrichten in Kleinbuchstaben, kein Bücherregal, das Wohnen bei den Eltern. Nichts davon sagt irgendetwas voraus. Jeder Mensch hat Gewohnheiten, die andere seltsam finden, und die Person, die dir gefällt, hat auch welche. Die Zeichen, die das Wort verdienen, betreffen das Verhalten: wie du behandelt wirst und wie Menschen behandelt werden, die nichts für sie tun können." },
      { type: "h2", text: "Warnung oder einfach nur anders?" },
      { type: "ul", items: [
        "**Muster statt Moment:** ein schlechter Abend ist ein schlechter Abend; dasselbe Verhalten zum dritten Mal ist eine Information",
        "**Der Umgang mit Menschen, die nichts nützen:** Kellner, Lieferfahrer, die eigene Familie, ein Ex, von dem nichts mehr zu holen ist",
        "**Was passiert, wenn du Nein sagst:** eine kleine Grenze ist der billigste Test, den es gibt, und Schmollen, Verhandeln oder Bestrafen ist eine vollständige Antwort",
        "**Wer in den Geschichten schuld ist:** wenn jede Ex verrückt war, jeder Chef ungerecht und jede Freundschaft verraten wurde, hörst du von der einen Person, die überall dabei war",
      ] },
      { type: "h2", accent: "green", text: "Was du tun kannst, wenn du eine siehst" },
      { type: "p", text: "Sag es dir zuerst schlicht: nicht \"er ist toxisch\", sondern \"er schweigt zwei Tage, wenn ich ihm widerspreche\". Die schlichte Version kannst du überprüfen, und du kannst sie ihm auch sagen. Sag sie einmal und sieh, was danach passiert. Wer Verantwortung übernehmen kann, tut es schnell und ohne Inszenierung. Wer es nicht kann, bringt dich innerhalb einer Minute dazu, dich zu entschuldigen. Du sammelst Informationen, du baust keine Anklage." },
      { type: "p", text: "Halte zwei Dinge auseinander: unangenehm und unsicher. Manches verdient ein Gespräch, manches verdient, dass du ohne Gespräch gehst — Beweise schuldest du niemandem. Und gib die Einschätzung nicht an eine App ab. Qulo prüft keine Ausweise und kontrolliert keine Fotos; wer deine Fragen richtig beantwortet, hat gelesen, was du geschrieben hast, mehr nicht." },
    ],
  },

  fr: {
    term: "Red flag",
    summary:
      "Un signal d'alarme dans le comportement de quelqu'un : une manière récurrente de te traiter, et de traiter les autres, qui en dit long sur la suite — pas une simple manie qui t'agace.",
    blocks: [
      { type: "h2", text: "D'où vient l'expression" },
      { type: "p", text: "Un drapeau rouge sur une plage, le long d'une voie ferrée ou sur un circuit dit toujours la même chose : arrête-toi, ici tu peux te faire mal. L'expression est passée par le vocabulaire de la thérapie, puis par la conversation ordinaire, et à la fin des années 2010 elle est devenue le raccourci préféré d'internet pour tout ce qui dérange chez quelqu'un. Elle a pris parce qu'elle transforme une impression lente et floue en deux mots qu'on peut dire à voix haute." },
      { type: "p", text: "Puis elle s'est diluée. On voit désormais des red flags partout : écrire sans majuscules, ne pas avoir de livres chez soi, vivre encore chez ses parents. Rien de tout cela ne prédit quoi que ce soit. Chacun a des habitudes qui paraîtront bizarres à quelqu'un d'autre, et la personne qui te plaît en aura aussi. Les signes qui méritent le mot concernent la conduite : la façon dont on te traite, et la façon dont sont traités ceux qui ne peuvent rien apporter." },
      { type: "h2", text: "Alerte ou simple différence ?" },
      { type: "ul", items: [
        "**Un motif, pas un moment :** une mauvaise soirée reste une mauvaise soirée ; le même comportement pour la troisième fois est une information",
        "**Sa façon de traiter ceux qui ne lui servent à rien :** serveurs, livreurs, sa propre famille, un ex dont il n'attend plus rien",
        "**Ce qui arrive quand tu dis non :** une petite limite est le test le moins cher qui existe, et bouder, négocier ou punir est une réponse complète",
        "**Qui est fautif dans ses histoires :** si toutes les ex étaient folles, tous les patrons injustes et tous les amis déloyaux, tu entends parler de la seule personne présente partout",
      ] },
      { type: "h2", accent: "green", text: "Que faire quand tu en repères un" },
      { type: "p", text: "Formule-le d'abord simplement, pour toi : pas \"il est toxique\", mais \"il ne me parle plus pendant deux jours dès que je ne suis pas d'accord\". La version simple est vérifiable, et c'est aussi celle que tu peux lui dire. Dis-la une fois, puis regarde la suite. Quelqu'un capable d'assumer le fait vite et sans mise en scène. Quelqu'un qui en est incapable te fera t'excuser en une minute. Tu récoltes des informations, tu ne montes pas un dossier." },
      { type: "p", text: "Garde deux choses distinctes : ce qui met mal à l'aise et ce qui met en danger. Certains signaux méritent une conversation, d'autres méritent que tu partes sans en avoir une, et tu ne dois de preuve à personne. Ne délègue pas non plus ce jugement à une application. Qulo ne vérifie pas les identités et ne contrôle pas les photos : répondre juste à tes questions prouve seulement qu'on a lu ce que tu as écrit." },
    ],
  },

  es: {
    term: "Bandera roja",
    summary:
      "Una señal de advertencia en la conducta de alguien: un patrón en cómo te trata a ti y a los demás, no una manía suya que simplemente no te gusta.",
    blocks: [
      { type: "h2", text: "De dónde viene la expresión" },
      { type: "p", text: "Una bandera roja en una playa, en una vía de tren o en un circuito dice siempre lo mismo: para, aquí puedes hacerte daño. La expresión pasó por el lenguaje de la terapia, luego por la conversación cotidiana, y a finales de los 2010 se convirtió en el atajo favorito de internet — en inglés, red flag — para todo lo que incomoda de una cita. Funcionó porque convierte una sensación lenta y difusa en dos palabras que puedes decir en voz alta." },
      { type: "p", text: "Después se infló. Hoy se reparten banderas rojas por escribir sin mayúsculas, por no tener libros en casa, por seguir viviendo con los padres. Nada de eso predice nada. Todo el mundo tiene costumbres que a otra persona le parecerán raras, y quien te gusta también las tendrá. Las señales que merecen la palabra hablan de conducta: cómo te trata a ti y cómo trata a quien no puede darle nada." },
      { type: "h2", text: "¿Advertencia o simple diferencia?" },
      { type: "ul", items: [
        "**Un patrón, no un momento:** una mala noche es una mala noche; el mismo comportamiento por tercera vez es información",
        "**Cómo trata a quien no le sirve de nada:** camareros, repartidores, su propia familia, un ex del que ya no espera nada",
        "**Qué pasa cuando dices que no:** un límite pequeño es la prueba más barata que existe, y el enfado, la negociación o el castigo son una respuesta completa",
        "**De quién es la culpa en sus historias:** si todas las ex estaban locas, todos los jefes eran injustos y todos los amigos desleales, estás oyendo hablar de la única persona que aparece en todas",
      ] },
      { type: "h2", accent: "green", text: "Qué hacer cuando la ves" },
      { type: "p", text: "Dilo primero en palabras llanas, para ti: no \"es tóxico\", sino \"se calla dos días cada vez que no estoy de acuerdo\". La versión llana es la que puedes comprobar y también la que puedes decirle. Dila una vez y mira qué pasa después. Quien sabe hacerse cargo lo hace rápido y sin escena. Quien no sabe te tendrá pidiendo perdón en un minuto. Estás reuniendo información, no montando un caso." },
      { type: "p", text: "Separa dos cosas: lo incómodo y lo inseguro. Hay señales que merecen una conversación y otras que merecen que te vayas sin tenerla; no le debes pruebas a nadie. Y no le encargues ese criterio a una aplicación. Qulo no verifica identidades ni revisa fotos; acertar tus preguntas solo demuestra que alguien leyó lo que escribiste." },
    ],
  },

  ar: {
    term: "علم أحمر",
    summary:
      "علامة تحذير في سلوك الشخص: نمط في طريقة معاملته لك وللآخرين يخبرك بشيء عمّا هو قادم، لا مجرد عادة لا تعجبك.",
    blocks: [
      { type: "h2", text: "من أين جاء التعبير" },
      { type: "p", text: "العلم الأحمر على الشاطئ أو عند سكة الحديد أو في حلبة السباق يقول الشيء نفسه دائمًا: قف، هنا ما قد يؤذيك. انتقل التعبير إلى لغة العلاج النفسي ثم إلى الكلام اليومي، وفي أواخر العقد الثاني من الألفية صار الاختصار المفضّل على الإنترنت — بالإنجليزية red flag — لكل ما يزعجك في شخص تواعده. انتشر لأنه يحوّل إحساسًا بطيئًا غامضًا إلى كلمتين يمكنك قولهما بصوت مسموع." },
      { type: "p", text: "ثم تضخّم المعنى. صار الناس يمنحون علمًا أحمر لمن يكتب رسائله بحروف صغيرة، أو لا توجد كتب في بيته، أو ما زال يسكن مع أهله. لا شيء من هذا يتنبأ بشيء. لكل إنسان عادات يجدها غيره غريبة، ومن يعجبك سيكون له نصيبه منها. العلامات التي تستحق الكلمة تتعلق بالسلوك: كيف يعاملك، وكيف يعامل من لا يستطيع أن يقدّم له شيئًا." },
      { type: "h2", text: "تحذير أم مجرد اختلاف؟" },
      { type: "ul", items: [
        "**نمط لا لحظة:** ليلة سيئة تبقى ليلة سيئة، أما تكرار السلوك للمرة الثالثة فهو معلومة",
        "**كيف يعامل من لا نفع له فيه:** النادل، وعامل التوصيل، وأهله، وشريك سابق لم يعد ينتظر منه شيئًا",
        "**ماذا يحدث حين تقول لا:** حدّ صغير أرخص اختبار موجود، والعتب أو المساومة أو العقاب جواب كامل",
        "**من المذنب في حكاياته:** إذا كانت كل شريكة سابقة مجنونة وكل مدير ظالمًا وكل صديق غادرًا، فأنت تسمع عن الشخص الوحيد الموجود في كل الحكايات",
      ] },
      { type: "h2", accent: "green", text: "ماذا تفعل حين ترى واحدة" },
      { type: "p", text: "قلها لنفسك بكلمات بسيطة أولًا: ليس \"إنه سام\"، بل \"يصمت يومين كلما اختلفت معه\". الصيغة البسيطة هي التي يمكنك التحقق منها، وهي أيضًا التي يمكنك قولها له. قلها مرة واحدة ثم راقب ما يحدث بعدها. من يستطيع تحمّل المسؤولية يفعلها بسرعة وبلا استعراض، ومن لا يستطيع سيجعلك تعتذر خلال دقيقة. أنت تجمع معلومات، لا تبني قضية." },
      { type: "p", text: "افصل بين أمرين: ما يزعجك وما يعرّضك للخطر. بعض العلامات تستحق حوارًا، وبعضها يستحق أن ترحل دون حوار، ولا تدين لأحد بإثبات. ولا تترك هذا الحكم لتطبيق. لا يوجد في Qulo تحقّق من الهوية ولا فحص للصور؛ ومن يجيب عن أسئلتك إجابة صحيحة يكون قد قرأ ما كتبته، لا أكثر." },
    ],
  },

  ru: {
    term: "Красный флаг",
    summary:
      "Тревожный знак в поведении человека: повторяющийся способ обращаться с вами и с окружающими, который говорит о будущем, а не просто привычка, которая вам не по душе.",
    blocks: [
      { type: "h2", text: "Откуда взялось выражение" },
      { type: "p", text: "Красный флаг на пляже, у железной дороги или на гоночной трассе означает одно и то же: стой, здесь можно пострадать. Выражение попало сначала в язык психотерапии, потом в обычную речь, а к концу 2010-х стало любимым сокращением интернета — по-английски red flag — для всего, что настораживает в человеке. Оно прижилось, потому что превращает медленное неясное чувство в два слова, которые можно произнести вслух." },
      { type: "p", text: "Потом смысл размылся. Сегодня красный флаг раздают за сообщения без заглавных букв, за отсутствие книг дома, за то, что человек живёт с родителями. Ничего из этого ничего не предсказывает. У каждого есть привычки, которые кому-то покажутся странными, и у того, кто вам нравится, они тоже найдутся. Знаки, заслуживающие этого слова, касаются поведения: как обращаются с вами и как — с теми, кто ничем не может быть полезен." },
      { type: "h2", text: "Предупреждение или просто непохожесть?" },
      { type: "ul", items: [
        "**Не эпизод, а закономерность:** плохой вечер — это плохой вечер, а третий раз одного и того же поведения — уже информация",
        "**Как он ведёт себя с теми, кто ему не нужен:** официант, курьер, собственная семья, бывшая, от которой уже ничего не надо",
        "**Что происходит, когда вы говорите нет:** маленькая граница — самая дешёвая проверка, а обида, торг или наказание — исчерпывающий ответ",
        "**Кто виноват в его историях:** если все бывшие сумасшедшие, все начальники несправедливы, а все друзья предали, вы слышите о единственном человеке, который был во всех этих историях",
      ] },
      { type: "h2", accent: "green", text: "Что делать, если увидели" },
      { type: "p", text: "Сначала скажите это себе простыми словами: не \"он токсичный\", а \"он молчит два дня каждый раз, когда я с ним не соглашаюсь\". Простую версию можно проверить, и её же можно произнести вслух при нём. Скажите один раз и посмотрите, что будет дальше. Тот, кто умеет брать ответственность, делает это быстро и без спектакля. Тот, кто не умеет, через минуту заставит извиняться вас. Вы собираете информацию, а не готовите обвинение." },
      { type: "p", text: "Разделяйте две вещи: неприятно и небезопасно. Одни знаки заслуживают разговора, другие — того, чтобы уйти без него, и доказательства вы никому не должны. И не перекладывайте это решение на приложение. В Qulo нет проверки документов и модерации фотографий: правильные ответы на ваши вопросы означают только, что человек прочитал написанное вами." },
    ],
  },

  pt: {
    term: "Red flag",
    summary:
      "Um sinal de alerta no comportamento de alguém: um padrão na forma como trata você e as outras pessoas, e não uma mania qualquer que por acaso te incomoda.",
    blocks: [
      { type: "h2", text: "De onde vem a expressão" },
      { type: "p", text: "Uma bandeira vermelha na praia, na linha do trem ou na pista de corrida diz sempre a mesma coisa: pare, aqui dá para se machucar. A expressão passou pelo vocabulário da terapia, depois pela conversa comum, e no fim dos anos 2010 virou o atalho preferido da internet para tudo o que incomoda em alguém. Pegou porque transforma uma sensação lenta e vaga em duas palavras que dá para dizer em voz alta." },
      { type: "p", text: "Depois inflacionou. Hoje se distribui red flag para quem escreve tudo em minúscula, não tem livros em casa ou ainda mora com os pais. Nada disso prevê coisa alguma. Todo mundo tem hábitos que outra pessoa acharia estranhos, e quem te interessa também terá os seus. Os sinais que merecem a palavra são sobre conduta: como você é tratado e como são tratadas as pessoas que não podem fazer nada por ele." },
      { type: "h2", text: "Alerta ou só diferença?" },
      { type: "ul", items: [
        "**Padrão, não momento:** uma noite ruim é uma noite ruim; o mesmo comportamento pela terceira vez é informação",
        "**Como trata quem não lhe serve para nada:** garçom, entregador, a própria família, um ex de quem não espera mais nada",
        "**O que acontece quando você diz não:** um limite pequeno é o teste mais barato que existe, e emburrar, negociar ou punir é uma resposta completa",
        "**De quem é a culpa nas histórias dele:** se todas as ex eram loucas, todos os chefes injustos e todos os amigos desleais, você está ouvindo sobre a única pessoa presente em todas elas",
      ] },
      { type: "h2", accent: "green", text: "O que fazer quando aparece uma" },
      { type: "p", text: "Primeiro diga a si mesmo em palavras simples: não \"ele é tóxico\", e sim \"ele fica dois dias sem falar comigo sempre que discordo dele\". A versão simples é a que dá para verificar e também a que dá para dizer na cara dele. Diga uma vez e observe o que vem depois. Quem consegue assumir responsabilidade faz isso rápido e sem encenação. Quem não consegue deixa você pedindo desculpa em um minuto. Você está juntando informação, não montando um processo." },
      { type: "p", text: "Separe duas coisas: desconfortável e inseguro. Alguns sinais merecem uma conversa, outros merecem que você vá embora sem ela — e você não deve prova a ninguém. E não terceirize esse julgamento para um aplicativo. O Qulo não verifica identidade nem revisa fotos; acertar as suas perguntas só mostra que a pessoa leu o que você escreveu." },
    ],
  },

  it: {
    term: "Red flag",
    summary:
      "Un segnale d'allarme nel comportamento di qualcuno: uno schema nel modo in cui tratta te e tratta gli altri, non una fissazione qualsiasi che ti dà fastidio.",
    blocks: [
      { type: "h2", text: "Da dove arriva l'espressione" },
      { type: "p", text: "Una bandiera rossa in spiaggia, lungo i binari o in pista dice sempre la stessa cosa: fermati, qui puoi farti male. L'espressione è passata dal linguaggio della terapia a quello di tutti i giorni e, verso la fine degli anni Dieci, è diventata la scorciatoia preferita di internet per tutto ciò che disturba in una persona. Ha funzionato perché trasforma una sensazione lenta e confusa in due parole che puoi dire ad alta voce." },
      { type: "p", text: "Poi si è svalutata. Oggi si assegnano red flag a chi scrive tutto in minuscolo, non ha libri in casa, vive ancora con i genitori. Niente di tutto questo prevede qualcosa. Ognuno ha abitudini che a un altro sembrerebbero strane, e anche la persona che ti piace ne avrà. I segnali che meritano la parola riguardano la condotta: come vieni trattato tu e come vengono trattati quelli che non possono dargli nulla." },
      { type: "h2", text: "Allarme o semplice differenza?" },
      { type: "ul", items: [
        "**Uno schema, non un momento:** una brutta serata è una brutta serata; lo stesso comportamento per la terza volta è un'informazione",
        "**Come tratta chi non gli serve:** camerieri, fattorini, la sua famiglia, un ex da cui non ha più niente da ottenere",
        "**Cosa succede quando dici di no:** un piccolo limite è la prova più economica che esista, e il muso, la trattativa o la punizione sono una risposta completa",
        "**Di chi è la colpa nelle sue storie:** se tutte le ex erano pazze, tutti i capi ingiusti e tutti gli amici sleali, stai sentendo parlare dell'unica persona presente in ognuna",
      ] },
      { type: "h2", accent: "green", text: "Cosa fare quando ne vedi una" },
      { type: "p", text: "Prima dillo a te stesso in parole semplici: non \"è tossico\", ma \"sta zitto due giorni ogni volta che non sono d'accordo\". La versione semplice è quella che puoi verificare ed è anche quella che puoi dirgli in faccia. Dilla una volta e guarda cosa succede dopo. Chi sa prendersi la responsabilità lo fa in fretta e senza scene. Chi non ne è capace ti farà chiedere scusa nel giro di un minuto. Stai raccogliendo informazioni, non costruendo un processo." },
      { type: "p", text: "Tieni separate due cose: a disagio e non al sicuro. Alcuni segnali meritano una conversazione, altri meritano che tu te ne vada senza farla, e non devi prove a nessuno. E non delegare questo giudizio a un'app. Qulo non verifica documenti e non controlla le foto: rispondere bene alle tue domande dimostra solo che qualcuno ha letto ciò che hai scritto." },
    ],
  },

  ja: {
    term: "レッドフラッグ",
    summary:
      "相手のふるまいに出る危険信号。あなたや周りの人への接し方に繰り返し現れるもので、たまたま自分の好みに合わない癖のことではありません。",
    blocks: [
      { type: "h2", text: "この言葉の来歴" },
      { type: "p", text: "浜辺でも線路脇でもサーキットでも、赤い旗の意味は同じです。止まれ、ここには危ないものがある。この言い方はまず心理療法の言葉になり、やがて日常会話に移り、2010年代の終わりには「相手の気になるところ」全般を指すネット上の定番になりました。日本語の「危険信号」に近い言葉です。広まった理由は単純で、ゆっくり積もっていく曖昧な違和感を、友達に口で言える二語に変えてくれるからです。" },
      { type: "p", text: "そのあと意味が薄まりました。今では小文字だけで返信する、家に本棚がない、実家暮らしといったことまでレッドフラッグ扱いされます。どれも先のことを何も予測しません。誰にでも、他人から見れば変わった癖があります。気になっている相手にもきっとあります。この言葉に値するのは行動のほうです。あなたへの接し方と、自分に何の得もない相手への接し方。" },
      { type: "h2", text: "警告なのか、ただの違いなのか" },
      { type: "ul", items: [
        "**一回ではなく繰り返し:** ひどい夜は、ひどい夜。同じことが三度目なら、それは情報です",
        "**得にならない相手への態度:** 店員、配達員、自分の家族、もう何も期待していない元恋人",
        "**あなたが断ったときに起きること:** 小さな線を引くのがいちばん安上がりな確認で、拗ねる・交渉する・罰するのは十分な答えです",
        "**話の中で誰が悪者か:** 元恋人は全員おかしくて、上司は全員理不尽で、友達は全員裏切ったのなら、そのすべてに共通する一人の話を聞いていることになります",
      ] },
      { type: "h2", accent: "green", text: "気づいたらどうするか" },
      { type: "p", text: "まず自分に、飾らない言い方で言ってみてください。「あの人は毒だ」ではなく「意見が合わないと二日黙る」。飾らない言い方なら確かめられるし、そのまま本人にも言えます。一度だけ言って、そのあとを見ます。責任を引き受けられる人は、演出なしにすぐ引き受けます。できない人は一分で、あなたのほうに謝らせます。あなたは情報を集めているだけで、告発の準備をしているのではありません。" },
      { type: "p", text: "「不快」と「危険」は分けてください。話し合う価値のある印もあれば、話し合わずに離れていい印もあります。誰にも証拠を示す義務はありません。そしてこの判断をアプリに任せないこと。Quloに本人確認も写真の審査もありません。質問に全問正解する人は、あなたの書いたものを読んだというだけです。" },
    ],
  },

  ko: {
    term: "레드 플래그",
    summary:
      "상대의 행동에서 드러나는 경고 신호. 당신과 주변 사람을 대하는 방식에서 반복되는 패턴이며, 그저 취향에 맞지 않는 습관과는 다릅니다.",
    blocks: [
      { type: "h2", text: "이 말은 어디서 왔나" },
      { type: "p", text: "해변이든 철길이든 경주 트랙이든 붉은 깃발의 뜻은 같습니다. 멈춰라, 여기서는 다칠 수 있다. 이 표현은 심리 상담의 언어를 거쳐 일상 대화로 넘어왔고, 2010년대 후반에는 상대에게서 거슬리는 모든 것을 가리키는 인터넷 유행어가 되었습니다. 우리말로는 위험 신호에 가깝습니다. 오래 쌓인 모호한 느낌을 입 밖으로 낼 수 있는 한마디로 바꿔주기 때문에 널리 퍼졌습니다." },
      { type: "p", text: "그다음에는 의미가 헐거워졌습니다. 요즘은 메시지를 소문자로만 쓴다, 집에 책이 없다, 아직 부모님과 산다는 것까지 레드 플래그로 불립니다. 그중 무엇도 앞일을 알려주지 않습니다. 누구에게나 남이 보면 이상한 습관이 있고, 당신이 좋아하는 사람에게도 있습니다. 이 단어를 붙일 만한 신호는 행동에 관한 것입니다. 당신을 대하는 방식, 그리고 자기에게 아무 도움도 되지 않는 사람을 대하는 방식." },
      { type: "h2", text: "경고인가, 그냥 다른 것인가" },
      { type: "ul", items: [
        "**한 순간이 아니라 반복:** 나쁜 저녁은 나쁜 저녁일 뿐이지만, 같은 행동이 세 번째면 그것은 정보입니다",
        "**득 될 게 없는 사람을 대하는 태도:** 종업원, 배달 기사, 자기 가족, 더 바랄 것이 없는 옛 연인",
        "**당신이 거절했을 때 벌어지는 일:** 작은 선을 하나 긋는 것이 가장 싼 시험이고, 삐치거나 협상하거나 벌주는 반응이면 답은 이미 나온 것입니다",
        "**이야기 속에서 누가 잘못했는지:** 옛 연인은 모두 이상하고 상사는 모두 부당하고 친구는 모두 배신했다면, 그 모든 이야기에 공통으로 등장하는 한 사람의 이야기를 듣고 있는 것입니다",
      ] },
      { type: "h2", accent: "green", text: "발견했다면 무엇을 할까" },
      { type: "p", text: "먼저 자신에게 담백한 말로 말해보세요. \"저 사람은 독이야\"가 아니라 \"의견이 다르면 이틀 동안 말을 안 해\". 담백한 문장은 확인할 수도 있고 본인에게 그대로 말할 수도 있습니다. 한 번 말하고 그다음을 보세요. 책임질 줄 아는 사람은 빠르게, 연기 없이 책임집니다. 그러지 못하는 사람은 1분 안에 당신이 사과하게 만듭니다. 당신은 정보를 모으는 중이지 고발장을 쓰는 중이 아닙니다." },
      { type: "p", text: "불편한 것과 안전하지 않은 것은 구분하세요. 대화할 가치가 있는 신호가 있고, 대화 없이 떠나도 되는 신호가 있습니다. 누구에게도 증거를 보일 의무는 없습니다. 그리고 이 판단을 앱에 맡기지 마세요. Qulo에는 신분 확인도 사진 심사도 없습니다. 질문을 다 맞혔다는 것은 당신이 쓴 글을 읽었다는 뜻일 뿐입니다." },
    ],
  },

  zh: {
    term: "危险信号",
    summary:
      "对方行为里的警告：他对待你、对待旁人的固定方式，能说明以后会怎样，而不是你恰好看不惯的某个小毛病。",
    blocks: [
      { type: "h2", text: "这个说法从哪来" },
      { type: "p", text: "海滩上、铁道边、赛道上的红旗，意思都一样：停下，这里会伤到人。这个说法先进入心理咨询的语言，再进入日常对话，到二〇一〇年代末，已经成了网上形容约会对象哪里让人不舒服的万能词，英文叫 red flag。它之所以流行，是因为它把一种缓慢又模糊的感觉，变成了一句能说出口的话。" },
      { type: "p", text: "后来它被用滥了。现在有人因为对方发消息不打标点、家里没有书、还和父母同住，就说这是危险信号。这些都预测不了什么。每个人都有别人看来奇怪的习惯，你喜欢的那个人也会有。真正配得上这个词的是行为本身：他怎么对你，以及他怎么对那些帮不上他忙的人。" },
      { type: "h2", text: "是警告，还是只是不一样" },
      { type: "ul", items: [
        "**看重复，不看一次：**一个糟糕的晚上只是一个糟糕的晚上；同样的行为第三次出现，就是信息",
        "**他怎么对帮不上忙的人：**服务员、外卖员、自己的家人、早已无所求的前任",
        "**你拒绝时会发生什么：**划一条小小的界线是最便宜的测试，赌气、讨价还价或惩罚都是完整的回答",
        "**他的故事里谁有错：**如果前任全是疯子、上司全不讲理、朋友全都背叛，你听到的是所有故事里唯一共同的那个人",
      ] },
      { type: "h2", accent: "green", text: "看到了该怎么办" },
      { type: "p", text: "先用最平实的话对自己说一遍：不是“他很有毒”，而是“我一不同意，他就两天不说话”。平实的说法可以验证，也可以当面说给他听。说一次，然后看接下来发生什么。能承担责任的人做得又快又不做戏；做不到的人，一分钟内就会让道歉的人变成你。你在收集信息，不是在准备起诉。" },
      { type: "p", text: "把两件事分开：不舒服，和不安全。有些信号值得谈一次，有些值得你不谈就走，你不欠任何人证据。也别把这个判断交给应用。Qulo 没有身份验证，也不审核照片；有人答对你的问题，只说明他读了你写的东西。" },
    ],
  },

  nl: {
    term: "Red flag",
    summary:
      "Een waarschuwingssignaal in iemands gedrag: een patroon in hoe diegene jou en anderen behandelt, en niet zomaar een eigenaardigheid die jou toevallig niet ligt.",
    blocks: [
      { type: "h2", text: "Waar de uitdrukking vandaan komt" },
      { type: "p", text: "Een rode vlag op het strand, langs het spoor of op een circuit betekent overal hetzelfde: stop, hier kun je gewond raken. De uitdrukking belandde eerst in therapietaal, daarna in gewone gesprekken, en tegen het eind van de jaren tien was het de favoriete afkorting van het internet voor alles wat stoort aan een date. Ze sloeg aan omdat ze een traag, vaag gevoel verandert in twee woorden die je hardop kunt zeggen." },
      { type: "p", text: "Daarna raakte het begrip uitgehold. Tegenwoordig krijgt iemand een red flag voor berichten zonder hoofdletters, voor een huis zonder boeken, voor nog thuis wonen. Niets daarvan voorspelt iets. Iedereen heeft gewoontes die een ander raar vindt, en degene op wie jij valt heeft ze ook. De signalen die het woord verdienen gaan over gedrag: hoe jij behandeld wordt, en hoe mensen behandeld worden die niets voor diegene kunnen betekenen." },
      { type: "h2", text: "Waarschuwing of gewoon anders?" },
      { type: "ul", items: [
        "**Een patroon, geen moment:** een slechte avond is een slechte avond; hetzelfde gedrag voor de derde keer is informatie",
        "**Hoe iemand omgaat met wie niets oplevert:** de ober, de bezorger, de eigen familie, een ex bij wie niets meer te halen valt",
        "**Wat er gebeurt als je nee zegt:** een kleine grens is de goedkoopste test die er is, en mokken, onderhandelen of straffen is een compleet antwoord",
        "**Wie er schuld heeft in de verhalen:** als elke ex gek was, elke baas onredelijk en elke vriend onbetrouwbaar, hoor je over de enige persoon die in al die verhalen voorkwam",
      ] },
      { type: "h2", accent: "green", text: "Wat je doet als je er een ziet" },
      { type: "p", text: "Zeg het eerst in gewone woorden tegen jezelf: niet \"hij is toxisch\", maar \"hij zwijgt twee dagen zodra ik het niet met hem eens ben\". De gewone versie kun je nagaan, en die kun je ook tegen hem uitspreken. Zeg het één keer en kijk wat er daarna gebeurt. Wie verantwoordelijkheid kan nemen doet dat snel en zonder vertoon. Wie dat niet kan, laat jou binnen een minuut sorry zeggen. Je verzamelt informatie, je bouwt geen dossier." },
      { type: "p", text: "Houd twee dingen uit elkaar: ongemakkelijk en onveilig. Sommige signalen verdienen een gesprek, andere verdienen dat je zonder gesprek vertrekt, en bewijs ben je niemand schuldig. Laat dat oordeel ook niet over aan een app. Qulo controleert geen identiteiten en keurt geen foto's; wie jouw vragen goed beantwoordt, heeft gelezen wat je schreef, meer niet." },
    ],
  },

  pl: {
    term: "Czerwona flaga",
    summary:
      "Sygnał ostrzegawczy w czyimś zachowaniu: powtarzalny sposób traktowania ciebie i innych ludzi, a nie dziwactwo, które akurat ci nie odpowiada.",
    blocks: [
      { type: "h2", text: "Skąd wzięło się to określenie" },
      { type: "p", text: "Czerwona flaga na plaży, przy torach czy na torze wyścigowym znaczy zawsze to samo: zatrzymaj się, tutaj można zrobić sobie krzywdę. Określenie trafiło najpierw do języka terapii, potem do zwykłych rozmów, a pod koniec lat dziesiątych stało się ulubionym skrótem internetu — po angielsku red flag — na wszystko, co w kimś przeszkadza. Przyjęło się, bo zamienia powolne, mgliste przeczucie w dwa słowa, które można powiedzieć na głos." },
      { type: "p", text: "Potem się zdewaluowało. Dziś czerwoną flagę dostaje się za pisanie bez wielkich liter, za brak książek w domu, za mieszkanie z rodzicami. Nic z tego niczego nie zapowiada. Każdy ma nawyki, które komuś innemu wydadzą się dziwne, i osoba, która ci się podoba, też je ma. Znaki warte tego słowa dotyczą postępowania: tego, jak traktuje ciebie, i tego, jak traktuje ludzi, którzy nic mu nie dadzą." },
      { type: "h2", text: "Ostrzeżenie czy po prostu inność?" },
      { type: "ul", items: [
        "**Wzorzec, nie chwila:** zły wieczór to zły wieczór; to samo zachowanie po raz trzeci to już informacja",
        "**Jak traktuje tych, którzy mu się nie przydadzą:** kelnera, kuriera, własną rodzinę, byłą, od której już niczego nie chce",
        "**Co się dzieje, kiedy mówisz nie:** mała granica to najtańszy test, jaki istnieje, a dąsy, negocjacje albo kara to pełna odpowiedź",
        "**Kto zawinił w jego opowieściach:** jeśli każda była partnerka była szalona, każdy szef niesprawiedliwy, a każdy przyjaciel nielojalny, słuchasz o jedynej osobie obecnej w każdej z tych historii",
      ] },
      { type: "h2", accent: "green", text: "Co zrobić, kiedy ją zobaczysz" },
      { type: "p", text: "Najpierw powiedz to sobie prosto: nie \"jest toksyczny\", tylko \"milczy przez dwa dni za każdym razem, gdy się z nim nie zgadzam\". Prostą wersję da się sprawdzić i da się ją powiedzieć jemu prosto w twarz. Powiedz raz i zobacz, co będzie dalej. Ktoś, kto potrafi wziąć odpowiedzialność, robi to szybko i bez przedstawienia. Ktoś, kto nie potrafi, w minutę doprowadzi do tego, że to ty przepraszasz. Zbierasz informacje, nie budujesz aktu oskarżenia." },
      { type: "p", text: "Rozdziel dwie rzeczy: niewygodne i niebezpieczne. Niektóre sygnały zasługują na rozmowę, inne na to, żeby wyjść bez niej — nikomu nie musisz niczego udowadniać. I nie oddawaj tej oceny aplikacji. Qulo nie weryfikuje tożsamości ani nie sprawdza zdjęć; poprawne odpowiedzi na twoje pytania znaczą tylko tyle, że ktoś przeczytał twój tekst." },
    ],
  },

  sv: {
    term: "Red flag",
    summary:
      "Ett varningstecken i någons beteende: ett mönster i hur personen behandlar dig och andra, inte en vana som du råkar tycka är irriterande.",
    blocks: [
      { type: "h2", text: "Var uttrycket kommer ifrån" },
      { type: "p", text: "En röd flagga på stranden, vid spåret eller på banan betyder alltid samma sak: stanna, här kan du skada dig. Uttrycket gick först in i terapispråket, sedan i vanliga samtal, och i slutet av 2010-talet hade det blivit internets favoritgenväg för allt som skaver hos en dejt. Det slog igenom för att det gör en långsam, otydlig känsla till två ord som du faktiskt kan säga högt." },
      { type: "p", text: "Sedan urholkades det. I dag delas red flags ut för meddelanden utan stor bokstav, för en bokhylla utan böcker, för att någon fortfarande bor hemma. Inget av det förutsäger något. Alla har vanor som någon annan tycker är konstiga, och personen du är förtjust i har också sina. Tecknen som förtjänar ordet handlar om uppförande: hur du blir behandlad, och hur de behandlas som inte kan ge personen någonting." },
      { type: "h2", text: "Varning eller bara olikhet?" },
      { type: "ul", items: [
        "**Ett mönster, inte ett tillfälle:** en dålig kväll är en dålig kväll; samma beteende för tredje gången är information",
        "**Hur personen behandlar dem som inte är till nytta:** servitören, budet, sin egen familj, ett ex som inte har något kvar att ge",
        "**Vad som händer när du säger nej:** en liten gräns är det billigaste testet som finns, och tjurighet, förhandling eller bestraffning är ett fullständigt svar",
        "**Vem som har fel i berättelserna:** om varje ex var galet, varje chef orättvis och varje vän illojal hör du om den enda person som var med överallt",
      ] },
      { type: "h2", accent: "green", text: "Vad du gör när du ser en" },
      { type: "p", text: "Säg det först i enkla ord till dig själv: inte \"han är toxisk\", utan \"han tystnar i två dagar varje gång jag inte håller med\". Den enkla versionen går att kontrollera, och den går också att säga rakt ut till honom. Säg den en gång och se vad som händer sedan. Den som kan ta ansvar gör det snabbt och utan uppvisning. Den som inte kan får dig att be om ursäkt inom en minut. Du samlar information, du bygger inte ett åtal." },
      { type: "p", text: "Håll isär två saker: obekvämt och osäkert. Vissa tecken förtjänar ett samtal, andra förtjänar att du går utan ett, och du är ingen skyldig bevis. Lämna inte heller den bedömningen till en app. Qulo har ingen identitetskontroll och ingen bildgranskning; att någon svarar rätt på dina frågor visar bara att personen läst det du skrivit." },
    ],
  },

  hi: {
    term: "रेड फ्लैग",
    summary:
      "किसी के व्यवहार में दिखने वाला चेतावनी संकेत: वह आपके साथ और दूसरों के साथ कैसा बर्ताव करता है, इसका दोहराया जाने वाला पैटर्न — कोई ऐसी आदत नहीं जो बस आपको पसंद न हो।",
    blocks: [
      { type: "h2", text: "यह शब्द आया कहाँ से" },
      { type: "p", text: "समुद्र तट पर, रेल की पटरी के पास या रेसिंग ट्रैक पर लाल झंडे का मतलब एक ही होता है: रुको, यहाँ चोट लग सकती है। यह मुहावरा पहले थेरेपी की भाषा में आया, फिर रोज़मर्रा की बातचीत में, और 2010 के दशक के आख़िर तक इंटरनेट पर किसी में भी खटकने वाली हर बात के लिए इस्तेमाल होने लगा। हिंदी में इसे चेतावनी संकेत कहेंगे। यह इसलिए चला कि धीरे-धीरे बनी एक धुँधली बेचैनी को दो शब्दों में कह देने लायक बना देता है।" },
      { type: "p", text: "फिर इसका मतलब पतला पड़ गया। आज छोटे अक्षरों में मैसेज करने, घर में किताबें न होने या माता-पिता के साथ रहने तक को रेड फ्लैग कह दिया जाता है। इनमें से कोई बात आगे का कुछ नहीं बताती। हर इंसान की कुछ आदतें किसी और को अजीब लगेंगी, और जो आपको पसंद है उसकी भी होंगी। जो संकेत इस शब्द के लायक हैं, वे बर्ताव से जुड़े हैं: वह आपके साथ कैसा है, और उन लोगों के साथ कैसा है जिनसे उसे कुछ नहीं मिलना।" },
      { type: "h2", text: "चेतावनी है या बस फ़र्क़?" },
      { type: "ul", items: [
        "**एक पल नहीं, पैटर्न देखिए:** एक बुरी शाम बस एक बुरी शाम है; वही व्यवहार तीसरी बार दिखे तो वह जानकारी है",
        "**जिनसे कोई फ़ायदा नहीं, उनके साथ बर्ताव:** वेटर, डिलीवरी वाला, अपना परिवार, वह पूर्व साथी जिससे अब कुछ नहीं चाहिए",
        "**आपके मना करने पर क्या होता है:** एक छोटी-सी सीमा सबसे सस्ती जाँच है, और रूठना, मोलभाव करना या सज़ा देना पूरा जवाब है",
        "**उसकी कहानियों में ग़लती किसकी है:** अगर हर पूर्व साथी पागल था, हर बॉस नाइंसाफ़ और हर दोस्त बेवफ़ा, तो आप उस एक इंसान के बारे में सुन रहे हैं जो हर कहानी में मौजूद था",
      ] },
      { type: "h2", accent: "green", text: "दिखे तो क्या करें" },
      { type: "p", text: "पहले ख़ुद से सीधी भाषा में कहिए: \"वह टॉक्सिक है\" नहीं, बल्कि \"मेरी असहमति पर वह दो दिन बात नहीं करता\"। सीधी बात ही जाँची जा सकती है और वही सामने कही भी जा सकती है। एक बार कहिए और फिर देखिए कि आगे क्या होता है। जो ज़िम्मेदारी ले सकता है, वह जल्दी और बिना नाटक के लेता है। जो नहीं ले सकता, वह एक मिनट में माफ़ी आपसे मँगवा लेगा। आप जानकारी जुटा रहे हैं, मुक़दमा नहीं बना रहे।" },
      { type: "p", text: "दो चीज़ों को अलग रखिए: असहज होना और असुरक्षित होना। कुछ संकेत बातचीत के लायक हैं, कुछ इस लायक कि आप बिना बात किए चले जाएँ — किसी को सबूत देना आपकी ज़िम्मेदारी नहीं। और यह फ़ैसला किसी ऐप पर मत छोड़िए। Qulo में न पहचान की जाँच है, न तस्वीरों की; कोई आपके सवालों के सही जवाब दे दे तो इसका मतलब सिर्फ़ इतना है कि उसने आपका लिखा पढ़ा है।" },
    ],
  },
};
