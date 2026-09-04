import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * The ick — attraction switching off abruptly over something small.
 *
 * Editorial notes for whoever touches this next:
 * - The brief was to stay even-handed: the ick is sometimes a real
 *   incompatibility surfacing in miniature and sometimes avoidance wearing the
 *   costume of taste, and the page must not tell the reader which theirs is. So
 *   block 2 names both readings, and block 4 is a set of tests the reader
 *   applies themselves (timing, does it generalise, can you name the specific
 *   thing, would it bother you unobserved). Do not resolve this into a verdict
 *   in either direction — "trust your gut" and "it's just avoidance" are both
 *   wrong here.
 * - No clinical framing. Avoidance is described as a behaviour pattern, not
 *   diagnosed as an attachment style, and no therapy vocabulary is used.
 * - Block 7 speaks to the person who was on the receiving end, because roughly
 *   half the people searching this phrase at 1am were just left. It is not a
 *   Qulo pitch: the app has no honest connection to this term, and claiming a
 *   question quiz prevents a sudden loss of attraction would be false. Only
 *   green-flag carries the product angle in this batch of four.
 * - No statistics. The 78% burnout figure (Forbes Health / OnePoll, 2024) is
 *   about dating-app fatigue and has no bearing on this.
 * - Term names, the widest spread of the four files: en/tr/pl/sv keep the
 *   loanword, de/fr/es/pt/it/nl take it with an article, and five languages have
 *   their own established phrase — ar النفور المفاجئ, ru внезапное отвращение,
 *   ko 정 떨어지는 순간, zh 下头 (current slang, exactly this meaning). ja uses
 *   蛙化現象, whose own meaning has drifted — it used to mean going cold once
 *   someone likes you back, and now mostly means the ick; the ja body states
 *   that drift rather than hiding it. The English term is named inside the body
 *   in every locale that does not use it as the headword.
 */
