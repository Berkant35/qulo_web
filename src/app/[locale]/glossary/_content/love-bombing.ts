import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Love bombing — overwhelming early attention, praise and intensity that
 * outruns anything the other person could yet know about you.
 *
 * This is the most careful file in the set. Judgement calls, so a later editor
 * does not undo them by accident:
 *
 * - THE ENTRY REFUSES TO SAY THAT STRONG EARLY AFFECTION IS MANIPULATION.
 *   Block 1 says the opposite in every locale: new attraction is loud, most
 *   fast starts are sincere, and the word has spread far enough that it now
 *   gets attached to anyone who is simply keen. Removing that sentence turns a
 *   description into an accusation and must not happen.
 * - NO DIAGNOSIS ANYWHERE. The h2 is "how to recognise the pattern", not how to
 *   recognise a love bomber. Nothing here labels a person, names a personality
 *   disorder, or claims to know intent. Behaviour only.
 * - THE TWO DISTINGUISHING MARKS ARE LOAD-BEARING and both must survive an
 *   edit: (1) the intensity arrives before the person could possibly know you —
 *   praise that would fit anybody, certainty after four days; (2) what happens
 *   at the first small no. The second is the informative one and is deliberately
 *   the last list item and the centre of block 6.
 * - NON-ALARMIST CLOSE. Block 7 tells the reader to watch a pattern over weeks
 *   rather than convict after one big evening, and points to a friend outside
 *   the situation. It deliberately does not name a helpline or a service: there
 *   is no sourced, per-country resource available to this file, and inventing
 *   one for 16 locales would be worse than saying nothing. If a sourced
 *   localised resource is ever added, this is the block for it.
 * - THE FUTURE-FAKING BOUNDARY appears at the end of block 1: this floods the
 *   present, future faking spends a future that never gets a date. The
 *   future-faking page draws the same line from its own side, in its own words
 *   — keep the two phrasings distinct.
 * - NO STATISTICS. Nothing quantitative is claimed. The one sourced figure
 *   available (Forbes Health / OnePoll 2024, dating-app burnout) is about a
 *   different subject and is not stretched to fit here.
 * - NO QULO ANGLE, on purpose and non-negotiably. Love bombing happens
 *   everywhere, including on this app, and a question quiz does nothing to
 *   prevent it. Claiming otherwise would be a safety claim the product cannot
 *   support. The slug page renders a Qulo CTA below the body; the body sells
 *   nothing.
 *
 * Term names: native where the language really has one — tr Sevgi bombardımanı,
 * es Bombardeo de amor, ar قصف الحب, ru Лав-бомбинг, ja ラブボミング,
 * ko 러브 바밍, zh 爱情轰炸, hi लव बॉम्बिंग — with the English named in the
 * summary where both circulate. The remaining Latin-script locales keep the
 * loanword because that is what speakers there actually say.
 */
