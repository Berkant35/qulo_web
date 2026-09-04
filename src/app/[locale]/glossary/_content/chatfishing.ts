import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Chatfishing — letting an AI write your dating messages, so the person on the
 * other end is charmed by a language model rather than by you.
 *
 * Judgement calls a later editor should not undo by accident:
 *
 * - THE SPECTRUM IS DELIBERATE. This page does not treat every use of a model
 *   as chatfishing. Fixing spelling or taking the sting out of an angry draft
 *   is named as a different thing from handing over the whole conversation, and
 *   the line is drawn by one test — would they recognise you when you meet.
 *   Flattening this into "using AI is deception" would be both wrong and
 *   preachy, and rule 7 (no moralising) applies here more than anywhere.
 *
 * - NO "MOST PEOPLE". The English draft originally read "most people draw the
 *   line at…", which is an unsourced claim about the world. It is written as a
 *   test the reader can apply instead. Do not reintroduce a quantifier here,
 *   and do not add a percentage of daters who use AI — no citable primary
 *   source for that was available.
 *
 * - NO SOURCES IN THE BODY. The term is well documented (an encyclopaedia entry
 *   plus science and psychology press), which is why the definition is written
 *   with confidence, but the page cites nothing: a glossary entry that name-
 *   drops publications reads like an essay, and the brand rule keeps outside
 *   platforms unnamed anyway. No chatbot, model or vendor is named either.
 *
 * - NO QULO ANGLE. There is no honest one. Writing your own questions does not
 *   prevent someone chatting with a model, so block 7 is spent on what
 *   chatfishing costs the person doing it — the gap that shows up on the first
 *   date — which is the part readers searching this term actually need.
 *
 * - TERM NAMES. Because the word is new, most languages have no native
 *   equivalent and simply use the English; ar/ru/ja/ko/hi take the native-script
 *   rendering people actually type. zh is the exception with a real idiom of its
 *   own, "AI 代聊", so that is the term and the summary names the English word.
 */
