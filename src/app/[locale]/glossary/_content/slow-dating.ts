import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Slow dating — deliberately dating fewer people, with more attention on each:
 * fewer matches, longer conversations, meeting in person sooner.
 *
 * Statistics: none. There is a lot of circulating copy claiming slow daters
 * "have better outcomes" or that some percentage of relationships start this
 * way; none of it traces to a study, so this page describes what people change
 * and what it feels like instead of asserting results. The burnout figure is
 * used once on `swipe-fatigue.ts` and is not repeated here.
 *
 * Qulo angle: deliberately absent. The mechanic is adjacent to slow dating and
 * it would have been easy to end on a pitch, but the swipe-fatigue page already
 * carries one and the useful thing here is the honest expectation-setting in
 * block 7 — the first two weeks feel like a loss, and slowing down does not
 * stop anyone ghosting you. Do not "improve" block 7 into a product mention.
 *
 * Also note: block 2 explicitly refuses the chastity reading. Slow dating gets
 * written up as a rule about waiting to have sex; it is not, and saying so is
 * the difference between describing behaviour and moralising about it.
 *
 * Term names: the English loanword travels (tr/de/fr/es/pt/it/nl/pl/sv), ru
 * uses the transliterated "слоу-дейтинг" that circulates in Russian copy, and
 * ar/ja/ko/zh/hi have real native renderings.
 */
