import type { LocalizedArticle } from "@/components/blog/ArticleBlocks";

/**
 * "How to write a question that works" — the guidance half of
 * /[locale]/questions. The 22 worked examples printed underneath it come from
 * `EXAMPLE_QUESTIONS`, which is generated from the app's own per-market
 * question library, so the prose here must stay true for a reader whose
 * examples were authored for their market rather than translated into it.
 *
 * No statistic appears on this page, deliberately. The only external figure the
 * site is cleared to quote (dating-app burnout, Forbes Health / OnePoll, 2024)
 * is about how people feel using apps, not about how to word a question — and a
 * number borrowed for weight is exactly how an unsourced claim gets born. The
 * argument rests on the mechanic instead: four options, one correct, and a
 * match only when every question is answered right.
 *
 * Product limits are stated in `QUESTION_LABELS.ctaDesc`, not here, so the
 * range and the plan that governs it live in one place: 2 to 4 questions on the
 * free plan, up to 10 on a paid one. Do not restate the ceiling in this file
 * without naming the paid plan in the same sentence — `npm run verify:claims`
 * fails the build on a bare 2-to-10 range.
 *
 * Block sequence is identical in all 16 locales — h2, p, p, h2, ul(4), h2
 * green, ul(4), p — the same parity contract `npm run verify:content` enforces
 * on the blog and advice trees. That guard does not walk this directory yet, so
 * the sequence is maintained by hand: keep it if you edit.
 *
 * Brand rule: Qulo is the only dating app named anywhere on this site. The
 * "questions that do not work" list describes patterns, never an app.
 */
