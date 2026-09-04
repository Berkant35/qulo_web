import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Catfishing — pretending online to be someone you are not, with borrowed
 * photos and an invented life, so the other person attaches to a character.
 *
 * Judgement calls a later editor should not undo by accident:
 *
 * - PRODUCT CLAIM. Block 7 says outright that Qulo does **not** verify
 *   identity, screen photos or detect fake profiles, because it does not. The
 *   quiz is easy to mistake for a screening mechanism and it is not one:
 *   answering someone's questions proves the person read the profile and
 *   nothing else. The question count is deliberately left out of block 7: a
 *   free account writes 2 to 4 and only a paid plan reaches 10, and neither
 *   number belongs on a page about what the quiz does NOT verify. Never quote
 *   the range as 2 to 10 without naming the paid plan in the same sentence.
 *   This page is the one place in the glossary where naming Qulo is worth it
 *   precisely because the honest statement is a limitation, not a pitch. Do
 *   not soften it into "helps you spot fake profiles".
 *
 * - THE 2010 DOCUMENTARY is referenced by year, not by title. The title adds
 *   nothing a reader needs and the year is enough to place the word's origin.
 *
 * - NO FIGURES. There is no "X% of profiles are fake", no "most catfish want
 *   money", no "romance scams are rising". Every one of those would need a
 *   named primary source in the same sentence and none was available, so the
 *   motives are described qualitatively instead. Do not add a percentage here.
 *
 * - "REVERSE IMAGE SEARCH" is described generically; no search engine or tool
 *   is named anywhere.
 *
 * - TERM NAMES. ar/ru/ja/ko/zh/hi use the native rendering rather than the
 *   Latin loanword, and where both genuinely circulate (ar, ja, zh) the summary
 *   names the English word too so the page still answers the searcher who typed
 *   "catfishing". zh uses 网络身份造假 rather than the slang 照骗, which only
 *   covers deceptive photos and would contradict the paragraph distinguishing
 *   a flattering photo from a fabricated person.
 */
