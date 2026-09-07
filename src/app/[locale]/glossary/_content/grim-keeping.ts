import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * SOURCES, both verified at source rather than through a summary:
 *
 * - The word: Cambridge Dictionary's "New words" bulletin of 12 January 2026
 *   defines grim-keeping as "forming a relationship with someone based on
 *   disliking the same things", citing a huffingtonpost.co.uk piece of
 *   30 October 2025. The same bulletin carried chatfishing, which this
 *   glossary already covers.
 * - The research: Bosson, Johnson, Niederhoffer & Swann, "Interpersonal
 *   chemistry through negativity: Bonding by sharing negative attitudes about
 *   others", Personal Relationships 13(2), 135-150 (2006). Two surveys plus
 *   one experiment. Metadata confirmed against Semantic Scholar; abstract and
 *   the boundary condition read from the publisher's institutional repository
 *   record after the author-hosted PDF proved unextractable.
 *
 * THE BOUNDARY CONDITION IS NOT OPTIONAL. The experiment found shared negative
 * attitudes predicted liking more strongly than shared positive ones **only
 * when the attitudes were weak**. Dropping that clause turns a careful finding
 * into "negativity bonds better", which the paper does not claim.
 *
 * NOT USED: a "63% felt disappointed" figure that appears in the indy100 piece
 * Cambridge cites for bio-baiting. Whoever ran that survey is not named in a
 * source I could reach, so it is not publishable here.
 *
 * QULO ANGLE: only the last sentence, and it is an observation the cited work
 * supports rather than a product claim — a question everyone answers the same
 * way carries little information about whoever answered it.
 */
