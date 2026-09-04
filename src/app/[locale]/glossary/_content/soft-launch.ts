import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Soft launch — hinting at a new relationship on social media without revealing
 * who it is.
 *
 * Judgement calls made here, so a later editor does not undo them by accident:
 *
 * - No social platform is named anywhere, in any locale. The competitor rule in
 *   the authoring spec covers dating apps, but naming a specific network would
 *   date the page the moment habits move, so the copy stays at "social media",
 *   "the account", "the feed". Please keep it that way.
 * - The page refuses to rule on what a soft launch means about someone. The
 *   honest reading is that it is evidence of a feeling and not a statement of
 *   status, and block 7 says exactly that: the same photo reads as "I am proud
 *   of this" to one person and "I am being kept off the record" to the other,
 *   and only a conversation settles which. Turning "they soft launched you"
 *   into a red flag would be a diagnosis, which rule 7 forbids.
 * - Block 2 covers the hard launch (face in frame, tagged, named) as the
 *   contrast rather than as a goal. Never hard launching is framed as a habit
 *   about visibility online, not as a verdict on the relationship.
 * - No statistics: nothing sourced exists on how common soft launching is, so
 *   nothing is claimed. No Qulo angle either — this is a social-media behaviour
 *   that has nothing to do with how anyone matched, and block 7 is a reader
 *   takeaway instead.
 *
 * Term names: the English loanword is what people say in tr, de, fr, es, pt,
 * it, nl, pl and sv, and ja/ko/ru/hi take the standard transliteration. The
 * exceptions are ar, which gets the descriptive "الإعلان الخفي" with the English
 * in the summary, and zh, where the everyday pair is 官宣 (hard launch) and
 * 半官宣 (soft launch) — using those makes the whole contrast in block 2 land
 * naturally, so do not replace them with a transliteration.
 */