export const writingQuestions: LocalizedArticle = {
  en: [
    { type: "h2", text: "What makes a question work" },
    { type: "p", text: "A question works when a stranger who has read your profile can reason their way to the right answer. They have never met you, so they cannot simply know it — but if your photos, your bio and your other questions all point in one direction, someone paying attention gets there." },
    { type: "p", text: "That rules out both extremes. If the answer comes down to chance, everyone gets through and the question filtered nothing. If it is a private in-joke only your closest friend could land, nobody gets through and you never hear from anyone. Aim between the two: a fair shot for someone actually reading, none for someone tapping at random." },
    { type: "h2", text: "The four options" },
    { type: "ul", items: [
      "**Make all four plausible.** If three of them are obviously wrong, you have written a question with one option.",
      "**Only one can be true.** If two answers can both be defended, the person who picks the other one is right and fails anyway.",
      "**No joke option.** A silly fourth answer is fun to write, but it cuts the guess down to three — and often points straight at the real one by contrast.",
      "**Keep them short.** A few words each is enough. Four long options turn a quick decision into homework.",
    ] },
    { type: "h2", accent: "green", text: "Questions that do not work" },
    { type: "ul", items: [
      "**Facts about you nobody could infer.** The street you grew up on, your first pet's name. There is nothing to reason from, so it becomes a coin toss with four sides.",
      "**Anything with an arguable answer.** “Which of these films is the best?” has no correct answer, only yours, and from the outside nobody can find it.",
      "**Anything you would not want a stranger to guess right.** Where you live, which gym you go to, when you are home alone. The whole point of the question is that someone you have not met gets it right.",
      "**Questions where the flattering option is obvious.** One kind answer among three selfish ones measures nothing except whether the other person can read the room.",
    ] },
    { type: "p", text: "If you are staring at an empty field, take one of the examples below and rewrite it until it is about you — that is faster than inventing from nothing. And you do not have to fill every slot today: two questions you actually like will do more than four written to get the form finished." },
  ],
  tr: [
    { type: "h2", text: "Bir soruyu işe yarar kılan şey" },
    { type: "p", text: "Bir soru, profilini okumuş bir yabancının akıl yürüterek doğru cevaba varabildiği zaman işe yarar. Seninle hiç tanışmadı, yani cevabı bilmesi mümkün değil — ama fotoğrafların, biyografin ve diğer soruların aynı yöne işaret ediyorsa, dikkatli okuyan biri oraya ulaşır." },
    { type: "p", text: "Bu, iki ucu birden eler. Cevap tamamen şansa kalıyorsa herkes geçer ve soru hiçbir şey elememiş olur. Yalnızca en yakın arkadaşının bilebileceği özel bir şakaysa kimse geçemez ve kimseden ses çıkmaz. Ortayı hedefle: gerçekten okuyanın adil bir şansı olsun, rastgele dokunanın olmasın." },
    { type: "h2", text: "Dört seçenek" },
    { type: "ul", items: [
      "**Dördü de akla yatkın olsun.** Üçü açıkça yanlışsa, tek seçenekli bir soru yazmışsın demektir.",
      "**Yalnızca biri doğru olabilsin.** İki cevap da savunulabiliyorsa, diğerini seçen kişi haklıdır ama yine de elenir.",
      "**Şaka seçeneği koyma.** Komik dördüncü şıkkı yazmak keyiflidir ama tahmini üçe indirir; çoğu zaman da zıtlığıyla doğru cevabı ele verir.",
      "**Kısa tut.** Birkaç kelime yeter. Dört uzun seçenek, saniyelik bir kararı ev ödevine çevirir.",
    ] },
    { type: "h2", accent: "green", text: "İşe yaramayan sorular" },
    { type: "ul", items: [
      "**Kimsenin çıkaramayacağı kişisel ayrıntılar.** Çocukluğunun sokağı, ilk evcil hayvanının adı. Akıl yürütecek hiçbir şey yok; dört yüzlü bir yazı tura oluyor.",
      "**Cevabı tartışmaya açık olan her şey.** “Bunlardan hangisi en iyi film?” sorusunun doğru cevabı yoktur, senin cevabın vardır; dışarıdan kimse onu bulamaz.",
      "**Bir yabancının doğru bilmesini istemeyeceğin her şey.** Oturduğun semt, gittiğin spor salonu, evde yalnız kaldığın saatler. Sorunun bütün amacı, henüz tanışmadığın birinin onu doğru bilmesi.",
      "**Gurur okşayan şıkkın belli olduğu sorular.** Üç bencil cevabın arasına konmuş tek nazik cevap, karşındakinin havayı okuyup okuyamadığından başka bir şey ölçmez.",
    ] },
    { type: "p", text: "Boş kutuya bakıp kaldıysan, aşağıdaki örneklerden birini al ve seninle ilgili hale gelene kadar değiştir; sıfırdan uydurmaktan hızlıdır. Bugün her boşluğu doldurmak da zorunda değilsin: gerçekten sevdiğin iki soru, formu bitirmek için yazılmış dört sorudan çok daha iyi iş görür." },
  ],
  de: [
    { type: "h2", text: "Was eine Frage funktionieren lässt" },
    { type: "p", text: "Eine Frage funktioniert, wenn eine fremde Person, die dein Profil gelesen hat, sich die richtige Antwort erschließen kann. Sie kennt dich nicht, kann sie also nicht einfach wissen — aber wenn deine Fotos, dein Text und deine anderen Fragen in dieselbe Richtung zeigen, kommt jemand, der aufmerksam liest, darauf." },
    { type: "p", text: "Damit fallen beide Extreme weg. Ist die Antwort reine Glückssache, kommen alle durch und die Frage hat nichts gefiltert. Ist sie ein privater Insider, den nur deine beste Freundin versteht, kommt niemand durch und du hörst von niemandem. Ziel ist die Mitte: eine faire Chance für alle, die wirklich lesen, und keine für alle, die auf gut Glück tippen." },
    { type: "h2", text: "Die vier Antwortoptionen" },
    { type: "ul", items: [
      "**Alle vier müssen plausibel sein.** Sind drei davon offensichtlich falsch, hast du eine Frage mit einer einzigen Option geschrieben.",
      "**Nur eine darf stimmen.** Lassen sich zwei Antworten begründen, hat die Person, die die andere wählt, recht und scheitert trotzdem.",
      "**Keine Scherzoption.** Eine alberne vierte Antwort macht beim Schreiben Spaß, kürzt das Raten aber auf drei — und verrät die richtige oft schon durch den Kontrast.",
      "**Halte sie kurz.** Ein paar Wörter reichen. Vier lange Optionen machen aus einer schnellen Entscheidung eine Hausaufgabe.",
    ] },
    { type: "h2", accent: "green", text: "Fragen, die nicht funktionieren" },
    { type: "ul", items: [
      "**Details über dich, die niemand erschließen kann.** Die Straße deiner Kindheit, der Name deines ersten Haustiers. Es gibt nichts, woraus man schließen könnte — ein Münzwurf mit vier Seiten.",
      "**Alles mit strittiger Antwort.** „Welcher dieser Filme ist der beste?“ hat keine richtige Antwort, nur deine, und von außen findet sie niemand.",
      "**Alles, was eine fremde Person nicht erraten können soll.** Wo du wohnst, in welches Studio du gehst, wann du allein zu Hause bist. Der Sinn der Frage ist ja gerade, dass jemand sie richtig beantwortet, den du noch nicht kennst.",
      "**Fragen, bei denen die schmeichelhafte Option offensichtlich ist.** Eine nette Antwort zwischen drei selbstsüchtigen prüft nichts außer der Fähigkeit, die Situation zu lesen.",
    ] },
    { type: "p", text: "Wenn du auf ein leeres Feld starrst: Nimm eines der Beispiele unten und schreib es um, bis es von dir handelt — das geht schneller, als bei null anzufangen. Und du musst heute nicht jeden Platz füllen: zwei Fragen, die dir wirklich gefallen, bringen mehr als vier, die nur das Formular abschließen." },
  ],
  fr: [
    { type: "h2", text: "Ce qui fait qu'une question fonctionne" },
    { type: "p", text: "Une question fonctionne quand un inconnu qui a lu votre profil peut raisonner jusqu'à la bonne réponse. Il ne vous connaît pas, il ne peut donc pas la savoir — mais si vos photos, votre bio et vos autres questions pointent dans la même direction, quelqu'un d'attentif y arrive." },
    { type: "p", text: "Cela élimine les deux extrêmes. Si la réponse tient au hasard, tout le monde passe et la question n'a rien filtré. Si c'est une blague privée que seule votre meilleure amie comprendrait, personne ne passe et vous n'avez de nouvelles de personne. Visez le milieu : une vraie chance pour qui lit vraiment, aucune pour qui clique au hasard." },
    { type: "h2", text: "Les quatre options" },
    { type: "ul", items: [
      "**Rendez les quatre plausibles.** Si trois sont manifestement fausses, vous avez écrit une question à une seule option.",
      "**Une seule peut être vraie.** Si deux réponses se défendent, celui qui choisit l'autre a raison et échoue quand même.",
      "**Pas d'option blague.** Une quatrième réponse absurde est amusante à écrire, mais elle ramène le choix à trois — et désigne souvent la bonne par contraste.",
      "**Faites court.** Quelques mots suffisent. Quatre options longues transforment une décision rapide en devoir du soir.",
    ] },
    { type: "h2", accent: "green", text: "Les questions qui ne fonctionnent pas" },
    { type: "ul", items: [
      "**Les détails sur vous que personne ne peut deviner.** La rue de votre enfance, le nom de votre premier animal. Il n'y a rien à en déduire : c'est un pile ou face à quatre faces.",
      "**Tout ce dont la réponse se discute.** « Lequel de ces films est le meilleur ? » n'a pas de bonne réponse, seulement la vôtre, et de l'extérieur personne ne peut la trouver.",
      "**Tout ce que vous ne voudriez pas qu'un inconnu devine.** Où vous habitez, dans quelle salle de sport vous allez, à quelles heures vous êtes chez vous sans personne. Le principe même de la question, c'est que quelqu'un que vous n'avez pas rencontré tombe juste.",
      "**Les questions où l'option flatteuse saute aux yeux.** Une réponse généreuse au milieu de trois égoïstes ne mesure rien, sinon la capacité à deviner ce qu'on attend.",
    ] },
    { type: "p", text: "Si vous fixez un champ vide, prenez un des exemples ci-dessous et réécrivez-le jusqu'à ce qu'il parle de vous : c'est plus rapide que de partir de rien. Et rien ne vous oblige à tout remplir aujourd'hui : deux questions qui vous plaisent vraiment valent mieux que quatre écrites pour en finir avec le formulaire." },
  ],
  es: [
    { type: "h2", text: "Qué hace que una pregunta funcione" },
    { type: "p", text: "Una pregunta funciona cuando alguien que no te conoce, pero ha leído tu perfil, puede razonar hasta la respuesta correcta. Nunca te ha visto, así que saberla es imposible — pero si tus fotos, tu descripción y tus otras preguntas apuntan en la misma dirección, quien lea con atención llega." },
    { type: "p", text: "Eso descarta los dos extremos. Si la respuesta es pura suerte, pasa cualquiera y la pregunta no ha filtrado nada. Si es un chiste privado que solo entendería tu mejor amiga, no pasa nadie y no recibes ni un mensaje. Apunta al medio: una oportunidad real para quien lee de verdad y ninguna para quien responde sin leer." },
    { type: "h2", text: "Las cuatro opciones" },
    { type: "ul", items: [
      "**Que las cuatro sean creíbles.** Si tres son claramente falsas, has escrito una pregunta de una sola opción.",
      "**Solo una puede ser cierta.** Si dos respuestas se pueden defender, quien elija la otra tiene razón y aun así falla.",
      "**Sin opción de broma.** La cuarta respuesta graciosa es divertida de escribir, pero reduce la apuesta a tres — y muchas veces delata la buena por contraste.",
      "**Que sean cortas.** Con unas pocas palabras basta. Cuatro opciones largas convierten una decisión rápida en deberes.",
    ] },
    { type: "h2", accent: "green", text: "Preguntas que no funcionan" },
    { type: "ul", items: [
      "**Datos tuyos que nadie puede deducir.** La calle de tu infancia, el nombre de tu primera mascota. No hay nada de lo que tirar: es una moneda al aire con cuatro caras.",
      "**Cualquier cosa con respuesta discutible.** «¿Cuál de estas películas es la mejor?» no tiene respuesta correcta, solo la tuya, y desde fuera nadie la encuentra.",
      "**Cualquier cosa que no querrías que acertara un desconocido.** Dónde vives, a qué gimnasio vas, cuándo estás en casa a solas. El sentido de la pregunta es justamente que la acierte alguien a quien no conoces.",
      "**Preguntas donde la opción halagadora es evidente.** Una respuesta amable entre tres egoístas no mide nada salvo si la otra persona sabe leer la situación.",
    ] },
    { type: "p", text: "Si te has quedado mirando un campo en blanco, coge uno de los ejemplos de abajo y reescríbelo hasta que hable de ti: es más rápido que inventar desde cero. Y no hace falta llenarlo todo hoy: dos preguntas que te gusten de verdad valen más que cuatro escritas para acabar el formulario." },
  ],
  ar: [
    { type: "h2", text: "ما الذي يجعل السؤال ناجحاً" },
    { type: "p", text: "ينجح السؤال حين يستطيع شخص لا يعرفك، لكنه قرأ ملفك، أن يستنتج الإجابة الصحيحة. هو لم يلتقِ بك، فلا سبيل إلى أن يعرفها ببساطة — لكن إن كانت صورك ونبذتك وبقية أسئلتك تشير إلى الاتجاه نفسه، فمن يقرأ بانتباه سيصل." },
    { type: "p", text: "هذا يستبعد الطرفين معاً. إذا كانت الإجابة محض حظ، يمرّ الجميع ولا يكون السؤال قد صفّى شيئاً. وإذا كانت نكتة خاصة لا يفهمها إلا أقرب أصدقائك، فلن يمرّ أحد ولن يصلك خبر من أحد. استهدف المنتصف: فرصة عادلة لمن يقرأ فعلاً، ولا فرصة لمن يضغط عشوائياً." },
    { type: "h2", text: "الخيارات الأربعة" },
    { type: "ul", items: [
      "**اجعل الأربعة كلها معقولة.** إذا كانت ثلاثة منها خاطئة بشكل واضح، فأنت كتبت سؤالاً بخيار واحد.",
      "**واحد فقط يصحّ.** إذا كان بالإمكان الدفاع عن إجابتين معاً، فمن يختار الأخرى يكون محقاً ويسقط رغم ذلك.",
      "**لا خيار للمزاح.** الإجابة الرابعة الطريفة ممتعة في الكتابة، لكنها تختصر التخمين إلى ثلاثة — وكثيراً ما تكشف الصحيحة بالمقارنة.",
      "**اجعلها قصيرة.** بضع كلمات تكفي. أربعة خيارات طويلة تحوّل قراراً سريعاً إلى واجب مدرسي.",
    ] },
    { type: "h2", accent: "green", text: "أسئلة لا تنجح" },
    { type: "ul", items: [
      "**تفاصيل عنك لا يمكن لأحد استنتاجها.** شارع طفولتك، اسم أول حيوان أليف لك. لا شيء يُبنى عليه الاستنتاج، فتتحول المسألة إلى قرعة بأربعة وجوه.",
      "**أي سؤال إجابته قابلة للجدل.** «أي هذه الأفلام أفضل؟» لا إجابة صحيحة له، بل إجابتك أنت، ولا أحد يبلغها من الخارج.",
      "**أي شيء لا تريد لغريب أن يصيبه.** أين تسكن، وأي نادٍ رياضي ترتاده، ومتى تكون وحدك في البيت. جوهر السؤال أن يجيب عنه بشكل صحيح شخص لم تلتقِ به بعد.",
      "**الأسئلة التي يكون فيها الخيار المُجامل واضحاً.** إجابة لطيفة واحدة بين ثلاث أنانية لا تقيس شيئاً سوى القدرة على قراءة الموقف.",
    ] },
    { type: "p", text: "إذا كنت تحدّق في حقل فارغ، خذ أحد الأمثلة أدناه وأعد صياغته حتى يصير عنك أنت؛ هذا أسرع من البدء من الصفر. ولستَ مضطراً لملء كل الخانات اليوم: سؤالان تحبهما فعلاً يعملان أكثر من أربعة كُتبت لإنهاء النموذج." },
  ],
  ru: [
    { type: "h2", text: "Что делает вопрос рабочим" },
    { type: "p", text: "Вопрос работает, когда незнакомый человек, прочитавший ваш профиль, может дойти до правильного ответа рассуждением. Он вас не знает и просто помнить ответ не может — но если фотографии, описание и остальные вопросы указывают в одну сторону, внимательный читатель дойдёт." },
    { type: "p", text: "Это отсекает обе крайности. Если ответ — чистая случайность, проходят все, и вопрос ничего не отфильтровал. Если это личная шутка, понятная только лучшему другу, не проходит никто, и вам никто не пишет. Цельтесь в середину: честный шанс тому, кто действительно читает, и никакого — тому, кто жмёт наугад." },
    { type: "h2", text: "Четыре варианта ответа" },
    { type: "ul", items: [
      "**Все четыре должны выглядеть правдоподобно.** Если три очевидно неверны, вы написали вопрос с одним вариантом.",
      "**Верным может быть только один.** Если два ответа одинаково защитимы, тот, кто выберет другой, окажется прав и всё равно не пройдёт.",
      "**Никаких шуточных вариантов.** Смешной четвёртый ответ приятно писать, но он сокращает выбор до трёх — и часто по контрасту выдаёт правильный.",
      "**Пишите коротко.** Хватит нескольких слов. Четыре длинных варианта превращают быстрое решение в домашнее задание.",
    ] },
    { type: "h2", accent: "green", text: "Вопросы, которые не работают" },
    { type: "ul", items: [
      "**Факты о вас, которые невозможно вывести.** Улица вашего детства, кличка первого питомца. Рассуждать не из чего — получается монетка с четырьмя сторонами.",
      "**Всё, где ответ спорный.** «Какой из этих фильмов лучший?» не имеет правильного ответа, есть только ваш, и снаружи его не найти.",
      "**Всё, что незнакомому человеку лучше не угадывать.** Где вы живёте, в какой зал ходите, в какие часы бываете дома в одиночестве. Смысл вопроса как раз в том, что верно ответит человек, с которым вы ещё не встречались.",
      "**Вопросы, где лестный вариант очевиден.** Один добрый ответ среди трёх эгоистичных проверяет лишь умение угадать ожидаемое.",
    ] },
    { type: "p", text: "Если вы смотрите на пустое поле, возьмите любой пример ниже и переписывайте его, пока он не станет про вас, — это быстрее, чем придумывать с нуля. И заполнять всё сегодня необязательно: два вопроса, которые нравятся вам самим, сделают больше, чем четыре, написанных ради галочки." },
  ],
  pt: [
    { type: "h2", text: "O que faz uma pergunta funcionar" },
    { type: "p", text: "Uma pergunta funciona quando alguém que não te conhece, mas leu o seu perfil, consegue chegar à resposta certa pensando. Essa pessoa nunca te viu, então não tem como simplesmente saber — mas se as suas fotos, a sua bio e as suas outras perguntas apontam para o mesmo lado, quem presta atenção chega lá." },
    { type: "p", text: "Isso elimina os dois extremos. Se a resposta é pura sorte, passa qualquer um e a pergunta não filtrou nada. Se é uma piada interna que só a sua melhor amiga entenderia, não passa ninguém e você não recebe mensagem nenhuma. Mire no meio: chance real para quem lê de verdade, nenhuma para quem responde no chute." },
    { type: "h2", text: "As quatro opções" },
    { type: "ul", items: [
      "**Deixe as quatro plausíveis.** Se três estão claramente erradas, você escreveu uma pergunta de uma opção só.",
      "**Só uma pode ser verdadeira.** Se duas respostas dá para defender, quem escolher a outra está certo e mesmo assim erra.",
      "**Nada de opção de piada.** A quarta resposta engraçada é divertida de escrever, mas reduz o palpite a três — e muitas vezes entrega a certa por contraste.",
      "**Mantenha curtas.** Poucas palavras bastam. Quatro opções longas transformam uma decisão rápida em dever de casa.",
    ] },
    { type: "h2", accent: "green", text: "Perguntas que não funcionam" },
    { type: "ul", items: [
      "**Detalhes seus que ninguém tem como deduzir.** A rua da sua infância, o nome do seu primeiro bicho. Não há de onde raciocinar: vira cara ou coroa com quatro lados.",
      "**Qualquer coisa com resposta discutível.** “Qual destes filmes é o melhor?” não tem resposta certa, só a sua, e de fora ninguém acha.",
      "**Qualquer coisa que você não queira que um desconhecido acerte.** Onde você mora, em que academia treina, a que horas fica em casa sem mais ninguém. O sentido da pergunta é justamente alguém que você ainda não conhece acertar.",
      "**Perguntas em que a opção simpática é óbvia.** Uma resposta generosa no meio de três egoístas não mede nada além da capacidade de ler a situação.",
    ] },
    { type: "p", text: "Se você está encarando um campo em branco, pegue um dos exemplos abaixo e reescreva até ele falar de você — é mais rápido do que inventar do zero. E não precisa preencher tudo hoje: duas perguntas de que você gosta de verdade valem mais que quatro escritas só para fechar o formulário." },
  ],
  it: [
    { type: "h2", text: "Cosa rende una domanda efficace" },
    { type: "p", text: "Una domanda funziona quando uno sconosciuto che ha letto il tuo profilo riesce ad arrivare alla risposta giusta ragionando. Non ti ha mai incontrato, quindi non può semplicemente saperla — ma se le foto, la bio e le altre domande puntano nella stessa direzione, chi legge con attenzione ci arriva." },
    { type: "p", text: "Questo esclude entrambi gli estremi. Se la risposta è pura fortuna passano tutti e la domanda non ha filtrato niente. Se è una battuta privata che capirebbe solo la tua migliore amica non passa nessuno e non ti scrive più nessuno. Punta al centro: una possibilità concreta per chi legge davvero, nessuna per chi tocca a caso." },
    { type: "h2", text: "Le quattro opzioni" },
    { type: "ul", items: [
      "**Rendile tutte e quattro plausibili.** Se tre sono palesemente sbagliate, hai scritto una domanda con una sola opzione.",
      "**Solo una può essere vera.** Se due risposte si possono difendere entrambe, chi sceglie l'altra ha ragione e viene comunque escluso.",
      "**Niente opzione scherzosa.** La quarta risposta buffa è divertente da scrivere, ma riduce la scelta a tre — e spesso, per contrasto, rivela quella giusta.",
      "**Tienile corte.** Bastano poche parole. Quattro opzioni lunghe trasformano una decisione rapida in un compito a casa.",
    ] },
    { type: "h2", accent: "green", text: "Domande che non funzionano" },
    { type: "ul", items: [
      "**Dettagli su di te che nessuno può dedurre.** La via della tua infanzia, il nome del tuo primo animale. Non c'è nulla su cui ragionare: è un testa o croce a quattro facce.",
      "**Tutto ciò che ha una risposta opinabile.** «Quale di questi film è il migliore?» non ha una risposta giusta, ha solo la tua, e da fuori nessuno la trova.",
      "**Tutto ciò che non vorresti far indovinare a uno sconosciuto.** Dove abiti, in quale palestra vai, a che ora sei in casa senza nessuno. Il senso della domanda è proprio che ci azzecchi qualcuno che non hai ancora incontrato.",
      "**Domande in cui l'opzione lusinghiera si vede subito.** Una risposta gentile in mezzo a tre egoiste non misura niente, se non la capacità di capire cosa ci si aspetta.",
    ] },
    { type: "p", text: "Se stai fissando un campo vuoto, prendi uno degli esempi qui sotto e riscrivilo finché non parla di te: è più veloce che inventare dal nulla. E non devi riempire tutto oggi: due domande che ti piacciono davvero valgono più di quattro scritte per chiudere il modulo." },
  ],
  ja: [
    { type: "h2", text: "うまくいく質問の条件" },
    { type: "p", text: "質問がうまく働くのは、プロフィールを読んだ初対面の人が、考えて正解にたどり着けるときです。相手はあなたを知らないので、そのまま知っているはずがありません。ただ、写真や自己紹介、ほかの質問が同じ方向を指していれば、ちゃんと読んでいる人はたどり着けます。" },
    { type: "p", text: "これで両極端が外れます。答えが完全に運まかせなら誰でも通ってしまい、質問は何もふるい分けていません。逆に親友しか分からない内輪ネタなら誰も通れず、誰からも連絡が来ません。狙うのは真ん中です。きちんと読んだ人には勝ち目があり、適当にタップした人には勝ち目がない、そのあたり。" },
    { type: "h2", text: "四つの選択肢" },
    { type: "ul", items: [
      "**四つともありえる答えにする。** 三つが明らかに違うなら、実質ひとつしか選べない質問です。",
      "**正解はひとつだけ。** どちらにも理屈が通ってしまうと、もう一方を選んだ人は正しいのに落ちます。",
      "**ネタ選択肢は入れない。** ふざけた四つ目は書くのが楽しい反面、推測を三択に減らし、対比で正解を教えてしまうこともあります。",
      "**短くする。** 数語で十分です。長い選択肢が四つ並ぶと、さっと決められるはずのものが宿題になります。",
    ] },
    { type: "h2", accent: "green", text: "うまくいかない質問" },
    { type: "ul", items: [
      "**誰にも推測できない、あなただけの事実。** 子どものころに住んでいた通り、初めて飼ったペットの名前。手がかりがないので、四面のコイン投げになります。",
      "**答えが人によって割れるもの。** 「この中でいちばんいい映画は？」に正解はなく、あるのはあなたの答えだけ。外からは見つけようがありません。",
      "**知らない人に当てられたくないこと。** 住んでいる場所、通っているジム、家にひとりでいる時間帯。この質問は、まだ会ったことのない人が正解するためのものです。",
      "**好印象の選択肢が丸わかりの質問。** 自分本位な三つの中に優しい答えがひとつ。測れるのは空気を読む力だけです。",
    ] },
    { type: "p", text: "空欄を前に固まってしまったら、下の例をひとつ選んで、自分の話になるまで書き換えてみてください。ゼロから考えるより早いです。今日すべて埋める必要もありません。フォームを終わらせるために書いた四問より、自分が気に入っている二問のほうがよく働きます。" },
  ],
  ko: [
    { type: "h2", text: "잘 통하는 질문의 조건" },
    { type: "p", text: "질문은 프로필을 읽은 낯선 사람이 추론해서 정답에 닿을 수 있을 때 제 몫을 합니다. 상대는 당신을 만난 적이 없으니 그냥 알 수는 없습니다. 다만 사진과 소개글, 다른 질문들이 같은 방향을 가리키면 주의 깊게 읽은 사람은 도달합니다." },
    { type: "p", text: "그러면 양 극단이 걸러집니다. 답이 순전히 운이면 아무나 통과하고, 질문은 아무것도 거르지 못한 셈입니다. 반대로 가장 친한 친구만 아는 사적인 농담이면 아무도 통과하지 못하고 연락도 오지 않습니다. 가운데를 노리세요. 제대로 읽은 사람에게는 가능성이 있고, 아무렇게나 누른 사람에게는 없도록." },
    { type: "h2", text: "네 개의 선택지" },
    { type: "ul", items: [
      "**네 개 모두 그럴듯하게.** 셋이 대놓고 틀렸다면 사실상 선택지가 하나인 질문입니다.",
      "**정답은 하나뿐이어야 합니다.** 두 답 모두 말이 된다면, 다른 쪽을 고른 사람은 옳은데도 떨어집니다.",
      "**농담 선택지는 넣지 마세요.** 웃기는 네 번째 답은 쓰기엔 즐겁지만 추측을 셋으로 줄이고, 대비 때문에 정답을 알려주기도 합니다.",
      "**짧게 쓰세요.** 몇 단어면 충분합니다. 긴 선택지 네 개는 금방 끝날 결정을 숙제로 만듭니다.",
    ] },
    { type: "h2", accent: "green", text: "잘 안 되는 질문" },
    { type: "ul", items: [
      "**아무도 유추할 수 없는 개인적 사실.** 어릴 때 살던 골목, 첫 반려동물 이름. 추론할 근거가 없으니 면이 넷인 동전 던지기가 됩니다.",
      "**답이 갈리는 질문.** “이 중에서 가장 좋은 영화는?”에는 정답이 없고 당신의 답만 있습니다. 밖에서는 찾을 방법이 없습니다.",
      "**낯선 사람이 맞히기를 원하지 않는 것.** 사는 동네, 다니는 헬스장, 집에 혼자 있는 시간. 이 질문은 아직 만난 적 없는 사람이 맞히라고 있는 것입니다.",
      "**듣기 좋은 답이 뻔한 질문.** 이기적인 답 셋 사이에 착한 답 하나. 분위기를 읽는 능력 말고는 아무것도 재지 못합니다.",
    ] },
    { type: "p", text: "빈칸 앞에서 막혔다면 아래 예시 중 하나를 골라 당신 이야기가 될 때까지 고쳐 보세요. 맨바닥에서 짜내는 것보다 빠릅니다. 오늘 다 채울 필요도 없습니다. 양식을 끝내려고 쓴 네 개보다, 마음에 드는 두 개가 더 많은 일을 합니다." },
  ],
  zh: [
    { type: "h2", text: "什么样的问题才管用" },
    { type: "p", text: "一个问题管用，是指看过你资料的陌生人能靠推理找到正确答案。对方没见过你，不可能直接知道；但如果你的照片、简介和其他问题都指向同一个方向，认真看的人就能想到。" },
    { type: "p", text: "这样两头就都排除了。答案纯靠运气，谁都能通过，问题等于什么也没筛。反过来，只有最好的朋友才懂的私人梗，没人能通过，你也收不到消息。往中间靠：认真看的人有机会，随手乱点的人没有。" },
    { type: "h2", text: "四个选项" },
    { type: "ul", items: [
      "**四个都要像真的。** 如果有三个明显是错的，你写的其实是只有一个选项的题。",
      "**只能有一个是对的。** 两个答案都说得通的话，选另一个的人明明有理，却还是过不了。",
      "**别放搞笑选项。** 那个逗趣的第四项写起来开心，却把猜的范围缩到三个，还常常靠对比把正确答案暴露出来。",
      "**写短一点。** 几个字就够。四个长选项会把一个随手做的决定变成作业。",
    ] },
    { type: "h2", accent: "green", text: "不管用的问题" },
    { type: "ul", items: [
      "**别人无从推断的私人细节。** 你小时候住的那条街、第一只宠物的名字。没有可推理的线索，就成了四面的抛硬币。",
      "**答案本来就有争议的。** “这几部里哪部电影最好？”没有正确答案，只有你的答案，外人根本找不到。",
      "**你不希望陌生人猜中的事。** 你住在哪儿、去哪家健身房、什么时候一个人在家。这道题的意义恰恰是让还没见过面的人答对。",
      "**讨好型答案一眼就能看出来的问题。** 三个自私的答案里夹一个善良的，测的只是会不会看眼色。",
    ] },
    { type: "p", text: "如果你盯着空白框发呆，就挑下面一个例子，改到它讲的是你为止，这比从零想快得多。也不用今天全部填完：你自己喜欢的两个问题，胜过为了把表单填完写下的四个。" },
  ],
  nl: [
    { type: "h2", text: "Wat een vraag laat werken" },
    { type: "p", text: "Een vraag werkt als een onbekende die je profiel heeft gelezen zich naar het juiste antwoord kan redeneren. Diegene heeft je nooit ontmoet en kan het dus niet gewoon weten — maar als je foto's, je bio en je andere vragen dezelfde kant op wijzen, komt iemand die oplet eruit." },
    { type: "p", text: "Daarmee vallen beide uitersten af. Is het antwoord puur geluk, dan komt iedereen erdoor en heeft de vraag niets gefilterd. Is het een privégrap die alleen je beste vriendin snapt, dan komt niemand erdoor en hoor je van niemand iets. Mik op het midden: een eerlijke kans voor wie echt leest, geen kans voor wie lukraak tikt." },
    { type: "h2", text: "De vier antwoordopties" },
    { type: "ul", items: [
      "**Maak alle vier geloofwaardig.** Zijn er drie overduidelijk fout, dan heb je een vraag met één optie geschreven.",
      "**Er kan er maar één waar zijn.** Zijn twee antwoorden allebei te verdedigen, dan heeft wie de andere kiest gelijk en valt toch af.",
      "**Geen grapoptie.** Dat gekke vierde antwoord is leuk om te schrijven, maar het brengt het gokken terug naar drie — en verraadt het echte vaak door het contrast.",
      "**Houd ze kort.** Een paar woorden volstaat. Vier lange opties maken van een snelle keuze een huiswerkopdracht.",
    ] },
    { type: "h2", accent: "green", text: "Vragen die niet werken" },
    { type: "ul", items: [
      "**Weetjes over jou die niemand kan afleiden.** De straat van je jeugd, de naam van je eerste huisdier. Er valt niets uit op te maken: het is kop of munt met vier kanten.",
      "**Alles waarover je kunt twisten.** “Welke van deze films is de beste?” heeft geen goed antwoord, alleen het jouwe, en van buitenaf vindt niemand het.",
      "**Alles wat je een onbekende liever niet laat raden.** Waar je woont, in welke sportschool je komt, wanneer je alleen thuis bent. De hele bedoeling is dat iemand die je nog niet kent het goed heeft.",
      "**Vragen waarbij de vleiende optie eruit springt.** Eén aardig antwoord tussen drie egoïstische meet niets, behalve of iemand aanvoelt wat er verwacht wordt.",
    ] },
    { type: "p", text: "Staar je naar een leeg veld, neem dan een van de voorbeelden hieronder en herschrijf het tot het over jou gaat — dat gaat sneller dan iets uit het niets bedenken. En je hoeft vandaag niet elke plek te vullen: twee vragen die je zelf leuk vindt doen meer dan vier die je schreef om het formulier af te maken." },
  ],
  pl: [
    { type: "h2", text: "Co sprawia, że pytanie działa" },
    { type: "p", text: "Pytanie działa wtedy, gdy ktoś obcy, kto przeczytał twój profil, może dojść do właściwej odpowiedzi rozumowaniem. Nie zna cię, więc po prostu wiedzieć nie może — ale jeśli zdjęcia, opis i pozostałe pytania wskazują w tę samą stronę, uważny czytelnik trafi." },
    { type: "p", text: "To wyklucza obie skrajności. Jeśli odpowiedź zależy wyłącznie od przypadku, przechodzi każdy i pytanie niczego nie odsiało. Jeśli to prywatny żart, który rozumie tylko twoja najlepsza przyjaciółka, nie przejdzie nikt i nikt się nie odezwie. Celuj w środek: uczciwa szansa dla kogoś, kto naprawdę czyta, i żadna dla kogoś, kto klika na oślep." },
    { type: "h2", text: "Cztery odpowiedzi" },
    { type: "ul", items: [
      "**Wszystkie cztery mają brzmieć wiarygodnie.** Jeśli trzy są ewidentnie błędne, w praktyce masz pytanie z jedną odpowiedzią.",
      "**Prawdziwa może być tylko jedna.** Jeśli dwie odpowiedzi da się obronić, ten, kto wybierze tę drugą, ma rację i tak czy inaczej odpada.",
      "**Żadnej odpowiedzi dla żartu.** Zabawna czwarta opcja pisze się przyjemnie, ale zawęża zgadywanie do trzech — a przez kontrast często zdradza tę właściwą.",
      "**Pisz krótko.** Kilka słów wystarczy. Cztery długie odpowiedzi zamieniają szybką decyzję w pracę domową.",
    ] },
    { type: "h2", accent: "green", text: "Pytania, które nie działają" },
    { type: "ul", items: [
      "**Fakty o tobie, których nikt nie wydedukuje.** Ulica z dzieciństwa, imię pierwszego zwierzaka. Nie ma z czego wnioskować — wychodzi rzut monetą o czterech stronach.",
      "**Wszystko, o co można się spierać.** „Który z tych filmów jest najlepszy?” nie ma poprawnej odpowiedzi, ma tylko twoją, a z zewnątrz nikt jej nie znajdzie.",
      "**Wszystko, czego wolisz nie dawać obcemu do odgadnięcia.** Gdzie mieszkasz, do której siłowni chodzisz, o której bywasz w domu bez nikogo. Sens pytania polega właśnie na tym, że odpowie na nie poprawnie ktoś, kogo jeszcze nie znasz.",
      "**Pytania, w których pochlebna odpowiedź rzuca się w oczy.** Jedna miła odpowiedź wśród trzech egoistycznych nie mierzy niczego poza umiejętnością odczytania sytuacji.",
    ] },
    { type: "p", text: "Jeśli wpatrujesz się w puste pole, weź jeden z przykładów poniżej i przerabiaj go, aż będzie o tobie — to szybsze niż wymyślanie od zera. I nie musisz dziś zapełnić wszystkich miejsc: dwa pytania, które naprawdę ci się podobają, zrobią więcej niż cztery napisane po to, żeby zamknąć formularz." },
  ],
  sv: [
    { type: "h2", text: "Vad som får en fråga att fungera" },
    { type: "p", text: "En fråga fungerar när en främling som har läst din profil kan resonera sig fram till rätt svar. Hen har aldrig träffat dig och kan alltså inte bara veta — men om bilderna, texten och dina andra frågor pekar åt samma håll kommer den som läser uppmärksamt fram till det." },
    { type: "p", text: "Det sållar bort båda ytterligheterna. Är svaret ren slump kommer alla igenom och frågan har inte filtrerat någonting. Är det ett internskämt som bara din bästa vän fattar kommer ingen igenom och du hör inte av någon alls. Sikta på mitten: en rimlig chans för den som faktiskt läser, ingen alls för den som trycker på måfå." },
    { type: "h2", text: "De fyra svarsalternativen" },
    { type: "ul", items: [
      "**Gör alla fyra trovärdiga.** Är tre uppenbart fel har du skrivit en fråga med ett enda alternativ.",
      "**Bara ett får vara sant.** Om två svar båda går att försvara har den som väljer det andra rätt och åker ändå ut.",
      "**Inget skämtalternativ.** Det tokiga fjärde svaret är roligt att skriva, men det kortar gissningen till tre — och avslöjar ofta det rätta genom kontrasten.",
      "**Håll dem korta.** Några ord räcker. Fyra långa alternativ gör ett snabbt beslut till en läxa.",
    ] },
    { type: "h2", accent: "green", text: "Frågor som inte fungerar" },
    { type: "ul", items: [
      "**Sådant om dig som ingen kan räkna ut.** Gatan där du växte upp, namnet på ditt första husdjur. Det finns inget att resonera utifrån — det blir en slantsingling med fyra sidor.",
      "**Allt som går att tycka olika om.** ”Vilken av de här filmerna är bäst?” har inget rätt svar, bara ditt, och utifrån hittar ingen det.",
      "**Allt du inte vill att en främling gissar rätt på.** Var du bor, vilket gym du går till, när du är ensam hemma. Hela poängen är att någon du inte har träffat ska svara rätt.",
      "**Frågor där det smickrande alternativet syns på långt håll.** Ett snällt svar bland tre själviska mäter ingenting utom förmågan att läsa av läget.",
    ] },
    { type: "p", text: "Om du stirrar på ett tomt fält: ta ett av exemplen nedan och skriv om det tills det handlar om dig — det går snabbare än att hitta på från ingenting. Och du behöver inte fylla varje plats idag: två frågor du själv gillar gör mer än fyra som skrevs för att bli klar med formuläret." },
  ],
  hi: [
    { type: "h2", text: "सवाल को काम का क्या बनाता है" },
    { type: "p", text: "सवाल तब काम करता है जब आपकी प्रोफ़ाइल पढ़ चुका कोई अजनबी सोच-समझकर सही जवाब तक पहुँच सके। वह आपसे कभी मिला नहीं, इसलिए उसे जवाब पता होने का कोई रास्ता नहीं — लेकिन अगर आपकी तस्वीरें, बायो और बाकी सवाल एक ही दिशा में इशारा करते हैं, तो ध्यान से पढ़ने वाला वहाँ पहुँच जाता है।" },
    { type: "p", text: "इससे दोनों सिरे कट जाते हैं। जवाब अगर पूरी तरह किस्मत पर है, तो हर कोई पार हो जाएगा और सवाल ने कुछ छाना ही नहीं। और अगर वह ऐसा निजी मज़ाक है जो सिर्फ़ आपकी सबसे करीबी दोस्त समझती है, तो कोई पार नहीं होगा और किसी का संदेश भी नहीं आएगा। बीच का रास्ता चुनिए: जो सचमुच पढ़ रहा है उसे मौका मिले, जो यूँ ही टैप कर रहा है उसे नहीं।" },
    { type: "h2", text: "चार विकल्प" },
    { type: "ul", items: [
      "**चारों विकल्प मुमकिन लगें।** अगर तीन साफ़ तौर पर गलत हैं, तो आपने एक ही विकल्प वाला सवाल लिखा है।",
      "**सही सिर्फ़ एक हो।** अगर दोनों जवाबों के पक्ष में दलील दी जा सकती है, तो दूसरा चुनने वाला सही होकर भी बाहर हो जाएगा।",
      "**मज़ाक वाला विकल्प मत रखिए।** मज़ेदार चौथा जवाब लिखने में अच्छा लगता है, पर वह अंदाज़ा तीन तक सीमित कर देता है — और अक्सर तुलना से असली जवाब बता भी देता है।",
      "**छोटे रखिए।** कुछ शब्द काफ़ी हैं। चार लंबे विकल्प एक झटपट फ़ैसले को होमवर्क बना देते हैं।",
    ] },
    { type: "h2", accent: "green", text: "जो सवाल काम नहीं करते" },
    { type: "ul", items: [
      "**आपके बारे में ऐसी बातें जिनका अंदाज़ा कोई नहीं लगा सकता।** बचपन की गली, पहले पालतू का नाम। सोचने के लिए कुछ है ही नहीं, तो चार पहलुओं वाला सिक्का उछालना रह जाता है।",
      "**जिसका जवाब बहस का विषय हो।** “इनमें सबसे अच्छी फ़िल्म कौन सी है?” का कोई सही जवाब नहीं होता, सिर्फ़ आपका जवाब होता है, और बाहर से उसे कोई नहीं ढूँढ सकता।",
      "**ऐसी कोई बात जिसका सही जवाब आप किसी अजनबी से नहीं चाहेंगे।** आप कहाँ रहते हैं, किस जिम जाते हैं, घर पर अकेले कब होते हैं। सवाल का मक़सद ही यह है कि उसका सही जवाब कोई ऐसा दे जिससे आप अभी मिले नहीं हैं।",
      "**वे सवाल जिनमें अच्छा दिखने वाला विकल्प साफ़ पता चल जाए।** तीन स्वार्थी जवाबों के बीच एक भला जवाब सिर्फ़ यह नापता है कि सामने वाला माहौल पढ़ पाता है या नहीं।",
    ] },
    { type: "p", text: "अगर खाली बॉक्स देखकर अटक गए हैं, तो नीचे दिए उदाहरणों में से कोई एक लीजिए और तब तक बदलिए जब तक वह आपके बारे में न हो जाए — शून्य से सोचने के मुकाबले यह तेज़ है। और आज ही हर जगह भरना ज़रूरी नहीं: फ़ॉर्म पूरा करने के लिए लिखे गए चार सवालों से बेहतर हैं वे दो सवाल जो आपको सचमुच पसंद हों।" },
  ],
};
