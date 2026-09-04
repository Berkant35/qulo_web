import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Swipe fatigue — the flat exhaustion that builds from evaluating an endless
 * stream of faces on dating apps.
 *
 * Statistics: this is the one glossary page that carries the burnout figure
 * (78%, Forbes Health / OnePoll 2024, n=1,000 US adults who used a dating app
 * in the past year — `FORBES_ONEPOLL_2024` in src/lib/constants/stats.ts). It
 * appears exactly once per locale, in block 2, with publisher, year, sample
 * size and population written out in the same sentence. Do not lift the number
 * into another term file and do not shorten the attribution to "a 2024 survey";
 * a bare percentage here is the defect the stats policy exists to prevent.
 * Everything else on this page is described qualitatively on purpose — the
 * older claims about swipes per match, minutes per day and reply rates had no
 * traceable source and are deliberately absent.
 *
 * Qulo angle (block 7): kept, because the link is real — the term names the
 * cost of sorting people by photo, and Qulo's mechanic replaces that queue with
 * questions. The claim is limited to what the app does (2 to 4 multiple-choice
 * questions on a free account, up to 10 on a paid plan, four options, every
 * answer must be right) and stops short of saying the format cures burnout,
 * which nothing here can support. Never quote the range as 2 to 10 without
 * naming the paid plan in the same sentence — 10 is the Premium cap, not what
 * the free reader this page addresses actually gets.
 *
 * Term names: most languages use the English loanword or a half-loan compound
 * (de "Swipe-Müdigkeit", nl "Swipemoeheid", sv "Swipetrötthet"); ja/ko/zh/hi/ru
 * have genuine native renderings and use them. de mentions the English form in
 * the summary because both circulate there.
 */
