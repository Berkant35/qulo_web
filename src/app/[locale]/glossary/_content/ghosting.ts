import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * Ghosting — someone cuts off all contact with no explanation and never returns.
 *
 * Judgement calls a later editor should not undo by accident:
 *
 * - NO Qulo angle. Block 7 deliberately carries no product mention. Ghosting
 *   happens on every platform and in every kind of dating, and nothing in the
 *   app prevents it: a match still has to keep replying, and Qulo cannot make
 *   anyone do that. Claiming a question quiz stops people disappearing would be
 *   false, so block 7 is spent on the thing the reader actually came for —
 *   that the ambiguity is the injury, not the rejection. The same holds for
 *   `cloaking`, `zombieing` and `orbiting`; none of the four ends on a pitch.
 *
 * - The **78%** burnout figure is the one external statistic available and it
 *   is cited in full in every locale: 2024 **Forbes Health** survey conducted
 *   with **OnePoll** among **1,000** US adults who had used a dating app in the
 *   past year (see `FORBES_ONEPOLL_2024` in `src/lib/constants/stats.ts`). It
 *   is used here as context for why threads get dropped, never as a causal
 *   claim that burnout produces ghosting — the survey measured burnout, not
 *   ghosting. The sentence after it ("not all of it is rejection") is framed as
 *   interpretation, not as a finding. Do not add a second number to this page.
 *
 * - Term names. Most locales keep the loanword because that is what people
 *   actually say. Three do not: `ko` uses 잠수 이별, the native Korean phrase,
 *   with 고스팅 named in the summary; `zh` uses 幽灵式分手 with "ghosting" named
 *   in the summary; `ja`, `ar`, `ru` and `hi` use the established native
 *   renderings (ゴースティング, الغوستينغ, гостинг, घोस्टिंग). Do not "fix"
 *   these back to Latin-script "ghosting".
 *
 * - Register follows `GLOSSARY_LABELS` per locale: informal in tr/de/es/it/zh/
 *   nl/pl/sv, vous in fr, вы in ru, polite forms in ja/ko, आप in hi.
 *
 * - No moderation advice ("report them") anywhere in this cluster: Qulo has no
 *   moderation team, and telling a reader to report from a Qulo page implies
 *   one exists.
 */
