import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * SOURCE, verified against several independent reports of the same
 * announcement (the publisher's own page returns 403 to automated fetches):
 * Merriam-Webster named "gaslighting" its 2022 Word of the Year after lookups
 * rose 1740% that year, and — unusually — no single news event caused the
 * spike; the word stayed in the site's fifty most-looked-up words all year.
 * The dictionary defines it as grossly misleading someone, especially for
 * one's own advantage, and traces the name to a 1938 play and the film made
 * from it, in which a husband works to convince his wife she is going mad.
 *
 * TONE: this page describes a pattern; it does not diagnose anyone. The
 * over-application of the term is treated as part of the subject rather than
 * ignored, because a reader who has just been called a gaslighter for
 * remembering an evening differently is also served by this page.
 *
 * NO QULO ANGLE. There is no honest mechanical link between this term and
 * question-based matching, and `glossary.ts` says the angle belongs only
 * "where there is an honest one".
 */
export const gaslighting: LocalizedGlossaryEntry = {
  en: {
    term: "Gaslighting",
    summary:
      "Repeatedly pushing someone to doubt their own memory or perception — insisting things they saw did not happen, or that they are imagining a problem — until they stop trusting their own account of events.",
    blocks: [
      { type: "h2", text: "Where the word comes from, and where it stops" },
      { type: "p", text: "The name comes from a 1938 play and the film made from it, in which a husband sets out to convince his wife she is losing her mind — dimming the gas lamps and telling her the light has not changed. Merriam-Webster made it the 2022 Word of the Year after lookups rose 1740% in a single year, and noted something unusual about the pattern: no one news event caused the spike. The word simply stayed in the dictionary's fifty most-searched terms for the whole of 2022. People were not looking it up because of a story. They were looking it up because they had heard it and wanted to know whether it applied to them." },
      { type: "p", text: "That popularity is also the problem, because the word has drifted to cover any disagreement about the past. It should not. Two people remember an evening differently almost every time; that is ordinary and says nothing about either of them. **What the term names is repetition with a direction** — the same denials, aimed the same way, until one person's confidence in their own memory gives out. A single argument where someone insists they never said that is a bad argument. A pattern where you increasingly cannot trust what you remember is the thing this word was coined for." },

      { type: "h2", text: "How to recognise the pattern" },
      {
        type: "ul",
        items: [
          "Things you clearly remember are described as never having happened, calmly and often.",
          "Your reaction becomes the subject: too sensitive, too dramatic, unable to take a joke.",
          "You start apologising for conversations you cannot reconstruct, and rehearsing them in advance.",
          "You check messages back to confirm your own version of events before you dare raise it.",
        ],
      },

      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Write things down. Not as evidence for an argument — arguing about the record is the trap — but for yourself, because the pattern works by wearing down your own account and a note written on the day is very hard to talk you out of. Then tell one person outside the situation. Isolation is what allows it to continue, and a friend who hears the same three stories will often see the shape before you do." },
      { type: "p", text: "Be slow to apply the label and slow to accept it. Someone who forgets, exaggerates or defends themselves badly is not doing this; describing an ordinary conflict this way makes the word useless for people who need it. But if you notice you have started to doubt your own mind, that observation is worth taking seriously on its own, whatever anyone else says about it — and it is a good reason to talk to a professional rather than to work it out alone." },
    ],
  },
  tr: {
    term: "Gaslighting",
    summary:
      "Birini kendi hafızasından ya da algısından kuşku duymaya itmek — gördüğü şeylerin olmadığını, bir sorunu hayal ettiğini ısrarla söylemek — ve bunu, kişi kendi anlattığına güvenmeyi bırakana kadar tekrarlamak.",
    blocks: [
      { type: "h2", text: "Kelimenin geldiği yer ve durduğu yer" },
      { type: "p", text: "Ad, 1938 tarihli bir oyundan ve ondan uyarlanan filmden geliyor: kocası, karısını aklını kaçırdığına inandırmaya çalışır — gaz lambalarını kısar ve ışığın değişmediğini söyler. Merriam-Webster, bu kelimeye yapılan sözlük aramaları bir yılda %1740 artınca onu 2022'nin Yılın Kelimesi seçti ve örüntüde alışılmadık bir şeye dikkat çekti: sıçramaya tek bir haber sebep olmamıştı. Kelime, 2022'nin tamamını sözlükte en çok aranan elli terim arasında geçirdi. İnsanlar bir olay yüzünden aramıyordu. Kelimeyi bir yerde duymuşlardı ve kendilerine uyup uymadığını öğrenmek istiyorlardı." },
      { type: "p", text: "Bu yaygınlık aynı zamanda sorunun kendisi; çünkü kelime, geçmişe dair her anlaşmazlığı kapsayacak kadar kaydı. Kaymamalı. İki insan bir akşamı neredeyse her seferinde farklı hatırlar; bu sıradandır ve ikisi hakkında da bir şey söylemez. **Terimin adını koyduğu şey, yönü olan bir tekrardır** — aynı inkârlar, aynı tarafa doğrultulmuş, ta ki birinin kendi hafızasına duyduğu güven tükenene kadar. Karşındakinin “ben öyle bir şey demedim” diye diretmesi kötü bir tartışmadır. Hatırladığın şeye giderek güvenemez hale gelmen ise bu kelimenin icat edilme sebebidir." },

      { type: "h2", text: "Örüntüyü nasıl tanırsın" },
      {
        type: "ul",
        items: [
          "Açıkça hatırladığın şeyler, sakin bir tonda ve sık sık, hiç yaşanmamış gibi anlatılıyor.",
          "Konu senin tepkine kayıyor: fazla hassassın, olay çıkarıyorsun, şakadan anlamıyorsun.",
          "Yeniden kuramadığın konuşmalar için özür dilemeye ve konuşmaları önceden prova etmeye başlıyorsun.",
          "Bir şeyi dile getirmeye cesaret etmeden önce, kendi anlattığını doğrulamak için mesajları geri okuyorsun.",
        ],
      },

      { type: "h2", accent: "green", text: "Ne yapmalı" },
      { type: "p", text: "Yaz. Tartışmada delil olsun diye değil — kaydı tartışmaya açmak zaten tuzağın kendisi — kendin için: çünkü bu örüntü tam olarak senin kendi anlattığını aşındırarak işliyor ve o gün yazılmış bir not, seni fikrinden döndürmeyi çok zorlaştırıyor. Sonra durumun dışından bir kişiye anlat. Bunun sürmesini mümkün kılan şey yalnızlık; aynı üç hikâyeyi dinleyen bir arkadaş, şekli çoğu zaman senden önce görür." },
      { type: "p", text: "Etiketi yapıştırmakta da kabul etmekte de acele etme. Unutan, abartan ya da kendini kötü savunan biri bunu yapmıyordur; sıradan bir çatışmayı böyle adlandırmak, kelimeyi ona gerçekten ihtiyacı olanlar için işe yaramaz hale getirir. Ama kendi aklından şüphe etmeye başladığını fark ettiysen, bu gözlem başkasının ne dediğinden bağımsız olarak tek başına ciddiye alınmayı hak eder — ve tek başına çözmeye çalışmak yerine bir uzmanla konuşmak için iyi bir sebeptir." },
    ],
  },
  de: {
    term: "Gaslighting",
    summary:
      "Jemanden immer wieder dazu bringen, an der eigenen Erinnerung oder Wahrnehmung zu zweifeln — zu behaupten, Gesehenes habe nie stattgefunden oder ein Problem sei nur eingebildet —, bis die Person dem eigenen Bericht nicht mehr traut.",
    blocks: [
      { type: "h2", text: "Woher das Wort kommt und wo es aufhört" },
      { type: "p", text: "Der Name stammt aus einem Theaterstück von 1938 und dem Film, der daraus gemacht wurde: Darin arbeitet ein Ehemann daran, seine Frau davon zu überzeugen, dass sie den Verstand verliert — er dimmt die Gaslampen und sagt ihr, das Licht habe sich nicht verändert. Merriam-Webster machte es zum Wort des Jahres 2022, nachdem die Suchanfragen im Wörterbuch innerhalb eines einzigen Jahres um 1740 % gestiegen waren, und wies auf etwas Ungewöhnliches hin: Kein einzelnes Nachrichtenereignis hatte diesen Sprung ausgelöst. Das Wort blieb schlicht das ganze Jahr 2022 über unter den fünfzig meistgesuchten Begriffen. Die Leute schlugen es nicht wegen einer Geschichte nach. Sie schlugen es nach, weil sie es gehört hatten und wissen wollten, ob es auf sie zutrifft." },
      { type: "p", text: "Diese Verbreitung ist zugleich das Problem, denn das Wort ist inzwischen auf jede Meinungsverschiedenheit über die Vergangenheit abgerutscht. Das sollte es nicht. Zwei Menschen erinnern sich an denselben Abend fast jedes Mal unterschiedlich; das ist gewöhnlich und sagt über keinen von beiden etwas aus. **Was der Begriff benennt, ist eine Wiederholung mit einer Richtung** — dieselben Widersprüche, immer auf dieselbe Seite gezielt, bis das Vertrauen eines Menschen in die eigene Erinnerung aufgibt. Ein einzelner Streit, in dem jemand darauf beharrt, das nie gesagt zu haben, ist ein schlechter Streit. Ein Muster, in dem du dem, woran du dich erinnerst, immer weniger trauen kannst, ist das, wofür dieses Wort erfunden wurde." },
      { type: "h2", text: "Woran du das Muster erkennst" },
      {
        type: "ul",
        items: [
          "Dinge, an die du dich klar erinnerst, werden ruhig und immer wieder als nie geschehen dargestellt.",
          "Deine Reaktion wird zum Thema: zu empfindlich, zu dramatisch, verstehst keinen Spaß.",
          "Du entschuldigst dich für Gespräche, die du nicht mehr zusammensetzen kannst, und probst sie vorher im Kopf.",
          "Du liest Nachrichten zurück, um deine eigene Version zu bestätigen, bevor du dich traust, sie anzusprechen.",
        ],
      },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Schreib es auf. Nicht als Beweismittel für einen Streit — über das Protokoll zu streiten ist genau die Falle —, sondern für dich selbst: Das Muster wirkt, indem es deinen eigenen Bericht abnutzt, und eine Notiz, die noch am selben Tag entstanden ist, lässt sich sehr schwer wegreden. Erzähl es dann einer Person außerhalb der Situation. Isolation ist es, was das Ganze am Laufen hält, und wer dieselben drei Geschichten hört, erkennt die Form oft früher als du." },
      { type: "p", text: "Sei zurückhaltend damit, das Etikett zu vergeben, und ebenso zurückhaltend damit, es anzunehmen. Wer vergisst, übertreibt oder sich schlecht verteidigt, tut das hier nicht; einen gewöhnlichen Konflikt so zu nennen, macht das Wort für die Menschen unbrauchbar, die es wirklich brauchen. Wenn du aber bemerkst, dass du angefangen hast, an deinem eigenen Verstand zu zweifeln, verdient diese Beobachtung für sich genommen, ernst genommen zu werden, ganz gleich, was andere dazu sagen — und sie ist ein guter Grund, mit einer Fachperson zu sprechen, statt es allein auszumachen." },
    ],
  },
  fr: {
    term: "Gaslighting",
    summary:
      "Pousser quelqu’un, encore et encore, à douter de sa propre mémoire ou de sa perception — soutenir que ce qu’il a vu n’a jamais eu lieu, ou qu’il imagine un problème — jusqu’à ce qu’il ne se fie plus à sa propre version des faits.",
    blocks: [
      { type: "h2", text: "D’où vient le mot, et où il s’arrête" },
      { type: "p", text: "Le nom vient d’une pièce de 1938 et du film qui en a été tiré : un mari s’emploie à convaincre sa femme qu’elle perd la raison — il baisse les lampes à gaz et lui assure que la lumière n’a pas changé. Merriam-Webster en a fait le mot de l’année 2022 après une hausse des recherches de 1740 % en un seul an, en relevant quelque chose d’inhabituel : aucun événement d’actualité n’avait provoqué cette flambée. Le mot est simplement resté toute l’année 2022 parmi les cinquante termes les plus consultés du dictionnaire. Les gens ne le cherchaient pas à cause d’une affaire. Ils le cherchaient parce qu’ils l’avaient entendu et voulaient savoir s’il s’appliquait à eux." },
      { type: "p", text: "Cette popularité est aussi le problème, car le mot a glissé jusqu’à recouvrir n’importe quel désaccord sur le passé. Il ne devrait pas. Deux personnes se souviennent différemment d’une même soirée presque à chaque fois ; c’est ordinaire et cela ne dit rien de l’une ni de l’autre. **Ce que le terme désigne, c’est une répétition qui a une direction** — les mêmes dénégations, orientées du même côté, jusqu’à ce que la confiance de quelqu’un dans sa propre mémoire cède. Une dispute isolée où l’autre soutient « je n’ai jamais dit ça » est une mauvaise dispute. Un schéma où vous pouvez de moins en moins vous fier à ce dont vous vous souvenez, c’est ce pour quoi ce mot a été forgé." },
      { type: "h2", text: "Comment reconnaître ce schéma" },
      {
        type: "ul",
        items: [
          "Des choses dont vous vous souvenez clairement sont présentées comme n’ayant jamais eu lieu, calmement et souvent.",
          "Votre réaction devient le sujet : trop sensible, trop dramatique, incapable de prendre une plaisanterie.",
          "Vous vous excusez pour des conversations que vous n’arrivez pas à reconstituer, et vous les répétez à l’avance.",
          "Vous relisez les messages pour confirmer votre propre version avant d’oser en parler.",
        ],
      },
      { type: "h2", accent: "green", text: "Que faire" },
      { type: "p", text: "Écrivez les choses. Pas comme preuve dans une dispute — se disputer sur le compte rendu est justement le piège —, mais pour vous : ce schéma agit en usant votre propre version, et une note écrite le jour même est très difficile à vous faire retirer. Parlez-en ensuite à une personne extérieure à la situation. C’est l’isolement qui permet à tout cela de durer, et un ami qui entend les trois mêmes histoires en voit souvent la forme avant vous." },
      { type: "p", text: "Soyez lent à coller l’étiquette et lent à l’accepter. Quelqu’un qui oublie, exagère ou se défend maladroitement ne fait pas cela ; qualifier ainsi un conflit ordinaire rend le mot inutile pour celles et ceux qui en ont besoin. Mais si vous constatez que vous avez commencé à douter de votre propre esprit, cette observation mérite d’être prise au sérieux pour elle-même, quoi qu’en disent les autres — et c’est une bonne raison d’en parler à un professionnel plutôt que de démêler cela seul." },
    ],
  },
  es: {
    term: "Luz de gas",
    summary:
      "Empujar a alguien una y otra vez a dudar de su propia memoria o percepción —insistir en que lo que vio no ocurrió, o en que se está imaginando un problema— hasta que deja de fiarse de su propio relato de los hechos; en inglés se llama gaslighting.",
    blocks: [
      { type: "h2", text: "¿De dónde viene la palabra y dónde deja de aplicarse?" },
      { type: "p", text: "El nombre viene de una obra de teatro de 1938 y de la película que se hizo a partir de ella: un marido se propone convencer a su mujer de que está perdiendo la cabeza; baja las lámparas de gas y le dice que la luz no ha cambiado. Merriam-Webster la eligió palabra del año 2022 después de que las búsquedas en el diccionario subieran un 1740 % en un solo año, y señaló algo poco habitual: ninguna noticia concreta había provocado ese salto. La palabra simplemente se mantuvo todo 2022 entre los cincuenta términos más buscados. La gente no la consultaba por un caso sonado. La consultaba porque la había oído y quería saber si le encajaba." },
      { type: "p", text: "Esa popularidad es también el problema, porque la palabra se ha ido corriendo hasta abarcar cualquier desacuerdo sobre el pasado. No debería. Dos personas recuerdan una misma noche de forma distinta casi siempre; eso es corriente y no dice nada de ninguna de las dos. **Lo que el término nombra es una repetición con una dirección**: las mismas negaciones, apuntando siempre al mismo lado, hasta que a alguien se le agota la confianza en su propia memoria. Una discusión suelta en la que el otro insiste en que él nunca dijo eso es una mala discusión. Un patrón en el que cada vez puedes fiarte menos de lo que recuerdas es aquello para lo que se acuñó esta palabra." },
      { type: "h2", text: "Cómo reconocer el patrón" },
      {
        type: "ul",
        items: [
          "Cosas que recuerdas con claridad se cuentan como si nunca hubieran pasado, con calma y a menudo.",
          "El tema pasa a ser tu reacción: eres demasiado sensible, demasiado dramático, no aguantas una broma.",
          "Empiezas a pedir perdón por conversaciones que no consigues reconstruir, y a ensayarlas de antemano.",
          "Relees los mensajes para confirmar tu propia versión antes de atreverte a sacar el tema.",
        ],
      },
      { type: "h2", accent: "green", text: "Qué puedes hacer" },
      { type: "p", text: "Escríbelo. No como prueba para una discusión —discutir sobre el registro es justo la trampa—, sino para ti: el patrón funciona desgastando tu propio relato, y una nota escrita ese mismo día es muy difícil de rebatir. Después cuéntaselo a una persona de fuera de la situación. Lo que permite que esto siga es el aislamiento, y una amistad que escucha las mismas tres historias suele ver la forma antes que tú." },
      { type: "p", text: "Tarda en poner la etiqueta y tarda también en aceptarla. Quien olvida, exagera o se defiende mal no está haciendo esto; llamar así a un conflicto corriente deja la palabra inservible para quien de verdad la necesita. Pero si notas que has empezado a dudar de tu propia cabeza, esa observación merece tomarse en serio por sí sola, diga lo que diga cualquier otro, y es una buena razón para hablarlo con un profesional en vez de resolverlo a solas." },
    ],
  },
  ar: {
    term: "التلاعب النفسي",
    summary:
      "دفعُ شخص مرارًا إلى الشكّ في ذاكرته وإدراكه، بالإصرار على أنّ ما رآه لم يحدث أو أنّه يتوهّم وجود مشكلة، حتى يكفّ عن الثقة بروايته هو لما جرى؛ ويُعرف بالإنجليزية باسم gaslighting.",
    blocks: [
      { type: "h2", text: "من أين جاءت الكلمة، وأين تتوقّف" },
      { type: "p", text: "يعود الاسم إلى مسرحية من عام 1938 وإلى الفيلم المأخوذ عنها، حيث يسعى زوج إلى إقناع زوجته بأنّها تفقد عقلها: يخفض مصابيح الغاز ثم يقول لها إنّ الضوء لم يتغيّر. وقد جعله قاموس Merriam-Webster كلمة العام 2022 بعدما ارتفعت عمليات البحث عنه بنسبة 1740% في سنة واحدة، ولفت إلى أمر غير معتاد في هذا النمط: لم يكن وراء القفزة خبر واحد بعينه. بل ظلّت الكلمة طوال عام 2022 ضمن الخمسين مصطلحًا الأكثر بحثًا في القاموس. لم يكن الناس يبحثون عنها بسبب قصّة ما، بل لأنّهم سمعوها وأرادوا أن يعرفوا إن كانت تنطبق عليهم." },
      { type: "p", text: "وهذه الشهرة نفسها هي المشكلة أيضًا، لأنّ الكلمة انزلقت حتى صارت تغطّي أيّ خلاف حول الماضي. وهي لا ينبغي أن تفعل. اثنان يتذكّران الأمسية نفسها بطريقتين مختلفتين في كل مرة تقريبًا؛ هذا أمر عادي ولا يقول شيئًا عن أيّ منهما. **ما يسمّيه المصطلح هو تكرار له اتجاه**: الإنكار نفسه، موجَّهًا إلى الجهة نفسها، حتى تنفد ثقة أحدهما بذاكرته. أن يصرّ أحدهم مرة واحدة على أنّه لم يقل ذلك أبدًا فهذا نقاش سيّئ. أمّا أن تصل تدريجيًا إلى أنّك لم تعد تثق بما تتذكّره، فهذا هو ما صيغت الكلمة من أجله." },
      { type: "h2", text: "كيف تتعرّف على هذا النمط" },
      {
        type: "ul",
        items: [
          "أشياء تتذكّرها بوضوح تُروى كأنّها لم تحدث قط، بهدوء وبشكل متكرّر.",
          "يتحوّل الحديث إلى ردّة فعلك أنت: أنت شديد الحساسية، تفتعل الدراما، لا تحتمل مزحة.",
          "تبدأ بالاعتذار عن محادثات لا تستطيع استعادتها، وتتمرّن عليها قبل أن تجري.",
          "تعود إلى الرسائل القديمة لتتأكّد من روايتك أنت قبل أن تجرؤ على فتح الموضوع.",
        ],
      },
      { type: "h2", accent: "green", text: "ماذا يمكنك أن تفعل" },
      { type: "p", text: "دوِّن ما يحدث. لا لتجعله دليلًا في نقاش، فالجدال حول السجلّ هو الفخّ نفسه، بل لنفسك: هذا النمط يعمل عبر تآكل روايتك أنت، وملاحظة كُتبت في يومها يصعب جدًا أن يُقنعك أحد بالعدول عنها. ثم أخبر شخصًا واحدًا من خارج الموقف. العزلة هي ما يسمح لهذا بالاستمرار، وصديق يسمع القصص الثلاث نفسها كثيرًا ما يرى الشكل قبل أن تراه أنت." },
      { type: "p", text: "لا تتعجّل في إلصاق الوصف، ولا في قبوله. من ينسى أو يبالغ أو يدافع عن نفسه دفاعًا سيّئًا لا يفعل هذا؛ وتسمية خلاف عادي بهذا الاسم تُفقد الكلمة قيمتها عند من يحتاجونها فعلًا. لكن إن لاحظت أنّك بدأت تشكّ في عقلك أنت، فهذه الملاحظة وحدها تستحقّ أن تُؤخذ على محمل الجدّ مهما قال غيرك عنها، وهي سبب وجيه لأن تتحدّث إلى مختصّ بدل أن تحلّها وحدك." },
    ],
  },
  ru: {
    term: "Газлайтинг",
    summary:
      "Раз за разом человека вынуждают усомниться в собственной памяти и восприятии — уверяя, что увиденного не было и что проблема ему только кажется, — пока он не перестанет доверять собственному рассказу о случившемся.",
    blocks: [
      { type: "h2", text: "Откуда взялось это слово и где оно заканчивается" },
      { type: "p", text: "Название пришло из пьесы 1938 года и снятого по ней фильма, где муж старается убедить жену, что она сходит с ума: он убавляет газовые лампы и говорит, что свет не изменился. Merriam-Webster назвал это слово словом 2022 года после того, как число обращений к словарю выросло за один год на 1740%, и отметил в этой картине кое-что необычное: у всплеска не было одной новостной причины. Слово просто продержалось весь 2022 год среди пятидесяти самых запрашиваемых терминов словаря. Люди искали его не из-за какой-то истории. Они его где-то услышали и хотели понять, относится ли оно к ним." },
      { type: "p", text: "Эта популярность и есть проблема: слово расползлось и покрывает теперь любое разногласие о прошлом. Так быть не должно. Двое почти всегда вспоминают один и тот же вечер по-разному; это обычное дело и ничего не говорит ни о ком из них. **Термин называет повторение, у которого есть направление** — одни и те же отрицания, направленные в одну сторону, пока у человека не кончится доверие к собственной памяти. Один спор, в котором собеседник упрямо повторяет: «я такого не говорил», — это просто плохой спор. А состояние, когда вы всё меньше можете полагаться на то, что помните, — то, ради чего это слово и придумали." },
      { type: "h2", text: "Как распознать этот рисунок" },
      {
        type: "ul",
        items: [
          "То, что вы отчётливо помните, спокойно и часто описывают как никогда не происходившее.",
          "Предметом разговора становится ваша реакция: слишком чувствительны, устраиваете драму, не понимаете шуток.",
          "Вы начинаете извиняться за разговоры, которые не можете восстановить, и заранее проговариваете их про себя.",
          "Прежде чем решиться о чём-то заговорить, вы перечитываете переписку, чтобы подтвердить собственную версию событий.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Записывайте. Не как доказательство для спора — спорить о записях и есть ловушка, — а для себя: этот рисунок работает тем, что стирает ваш собственный рассказ, а от заметки, сделанной в тот же день, вас очень трудно отговорить. Потом расскажите одному человеку вне этой истории. Продолжаться этому позволяет изоляция, и тот, кто услышит три одинаковые истории, часто увидит форму раньше вас." },
      { type: "p", text: "Не спешите ни навешивать этот ярлык, ни принимать его на свой счёт. Тот, кто забывает, преувеличивает или неудачно защищается, делает не это; называть так обычный конфликт — значит лишить слово смысла для тех, кому оно действительно нужно. Но если вы замечаете, что начали сомневаться в собственном рассудке, само это наблюдение стоит принять всерьёз, что бы об этом ни говорили другие, — и это хороший повод поговорить со специалистом, а не разбираться в одиночку." },
    ],
  },
  pt: {
    term: "Gaslighting",
    summary:
      "Levar alguém, repetidas vezes, a duvidar da própria memória ou percepção — insistindo que o que essa pessoa viu não aconteceu, ou que ela está imaginando um problema — até que deixe de confiar no próprio relato dos fatos.",
    blocks: [
      { type: "h2", text: "De onde vem a palavra, e onde ela para" },
      { type: "p", text: "O nome vem de uma peça de 1938 e do filme feito a partir dela, em que um marido se empenha em convencer a esposa de que ela está enlouquecendo — diminui as lamparinas a gás e diz que a luz não mudou. A Merriam-Webster escolheu a palavra como a Palavra do Ano de 2022 depois que as consultas ao dicionário subiram 1740% em um único ano, e apontou algo incomum: nenhum acontecimento isolado do noticiário provocou o salto. A palavra simplesmente ficou entre os cinquenta termos mais buscados do dicionário durante todo o ano de 2022. As pessoas não a procuravam por causa de uma notícia. Procuravam porque tinham ouvido a palavra e queriam saber se ela se aplicava a elas." },
      { type: "p", text: "Essa popularidade é também o problema, porque a palavra escorregou até cobrir qualquer divergência sobre o passado. Não deveria. Duas pessoas se lembram de uma mesma noite de formas diferentes quase sempre; isso é comum e não diz nada sobre nenhuma das duas. **O que o termo nomeia é uma repetição com direção** — as mesmas negações, apontadas para o mesmo lado, até a confiança de alguém na própria memória se esgotar. Uma discussão em que a outra pessoa insiste que nunca disse aquilo é uma discussão ruim. Um padrão em que você vai deixando de confiar no que lembra é aquilo para que esta palavra foi criada." },
      { type: "h2", text: "Como reconhecer o padrão" },
      {
        type: "ul",
        items: [
          "Coisas de que você se lembra com clareza são descritas como se nunca tivessem acontecido, com calma e com frequência.",
          "A sua reação vira o assunto: sensibilidade demais, drama demais, falta de senso de humor.",
          "Você começa a pedir desculpas por conversas que não consegue reconstruir, e a ensaiá-las antes.",
          "Você relê as mensagens para confirmar a sua própria versão antes de ter coragem de tocar no assunto.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer" },
      { type: "p", text: "Anote as coisas. Não como prova para uma discussão — discutir o registro é justamente a armadilha — mas para você: esse padrão funciona desgastando o seu próprio relato, e uma anotação feita no mesmo dia é muito difícil de desmontar. Depois conte para uma pessoa de fora da situação. É o isolamento que permite que isso continue, e um amigo que ouve as mesmas três histórias costuma enxergar o formato antes de você." },
      { type: "p", text: "Demore para colar o rótulo e demore para aceitá-lo. Quem esquece, exagera ou se defende mal não está fazendo isso; chamar um conflito comum assim torna a palavra inútil para quem realmente precisa dela. Mas se você percebeu que começou a duvidar da própria cabeça, essa observação merece ser levada a sério por si só, digam os outros o que disserem — e é um bom motivo para conversar com um profissional em vez de tentar resolver sozinho." },
    ],
  },
  it: {
    term: "Gaslighting",
    summary:
      "Spingere qualcuno, di continuo, a dubitare della propria memoria o della propria percezione — insistendo che le cose che ha visto non sono successe, o che si sta immaginando un problema — finché smette di fidarsi del proprio racconto dei fatti.",
    blocks: [
      { type: "h2", text: "Da dove viene la parola, e dove si ferma" },
      { type: "p", text: "Il nome viene da un’opera teatrale del 1938 e dal film che ne è stato tratto, in cui un marito si mette in testa di convincere la moglie che sta perdendo la ragione: abbassa le lampade a gas e le dice che la luce non è cambiata. Merriam-Webster l’ha scelta come Parola dell’anno 2022 dopo che le ricerche nel dizionario erano cresciute del 1740% in un solo anno, e ha segnalato una cosa insolita: nessun singolo fatto di cronaca aveva provocato quel salto. La parola è semplicemente rimasta fra i cinquanta termini più cercati del dizionario per tutto il 2022. Le persone non la cercavano per via di una notizia. La cercavano perché l’avevano sentita e volevano sapere se riguardava anche loro." },
      { type: "p", text: "Questa diffusione è anche il problema, perché la parola è scivolata fino a coprire qualunque disaccordo sul passato. Non dovrebbe. Due persone ricordano una serata in modo diverso quasi ogni volta; è una cosa ordinaria e non dice niente né dell’una né dell’altra. **Quello che il termine nomina è una ripetizione con una direzione** — le stesse smentite, puntate sempre dalla stessa parte, finché la fiducia di qualcuno nella propria memoria cede. Una singola discussione in cui l’altro insiste di non aver mai detto quella cosa è una brutta discussione. Non riuscire più a fidarti di ciò che ricordi è la cosa per cui questa parola è stata coniata." },
      { type: "h2", text: "Come riconoscere lo schema" },
      {
        type: "ul",
        items: [
          "Cose che ricordi con chiarezza vengono descritte come mai avvenute, con calma e spesso.",
          "L’argomento diventa la tua reazione: troppo sensibile, troppo drammatico, incapace di stare a uno scherzo.",
          "Cominci a scusarti per conversazioni che non riesci a ricostruire, e a provarle in anticipo.",
          "Prima di osare tirare fuori una cosa, rileggi i messaggi per confermare la tua versione dei fatti.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa fare" },
      { type: "p", text: "Scrivi le cose. Non come prova da usare in una discussione — discutere sul verbale è proprio la trappola — ma per te: questo schema funziona logorando il tuo racconto, e una nota scritta il giorno stesso è molto difficile da smontare. Poi parlane con una persona fuori dalla situazione. È l’isolamento che permette a tutto questo di andare avanti, e un amico che sente le stesse tre storie spesso ne vede la forma prima di te." },
      { type: "p", text: "Vacci piano nell’attaccare l’etichetta e vacci piano nell’accettarla. Chi dimentica, esagera o si difende male non sta facendo questo; chiamare così un conflitto ordinario rende la parola inutile per chi ne ha davvero bisogno. Ma se ti accorgi di aver cominciato a dubitare della tua testa, quell’osservazione merita di essere presa sul serio per conto suo, qualunque cosa ne dicano gli altri — ed è un buon motivo per parlarne con un professionista invece di venirne a capo da solo." },
    ],
  },
  ja: {
    term: "ガスライティング",
    summary:
      "見たはずのことは起きていない、問題は気のせいだと言い続けて相手に自分の記憶や感覚を疑わせ、やがて本人が自分の語る出来事を信じられなくなるところまで持っていくことを指します。",
    blocks: [
      { type: "h2", text: "言葉の出どころと、どこで止まるか" },
      { type: "p", text: "名前は1938年の戯曲と、そこから作られた映画から来ています。夫が妻に、自分は正気を失いつつあると思わせようとする話で、ガス灯を暗くしておきながら、明かりは変わっていないと言い張ります。Merriam-Websterは、この語の検索が一年で1740%増えたことを受けて2022年の「今年の言葉」に選び、その広がり方について珍しい点を指摘しました。急増のきっかけになった特定のニュースが一つもなかったのです。この言葉は2022年を通してずっと、辞書で最も多く調べられた五十語の中に入り続けていました。人々は出来事があったから調べたのではありません。どこかで耳にして、それが自分に当てはまるのかどうかを知りたかったのです。" },
      { type: "p", text: "その広まり方が、そのまま問題でもあります。この言葉は、過去をめぐるあらゆる食い違いにまで届くようになってしまいました。そこまで広げるべきではありません。二人が同じ一晩を違うふうに覚えていることはほとんど毎回あることで、それはごく普通のことですし、どちらの人柄も語りません。**この言葉が名指しているのは、向きのある反復です**。同じ否定が同じ方向に向けられ続け、やがて片方の人が自分の記憶に対して持っていた自信を使い果たしてしまう。そんなことは言っていないと相手が言い張る一度きりの口論は、ただの悪い口論です。自分の覚えていることが、だんだん信じられなくなっていく状態のほうが、この言葉が作られた理由にあたります。" },
      { type: "h2", text: "パターンの見分け方" },
      {
        type: "ul",
        items: [
          "はっきり覚えていることが、落ち着いた口調で、何度も、なかったことにされる。",
          "話題が自分の反応にすり替わる。敏感すぎる、大げさ、冗談が通じない。",
          "思い出せない会話について謝るようになり、話す前にやりとりを頭の中で練習するようになる。",
          "口に出す勇気が出る前に、自分の記憶を確かめるためにメッセージをさかのぼって読み返す。",
        ],
      },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "書き留めてください。口論のための証拠としてではなく（記録をめぐって争うこと自体が罠です）、自分のためにです。この形は、あなた自身の記憶を少しずつ削っていくことで働くので、その日のうちに書かれたメモは、あとから言いくるめるのがとても難しくなります。そのうえで、状況の外にいる人を一人選んで話してください。これが続いてしまう条件は孤立です。同じ三つの話を聞いた友人は、たいていあなたより先にその形に気づきます。" },
      { type: "p", text: "名前を貼るのも、受け入れるのも急がないことです。忘れる人、話を盛る人、自分の弁護が下手な人は、これをしているわけではありません。ありふれた対立をこの言葉で呼んでしまうと、本当に必要としている人にとってこの言葉は使いものにならなくなります。ただ、自分の頭を疑いはじめていると気づいたのなら、その気づきは、ほかの誰が何と言おうと、それだけで真剣に受け止める価値があります。そして、ひとりで結論を出そうとするより、専門家に相談するだけの理由になります。" },
    ],
  },
  ko: {
    term: "가스라이팅",
    summary:
      "본 것이 일어나지 않았다거나 문제를 지어내고 있다고 계속 말하면서 상대가 자기 기억과 감각을 의심하게 만들고, 끝내 자신이 겪은 일에 대한 스스로의 이야기를 믿지 못하게 만드는 일을 가리킵니다.",
    blocks: [
      { type: "h2", text: "이 말이 어디에서 왔고, 어디에서 멈추는가" },
      { type: "p", text: "이름은 1938년에 나온 희곡과 그것을 옮긴 영화에서 왔습니다. 남편이 아내에게 정신이 나가고 있다고 믿게 만들려 하는 이야기로, 가스등을 어둡게 해 놓고는 불빛은 그대로라고 말합니다. Merriam-Webster는 이 단어의 사전 검색이 한 해 동안 1740% 늘어나자 2022년 올해의 단어로 골랐고, 그 흐름에서 흔치 않은 점 하나를 짚었습니다. 급증을 불러온 특정한 사건이 하나도 없었다는 것입니다. 이 단어는 2022년 내내 사전에서 가장 많이 찾아본 쉰 개 단어 안에 머물렀습니다. 사람들은 어떤 사건 때문에 찾아본 것이 아닙니다. 어디선가 그 말을 듣고, 자기에게 해당하는지 알고 싶었던 것입니다." },
      { type: "p", text: "이 인기가 곧 문제이기도 합니다. 과거를 두고 벌어지는 모든 의견 차이에까지 이 말이 번졌기 때문입니다. 그래서는 안 됩니다. 두 사람이 같은 저녁을 다르게 기억하는 일은 거의 매번 일어나고, 그건 평범한 일이며 두 사람 어느 쪽에 대해서도 아무것도 말해 주지 않습니다. **이 말이 가리키는 것은 방향이 있는 반복입니다**. 같은 부정이 같은 쪽을 향해 되풀이되고, 끝내 한 사람이 자기 기억에 대해 가지고 있던 믿음이 바닥나는 흐름입니다. 그런 말 한 적 없다고 상대가 우기는 한 번의 말다툼은 그냥 나쁜 말다툼입니다. 내가 기억하는 것을 점점 믿지 못하게 되는 쪽이, 이 말이 만들어진 이유입니다." },
      { type: "h2", text: "이 패턴을 알아보는 법" },
      {
        type: "ul",
        items: [
          "분명히 기억하는 일들이, 차분한 말투로, 자주, 없었던 일처럼 이야기됩니다.",
          "화제가 내 반응으로 옮겨 갑니다. 너무 예민하다, 유난이다, 농담을 못 받아들인다.",
          "다시 떠올릴 수 없는 대화를 두고 사과하게 되고, 할 말을 미리 연습하게 됩니다.",
          "말을 꺼낼 용기를 내기 전에, 내 기억이 맞는지 확인하려고 메시지를 거슬러 읽습니다.",
        ],
      },
      { type: "h2", accent: "green", text: "무엇을 하면 좋을까" },
      { type: "p", text: "적어 두세요. 말다툼에서 쓸 증거로가 아니라(기록을 두고 다투는 것 자체가 함정입니다) 나 자신을 위해서입니다. 이 방식은 내가 겪은 이야기를 조금씩 깎아 내면서 작동하는데, 그날 적어 둔 메모는 나중에 말로 뒤집기가 아주 어렵습니다. 그다음에는 이 상황 밖에 있는 사람 한 명에게 이야기하세요. 이 일이 계속될 수 있게 하는 조건은 고립이고, 같은 이야기 세 개를 들은 친구는 대개 나보다 먼저 그 모양을 알아봅니다." },
      { type: "p", text: "이름표를 붙이는 것도, 받아들이는 것도 서두르지 마세요. 잊어버리는 사람, 과장하는 사람, 자기 변명이 서툰 사람이 이걸 하고 있는 건 아닙니다. 흔한 갈등을 이 말로 부르면, 정말 이 말이 필요한 사람에게 이 말은 쓸모없어집니다. 다만 내가 내 정신을 의심하기 시작했다는 걸 알아차렸다면, 그 관찰은 다른 누가 무어라 하든 그 자체로 진지하게 받아들일 값어치가 있고, 혼자 풀어 보려 하기보다 전문가와 이야기해 볼 좋은 이유가 됩니다." },
    ],
  },
  zh: {
    term: "煤气灯效应",
    summary:
      "反复把一个人推向对自己记忆和感知的怀疑——坚称他亲眼见过的事没有发生，或者说问题是他自己想出来的——直到他不再相信自己对事情的讲述（英文称作 gaslighting）。",
    blocks: [
      { type: "h2", text: "这个词从哪里来，又在哪里止步" },
      { type: "p", text: "这个名字来自1938年的一部话剧，以及由它改编的电影：剧中的丈夫一心要让妻子相信自己疯了——他把煤气灯调暗，却告诉她灯光根本没有变。韦氏词典（Merriam-Webster）把它选为2022年的年度词汇，因为那一年它的查词量上涨了1740%；词典还注意到一件不寻常的事：这次暴涨并不是由某一条新闻引起的。整个2022年，这个词一直留在该词典查询量最高的五十个词里。人们不是因为某个事件才去查它。他们是在别处听到了这个词，想知道它说的是不是自己。" },
      { type: "p", text: "这份流行本身也是问题所在，因为这个词已经漂移到可以指称任何一次关于往事的分歧。它不该如此。两个人对同一个晚上的记忆几乎每次都不一样；这很平常，也说明不了谁的问题。**这个词命名的，是有方向的重复**——同样的否认，朝着同一个方向，直到一个人对自己记忆的信心耗尽为止。对方咬定“我没说过那种话”，那是一次糟糕的争吵。而你越来越不敢相信自己记得的东西，才是这个词被造出来要说的事。" },
      { type: "h2", text: "怎么认出这个模式" },
      {
        type: "ul",
        items: [
          "你清清楚楚记得的事，被平静地、反复地说成从来没有发生过。",
          "话题转到你的反应上：你太敏感、太爱小题大做、开不起玩笑。",
          "你开始为自己复原不出来的对话道歉，并且提前在心里演练要说的话。",
          "在你敢开口提起之前，先回头翻聊天记录，确认自己记的版本没错。",
        ],
      },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "把事情写下来。不是为了在争吵里当证据——去争论那份记录本身就是陷阱——而是写给自己看：这个模式正是靠磨损你自己的讲述来起作用的，而当天写下的一行字，很难被人说服着推翻。然后，告诉一个身在事外的人。让它得以持续下去的是孤立，一个听过同样三个故事的朋友，往往比你先看出形状来。" },
      { type: "p", text: "给人贴上这个标签要慢，接受这个标签同样要慢。会忘事、会夸张、会笨拙地替自己辩解的人，做的不是这件事；把一次普通的冲突叫成这个名字，会让这个词对真正需要它的人失去用处。但如果你发现自己已经开始怀疑起自己的脑子，那么不管别人怎么说，这个察觉本身就值得认真对待——它也是一个好理由：去找专业的人谈谈，而不是一个人硬扛。" },
    ],
  },
  nl: {
    term: "Gaslighting",
    summary:
      "Iemand er keer op keer toe brengen om aan het eigen geheugen of de eigen waarneming te twijfelen — volhouden dat wat diegene zag niet is gebeurd, of dat diegene zich een probleem inbeeldt — tot die persoon het eigen verhaal niet meer vertrouwt.",
    blocks: [
      { type: "h2", text: "Waar het woord vandaan komt, en waar het ophoudt" },
      { type: "p", text: "De naam komt uit een toneelstuk uit 1938 en de film die daarvan is gemaakt, waarin een man zijn vrouw ervan probeert te overtuigen dat ze haar verstand verliest — hij draait de gaslampen lager en zegt dat het licht niet veranderd is. Merriam-Webster maakte het woord tot Woord van het Jaar 2022, nadat het aantal opzoekingen in één jaar met 1740% was gestegen, en wees op iets ongewoons: geen enkele nieuwsgebeurtenis lag aan die piek ten grondslag. Het woord bleef simpelweg heel 2022 staan in de vijftig meest opgezochte termen van het woordenboek. Mensen zochten het niet op vanwege een verhaal in het nieuws. Ze zochten het op omdat ze het ergens hadden gehoord en wilden weten of het op hen sloeg." },
      { type: "p", text: "Die populariteit is meteen ook het probleem, want het woord is afgegleden tot het elk meningsverschil over het verleden dekt. Dat zou het niet moeten doen. Twee mensen herinneren zich een avond bijna altijd anders; dat is doodgewoon en zegt over geen van beiden iets. **Waar de term op doelt is herhaling met een richting** — dezelfde ontkenningen, steeds dezelfde kant op, tot iemands vertrouwen in het eigen geheugen het begeeft. Eén ruzie waarin de ander volhoudt dat hij dat nooit gezegd heeft, is een slechte ruzie. Een patroon waarin je steeds minder kunt vertrouwen op wat je je herinnert, is waarvoor dit woord bedacht is." },
      { type: "h2", text: "Hoe je het patroon herkent" },
      {
        type: "ul",
        items: [
          "Dingen die je je duidelijk herinnert, worden rustig en vaak beschreven als nooit gebeurd.",
          "Jouw reactie wordt het onderwerp: te gevoelig, te dramatisch, kan niet tegen een grapje.",
          "Je verontschuldigt je voor gesprekken die je niet kunt reconstrueren, en oefent ze van tevoren.",
          "Je leest berichten terug om je eigen versie te bevestigen voordat je het aandurft iets aan te kaarten.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je kunt doen" },
      { type: "p", text: "Schrijf dingen op. Niet als bewijs voor een discussie — discussiëren over de vastlegging is juist de val — maar voor jezelf: dit patroon werkt doordat het jouw eigen verhaal afslijt, en een notitie die je diezelfde dag hebt gemaakt laat zich heel moeilijk wegpraten. Vertel het daarna aan één iemand buiten de situatie. Geïsoleerd raken is wat het laat doorgaan, en een vriend die dezelfde drie verhalen hoort, ziet de vorm vaak eerder dan jij." },
      { type: "p", text: "Wees traag met het opplakken van het label en traag met het aanvaarden ervan. Wie iets vergeet, overdrijft of zichzelf slecht verdedigt, doet dit niet; een gewoon conflict zo noemen maakt het woord onbruikbaar voor de mensen die het echt nodig hebben. Maar als je merkt dat je aan je eigen verstand bent gaan twijfelen, verdient die constatering het om op zichzelf serieus genomen te worden, wat anderen er ook over zeggen — en het is een goede reden om met een professional te praten in plaats van het alleen uit te zoeken." },
    ],
  },
  pl: {
    term: "Gaslighting",
    summary:
      "Powtarzane podważanie czyjejś pamięci i tego, co ta osoba widziała — zapewnianie, że coś się nigdy nie wydarzyło albo że problem istnieje tylko w jej głowie — aż przestaje ufać własnej relacji zdarzeń.",
    blocks: [
      { type: "h2", text: "Skąd wzięło się to słowo i gdzie się kończy" },
      { type: "p", text: "Nazwa pochodzi ze sztuki z 1938 roku i z nakręconego na jej podstawie filmu, w którym mąż stara się przekonać żonę, że traci rozum — przygasza lampy gazowe i mówi, że światło wcale się nie zmieniło. Merriam-Webster ogłosił to słowo Słowem Roku 2022, gdy liczba wyszukiwań w słowniku wzrosła w ciągu jednego roku o 1740%, i zwrócił uwagę na coś nietypowego: skoku nie wywołało żadne pojedyncze wydarzenie. Słowo po prostu utrzymało się przez cały 2022 rok wśród pięćdziesięciu najczęściej wyszukiwanych haseł słownika. Ludzie nie sprawdzali tego słowa z powodu jakiejś jednej historii. Usłyszeli je gdzieś i chcieli wiedzieć, czy pasuje do nich." },
      { type: "p", text: "Ta popularność jest zarazem problemem, bo słowo rozlało się na każdy spór o przeszłość. Nie powinno. Dwoje ludzi niemal za każdym razem pamięta ten sam wieczór inaczej; to zwyczajne i nie mówi nic o żadnym z nich. **To, czemu ten termin nadaje nazwę, to powtarzalność mająca kierunek** — te same zaprzeczenia, wymierzone w tę samą stronę, aż w kimś wyczerpie się zaufanie do własnej pamięci. Pojedyncza kłótnia, w której druga osoba upiera się, że nic takiego nie padło, to po prostu zła kłótnia. Stan, w którym coraz mniej możesz polegać na tym, co pamiętasz, to rzecz, dla której ukuto to słowo." },
      { type: "h2", text: "Jak rozpoznać ten schemat" },
      {
        type: "ul",
        items: [
          "Rzeczy, które wyraźnie pamiętasz, bywają opisywane jako coś, co nigdy się nie wydarzyło — spokojnym tonem i często.",
          "Tematem staje się twoja reakcja: przewrażliwienie, robienie dramatu, brak dystansu do żartów.",
          "Zaczynasz przepraszać za rozmowy, których nie potrafisz odtworzyć, i ćwiczyć je wcześniej w głowie.",
          "Zanim odważysz się coś poruszyć, wracasz do wiadomości, żeby potwierdzić własną wersję wydarzeń.",
        ],
      },
      { type: "h2", accent: "green", text: "Co możesz zrobić" },
      { type: "p", text: "Zapisuj. Nie jako dowód do kłótni — spieranie się o zapis jest właśnie pułapką — tylko dla siebie, bo ten schemat działa przez ścieranie twojej własnej relacji, a od notatki zrobionej tego samego dnia bardzo trudno cię odwieść. Potem powiedz o tym jednej osobie spoza całej sytuacji. To izolacja pozwala temu trwać, a osoba, która usłyszy te same trzy historie, często dostrzeże kształt wcześniej niż ty." },
      { type: "p", text: "Nie spiesz się z przyklejaniem tej etykiety ani z jej przyjmowaniem. Ktoś, kto zapomina, wyolbrzymia albo nieudolnie się broni, nie robi tego; nazywanie w ten sposób zwykłego konfliktu odbiera słowu użyteczność dla ludzi, którym jest naprawdę potrzebne. Ale jeśli zauważasz, że zaczynasz wątpić we własny rozum, sama ta obserwacja zasługuje na poważne potraktowanie, niezależnie od tego, co mówi o niej ktokolwiek inny — i jest dobrym powodem, żeby porozmawiać ze specjalistą, zamiast rozwiązywać to w pojedynkę." },
    ],
  },
  sv: {
    term: "Gaslighting",
    summary:
      "Att gång på gång pressa någon att tvivla på sitt eget minne eller sin egen uppfattning — att envist hävda att det de sett aldrig hände, eller att de inbillar sig problemet — tills de slutar lita på sin egen version av vad som skedde.",
    blocks: [
      { type: "h2", text: "Var ordet kommer ifrån, och var det tar slut" },
      { type: "p", text: "Namnet kommer från en pjäs från 1938 och filmen som gjordes av den, där en man målmedvetet försöker övertyga sin hustru om att hon håller på att förlora förståndet — han skruvar ner gaslamporna och säger att ljuset inte har förändrats. Merriam-Webster utsåg ordet till årets ord 2022 sedan uppslagningarna ökat med 1740 procent på ett enda år, och noterade något ovanligt i mönstret: ingen enskild nyhetshändelse låg bakom toppen. Ordet låg helt enkelt kvar bland ordbokens femtio mest uppslagna ord under hela 2022. Folk slog inte upp det på grund av en nyhet. De slog upp det för att de hört det och ville veta om det stämde in på dem." },
      { type: "p", text: "Den populariteten är samtidigt problemet, för ordet har glidit iväg och täcker numera varje oenighet om det förflutna. Det borde det inte. Två personer minns en kväll olika nästan varje gång; det är vardagligt och säger ingenting om någon av dem. **Det termen sätter namn på är upprepning med en riktning** — samma förnekanden, riktade åt samma håll, tills en människas tilltro till sitt eget minne tar slut. Ett enskilt gräl där någon envist hävdar att hen aldrig sagt det är ett dåligt gräl. Ett mönster där du allt mindre kan lita på det du minns är det som ordet myntades för." },
      { type: "h2", text: "Så känner du igen mönstret" },
      {
        type: "ul",
        items: [
          "Sådant du minns tydligt beskrivs som att det aldrig har hänt — lugnt och ofta.",
          "Din reaktion blir ämnet: du är för känslig, för dramatisk, tål inte ett skämt.",
          "Du börjar be om ursäkt för samtal du inte kan återskapa, och repeterar dem i förväg.",
          "Du går tillbaka i meddelandena för att bekräfta din egen version innan du vågar ta upp något.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Skriv ner saker. Inte som bevis i ett gräl — att bråka om anteckningarna är just fällan — utan för din egen skull, eftersom mönstret fungerar genom att nöta ner din egen version, och en notering skriven samma dag är mycket svår att prata bort. Berätta sedan för en person utanför situationen. Isoleringen är det som låter det fortsätta, och någon som får höra samma tre berättelser ser ofta formen före dig." },
      { type: "p", text: "Var långsam med att sätta etiketten och långsam med att ta emot den. Den som glömmer, överdriver eller försvarar sig klumpigt gör inte det här; att beskriva en vanlig konflikt så gör ordet oanvändbart för dem som verkligen behöver det. Men om du märker att du har börjat tvivla på ditt eget förstånd är den iakttagelsen värd att ta på allvar i sig, vad andra än säger om saken — och det är ett gott skäl att söka professionellt stöd i stället för att reda ut det ensam." },
    ],
  },
  hi: {
    term: "गैसलाइटिंग",
    summary:
      "किसी को बार-बार अपनी ही याददाश्त या समझ पर शक करने की ओर धकेलना — यह कहते रहना कि जो उसने देखा वह हुआ ही नहीं, या कि समस्या उसकी कल्पना है — जब तक वह अपने ही बयान पर भरोसा करना छोड़ न दे।",
    blocks: [
      { type: "h2", text: "यह शब्द कहाँ से आया, और कहाँ जाकर रुकता है" },
      { type: "p", text: "यह नाम 1938 के एक नाटक और उस पर बनी फ़िल्म से आया है, जिसमें एक पति अपनी पत्नी को यह यक़ीन दिलाने में जुट जाता है कि उसका दिमाग़ ख़राब हो रहा है — वह गैस की लालटेनों की रोशनी मद्धिम करता है और कहता है कि रोशनी में कोई फ़र्क़ नहीं आया। Merriam-Webster ने इसे 2022 का वर्ड ऑफ़ द ईयर चुना, क्योंकि उस एक साल में इस शब्द की खोज 1740% बढ़ गई थी; और शब्दकोश ने इस सिलसिले में एक असामान्य बात दर्ज की: इस उछाल के पीछे कोई एक ख़बर नहीं थी। यह शब्द पूरे 2022 के दौरान शब्दकोश में सबसे ज़्यादा खोजे गए पचास शब्दों में बना रहा। लोग किसी घटना की वजह से इसे नहीं खोज रहे थे। उन्होंने इसे कहीं सुना था और जानना चाहते थे कि यह उन पर लागू होता है या नहीं।" },
      { type: "p", text: "यही लोकप्रियता एक मुश्किल भी है, क्योंकि यह शब्द खिसकते-खिसकते अतीत को लेकर हुई हर असहमति तक पहुँच गया है। ऐसा नहीं होना चाहिए। दो लोग एक ही शाम को लगभग हर बार अलग-अलग याद रखते हैं; यह आम बात है और इससे दोनों में से किसी के बारे में कुछ साबित नहीं होता। **यह शब्द जिसे नाम देता है, वह है दिशा वाली पुनरावृत्ति** — वही इनकार, हर बार उसी तरफ़ तने हुए, तब तक जब तक एक इंसान का अपनी याददाश्त पर भरोसा ख़त्म न हो जाए। कोई एक बार अड़ जाए कि उसने ऐसा कभी कहा ही नहीं, तो वह एक बुरी बहस है। पर आप धीरे-धीरे अपनी ही याद पर भरोसा न कर पाएँ — यह शब्द ठीक इसी के लिए गढ़ा गया था।" },
      { type: "h2", text: "इस पैटर्न को कैसे पहचानें" },
      {
        type: "ul",
        items: [
          "जो बातें आपको साफ़ याद हैं, उन्हें शांत लहज़े में और बार-बार ऐसे बताया जाता है जैसे वे कभी हुई ही न हों।",
          "बात आपकी प्रतिक्रिया पर आ जाती है: आप बहुत संवेदनशील हैं, ड्रामा कर रहे हैं, मज़ाक़ नहीं समझते।",
          "आप उन बातचीतों के लिए माफ़ी माँगने लगते हैं जिन्हें आप दोबारा जोड़ ही नहीं पाते, और आगे की बातचीत पहले से मन में दोहराते हैं।",
          "कुछ कहने की हिम्मत जुटाने से पहले आप पुराने मैसेज पढ़कर अपनी ही बात की तस्दीक़ करते हैं।",
        ],
      },
      { type: "h2", accent: "green", text: "क्या किया जा सकता है" },
      { type: "p", text: "लिख लीजिए। बहस में सबूत के तौर पर नहीं — रिकॉर्ड पर बहस करना ही तो असली जाल है — बल्कि अपने लिए: यह पैटर्न काम ही आपके अपने बयान को घिसकर करता है, और उसी दिन लिखी गई एक पंक्ति से आपको डिगाना बहुत मुश्किल होता है। फिर इस हालात से बाहर के किसी एक इंसान को बताइए। इसे चलते रहने देती है तनहाई; वही तीन क़िस्से सुनने वाला दोस्त अक्सर आपसे पहले उसका आकार देख लेता है।" },
      { type: "p", text: "यह लेबल लगाने में भी जल्दबाज़ी मत कीजिए और मान लेने में भी। जो भूल जाता है, बढ़ा-चढ़ाकर कहता है या ख़ुद का बचाव ठीक से नहीं कर पाता, वह यह नहीं कर रहा; एक आम टकराव को यह नाम दे देना उस शब्द को उन लोगों के लिए बेकार कर देता है जिन्हें उसकी सचमुच ज़रूरत है। लेकिन अगर आपको लगे कि आपने अपने ही दिमाग़ पर शक करना शुरू कर दिया है, तो कोई और चाहे जो कहे, यह एहसास अपने आप में गंभीरता से लेने लायक़ है — और यह अकेले सुलझाने की कोशिश करने के बजाय किसी पेशेवर से बात करने की अच्छी वजह भी है।" },
    ],
  },
};