export const swipeFatigue: LocalizedGlossaryEntry = {
  en: {
    term: "Swipe fatigue",
    summary:
      "The flat, worn-out feeling that builds when you spend hours judging strangers from photos — the app stops being fun, opening it feels like a chore, and after a while everyone starts to look the same.",
    blocks: [
      { type: "h2", text: "Why sorting faces wears you out" },
      { type: "p", text: "Every profile asks you for a decision, and your brain treats small decisions much the way it treats big ones: each of them spends something. The queue of faces never ends, so there is no point at which you get to feel finished. Add the fact that most of those decisions lead nowhere — no reply, no conversation, no plan — and you have effort going out with almost nothing coming back." },
      { type: "p", text: "If that describes your last few months, you are in ordinary company. In a 2024 Forbes Health survey run with OnePoll among 1,000 US adults who had used a dating app in the past year, 78% reported burnout. The tiredness is not a verdict on how good you are at this, and it is not a mood you can push through by swiping harder." },
      { type: "h2", text: "How you recognise it" },
      { type: "ul", items: [
        "**You swipe without reading.** Names, jobs, whole bios go past and none of it registers.",
        "**Started conversations sit there.** Messages wait for days, and then you feel bad about it.",
        "**Good news lands flat.** A new match used to be a small lift; now it barely moves you.",
        "**You open the app out of boredom**, in a queue or in bed, the same way you open a news feed.",
      ] },
      { type: "h2", accent: "green", text: "What actually helps" },
      { type: "p", text: "Deleting the app for a week helps less than changing how you use it. Try a fixed slot instead — twenty minutes, twice a week — and close it when the time is up. Read three profiles properly rather than skimming forty. Clear out the matches you are never going to write to; an inbox you are avoiding is its own weight. And when a conversation is going well, suggest a coffee early, while you still have the energy for it." },
      { type: "p", text: "It also helps to change what you are being asked to decide. On Qulo there is no swipe queue: each member writes between two and four multiple-choice questions — up to ten on a paid plan — with four options each and marks the correct answer, and you match with someone only by getting every one of their questions right. It is slow on purpose — reading one person properly costs less than sorting fifty." },
    ],
  },

  tr: {
    term: "Swipe yorgunluğu",
    summary:
      "Saatlerce fotoğraflara bakıp yabancıları eleyince biriken o donuk yorgunluk: uygulama artık eğlendirmez, açmak angarya gibi gelir ve bir süre sonra herkes birbirine benzemeye başlar.",
    blocks: [
      { type: "h2", text: "Yüz elemek neden yorar" },
      { type: "p", text: "Her profil senden bir karar ister; beyin küçük kararları da büyükler gibi işler, her birine bir şey harcar. Yüz sırası hiç bitmediği için, oturup da işi bitirdiğini hissedebileceğin bir nokta yoktur. Üstüne bu kararların çoğu hiçbir yere çıkmaz: cevap yok, sohbet yok, plan yok. Emek gider, karşılığı gelmez." },
      { type: "p", text: "Son birkaç ayın böyle geçtiyse yalnız değilsin. Forbes Health'in 2024'te OnePoll ile birlikte, son bir yıl içinde flört uygulaması kullanmış 1.000 ABD'li yetişkinle yaptığı ankette katılımcıların %78'i tükenmişlik bildirdi. Bu yorgunluk beceriksizlik işareti değil, daha çok kaydırarak da geçmiyor." },
      { type: "h2", text: "Nasıl anlarsın" },
      { type: "ul", items: [
        "**Okumadan kaydırıyorsun.** İsim, iş, koca bir biyografi geçip gidiyor, hiçbiri aklında kalmıyor.",
        "**Başlayan sohbetler öylece duruyor.** Mesaj günlerce bekliyor, sonra kendini kötü hissediyorsun.",
        "**Güzel haber bile düz geçiyor.** Eskiden yeni bir eşleşme keyif verirdi, artık bir şey hissettirmiyor.",
        "**Uygulamayı can sıkıntısından açıyorsun**: sırada beklerken, yatakta, haber akışı açar gibi.",
      ] },
      { type: "h2", accent: "green", text: "Ne işe yarıyor" },
      { type: "p", text: "Uygulamayı bir haftalığına silmek, kullanma biçimini değiştirmek kadar işe yaramıyor. Sabit bir aralık dene: haftada iki kez yirmişer dakika, süre bitince kapat. Kırk profili göz ucuyla geçmek yerine üç profili doğru düzgün oku. Hiç yazmayacağın eşleşmeleri temizle; kaçtığın bir gelen kutusu da yük. Sohbet iyi gidiyorsa, hâlâ enerjin varken erkenden bir kahve teklif et." },
      { type: "p", text: "Bir de neye karar vermenin istendiğini değiştirmek işe yarıyor. Qulo'da kaydırılacak bir sıra yok: herkes dört şıklı iki ila dört soru yazıp doğru cevabı işaretliyor — ücretli planda ona kadar; sen de ancak birinin bütün sorularını doğru bilerek onunla eşleşiyorsun. Bilerek yavaş; bir kişiyi düzgün okumak elli kişiyi elemekten daha az yoruyor." },
    ],
  },

  de: {
    term: "Swipe-Müdigkeit",
    summary:
      "Die stumpfe Erschöpfung, die entsteht, wenn man stundenlang Fremde nach Fotos sortiert: Die App macht keinen Spaß mehr, das Öffnen fühlt sich nach Pflicht an, und irgendwann sehen alle gleich aus (englisch: swipe fatigue).",
    blocks: [
      { type: "h2", text: "Warum das Sortieren von Gesichtern müde macht" },
      { type: "p", text: "Jedes Profil verlangt eine Entscheidung, und das Gehirn behandelt kleine Entscheidungen ähnlich wie große: Jede kostet etwas. Die Warteschlange aus Gesichtern endet nie, es gibt also keinen Punkt, an dem man fertig ist. Dazu kommt, dass die meisten dieser Entscheidungen ins Leere laufen — keine Antwort, kein Gespräch, keine Verabredung. Aufwand geht raus, zurück kommt fast nichts." },
      { type: "p", text: "Wer die letzten Monate so erlebt hat, ist damit nicht allein. In einer Umfrage von Forbes Health aus dem Jahr 2024, durchgeführt mit OnePoll unter 1.000 Erwachsenen in den USA, die im Jahr davor eine Dating-App genutzt hatten, berichteten 78 % von Burnout. Die Müdigkeit sagt nichts darüber, wie gut du darin bist, und sie lässt sich nicht wegwischen." },
      { type: "h2", text: "Woran du sie erkennst" },
      { type: "ul", items: [
        "**Du wischst, ohne zu lesen.** Namen, Berufe, ganze Profiltexte ziehen vorbei und bleiben nicht hängen.",
        "**Angefangene Chats bleiben liegen.** Nachrichten stehen tagelang da, und danach hast du ein schlechtes Gewissen.",
        "**Gute Nachrichten kommen nicht mehr an.** Früher war ein neues Match ein kleiner Moment, jetzt löst es nichts aus.",
        "**Du öffnest die App aus Langeweile**, an der Kasse oder im Bett, wie einen Newsfeed.",
      ] },
      { type: "h2", accent: "green", text: "Was wirklich hilft" },
      { type: "p", text: "Die App eine Woche zu löschen bringt weniger, als zu ändern, wie du sie benutzt. Nimm dir feste Zeiten: zweimal pro Woche zwanzig Minuten, danach ist zu. Lies drei Profile richtig, statt vierzig zu überfliegen. Räum die Matches weg, denen du nie schreiben wirst — ein Postfach, das du meidest, ist selbst eine Last. Und wenn ein Gespräch gut läuft, schlag früh einen Kaffee vor, solange du noch Lust darauf hast." },
      { type: "p", text: "Es hilft außerdem, zu ändern, worüber du überhaupt entscheidest. Bei Qulo gibt es keine Wischschlange: Jedes Mitglied schreibt zwei bis vier Fragen mit je vier Antwortmöglichkeiten und markiert die richtige, im kostenpflichtigen Tarif sind es bis zu zehn, und ein Match entsteht nur, wenn jemand alle Fragen richtig beantwortet. Das ist bewusst langsam — eine Person richtig zu lesen kostet weniger als fünfzig auszusortieren." },
    ],
  },

  fr: {
    term: "Fatigue du swipe",
    summary:
      "Cette lassitude sourde qui s'installe quand on passe des heures à trier des inconnus sur photo : l'appli n'amuse plus, l'ouvrir devient une corvée et, au bout d'un moment, tout le monde se ressemble.",
    blocks: [
      { type: "h2", text: "Pourquoi trier des visages épuise" },
      { type: "p", text: "Chaque profil réclame une décision, et le cerveau traite les petites décisions à peu près comme les grandes : chacune coûte quelque chose. La file de visages ne s'arrête jamais, donc il n'existe aucun moment où l'on a terminé. Ajoutez que la plupart de ces décisions ne mènent nulle part — pas de réponse, pas de conversation, pas de rendez-vous — et l'effort part sans que rien ne revienne." },
      { type: "p", text: "Si vos derniers mois ressemblent à ça, vous n'êtes pas un cas à part. Dans une enquête menée en 2024 par Forbes Health avec OnePoll auprès de 1 000 adultes américains ayant utilisé une appli de rencontre dans l'année écoulée, 78 % faisaient état d'un épuisement. Cette fatigue ne dit rien de vos capacités, et on n'en sort pas en swipant davantage." },
      { type: "h2", text: "Comment la reconnaître" },
      { type: "ul", items: [
        "**Vous swipez sans lire.** Les prénoms, les métiers, des bios entières défilent sans laisser de trace.",
        "**Les conversations restent en plan.** Les messages attendent des jours, et ensuite vous culpabilisez.",
        "**Même les bonnes nouvelles tombent à plat.** Un nouveau match faisait plaisir ; maintenant, plus rien.",
        "**Vous ouvrez l'appli par ennui**, dans la file d'attente ou au lit, comme un fil d'actualité.",
      ] },
      { type: "h2", accent: "green", text: "Ce qui aide vraiment" },
      { type: "p", text: "Supprimer l'appli une semaine aide moins que changer la façon de s'en servir. Fixez un créneau : vingt minutes, deux fois par semaine, et vous fermez quand c'est fini. Lisez trois profils correctement plutôt que d'en survoler quarante. Faites le tri dans les matchs auxquels vous n'écrirez jamais : une boîte que l'on évite pèse aussi. Et quand un échange se passe bien, proposez un café tôt, tant que l'envie est là." },
      { type: "p", text: "Changer ce sur quoi on vous demande de trancher aide également. Sur Qulo, il n'y a pas de file à faire défiler : chaque personne écrit de deux à quatre questions à quatre réponses en indiquant la bonne, jusqu'à dix avec un abonnement payant, et on ne se rencontre qu'en répondant juste à toutes. C'est lent volontairement — lire une personne comme il faut coûte moins que d'en trier cinquante." },
    ],
  },

  es: {
    term: "Fatiga del swipe",
    summary:
      "Ese cansancio plano que se acumula tras horas descartando desconocidos por una foto: la app deja de divertir, abrirla se vuelve una obligación y al final todo el mundo parece igual.",
    blocks: [
      { type: "h2", text: "Por qué clasificar caras agota" },
      { type: "p", text: "Cada perfil te pide una decisión, y el cerebro trata las decisiones pequeñas casi igual que las grandes: cada una gasta algo. La fila de caras no se acaba nunca, así que no hay un punto en el que puedas darte por terminado. Súmale que la mayoría de esas decisiones no lleva a ninguna parte —sin respuesta, sin conversación, sin plan— y tienes esfuerzo saliendo sin que vuelva casi nada." },
      { type: "p", text: "Si tus últimos meses han sido así, no eres un caso raro. En una encuesta de 2024 de Forbes Health realizada con OnePoll entre 1.000 adultos de Estados Unidos que habían usado una app de citas en el último año, el 78 % declaró agotamiento. Ese cansancio no dice nada sobre lo bueno que eres en esto, y no se arregla deslizando más." },
      { type: "h2", text: "Cómo reconocerla" },
      { type: "ul", items: [
        "**Deslizas sin leer.** Nombres, trabajos, biografías enteras pasan y no se te queda nada.",
        "**Las conversaciones se quedan a medias.** Los mensajes esperan días y luego te sientes mal.",
        "**Hasta lo bueno te da igual.** Antes un match nuevo animaba el día; ahora ni te inmuta.",
        "**Abres la app por aburrimiento**, en la cola o en la cama, como quien mira un feed.",
      ] },
      { type: "h2", accent: "green", text: "Qué ayuda de verdad" },
      { type: "p", text: "Borrar la app una semana ayuda menos que cambiar cómo la usas. Prueba con un rato fijo: veinte minutos, dos veces por semana, y cierras cuando se acaba. Lee tres perfiles bien en lugar de ojear cuarenta. Limpia los matches a los que nunca vas a escribir; un buzón que evitas también pesa. Y si una conversación va bien, propón un café pronto, mientras aún te apetece." },
      { type: "p", text: "También ayuda cambiar sobre qué te toca decidir. En Qulo no hay una fila que deslizar: cada persona escribe entre dos y cuatro preguntas de cuatro opciones y marca la correcta, hasta diez con un plan de pago, y solo hay match si aciertas todas las suyas. Es lento a propósito: leer bien a alguien cansa menos que descartar a cincuenta." },
    ],
  },

  ar: {
    term: "إرهاق التمرير",
    summary:
      "ذلك الفتور الذي يتراكم بعد ساعات من فرز الغرباء بناءً على صورهم: التطبيق يفقد متعته، وفتحه يصير واجبًا ثقيلًا، ومع الوقت تتشابه الوجوه كلها.",
    blocks: [
      { type: "h2", text: "لماذا يُتعِب فرز الوجوه؟" },
      { type: "p", text: "كل ملف شخصي يطلب منك قرارًا، والدماغ يعامل القرارات الصغيرة كما يعامل الكبيرة تقريبًا: كل واحد منها يستهلك شيئًا. طابور الوجوه لا ينتهي، فلا توجد لحظة تشعر فيها بأنك أنجزت المهمة. أضف إلى ذلك أن معظم هذه القرارات لا تفضي إلى شيء: لا رد، ولا محادثة، ولا موعد. الجهد يخرج ولا يعود منه إلا القليل." },
      { type: "p", text: "إن كانت شهورك الأخيرة على هذا النحو فأنت لست استثناءً. في استطلاع أجرته Forbes Health عام 2024 بالتعاون مع OnePoll وشمل 1,000 بالغ في الولايات المتحدة استخدموا تطبيق مواعدة خلال العام السابق، قال 78% إنهم عانوا إنهاكًا. هذا التعب لا يقول شيئًا عن مهارتك، ولا يزول بمزيد من التمرير." },
      { type: "h2", text: "كيف تعرف أنك وصلت إليه" },
      { type: "ul", items: [
        "**تمرّر دون أن تقرأ.** الأسماء والوظائف ونصوص كاملة تمر أمامك ولا يبقى منها شيء.",
        "**محادثات تبدأ ثم تبقى معلّقة.** الرسائل تنتظر أيامًا، ثم يأتي الشعور بالذنب.",
        "**حتى الخبر الجيد لا يحرّكك.** كان التوافق الجديد يُبهج، والآن بالكاد تلاحظه.",
        "**تفتح التطبيق من الملل**، في الطابور أو قبل النوم، كأنك تتصفح الأخبار.",
      ] },
      { type: "h2", accent: "green", text: "ما الذي يفيد فعلًا" },
      { type: "p", text: "حذف التطبيق أسبوعًا يفيد أقل من تغيير طريقة استخدامه. جرّب وقتًا محددًا: عشرون دقيقة مرتين في الأسبوع، وأغلقه حين ينتهي الوقت. اقرأ ثلاثة ملفات بتمعّن بدل أن تتصفح أربعين. امسح التوافقات التي تعرف أنك لن تراسلها؛ صندوق تتجنّبه هو عبء بحد ذاته. وإذا سارت محادثة على ما يرام، اقترح لقاءً مبكرًا ما دامت الرغبة موجودة." },
      { type: "p", text: "ويفيد أيضًا أن تغيّر طبيعة القرار المطلوب منك. في Qulo لا يوجد طابور للتمرير: كل عضو يكتب من سؤالين إلى أربعة أسئلة بأربعة خيارات ويحدد الإجابة الصحيحة، وحتى عشرة أسئلة في الخطة المدفوعة، ولا يحدث التوافق إلا إذا أجاب الطرف الآخر عن كل الأسئلة إجابة صحيحة. البطء هنا مقصود، وقراءة شخص واحد بعناية أقل كلفة من فرز خمسين." },
    ],
  },

  ru: {
    term: "Усталость от свайпов",
    summary:
      "Тусклое утомление, которое накапливается, когда часами перебираешь незнакомцев по фотографиям: приложение перестаёт радовать, открывать его — как повинность, а лица сливаются в одно.",
    blocks: [
      { type: "h2", text: "Почему перебор лиц выматывает" },
      { type: "p", text: "Каждая анкета требует решения, а мозг относится к мелким решениям почти так же, как к крупным: на каждое уходит ресурс. Очередь из лиц не кончается, поэтому нет момента, когда работа считается сделанной. Прибавьте, что большинство этих решений ни к чему не приводит — ни ответа, ни разговора, ни встречи. Силы уходят, а обратно почти ничего не возвращается." },
      { type: "p", text: "Если последние месяцы выглядели именно так, вы не исключение. В опросе Forbes Health, проведённом в 2024 году совместно с OnePoll среди 1000 взрослых американцев, пользовавшихся приложением для знакомств в течение года, 78% сообщили о выгорании. Эта усталость ничего не говорит о том, насколько вы хороши в знакомствах, и её не пересвайпить." },
      { type: "h2", text: "Как это заметить" },
      { type: "ul", items: [
        "**Листаете, не читая.** Имена, профессии, целые описания проходят мимо и не откладываются.",
        "**Начатые переписки повисают.** Сообщение лежит без ответа днями, а потом становится неловко.",
        "**Хорошие новости не радуют.** Раньше новый мэтч поднимал настроение, теперь не задевает вовсе.",
        "**Открываете приложение от скуки** — в очереди, перед сном, как обычную ленту.",
      ] },
      { type: "h2", accent: "green", text: "Что действительно помогает" },
      { type: "p", text: "Удалить приложение на неделю помогает меньше, чем изменить способ им пользоваться. Заведите окно: двадцать минут дважды в неделю — и закрывайте, когда время вышло. Прочитайте три анкеты внимательно вместо сорока по диагонали. Разберите мэтчи, которым вы никогда не напишете: папка, которую вы обходите стороной, тоже давит. А если переписка идёт хорошо, зовите на кофе рано, пока на это есть силы." },
      { type: "p", text: "Помогает и сменить сам предмет решения. В Qulo нет ленты для свайпов: каждый пишет от двух до четырёх вопросов с четырьмя вариантами ответа и отмечает верный, на платном тарифе — до десяти, а мэтч случается, только если человек ответил правильно на все. Это намеренно медленно — прочитать одного внимательно дешевле, чем перебрать полсотни." },
    ],
  },

  pt: {
    term: "Fadiga de swipe",
    summary:
      "Aquele cansaço sem graça que se acumula depois de horas descartando desconhecidos pela foto: o aplicativo deixa de ser divertido, abrir vira obrigação e, no fim, todo mundo parece igual.",
    blocks: [
      { type: "h2", text: "Por que separar rostos cansa tanto" },
      { type: "p", text: "Cada perfil pede uma decisão, e o cérebro trata decisão pequena quase como trata decisão grande: cada uma gasta alguma coisa. A fila de rostos não termina, então não existe o momento em que você pode se dar por satisfeito. Some a isso que a maior parte dessas decisões não vira nada — sem resposta, sem conversa, sem encontro — e o esforço sai sem quase nada voltar." },
      { type: "p", text: "Se os seus últimos meses foram assim, você não é exceção. Numa pesquisa de 2024 da Forbes Health feita com a OnePoll entre 1.000 adultos dos Estados Unidos que tinham usado um aplicativo de relacionamento no último ano, 78% relataram esgotamento. Esse cansaço não diz nada sobre o quanto você é bom nisso e não passa deslizando mais." },
      { type: "h2", text: "Como perceber" },
      { type: "ul", items: [
        "**Você desliza sem ler.** Nomes, profissões, biografias inteiras passam e não fica nada.",
        "**Conversas começadas ficam paradas.** As mensagens esperam dias e depois vem a culpa.",
        "**Até notícia boa cai no vazio.** Um match novo animava; agora não mexe com você.",
        "**Você abre o app por tédio**, na fila ou na cama, do jeito que abre um feed.",
      ] },
      { type: "h2", accent: "green", text: "O que ajuda de verdade" },
      { type: "p", text: "Apagar o aplicativo por uma semana ajuda menos do que mudar o jeito de usar. Faça um horário fixo: vinte minutos, duas vezes por semana, e feche quando acabar. Leia três perfis direito em vez de passar os olhos em quarenta. Limpe os matches para quem você nunca vai escrever; caixa de entrada que se evita também pesa. E, quando a conversa engata, chame para um café logo, enquanto ainda dá vontade." },
      { type: "p", text: "Também ajuda mudar o que você tem de decidir. No Qulo não existe fila para deslizar: cada pessoa escreve de duas a quatro perguntas de quatro alternativas e marca a certa, até dez num plano pago, e o match só acontece quando alguém acerta todas. É lento de propósito — ler uma pessoa com atenção cansa menos do que descartar cinquenta." },
    ],
  },

  it: {
    term: "Stanchezza da swipe",
    summary:
      "Quella spossatezza piatta che si accumula dopo ore passate a scartare sconosciuti da una foto: l'app smette di divertire, aprirla diventa un dovere e alla fine sembrano tutti uguali.",
    blocks: [
      { type: "h2", text: "Perché smistare volti stanca" },
      { type: "p", text: "Ogni profilo chiede una decisione, e il cervello tratta le decisioni piccole quasi come quelle grandi: ognuna consuma qualcosa. La fila di volti non finisce mai, quindi non arriva mai il momento in cui hai finito. Aggiungi che la maggior parte di quelle decisioni non porta da nessuna parte — nessuna risposta, nessuna conversazione, nessun appuntamento — e la fatica esce senza che rientri quasi niente." },
      { type: "p", text: "Se gli ultimi mesi sono andati così, non sei un caso isolato. In un sondaggio del 2024 di Forbes Health condotto con OnePoll su 1.000 adulti statunitensi che avevano usato un'app di incontri nell'ultimo anno, il 78% ha riferito esaurimento. Questa stanchezza non dice niente su quanto sei bravo in queste cose e non passa scorrendo di più." },
      { type: "h2", text: "Come riconoscerla" },
      { type: "ul", items: [
        "**Scorri senza leggere.** Nomi, lavori, biografie intere passano e non resta niente.",
        "**Le conversazioni iniziate restano lì.** I messaggi aspettano giorni e poi arriva il senso di colpa.",
        "**Anche le buone notizie cadono nel vuoto.** Un match nuovo era una piccola gioia, ora non muove più niente.",
        "**Apri l'app per noia**, in fila o a letto, come apriresti un feed.",
      ] },
      { type: "h2", accent: "green", text: "Cosa aiuta davvero" },
      { type: "p", text: "Cancellare l'app per una settimana aiuta meno che cambiare il modo di usarla. Prova con una finestra fissa: venti minuti, due volte a settimana, e si chiude quando il tempo è finito. Leggi bene tre profili invece di sfogliarne quaranta. Fai pulizia tra i match a cui non scriverai mai: una casella che eviti pesa comunque. E se una conversazione va bene, proponi un caffè presto, finché ne hai voglia." },
      { type: "p", text: "Aiuta anche cambiare su cosa ti viene chiesto di decidere. Su Qulo non c'è una fila da scorrere: ogni persona scrive da due a quattro domande con quattro risposte e indica quella giusta, fino a dieci con un piano a pagamento, e il match arriva solo se le indovini tutte. È lento di proposito: leggere bene una persona costa meno che scartarne cinquanta." },
    ],
  },

  ja: {
    term: "スワイプ疲れ",
    summary:
      "写真だけで見知らぬ人を仕分けし続けた末に残る、平坦な疲れ。アプリが楽しくなくなり、開くこと自体が義務のようになり、やがて誰の顔も同じに見えてくる状態です。",
    blocks: [
      { type: "h2", text: "顔を仕分ける作業はなぜ疲れるのか" },
      { type: "p", text: "プロフィールは一つひとつが判断を求めてきます。脳は小さな判断も大きな判断とほとんど同じように扱うので、そのたびに何かを消耗します。しかも顔の行列には終わりがなく、「今日はここまでで終わり」と思える地点がありません。そのうえ判断の大半はどこにもつながりません。返信もなく、会話も生まれず、約束にもならない。労力だけが出ていって、返ってくるものがほとんどないのです。" },
      { type: "p", text: "ここ数か月がこんな調子でも、それは珍しいことではありません。Forbes Health が2024年に OnePoll と実施した、過去1年にマッチングアプリを使った米国の成人1,000人への調査では、78%が燃え尽きを報告しています。この疲れはあなたの上手い下手を示すものではなく、さらに多くスワイプして抜け出せるものでもありません。" },
      { type: "h2", text: "こんなときは疲れています" },
      { type: "ul", items: [
        "**読まずにスワイプしている。** 名前も仕事も自己紹介も、目の前を通り過ぎるだけで残らない。",
        "**始まった会話が止まっている。** 届いたメッセージを何日も置いたままにして、あとで後ろめたくなる。",
        "**いい知らせが響かない。** 前はマッチが小さな喜びだったのに、今は何も動かない。",
        "**退屈しのぎに開いてしまう。** レジ待ちやベッドの中で、ニュースを開くのと同じ手つきで。",
      ] },
      { type: "h2", accent: "green", text: "効くのはこういうこと" },
      { type: "p", text: "一週間アプリを消すより、使い方を変えるほうが効きます。時間を決めてしまいましょう。週に二回、二十分。時間が来たら閉じます。四十人を流し見するより、三人をきちんと読む。もう書かないとわかっているマッチは整理する。避けている受信箱は、それだけで重荷です。会話がうまくいっているなら、気力があるうちに早めにお茶に誘ってください。" },
      { type: "p", text: "何を判断させられるかを変えるのも効きます。Qulo にスワイプの行列はありません。一人ひとりが四択の質問を2問から4問（有料プランなら最大10問）つくって正解を設定し、その全問に正解した相手とだけマッチします。あえて遅い仕組みです。一人をきちんと読むほうが、五十人を仕分けるより負担は軽くなります。" },
    ],
  },

  ko: {
    term: "스와이프 피로",
    summary:
      "사진만 보고 낯선 사람을 몇 시간씩 걸러내다 보면 남는 밋밋한 지침. 앱이 더는 즐겁지 않고, 여는 것 자체가 숙제 같아지며, 나중에는 모든 얼굴이 비슷해 보입니다.",
    blocks: [
      { type: "h2", text: "얼굴을 고르는 일이 왜 지치게 할까" },
      { type: "p", text: "프로필 하나하나가 판단을 요구합니다. 뇌는 작은 판단도 큰 판단과 거의 같은 방식으로 처리해서 매번 무언가를 씁니다. 게다가 얼굴의 줄은 끝나지 않으니 오늘은 여기까지라고 말할 지점이 없습니다. 그렇게 내린 판단의 대부분은 아무 데로도 이어지지 않습니다. 답장도, 대화도, 약속도 없습니다. 힘만 나가고 돌아오는 것은 거의 없습니다." },
      { type: "p", text: "최근 몇 달이 이랬다면 특별한 일이 아닙니다. Forbes Health가 2024년 OnePoll과 함께 지난 1년간 데이팅 앱을 써 본 미국 성인 1,000명을 조사한 결과, 78%가 번아웃을 겪었다고 답했습니다. 이 피로는 당신이 연애에 서툴다는 뜻이 아니고, 더 많이 넘긴다고 사라지지도 않습니다." },
      { type: "h2", text: "이런 신호가 보이면" },
      { type: "ul", items: [
        "**읽지 않고 넘깁니다.** 이름도 직업도 소개글도 스쳐 지나갈 뿐 남지 않습니다.",
        "**시작된 대화가 멈춰 있습니다.** 메시지를 며칠씩 두고, 나중에 마음이 불편해집니다.",
        "**좋은 소식도 밋밋합니다.** 예전에는 새 매치가 기분을 올려 줬는데 이제는 아무렇지 않습니다.",
        "**심심해서 앱을 엽니다.** 줄 서 있을 때나 침대에서, 뉴스 피드를 열듯이.",
      ] },
      { type: "h2", accent: "green", text: "실제로 도움이 되는 것" },
      { type: "p", text: "앱을 일주일 지우는 것보다 쓰는 방식을 바꾸는 편이 낫습니다. 시간을 정해 두세요. 일주일에 두 번, 이십 분. 시간이 되면 닫습니다. 마흔 개를 훑는 대신 세 개를 제대로 읽습니다. 절대 먼저 말 걸지 않을 매치는 정리하세요. 피하고 있는 받은함도 그 자체로 짐입니다. 대화가 잘 흘러가면 기운이 있을 때 일찍 커피 한잔을 제안하세요." },
      { type: "p", text: "무엇을 판단하게 되는지를 바꾸는 것도 도움이 됩니다. Qulo에는 넘길 줄이 없습니다. 각자 사지선다 질문을 2~4개(유료 플랜에서는 최대 10개) 쓰고 정답을 표시하며, 그 질문을 모두 맞힌 사람과만 매치됩니다. 일부러 느립니다. 한 사람을 제대로 읽는 편이 쉰 명을 걸러 내는 것보다 덜 지칩니다." },
    ],
  },

  zh: {
    term: "滑动疲劳",
    summary:
      "连着几个小时只看照片筛人之后剩下的那种钝钝的疲惫：软件不再有意思，打开它像完成任务，到最后所有人看起来都差不多。",
    blocks: [
      { type: "h2", text: "为什么筛脸这么累" },
      { type: "p", text: "每一份资料都在要求你做一个决定，而大脑处理小决定和大决定的方式差不多，每一次都要消耗一点。面孔的队列没有尽头，所以永远没有一个「今天到此为止」的时刻。再加上这些决定大多没有下文——没有回复，没有对话，也没有见面——力气一直往外走，回来的却几乎没有。" },
      { type: "p", text: "如果你最近几个月就是这样，这并不特别。Forbes Health 在 2024 年联合 OnePoll，对过去一年用过交友软件的 1,000 名美国成年人做的调查中，78% 的人表示自己出现了倦怠。这种疲惫说明不了你在感情里的好坏，也不会因为多滑几下就消失。" },
      { type: "h2", text: "怎么判断自己累了" },
      { type: "ul", items: [
        "**不看内容就往下滑。** 名字、职业、整段自我介绍从眼前过去，什么都没留下。",
        "**开了头的对话搁在那里。** 消息放好几天不回，回过头来又觉得过意不去。",
        "**好消息也没感觉。** 从前配对成功还能高兴一下，现在毫无波澜。",
        "**无聊时才打开。** 排队时、睡前，跟刷新闻的手势一模一样。",
      ] },
      { type: "h2", accent: "green", text: "真正管用的做法" },
      { type: "p", text: "把软件卸载一周，不如换个用法。给自己定时间：一周两次，每次二十分钟，时间到就关掉。与其扫四十份资料，不如认真读三份。把明知不会去搭话的配对清掉——一个你在躲的收件箱本身就是负担。聊得顺利的时候，趁自己还有兴致，早点约一杯咖啡。" },
      { type: "p", text: "换掉「让你判断什么」也有用。Qulo 没有可以滑的队列：每个人写 2 到 4 道四选一的题目并标出正确答案（付费方案最多 10 道），只有全部答对才会配对成功。这是有意放慢的。认真读懂一个人，比筛掉五十个人省力。" },
    ],
  },

  nl: {
    term: "Swipemoeheid",
    summary:
      "Die vlakke vermoeidheid die ontstaat als je uren bezig bent onbekenden op een foto te beoordelen: de app is niet leuk meer, openen voelt als een klus en uiteindelijk lijkt iedereen op elkaar.",
    blocks: [
      { type: "h2", text: "Waarom gezichten sorteren zo moe maakt" },
      { type: "p", text: "Elk profiel vraagt om een beslissing, en je hoofd behandelt kleine beslissingen ongeveer als grote: elke keer gaat er iets af. De rij gezichten houdt nooit op, dus er is geen moment waarop je klaar bent. Daar komt bij dat de meeste van die beslissingen nergens toe leiden — geen antwoord, geen gesprek, geen afspraak. Er gaat energie in en er komt bijna niets terug." },
      { type: "p", text: "Als je laatste maanden er zo uitzagen, ben je geen uitzondering. In een onderzoek van Forbes Health uit 2024, uitgevoerd met OnePoll onder 1.000 volwassen Amerikanen die het jaar ervoor een datingapp hadden gebruikt, gaf 78% aan opgebrand te zijn. Die moeheid zegt niets over hoe goed je hierin bent, en je swipet je er niet uit." },
      { type: "h2", text: "Hoe je het herkent" },
      { type: "ul", items: [
        "**Je swipet zonder te lezen.** Namen, beroepen, hele teksten gaan voorbij en blijven nergens hangen.",
        "**Begonnen gesprekken blijven liggen.** Berichten staan dagen te wachten en daarna voel je je schuldig.",
        "**Goed nieuws doet niets meer.** Een nieuwe match was een klein moment, nu haal je je schouders op.",
        "**Je opent de app uit verveling**, in de rij of in bed, net als een tijdlijn.",
      ] },
      { type: "h2", accent: "green", text: "Wat wel helpt" },
      { type: "p", text: "De app een week verwijderen helpt minder dan veranderen hoe je hem gebruikt. Kies een vast moment: twee keer per week twintig minuten, en daarna dicht. Lees drie profielen echt in plaats van er veertig te scannen. Ruim de matches op waar je toch nooit iets naartoe schrijft; een inbox die je ontwijkt weegt ook. En als een gesprek goed loopt, stel dan vroeg koffie voor, zolang je er nog zin in hebt." },
      { type: "p", text: "Het helpt ook om te veranderen waarover je moet beslissen. Bij Qulo is er geen rij om doorheen te swipen: iedereen schrijft twee tot vier meerkeuzevragen met vier opties en markeert het juiste antwoord, tot tien met een betaald abonnement, en je matcht alleen met iemand die ze allemaal goed heeft. Dat is met opzet traag — één iemand goed lezen kost minder dan er vijftig wegstrepen." },
    ],
  },

  pl: {
    term: "Zmęczenie przesuwaniem",
    summary:
      "To płaskie znużenie, które narasta po godzinach oceniania obcych ludzi po zdjęciu: aplikacja przestaje bawić, otwieranie jej staje się obowiązkiem, a po jakimś czasie wszyscy wyglądają tak samo.",
    blocks: [
      { type: "h2", text: "Dlaczego przeglądanie twarzy tak męczy" },
      { type: "p", text: "Każdy profil domaga się decyzji, a mózg traktuje małe decyzje podobnie jak duże: każda coś kosztuje. Kolejka twarzy nigdy się nie kończy, więc nie ma momentu, w którym można uznać robotę za zrobioną. Do tego większość tych decyzji donikąd nie prowadzi — bez odpowiedzi, bez rozmowy, bez spotkania. Wysiłek wychodzi, a wraca z niego prawie nic." },
      { type: "p", text: "Jeśli tak wyglądały twoje ostatnie miesiące, nie jesteś wyjątkiem. W badaniu Forbes Health z 2024 roku, przeprowadzonym z OnePoll wśród 1000 dorosłych Amerykanów, którzy w ciągu poprzedniego roku korzystali z aplikacji randkowej, 78% zgłosiło wypalenie. To zmęczenie nic nie mówi o tym, jak ci idzie w randkowaniu, i nie mija od intensywniejszego przewijania." },
      { type: "h2", text: "Po czym to poznasz" },
      { type: "ul", items: [
        "**Przesuwasz, nie czytając.** Imiona, zawody, całe opisy przelatują i nic z nich nie zostaje.",
        "**Zaczęte rozmowy stoją.** Wiadomości leżą po kilka dni, a potem robi się głupio.",
        "**Nawet dobra wiadomość nic nie daje.** Kiedyś nowe dopasowanie cieszyło, teraz nie rusza.",
        "**Otwierasz aplikację z nudów** — w kolejce albo w łóżku, tak jak otwiera się serwis z newsami.",
      ] },
      { type: "h2", accent: "green", text: "Co naprawdę pomaga" },
      { type: "p", text: "Skasowanie aplikacji na tydzień pomaga mniej niż zmiana sposobu korzystania. Wyznacz sobie okienko: dwadzieścia minut dwa razy w tygodniu, a po czasie zamykasz. Przeczytaj porządnie trzy profile zamiast przelecieć czterdzieści. Uporządkuj dopasowania, do których i tak nigdy nie napiszesz — skrzynka, której unikasz, też ciąży. A kiedy rozmowa się klei, zaproponuj kawę wcześnie, póki masz na to siłę." },
      { type: "p", text: "Pomaga też zmienić to, o czym w ogóle decydujesz. W Qulo nie ma kolejki do przewijania: każdy pisze od dwóch do czterech pytań z czterema odpowiedziami i zaznacza poprawną, w planie płatnym do dziesięciu, a dopasowanie powstaje tylko wtedy, gdy ktoś odpowie dobrze na wszystkie. To celowo powolne — porządne przeczytanie jednej osoby kosztuje mniej niż odsianie pięćdziesięciu." },
    ],
  },

  sv: {
    term: "Swipetrötthet",
    summary:
      "Den där platta utmattningen som byggs upp när man i timmar sorterar främlingar utifrån ett foto: appen är inte kul längre, att öppna den känns som ett måste och till slut ser alla likadana ut.",
    blocks: [
      { type: "h2", text: "Varför det tröttar att sortera ansikten" },
      { type: "p", text: "Varje profil kräver ett beslut, och hjärnan behandlar små beslut ungefär som stora: varje gång går det åt något. Kön av ansikten tar aldrig slut, så det finns ingen punkt där man är klar. Lägg till att de flesta av besluten inte leder någonstans — inget svar, ingen konversation, ingen träff — så går kraften ut utan att nästan något kommer tillbaka." },
      { type: "p", text: "Om de senaste månaderna sett ut så är du inget undantag. I en undersökning från Forbes Health 2024, gjord tillsammans med OnePoll bland 1 000 vuxna i USA som använt en dejtingapp det senaste året, uppgav 78 % att de känt sig utbrända. Tröttheten säger ingenting om hur bra du är på det här, och den swipar man sig inte ur." },
      { type: "h2", text: "Så känner du igen den" },
      { type: "ul", items: [
        "**Du swipar utan att läsa.** Namn, jobb, hela presentationer passerar utan att fastna.",
        "**Påbörjade samtal blir liggande.** Meddelanden står kvar i dagar och sedan kommer skuldkänslan.",
        "**Även goda nyheter faller platt.** En ny matchning var en liten glädje, nu händer ingenting.",
        "**Du öppnar appen av leda** — i kön eller i sängen, precis som ett nyhetsflöde.",
      ] },
      { type: "h2", accent: "green", text: "Det här hjälper faktiskt" },
      { type: "p", text: "Att radera appen en vecka hjälper mindre än att ändra hur du använder den. Sätt en fast stund: tjugo minuter två gånger i veckan, och stäng när tiden är slut. Läs tre profiler ordentligt i stället för att skumma fyrtio. Rensa bland matchningarna du ändå aldrig kommer att skriva till — en inkorg man undviker väger också. Och när ett samtal går bra, föreslå en fika tidigt, medan orken finns kvar." },
      { type: "p", text: "Det hjälper också att ändra vad du ska ta ställning till. I Qulo finns ingen kö att swipa i: var och en skriver mellan två och fyra flervalsfrågor med fyra alternativ och markerar rätt svar, upp till tio med ett betalt abonnemang, och en matchning uppstår bara om någon har alla rätt. Det är långsamt med flit — att läsa en person ordentligt kostar mindre än att sålla bort femtio." },
    ],
  },

  hi: {
    term: "स्वाइप थकान",
    summary:
      "घंटों सिर्फ़ तस्वीरें देखकर अजनबियों को छाँटते रहने से जो सूनी-सी थकान जमा होती है: ऐप में मज़ा नहीं रहता, उसे खोलना बोझ लगने लगता है और आख़िर में सब चेहरे एक जैसे दिखने लगते हैं।",
    blocks: [
      { type: "h2", text: "चेहरे छाँटना थका क्यों देता है" },
      { type: "p", text: "हर प्रोफ़ाइल आपसे एक फ़ैसला माँगती है, और दिमाग़ छोटे फ़ैसलों को भी लगभग बड़े फ़ैसलों जैसा ही लेता है — हर बार कुछ न कुछ ख़र्च होता है। चेहरों की कतार कभी ख़त्म नहीं होती, इसलिए ऐसा कोई पल आता ही नहीं जब लगे कि काम पूरा हुआ। ऊपर से इनमें से ज़्यादातर फ़ैसले कहीं नहीं पहुँचते — न जवाब, न बातचीत, न मिलने का कोई प्लान। मेहनत जाती है, लौटकर कुछ नहीं आता।" },
      { type: "p", text: "अगर आपके पिछले कुछ महीने ऐसे ही बीते हैं तो यह कोई अनोखी बात नहीं। Forbes Health ने 2024 में OnePoll के साथ मिलकर अमेरिका के उन 1,000 वयस्कों से बात की जिन्होंने पिछले एक साल में कोई डेटिंग ऐप इस्तेमाल किया था; उनमें से 78% ने थककर चूर हो जाने की बात कही। यह थकान इसका पैमाना नहीं है कि आप इस मामले में कितने अच्छे हैं, और और ज़्यादा स्वाइप करने से जाती भी नहीं।" },
      { type: "h2", text: "कैसे पहचानें" },
      { type: "ul", items: [
        "**बिना पढ़े स्वाइप करना।** नाम, काम, पूरा परिचय सामने से गुज़र जाता है और कुछ याद नहीं रहता।",
        "**शुरू हुई बातचीत अटकी रहना।** मैसेज कई दिन पड़े रहते हैं और बाद में बुरा लगता है।",
        "**अच्छी ख़बर भी फीकी लगना।** पहले नया मैच थोड़ा ख़ुश कर देता था, अब कुछ महसूस ही नहीं होता।",
        "**बोरियत में ऐप खोलना** — लाइन में लगे हुए या बिस्तर पर, जैसे कोई फ़ीड खोलते हैं।",
      ] },
      { type: "h2", accent: "green", text: "असल में क्या काम आता है" },
      { type: "p", text: "हफ़्ते भर ऐप हटा देने से ज़्यादा फ़ायदा तरीक़ा बदलने से होता है। एक तय समय रखिए: हफ़्ते में दो बार, बीस मिनट — और समय पूरा होते ही बंद। चालीस प्रोफ़ाइलें सरसरी तौर पर देखने के बजाय तीन को ठीक से पढ़िए। जिन मैचों को कभी मैसेज नहीं करेंगे, उन्हें हटा दीजिए; जिस इनबॉक्स से आप बचते रहते हैं, वह भी एक बोझ है। और बात अच्छी चल रही हो तो जल्दी मिलने का कहिए, जब तक मन में उत्साह बाकी है।" },
      { type: "p", text: "यह भी काम आता है कि आपसे किस चीज़ पर फ़ैसला माँगा जा रहा है, उसे ही बदल दिया जाए। Qulo में स्वाइप की कोई कतार नहीं है: हर व्यक्ति चार-विकल्प वाले दो से चार सवाल लिखता है और सही जवाब चुन देता है, भुगतान वाली योजना में दस तक, और मैच तभी होता है जब सामने वाला उसके सारे सवाल सही कर दे। यह जान-बूझकर धीमा है — एक इंसान को ठीक से पढ़ना पचास को छाँटने से कम थकाता है।" },
    ],
  },
};