export const catfishing: LocalizedGlossaryEntry = {
  en: {
    term: "Catfishing",
    summary:
      "Pretending online to be someone you are not — borrowed photos, a made-up name, an invented life — so that the person talking to you falls for a character instead of a real person.",
    blocks: [
      { type: "h2", text: "Why someone builds a fake profile" },
      { type: "p", text: "The word comes from a 2010 documentary about a man who fell in love with a woman who did not exist, and it stuck because the situation is so recognisable. The reasons behind it vary more than people expect. Some are running a scam and want money. Some are bored. Many are simply ashamed of their own face or their own life, borrow a better one, and then cannot find a way to climb back down." },
      { type: "p", text: "It helps to separate two things. A photo from three years ago, a couple of centimetres added to a height, an age rounded down — that is vanity, and almost everyone does a version of it. Catfishing is **different in kind**: the person on the other side is not a flattering edit of someone real, they are an invention." },
      { type: "h2", text: "How to spot it" },
      { type: "ul", items: [
        "Video is always impossible: a broken camera, bad signal, shyness — a fresh reason every time you ask.",
        "The photos are few, oddly polished and never casual; a reverse image search finds the same pictures somewhere else.",
        "Details drift. The job, the city, a sibling's name quietly change between conversations.",
        "Feelings escalate fast, and then money appears: an emergency, a stuck payment, a short loan.",
      ] },
      { type: "h2", accent: "green", text: "The one check worth making" },
      { type: "p", text: "Ask for a **short live video call in the first week**, before you have invested anything. Keep it light: five minutes, just to see who you are talking to. Someone real will do it, or will say plainly why they cannot and offer another time. A live call is hard to fake convincingly, so a person who dodges it four times has already answered you. And never send money to someone you have not met." },
      { type: "p", text: "One honest note about apps, this one included. On Qulo each member writes their own questions and you match only by getting them all right — but that proves someone read your profile, nothing more. **Qulo does not verify identity, screen photos or detect fake profiles.** Asking for that video call is still your job." },
    ],
  },
  tr: {
    term: "Catfishing",
    summary:
      "Sahte fotoğraflar, uydurma bir isim ve olmayan bir hayatla başkası gibi davranmak; karşındaki kişi gerçek biriyle değil, kurgulanmış bir karakterle bağ kurar.",
    blocks: [
      { type: "h2", text: "İnsanlar neden sahte profil kurar?" },
      { type: "p", text: "Kelime, 2010 yapımı bir belgeselden geliyor: bir adam, aslında var olmayan bir kadına âşık oluyor. Durum fazlasıyla tanıdık geldiği için de dilde kaldı. Sebepler sanıldığından çeşitli. Bir kısmı doğrudan dolandırıcılık, para peşinde. Bir kısmı sıkıntıdan. Çoğu ise kendi yüzünden ya da kendi hayatından utanıyor, daha parlak bir tanesini ödünç alıyor ve sonra o merdivenden inmenin bir yolunu bulamıyor." },
      { type: "p", text: "İki şeyi ayırmak işe yarar. Üç yıl önceki bir fotoğraf, birkaç santim uzatılmış boy, aşağı yuvarlanmış bir yaş — bu kibir, ve neredeyse herkes bunun bir versiyonunu yapıyor. Catfishing **türü itibarıyla başka bir şey**: karşındaki kişi gerçek birinin makyajlanmış hâli değil, tamamen uydurma." },
      { type: "h2", text: "Nasıl anlaşılır?" },
      { type: "ul", items: [
        "Görüntülü konuşma hep imkânsız: kamera bozuk, çekim kötü, utanıyor — her seferinde yeni bir gerekçe.",
        "Fotoğraflar az, fazla düzgün ve hiç gündelik değil; görselle arama yapınca aynı kareler başka yerlerde çıkıyor.",
        "Ayrıntılar kayıyor. İş, şehir, kardeşin adı konuşmalar arasında sessizce değişiyor.",
        "Duygular hızla büyüyor, sonra para giriyor: acil bir durum, takılan bir ödeme, kısa bir borç.",
      ] },
      { type: "h2", accent: "green", text: "Yapılacak tek sağlam kontrol" },
      { type: "p", text: "**İlk hafta içinde kısa bir görüntülü görüşme iste**, daha hiçbir şey yatırmamışken. Havayı ağırlaştırma: beş dakika, sadece kiminle konuştuğunu görmek için. Gerçek biri ya bunu yapar ya da neden yapamadığını açıkça söyleyip başka bir saat önerir. Canlı görüntüyü ikna edici biçimde taklit etmek zordur; dört kez kaçıran biri sana cevabını çoktan vermiştir. Ve tanışmadığın kimseye para gönderme." },
      { type: "p", text: "Uygulamalar hakkında dürüst bir not, bu uygulama dahil. Qulo'da herkes kendisiyle ilgili sorular yazar ve ancak hepsini doğru bilen kişiyle eşleşirsin — ama bu yalnızca birinin profilini okuduğunu gösterir, fazlasını değil. **Qulo kimlik doğrulamaz, fotoğraf denetlemez, sahte profil tespit etmez.** O görüntülü görüşmeyi istemek yine sana kalmış." },
    ],
  },
  de: {
    term: "Catfishing",
    summary:
      "Sich online als jemand anderes ausgeben — mit fremden Fotos, erfundenem Namen und erfundenem Leben —, sodass das Gegenüber sich in eine Figur verliebt statt in einen echten Menschen.",
    blocks: [
      { type: "h2", text: "Warum Menschen ein falsches Profil anlegen" },
      { type: "p", text: "Das Wort stammt aus einer Dokumentation von 2010, in der sich ein Mann in eine Frau verliebt, die es nicht gibt. Es ist geblieben, weil die Situation so vielen bekannt vorkommt. Die Gründe dahinter sind vielfältiger, als man denkt. Manche ziehen eine Betrugsmasche auf und wollen Geld. Manche langweilen sich. Viele schämen sich schlicht für ihr eigenes Gesicht oder ihr eigenes Leben, borgen sich ein besseres und finden danach keinen Weg mehr zurück." },
      { type: "p", text: "Es hilft, zwei Dinge zu trennen. Ein Foto von vor drei Jahren, ein paar Zentimeter mehr Körpergröße, ein abgerundetes Alter — das ist Eitelkeit, und fast alle machen irgendeine Version davon. Catfishing ist **etwas grundsätzlich anderes**: Die Person auf der anderen Seite ist keine geschönte Fassung von jemandem, sie ist erfunden." },
      { type: "h2", text: "Woran du es erkennst" },
      { type: "ul", items: [
        "Video ist immer unmöglich: kaputte Kamera, schlechtes Netz, Schüchternheit — jedes Mal ein neuer Grund.",
        "Wenige, seltsam perfekte Fotos, nie ein beiläufiges; die Rückwärtssuche findet dieselben Bilder woanders.",
        "Details verrutschen. Beruf, Stadt, der Name der Schwester ändern sich zwischen zwei Gesprächen.",
        "Die Gefühle eskalieren schnell, dann kommt Geld ins Spiel: ein Notfall, eine blockierte Zahlung, ein kurzer Kredit.",
      ] },
      { type: "h2", accent: "green", text: "Die eine Prüfung, die wirklich hilft" },
      { type: "p", text: "Bitte **in der ersten Woche um einen kurzen Videoanruf**, bevor du irgendetwas investiert hast. Halte es leicht: fünf Minuten, nur um zu sehen, mit wem du schreibst. Wer echt ist, macht das — oder sagt offen, warum es gerade nicht geht, und schlägt einen anderen Termin vor. Live-Video lässt sich kaum überzeugend fälschen, und wer viermal ausweicht, hat bereits geantwortet. Und schick niemandem Geld, den du nie getroffen hast." },
      { type: "p", text: "Eine ehrliche Anmerkung zu Apps, diese eingeschlossen: Bei Qulo schreibt jedes Mitglied eigene Fragen, und ein Match entsteht nur, wenn jemand alle richtig beantwortet — das beweist aber nur, dass die Person dein Profil gelesen hat. **Qulo prüft keine Identitäten, kontrolliert keine Fotos und erkennt keine Fake-Profile.** Nach dem Videoanruf musst du selbst fragen." },
    ],
  },
  fr: {
    term: "Catfishing",
    summary:
      "Se faire passer en ligne pour quelqu'un d'autre — photos volées, faux prénom, vie inventée — pour que la personne en face s'attache à un personnage plutôt qu'à quelqu'un de réel.",
    blocks: [
      { type: "h2", text: "Pourquoi on se crée un faux profil" },
      { type: "p", text: "Le mot vient d'un documentaire de 2010 où un homme tombe amoureux d'une femme qui n'existe pas, et il est resté parce que la situation parle à tout le monde. Les raisons sont plus variées qu'on ne l'imagine. Certains montent une arnaque et veulent de l'argent. D'autres s'ennuient. Beaucoup ont simplement honte de leur visage ou de leur vie, en empruntent un plus beau, puis ne trouvent plus comment redescendre." },
      { type: "p", text: "Il faut distinguer deux choses. Une photo d'il y a trois ans, quelques centimètres ajoutés, un âge arrondi vers le bas : c'est de la coquetterie, et presque tout le monde en fait une version. Le catfishing est **d'une autre nature** : la personne en face n'est pas une version flatteuse de quelqu'un, elle est inventée." },
      { type: "h2", text: "Comment le repérer" },
      { type: "ul", items: [
        "L'appel vidéo est toujours impossible : caméra cassée, mauvais réseau, timidité — un motif différent à chaque fois.",
        "Peu de photos, étrangement léchées, jamais spontanées ; une recherche d'image inversée les retrouve ailleurs.",
        "Les détails glissent. Le métier, la ville, le prénom d'un frère changent d'une conversation à l'autre.",
        "Les sentiments s'emballent vite, puis l'argent arrive : une urgence, un paiement bloqué, un petit prêt.",
      ] },
      { type: "h2", accent: "green", text: "La seule vérification qui compte" },
      { type: "p", text: "Demandez **un court appel vidéo dès la première semaine**, avant d'avoir investi quoi que ce soit. Restez léger : cinq minutes, juste pour voir à qui vous parlez. Quelqu'un de réel acceptera, ou expliquera franchement pourquoi c'est impossible et proposera un autre moment. Une vidéo en direct est très difficile à truquer, et celui qui esquive quatre fois vous a déjà répondu. Et n'envoyez jamais d'argent à quelqu'un que vous n'avez pas rencontré." },
      { type: "p", text: "Une note honnête sur les applis, celle-ci comprise. Sur Qulo, chacun écrit ses propres questions et le match n'a lieu que si l'autre répond juste à toutes — mais cela prouve seulement qu'il a lu votre profil, rien de plus. **Qulo ne vérifie aucune identité, ne contrôle pas les photos et ne détecte pas les faux profils.** L'appel vidéo, c'est à vous de le demander." },
    ],
  },
  es: {
    term: "Catfishing",
    summary:
      "Hacerse pasar por otra persona en internet — fotos ajenas, un nombre falso, una vida inventada — para que quien está al otro lado se enamore de un personaje y no de alguien real.",
    blocks: [
      { type: "h2", text: "Por qué alguien se crea un perfil falso" },
      { type: "p", text: "La palabra viene de un documental de 2010 sobre un hombre que se enamora de una mujer que no existe, y se quedó porque la situación resulta demasiado reconocible. Los motivos son más variados de lo que parece. Algunos buscan dinero y montan una estafa. Otros se aburren. Muchos sienten vergüenza de su propia cara o de su propia vida, piden prestada una mejor y luego no encuentran la forma de bajarse." },
      { type: "p", text: "Conviene separar dos cosas. Una foto de hace tres años, unos centímetros de más en la altura, una edad redondeada hacia abajo: eso es vanidad, y casi todo el mundo hace alguna versión. El catfishing es **otra cosa distinta**: quien está al otro lado no es una versión favorecida de alguien real, es un invento." },
      { type: "h2", text: "Cómo detectarlo" },
      { type: "ul", items: [
        "La videollamada siempre es imposible: cámara rota, mala cobertura, vergüenza — una excusa nueva cada vez.",
        "Pocas fotos, demasiado perfectas y nunca espontáneas; una búsqueda inversa las encuentra en otro sitio.",
        "Los detalles se mueven. El trabajo, la ciudad, el nombre de un hermano cambian de una conversación a otra.",
        "Los sentimientos se disparan rápido y luego aparece el dinero: una urgencia, un pago bloqueado, un préstamo corto.",
      ] },
      { type: "h2", accent: "green", text: "La única comprobación que sirve" },
      { type: "p", text: "Pide **una videollamada corta durante la primera semana**, antes de haber invertido nada. Sin dramatismo: cinco minutos, solo para ver con quién hablas. Alguien real lo hará, o dirá con claridad por qué no puede y propondrá otro momento. Un vídeo en directo es muy difícil de falsificar, así que quien lo esquiva cuatro veces ya te ha respondido. Y nunca envíes dinero a alguien que no conoces en persona." },
      { type: "p", text: "Una nota honesta sobre las apps, esta incluida. En Qulo cada persona escribe sus propias preguntas y solo hay match si la otra las acierta todas — pero eso demuestra que ha leído tu perfil, nada más. **Qulo no verifica identidades, no revisa fotos ni detecta perfiles falsos.** Pedir esa videollamada sigue siendo cosa tuya." },
    ],
  },
  ar: {
    term: "انتحال الشخصية",
    summary:
      "أن يتظاهر أحدهم على الإنترنت بأنه شخص آخر بصور مسروقة واسم مستعار وحياة ملفّقة، فيتعلّق من يحادثه بشخصية مصنوعة لا بإنسان حقيقي. ويسمّى بالإنجليزية catfishing.",
    blocks: [
      { type: "h2", text: "لماذا يصنع أحدهم حسابًا وهميًا؟" },
      { type: "p", text: "جاءت التسمية من فيلم وثائقي عام 2010 عن رجل أحبّ امرأة لا وجود لها، وبقيت لأن الموقف مألوف جدًا. الدوافع أكثر تنوعًا مما يُظن. بعضهم يدير عملية احتيال ويريد المال. بعضهم يتسلّى فقط. وكثيرون يخجلون من وجوههم أو من حياتهم، فيستعيرون وجهًا أفضل، ثم لا يجدون طريقة للتراجع." },
      { type: "p", text: "من المفيد الفصل بين أمرين. صورة قديمة بثلاث سنوات، أو سنتيمترات مضافة إلى الطول، أو عمر مخفَّض قليلًا: هذه زهو بالنفس، ويكاد الجميع يفعل شيئًا مشابهًا. أما انتحال الشخصية فهو **نوع مختلف تمامًا**: من يحادثك ليس نسخة محسّنة من إنسان، بل شخص مُختلَق من الأساس." },
      { type: "h2", text: "كيف تكتشفه" },
      { type: "ul", items: [
        "المكالمة المرئية مستحيلة دائمًا: كاميرا معطّلة، شبكة ضعيفة، خجل — عذر جديد في كل مرة.",
        "صور قليلة ومصقولة بشكل غريب ولا شيء عفوي فيها؛ والبحث العكسي عن الصورة يجدها في مكان آخر.",
        "التفاصيل تتبدّل. المهنة والمدينة واسم الأخ تتغيّر بهدوء بين محادثة وأخرى.",
        "المشاعر تتصاعد بسرعة، ثم يظهر المال: حالة طارئة، أو تحويل متعثّر، أو قرض قصير.",
      ] },
      { type: "h2", accent: "green", text: "الفحص الوحيد الذي يستحق" },
      { type: "p", text: "اطلب **مكالمة مرئية قصيرة في الأسبوع الأول**، قبل أن تستثمر مشاعرك في شيء. اجعلها خفيفة: خمس دقائق فقط لترى من تحادث. الشخص الحقيقي سيفعلها، أو سيقول بوضوح لماذا لا يستطيع ويقترح وقتًا آخر. تزييف بث مباشر بشكل مقنع أمر صعب، ومن يتهرّب أربع مرات يكون قد أجابك. ولا ترسل مالًا لمن لم تقابله." },
      { type: "p", text: "ملاحظة صادقة عن التطبيقات، وهذا منها. في Qulo يكتب كل عضو أسئلته الخاصة، ولا يحدث التوافق إلا بالإجابة عنها كلها بشكل صحيح — لكن هذا يثبت أن أحدهم قرأ ملفك فقط. **لا يتحقق Qulo من الهوية ولا يفحص الصور ولا يكشف الحسابات الوهمية.** طلب المكالمة المرئية يبقى مسؤوليتك أنت." },
    ],
  },
  ru: {
    term: "Кэтфишинг",
    summary:
      "Выдавать себя в интернете за другого человека — чужие фото, придуманное имя, вымышленная жизнь, — чтобы собеседник привязался к персонажу, а не к живому человеку.",
    blocks: [
      { type: "h2", text: "Зачем люди заводят фальшивый профиль" },
      { type: "p", text: "Слово пришло из документального фильма 2010 года о мужчине, влюбившемся в женщину, которой не существует, и прижилось, потому что ситуация слишком узнаваема. Причин больше, чем принято думать. Кто-то выстраивает схему и хочет денег. Кому-то просто скучно. Многие стыдятся собственного лица или собственной жизни, берут взаймы чужое и потом уже не находят способа спуститься обратно." },
      { type: "p", text: "Полезно различать две вещи. Фотография трёхлетней давности, пара лишних сантиметров роста, округлённый вниз возраст — это тщеславие, и в том или ином виде так делают почти все. Кэтфишинг устроен **принципиально иначе**: человек по ту сторону не приукрашен, он придуман целиком." },
      { type: "h2", text: "Как это распознать" },
      { type: "ul", items: [
        "Видеозвонок всегда невозможен: сломанная камера, плохая связь, стеснительность — каждый раз новая причина.",
        "Фотографий мало, они странно вылизанные и никогда не бытовые; поиск по картинке находит те же кадры в другом месте.",
        "Детали плывут. Работа, город, имя брата тихо меняются от разговора к разговору.",
        "Чувства нарастают стремительно, а затем появляются деньги: срочный случай, застрявший платёж, небольшой заём.",
      ] },
      { type: "h2", accent: "green", text: "Одна проверка, которая работает" },
      { type: "p", text: "Попросите **короткий видеозвонок на первой неделе**, пока вы ещё ничего не вложили. Без пафоса: пять минут, просто увидеть, с кем вы переписываетесь. Настоящий человек согласится или честно объяснит, почему сейчас не выходит, и предложит другое время. Живое видео подделать убедительно трудно, и тот, кто увиливает четвёртый раз, уже ответил. И никогда не отправляйте деньги тому, кого не видели вживую." },
      { type: "p", text: "Честное замечание о приложениях, включая это. В Qulo каждый пишет свои собственные вопросы, и совпадение случается, только если человек ответил на все верно, — но это доказывает лишь то, что он прочитал вашу анкету. **Qulo не проверяет личность, не модерирует фотографии и не распознаёт фальшивые аккаунты.** Попросить о видеозвонке всё равно придётся вам." },
    ],
  },
  pt: {
    term: "Catfishing",
    summary:
      "Fingir ser outra pessoa na internet — fotos alheias, nome falso, uma vida inventada — para que quem está do outro lado se apegue a um personagem em vez de alguém real.",
    blocks: [
      { type: "h2", text: "Por que alguém cria um perfil falso" },
      { type: "p", text: "A palavra vem de um documentário de 2010 sobre um homem que se apaixona por uma mulher que não existe, e pegou porque a situação é reconhecível demais. Os motivos são mais variados do que se imagina. Uns querem dinheiro e montam um golpe. Outros estão entediados. Muitos simplesmente têm vergonha do próprio rosto ou da própria vida, pegam emprestada uma versão melhor e depois não acham como descer de lá." },
      { type: "p", text: "Vale separar duas coisas. Uma foto de três anos atrás, alguns centímetros a mais na altura, uma idade arredondada para baixo: isso é vaidade, e quase todo mundo faz alguma versão disso. Catfishing é **outra coisa em natureza**: quem está do outro lado não é uma versão favorecida de alguém, é uma invenção." },
      { type: "h2", text: "Como perceber" },
      { type: "ul", items: [
        "A chamada de vídeo é sempre impossível: câmera quebrada, sinal ruim, timidez — um motivo novo a cada vez.",
        "Poucas fotos, estranhamente perfeitas e nunca espontâneas; a busca reversa encontra as mesmas imagens em outro lugar.",
        "Os detalhes escorregam. O trabalho, a cidade, o nome do irmão mudam de uma conversa para outra.",
        "O sentimento cresce depressa e então aparece dinheiro: uma emergência, um pagamento travado, um empréstimo curto.",
      ] },
      { type: "h2", accent: "green", text: "A única verificação que vale" },
      { type: "p", text: "Peça **uma chamada de vídeo curta na primeira semana**, antes de investir qualquer coisa. Sem peso: cinco minutos, só para ver com quem você está falando. Uma pessoa real topa, ou diz com clareza por que não dá agora e sugere outro horário. Vídeo ao vivo é difícil de falsificar de forma convincente, e quem foge quatro vezes já respondeu. E nunca mande dinheiro para quem você não conheceu." },
      { type: "p", text: "Uma nota honesta sobre aplicativos, este incluído. No Qulo cada pessoa escreve as próprias perguntas e o match só acontece se a outra acertar todas — mas isso prova apenas que alguém leu o seu perfil. **O Qulo não verifica identidade, não analisa fotos e não detecta perfis falsos.** Pedir aquela chamada de vídeo continua sendo com você." },
    ],
  },
  it: {
    term: "Catfishing",
    summary:
      "Fingersi qualcun altro online — foto rubate, un nome inventato, una vita che non esiste — così che chi ti scrive si affezioni a un personaggio invece che a una persona vera.",
    blocks: [
      { type: "h2", text: "Perché qualcuno si costruisce un profilo falso" },
      { type: "p", text: "La parola arriva da un documentario del 2010 su un uomo innamorato di una donna che non esiste, ed è rimasta perché la situazione è fin troppo riconoscibile. Le ragioni sono più varie di quanto si creda. Qualcuno organizza una truffa e vuole soldi. Qualcuno si annoia. Molti si vergognano semplicemente della propria faccia o della propria vita, ne prendono in prestito una migliore e poi non trovano più il modo di scendere." },
      { type: "p", text: "Conviene distinguere due cose. Una foto di tre anni fa, qualche centimetro in più di altezza, un'età arrotondata per difetto: quella è vanità, e più o meno la fanno tutti. Il catfishing è **un'altra cosa per natura**: chi hai dall'altra parte non è una versione migliorata di qualcuno, è un'invenzione." },
      { type: "h2", text: "Come riconoscerlo" },
      { type: "ul", items: [
        "La videochiamata è sempre impossibile: telecamera rotta, linea che va male, timidezza — ogni volta un motivo nuovo.",
        "Poche foto, stranamente perfette e mai spontanee; una ricerca inversa le ritrova altrove.",
        "I dettagli slittano. Il lavoro, la città, il nome di un fratello cambiano da una conversazione all'altra.",
        "I sentimenti corrono in fretta e poi entrano i soldi: un'emergenza, un pagamento bloccato, un piccolo prestito.",
      ] },
      { type: "h2", accent: "green", text: "L'unico controllo che serve" },
      { type: "p", text: "Chiedi **una videochiamata breve nella prima settimana**, prima di aver investito qualcosa. Tienila leggera: cinque minuti, solo per vedere con chi stai parlando. Una persona vera lo fa, oppure dice chiaramente perché non può e propone un altro momento. Un video dal vivo è difficile da falsificare in modo convincente, e chi lo evita quattro volte ti ha già risposto. E non mandare mai soldi a chi non hai incontrato." },
      { type: "p", text: "Una nota onesta sulle app, questa compresa. Su Qulo ognuno scrive le proprie domande e il match arriva solo se l'altro le indovina tutte — ma questo dimostra soltanto che ha letto il tuo profilo. **Qulo non verifica l'identità, non controlla le foto e non individua i profili falsi.** Chiedere quella videochiamata resta compito tuo." },
    ],
  },
  ja: {
    term: "なりすまし",
    summary:
      "他人の写真や偽の名前、つくり上げた経歴で別人を装うこと。相手は実在する人ではなく、つくられたキャラクターに心を寄せることになる。英語ではキャットフィッシングと呼ばれる。",
    blocks: [
      { type: "h2", text: "なぜ偽のプロフィールをつくるのか" },
      { type: "p", text: "この言葉は、実在しない女性に恋をした男性を追った2010年のドキュメンタリーから広まりました。あまりにも身に覚えのある状況だったから残ったのだと思います。動機は思われているより幅があります。お金目当ての詐欺もあれば、退屈しのぎもある。そして多くは、自分の顔や自分の生活が恥ずかしくて、もっと良さそうな誰かを借りてしまい、あとから降りる方法が見つからなくなった人です。" },
      { type: "p", text: "二つを分けて考えると分かりやすくなります。三年前の写真、少し盛った身長、切り下げた年齢。これは見栄で、程度の差はあれ誰もがやっています。なりすましは**種類がまったく違います**。相手は実在する人を良く見せた姿ではなく、最初から存在しない人です。" },
      { type: "h2", text: "見分け方" },
      { type: "ul", items: [
        "ビデオ通話がいつも無理。カメラが壊れた、電波が悪い、恥ずかしい — 頼むたびに理由が変わる。",
        "写真が少なく、妙に作り込まれていて日常の一枚がない。画像検索をすると同じ写真が別の場所で出てくる。",
        "細部がずれる。仕事、住んでいる街、きょうだいの名前が会話のたびに少しずつ変わる。",
        "感情の進み方が急で、そのあとお金の話が出てくる。急な事情、止まった送金、少しだけの立て替え。",
      ] },
      { type: "h2", accent: "green", text: "確かめる方法はひとつ" },
      { type: "p", text: "まだ気持ちを注ぎ込む前に、**最初の一週間のうちに短いビデオ通話**をお願いしてみてください。重くする必要はありません。五分だけ、誰と話しているのか見るためです。本当にいる人なら応じるか、できない理由を正直に話して別の時間を提案します。生の映像を自然に偽装するのは難しく、四回続けてかわす人はもう答えを出しています。会ったことのない相手にお金を送らないこと。" },
      { type: "p", text: "アプリについて正直に書いておきます。このアプリも例外ではありません。Quloでは各自が自分で質問を書き、全問正解した相手とだけマッチします。ただしそれは、相手があなたのプロフィールを読んだという証明にすぎません。**Quloは本人確認も写真の審査も偽アカウントの検知も行いません。** ビデオ通話を頼むのは、やはりあなた自身です。" },
    ],
  },
  ko: {
    term: "캣피싱",
    summary:
      "남의 사진과 가짜 이름, 지어낸 이력으로 다른 사람인 척하는 일. 상대는 실제 사람이 아니라 만들어진 인물에게 마음을 주게 된다.",
    blocks: [
      { type: "h2", text: "왜 가짜 프로필을 만들까" },
      { type: "p", text: "이 말은 존재하지 않는 여자에게 빠진 남자를 다룬 2010년 다큐멘터리에서 퍼졌습니다. 상황이 너무 낯익어서 그대로 남았습니다. 이유는 생각보다 다양합니다. 돈을 노린 사기도 있고, 그냥 심심해서인 경우도 있습니다. 많은 경우는 자기 얼굴이나 자기 삶이 부끄러워 더 그럴듯한 쪽을 빌려 쓰다가, 내려올 방법을 찾지 못한 사람들입니다." },
      { type: "p", text: "두 가지를 구분하면 이해가 쉬워집니다. 삼 년 전 사진, 몇 센티 올린 키, 조금 낮춘 나이. 이건 허영이고 정도의 차이만 있을 뿐 거의 모두가 합니다. 캣피싱은 **종류가 아예 다릅니다.** 상대는 실제 사람을 예쁘게 다듬은 모습이 아니라, 처음부터 없는 사람입니다." },
      { type: "h2", text: "이렇게 알아챕니다" },
      { type: "ul", items: [
        "영상통화가 늘 불가능합니다. 카메라 고장, 신호 불량, 부끄러움 — 물을 때마다 이유가 바뀝니다.",
        "사진이 몇 장뿐이고 이상하게 잘 꾸며져 있으며 일상적인 컷이 없습니다. 이미지 검색을 하면 다른 곳에서 같은 사진이 나옵니다.",
        "세부가 흔들립니다. 직업, 사는 도시, 형제의 이름이 대화마다 조금씩 달라집니다.",
        "감정이 빠르게 커지고 그다음 돈 이야기가 나옵니다. 급한 사정, 막힌 송금, 잠깐만 빌리는 돈.",
      ] },
      { type: "h2", accent: "green", text: "확인할 방법은 하나뿐" },
      { type: "p", text: "아직 마음을 크게 쏟기 전에, **첫 주 안에 짧은 영상통화**를 청해 보세요. 무겁게 만들 필요는 없습니다. 5분이면 됩니다. 누구와 이야기하고 있는지 보려는 것뿐이니까요. 실제로 존재하는 사람은 응하거나, 지금 어려운 이유를 솔직히 말하고 다른 시간을 제안합니다. 실시간 영상은 그럴듯하게 위조하기 어렵고, 네 번 피한 사람은 이미 답을 준 셈입니다. 만난 적 없는 사람에게 돈을 보내지 마세요." },
      { type: "p", text: "앱에 대해 솔직히 말하면 이 앱도 마찬가지입니다. Qulo에서는 각자 자기 질문을 쓰고 그걸 모두 맞힌 사람과만 매칭됩니다. 하지만 그건 상대가 당신의 프로필을 읽었다는 증거일 뿐입니다. **Qulo는 신원 확인도, 사진 심사도, 가짜 계정 탐지도 하지 않습니다.** 영상통화를 요청하는 일은 여전히 당신 몫입니다." },
    ],
  },
  zh: {
    term: "网络身份造假",
    summary:
      "用别人的照片、假名字和编造的经历冒充另一个人，让对面喜欢上的是一个被设计出来的角色，而不是真实存在的人；英文叫 catfishing。",
    blocks: [
      { type: "h2", text: "人为什么要弄一个假账号" },
      { type: "p", text: "这个说法来自 2010 年的一部纪录片：一个男人爱上了一个并不存在的女人。它留了下来，是因为这种处境太容易被认出来。背后的原因比想象中杂。有人是为了钱，从头到尾就是一场骗局；有人只是无聊。更多的人是对自己的长相或生活感到难堪，借了一副更体面的样子，后来就找不到台阶下了。" },
      { type: "p", text: "把两件事分开会清楚很多。三年前的照片、多报几厘米身高、年龄往下抹一点——那是虚荣，几乎每个人都做过某种版本。身份造假是**性质完全不同的一件事**：对面不是被美化过的某个人，而是压根不存在的人。" },
      { type: "h2", text: "怎么看出来" },
      { type: "ul", items: [
        "视频永远打不成：摄像头坏了、信号差、不好意思——每次的理由都不一样。",
        "照片很少，精修得反常，没有一张随手拍；用图片反向搜索，同样的照片出现在别处。",
        "细节会漂。工作、城市、兄弟姐妹的名字，在两次聊天之间悄悄变了。",
        "感情升温特别快，接着钱就出现了：一件急事、一笔卡住的转账、一笔说好很快还的借款。",
      ] },
      { type: "h2", accent: "green", text: "值得做的只有一件事" },
      { type: "p", text: "在还没投入太多之前，**第一周里约一次简短的视频通话**。别搞得很严肃：五分钟，就是看看在跟谁说话。真实的人会答应，或者坦率地说明现在为什么不方便，并另约时间。实时视频很难伪装得像样，连续躲四次的人其实已经回答了你。另外，不要给没见过面的人转钱。" },
      { type: "p", text: "关于交友软件说句实话，包括这一款。在 Qulo，每个人自己出题，只有全部答对才会配对——但那只能说明对方认真读了你的资料，仅此而已。**Qulo 不做身份验证，不审核照片，也不识别假账号。** 那通视频电话，还是得你自己开口约。" },
    ],
  },
  nl: {
    term: "Catfishing",
    summary:
      "Je online voordoen als iemand anders — met andermans foto's, een verzonnen naam en een verzonnen leven — zodat degene aan de andere kant valt voor een personage in plaats van voor een mens.",
    blocks: [
      { type: "h2", text: "Waarom iemand een nepprofiel maakt" },
      { type: "p", text: "Het woord komt uit een documentaire uit 2010 over een man die verliefd werd op een vrouw die niet bestond, en het bleef hangen omdat de situatie zo herkenbaar is. De redenen lopen verder uiteen dan je zou denken. Sommigen zetten een oplichting op en willen geld. Sommigen vervelen zich. Velen schamen zich gewoon voor hun eigen gezicht of hun eigen leven, lenen een mooier exemplaar en vinden daarna de weg terug niet meer." },
      { type: "p", text: "Het helpt om twee dingen te scheiden. Een foto van drie jaar geleden, een paar centimeter extra lengte, een leeftijd naar beneden afgerond: dat is ijdelheid, en bijna iedereen doet daar een versie van. Catfishing is **iets wezenlijk anders**: de persoon aan de andere kant is geen mooiere uitvoering van iemand, maar een verzinsel." },
      { type: "h2", text: "Hoe je het herkent" },
      { type: "ul", items: [
        "Videobellen kan altijd net niet: kapotte camera, slecht bereik, verlegenheid — elke keer een nieuwe reden.",
        "Weinig foto's, vreemd glad en nooit terloops; een omgekeerde afbeeldingszoekopdracht vindt ze ergens anders.",
        "Details schuiven. Het werk, de stad, de naam van een broer veranderen tussen twee gesprekken door.",
        "De gevoelens gaan snel, en dan komt geld in beeld: een noodgeval, een vastgelopen betaling, een kort voorschot.",
      ] },
      { type: "h2", accent: "green", text: "De ene controle die werkt" },
      { type: "p", text: "Vraag **in de eerste week om een kort videogesprek**, voordat je ergens in hebt geïnvesteerd. Houd het licht: vijf minuten, gewoon om te zien met wie je praat. Iemand die echt bestaat doet dat, of legt eerlijk uit waarom het nu niet lukt en stelt een ander moment voor. Live beeld is moeilijk overtuigend te vervalsen, en wie het vier keer ontwijkt heeft al geantwoord. En stuur nooit geld naar iemand die je nooit hebt ontmoet." },
      { type: "p", text: "Een eerlijke opmerking over apps, deze incluis. Op Qulo schrijft iedereen eigen vragen en ontstaat er alleen een match als de ander ze allemaal goed heeft — maar dat bewijst alleen dat iemand je profiel heeft gelezen. **Qulo controleert geen identiteit, keurt geen foto's en spoort geen nepprofielen op.** Om dat videogesprek moet je zelf vragen." },
    ],
  },
  pl: {
    term: "Catfishing",
    summary:
      "Podszywanie się w sieci pod kogoś innego — cudze zdjęcia, wymyślone imię, nieistniejące życie — tak że osoba po drugiej stronie przywiązuje się do postaci, a nie do prawdziwego człowieka.",
    blocks: [
      { type: "h2", text: "Dlaczego ktoś zakłada fałszywy profil" },
      { type: "p", text: "Słowo pochodzi z dokumentu z 2010 roku o mężczyźnie, który zakochał się w kobiecie nieistniejącej, i przyjęło się, bo ta sytuacja jest aż nadto rozpoznawalna. Powodów jest więcej, niż się wydaje. Ktoś prowadzi oszustwo i chce pieniędzy. Ktoś się nudzi. Wielu po prostu wstydzi się własnej twarzy albo własnego życia, pożycza ładniejsze i potem nie umie z niego zejść." },
      { type: "p", text: "Warto rozdzielić dwie rzeczy. Zdjęcie sprzed trzech lat, kilka centymetrów dodane do wzrostu, wiek zaokrąglony w dół — to próżność i prawie każdy robi jakąś jej wersję. Catfishing to **coś zupełnie innego**: osoba po drugiej stronie nie jest podkolorowaną wersją kogoś prawdziwego, tylko wymysłem." },
      { type: "h2", text: "Jak to rozpoznać" },
      { type: "ul", items: [
        "Rozmowa wideo zawsze jest niemożliwa: zepsuta kamera, słaby zasięg, nieśmiałość — za każdym razem inny powód.",
        "Zdjęć jest mało, są dziwnie dopracowane i nigdy zwyczajne; wyszukiwanie obrazem znajduje te same kadry gdzie indziej.",
        "Szczegóły się przesuwają. Praca, miasto, imię brata zmieniają się między rozmowami.",
        "Uczucia rosną błyskawicznie, a potem pojawiają się pieniądze: nagły wypadek, zablokowany przelew, krótka pożyczka.",
      ] },
      { type: "h2", accent: "green", text: "Jedno sprawdzenie, które działa" },
      { type: "p", text: "Poproś o **krótką rozmowę wideo w pierwszym tygodniu**, zanim cokolwiek w to włożysz. Bez ciężaru: pięć minut, żeby zobaczyć, z kim rozmawiasz. Ktoś prawdziwy się zgodzi albo powie wprost, dlaczego teraz nie może, i zaproponuje inny termin. Obraz na żywo trudno przekonująco podrobić, a kto unika go czwarty raz, już odpowiedział. I nigdy nie wysyłaj pieniędzy komuś, kogo nie spotkałeś." },
      { type: "p", text: "Uczciwa uwaga o aplikacjach, tej również. W Qulo każdy pisze własne pytania i dopasowanie następuje tylko wtedy, gdy ktoś odpowie poprawnie na wszystkie — ale to dowodzi jedynie, że przeczytał twój profil. **Qulo nie weryfikuje tożsamości, nie sprawdza zdjęć i nie wykrywa fałszywych kont.** O tę rozmowę wideo i tak musisz poprosić sam." },
    ],
  },
  sv: {
    term: "Catfishing",
    summary:
      "Att på nätet utge sig för att vara någon annan — med andras bilder, ett påhittat namn och ett påhittat liv — så att den du skriver med fäster sig vid en rollfigur i stället för vid en verklig människa.",
    blocks: [
      { type: "h2", text: "Varför någon skapar en falsk profil" },
      { type: "p", text: "Ordet kommer från en dokumentär från 2010 om en man som blev kär i en kvinna som inte fanns, och det stannade kvar eftersom situationen är så igenkännbar. Skälen är mer skiftande än man tror. Vissa driver ett bedrägeri och vill åt pengar. Vissa har tråkigt. Många skäms helt enkelt för sitt eget ansikte eller sitt eget liv, lånar ett bättre och hittar sedan ingen väg tillbaka." },
      { type: "p", text: "Det hjälper att skilja på två saker. Ett foto från tre år sedan, några centimeter extra längd, en ålder avrundad nedåt — det är fåfänga, och nästan alla gör någon version av det. Catfishing är **något helt annat i sak**: personen på andra sidan är ingen försköning av någon verklig, utan en uppfinning." },
      { type: "h2", text: "Så känner du igen det" },
      { type: "ul", items: [
        "Videosamtal går alltid precis inte: trasig kamera, dålig täckning, blyghet — ett nytt skäl varje gång.",
        "Få bilder, konstigt polerade och aldrig vardagliga; en omvänd bildsökning hittar samma bilder någon annanstans.",
        "Detaljerna glider. Jobbet, staden, en brors namn ändras tyst mellan samtalen.",
        "Känslorna går fort, och sedan dyker pengar upp: en akut situation, en betalning som fastnat, ett kort lån.",
      ] },
      { type: "h2", accent: "green", text: "Den enda kontroll som är värd något" },
      { type: "p", text: "Be om **ett kort videosamtal redan första veckan**, innan du hunnit investera något. Håll det lätt: fem minuter, bara för att se vem du pratar med. Någon som finns på riktigt gör det, eller säger rakt ut varför det inte går just nu och föreslår en annan tid. Direktsänd bild är svår att förfalska övertygande, och den som slingrar sig fjärde gången har redan svarat. Skicka aldrig pengar till någon du inte har träffat." },
      { type: "p", text: "En ärlig anmärkning om appar, den här inräknad. På Qulo skriver var och en egna frågor, och en matchning sker bara om den andra svarar rätt på alla — men det bevisar bara att någon har läst din profil. **Qulo verifierar inte identiteter, granskar inte bilder och upptäcker inte falska konton.** Videosamtalet måste du be om själv." },
    ],
  },
  hi: {
    term: "कैटफ़िशिंग",
    summary:
      "किसी और की तस्वीरों, नकली नाम और गढ़ी हुई ज़िंदगी के सहारे ऑनलाइन कोई और बनकर पेश आना, ताकि सामने वाला असली इंसान से नहीं, बनाए हुए किरदार से जुड़ जाए।",
    blocks: [
      { type: "h2", text: "लोग नकली प्रोफ़ाइल क्यों बनाते हैं" },
      { type: "p", text: "यह शब्द 2010 की एक डॉक्यूमेंट्री से आया, जिसमें एक आदमी को ऐसी औरत से प्यार हो जाता है जो थी ही नहीं। शब्द टिक गया क्योंकि यह हालत बहुत जानी-पहचानी लगती है। वजहें उम्मीद से ज़्यादा अलग-अलग होती हैं। कुछ लोग सीधे ठगी करते हैं और पैसा चाहते हैं। कुछ बस ऊब से करते हैं। बहुत से लोग अपने चेहरे या अपनी ज़िंदगी से शर्मिंदा होते हैं, कोई बेहतर वाली उधार ले लेते हैं और फिर वहाँ से उतरने का रास्ता नहीं मिलता।" },
      { type: "p", text: "दो चीज़ों को अलग रखना ज़रूरी है। तीन साल पुरानी तस्वीर, कद में जोड़े गए दो सेंटीमीटर, थोड़ी घटाई हुई उम्र — यह दिखावा है, और किसी न किसी रूप में लगभग सब करते हैं। कैटफ़िशिंग **बिल्कुल दूसरी किस्म की चीज़ है**: सामने वाला किसी असली इंसान का सजा-धजा रूप नहीं, पूरी तरह गढ़ा हुआ है।" },
      { type: "h2", text: "कैसे पहचानें" },
      { type: "ul", items: [
        "वीडियो कॉल हमेशा नामुमकिन: कैमरा ख़राब, नेटवर्क कमज़ोर, झिझक — हर बार नई वजह।",
        "तस्वीरें गिनी-चुनी, अजीब तरह से चमकाई हुई, कोई आम-सी नहीं; रिवर्स इमेज सर्च में वही तस्वीरें कहीं और मिल जाती हैं।",
        "ब्योरे खिसकते हैं। काम, शहर, भाई का नाम एक बातचीत से दूसरी में चुपचाप बदल जाता है।",
        "भावनाएँ तेज़ी से बढ़ती हैं और फिर पैसे की बात आती है: कोई इमरजेंसी, अटका हुआ पेमेंट, थोड़े दिन का उधार।",
      ] },
      { type: "h2", accent: "green", text: "एक ही जाँच काम की है" },
      { type: "p", text: "कुछ भी लगाने से पहले, **पहले हफ़्ते में एक छोटी वीडियो कॉल** माँग लीजिए। इसे भारी मत बनाइए: पाँच मिनट, बस यह देखने के लिए कि बात किससे हो रही है। असली इंसान या तो कर लेगा, या साफ़ बता देगा कि अभी क्यों नहीं हो सकता और दूसरा समय सुझाएगा। लाइव वीडियो को भरोसेमंद ढंग से नकली बनाना मुश्किल है, और जो चार बार टाल दे उसने जवाब दे ही दिया। और जिससे कभी मिले नहीं, उसे पैसे मत भेजिए।" },
      { type: "p", text: "ऐप्स के बारे में एक ईमानदार बात, इसमें यह ऐप भी शामिल है। Qulo पर हर कोई अपने सवाल लिखता है और मैच तभी होता है जब सामने वाला सब सही जवाब दे — पर इससे बस इतना साबित होता है कि उसने आपकी प्रोफ़ाइल पढ़ी। **Qulo पहचान की पुष्टि नहीं करता, तस्वीरें नहीं जाँचता और नकली अकाउंट नहीं पकड़ता।** वीडियो कॉल माँगना अब भी आपका काम है।" },
    ],
  },
};
