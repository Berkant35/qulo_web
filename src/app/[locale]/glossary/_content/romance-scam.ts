import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * SOURCE: the US Federal Trade Commission, verified directly at source rather
 * than through a summary.
 *
 * - Consumer advice page "What To Know About Romance Scams": the warning signs
 *   (cannot meet in person, requests for money, unusual payment methods) and
 *   the advice quoted here — never send money to someone you have not met, do a
 *   reverse image search, search the job title plus "scammer", report it.
 * - Press release, April 2026: "Nearly 60% of people who reported losing money
 *   to a romance scam in 2025 said it started on a social media platform."
 *
 * NOT USED: a "$298 million in romance scam losses originating on social media"
 * figure that circulates in summaries of that release. It is not in the release.
 * Checked, absent, dropped.
 *
 * NOT CLAIMED: that Qulo screens out impostors. Writing questions is not
 * identity verification and `glossary.ts` forbids implying it is. The page
 * carries no Qulo angle at all, because there is no honest one — the honest
 * observation is the opposite one, that this now begins mostly elsewhere.
 */
export const romanceScam: LocalizedGlossaryEntry = {
  en: {
    term: "Romance scam",
    summary:
      "A fraud in which someone builds a romantic relationship over weeks or months purely to ask for money — and where the relationship itself, not the request, is the part that was constructed.",
    blocks: [
      { type: "h2", text: "It usually does not start where people think" },
      { type: "p", text: "The picture most people carry is of a dating app. The reporting says otherwise: the US Federal Trade Commission found that **nearly 60% of people who reported losing money to a romance scam in 2025 said it started on a social media platform** — a message from a stranger on Instagram or Facebook, a follow, a comment answered. Dating apps are part of it, but the larger share now begins somewhere nobody is on guard, because nobody opens a social feed braced for a stranger's affection." },
      { type: "p", text: "The other thing worth unlearning is that the money comes early. It does not. Weeks of ordinary conversation come first — good morning messages, plans, the texture of a real relationship — and the request arrives only once refusing it would feel like abandoning someone. That is the design, not an accident of pacing. It is also why the usual advice to spot a scammer by their bad grammar is close to useless: by the time money is mentioned, months of writing have already read like a person." },

      { type: "h2", text: "How to recognise the pattern" },
      {
        type: "ul",
        items: [
          "Meeting in person never happens, and each excuse is structural: working offshore, deployed, stuck abroad on a contract.",
          "Video calls are deflected — a broken camera, bad signal — while messages continue without interruption.",
          "The first request is small and urgent: a medical bill, a customs fee, a plane ticket to finally visit you.",
          "Payment is asked for in a form that cannot be reversed: wire transfer, gift cards, a payment app, cryptocurrency.",
        ],
      },

      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "The FTC's advice is one sentence and it does the work of a whole checklist: never send money or gifts to a sweetheart you have not met in person. Around that, two searches cost nothing. Run their photos through a reverse image search — a stolen picture usually belongs to someone with a public account elsewhere. And search their job description together with the word scammer; the scripts are reused, and other people have written up the same story." },
      { type: "p", text: "If it has already happened, the useful thing is speed rather than shame. Stop contact, keep the messages and payment records, tell the bank or the payment service immediately, and report it — in the US at ReportFraud.ftc.gov, elsewhere to the national fraud line — and report the account on the platform where you met. Being deceived by a professional is not a failure of intelligence, and the people running this do it full time, to many people at once, from a script." },
    ],
  },
  tr: {
    term: "Aşk dolandırıcılığı",
    summary:
      "Birinin haftalar ya da aylar boyunca romantik bir ilişki kurup bunu yalnızca para istemek için yaptığı dolandırıcılık — ve kurgulanmış olan şey, istek değil ilişkinin kendisidir.",
    blocks: [
      { type: "h2", text: "Genelde sanıldığı yerde başlamıyor" },
      { type: "p", text: "Çoğu insanın kafasındaki tablo bir tanışma uygulaması. Veriler başka şey söylüyor: ABD Federal Ticaret Komisyonu'na göre **2025'te bir aşk dolandırıcılığında para kaybettiğini bildirenlerin yaklaşık %60'ı, işin bir sosyal medya platformunda başladığını söyledi** — Instagram ya da Facebook'tan gelen bir mesaj, bir takip, yanıtlanan bir yorum. Tanışma uygulamaları da bunun parçası, ama büyük pay artık kimsenin tetikte olmadığı bir yerde başlıyor; çünkü kimse sosyal medyayı bir yabancının ilgisine karşı hazırlıklı açmıyor." },
      { type: "p", text: "Unutulması gereken ikinci şey, paranın erken istendiği. İstenmiyor. Önce haftalarca sıradan bir sohbet geliyor — günaydın mesajları, planlar, gerçek bir ilişkinin dokusu — ve istek ancak reddetmenin birini yüzüstü bırakmak gibi hissettireceği noktada geliyor. Bu, temponun tesadüfü değil, tasarımın kendisi. Dolandırıcıyı bozuk gramerinden tanıma tavsiyesinin neredeyse işe yaramamasının sebebi de bu: paradan söz edildiğinde, aylardır süren bir yazışma çoktan bir insan gibi okunmuş oluyor." },

      { type: "h2", text: "Örüntüyü nasıl tanırsın" },
      {
        type: "ul",
        items: [
          "Yüz yüze buluşma hiç gerçekleşmiyor ve her mazeret yapısal: denizde çalışıyor, görevde, yurtdışında sözleşmeye takılmış.",
          "Görüntülü konuşma savuşturuluyor — kamera bozuk, çekmiyor — ama mesajlaşma hiç aksamıyor.",
          "İlk istek küçük ve acil: bir hastane faturası, bir gümrük ücreti, seni görmeye gelmek için bir uçak bileti.",
          "Ödeme geri alınamayacak bir biçimde isteniyor: havale, hediye kartı, bir ödeme uygulaması, kripto para.",
        ],
      },

      { type: "h2", accent: "green", text: "Ne yapmalı" },
      { type: "p", text: "FTC'nin tavsiyesi tek cümle ve koca bir kontrol listesinin işini görüyor: yüz yüze hiç görüşmediğin bir sevgiliye asla para ya da hediye gönderme. Bunun etrafında iki arama da bedava. Fotoğraflarını ters görsel aramadan geçir — çalınmış bir fotoğraf genelde başka bir yerde açık hesabı olan birine aittir. Bir de mesleğini scammer kelimesiyle birlikte arat; senaryolar yeniden kullanılıyor ve aynı hikâyeyi yazmış başkaları oluyor." },
      { type: "p", text: "Olan olduysa işe yarayan şey utanç değil hız. Teması kes, mesajları ve ödeme kayıtlarını sakla, bankaya ya da ödeme servisine hemen haber ver ve bildir — ABD'de ReportFraud.ftc.gov, başka yerlerde ulusal dolandırıcılık hattı — ayrıca tanıştığınız platformda hesabı şikâyet et. Profesyonel biri tarafından kandırılmak bir zekâ eksikliği değil; bu işi yapanlar tam zamanlı yapıyor, aynı anda pek çok kişiye, ellerindeki senaryodan." },
    ],
  },
  de: {
    term: "Romance Scam",
    summary:
      "Ein Betrug, bei dem jemand über Wochen oder Monate eine Liebesbeziehung aufbaut, nur um am Ende um Geld zu bitten — konstruiert ist dabei nicht die Bitte, sondern die Beziehung selbst. Im Deutschen auch Liebesbetrug genannt.",
    blocks: [
      { type: "h2", text: "Es fängt meistens nicht dort an, wo man denkt" },
      { type: "p", text: "Das Bild, das die meisten im Kopf haben, ist eine Dating-App. Die Zahlen sagen etwas anderes: Die US-amerikanische Federal Trade Commission (FTC) stellte fest, dass **fast 60 % der Menschen, die 2025 einen Geldverlust durch einen Romance Scam meldeten, angaben, es habe auf einer Social-Media-Plattform angefangen** — eine Nachricht von einer fremden Person auf Instagram oder Facebook, ein Follow, ein beantworteter Kommentar. Dating-Apps gehören dazu, aber der größere Teil beginnt inzwischen dort, wo niemand auf der Hut ist, weil niemand seinen Social-Media-Feed öffnet und dabei mit der Zuneigung einer fremden Person rechnet." },
      { type: "p", text: "Das Zweite, was man verlernen sollte, ist die Vorstellung, dass das Geld früh ins Spiel kommt. Kommt es nicht. Zuerst kommen Wochen ganz gewöhnlicher Gespräche — Guten-Morgen-Nachrichten, Pläne, die Textur einer echten Beziehung — und die Bitte kommt erst, wenn ein Nein sich anfühlen würde, als ließe man jemanden im Stich. Das ist die Konstruktion und kein Zufall des Tempos. Es ist auch der Grund, warum der übliche Rat, man erkenne Betrüger an ihrer schlechten Grammatik, kaum etwas taugt: Wenn Geld zur Sprache kommt, haben sich Monate des Schreibens längst wie ein Mensch gelesen." },
      { type: "h2", text: "Woran du das Muster erkennst" },
      {
        type: "ul",
        items: [
          "Ein Treffen kommt nie zustande, und jede Ausrede ist strukturell: Arbeit auf einer Bohrinsel, im Auslandseinsatz, wegen eines Auftrags im Ausland festsitzend.",
          "Videoanrufe werden abgewehrt — kaputte Kamera, schlechtes Netz — während die Nachrichten ohne Unterbrechung weiterlaufen.",
          "Die erste Bitte ist klein und dringend: eine Arztrechnung, eine Zollgebühr, ein Flugticket, um dich endlich zu besuchen.",
          "Bezahlt werden soll auf einem Weg, der sich nicht zurückholen lässt: Überweisung, Geschenkkarten, eine Bezahl-App, Kryptowährung.",
        ],
      },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Der Rat der FTC ist ein einziger Satz und ersetzt eine ganze Checkliste: Schick niemals Geld oder Geschenke an jemanden, in den du verliebt bist und den du nie persönlich getroffen hast. Darum herum kosten zwei Suchen nichts. Lass die Fotos durch eine umgekehrte Bildersuche laufen — ein gestohlenes Bild gehört meistens zu jemandem mit einem öffentlichen Konto anderswo. Und such nach der Berufsbezeichnung zusammen mit dem Wort scammer; die Skripte werden wiederverwendet, und andere haben dieselbe Geschichte längst aufgeschrieben." },
      { type: "p", text: "Wenn es schon passiert ist, hilft Tempo mehr als Scham. Brich den Kontakt ab, sichere die Nachrichten und die Zahlungsbelege, informiere sofort die Bank oder den Zahlungsdienst und melde es — in den USA über ReportFraud.ftc.gov, anderswo bei der nationalen Betrugsmeldestelle — und melde das Konto auf der Plattform, auf der ihr euch kennengelernt habt. Von Profis getäuscht zu werden ist kein Mangel an Intelligenz; die Leute, die das betreiben, tun es hauptberuflich, bei vielen Menschen gleichzeitig, nach einem Skript." },
    ],
  },
  fr: {
    term: "Arnaque sentimentale",
    summary:
      "Une escroquerie où quelqu’un construit une relation amoureuse pendant des semaines ou des mois dans le seul but de demander de l’argent — et où ce qui a été fabriqué n’est pas la demande, mais la relation elle-même.",
    blocks: [
      { type: "h2", text: "Cela ne commence pas là où on l’imagine" },
      { type: "p", text: "L’image que la plupart des gens ont en tête, c’est une application de rencontre. Les données disent autre chose : la Federal Trade Commission américaine (FTC) a constaté que **près de 60 % des personnes ayant déclaré avoir perdu de l’argent dans une arnaque sentimentale en 2025 ont dit que tout avait commencé sur une plateforme de réseau social** — un message d’un inconnu sur Instagram ou Facebook, un abonnement, un commentaire auquel on répond. Les applications de rencontre en font partie, mais la plus grande part commence désormais là où personne n’est sur ses gardes, parce que personne n’ouvre son fil d’actualité en s’attendant à l’affection d’un inconnu." },
      { type: "p", text: "L’autre chose à désapprendre, c’est que l’argent arriverait tôt. Il n’arrive pas tôt. Viennent d’abord des semaines de conversation ordinaire — les messages du matin, des projets, la texture d’une vraie relation — et la demande n’arrive qu’au moment où refuser donnerait l’impression d’abandonner quelqu’un. C’est le dispositif, pas un hasard de rythme. C’est aussi pourquoi le conseil habituel, repérer un escroc à ses fautes de grammaire, ne sert presque à rien : quand l’argent est enfin évoqué, des mois d’écriture se sont déjà lus comme une personne." },
      { type: "h2", text: "Comment reconnaître ce schéma" },
      {
        type: "ul",
        items: [
          "La rencontre en vrai n’a jamais lieu, et chaque excuse est structurelle : travail en mer, en mission à l’étranger, bloqué ailleurs par un contrat.",
          "Les appels vidéo sont esquivés — caméra cassée, mauvaise connexion — alors que les messages, eux, ne s’interrompent jamais.",
          "La première demande est petite et urgente : une facture médicale, des frais de douane, un billet d’avion pour venir enfin vous voir.",
          "Le paiement est réclamé sous une forme irréversible : virement, cartes cadeaux, une application de paiement, cryptomonnaie.",
        ],
      },
      { type: "h2", accent: "green", text: "Que faire" },
      { type: "p", text: "Le conseil de la FTC tient en une phrase et fait le travail de toute une check-list : n’envoyez jamais d’argent ni de cadeaux à quelqu’un dont vous êtes amoureux et que vous n’avez jamais rencontré en personne. Autour de cela, deux recherches ne coûtent rien. Passez ses photos dans une recherche d’image inversée — une photo volée appartient le plus souvent à quelqu’un qui a un compte public ailleurs. Et cherchez son métier accompagné du mot « scammer » ; les scénarios sont réutilisés, et d’autres ont déjà raconté la même histoire." },
      { type: "p", text: "Si c’est déjà arrivé, ce qui aide, c’est la vitesse, pas la honte. Coupez le contact, gardez les messages et les preuves de paiement, prévenez immédiatement la banque ou le service de paiement, et signalez — aux États-Unis sur ReportFraud.ftc.gov, ailleurs auprès du service national de signalement des fraudes — puis signalez le compte sur la plateforme où vous vous êtes rencontrés. Se faire tromper par un professionnel n’est pas un manque d’intelligence : les gens qui font cela le font à plein temps, auprès de beaucoup de personnes à la fois, à partir d’un script." },
    ],
  },
  es: {
    term: "Estafa romántica",
    summary:
      "Un fraude en el que alguien construye una relación amorosa durante semanas o meses con el único fin de pedir dinero — y donde lo construido no es la petición, sino la relación misma.",
    blocks: [
      { type: "h2", text: "Casi nunca empieza donde la gente cree" },
      { type: "p", text: "La imagen que casi todo el mundo tiene en la cabeza es una aplicación de citas. Los datos dicen otra cosa: la Comisión Federal de Comercio de Estados Unidos (FTC) encontró que **cerca del 60 % de las personas que denunciaron haber perdido dinero en una estafa romántica en 2025 dijeron que todo empezó en una plataforma de redes sociales** — un mensaje de un desconocido en Instagram o Facebook, un seguimiento, un comentario respondido. Las aplicaciones de citas también forman parte, pero la mayor parte empieza ahora donde nadie está en guardia, porque nadie abre sus redes preparado para el afecto de un extraño." },
      { type: "p", text: "Lo otro que conviene desaprender es que el dinero llega pronto. No llega. Primero vienen semanas de conversación corriente — mensajes de buenos días, planes, la textura de una relación de verdad — y la petición solo aparece cuando negarse se sentiría como abandonar a alguien. Eso es el diseño, no una casualidad del ritmo. Es también la razón por la que el consejo habitual de reconocer a un estafador por su mala gramática no sirve casi de nada: cuando por fin se menciona el dinero, meses de mensajes ya se han leído como una persona." },
      { type: "h2", text: "Cómo reconocer el patrón" },
      {
        type: "ul",
        items: [
          "El encuentro en persona nunca ocurre, y cada excusa es estructural: trabaja en alta mar, está destinado fuera, atrapado en el extranjero por un contrato.",
          "Las videollamadas se esquivan — cámara rota, mala cobertura — mientras los mensajes siguen sin interrupción.",
          "La primera petición es pequeña y urgente: una factura médica, una tasa de aduana, un billete de avión para ir por fin a verte.",
          "El pago se pide de una forma que no se puede revertir: transferencia, tarjetas regalo, una aplicación de pagos, criptomonedas.",
        ],
      },
      { type: "h2", accent: "green", text: "¿Qué hacer?" },
      { type: "p", text: "El consejo de la FTC cabe en una frase y hace el trabajo de una lista entera: nunca envíes dinero ni regalos a alguien de quien te has enamorado y a quien no has visto nunca en persona. Alrededor de eso, dos búsquedas no cuestan nada. Pasa sus fotos por una búsqueda inversa de imágenes — una foto robada suele pertenecer a alguien con una cuenta pública en otro sitio. Y busca su profesión junto con la palabra scammer; los guiones se reutilizan, y otras personas ya han contado la misma historia." },
      { type: "p", text: "Si ya ha pasado, lo que sirve es la rapidez, no la vergüenza. Corta el contacto, guarda los mensajes y los comprobantes de pago, avisa de inmediato al banco o al servicio de pago y denúncialo — en Estados Unidos en ReportFraud.ftc.gov, en otros países ante la línea nacional de fraude — y denuncia la cuenta en la plataforma donde conociste a esa persona. Que te engañe un profesional no es falta de inteligencia; quienes se dedican a esto lo hacen a tiempo completo, con muchas personas a la vez y siguiendo un guion." },
    ],
  },
  ar: {
    term: "الاحتيال العاطفي",
    summary:
      "احتيال يبني فيه شخص علاقة عاطفية على مدى أسابيع أو شهور لغرض واحد هو طلب المال؛ والمُصطنَع فيه ليس الطلب، بل العلاقة نفسها.",
    blocks: [
      { type: "h2", text: "غالبًا لا يبدأ من حيث يظنّ الناس" },
      { type: "p", text: "الصورة التي يحملها معظم الناس هي تطبيق مواعدة. لكنّ البلاغات تقول غير ذلك: وجدت لجنة التجارة الفدرالية الأمريكية (FTC) أنّ **نحو 60% ممّن أبلغوا عن خسارة أموال في احتيال عاطفي خلال عام 2025 قالوا إنّ الأمر بدأ على منصّة تواصل اجتماعي**، رسالة من غريب على إنستغرام أو فيسبوك، متابعة جديدة، تعليق جرى الردّ عليه. تطبيقات المواعدة جزء من الصورة، لكنّ الحصّة الأكبر صارت تبدأ في مكان لا يكون فيه أحد على حذر، لأنّ أحدًا لا يفتح صفحته على وسائل التواصل وهو متحسّب لاهتمام عاطفي من غريب." },
      { type: "p", text: "والأمر الآخر الذي يستحقّ التصحيح هو الاعتقاد بأنّ طلب المال يأتي مبكرًا. إنّه لا يأتي مبكرًا. تسبقه أسابيع من حديث عاديّ تمامًا: رسائل صباح الخير، خطط لقادم الأيام، نسيج علاقة حقيقية؛ ثمّ يصل الطلب في اللحظة التي يصبح فيها الرفض شعورًا بأنّك تتخلّى عن أحدهم. هذا هو التصميم، لا مصادفة في الإيقاع. وهو أيضًا سبب أنّ النصيحة الشائعة بكشف المحتال من ركاكة لغته لا تكاد تنفع: فحين يُذكر المال، تكون شهور من الكتابة قد قُرئت بالفعل كما يُقرأ إنسان حقيقي." },
      { type: "h2", text: "كيف تتعرّف على هذا النمط" },
      {
        type: "ul",
        items: [
          "اللقاء المباشر لا يحدث أبدًا، وكلّ عذر بنيويّ: العمل في عرض البحر، مهمّة عسكرية، عقد يحتجزه في الخارج.",
          "المكالمات المرئية تُؤجَّل دائمًا: كاميرا معطّلة، شبكة ضعيفة، بينما الرسائل لا تنقطع لحظة.",
          "الطلب الأول صغير وعاجل: فاتورة علاج، رسوم جمركية، تذكرة طائرة ليأتي إليك أخيرًا.",
          "يُطلب الدفع بصيغة لا يمكن التراجع عنها: حوالة بنكية، بطاقات هدايا، تطبيق دفع، عملات مشفّرة.",
        ],
      },
      { type: "h2", accent: "green", text: "ماذا يمكنك أن تفعل" },
      { type: "p", text: "نصيحة اللجنة جملة واحدة تؤدّي عمل قائمة كاملة: لا ترسل مالًا أو هدايا أبدًا إلى حبيب لم تلتقِ به وجهًا لوجه. وحول هذه الجملة هناك بحثان لا يكلّفان شيئًا. مرّر صوره في بحث عكسي بالصورة، فالصورة المسروقة تعود عادةً إلى شخص له حساب عامّ في مكان آخر. وابحث عن وصف عمله مقرونًا بكلمة scammer؛ فالسيناريوهات يُعاد استخدامها، وغيرك كتب القصّة نفسها من قبل." },
      { type: "p", text: "وإن كان الأمر قد وقع فعلًا، فالمفيد هو السرعة لا الخجل. اقطع التواصل، واحتفظ بالرسائل وسجلّات الدفع، وأبلغ بنكك أو خدمة الدفع فورًا، ثمّ قدّم بلاغًا: في الولايات المتحدة عبر ReportFraud.ftc.gov، وفي غيرها لدى الجهة الوطنية المختصّة بالإبلاغ عن الاحتيال. وأبلغ أيضًا عن الحساب على المنصّة التي التقيتما فيها. أن يخدعك محترف ليس نقصًا في الذكاء؛ فمن يديرون هذا يفعلونه بدوام كامل، مع أشخاص كثيرين في الوقت نفسه، انطلاقًا من نصّ جاهز." },
    ],
  },
  ru: {
    term: "Романтическая афера",
    summary:
      "Мошенничество, в котором человек неделями или месяцами выстраивает романтические отношения исключительно ради того, чтобы попросить денег, — и сконструированы здесь сами отношения, а не просьба.",
    blocks: [
      { type: "h2", text: "Обычно это начинается не там, где принято думать" },
      { type: "p", text: "Картинка, которая есть у большинства, — приложение для знакомств. Обращения говорят другое: американская Федеральная торговая комиссия (FTC) выяснила, что **почти 60% тех, кто сообщил о потере денег в романтической афере в 2025 году, сказали, что всё началось на площадке в социальных сетях** — сообщение от незнакомого человека в Instagram или Facebook, подписка, ответ на комментарий. Приложения для знакомств — часть этой картины, но большая доля теперь начинается там, где никто не насторожён: ленту соцсетей никто не открывает, готовясь к нежности от незнакомца." },
      { type: "p", text: "Второе, от чего стоит отучиться, — мысль, что деньги просят рано. Не просят. Сначала идут недели самого обычного общения — сообщения с добрым утром, планы, ткань настоящих отношений, — и просьба появляется только тогда, когда отказать значило бы бросить человека. Это устройство схемы, а не случайность темпа. Поэтому же почти бесполезен совет узнавать мошенника по корявому языку: к моменту, когда речь заходит о деньгах, месяцы переписки уже читаются как живой человек." },
      { type: "h2", text: "Как распознать этот рисунок" },
      {
        type: "ul",
        items: [
          "Встреча вживую так и не случается, и каждая отговорка встроена в обстоятельства: работа в море, служба в командировке, контракт, из-за которого не выбраться из другой страны.",
          "Видеозвонки уходят в сторону — сломанная камера, плохая связь, — а переписка при этом не прерывается ни на день.",
          "Первая просьба маленькая и срочная: счёт за лечение, таможенный сбор, билет на самолёт, чтобы наконец приехать к вам.",
          "Оплату просят в форме, которую нельзя отменить: банковский перевод, подарочные карты, платёжное приложение, криптовалюта.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Совет FTC умещается в одно предложение и заменяет целый чек-лист: никогда не отправляйте деньги или подарки тому, с кем ни разу не виделись вживую. Вокруг этого есть два бесплатных действия. Прогоните фотографии через обратный поиск по изображению — украденный снимок обычно принадлежит человеку с открытым аккаунтом где-то ещё. И поищите описание его профессии вместе со словом scammer: сценарии используют повторно, и другие люди уже описали ровно ту же историю." },
      { type: "p", text: "Если это уже произошло, помогает скорость, а не стыд. Прекратите общение, сохраните переписку и подтверждения платежей, сразу сообщите банку или платёжному сервису и подайте заявление — в США на ReportFraud.ftc.gov, в других странах на национальную линию для сообщений о мошенничестве, — а ещё пожалуйтесь на аккаунт на той площадке, где вы познакомились. Дать себя обмануть профессионалу — не признак недостатка ума: те, кто этим занимается, делают это на полной занятости, сразу со многими людьми, по готовому сценарию." },
    ],
  },
  pt: {
    term: "Golpe do amor",
    summary:
      "Uma fraude em que alguém constrói uma relação amorosa ao longo de semanas ou meses só para pedir dinheiro — e em que a parte construída não é o pedido, mas a própria relação.",
    blocks: [
      { type: "h2", text: "Em geral não começa onde as pessoas imaginam" },
      { type: "p", text: "A imagem que quase todo mundo tem é a de um aplicativo de relacionamento. Os dados dizem outra coisa: a Comissão Federal de Comércio dos Estados Unidos (FTC) constatou que **quase 60% das pessoas que relataram ter perdido dinheiro em um golpe do amor em 2025 disseram que tudo tinha começado em uma plataforma de rede social** — uma mensagem de um desconhecido no Instagram ou no Facebook, um seguidor novo, um comentário respondido. Os aplicativos de relacionamento fazem parte disso, mas a maior fatia hoje começa em um lugar onde ninguém está de guarda alta, porque ninguém abre uma rede social preparado para o afeto de um estranho." },
      { type: "p", text: "A outra coisa que vale desaprender é que o dinheiro aparece cedo. Não aparece. Primeiro vêm semanas de conversa comum — mensagens de bom dia, planos, a textura de uma relação de verdade — e o pedido só chega quando recusar já pareceria abandonar alguém. Isso é o projeto, não um acaso de ritmo. É também por isso que o conselho de sempre, o de identificar o golpista pela gramática ruim, não serve para quase nada: quando o dinheiro entra na conversa, meses de mensagens já foram lidos como uma pessoa." },
      { type: "h2", text: "Como reconhecer o padrão" },
      {
        type: "ul",
        items: [
          "O encontro presencial nunca acontece, e as explicações têm sempre a mesma estrutura: trabalha embarcado, está em missão, ficou preso no exterior por causa de um contrato.",
          "As chamadas de vídeo são desviadas — câmera quebrada, sinal ruim — enquanto as mensagens seguem sem nenhuma interrupção.",
          "O primeiro pedido é pequeno e urgente: uma conta de hospital, uma taxa alfandegária, uma passagem de avião para finalmente visitar você.",
          "O pagamento é pedido em um formato que não dá para reverter: transferência, cartões-presente, um aplicativo de pagamento, criptomoeda.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer" },
      { type: "p", text: "O conselho da FTC cabe em uma frase e faz o trabalho de uma lista inteira: nunca envie dinheiro nem presentes para um amor que você não encontrou pessoalmente. Em volta disso, duas buscas não custam nada. Passe as fotos por uma busca reversa de imagens — uma foto roubada costuma pertencer a alguém que tem um perfil público em outro lugar. E pesquise a profissão que a pessoa diz ter junto com a palavra scammer; os roteiros são reaproveitados, e outras pessoas já escreveram a mesma história." },
      { type: "p", text: "Se já aconteceu, o que ajuda é a pressa, não a vergonha. Corte o contato, guarde as mensagens e os comprovantes de pagamento, avise o banco ou o serviço de pagamento na hora e faça a denúncia — nos Estados Unidos em ReportFraud.ftc.gov, em outros lugares no canal nacional de denúncia de fraudes — e denuncie a conta na plataforma onde vocês se conheceram. Ser enganado por um profissional não é falta de inteligência: quem faz isso trabalha em tempo integral, com muitas pessoas ao mesmo tempo, seguindo um roteiro." },
    ],
  },
  it: {
    term: "Truffa romantica",
    summary:
      "Una truffa in cui qualcuno costruisce una relazione sentimentale nel giro di settimane o mesi con l’unico scopo di chiedere denaro — e in cui la parte costruita non è la richiesta, ma la relazione stessa.",
    blocks: [
      { type: "h2", text: "Di solito non comincia dove la gente pensa" },
      { type: "p", text: "L’immagine che quasi tutti hanno in mente è quella di un’app di incontri. I dati dicono altro: la Federal Trade Commission degli Stati Uniti (FTC) ha rilevato che **quasi il 60% delle persone che nel 2025 hanno dichiarato di aver perso denaro in una truffa romantica ha detto che tutto era cominciato su una piattaforma di social media** — un messaggio da uno sconosciuto su Instagram o Facebook, un follow, un commento a cui si è risposto. Le app di incontri fanno parte del quadro, ma la quota più grande ormai comincia in un posto dove nessuno sta in guardia, perché nessuno apre un social preparandosi all’affetto di un estraneo." },
      { type: "p", text: "L’altra cosa da disimparare è che i soldi arrivino subito. Non arrivano. Prima vengono settimane di conversazione ordinaria — messaggi del buongiorno, progetti, la trama di una relazione vera — e la richiesta arriva soltanto quando rifiutare sembrerebbe abbandonare qualcuno. È il progetto, non un caso di ritmo. È anche il motivo per cui il consiglio di sempre, riconoscere il truffatore dalla grammatica sgangherata, non serve quasi a niente: quando si arriva a parlare di soldi, mesi di messaggi si sono già letti come una persona." },
      { type: "h2", text: "Come riconoscere lo schema" },
      {
        type: "ul",
        items: [
          "L’incontro di persona non avviene mai, e ogni scusa è strutturale: lavora su una piattaforma in mare, è in missione, è bloccato all’estero per un contratto.",
          "Le videochiamate vengono schivate — telecamera rotta, segnale pessimo — mentre i messaggi non si interrompono mai.",
          "La prima richiesta è piccola e urgente: una spesa medica, una tassa doganale, un biglietto aereo per venire finalmente da te.",
          "Il pagamento viene chiesto in una forma che non si può annullare: bonifico, carte regalo, un’app di pagamento, criptovalute.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa fare" },
      { type: "p", text: "Il consiglio della FTC sta in una frase e fa il lavoro di un’intera lista di controllo: non mandare mai denaro o regali a una persona di cui ti sei innamorato ma che non hai mai incontrato di persona. Intorno a questo, due ricerche non costano nulla. Passa le sue foto in una ricerca inversa per immagini — una foto rubata di solito appartiene a qualcuno che altrove ha un profilo pubblico. E cerca la professione che dice di fare insieme alla parola scammer; i copioni vengono riciclati, e altre persone hanno già raccontato la stessa storia." },
      { type: "p", text: "Se è già successo, quello che serve è la rapidità, non la vergogna. Interrompi i contatti, conserva i messaggi e le ricevute dei pagamenti, avvisa subito la banca o il servizio di pagamento e fai una segnalazione — negli Stati Uniti su ReportFraud.ftc.gov, altrove al servizio nazionale contro le truffe — e segnala l’account sulla piattaforma dove vi siete conosciuti. Essere ingannati da un professionista non è una mancanza di intelligenza: chi fa questo lavoro lo fa a tempo pieno, su molte persone insieme, seguendo un copione." },
    ],
  },
  ja: {
    term: "ロマンス詐欺",
    summary:
      "何週間も何か月もかけて恋愛関係を築き、その関係をひとえに金銭を求めるために使う詐欺のことで、作り物なのは頼みごとのほうではなく関係そのものです。",
    blocks: [
      { type: "h2", text: "多くの人が思っている場所からは始まらない" },
      { type: "p", text: "多くの人が思い浮かべるのはマッチングアプリです。しかし届いている報告は違うことを示しています。米国の連邦取引委員会（FTC）によれば、**2025年にロマンス詐欺で金銭を失ったと報告した人のうち、およそ60%が、きっかけはソーシャルメディア上だったと答えています**。InstagramやFacebookで見知らぬ人から届いた一通のメッセージ、フォロー、返事をした一つのコメント。マッチングアプリもその一部ではありますが、いまは誰も身構えていない場所から始まる割合のほうが大きくなっています。ソーシャルメディアを開くときに、見知らぬ人からの好意に備えている人はいないからです。" },
      { type: "p", text: "もう一つ手放したほうがいいのは、お金の話が早い段階で出てくるという思い込みです。実際には早く出てきません。まずは何週間もの普通のやりとりが続きます。おはようのメッセージ、これからの予定、本物の関係の手触り。そして頼みごとが届くのは、断ることが誰かを見捨てるように感じられるところまで来たあとです。これはテンポの偶然ではなく、設計です。文法のおかしさで詐欺師を見抜けという定番の助言がほとんど役に立たないのも、そのためです。お金の話が出るころには、何か月分もの文章がすでに一人の人間として読まれてしまっています。" },
      { type: "h2", text: "パターンの見分け方" },
      {
        type: "ul",
        items: [
          "直接会うことが一度も実現せず、その理由はいつも構造的です。船の上で働いている、任地にいる、契約で海外から動けない。",
          "ビデオ通話はいつもかわされます。カメラが壊れている、電波が悪い。それでもメッセージだけは途切れません。",
          "最初の頼みごとは小さくて急ぎます。医療費、通関の手数料、ようやく会いに行くための航空券。",
          "支払いは取り消せない方法で求められます。銀行送金、ギフトカード、送金アプリ、暗号資産。",
        ],
      },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "FTCの助言は一文で、それだけでチェックリスト一枚分の働きをします。直接会ったことのない相手には、お金も贈り物も決して送らないこと。そのまわりに、費用のかからない検索が二つあります。相手の写真を画像検索にかけてみてください。盗まれた写真は、たいてい別の場所で公開アカウントを持っている人のものです。もう一つは、相手の職業の説明に scammer という語を足して検索することです。台本は使い回されていて、同じ話をすでに書き残している人がいます。" },
      { type: "p", text: "すでに起きてしまったなら、役に立つのは恥ずかしさではなく速さです。連絡を断ち、メッセージと支払いの記録を残し、銀行か決済サービスにすぐ知らせてください。そのうえで通報します。米国なら ReportFraud.ftc.gov、それ以外の国ではその国の詐欺通報窓口へ。出会ったプラットフォームでも、そのアカウントを報告してください。プロにだまされることは知能の欠如ではありません。これを回している側は、それを本業として、多くの人を同時に相手にしながら、手元の台本どおりに進めています。" },
    ],
  },
  ko: {
    term: "로맨스 스캠",
    summary:
      "몇 주에서 몇 달에 걸쳐 연애 관계를 쌓아 올린 뒤 오직 돈을 요구하기 위해 그 관계를 쓰는 사기이며, 지어낸 쪽은 그 부탁이 아니라 관계 자체입니다.",
    blocks: [
      { type: "h2", text: "대개 사람들이 생각하는 곳에서 시작되지 않습니다" },
      { type: "p", text: "많은 사람이 떠올리는 그림은 데이팅 앱입니다. 그런데 신고된 내용은 다른 이야기를 합니다. 미국 연방거래위원회(FTC)에 따르면 **2025년에 로맨스 스캠으로 돈을 잃었다고 신고한 사람의 약 60%가 그 일이 소셜미디어 플랫폼에서 시작됐다고 답했습니다**. 인스타그램이나 페이스북으로 모르는 사람에게서 온 메시지 한 통, 팔로우 하나, 답을 단 댓글 하나. 데이팅 앱도 그중 일부지만, 이제 더 큰 몫은 아무도 경계하지 않는 자리에서 시작됩니다. 소셜미디어를 열면서 낯선 사람의 호의에 대비하는 사람은 없기 때문입니다." },
      { type: "p", text: "또 하나 내려놓아야 할 생각은 돈 이야기가 일찍 나온다는 것입니다. 일찍 나오지 않습니다. 먼저 몇 주 동안 평범한 대화가 쌓입니다. 아침 인사, 앞으로의 계획, 진짜 관계가 가지는 결. 그리고 부탁은 거절하는 일이 누군가를 저버리는 것처럼 느껴지는 지점에 이르러서야 도착합니다. 이건 속도의 우연이 아니라 설계입니다. 어색한 문장으로 사기꾼을 알아보라는 흔한 조언이 거의 쓸모없는 이유도 여기에 있습니다. 돈 이야기가 나올 무렵이면 몇 달치 글이 이미 한 사람처럼 읽힌 뒤이기 때문입니다." },
      { type: "h2", text: "이 패턴을 알아보는 법" },
      {
        type: "ul",
        items: [
          "직접 만나는 일이 끝내 일어나지 않고, 이유는 늘 구조적입니다. 원양에서 일한다, 파병 중이다, 해외 계약에 묶여 있다.",
          "영상통화는 계속 미뤄집니다. 카메라가 고장 났다, 신호가 나쁘다. 그런데 메시지는 한 번도 끊기지 않습니다.",
          "첫 부탁은 작고 급합니다. 병원비, 통관 수수료, 드디어 만나러 갈 비행기표.",
          "돈은 되돌릴 수 없는 방식으로 요구됩니다. 계좌 이체, 상품권, 송금 앱, 가상자산.",
        ],
      },
      { type: "h2", accent: "green", text: "무엇을 하면 좋을까" },
      { type: "p", text: "FTC의 조언은 한 문장인데, 그 한 문장이 긴 점검표만큼의 일을 합니다. 직접 만난 적 없는 연인에게는 돈도 선물도 절대 보내지 마세요. 그 옆에 값이 들지 않는 검색이 두 가지 있습니다. 상대의 사진을 역이미지 검색에 넣어 보세요. 도용된 사진은 대개 다른 곳에 공개 계정을 가진 누군가의 것입니다. 그리고 상대가 말한 직업 설명을 scammer라는 단어와 함께 검색해 보세요. 대본은 재사용되고, 같은 이야기를 이미 적어 둔 사람들이 있습니다." },
      { type: "p", text: "이미 벌어진 일이라면 도움이 되는 건 부끄러움이 아니라 속도입니다. 연락을 끊고, 메시지와 결제 기록을 남겨 두고, 은행이나 결제 서비스에 곧바로 알리고, 신고하세요. 미국에서는 ReportFraud.ftc.gov, 다른 나라에서는 그 나라의 사기 신고 창구로 하면 됩니다. 만난 플랫폼에도 그 계정을 신고해 두세요. 전문가에게 속는 일은 지능이 모자라서가 아닙니다. 이 일을 하는 사람들은 그것을 전업으로, 여러 사람을 동시에 상대하며, 손에 든 대본대로 합니다." },
    ],
  },
  zh: {
    term: "恋爱诈骗",
    summary:
      "有人花几个星期甚至几个月经营一段感情，全部目的只是为了开口要钱——被精心搭建起来的不是那个请求，而是这段关系本身。英文叫 romance scam。",
    blocks: [
      { type: "h2", text: "它通常不是从大家以为的地方开始的" },
      { type: "p", text: "大多数人脑子里的画面是交友软件。举报的数据却指向别处：美国联邦贸易委员会发现，**在2025年报告因恋爱诈骗损失钱财的人当中，近60%说这件事是从社交媒体平台开始的**——Instagram 或 Facebook 上一条陌生人的私信、一次关注、一条被回复的评论。交友软件确实也占一部分，但更大的那一份如今起始于没人设防的地方；因为没有人在打开社交动态的时候，是提防着一个陌生人的好感的。" },
      { type: "p", text: "另一件需要改掉的印象是：钱来得很早。并不早。先来的是几个星期的日常聊天——早安消息、计划、一段真实关系该有的质感——而开口要钱，只发生在拒绝会让人觉得像是抛下一个人的那一刻。这不是节奏上的巧合，这本身就是设计。这也是为什么“看对方语法不通就能认出骗子”这条老建议几乎没用：等到钱被提起的时候，几个月的文字往来早就读起来像一个真实的人了。" },
      { type: "h2", text: "怎么认出这个模式" },
      {
        type: "ul",
        items: [
          "见面永远不会发生，而每一个借口都是结构性的：在海上工作、在外驻派、被一份合同困在国外。",
          "视频通话总被绕开——摄像头坏了、信号不好——可消息却一条不落地继续。",
          "第一次开口要的数目不大而且很急：一笔医药费、一笔关税、一张终于能来见你的机票。",
          "付款方式一定是收不回来的那种：电汇、礼品卡、某个支付应用、加密货币。",
        ],
      },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "美国联邦贸易委员会的建议只有一句话，却顶得上一整份清单：绝不要给一个从未当面见过的恋人寄钱或寄礼物。围绕这一条，还有两次不花钱的搜索。把对方的照片放进反向图片搜索——被盗用的照片，通常属于某个在别处有公开账号的人。再把对方的职业描述和 scammer 这个词放在一起搜一遍；剧本是重复使用的，写下过同一个故事的人不止一个。" },
      { type: "p", text: "如果事情已经发生了，管用的是速度，不是羞耻。停止联系，保留聊天记录和付款凭证，立刻通知银行或支付服务，然后举报——在美国是 ReportFraud.ftc.gov，在其他国家和地区则是当地的全国性反诈骗举报渠道——并在你们认识的那个平台上举报这个账号。被一个专业的人骗到，不是智力上的失败；做这件事的人是全职在做，同时对着很多人，手里还拿着一份现成的剧本。" },
    ],
  },
  nl: {
    term: "Datingfraude",
    summary:
      "Fraude waarbij iemand weken- of maandenlang een romantische relatie opbouwt met als enige doel om geld te vragen — en waarbij niet de vraag, maar de relatie zelf het geconstrueerde deel is; in het Engels romance scam.",
    blocks: [
      { type: "h2", text: "Het begint meestal niet waar mensen denken" },
      { type: "p", text: "Het beeld dat de meeste mensen erbij hebben is een datingapp, en de naam wijst diezelfde kant op. De cijfers zeggen iets anders: de Amerikaanse Federal Trade Commission (FTC) stelde vast dat **bijna 60% van de mensen die in 2025 meldden geld te hebben verloren aan datingfraude, zei dat het op een socialemediaplatform was begonnen** — een bericht van een onbekende op Instagram of Facebook, een volger, een beantwoorde reactie. Datingapps horen erbij, maar het grootste deel begint inmiddels op een plek waar niemand op zijn hoede is, want niemand opent een tijdlijn voorbereid op de genegenheid van een vreemde." },
      { type: "p", text: "Het tweede wat je beter kunt afleren, is dat het geld vroeg komt. Dat doet het niet. Eerst komen weken van gewone gesprekken — goedemorgenberichten, plannen, het weefsel van een echte relatie — en de vraag komt pas op het moment dat weigeren zou voelen als iemand in de steek laten. Dat is het ontwerp, geen toeval van tempo. Het is ook waarom het bekende advies om een oplichter aan zijn slechte grammatica te herkennen bijna niets waard is: tegen de tijd dat het over geld gaat, lezen maanden aan berichten allang als een mens." },
      { type: "h2", text: "Hoe je het patroon herkent" },
      {
        type: "ul",
        items: [
          "Een ontmoeting in het echt komt er nooit, en elk excuus is structureel: werken op zee, uitgezonden zijn, vastzitten in het buitenland voor een contract.",
          "Videobellen wordt afgehouden — een kapotte camera, slecht bereik — terwijl de berichten zonder onderbreking doorgaan.",
          "Het eerste verzoek is klein en dringend: een ziekenhuisrekening, douanekosten, een vliegticket om je eindelijk te komen opzoeken.",
          "Betalen moet op een manier die niet terug te draaien is: een overboeking, cadeaubonnen, een betaalapp, cryptovaluta.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je kunt doen" },
      { type: "p", text: "Het advies van de FTC past in één zin en doet het werk van een hele checklist: stuur nooit geld of cadeaus naar een geliefde die je niet in het echt hebt ontmoet. Daaromheen kosten twee zoekopdrachten je niets. Haal de foto’s door een omgekeerde afbeeldingszoekopdracht — een gestolen foto hoort meestal bij iemand die ergens anders een openbaar account heeft. En zoek op het beroep dat diegene noemt samen met het woord scammer; de scripts worden hergebruikt, en anderen hebben hetzelfde verhaal al opgeschreven." },
      { type: "p", text: "Is het al gebeurd, dan helpt snelheid, niet schaamte. Beëindig het contact, bewaar de berichten en de betaalbewijzen, waarschuw meteen je bank of de betaaldienst en doe melding — in de VS via ReportFraud.ftc.gov, elders bij het nationale fraudemeldpunt — en meld het account op het platform waar jullie elkaar hebben ontmoet. Bedrogen worden door een beroepskracht is geen gebrek aan verstand: de mensen die dit doen, doen het fulltime, bij veel mensen tegelijk, vanaf een script." },
    ],
  },
  pl: {
    term: "Oszustwo matrymonialne",
    summary:
      "Oszustwo, w którym ktoś tygodniami albo miesiącami buduje romantyczną relację wyłącznie po to, żeby w końcu poprosić o pieniądze — a skonstruowana jest sama relacja, nie prośba.",
    blocks: [
      { type: "h2", text: "Zwykle nie zaczyna się tam, gdzie ludzie myślą" },
      { type: "p", text: "Obraz, który większość z nas nosi w głowie, to aplikacja randkowa. Zgłoszenia mówią co innego: amerykańska Federalna Komisja Handlu (FTC) ustaliła, że **blisko 60% osób, które zgłosiły utratę pieniędzy w oszustwie matrymonialnym w 2025 roku, powiedziało, że wszystko zaczęło się na platformie społecznościowej** — wiadomość od kogoś obcego na Instagramie albo Facebooku, obserwowanie profilu, odpowiedź pod komentarzem. Aplikacje randkowe są tego częścią, ale większa część zaczyna się dziś tam, gdzie nikt nie jest czujny, bo nikt nie otwiera mediów społecznościowych przygotowany na czułość od obcej osoby." },
      { type: "p", text: "Druga rzecz, którą warto się oduczyć, to przekonanie, że pieniądze pojawiają się wcześnie. Nie pojawiają. Najpierw są tygodnie zupełnie zwyczajnej rozmowy — wiadomości na dzień dobry, plany, tkanka prawdziwej relacji — a prośba pada dopiero w momencie, w którym odmowa byłaby jak zostawienie kogoś samego. To jest zaprojektowane, a nie przypadek tempa. To także powód, dla którego rada, żeby rozpoznać oszusta po błędach językowych, jest niemal bezużyteczna: zanim padnie słowo o pieniądzach, miesiące pisania czytają się już jak człowiek." },
      { type: "h2", text: "Jak rozpoznać ten schemat" },
      {
        type: "ul",
        items: [
          "Spotkanie na żywo nigdy nie dochodzi do skutku, a każda wymówka jest wbudowana w sytuację: praca na morzu, służba na misji, kontrakt za granicą, z którego nie da się wyrwać.",
          "Rozmowy wideo są zbywane — zepsuta kamera, słaby zasięg — podczas gdy wiadomości płyną bez żadnej przerwy.",
          "Pierwsza prośba jest mała i pilna: rachunek za leczenie, opłata celna, bilet lotniczy, żeby wreszcie cię odwiedzić.",
          "Zapłata ma iść w formie, której nie da się cofnąć: przelew, karty podarunkowe, aplikacja płatnicza, kryptowaluty.",
        ],
      },
      { type: "h2", accent: "green", text: "Co można z tym zrobić" },
      { type: "p", text: "Rada FTC mieści się w jednym zdaniu, a robi robotę całej listy kontrolnej: nigdy nie wysyłaj pieniędzy ani prezentów komuś, z kim nie doszło do spotkania na żywo. Wokół tego dwa wyszukiwania nic nie kosztują. Przepuść zdjęcia tej osoby przez wyszukiwanie obrazem — skradzione zdjęcie zwykle należy do kogoś, kto ma gdzie indziej publiczne konto. I wpisz w wyszukiwarkę opis jej pracy razem ze słowem scammer; scenariusze są używane wielokrotnie, a inni zdążyli już opisać dokładnie tę samą historię." },
      { type: "p", text: "Jeśli to już się stało, przydaje się szybkość, a nie wstyd. Zerwij kontakt, zachowaj wiadomości i potwierdzenia przelewów, od razu powiadom bank albo serwis płatniczy i zgłoś sprawę — w Stanach Zjednoczonych pod adresem ReportFraud.ftc.gov, w innych krajach na krajową infolinię do zgłaszania oszustw — a także zgłoś konto na platformie, gdzie zaczęła się ta znajomość. Dać się oszukać zawodowcowi to nie jest brak inteligencji; ci, którzy to robią, robią to na pełny etat, wielu osobom naraz, z gotowego scenariusza." },
    ],
  },
  sv: {
    term: "Romansbedrägeri",
    summary:
      "Ett bedrägeri där någon bygger upp en kärleksrelation under veckor eller månader enbart för att kunna be om pengar — och där det som är konstruerat är själva relationen, inte förfrågan.",
    blocks: [
      { type: "h2", text: "Det börjar oftast inte där folk tror" },
      { type: "p", text: "Bilden de flesta bär på är en dejtingapp. Anmälningarna säger något annat: den amerikanska konsumentmyndigheten Federal Trade Commission (FTC) fann att **nästan 60 procent av dem som anmälde att de förlorat pengar i ett romansbedrägeri under 2025 uppgav att det började på en social medieplattform** — ett meddelande från en främling på Instagram eller Facebook, en ny följare, en kommentar som besvarades. Dejtingappar är en del av bilden, men den större delen börjar numera någonstans där ingen är på sin vakt, eftersom ingen öppnar ett socialt flöde beredd på ömhet från en främling." },
      { type: "p", text: "Det andra som är värt att lära om är att pengarna kommer tidigt. Det gör de inte. Först kommer veckor av alldeles vanligt samtal — godmorgonmeddelanden, planer, väven i en riktig relation — och frågan om pengar dyker upp först när ett nej skulle kännas som att svika någon. Det är själva konstruktionen, inte en slump i tempot. Det är också därför rådet att känna igen en bedragare på dålig språkbehandling är nästan oanvändbart: när pengarna nämns har månader av skrivande redan låtit som en människa." },
      { type: "h2", text: "Så känner du igen mönstret" },
      {
        type: "ul",
        items: [
          "Något möte i verkligheten blir aldrig av, och varje ursäkt är inbyggd i livssituationen: jobb till havs, utlandstjänst, ett kontrakt som håller kvar hen utomlands.",
          "Videosamtal vinklas bort — trasig kamera, dålig uppkoppling — medan meddelandena fortsätter utan avbrott.",
          "Den första förfrågan är liten och brådskande: en sjukhusräkning, en tullavgift, en flygbiljett för att äntligen kunna hälsa på dig.",
          "Betalningen ska ske på ett sätt som inte går att ångra: banköverföring, presentkort, en betalapp, kryptovaluta.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "FTC:s råd är en enda mening och gör hela checklistans jobb: skicka aldrig pengar eller presenter till någon du inte har träffat i verkligheten. Runt det kostar två sökningar ingenting. Kör personens bilder genom en omvänd bildsökning — en stulen bild tillhör oftast någon som har ett öppet konto någon annanstans. Och sök på personens yrkesbeskrivning tillsammans med ordet scammer; manusen återanvänds, och andra har redan skrivit ner precis samma historia." },
      { type: "p", text: "Har det redan hänt är det snabbhet som hjälper, inte skam. Bryt kontakten, spara meddelandena och betalningsunderlagen, hör av dig till banken eller betaltjänsten direkt och anmäl det — i USA på ReportFraud.ftc.gov, på andra håll till den nationella linjen för bedrägerianmälningar — och anmäl dessutom kontot på plattformen där ni möttes. Att bli lurad av en yrkesmänniska är inte ett tecken på bristande intelligens, och de som ligger bakom det här gör det på heltid, mot många personer samtidigt, utifrån ett manus." },
    ],
  },
  hi: {
    term: "रोमांस स्कैम",
    summary:
      "एक ऐसी ठगी जिसमें कोई हफ़्तों या महीनों तक एक रिश्ता बनाता है, सिर्फ़ इसलिए कि आख़िर में पैसे माँग सके — और जो गढ़ा गया होता है वह वह माँग नहीं, ख़ुद वह रिश्ता होता है।",
    blocks: [
      { type: "h2", text: "यह आमतौर पर वहाँ से शुरू नहीं होता जहाँ लोग समझते हैं" },
      { type: "p", text: "ज़्यादातर लोगों के मन में तस्वीर किसी डेटिंग ऐप की होती है। शिकायतों के आँकड़े कुछ और कहते हैं: अमेरिका के फ़ेडरल ट्रेड कमीशन (FTC) ने पाया कि **2025 में रोमांस स्कैम में पैसा गँवाने की शिकायत करने वालों में से क़रीब 60% ने कहा कि बात किसी सोशल मीडिया प्लैटफ़ॉर्म पर शुरू हुई थी** — Instagram या Facebook पर किसी अजनबी का एक मैसेज, एक फ़ॉलो, एक कमेंट जिसका जवाब दे दिया गया। डेटिंग ऐप भी इसका हिस्सा हैं, पर बड़ा हिस्सा अब वहाँ से शुरू होता है जहाँ कोई सतर्क ही नहीं होता; क्योंकि कोई भी अपनी सोशल फ़ीड किसी अजनबी के लगाव के लिए तैयार होकर नहीं खोलता।" },
      { type: "p", text: "दूसरी बात जो भुला देनी चाहिए वह यह है कि पैसा जल्दी माँगा जाता है। नहीं माँगा जाता। पहले हफ़्तों तक आम बातचीत चलती है — गुड मॉर्निंग के मैसेज, योजनाएँ, एक असली रिश्ते की बुनावट — और माँग तभी आती है जब मना करना किसी को बीच रास्ते छोड़ देने जैसा लगने लगे। यह रफ़्तार का इत्तिफ़ाक़ नहीं, यही डिज़ाइन है। इसीलिए वह पुरानी सलाह भी लगभग बेकार है कि ठग को उसकी टूटी-फूटी भाषा से पहचान लीजिए: जब तक पैसे का ज़िक्र आता है, महीनों की लिखा-पढ़ी पहले ही किसी असली इंसान जैसी पढ़ी जा चुकी होती है।" },
      { type: "h2", text: "इस पैटर्न को कैसे पहचानें" },
      {
        type: "ul",
        items: [
          "आमने-सामने मिलना कभी नहीं हो पाता, और हर बहाना ढाँचागत होता है: समुंदर में काम, कहीं तैनाती, विदेश में किसी कॉन्ट्रैक्ट में फँस जाना।",
          "वीडियो कॉल हर बार टल जाती है — कैमरा ख़राब, नेटवर्क कमज़ोर — जबकि मैसेज बिना रुके चलते रहते हैं।",
          "पहली माँग छोटी और जल्दबाज़ी वाली होती है: कोई अस्पताल का बिल, कोई कस्टम ड्यूटी, आपसे मिलने आने के लिए एक हवाई टिकट।",
          "पैसा हमेशा ऐसे तरीक़े से माँगा जाता है जो वापस नहीं आ सकता: बैंक ट्रांसफ़र, गिफ़्ट कार्ड, कोई पेमेंट ऐप, क्रिप्टोकरेंसी।",
        ],
      },
      { type: "h2", accent: "green", text: "क्या किया जा सकता है" },
      { type: "p", text: "FTC की सलाह एक ही वाक्य की है और पूरी चेकलिस्ट का काम कर देती है: जिससे आप कभी आमने-सामने मिले ही नहीं, उसे कभी पैसे या तोहफ़े मत भेजिए। इसके इर्द-गिर्द दो तलाशें मुफ़्त हैं। उनकी तस्वीरें रिवर्स इमेज सर्च में डालिए — चुराई हुई तस्वीर आम तौर पर किसी ऐसे इंसान की होती है जिसका कहीं और खुला अकाउंट मौजूद है। और उनके काम का ब्योरा scammer शब्द के साथ मिलाकर खोजिए; स्क्रिप्ट दोबारा इस्तेमाल होती हैं, और वही कहानी लिख चुके लोग पहले से मौजूद होते हैं।" },
      { type: "p", text: "अगर यह हो ही चुका है, तो काम शर्म नहीं, रफ़्तार आती है। संपर्क बंद कीजिए, मैसेज और पेमेंट के रिकॉर्ड संभालकर रखिए, बैंक या पेमेंट सेवा को फ़ौरन बताइए, और शिकायत दर्ज कराइए — अमेरिका में ReportFraud.ftc.gov पर, और बाक़ी जगहों पर वहाँ की राष्ट्रीय धोखाधड़ी शिकायत लाइन पर — साथ ही जिस प्लैटफ़ॉर्म पर मुलाक़ात हुई थी, वहाँ उस अकाउंट की रिपोर्ट कीजिए। किसी पेशेवर के हाथों धोखा खा जाना अक़्ल की कमी नहीं है; यह काम करने वाले लोग इसे पूरे वक़्त करते हैं, एक साथ बहुत सारे लोगों के साथ, और एक तयशुदा स्क्रिप्ट से।" },
    ],
  },
};
