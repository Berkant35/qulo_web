import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Cloaking — ghosting plus a block on every channel, so no trace of the person
 * or the conversation is left behind.
 *
 * Judgement calls a later editor should not undo by accident:
 *
 * - This page's whole job is the boundary with `ghosting`. Ghosting = silence;
 *   cloaking = silence AND erasure (block, deleted thread, vanished profile),
 *   often after a no-show. Every locale opens on that contrast with its own
 *   image (door closed vs. door taken off the wall) and returns to it in the
 *   closing paragraph. If you edit one locale, keep the contrast intact.
 *
 * - No "report them" advice, in any locale. Qulo has no moderation team, no ID
 *   verification and no fake-profile detection; telling a reader on a Qulo page
 *   to report a profile implies a review process that does not exist. The
 *   practical block instead tells them what to do with the evening.
 *
 * - We do not say why someone cloaks. The motives listed (avoiding a
 *   confrontation, fear, never intending to come, a blanket blocking habit) are
 *   offered as things that cannot be told apart from the outside, precisely so
 *   the page does not diagnose the person doing it. No statistic is available
 *   for cloaking and none is invented — the burnout figure belongs on
 *   `ghosting`, where it fits, and is deliberately not repeated here.
 *
 * - Term names. Most locales keep the loanword. `ar` uses الكلوكينغ, `ru`
 *   клоакинг, `ja` クローキング, `ko` 클로킹, `hi` क्लोकिंग. `zh` uses
 *   拉黑式消失 ("disappearing by blocking"), which is what a Chinese reader
 *   would actually say, with "cloaking" named in the summary; it is built the
 *   same way as the other three zh terms in this cluster so they read as a set.
 *
 * - The no-show example is deliberately concrete (standing outside a
 *   restaurant) because that is the situation the reader is usually in when
 *   they search this word. Localised, not translated literally.
 */