export const chatfishing: LocalizedGlossaryEntry = {
  en: {
    term: "Chatfishing",
    summary:
      "Letting an AI write your dating messages, so the person on the other end is being charmed by a language model's words while believing they are getting to know you.",
    blocks: [
      { type: "h2", text: "Where the word came from" },
      { type: "p", text: "It is a new word, built on catfishing: that one fakes the face, this one fakes the voice. It arrived as chatbots became good enough to write a warm, funny paragraph in two seconds. Almost nobody starts out planning to deceive anyone. You are staring at an empty message box at one in the morning, terrified of being boring, and there is a tool right there that is never boring." },
      { type: "p", text: "There is a real spectrum here, and pretending otherwise is not useful. Running a message through a model to fix your spelling, or to take the sting out of something you wrote while angry, is not the same as pasting in what they said and sending back whatever comes out. A simple test settles most of it: **would they recognise you when you meet?**" },
      { type: "h2", text: "How to tell you are talking to a model" },
      { type: "ul", items: [
        "Every reply is fluent, warm and slightly generic — lovely sentences that would suit almost anyone.",
        "It responds to everything you said and asks nothing real back; the follow-ups stay polite and surface-level.",
        "The tone never moves. Same length, same polish at nine in the morning and at two at night, never a typo, never a one-word reply.",
        "Specifics evaporate. Something you mentioned two days ago comes back paraphrased, or does not come back at all.",
      ] },
      { type: "h2", accent: "green", text: "How to check without accusing anyone" },
      { type: "p", text: "If you suspect it, do not open with an accusation — you may be wrong, and it is a horrible thing to be wrong about. **Move the conversation somewhere a model handles badly** instead. Send a voice note. Send a photo of what is in front of you. Ask something that only makes sense if they remember what you said on Tuesday. Or just suggest meeting sooner. Real people are much easier to find in person." },
      { type: "p", text: "If you are the one doing it, **the bill comes on the first date**. Three weeks of being wittier than you are, and then you have to sit at a table as yourself. The drop gets felt even when nobody can name it. Nobody was ever left over a clumsy message — people leave over the gap between the message and the person." },
    ],
  },
  tr: {
    term: "Chatfishing",
    summary:
      "Flört mesajlarını yapay zekâya yazdırmak; karşındaki kişi seni tanıdığını sanırken aslında bir dil modelinin cümlelerine tutulur.",
    blocks: [
      { type: "h2", text: "Kelime nereden geliyor?" },
      { type: "p", text: "Yeni bir kelime; catfishing'in üzerine kuruldu. O yüzü taklit ediyordu, bu sesi taklit ediyor. Sohbet botları iki saniyede sıcak ve esprili bir paragraf yazacak kadar iyileşince ortaya çıktı. Neredeyse kimse baştan birini kandırmayı planlamıyor. Gecenin biri, boş mesaj kutusuna bakıyorsun, sıkıcı görünmekten ödün kopuyor ve elinin altında asla sıkıcı olmayan bir araç duruyor." },
      { type: "p", text: "Burada gerçek bir gri alan var ve yok saymanın kimseye faydası yok. Yazım hatalarını düzeltmek için mesajını modele okutmak ya da sinirliyken yazdığın bir cümlenin dikenlerini almak, karşıdakinin yazdığını yapıştırıp çıkanı olduğu gibi göndermekle aynı şey değil. Basit bir soru meselenin çoğunu çözer: **buluştuğunuzda seni tanır mı?**" },
      { type: "h2", text: "Karşında bir model olduğunu nasıl anlarsın?" },
      { type: "ul", items: [
        "Her cevap akıcı, sıcak ve tuhaf biçimde genel — neredeyse herkese uyacak güzel cümleler.",
        "Söylediğin her şeye karşılık veriyor ama gerçek bir soru sormuyor; devam soruları hep nazik ve yüzeysel kalıyor.",
        "Ton hiç oynamıyor. Sabah dokuzda da gece ikide de aynı uzunluk, aynı cila; ne bir yazım hatası ne tek kelimelik bir cevap.",
        "Ayrıntılar buharlaşıyor. İki gün önce anlattığın şey ya başka kelimelerle geri geliyor ya hiç geri gelmiyor.",
      ] },
      { type: "h2", accent: "green", text: "Suçlamadan nasıl anlarsın?" },
      { type: "p", text: "Şüpheleniyorsan suçlamayla başlama — yanılıyor olabilirsin ve yanılmak için hiç hoş bir konu değil. Bunun yerine **sohbeti modelin iyi beceremediği bir yere taşı**. Sesli mesaj at. Önündeki manzaranın fotoğrafını gönder. Salı günü söylediğin bir şeyi hatırlamadan anlamsız kalacak bir soru sor. Ya da buluşmayı öne al. Gerçek insanı yüz yüze bulmak çok daha kolay." },
      { type: "p", text: "Bunu yapan taraf sensen, **fatura ilk buluşmada geliyor**. Üç hafta boyunca olduğundan daha esprili biri oluyorsun, sonra masaya kendin olarak oturmak zorunda kalıyorsun. Düşüş, adı konmasa bile hissediliyor. Kimse beceriksiz bir mesaj yüzünden bırakılmadı; insanlar mesajla kişi arasındaki mesafe yüzünden bırakıyor." },
    ],
  },
  de: {
    term: "Chatfishing",
    summary:
      "Die eigenen Dating-Nachrichten von einer KI schreiben lassen, sodass sich das Gegenüber von den Worten eines Sprachmodells bezaubern lässt und dabei glaubt, dich kennenzulernen.",
    blocks: [
      { type: "h2", text: "Woher das Wort kommt" },
      { type: "p", text: "Ein neues Wort, gebaut auf Catfishing: Dort wird das Gesicht gefälscht, hier die Stimme. Es tauchte auf, als Chatbots gut genug wurden, um in zwei Sekunden einen warmen, witzigen Absatz zu schreiben. Fast niemand nimmt sich vor, jemanden zu täuschen. Man sitzt um ein Uhr nachts vor einem leeren Nachrichtenfeld, hat Angst, langweilig zu sein, und daneben liegt ein Werkzeug, das nie langweilig ist." },
      { type: "p", text: "Es gibt hier eine echte Grauzone, und so zu tun, als gäbe es sie nicht, hilft niemandem. Eine Nachricht durch ein Modell zu schicken, um Tippfehler zu beseitigen oder einer wütend geschriebenen Zeile die Schärfe zu nehmen, ist nicht dasselbe, wie das Geschriebene hineinzukopieren und zurückzuschicken, was herauskommt. Eine einfache Frage klärt das meiste: **Würde die Person dich beim Treffen wiedererkennen?**" },
      { type: "h2", text: "Woran du merkst, dass ein Modell antwortet" },
      { type: "ul", items: [
        "Jede Antwort ist flüssig, warm und leicht beliebig — schöne Sätze, die zu fast jedem passen würden.",
        "Sie geht auf alles ein, was du geschrieben hast, und fragt nichts wirklich zurück; die Nachfragen bleiben höflich und oberflächlich.",
        "Der Ton bewegt sich nie. Um neun Uhr morgens und um zwei Uhr nachts dieselbe Länge, dieselbe Politur, kein Tippfehler, nie eine Ein-Wort-Antwort.",
        "Konkretes verschwindet. Was du vor zwei Tagen erzählt hast, kommt umformuliert zurück — oder gar nicht.",
      ] },
      { type: "h2", accent: "green", text: "Wie du es prüfst, ohne jemanden zu beschuldigen" },
      { type: "p", text: "Wenn du es vermutest, fang nicht mit einem Vorwurf an — du könntest dich irren, und das ist eine hässliche Sache, sich zu irren. **Verlege das Gespräch dorthin, wo ein Modell schlecht ist.** Schick eine Sprachnachricht. Schick ein Foto von dem, was vor dir liegt. Frag etwas, das nur Sinn ergibt, wenn sich jemand an Dienstag erinnert. Oder schlag ein früheres Treffen vor. Echte Menschen findet man persönlich viel leichter." },
      { type: "p", text: "Und wenn du derjenige bist: **Die Rechnung kommt beim ersten Date.** Drei Wochen lang witziger sein, als du bist, und dann als du selbst am Tisch sitzen. Der Absturz wird gespürt, auch wenn niemand ihn benennen kann. Wegen einer unbeholfenen Nachricht hat noch nie jemand aufgehört — Menschen gehen wegen des Abstands zwischen der Nachricht und der Person." },
    ],
  },
  fr: {
    term: "Chatfishing",
    summary:
      "Faire écrire ses messages de rencontre par une IA, de sorte que l'autre est séduit par les phrases d'un modèle de langage en croyant apprendre à vous connaître.",
    blocks: [
      { type: "h2", text: "D'où vient le mot" },
      { type: "p", text: "C'est un mot récent, construit sur le catfishing : là on falsifie le visage, ici on falsifie la voix. Il est apparu quand les agents conversationnels sont devenus capables d'écrire un paragraphe chaleureux et drôle en deux secondes. Presque personne ne commence en décidant de tromper quelqu'un. On fixe une zone de texte vide à une heure du matin, terrifié à l'idée d'être ennuyeux, et l'outil juste à côté ne l'est jamais." },
      { type: "p", text: "Il existe un vrai dégradé, et faire semblant du contraire n'aide personne. Passer un message dans un modèle pour corriger l'orthographe, ou pour retirer le venin d'une phrase écrite en colère, ce n'est pas la même chose que coller ce que l'autre a écrit et renvoyer ce qui sort. Une question simple règle l'essentiel : **vous reconnaîtrait-on en vrai ?**" },
      { type: "h2", text: "Comment savoir qu'on parle à un modèle" },
      { type: "ul", items: [
        "Chaque réponse est fluide, chaleureuse et un peu passe-partout — de jolies phrases qui iraient à presque n'importe qui.",
        "Elle répond à tout ce que vous avez dit et ne demande rien de réel en retour ; les relances restent polies et superficielles.",
        "Le ton ne bouge jamais. Même longueur, même vernis à neuf heures du matin et à deux heures du matin, aucune faute de frappe, jamais une réponse d'un mot.",
        "Le concret s'évapore. Ce que vous avez raconté il y a deux jours revient reformulé, ou ne revient pas du tout.",
      ] },
      { type: "h2", accent: "green", text: "Comment vérifier sans accuser" },
      { type: "p", text: "Si vous avez un doute, ne commencez pas par une accusation : vous pouvez vous tromper, et c'est un très mauvais sujet sur lequel se tromper. **Déplacez plutôt la conversation là où un modèle est mauvais.** Envoyez un message vocal. Envoyez une photo de ce que vous avez sous les yeux. Posez une question qui n'a de sens que si l'on se souvient de mardi. Ou proposez de vous voir plus tôt. Les vraies personnes se trouvent bien plus vite en face à face." },
      { type: "p", text: "Et si c'est vous qui le faites, **la note arrive au premier rendez-vous**. Trois semaines à être plus drôle que vous ne l'êtes, puis il faut s'asseoir à table en étant soi. La chute se sent même quand personne ne sait la nommer. Personne n'a jamais été quitté pour un message maladroit : on quitte pour l'écart entre le message et la personne." },
    ],
  },
  es: {
    term: "Chatfishing",
    summary:
      "Dejar que una IA escriba tus mensajes en apps de citas, de modo que la otra persona se enamora de las frases de un modelo de lenguaje mientras cree que te está conociendo.",
    blocks: [
      { type: "h2", text: "De dónde viene la palabra" },
      { type: "p", text: "Es una palabra reciente, construida sobre el catfishing: aquel falsea la cara, este falsea la voz. Apareció cuando los chatbots empezaron a escribir un párrafo cálido y gracioso en dos segundos. Casi nadie empieza queriendo engañar a nadie. Estás mirando una caja de texto vacía a la una de la madrugada, con pánico a resultar aburrido, y al lado tienes una herramienta que nunca lo es." },
      { type: "p", text: "Aquí hay un degradado real y fingir lo contrario no ayuda. Pasar un mensaje por un modelo para corregir la ortografía, o para quitarle el veneno a algo escrito con rabia, no es lo mismo que pegar lo que te han dicho y enviar lo que salga. Una pregunta sencilla resuelve casi todo: **¿te reconocería al verte?**" },
      { type: "h2", text: "Cómo saber que hablas con un modelo" },
      { type: "ul", items: [
        "Cada respuesta es fluida, cálida y un poco genérica — frases preciosas que le servirían a cualquiera.",
        "Responde a todo lo que dijiste y no pregunta nada de verdad; las repreguntas se quedan educadas y en la superficie.",
        "El tono nunca se mueve. La misma longitud y el mismo pulido a las nueve de la mañana y a las dos de la madrugada, sin una errata, sin una respuesta de una palabra.",
        "Lo concreto se evapora. Algo que contaste hace dos días vuelve parafraseado, o no vuelve.",
      ] },
      { type: "h2", accent: "green", text: "Cómo comprobarlo sin acusar a nadie" },
      { type: "p", text: "Si lo sospechas, no empieces acusando: puedes equivocarte, y es un asunto horrible en el que equivocarse. **Lleva la conversación a donde un modelo funciona mal.** Manda un audio. Manda una foto de lo que tienes delante. Pregunta algo que solo tiene sentido si recuerda lo que dijiste el martes. O propón veros antes. A las personas reales se las encuentra mucho mejor en persona." },
      { type: "p", text: "Y si quien lo hace eres tú, **la factura llega en la primera cita**. Tres semanas siendo más ingenioso de lo que eres y luego hay que sentarse a la mesa siendo tú. La caída se nota aunque nadie sepa nombrarla. A nadie lo han dejado por un mensaje torpe: se deja por la distancia entre el mensaje y la persona." },
    ],
  },
  ar: {
    term: "الشات فيشينغ",
    summary:
      "أن تترك الذكاء الاصطناعي يكتب رسائلك في تطبيقات التعارف، فيقع الطرف الآخر في غرام كلام نموذج لغوي وهو يظن أنه يتعرّف عليك أنت.",
    blocks: [
      { type: "h2", text: "من أين جاءت الكلمة؟" },
      { type: "p", text: "كلمة حديثة بُنيت على انتحال الشخصية: الأولى تزيّف الوجه، وهذه تزيّف الصوت. ظهرت حين صارت روبوتات المحادثة قادرة على كتابة فقرة دافئة وطريفة خلال ثانيتين. ولا أحد تقريبًا يبدأ ناويًا الخداع. أنت أمام مربع رسالة فارغ في الواحدة بعد منتصف الليل، مرعوب من أن تبدو مملًا، وإلى جوارك أداة لا تكون مملة أبدًا." },
      { type: "p", text: "هناك تدرّج حقيقي هنا، وإنكاره لا يفيد أحدًا. تمرير رسالتك على نموذج لتصحيح الإملاء، أو لنزع الحدّة من جملة كتبتها وأنت غاضب، ليس كنسخ ما قاله الطرف الآخر وإرسال ما يخرج كما هو. سؤال بسيط يحسم معظم الأمر: **هل سيعرفك حين تلتقيان؟**" },
      { type: "h2", text: "كيف تعرف أنك تحادث نموذجًا" },
      { type: "ul", items: [
        "كل رد سلس ودافئ وعام بشكل غريب — جمل جميلة تصلح لأي شخص تقريبًا.",
        "يردّ على كل ما قلته ولا يسأل شيئًا حقيقيًا؛ أسئلة المتابعة تبقى مهذّبة وسطحية.",
        "النبرة لا تتحرك أبدًا. الطول نفسه واللمعان نفسه في التاسعة صباحًا وفي الثانية بعد منتصف الليل، بلا خطأ مطبعي وبلا رد من كلمة واحدة.",
        "التفاصيل تتبخّر. ما ذكرته قبل يومين يعود بصياغة أخرى، أو لا يعود أبدًا.",
      ] },
      { type: "h2", accent: "green", text: "كيف تتحقق بلا اتهام" },
      { type: "p", text: "إن شككت، لا تبدأ باتهام — قد تكون مخطئًا، والخطأ هنا مؤذٍ. **انقل الحديث إلى مكان يضعف فيه النموذج.** أرسل رسالة صوتية. أرسل صورة لما أمامك. اسأل سؤالًا لا معنى له إلا إذا تذكّر ما قلته يوم الثلاثاء. أو اقترح لقاءً أبكر. العثور على إنسان حقيقي أسهل بكثير وجهًا لوجه." },
      { type: "p", text: "وإن كنت أنت من يفعلها، **فالفاتورة تصل في أول لقاء**. ثلاثة أسابيع وأنت أظرف مما أنت عليه، ثم عليك أن تجلس إلى الطاولة كما أنت. الهبوط يُشعر به حتى لو لم يجد أحد له اسمًا. لم يُترك أحد بسبب رسالة مرتبكة؛ الناس يتركون بسبب المسافة بين الرسالة وصاحبها." },
    ],
  },
  ru: {
    term: "Чатфишинг",
    summary:
      "Позволять искусственному интеллекту писать за вас сообщения на сайте знакомств: собеседника очаровывают фразы языковой модели, а он думает, что узнаёт вас.",
    blocks: [
      { type: "h2", text: "Откуда взялось слово" },
      { type: "p", text: "Слово новое, построено по образцу кэтфишинга: там подделывают лицо, здесь — голос. Оно появилось, когда чат-боты научились за две секунды писать тёплый и остроумный абзац. Почти никто не садится за переписку с намерением обмануть. Просто час ночи, пустое поле для сообщения, страх показаться скучным — и рядом инструмент, который скучным не бывает никогда." },
      { type: "p", text: "Здесь есть настоящая градация, и делать вид, что её нет, бессмысленно. Прогнать сообщение через модель ради орфографии или чтобы убрать яд из строки, написанной в злости, — это не то же самое, что вставить чужой текст и отправить обратно всё, что получилось. Простой вопрос снимает большую часть сомнений: **узнает ли вас человек при встрече?**" },
      { type: "h2", text: "Как понять, что вам отвечает модель" },
      { type: "ul", items: [
        "Каждый ответ гладкий, тёплый и странно универсальный — красивые фразы, которые подошли бы почти кому угодно.",
        "Он откликается на всё, что вы сказали, и не спрашивает ничего настоящего; уточнения остаются вежливыми и поверхностными.",
        "Тон никогда не меняется. Одна и та же длина и отделка в девять утра и в два ночи, ни одной опечатки, ни одного односложного ответа.",
        "Конкретика испаряется. То, что вы рассказали два дня назад, возвращается пересказанным — или не возвращается вовсе.",
      ] },
      { type: "h2", accent: "green", text: "Как проверить, никого не обвиняя" },
      { type: "p", text: "Если подозреваете, не начинайте с обвинения: вы можете ошибаться, а ошибиться здесь особенно неприятно. **Лучше переведите разговор туда, где модель слаба.** Отправьте голосовое. Пришлите фотографию того, что перед вами. Задайте вопрос, который имеет смысл, только если человек помнит вторник. Или предложите встретиться раньше. Живого человека гораздо проще найти вживую." },
      { type: "p", text: "А если так делаете вы, **счёт придёт на первом свидании**. Три недели быть остроумнее себя настоящего — и потом сесть за стол собой. Провал чувствуется, даже когда его не могут назвать. Никого не бросали из-за неловкого сообщения; бросают из-за расстояния между сообщением и человеком." },
    ],
  },
  pt: {
    term: "Chatfishing",
    summary:
      "Deixar uma IA escrever suas mensagens de paquera, de modo que a pessoa do outro lado se encanta com as frases de um modelo de linguagem achando que está conhecendo você.",
    blocks: [
      { type: "h2", text: "De onde vem a palavra" },
      { type: "p", text: "É uma palavra nova, construída sobre o catfishing: aquele falsifica o rosto, este falsifica a voz. Apareceu quando os chatbots ficaram bons o bastante para escrever um parágrafo caloroso e engraçado em dois segundos. Quase ninguém começa querendo enganar alguém. Você está diante de uma caixa de mensagem vazia à uma da manhã, com pavor de parecer sem graça, e ao lado existe uma ferramenta que nunca é sem graça." },
      { type: "p", text: "Existe um degradê real aqui, e fingir o contrário não ajuda. Passar a mensagem por um modelo para corrigir a ortografia, ou para tirar o veneno de algo escrito com raiva, não é a mesma coisa que colar o que a pessoa disse e devolver o que sair. Uma pergunta simples resolve quase tudo: **ela reconheceria você ao vivo?**" },
      { type: "h2", text: "Como saber que você fala com um modelo" },
      { type: "ul", items: [
        "Toda resposta é fluente, calorosa e meio genérica — frases lindas que serviriam para quase qualquer pessoa.",
        "Responde a tudo o que você disse e não pergunta nada de verdade; as perguntas seguintes ficam educadas e na superfície.",
        "O tom nunca se move. O mesmo tamanho e o mesmo acabamento às nove da manhã e às duas da madrugada, sem um erro de digitação, sem uma resposta de uma palavra.",
        "O concreto evapora. Algo que você contou há dois dias volta parafraseado, ou não volta.",
      ] },
      { type: "h2", accent: "green", text: "Como verificar sem acusar ninguém" },
      { type: "p", text: "Se desconfiar, não comece acusando: você pode estar errado, e é um assunto péssimo para se errar. **Leve a conversa para onde um modelo vai mal.** Mande um áudio. Mande uma foto do que está na sua frente. Pergunte algo que só faz sentido se a pessoa lembrar do que você falou na terça. Ou proponha encontrar mais cedo. Gente de verdade é muito mais fácil de achar pessoalmente." },
      { type: "p", text: "E se quem faz isso é você, **a conta chega no primeiro encontro**. Três semanas sendo mais espirituoso do que você é, e depois é preciso sentar à mesa como você mesmo. A queda é sentida mesmo quando ninguém consegue nomear. Ninguém nunca foi deixado por uma mensagem desajeitada: deixam pela distância entre a mensagem e a pessoa." },
    ],
  },
  it: {
    term: "Chatfishing",
    summary:
      "Lasciare che un'IA scriva i tuoi messaggi di corteggiamento, così chi ti legge si innamora delle frasi di un modello linguistico credendo di conoscere te.",
    blocks: [
      { type: "h2", text: "Da dove arriva la parola" },
      { type: "p", text: "È una parola nuova, costruita sul catfishing: quello falsifica il volto, questo falsifica la voce. È arrivata quando i chatbot sono diventati capaci di scrivere un paragrafo caldo e spiritoso in due secondi. Quasi nessuno parte con l'intenzione di ingannare qualcuno. Sei davanti a una casella vuota all'una di notte, terrorizzato dall'idea di risultare noioso, e accanto hai uno strumento che noioso non è mai." },
      { type: "p", text: "Qui esiste una scala di grigi vera, e fingere il contrario non serve. Far correggere l'ortografia a un modello, o togliere il veleno da una frase scritta con rabbia, non è la stessa cosa che incollare quello che ti ha scritto e rispedire ciò che esce. Una domanda semplice risolve quasi tutto: **ti riconoscerebbe dal vivo?**" },
      { type: "h2", text: "Come capire che stai scrivendo a un modello" },
      { type: "ul", items: [
        "Ogni risposta è fluida, calda e stranamente generica — belle frasi che andrebbero bene per chiunque.",
        "Risponde a tutto quello che hai detto e non chiede niente di reale; le domande di rimbalzo restano educate e in superficie.",
        "Il tono non si muove mai. Stessa lunghezza e stessa lucidatura alle nove del mattino e alle due di notte, mai un refuso, mai una risposta di una parola.",
        "Il concreto evapora. Una cosa che hai raccontato due giorni fa torna parafrasata, oppure non torna.",
      ] },
      { type: "h2", accent: "green", text: "Come verificare senza accusare nessuno" },
      { type: "p", text: "Se hai il sospetto, non partire con un'accusa: potresti sbagliarti, ed è un pessimo argomento su cui sbagliarsi. **Sposta invece la conversazione dove un modello va male.** Manda un vocale. Manda la foto di quello che hai davanti. Fai una domanda che ha senso solo se ricorda cosa hai detto martedì. Oppure proponi di vedervi prima. Le persone vere si trovano molto più in fretta di persona." },
      { type: "p", text: "E se sei tu a farlo, **il conto arriva al primo appuntamento**. Tre settimane a essere più brillante di quanto sei, e poi devi sederti a tavola come te stesso. Il calo si sente anche quando nessuno sa dargli un nome. Nessuno è mai stato lasciato per un messaggio goffo: si viene lasciati per la distanza tra il messaggio e la persona." },
    ],
  },
  ja: {
    term: "チャットフィッシング",
    summary:
      "マッチングアプリのやり取りを生成AIに書かせること。相手はあなたを知っていくつもりで、実際には言語モデルの文章に惹かれていく。",
    blocks: [
      { type: "h2", text: "この言葉の出どころ" },
      { type: "p", text: "なりすまし（キャットフィッシング）から作られた新しい言葉です。あちらは顔を偽り、こちらは声を偽ります。チャットボットが二秒で温かくて気の利いた文章を書けるようになった頃に広まりました。最初から騙すつもりで始める人はほとんどいません。深夜一時、空っぽの入力欄を前に、つまらない人だと思われるのが怖い。そのすぐ横に、決してつまらなくならない道具がある。それだけのことです。" },
      { type: "p", text: "ここには本物のグラデーションがあり、無いふりをしても意味がありません。誤字を直してもらう、怒って書いた一文の棘を抜いてもらう。それは、相手の文章を貼り付けて出てきたものをそのまま送ることとは違います。ほとんどの迷いは単純な問いで片づきます。**会ったとき、その人はあなただと分かるでしょうか。**" },
      { type: "h2", text: "モデルと話しているサイン" },
      { type: "ul", items: [
        "どの返信もなめらかで温かく、そして妙に一般的。誰に送っても成立してしまう、きれいな文章。",
        "こちらの話にはすべて反応するのに、本気の質問が返ってこない。掘り下げが礼儀正しいまま浅い。",
        "調子がまったく変わらない。朝九時も深夜二時も同じ長さ、同じ仕上がり。誤字もなければ、ひと言だけの返信もない。",
        "具体が消える。二日前に話したことが言い換えられて戻ってくるか、そもそも戻ってこない。",
      ] },
      { type: "h2", accent: "green", text: "問い詰めずに確かめる方法" },
      { type: "p", text: "疑っても、まず問い詰めないでください。外れる可能性があり、この件で外すのはかなり気まずい。代わりに、**モデルが苦手な場所へ会話を動かします。** 音声メッセージを送る。目の前の景色を撮って送る。火曜に話した内容を覚えていなければ成り立たない質問をする。あるいは、会う日を前倒しにする。本物の人間は、会ってしまえばずっと簡単に見つかります。" },
      { type: "p", text: "やっている側なら、**請求書は初対面の日に届きます。** 三週間、自分より気の利いた人でいて、そのあと自分としてテーブルに座ることになる。落差は、言葉にできなくても伝わります。ぎこちないメッセージが理由で去られた人はいません。去られるのは、メッセージとその人のあいだの距離が理由です。" },
    ],
  },
  ko: {
    term: "챗피싱",
    summary:
      "데이팅 앱 대화를 AI에게 대신 쓰게 하는 일. 상대는 당신을 알아가는 줄 알지만 실제로는 언어 모델의 문장에 마음이 기운다.",
    blocks: [
      { type: "h2", text: "이 말이 나온 자리" },
      { type: "p", text: "캣피싱을 본떠 만든 새 단어입니다. 그쪽은 얼굴을 위조하고, 이쪽은 목소리를 위조합니다. 챗봇이 2초 만에 따뜻하고 재치 있는 문단을 써내게 되면서 생겼습니다. 처음부터 속이려고 시작하는 사람은 거의 없습니다. 새벽 한 시에 빈 입력창을 보고 있고, 재미없는 사람으로 보일까 봐 무섭고, 바로 옆에는 절대 재미없지 않은 도구가 있을 뿐입니다." },
      { type: "p", text: "여기엔 진짜 스펙트럼이 있고, 없는 척해도 소용없습니다. 맞춤법을 고치려고 모델을 거치는 것, 화가 나서 쓴 문장의 가시를 빼는 것은, 상대의 말을 붙여넣고 나온 결과를 그대로 보내는 것과 같지 않습니다. 대부분은 간단한 질문 하나로 정리됩니다. **만났을 때 그 사람이 당신을 알아볼까요?**" },
      { type: "h2", text: "모델과 대화하고 있다는 신호" },
      { type: "ul", items: [
        "모든 답이 매끄럽고 다정하고 묘하게 일반적입니다. 누구에게 보내도 어울릴 예쁜 문장들.",
        "당신이 한 말에는 다 반응하는데 진짜 질문은 돌아오지 않습니다. 되묻는 말이 예의 바른 채로 얕게 머뭅니다.",
        "톤이 전혀 움직이지 않습니다. 아침 아홉 시에도 새벽 두 시에도 같은 길이, 같은 광. 오타도 없고 한 단어짜리 답도 없습니다.",
        "구체적인 것이 증발합니다. 이틀 전에 한 이야기가 바꿔 쓴 채로 돌아오거나, 아예 돌아오지 않습니다.",
      ] },
      { type: "h2", accent: "green", text: "추궁하지 않고 확인하는 법" },
      { type: "p", text: "의심이 들어도 추궁으로 시작하지 마세요. 틀릴 수 있고, 이 문제에서 틀리면 꽤 아픕니다. 대신 **모델이 약한 쪽으로 대화를 옮기세요.** 음성 메시지를 보내세요. 지금 눈앞에 있는 것을 찍어 보내세요. 화요일에 한 말을 기억해야만 성립하는 질문을 던지세요. 아니면 만나는 날을 앞당기세요. 진짜 사람은 만나면 훨씬 쉽게 확인됩니다." },
      { type: "p", text: "하는 쪽이 당신이라면 **청구서는 첫 만남에 옵니다.** 3주 동안 실제보다 재치 있는 사람으로 지내고, 그다음엔 자기 자신으로 마주 앉아야 합니다. 그 낙차는 이름 붙이지 못해도 느껴집니다. 어설픈 메시지 때문에 떠난 사람은 없습니다. 사람들은 메시지와 사람 사이의 거리 때문에 떠납니다." },
    ],
  },
  zh: {
    term: "AI 代聊",
    summary:
      "把交友软件上的聊天交给人工智能来写，对面以为在认识你，其实被打动的是一个语言模型的句子；英文叫 chatfishing。",
    blocks: [
      { type: "h2", text: "这个词从哪来" },
      { type: "p", text: "这是个新词，照着网络身份造假的说法造出来的：那个伪造的是脸，这个伪造的是说话的声音。它出现在聊天机器人两秒钟就能写出一段又暖又好笑的话之后。几乎没有人一开始就打算骗谁。你在凌晨一点盯着空白的输入框，怕自己显得无趣，而旁边正好有一个永远不会无趣的工具。" },
      { type: "p", text: "这里确实有中间地带，装作没有并不诚实。让模型顺一顺错别字，或者把气头上写的那句话的刺拔掉，跟把对方的话复制进去、再把吐出来的原样发回，不是一回事。一个简单的问题能解决大半：**见了面，对方还认得出你吗？**" },
      { type: "h2", text: "怎么看出对面是模型" },
      { type: "ul", items: [
        "每一条都流畅、温柔，又莫名地通用——很漂亮，但发给谁都成立。",
        "你说的每件事它都接住了，却不真正问你什么；追问永远停在客气和表面。",
        "语气从不变化。早上九点和凌晨两点一样长、一样精致，没有错别字，也没有一个字的回复。",
        "具体的东西会蒸发。你两天前提过的事，要么换了说法回来，要么根本没回来。",
      ] },
      { type: "h2", accent: "green", text: "怎么在不质问的前提下确认" },
      { type: "p", text: "就算怀疑，也别用质问开场——你可能弄错，而在这件事上弄错很伤人。**把对话挪到模型不擅长的地方。** 发一条语音；拍一张你眼前的东西；问一个必须记得你周二说过什么才能回答的问题。或者干脆把见面提前。真人在面对面时好认得多。" },
      { type: "p", text: "如果做这件事的是你，**账单会在第一次见面时到。** 三个星期扮演一个比自己更风趣的人，然后要以本人的样子坐到桌前。那个落差，即使说不上来也感觉得到。没有人是因为一条笨拙的消息被放弃的；被放弃的原因，是消息和本人之间的那段距离。" },
    ],
  },
  nl: {
    term: "Chatfishing",
    summary:
      "Je datingberichten door een AI laten schrijven, zodat de ander valt voor de zinnen van een taalmodel terwijl die denkt jou te leren kennen.",
    blocks: [
      { type: "h2", text: "Waar het woord vandaan komt" },
      { type: "p", text: "Het is een nieuw woord, gebouwd op catfishing: dat vervalst het gezicht, dit vervalst de stem. Het dook op toen chatbots goed genoeg werden om in twee seconden een warme, grappige alinea te schrijven. Bijna niemand begint met het plan iemand te bedriegen. Je staart om één uur 's nachts naar een leeg berichtvenster, doodsbang om saai te zijn, en er ligt een gereedschap naast dat nooit saai is." },
      { type: "p", text: "Er zit hier een echt grijs gebied in, en doen alsof dat er niet is helpt niemand. Een bericht door een model halen om je spelling te herstellen, of om het gif uit een boos geschreven zin te halen, is niet hetzelfde als plakken wat de ander schreef en terugsturen wat eruit komt. Eén simpele vraag beslist het meeste: **zou die persoon je herkennen als jullie afspreken?**" },
      { type: "h2", text: "Hoe je merkt dat je met een model praat" },
      { type: "ul", items: [
        "Elk antwoord is vloeiend, warm en een beetje algemeen — mooie zinnen die op bijna iedereen zouden passen.",
        "Het reageert op alles wat je zei en vraagt niets echts terug; het doorvragen blijft beleefd en oppervlakkig.",
        "De toon beweegt nooit. Dezelfde lengte en dezelfde glans om negen uur 's ochtends en om twee uur 's nachts, nooit een typefout, nooit een antwoord van één woord.",
        "Het concrete verdampt. Iets wat je twee dagen geleden vertelde komt geparafraseerd terug, of komt helemaal niet terug.",
      ] },
      { type: "h2", accent: "green", text: "Hoe je het checkt zonder iemand te beschuldigen" },
      { type: "p", text: "Begin bij twijfel niet met een beschuldiging — je kunt het mis hebben, en dat is een naar ding om mis te hebben. **Verplaats het gesprek liever naar waar een model slecht in is.** Stuur een spraakbericht. Stuur een foto van wat er voor je ligt. Stel een vraag die alleen klopt als iemand zich dinsdag herinnert. Of stel voor om eerder af te spreken. Echte mensen vind je in levenden lijve veel sneller." },
      { type: "p", text: "En als jij degene bent: **de rekening komt op de eerste date.** Drie weken geestiger zijn dan je bent, en dan als jezelf aan tafel zitten. De val wordt gevoeld, ook als niemand er een naam voor heeft. Niemand is ooit verlaten om een onhandig bericht — mensen vertrekken om de afstand tussen het bericht en de persoon." },
    ],
  },
  pl: {
    term: "Chatfishing",
    summary:
      "Oddanie swoich randkowych wiadomości sztucznej inteligencji, przez co druga osoba zakochuje się w zdaniach modelu językowego, wierząc, że poznaje ciebie.",
    blocks: [
      { type: "h2", text: "Skąd wzięło się to słowo" },
      { type: "p", text: "To nowe słowo, zbudowane na catfishingu: tam podrabia się twarz, tutaj głos. Pojawiło się, gdy chatboty nauczyły się pisać ciepły i dowcipny akapit w dwie sekundy. Prawie nikt nie zaczyna z zamiarem oszukania kogokolwiek. Po prostu jest pierwsza w nocy, okno wiadomości jest puste, boisz się, że wyjdziesz nudno, a obok leży narzędzie, które nudne nie bywa." },
      { type: "p", text: "Istnieje tu prawdziwa skala szarości i udawanie, że jej nie ma, nikomu nie pomaga. Przepuścić wiadomość przez model, żeby poprawić literówki albo zdjąć jad ze zdania napisanego w złości, to nie to samo co wkleić czyjś tekst i odesłać to, co wyjdzie. Proste pytanie rozstrzyga większość: **czy ta osoba pozna cię na żywo?**" },
      { type: "h2", text: "Po czym poznasz, że piszesz z modelem" },
      { type: "ul", items: [
        "Każda odpowiedź jest płynna, ciepła i dziwnie uniwersalna — ładne zdania, które pasowałyby do prawie każdego.",
        "Odnosi się do wszystkiego, co powiedziałeś, i o nic naprawdę nie pyta; dopytywanie zostaje grzeczne i płytkie.",
        "Ton nigdy nie drgnie. O dziewiątej rano i o drugiej w nocy ta sama długość i ten sam połysk, ani jednej literówki, ani jednej jednowyrazowej odpowiedzi.",
        "Konkret wyparowuje. To, o czym mówiłeś dwa dni temu, wraca sparafrazowane albo nie wraca wcale.",
      ] },
      { type: "h2", accent: "green", text: "Jak sprawdzić, nikogo nie oskarżając" },
      { type: "p", text: "Jeśli podejrzewasz, nie zaczynaj od oskarżenia — możesz się mylić, a to bardzo niewdzięczna rzecz, w której można się mylić. **Przenieś rozmowę tam, gdzie model wypada słabo.** Wyślij wiadomość głosową. Wyślij zdjęcie tego, co masz przed sobą. Zadaj pytanie, które ma sens tylko wtedy, gdy ktoś pamięta wtorek. Albo zaproponuj wcześniejsze spotkanie. Prawdziwego człowieka o wiele łatwiej znaleźć na żywo." },
      { type: "p", text: "A jeśli to ty tak robisz, **rachunek przychodzi na pierwszej randce.** Trzy tygodnie bycia dowcipniejszym, niż się jest, a potem trzeba usiąść przy stole jako się samo. Ten spadek czuć, nawet gdy nikt nie umie go nazwać. Nikogo nie zostawiono przez niezgrabną wiadomość — zostawia się przez dystans między wiadomością a człowiekiem." },
    ],
  },
  sv: {
    term: "Chatfishing",
    summary:
      "Att låta en AI skriva dina dejtmeddelanden, så att den andra charmas av en språkmodells meningar samtidigt som hen tror sig lära känna dig.",
    blocks: [
      { type: "h2", text: "Varifrån ordet kommer" },
      { type: "p", text: "Det är ett nytt ord, byggt på catfishing: där förfalskas ansiktet, här rösten. Det dök upp när chattbotar blev tillräckligt bra för att skriva ett varmt och roligt stycke på två sekunder. Nästan ingen börjar med planen att lura någon. Man sitter framför en tom meddelanderuta klockan ett på natten, livrädd för att vara tråkig, och bredvid ligger ett verktyg som aldrig är det." },
      { type: "p", text: "Här finns en verklig gråskala, och att låtsas annat hjälper ingen. Att köra ett meddelande genom en modell för att fixa stavningen, eller för att ta udden av något du skrev arg, är inte samma sak som att klistra in vad den andra skrev och skicka tillbaka det som kommer ut. En enkel fråga avgör det mesta: **skulle personen känna igen dig när ni ses?**" },
      { type: "h2", text: "Så märker du att du pratar med en modell" },
      { type: "ul", items: [
        "Varje svar är flytande, varmt och lite väl allmänt — vackra meningar som skulle passa nästan vem som helst.",
        "Det bemöter allt du sagt och frågar inget på riktigt tillbaka; följdfrågorna stannar artiga och ytliga.",
        "Tonen rör sig aldrig. Samma längd och samma polering klockan nio på morgonen och klockan två på natten, aldrig ett stavfel, aldrig ett enordssvar.",
        "Det konkreta dunstar bort. Något du nämnde för två dagar sedan kommer tillbaka omskrivet, eller inte alls.",
      ] },
      { type: "h2", accent: "green", text: "Så kollar du utan att anklaga någon" },
      { type: "p", text: "Misstänker du det, börja inte med en anklagelse — du kan ha fel, och det är en obehaglig sak att ha fel om. **Flytta i stället samtalet dit en modell är dålig.** Skicka ett röstmeddelande. Skicka en bild på det du har framför dig. Ställ en fråga som bara går ihop om någon minns tisdagen. Eller föreslå att ni ses tidigare. Riktiga människor är mycket lättare att hitta öga mot öga." },
      { type: "p", text: "Och är det du som gör det kommer **notan på första dejten.** Tre veckor av att vara roligare än du är, och sedan ska du sitta vid bordet som dig själv. Fallet känns även när ingen kan sätta ord på det. Ingen har någonsin blivit lämnad för ett fumligt meddelande — man lämnas för avståndet mellan meddelandet och personen." },
    ],
  },
  hi: {
    term: "चैटफ़िशिंग",
    summary:
      "डेटिंग ऐप की बातचीत किसी एआई से लिखवाना, जिससे सामने वाला यह समझते हुए कि वह आपको जान रहा है, दरअसल एक भाषा मॉडल के वाक्यों पर रीझता रहे।",
    blocks: [
      { type: "h2", text: "यह शब्द कहाँ से आया" },
      { type: "p", text: "यह नया शब्द कैटफ़िशिंग की तर्ज़ पर बना है: वह चेहरा नकली करता है, यह आवाज़। यह तब आया जब चैटबॉट दो सेकंड में गर्मजोशी भरा और मज़ेदार पैराग्राफ़ लिखने लगे। लगभग कोई भी धोखा देने की योजना से शुरू नहीं करता। रात के एक बजे खाली मैसेज बॉक्स सामने है, बोरिंग लगने का डर है, और ठीक बगल में एक औज़ार है जो कभी बोरिंग नहीं होता।" },
      { type: "p", text: "यहाँ सचमुच एक बीच की जगह है, और उसे नकारने से कुछ नहीं मिलता। वर्तनी सुधरवाने के लिए या गुस्से में लिखी लाइन की धार कम करने के लिए मॉडल से मदद लेना, और सामने वाले का मैसेज चिपकाकर जो निकले उसे वैसे ही भेज देना — ये एक बात नहीं। ज़्यादातर उलझन एक आसान सवाल से सुलझ जाती है: **मिलने पर वह आपको पहचान पाएगा?**" },
      { type: "h2", text: "कैसे पता चले कि सामने मॉडल है" },
      { type: "ul", items: [
        "हर जवाब सधा हुआ, गर्मजोशी भरा और अजीब तरह से आम — सुंदर वाक्य, जो लगभग किसी पर भी फिट बैठ जाएँ।",
        "आपकी कही हर बात का जवाब आता है, पर असली सवाल कभी नहीं लौटता; आगे की पूछताछ शिष्ट और ऊपरी बनी रहती है।",
        "लहजा कभी नहीं हिलता। सुबह नौ बजे और रात दो बजे वही लंबाई, वही चमक; न कोई टाइपो, न एक शब्द का जवाब।",
        "ठोस बातें उड़ जाती हैं। दो दिन पहले बताई कोई बात या तो बदले शब्दों में लौटती है, या लौटती ही नहीं।",
      ] },
      { type: "h2", accent: "green", text: "बिना इल्ज़ाम लगाए कैसे जाँचें" },
      { type: "p", text: "शक हो तो इल्ज़ाम से शुरुआत मत कीजिए — आप ग़लत भी हो सकते हैं, और इस मामले में ग़लत होना बुरा लगता है। **बातचीत को वहाँ ले जाइए जहाँ मॉडल कमज़ोर है।** वॉइस नोट भेजिए। अपने सामने की चीज़ की तस्वीर भेजिए। ऐसा सवाल पूछिए जिसका मतलब तभी बनता है जब मंगलवार की बात याद हो। या मिलने की तारीख़ पास ले आइए। असली इंसान आमने-सामने कहीं जल्दी पहचाना जाता है।" },
      { type: "p", text: "और अगर यह आप कर रहे हैं, तो **बिल पहली मुलाक़ात पर आता है।** तीन हफ़्ते अपने से ज़्यादा हाज़िरजवाब बने रहना, और फिर मेज़ पर अपने असली रूप में बैठना। वह गिरावट महसूस होती है, भले नाम न दिया जा सके। किसी को बेढंगे मैसेज की वजह से नहीं छोड़ा गया; लोग मैसेज और इंसान के बीच की दूरी की वजह से छोड़ते हैं।" },
    ],
  },
};