export const ghosting: LocalizedGlossaryEntry = {
  en: {
    term: "Ghosting",
    summary:
      "Cutting off all contact with no explanation and no goodbye — the messages simply stop, and the person never comes back to say why.",
    blocks: [
      { type: "h2", text: "Why people disappear instead of saying so" },
      { type: "p", text: "Ghosting is cheap. When you have never met in person, share no friends and owe each other nothing, walking away costs almost nothing — one tap and the thread is gone. Add the fact that nobody teaches you how to end something small without hurting someone, and silence starts to look like the kind option. It rarely is. It is just the comfortable one, for the person leaving." },
      { type: "p", text: "Volume plays a part too. Someone running eight conversations at once is not deciding anything about you; they are closing tabs. Exhaustion at that scale is common: in a 2024 **Forbes Health** survey conducted with **OnePoll** among **1,000** US adults who had used a dating app in the past year, **78%** said they felt burned out by it. Not all of it is rejection. Some of it is someone who ran out of energy." },
      { type: "h2", text: "How to tell it apart from a slow reply" },
      { type: "ul", items: [
        "**The silence is total.** Not slower replies — nothing at all, across every channel you had.",
        "**Nothing happened.** No argument, no cooling off, no bad date you can point at.",
        "**They are still around.** Online, posting, active — just not with you.",
        "**It holds.** A week, two weeks, and no explanation ever arrives.",
      ] },
      { type: "h2", accent: "green", text: "What actually helps" },
      { type: "p", text: "Send one message if you want to. One. Something short and calm: “Hey, I think this fizzled out. No hard feelings.” It is not for them, it is for you — so the last line in the thread is yours. Then stop refreshing. No second message, no checking whether they are online, no asking a mutual friend to find out. The answer you want is not coming, and hunting for it holds the door open long past the point it helps." },
      { type: "p", text: "And be fair to yourself about what actually hurts. It is rarely losing them — three weeks in, you barely knew them. It is being handed a question with no answer, so your head keeps writing endings for it. Pick the dullest one: they did not want to have that conversation. Almost always, that is the whole story." },
    ],
  },
  tr: {
    term: "Ghosting",
    summary:
      "Hiçbir açıklama yapmadan, veda bile etmeden bütün iletişimi kesmek — mesajlar bir anda durur ve karşı taraf nedenini söylemeye bir daha hiç dönmez.",
    blocks: [
      { type: "h2", text: "İnsanlar neden söylemek yerine kayboluyor" },
      { type: "p", text: "Ghosting ucuz bir çıkış. Hiç yüz yüze görüşmediyseniz, ortak arkadaşınız yoksa ve birbirinize borçlu olduğunuz hiçbir şey yoksa çekip gitmenin bedeli neredeyse sıfırdır: tek dokunuş, sohbet yok olur. Üstüne bir de şu var: küçük bir şeyi kimseyi kırmadan bitirmeyi kimse öğretmiyor. O yüzden sessizlik nazik seçenek gibi görünmeye başlar. Genelde değildir; sadece gideni rahatlatan seçenektir." },
      { type: "p", text: "Kalabalık da payını alıyor. Aynı anda sekiz sohbet yürüten biri senin hakkında bir karar vermiyor, sadece sekmeleri kapatıyor. Bu ölçekte yorulmak yaygın: 2024'te **Forbes Health**'in **OnePoll** ile yaptığı ve son bir yılda flört uygulaması kullanmış **1.000** ABD'li yetişkini kapsayan ankette katılımcıların **%78**'i tükenmişlik hissettiğini söyledi. Yaşadığın şeyin hepsi reddedilme değil; bir kısmı enerjisi biten birinin sessizliği." },
      { type: "h2", text: "Geç cevaptan nasıl ayırt edilir" },
      { type: "ul", items: [
        "**Sessizlik tam.** Yavaşlayan cevaplar değil; elindeki bütün kanallarda tam bir hiçlik.",
        "**Ortada bir sebep yok.** Tartışma yok, soğuma yok, işaret edebileceğin kötü bir buluşma yok.",
        "**Ortalıkta hâlâ var.** Çevrimiçi oluyor, paylaşım yapıyor, aktif — sadece seninle değil.",
        "**Durum değişmiyor.** Bir hafta, iki hafta geçiyor ve açıklama hiç gelmiyor.",
      ] },
      { type: "h2", accent: "green", text: "Ne işe yarar" },
      { type: "p", text: "İstiyorsan tek bir mesaj at. Bir tane. Kısa ve sakin: “Selam, galiba burada bitti. Kırgınlık yok.” Bu mesaj onun için değil, senin için — son söz sende kalsın diye. Sonra ekranı yenilemeyi bırak. İkinci mesajı atma, çevrimiçi mi diye bakma, ortak arkadaşa sordurma. Beklediğin cevap gelmeyecek; onu aramak da kapıyı işine yaramayacak kadar uzun süre açık tutar." },
      { type: "p", text: "Bir de canını yakan şey konusunda kendine dürüst ol. Genelde onu kaybetmek değil bu — üç hafta sonunda zaten pek tanımıyordun. Cevabı olmayan bir soruyla baş başa kalmak asıl mesele; zihnin boşluğu doldurmak için durmadan yeni sonlar yazıyor. En sıkıcı ihtimali seç: o konuşmayı yapmak istemedi. Hikâye neredeyse her zaman bu kadar." },
    ],
  },
  de: {
    term: "Ghosting",
    summary:
      "Der plötzliche Abbruch jeglichen Kontakts ohne Erklärung und ohne Abschied – die Nachrichten hören einfach auf, und die Person meldet sich nie wieder, um zu sagen, warum.",
    blocks: [
      { type: "h2", text: "Warum Menschen lieber verschwinden, als es zu sagen" },
      { type: "p", text: "Ghosting ist billig. Wenn ihr euch nie persönlich getroffen habt, keine gemeinsamen Freunde habt und einander nichts schuldet, kostet das Weggehen fast nichts: ein Tippen, und der Chat ist weg. Dazu kommt, dass einem niemand beibringt, etwas Kleines zu beenden, ohne jemanden zu verletzen. Schweigen wirkt dann wie die freundliche Variante. Das ist es selten. Es ist nur die bequeme – für den, der geht." },
      { type: "p", text: "Auch die Menge spielt mit. Wer acht Chats gleichzeitig führt, entscheidet nichts über dich, sondern schließt Tabs. Erschöpfung in diesem Ausmaß ist verbreitet: In einer Umfrage von **Forbes Health** mit **OnePoll** aus dem Jahr 2024 unter **1.000** Erwachsenen in den USA, die im Jahr davor eine Dating-App genutzt hatten, sagten **78 %**, sie fühlten sich davon ausgebrannt. Nicht alles davon ist Ablehnung. Manches ist einfach jemand, dem die Kraft ausgegangen ist." },
      { type: "h2", text: "Woran du es von einer späten Antwort unterscheidest" },
      { type: "ul", items: [
        "**Die Stille ist total.** Keine langsameren Antworten – gar nichts, auf allen Kanälen, die ihr hattet.",
        "**Es ist nichts vorgefallen.** Kein Streit, keine Abkühlung, kein missglücktes Date, auf das du zeigen könntest.",
        "**Die Person ist weiter unterwegs.** Online, aktiv, postet – nur eben nicht bei dir.",
        "**Es bleibt so.** Eine Woche, zwei Wochen, und es kommt nie eine Erklärung.",
      ] },
      { type: "h2", accent: "green", text: "Was wirklich hilft" },
      { type: "p", text: "Schreib eine Nachricht, wenn du willst. Eine. Kurz und ruhig: „Hey, ich glaube, das ist im Sand verlaufen. Alles gut.“ Sie ist nicht für die andere Person, sondern für dich – damit die letzte Zeile im Chat von dir stammt. Dann hör auf zu aktualisieren. Keine zweite Nachricht, kein Nachsehen, ob sie online ist, kein Nachfragen über Bekannte. Die Antwort, die du willst, kommt nicht, und das Suchen danach hält die Tür viel länger offen, als es dir guttut." },
      { type: "p", text: "Und sei ehrlich zu dir, was da eigentlich wehtut. Meistens ist es nicht der Verlust der Person – nach drei Wochen kanntest du sie kaum. Es ist die Frage ohne Antwort, zu der dein Kopf ständig neue Enden schreibt. Nimm das langweiligste: Diese Person wollte dieses Gespräch nicht führen. Mehr steckt fast nie dahinter." },
    ],
  },
  fr: {
    term: "Ghosting",
    summary:
      "La rupture brutale de tout contact, sans un mot d'explication ni un au revoir : les messages s'arrêtent et la personne ne revient jamais dire pourquoi.",
    blocks: [
      { type: "h2", text: "Pourquoi on préfère disparaître que le dire" },
      { type: "p", text: "Le ghosting ne coûte presque rien. Quand on ne s'est jamais vus, qu'on n'a aucun ami en commun et qu'on ne se doit rien, partir se fait en une seconde : une pression du doigt et la conversation n'existe plus. Ajoutez à cela que personne n'apprend nulle part à mettre fin à quelque chose de petit sans blesser l'autre. Le silence passe alors pour la solution délicate. Il l'est rarement : il arrange surtout celui qui s'en va." },
      { type: "p", text: "Le nombre compte aussi. Quelqu'un qui mène huit conversations en parallèle ne tranche rien à votre sujet : il ferme des onglets. La fatigue à cette échelle est courante : dans une enquête **Forbes Health** menée avec **OnePoll** en 2024 auprès de **1 000** adultes américains ayant utilisé une application de rencontre dans l'année, **78 %** se disaient épuisés. Tout n'est pas un rejet ; une partie, c'est simplement quelqu'un à bout." },
      { type: "h2", text: "Comment le distinguer d'une réponse qui tarde" },
      { type: "ul", items: [
        "**Le silence est total.** Pas des réponses plus lentes : plus rien, sur tous les canaux que vous aviez.",
        "**Rien ne s'est passé.** Pas de dispute, pas de refroidissement, aucun rendez-vous raté à désigner.",
        "**La personne est toujours là.** En ligne, active, elle publie – mais pas avec vous.",
        "**Ça dure.** Une semaine, deux semaines, et aucune explication n'arrive jamais.",
      ] },
      { type: "h2", accent: "green", text: "Ce qui aide vraiment" },
      { type: "p", text: "Envoyez un message si vous en avez envie. Un seul. Court et calme : « Salut, je crois que ça s'est arrêté là. Sans rancune. » Il n'est pas pour l'autre, il est pour vous : la dernière ligne de la conversation vous appartient. Ensuite, arrêtez de rafraîchir. Pas de deuxième message, pas de vérification de son statut en ligne, pas d'enquête auprès d'un ami commun. La réponse que vous cherchez ne viendra pas, et la chercher garde la porte ouverte bien plus longtemps qu'il ne le faudrait." },
      { type: "p", text: "Et soyez juste avec vous-même sur ce qui fait mal. Ce n'est presque jamais la personne : au bout de trois semaines, vous la connaissiez à peine. C'est une question laissée sans réponse, à laquelle votre tête invente des fins en boucle. Prenez la plus ennuyeuse : l'autre n'a pas voulu avoir cette conversation. C'est presque toujours toute l'histoire." },
    ],
  },
  es: {
    term: "Ghosting",
    summary:
      "Cortar de golpe todo el contacto sin dar una explicación ni despedirse: los mensajes se acaban y la otra persona nunca vuelve para decir por qué.",
    blocks: [
      { type: "h2", text: "Por qué desaparecer sale más barato que hablar" },
      { type: "p", text: "El ghosting cuesta poquísimo. Cuando no ha habido un encuentro en persona, no hay amigos en común y nadie le debe nada a nadie, irse sale casi gratis: un toque y la conversación deja de existir. Añade que nadie te enseña a terminar algo pequeño sin hacer daño y el silencio empieza a parecer la opción amable. Casi nunca lo es: es la cómoda, para quien se marcha." },
      { type: "p", text: "La cantidad también influye. Quien lleva ocho conversaciones a la vez no está decidiendo nada sobre ti: está cerrando pestañas. El agotamiento a esa escala es habitual: en una encuesta de **Forbes Health** realizada con **OnePoll** en 2024 entre **1.000** adultos de Estados Unidos que habían usado una app de citas ese año, el **78%** dijo sentirse quemado. No todo es rechazo; una parte es alguien que se quedó sin fuerzas." },
      { type: "h2", text: "Cómo saber que es ghosting y no una respuesta lenta" },
      { type: "ul", items: [
        "**El silencio es total.** No son respuestas más lentas: no hay nada, por ningún canal.",
        "**No ha pasado nada.** Ni discusión, ni enfriamiento, ni una cita mala a la que señalar.",
        "**Sigue ahí.** Se conecta, publica, está activo — pero no contigo.",
        "**Se mantiene.** Una semana, dos semanas, y la explicación no llega nunca.",
      ] },
      { type: "h2", accent: "green", text: "Qué ayuda de verdad" },
      { type: "p", text: "Manda un mensaje si te apetece. Uno. Corto y tranquilo: «Hola, creo que esto se apagó. Sin rencores». No es para la otra persona, es para ti: que lo último del chat sea tuyo. Después deja de refrescar. Nada de segundo mensaje, de mirar si está en línea, de preguntar a un conocido. La respuesta que buscas no va a llegar, y buscarla mantiene la puerta abierta mucho más de lo que te conviene." },
      { type: "p", text: "Y sé justo contigo sobre qué es lo que duele. Casi nunca es perder a esa persona: a las tres semanas apenas la conocías. Es quedarte con una pregunta sin respuesta, y la cabeza no para de inventarle finales. Quédate con el más aburrido: no quiso tener esa conversación. Casi siempre esa es la historia entera." },
    ],
  },
  ar: {
    term: "الغوستينغ",
    summary:
      "قطع كل تواصل فجأة دون أي تفسير ودون وداع؛ تتوقف الرسائل ولا يعود الشخص أبدًا ليقول لك السبب.",
    blocks: [
      { type: "h2", text: "لماذا يختار الناس الاختفاء بدل المصارحة" },
      { type: "p", text: "الاختفاء رخيص الثمن. حين لا تكونان قد التقيتما وجهًا لوجه، ولا يجمعكما أصدقاء مشتركون، ولا أحد مدين للآخر بشيء، فإن الانسحاب لا يكلّف شيئًا تقريبًا: ضغطة واحدة وتختفي المحادثة كلها. أضف إلى ذلك أن أحدًا لا يعلّمك كيف تُنهي شيئًا صغيرًا دون أن تجرح أحدًا، فيبدو الصمت وكأنه الخيار اللطيف. نادرًا ما يكون كذلك؛ هو ببساطة الخيار المريح لمن يرحل." },
      { type: "p", text: "للعدد دور أيضًا. من يدير ثماني محادثات في وقت واحد لا يتخذ قرارًا بشأنك، بل يغلق نوافذ. والإرهاق بهذا الحجم شائع: في استطلاع أجرته **Forbes Health** مع **OnePoll** عام 2024 وشمل **1000** بالغ أمريكي استخدموا تطبيق مواعدة خلال العام السابق، قال **78%** إنهم شعروا بالإنهاك منه. ليس كل ما يحدث رفضًا؛ بعضه شخص نفدت طاقته." },
      { type: "h2", text: "كيف تميّزه عن ردٍّ متأخر" },
      { type: "ul", items: [
        "**الصمت كامل.** ليست ردودًا أبطأ، بل لا شيء إطلاقًا، على كل قناة كانت بينكما.",
        "**لم يحدث شيء.** لا خلاف، ولا فتور، ولا موعد سيئ يمكنك الإشارة إليه.",
        "**الشخص ما زال موجودًا.** متصل، ينشر، نشِط — لكن ليس معك.",
        "**الوضع يستمر.** أسبوع، أسبوعان، ولا يصل أي تفسير.",
      ] },
      { type: "h2", accent: "green", text: "ما الذي يساعد فعلًا" },
      { type: "p", text: "أرسل رسالة واحدة إن أردت. واحدة فقط، قصيرة وهادئة: «أظن أن الأمر انتهى هنا. لا ضغينة». هي ليست له، بل لك؛ كي تكون آخر كلمة في المحادثة كلمتك. ثم توقف عن تحديث الشاشة. لا رسالة ثانية، ولا تفقّد لحالة الاتصال، ولا سؤال عبر صديق مشترك. الجواب الذي تنتظره لن يأتي، والبحث عنه يُبقي الباب مفتوحًا أطول بكثير مما ينفعك." },
      { type: "p", text: "وكن منصفًا مع نفسك في تحديد مصدر الألم. غالبًا ليس فقدان الشخص؛ بعد ثلاثة أسابيع لم تكن تعرفه حقًا. الألم هو سؤال بلا إجابة، فيظل ذهنك يكتب له نهايات جديدة. اختر أكثرها مللًا: لم يرغب في إجراء تلك المحادثة. هذه هي القصة كاملة في أغلب الأحيان." },
    ],
  },
  ru: {
    term: "гостинг",
    summary:
      "Внезапный обрыв всякого общения без объяснений и без прощания: сообщения просто перестают приходить, и человек больше не возвращается, чтобы сказать почему.",
    blocks: [
      { type: "h2", text: "Почему проще исчезнуть, чем сказать" },
      { type: "p", text: "Гостинг почти ничего не стоит. Если вы не виделись вживую, у вас нет общих друзей и вы ничем друг другу не обязаны, уйти можно одним касанием — и переписки больше нет. Добавьте к этому, что заканчивать что-то небольшое, не задев человека, никто не учит. Тогда молчание начинает выглядеть как деликатный вариант. Обычно это не так: оно просто удобно тому, кто уходит." },
      { type: "p", text: "Дело и в количестве. Тот, кто ведёт восемь переписок сразу, не выносит решения о вас — он закрывает вкладки. Усталость такого масштаба встречается часто: в опросе **Forbes Health**, проведённом совместно с **OnePoll** в 2024 году среди **1000** взрослых американцев, пользовавшихся приложением для знакомств за прошедший год, **78%** сказали, что чувствуют выгорание. Не всё здесь отказ; часть — это человек, у которого кончились силы." },
      { type: "h2", text: "Как отличить это от долгого ответа" },
      { type: "ul", items: [
        "**Тишина полная.** Не более редкие ответы, а ничего вообще, по всем каналам, что у вас были.",
        "**Ничего не произошло.** Ни ссоры, ни охлаждения, ни неудачного свидания, на которое можно кивнуть.",
        "**Человек при этом на связи.** Онлайн, публикует, активен — просто не с вами.",
        "**Так и остаётся.** Неделя, две, и объяснение не приходит никогда.",
      ] },
      { type: "h2", accent: "green", text: "Что действительно помогает" },
      { type: "p", text: "Напишите одно сообщение, если хочется. Одно. Короткое и спокойное: «Привет. Кажется, у нас всё сошло на нет. Без обид». Оно не для него, а для вас — чтобы последняя строчка в переписке была вашей. Дальше перестаньте обновлять экран. Никакого второго сообщения, проверки статуса и расспросов через общих знакомых. Ответа, которого вы ждёте, не будет, а поиски держат дверь открытой куда дольше, чем вам полезно." },
      { type: "p", text: "И будьте честны с собой насчёт того, что именно болит. Обычно это не потеря человека — через три недели вы едва его знали. Это вопрос без ответа, к которому голова снова и снова придумывает финалы. Возьмите самый скучный: он не захотел этого разговора. Почти всегда в этом вся история." },
    ],
  },
  pt: {
    term: "Ghosting",
    summary:
      "O corte repentino de todo contato, sem explicação e sem despedida: as mensagens simplesmente param e a pessoa nunca volta para dizer por quê.",
    blocks: [
      { type: "h2", text: "Por que some em vez de falar" },
      { type: "p", text: "Sumir sai barato. Quando não houve encontro presencial, não existem amigos em comum e ninguém deve nada a ninguém, ir embora custa quase nada: um toque e a conversa deixa de existir. Some a isso o fato de que ninguém ensina a terminar algo pequeno sem magoar. Aí o silêncio começa a parecer a opção gentil. Quase nunca é: é a opção confortável para quem vai embora." },
      { type: "p", text: "O volume também pesa. Quem toca oito conversas ao mesmo tempo não está decidindo nada sobre você — está fechando abas. Cansaço nessa escala é comum: numa pesquisa da **Forbes Health** feita com o **OnePoll** em 2024 com **1.000** adultos dos Estados Unidos que tinham usado um app de namoro no ano anterior, **78%** disseram se sentir esgotados. Nem tudo é rejeição; parte é alguém que ficou sem energia." },
      { type: "h2", text: "Como diferenciar de uma resposta demorada" },
      { type: "ul", items: [
        "**O silêncio é total.** Não são respostas mais lentas: é nada, em todos os canais que vocês tinham.",
        "**Não aconteceu nada.** Sem briga, sem esfriada, sem encontro ruim para apontar.",
        "**A pessoa continua por aí.** Online, postando, ativa — só não com você.",
        "**E fica assim.** Uma semana, duas, e a explicação nunca chega.",
      ] },
      { type: "h2", accent: "green", text: "O que ajuda de verdade" },
      { type: "p", text: "Mande uma mensagem, se quiser. Uma. Curta e tranquila: “Oi, acho que isso aqui esfriou. Sem mágoas.” Ela não é para a outra pessoa, é para você — para que a última linha da conversa seja sua. Depois, pare de atualizar. Nada de segunda mensagem, de checar se está online, de perguntar para um conhecido. A resposta que você quer não vem, e procurar por ela mantém a porta aberta muito além do ponto em que isso ajuda." },
      { type: "p", text: "E seja justo com você sobre o que realmente dói. Quase nunca é perder a pessoa — em três semanas você mal a conhecia. É ficar com uma pergunta sem resposta, e a cabeça não para de inventar finais. Fique com o mais sem graça: ela não quis ter essa conversa. Quase sempre a história é só isso." },
    ],
  },
  it: {
    term: "Ghosting",
    summary:
      "L'interruzione improvvisa di ogni contatto, senza una spiegazione e senza un saluto: i messaggi si fermano e la persona non torna mai a dirti perché.",
    blocks: [
      { type: "h2", text: "Perché si sparisce invece di dirlo" },
      { type: "p", text: "Sparire costa pochissimo. Se non vi siete mai visti di persona, non avete amici in comune e non vi dovete niente, andarsene non costa quasi nulla: un tocco e la conversazione non esiste più. Aggiungi che nessuno ti insegna a chiudere una cosa piccola senza ferire qualcuno, e il silenzio inizia a sembrare la scelta gentile. Quasi mai lo è: è la scelta comoda per chi se ne va." },
      { type: "p", text: "Conta anche la quantità. Chi porta avanti otto chat insieme non sta decidendo niente su di te: sta chiudendo schede. La stanchezza a quel livello è diffusa: in un sondaggio **Forbes Health** condotto con **OnePoll** nel 2024 su **1.000** adulti statunitensi che avevano usato un'app di incontri nell'ultimo anno, il **78%** ha detto di sentirsi esaurito. Non è tutto rifiuto: una parte è qualcuno rimasto senza energie." },
      { type: "h2", text: "Come distinguerlo da una risposta lenta" },
      { type: "ul", items: [
        "**Il silenzio è totale.** Non risposte più rade: proprio niente, su tutti i canali che avevate.",
        "**Non è successo nulla.** Nessun litigio, nessun raffreddamento, nessun appuntamento andato male da indicare.",
        "**La persona c'è ancora.** Online, pubblica, è attiva — solo non con te.",
        "**E resta così.** Una settimana, due, e la spiegazione non arriva mai.",
      ] },
      { type: "h2", accent: "green", text: "Cosa aiuta davvero" },
      { type: "p", text: "Scrivi un messaggio, se ti va. Uno. Corto e tranquillo: «Ciao, credo che si sia spento qui. Nessun rancore». Non è per l'altra persona, è per te: così l'ultima riga della chat è tua. Poi smetti di aggiornare. Niente secondo messaggio, niente controlli sullo stato online, niente domande a un conoscente. La risposta che cerchi non arriverà, e cercarla tiene la porta aperta molto più a lungo di quanto ti faccia bene." },
      { type: "p", text: "E sii onesto con te su cosa fa male davvero. Quasi mai è perdere quella persona: dopo tre settimane la conoscevi appena. È restare con una domanda senza risposta, e la testa continua a scriverle finali. Prendi quello più noioso: non ha voluto fare quella conversazione. Quasi sempre la storia è tutta qui." },
    ],
  },
  ja: {
    term: "ゴースティング",
    summary:
      "説明も別れの言葉もないまま、突然すべての連絡を絶つこと。メッセージが止まり、相手が理由を告げに戻ってくることもありません。",
    blocks: [
      { type: "h2", text: "なぜ言わずに消えるのか" },
      { type: "p", text: "ゴースティングは、する側にとって代償がほとんどありません。まだ直接会っていない、共通の友人もいない、互いに義理もない——その状態なら、去るのは指一本です。タップひとつでやり取りごと消えてしまいます。そのうえ、小さな関係を相手を傷つけずに終わらせる方法を、私たちはどこでも教わっていません。だから沈黙が「やさしい選択」に見えてきます。実際はそうではなく、去る側にとって楽なだけの選択です。" },
      { type: "p", text: "数の問題もあります。同時に八つのやり取りを抱えている人は、あなたについて何かを判断しているのではなく、タブを閉じているだけです。その規模の疲れは珍しくありません。2024年に **Forbes Health** が **OnePoll** と実施した、過去1年にマッチングアプリを使った米国の成人 **1,000人** への調査では、**78%** が燃え尽きを感じたと答えています。すべてが拒絶ではありません。一部は、単に力尽きた人の沈黙です。" },
      { type: "h2", text: "返信が遅いだけの状態との見分け方" },
      { type: "ul", items: [
        "**沈黙が完全。** 返信が遅くなったのではなく、使っていたすべての連絡先で反応がゼロ。",
        "**きっかけがない。** けんかも、冷める出来事も、失敗したデートも思い当たらない。",
        "**相手は普通に動いている。** ログインし、投稿し、活動している——あなたとだけ話さない。",
        "**その状態が続く。** 1週間、2週間と過ぎても、説明は最後まで届かない。",
      ] },
      { type: "h2", accent: "green", text: "本当に助けになること" },
      { type: "p", text: "送りたいなら、一通だけ送ってください。一通です。短く、落ち着いた文で。「たぶんここで終わりですね。気にしていません」。それは相手のためではなく、自分のため——最後の一行を自分の言葉にしておくためです。あとは画面の更新をやめること。二通目を送らない、オンライン状態を確認しない、共通の知人に探りを入れない。ほしい答えは返ってきませんし、探し続けるほど、必要以上に長く扉が開いたままになります。" },
      { type: "p", text: "そして、何がつらいのかを正直に見てください。多くの場合、つらいのは相手を失ったことではありません。3週間なら、まだよく知らない相手です。つらいのは、答えのない問いを渡され、頭が勝手に結末を書き続けることです。いちばん退屈な答えを選んでください。その人は、その会話をしたくなかった。ほとんどの場合、話はそれだけです。" },
    ],
  },
  ko: {
    term: "잠수 이별",
    summary:
      "설명도 인사도 없이 모든 연락을 끊어버리는 일. 영어로는 고스팅이라고 하며, 메시지가 갑자기 멈추고 상대는 이유를 말하러 다시 돌아오지 않습니다.",
    blocks: [
      { type: "h2", text: "왜 말하는 대신 사라질까" },
      { type: "p", text: "잠수는 비용이 거의 들지 않습니다. 아직 직접 만난 적이 없고, 함께 아는 사람도 없고, 서로에게 빚진 것도 없다면 떠나는 데 드는 값은 거의 0입니다. 한 번 누르면 대화방째로 사라지니까요. 게다가 작은 관계를 상처 없이 끝내는 법은 어디에서도 배우지 않습니다. 그래서 침묵이 배려처럼 보이기 시작합니다. 대개는 배려가 아니라, 떠나는 쪽에게만 편한 선택입니다." },
      { type: "p", text: "숫자의 문제이기도 합니다. 동시에 여덟 개의 대화를 굴리는 사람은 당신에 대해 결론을 내린 게 아니라 창을 닫고 있는 겁니다. 그 정도 규모의 피로는 흔합니다. 2024년 **Forbes Health**가 **OnePoll**과 함께 지난 1년간 데이팅 앱을 써 본 미국 성인 **1,000명**을 조사한 결과, **78%**가 지쳤다고 답했습니다. 전부가 거절은 아닙니다. 일부는 그냥 기운이 다한 사람의 침묵입니다." },
      { type: "h2", text: "답장이 늦는 것과 구별하는 법" },
      { type: "ul", items: [
        "**침묵이 완전합니다.** 답이 느려진 게 아니라, 쓰던 모든 창구에서 아무 반응이 없습니다.",
        "**계기가 없습니다.** 다툼도, 식어가는 신호도, 망친 데이트도 짚을 게 없습니다.",
        "**상대는 잘 지냅니다.** 접속하고, 올리고, 활동합니다 — 당신하고만 말하지 않을 뿐입니다.",
        "**그 상태가 유지됩니다.** 일주일, 이 주일이 지나도 설명은 끝내 오지 않습니다.",
      ] },
      { type: "h2", accent: "green", text: "실제로 도움이 되는 것" },
      { type: "p", text: "보내고 싶다면 딱 한 통만 보내세요. 한 통입니다. 짧고 담담하게. “여기까지인 것 같네요. 미워하진 않아요.” 이 메시지는 상대가 아니라 나를 위한 것입니다. 대화의 마지막 줄이 내 문장이 되도록요. 그다음에는 새로고침을 멈추세요. 두 번째 메시지, 접속 상태 확인, 아는 사람을 통한 확인 — 전부 하지 않는 편이 낫습니다. 원하는 답은 오지 않고, 찾을수록 문이 필요 이상으로 오래 열려 있습니다." },
      { type: "p", text: "그리고 무엇이 아픈지 스스로에게 솔직해지세요. 대개는 그 사람을 잃은 게 아픈 것이 아닙니다. 3주면 아직 잘 알지도 못하는 사이입니다. 진짜 아픈 건 답 없는 질문을 손에 쥔 채 머리가 계속 결말을 새로 쓰는 일입니다. 가장 심심한 답을 고르세요. 그 사람은 그 대화를 하고 싶지 않았던 겁니다. 거의 언제나 그게 이야기의 전부입니다." },
    ],
  },
  zh: {
    term: "幽灵式分手",
    summary:
      "不给任何解释、也不说一声再见就切断全部联系：消息突然停了，对方再也没有回来告诉你原因。英文里叫 ghosting。",
    blocks: [
      { type: "h2", text: "为什么有人宁可消失也不肯开口" },
      { type: "p", text: "消失的成本太低了。还没见过面，没有共同朋友，谁也不欠谁，抽身几乎不需要付出什么：手指一按，整段对话就没了。再加上一件事——把一段还很轻的关系体面地结束掉，从来没人教过。于是沉默看起来像是温柔的选项。它通常不是，它只是对走的那个人最省事。" },
      { type: "p", text: "数量也在起作用。同时开着八段对话的人，不是在对你下判断，只是在关标签页。这种规模的疲惫很常见：2024 年 **Forbes Health** 与 **OnePoll** 合作、针对过去一年用过约会软件的 **1000** 名美国成年人所做的调查里，**78%** 的人说自己感到倦怠。发生的事不全是拒绝，有一部分只是某个人力气用完了。" },
      { type: "h2", text: "怎么和“回得慢”区分开" },
      { type: "ul", items: [
        "**沉默是彻底的。** 不是回得慢，而是你们用过的每个渠道都没有动静。",
        "**没有导火索。** 没吵架，没有降温的过程，也没有一次糟糕的约会可以指认。",
        "**人还好好的。** 上线、发动态、很活跃——只是不跟你说话。",
        "**一直维持着。** 一周、两周过去，解释始终没有出现。",
      ] },
      { type: "h2", accent: "green", text: "真正有用的做法" },
      { type: "p", text: "想发就发一条，只发一条。写得短一点、平静一点：“我猜我们到这儿就停了，没有怨气。”这条消息不是给对方的，是给你自己的——让对话的最后一句话属于你。然后停止刷新。不要发第二条，不要去看对方是否在线，不要托人打听。你想要的那个答案不会来，而一直找它，只会让那扇门开得比对你有好处的时间长得多。" },
      { type: "p", text: "还有，对自己诚实一点：真正难受的到底是什么。多半不是失去这个人——三周而已，你其实并不了解他。难受的是手里多了一个没有答案的问题，脑子就不停地替它写结局。挑最无聊的那个：他不想进行那场对话。绝大多数时候，故事就这么多。" },
    ],
  },
  nl: {
    term: "Ghosting",
    summary:
      "Alle contact abrupt verbreken zonder uitleg en zonder afscheid: de berichten stoppen gewoon en diegene komt nooit meer terug om te zeggen waarom.",
    blocks: [
      { type: "h2", text: "Waarom mensen liever verdwijnen dan het zeggen" },
      { type: "p", text: "Ghosting kost bijna niets. Als jullie elkaar nooit in het echt hebben gezien, geen vrienden delen en niets van elkaar te goed hebben, is weggaan één tik: het gesprek bestaat niet meer. Daar komt bij dat niemand je leert hoe je iets kleins beëindigt zonder iemand te kwetsen. Stilte gaat er dan uitzien als de vriendelijke optie. Dat is het zelden. Het is de makkelijke optie — voor degene die vertrekt." },
      { type: "p", text: "De hoeveelheid speelt ook mee. Wie acht gesprekken tegelijk voert, beslist niets over jou, maar sluit tabbladen. Vermoeidheid op die schaal komt vaak voor: in een onderzoek van **Forbes Health** met **OnePoll** uit 2024 onder **1.000** Amerikaanse volwassenen die het jaar ervoor een datingapp hadden gebruikt, zei **78%** zich opgebrand te voelen. Niet alles is afwijzing; een deel is iemand die helemaal op is." },
      { type: "h2", text: "Hoe je het onderscheidt van traag antwoorden" },
      { type: "ul", items: [
        "**De stilte is compleet.** Geen tragere antwoorden, maar helemaal niets, via geen enkel kanaal dat jullie hadden.",
        "**Er is niets gebeurd.** Geen ruzie, geen afkoeling, geen mislukte date om naar te wijzen.",
        "**Diegene is er gewoon nog.** Online, actief, plaatst dingen — alleen niet bij jou.",
        "**Het blijft zo.** Een week, twee weken, en er komt nooit uitleg.",
      ] },
      { type: "h2", accent: "green", text: "Wat echt helpt" },
      { type: "p", text: "Stuur één bericht als je dat wilt. Eén. Kort en rustig: “Hé, volgens mij is dit doodgebloed. Geen hard feelings.” Het is niet voor die ander, het is voor jou — zodat de laatste regel in het gesprek van jou is. Stop daarna met verversen. Geen tweede bericht, niet kijken of diegene online is, niemand laten polsen. Het antwoord dat je wilt komt niet, en ernaar zoeken houdt de deur veel langer open dan goed voor je is." },
      { type: "p", text: "En wees eerlijk tegen jezelf over wat er nou eigenlijk pijn doet. Meestal is het niet dat je diegene kwijt bent — na drie weken kende je die persoon amper. Het is een vraag zonder antwoord, waar je hoofd steeds nieuwe eindes bij verzint. Neem het saaiste: die ander wilde dat gesprek niet voeren. Bijna altijd is dat het hele verhaal." },
    ],
  },
  pl: {
    term: "Ghosting",
    summary:
      "Nagłe zerwanie wszelkiego kontaktu bez wyjaśnienia i bez pożegnania: wiadomości po prostu się urywają, a druga osoba nigdy nie wraca, żeby powiedzieć dlaczego.",
    blocks: [
      { type: "h2", text: "Dlaczego łatwiej zniknąć, niż powiedzieć" },
      { type: "p", text: "Zniknięcie prawie nic nie kosztuje. Jeśli nie widzieliście się na żywo, nie macie wspólnych znajomych i nikt nikomu nic nie jest winien, odejście to jedno kliknięcie — i rozmowa przestaje istnieć. Do tego nikt nie uczy, jak kończyć coś małego, nie raniąc drugiej osoby. Milczenie zaczyna więc wyglądać na wersję delikatną. Rzadko nią jest. Jest wygodne — dla tego, kto odchodzi." },
      { type: "p", text: "Znaczenie ma też skala. Ktoś, kto prowadzi osiem rozmów naraz, nie rozstrzyga niczego w twojej sprawie — zamyka karty. Zmęczenie na tym poziomie jest częste: w badaniu **Forbes Health** przeprowadzonym z **OnePoll** w 2024 roku wśród **1000** dorosłych Amerykanów, którzy w ciągu roku korzystali z aplikacji randkowej, **78%** przyznało, że czuje wypalenie. Nie wszystko jest odrzuceniem; część to ktoś, komu skończyły się siły." },
      { type: "h2", text: "Jak odróżnić to od spóźnionej odpowiedzi" },
      { type: "ul", items: [
        "**Cisza jest całkowita.** Nie wolniejsze odpowiedzi, tylko zero reakcji na każdym kanale, który mieliście.",
        "**Nic się nie wydarzyło.** Żadnej kłótni, żadnego ochłodzenia, żadnej nieudanej randki, na którą można wskazać.",
        "**Ta osoba wciąż funkcjonuje.** Jest online, wrzuca posty, działa — tylko nie z tobą.",
        "**I tak zostaje.** Tydzień, dwa, a wyjaśnienie nie przychodzi nigdy.",
      ] },
      { type: "h2", accent: "green", text: "Co naprawdę pomaga" },
      { type: "p", text: "Wyślij jedną wiadomość, jeśli masz ochotę. Jedną. Krótko i spokojnie: „Cześć, chyba nam się to wypaliło. Bez żalu”. Ona nie jest dla tamtej osoby, tylko dla ciebie — żeby ostatnia linijka w rozmowie należała do ciebie. Potem przestań odświeżać. Żadnej drugiej wiadomości, sprawdzania statusu, wypytywania wspólnych znajomych. Odpowiedź, na którą czekasz, nie przyjdzie, a szukanie jej trzyma te drzwi otwarte dużo dłużej, niż ci służy." },
      { type: "p", text: "I bądź wobec siebie uczciwy co do tego, co tak naprawdę boli. Zwykle nie jest to strata tej osoby — po trzech tygodniach ledwo ją znałeś. Boli pytanie bez odpowiedzi, do którego głowa dopisuje kolejne zakończenia. Weź to najnudniejsze: ta osoba nie chciała odbyć tej rozmowy. Prawie zawsze to cała historia." },
    ],
  },
  sv: {
    term: "Ghosting",
    summary:
      "Att bryta all kontakt tvärt, utan förklaring och utan att säga hej då: meddelandena tar bara slut och personen kommer aldrig tillbaka för att berätta varför.",
    blocks: [
      { type: "h2", text: "Varför folk försvinner i stället för att säga det" },
      { type: "p", text: "Ghosting kostar nästan ingenting. Har ni aldrig setts på riktigt, inte har några gemensamma vänner och inte är skyldiga varandra något, är det en tryckning att gå — och konversationen finns inte längre. Lägg till att ingen lär dig att avsluta något litet utan att såra någon. Då börjar tystnaden se ut som det snälla alternativet. Det är den sällan. Den är bekväm, för den som går." },
      { type: "p", text: "Mängden spelar också in. Den som har åtta konversationer igång avgör ingenting om dig — hen stänger flikar. Trötthet i den skalan är vanlig: i en undersökning från **Forbes Health** gjord med **OnePoll** 2024 bland **1 000** amerikanska vuxna som använt en dejtingapp det senaste året sa **78 %** att de kände sig utbrända. Allt är inte ett avslag; en del är någon som har slut på ork." },
      { type: "h2", text: "Hur du skiljer det från ett sent svar" },
      { type: "ul", items: [
        "**Tystnaden är total.** Inte långsammare svar, utan ingenting alls, i varje kanal ni hade.",
        "**Ingenting har hänt.** Inget bråk, ingen avsvalning, ingen misslyckad dejt att peka på.",
        "**Personen finns kvar.** Online, aktiv, lägger upp saker — bara inte med dig.",
        "**Det håller i sig.** En vecka, två veckor, och förklaringen kommer aldrig.",
      ] },
      { type: "h2", accent: "green", text: "Vad som faktiskt hjälper" },
      { type: "p", text: "Skicka ett meddelande om du vill. Ett. Kort och lugnt: ”Hej, jag tror det rann ut i sanden här. Inga hårda känslor.” Det är inte för den andra, det är för dig — så att sista raden i chatten är din. Sluta sedan uppdatera. Inget andra meddelande, ingen koll på om hen är online, ingen som frågar åt dig. Svaret du vill ha kommer inte, och letandet håller dörren öppen långt efter att det slutat hjälpa." },
      { type: "p", text: "Och var ärlig mot dig själv om vad det egentligen är som gör ont. Det är sällan förlusten av personen — efter tre veckor kände du hen knappt. Det är en fråga utan svar, och huvudet skriver nya slut till den hela tiden. Ta det tråkigaste: hen ville inte ta det samtalet. Nästan alltid är det hela historien." },
    ],
  },
  hi: {
    term: "घोस्टिंग",
    summary:
      "बिना कोई वजह बताए और बिना अलविदा कहे सारा संपर्क अचानक तोड़ देना — मैसेज आने बंद हो जाते हैं और सामने वाला कभी लौटकर यह नहीं बताता कि क्यों।",
    blocks: [
      { type: "h2", text: "लोग कहने के बजाय गायब क्यों हो जाते हैं" },
      { type: "p", text: "गायब हो जाना सस्ता पड़ता है। जब आप कभी आमने-सामने मिले ही नहीं, कोई साझा दोस्त नहीं है और किसी पर किसी का कुछ बकाया नहीं है, तो निकल जाने की कीमत लगभग शून्य है — एक टैप और पूरी बातचीत गायब। इसमें यह भी जोड़िए कि किसी छोटी-सी बात को बिना चोट पहुँचाए खत्म करना हमें कहीं सिखाया ही नहीं जाता। तब चुप्पी नरम रास्ता लगने लगती है। वह होती नहीं; वह सिर्फ़ जाने वाले के लिए आसान होती है।" },
      { type: "p", text: "संख्या का भी असर है। जो व्यक्ति एक साथ आठ बातचीत चला रहा है, वह आपके बारे में कोई फ़ैसला नहीं ले रहा — वह टैब बंद कर रहा है। इस पैमाने पर थकान आम है: 2024 में **Forbes Health** ने **OnePoll** के साथ मिलकर उन **1,000** अमेरिकी वयस्कों पर सर्वे किया जिन्होंने पिछले साल कोई डेटिंग ऐप इस्तेमाल किया था, और **78%** ने कहा कि वे इससे थक चुके हैं। हर चुप्पी अस्वीकार नहीं होती; कुछ हिस्सा बस किसी की खत्म हो चुकी ऊर्जा है।" },
      { type: "h2", text: "देर से आने वाले जवाब से इसे कैसे अलग करें" },
      { type: "ul", items: [
        "**चुप्पी पूरी होती है।** जवाब धीमे नहीं होते — हर उस माध्यम पर कुछ भी नहीं आता जो आपके पास था।",
        "**कोई वजह नहीं होती।** न झगड़ा, न ठंडापन, न कोई खराब मुलाकात जिसकी तरफ़ इशारा किया जा सके।",
        "**सामने वाला मौजूद है।** ऑनलाइन आता है, पोस्ट करता है, सक्रिय है — बस आपसे बात नहीं करता।",
        "**यह टिका रहता है।** एक हफ़्ता, दो हफ़्ते बीत जाते हैं और सफ़ाई कभी नहीं आती।",
      ] },
      { type: "h2", accent: "green", text: "असल में क्या काम आता है" },
      { type: "p", text: "मन हो तो एक मैसेज भेज दीजिए। सिर्फ़ एक। छोटा और शांत: “लगता है बात यहीं खत्म हो गई। कोई शिकायत नहीं।” यह मैसेज सामने वाले के लिए नहीं, आपके लिए है — ताकि बातचीत की आख़िरी पंक्ति आपकी हो। इसके बाद स्क्रीन बार-बार खोलना बंद कर दीजिए। दूसरा मैसेज नहीं, ऑनलाइन है या नहीं यह देखना नहीं, किसी जान-पहचान से पूछताछ नहीं। जो जवाब आप चाहते हैं वह नहीं आएगा, और उसे ढूँढ़ते रहना दरवाज़ा ज़रूरत से कहीं ज़्यादा देर खुला रखता है।" },
      { type: "p", text: "और यह भी ईमानदारी से देखिए कि दर्द असल में किस बात का है। अक्सर उस व्यक्ति को खोने का नहीं — तीन हफ़्ते में आप उन्हें ठीक से जानते ही नहीं थे। दर्द उस सवाल का है जिसका जवाब नहीं मिला, और दिमाग़ उसके नए-नए अंत लिखता रहता है। सबसे उबाऊ वाला चुन लीजिए: वह यह बातचीत करना नहीं चाहता था। लगभग हमेशा कहानी बस इतनी ही होती है।" },
    ],
  },
};
