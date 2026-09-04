import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Compatibility — how well two people actually fit, as opposed to the score a
 * quiz claims to compute.
 *
 * JUDGEMENT CALLS a later editor should not undo by accident:
 *
 * - This page argues AGAINST the pop version of the term on purpose. The
 *   percentage-from-a-questionnaire idea is named and then refused. Softening
 *   that back into "find your 97% match" energy would contradict both the
 *   research cited here and the sibling article
 *   `blog/[slug]/_content/what-actually-predicts-compatibility.ts`.
 * - Two academic sources are named inline (Finkel et al., 2012, Psychological
 *   Science in the Public Interest; Joel, Eastwick et al., 2020, PNAS) and no
 *   figure is quoted from either — the claims are directional, not numeric, so
 *   there is no bare statistic to source. Do not "improve" these sentences by
 *   adding effect sizes; if a number goes in, the full citation has to go with
 *   it. Neither source is a dating app, which is why they may be named at all.
 * - Block 7 is deliberately the opposite of a product pitch: it states plainly
 *   that Qulo's questions do NOT measure compatibility, only attention. That
 *   sentence is the point of the block. It must never be rewritten into a claim
 *   that solving someone's questions predicts fit, and it must never imply the
 *   app verifies identity or assesses personality — it does neither.
 *
 * TERM NAMES: most languages have a real word here and it is used (uyum,
 * compatibilité, совместимость, 相性, 궁합, 契合度, अनुकूलता). Only pl reuses a
 * word that also serves elsewhere ("dopasowanie"); the pl `match` entry keeps
 * the loanword "match", so the two headings stay distinct.
 */