export const slowDating: LocalizedGlossaryEntry = {
  en: {
    term: "Slow dating",
    summary:
      "Dating fewer people on purpose and giving each of them real attention — fewer matches, longer conversations, and meeting in person sooner instead of texting for months.",
    blocks: [
      { type: "h2", text: "Where the idea comes from" },
      { type: "p", text: "For most of the last decade the assumption was that more is better: more matches, more conversations, more chances. Volume turned out to have a price. Attention does not scale — five conversations get a fifth of you each — and the sheer number of options makes every one of them feel replaceable. Slow dating is the correction. Fewer people, and more of you in each of them." },
      { type: "p", text: "It is not a set of rules about waiting, and it has nothing to say about when anyone should sleep with anyone. This is arithmetic, not virtue. The point is not to be slow for its own sake; it is to spend your attention where it has an actual chance of turning into something, instead of spreading it thin across a dozen half-conversations." },
      { type: "h2", text: "What people actually change" },
      { type: "ul", items: [
        "**A cap on open conversations.** Three at a time, not thirteen.",
        "**Meeting sooner, not later.** A coffee in the first week or two, before the texting becomes the whole relationship.",
        "**Real questions early.** What you want, whether you want children, whether this is meant to be serious — asked in one sentence, not saved for month three.",
        "**Fixed times for the app.** Two sittings a week instead of a hundred small check-ins.",
      ] },
      { type: "h2", accent: "green", text: "How to try it" },
      { type: "p", text: "Start by closing things down rather than opening more. Politely end the conversations you have not thought about in a week, and keep two or three. Ask one question you actually want the answer to, and answer theirs properly rather than with a reflex. Suggest something specific — a place, a day, an hour — because the vague version drifts for weeks. And give each person at least two real conversations before you decide anything." },
      { type: "p", text: "Expect the first fortnight to feel like a loss: fewer notifications, a quieter phone, the nagging sense of missing out. What comes back is different. You remember what people told you, and you turn up to a first date with something to say. It will not stop anyone ghosting you — it does mean you spend less on people who were never going to show up." },
    ],
  },

  tr: {
    term: "Slow dating",
    summary:
      "Bilinçli olarak daha az kişiyle, daha çok ilgiyle tanışmak: az eşleşme, uzun sohbetler ve aylarca yazışmak yerine erken buluşmak. Türkçede yavaş flört de deniyor.",
    blocks: [
      { type: "h2", text: "Fikir nereden çıktı" },
      { type: "p", text: "Son on yılın varsayımı çoğun daha iyi olduğuydu: daha çok eşleşme, daha çok sohbet, daha çok şans. Çokluğun bir bedeli olduğu ortaya çıktı. İlgi bölünerek çoğalmıyor; beş sohbet varsa her birine beşte birin düşüyor. Üstelik seçenek sayısı arttıkça her biri yeri kolayca doldurulabilir gibi görünüyor. Slow dating bunun düzeltmesi: daha az kişi, her birine daha çok sen." },
      { type: "p", text: "Bu, beklemeye dair bir kurallar listesi değil; kimin kiminle ne zaman yatacağıyla da ilgisi yok. Mesele erdem değil, basit aritmetik. Amaç yavaş olmak için yavaş olmak da değil; ilgini bir şeye dönüşme ihtimali olan yere harcamak, on iki yarım sohbete serpiştirmek yerine." },
      { type: "h2", text: "İnsanlar aslında neyi değiştiriyor" },
      { type: "ul", items: [
        "**Açık sohbet sayısına sınır.** Aynı anda üç tane, on üç değil.",
        "**Erken buluşmak.** İlk bir iki hafta içinde bir kahve; yazışma ilişkinin kendisi hâline gelmeden.",
        "**Gerçek soruları başta sormak.** Ne istediğin, çocuk isteyip istemediğin, bunun ciddi olup olmadığı — tek cümleyle, üçüncü aya saklamadan.",
        "**Uygulamaya sabit saat.** Haftada iki oturum, gün boyu yüz kere bakmak yerine.",
      ] },
      { type: "h2", accent: "green", text: "Nasıl denenir" },
      { type: "p", text: "Yenilerini açmak yerine kapatmakla başla. Bir haftadır aklına gelmeyen sohbetleri kibarca bitir, iki üç tane kalsın. Cevabını gerçekten merak ettiğin bir soru sor ve karşındakinin sorusuna da refleksle değil, düzgün cevap ver. Somut bir şey öner: yer, gün, saat. Muğlak versiyon haftalarca sürüklenir. Ve bir karar vermeden önce herkese en az iki gerçek sohbet tanı." },
      { type: "p", text: "İlk iki hafta kayıp gibi hissettirecek: daha az bildirim, sessiz bir telefon, bir şeyleri kaçırıyormuşsun hissi. Geri gelen şey ise farklı. İnsanların sana ne anlattığını hatırlıyorsun ve ilk buluşmaya söyleyecek sözle gidiyorsun. Kimsenin seni ortadan kaybolarak terk etmesini engellemez; ama zaten gelmeyecek olan insanlara daha az harcarsın." },
    ],
  },

  de: {
    term: "Slow Dating",
    summary:
      "Bewusst weniger Menschen kennenlernen und jedem davon echte Aufmerksamkeit geben: wenige Matches, längere Gespräche und ein früheres Treffen statt monatelangem Schreiben.",
    blocks: [
      { type: "h2", text: "Woher die Idee kommt" },
      { type: "p", text: "Das letzte Jahrzehnt lief auf der Annahme, mehr sei besser: mehr Matches, mehr Gespräche, mehr Chancen. Die Menge hat einen Preis. Aufmerksamkeit lässt sich nicht vervielfachen — bei fünf Gesprächen bekommt jedes ein Fünftel von dir — und je mehr Optionen es gibt, desto austauschbarer wirkt jede einzelne. Slow Dating ist die Korrektur: weniger Menschen, und von dir mehr bei jedem." },
      { type: "p", text: "Es ist keine Regelsammlung übers Warten und sagt nichts darüber, wann jemand mit jemandem schlafen sollte. Das ist Rechnen, nicht Moral. Es geht nicht darum, langsam zu sein, weil langsam gut klingt, sondern darum, Aufmerksamkeit dort auszugeben, wo tatsächlich etwas daraus werden kann, statt sie auf zwölf halbe Gespräche zu verteilen." },
      { type: "h2", text: "Was Leute konkret ändern" },
      { type: "ul", items: [
        "**Eine Obergrenze für offene Chats.** Drei gleichzeitig, nicht dreizehn.",
        "**Früher treffen statt später.** Ein Kaffee in den ersten ein, zwei Wochen, bevor das Schreiben die ganze Beziehung ist.",
        "**Die echten Fragen früh stellen.** Was du willst, ob du Kinder willst, ob das ernst gemeint ist — in einem Satz, nicht erst im dritten Monat.",
        "**Feste Zeiten für die App.** Zweimal pro Woche hinsetzen statt hundert kurze Blicke am Tag.",
      ] },
      { type: "h2", accent: "green", text: "So probierst du es aus" },
      { type: "p", text: "Fang damit an, Dinge zu schließen, statt neue zu öffnen. Beende freundlich die Gespräche, an die du eine Woche lang nicht gedacht hast, und behalte zwei oder drei. Stell eine Frage, deren Antwort dich wirklich interessiert, und beantworte die Gegenfrage richtig statt im Reflex. Schlag etwas Konkretes vor — Ort, Tag, Uhrzeit — die vage Variante zieht sich wochenlang. Und gib jedem mindestens zwei echte Gespräche, bevor du entscheidest." },
      { type: "p", text: "Die ersten zwei Wochen werden sich nach Verlust anfühlen: weniger Benachrichtigungen, ein stilles Handy, das Gefühl, etwas zu verpassen. Was zurückkommt, ist anderes. Du erinnerst dich, was die Leute erzählt haben, und kommst zum ersten Date mit etwas zu sagen. Ghosting verhindert das nicht — aber du investierst weniger in Menschen, die ohnehin nie aufgetaucht wären." },
    ],
  },

  fr: {
    term: "Slow dating",
    summary:
      "Voir volontairement moins de personnes en accordant à chacune une vraie attention : peu de matchs, des conversations plus longues et une rencontre rapide plutôt que des mois de messages.",
    blocks: [
      { type: "h2", text: "D'où vient l'idée" },
      { type: "p", text: "Pendant dix ans, le postulat a été que plus il y en a, mieux c'est : plus de matchs, plus de conversations, plus de chances. Le volume a un coût. L'attention ne se multiplie pas — cinq conversations, c'est un cinquième de vous dans chacune — et plus il y a d'options, plus chacune paraît remplaçable. Le slow dating est la correction : moins de gens, davantage de vous pour chacun." },
      { type: "p", text: "Ce n'est pas un règlement sur l'attente, et cela ne dit rien du moment où l'on devrait coucher avec quelqu'un. C'est de l'arithmétique, pas de la vertu. L'objectif n'est pas la lenteur pour la lenteur, mais de dépenser son attention là où quelque chose peut réellement naître, au lieu de l'étaler sur douze demi-conversations." },
      { type: "h2", text: "Ce que les gens changent vraiment" },
      { type: "ul", items: [
        "**Un plafond de conversations ouvertes.** Trois à la fois, pas treize.",
        "**Se voir tôt plutôt que tard.** Un café dans les deux premières semaines, avant que les messages ne deviennent toute la relation.",
        "**Les vraies questions dès le début.** Ce que vous cherchez, si vous voulez des enfants, si c'est sérieux — en une phrase, pas au troisième mois.",
        "**Des horaires fixes pour l'appli.** Deux sessions par semaine au lieu de cent coups d'œil.",
      ] },
      { type: "h2", accent: "green", text: "Comment essayer" },
      { type: "p", text: "Commencez par fermer plutôt que par ouvrir. Terminez poliment les conversations auxquelles vous n'avez pas pensé depuis une semaine, et gardez-en deux ou trois. Posez une question dont la réponse vous intéresse vraiment, et répondez à la leur autrement que par réflexe. Proposez quelque chose de précis — un lieu, un jour, une heure — car la version vague traîne des semaines. Et accordez à chacun au moins deux vraies conversations avant de trancher." },
      { type: "p", text: "Les quinze premiers jours ressembleront à une perte : moins de notifications, un téléphone silencieux, l'impression de rater quelque chose. Ce qui revient est d'une autre nature. Vous vous souvenez de ce qu'on vous a raconté et vous arrivez au premier rendez-vous avec quelque chose à dire. Cela n'empêchera personne de disparaître du jour au lendemain, mais vous dépenserez moins pour des gens qui ne seraient jamais venus." },
    ],
  },

  es: {
    term: "Slow dating",
    summary:
      "Conocer a propósito a menos gente y dedicarle atención de verdad a cada persona: pocos matches, conversaciones más largas y quedar pronto en lugar de escribirse durante meses.",
    blocks: [
      { type: "h2", text: "De dónde sale la idea" },
      { type: "p", text: "Durante la última década se dio por hecho que más era mejor: más matches, más conversaciones, más oportunidades. El volumen tiene un precio. La atención no se multiplica —con cinco conversaciones, a cada una le toca un quinto de ti— y cuantas más opciones hay, más reemplazable parece cada una. El slow dating es la corrección: menos gente y más de ti en cada una." },
      { type: "p", text: "No es un reglamento sobre esperar, ni dice nada sobre cuándo acostarse con alguien. Es aritmética, no moral. La gracia no está en ir lento porque suene bien, sino en gastar la atención donde de verdad puede convertirse en algo, en vez de repartirla entre doce conversaciones a medias." },
      { type: "h2", text: "Qué cambia la gente en la práctica" },
      { type: "ul", items: [
        "**Un tope de conversaciones abiertas.** Tres a la vez, no trece.",
        "**Quedar antes, no después.** Un café en la primera o segunda semana, antes de que los mensajes sean toda la relación.",
        "**Las preguntas de verdad, pronto.** Qué buscas, si quieres hijos, si esto va en serio: en una frase, no en el tercer mes.",
        "**Horarios fijos para la app.** Dos ratos por semana en lugar de cien miraditas.",
      ] },
      { type: "h2", accent: "green", text: "Cómo probarlo" },
      { type: "p", text: "Empieza cerrando en vez de abrir. Termina con educación las conversaciones en las que no has pensado en una semana y quédate con dos o tres. Haz una pregunta cuya respuesta te interese de verdad y contesta la suya bien, no por reflejo. Propón algo concreto —un sitio, un día, una hora—, porque la versión vaga se arrastra semanas. Y dale a cada persona al menos dos conversaciones reales antes de decidir nada." },
      { type: "p", text: "Las dos primeras semanas se sentirán como una pérdida: menos notificaciones, un móvil callado, la sospecha de estarte perdiendo algo. Lo que vuelve es otra cosa. Te acuerdas de lo que te contaron y llegas a la primera cita con algo que decir. No evitará que alguien desaparezca sin avisar; sí hace que gastes menos en gente que nunca iba a aparecer." },
    ],
  },

  ar: {
    term: "المواعدة البطيئة",
    summary:
      "أن تتعرّف عن قصد إلى عدد أقل من الناس وتمنح كل واحد منهم انتباهًا حقيقيًا: توافقات أقل، محادثات أطول، ولقاء مبكر بدل مراسلة تمتد شهورًا.",
    blocks: [
      { type: "h2", text: "من أين جاءت الفكرة" },
      { type: "p", text: "ساد طوال العقد الماضي افتراض أن الأكثر أفضل: توافقات أكثر، محادثات أكثر، فرص أكثر. تبيّن أن للكثرة ثمنًا. الانتباه لا يتضاعف؛ خمس محادثات تعني أن كل واحدة تنال خُمسك، وكلما زادت الخيارات بدا كل خيار قابلًا للاستبدال. المواعدة البطيئة هي التصحيح: أشخاص أقل، ونصيب أكبر منك لكل واحد منهم." },
      { type: "p", text: "ليست هذه قائمة قواعد عن الانتظار، ولا تقول شيئًا عن توقيت العلاقة الجسدية بين اثنين. المسألة حساب لا فضيلة. الهدف ليس البطء لأن البطء يبدو جميلًا، بل أن تُنفق انتباهك حيث يمكن أن يتحول فعلًا إلى شيء، بدل أن توزّعه على عشر محادثات ناقصة." },
      { type: "h2", text: "ما الذي يغيّره الناس فعليًا" },
      { type: "ul", items: [
        "**سقف لعدد المحادثات المفتوحة.** ثلاث في الوقت نفسه، لا ثلاث عشرة.",
        "**اللقاء مبكرًا لا متأخرًا.** قهوة في الأسبوع الأول أو الثاني، قبل أن تصير المراسلة هي العلاقة كلها.",
        "**الأسئلة الحقيقية من البداية.** ماذا تريد، هل تريد أطفالًا، هل هذا جدّي — في جملة واحدة، لا في الشهر الثالث.",
        "**أوقات ثابتة للتطبيق.** جلستان في الأسبوع بدل مئة نظرة سريعة.",
      ] },
      { type: "h2", accent: "green", text: "كيف تجرّبها" },
      { type: "p", text: "ابدأ بالإغلاق لا بالفتح. أنهِ بلطف المحادثات التي لم تخطر ببالك منذ أسبوع، وأبقِ اثنتين أو ثلاثًا. اسأل سؤالًا تريد إجابته حقًا، وأجب عن سؤال الطرف الآخر إجابة كاملة لا ردّ فعل سريع. اقترح شيئًا محددًا: مكان ويوم وساعة، فالاقتراح الغامض يتأجل أسابيع. وامنح كل شخص محادثتين حقيقيتين على الأقل قبل أن تحسم رأيك." },
      { type: "p", text: "توقّع أن يبدو الأسبوعان الأولان كخسارة: إشعارات أقل، هاتف هادئ، وإحساس بأنك تفوّت شيئًا. لكن ما يعود مختلف. تتذكّر ما قاله لك الناس، وتصل إلى اللقاء الأول ولديك ما تتحدث عنه. هذا لن يمنع أحدًا من الاختفاء فجأة، لكنه يجعلك تنفق أقل على من لم يكن سيأتي أصلًا." },
    ],
  },

  ru: {
    term: "Слоу-дейтинг",
    summary:
      "Осознанное решение знакомиться с меньшим числом людей, но по-настоящему: мало мэтчей, длинные разговоры и встреча вживую вместо переписки, растянутой на месяцы.",
    blocks: [
      { type: "h2", text: "Откуда взялась идея" },
      { type: "p", text: "Почти всё прошлое десятилетие держалось на допущении, что больше — лучше: больше мэтчей, больше переписок, больше шансов. У количества оказалась цена. Внимание не умножается: пять разговоров — это по пятой части вас в каждом, а чем больше вариантов, тем заменимее выглядит любой из них. Слоу-дейтинг — поправка к этому: меньше людей и больше вас в каждом." },
      { type: "p", text: "Это не свод правил про ожидание и не разговор о том, когда кому с кем спать. Здесь арифметика, а не добродетель. Смысл не в медленности ради медленности, а в том, чтобы тратить внимание там, где из него действительно может что-то вырасти, вместо того чтобы размазывать его по десятку полуразговоров." },
      { type: "h2", text: "Что люди меняют на практике" },
      { type: "ul", items: [
        "**Потолок на число открытых переписок.** Три одновременно, а не тринадцать.",
        "**Встреча раньше, а не позже.** Кофе на первой-второй неделе, пока переписка не стала всеми отношениями.",
        "**Настоящие вопросы в начале.** Что вы ищете, хотите ли детей, всерьёз ли это — одной фразой, а не на третий месяц.",
        "**Фиксированное время для приложения.** Два захода в неделю вместо сотни коротких проверок.",
      ] },
      { type: "h2", accent: "green", text: "Как попробовать" },
      { type: "p", text: "Начните не с новых знакомств, а с закрытия старых. Вежливо завершите переписки, о которых не вспоминали неделю, и оставьте две-три. Задайте вопрос, ответ на который вам правда интересен, и на встречный ответьте по-человечески, а не рефлексом. Предложите конкретное: место, день, час — расплывчатый вариант тянется неделями. И дайте каждому хотя бы два настоящих разговора, прежде чем что-то решать." },
      { type: "p", text: "Первые две недели будут ощущаться как потеря: меньше уведомлений, тихий телефон, чувство, что вы что-то упускаете. Возвращается другое. Вы помните, что вам рассказали, и приходите на первое свидание с темой для разговора. Это не помешает кому-то исчезнуть без объяснений, но вы будете меньше вкладываться в тех, кто и не собирался приходить." },
    ],
  },

  pt: {
    term: "Slow dating",
    summary:
      "Conhecer menos gente de propósito e dar atenção de verdade a cada pessoa: poucos matches, conversas mais longas e um encontro cedo em vez de meses só de mensagem.",
    blocks: [
      { type: "h2", text: "De onde vem a ideia" },
      { type: "p", text: "Na última década partiu-se do princípio de que mais era melhor: mais matches, mais conversas, mais chances. O volume cobrou seu preço. Atenção não se multiplica — com cinco conversas, cada uma fica com um quinto de você — e quanto mais opções existem, mais substituível cada uma parece. O slow dating é a correção: menos gente e mais de você em cada uma." },
      { type: "p", text: "Não é um manual sobre esperar, e não diz nada sobre quando alguém deve transar com alguém. Aqui é aritmética, não virtude. A graça não é ser lento porque soa bonito, e sim gastar a atenção onde ela tem chance real de virar alguma coisa, em vez de espalhá-la por uma dúzia de meias conversas." },
      { type: "h2", text: "O que as pessoas mudam na prática" },
      { type: "ul", items: [
        "**Um limite de conversas abertas.** Três por vez, não treze.",
        "**Encontrar antes, não depois.** Um café na primeira ou segunda semana, antes que a troca de mensagens vire o relacionamento inteiro.",
        "**As perguntas de verdade logo no começo.** O que você quer, se quer filhos, se isso é sério — em uma frase, não no terceiro mês.",
        "**Horário fixo para o app.** Duas sentadas por semana em vez de cem olhadinhas.",
      ] },
      { type: "h2", accent: "green", text: "Como experimentar" },
      { type: "p", text: "Comece fechando, não abrindo. Encerre com educação as conversas em que você não pensou na última semana e fique com duas ou três. Faça uma pergunta cuja resposta você realmente queira ouvir, e responda a dele direito, não no automático. Proponha algo concreto — lugar, dia, hora — porque a versão vaga se arrasta por semanas. E dê a cada pessoa pelo menos duas conversas reais antes de decidir qualquer coisa." },
      { type: "p", text: "As duas primeiras semanas vão parecer perda: menos notificações, celular quieto, aquela sensação de estar ficando de fora. O que volta é outra coisa. Você lembra o que a pessoa contou e chega ao primeiro encontro com assunto. Não vai impedir ninguém de sumir sem explicação, mas você gasta menos com quem nunca ia aparecer." },
    ],
  },

  it: {
    term: "Slow dating",
    summary:
      "Frequentare di proposito meno persone dando a ciascuna attenzione vera: pochi match, conversazioni più lunghe e un incontro presto invece di mesi passati a scriversi.",
    blocks: [
      { type: "h2", text: "Da dove nasce l'idea" },
      { type: "p", text: "Per quasi dieci anni si è dato per scontato che di più fosse meglio: più match, più conversazioni, più occasioni. La quantità ha un prezzo. L'attenzione non si moltiplica — con cinque conversazioni ognuna riceve un quinto di te — e più opzioni ci sono, più ciascuna sembra sostituibile. Lo slow dating è la correzione: meno persone e più di te in ognuna." },
      { type: "p", text: "Non è un regolamento sull'attesa e non dice nulla su quando andare a letto con qualcuno. Qui c'è aritmetica, non virtù. Il punto non è essere lenti perché suona bene, ma spendere l'attenzione dove può davvero diventare qualcosa, invece di distribuirla su dodici mezze conversazioni." },
      { type: "h2", text: "Cosa cambiano davvero le persone" },
      { type: "ul", items: [
        "**Un tetto alle conversazioni aperte.** Tre alla volta, non tredici.",
        "**Vedersi prima, non dopo.** Un caffè nella prima o seconda settimana, prima che i messaggi diventino tutta la relazione.",
        "**Le domande vere subito.** Cosa cerchi, se vuoi figli, se la cosa è seria: in una frase, non al terzo mese.",
        "**Orari fissi per l'app.** Due sedute a settimana invece di cento occhiate.",
      ] },
      { type: "h2", accent: "green", text: "Come provarci" },
      { type: "p", text: "Comincia chiudendo, non aprendo. Chiudi con garbo le conversazioni a cui non pensi da una settimana e tienine due o tre. Fai una domanda di cui vuoi davvero la risposta, e rispondi alla loro per bene, non di riflesso. Proponi qualcosa di preciso — un posto, un giorno, un'ora — perché la versione vaga si trascina per settimane. E concedi a ciascuno almeno due conversazioni vere prima di decidere." },
      { type: "p", text: "Le prime due settimane sembreranno una perdita: meno notifiche, telefono silenzioso, la sensazione di perderti qualcosa. Quello che torna è diverso. Ti ricordi cosa ti hanno raccontato e arrivi al primo appuntamento con qualcosa da dire. Non impedirà a nessuno di sparire, ma spenderai meno per persone che comunque non si sarebbero presentate." },
    ],
  },

  ja: {
    term: "スローデーティング",
    summary:
      "あえて出会う人数を絞り、一人ひとりにきちんと向き合うやり方。マッチは少なく、会話は長く、何か月もメッセージを続けるより早めに会うことを重視します。",
    blocks: [
      { type: "h2", text: "この考え方の出どころ" },
      { type: "p", text: "この十年ほど、前提は「多いほうがいい」でした。マッチも会話もチャンスも多いほうがいい、と。ところが量には代償がありました。注意は増やせません。会話が五つあれば、それぞれに配られるのはあなたの五分の一です。しかも選択肢が増えるほど、どの相手も替えがきくように見えてきます。スローデーティングはその修正です。人数を減らし、一人あたりのあなたを増やす。" },
      { type: "p", text: "これは「待つこと」の規則集ではありませんし、いつ体の関係を持つべきかという話でもありません。徳の問題ではなく算数の問題です。ゆっくりすること自体が目的ではなく、何かに育つ見込みのある場所に注意を使うこと。十二の中途半端な会話に薄く配ってしまわないこと。それだけです。" },
      { type: "h2", text: "実際に変えていること" },
      { type: "ul", items: [
        "**同時進行の会話に上限をつくる。** 同時に三つまで、十三ではなく。",
        "**会うのを後ろ倒しにしない。** 最初の一、二週間でお茶を。メッセージのやり取りが関係のすべてになる前に。",
        "**肝心なことを早めに聞く。** 何を求めているか、子どもを望むか、真剣な話なのか。一文で聞く。三か月目まで取っておかない。",
        "**アプリを開く時間を決める。** 一日に何十回も覗くのではなく、週に二回まとめて。",
      ] },
      { type: "h2", accent: "green", text: "試し方" },
      { type: "p", text: "新しく増やすのではなく、閉じるところから始めます。この一週間思い出しもしなかった会話は、丁寧に切り上げる。残すのは二つか三つ。答えを本当に知りたい質問をひとつ投げて、相手の質問には反射でなくきちんと答える。誘うときは場所と曜日と時間まで具体的に。曖昧な誘いは何週間も宙に浮きます。そして判断する前に、一人につき少なくとも二回は中身のある会話を。" },
      { type: "p", text: "最初の二週間は損をした気分になります。通知は減り、スマホは静かになり、何かを逃している気がする。けれど返ってくるものは別種です。相手が話した内容を覚えていて、初対面の席に話すことを持って行けます。音信不通にされるのを防ぐ効果はありません。ただ、はじめから来る気のなかった人に使う分は確実に減ります。" },
    ],
  },

  ko: {
    term: "슬로 데이팅",
    summary:
      "일부러 만나는 사람 수를 줄이고 한 사람 한 사람에게 진짜 관심을 쓰는 방식. 매치는 적게, 대화는 길게, 몇 달씩 메시지만 주고받는 대신 일찍 만나는 것을 택합니다.",
    blocks: [
      { type: "h2", text: "이 생각이 나온 배경" },
      { type: "p", text: "지난 십 년의 전제는 많을수록 좋다는 것이었습니다. 매치도, 대화도, 기회도 많을수록 낫다고요. 그런데 양에는 값이 붙었습니다. 관심은 늘어나지 않습니다. 대화가 다섯 개면 각각에 돌아가는 건 당신의 오분의 일이고, 선택지가 많아질수록 누구든 대체 가능해 보입니다. 슬로 데이팅은 그 교정입니다. 사람은 줄이고, 한 사람에게 가는 당신을 늘리는 것." },
      { type: "p", text: "기다림에 관한 규칙집이 아니고, 언제 잠자리를 가져야 하는지에 대한 이야기도 아닙니다. 도덕이 아니라 산수입니다. 느린 것 자체가 목적이 아니라, 무언가로 자랄 가능성이 있는 곳에 관심을 쓰자는 이야기입니다. 열두 개의 반쪽짜리 대화에 얇게 펴 바르지 말자는 것이고요." },
      { type: "h2", text: "사람들이 실제로 바꾸는 것" },
      { type: "ul", items: [
        "**열어 두는 대화 수에 상한을 둡니다.** 동시에 세 개, 열세 개가 아니라.",
        "**미루지 않고 일찍 만납니다.** 첫 한두 주 안에 커피 한잔. 메시지가 관계 전부가 되기 전에.",
        "**진짜 질문을 앞에서 합니다.** 무엇을 원하는지, 아이를 원하는지, 진지한 만남인지 — 한 문장으로, 석 달 뒤로 미루지 않고.",
        "**앱을 여는 시간을 정합니다.** 하루에 백 번 들여다보는 대신 일주일에 두 번.",
      ] },
      { type: "h2", accent: "green", text: "이렇게 해 보세요" },
      { type: "p", text: "새로 여는 대신 닫는 일부터 시작하세요. 일주일 동안 떠올리지도 않은 대화는 정중히 마무리하고 두세 개만 남깁니다. 답이 정말 궁금한 질문을 하나 던지고, 상대의 질문에는 반사적으로가 아니라 제대로 답합니다. 제안은 구체적으로 하세요. 장소, 요일, 시간까지. 막연한 제안은 몇 주씩 떠다닙니다. 그리고 무엇을 결정하기 전에 한 사람당 최소 두 번은 내용 있는 대화를 나눠 보세요." },
      { type: "p", text: "첫 이 주는 손해처럼 느껴질 겁니다. 알림은 줄고 휴대폰은 조용해지고, 뭔가 놓치고 있다는 기분이 듭니다. 그런데 돌아오는 것은 다른 종류입니다. 상대가 한 이야기를 기억하게 되고, 첫 만남에 할 말을 가지고 나가게 됩니다. 누군가 말없이 사라지는 걸 막아 주지는 않습니다. 다만 애초에 나올 생각이 없던 사람에게 쓰는 몫이 줄어듭니다." },
    ],
  },

  zh: {
    term: "慢约会",
    summary:
      "有意识地少认识几个人，把注意力真正给到每一个：配对少一些，聊得深一些，早点见面，而不是发几个月的消息。",
    blocks: [
      { type: "h2", text: "这个说法从哪儿来" },
      { type: "p", text: "过去十年的默认前提是「越多越好」：配对越多、对话越多、机会越多。可是数量是要付代价的。注意力没法翻倍——同时聊五个人，每个人只分到五分之一的你——而选项一多，每个人看起来都变得可替换。慢约会就是对这件事的修正：人少一点，给每个人的你多一点。" },
      { type: "p", text: "它不是一套关于「要等多久」的规矩，也没打算讨论谁该在什么时候跟谁上床。这是算术，不是德行。重点不是为了慢而慢，而是把注意力花在真有可能长出点什么的地方，而不是摊薄在十几段半途而废的对话里。" },
      { type: "h2", text: "人们实际上改了什么" },
      { type: "ul", items: [
        "**给同时进行的对话设上限。** 一次三个，不是十三个。",
        "**见面提前，而不是拖后。** 头一两周就约杯咖啡，别让聊天本身变成整段关系。",
        "**该问的早点问。** 你想要什么、想不想要孩子、这段是不是认真的——一句话问清楚，别留到第三个月。",
        "**给软件定时间。** 一周坐下来看两次，而不是一天点开一百回。",
      ] },
      { type: "h2", accent: "green", text: "怎么开始试" },
      { type: "p", text: "先从关掉开始，而不是继续打开。一周都没想起过的对话，礼貌地收尾，留下两三个就够。问一个你真的想知道答案的问题，对方问你时也认真答，别用条件反射的那种回复。约的时候给出具体的地点、日子和时间——含糊的邀约会飘上好几周。做任何判断之前，先跟每个人聊满两次有内容的对话。" },
      { type: "p", text: "头两周会像在亏本：通知变少，手机安静，总觉得错过了什么。但回来的东西是另一种。你记得对方说过什么，第一次见面时手里有话可聊。它挡不住任何人突然消失，只是让你少花力气在本来就不会出现的人身上。" },
    ],
  },

  nl: {
    term: "Slow dating",
    summary:
      "Bewust met minder mensen daten en aan ieder van hen echte aandacht geven: weinig matches, langere gesprekken en sneller afspreken in plaats van maandenlang appen.",
    blocks: [
      { type: "h2", text: "Waar het idee vandaan komt" },
      { type: "p", text: "Het afgelopen decennium gold de aanname dat meer beter is: meer matches, meer gesprekken, meer kansen. Die hoeveelheid heeft een prijs. Aandacht laat zich niet vermenigvuldigen — bij vijf gesprekken krijgt elk een vijfde van jou — en hoe meer opties er zijn, hoe vervangbaarder ieder van hen lijkt. Slow dating is de correctie: minder mensen, en meer van jou bij elk van hen." },
      { type: "p", text: "Het is geen reglement over wachten en het zegt niets over wanneer je met iemand naar bed zou moeten gaan. Dit is rekenwerk, geen deugd. Het gaat er niet om traag te zijn omdat traag mooi klinkt, maar om je aandacht te besteden waar er echt iets uit kan groeien, in plaats van haar over twaalf halve gesprekken uit te smeren." },
      { type: "h2", text: "Wat mensen in de praktijk veranderen" },
      { type: "ul", items: [
        "**Een maximum aan lopende gesprekken.** Drie tegelijk, geen dertien.",
        "**Eerder afspreken dan later.** Koffie in de eerste of tweede week, voordat het appen de hele relatie wordt.",
        "**De echte vragen vroeg.** Wat je zoekt, of je kinderen wilt, of dit serieus bedoeld is — in één zin, niet pas in maand drie.",
        "**Vaste momenten voor de app.** Twee keer per week zitten in plaats van honderd korte blikken.",
      ] },
      { type: "h2", accent: "green", text: "Hoe je het uitprobeert" },
      { type: "p", text: "Begin met afsluiten in plaats van openen. Rond netjes de gesprekken af waar je een week niet aan hebt gedacht en houd er twee of drie over. Stel één vraag waarvan je het antwoord echt wilt weten, en beantwoord die van hen fatsoenlijk in plaats van uit reflex. Stel iets concreets voor — een plek, een dag, een tijd — want de vage versie blijft weken hangen. En gun iedereen minstens twee echte gesprekken voordat je iets beslist." },
      { type: "p", text: "Reken erop dat de eerste twee weken voelen als verlies: minder meldingen, een stille telefoon, het idee dat je iets misloopt. Wat terugkomt is anders. Je onthoudt wat mensen verteld hebben en komt bij een eerste date aan met iets te zeggen. Het houdt niemand tegen die zonder bericht verdwijnt, maar je steekt minder in mensen die toch nooit waren komen opdagen." },
    ],
  },

  pl: {
    term: "Slow dating",
    summary:
      "Świadome poznawanie mniejszej liczby osób i dawanie każdej z nich prawdziwej uwagi: mało dopasowań, dłuższe rozmowy i szybsze spotkanie zamiast miesięcy pisania.",
    blocks: [
      { type: "h2", text: "Skąd wziął się ten pomysł" },
      { type: "p", text: "Przez ostatnią dekadę obowiązywało założenie, że więcej znaczy lepiej: więcej dopasowań, więcej rozmów, więcej szans. Ilość okazała się mieć swoją cenę. Uwagi nie da się pomnożyć — przy pięciu rozmowach każda dostaje jedną piątą ciebie — a im więcej opcji, tym bardziej wymienna wydaje się każda z nich. Slow dating jest korektą: mniej osób i więcej ciebie przy każdej z nich." },
      { type: "p", text: "To nie jest regulamin o czekaniu i nie mówi nic o tym, kiedy z kimś pójść do łóżka. Tu chodzi o arytmetykę, nie o cnotę. Nie o to, żeby być powolnym, bo ładnie brzmi, tylko żeby wydawać uwagę tam, gdzie naprawdę może z niej coś wyrosnąć, zamiast rozsmarowywać ją na kilkunastu połowicznych rozmowach." },
      { type: "h2", text: "Co ludzie realnie zmieniają" },
      { type: "ul", items: [
        "**Limit otwartych rozmów.** Trzy naraz, nie trzynaście.",
        "**Spotkanie wcześniej, nie później.** Kawa w pierwszym albo drugim tygodniu, zanim pisanie stanie się całym związkiem.",
        "**Prawdziwe pytania na starcie.** Czego szukasz, czy chcesz dzieci, czy to ma być poważne — jednym zdaniem, a nie w trzecim miesiącu.",
        "**Stałe pory na aplikację.** Dwa posiedzenia w tygodniu zamiast stu krótkich zerknięć.",
      ] },
      { type: "h2", accent: "green", text: "Jak to wypróbować" },
      { type: "p", text: "Zacznij od zamykania, nie od otwierania. Grzecznie zakończ rozmowy, o których nie pomyślałeś od tygodnia, i zostaw dwie albo trzy. Zadaj jedno pytanie, na które naprawdę chcesz znać odpowiedź, a na ich pytanie odpowiedz porządnie, nie odruchowo. Zaproponuj coś konkretnego — miejsce, dzień, godzinę — bo wersja ogólnikowa ciągnie się tygodniami. I daj każdej osobie przynajmniej dwie prawdziwe rozmowy, zanim cokolwiek zdecydujesz." },
      { type: "p", text: "Pierwsze dwa tygodnie będą przypominać stratę: mniej powiadomień, cichszy telefon, wrażenie, że coś cię omija. To, co wraca, jest innego rodzaju. Pamiętasz, co ci powiedziano, i przychodzisz na pierwszą randkę z tematem. Nikogo to nie powstrzyma przed zniknięciem bez słowa, ale mniej wydasz na ludzi, którzy i tak nigdy by się nie pojawili." },
    ],
  },

  sv: {
    term: "Slow dating",
    summary:
      "Att medvetet dejta färre personer och ge var och en riktig uppmärksamhet: få matchningar, längre samtal och en träff tidigt i stället för månader av meddelanden.",
    blocks: [
      { type: "h2", text: "Var idén kommer ifrån" },
      { type: "p", text: "Under det senaste decenniet har antagandet varit att mer är bättre: fler matchningar, fler samtal, fler chanser. Mängden visade sig ha ett pris. Uppmärksamhet går inte att multiplicera — med fem samtal får varje en femtedel av dig — och ju fler alternativ det finns, desto mer utbytbart känns vart och ett. Slow dating är korrigeringen: färre personer, och mer av dig i var och en." },
      { type: "p", text: "Det är inget regelverk om att vänta och säger ingenting om när någon bör ligga med någon. Det här är räkning, inte dygd. Poängen är inte att vara långsam för att det låter fint, utan att lägga uppmärksamheten där något faktiskt kan växa, i stället för att breda ut den över ett dussin halva samtal." },
      { type: "h2", text: "Vad folk faktiskt ändrar" },
      { type: "ul", items: [
        "**Ett tak för pågående samtal.** Tre åt gången, inte tretton.",
        "**Ses tidigare, inte senare.** En fika första eller andra veckan, innan skrivandet blir hela relationen.",
        "**De riktiga frågorna tidigt.** Vad du vill ha, om du vill ha barn, om det här är menat på allvar — i en mening, inte i månad tre.",
        "**Bestämda tider för appen.** Två stunder i veckan i stället för hundra snabba koll.",
      ] },
      { type: "h2", accent: "green", text: "Så testar du" },
      { type: "p", text: "Börja med att stänga i stället för att öppna. Avsluta vänligt de samtal du inte tänkt på den senaste veckan och behåll två eller tre. Ställ en fråga vars svar du verkligen vill höra, och besvara deras ordentligt i stället för på reflex. Föreslå något konkret — en plats, en dag, en tid — för den vaga varianten driver omkring i veckor. Och ge varje person minst två riktiga samtal innan du bestämmer dig." },
      { type: "p", text: "Räkna med att de första två veckorna känns som en förlust: färre aviseringar, tystare telefon, känslan av att missa något. Det som kommer tillbaka är av ett annat slag. Du minns vad folk har berättat, och du dyker upp på en första träff med något att säga. Det hindrar ingen från att försvinna utan ett ord, men du lägger mindre på personer som ändå aldrig tänkte komma." },
    ],
  },

  hi: {
    term: "स्लो डेटिंग",
    summary:
      "जान-बूझकर कम लोगों से मिलना और हर एक को सचमुच का ध्यान देना: मैच कम, बातचीत लंबी, और महीनों मैसेज करने के बजाय जल्दी मिल लेना।",
    blocks: [
      { type: "h2", text: "यह ख़याल आया कहाँ से" },
      { type: "p", text: "पिछले एक दशक की मान्यता यही रही कि जितना ज़्यादा, उतना अच्छा — ज़्यादा मैच, ज़्यादा बातचीत, ज़्यादा मौक़े। पर संख्या की क़ीमत भी चुकानी पड़ी। ध्यान बढ़ता नहीं है; पाँच बातचीत चल रही हों तो हर एक के हिस्से आपका पाँचवाँ भाग ही आता है। और विकल्प जितने बढ़ते हैं, हर इंसान उतना ही आसानी से बदला जा सकने वाला लगने लगता है। स्लो डेटिंग इसी की काट है: लोग कम, और हर एक को आप ज़्यादा।" },
      { type: "p", text: "यह इंतज़ार करने के नियमों की सूची नहीं है, और इससे इसका कोई लेना-देना नहीं कि किसे कब शारीरिक रिश्ते में जाना चाहिए। यह गणित है, नैतिकता नहीं। मक़सद धीमे होने के लिए धीमे होना नहीं, बल्कि ध्यान वहाँ ख़र्च करना है जहाँ उससे सचमुच कुछ बन सकता हो — बारह अधूरी बातचीतों में बाँट देने के बजाय।" },
      { type: "h2", text: "लोग असल में क्या बदलते हैं" },
      { type: "ul", items: [
        "**चालू बातचीत की एक हद।** एक साथ तीन, तेरह नहीं।",
        "**मिलना जल्दी, टालना नहीं।** पहले या दूसरे हफ़्ते में एक कॉफ़ी — इससे पहले कि मैसेज करना ही पूरा रिश्ता बन जाए।",
        "**असली सवाल शुरू में।** आप क्या चाहते हैं, बच्चे चाहिए या नहीं, बात गंभीर है या नहीं — एक वाक्य में, तीसरे महीने के लिए बचाकर नहीं।",
        "**ऐप के लिए तय समय।** दिन में सौ बार झाँकने के बजाय हफ़्ते में दो बार बैठकर।",
      ] },
      { type: "h2", accent: "green", text: "आज़माएँ कैसे" },
      { type: "p", text: "नई बातचीत खोलने से नहीं, पुरानी बंद करने से शुरू कीजिए। जिन बातचीतों का हफ़्ते भर से ख़याल तक नहीं आया, उन्हें शालीनता से ख़त्म कीजिए और दो-तीन रख लीजिए। एक सवाल पूछिए जिसका जवाब आप सचमुच जानना चाहते हैं, और उनके सवाल का जवाब आदतन नहीं, ठीक से दीजिए। मिलने का प्रस्ताव ठोस रखिए — जगह, दिन, समय — क्योंकि गोल-मोल न्योता हफ़्तों लटका रहता है। और कोई नतीजा निकालने से पहले हर व्यक्ति को कम से कम दो असली बातचीत दीजिए।" },
      { type: "p", text: "पहले दो हफ़्ते नुक़सान जैसे लगेंगे: कम नोटिफिकेशन, चुप पड़ा फ़ोन, और यह खटक कि कुछ छूट रहा है। लेकिन जो लौटकर आता है वह अलग किस्म का होता है। लोगों ने जो बताया वह आपको याद रहता है, और पहली मुलाक़ात पर आप कुछ कहने के साथ पहुँचते हैं। इससे कोई अचानक ग़ायब होना बंद नहीं कर देगा; बस उन लोगों पर आपका ख़र्च कम हो जाएगा जो कभी आने वाले ही नहीं थे।" },
    ],
  },
};