export const cloaking: LocalizedGlossaryEntry = {
  en: {
    term: "Cloaking",
    summary:
      "Being blocked and deleted at the same moment someone stops replying — sometimes right after they leave you waiting at a restaurant — so no thread, no profile and nobody to ask is left behind.",
    blocks: [
      { type: "h2", text: "Ghosting with the exit sealed behind them" },
      { type: "p", text: "Ghosting shuts the door. Cloaking takes the door off the wall. The other person stops answering and, in the same minute, blocks you — on the app, on your phone, on every account where you could still see them. The match vanishes. The chat vanishes. Search their name and nothing comes back. It often lands right after a date has been agreed, and sometimes while you are already sitting at the table." },
      { type: "p", text: "The reasons are wildly different from one another, and from the outside there is no way to tell which one you got. Some people are dodging a confrontation they expect to go badly. Some got frightened. Some never intended to turn up. And some block everyone the moment they decide something is finished — a habit, not a verdict on you." },
      { type: "h2", text: "How it differs from a plain no-show" },
      { type: "ul", items: [
        "**Stood up and erased at once.** They did not arrive, and by the time you texted, the number was already blocked.",
        "**The conversation is gone.** Not unread — deleted, along with the match itself.",
        "**Every channel closes together.** App, phone, socials, all inside the same hour.",
        "**No profile is left to check.** You search and nothing comes back, as though you invented them.",
      ] },
      { type: "h2", accent: "green", text: "What to do with the rest of that evening" },
      { type: "p", text: "If you are standing outside a restaurant right now: go in and eat, or go home. Do not give it ninety minutes. After that, leave the block alone — no new number, no borrowed account, no second profile. Getting around it will not produce an explanation, and it turns a bad evening into something you have to apologise for later. Tell one friend out loud tonight what happened. It shrinks the moment it stops living only in your head." },
      { type: "p", text: "Cloaking stings differently from ghosting, and not because of how much you liked them. Ghosting leaves you holding a question with no answer. Cloaking takes away the place the question lived: no thread to reread, no profile to check, no trace of the last three weeks. That is disorienting, and it fades. None of it was a measurement of you." },
    ],
  },
  tr: {
    term: "Cloaking",
    summary:
      "Birinin cevap vermeyi bırakmasıyla aynı anda seni her yerden engelleyip silmesi — bazen buluşmaya gelmeyip kaybolduktan hemen sonra; geriye ne sohbet kalır ne profil.",
    blocks: [
      { type: "h2", text: "Çıkışın arkadan örüldüğü ghosting" },
      { type: "p", text: "Ghosting kapıyı kapatır; cloaking kapıyı duvardan söker. Karşı taraf cevap vermeyi bırakır ve aynı dakika içinde seni engeller: uygulamada, telefonda, onu hâlâ görebileceğin her hesapta. Eşleşme kaybolur. Sohbet kaybolur. Adını arattığında hiçbir şey çıkmaz. Genelde buluşma sözü verildikten hemen sonra olur; bazen sen çoktan masaya oturmuşken." },
      { type: "p", text: "Sebepler birbirinden çok farklı olabiliyor ve dışarıdan hangisi olduğunu anlamanın yolu yok. Kimi kötü geçeceğini düşündüğü bir yüzleşmeden kaçıyor. Kimi korkuyor. Kimi zaten gelmeyi hiç düşünmemiş. Kimi de bir şeyin bittiğine karar verir vermez herkesi engelliyor — bu bir alışkanlık, senin hakkında verilmiş bir hüküm değil." },
      { type: "h2", text: "Sadece gelmemekten farkı ne" },
      { type: "ul", items: [
        "**Hem ekildin hem silindin.** Gelmedi ve sen mesaj attığında numara çoktan engellenmişti.",
        "**Sohbet ortada yok.** Okunmamış değil; eşleşmeyle birlikte tamamen silinmiş.",
        "**Bütün kanallar aynı anda kapanır.** Uygulama, telefon, sosyal medya — hepsi aynı saat içinde.",
        "**Bakacak bir profil kalmaz.** Arattığında hiçbir sonuç çıkmaz; sanki onu sen uydurmuşsun gibi.",
      ] },
      { type: "h2", accent: "green", text: "O akşamın kalanını ne yapmalı" },
      { type: "p", text: "Şu anda bir restoranın önünde bekliyorsan: ya içeri girip yemeğini ye ya da eve dön. Doksan dakika verme. Sonrasında engeli olduğu gibi bırak — yeni numara yok, arkadaşının hesabı yok, ikinci profil yok. Etrafından dolaşmak sana bir açıklama kazandırmaz; kötü bir akşamı sonradan özür dilemen gereken bir şeye çevirir. Bu gece olanları bir arkadaşına sesli olarak anlat. Sadece kafanın içinde yaşamayı bıraktığı anda küçülür." },
      { type: "p", text: "Cloaking, ghosting'den farklı bir yerden acıtır ve bunun onu ne kadar sevdiğinle ilgisi yoktur. Ghosting elinde cevapsız bir soru bırakır. Cloaking sorunun yaşadığı yeri de alıp götürür: tekrar okunacak sohbet yok, bakılacak profil yok, üç haftanın izi yok. Bu insanı sersemletir ve geçer. Hiçbiri seninle ilgili bir ölçüm değildi." },
    ],
  },
  de: {
    term: "Cloaking",
    summary:
      "Blockiert und gelöscht zu werden in genau dem Moment, in dem jemand aufhört zu antworten – manchmal direkt nachdem er dich im Restaurant hat warten lassen. Es bleibt kein Chat und kein Profil übrig.",
    blocks: [
      { type: "h2", text: "Ghosting, bei dem der Ausgang zugemauert wird" },
      { type: "p", text: "Ghosting schließt die Tür. Cloaking reißt sie aus der Wand. Die andere Person antwortet nicht mehr und blockiert dich in derselben Minute: in der App, auf dem Handy, in jedem Profil, in dem du sie noch sehen konntest. Das Match ist weg. Der Chat ist weg. Du suchst den Namen und findest nichts. Oft passiert es kurz nachdem ein Date vereinbart wurde – manchmal, während du schon am Tisch sitzt." },
      { type: "p", text: "Die Gründe gehen weit auseinander, und von außen ist nicht zu erkennen, welcher zutrifft. Manche weichen einer Auseinandersetzung aus, die sie für unangenehm halten. Manche bekommen es mit der Angst zu tun. Manche wollten nie auftauchen. Und manche blockieren grundsätzlich alle, sobald für sie etwas vorbei ist – Gewohnheit, kein Urteil über dich." },
      { type: "h2", text: "Was es von einem einfachen Nichterscheinen unterscheidet" },
      { type: "ul", items: [
        "**Versetzt und gelöscht in einem Zug.** Die Person kam nicht, und als du geschrieben hast, war die Nummer schon blockiert.",
        "**Der Chat existiert nicht mehr.** Nicht ungelesen – gelöscht, zusammen mit dem Match.",
        "**Alle Kanäle schließen gleichzeitig.** App, Handy, soziale Netzwerke, alles in derselben Stunde.",
        "**Es bleibt kein Profil zum Nachsehen.** Du suchst und findest nichts, als hättest du dir alles ausgedacht.",
      ] },
      { type: "h2", accent: "green", text: "Was du mit dem Rest des Abends machst" },
      { type: "p", text: "Wenn du gerade vor einem Restaurant stehst: Geh rein und iss, oder geh nach Hause. Warte keine anderthalb Stunden. Und lass danach die Blockade in Ruhe – keine neue Nummer, kein geliehener Account, kein Zweitprofil. Daran vorbeizukommen bringt dir keine Erklärung, sondern macht aus einem schlechten Abend etwas, wofür du dich später entschuldigen musst. Erzähl heute noch einer vertrauten Person laut, was passiert ist. Es schrumpft, sobald es nicht mehr nur in deinem Kopf lebt." },
      { type: "p", text: "Cloaking trifft anders als Ghosting, und das hat nichts damit zu tun, wie sehr du die Person mochtest. Ghosting lässt dich mit einer offenen Frage zurück. Cloaking nimmt dir auch noch den Ort, an dem die Frage stand: kein Chat zum Nachlesen, kein Profil, kein Beleg für die letzten drei Wochen. Das verwirrt – und es geht vorbei. Ein Urteil über dich war nichts davon." },
    ],
  },
  fr: {
    term: "Cloaking",
    summary:
      "Le fait d'être bloqué et effacé au moment précis où l'autre cesse de répondre, parfois juste après vous avoir posé un lapin : il ne reste ni conversation, ni profil, ni personne à qui demander.",
    blocks: [
      { type: "h2", text: "Un ghosting dont la sortie est murée" },
      { type: "p", text: "Le ghosting ferme la porte. Le cloaking l'arrache du mur. L'autre cesse de répondre et, dans la même minute, vous bloque : sur l'application, sur votre téléphone, sur chaque compte où vous pouviez encore le voir. Le match disparaît. La conversation disparaît. Vous cherchez son nom et il n'y a rien. Cela arrive souvent juste après qu'un rendez-vous a été fixé, parfois pendant que vous êtes déjà attablé." },
      { type: "p", text: "Les raisons varient énormément et, de l'extérieur, impossible de savoir laquelle vous est tombée dessus. Certains fuient une confrontation qu'ils redoutent. D'autres ont pris peur. D'autres n'avaient jamais prévu de venir. Et certains bloquent tout le monde dès qu'ils considèrent qu'une histoire est finie : une habitude, pas un verdict sur vous." },
      { type: "h2", text: "Ce qui le distingue d'un simple lapin" },
      { type: "ul", items: [
        "**Posé et effacé d'un coup.** La personne n'est pas venue, et quand vous avez écrit, le numéro était déjà bloqué.",
        "**La conversation n'existe plus.** Pas non lue : supprimée, avec le match lui-même.",
        "**Tous les canaux se ferment en même temps.** Application, téléphone, réseaux sociaux, dans la même heure.",
        "**Il ne reste aucun profil à consulter.** Vous cherchez et rien ne remonte, comme si vous l'aviez inventé.",
      ] },
      { type: "h2", accent: "green", text: "Quoi faire du reste de la soirée" },
      { type: "p", text: "Si vous êtes devant un restaurant à cet instant : entrez et mangez, ou rentrez. N'accordez pas une heure et demie. Ensuite, laissez le blocage tranquille — pas de nouveau numéro, pas de compte emprunté, pas de second profil. Le contourner ne produira aucune explication et transformera une mauvaise soirée en quelque chose dont vous devrez vous excuser. Racontez la scène à voix haute à un ami ce soir. Elle rétrécit dès qu'elle cesse de vivre uniquement dans votre tête." },
      { type: "p", text: "Le cloaking pique autrement que le ghosting, et ce n'est pas une question d'attachement. Le ghosting vous laisse une question sans réponse. Le cloaking supprime aussi l'endroit où vivait la question : plus de conversation à relire, plus de profil à vérifier, plus aucune trace des trois dernières semaines. C'est désorientant, et ça passe. Rien là-dedans ne mesurait votre valeur." },
    ],
  },
  es: {
    term: "Cloaking",
    summary:
      "Que te bloqueen y te borren en el mismo momento en que dejan de responder, a veces justo después de dejarte plantado: no queda ni conversación, ni perfil, ni a quién preguntar.",
    blocks: [
      { type: "h2", text: "Un ghosting con la salida tapiada" },
      { type: "p", text: "El ghosting cierra la puerta. El cloaking la arranca de la pared. La otra persona deja de contestar y, en el mismo minuto, te bloquea: en la app, en el teléfono, en cada cuenta donde todavía podías verla. El match desaparece. La conversación desaparece. Buscas su nombre y no sale nada. Suele ocurrir justo después de cerrar una cita, y a veces cuando ya estás sentado a la mesa." },
      { type: "p", text: "Los motivos son muy distintos entre sí y desde fuera no hay manera de saber cuál te ha tocado. Hay quien esquiva una confrontación que da por perdida. Hay quien se asusta. Hay quien nunca pensó en presentarse. Y hay quien bloquea a todo el mundo en cuanto decide que algo se acabó: es una costumbre, no un veredicto sobre ti." },
      { type: "h2", text: "En qué se diferencia de un simple plantón" },
      { type: "ul", items: [
        "**Te dejó plantado y te borró a la vez.** No apareció, y cuando escribiste el número ya estaba bloqueado.",
        "**La conversación no está.** No sin leer: borrada, junto con el match.",
        "**Todos los canales se cierran a la vez.** App, teléfono, redes, todo en la misma hora.",
        "**No queda perfil que mirar.** Buscas y no aparece nada, como si te lo hubieras inventado.",
      ] },
      { type: "h2", accent: "green", text: "Qué hacer con el resto de la noche" },
      { type: "p", text: "Si estás ahora mismo en la puerta de un restaurante: entra y cena, o vete a casa. No le des hora y media. Después, deja el bloqueo donde está: nada de números nuevos, cuentas prestadas ni segundos perfiles. Saltárselo no te va a dar una explicación y convierte una mala noche en algo por lo que luego tendrás que pedir perdón. Cuéntaselo esta noche en voz alta a alguien. Encoge en cuanto deja de vivir solo en tu cabeza." },
      { type: "p", text: "El cloaking duele de otra forma que el ghosting, y no por lo mucho que te gustaba esa persona. El ghosting te deja con una pregunta sin respuesta. El cloaking se lleva además el lugar donde vivía la pregunta: no hay chat que releer, ni perfil que mirar, ni rastro de esas tres semanas. Desorienta, y se pasa. Nada de eso medía cuánto vales." },
    ],
  },
  ar: {
    term: "الكلوكينغ",
    summary:
      "أن يحظرك الشخص ويمحو كل أثر له في اللحظة نفسها التي يتوقف فيها عن الرد، أحيانًا بعد أن يتركك تنتظره في المطعم؛ فلا تبقى محادثة ولا حساب ولا أحد تسأله.",
    blocks: [
      { type: "h2", text: "غوستينغ يُغلق فيه الباب ثم يُردم" },
      { type: "p", text: "الغوستينغ يغلق الباب، أما الكلوكينغ فيقتلع الباب من الجدار. يتوقف الطرف الآخر عن الرد، وفي الدقيقة نفسها يحظرك: في التطبيق، وفي هاتفك، وفي كل حساب كان بإمكانك أن تراه فيه. يختفي التطابق، وتختفي المحادثة، وتبحث عن اسمه فلا تجد شيئًا. يحدث هذا غالبًا بعد الاتفاق على موعد مباشرة، وأحيانًا وأنت جالس إلى الطاولة بالفعل." },
      { type: "p", text: "الأسباب متباعدة جدًا، ولا سبيل من الخارج لمعرفة أيها وقع لك. بعضهم يتجنّب مواجهة يظن أنها ستسوء. وبعضهم خاف. وبعضهم لم ينوِ الحضور أصلًا. وبعضهم يحظر الجميع بمجرد أن يقرر أن الأمر انتهى؛ هذه عادة عنده، لا حكم عليك." },
      { type: "h2", text: "ما الذي يميّزه عن مجرد عدم الحضور" },
      { type: "ul", items: [
        "**تُرِكت وأُزيلت في آن واحد.** لم يحضر، وحين راسلته كان الرقم محظورًا بالفعل.",
        "**المحادثة اختفت.** ليست غير مقروءة، بل محذوفة مع التطابق نفسه.",
        "**كل القنوات تُغلق دفعة واحدة.** التطبيق والهاتف وحسابات التواصل، خلال الساعة نفسها.",
        "**لا يبقى حساب تعود إليه.** تبحث فلا يظهر شيء، كأنك تخيّلت الشخص من عندك.",
      ] },
      { type: "h2", accent: "green", text: "ماذا تفعل ببقية تلك الليلة" },
      { type: "p", text: "إن كنت واقفًا أمام مطعم الآن: ادخل وتناول عشاءك، أو عد إلى البيت. لا تمنحه ساعة ونصفًا. ثم اترك الحظر كما هو — لا رقم جديد، ولا حساب مستعار، ولا ملف ثانٍ. الالتفاف حوله لن يمنحك تفسيرًا، وسيحوّل ليلة سيئة إلى شيء تعتذر عنه لاحقًا. احكِ ما جرى بصوت عالٍ لصديق هذه الليلة؛ الحكاية تصغر حالما تتوقف عن العيش في رأسك وحده." },
      { type: "p", text: "الكلوكينغ يؤلم بطريقة مختلفة عن الغوستينغ، ولا علاقة لذلك بمدى تعلّقك بالشخص. الغوستينغ يتركك مع سؤال بلا جواب. أما الكلوكينغ فيأخذ معه المكان الذي كان السؤال يعيش فيه: لا محادثة تعيد قراءتها، ولا حساب تتفقده، ولا أثر للأسابيع الثلاثة الماضية. هذا مربك، ثم يزول. ولم يكن أي منه قياسًا لقيمتك." },
    ],
  },
  ru: {
    term: "клоакинг",
    summary:
      "Ситуация, когда человек одновременно перестаёт отвечать и блокирует вас везде — иногда сразу после того, как не пришёл на свидание. Не остаётся ни переписки, ни анкеты, ни кого спросить.",
    blocks: [
      { type: "h2", text: "Гостинг, за которым замуровали выход" },
      { type: "p", text: "Гостинг закрывает дверь. Клоакинг вынимает её из стены. Человек перестаёт отвечать и в ту же минуту блокирует вас: в приложении, в телефоне, во всех аккаунтах, где вы могли его видеть. Совпадение исчезает. Переписка исчезает. Вы ищете имя — и не находите ничего. Чаще всего это происходит сразу после того, как встреча назначена, а иногда пока вы уже сидите за столиком." },
      { type: "p", text: "Причины бывают очень разные, и снаружи не понять, какая именно. Кто-то уходит от разговора, который заранее считает тяжёлым. Кто-то испугался. Кто-то и не собирался приходить. А кто-то блокирует всех подряд, как только решил, что история закончена, — это привычка, а не приговор вам." },
      { type: "h2", text: "Чем это отличается от обычного «не пришёл»" },
      { type: "ul", items: [
        "**Вас не дождались и стёрли.** Человек не пришёл, а когда вы написали, номер уже был в блоке.",
        "**Переписки нет.** Не непрочитанная — удалённая, вместе с самим совпадением.",
        "**Все каналы закрываются разом.** Приложение, телефон, соцсети — всё в течение часа.",
        "**Не осталось анкеты, чтобы проверить.** Ищете — и пусто, как будто вы всё выдумали.",
      ] },
      { type: "h2", accent: "green", text: "Что делать с остатком вечера" },
      { type: "p", text: "Если вы прямо сейчас стоите у ресторана: зайдите и поужинайте или поезжайте домой. Не давайте этому полтора часа. Дальше оставьте блокировку в покое — никаких новых номеров, чужих аккаунтов и вторых анкет. Обойти её не значит получить объяснение; так плохой вечер превращается в то, за что потом извиняются. Расскажите вслух одному другу, что случилось. История уменьшается, как только перестаёт жить только у вас в голове." },
      { type: "p", text: "Клоакинг задевает иначе, чем гостинг, и дело не в том, насколько человек вам нравился. Гостинг оставляет вопрос без ответа. Клоакинг забирает и то место, где этот вопрос жил: нечего перечитать, некуда заглянуть, нет следов последних трёх недель. Это дезориентирует — и проходит. Ничто из этого вас не измеряло." },
    ],
  },
  pt: {
    term: "Cloaking",
    summary:
      "Ser bloqueado e apagado no mesmo instante em que a pessoa para de responder, às vezes logo depois de te deixar esperando no restaurante: não sobra conversa, nem perfil, nem a quem perguntar.",
    blocks: [
      { type: "h2", text: "Ghosting com a saída lacrada" },
      { type: "p", text: "O ghosting fecha a porta. O cloaking arranca a porta da parede. A pessoa para de responder e, no mesmo minuto, te bloqueia: no app, no telefone, em cada conta em que você ainda podia vê-la. O match some. A conversa some. Você procura o nome e não aparece nada. Costuma acontecer logo depois de um encontro combinado — às vezes com você já sentado à mesa." },
      { type: "p", text: "Os motivos são bem diferentes entre si e, de fora, não dá para saber qual foi. Tem quem esteja fugindo de uma conversa que imagina difícil. Tem quem tenha se assustado. Tem quem nunca pensou em aparecer. E tem quem bloqueie todo mundo assim que decide que acabou: é um hábito, não um veredito sobre você." },
      { type: "h2", text: "O que diferencia isso de um cano comum" },
      { type: "ul", items: [
        "**Levou um cano e foi apagado junto.** A pessoa não apareceu e, quando você mandou mensagem, o número já estava bloqueado.",
        "**A conversa sumiu.** Não é não lida: foi apagada, junto com o próprio match.",
        "**Todos os canais fecham de uma vez.** App, telefone, redes sociais, tudo dentro da mesma hora.",
        "**Não sobra perfil para olhar.** Você pesquisa e não volta nada, como se tivesse inventado a pessoa.",
      ] },
      { type: "h2", accent: "green", text: "O que fazer com o resto da noite" },
      { type: "p", text: "Se você está parado na porta de um restaurante agora: entre e coma, ou vá para casa. Não dê uma hora e meia. Depois, deixe o bloqueio quieto — nada de número novo, conta emprestada ou segundo perfil. Passar por cima não vai render explicação nenhuma e transforma uma noite ruim em algo pelo qual você vai ter que pedir desculpa. Conte em voz alta para um amigo hoje. A história encolhe assim que para de morar só na sua cabeça." },
      { type: "p", text: "O cloaking dói de um jeito diferente do ghosting, e não é pelo tamanho do envolvimento. O ghosting deixa você com uma pergunta sem resposta. O cloaking leva junto o lugar onde a pergunta morava: não há conversa para reler, nem perfil para checar, nem prova das últimas três semanas. Isso desorienta, e passa. Nada ali media o seu valor." },
    ],
  },
  it: {
    term: "Cloaking",
    summary:
      "Essere bloccati e cancellati nello stesso istante in cui l'altra persona smette di rispondere, a volte subito dopo averti dato buca: non resta la chat, non resta il profilo, non resta nessuno a cui chiedere.",
    blocks: [
      { type: "h2", text: "Un ghosting con l'uscita murata" },
      { type: "p", text: "Il ghosting chiude la porta. Il cloaking la stacca dal muro. L'altra persona smette di rispondere e nello stesso minuto ti blocca: nell'app, sul telefono, su ogni account dove potevi ancora vederla. Il match sparisce. La chat sparisce. Cerchi il nome e non trovi niente. Spesso succede subito dopo che avete fissato un appuntamento, a volte mentre sei già seduto al tavolo." },
      { type: "p", text: "I motivi sono lontanissimi tra loro e da fuori non si capisce quale ti sia capitato. C'è chi evita un confronto che dà per sgradevole. C'è chi si è spaventato. C'è chi non aveva mai pensato di presentarsi. E c'è chi blocca tutti appena decide che una storia è finita: è un'abitudine, non un giudizio su di te." },
      { type: "h2", text: "Cosa lo distingue da una semplice buca" },
      { type: "ul", items: [
        "**Buca e cancellazione insieme.** Non si è presentato e, quando hai scritto, il numero era già bloccato.",
        "**La chat non c'è più.** Non è da leggere: è cancellata, insieme al match.",
        "**Tutti i canali si chiudono insieme.** App, telefono, social, tutto nella stessa ora.",
        "**Non resta un profilo da controllare.** Cerchi e non torna niente, come se te lo fossi inventato.",
      ] },
      { type: "h2", accent: "green", text: "Cosa fare del resto della serata" },
      { type: "p", text: "Se in questo momento sei davanti a un ristorante: entra e mangia, oppure torna a casa. Non concedere un'ora e mezza. Poi lascia stare il blocco — niente numero nuovo, niente account prestato, niente secondo profilo. Aggirarlo non ti darà una spiegazione e trasforma una brutta serata in qualcosa di cui poi dovrai scusarti. Racconta ad alta voce a un amico cosa è successo, stasera. La cosa si rimpicciolisce appena smette di vivere solo nella tua testa." },
      { type: "p", text: "Il cloaking punge in modo diverso dal ghosting, e non per quanto ti piaceva quella persona. Il ghosting ti lascia una domanda senza risposta. Il cloaking porta via anche il posto in cui la domanda stava: nessuna chat da rileggere, nessun profilo da guardare, nessuna traccia delle ultime tre settimane. Disorienta, e passa. Niente di tutto questo misurava te." },
    ],
  },
  ja: {
    term: "クローキング",
    summary:
      "返信が止まるのと同時に、あらゆる場所でブロックされ、痕跡ごと消される状態。約束をすっぽかされた直後に起きることもあり、やり取りもプロフィールも残りません。",
    blocks: [
      { type: "h2", text: "出口ごとふさがれるゴースティング" },
      { type: "p", text: "ゴースティングは扉を閉めます。クローキングは扉ごと壁から外します。相手は返信をやめ、その同じ一分のうちにあなたをブロックします——アプリでも、電話でも、まだ姿が見えていたすべてのアカウントでも。マッチが消え、トークが消え、名前で検索しても何も出てきません。会う約束をした直後に起きることが多く、あなたがもう店の席に着いているときに起きることもあります。" },
      { type: "p", text: "理由は人によってまったく違い、外からはどれなのか分かりません。気まずくなりそうな話し合いを避けている人もいます。怖くなった人もいます。はじめから来るつもりのなかった人もいます。そして、終わったと決めた瞬間に誰でもブロックする人もいます。それは癖であって、あなたへの評価ではありません。" },
      { type: "h2", text: "ただのドタキャンとの違い" },
      { type: "ul", items: [
        "**すっぽかされたうえに消された。** 相手は来ず、連絡した時点で番号はすでにブロック済み。",
        "**トークが残っていない。** 未読ではなく、マッチごと削除されている。",
        "**すべての窓口が同時に閉じる。** アプリ、電話、SNS——どれも同じ時間帯に。",
        "**確認できるプロフィールがない。** 検索しても何も出ず、自分の作り話だったように感じる。",
      ] },
      { type: "h2", accent: "green", text: "その夜の残りをどう使うか" },
      { type: "p", text: "いま店の前に立っているなら、中に入って食べるか、帰ってください。90分も待たないこと。そのあとはブロックをそのままにしておきます——新しい番号も、人のアカウントも、二つ目のプロフィールも使わない。回り込んでも説明は手に入らず、ただでさえ嫌な夜が、あとで謝る羽目になる夜に変わるだけです。今夜のうちに、起きたことを誰かに声に出して話してください。頭の中だけに住まなくなった瞬間に、話は小さくなります。" },
      { type: "p", text: "クローキングがゴースティングと違う痛み方をするのは、相手をどれだけ好きだったかとは関係ありません。ゴースティングは答えのない問いを残します。クローキングは、その問いが置かれていた場所ごと持ち去ります。読み返すやり取りも、見に行くプロフィールも、この三週間の痕跡もありません。混乱しますが、必ず薄れます。そのどれも、あなたを測ったものではありません。" },
    ],
  },
  ko: {
    term: "클로킹",
    summary:
      "답장이 끊기는 바로 그 순간에 모든 곳에서 차단당하고 흔적까지 지워지는 일. 약속 장소에 나타나지 않은 직후에 벌어지기도 하며, 대화도 프로필도 남지 않습니다.",
    blocks: [
      { type: "h2", text: "출구까지 막아버린 잠수" },
      { type: "p", text: "잠수가 문을 닫는 일이라면, 클로킹은 문을 벽에서 떼어 가는 일입니다. 상대는 답장을 멈추고 같은 1분 안에 당신을 차단합니다. 앱에서도, 전화번호부에서도, 아직 볼 수 있던 모든 계정에서도요. 매칭이 사라지고, 대화방이 사라지고, 이름을 검색해도 아무것도 나오지 않습니다. 만나기로 약속한 직후에 벌어지는 경우가 많고, 이미 자리에 앉아 있을 때 벌어지기도 합니다." },
      { type: "p", text: "이유는 제각각이고, 밖에서는 어느 쪽인지 알 방법이 없습니다. 껄끄러울 것 같은 대화를 피하는 사람도 있고, 겁이 난 사람도 있고, 애초에 나올 생각이 없던 사람도 있습니다. 끝났다고 판단하는 순간 모두를 차단해 버리는 사람도 있습니다. 그건 그 사람의 습관이지, 당신에 대한 판정이 아닙니다." },
      { type: "h2", text: "단순히 안 나온 것과 무엇이 다른가" },
      { type: "ul", items: [
        "**바람맞은 동시에 지워집니다.** 상대는 오지 않았고, 연락했을 땐 이미 번호가 차단돼 있습니다.",
        "**대화방이 없습니다.** 안 읽은 게 아니라, 매칭째로 삭제됐습니다.",
        "**모든 통로가 한꺼번에 닫힙니다.** 앱, 전화, SNS — 전부 같은 시간대에.",
        "**확인할 프로필이 남지 않습니다.** 검색해도 아무것도 안 나와서, 내가 지어낸 사람 같습니다.",
      ] },
      { type: "h2", accent: "green", text: "그날 저녁의 나머지를 쓰는 법" },
      { type: "p", text: "지금 식당 앞에 서 있다면, 들어가서 먹거나 집으로 가세요. 90분씩 기다리지 마세요. 그다음에는 차단을 그대로 두세요. 새 번호도, 남의 계정도, 두 번째 프로필도 쓰지 않는 편이 낫습니다. 우회해도 설명은 얻지 못하고, 나쁜 저녁이 나중에 사과해야 할 일로 바뀝니다. 오늘 밤 안에 누군가에게 소리 내어 이야기해 보세요. 머릿속에만 살지 않게 되는 순간 이야기는 작아집니다." },
      { type: "p", text: "클로킹이 잠수와 다르게 아픈 건, 그 사람을 얼마나 좋아했는지와는 상관이 없습니다. 잠수는 답 없는 질문을 남깁니다. 클로킹은 그 질문이 놓여 있던 자리까지 가져갑니다. 다시 읽을 대화도, 들여다볼 프로필도, 지난 3주의 흔적도 없습니다. 혼란스럽지만 옅어집니다. 그중 어느 것도 당신을 잰 적이 없습니다." },
    ],
  },
  zh: {
    term: "拉黑式消失",
    summary:
      "对方停止回复的同一刻，把你在所有地方拉黑并删干净，有时就发生在放你鸽子之后：聊天没了，资料页也没了，连能问的人都不剩。英文里叫 cloaking。",
    blocks: [
      { type: "h2", text: "把出口一并封死的消失" },
      { type: "p", text: "幽灵式分手是把门关上，拉黑式消失是把门从墙上卸走。对方停止回复，并在同一分钟把你拉黑：约会软件里、手机通讯录里、你还能看到他的每一个账号里。配对没了，聊天记录没了，搜他的名字什么也搜不到。这种事常发生在约好见面之后，有时你已经坐在餐桌前了。" },
      { type: "p", text: "背后的原因差得很远，而且从外面根本判断不出你遇上的是哪一种。有人在躲一场他预感会很难堪的对话。有人是怕了。有人本来就没打算来。也有人只要认定一件事结束了，就习惯性地把所有人都拉黑——那是习惯，不是对你的判决。" },
      { type: "h2", text: "它和单纯放鸽子有什么不同" },
      { type: "ul", items: [
        "**被放鸽子的同时被抹掉。** 人没来，等你发消息时，号码已经被拉黑了。",
        "**聊天记录不在了。** 不是未读，是连同配对一起被删掉。",
        "**所有渠道同时关闭。** 软件、电话、社交账号，都在同一个小时内。",
        "**没有资料页可查。** 一搜什么都没有，像是这个人是你自己编出来的。",
      ] },
      { type: "h2", accent: "green", text: "那天晚上剩下的时间怎么过" },
      { type: "p", text: "如果你此刻正站在餐厅门口：进去吃，或者回家。不要给它一个半小时。接下来，别去动那道拉黑——不换号码，不借账号，不注册第二个身份。绕过去不会换来任何解释，只会把一个糟糕的晚上变成日后需要道歉的事。今晚找个人，把发生的事说出口。它一旦不再只住在你脑子里，就会变小。" },
      { type: "p", text: "拉黑式消失之所以和幽灵式分手不一样疼，和你有多喜欢对方无关。幽灵式分手留给你一个没有答案的问题；拉黑式消失连问题待过的地方也一并带走了：没有可以重读的对话，没有可以点开的资料页，没有这三周存在过的痕迹。这确实让人发懵，但它会淡掉。这里面没有一样是在衡量你。" },
    ],
  },
  nl: {
    term: "Cloaking",
    summary:
      "Geblokkeerd en gewist worden op precies het moment dat iemand stopt met antwoorden, soms vlak nadat diegene je in een restaurant heeft laten wachten: er blijft geen gesprek en geen profiel over.",
    blocks: [
      { type: "h2", text: "Ghosting waarbij de uitgang wordt dichtgemetseld" },
      { type: "p", text: "Ghosting doet de deur dicht. Cloaking haalt de deur uit de muur. De ander stopt met antwoorden en blokkeert je in dezelfde minuut: in de app, op je telefoon, op elk account waar je diegene nog kon zien. De match is weg. Het gesprek is weg. Je zoekt de naam en er komt niets terug. Het gebeurt vaak vlak nadat een date is afgesproken, soms terwijl je al aan tafel zit." },
      { type: "p", text: "De redenen lopen enorm uiteen en van buitenaf zie je niet welke het is. Sommigen ontlopen een gesprek waarvan ze een slechte afloop verwachten. Sommigen schrikken. Sommigen waren nooit van plan te komen. En sommigen blokkeren iedereen zodra ze vinden dat iets voorbij is — een gewoonte, geen oordeel over jou." },
      { type: "h2", text: "Hoe het verschilt van gewoon niet komen opdagen" },
      { type: "ul", items: [
        "**Laten zitten én gewist.** Diegene kwam niet, en toen je appte was het nummer al geblokkeerd.",
        "**Het gesprek bestaat niet meer.** Niet ongelezen — verwijderd, samen met de match zelf.",
        "**Alle kanalen sluiten tegelijk.** App, telefoon, sociale media, allemaal binnen hetzelfde uur.",
        "**Er is geen profiel meer om te bekijken.** Je zoekt en krijgt niets, alsof je die persoon verzonnen hebt.",
      ] },
      { type: "h2", accent: "green", text: "Wat je met de rest van die avond doet" },
      { type: "p", text: "Sta je nu voor een restaurant? Ga naar binnen en eet, of ga naar huis. Geef het geen anderhalf uur. Laat daarna die blokkade met rust — geen nieuw nummer, geen geleend account, geen tweede profiel. Eromheen werken levert geen uitleg op en maakt van een rotavond iets waarvoor je later sorry moet zeggen. Vertel het vanavond hardop aan één vriend of vriendin. Het krimpt zodra het niet alleen nog in je hoofd woont." },
      { type: "p", text: "Cloaking prikt anders dan ghosting, en dat heeft niets te maken met hoe leuk je diegene vond. Ghosting laat je achter met een vraag zonder antwoord. Cloaking neemt ook de plek weg waar die vraag stond: geen gesprek om terug te lezen, geen profiel om te checken, geen spoor van de afgelopen drie weken. Dat maakt je even stuurloos, en het gaat over. Niets ervan zei iets over jou." },
    ],
  },
  pl: {
    term: "Cloaking",
    summary:
      "Zablokowanie i skasowanie cię dokładnie w tej samej chwili, w której druga osoba przestaje odpisywać — czasem tuż po wystawieniu cię do wiatru. Nie zostaje ani rozmowa, ani profil.",
    blocks: [
      { type: "h2", text: "Ghosting z zamurowanym wyjściem" },
      { type: "p", text: "Ghosting zamyka drzwi. Cloaking wyrywa je ze ściany. Druga osoba przestaje odpisywać i w tej samej minucie cię blokuje: w aplikacji, w telefonie, na każdym koncie, na którym mogłeś ją jeszcze zobaczyć. Dopasowanie znika. Rozmowa znika. Wpisujesz imię w wyszukiwarkę i nie ma nic. Najczęściej dzieje się to zaraz po umówieniu randki, czasem gdy już siedzisz przy stoliku." },
      { type: "p", text: "Powody bywają skrajnie różne i z zewnątrz nie da się poznać, który to. Ktoś ucieka przed rozmową, po której spodziewa się awantury. Ktoś się przestraszył. Ktoś w ogóle nie zamierzał przyjść. A ktoś blokuje wszystkich, gdy tylko uzna, że sprawa jest zamknięta — to nawyk, nie wyrok na ciebie." },
      { type: "h2", text: "Czym różni się od zwykłego niepojawienia się" },
      { type: "ul", items: [
        "**Wystawiony i wymazany naraz.** Nie przyszedł, a kiedy napisałeś, numer był już zablokowany.",
        "**Rozmowy nie ma.** Nie jest nieprzeczytana — została skasowana razem z dopasowaniem.",
        "**Wszystkie kanały zamykają się naraz.** Aplikacja, telefon, media społecznościowe, w ciągu jednej godziny.",
        "**Nie został żaden profil do sprawdzenia.** Szukasz i nic nie wyskakuje, jakbyś tę osobę wymyślił.",
      ] },
      { type: "h2", accent: "green", text: "Co zrobić z resztą tego wieczoru" },
      { type: "p", text: "Jeśli stoisz właśnie przed restauracją: wejdź i zjedz albo wróć do domu. Nie dawaj temu półtorej godziny. Potem zostaw blokadę w spokoju — żadnego nowego numeru, pożyczonego konta ani drugiego profilu. Obchodzenie jej nie przyniesie wyjaśnienia, a zły wieczór zamieni w coś, za co będziesz przepraszać. Opowiedz dziś komuś na głos, co się stało. Ta historia maleje, gdy tylko przestaje mieszkać wyłącznie w twojej głowie." },
      { type: "p", text: "Cloaking boli inaczej niż ghosting i nie ma to związku z tym, jak bardzo ci na kimś zależało. Ghosting zostawia pytanie bez odpowiedzi. Cloaking zabiera także miejsce, w którym to pytanie stało: nie ma rozmowy do odczytania, profilu do sprawdzenia ani śladu po ostatnich trzech tygodniach. To dezorientuje i mija. Nic z tego nie mierzyło ciebie." },
    ],
  },
  sv: {
    term: "Cloaking",
    summary:
      "Att bli blockerad och raderad i samma stund som någon slutar svara, ibland precis efter att ha lämnat dig väntande på en restaurang: ingen chatt och ingen profil finns kvar.",
    blocks: [
      { type: "h2", text: "Ghosting där utgången muras igen" },
      { type: "p", text: "Ghosting stänger dörren. Cloaking lyfter bort den ur väggen. Den andra slutar svara och blockerar dig i samma minut: i appen, i telefonen, på varje konto där du fortfarande kunde se hen. Matchningen försvinner. Chatten försvinner. Du söker på namnet och får ingenting. Det händer ofta precis efter att en dejt är bokad, ibland medan du redan sitter vid bordet." },
      { type: "p", text: "Skälen skiljer sig enormt och utifrån går det inte att se vilket det är. Någon undviker ett samtal hen tror blir obehagligt. Någon blev rädd. Någon tänkte aldrig dyka upp. Och någon blockerar alla så fort hen bestämt att något är slut — en vana, inte en dom över dig." },
      { type: "h2", text: "Vad som skiljer det från att bara utebli" },
      { type: "ul", items: [
        "**Bortglömd och borttagen på en gång.** Hen kom inte, och när du skrev var numret redan blockerat.",
        "**Chatten finns inte kvar.** Inte oläst — raderad, tillsammans med själva matchningen.",
        "**Alla kanaler stängs samtidigt.** App, telefon, sociala medier, allt inom samma timme.",
        "**Det finns ingen profil kvar att kolla.** Du söker och får inget, som om du hittat på personen.",
      ] },
      { type: "h2", accent: "green", text: "Vad du gör med resten av kvällen" },
      { type: "p", text: "Står du utanför en restaurang just nu: gå in och ät, eller åk hem. Ge det inte en och en halv timme. Låt sedan blockeringen vara — inget nytt nummer, inget lånat konto, ingen andra profil. Att ta sig runt den ger dig ingen förklaring och gör en dålig kväll till något du får be om ursäkt för. Berätta högt för en vän i kväll vad som hände. Det krymper så fort det slutar bo enbart i huvudet." },
      { type: "p", text: "Cloaking svider på ett annat sätt än ghosting, och det har inget med hur mycket du gillade personen att göra. Ghosting lämnar dig med en fråga utan svar. Cloaking tar dessutom bort platsen där frågan stod: ingen chatt att läsa om, ingen profil att kolla, inget spår av de senaste tre veckorna. Det gör dig vilsen, och det går över. Ingenting av det mätte dig." },
    ],
  },
  hi: {
    term: "क्लोकिंग",
    summary:
      "जिस पल कोई जवाब देना बंद करता है, उसी पल आपको हर जगह ब्लॉक करके मिटा देना — कभी-कभी मिलने के वादे पर न आने के तुरंत बाद; पीछे न चैट बचती है, न प्रोफ़ाइल।",
    blocks: [
      { type: "h2", text: "जिसमें निकलने का रास्ता भी चुन दिया जाता है" },
      { type: "p", text: "घोस्टिंग दरवाज़ा बंद करती है; क्लोकिंग दरवाज़े को दीवार से ही उखाड़ लेती है। सामने वाला जवाब देना बंद करता है और उसी मिनट आपको ब्लॉक कर देता है — ऐप पर, फ़ोन पर, हर उस अकाउंट पर जहाँ आप उसे अब तक देख सकते थे। मैच गायब, चैट गायब, और नाम सर्च करने पर कुछ नहीं मिलता। यह अक्सर मिलने की तारीख़ तय होने के ठीक बाद होता है, और कभी-कभी तब जब आप मेज़ पर बैठ चुके होते हैं।" },
      { type: "p", text: "वजहें आपस में बहुत अलग होती हैं और बाहर से यह जानने का कोई तरीक़ा नहीं कि आपके साथ कौन-सी हुई। कोई ऐसी बातचीत से बच रहा है जिसके बिगड़ने का उसे डर है। कोई घबरा गया। कोई आने वाला था ही नहीं। और कोई हर बात के खत्म होते ही आदतन सबको ब्लॉक कर देता है — यह उसकी आदत है, आप पर सुनाया गया फ़ैसला नहीं।" },
      { type: "h2", text: "सिर्फ़ न आने से यह कैसे अलग है" },
      { type: "ul", items: [
        "**इंतज़ार भी कराया और मिटा भी दिया।** वह नहीं आया, और जब तक आपने मैसेज किया, नंबर ब्लॉक हो चुका था।",
        "**चैट ही नहीं बची।** अनरीड नहीं — मैच के साथ पूरी तरह डिलीट।",
        "**सारे रास्ते एक साथ बंद।** ऐप, फ़ोन, सोशल अकाउंट — सब उसी एक घंटे में।",
        "**देखने के लिए कोई प्रोफ़ाइल नहीं।** सर्च कीजिए तो कुछ नहीं आता, जैसे वह इंसान आपने खुद गढ़ा हो।",
      ] },
      { type: "h2", accent: "green", text: "उस शाम का बाक़ी हिस्सा कैसे बिताएँ" },
      { type: "p", text: "अगर आप इस वक़्त किसी रेस्तराँ के बाहर खड़े हैं: अंदर जाइए और खाना खाइए, या घर लौट जाइए। डेढ़ घंटा मत दीजिए। इसके बाद ब्लॉक को वैसे ही रहने दीजिए — नया नंबर नहीं, किसी और का अकाउंट नहीं, दूसरी प्रोफ़ाइल नहीं। उसे पार करने से सफ़ाई नहीं मिलेगी, बस एक बुरी शाम ऐसी चीज़ बन जाएगी जिसके लिए बाद में माफ़ी माँगनी पड़े। आज रात किसी एक दोस्त को बोलकर बता दीजिए कि क्या हुआ। जैसे ही यह सिर्फ़ आपके दिमाग़ में रहना बंद करती है, छोटी हो जाती है।" },
      { type: "p", text: "क्लोकिंग की चुभन घोस्टिंग से अलग होती है, और इसका इससे कोई लेना-देना नहीं कि आप उन्हें कितना पसंद करते थे। घोस्टिंग एक बिन जवाब सवाल छोड़ जाती है। क्लोकिंग उस जगह को भी साथ ले जाती है जहाँ वह सवाल रहता था: न दोबारा पढ़ने को चैट, न देखने को प्रोफ़ाइल, न पिछले तीन हफ़्तों का कोई निशान। यह उलझन देती है और फिर बीत जाती है। इसमें से कुछ भी आपका माप नहीं था।" },
    ],
  },
};