export const softLaunch: LocalizedGlossaryEntry = {
  en: {
    term: "Soft launch",
    summary:
      "Hinting at a new relationship on social media without showing who it is — a hand in the frame, a second coffee cup, a shadow on the wall — so people know something is happening but not with whom.",
    blocks: [
      { type: "h2", text: "Why people soft launch" },
      {
        type: "p",
        text: "Posting a new person is a public commitment with a public cost if it ends. The soft launch splits the difference: you get to say something without putting anyone on display. A cropped hand, a second cup on the table, a sleeve at the edge of the picture. Two reasons usually sit behind it. Privacy — from colleagues, family, an ex, a group chat. And an exit that costs nothing: if it ends, there is nothing to delete and nobody to explain it to.",
      },
      {
        type: "p",
        text: "A hard launch is the opposite move: the face in the frame, tagged, named, no ambiguity left. It usually comes later, if it comes at all. Some people skip straight to it. Others never post anyone, ever — that is a habit about being visible online, not a verdict on the relationship.",
      },
      { type: "h2", text: "How to read one" },
      {
        type: "ul",
        items: [
          "The crop is a choice. Including a face is the easiest thing in the world.",
          "Who it went out to: close friends only, or the whole account.",
          "Whether it is the first one, or the fifth thing to stop at this stage.",
          "Whether they told you before posting, or you found out by scrolling.",
        ],
      },
      { type: "h2", text: "If you are the one in the photo", accent: "green" },
      {
        type: "p",
        text: "Two people can read the same picture in opposite directions. One means \"I am happy about this and I wanted to say something\". The other reads \"I am being kept off the record\". The cheap fix is to say which one it is. Ask before you post someone's hand — almost everyone says yes, and the part they remember is that you asked. And if you would rather not be posted at all, say so early.",
      },
      {
        type: "p",
        text: "A soft launch is evidence of a feeling, not a statement of status. It tells you someone is pleased and cautious at the same time, which is most people at the start of something. If you are trying to work out where you stand, the account will not tell you — the conversation you are avoiding by studying it would.",
      },
    ],
  },

  tr: {
    term: "Soft launch",
    summary:
      "Yeni bir ilişkiyi sosyal medyada kimi olduğunu göstermeden ima etmek: kadraja giren bir el, ikinci bir kahve fincanı, duvardaki bir gölge. Bir şey olduğu bellidir, kiminle olduğu değil.",
    blocks: [
      { type: "h2", text: "İnsanlar bunu neden yapıyor" },
      {
        type: "p",
        text: "Yeni birini paylaşmak alenî bir taahhüttür; bittiğinde bedeli de alenî olur. Soft launch ikisinin ortasını bulur: kimseyi ortaya sermeden bir şey söylemiş olursun. Kırpılmış bir el, masadaki ikinci fincan, karenin kenarında bir kol. Arkasında genelde iki sebep vardır. Mahremiyet — iş arkadaşlarından, aileden, eski sevgiliden, grup sohbetinden. Bir de bedelsiz bir çıkış: biterse silinecek bir şey, açıklama yapılacak bir kimse olmaz.",
      },
      {
        type: "p",
        text: "Hard launch bunun tam tersi: yüz kadrajda, etiketli, adıyla, hiçbir belirsizlik bırakmadan. Genelde daha sonra gelir, gelirse. Kimisi doğrudan oradan başlar. Kimisi de hiçbir zaman kimseyi paylaşmaz — bu, internette görünmeye dair bir alışkanlıktır, ilişki hakkında bir hüküm değil.",
      },
      { type: "h2", text: "Böyle bir paylaşım nasıl okunur" },
      {
        type: "ul",
        items: [
          "Kırpma bir tercih. Bir yüzü kadraja almak dünyanın en kolay işi.",
          "Kime gösterildiği: sadece yakın arkadaşlara mı, tüm hesaba mı.",
          "İlki mi, yoksa bu aşamada duran beşinci ilişki mi.",
          "Paylaşmadan önce sana söylemiş mi, yoksa akışta mı gördün.",
        ],
      },
      { type: "h2", text: "Fotoğraftaki kişi sensen", accent: "green" },
      {
        type: "p",
        text: "İki kişi aynı kareyi taban tabana zıt okuyabilir. Biri \"buna sevindim ve bir şey söylemek istedim\" der. Diğeri \"kayıt dışı tutuluyorum\" diye okur. Ucuz çözüm, hangisi olduğunu söylemek. Birinin elini paylaşmadan önce sor; çoğu kişi olur der ve akılda kalan zaten sorman olur. Hiç paylaşılmak istemiyorsan bunu erken söyle.",
      },
      {
        type: "p",
        text: "Soft launch bir duygunun kanıtıdır, bir statü beyanı değil. Sana birinin aynı anda hem mutlu hem temkinli olduğunu söyler — yani bir şeyin başındaki çoğu insanı. Nerede durduğunu anlamaya çalışıyorsan hesap sana bunu söylemez; onu inceleyerek ertelediğin konuşma söylerdi.",
      },
    ],
  },

  de: {
    term: "Soft Launch",
    summary:
      "Eine neue Beziehung in den sozialen Medien andeuten, ohne zu zeigen, um wen es geht — eine Hand im Bild, eine zweite Tasse, ein Schatten an der Wand. Man sieht, dass etwas läuft, aber nicht mit wem.",
    blocks: [
      { type: "h2", text: "Warum Menschen soft launchen" },
      {
        type: "p",
        text: "Eine neue Person zu posten ist ein öffentliches Bekenntnis mit öffentlichen Kosten, falls es endet. Der Soft Launch teilt die Differenz: Man sagt etwas, ohne jemanden auszustellen. Eine angeschnittene Hand, eine zweite Tasse auf dem Tisch, ein Ärmel am Bildrand. Meist stehen zwei Gründe dahinter. Privatsphäre — vor Kolleginnen, Familie, einer Ex, einem Gruppenchat. Und ein Ausstieg, der nichts kostet: Endet es, gibt es nichts zu löschen und niemandem etwas zu erklären.",
      },
      {
        type: "p",
        text: "Der Hard Launch ist die Gegenbewegung: das Gesicht im Bild, markiert, benannt, keine Unklarheit mehr. Er kommt meist später, wenn überhaupt. Manche überspringen den Zwischenschritt. Andere posten nie jemanden — das ist eine Gewohnheit im Umgang mit Sichtbarkeit, kein Urteil über die Beziehung.",
      },
      { type: "h2", text: "Wie man so einen Post liest" },
      {
        type: "ul",
        items: [
          "Der Bildausschnitt ist eine Entscheidung. Ein Gesicht mitzunehmen wäre das Einfachste der Welt.",
          "Wer ihn sehen durfte: nur enge Freunde oder der ganze Account.",
          "Ob es der erste ist oder die fünfte Sache, die in diesem Stadium stehen bleibt.",
          "Ob du es vorher erfahren hast oder es beim Scrollen entdeckt hast.",
        ],
      },
      { type: "h2", text: "Wenn du die Person auf dem Bild bist", accent: "green" },
      {
        type: "p",
        text: "Zwei Menschen können dasselbe Foto genau gegensätzlich lesen. Für die eine heißt es: \"Ich freue mich und wollte etwas sagen.\" Der andere liest: \"Ich werde nicht aktenkundig.\" Die billige Lösung ist zu sagen, was gemeint war. Frag, bevor du die Hand von jemandem postest — fast alle sagen ja, und gemerkt wird sich das Fragen. Und wenn du gar nicht gepostet werden willst, sag es früh.",
      },
      {
        type: "p",
        text: "Ein Soft Launch ist ein Hinweis auf ein Gefühl, keine Statusmeldung. Er zeigt, dass jemand gleichzeitig froh und vorsichtig ist — also fast jeder am Anfang. Wenn du wissen willst, woran du bist, sagt es dir der Account nicht: Das Gespräch, das du beim Betrachten vermeidest, würde es sagen.",
      },
    ],
  },

  fr: {
    term: "Soft launch",
    summary:
      "Laisser deviner une nouvelle histoire sur les réseaux sans montrer de qui il s'agit : une main dans le cadre, une deuxième tasse, une ombre sur le mur. On voit qu'il se passe quelque chose, pas avec qui.",
    blocks: [
      { type: "h2", text: "Pourquoi on fait un soft launch" },
      {
        type: "p",
        text: "Publier quelqu'un, c'est un engagement public qui coûte publiquement si ça s'arrête. Le soft launch coupe la poire en deux : on dit quelque chose sans exposer personne. Une main coupée par le cadre, une deuxième tasse sur la table, une manche au bord de l'image. Deux raisons reviennent. La vie privée — collègues, famille, un ex, une boucle de messages. Et une sortie gratuite : si ça s'arrête, rien à supprimer et personne à qui s'expliquer.",
      },
      {
        type: "p",
        text: "Le hard launch est le mouvement inverse : le visage dans le cadre, identifié, nommé, plus aucune ambiguïté. Il vient en général plus tard, quand il vient. Certains sautent directement l'étape. D'autres ne publient jamais personne — c'est une habitude vis-à-vis de la visibilité en ligne, pas un verdict sur la relation.",
      },
      { type: "h2", text: "Comment le lire" },
      {
        type: "ul",
        items: [
          "Le cadrage est un choix. Rien de plus simple que d'inclure un visage.",
          "À qui c'était destiné : les amis proches seulement, ou tout le compte.",
          "Si c'est le premier, ou la cinquième histoire à rester à ce stade.",
          "S'il ou elle vous a prévenu avant de publier, ou si vous l'avez découvert en faisant défiler.",
        ],
      },
      { type: "h2", text: "Si c'est vous sur la photo", accent: "green" },
      {
        type: "p",
        text: "Deux personnes peuvent lire la même image de façon exactement opposée. L'une dit : \"je suis contente et j'avais envie de le dire\". L'autre comprend : \"on me garde hors dossier\". La solution la moins chère est de préciser laquelle des deux. Demandez avant de publier la main de quelqu'un ; la plupart disent oui, et c'est le fait d'avoir demandé qui reste. Et si vous préférez ne pas être publié du tout, dites-le tôt.",
      },
      {
        type: "p",
        text: "Un soft launch témoigne d'un sentiment, il n'annonce pas un statut. Il indique que quelqu'un est à la fois content et prudent — c'est-à-dire presque tout le monde au début. Si vous cherchez à savoir où vous en êtes, le compte ne vous le dira pas : la conversation que vous évitez en l'étudiant, si.",
      },
    ],
  },

  es: {
    term: "Soft launch",
    summary:
      "Insinuar una relación nueva en redes sin enseñar de quién se trata: una mano en el encuadre, una segunda taza, una sombra en la pared. Se nota que pasa algo, pero no con quién.",
    blocks: [
      { type: "h2", text: "Por qué se hace" },
      {
        type: "p",
        text: "Publicar a alguien nuevo es un compromiso público con un coste público si se acaba. El soft launch parte la diferencia: dices algo sin exponer a nadie. Una mano cortada por el encuadre, una segunda taza en la mesa, una manga al borde de la foto. Detrás suele haber dos razones. Privacidad — de los compañeros de trabajo, de la familia, de un ex, de un grupo. Y una salida gratis: si se acaba, no hay nada que borrar ni nadie a quien dar explicaciones.",
      },
      {
        type: "p",
        text: "El hard launch es el movimiento contrario: la cara en el encuadre, etiquetada, con nombre, sin ambigüedad. Suele llegar después, si llega. Hay quien se salta el paso intermedio. Y hay quien no publica nunca a nadie — eso es un hábito sobre cómo se está en internet, no un veredicto sobre la relación.",
      },
      { type: "h2", text: "Cómo se lee" },
      {
        type: "ul",
        items: [
          "El encuadre es una decisión. Incluir una cara es lo más fácil del mundo.",
          "A quién iba dirigido: solo a amigos cercanos o a toda la cuenta.",
          "Si es el primero o la quinta historia que se queda en esta fase.",
          "Si te avisó antes de publicarlo o te enteraste bajando por el feed.",
        ],
      },
      { type: "h2", text: "Si la de la foto eres tú", accent: "green" },
      {
        type: "p",
        text: "Dos personas pueden leer la misma imagen de forma opuesta. Una quiere decir \"estoy contenta y quería contar algo\". La otra entiende \"me están dejando fuera del registro\". La solución barata es decir cuál de las dos es. Pregunta antes de publicar la mano de alguien; casi todo el mundo dice que sí, y lo que se recuerda es que preguntaste. Y si prefieres no aparecer, dilo pronto.",
      },
      {
        type: "p",
        text: "Un soft launch es la señal de un sentimiento, no una declaración de estado. Te dice que alguien está contento y prudente a la vez, que es como está casi todo el mundo al principio. Si intentas averiguar en qué punto estáis, la cuenta no te lo va a decir: la conversación que evitas mientras la miras, sí.",
      },
    ],
  },

  ar: {
    term: "الإعلان الخفي",
    summary:
      "التلميح إلى علاقة جديدة على مواقع التواصل دون كشف صاحبها: يد في الإطار، فنجان ثانٍ، ظلّ على الحائط. يعرف الناس أن شيئًا ما يحدث، لا مع من. تُعرف بالإنجليزية بـ soft launch.",
    blocks: [
      { type: "h2", text: "لماذا يفعل الناس ذلك" },
      {
        type: "p",
        text: "نشر شخص جديد التزام علني، وثمنه علني أيضًا إن انتهى الأمر. الإعلان الخفي يقسم المسافة: تقول شيئًا دون أن تعرض أحدًا. يد مقصوصة عند حافة الصورة، فنجان ثانٍ على الطاولة، كُمّ في الزاوية. وراء ذلك سببان في الغالب. الخصوصية — من الزملاء، من العائلة، من علاقة سابقة، من مجموعة محادثة. وباب خروج بلا تكلفة: إن انتهى، فلا صورة تُحذف ولا أحد يُشرح له.",
      },
      {
        type: "p",
        text: "الإعلان الصريح هو الحركة المعاكسة: الوجه في الصورة، والإشارة إلى الحساب، والاسم، ولا يبقى أي غموض. يأتي عادة لاحقًا، إن أتى. بعض الناس يقفزون إليه مباشرة. وبعضهم لا ينشر أحدًا أبدًا — وتلك عادة تتعلق بالظهور على الإنترنت، لا حكمًا على العلاقة.",
      },
      { type: "h2", text: "كيف تقرأ منشورًا كهذا" },
      {
        type: "ul",
        items: [
          "القصّ اختيار. إدخال الوجه في الصورة هو أسهل شيء في الدنيا.",
          "لمن نُشر: للأصدقاء المقرّبين فقط أم للحساب كله.",
          "أهو الأول، أم الخامس الذي يتوقف عند هذه المرحلة.",
          "هل أخبرك قبل النشر، أم عرفت وأنت تتصفّح.",
        ],
      },
      { type: "h2", text: "إن كنت أنت من في الصورة", accent: "green" },
      {
        type: "p",
        text: "يمكن لشخصين أن يقرآ الصورة نفسها قراءتين متعاكستين تمامًا. أحدهما يقصد «أنا سعيد وأردت أن أقول شيئًا»، والآخر يقرأ «يُبقونني خارج السجل». الحل الرخيص أن تقول أيّ المعنيين هو. اسأل قبل أن تنشر يد أحدهم؛ معظم الناس يوافقون، والذي يبقى في الذاكرة هو أنك سألت. وإن كنت تفضّل ألا تُنشر أصلًا، فقل ذلك مبكرًا.",
      },
      {
        type: "p",
        text: "الإعلان الخفي دليل على شعور، لا بيان عن حالة. يقول لك إن أحدهم سعيد وحذر في الوقت نفسه، وهذا حال معظم الناس في البداية. وإن كنت تحاول أن تعرف موقعك، فالحساب لن يخبرك: المحادثة التي تؤجّلها بينما تدقّق فيه هي التي كانت ستخبرك.",
      },
    ],
  },

  ru: {
    term: "Софт-лонч",
    summary:
      "Намёк на новые отношения в соцсетях без показа человека: рука в кадре, вторая чашка кофе, тень на стене. Видно, что что-то происходит, но не видно, с кем.",
    blocks: [
      { type: "h2", text: "Зачем так делают" },
      {
        type: "p",
        text: "Выложить нового человека — публичное обязательство, у которого будет публичная цена, если всё закончится. Софт-лонч делит разницу пополам: вы что-то говорите, никого при этом не выставляя. Обрезанная рука, вторая чашка на столе, рукав у края кадра. За этим обычно стоят две причины. Приватность — от коллег, семьи, бывшего, общего чата. И выход, который ничего не стоит: если закончится, нечего удалять и некому объяснять.",
      },
      {
        type: "p",
        text: "Хард-лонч — противоположный шаг: лицо в кадре, отметка, имя, никакой недосказанности. Он обычно приходит позже, если приходит вообще. Кто-то сразу начинает с него. А кто-то не выкладывает никого и никогда — это привычка в отношении публичности, а не приговор отношениям.",
      },
      { type: "h2", text: "Как это читать" },
      {
        type: "ul",
        items: [
          "Кадрирование — это выбор. Включить в кадр лицо проще всего на свете.",
          "Кому это показали: только близким друзьям или всему аккаунту.",
          "Первый ли это раз или пятая история, застрявшая на этой стадии.",
          "Сказали ли вам заранее, или вы узнали, листая ленту.",
        ],
      },
      { type: "h2", text: "Если на фото вы", accent: "green" },
      {
        type: "p",
        text: "Двое могут прочитать один и тот же кадр прямо противоположно. Один вкладывает: «мне хорошо, и хотелось об этом сказать». Другой читает: «меня держат вне протокола». Дешёвое решение — сказать, что именно имелось в виду. Спрашивайте, прежде чем выложить чью-то руку: почти все соглашаются, а запоминается именно то, что вы спросили. И если вам вообще не хочется появляться в чужой ленте, скажите это сразу.",
      },
      {
        type: "p",
        text: "Софт-лонч — свидетельство чувства, а не заявление о статусе. Он говорит, что человеку одновременно радостно и тревожно-осторожно, то есть примерно как почти всем в начале. Если вы пытаетесь понять, где вы находитесь, лента не ответит: ответил бы тот разговор, который вы откладываете, разглядывая её.",
      },
    ],
  },

  pt: {
    term: "Soft launch",
    summary:
      "Insinuar um relacionamento novo nas redes sem mostrar quem é: uma mão no enquadramento, uma segunda xícara, uma sombra na parede. Dá para ver que algo está acontecendo, mas não com quem.",
    blocks: [
      { type: "h2", text: "Por que as pessoas fazem isso" },
      {
        type: "p",
        text: "Postar alguém novo é um compromisso público com um custo público se acabar. O soft launch divide a diferença: você diz alguma coisa sem expor ninguém. Uma mão cortada pela moldura, uma segunda xícara na mesa, uma manga na beirada da foto. Costumam existir dois motivos. Privacidade — de colegas, da família, de um ex, de um grupo. E uma saída que não custa nada: se acabar, não há o que apagar nem a quem explicar.",
      },
      {
        type: "p",
        text: "O hard launch é o movimento contrário: o rosto no enquadramento, marcado, com nome, sem ambiguidade nenhuma. Costuma vir depois, quando vem. Tem gente que pula direto para ele. E tem gente que nunca posta ninguém — isso é um hábito sobre estar exposto na internet, não um veredicto sobre a relação.",
      },
      { type: "h2", text: "Como ler um" },
      {
        type: "ul",
        items: [
          "O corte é uma escolha. Incluir um rosto é a coisa mais fácil do mundo.",
          "Para quem foi publicado: só para amigos próximos ou para a conta inteira.",
          "Se é o primeiro ou a quinta história que fica parada nesse estágio.",
          "Se avisaram você antes de postar ou se você descobriu rolando o feed.",
        ],
      },
      { type: "h2", text: "Se quem está na foto é você", accent: "green" },
      {
        type: "p",
        text: "Duas pessoas podem ler a mesma imagem de formas opostas. Uma quer dizer \"estou feliz e queria falar alguma coisa\". A outra entende \"estão me deixando fora do registro\". A solução barata é dizer qual das duas é. Pergunte antes de postar a mão de alguém; quase todo mundo diz sim, e o que fica é o fato de você ter perguntado. E se prefere não aparecer, diga isso cedo.",
      },
      {
        type: "p",
        text: "Um soft launch é sinal de um sentimento, não uma declaração de status. Ele diz que alguém está feliz e cauteloso ao mesmo tempo, que é como quase todo mundo está no começo. Se você está tentando entender em que pé estão, a conta não vai contar: quem contaria é a conversa que você evita enquanto estuda o perfil.",
      },
    ],
  },

  it: {
    term: "Soft launch",
    summary:
      "Far intuire una relazione nuova sui social senza mostrare chi sia: una mano nell'inquadratura, una seconda tazza, un'ombra sul muro. Si capisce che c'è qualcosa, non con chi.",
    blocks: [
      { type: "h2", text: "Perché lo si fa" },
      {
        type: "p",
        text: "Pubblicare una persona nuova è un impegno pubblico, con un costo pubblico se finisce. Il soft launch divide la differenza: dici qualcosa senza esporre nessuno. Una mano tagliata dall'inquadratura, una seconda tazza sul tavolo, una manica al bordo della foto. Dietro ci sono di solito due ragioni. La privacy — dai colleghi, dalla famiglia, da un ex, da una chat di gruppo. E un'uscita che non costa niente: se finisce, non c'è nulla da cancellare e nessuno a cui spiegare.",
      },
      {
        type: "p",
        text: "L'hard launch è il movimento opposto: il viso nell'inquadratura, taggato, con il nome, senza più ambiguità. Di solito arriva dopo, se arriva. C'è chi salta direttamente a quello. E c'è chi non pubblica mai nessuno — è un'abitudine su come si sta online, non un giudizio sulla relazione.",
      },
      { type: "h2", text: "Come si legge" },
      {
        type: "ul",
        items: [
          "L'inquadratura è una scelta. Includere un viso è la cosa più semplice del mondo.",
          "A chi è stata mostrata: solo agli amici stretti o a tutto il profilo.",
          "Se è il primo o la quinta storia che si ferma a questo stadio.",
          "Se te l'ha detto prima di pubblicare o l'hai scoperto scorrendo.",
        ],
      },
      { type: "h2", text: "Se nella foto ci sei tu", accent: "green" },
      {
        type: "p",
        text: "Due persone possono leggere la stessa immagine in modo opposto. Una vuole dire \"sono contenta e avevo voglia di dirlo\". L'altra legge \"mi tengono fuori dai registri\". La soluzione più economica è dire quale delle due sia. Chiedi prima di pubblicare la mano di qualcuno: quasi tutti dicono di sì, e quello che resta è che hai chiesto. E se preferisci non comparire affatto, dillo presto.",
      },
      {
        type: "p",
        text: "Un soft launch è la traccia di un sentimento, non una dichiarazione di stato. Dice che qualcuno è contento e prudente insieme, cioè come quasi tutti all'inizio. Se stai cercando di capire a che punto siete, il profilo non te lo dirà: te lo direbbe la conversazione che stai evitando mentre lo studi.",
      },
    ],
  },

  ja: {
    term: "ソフトローンチ",
    summary:
      "新しい関係を、相手が誰かは見せないままSNSでほのめかすこと。写り込んだ手、二つ目のカップ、壁の影。何かが起きていることは伝わるが、誰とかは伝わらない。",
    blocks: [
      { type: "h2", text: "なぜソフトローンチをするのか" },
      {
        type: "p",
        text: "新しい相手を投稿するのは公開の約束で、終わったときの代償も公開されます。ソフトローンチはその中間を取ります。誰も差し出さずに、何かを言うことができる。切れた手、テーブルの二つ目のカップ、画面の端の袖。理由はたいてい二つです。ひとつはプライバシー。同僚、家族、元恋人、グループチャットから距離を取るため。もうひとつは、費用のかからない出口です。終わっても、消すものも、説明する相手もいない。",
      },
      {
        type: "p",
        text: "ハードローンチは逆の動きです。顔が写り、タグがつき、名前が出て、曖昧さが残らない。たいていは後から来ますし、来ないこともあります。最初からそちらを選ぶ人もいます。そして誰のことも投稿しない人もいる。それはネット上での見え方の習慣であって、関係についての判定ではありません。",
      },
      { type: "h2", text: "どう読めばいいか" },
      {
        type: "ul",
        items: [
          "その切り取り方は選択です。顔を入れることほど簡単なことはありません。",
          "誰に向けた投稿か。親しい友人だけか、アカウント全体か。",
          "それが最初の一枚なのか、この段階で止まる五つ目なのか。",
          "投稿の前に伝えてくれたのか、あなたがスクロール中に見つけたのか。",
        ],
      },
      { type: "h2", text: "写っているのが自分だったら", accent: "green" },
      {
        type: "p",
        text: "同じ一枚でも、二人はまったく逆に読むことがあります。片方は「うれしいから何か言いたかった」。もう片方は「記録に残さないつもりなんだ」。安上がりな解決は、どちらなのかを言葉にすることです。誰かの手を投稿する前に一言聞いてください。たいていは「いいよ」と返ってきますし、相手の記憶に残るのは聞いてくれたという事実のほうです。そもそも写りたくないなら、早めに伝えてください。",
      },
      {
        type: "p",
        text: "ソフトローンチは気持ちの証拠であって、関係の宣言ではありません。うれしさと慎重さが同時にある、ということだけを伝えます。始まったばかりの人の多くがそうです。自分の立ち位置を知りたいなら、アカウントは答えてくれません。それを眺めることで先延ばしにしている会話が答えます。",
      },
    ],
  },

  ko: {
    term: "소프트 런칭",
    summary:
      "새 연애를 상대가 누구인지는 드러내지 않은 채 SNS에 넌지시 비추는 것. 프레임에 걸친 손, 두 번째 커피잔, 벽에 진 그림자. 뭔가 있다는 건 알겠는데 누구인지는 알 수 없다.",
    blocks: [
      { type: "h2", text: "왜 이렇게 올릴까" },
      {
        type: "p",
        text: "새로운 사람을 올리는 건 공개적인 약속이고, 끝났을 때의 대가도 공개됩니다. 소프트 런칭은 그 중간을 취합니다. 아무도 드러내지 않으면서 무언가를 말할 수 있으니까요. 잘린 손, 테이블 위 두 번째 잔, 화면 끄트머리의 소매. 보통 이유는 둘입니다. 하나는 사생활 — 동료, 가족, 전 연인, 단체 대화방으로부터. 다른 하나는 비용이 들지 않는 퇴로입니다. 끝나도 지울 것도, 설명할 사람도 없습니다.",
      },
      {
        type: "p",
        text: "하드 런칭은 반대 방향입니다. 얼굴이 프레임 안에 있고, 태그가 달리고, 이름이 나오고, 모호함이 남지 않습니다. 보통은 나중에 오고, 오지 않기도 합니다. 처음부터 그쪽으로 가는 사람도 있습니다. 그리고 누구도 올리지 않는 사람도 있습니다. 그건 온라인에서 어떻게 보일지에 대한 습관이지, 관계에 대한 판정이 아닙니다.",
      },
      { type: "h2", text: "이걸 어떻게 읽을까" },
      {
        type: "ul",
        items: [
          "그 구도는 선택이다. 얼굴을 넣는 것만큼 쉬운 일도 없다.",
          "누구에게 올렸는가. 친한 친구만인가, 계정 전체인가.",
          "첫 번째인가, 아니면 이 단계에서 멈춘 다섯 번째인가.",
          "올리기 전에 나에게 말했는가, 아니면 스크롤하다 알게 됐는가.",
        ],
      },
      { type: "h2", text: "사진 속 사람이 나라면", accent: "green" },
      {
        type: "p",
        text: "같은 사진을 두 사람이 정반대로 읽을 수 있습니다. 한쪽은 「기뻐서 뭔가 말하고 싶었어」입니다. 다른 쪽은 「나를 기록에 남기지 않는구나」로 읽습니다. 값싼 해법은 어느 쪽인지 말해 주는 것입니다. 누군가의 손을 올리기 전에 물어보세요. 대개는 그러라고 하고, 기억에 남는 건 물어봤다는 사실입니다. 아예 올라가고 싶지 않다면 일찍 말하세요.",
      },
      {
        type: "p",
        text: "소프트 런칭은 감정의 증거이지 상태의 선언이 아닙니다. 누군가가 기쁘면서 동시에 조심스럽다는 것을 알려 줄 뿐이고, 시작 무렵의 사람 대부분이 그렇습니다. 내가 어디쯤 있는지 알고 싶다면 계정은 답해 주지 않습니다. 그것을 들여다보며 미루고 있는 그 대화가 답해 줍니다.",
      },
    ],
  },

  zh: {
    term: "半官宣",
    summary:
      "在社交平台上暗示自己有了新的关系，却不露出对方是谁：入镜的一只手、第二个咖啡杯、墙上的影子。别人看得出有事发生，看不出和谁。英文里叫 soft launch。",
    blocks: [
      { type: "h2", text: "人们为什么这样发" },
      {
        type: "p",
        text: "把一个新的人发出来，是一次公开的承诺；万一结束，代价也是公开的。半官宣取了中间值：你说了点什么，却没有把任何人交出去。被裁掉的手、桌上第二个杯子、画面边缘的一截袖子。背后通常是两个理由。一是隐私——避开同事、家人、前任、某个群聊。二是一个不花代价的退路：如果结束了，没有什么要删，也没有人需要交代。",
      },
      {
        type: "p",
        text: "官宣是相反的动作：脸在画面里，标记了账号，说了名字，不留任何模糊。它通常来得更晚，也可能永远不来。有人直接跳到那一步。也有人从来不发任何人——那是关于自己在网上如何露面的习惯，不是对这段关系的判决。",
      },
      { type: "h2", text: "该怎么读这样一条" },
      {
        type: "ul",
        items: [
          "怎么裁的是一个选择。把脸放进画面是世上最容易的事。",
          "发给谁看：只给密友，还是整个账号。",
          "这是第一条，还是停在这个阶段的第五段关系。",
          "他有没有在发之前告诉你，还是你刷到才知道。",
        ],
      },
      { type: "h2", text: "如果照片里的人是你", accent: "green" },
      {
        type: "p",
        text: "同一张照片，两个人可能读出完全相反的意思。一个想说的是“我很开心，想说点什么”。另一个读到的是“我被留在记录之外”。最便宜的解决办法，是把意思说出来。要发别人的手之前先问一句；大多数人都会说好，而对方真正记住的是你问了。如果你根本不想出现在别人的动态里，早点讲。",
      },
      {
        type: "p",
        text: "半官宣是一种情绪的证据，不是一份关系声明。它只说明一个人同时是高兴的和谨慎的——刚开始的人大多如此。如果你想弄清楚自己在什么位置，账号不会告诉你；那场你一边翻动态一边在回避的对话才会。",
      },
    ],
  },

  nl: {
    term: "Soft launch",
    summary:
      "Een nieuwe relatie op sociale media aanstippen zonder te laten zien wie het is: een hand in beeld, een tweede kopje, een schaduw op de muur. Iedereen ziet dat er iets speelt, niet met wie.",
    blocks: [
      { type: "h2", text: "Waarom mensen soft launchen" },
      {
        type: "p",
        text: "Iemand nieuws posten is een openbare toezegging met openbare kosten als het misgaat. De soft launch splitst het verschil: je zegt iets zonder iemand tentoon te stellen. Een afgesneden hand, een tweede kopje op tafel, een mouw aan de rand van de foto. Er zitten meestal twee redenen achter. Privacy — voor collega's, familie, een ex, een groepsapp. En een uitgang die niets kost: als het eindigt, valt er niets te wissen en hoeft niemand iets uitgelegd te krijgen.",
      },
      {
        type: "p",
        text: "De hard launch is de omgekeerde beweging: het gezicht in beeld, getagd, met naam, geen twijfel meer mogelijk. Die komt meestal later, als hij komt. Sommigen slaan de tussenstap over. Anderen posten nooit iemand — dat is een gewoonte over zichtbaar zijn online, geen oordeel over de relatie.",
      },
      { type: "h2", text: "Hoe je er een leest" },
      {
        type: "ul",
        items: [
          "De uitsnede is een keuze. Een gezicht meenemen is het makkelijkste wat er is.",
          "Aan wie het geplaatst werd: alleen goede vrienden of het hele account.",
          "Of dit de eerste is of de vijfde die in dit stadium blijft steken.",
          "Of je het vooraf hoorde, of het al scrollend ontdekte.",
        ],
      },
      { type: "h2", text: "Als jij degene op de foto bent", accent: "green" },
      {
        type: "p",
        text: "Twee mensen kunnen dezelfde foto precies omgekeerd lezen. De een bedoelt: \"ik ben blij en wilde iets zeggen\". De ander leest: \"ik word buiten de boeken gehouden\". De goedkope oplossing is zeggen welke van de twee het is. Vraag het voordat je iemands hand post; bijna iedereen zegt ja, en wat bijblijft is dat je het vroeg. En als je liever helemaal niet gepost wordt: zeg dat vroeg.",
      },
      {
        type: "p",
        text: "Een soft launch is een aanwijzing voor een gevoel, geen statusmelding. Hij vertelt dat iemand tegelijk blij en voorzichtig is, en dat is bijna iedereen aan het begin. Wil je weten waar je staat, dan gaat het account het niet zeggen: het gesprek dat je vermijdt terwijl je ernaar kijkt wel.",
      },
    ],
  },

  pl: {
    term: "Soft launch",
    summary:
      "Zasugerowanie nowego związku w mediach społecznościowych bez pokazywania, o kogo chodzi: dłoń w kadrze, druga filiżanka, cień na ścianie. Widać, że coś się dzieje, ale nie z kim.",
    blocks: [
      { type: "h2", text: "Dlaczego ludzie tak robią" },
      {
        type: "p",
        text: "Wrzucenie nowej osoby to publiczna deklaracja, której koszt też jest publiczny, jeśli się skończy. Soft launch dzieli różnicę na pół: mówisz coś, nikogo nie wystawiając. Ucięta dłoń, druga filiżanka na stole, rękaw przy krawędzi zdjęcia. Zwykle stoją za tym dwa powody. Prywatność — przed współpracownikami, rodziną, byłym, grupą na czacie. I wyjście, które nic nie kosztuje: jeśli się skończy, nie ma czego kasować ani komu tłumaczyć.",
      },
      {
        type: "p",
        text: "Hard launch to ruch odwrotny: twarz w kadrze, oznaczenie, imię, żadnej niejasności. Zwykle przychodzi później, o ile w ogóle. Niektórzy przeskakują od razu do niego. A niektórzy nigdy nikogo nie wrzucają — to nawyk dotyczący bycia widocznym w sieci, a nie wyrok na związek.",
      },
      { type: "h2", text: "Jak to czytać" },
      {
        type: "ul",
        items: [
          "Kadr to decyzja. Zmieścić twarz to najprostsza rzecz na świecie.",
          "Do kogo trafiło: tylko do bliskich znajomych czy na całe konto.",
          "Czy to pierwszy raz, czy piąta historia, która zatrzymuje się na tym etapie.",
          "Czy uprzedził cię przed publikacją, czy dowiedziałaś się, przewijając.",
        ],
      },
      { type: "h2", text: "Jeśli to ty jesteś na zdjęciu", accent: "green" },
      {
        type: "p",
        text: "Dwie osoby mogą odczytać to samo zdjęcie dokładnie odwrotnie. Jedna ma na myśli: \"cieszę się i chciałam coś powiedzieć\". Druga czyta: \"trzymają mnie poza protokołem\". Tanie rozwiązanie to powiedzieć, o które chodzi. Zapytaj, zanim wrzucisz czyjąś dłoń; prawie każdy się zgodzi, a zapamiętane zostanie to, że zapytałaś. A jeśli w ogóle nie chcesz być wrzucana, powiedz to wcześnie.",
      },
      {
        type: "p",
        text: "Soft launch jest śladem uczucia, nie oświadczeniem o statusie. Mówi, że ktoś jest jednocześnie zadowolony i ostrożny, czyli tak jak niemal każdy na początku. Jeśli próbujesz ustalić, na czym stoisz, konto ci tego nie powie — powiedziałaby ta rozmowa, którą odkładasz, wpatrując się w profil.",
      },
    ],
  },

  sv: {
    term: "Soft launch",
    summary:
      "Att antyda ett nytt förhållande på sociala medier utan att visa vem det är: en hand i bild, en andra kaffekopp, en skugga på väggen. Man ser att något pågår, men inte med vem.",
    blocks: [
      { type: "h2", text: "Varför man gör en soft launch" },
      {
        type: "p",
        text: "Att lägga upp en ny person är ett offentligt åtagande med en offentlig kostnad om det tar slut. En soft launch delar skillnaden: du säger något utan att ställa ut någon. En avskuren hand, en andra kopp på bordet, en ärm i bildkanten. Bakom ligger oftast två skäl. Integritet — mot kollegor, familj, ett ex, en gruppchatt. Och en utgång som inte kostar något: tar det slut finns inget att radera och ingen att förklara sig för.",
      },
      {
        type: "p",
        text: "En hard launch är den motsatta rörelsen: ansiktet i bild, taggat, med namn, ingen tvetydighet kvar. Den kommer oftast senare, om den kommer. Vissa hoppar direkt dit. Andra lägger aldrig upp någon alls — det är en vana kring att synas på nätet, inte en dom över förhållandet.",
      },
      { type: "h2", text: "Hur man läser en" },
      {
        type: "ul",
        items: [
          "Beskärningen är ett val. Att få med ett ansikte är det enklaste som finns.",
          "Vem den lades upp för: bara nära vänner eller hela kontot.",
          "Om det är den första eller den femte historien som stannar i det här läget.",
          "Om du fick veta innan, eller upptäckte det medan du scrollade.",
        ],
      },
      { type: "h2", text: "Om det är du som är på bilden", accent: "green" },
      {
        type: "p",
        text: "Två personer kan läsa samma bild rakt motsatt. Den ena menar: \"jag är glad och ville säga något\". Den andra läser: \"jag hålls utanför protokollet\". Den billiga lösningen är att säga vilket av det som gäller. Fråga innan du lägger upp någons hand; nästan alla säger ja, och det som fastnar är att du frågade. Och vill du helst inte läggas upp alls, säg det tidigt.",
      },
      {
        type: "p",
        text: "En soft launch är spår av en känsla, inte ett besked om status. Den säger att någon är glad och försiktig på samma gång, vilket nästan alla är i början. Vill du veta var du står svarar inte kontot: det gör samtalet du skjuter upp medan du granskar det.",
      },
    ],
  },

  hi: {
    term: "सॉफ्ट लॉन्च",
    summary:
      "नए रिश्ते का इशारा सोशल मीडिया पर देना, पर यह न बताना कि वह है कौन: फ्रेम में आया एक हाथ, दूसरा कॉफी कप, दीवार पर पड़ती परछाईं। दिखता है कि कुछ चल रहा है, किसके साथ नहीं।",
    blocks: [
      { type: "h2", text: "लोग ऐसा करते क्यों हैं" },
      {
        type: "p",
        text: "किसी नए इंसान को पोस्ट करना एक सार्वजनिक वादा है, और रिश्ता टूटे तो कीमत भी सार्वजनिक चुकानी पड़ती है। सॉफ्ट लॉन्च बीच का रास्ता है: आप कुछ कह भी देते हैं और किसी को सामने भी नहीं लाते। कटा हुआ हाथ, मेज पर दूसरा कप, तस्वीर के किनारे एक आस्तीन। पीछे आमतौर पर दो वजहें होती हैं। एक, निजता — सहकर्मियों, घरवालों, किसी पुराने साथी, किसी ग्रुप से। दूसरी, बिना कीमत का रास्ता: बात खत्म हो जाए तो न कुछ मिटाना है, न किसी को सफाई देनी है।",
      },
      {
        type: "p",
        text: "हार्ड लॉन्च इसका उल्टा है: चेहरा फ्रेम में, टैग किया हुआ, नाम के साथ, कोई धुंधलापन नहीं। यह आमतौर पर बाद में आता है, और कभी-कभी आता ही नहीं। कुछ लोग सीधे वहीं से शुरू करते हैं। और कुछ कभी किसी को पोस्ट करते ही नहीं — यह इंटरनेट पर दिखने की आदत है, रिश्ते पर कोई फैसला नहीं।",
      },
      { type: "h2", text: "इसे पढ़ें कैसे" },
      {
        type: "ul",
        items: [
          "फ्रेम कैसे काटा गया, यह एक चुनाव है। चेहरा शामिल करना सबसे आसान काम था।",
          "यह किसके लिए डाला गया: सिर्फ करीबी दोस्तों के लिए या पूरे अकाउंट के लिए।",
          "यह पहला है, या इसी पड़ाव पर रुक जाने वाला पांचवां किस्सा।",
          "पोस्ट करने से पहले आपको बताया गया था, या आपने स्क्रॉल करते हुए देखा।",
        ],
      },
      { type: "h2", text: "अगर तस्वीर में आप हैं", accent: "green" },
      {
        type: "p",
        text: "एक ही तस्वीर को दो लोग बिल्कुल उल्टा पढ़ सकते हैं। एक का मतलब होता है “मैं खुश हूं और कुछ कहना चाहता था”। दूसरा पढ़ता है “मुझे रिकॉर्ड से बाहर रखा जा रहा है”। सबसे सस्ता हल यही है कि आप बता दें कि मतलब कौन-सा है। किसी का हाथ पोस्ट करने से पहले पूछ लीजिए; ज्यादातर लोग हां कहते हैं, और याद उन्हें यही रहता है कि आपने पूछा। और अगर आप बिल्कुल भी पोस्ट नहीं होना चाहते, तो यह शुरू में ही कह दीजिए।",
      },
      {
        type: "p",
        text: "सॉफ्ट लॉन्च एक भावना का सबूत है, रिश्ते का ऐलान नहीं। यह इतना बताता है कि कोई खुश भी है और सावधान भी — शुरुआत में ज्यादातर लोग यही होते हैं। अगर आप यह समझने की कोशिश में हैं कि आप कहां खड़े हैं, तो अकाउंट नहीं बताएगा: वही बातचीत बताएगी जिसे टालने के लिए आप अकाउंट देख रहे हैं।",
      },
    ],
  },
};