export const loveBombing: LocalizedGlossaryEntry = {
  en: {
    term: "Love bombing",
    summary:
      "A rush of attention, compliments and intensity that arrives far earlier than the other person could actually know you, and that cools or turns sharp the first time you set a boundary.",
    blocks: [
      { type: "h2", text: "Why early intensity is hard to read" },
      { type: "p", text: "The phrase came out of writing about controlling relationships and has since spread into everyday dating talk, where it now gets attached to anyone who is simply keen. That is worth resisting. Strong early feeling is common and usually sincere — new attraction is loud, and delighted people tend to say so. It is also not the same as future faking: this floods the present, today's messages and today's gifts, while future faking spends a future that never gets a date." },
      { type: "p", text: "What the term points at is narrower than enthusiasm. The affection is aimed at a version of you the other person could not have met yet: praise that would fit anybody, certainty about a future after four days. And **the informative moment is not the flood, it is the first small no**. Warmth that is real adjusts to it. A sudden chill, sulking or pressure to explain yourself says what the compliments did not." },
      { type: "h2", text: "How to recognise the pattern" },
      {
        type: "ul",
        items: [
          "The compliments describe someone they have not met yet — depth, loyalty, the one — in the first week.",
          "Contact fills the day: messages, calls, and a note of hurt when you are slow to answer.",
          "Gifts or grand gestures arrive early and large enough to feel like a debt.",
          "One small no changes the temperature: coldness, hurt, or pressure to justify yourself.",
        ],
      },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Slow the pace rather than judge the person. Keep your own week — friends, work, sleep, the plans you already had. Say the boring true thing: I like this, and I would rather go slower. Warmth that is real survives that easily, and usually feels relieved by it. And hold back the things that are hard to take back, at least for a while: money, keys, your address, an account of yours. Going slowly costs you nothing." },
      { type: "p", text: "Most fast starts are just fast starts. Watch how things go over a few weeks instead of deciding after one overwhelming evening, and be slow to put a label on someone for being warm. If the intensity turns into pressure you cannot refuse, that is no longer a question of pace, and talking it through with a friend outside the situation helps more than any list of signs." },
    ],
  },
  tr: {
    term: "Sevgi bombardımanı",
    summary:
      "Karşınızdaki sizi henüz tanıyamayacakken üstünüze boşalan ilgi, iltifat ve yoğunluk seli; ilk sınırı koyduğunuz anda soğuyan ya da sertleşen bir tempo. İngilizcede love bombing denir.",
    blocks: [
      { type: "h2", text: "Erken yoğunluğu okumak neden zor?" },
      { type: "p", text: "Terim, kontrolcü ilişkiler üzerine yazılan metinlerden çıktı ve zamanla gündelik flört diline yayıldı; bugün sadece hevesli olan herkes için kullanılıyor. Buna direnmekte fayda var. Başlangıçtaki güçlü duygu yaygındır ve çoğu zaman içtendir — yeni bir çekim gürültülüdür, mutlu olan insan da bunu söyler. Ayrıca future faking ile aynı şey değildir: bu, bugünü doldurur, bugünkü mesajları ve bugünkü hediyeleri; future faking ise hiçbir zaman tarihi konmayan bir geleceği harcar." },
      { type: "p", text: "Terimin işaret ettiği şey hevesten daha dardır. İlgi, karşı tarafın henüz tanışmış olamayacağı bir sizi hedefler: herkese uyacak övgüler, dördüncü günde kurulmuş bir gelecek kesinliği. **Asıl bilgi veren an da bu sel değil, ilk küçük hayırdır.** Gerçek sıcaklık ona uyum sağlar. Ani bir soğukluk, küskünlük ya da kendinizi açıklamaya zorlanmak, iltifatların söylemediği şeyi söyler." },
      { type: "h2", text: "Örüntü nasıl anlaşılır?" },
      {
        type: "ul",
        items: [
          "İltifatlar daha ilk hafta, henüz tanımadıkları birini anlatır: derinlik, sadakat, aradığı kişi.",
          "İletişim günü doldurur: mesajlar, aramalar ve geç yanıt verdiğinizde beliren kırgınlık tonu.",
          "Hediyeler ya da büyük jestler, borç hissi bırakacak kadar erken ve büyük gelir.",
          "Tek bir küçük hayır ısıyı değiştirir: soğukluk, kırgınlık ya da kendinizi savunma baskısı.",
        ],
      },
      { type: "h2", accent: "green", text: "Ne yapabilirsiniz?" },
      { type: "p", text: "Kişiyi yargılamak yerine tempoyu yavaşlatın. Kendi haftanızı koruyun: arkadaşlarınız, işiniz, uykunuz, zaten yaptığınız planlar. Sıkıcı ama doğru olan şeyi söyleyin: bu hoşuma gidiyor, ama daha yavaş ilerlemek istiyorum. Gerçek olan sıcaklık bunu kolayca kaldırır, hatta çoğu zaman rahatlar. Geri alması zor olan şeyleri de bir süre elinizde tutun: para, anahtar, adresiniz, bir hesabınız. Yavaş gitmenin size bir maliyeti yok." },
      { type: "p", text: "Hızlı başlangıçların çoğu sadece hızlı başlangıçtır. Tek bir büyüleyici akşamdan sonra karar vermek yerine birkaç haftaya bakın ve sıcak davrandığı için birine etiket yapıştırmakta acele etmeyin. Yoğunluk reddedemediğiniz bir baskıya dönüşüyorsa mesele artık tempo değildir; böyle bir durumda, olayın dışındaki bir arkadaşınızla konuşmak her işaret listesinden daha çok işe yarar." },
    ],
  },
  de: {
    term: "Lovebombing",
    summary:
      "Eine Flut aus Aufmerksamkeit, Komplimenten und Intensität, die weit früher kommt, als die andere Person dich kennen könnte, und die abkühlt oder scharf wird, sobald du zum ersten Mal eine Grenze ziehst.",
    blocks: [
      { type: "h2", text: "Warum frühe Intensität schwer zu lesen ist" },
      { type: "p", text: "Der Begriff stammt aus Texten über kontrollierende Beziehungen und ist seither in die Alltagssprache übergegangen, wo er inzwischen jeden trifft, der schlicht begeistert ist. Dagegen lohnt sich Widerstand. Starke Gefühle am Anfang sind normal und meistens ehrlich — frische Verliebtheit ist laut, und wer sich freut, sagt das auch. Es ist außerdem nicht dasselbe wie Future Faking: Hier wird die Gegenwart geflutet, die Nachrichten und Geschenke von heute, während Future Faking eine Zukunft ausgibt, die nie ein Datum bekommt." },
      { type: "p", text: "Worauf der Begriff zeigt, ist enger als Begeisterung. Die Zuneigung gilt einer Version von dir, die das Gegenüber noch gar nicht kennengelernt haben kann: Lob, das auf jeden passt, Gewissheit über eine Zukunft nach vier Tagen. **Und aufschlussreich ist nicht die Flut, sondern das erste kleine Nein.** Echte Wärme stellt sich darauf ein. Plötzliche Kühle, Schmollen oder Druck, dich zu rechtfertigen, sagt das, was die Komplimente nicht gesagt haben." },
      { type: "h2", text: "Woran du das Muster erkennst" },
      {
        type: "ul",
        items: [
          "Die Komplimente beschreiben schon in der ersten Woche jemanden, den man noch nicht kennt: Tiefe, Treue, die große Liebe.",
          "Der Kontakt füllt den Tag: Nachrichten, Anrufe und ein gekränkter Unterton, wenn du langsam antwortest.",
          "Geschenke oder große Gesten kommen früh und so groß, dass sie sich wie eine Schuld anfühlen.",
          "Ein kleines Nein verändert die Temperatur: Kälte, Gekränktsein oder Druck, dich zu erklären.",
        ],
      },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Verlangsame das Tempo, statt über die Person zu urteilen. Behalte deine eigene Woche: Freundinnen und Freunde, Arbeit, Schlaf, die Pläne, die schon standen. Sag das langweilige Wahre: Ich mag das, und ich möchte langsamer machen. Echte Wärme hält das mühelos aus und ist meistens sogar erleichtert. Und halte eine Weile zurück, was sich schwer zurücknehmen lässt: Geld, Schlüssel, deine Adresse, einen Zugang von dir. Langsamkeit kostet dich nichts." },
      { type: "p", text: "Die meisten schnellen Anfänge sind einfach schnelle Anfänge. Schau dir ein paar Wochen an, statt nach einem überwältigenden Abend zu entscheiden, und sei zurückhaltend damit, jemandem für Wärme ein Etikett zu verpassen. Wenn die Intensität in Druck kippt, den du nicht ablehnen kannst, geht es nicht mehr ums Tempo — dann hilft ein Gespräch mit einer Freundin oder einem Freund außerhalb der Situation mehr als jede Liste von Anzeichen." },
    ],
  },
  fr: {
    term: "Love bombing",
    summary:
      "Un déferlement d'attention, de compliments et d'intensité qui arrive bien avant que l'autre puisse vous connaître, et qui refroidit ou se durcit dès la première fois où vous posez une limite.",
    blocks: [
      { type: "h2", text: "Pourquoi l'intensité précoce est difficile à lire" },
      { type: "p", text: "L'expression vient de textes sur les relations d'emprise et s'est répandue dans le langage courant, où elle est aujourd'hui collée à quiconque se montre simplement enthousiaste. Mieux vaut y résister. Un sentiment fort au début est fréquent et le plus souvent sincère : une attirance neuve fait du bruit, et les gens ravis le disent. Ce n'est pas non plus du future faking : ici on inonde le présent, les messages et les cadeaux d'aujourd'hui, tandis que le future faking dépense un avenir auquel on ne met jamais de date." },
      { type: "p", text: "Ce que le terme désigne est plus étroit que l'enthousiasme. L'affection vise une version de vous que l'autre n'a pas encore pu rencontrer : des éloges qui iraient à n'importe qui, une certitude sur l'avenir au bout de quatre jours. Et **le moment révélateur n'est pas le déferlement, c'est le premier petit non**. Une chaleur réelle s'y adapte. Une froideur soudaine, de la bouderie ou la pression de vous justifier dit ce que les compliments taisaient." },
      { type: "h2", text: "Comment reconnaître ce schéma" },
      {
        type: "ul",
        items: [
          "Dès la première semaine, les compliments décrivent quelqu'un qu'il ne connaît pas encore : profondeur, loyauté, la bonne personne.",
          "Le contact remplit la journée : messages, appels, et une pointe de reproche quand vous tardez à répondre.",
          "Les cadeaux ou les grands gestes arrivent tôt et assez gros pour ressembler à une dette.",
          "Un petit non change la température : froideur, vexation, ou pression pour vous justifier.",
        ],
      },
      { type: "h2", accent: "green", text: "Que faire" },
      { type: "p", text: "Ralentissez le rythme plutôt que de juger la personne. Gardez votre semaine à vous : vos amis, le travail, le sommeil, les projets déjà prévus. Dites la chose ennuyeuse et vraie : j'aime bien, et je préfère aller plus doucement. Une chaleur réelle encaisse cela sans peine, et s'en trouve souvent soulagée. Et gardez un temps ce qui est difficile à reprendre : l'argent, les clés, votre adresse, l'accès à un de vos comptes. Aller lentement ne vous coûte rien." },
      { type: "p", text: "La plupart des débuts rapides ne sont que des débuts rapides. Observez quelques semaines au lieu de trancher après une soirée bouleversante, et n'accolez pas trop vite une étiquette à quelqu'un parce qu'il est chaleureux. Si l'intensité devient une pression que vous ne pouvez pas refuser, il n'est plus question de rythme : en parler à un ami extérieur à la situation aide alors bien plus que n'importe quelle liste de signes." },
    ],
  },
  es: {
    term: "Bombardeo de amor",
    summary:
      "Una avalancha de atención, halagos e intensidad que llega mucho antes de que la otra persona pueda conocerte, y que se enfría o se tensa la primera vez que pones un límite. En inglés se llama love bombing.",
    blocks: [
      { type: "h2", text: "Por qué la intensidad temprana es difícil de leer" },
      { type: "p", text: "La expresión salió de los textos sobre relaciones de control y desde entonces se ha colado en el lenguaje cotidiano, donde hoy se le cuelga a cualquiera que simplemente esté ilusionado. Conviene resistirse a eso. Sentir mucho al principio es habitual y casi siempre sincero: una atracción nueva hace ruido, y quien está encantado lo dice. Tampoco es lo mismo que el future faking: esto inunda el presente, los mensajes y los regalos de hoy, mientras que el future faking gasta un futuro al que nunca se le pone fecha." },
      { type: "p", text: "Lo que el término señala es más estrecho que el entusiasmo. El cariño apunta a una versión de ti que la otra persona todavía no ha podido conocer: elogios que le valdrían a cualquiera, certezas sobre el futuro al cuarto día. Y **el momento revelador no es la avalancha, es el primer no pequeño**. El calor de verdad se adapta a él. Un frío repentino, un enfado silencioso o la presión de justificarte dicen lo que los halagos no decían." },
      { type: "h2", text: "Cómo reconocer el patrón" },
      {
        type: "ul",
        items: [
          "Ya en la primera semana los halagos describen a alguien a quien todavía no conoce: profundidad, lealtad, la persona indicada.",
          "El contacto llena el día: mensajes, llamadas y un tono dolido cuando tardas en responder.",
          "Los regalos o los gestos grandes llegan pronto y con un tamaño que se parece a una deuda.",
          "Un no pequeño cambia la temperatura: frialdad, ofensa o presión para que te expliques.",
        ],
      },
      { type: "h2", accent: "green", text: "Qué puedes hacer" },
      { type: "p", text: "Baja el ritmo en lugar de juzgar a la persona. Conserva tu semana: tus amigos, el trabajo, el sueño, los planes que ya tenías. Di lo aburrido y verdadero: esto me gusta y prefiero ir más despacio. El cariño real aguanta eso sin problema y a menudo hasta lo agradece. Y guarda un tiempo lo que cuesta recuperar: dinero, llaves, tu dirección, el acceso a alguna cuenta tuya. Ir despacio no te cuesta nada." },
      { type: "p", text: "La mayoría de los comienzos rápidos son solo comienzos rápidos. Mira cómo va en unas semanas en vez de decidir después de una noche arrolladora, y tarda en ponerle una etiqueta a alguien por ser cariñoso. Si la intensidad se convierte en una presión que no puedes rechazar, ya no es una cuestión de ritmo, y hablarlo con una amistad ajena a la situación ayuda más que cualquier lista de señales." },
    ],
  },
  ar: {
    term: "قصف الحب",
    summary:
      "سيل من الاهتمام والمجاملات والحماسة يصل قبل أن يتمكّن الطرف الآخر من معرفتك فعلًا، ثم يبرد أو يتحوّل إلى ضغط عند أول حدّ ترسمه. ويُعرف بالإنجليزية باسم love bombing.",
    blocks: [
      { type: "h2", text: "لماذا يصعب قراءة الحماسة المبكرة" },
      { type: "p", text: "خرج المصطلح من كتابات عن علاقات السيطرة، ثم انتقل إلى لغة المواعدة اليومية حتى صار يُلصق بكل من يبدي حماسة بسيطة. ويستحق ذلك بعض المقاومة. المشاعر القوية في البداية شائعة وصادقة في الغالب؛ الانجذاب الجديد صاخب، ومن يشعر بالفرح يقوله. كما أنه ليس وعود المستقبل الزائفة: هذا يغرق الحاضر برسائل اليوم وهداياه، أمّا تلك فتنفق مستقبلًا لا يُحدَّد له موعد أبدًا." },
      { type: "p", text: "ما يشير إليه المصطلح أضيق من مجرد الحماس. المودّة موجَّهة إلى نسخة منك لم يكن بوسع الطرف الآخر أن يتعرّف عليها بعد: مديح يصلح لأي أحد، ويقين بشأن المستقبل بعد أربعة أيام. **واللحظة الكاشفة ليست السيل، بل أول رفض صغير.** الدفء الحقيقي يتكيّف معه. أمّا البرود المفاجئ أو العتب أو الضغط عليك كي تبرّر نفسك فيقول ما لم تقله المجاملات." },
      { type: "h2", text: "كيف تتعرّف على هذا النمط" },
      {
        type: "ul",
        items: [
          "المديح في الأسبوع الأول يصف شخصًا لم يتعرّف عليه بعد: عمقًا ووفاءً و«الشخص المناسب».",
          "التواصل يملأ اليوم: رسائل ومكالمات ونبرة عتاب إن تأخّرت في الرد.",
          "الهدايا أو المبادرات الكبيرة تأتي مبكرًا وبحجم يجعلها أشبه بدَين عليك.",
          "رفض صغير واحد يغيّر الحرارة: برود أو انكسار أو ضغط كي تشرح موقفك.",
        ],
      },
      { type: "h2", accent: "green", text: "ماذا يمكنك أن تفعل" },
      { type: "p", text: "خفّف الإيقاع بدل أن تحكم على الشخص. احتفظ بأسبوعك كما هو: أصدقاؤك وعملك ونومك والخطط التي كانت قائمة أصلًا. قل الجملة المملّة والصادقة: هذا يعجبني، وأفضّل أن نمضي ببطء أكثر. الدفء الحقيقي يحتمل هذا بسهولة، بل يرتاح له غالبًا. وأجّل بعض الوقت ما يصعب استرجاعه: المال، المفاتيح، عنوان سكنك، الدخول إلى أي حساب لك. البطء لا يكلّفك شيئًا." },
      { type: "p", text: "معظم البدايات السريعة ليست سوى بدايات سريعة. راقب مجرى الأمور على مدى أسابيع بدل أن تحسم بعد أمسية واحدة مبهرة، ولا تتعجّل في إلصاق وصف بشخص لأنه دافئ. أمّا إذا تحوّلت الحماسة إلى ضغط لا تستطيع رفضه، فالمسألة لم تعد إيقاعًا؛ والحديث مع صديق خارج الموقف يفيد حينها أكثر من أي قائمة علامات." },
    ],
  },
  ru: {
    term: "Лав-бомбинг",
    summary:
      "Поток внимания, комплиментов и накала, который обрушивается задолго до того, как человек мог бы вас узнать, и остывает или становится жёстким при первой же границе, которую вы обозначаете.",
    blocks: [
      { type: "h2", text: "Почему ранний накал трудно прочитать" },
      { type: "p", text: "Выражение пришло из текстов о контролирующих отношениях и разошлось по обычному разговору о свиданиях, где теперь достаётся всякому, кто просто увлечён. Этому стоит сопротивляться. Сильные чувства в начале — обычное дело и чаще всего искреннее: новая влюблённость шумная, и обрадованный человек об этом говорит. И это не то же самое, что фьючер-фейкинг: здесь заливают настоящее, сегодняшние сообщения и сегодняшние подарки, а фьючер-фейкинг тратит будущее, которому никогда не назначают дату." },
      { type: "p", text: "То, на что указывает термин, уже, чем просто увлечённость. Нежность адресована той версии вас, с которой человек ещё не мог познакомиться: похвалы, подходящие кому угодно, уверенность в будущем на четвёртый день. И **показателен не сам поток, а первое маленькое нет**. Настоящее тепло к нему подстраивается. Внезапный холод, обида или давление, чтобы вы оправдались, говорят то, чего не сказали комплименты." },
      { type: "h2", text: "Как распознать этот рисунок" },
      {
        type: "ul",
        items: [
          "Уже в первую неделю комплименты описывают человека, с которым он ещё не знаком: глубину, верность, «того самого».",
          "Общение заполняет день: сообщения, звонки и нотка обиды, если вы отвечаете медленно.",
          "Подарки или широкие жесты приходят рано и такого размера, что ощущаются как долг.",
          "Одно маленькое нет меняет температуру: холод, обида или давление, чтобы вы объяснились.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Замедлите темп вместо того, чтобы выносить приговор человеку. Сохраните свою неделю: друзей, работу, сон, планы, которые уже были. Скажите скучную правду: мне это нравится, и я хочу помедленнее. Настоящее тепло переносит такое легко, а чаще даже с облегчением. И придержите на время то, что трудно забрать назад: деньги, ключи, свой адрес, доступ к какому-нибудь своему аккаунту. Медленный темп ничего вам не стоит." },
      { type: "p", text: "Большинство быстрых начал — просто быстрые начала. Посмотрите, как всё пойдёт за несколько недель, вместо того чтобы решать после одного оглушительного вечера, и не спешите вешать на человека ярлык за то, что он тёплый. Если накал превращается в давление, от которого нельзя отказаться, речь идёт уже не о темпе, и разговор с другом вне этой истории поможет больше любого списка признаков." },
    ],
  },
  pt: {
    term: "Love bombing",
    summary:
      "Uma enxurrada de atenção, elogios e intensidade que chega muito antes de a outra pessoa poder conhecer você, e que esfria ou fica áspera na primeira vez que você põe um limite.",
    blocks: [
      { type: "h2", text: "Por que a intensidade precoce é difícil de ler" },
      { type: "p", text: "A expressão veio de textos sobre relações de controle e depois se espalhou pela conversa cotidiana, onde hoje é grudada em qualquer pessoa que esteja apenas animada. Vale resistir a isso. Sentimento forte no começo é comum e quase sempre sincero: uma atração nova é barulhenta, e quem está encantado costuma dizer. Também não é a mesma coisa que future faking: aqui se inunda o presente, as mensagens e os presentes de hoje, enquanto o future faking gasta um futuro que nunca ganha data." },
      { type: "p", text: "O que o termo aponta é mais estreito do que entusiasmo. O carinho mira uma versão de você que a outra pessoa ainda não teve como conhecer: elogios que serviriam para qualquer um, certezas sobre o futuro no quarto dia. E **o momento revelador não é a enxurrada, é o primeiro não pequeno**. O calor de verdade se acomoda a ele. Uma frieza repentina, um emburramento ou a pressão para você se justificar dizem o que os elogios não disseram." },
      { type: "h2", text: "Como reconhecer o padrão" },
      {
        type: "ul",
        items: [
          "Já na primeira semana os elogios descrevem alguém que a pessoa ainda não conhece: profundidade, lealdade, a pessoa certa.",
          "O contato preenche o dia: mensagens, ligações e um tom magoado quando você demora a responder.",
          "Presentes ou gestos grandiosos chegam cedo e grandes o bastante para parecerem uma dívida.",
          "Um não pequeno muda a temperatura: frieza, mágoa ou pressão para você se explicar.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer" },
      { type: "p", text: "Diminua o ritmo em vez de julgar a pessoa. Mantenha a sua semana: amigos, trabalho, sono, os programas que você já tinha. Diga a coisa chata e verdadeira: eu gosto disso e prefiro ir mais devagar. O carinho real aguenta isso sem esforço e muitas vezes até se alivia. E segure por um tempo o que é difícil de recuperar: dinheiro, chaves, seu endereço, o acesso a alguma conta sua. Ir devagar não te custa nada." },
      { type: "p", text: "A maioria dos começos rápidos é só isso: começos rápidos. Observe algumas semanas em vez de decidir depois de uma noite avassaladora, e demore a colar um rótulo em alguém por ser caloroso. Se a intensidade virar uma pressão que você não consegue recusar, já não é questão de ritmo, e conversar com um amigo de fora da situação ajuda mais do que qualquer lista de sinais." },
    ],
  },
  it: {
    term: "Love bombing",
    summary:
      "Un'ondata di attenzioni, complimenti e intensità che arriva molto prima che l'altra persona possa conoscerti, e che si raffredda o si irrigidisce la prima volta che poni un limite.",
    blocks: [
      { type: "h2", text: "Perché l'intensità precoce è difficile da leggere" },
      { type: "p", text: "L'espressione nasce da testi sulle relazioni di controllo e si è poi diffusa nel parlare comune, dove ormai viene appiccicata a chiunque sia semplicemente entusiasta. Vale la pena resistere. Provare molto all'inizio è normale e quasi sempre sincero: un'attrazione nuova fa rumore, e chi è contento lo dice. E non è la stessa cosa del future faking: qui si allaga il presente, i messaggi e i regali di oggi, mentre il future faking spende un futuro a cui non si mette mai una data." },
      { type: "p", text: "Quello che il termine indica è più stretto dell'entusiasmo. L'affetto è rivolto a una versione di te che l'altra persona non può ancora aver conosciuto: elogi che andrebbero bene per chiunque, certezze sul futuro al quarto giorno. E **il momento rivelatore non è l'ondata, è il primo piccolo no**. Il calore vero ci si adatta. Un freddo improvviso, il broncio o la pressione a giustificarti dicono ciò che i complimenti non dicevano." },
      { type: "h2", text: "Come riconoscere lo schema" },
      {
        type: "ul",
        items: [
          "Già nella prima settimana i complimenti descrivono qualcuno che non ha ancora conosciuto: profondità, lealtà, la persona giusta.",
          "Il contatto riempie la giornata: messaggi, chiamate e una nota di offesa quando tardi a rispondere.",
          "Regali o gesti grandiosi arrivano presto e abbastanza grandi da sembrare un debito.",
          "Un piccolo no cambia la temperatura: freddezza, permalosità o pressione perché ti spieghi.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa fare" },
      { type: "p", text: "Rallenta il ritmo invece di giudicare la persona. Tieniti la tua settimana: gli amici, il lavoro, il sonno, i programmi che avevi già. Di' la cosa noiosa e vera: mi piace, e preferisco andare più piano. Il calore autentico regge senza fatica, e spesso ne è persino sollevato. E trattieni per un po' quello che è difficile riprendersi: soldi, chiavi, il tuo indirizzo, l'accesso a un tuo account. Andare piano non ti costa niente." },
      { type: "p", text: "La maggior parte degli inizi veloci sono solo inizi veloci. Guarda come va nel giro di qualche settimana invece di decidere dopo una serata travolgente, e vacci piano prima di attaccare un'etichetta a qualcuno perché è affettuoso. Se l'intensità diventa una pressione che non puoi rifiutare, non è più una questione di ritmo, e parlarne con un amico esterno alla situazione aiuta più di qualsiasi elenco di segnali." },
    ],
  },
  ja: {
    term: "ラブボミング",
    summary:
      "相手がまだあなたを知りようもない時期に、好意も賛辞も熱量も一気に押し寄せてくること。そして、こちらが小さな線を一本引いた途端に冷めたり、とげとげしくなったりするのが特徴です。",
    blocks: [
      { type: "h2", text: "早すぎる熱量が読みにくい理由" },
      { type: "p", text: "この言葉はもともと支配的な関係について書かれた文章から出てきたもので、いまでは日常の恋愛話に広がり、単に前のめりなだけの人にまで貼られるようになりました。そこは踏みとどまりたいところです。始まりの強い気持ちはよくあることで、たいていは本物です。新しい好意は声が大きく、うれしい人はうれしいと言います。フューチャーフェイキングとも別物です。こちらは今日のメッセージや今日の贈り物で現在をあふれさせ、あちらは日付のつかない未来を先に使ってしまいます。" },
      { type: "p", text: "この言葉が指しているのは、熱心さよりも狭い範囲です。向けられている好意の相手は、まだ出会えていないはずのあなたです。誰にでも当てはまる褒め言葉、四日目の確信。そして**手がかりになるのは、その洪水ではなく、最初の小さな「無理」のほうです**。本物の温かさはそこに合わせて動きます。急な冷たさ、すねること、説明を迫る圧力は、賛辞が語らなかったことを語ります。" },
      { type: "h2", text: "パターンの見分け方" },
      {
        type: "ul",
        items: [
          "最初の一週間から、まだ会っていない誰かを褒めている。深さ、誠実さ、運命の人といった言葉。",
          "連絡が一日を埋める。メッセージ、電話、そして返事が遅いときに混じる傷ついた調子。",
          "贈り物や大きな振る舞いが早く、借りのように感じる大きさで届く。",
          "小さな断りひとつで温度が変わる。冷たさ、傷ついた態度、あるいは理由を説明させる圧力。",
        ],
      },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "相手を裁くのではなく、速度を落としてください。自分の一週間は手放さないこと。友人、仕事、睡眠、もともと入っていた予定です。そして退屈でも本当のことを言います。うれしいけれど、もう少しゆっくり進めたい。本物の温かさはこれを軽々と受け止めますし、たいていはほっとします。取り返しのつきにくいものはしばらく手元に置いてください。お金、鍵、住所、自分のアカウント。ゆっくり進むことに費用はかかりません。" },
      { type: "p", text: "速い始まりの多くは、ただ速い始まりです。圧倒された一晩で結論を出さず、数週間の流れを見てください。温かいというだけで誰かに名前をつけるのは急がないことです。もし熱量が、断れない圧力に変わってしまったなら、それはもう速度の話ではありません。そのときは、この状況の外にいる友人に話すほうが、どんな兆候リストよりも助けになります。" },
    ],
  },
  ko: {
    term: "러브 바밍",
    summary:
      "상대가 아직 당신을 알 수 없는 시기에 관심과 찬사와 열기가 한꺼번에 쏟아지는 일, 그리고 당신이 처음으로 선을 그었을 때 그 온도가 식거나 날카로워지는 흐름을 가리킵니다.",
    blocks: [
      { type: "h2", text: "이른 열기를 읽기 어려운 이유" },
      { type: "p", text: "이 말은 원래 통제적인 관계를 다룬 글에서 나왔고, 이후 일상적인 연애 이야기로 퍼지면서 이제는 그저 열심인 사람에게까지 붙습니다. 그건 좀 버텨 볼 만한 일입니다. 시작에 감정이 큰 것은 흔하고 대개 진심입니다. 새로 생긴 호감은 시끄럽고, 기쁜 사람은 기쁘다고 말합니다. 퓨처 페이킹과도 다릅니다. 이쪽은 오늘의 메시지와 오늘의 선물로 현재를 가득 채우고, 저쪽은 끝내 날짜가 붙지 않는 미래를 미리 써 버립니다." },
      { type: "p", text: "이 말이 가리키는 범위는 열정보다 좁습니다. 그 애정은 상대가 아직 만나 보았을 리 없는 당신을 향합니다. 누구에게나 들어맞을 칭찬, 나흘 만에 생긴 미래에 대한 확신. 그리고 **실마리는 그 홍수가 아니라 처음의 작은 거절입니다**. 진짜 다정함은 거기에 맞춰 움직입니다. 갑작스러운 냉랭함, 삐침, 해명을 요구하는 압박은 칭찬이 말하지 않은 것을 말해 줍니다." },
      { type: "h2", text: "이 패턴을 알아보는 법" },
      {
        type: "ul",
        items: [
          "첫 주부터 아직 만나 보지 못한 사람을 칭찬합니다. 깊이, 한결같음, 운명 같은 표현들.",
          "연락이 하루를 채웁니다. 메시지와 전화, 그리고 답이 늦을 때 섞이는 서운한 기색.",
          "선물이나 큰 제스처가 이르게, 빚처럼 느껴질 만큼 크게 옵니다.",
          "작은 거절 하나에 온도가 달라집니다. 냉랭함, 서운함, 또는 해명하라는 압박.",
        ],
      },
      { type: "h2", accent: "green", text: "무엇을 하면 좋을까" },
      { type: "p", text: "사람을 판단하기보다 속도를 늦추세요. 자기 한 주를 지키면 됩니다. 친구, 일, 잠, 원래 있던 약속들. 그리고 시시하지만 사실인 말을 하세요. 좋긴 한데, 조금 천천히 가고 싶어. 진짜 다정함은 이 말을 가볍게 받아들이고, 대개는 오히려 안도합니다. 되돌리기 어려운 것들은 한동안 쥐고 계세요. 돈, 열쇠, 집 주소, 계정 접근 권한. 천천히 가는 데는 비용이 들지 않습니다." },
      { type: "p", text: "빠른 시작의 대부분은 그냥 빠른 시작입니다. 압도당한 하룻밤으로 결론 내리지 말고 몇 주의 흐름을 보세요. 다정하다는 이유만으로 누군가에게 이름표를 붙이는 일도 서두르지 마시고요. 다만 그 열기가 거절할 수 없는 압박으로 바뀐다면 그건 더 이상 속도의 문제가 아닙니다. 그럴 때는 이 상황 밖에 있는 친구와 이야기하는 편이 어떤 신호 목록보다 도움이 됩니다." },
    ],
  },
  zh: {
    term: "爱情轰炸",
    summary:
      "在对方还不可能真正了解你的时候，关注、赞美和热度就一股脑涌来；而当你第一次划下界线，那份热度会突然变冷或变得尖锐。英文叫 love bombing。",
    blocks: [
      { type: "h2", text: "为什么早期的热度很难判断" },
      { type: "p", text: "这个说法最早出现在讨论控制型关系的文章里，后来进入日常的恋爱话题，如今连单纯只是很兴奋的人也会被贴上这个标签。这一点值得警惕。开头感情强烈是常见的，多数时候也是真诚的：新的心动本来就吵，高兴的人会把高兴说出口。它和画大饼也不是一回事：爱情轰炸淹没的是当下，是今天的消息和今天的礼物；画大饼花掉的是一个永远定不下日期的将来。" },
      { type: "p", text: "这个词真正指向的范围比热情窄得多。那些好意针对的是一个对方还来不及认识的你：换成任何人都成立的夸奖，认识第四天就有的笃定。而**真正说明问题的不是这场洪水，是第一次小小的拒绝。**真实的温度会跟着调整。突然的冷淡、闹别扭、逼你解释自己，说出了那些赞美没有说的事。" },
      { type: "h2", text: "怎么看出这个模式" },
      {
        type: "ul",
        items: [
          "第一周的夸奖描述的是一个他还没认识的人：深情、忠诚、命中注定的那个。",
          "联系把一天填满：消息、电话，以及你回慢了之后那点受伤的语气。",
          "礼物或大动作来得很早，大到让人觉得欠了人情。",
          "一个小小的拒绝就改变温度：变冷、受伤，或者逼你解释。",
        ],
      },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "把速度慢下来，而不是急着给人下判断。守住自己的一周：朋友、工作、睡眠，还有本来就有的安排。然后把那句无趣但真实的话说出来：我挺喜欢的，但想慢一点。真实的热情很容易接得住这句话，多数时候反而松一口气。那些不好收回的东西先留一阵子：钱、钥匙、住址、你的账号。慢一点不需要你付出什么。" },
      { type: "p", text: "大多数快速的开始，就只是快速的开始而已。别在被冲昏头的那一晚下结论，看看几个星期里事情怎么走；也别因为一个人热情就急着给他安一个名字。但如果这份热度变成了你没办法拒绝的压力，那就不再是快慢的问题了；这时候找一个局外的朋友聊聊，比任何一份信号清单都有用。" },
    ],
  },
  nl: {
    term: "Lovebombing",
    summary:
      "Een stortvloed aan aandacht, complimenten en intensiteit die veel eerder komt dan de ander je kan kennen, en die afkoelt of scherp wordt zodra je voor het eerst een grens stelt.",
    blocks: [
      { type: "h2", text: "Waarom vroege intensiteit lastig te lezen is" },
      { type: "p", text: "De term komt uit teksten over controlerende relaties en is daarna in het gewone datinggesprek terechtgekomen, waar hij inmiddels op iedereen wordt geplakt die simpelweg enthousiast is. Dat is het waard om tegen te gaan. Sterke gevoelens aan het begin zijn normaal en meestal oprecht: nieuwe verliefdheid maakt lawaai, en wie blij is zegt dat. Het is ook niet hetzelfde als future faking: dit overspoelt het heden, de berichten en cadeaus van vandaag, terwijl future faking een toekomst uitgeeft die nooit een datum krijgt." },
      { type: "p", text: "Waar de term op wijst is smaller dan enthousiasme. De genegenheid richt zich op een versie van jou die de ander nog niet kan hebben leren kennen: lof die op iedereen past, zekerheid over de toekomst na vier dagen. En **het veelzeggende moment is niet de vloedgolf, het is het eerste kleine nee**. Echte warmte past zich daaraan aan. Plotselinge kilte, mokken of druk om jezelf te verantwoorden zegt wat de complimenten niet zeiden." },
      { type: "h2", text: "Hoe je het patroon herkent" },
      {
        type: "ul",
        items: [
          "De complimenten beschrijven in week één iemand die hij nog niet kent: diepgang, trouw, de ware.",
          "Het contact vult de dag: berichten, telefoontjes en een gekwetst toontje als je traag antwoordt.",
          "Cadeaus of grote gebaren komen vroeg en zijn groot genoeg om als een schuld te voelen.",
          "Eén klein nee verandert de temperatuur: kilte, gekwetstheid of druk om je te verklaren.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je kunt doen" },
      { type: "p", text: "Verlaag het tempo in plaats van de ander te veroordelen. Houd je eigen week: vrienden, werk, slaap, de plannen die er al waren. Zeg het saaie ware ding: ik vind dit leuk, en ik wil graag rustiger aan doen. Echte warmte kan daar moeiteloos tegen en is er meestal zelfs opgelucht over. En houd even vast wat moeilijk terug te nemen is: geld, sleutels, je adres, toegang tot een account van je. Langzaam gaan kost je niets." },
      { type: "p", text: "De meeste snelle starts zijn gewoon snelle starts. Kijk hoe het over een paar weken loopt in plaats van te beslissen na één overweldigende avond, en wees traag met een etiket voor iemand die warm is. Slaat de intensiteit om in druk die je niet kunt weigeren, dan gaat het niet meer over tempo, en helpt praten met een vriend buiten de situatie meer dan welke lijst met signalen ook." },
    ],
  },
  pl: {
    term: "Love bombing",
    summary:
      "Zalew uwagi, komplementów i intensywności, który pojawia się dużo wcześniej, niż druga osoba mogłaby cię poznać, i stygnie albo się zaostrza przy pierwszej granicy, jaką stawiasz.",
    blocks: [
      { type: "h2", text: "Dlaczego wczesną intensywność trudno odczytać" },
      { type: "p", text: "Wyrażenie wzięło się z tekstów o relacjach opartych na kontroli, a potem trafiło do codziennych rozmów o randkowaniu, gdzie dziś przykleja się je każdemu, kto jest po prostu zapalony. Warto się temu opierać. Silne uczucia na początku są zwyczajne i najczęściej szczere: świeża fascynacja jest głośna, a ucieszony człowiek zwykle to mówi. To także nie to samo co future faking: tutaj zalewa się teraźniejszość, dzisiejsze wiadomości i dzisiejsze prezenty, a future faking wydaje przyszłość, której nigdy nie przypisuje się daty." },
      { type: "p", text: "To, na co wskazuje ten termin, jest węższe niż entuzjazm. Czułość kierowana jest do wersji ciebie, której druga osoba nie mogła jeszcze poznać: pochwały pasujące do każdego, pewność co do przyszłości czwartego dnia. A **rozstrzygający jest nie zalew, tylko pierwsze małe nie**. Prawdziwe ciepło się do niego dostosowuje. Nagły chłód, dąsy albo presja, żebyś się tłumaczył, mówią to, czego nie powiedziały komplementy." },
      { type: "h2", text: "Jak rozpoznać ten schemat" },
      {
        type: "ul",
        items: [
          "Już w pierwszym tygodniu komplementy opisują kogoś, kogo ta osoba jeszcze nie zna: głębię, lojalność, tę jedyną.",
          "Kontakt wypełnia dzień: wiadomości, telefony i nutka urazy, gdy wolno odpisujesz.",
          "Prezenty albo wielkie gesty przychodzą wcześnie i na tyle duże, że przypominają dług.",
          "Jedno małe nie zmienia temperaturę: chłód, uraza albo presja, żebyś się wytłumaczył.",
        ],
      },
      { type: "h2", accent: "green", text: "Co możesz zrobić" },
      { type: "p", text: "Zwolnij tempo, zamiast oceniać człowieka. Zatrzymaj swój własny tydzień: znajomych, pracę, sen, plany, które już były. Powiedz nudną prawdę: podoba mi się to i wolałbym iść wolniej. Prawdziwe ciepło znosi to bez trudu, a częściej przyjmuje z ulgą. I przytrzymaj przez jakiś czas to, co trudno cofnąć: pieniądze, klucze, swój adres, dostęp do konta. Wolniejsze tempo nic cię nie kosztuje." },
      { type: "p", text: "Większość szybkich początków to po prostu szybkie początki. Popatrz, jak potoczy się kilka tygodni, zamiast rozstrzygać po jednym oszałamiającym wieczorze, i nie spiesz się z przyklejaniem komuś etykiety za to, że jest ciepły. Jeśli intensywność zamienia się w presję, której nie da się odmówić, to nie jest już kwestia tempa, a rozmowa z kimś spoza tej historii pomoże bardziej niż jakakolwiek lista sygnałów." },
    ],
  },
  sv: {
    term: "Love bombing",
    summary:
      "En störtflod av uppmärksamhet, komplimanger och intensitet som kommer långt innan den andra kan känna dig, och som svalnar eller blir vass första gången du sätter en gräns.",
    blocks: [
      { type: "h2", text: "Varför tidig intensitet är svår att läsa" },
      { type: "p", text: "Uttrycket kommer från texter om kontrollerande relationer och har sedan spridit sig till vanligt dejtingsnack, där det numera klistras på alla som helt enkelt är entusiastiska. Det är värt att stå emot. Starka känslor i början är vanliga och oftast uppriktiga: ny förälskelse är högljudd, och den som är glad säger det. Det är inte heller samma sak som future faking: här översvämmas nuet, dagens meddelanden och dagens presenter, medan future faking gör av med en framtid som aldrig får ett datum." },
      { type: "p", text: "Det termen pekar på är smalare än entusiasm. Ömheten riktas mot en version av dig som den andra omöjligt kan ha lärt känna än: beröm som skulle passa vem som helst, visshet om framtiden efter fyra dagar. Och **det avslöjande ögonblicket är inte floden, det är det första lilla nejet**. Äkta värme anpassar sig till det. Plötslig kyla, tjurighet eller press på dig att förklara dig säger det som komplimangerna inte sa." },
      { type: "h2", text: "Så känner du igen mönstret" },
      {
        type: "ul",
        items: [
          "Redan första veckan beskriver komplimangerna någon hen inte har träffat: djup, lojalitet, den rätta.",
          "Kontakten fyller dagen: meddelanden, samtal och en sårad ton när du svarar långsamt.",
          "Presenter eller stora gester kommer tidigt och tillräckligt stora för att kännas som en skuld.",
          "Ett litet nej ändrar temperaturen: kyla, sårad min eller press att försvara dig.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Sänk tempot i stället för att döma personen. Behåll din egen vecka: vänner, jobb, sömn, planerna som redan fanns. Säg det tråkiga och sanna: jag gillar det här, och jag vill ta det långsammare. Äkta värme klarar det utan problem och blir oftast lättad. Håll dessutom kvar en stund det som är svårt att ta tillbaka: pengar, nycklar, din adress, tillgången till något av dina konton. Att gå långsamt kostar dig ingenting." },
      { type: "p", text: "De flesta snabba starter är bara snabba starter. Se hur det går över några veckor i stället för att avgöra saken efter en överväldigande kväll, och var långsam med att sätta en etikett på någon för att hen är varm. Om intensiteten övergår i påtryckningar du inte kan tacka nej till handlar det inte längre om tempo, och då hjälper ett samtal med en vän utanför situationen mer än någon lista med tecken." },
    ],
  },
  hi: {
    term: "लव बॉम्बिंग",
    summary:
      "इतनी जल्दी उमड़ता ध्यान, तारीफ़ और तीव्रता कि सामने वाला आपको जान ही नहीं सकता था; और पहली बार कोई सीमा तय करते ही वही गर्मी या तो ठंडी पड़ जाती है या तीखी हो जाती है।",
    blocks: [
      { type: "h2", text: "शुरुआती तीव्रता को पढ़ना मुश्किल क्यों है" },
      { type: "p", text: "यह शब्द नियंत्रण वाले रिश्तों पर लिखे गए लेखों से निकला और फिर रोज़मर्रा की डेटिंग बातचीत में फैल गया, जहाँ अब यह हर उस इंसान पर चिपका दिया जाता है जो बस उत्साहित है। इसका विरोध करना ठीक है। शुरुआत में तेज़ भावनाएँ आम हैं और अक्सर सच्ची भी: नया आकर्षण शोर करता है, और जो ख़ुश है वह कह देता है। यह फ़्यूचर फेकिंग भी नहीं है: यह वर्तमान को भर देता है — आज के मैसेज, आज के तोहफ़े — जबकि फ़्यूचर फेकिंग वह भविष्य ख़र्च करता है जिसकी तारीख़ कभी तय नहीं होती।" },
      { type: "p", text: "यह शब्द जिस ओर इशारा करता है, वह उत्साह से कहीं संकरा है। स्नेह आपके उस रूप के लिए है जिससे सामने वाला अभी मिल ही नहीं सकता था: ऐसी तारीफ़ें जो किसी पर भी फ़िट बैठें, चौथे दिन बन चुका भविष्य का यक़ीन। और **असली सुराग़ यह बाढ़ नहीं, पहली छोटी सी ना है**। सच्ची गर्मजोशी उसके साथ ख़ुद को ढाल लेती है। अचानक की ठंडक, रूठना, या ख़ुद को समझाने का दबाव वह कह देता है जो तारीफ़ों ने नहीं कहा।" },
      { type: "h2", text: "इस पैटर्न को कैसे पहचानें" },
      {
        type: "ul",
        items: [
          "पहले ही हफ़्ते तारीफ़ें ऐसे इंसान की होती हैं जिससे वे अभी मिले ही नहीं: गहराई, वफ़ादारी, सही इंसान।",
          "संपर्क पूरा दिन भर देता है: मैसेज, कॉल, और देर से जवाब देने पर आहत सा लहज़ा।",
          "तोहफ़े या बड़े इशारे इतनी जल्दी और इतने बड़े आते हैं कि क़र्ज़ जैसे लगने लगें।",
          "एक छोटी सी ना तापमान बदल देती है: ठंडापन, नाराज़गी, या सफ़ाई देने का दबाव।",
        ],
      },
      { type: "h2", accent: "green", text: "क्या किया जा सकता है" },
      { type: "p", text: "इंसान पर फ़ैसला सुनाने के बजाय रफ़्तार धीमी कीजिए। अपना हफ़्ता अपने पास रखिए: दोस्त, काम, नींद, और वे योजनाएँ जो पहले से थीं। फिर वह उबाऊ मगर सच्ची बात कह दीजिए — मुझे यह अच्छा लग रहा है, पर मैं थोड़ा धीरे चलना चाहता हूँ। सच्ची गर्मजोशी इसे आसानी से झेल लेती है, अक्सर तो राहत ही महसूस करती है। और जो वापस लेना मुश्किल हो, उसे कुछ समय रोक रखिए: पैसा, चाबी, अपना पता, किसी खाते की पहुँच। धीरे चलने की कोई क़ीमत नहीं लगती।" },
      { type: "p", text: "तेज़ शुरुआतें ज़्यादातर बस तेज़ शुरुआतें ही होती हैं। एक भारी-भरकम शाम के बाद नतीजा निकालने के बजाय कुछ हफ़्तों का रुख़ देखिए, और किसी को गर्मजोश होने भर के लिए कोई नाम देने में जल्दबाज़ी मत कीजिए। हाँ, अगर वह तीव्रता ऐसे दबाव में बदल जाए जिसे आप मना नहीं कर पा रहे, तो बात अब रफ़्तार की नहीं रही; ऐसे में इस हालात से बाहर के किसी दोस्त से बात करना किसी भी संकेत-सूची से ज़्यादा काम आता है।" },
    ],
  },
};