export const ick: LocalizedGlossaryEntry = {
  en: {
    term: "The ick",
    summary:
      "A sudden, often disproportionate loss of attraction set off by something small — a gesture, a phrase, the way someone runs for a bus — which can be a real incompatibility surfacing or avoidance in disguise.",
    blocks: [
      { type: "h2", text: "Where it comes from and why it is so abrupt" },
      { type: "p", text: "The word was in British slang for years before reality television made it a household phrase in the late 2010s. What it names is much older than the word. Attraction runs partly on a story you are telling yourself about someone, and the ick is that story breaking. Some small thing makes them suddenly visible as an ordinary, slightly awkward human being, and the feeling switches off long before any reasoning catches up." },
      { type: "p", text: "That is why the triggers sound absurd when you list them out loud, and why so many of them are things nobody can help. It is also why they arrive at a suspiciously convenient moment — usually just as it starts to get real. But sometimes the small thing is an honest sample of a larger one: what he laughed at, how she spoke to the driver. Both happen. The feeling itself cannot tell you which." },
      { type: "h2", text: "Which kind is yours?" },
      { type: "ul", items: [
        "**Timing:** did it arrive after they did something, or right after things got closer?",
        "**Does it generalise:** is it this person, or does everyone get an ick at about week five?",
        "**Can you name the specific thing:** \"how he spoke to the waiter\" points at conduct; \"how he ran for the bus\" points at nothing",
        "**Would it bother you if nobody could see:** if the discomfort is about being seen with them, it is about you",
      ] },
      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "You never need a good reason to stop seeing someone, and you do not owe an explanation built out of the trigger — \"I don't feel a romantic connection\" is kinder and just as true. If you want to know which kind yours is, keep the decision open for two more weeks of ordinary contact. A real mismatch gets louder the more you learn about them. Avoidance gets quieter once nothing frightening happens." },
      { type: "p", text: "If you were on the receiving end, there is usually nothing to repair. The trigger rarely said you had done something wrong; it said something about the moment it landed in. And be wary of trying to become ick-proof by staying smooth and unremarkable: almost everything that makes a person lovable up close looks slightly embarrassing from a distance." },
    ],
  },

  tr: {
    term: "Ick",
    summary:
      "Küçük bir ayrıntının çekimi bir anda kesmesi: bir el hareketi, bir laf, otobüse koşuş şekli. Bazen gerçek bir uyumsuzluğun küçük hâli, bazen kaçışın kılık değiştirmişi.",
    blocks: [
      { type: "h2", text: "Nereden geliyor, neden bu kadar ani?" },
      { type: "p", text: "Kelime İngiliz argosunda yıllardır vardı; 2010'ların sonunda bir yarışma programıyla herkesin diline yerleşti. Türkçede genellikle \"ani soğuma\" diye anlatılır. Adlandırdığı şeyse kelimeden çok daha eski. Çekim, bir ölçüde karşındaki hakkında kendine anlattığın hikâyeye dayanır; ick de o hikâyenin bir anda kırılmasıdır. Küçük bir ayrıntı onu sıradan, biraz beceriksiz bir insan olarak görünür kılar ve his, akıl yetişemeden kapanır." },
      { type: "p", text: "Tetikleyicileri yüksek sesle sıraladığında saçma gelmesinin sebebi bu; çoğunun kimsenin elinde olmayan şeyler olması da öyle. Ayrıca şüpheli derecede uygun bir anda gelirler: genellikle işler ciddileşmeye başladığında. Ama bazen o küçük şey daha büyük bir şeyin dürüst bir örneğidir; neye güldüğü, şoförle nasıl konuştuğu. İkisi de oluyor. Hissin kendisi hangisi olduğunu söylemiyor." },
      { type: "h2", text: "Seninki hangisi?" },
      { type: "ul", items: [
        "**Zamanlama:** o bir şey yaptıktan sonra mı geldi, yoksa aranız yakınlaştıktan hemen sonra mı?",
        "**Hep oluyor mu:** bu kişiye mi özgü, yoksa beşinci hafta civarında herkeste mi oluyor?",
        "**Somut şeyi söyleyebiliyor musun:** \"garsonla konuşma şekli\" davranışa işaret eder; \"otobüse koşma şekli\" hiçbir şeye",
        "**Kimse görmese yine rahatsız olur muydun:** rahatsızlık onunla birlikte görülmekle ilgiliyse, mesele sende",
      ] },
      { type: "h2", accent: "green", text: "Ne yapmalı?" },
      { type: "p", text: "Birini görmeyi bırakmak için iyi bir sebebe ihtiyacın yok ve açıklamayı tetikleyicinin üstüne kurmak zorunda değilsin — \"romantik bir bağ hissetmiyorum\" hem daha nazik hem aynı ölçüde doğru. Hangisi olduğunu öğrenmek istiyorsan kararı iki hafta daha açık tut ve sıradan teması sürdür. Gerçek bir uyumsuzluk, onu tanıdıkça yükselir. Kaçış ise korkulacak bir şey olmadığı görülünce sesini keser." },
      { type: "p", text: "Karşı taraf sensen, onaracak bir şey genellikle yoktur. Tetikleyici çoğu zaman senin yanlışını değil, denk geldiği anı anlatıyordu. Bir de kendini pürüzsüz ve dikkat çekmeyen biri yaparak buna karşı bağışıklık kazanmaya çalışma: bir insanı yakından sevilesi kılan şeylerin neredeyse hepsi, uzaktan bakınca biraz utandırıcı görünür." },
    ],
  },

  de: {
    term: "Der Ick",
    summary:
      "Der plötzliche, oft unverhältnismäßige Verlust von Anziehung durch eine Kleinigkeit: eine Geste, ein Satz, die Art, wie jemand zum Bus rennt. Mal steckt eine echte Unvereinbarkeit dahinter, mal schlicht Vermeidung.",
    blocks: [
      { type: "h2", text: "Woher er kommt und warum er so abrupt ist" },
      { type: "p", text: "Das Wort gab es im britischen Slang lange, bevor eine Reality-Show es Ende der 2010er in aller Munde brachte. Was es benennt, ist viel älter als der Begriff. Anziehung beruht zum Teil auf einer Geschichte, die du dir über jemanden erzählst, und der Ick ist der Moment, in dem diese Geschichte reißt. Eine Kleinigkeit lässt die Person plötzlich als ganz gewöhnlichen, leicht unbeholfenen Menschen erscheinen, und das Gefühl schaltet ab, lange bevor der Verstand hinterherkommt." },
      { type: "p", text: "Deshalb klingen die Auslöser absurd, wenn man sie laut aufzählt, und deshalb sind so viele Dinge dabei, für die niemand etwas kann. Deshalb kommen sie auch zu verdächtig passenden Zeitpunkten: meist genau dann, wenn es ernst wird. Manchmal ist die Kleinigkeit aber eine ehrliche Kostprobe von etwas Größerem — worüber er gelacht hat, wie sie mit dem Fahrer geredet hat. Beides gibt es. Das Gefühl selbst sagt dir nicht, was davon." },
      { type: "h2", text: "Welche Sorte ist deiner?" },
      { type: "ul", items: [
        "**Der Zeitpunkt:** kam er, nachdem die Person etwas getan hat, oder direkt danach, als es näher wurde?",
        "**Passiert es immer:** liegt es an dieser Person, oder kommt der Ick grundsätzlich in Woche fünf?",
        "**Kannst du die konkrete Sache benennen:** \"wie er mit dem Kellner geredet hat\" zeigt auf Verhalten; \"wie er zum Bus gerannt ist\" auf nichts",
        "**Würde es dich stören, wenn niemand zusieht:** wenn das Unbehagen daher rührt, mit dieser Person gesehen zu werden, geht es um dich",
      ] },
      { type: "h2", accent: "green", text: "Was du damit machst" },
      { type: "p", text: "Du brauchst keinen guten Grund, um jemanden nicht mehr zu treffen, und du schuldest keine Erklärung, die auf dem Auslöser aufbaut — \"Ich spüre keine romantische Verbindung\" ist freundlicher und genauso wahr. Wenn du wissen willst, welche Sorte es ist, halte die Entscheidung zwei weitere Wochen offen und bleib im gewöhnlichen Kontakt. Eine echte Unvereinbarkeit wird lauter, je mehr du erfährst. Vermeidung wird leiser, sobald nichts Bedrohliches passiert." },
      { type: "p", text: "Wenn es dich getroffen hat: Meist gibt es nichts zu reparieren. Der Auslöser hatte selten damit zu tun, dass du etwas falsch gemacht hättest, sondern mit dem Moment, in dem er landete. Und versuch nicht, dich ick-sicher zu machen, indem du glatt und unauffällig bleibst: Fast alles, was einen Menschen aus der Nähe liebenswert macht, wirkt aus der Ferne ein bisschen peinlich." },
    ],
  },

  fr: {
    term: "Le ick",
    summary:
      "La perte soudaine, souvent disproportionnée, du désir, déclenchée par un détail : un geste, une phrase, la façon de courir après le bus. Parfois une vraie incompatibilité qui remonte, parfois de l'évitement déguisé.",
    blocks: [
      { type: "h2", text: "D'où ça vient et pourquoi c'est si brutal" },
      { type: "p", text: "Le mot circulait dans l'argot britannique bien avant qu'une émission de téléréalité ne le rende courant, à la fin des années 2010. Ce qu'il nomme est bien plus ancien que lui. Le désir repose en partie sur l'histoire qu'on se raconte à propos de quelqu'un, et le ick, c'est cette histoire qui casse. Un détail rend la personne soudain visible comme un humain ordinaire et un peu maladroit, et le sentiment s'éteint bien avant que le raisonnement n'arrive." },
      { type: "p", text: "D'où l'absurdité des déclencheurs quand on les énumère à voix haute, et le fait que beaucoup portent sur des choses dont personne n'est responsable. D'où aussi leur arrivée à un moment suspect : souvent pile quand ça devient sérieux. Mais parfois le petit détail est un échantillon honnête d'autre chose — ce qui l'a fait rire, sa façon de parler au chauffeur. Les deux existent. La sensation, elle, ne te dit pas laquelle." },
      { type: "h2", text: "Le tien, c'est lequel ?" },
      { type: "ul", items: [
        "**Le moment :** est-il venu après un geste précis, ou juste après que la relation s'est rapprochée ?",
        "**Est-ce que ça se répète :** c'est cette personne, ou tout le monde y a droit vers la cinquième semaine ?",
        "**Peux-tu nommer la chose exacte :** \"sa façon de parler au serveur\" désigne une conduite ; \"sa façon de courir après le bus\" ne désigne rien",
        "**Est-ce que ça te dérangerait si personne ne voyait :** si la gêne vient d'être vu avec cette personne, elle parle de toi",
      ] },
      { type: "h2", accent: "green", text: "Quoi en faire" },
      { type: "p", text: "Tu n'as jamais besoin d'une bonne raison pour arrêter de voir quelqu'un, et tu ne dois pas une explication fabriquée à partir du déclencheur : \"je ne ressens pas de connexion amoureuse\" est plus gentil et tout aussi vrai. Si tu veux savoir de quel type il s'agit, laisse la décision ouverte encore deux semaines de contact ordinaire. Une vraie incompatibilité monte à mesure que tu en apprends. L'évitement se calme dès que rien d'effrayant n'arrive." },
      { type: "p", text: "Si tu es de l'autre côté, il n'y a en général rien à réparer. Le déclencheur ne disait presque jamais que tu avais mal fait ; il disait quelque chose du moment où il est tombé. Et ne cherche pas à devenir imperméable au ick en restant lisse et discret : presque tout ce qui rend quelqu'un aimable de près paraît un peu embarrassant de loin." },
    ],
  },

  es: {
    term: "El ick",
    summary:
      "La pérdida repentina, muchas veces desproporcionada, de la atracción por culpa de un detalle: un gesto, una frase, cómo alguien corre para coger el autobús. A veces asoma una incompatibilidad real; a veces es huida disfrazada.",
    blocks: [
      { type: "h2", text: "De dónde sale y por qué es tan brusco" },
      { type: "p", text: "La palabra llevaba años en la jerga británica antes de que un programa de telerrealidad la pusiera en boca de todos a finales de los 2010. Lo que nombra es mucho más antiguo que el término. La atracción se apoya en parte en la historia que te cuentas sobre alguien, y el ick es esa historia rompiéndose. Un detalle hace que la persona aparezca de golpe como un humano corriente y un poco torpe, y la sensación se apaga mucho antes de que llegue el razonamiento." },
      { type: "p", text: "Por eso los disparadores suenan absurdos al enumerarlos en voz alta, y por eso tantos son cosas que nadie puede evitar. Y por eso llegan en un momento sospechosamente oportuno: casi siempre cuando la cosa empieza a ir en serio. Pero a veces ese detalle es una muestra honesta de algo mayor: de qué se rió, cómo le habló al conductor. Las dos cosas pasan. La sensación no te dice cuál es la tuya." },
      { type: "h2", text: "¿El tuyo de qué tipo es?" },
      { type: "ul", items: [
        "**El momento:** ¿llegó después de que hiciera algo, o justo después de que la cosa se acercara?",
        "**¿Se repite?:** ¿es esta persona, o a todas les llega el ick por la quinta semana?",
        "**¿Puedes nombrar la cosa concreta?:** \"cómo le habló al camarero\" señala conducta; \"cómo corrió para el autobús\" no señala nada",
        "**¿Te molestaría si no lo viera nadie?:** si la incomodidad viene de que te vean con esa persona, habla de ti",
      ] },
      { type: "h2", accent: "green", text: "Qué hacer con él" },
      { type: "p", text: "Nunca necesitas una buena razón para dejar de ver a alguien, y no le debes una explicación construida sobre el disparador: \"no siento una conexión romántica\" es más amable e igual de cierto. Si quieres saber de qué tipo es el tuyo, deja la decisión abierta dos semanas más de trato normal. Una incompatibilidad real sube de volumen según vas conociendo a la persona. La huida se calla en cuanto no pasa nada temible." },
      { type: "p", text: "Si te lo han hecho a ti, casi nunca hay nada que reparar. El disparador rara vez decía que hicieras algo mal; decía algo del momento en que cayó. Y desconfía de volverte a prueba de icks quedándote liso y discreto: casi todo lo que hace querible a una persona de cerca resulta un poco vergonzoso de lejos." },
    ],
  },

  ar: {
    term: "النفور المفاجئ",
    summary:
      "انطفاء الانجذاب فجأة بسبب تفصيل صغير: حركة يد، أو جملة، أو طريقة الركض خلف الحافلة. أحيانًا يكون عدم توافق حقيقي يطفو على السطح، وأحيانًا هروبًا متنكرًا.",
    blocks: [
      { type: "h2", text: "من أين يأتي ولماذا هو مباغت هكذا" },
      { type: "p", text: "بالإنجليزية يسمّى the ick، وكان دارجًا في العامية البريطانية قبل أن يشيع في أواخر العقد الثاني من الألفية عبر برامج تلفزيون الواقع. لكن ما يصفه أقدم بكثير من الكلمة. الانجذاب يقوم جزئيًا على حكاية ترويها لنفسك عن الشخص، والنفور المفاجئ هو انكسار تلك الحكاية. تفصيل صغير يجعله يظهر فجأة إنسانًا عاديًا أخرق قليلًا، فينطفئ الشعور قبل أن يلحق به العقل بكثير." },
      { type: "p", text: "لذلك تبدو المحفّزات سخيفة حين تعدّدها بصوت مسموع، ولذلك كثير منها أشياء لا يد لأحد فيها. ولذلك أيضًا تأتي في توقيت مريب: غالبًا حين تبدأ العلاقة تصير جدّية. لكن أحيانًا يكون التفصيل الصغير عيّنة صادقة من شيء أكبر: مما ضحك عليه، وكيف كلّمت السائق. الحالتان تحدثان، والشعور وحده لا يقول لك أيّهما حالتك." },
      { type: "h2", text: "أي نوع هو نفورك؟" },
      { type: "ul", items: [
        "**التوقيت:** هل جاء بعد تصرّف بعينه، أم بعد أن اقتربت العلاقة مباشرة؟",
        "**هل يتكرر مع الجميع:** أهو هذا الشخص، أم أن الأمر يحدث مع كل شخص في الأسبوع الخامس تقريبًا؟",
        "**هل تستطيع تسمية الشيء المحدد:** \"كيف كلّم النادل\" يشير إلى سلوك، و\"كيف ركض خلف الحافلة\" لا يشير إلى شيء",
        "**هل كان سيزعجك لو لم يرَ أحد:** إن كان الانزعاج من أن يراك الناس معه، فالمسألة عنك أنت",
      ] },
      { type: "h2", accent: "green", text: "ماذا تفعل به" },
      { type: "p", text: "لا تحتاج سببًا وجيهًا لتتوقف عن مواعدة أحد، ولا تدين له بتفسير مبني على المحفّز؛ جملة \"لا أشعر بارتباط عاطفي\" ألطف وصادقة بالقدر نفسه. وإن أردت أن تعرف أي نوع هو، اترك القرار مفتوحًا أسبوعين آخرين من التواصل العادي. عدم التوافق الحقيقي يعلو صوته كلما عرفت أكثر، أما الهروب فيهدأ حين يتبيّن أن لا شيء مخيفًا يحدث." },
      { type: "p", text: "وإن كنت أنت من حدث له ذلك، فغالبًا لا شيء يحتاج إصلاحًا. المحفّز نادرًا ما كان يقول إنك أخطأت، بل يقول شيئًا عن اللحظة التي وقع فيها. واحذر أن تحاول تحصين نفسك بأن تبقى ناعمًا بلا ملامح: كل ما يجعل الإنسان محبوبًا عن قرب يبدو من بعيد محرجًا قليلًا." },
    ],
  },

  ru: {
    term: "Внезапное отвращение",
    summary:
      "Резкая, часто несоразмерная потеря влечения из-за мелочи: жеста, фразы, того, как человек бежит за автобусом. Иногда это всплывшая настоящая несовместимость, иногда — избегание под другим именем.",
    blocks: [
      { type: "h2", text: "Откуда это берётся и почему так резко" },
      { type: "p", text: "По-английски это называют the ick; слово жило в британском сленге задолго до того, как реалити-шоу в конце 2010-х сделали его общеупотребительным. То, что оно называет, гораздо старше самого слова. Влечение отчасти держится на истории, которую вы себе рассказываете о человеке, и внезапное отвращение — это момент, когда история рвётся. Мелочь вдруг делает его обычным, слегка нелепым человеком, и чувство выключается задолго до того, как подоспеют доводы." },
      { type: "p", text: "Поэтому список триггеров звучит нелепо, если произнести его вслух, и поэтому многие из них — то, в чём никто не виноват. Поэтому же они приходят подозрительно вовремя: часто ровно тогда, когда всё становится серьёзным. Но иногда мелочь — честный образец чего-то большего: над чем он смеялся, как она говорила с водителем. Бывает и так, и так. Само чувство не подскажет, какой случай ваш." },
      { type: "h2", text: "Какой случай у вас?" },
      { type: "ul", items: [
        "**Момент:** это пришло после конкретного поступка или сразу после того, как вы стали ближе?",
        "**Повторяется ли:** дело в этом человеке или примерно на пятой неделе так бывает с каждым?",
        "**Можете ли вы назвать конкретную вещь:** \"как он говорил с официантом\" указывает на поведение, \"как он бежал за автобусом\" — ни на что",
        "**Мешало бы это, если бы никто не видел:** если неловко от того, что вас видят вместе, речь о вас",
      ] },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Чтобы перестать встречаться с человеком, хорошая причина не нужна, и объяснение, построенное на триггере, вы никому не должны: \"я не чувствую романтической связи\" добрее и не менее правдиво. Если хотите понять, какой это случай, оставьте решение открытым ещё на пару недель обычного общения. Настоящая несовместимость становится громче по мере узнавания. Избегание стихает, когда выясняется, что ничего страшного не происходит." },
      { type: "p", text: "Если так поступили с вами, чинить обычно нечего. Триггер редко говорил о том, что вы сделали что-то не так, — он говорил о моменте, в который попал. И не пытайтесь стать неуязвимым, оставаясь гладким и незаметным: почти всё, за что человека любят вблизи, издалека выглядит слегка неловко." },
    ],
  },

  pt: {
    term: "O ick",
    summary:
      "A perda repentina, muitas vezes desproporcional, da atração por causa de um detalhe: um gesto, uma frase, o jeito de correr atrás do ônibus. Às vezes é uma incompatibilidade real vindo à tona; às vezes é fuga disfarçada.",
    blocks: [
      { type: "h2", text: "De onde vem e por que é tão abrupto" },
      { type: "p", text: "A palavra já circulava na gíria britânica antes de um reality show torná-la popular no fim dos anos 2010. O que ela nomeia é bem mais velho que o termo. A atração se apoia em parte na história que você conta para si mesmo sobre alguém, e o ick é essa história se quebrando. Um detalhe faz a pessoa aparecer de repente como um humano comum e meio desajeitado, e o sentimento desliga muito antes de qualquer raciocínio alcançar." },
      { type: "p", text: "Por isso os gatilhos soam absurdos quando você os lista em voz alta, e por isso tantos são coisas que ninguém controla. E por isso chegam num momento suspeito de tão conveniente: quase sempre quando a coisa começa a ficar séria. Mas às vezes o detalhe é uma amostra honesta de algo maior: do que ele riu, como ela falou com o motorista. Os dois acontecem. O sentimento sozinho não diz qual é o seu." },
      { type: "h2", text: "O seu é de que tipo?" },
      { type: "ul", items: [
        "**O momento:** chegou depois de algo que a pessoa fez, ou logo depois de vocês ficarem mais próximos?",
        "**Se repete:** é esta pessoa, ou todo mundo ganha um ick lá pela quinta semana?",
        "**Você consegue nomear a coisa exata:** \"o jeito como ele falou com o garçom\" aponta para conduta; \"o jeito como ele correu atrás do ônibus\" não aponta para nada",
        "**Incomodaria se ninguém visse:** se o desconforto é ser visto ao lado da pessoa, o assunto é você",
      ] },
      { type: "h2", accent: "green", text: "O que fazer com ele" },
      { type: "p", text: "Você nunca precisa de um bom motivo para parar de sair com alguém, e não deve uma explicação construída em cima do gatilho — \"não senti uma conexão romântica\" é mais gentil e igualmente verdadeiro. Se quiser saber de que tipo é o seu, deixe a decisão em aberto por mais duas semanas de convívio comum. Uma incompatibilidade real fica mais alta conforme você conhece a pessoa. A fuga se acalma assim que nada assustador acontece." },
      { type: "p", text: "Se foi com você que fizeram isso, quase nunca há o que consertar. O gatilho raramente dizia que você errou; dizia algo sobre o momento em que ele caiu. E desconfie de tentar ficar à prova de ick sendo liso e discreto: quase tudo o que torna alguém adorável de perto parece um pouco constrangedor de longe." },
    ],
  },

  it: {
    term: "L'ick",
    summary:
      "La perdita improvvisa, spesso sproporzionata, dell'attrazione per un dettaglio: un gesto, una frase, il modo di correre dietro all'autobus. A volte è una vera incompatibilità che affiora, a volte è evitamento travestito.",
    blocks: [
      { type: "h2", text: "Da dove arriva e perché è così brusco" },
      { type: "p", text: "La parola girava nello slang britannico molto prima che un reality la rendesse comune, alla fine degli anni Dieci. Quello che nomina è molto più vecchio del termine. L'attrazione si regge anche sulla storia che ti stai raccontando su qualcuno, e l'ick è quella storia che si spezza. Un dettaglio rende la persona improvvisamente visibile come un essere umano normale e un po' goffo, e il sentimento si spegne molto prima che il ragionamento arrivi." },
      { type: "p", text: "Per questo, elencati ad alta voce, gli inneschi sembrano assurdi, e per questo tanti riguardano cose di cui nessuno ha colpa. E per questo arrivano in un momento sospettosamente comodo: spesso proprio quando la cosa si fa seria. A volte però il dettaglio è un campione onesto di qualcosa di più grande: di che cosa ha riso, come ha parlato all'autista. Succedono entrambe. La sensazione da sola non ti dice quale delle due." },
      { type: "h2", text: "Il tuo di che tipo è?" },
      { type: "ul", items: [
        "**Il momento:** è arrivato dopo un gesto preciso o subito dopo che vi siete avvicinati?",
        "**Si ripete:** è questa persona, o a tutti tocca un ick verso la quinta settimana?",
        "**Sai nominare la cosa precisa:** \"come ha parlato al cameriere\" indica una condotta; \"come ha corso dietro all'autobus\" non indica niente",
        "**Ti darebbe fastidio se non vedesse nessuno:** se il disagio è farti vedere con quella persona, il tema sei tu",
      ] },
      { type: "h2", accent: "green", text: "Cosa farne" },
      { type: "p", text: "Non serve mai un buon motivo per smettere di vedere qualcuno, e non devi una spiegazione costruita sull'innesco: \"non sento una connessione romantica\" è più gentile e altrettanto vero. Se vuoi capire di che tipo è il tuo, tieni la decisione aperta per altre due settimane di frequentazione normale. Un'incompatibilità vera alza la voce man mano che conosci la persona. L'evitamento si placa appena si vede che non succede niente di spaventoso." },
      { type: "p", text: "Se sei tu ad averlo ricevuto, di solito non c'è niente da riparare. L'innesco quasi mai diceva che avevi sbagliato: diceva qualcosa del momento in cui è caduto. E diffida dall'idea di diventare a prova di ick restando liscio e poco appariscente: quasi tutto ciò che rende amabile una persona da vicino, da lontano sembra un po' imbarazzante." },
    ],
  },

  ja: {
    term: "蛙化現象",
    summary:
      "小さなきっかけで好意が急に冷める現象で、英語の the ick にあたります。本当の相性の悪さが顔を出したこともあれば、近づくことからの逃げが姿を変えただけのこともあります。",
    blocks: [
      { type: "h2", text: "どこから来た言葉で、なぜこんなに急なのか" },
      { type: "p", text: "「蛙化現象」はもともと、相手が自分を好きだと分かったとたんに気持ちが冷めることを指していました。ここ数年で使われ方が変わり、いまでは相手のささいな行動で一気に冷める意味で使う人のほうが多くなっています。英語の the ick とほぼ同じ位置です。好意は、相手について自分が語っている物語に支えられている部分があり、この現象はその物語が切れる瞬間。だから理屈が追いつく前に、感情のほうが先に消えます。" },
      { type: "p", text: "きっかけを声に出して並べると滑稽に聞こえるのはそのためで、本人にはどうにもできないことが多いのもそのためです。しかも訪れる時期が妙に都合よく、たいていは関係が現実味を帯びたころ。ただし、その小さなことが大きな何かの正直な見本であることもあります。何を笑ったか、運転手にどう話したか。どちらも起こります。感情そのものは、どちらなのか教えてくれません。" },
      { type: "h2", text: "あなたのはどちらか" },
      { type: "ul", items: [
        "**時期:** 相手が何かをした後に来たのか、距離が縮まった直後に来たのか",
        "**毎回起きるか:** この人に対してだけか、それとも誰といても五週目あたりで冷めるのか",
        "**具体的に言えるか:** 「店員への話し方」は行動を指す。「バスに走る姿」は何も指していない",
        "**誰も見ていなくても嫌か:** 一緒にいるところを見られるのが嫌なら、それはあなたの側の話",
      ] },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "誰かと会うのをやめるのに、立派な理由は要りません。きっかけをそのまま説明にする必要もなく、「恋愛的な気持ちにはなれませんでした」で十分やさしく、十分本当です。どちらなのか知りたいなら、決めるのを二週間だけ保留して、ふつうの連絡を続けてみてください。本当の不一致は、相手を知るほど声が大きくなります。逃げのほうは、怖いことが何も起きないと静かになります。" },
      { type: "p", text: "言われた側になったときは、直すところはたいていありません。きっかけは、あなたが間違っていたという話ではなく、それが落ちた瞬間の話でした。それに、なめらかで目立たない人でいることで冷められない体質になろうとしないこと。近くで見て愛おしいものの大半は、遠くから見ると少し恥ずかしいものです。" },
    ],
  },

  ko: {
    term: "정 떨어지는 순간",
    summary:
      "아주 사소한 것 때문에 호감이 갑자기 꺼지는 일로, 영어로는 the ick이라고 합니다. 진짜 안 맞는 부분이 드러난 것일 수도, 가까워지는 것에 대한 회피가 모습을 바꾼 것일 수도 있습니다.",
    blocks: [
      { type: "h2", text: "어디서 왔고 왜 이렇게 갑작스러운가" },
      { type: "p", text: "영어권에서는 the ick이라고 부르는데, 2010년대 후반 리얼리티 예능을 타고 널리 퍼지기 전부터 영국 속어에 있던 말입니다. 다만 이 말이 가리키는 일은 말보다 훨씬 오래됐습니다. 호감은 어느 정도 당신이 그 사람에 대해 스스로에게 들려주는 이야기 위에 서 있고, 이 순간은 그 이야기가 끊기는 지점입니다. 사소한 장면 하나가 그를 평범하고 조금 어설픈 사람으로 만들어버리면, 이유가 따라오기 한참 전에 감정이 먼저 꺼집니다." },
      { type: "p", text: "그래서 계기를 소리 내어 늘어놓으면 우스워 보이고, 그중 많은 것이 본인도 어쩔 수 없는 일입니다. 게다가 오는 시점이 수상할 만큼 적절합니다. 대개 관계가 진짜가 되려는 무렵이지요. 하지만 그 사소한 것이 더 큰 무언가의 정직한 표본일 때도 있습니다. 무엇을 보고 웃었는지, 기사에게 어떻게 말했는지. 둘 다 실제로 일어납니다. 감정만으로는 어느 쪽인지 알 수 없습니다." },
      { type: "h2", text: "당신의 경우는 어느 쪽인가" },
      { type: "ul", items: [
        "**시점:** 상대가 무언가를 한 뒤에 왔습니까, 아니면 사이가 가까워진 직후에 왔습니까",
        "**늘 그런가:** 이 사람이 문제입니까, 아니면 누구를 만나도 다섯째 주쯤이면 그렇습니까",
        "**구체적으로 말할 수 있는가:** \"종업원에게 말하는 방식\"은 행동을 가리키고, \"버스를 향해 뛰는 모습\"은 아무것도 가리키지 않습니다",
        "**아무도 안 볼 때도 싫은가:** 함께 있는 모습을 남이 보는 게 불편한 것이라면, 그것은 당신 쪽 이야기입니다",
      ] },
      { type: "h2", accent: "green", text: "그럼 어떻게 할까" },
      { type: "p", text: "누군가를 그만 만나는 데 훌륭한 이유는 필요하지 않고, 계기를 그대로 설명으로 만들 의무도 없습니다. \"연애 감정이 생기지 않았어요\"가 더 다정하면서 똑같이 사실입니다. 어느 쪽인지 알고 싶다면 결정을 2주만 미뤄두고 평범한 연락을 이어가 보세요. 진짜 안 맞는 부분은 알아갈수록 소리가 커집니다. 회피는 무서운 일이 아무것도 일어나지 않으면 조용해집니다." },
      { type: "p", text: "반대로 당신이 그런 말을 들은 쪽이라면, 고칠 것은 대개 없습니다. 계기는 당신이 잘못했다는 뜻이라기보다, 그것이 떨어진 순간에 관한 이야기였습니다. 그리고 매끈하고 눈에 안 띄는 사람이 되어 면역을 얻으려 하지 마세요. 가까이서 사랑스러운 것들은 거의 다, 멀리서 보면 조금 민망합니다." },
    ],
  },

  zh: {
    term: "下头",
    summary:
      "因为一件很小的事——一个动作、一句话、追公交车的样子——好感突然熄灭。有时候是真正的不合适浮了上来，有时候只是回避换了个说法。",
    blocks: [
      { type: "h2", text: "它从哪来，为什么这么突然" },
      { type: "p", text: "英文里叫 the ick，二〇一〇年代末因为真人秀节目而流行，但这个词在英国俚语里早就有了；中文里最贴近的说法就是“下头”。它指的事情比词本身老得多。好感有一部分是靠你给自己讲的那个关于对方的故事撑着的，而下头就是这个故事断掉的那一刻。一个细节忽然让他显出普通、有点笨拙的样子，感觉先熄灭，道理很久以后才追上来。" },
      { type: "p", text: "所以把触发的事一条条念出来会觉得荒唐，而且很多是人家根本管不了的。也所以它来的时机可疑地凑巧：往往正是关系要动真格的时候。但有时候那件小事确实是更大一件事的诚实样本：他笑的是什么，她怎么跟司机说话。两种都有。感觉本身不会告诉你是哪一种。" },
      { type: "h2", text: "你这一次是哪一种" },
      { type: "ul", items: [
        "**时机：**是他做了什么之后来的，还是你们刚变得更近之后来的",
        "**是不是每次都这样：**是这个人的问题，还是不管跟谁，到第五周左右都会下头",
        "**你能说出具体那件事吗：**“他跟服务员说话的样子”指向行为；“他追公交车的样子”什么也没指向",
        "**如果没人看见，你还会介意吗：**如果不舒服的是被人看见和他在一起，那这件事关于你自己",
      ] },
      { type: "h2", accent: "green", text: "该怎么办" },
      { type: "p", text: "不想再见一个人，从来不需要一个像样的理由，也不必把那件小事原样说出来当解释——“我没有产生恋爱的感觉”更体面，也同样是真话。如果你想弄清楚是哪一种，把决定先放两周，保持平常的联系。真正的不合适会随着你更了解对方而越来越响；回避则会在发现没什么可怕的事发生之后安静下来。" },
      { type: "p", text: "如果被下头的是你，通常没有什么需要修补。那件小事很少是在说你做错了，它说的是它落下的那个时刻。另外，别为了不被下头而把自己磨得又光滑又没有棱角：凑近看让一个人可爱的东西，几乎都在远看时显得有点尴尬。" },
    ],
  },

  nl: {
    term: "De ick",
    summary:
      "Het plotselinge, vaak buitenproportionele wegvallen van aantrekking door iets kleins: een gebaar, een zin, de manier waarop iemand achter de bus aan rent. Soms komt er echte onverenigbaarheid boven, soms is het vermijding in vermomming.",
    blocks: [
      { type: "h2", text: "Waar het vandaan komt en waarom het zo abrupt is" },
      { type: "p", text: "Het woord bestond al in Brits slang voordat een realityprogramma het eind jaren tien gemeengoed maakte. Wat het benoemt is veel ouder dan de term. Aantrekking leunt deels op het verhaal dat je jezelf over iemand vertelt, en de ick is het moment waarop dat verhaal breekt. Een detail maakt de ander opeens zichtbaar als een gewoon, ietwat onhandig mens, en het gevoel gaat uit lang voordat enige redenering het inhaalt." },
      { type: "p", text: "Daarom klinken de triggers absurd als je ze hardop opsomt, en daarom gaat het zo vaak over dingen waar niemand iets aan kan doen. Daarom komen ze ook op een verdacht gunstig moment: meestal precies als het echt wordt. Maar soms is dat kleine ding een eerlijke steekproef van iets groters: waar hij om lachte, hoe zij tegen de chauffeur deed. Beide bestaan. Het gevoel zelf zegt niet welke van de twee." },
      { type: "h2", text: "Welke van de twee is die van jou?" },
      { type: "ul", items: [
        "**Het moment:** kwam het na iets wat diegene deed, of net nadat het dichterbij kwam?",
        "**Herhaalt het zich:** ligt het aan deze persoon, of krijgt iedereen rond week vijf een ick?",
        "**Kun je het precieze ding benoemen:** \"hoe hij tegen de ober deed\" wijst op gedrag; \"hoe hij achter de bus aan rende\" wijst nergens op",
        "**Zou het je storen als niemand keek:** als het ongemak gaat over gezien worden met diegene, gaat het over jou",
      ] },
      { type: "h2", accent: "green", text: "Wat je ermee doet" },
      { type: "p", text: "Je hebt nooit een goede reden nodig om met iemand te stoppen, en je bent geen uitleg schuldig die op de trigger gebouwd is — \"ik voel geen romantische klik\" is vriendelijker en even waar. Wil je weten welke van de twee het is, houd de beslissing dan nog twee weken open en blijf gewoon contact houden. Echte onverenigbaarheid wordt luider naarmate je meer weet. Vermijding wordt stiller zodra er niets engs gebeurt." },
      { type: "p", text: "Ben jij degene bij wie het gebeurde, dan valt er meestal niets te repareren. De trigger zei zelden dat jij iets fout deed; hij zei iets over het moment waarop hij viel. En pas op met ick-bestendig willen worden door glad en onopvallend te blijven: bijna alles wat iemand van dichtbij beminnelijk maakt, oogt van een afstand een beetje gênant." },
    ],
  },

  pl: {
    term: "Ick",
    summary:
      "Nagła, często nieproporcjonalna utrata pociągu przez drobiazg: gest, zdanie, sposób biegnięcia do autobusu. Czasem wypływa prawdziwe niedopasowanie, czasem to unikanie w przebraniu.",
    blocks: [
      { type: "h2", text: "Skąd się bierze i dlaczego jest tak nagłe" },
      { type: "p", text: "Słowo krążyło w brytyjskim slangu na długo przed tym, jak reality show upowszechniło je pod koniec lat dziesiątych. To, co nazywa, jest dużo starsze od samego określenia. Pociąg opiera się częściowo na historii, którą sam sobie o kimś opowiadasz, a ick to moment, w którym ta historia pęka. Drobiazg sprawia, że druga osoba nagle staje się zwykłym, trochę niezdarnym człowiekiem, a uczucie gaśnie na długo przed tym, zanim dogoni je rozumowanie." },
      { type: "p", text: "Dlatego wyliczane na głos wyzwalacze brzmią absurdalnie i dlatego tyle wśród nich rzeczy, na które nikt nie ma wpływu. Dlatego też przychodzą w podejrzanie dogodnym momencie: zwykle wtedy, gdy zaczyna się robić poważnie. Ale czasem ten drobiazg jest uczciwą próbką czegoś większego: z czego się śmiał, jak odezwała się do kierowcy. Zdarza się jedno i drugie. Samo uczucie nie powie ci, które." },
      { type: "h2", text: "Które z nich jest twoje?" },
      { type: "ul", items: [
        "**Moment:** przyszło po tym, co ktoś zrobił, czy zaraz po tym, jak zrobiło się bliżej?",
        "**Czy się powtarza:** chodzi o tę osobę, czy o to, że w okolicach piątego tygodnia zawsze tak jest?",
        "**Czy umiesz nazwać konkret:** \"jak odezwał się do kelnera\" wskazuje na postępowanie; \"jak biegł do autobusu\" nie wskazuje na nic",
        "**Czy przeszkadzałoby ci to, gdyby nikt nie widział:** jeśli niewygodne jest bycie widzianym razem, rzecz dotyczy ciebie",
      ] },
      { type: "h2", accent: "green", text: "Co z tym zrobić" },
      { type: "p", text: "Nigdy nie potrzebujesz dobrego powodu, żeby przestać się z kimś spotykać, i nie jesteś nikomu winien wyjaśnienia zbudowanego na wyzwalaczu — \"nie czuję romantycznej więzi\" jest łagodniejsze i tak samo prawdziwe. Jeśli chcesz wiedzieć, które to z dwojga, zostaw decyzję otwartą jeszcze na dwa tygodnie zwykłego kontaktu. Prawdziwe niedopasowanie robi się głośniejsze, im więcej wiesz. Unikanie cichnie, gdy okazuje się, że nic strasznego się nie dzieje." },
      { type: "p", text: "Jeśli to tobie ktoś tak zrobił, zwykle nie ma czego naprawiać. Wyzwalacz rzadko mówił, że zrobiłeś coś źle — mówił coś o chwili, w którą trafił. I uważaj na pomysł uodpornienia się przez bycie gładkim i niewyróżniającym się: prawie wszystko, co czyni człowieka kochanym z bliska, z daleka wygląda odrobinę żenująco." },
    ],
  },

  sv: {
    term: "The ick",
    summary:
      "Den plötsliga, ofta orimliga förlusten av attraktion som utlöses av något litet: en gest, en fras, sättet någon springer efter bussen. Ibland är det en verklig oförenlighet som visar sig, ibland undvikande i förklädnad.",
    blocks: [
      { type: "h2", text: "Var det kommer ifrån och varför det går så fort" },
      { type: "p", text: "Ordet fanns i brittisk slang långt innan ett realityprogram gjorde det allmänt i slutet av 2010-talet. Det som ordet beskriver är mycket äldre än ordet självt. Attraktion vilar delvis på den berättelse du själv har om någon, och the ick är ögonblicket då den berättelsen brister. En detalj gör personen plötsligt synlig som en vanlig, lite fumlig människa, och känslan slås av långt innan något resonemang hinner ikapp." },
      { type: "p", text: "Därför låter utlösarna orimliga när man räknar upp dem högt, och därför handlar så många om sådant ingen rår för. Därför kommer de också vid en misstänkt lämplig tidpunkt: oftast precis när det börjar bli på riktigt. Men ibland är det lilla ett ärligt stickprov på något större: vad han skrattade åt, hur hon pratade med chauffören. Båda finns. Känslan i sig säger inte vilken det är." },
      { type: "h2", text: "Vilken av dem är din?" },
      { type: "ul", items: [
        "**Tidpunkten:** kom den efter något personen gjorde, eller precis efter att ni kom närmare varandra?",
        "**Upprepas den:** handlar det om den här personen, eller får alla en ick runt vecka fem?",
        "**Kan du namnge den exakta saken:** \"hur han pratade med servitören\" pekar på uppförande; \"hur han sprang efter bussen\" pekar på ingenting",
        "**Skulle det störa dig om ingen såg:** om obehaget handlar om att synas ihop med personen handlar det om dig",
      ] },
      { type: "h2", accent: "green", text: "Vad du gör åt det" },
      { type: "p", text: "Du behöver aldrig ett bra skäl för att sluta träffa någon, och du är ingen förklaring skyldig som är byggd på utlösaren — \"jag känner ingen romantisk koppling\" är snällare och lika sant. Vill du veta vilken av dem det är, håll beslutet öppet ytterligare två veckor av vanlig kontakt. En verklig oförenlighet blir högre ju mer du lär känna personen. Undvikande blir tystare så fort inget skrämmande händer." },
      { type: "p", text: "Är det du som blivit lämnad på det sättet finns det oftast inget att laga. Utlösaren sa sällan att du gjort fel; den sa något om ögonblicket den landade i. Och akta dig för att försöka bli ick-säker genom att hålla dig slät och oansenlig: nästan allt som gör en människa älskvärd på nära håll ser lite pinsamt ut på avstånd." },
    ],
  },

  hi: {
    term: "इक",
    summary:
      "किसी छोटी-सी बात से आकर्षण का अचानक बुझ जाना — एक हरकत, एक जुमला, बस के पीछे दौड़ने का तरीक़ा। कभी यह सचमुच की बेमेल बात का सिरा होता है, कभी क़रीब आने से बचने का बदला हुआ रूप।",
    blocks: [
      { type: "h2", text: "यह आया कहाँ से और इतना अचानक क्यों" },
      { type: "p", text: "अंग्रेज़ी में इसे the ick कहते हैं; ब्रिटिश बोलचाल में यह शब्द बरसों से था और 2010 के दशक के आख़िर में एक रियलिटी शो से आम हो गया। मगर जिस चीज़ को यह नाम देता है, वह शब्द से कहीं पुरानी है। आकर्षण कुछ हद तक उस कहानी पर टिका होता है जो आप ख़ुद को उस इंसान के बारे में सुनाते हैं, और यह वही पल है जब कहानी टूट जाती है। कोई छोटी बात उसे अचानक एक साधारण, थोड़ा बेढंगा इंसान बना देती है, और दलील के पहुँचने से बहुत पहले भावना बुझ जाती है।" },
      { type: "p", text: "इसीलिए वजहें ज़ोर से गिनाने पर हास्यास्पद लगती हैं, और इसीलिए उनमें से कई ऐसी होती हैं जिन पर किसी का बस नहीं। और इसीलिए वे शक़ पैदा करने वाले ठीक वक़्त पर आती हैं: अक्सर तभी, जब बात असली होने लगती है। पर कभी-कभी वह छोटी बात किसी बड़ी बात का सच्चा नमूना होती है: वह किस पर हँसा, उसने ड्राइवर से कैसे बात की। दोनों होते हैं। भावना ख़ुद नहीं बताती कि आपका मामला कौन-सा है।" },
      { type: "h2", text: "आपका मामला कौन-सा है?" },
      { type: "ul", items: [
        "**वक़्त:** यह उसके कुछ करने के बाद आया, या रिश्ते के क़रीब आने के ठीक बाद?",
        "**हर बार होता है क्या:** बात इसी इंसान की है, या पाँचवें हफ़्ते के आसपास हर बार ऐसा ही होता है?",
        "**क्या आप ठीक-ठीक बात बता सकते हैं:** \"उसने वेटर से कैसे बात की\" बर्ताव की ओर इशारा है; \"वह बस के पीछे कैसे दौड़ा\" किसी चीज़ की ओर नहीं",
        "**कोई न देख रहा होता तो भी बुरा लगता:** अगर तकलीफ़ उसके साथ दिखने से है, तो मामला आपका अपना है",
      ] },
      { type: "h2", accent: "green", text: "इसका क्या करें" },
      { type: "p", text: "किसी से मिलना बंद करने के लिए अच्छी वजह कभी ज़रूरी नहीं होती, और सफ़ाई को उसी छोटी बात पर खड़ा करना भी ज़रूरी नहीं — \"मुझे रोमांटिक जुड़ाव महसूस नहीं हुआ\" ज़्यादा नरम है और उतना ही सच। अगर जानना है कि मामला कौन-सा है, तो फ़ैसले को दो हफ़्ते और खुला रखिए और सामान्य बातचीत जारी रखिए। असली बेमेल बात जानने के साथ और तेज़ होती जाती है; बचने की आदत तब चुप हो जाती है जब डरने लायक़ कुछ नहीं होता।" },
      { type: "p", text: "अगर यह आपके साथ हुआ है, तो सुधारने को आमतौर पर कुछ नहीं होता। वह वजह शायद ही कहती थी कि आपने ग़लत किया — वह उस पल के बारे में थी जिसमें वह गिरी। और चिकना, बिना किसी कोने वाला इंसान बनकर इससे बचने की कोशिश मत कीजिए: पास से जो चीज़ें किसी को प्यारा बनाती हैं, दूर से देखने पर उनमें से लगभग हर एक थोड़ी शर्मिंदा करने वाली लगती है।" },
    ],
  },
};