export const grimKeeping: LocalizedGlossaryEntry = {
  en: {
    term: "Grim-keeping",
    summary:
      "Building a connection on the things you both cannot stand — the shared eye-roll, the same pet hates — rather than on what you both love.",
    blocks: [
      { type: "h2", text: "Why a shared dislike lands so fast" },
      { type: "p", text: "Cambridge Dictionary added the word to its new-words watchlist in January 2026, defining it as forming a relationship with someone based on disliking the same things. The name is new; the pull is not. Anyone who has watched a first date turn from polite to easy the moment both people admit they hate the same thing has already seen it work." },
      { type: "p", text: "There is research behind the feeling, and it is older than the word. In **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer and Swann, Personal Relationships, 2006), two surveys and an experiment found that discovering a shared negative attitude about someone predicted liking a stranger more strongly than discovering a shared positive one — though only when the attitudes were mild to begin with. The authors' reading is that a shared dislike draws a line around the two of you and, unlike broad approval, says something specific about the person holding it. The part worth sitting with is that participants got this backwards: asked what would bring people closer, they confidently said sharing what you like." },

      { type: "h2", text: "How to recognise the pattern" },
      {
        type: "ul",
        items: [
          "The conversation is fastest and funniest when it is about something you are both against.",
          "You know what they cannot stand in detail, and what they love only in outline.",
          "Plans get made around avoiding things rather than around doing something.",
          "When the shared target is absent — the ex, the job, the trend — the talk goes quiet.",
        ],
      },

      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Do not treat it as a fault. A shared dislike is real information and often the first honest thing two strangers say to each other; the study's own explanation is that it is more revealing than agreement about something pleasant. The question is only whether it is the whole foundation. Try naming one thing you actually love and see whether the conversation survives the change of key — that is a cheap test and it tells you a lot." },
      { type: "p", text: "The risk is not negativity, it is what happens when the target disappears. A bond built on a common enemy needs the enemy. If you notice that the good hours are the complaining hours, the fix is not to complain less but to find out whether there is anything you are both for. And the same logic runs through any question worth asking someone: one that everybody answers the same way tells you almost nothing about the person answering it." },
    ],
  },
  tr: {
    term: "Ortak nefret bağı",
    summary:
      "Bağı, ikinizin de sevdiği şeyler üzerine değil, ikinizin de katlanamadığı şeyler üzerine kurmak — aynı şeye dönen gözler, aynı ortak dertler.",
    blocks: [
      { type: "h2", text: "Ortak bir hoşlanmamanın neden bu kadar hızlı tuttuğu" },
      { type: "p", text: "Cambridge Dictionary kelimeyi Ocak 2026'da yeni kelimeler listesine aldı ve şöyle tanımladı: aynı şeylerden hoşlanmama üzerinden ilişki kurmak. Yeni olan ad; çekim değil. İlk buluşmanın, iki kişi de aynı şeyden nefret ettiğini itiraf ettiği anda nezaketten rahatlığa geçtiğini görmüş olan herkes bunun işlediğini zaten biliyor." },
      { type: "p", text: "Bu hissin arkasında araştırma var ve kelimeden eski. **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer ve Swann, Personal Relationships, 2006) çalışmasında iki anket ve bir deney şunu buldu: biri hakkında ortak bir olumsuz tutum keşfetmek, bir yabancıyı sevmeyi, ortak bir olumlu tutum keşfetmekten daha güçlü yordadı — ama yalnızca tutumlar başlangıçta ılımlıyken. Yazarların okuması şu: ortak bir hoşlanmama ikinizin etrafına bir çizgi çekiyor ve geniş bir onaylamanın aksine, o tutumu taşıyan kişi hakkında özel bir şey söylüyor. Üzerinde durmaya değer kısım ise şu: katılımcılar bunu ters biliyordu — insanları neyin yakınlaştıracağı sorulduğunda, hiç tereddütsüz sevdiklerini paylaşmak dediler." },

      { type: "h2", text: "Örüntüyü nasıl tanırsın" },
      {
        type: "ul",
        items: [
          "Sohbet en hızlı ve en komik hâline, ikinizin de karşı olduğu bir şey konuşulurken geliyor.",
          "Nelere katlanamadığını ayrıntısıyla biliyorsun, neleri sevdiğini ise ana hatlarıyla.",
          "Planlar bir şey yapmak üzerine değil, bir şeyden kaçınmak üzerine kuruluyor.",
          "Ortak hedef ortada yokken — eski sevgili, iş, moda olan şey — konuşma sessizleşiyor.",
        ],
      },

      { type: "h2", accent: "green", text: "Ne yapmalı" },
      { type: "p", text: "Bunu bir kusur gibi ele alma. Ortak bir hoşlanmama gerçek bir bilgidir ve çoğu zaman iki yabancının birbirine söylediği ilk dürüst şeydir; çalışmanın kendi açıklaması da bunun hoş bir konuda anlaşmaktan daha çok şey ele verdiği yönünde. Tek soru, temelin tamamı olup olmadığı. Gerçekten sevdiğin bir şeyi adıyla söyle ve sohbetin bu ton değişikliğinden sağ çıkıp çıkmadığına bak — ucuz bir sınama ve çok şey anlatıyor." },
      { type: "p", text: "Risk olumsuzluk değil; hedef ortadan kalktığında ne olacağı. Ortak bir düşman üzerine kurulmuş bağın o düşmana ihtiyacı vardır. İyi saatlerin şikâyet saatleri olduğunu fark ediyorsan, çözüm daha az şikâyet etmek değil, ikinizin birlikte savunduğu bir şey olup olmadığını öğrenmek. Aynı mantık, birine sorulmaya değer her soruda da geçerli: herkesin aynı cevabı verdiği bir soru, cevaplayan hakkında neredeyse hiçbir şey söylemez." },
    ],
  },
  de: {
    term: "Grim-Keeping",
    summary:
      "Eine Verbindung über das aufbauen, was ihr beide nicht ausstehen könnt — das gemeinsame Augenrollen, dieselben Aufreger —, statt über das, was ihr beide liebt.",
    blocks: [
      { type: "h2", text: "Warum eine gemeinsame Abneigung so schnell zündet" },
      { type: "p", text: "Cambridge Dictionary nahm das Wort im Januar 2026 in seine Liste neuer Wörter auf und definierte es als eine Beziehung zu jemandem, die auf einer geteilten Abneigung gegen dieselben Dinge beruht. Neu ist der Name, nicht der Sog. Wer schon einmal erlebt hat, wie ein erstes Date genau in dem Moment von höflich zu locker kippt, in dem beide zugeben, dasselbe nicht ausstehen zu können, weiß bereits, dass es wirkt." },
      { type: "p", text: "Hinter dem Gefühl steckt Forschung, und die ist älter als das Wort. In **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer und Swann, Personal Relationships, 2006) fanden zwei Umfragen und ein Experiment, dass eine geteilte negative Haltung gegenüber einer dritten Person Sympathie für eine fremde Person stärker vorhersagte als eine geteilte positive Haltung — allerdings nur, wenn die Haltungen von vornherein schwach ausgeprägt waren. Die Lesart der Autorinnen und Autoren heißt: Eine gemeinsame Abneigung zieht eine Linie um euch beide und sagt, anders als breite Zustimmung, etwas Bestimmtes über die Person aus, die sie hat. Der Teil, bei dem es sich zu verweilen lohnt, ist dieser: Die Teilnehmenden hatten es genau andersherum im Kopf — gefragt, was Menschen einander näherbringt, antworteten sie ohne Zögern, man teile am besten das, was man mag." },
      { type: "h2", text: "Wie du das Muster erkennst" },
      {
        type: "ul",
        items: [
          "Das Gespräch ist immer dann am schnellsten und am lustigsten, wenn es um etwas geht, gegen das ihr beide seid.",
          "Du weißt im Detail, was die andere Person nicht ausstehen kann, und nur in Umrissen, was sie liebt.",
          "Pläne entstehen darum herum, etwas zu vermeiden, statt darum, etwas zu tun.",
          "Fehlt das gemeinsame Ziel — der Ex, der Job, der Trend —, wird das Gespräch still.",
        ],
      },
      { type: "h2", accent: "green", text: "Was du damit machen kannst" },
      { type: "p", text: "Behandle es nicht als Fehler. Eine gemeinsame Abneigung ist echte Information und oft das erste Ehrliche, das zwei fremde Menschen einander sagen; die Erklärung der Studie selbst lautet, dass sie mehr verrät als Einigkeit über etwas Angenehmes. Die Frage ist nur, ob sie das ganze Fundament ist. Nenne einmal etwas, das du wirklich liebst, und sieh nach, ob das Gespräch den Tonartwechsel übersteht — das ist ein billiger Test, und er verrät viel." },
      { type: "p", text: "Das Risiko ist nicht die Negativität, sondern das, was passiert, wenn das Ziel verschwindet. Eine Bindung, die auf einem gemeinsamen Feind steht, braucht diesen Feind. Wenn dir auffällt, dass die guten Stunden die Stunden des Klagens sind, liegt die Lösung nicht darin, weniger zu klagen, sondern herauszufinden, ob es etwas gibt, wofür ihr beide seid. Dieselbe Logik zieht sich durch jede Frage, die es wert ist, jemandem gestellt zu werden: Eine, die alle gleich beantworten, sagt fast nichts über die Person aus, die antwortet." },
    ],
  },
  fr: {
    term: "Grim-keeping",
    summary:
      "Construire un lien sur ce que vous ne supportez ni l’un ni l’autre — le même haussement de sourcils, les mêmes bêtes noires — plutôt que sur ce que vous aimez tous les deux.",
    blocks: [
      { type: "h2", text: "Pourquoi une aversion partagée prend si vite" },
      { type: "p", text: "Le Cambridge Dictionary a inscrit le mot sur sa liste de nouveautés en janvier 2026, avec cette définition : « nouer une relation avec quelqu’un sur la base d’aversions partagées ». C’est le nom qui est nouveau, pas l’attraction. Quiconque a vu un premier rendez-vous passer du poli au facile à la seconde où les deux personnes avouent détester la même chose l’a déjà vu marcher." },
      { type: "p", text: "Il y a de la recherche derrière cette impression, et elle est plus ancienne que le mot. Dans **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer et Swann, Personal Relationships, 2006), deux enquêtes et une expérience ont trouvé que découvrir une attitude négative partagée à l’égard d’un tiers prédisait la sympathie pour un inconnu plus fortement que découvrir une attitude positive partagée — mais uniquement lorsque ces attitudes étaient modérées au départ. La lecture des auteurs : une aversion commune trace un trait autour de vous deux et, à la différence d’une approbation large, dit quelque chose de précis sur celui ou celle qui la porte. Le détail qui mérite qu’on s’y arrête, c’est que les participants se le représentaient à l’envers : interrogés sur ce qui rapproche les gens, ils ont répondu sans hésiter qu’il fallait partager ce qu’on aime." },
      { type: "h2", text: "Comment reconnaître ce schéma" },
      {
        type: "ul",
        items: [
          "La conversation est la plus vive et la plus drôle quand elle porte sur quelque chose contre quoi vous êtes tous les deux.",
          "Vous savez en détail ce que l’autre ne supporte pas, et seulement dans les grandes lignes ce qu’il aime.",
          "Les projets se font autour de ce qu’il s’agit d’éviter plutôt qu’autour de quelque chose à faire.",
          "Quand la cible commune n’est pas là — l’ex, le travail, la mode du moment —, la conversation retombe.",
        ],
      },
      { type: "h2", accent: "green", text: "Qu’en faire" },
      { type: "p", text: "N’y voyez pas un défaut. Une aversion partagée est une information réelle, et souvent la première chose honnête que deux inconnus se disent ; l’explication que donne l’étude elle-même, c’est qu’elle en révèle plus qu’un accord sur quelque chose d’agréable. La seule question est de savoir si elle constitue tout le socle. Nommez une chose que vous aimez vraiment et regardez si la conversation survit au changement de registre : c’est un test peu coûteux et il en dit long." },
      { type: "p", text: "Le risque n’est pas la négativité, c’est ce qui arrive quand la cible disparaît. Un lien bâti sur un ennemi commun a besoin de cet ennemi. Si vous constatez que les bonnes heures sont les heures de récriminations, le remède n’est pas de moins se plaindre, mais de découvrir s’il existe quelque chose pour quoi vous êtes tous les deux. Et la même logique traverse toute question qui vaut la peine d’être posée à quelqu’un : celle à laquelle tout le monde répond pareil n’apprend presque rien sur la personne qui répond." },
    ],
  },
  es: {
    term: "Grim-keeping",
    summary:
      "Construir un vínculo sobre las cosas que ninguno de los dos soporta —el mismo gesto de fastidio, las mismas manías— en vez de sobre lo que ambos aman.",
    blocks: [
      { type: "h2", text: "¿Por qué una antipatía compartida cuaja tan rápido?" },
      { type: "p", text: "El Cambridge Dictionary añadió la palabra a su lista de nuevos términos en enero de 2026 y la definió así: formar una relación con alguien a partir de que a los dos les disgustan las mismas cosas. Lo nuevo es el nombre, no el tirón. Cualquiera que haya visto una primera cita pasar de lo cortés a lo cómodo en el instante en que ambos admiten que odian lo mismo ya lo ha visto funcionar." },
      { type: "p", text: "Detrás de esa sensación hay investigación, y es más antigua que la palabra. En **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer y Swann, Personal Relationships, 2006), dos encuestas y un experimento encontraron que descubrir una actitud negativa compartida hacia otra persona predecía la simpatía por un desconocido con más fuerza que descubrir una actitud positiva compartida, pero solo cuando esas actitudes eran moderadas de partida. La lectura de los autores es que una antipatía común traza una raya alrededor de los dos y, a diferencia de una aprobación amplia, dice algo concreto de quien la sostiene. La parte que merece detenerse es esta: los participantes lo tenían al revés; cuando se les preguntó qué acerca a la gente, respondieron sin dudar que compartir lo que a uno le gusta." },
      { type: "h2", text: "Cómo reconocer el patrón" },
      {
        type: "ul",
        items: [
          "La conversación es más rápida y más divertida cuando va de algo a lo que ambos se oponen.",
          "Sabes con detalle qué no soporta la otra persona, y solo a grandes rasgos qué le gusta.",
          "Los planes se hacen para evitar algo, no para hacer algo.",
          "Cuando el blanco común no está —el ex, el trabajo, la moda del momento—, la conversación se apaga.",
        ],
      },
      { type: "h2", accent: "green", text: "Qué hacer con esto" },
      { type: "p", text: "No lo trates como un defecto. Una antipatía compartida es información real y muchas veces lo primero honesto que se dicen dos desconocidos; la propia explicación del estudio es que revela más que estar de acuerdo en algo agradable. La única pregunta es si es todo el cimiento. Di en voz alta una cosa que de verdad te guste y mira si la conversación sobrevive al cambio de tono: es una prueba barata y cuenta mucho." },
      { type: "p", text: "El riesgo no es la negatividad, sino lo que pasa cuando el blanco desaparece. Un vínculo levantado sobre un enemigo común necesita a ese enemigo. Si notas que las buenas horas son las horas de quejarse, el remedio no es quejarse menos, sino averiguar si hay algo que ambos defiendan. Y la misma lógica recorre cualquier pregunta que merezca la pena hacerle a alguien: una que todo el mundo responde igual no dice casi nada de quien la responde." },
    ],
  },
  ar: {
    term: "رابطة الكره المشترك",
    summary:
      "أن تقوم العلاقة على ما لا يطيقه كلاكما لا على ما تحبّانه معًا: الضيق نفسه من الأشياء نفسها، والنفور المشترك من التفاصيل الصغيرة.",
    blocks: [
      { type: "h2", text: "لماذا يقرّب النفور المشترك بهذه السرعة؟" },
      { type: "p", text: "أضاف قاموس Cambridge Dictionary الكلمة إلى قائمة كلماته الجديدة في يناير 2026، وعرّفها بأنّها إقامة علاقة مع شخص على أساس كره الأشياء نفسها. الجديد هنا هو الاسم لا الجاذبية نفسها. فمن رأى لقاءً أوّل ينتقل من التهذيب إلى الارتياح في اللحظة التي يعترف فيها الطرفان بأنّهما يكرهان الشيء نفسه، يعرف أصلًا أنّ هذا يعمل." },
      { type: "p", text: "وخلف هذا الشعور بحثٌ أقدم من الكلمة نفسها. في دراسة **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer & Swann, Personal Relationships, 2006) وجد استطلاعان وتجربة واحدة أنّ اكتشاف موقف سلبي مشترك تجاه شخص ما كان أقوى في التنبّؤ بالميل إلى غريب من اكتشاف موقف إيجابي مشترك، لكن بشرط واحد: أن تكون المواقف معتدلة في الأصل. وقراءة الباحثين أنّ النفور المشترك يرسم خطًا حول الاثنين معًا، وأنّه، بخلاف الاستحسان العامّ، يقول شيئًا خاصًا عن صاحبه. أمّا الجزء الذي يستحقّ التوقّف عنده فهو أنّ المشاركين كانوا يظنّون العكس: حين سُئلوا عمّا يقرّب الناس بعضهم من بعض، أجابوا واثقين بأنّه مشاركة ما يحبّون." },
      { type: "h2", text: "كيف تتعرّف على هذا النمط" },
      {
        type: "ul",
        items: [
          "الحديث يكون في أسرع حالاته وأطرفها حين يدور حول شيء تقفان ضدّه معًا.",
          "تعرف بالتفصيل ما لا يطيقه، ولا تعرف ما يحبّه إلّا في خطوطه العامّة.",
          "الخطط تُبنى على تجنّب شيء ما، لا على فعل شيء ما.",
          "حين يغيب الهدف المشترك، أي حين لا يكون الحديث عن الحبيب السابق أو العمل أو الموضة الرائجة، يخفت الكلام.",
        ],
      },
      { type: "h2", accent: "green", text: "ماذا تفعل حيال ذلك" },
      { type: "p", text: "لا تعامله كعيب. النفور المشترك معلومة حقيقية، وهو في الغالب أوّل شيء صادق يقوله غريبان أحدهما للآخر؛ وتفسير الدراسة نفسها أنّه يكشف عن صاحبه أكثر ممّا يكشفه الاتفاق على شيء لطيف. السؤال الوحيد هو ما إذا كان هو الأساس كلّه. جرّب أن تسمّي شيئًا واحدًا تحبّه فعلًا، وانظر هل ينجو الحديث من تغيّر النبرة هذا؛ اختبار رخيص، لكنّه يقول لك الكثير." },
      { type: "p", text: "الخطر ليس السلبية، بل ما يحدث حين يختفي الهدف. فالرابطة التي تقوم على عدوّ مشترك تحتاج إلى ذلك العدوّ. وإن لاحظت أنّ أفضل ساعاتكما هي ساعات الشكوى، فالحلّ ليس أن تشكوَ أقلّ، بل أن تعرف إن كان بينكما شيء تقفان معه لا ضدّه. والمنطق نفسه يسري على كلّ سؤال يستحقّ أن يُطرح على أحد: السؤال الذي يجيب عنه الجميع بالإجابة نفسها لا يكاد يقول شيئًا عمّن أجاب." },
    ],
  },
  ru: {
    term: "Грим-кипинг",
    summary:
      "Связь, которая держится не на том, что вы любите, а на том, чего вы вдвоём не выносите, — на общем закатывании глаз и одних и тех же раздражителях.",
    blocks: [
      { type: "h2", text: "Почему общая неприязнь срабатывает так быстро" },
      { type: "p", text: "Cambridge Dictionary внёс это слово в список новых слов в январе 2026 года и определил его как построение отношений с человеком на почве неприязни к одному и тому же. Новое здесь название, а не само притяжение. Кто хоть раз видел, как первое свидание переходит от вежливости к лёгкости ровно в ту минуту, когда двое признаются, что терпеть не могут одно и то же, тот уже знает, что это работает." },
      { type: "p", text: "За этим ощущением стоит исследование, и оно старше самого слова. В работе «**Interpersonal chemistry through negativity**» (Bosson, Johnson, Niederhoffer и Swann, Personal Relationships, 2006) два опроса и эксперимент показали, что общее отрицательное отношение к кому-то предсказывало симпатию к незнакомому человеку сильнее, чем общее положительное, — но только когда сами установки изначально были умеренными. Авторы объясняют это так: общая неприязнь очерчивает круг вокруг вас двоих и, в отличие от широкого одобрения, говорит что-то определённое о том, кто её испытывает. Самое любопытное здесь то, что участники понимали всё наоборот: когда их спрашивали, что сближает людей, они уверенно отвечали, что нужно делиться тем, что нравится." },
      { type: "h2", text: "Как распознать этот рисунок" },
      {
        type: "ul",
        items: [
          "Быстрее и веселее всего разговор идёт тогда, когда речь о том, чего вы вместе не выносите.",
          "Вы в подробностях знаете, чего этот человек терпеть не может, и лишь в общих чертах — что он любит.",
          "Планы строятся вокруг того, чего избежать, а не вокруг того, что сделать вместе.",
          "Когда общей мишени нет рядом — бывших, работы, очередной моды, — разговор затихает.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Не считайте это изъяном. Общая неприязнь — настоящая информация и часто первое честное, что говорят друг другу два незнакомых человека; собственное объяснение авторов в том, что она выдаёт больше, чем согласие насчёт чего-то приятного. Вопрос только в том, весь ли это фундамент. Попробуйте назвать одну вещь, которую вы действительно любите, и посмотрите, переживёт ли разговор смену тональности, — проверка дешёвая, а говорит она о многом." },
      { type: "p", text: "Риск не в негативности, а в том, что произойдёт, когда мишень исчезнет. Связи, построенной на общем враге, этот враг нужен. Если вы замечаете, что хорошие часы — это часы жалоб, решение не в том, чтобы жаловаться меньше, а в том, чтобы выяснить, есть ли что-то, за что вы выступаете вместе. И та же логика проходит через любой вопрос, который стоит кому-то задать: вопрос, на который все отвечают одинаково, почти ничего не говорит о том, кто отвечает." },
    ],
  },
  pt: {
    term: "Grim-keeping",
    summary:
      "Construir uma conexão sobre aquilo que vocês dois não suportam — o mesmo revirar de olhos, as mesmas implicâncias — em vez de sobre o que vocês dois amam.",
    blocks: [
      { type: "h2", text: "Por que uma antipatia em comum pega tão rápido" },
      { type: "p", text: "O Cambridge Dictionary colocou a palavra na sua lista de palavras novas em janeiro de 2026, definindo-a como formar uma relação com alguém com base em não gostar das mesmas coisas. O nome é novo; a atração não é. Quem já viu um primeiro encontro passar do educado ao à vontade no instante em que os dois admitem que detestam a mesma coisa já viu isso funcionar." },
      { type: "p", text: "Existe pesquisa por trás dessa sensação, e ela é mais velha que a palavra. Em **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer e Swann, Personal Relationships, 2006), dois levantamentos e um experimento constataram que descobrir uma atitude negativa em comum a respeito de alguém previa melhor a simpatia por um desconhecido do que descobrir uma atitude positiva em comum — mas só quando as atitudes eram moderadas de início. A leitura dos autores é que uma antipatia compartilhada traça uma linha em volta de vocês dois e, ao contrário de uma aprovação genérica, diz algo específico sobre quem a tem. A parte em que vale a pena parar é que os participantes entendiam isso ao contrário: quando perguntados sobre o que aproximaria as pessoas, responderam com toda a confiança que era compartilhar aquilo de que se gosta." },
      { type: "h2", text: "Como reconhecer o padrão" },
      {
        type: "ul",
        items: [
          "A conversa fica mais rápida e mais engraçada quando é sobre algo contra o qual vocês dois estão.",
          "Você sabe em detalhe o que a outra pessoa não suporta, e só em linhas gerais o que ela ama.",
          "Os planos se organizam em torno de evitar coisas, e não em torno de fazer alguma coisa.",
          "Quando o alvo em comum não está em cena — o ex, o trabalho, a moda do momento — a conversa esfria.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer com isso" },
      { type: "p", text: "Não trate isso como um defeito. Uma antipatia em comum é informação de verdade e muitas vezes é a primeira coisa honesta que dois desconhecidos dizem um ao outro; a própria explicação do estudo é que ela revela mais do que a concordância sobre algo agradável. A única questão é se ela é a base inteira. Experimente dizer uma coisa que você ama de verdade e veja se a conversa sobrevive à mudança de tom — é um teste barato e diz muito." },
      { type: "p", text: "O risco não é a negatividade, é o que acontece quando o alvo desaparece. Um vínculo construído sobre um inimigo em comum precisa do inimigo. Se você percebeu que as boas horas são as horas das reclamações, a saída não é reclamar menos, e sim descobrir se há alguma coisa a favor da qual vocês dois estejam. E a mesma lógica atravessa qualquer pergunta que valha a pena fazer a alguém: uma pergunta que todo mundo responde da mesma forma não diz quase nada sobre quem respondeu." },
    ],
  },
  it: {
    term: "Grim-keeping",
    summary:
      "Costruire un legame su quello che nessuno dei due sopporta — lo stesso alzare gli occhi al cielo, le stesse insofferenze — invece che su quello che piace a entrambi.",
    blocks: [
      { type: "h2", text: "Perché un’antipatia condivisa attacca così in fretta" },
      { type: "p", text: "Il Cambridge Dictionary ha aggiunto la parola alla sua lista di parole nuove nel gennaio 2026, definendola come il costruire una relazione con qualcuno sulla base del non sopportare le stesse cose. Nuovo è il nome, non il richiamo. Chi ha visto un primo appuntamento passare dal cortese al facile nel momento esatto in cui entrambi ammettono di detestare la stessa cosa, sa già che funziona." },
      { type: "p", text: "Dietro questa sensazione c’è della ricerca, ed è più vecchia della parola. In **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer e Swann, Personal Relationships, 2006) due indagini e un esperimento hanno trovato che scoprire un atteggiamento negativo condiviso verso qualcuno prevedeva la simpatia per uno sconosciuto più fortemente di quanto facesse scoprire un atteggiamento positivo condiviso — ma solo quando gli atteggiamenti erano moderati in partenza. La lettura degli autori è che un’antipatia condivisa traccia una linea attorno a voi due e, a differenza di un’approvazione generica, dice qualcosa di specifico su chi la esprime. La parte su cui vale la pena fermarsi è che i partecipanti se l’aspettavano al contrario: alla domanda su che cosa avvicini le persone, hanno risposto senza esitare che è condividere ciò che piace." },
      { type: "h2", text: "Come riconoscere lo schema" },
      {
        type: "ul",
        items: [
          "La conversazione è più rapida e più divertente quando riguarda qualcosa contro cui siete entrambi.",
          "Sai nel dettaglio che cosa non sopporta, e solo a grandi linee che cosa ama.",
          "I programmi si fanno attorno a quello che si vuole evitare, non attorno a qualcosa da fare.",
          "Quando il bersaglio comune non c’è — l’ex, il lavoro, la moda del momento — la conversazione si spegne.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa farne" },
      { type: "p", text: "Non trattarlo come un difetto. Un’antipatia condivisa è un’informazione vera ed è spesso la prima cosa onesta che due sconosciuti si dicono; la spiegazione dello studio stesso è che rivela più di un accordo su qualcosa di piacevole. L’unica domanda è se sia tutta la base. Prova a dire una cosa che ami davvero e guarda se la conversazione sopravvive al cambio di tono — è una prova che non costa nulla e dice molto." },
      { type: "p", text: "Il rischio non è la negatività, è quello che succede quando il bersaglio sparisce. Un legame costruito su un nemico comune ha bisogno del nemico. Se ti accorgi che le ore belle sono le ore in cui vi lamentate, la soluzione non è lamentarsi di meno, ma scoprire se c’è qualcosa a favore di cui siete entrambi. E la stessa logica attraversa qualunque domanda valga la pena fare a qualcuno: una a cui tutti rispondono allo stesso modo non dice quasi niente su chi risponde." },
    ],
  },
  ja: {
    term: "グリムキーピング",
    summary:
      "二人とも好きなものではなく、二人とも我慢ならないもののほうでつながること。同じところで一緒にあきれ、同じものにうんざりする。その一致のうえに関係を築くことを指します。",
    blocks: [
      { type: "h2", text: "共通の「嫌い」がこんなに早く効くわけ" },
      { type: "p", text: "Cambridge Dictionaryは2026年1月、この語を新語のウォッチリストに加え、同じものを嫌うことを土台にして関係を結ぶこと、と定義しました。新しいのは名前のほうで、引力そのものは新しくありません。初めて会った二人が、同じものを嫌いだと打ち明けたとたんに、礼儀正しいだけの空気からくつろいだ空気へ変わる。それを一度でも見たことがあれば、これが効くことはもう知っているはずです。" },
      { type: "p", text: "この感覚の裏には研究があり、しかも言葉より古いものです。**Interpersonal chemistry through negativity**（Bosson, Johnson, Niederhoffer & Swann, Personal Relationships, 2006）では、二つの調査と一つの実験から、ある人物についての否定的な態度が共通していると分かるほうが、肯定的な態度が共通していると分かるよりも、初対面の相手への好意を強く予測する、という結果が出ています。ただしこれは、もともとの態度が穏やかな場合にかぎった話です。著者たちの読み方はこうです。共通の「嫌い」は二人のまわりに線を引き、広く何かを良いと言うのとは違って、そう思っている当人について具体的な何かを語ってしまう。そして、いちばん立ち止まる価値があるのは、参加者たちがこれを逆に思っていたことです。何が人を近づけるかと聞かれると、彼らは迷いなく、好きなものを分かち合うことだと答えました。" },
      { type: "h2", text: "このかたちの見分け方" },
      {
        type: "ul",
        items: [
          "会話がいちばん速く、いちばん面白くなるのは、二人とも反対しているものの話をしているときだ。",
          "相手が何に我慢ならないかは細かく知っているのに、何が好きかは輪郭しか知らない。",
          "予定が、何かをするためではなく、何かを避けるために組まれる。",
          "共通の的が話に出てこないとき、つまり元恋人や仕事や流行りものの話がないときに、会話が静かになる。",
        ],
      },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "欠点として扱わないでください。共通の「嫌い」は本物の情報で、見知らぬ二人が最初に交わす正直な言葉であることも多いものです。この研究自身の説明でも、それは何か気持ちのいいことに同意するよりも、その人について多くを明かすとされています。問題は、それが土台のすべてなのかどうか、それだけです。自分が本当に好きなものを一つ名前で挙げてみて、その調子の変化に会話が耐えられるかどうかを見てください。安上がりな試しですが、分かることは多いです。" },
      { type: "p", text: "危ないのは否定的であること自体ではなく、的がいなくなったときに何が起きるかです。共通の敵の上に建てた関係は、その敵を必要とします。いい時間がいつも愚痴の時間になっていると気づいたなら、直し方は愚痴を減らすことではありません。二人がそろって賛成できるものが何かあるのかを確かめることです。そして同じ理屈は、誰かに聞く価値のあるどんな問いにも通じます。みんなが同じ答えを返す問いは、答えた人について、ほとんど何も教えてくれません。" },
    ],
  },
  ko: {
    term: "같이 싫어하며 가까워지는 사이",
    summary:
      "둘 다 좋아하는 것이 아니라 둘 다 못 견디는 것 위에 관계를 세우는 일. 같은 대목에서 같이 눈살을 찌푸리고 같은 것에 질려 하는 데서 사이가 시작됩니다.",
    blocks: [
      { type: "h2", text: "같이 싫어하는 마음은 왜 이렇게 빨리 통할까" },
      { type: "p", text: "Cambridge Dictionary는 2026년 1월 이 말을 새 단어 목록에 올리면서, 같은 것을 싫어한다는 점을 바탕으로 관계를 맺는 일이라고 풀이했습니다. 새로운 것은 이름이지 그 끌림이 아닙니다. 처음 만난 두 사람이 같은 것을 싫어한다고 털어놓는 순간에 예의만 남아 있던 자리가 갑자기 편해지는 장면을 본 적이 있다면, 이게 통한다는 것은 이미 아는 셈입니다." },
      { type: "p", text: "이 느낌 뒤에는 연구가 있고, 그 연구는 단어보다 오래됐습니다. **Interpersonal chemistry through negativity**(Bosson, Johnson, Niederhoffer & Swann, Personal Relationships, 2006)에서는 설문 두 건과 실험 한 건을 통해, 어떤 사람에 대한 부정적인 태도가 같다는 것을 알게 되는 쪽이 긍정적인 태도가 같다는 것을 알게 되는 쪽보다 처음 보는 상대에 대한 호감을 더 강하게 예측한다는 결과가 나왔습니다. 다만 이는 두 태도가 애초에 그리 세지 않을 때에만 그랬습니다. 저자들의 해석은 이렇습니다. 같이 싫어하는 마음은 두 사람 둘레에 선을 하나 긋고, 무언가를 널리 좋게 보는 것과 달리 그 마음을 품은 사람에 대해 구체적인 무언가를 말해 준다는 것입니다. 그리고 가장 곱씹어 볼 만한 대목은 참가자들이 이걸 거꾸로 알고 있었다는 점입니다. 무엇이 사람을 가깝게 만드느냐고 묻자 그들은 망설임 없이 좋아하는 것을 나누는 일이라고 답했습니다." },
      { type: "h2", text: "이 패턴을 알아보는 법" },
      {
        type: "ul",
        items: [
          "둘 다 반대하는 무언가를 이야기할 때 대화가 가장 빠르고 가장 재미있습니다.",
          "상대가 무엇을 못 견디는지는 자세히 알면서, 무엇을 좋아하는지는 윤곽만 압니다.",
          "약속이 무언가를 하기 위해서가 아니라 무언가를 피하기 위해 잡힙니다.",
          "공통의 표적이 자리에 없을 때, 그러니까 전 애인이나 일이나 유행하는 무언가가 화제에서 빠지면 대화가 조용해집니다.",
        ],
      },
      { type: "h2", accent: "green", text: "그럼 어떻게 하면 좋을까" },
      { type: "p", text: "이걸 흠으로 여기지는 마세요. 같이 싫어하는 마음은 진짜 정보이고, 낯선 두 사람이 서로에게 처음으로 하는 솔직한 말인 경우도 많습니다. 이 연구가 스스로 내놓은 설명도, 그것이 즐거운 무언가에 대해 의견이 맞는 일보다 그 사람에 대해 더 많이 드러낸다는 쪽입니다. 물어볼 것은 하나뿐입니다. 그게 관계의 바닥 전부인가 하는 것이죠. 내가 정말 좋아하는 것 하나를 이름 붙여 말해 보고, 가락이 바뀌어도 대화가 살아남는지 지켜보세요. 값싼 시험이지만 알려 주는 것은 많습니다." },
      { type: "p", text: "위험한 것은 부정적인 이야기 자체가 아니라, 그 표적이 사라졌을 때 무슨 일이 벌어지느냐입니다. 공동의 적 위에 세운 사이는 그 적이 있어야 합니다. 좋은 시간이 곧 불평하는 시간이라는 것을 알아차렸다면, 답은 불평을 줄이는 것이 아닙니다. 둘이 함께 편들 수 있는 무언가가 있는지 알아보는 것입니다. 그리고 같은 이치가 누군가에게 물어볼 만한 모든 질문에도 통합니다. 모두가 똑같이 답하는 질문은 답한 사람에 대해 거의 아무것도 말해 주지 않습니다." },
    ],
  },
  zh: {
    term: "共同讨厌式结缘",
    summary:
      "把关系建立在两个人都受不了的事情上——同时翻起的白眼、同样几件看不顺眼的事——而不是建立在两个人都喜欢的事情上。",
    blocks: [
      { type: "h2", text: "一个共同的讨厌为什么一下就拉近了距离" },
      { type: "p", text: "剑桥词典（Cambridge Dictionary）在2026年1月把 grim-keeping 收进了新词观察名单，定义是：因为讨厌同样的东西而与人建立关系。新的是这个名字，不是这股拉力。凡是见过第一次约会在两个人承认自己讨厌同一样东西的那一刻，从客气转为轻松的人，都已经看过它起作用了。" },
      { type: "p", text: "这种感觉背后是有研究的，而且比这个词老得多。在**Interpersonal chemistry through negativity**（Bosson、Johnson、Niederhoffer 和 Swann，Personal Relationships，2006）里，两项问卷调查和一个实验发现：察觉到彼此对某个人抱有同样的负面看法，比察觉到彼此有同样的正面看法，更能预测一个人对陌生人的好感——但只有在这些看法本身一开始就比较温和的时候才是如此。作者的解读是，一个共同的讨厌在你们两个人周围画下了一条线；而且与泛泛的赞许不同，它透露了持这种看法的人身上某种具体的东西。真正值得停下来想一想的是，参与者把这件事想反了：被问到什么能让人彼此更亲近时，他们很有把握地说，是分享自己喜欢的东西。" },
      { type: "h2", text: "怎么认出这个模式" },
      {
        type: "ul",
        items: [
          "聊得最快、最好笑的时候，聊的都是你们两个人都反对的东西。",
          "他受不了什么，你连细节都清楚；他喜欢什么，你只知道个大概。",
          "计划总是围着躲开某件事来定，而不是围着一起去做某件事。",
          "共同的靶子不在场时——那个前任、那份工作、那个正流行的东西——话就少了下来。",
        ],
      },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "别把它当成毛病。一个共同的讨厌是真实的信息，往往还是两个陌生人对彼此说的第一句实话；这项研究自己的解释也是，比起在一件让人愉快的事情上达成一致，它更能透露出一个人的样子。唯一的问题是，它是不是整个地基。试着说出一件你真正喜欢的东西，看看聊天能不能挺过这次转调——这是个很便宜的测试，而且能告诉你不少事情。" },
      { type: "p", text: "风险不在于负面，而在于靶子消失之后会怎么样。建立在共同敌人之上的关系，需要那个敌人一直在。如果你发现好时光都是抱怨的时光，办法不是少抱怨，而是去弄清楚有没有什么是你们两个人都支持的。同样的道理也贯穿在任何一个值得问别人的问题里：一个所有人都给出同样答案的问题，几乎说不出回答它的人是什么样。" },
    ],
  },
  nl: {
    term: "Grim-keeping",
    summary:
      "Een band bouwen op de dingen waar jullie allebei niet tegen kunnen — hetzelfde met de ogen rollen, dezelfde ergernissen — in plaats van op wat jullie allebei mooi vinden.",
    blocks: [
      { type: "h2", text: "Waarom een gedeelde afkeer zo snel aanslaat" },
      { type: "p", text: "Het Cambridge Dictionary zette het woord in januari 2026 op zijn lijst van nieuwe woorden, met als omschrijving: een relatie met iemand aangaan op basis van dezelfde dingen niet leuk vinden. Nieuw is de naam, niet de aantrekkingskracht. Wie ooit zo’n eerste date van beleefd naar makkelijk heeft zien omslaan op het moment dat allebei toegeven dat ze een hekel hebben aan hetzelfde, heeft het al zien werken." },
      { type: "p", text: "Achter dat gevoel zit onderzoek, en dat is ouder dan het woord. In **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer en Swann, Personal Relationships, 2006) vonden twee enquêtes en een experiment dat het ontdekken van een gedeelde negatieve houding over iemand sterker voorspelde of je een onbekende aardig vond dan het ontdekken van een gedeelde positieve houding — maar alleen wanneer die houdingen om te beginnen mild waren. De auteurs lezen het zo: een gedeelde afkeer trekt een lijn om jullie tweeën heen en zegt, anders dan brede instemming, iets specifieks over degene die haar heeft. Het deel om even bij stil te staan is dat de deelnemers het omgekeerd hadden: gevraagd wat mensen dichter bij elkaar zou brengen, zeiden ze stellig dat het delen van wat je leuk vindt dat doet." },
      { type: "h2", text: "Hoe je het patroon herkent" },
      {
        type: "ul",
        items: [
          "Het gesprek is op zijn snelst en zijn grappigst wanneer het gaat over iets waar jullie allebei tegen zijn.",
          "Je weet tot in detail waar diegene niet tegen kan, en alleen in grote lijnen waar diegene van houdt.",
          "Plannen ontstaan rond het vermijden van dingen in plaats van rond iets doen.",
          "Als het gedeelde mikpunt er niet is — de ex, het werk, de rage van dit moment — valt het gesprek stil.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je ermee kunt" },
      { type: "p", text: "Zie het niet als een fout. Een gedeelde afkeer is echte informatie en vaak het eerste eerlijke dat twee onbekenden tegen elkaar zeggen; de studie verklaart zelf dat het meer prijsgeeft dan het eens zijn over iets aangenaams. De enige vraag is of het het hele fundament is. Noem eens één ding waar je echt van houdt en kijk of het gesprek die toonwisseling overleeft — dat is een goedkope test en hij zegt veel." },
      { type: "p", text: "Het risico is niet de negativiteit, maar wat er gebeurt als het mikpunt verdwijnt. Een band die op een gemeenschappelijke vijand is gebouwd, heeft die vijand nodig. Merk je dat de goede uren de klaaguren zijn, dan is de oplossing niet minder klagen maar uitzoeken of er iets is waar jullie allebei vóór zijn. En dezelfde logica loopt door elke vraag die het waard is om iemand te stellen: een vraag waarop iedereen hetzelfde antwoordt, zegt bijna niets over degene die hem beantwoordt." },
    ],
  },
  pl: {
    term: "Grim-keeping",
    summary:
      "Budowanie relacji na tym, czego nie znosicie, zamiast na tym, co lubicie — na wspólnym przewracaniu oczami i tych samych rzeczach, które doprowadzają was do szału.",
    blocks: [
      { type: "h2", text: "Dlaczego wspólna niechęć trafia tak szybko" },
      { type: "p", text: "Cambridge Dictionary dopisał to słowo do swojej listy nowych wyrazów w styczniu 2026 roku, definiując je jako budowanie relacji z kimś na gruncie niechęci do tych samych rzeczy. Nowa jest nazwa, nie samo przyciąganie. Każdy, kto widział, jak pierwsza randka przechodzi z uprzejmej w swobodną dokładnie w chwili, gdy obie osoby przyznają, że nie cierpią tego samego, już wie, że to działa." },
      { type: "p", text: "Za tym wrażeniem stoją badania — starsze niż samo słowo. W **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer i Swann, Personal Relationships, 2006) dwa sondaże i eksperyment wykazały, że odkrycie wspólnej negatywnej opinii o kimś zapowiadało sympatię do nieznajomej osoby silniej niż odkrycie wspólnej opinii pozytywnej — ale tylko wtedy, gdy postawy były na początku umiarkowane. Autorzy tłumaczą to tak: wspólna niechęć zakreśla linię wokół was dwojga i, inaczej niż szeroka aprobata, mówi coś konkretnego o osobie, która ją żywi. Najciekawsze jest to, że uczestnicy mieli to odwrotnie: zapytani, co zbliża ludzi do siebie, bez wahania odpowiadali: dzielenie się tym, co się lubi." },
      { type: "h2", text: "Jak rozpoznać ten schemat" },
      {
        type: "ul",
        items: [
          "Rozmowa nabiera tempa i humoru dopiero wtedy, gdy tematem jest coś, czego nie znosicie.",
          "Wiesz w szczegółach, czego druga osoba nie znosi, a to, co lubi, znasz tylko w zarysie.",
          "Plany powstają wokół unikania czegoś, a nie wokół zrobienia czegoś razem.",
          "Kiedy wspólnego obiektu niechęci nie ma w pobliżu — dawnego związku, pracy, jakiegoś trendu — rozmowa cichnie.",
        ],
      },
      { type: "h2", accent: "green", text: "Co możesz z tym zrobić" },
      { type: "p", text: "Nie traktuj tego jak wady. Wspólna niechęć to realna informacja i często pierwsza szczera rzecz, jaką mówią sobie dwie obce osoby; własne wyjaśnienie autorów badania jest takie, że zdradza ona więcej niż zgoda co do czegoś przyjemnego. Pytanie jest tylko jedno: czy to cały fundament. Spróbuj nazwać jedną rzecz, którą naprawdę lubisz, i sprawdź, czy rozmowa przetrwa tę zmianę tonacji — to tani test, a mówi bardzo dużo." },
      { type: "p", text: "Ryzykiem nie jest negatywność, tylko to, co się dzieje, kiedy obiekt niechęci znika. Więź zbudowana na wspólnym wrogu potrzebuje tego wroga. Jeśli zauważasz, że dobre godziny to godziny narzekania, rozwiązaniem nie jest narzekać mniej, tylko sprawdzić, czy jest coś, za czym stoicie razem. Ta sama logika przechodzi przez każde pytanie, które warto komuś zadać: takie, na które wszyscy odpowiadają tak samo, nie mówi prawie nic o osobie, która odpowiada." },
    ],
  },
  sv: {
    term: "Grim-keeping",
    summary:
      "Att bygga en kontakt på det ni båda inte står ut med — det gemensamma himlandet med ögonen, samma återkommande irritationer — snarare än på det ni båda tycker om.",
    blocks: [
      { type: "h2", text: "Varför en delad motvilja går fram så snabbt" },
      { type: "p", text: "Cambridge Dictionary förde upp ordet på sin bevakningslista över nya ord i januari 2026 och definierade det som att bygga en relation med någon utifrån att ogilla samma saker. Namnet är nytt; dragningen är det inte. Den som har sett en första dejt gå från artig till lättsam i samma stund som båda erkänner att de avskyr samma sak har redan sett det fungera." },
      { type: "p", text: "Det finns forskning bakom känslan, och den är äldre än ordet. I **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer och Swann, Personal Relationships, 2006) fann två enkätstudier och ett experiment att upptäckten av en delad negativ inställning till någon förutsade att man tyckte om en främling starkare än vad upptäckten av en delad positiv inställning gjorde — men bara när inställningarna var milda från början. Författarnas tolkning är att en delad motvilja drar en linje runt just er två och, till skillnad från bred uppskattning, säger något specifikt om den som bär den. Det som är värt att stanna vid är att deltagarna hade det bakvänt: tillfrågade om vad som för människor närmare varandra svarade de utan tvekan att det är att dela det man gillar." },
      { type: "h2", text: "Så känner du igen mönstret" },
      {
        type: "ul",
        items: [
          "Samtalet är som snabbast och roligast när det handlar om något ni båda är emot.",
          "Du vet i detalj vad den andra inte står ut med, och bara i grova drag vad hen tycker om.",
          "Planer görs upp kring att undvika saker snarare än kring att göra något.",
          "När den gemensamma måltavlan inte är närvarande — exet, jobbet, trenden — blir samtalet tyst.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra med det" },
      { type: "p", text: "Se det inte som ett fel. En delad motvilja är verklig information och ofta det första ärliga som två främlingar säger till varandra; studiens egen förklaring är att den avslöjar mer än vad enighet om något trevligt gör. Frågan är bara om den är hela grunden. Pröva att nämna en sak du faktiskt tycker om och se om samtalet överlever tonartsbytet — det är ett billigt test och det säger en hel del." },
      { type: "p", text: "Risken är inte negativiteten, utan vad som händer när måltavlan försvinner. Ett band byggt på en gemensam fiende behöver fienden. Om du märker att de bästa stunderna är de då ni klagar, är lösningen inte att klaga mindre, utan att ta reda på om det finns något ni båda är för. Och samma logik löper genom varje fråga som är värd att ställa någon: en fråga som alla besvarar likadant säger nästan ingenting om den som svarar." },
    ],
  },
  hi: {
    term: "साझा नापसंद का रिश्ता",
    summary:
      "रिश्ते की बुनियाद उन चीज़ों पर रखना जो आप दोनों को बर्दाश्त नहीं — वही एक साथ घूमती आँखें, वही एक जैसी चिढ़ — न कि उन चीज़ों पर जो आप दोनों को पसंद हैं।",
    blocks: [
      { type: "h2", text: "एक साझा नापसंद इतनी जल्दी क्यों जोड़ देती है" },
      { type: "p", text: "Cambridge Dictionary ने जनवरी 2026 में grim-keeping को अपनी नए शब्दों की सूची में जोड़ा और इसका मतलब बताया: एक जैसी चीज़ों को नापसंद करने के आधार पर किसी से रिश्ता बनाना। नाम नया है, खिंचाव नहीं। जिसने भी किसी पहली मुलाक़ात को उस पल में औपचारिक से सहज होते देखा है जब दोनों ने मान लिया कि उन्हें एक ही चीज़ से चिढ़ है, वह इसे काम करते देख चुका है।" },
      { type: "p", text: "इस एहसास के पीछे शोध भी है, और वह इस शब्द से पुराना है। **Interpersonal chemistry through negativity** (Bosson, Johnson, Niederhoffer और Swann, Personal Relationships, 2006) में दो सर्वे और एक प्रयोग ने पाया कि किसी के बारे में एक जैसी नकारात्मक राय का पता चलना, किसी अजनबी को पसंद करने की भविष्यवाणी एक जैसी सकारात्मक राय के पता चलने से ज़्यादा मज़बूती से करता था — लेकिन सिर्फ़ तब, जब ये राय शुरुआत में हल्की थीं। लेखकों की व्याख्या यह है कि एक साझा नापसंद आप दोनों के इर्द-गिर्द एक लकीर खींच देती है और, आम तारीफ़ के उलट, उसे रखने वाले इंसान के बारे में कुछ ख़ास बताती है। ठहरकर सोचने लायक़ हिस्सा यह है कि प्रतिभागियों ने इसे उल्टा समझा था: जब उनसे पूछा गया कि लोगों को क्या क़रीब लाएगा, तो उन्होंने पूरे यक़ीन से कहा — जो पसंद है उसे साझा करना।" },
      { type: "h2", text: "इस पैटर्न को कैसे पहचानें" },
      {
        type: "ul",
        items: [
          "बातचीत सबसे तेज़ और सबसे मज़ेदार तब होती है जब वह किसी ऐसी चीज़ पर हो जिसके ख़िलाफ़ आप दोनों हैं।",
          "उसे किन चीज़ों से चिढ़ है, यह आप बारीकी से जानते हैं; उसे क्या पसंद है, यह बस मोटे तौर पर।",
          "योजनाएँ कुछ करने के बजाय किसी चीज़ से बचने के इर्द-गिर्द बनती हैं।",
          "जब साझा निशाना सामने न हो — वह एक्स, वह नौकरी, वह ट्रेंड — तो बातचीत ठंडी पड़ जाती है।",
        ],
      },
      { type: "h2", accent: "green", text: "इसका क्या किया जाए" },
      { type: "p", text: "इसे ख़ामी मत मानिए। साझा नापसंद असली जानकारी है और अक्सर वह पहली सच्ची बात होती है जो दो अजनबी एक-दूसरे से कहते हैं; अध्ययन की अपनी व्याख्या भी यही है कि किसी सुखद बात पर सहमति के मुक़ाबले यह इंसान के बारे में ज़्यादा कुछ खोलकर रख देती है। सवाल सिर्फ़ इतना है कि क्या यही पूरी बुनियाद है। एक चीज़ का नाम लेकर बताइए जो आपको सचमुच पसंद है, और देखिए कि सुर बदलने के बाद बातचीत टिकती है या नहीं — यह सस्ता इम्तिहान है और बहुत कुछ बता देता है।" },
      { type: "p", text: "ख़तरा नकारात्मकता नहीं है, ख़तरा यह है कि निशाना हट जाने पर क्या बचता है। साझा दुश्मन पर टिके रिश्ते को उस दुश्मन की ज़रूरत बनी रहती है। अगर आपको लगे कि अच्छे घंटे शिकायत वाले घंटे ही हैं, तो हल कम शिकायत करना नहीं, बल्कि यह पता लगाना है कि कोई चीज़ ऐसी भी है या नहीं जिसके पक्ष में आप दोनों हों। यही तर्क किसी से पूछने लायक़ हर सवाल पर लागू होता है: जिस सवाल का जवाब सब एक जैसा देते हैं, वह जवाब देने वाले के बारे में लगभग कुछ नहीं बताता।" },
    ],
  },
};