export const compatibility: LocalizedGlossaryEntry = {
  en: {
    term: "Compatibility",
    summary:
      "How well two people actually fit in daily life — not a percentage a quiz can hand you, but something that only becomes visible in how two people treat each other once they are in it.",
    blocks: [
      { type: "h2", text: "Why the word promises more than it can deliver" },
      { type: "p", text: "The pop version of compatibility is a number: fill in a questionnaire, get a percentage, meet the person the percentage points at. The idea appeals because it turns something slow and uncertain into something you can read off a screen. It is also the version with the least evidence behind it. A 2012 review in Psychological Science in the Public Interest by Finkel and colleagues went through matching algorithms one by one and found no compelling evidence that any of them work." },
      { type: "p", text: "What does predict how a relationship goes turns out to be relational rather than personal. Joel, Eastwick and their co-authors, writing in PNAS in 2020, found that how two partners experienced the relationship itself predicted its quality far better than the traits either of them brought into it. None of that exists before people meet, and none of it fits on a profile." },
      { type: "h2", text: "What it actually looks like" },
      { type: "ul", items: [
        "**How you argue.** Whether a disagreement ends in repair or in scorekeeping says more than any shared hobby.",
        "**Whether you want the same shape of life.** Children, city, money, how much time alone — the boring questions decide the most.",
        "**How you are treated when you are inconvenient.** Tired, wrong, ill, busy: that is where the answer lives.",
        "**Pace.** Two people who need roughly the same speed rarely have to negotiate for it.",
      ] },
      { type: "h2", accent: "green", text: "How to find out, since you cannot measure it" },
      { type: "p", text: "Stop testing and start noticing. Disagree early about something small and watch what happens next — that is the closest thing to a compatibility test there is. Say a real preference out loud and see whether it gets heard or managed. Notice how someone talks about the last person who let them down. Compatibility is slow to confirm, but incompatibility usually shows up early, and it announces itself quietly rather than dramatically." },
      { type: "p", text: "One honest note about Qulo: the questions someone answers to reach you are not a compatibility test either. Getting them all right does not mean that person suits you. What the questions measure is attention — whether a stranger read what you wrote and thought about it before knocking. That is a much smaller claim, and it is the true one." },
    ],
  },
  tr: {
    term: "Uyum",
    summary:
      "İki insanın gündelik hayatta gerçekte birbirine ne kadar denk düştüğü. Bir testin verdiği yüzde değildir; ancak ilişkinin içine girildikten sonra, iki kişinin birbirine nasıl davrandığında görünür hale gelir.",
    blocks: [
      { type: "h2", text: "Kelime neden tutamayacağı bir söz veriyor" },
      { type: "p", text: "Uyumun popüler hali bir sayıdır: bir test doldurun, bir yüzde alın, o yüzdenin işaret ettiği kişiyle tanışın. Fikir cazip, çünkü yavaş ve belirsiz olanı ekranda okunabilir bir şeye çeviriyor. Arkasında en az kanıt bulunan hali de bu. Finkel ve arkadaşlarının 2012'de Psychological Science in the Public Interest dergisinde yayımladığı derleme, eşleştirme algoritmalarını tek tek inceledi ve hiçbirinin işe yaradığına dair ikna edici bir kanıt bulamadı." },
      { type: "p", text: "Bir ilişkinin nasıl gideceğini asıl öngören şeyler kişisel değil, ilişkisel çıkıyor. Joel, Eastwick ve ortak yazarlarının 2020'de PNAS'ta yayımladığı çalışma, iki kişinin ilişkiyi nasıl deneyimlediğinin, ilişkiye getirdikleri kişisel özelliklerden çok daha iyi bir yordayıcı olduğunu buldu. Bunların hiçbiri insanlar tanışmadan önce yoktur ve hiçbiri bir profile sığmaz." },
      { type: "h2", text: "Gerçekte neye benzer" },
      { type: "ul", items: [
        "**Nasıl tartıştığınız.** Bir anlaşmazlığın onarımla mı yoksa puan tutmayla mı bittiği, ortak hobilerden çok şey anlatır.",
        "**Aynı hayat biçimini isteyip istemediğiniz.** Çocuk, şehir, para, ne kadar yalnız kalmaya ihtiyaç duyduğunuz — en sıkıcı sorular en çok belirleyen sorulardır.",
        "**Zahmet verdiğiniz anda size nasıl davranıldığı.** Yorgunken, haksızken, hastayken, meşgulken: cevap oradadır.",
        "**Tempo.** Aşağı yukarı aynı hıza ihtiyaç duyan iki kişi bunun için pazarlık etmek zorunda kalmaz.",
      ] },
      { type: "h2", accent: "green", text: "Ölçülemiyorsa nasıl anlaşılır" },
      { type: "p", text: "Test etmeyi bırakın, fark etmeye başlayın. Erken bir aşamada küçük bir konuda anlaşmazlığa düşün ve sonrasında ne olduğuna bakın; uyum testine en çok benzeyen şey budur. Gerçek bir tercihinizi yüksek sesle söyleyin, duyuluyor mu yoksa idare mi ediliyor görün. Kendisini son hayal kırıklığına uğratan kişiyi nasıl anlattığına dikkat edin. Uyumun doğrulanması yavaştır ama uyumsuzluk genellikle erken belli olur ve kendini gürültüyle değil sessizce gösterir." },
      { type: "p", text: "Qulo hakkında dürüst bir not: birinin size ulaşmak için cevapladığı sorular da bir uyum testi değildir. Hepsini doğru bilmek, o kişinin size uygun olduğu anlamına gelmez. Sorular dikkati ölçer — bir yabancının yazdıklarınızı okuyup üzerine düşünüp düşünmediğini. Bu çok daha küçük bir iddiadır ve doğru olan da budur." },
    ],
  },
  de: {
    term: "Kompatibilität",
    summary:
      "Wie gut zwei Menschen im Alltag tatsächlich zusammenpassen — kein Prozentwert, den ein Test ausrechnet, sondern etwas, das erst darin sichtbar wird, wie zwei Menschen miteinander umgehen, wenn sie schon mittendrin sind.",
    blocks: [
      { type: "h2", text: "Warum das Wort mehr verspricht, als es halten kann" },
      { type: "p", text: "Die populäre Version von Kompatibilität ist eine Zahl: Fragebogen ausfüllen, Prozentwert bekommen, die Person treffen, auf die der Prozentwert zeigt. Der Gedanke ist verlockend, weil er etwas Langsames und Ungewisses in etwas verwandelt, das man vom Bildschirm ablesen kann. Es ist zugleich die Version mit der dünnsten Beleglage. Eine 2012 in Psychological Science in the Public Interest erschienene Übersichtsarbeit von Finkel und Kolleginnen und Kollegen ging Matching-Algorithmen einzeln durch und fand keinen überzeugenden Beleg dafür, dass einer davon funktioniert." },
      { type: "p", text: "Was den Verlauf einer Beziehung tatsächlich vorhersagt, ist nicht persönlich, sondern beziehungsbezogen. Joel, Eastwick und ihre Mitautorinnen und Mitautoren zeigten 2020 in PNAS, dass die Art, wie zwei Menschen die Beziehung selbst erleben, deren Qualität deutlich besser vorhersagt als die Eigenschaften, die beide mitbringen. Nichts davon existiert, bevor man sich begegnet, und nichts davon passt in ein Profil." },
      { type: "h2", text: "Woran man es wirklich erkennt" },
      { type: "ul", items: [
        "**Wie ihr streitet.** Ob ein Konflikt in Versöhnung endet oder im Punktezählen, sagt mehr als jedes gemeinsame Hobby.",
        "**Ob ihr dieselbe Form von Leben wollt.** Kinder, Stadt, Geld, wie viel Zeit für sich — die langweiligen Fragen entscheiden am meisten.",
        "**Wie du behandelt wirst, wenn du gerade unpassend bist.** Müde, im Unrecht, krank, im Stress: genau dort liegt die Antwort.",
        "**Tempo.** Zwei Menschen, die ungefähr dieselbe Geschwindigkeit brauchen, müssen darüber nicht verhandeln.",
      ] },
      { type: "h2", accent: "green", text: "Wie du es herausfindest, wenn du es nicht messen kannst" },
      { type: "p", text: "Hör auf zu testen und fang an zu bemerken. Sei früh bei etwas Kleinem anderer Meinung und schau, was danach passiert — näher kommt man einem Kompatibilitätstest nicht. Sprich einen echten Wunsch laut aus und sieh, ob er gehört oder verwaltet wird. Achte darauf, wie jemand über die letzte Person spricht, die ihn enttäuscht hat. Passung braucht Zeit, bis sie sich bestätigt; Unpassung zeigt sich meist früh — und eher leise als dramatisch." },
      { type: "p", text: "Eine ehrliche Anmerkung zu Qulo: Auch die Fragen, die jemand beantwortet, um dich zu erreichen, sind kein Kompatibilitätstest. Alles richtig zu haben heißt nicht, dass diese Person zu dir passt. Was die Fragen messen, ist Aufmerksamkeit — ob eine fremde Person gelesen und mitgedacht hat, bevor sie anklopft. Das ist ein viel kleinerer Anspruch, und es ist der zutreffende." },
    ],
  },
  fr: {
    term: "Compatibilité",
    summary:
      "À quel point deux personnes s'accordent réellement au quotidien — non pas un pourcentage sorti d'un test, mais quelque chose qui n'apparaît que dans la façon dont deux personnes se traitent une fois qu'elles y sont.",
    blocks: [
      { type: "h2", text: "Pourquoi le mot promet plus qu'il ne peut tenir" },
      { type: "p", text: "La version populaire de la compatibilité, c'est un chiffre : on remplit un questionnaire, on obtient un pourcentage, on rencontre la personne que ce pourcentage désigne. L'idée séduit parce qu'elle transforme quelque chose de lent et d'incertain en quelque chose qui se lit sur un écran. C'est aussi la version la moins étayée. Une revue publiée en 2012 dans Psychological Science in the Public Interest par Finkel et ses collègues a passé les algorithmes d'appariement au crible et n'a trouvé aucune preuve convaincante qu'ils fonctionnent." },
      { type: "p", text: "Ce qui prédit vraiment le cours d'une relation est relationnel, pas personnel. Joel, Eastwick et leurs co-auteurs, dans PNAS en 2020, ont montré que la manière dont deux partenaires vivent la relation elle-même prédit sa qualité bien mieux que les traits que chacun y apporte. Rien de tout cela n'existe avant la rencontre, et rien de tout cela ne tient dans un profil." },
      { type: "h2", text: "À quoi ça ressemble vraiment" },
      { type: "ul", items: [
        "**Votre façon de vous disputer.** Qu'un désaccord se termine par une réparation ou par un décompte de points en dit plus que n'importe quel loisir commun.",
        "**Vouloir la même forme de vie.** Enfants, ville, argent, besoin de solitude : ce sont les questions ennuyeuses qui tranchent.",
        "**Comment on vous traite quand vous dérangez.** Fatigué, dans l'erreur, malade, débordé : la réponse est là.",
        "**Le rythme.** Deux personnes qui ont besoin de la même vitesse n'ont pas à négocier pour l'obtenir.",
      ] },
      { type: "h2", accent: "green", text: "Comment le savoir, puisque ça ne se mesure pas" },
      { type: "p", text: "Arrêtez de tester, commencez à observer. Soyez en désaccord tôt, sur un détail, et regardez ce qui suit : c'est ce qui ressemble le plus à un test de compatibilité. Formulez une vraie préférence à voix haute et voyez si elle est entendue ou gérée. Écoutez comment l'autre parle de la dernière personne qui l'a déçu. La compatibilité met du temps à se confirmer ; l'incompatibilité, elle, se signale tôt, et sans bruit." },
      { type: "p", text: "Une remarque honnête sur Qulo : les questions auxquelles quelqu'un répond pour vous joindre ne sont pas non plus un test de compatibilité. Tout deviner ne veut pas dire que cette personne vous convient. Ce que les questions mesurent, c'est l'attention — si un inconnu a lu ce que vous avez écrit et y a réfléchi avant de frapper. C'est une promesse bien plus modeste, et c'est la vraie." },
    ],
  },
  es: {
    term: "Compatibilidad",
    summary:
      "Lo bien que dos personas encajan de verdad en el día a día: no un porcentaje que te entrega un test, sino algo que solo se ve en cómo se tratan dos personas cuando ya están dentro.",
    blocks: [
      { type: "h2", text: "Por qué la palabra promete más de lo que puede cumplir" },
      { type: "p", text: "La versión popular de la compatibilidad es un número: rellenas un cuestionario, obtienes un porcentaje y conoces a la persona que ese porcentaje señala. La idea atrae porque convierte algo lento e incierto en algo que se lee en una pantalla. También es la versión con menos pruebas detrás. Una revisión publicada en 2012 en Psychological Science in the Public Interest por Finkel y sus colegas repasó los algoritmos de emparejamiento uno a uno y no encontró pruebas convincentes de que ninguno funcione." },
      { type: "p", text: "Lo que sí predice cómo va una relación resulta ser relacional, no personal. Joel, Eastwick y sus coautores, en PNAS en 2020, hallaron que cómo viven dos personas la relación en sí predice su calidad mucho mejor que los rasgos que cada uno trae consigo. Nada de eso existe antes de conocerse, y nada de eso cabe en un perfil." },
      { type: "h2", text: "Qué aspecto tiene de verdad" },
      { type: "ul", items: [
        "**Cómo discutís.** Que un desacuerdo acabe en reparación o en llevar la cuenta dice más que cualquier afición compartida.",
        "**Si queréis la misma forma de vida.** Hijos, ciudad, dinero, cuánto tiempo a solas: las preguntas aburridas son las que deciden.",
        "**Cómo te tratan cuando resultas incómodo.** Cansado, equivocado, enfermo, sin tiempo: ahí está la respuesta.",
        "**El ritmo.** Dos personas que necesitan más o menos la misma velocidad no tienen que negociarla.",
      ] },
      { type: "h2", accent: "green", text: "Cómo averiguarlo, ya que no se puede medir" },
      { type: "p", text: "Deja de hacer tests y empieza a fijarte. Discrepa pronto en algo pequeño y mira qué pasa después: eso es lo más parecido a una prueba de compatibilidad que existe. Di una preferencia real en voz alta y comprueba si te escuchan o te gestionan. Fíjate en cómo habla de la última persona que le decepcionó. La compatibilidad tarda en confirmarse; la incompatibilidad suele avisar pronto, y lo hace en voz baja." },
      { type: "p", text: "Una nota honesta sobre Qulo: las preguntas que alguien responde para llegar hasta ti tampoco son un test de compatibilidad. Acertarlas todas no significa que esa persona te convenga. Lo que miden las preguntas es atención: si un desconocido leyó lo que escribiste y lo pensó antes de llamar a la puerta. Es una afirmación mucho más pequeña, y es la verdadera." },
    ],
  },
  ar: {
    term: "توافق",
    summary:
      "مدى انسجام شخصين فعليًا في الحياة اليومية. ليس نسبة مئوية يمنحها اختبار، بل شيء لا يظهر إلا في طريقة معاملة كلٍّ منهما للآخر بعد أن يصبحا داخل العلاقة.",
    blocks: [
      { type: "h2", text: "لماذا تَعِد الكلمة بأكثر مما تستطيع" },
      { type: "p", text: "الصورة الشائعة للتوافق رقم: تملأ استبيانًا، تحصل على نسبة، ثم تقابل الشخص الذي تشير إليه النسبة. الفكرة مغرية لأنها تحوّل شيئًا بطيئًا وغير مؤكد إلى شيء يُقرأ على الشاشة. وهي أيضًا الصورة الأقل سندًا. مراجعة نشرها فينكل وزملاؤه عام 2012 في Psychological Science in the Public Interest فحصت خوارزميات المطابقة واحدة تلو الأخرى ولم تجد دليلًا مقنعًا على أن أيًّا منها يعمل." },
      { type: "p", text: "أما ما يتنبأ فعلًا بمسار العلاقة فهو علائقي لا شخصي. وجد جويل وإيستويك وزملاؤهما، في دورية PNAS عام 2020، أن طريقة اختبار الطرفين للعلاقة نفسها تتنبأ بجودتها أفضل بكثير من الصفات التي يجلبها كلٌّ منهما معه. ولا شيء من ذلك موجود قبل أن يلتقي الاثنان، ولا شيء منه يتّسع له ملف تعريف." },
      { type: "h2", text: "كيف يبدو التوافق في الواقع" },
      { type: "ul", items: [
        "**كيف تختلفان.** أن ينتهي الخلاف بالإصلاح أو بحساب النقاط يقول أكثر من أي هواية مشتركة.",
        "**هل تريدان الشكل نفسه للحياة.** الأطفال، المدينة، المال، مقدار الوقت الذي تحتاجه وحدك — الأسئلة المملة هي التي تحسم.",
        "**كيف تُعامَل حين تكون عبئًا.** متعبًا، مخطئًا، مريضًا، مشغولًا: هناك تكمن الإجابة.",
        "**الإيقاع.** شخصان يحتاجان إلى السرعة نفسها تقريبًا لا يضطران للتفاوض عليها.",
      ] },
      { type: "h2", accent: "green", text: "كيف تعرف ما دام لا يُقاس" },
      { type: "p", text: "توقّف عن الاختبار وابدأ بالملاحظة. اختلف مبكرًا على أمر صغير وراقب ما يحدث بعده؛ هذا أقرب ما يوجد إلى اختبار توافق. قل تفضيلًا حقيقيًا بصوت مسموع وانظر: هل يُسمَع أم يُدار؟ لاحظ كيف يتحدث الشخص عن آخر من خذله. التوافق يحتاج وقتًا كي يتأكد، أما عدم التوافق فيظهر مبكرًا عادة، ويعلن عن نفسه بهدوء لا بضجيج." },
      { type: "p", text: "ملاحظة صادقة عن Qulo: الأسئلة التي يجيب عنها أحدهم للوصول إليك ليست اختبار توافق أيضًا. أن يصيبها كلها لا يعني أنه يناسبك. ما تقيسه الأسئلة هو الانتباه — هل قرأ الغريب ما كتبته وفكّر فيه قبل أن يطرق الباب. هذا ادّعاء أصغر بكثير، وهو الادّعاء الصحيح." },
    ],
  },
  ru: {
    term: "Совместимость",
    summary:
      "Насколько два человека на самом деле подходят друг другу в повседневности. Это не процент, который выдаёт тест, а то, что становится видно только в том, как двое обращаются друг с другом, когда уже вместе.",
    blocks: [
      { type: "h2", text: "Почему слово обещает больше, чем может дать" },
      { type: "p", text: "Популярная версия совместимости — это число: заполнить анкету, получить процент, встретить человека, на которого этот процент указывает. Идея привлекательна, потому что превращает медленное и неопределённое в то, что можно прочитать с экрана. И у неё же меньше всего доказательств. Обзор Финкеля и коллег, опубликованный в 2012 году в Psychological Science in the Public Interest, разобрал алгоритмы подбора один за другим и не нашёл убедительных свидетельств, что хоть один из них работает." },
      { type: "p", text: "То, что действительно предсказывает судьбу отношений, оказывается не личным, а отношенческим. Джоэл, Иствик и их соавторы в PNAS в 2020 году показали: то, как двое переживают сами отношения, предсказывает их качество куда лучше, чем черты, с которыми каждый пришёл. Ничего этого не существует до встречи и ничего из этого не помещается в анкету." },
      { type: "h2", text: "Как это выглядит на самом деле" },
      { type: "ul", items: [
        "**Как вы ссоритесь.** Заканчивается ли спор примирением или подсчётом очков — это говорит больше, чем любое общее хобби.",
        "**Хотите ли вы одинаковой формы жизни.** Дети, город, деньги, сколько времени наедине с собой — решают самые скучные вопросы.",
        "**Как с вами обходятся, когда вы неудобны.** Уставший, неправый, больной, занятой: ответ именно здесь.",
        "**Темп.** Двоим, которым нужна примерно одна скорость, не приходится о ней договариваться.",
      ] },
      { type: "h2", accent: "green", text: "Как это узнать, если измерить нельзя" },
      { type: "p", text: "Перестаньте проверять и начните замечать. Не согласитесь пораньше в чём-то мелком и посмотрите, что будет дальше, — ближе к тесту на совместимость ничего нет. Скажите вслух настоящее предпочтение и проверьте: его слышат или с ним справляются? Обратите внимание, как человек рассказывает о том, кто его в последний раз подвёл. Совместимость подтверждается долго, а несовместимость обычно заявляет о себе рано и негромко." },
      { type: "p", text: "Честное замечание про Qulo: вопросы, на которые отвечают, чтобы до вас добраться, — тоже не тест на совместимость. Ответить на все правильно не значит подойти вам. Вопросы измеряют внимание: прочитал ли незнакомый человек написанное вами и подумал ли над ним, прежде чем постучаться. Это гораздо более скромное утверждение — и верное." },
    ],
  },
  pt: {
    term: "Compatibilidade",
    summary:
      "O quanto duas pessoas realmente combinam no dia a dia: não uma porcentagem que um teste entrega, mas algo que só aparece no jeito como as duas se tratam depois que já estão dentro.",
    blocks: [
      { type: "h2", text: "Por que a palavra promete mais do que consegue cumprir" },
      { type: "p", text: "A versão popular da compatibilidade é um número: preencha um questionário, receba uma porcentagem, conheça a pessoa para quem essa porcentagem aponta. A ideia atrai porque transforma algo lento e incerto em algo que se lê numa tela. É também a versão com menos evidência por trás. Uma revisão publicada em 2012 na Psychological Science in the Public Interest, por Finkel e colegas, examinou os algoritmos de emparelhamento um a um e não encontrou evidência convincente de que algum deles funcione." },
      { type: "p", text: "O que de fato prevê o rumo de uma relação é relacional, não pessoal. Joel, Eastwick e seus coautores, na PNAS em 2020, mostraram que o modo como duas pessoas vivem a própria relação prevê a qualidade dela muito melhor do que as características que cada um levou para ali. Nada disso existe antes do encontro, e nada disso cabe num perfil." },
      { type: "h2", text: "Com o que ela se parece de verdade" },
      { type: "ul", items: [
        "**Como vocês discutem.** Se um desacordo termina em reparo ou em contagem de pontos diz mais do que qualquer gosto em comum.",
        "**Se vocês querem o mesmo formato de vida.** Filhos, cidade, dinheiro, quanto tempo sozinho: as perguntas chatas são as que decidem.",
        "**Como você é tratado quando dá trabalho.** Cansado, errado, doente, ocupado: é ali que está a resposta.",
        "**Ritmo.** Duas pessoas que precisam mais ou menos da mesma velocidade não precisam negociar por ela.",
      ] },
      { type: "h2", accent: "green", text: "Como descobrir, já que não dá para medir" },
      { type: "p", text: "Pare de testar e comece a reparar. Discorde cedo de alguma coisa pequena e veja o que acontece depois — é o mais perto de um teste de compatibilidade que existe. Diga uma preferência de verdade em voz alta e veja se ela é ouvida ou administrada. Repare em como a pessoa fala de quem a decepcionou por último. Compatibilidade demora a se confirmar; incompatibilidade costuma avisar cedo, e baixinho." },
      { type: "p", text: "Uma nota honesta sobre o Qulo: as perguntas que alguém responde para chegar até você também não são um teste de compatibilidade. Acertar todas não quer dizer que a pessoa combina com você. O que as perguntas medem é atenção — se um desconhecido leu o que você escreveu e pensou sobre isso antes de bater à porta. É uma afirmação bem menor, e é a verdadeira." },
    ],
  },
  it: {
    term: "Compatibilità",
    summary:
      "Quanto due persone si incastrano davvero nella vita di tutti i giorni: non una percentuale che ti consegna un test, ma qualcosa che si vede solo da come due persone si trattano quando ormai ci sono dentro.",
    blocks: [
      { type: "h2", text: "Perché la parola promette più di quanto possa mantenere" },
      { type: "p", text: "La versione pop della compatibilità è un numero: compili un questionario, ottieni una percentuale, incontri la persona che quella percentuale indica. L'idea attira perché trasforma qualcosa di lento e incerto in qualcosa che si legge su uno schermo. È anche la versione con meno prove alle spalle. Una rassegna pubblicata nel 2012 su Psychological Science in the Public Interest da Finkel e colleghi ha esaminato gli algoritmi di abbinamento uno per uno senza trovare prove convincenti che qualcuno di essi funzioni." },
      { type: "p", text: "Ciò che prevede davvero come andrà una relazione è relazionale, non personale. Joel, Eastwick e i loro coautori, su PNAS nel 2020, hanno mostrato che il modo in cui due partner vivono la relazione stessa ne prevede la qualità molto meglio dei tratti che ciascuno si porta dietro. Niente di tutto questo esiste prima dell'incontro, e niente di tutto questo entra in un profilo." },
      { type: "h2", text: "Che aspetto ha davvero" },
      { type: "ul", items: [
        "**Come litigate.** Se un disaccordo finisce in riparazione o in conteggio dei punti dice più di qualsiasi passione condivisa.",
        "**Se volete la stessa forma di vita.** Figli, città, soldi, quanto tempo da soli: sono le domande noiose a decidere.",
        "**Come vieni trattato quando sei scomodo.** Stanco, in torto, malato, di corsa: la risposta sta lì.",
        "**Il ritmo.** Due persone che hanno bisogno più o meno della stessa velocità non devono negoziarla.",
      ] },
      { type: "h2", accent: "green", text: "Come scoprirlo, visto che non si misura" },
      { type: "p", text: "Smetti di testare e comincia a notare. Non essere d'accordo presto, su una cosa piccola, e guarda cosa succede dopo: è la cosa più vicina a un test di compatibilità che esista. Di' una preferenza vera ad alta voce e vedi se viene ascoltata o gestita. Nota come parla dell'ultima persona che l'ha delusa. La compatibilità è lenta a confermarsi; l'incompatibilità di solito si annuncia presto, e sottovoce." },
      { type: "p", text: "Una nota onesta su Qulo: nemmeno le domande a cui qualcuno risponde per arrivare a te sono un test di compatibilità. Indovinarle tutte non significa che quella persona ti vada bene. Quello che le domande misurano è l'attenzione: se uno sconosciuto ha letto ciò che hai scritto e ci ha pensato prima di bussare. È una promessa molto più piccola, ed è quella vera." },
    ],
  },
  ja: {
    term: "相性",
    summary:
      "二人が実際の暮らしのなかでどれだけ噛み合うか。テストがはじき出す数字ではなく、関係の中に入ってから互いをどう扱うかにだけ表れるもの。",
    blocks: [
      { type: "h2", text: "この言葉が果たせない約束をする理由" },
      { type: "p", text: "相性の通俗版は数字だ。アンケートに答え、パーセンテージを受け取り、その数字が指す相手に会う。遅くて不確かなものを、画面で読める形に変えてくれるから魅力的に映る。同時に、最も裏づけの乏しい版でもある。フィンケルらが2012年に Psychological Science in the Public Interest 誌で発表したレビューは、マッチングアルゴリズムを一つずつ検討し、どれかが機能するという説得力のある証拠は見つからなかったと結論づけている。" },
      { type: "p", text: "関係の行方を実際に予測するのは、個人的なものではなく関係的なものだった。ジョエルとイーストウィックらが2020年に PNAS で示したのは、二人が関係そのものをどう経験しているかのほうが、それぞれが持ち込んだ性質よりもはるかによく関係の質を予測する、ということだ。どれも出会う前には存在せず、どれもプロフィールには収まらない。" },
      { type: "h2", text: "本当のところ、それはどう見えるか" },
      { type: "ul", items: [
        "**どう喧嘩するか。** 意見の食い違いが修復で終わるか、点数の勘定で終わるか。共通の趣味よりずっと多くを語る。",
        "**同じかたちの人生を望んでいるか。** 子ども、住む場所、お金、ひとりの時間の量。いちばん退屈な問いがいちばん決定的だ。",
        "**こちらが面倒な状態のとき、どう扱われるか。** 疲れているとき、間違えたとき、体調が悪いとき、余裕がないとき。答えはそこにある。",
        "**速度。** だいたい同じテンポを必要とする二人は、それについて交渉せずに済む。",
      ] },
      { type: "h2", accent: "green", text: "測れないものを、どう見極めるか" },
      { type: "p", text: "試すのをやめて、気づくことを始める。早い段階で小さなことに反対してみて、その後に何が起きるかを見る。相性テストにいちばん近いのはそれだ。本音の希望を口に出して、聞き届けられるのか、うまくあしらわれるのかを見る。最後に自分を失望させた相手のことをどう語るかにも注目する。相性の確認には時間がかかるが、合わないことはたいてい早く、そして静かに表に出る。" },
      { type: "p", text: "Qulo についても正直に書いておく。誰かがあなたに届くために答える質問も、相性テストではない。全問正解したからといって、その人があなたに合うわけではない。質問が測っているのは注意だ。見知らぬ人が、あなたの書いたものを読み、少し考えてからノックしたかどうか。それはずっと小さな主張であり、そして本当の主張でもある。" },
    ],
  },
  ko: {
    term: "궁합",
    summary:
      "두 사람이 실제 생활에서 얼마나 잘 맞는지. 테스트가 내주는 퍼센트가 아니라, 관계 안에 들어간 뒤 서로를 어떻게 대하는지에서만 드러나는 것.",
    blocks: [
      { type: "h2", text: "이 말이 지키지 못할 약속을 하는 이유" },
      { type: "p", text: "궁합의 대중적인 버전은 숫자다. 설문에 답하고 퍼센트를 받고, 그 숫자가 가리키는 사람을 만난다. 느리고 불확실한 것을 화면에서 읽을 수 있는 것으로 바꿔 주니 매력적으로 보인다. 동시에 근거가 가장 얇은 버전이기도 하다. 핑켈과 동료들이 2012년 Psychological Science in the Public Interest에 실은 리뷰는 매칭 알고리즘을 하나씩 검토한 뒤, 그중 어느 것이 작동한다는 설득력 있는 증거는 없다고 결론지었다." },
      { type: "p", text: "관계가 어떻게 흘러갈지를 실제로 예측하는 것은 개인적인 요소가 아니라 관계적인 요소였다. 조엘과 이스트윅을 비롯한 공저자들은 2020년 PNAS에서, 두 사람이 관계 자체를 어떻게 겪는지가 각자 가지고 들어온 특성보다 관계의 질을 훨씬 잘 예측한다는 것을 보여 주었다. 그 어느 것도 만나기 전에는 존재하지 않고, 프로필에 들어가지도 않는다." },
      { type: "h2", text: "실제로는 이런 모습이다" },
      { type: "ul", items: [
        "**어떻게 다투는가.** 다툼이 회복으로 끝나는지 점수 계산으로 끝나는지가 공통 취미보다 많은 것을 말해 준다.",
        "**같은 모양의 삶을 원하는가.** 아이, 도시, 돈, 혼자 있는 시간의 양 — 가장 지루한 질문이 가장 많이 결정한다.",
        "**내가 성가신 상태일 때 어떻게 대하는가.** 지쳤을 때, 틀렸을 때, 아플 때, 바쁠 때. 답은 거기 있다.",
        "**속도.** 비슷한 속도를 필요로 하는 두 사람은 그 문제로 협상할 일이 거의 없다.",
      ] },
      { type: "h2", accent: "green", text: "잴 수 없으니, 어떻게 알아볼까" },
      { type: "p", text: "시험하기를 그만두고 알아차리기를 시작하자. 초반에 사소한 것에서 한번 다른 의견을 내고, 그다음에 무슨 일이 일어나는지 보자. 세상에 있는 궁합 테스트 중 여기에 가장 가깝다. 진짜 원하는 바를 소리 내어 말하고, 그것이 들리는지 아니면 적당히 관리되는지 보자. 자신을 마지막으로 실망시킨 사람을 어떻게 이야기하는지도 눈여겨보자. 잘 맞는다는 것은 확인에 시간이 걸리지만, 안 맞는다는 것은 대개 일찍, 그리고 조용히 드러난다." },
      { type: "p", text: "Qulo에 대해서도 솔직히 적어 둔다. 누군가 당신에게 닿기 위해 푸는 질문 역시 궁합 테스트가 아니다. 전부 맞혔다고 해서 그 사람이 당신에게 맞는다는 뜻은 아니다. 질문이 재는 것은 주의력이다. 낯선 사람이 당신이 쓴 것을 읽고 잠깐 생각한 뒤에 문을 두드렸는지. 훨씬 작은 주장이고, 사실인 주장이다." },
    ],
  },
  zh: {
    term: "契合度",
    summary:
      "两个人在真实生活里到底有多合得来。它不是某个测试给出的百分比，而是只有在关系里、从两个人如何对待彼此当中才看得出来的东西。",
    blocks: [
      { type: "h2", text: "为什么这个词承诺了它兑现不了的东西" },
      { type: "p", text: "契合度的流行版本是一个数字：填一份问卷，得到一个百分比，去见这个百分比所指的人。这想法很吸引人，因为它把缓慢又不确定的事变成了屏幕上可以直接读的东西。它同时也是证据最薄的版本。芬克尔等人2012年发表在 Psychological Science in the Public Interest 上的综述逐一检视了配对算法，没有找到任何有说服力的证据能证明其中哪一种真的有效。" },
      { type: "p", text: "真正能预测一段关系走向的，是关系层面的东西，而不是个人层面的。乔尔、伊斯特威克与合作者2020年在 PNAS 上指出，两个人如何经历这段关系本身，对关系质量的预测力远高于各自带进来的个人特质。这些在两人见面之前都不存在，也没有一样能塞进一份资料里。" },
      { type: "h2", text: "它真实的样子" },
      { type: "ul", items: [
        "**你们怎么吵架。** 分歧以修补收场还是以记账收场，比任何共同爱好都说明问题。",
        "**是否想要同一种形状的人生。** 孩子、城市、钱、需要多少独处时间——最无聊的问题决定得最多。",
        "**当你添麻烦时，对方怎么待你。** 疲惫时、犯错时、生病时、忙不过来时，答案就在那里。",
        "**节奏。** 两个需要差不多速度的人，几乎不必为此讨价还价。",
      ] },
      { type: "h2", accent: "green", text: "既然量不出来，那怎么看得出来" },
      { type: "p", text: "别再测试，开始观察。早一点在小事上表达不同意见，然后看接下来发生了什么——这已经是最接近契合度测试的做法了。把一个真实的偏好说出口，看它是被听见，还是被安抚过去。留意对方怎么谈论上一个让他失望的人。合得来需要很久才能确认，合不来通常很早就露面，而且是安静地露面。" },
      { type: "p", text: "关于 Qulo 也说句实话：别人为了联系你而回答的那些题，同样不是契合度测试。全答对并不代表这个人适合你。题目衡量的是注意力——一个陌生人是否读过你写的东西、并在敲门之前想了一下。这是一个小得多的说法，也是那个成立的说法。" },
    ],
  },
  nl: {
    term: "Compatibiliteit",
    summary:
      "Hoe goed twee mensen in het dagelijks leven echt bij elkaar passen. Geen percentage dat een test je aanreikt, maar iets dat pas zichtbaar wordt in hoe twee mensen met elkaar omgaan als ze er eenmaal in zitten.",
    blocks: [
      { type: "h2", text: "Waarom het woord meer belooft dan het waarmaakt" },
      { type: "p", text: "De populaire versie van compatibiliteit is een getal: vul een vragenlijst in, krijg een percentage, ontmoet de persoon waar dat percentage naar wijst. Het idee spreekt aan omdat het iets traags en onzekers verandert in iets dat je van een scherm afleest. Het is ook de versie met het minste bewijs. Een overzichtsstudie uit 2012 in Psychological Science in the Public Interest van Finkel en collega's nam matching-algoritmes stuk voor stuk door en vond geen overtuigend bewijs dat er ook maar één werkt." },
      { type: "p", text: "Wat het verloop van een relatie wél voorspelt, blijkt relationeel te zijn en niet persoonlijk. Joel, Eastwick en hun coauteurs lieten in 2020 in PNAS zien dat hoe twee partners de relatie zelf ervaren de kwaliteit ervan veel beter voorspelt dan de eigenschappen die ieder meebrengt. Niets daarvan bestaat vóór de ontmoeting, en niets daarvan past op een profiel." },
      { type: "h2", text: "Hoe het er echt uitziet" },
      { type: "ul", items: [
        "**Hoe jullie ruziemaken.** Of een meningsverschil eindigt in herstel of in punten tellen, zegt meer dan welke gedeelde hobby ook.",
        "**Of jullie dezelfde vorm van leven willen.** Kinderen, stad, geld, hoeveel tijd alleen — de saaie vragen beslissen het meest.",
        "**Hoe je behandeld wordt als je even lastig uitkomt.** Moe, ongelijk, ziek, druk: daar zit het antwoord.",
        "**Tempo.** Twee mensen die ongeveer dezelfde snelheid nodig hebben, hoeven daar niet over te onderhandelen.",
      ] },
      { type: "h2", accent: "green", text: "Hoe je erachter komt, nu meten niet kan" },
      { type: "p", text: "Stop met testen en begin met opmerken. Wees vroeg oneens over iets kleins en kijk wat er daarna gebeurt — dichter bij een compatibiliteitstest kom je niet. Zeg een echte voorkeur hardop en kijk of die gehoord wordt of gemanaged. Let op hoe iemand praat over de laatste persoon die hem teleurstelde. Passen kost tijd om te bevestigen; niet passen meldt zich meestal vroeg, en zachtjes." },
      { type: "p", text: "Eén eerlijke opmerking over Qulo: ook de vragen die iemand beantwoordt om bij jou te komen zijn geen compatibiliteitstest. Alles goed hebben betekent niet dat iemand bij je past. Wat de vragen meten is aandacht — of een onbekende las wat jij schreef en erover nadacht voor hij aanklopte. Dat is een veel kleinere claim, en het is de kloppende." },
    ],
  },
  pl: {
    term: "Dopasowanie",
    summary:
      "To, jak bardzo dwoje ludzi naprawdę do siebie pasuje na co dzień. Nie procent, który wylicza test, tylko coś, co widać dopiero po tym, jak dwoje ludzi traktuje się nawzajem, gdy są już w środku.",
    blocks: [
      { type: "h2", text: "Dlaczego to słowo obiecuje więcej, niż może dać" },
      { type: "p", text: "Popularna wersja dopasowania to liczba: wypełnij ankietę, dostań procent, poznaj osobę, na którą ten procent wskazuje. Pomysł kusi, bo zamienia coś powolnego i niepewnego w coś, co da się odczytać z ekranu. Jest to zarazem wersja z najsłabszymi dowodami. Przegląd Finkela i współpracowników opublikowany w 2012 roku w Psychological Science in the Public Interest przeanalizował algorytmy dobierania par jeden po drugim i nie znalazł przekonujących dowodów, by którykolwiek z nich działał." },
      { type: "p", text: "To, co naprawdę przewiduje losy związku, okazuje się relacyjne, a nie osobiste. Joel, Eastwick i współautorzy pokazali w 2020 roku w PNAS, że sposób, w jaki dwoje partnerów przeżywa sam związek, przewiduje jego jakość znacznie lepiej niż cechy, z którymi każde z nich przyszło. Nic z tego nie istnieje przed spotkaniem i nic z tego nie mieści się w profilu." },
      { type: "h2", text: "Jak to naprawdę wygląda" },
      { type: "ul", items: [
        "**Jak się kłócicie.** To, czy spór kończy się naprawą, czy liczeniem punktów, mówi więcej niż wspólne hobby.",
        "**Czy chcecie takiego samego kształtu życia.** Dzieci, miasto, pieniądze, ile czasu dla siebie — najnudniejsze pytania rozstrzygają najwięcej.",
        "**Jak jesteś traktowany, kiedy jesteś niewygodny.** Zmęczony, w błędzie, chory, zajęty: tam jest odpowiedź.",
        "**Tempo.** Dwoje ludzi, którzy potrzebują mniej więcej tej samej prędkości, nie musi o nią negocjować.",
      ] },
      { type: "h2", accent: "green", text: "Jak to sprawdzić, skoro nie da się tego zmierzyć" },
      { type: "p", text: "Przestań testować, zacznij zauważać. Nie zgódź się wcześnie w drobnej sprawie i zobacz, co się potem dzieje — bliżej testu dopasowania nie da się podejść. Powiedz na głos prawdziwą preferencję i sprawdź, czy zostanie usłyszana, czy raczej obsłużona. Zwróć uwagę, jak druga osoba opowiada o kimś, kto ostatnio ją zawiódł. Dopasowanie potwierdza się powoli, a niedopasowanie zwykle zgłasza się wcześnie i po cichu." },
      { type: "p", text: "Uczciwa uwaga o Qulo: pytania, na które ktoś odpowiada, żeby do ciebie dotrzeć, też nie są testem dopasowania. Trafienie we wszystkie nie znaczy, że ta osoba do ciebie pasuje. Pytania mierzą uwagę — to, czy nieznajomy przeczytał to, co napisałeś, i pomyślał nad tym, zanim zapukał. To znacznie mniejsza obietnica i akurat prawdziwa." },
    ],
  },
  sv: {
    term: "Kompatibilitet",
    summary:
      "Hur väl två personer faktiskt passar ihop i vardagen. Inte en procentsats som ett test räknar fram, utan något som syns först i hur två människor behandlar varandra när de väl är i det.",
    blocks: [
      { type: "h2", text: "Varför ordet lovar mer än det kan hålla" },
      { type: "p", text: "Populärversionen av kompatibilitet är en siffra: fyll i ett formulär, få en procentsats, träffa personen som siffran pekar ut. Tanken lockar eftersom den gör något långsamt och osäkert till något man kan läsa av på en skärm. Det är också versionen med tunnast underlag. En översikt från 2012 i Psychological Science in the Public Interest av Finkel och kollegor gick igenom matchningsalgoritmer en efter en och fann inga övertygande belägg för att någon av dem fungerar." },
      { type: "p", text: "Det som faktiskt förutsäger hur en relation går visar sig vara relationellt, inte personligt. Joel, Eastwick och deras medförfattare visade i PNAS 2020 att hur två partner upplever själva relationen förutsäger dess kvalitet betydligt bättre än de egenskaper var och en bär med sig in. Inget av det finns innan man möts, och inget av det ryms i en profil." },
      { type: "h2", text: "Hur det ser ut på riktigt" },
      { type: "ul", items: [
        "**Hur ni bråkar.** Om en oenighet slutar i försoning eller i poängräkning säger mer än någon gemensam hobby.",
        "**Om ni vill ha samma form på livet.** Barn, stad, pengar, hur mycket tid för sig själv — de tråkiga frågorna avgör mest.",
        "**Hur du blir behandlad när du är besvärlig.** Trött, på fel spår, sjuk, stressad: där finns svaret.",
        "**Tempot.** Två personer som behöver ungefär samma hastighet slipper förhandla om den.",
      ] },
      { type: "h2", accent: "green", text: "Hur du tar reda på det, när det inte går att mäta" },
      { type: "p", text: "Sluta testa och börja lägga märke till. Var oense tidigt om något litet och se vad som händer sedan — närmare ett kompatibilitetstest kommer man inte. Säg en riktig önskan högt och se om den hörs eller hanteras. Lägg märke till hur den andra pratar om den senaste som svek. Kompatibilitet tar tid att bekräfta; det som inte passar brukar däremot märkas tidigt, och tyst." },
      { type: "p", text: "En ärlig anmärkning om Qulo: frågorna någon svarar på för att nå dig är inte heller ett kompatibilitetstest. Att ha alla rätt betyder inte att personen passar dig. Det frågorna mäter är uppmärksamhet — om en främling läste det du skrev och tänkte efter innan hen knackade på. Det är ett mycket mindre anspråk, och det är det sanna." },
    ],
  },
  hi: {
    term: "अनुकूलता",
    summary:
      "दो लोग रोज़मर्रा की ज़िंदगी में एक-दूसरे के साथ सचमुच कितना निभा पाते हैं। यह किसी टेस्ट से मिला प्रतिशत नहीं, बल्कि वह चीज़ है जो रिश्ते के भीतर आने के बाद, एक-दूसरे के साथ किए गए बर्ताव में ही दिखती है।",
    blocks: [
      { type: "h2", text: "यह शब्द वह वादा क्यों करता है जो निभा नहीं सकता" },
      { type: "p", text: "अनुकूलता का लोकप्रिय रूप एक संख्या है: एक सवालनामा भरिए, एक प्रतिशत पाइए, और उस प्रतिशत के बताए इंसान से मिलिए। विचार आकर्षक लगता है, क्योंकि यह धीमी और अनिश्चित चीज़ को स्क्रीन पर पढ़ी जा सकने वाली चीज़ में बदल देता है। यही वह रूप भी है जिसके पीछे सबसे कम सबूत हैं। फ़िंकल और उनके साथियों की 2012 में Psychological Science in the Public Interest में छपी समीक्षा ने मैचिंग एल्गोरिद्म एक-एक कर परखे और कोई ठोस सबूत नहीं पाया कि उनमें से कोई काम करता है।" },
      { type: "p", text: "रिश्ते की दिशा असल में जो चीज़ें बताती हैं, वे निजी नहीं बल्कि आपसी हैं। जोएल, ईस्टविक और उनके सह-लेखकों ने 2020 में PNAS में दिखाया कि दोनों साथी रिश्ते को खुद कैसे जीते हैं, यह रिश्ते की गुणवत्ता का उन गुणों से कहीं बेहतर संकेत है जो दोनों अपने साथ लेकर आए थे। इनमें से कुछ भी मिलने से पहले मौजूद नहीं होता, और कुछ भी किसी प्रोफ़ाइल में नहीं समाता।" },
      { type: "h2", text: "यह असल में कैसी दिखती है" },
      { type: "ul", items: [
        "**आप झगड़ते कैसे हैं।** कोई असहमति सुलह पर ख़त्म होती है या हिसाब-किताब पर — यह किसी भी साझा शौक़ से ज़्यादा बताता है।",
        "**क्या आप दोनों एक ही तरह की ज़िंदगी चाहते हैं।** बच्चे, शहर, पैसा, अकेले कितना वक़्त — सबसे नीरस सवाल ही सबसे ज़्यादा तय करते हैं।",
        "**जब आप असुविधा बनते हैं, तब आपके साथ कैसा बर्ताव होता है।** थके हुए, ग़लत, बीमार, व्यस्त: जवाब वहीं मिलता है।",
        "**रफ़्तार।** जिन दो लोगों को लगभग एक ही रफ़्तार चाहिए, उन्हें उसके लिए मोलभाव नहीं करना पड़ता।",
      ] },
      { type: "h2", accent: "green", text: "जब नापा नहीं जा सकता, तो पता कैसे चले" },
      { type: "p", text: "परखना बंद कीजिए, ग़ौर करना शुरू कीजिए। शुरू में ही किसी छोटी बात पर असहमत होइए और देखिए आगे क्या होता है — अनुकूलता की जाँच के सबसे क़रीब यही है। कोई सच्ची पसंद ज़ुबान पर लाइए और देखिए कि वह सुनी जाती है या बस संभाल ली जाती है। इस पर भी ध्यान दीजिए कि वह अपने पिछले निराश करने वाले इंसान के बारे में कैसे बात करता है। अनुकूलता की पुष्टि में वक़्त लगता है, पर बेमेल होना अक्सर जल्दी और चुपचाप सामने आ जाता है।" },
      { type: "p", text: "Qulo के बारे में एक ईमानदार बात: कोई आप तक पहुँचने के लिए जो सवाल हल करता है, वे भी अनुकूलता की जाँच नहीं हैं। सारे सही कर देने का मतलब यह नहीं कि वह इंसान आपके लिए ठीक है। सवाल जो नापते हैं वह है ध्यान — कि एक अजनबी ने आपका लिखा पढ़ा और दस्तक देने से पहले उस पर सोचा या नहीं। यह कहीं छोटा दावा है, और यही सच्चा दावा है।" },
    ],
  },
};
