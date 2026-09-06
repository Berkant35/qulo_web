import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * SOURCES, both verified directly rather than taken from a summary:
 *
 * - Origin and definition: Dictionary.com's slang entry for the term. It
 *   records that a dating app coined it in 2017 — the app is NOT named here,
 *   per the site-wide rule that Qulo is the only dating app named anywhere.
 * - The research: Hancock, Toma & Ellison, "The Truth about Lying in Online
 *   Dating Profiles", CHI 2007. 80 online daters had their height and weight
 *   measured in a lab and their age verified, then compared with their
 *   profiles. Nearly two thirds were off on weight by five pounds or more,
 *   nearly half lied about height, age was least lied about — and the average
 *   height deviation was 0.33 inches. That last number is the point: the
 *   deception is frequent but small, which is exactly what this word names.
 *
 * NOT USED: a widely repeated "81% lied about a physical characteristic"
 * figure attributed to a 2008 follow-up. It could not be verified at source
 * (publisher returned 403), so it is not published here. The 2007 paper says
 * something better anyway, and it says it first-hand.
 *
 * NOT CLAIMED: that writing questions verifies identity or screens out people
 * who exaggerate. It does not, and `glossary.ts` forbids implying it.
 */
export const kittenfishing: LocalizedGlossaryEntry = {
  en: {
    term: "Kittenfishing",
    summary:
      "Presenting a flattering but misleading version of yourself online — an old or edited photo, a rounded-up height, a job title with more shine than the work — without inventing the whole person the way catfishing does.",
    blocks: [
      { type: "h2", text: "A small lie, not a false identity" },
      { type: "p", text: "A dating app coined the word in 2017 and it stuck, because it named something the existing vocabulary missed. Catfishing is a whole invented person. Kittenfishing is the kitten-sized version: the person is real, will turn up, and is who they said — they have just been generous with themselves. The photo is three years and one haircut old. The height is rounded to the number above. The job is described the way it would be on a good day." },
      { type: "p", text: "This is not a rare failing, and the research is unusually clean about it. In **The Truth about Lying in Online Dating Profiles** (Hancock, Toma and Ellison, CHI 2007), eighty online daters had their height and weight measured in a lab and their age checked, then compared with what their profiles said. Nearly two thirds were off on weight by five pounds or more, and nearly half had shifted their height; age was the least altered. But the average height discrepancy was about a third of an inch. That combination — very common, very small — is the whole of what this word describes, and it is why treating it as a scandal usually gets it wrong." },

      { type: "h2", text: "How to recognise the pattern" },
      {
        type: "ul",
        items: [
          "Every photo is a flattering angle, and none of them is recent or plainly lit.",
          "There are no full-length or candid pictures, only portraits and holidays.",
          "Details drift slightly between the profile, the messages and the conversation.",
          "They stall on a video call or a same-week meeting without ever refusing one.",
        ],
      },

      { type: "h2", accent: "green", text: "What to do about it" },
      { type: "p", text: "Assume some polish and do not treat it as a verdict. Nearly everyone edits themselves upward a little, and the study above suggests the edit is usually small enough not to matter. What is worth doing is meeting sooner rather than later, in an ordinary public place, before a picture in your head hardens into an expectation the person cannot meet. A short first meeting settles in twenty minutes what weeks of messaging cannot." },
      { type: "p", text: "The line worth watching is not accuracy but scale. A softened photo is vanity. A different age, a job that does not exist, a partner left out of the story — that is not kittenfishing any more, and the honest response is to leave, not to negotiate. And it is worth turning the question around: the parts of a profile that can be polished are the parts that say least about whether you will enjoy each other's company." },
    ],
  },
  tr: {
    term: "Kittenfishing",
    summary:
      "Kimliği baştan uydurmadan, kendini çevrimiçi ortamda olduğundan daha parlak gösterme — eski ya da rötuşlanmış fotoğraf, yukarı yuvarlanmış boy, işin kendisinden daha gösterişli bir unvan.",
    blocks: [
      { type: "h2", text: "Küçük bir abartı, sahte bir kimlik değil" },
      { type: "p", text: "Kelimeyi 2017'de bir tanışma uygulaması ortaya attı ve tuttu; çünkü mevcut sözcüklerin kaçırdığı bir şeye ad koydu. Catfishing baştan uydurulmuş bir insandır. Kittenfishing ise onun yavru boyu: karşındaki kişi gerçek, buluşmaya gelecek ve söylediği kişi — sadece kendine karşı cömert davranmış. Fotoğraf üç yıl ve bir saç kesimi eski. Boy bir üst sayıya yuvarlanmış. İş, iyi bir günde anlatılacağı gibi anlatılmış." },
      { type: "p", text: "Bu nadir bir kusur değil ve araştırma bu konuda alışılmadık biçimde net. **The Truth about Lying in Online Dating Profiles** (Hancock, Toma ve Ellison, CHI 2007) çalışmasında seksen çevrimiçi tanışma kullanıcısının boyu ve kilosu laboratuvarda ölçüldü, yaşı doğrulandı ve profillerinde yazanla karşılaştırıldı. Neredeyse üçte ikisinin kilosu iki kilodan fazla sapmıştı, neredeyse yarısı boyunu kaydırmıştı; en az oynanan bilgi yaştı. Ama ortalama boy farkı bir santimin altındaydı. Bu birleşim — çok yaygın, çok küçük — bu kelimenin anlattığı şeyin tamamı ve meseleyi skandal muamelesi görmenin neden çoğu zaman yanlış olduğunun sebebi." },

      { type: "h2", text: "Örüntüyü nasıl tanırsın" },
      {
        type: "ul",
        items: [
          "Bütün fotoğraflar kollayıcı bir açıdan çekilmiş; hiçbiri yeni ya da düz ışıkta değil.",
          "Boy fotoğrafı ya da doğal kare yok, sadece portreler ve tatil kareleri.",
          "Ayrıntılar profil, mesajlar ve sohbet arasında hafifçe kayıyor.",
          "Görüntülü konuşmayı ya da yakın tarihli buluşmayı hiç reddetmeden sürekli erteliyor.",
        ],
      },

      { type: "h2", accent: "green", text: "Ne yapmalı" },
      { type: "p", text: "Bir miktar cila olduğunu varsay ve bunu hüküm yerine koyma. Neredeyse herkes kendini biraz yukarı çeker ve yukarıdaki çalışma bu düzeltmenin genelde önemsiz kalacak kadar küçük olduğunu gösteriyor. Asıl işe yarayan şey, geç değil erken buluşmak: sıradan ve kalabalık bir yerde, kafandaki görüntü karşıdakinin karşılayamayacağı bir beklentiye dönüşmeden önce. Kısa bir ilk buluşma, haftalarca mesajlaşmanın çözemediğini yirmi dakikada çözer." },
      { type: "p", text: "Dikkat edilecek çizgi doğruluk değil, ölçek. Yumuşatılmış bir fotoğraf kibirdir. Farklı bir yaş, var olmayan bir iş, anlatıdan çıkarılmış bir partner — bunlar artık kittenfishing değildir ve dürüst karşılık pazarlık etmek değil, kalkıp gitmektir. Bir de soruyu tersine çevirmeye değer: bir profilin cilalanabilen kısımları, birlikte vakit geçirmekten keyif alıp almayacağın konusunda en az şey söyleyen kısımlarıdır." },
    ],
  },
  de: {
    term: "Kittenfishing",
    summary:
      "Sich online vorteilhafter darstellen, als man ist — ein altes oder bearbeitetes Foto, eine aufgerundete Körpergröße, ein Jobtitel mit mehr Glanz als die Arbeit dahinter —, ohne dabei wie beim Catfishing gleich eine ganze Person zu erfinden.",
    blocks: [
      { type: "h2", text: "Eine kleine Übertreibung, keine falsche Identität" },
      { type: "p", text: "Eine Dating-App prägte das Wort 2017, und es blieb hängen, weil es etwas benannte, das im vorhandenen Wortschatz gefehlt hatte. Catfishing ist eine komplett erfundene Person. Kittenfishing ist die Kätzchen-Variante davon: Die Person ist echt, sie kommt zum Treffen, und sie ist, wer sie gesagt hat — sie war nur großzügig mit sich selbst. Das Foto ist drei Jahre und einen Haarschnitt alt. Die Körpergröße ist auf die nächste Zahl aufgerundet. Der Job ist so beschrieben, wie er an einem guten Tag wäre." },
      { type: "p", text: "Das ist kein seltenes Vergehen, und die Forschung dazu ist ungewöhnlich klar. In der Studie **The Truth about Lying in Online Dating Profiles** (Hancock, Toma und Ellison, CHI 2007) wurden achtzig Menschen, die online daten, im Labor gemessen und gewogen und ihr Alter überprüft; danach wurde all das mit ihren Profilangaben verglichen. Bei fast zwei Dritteln wich das Gewicht um zwei Kilo oder mehr ab, fast die Hälfte hatte die Körpergröße verschoben; am Alter wurde am wenigsten gedreht. Die durchschnittliche Abweichung bei der Größe lag aber unter einem Zentimeter. Diese Kombination — sehr häufig, sehr klein — ist genau das, was dieses Wort beschreibt, und der Grund, warum es meistens danebengeht, die Sache als Skandal zu behandeln." },
      { type: "h2", text: "Woran du das Muster erkennst" },
      {
        type: "ul",
        items: [
          "Alle Fotos sind aus einem vorteilhaften Winkel, und keines ist aktuell oder schlicht ausgeleuchtet.",
          "Es gibt keine Ganzkörper- und keine Schnappschussbilder, nur Porträts und Urlaub.",
          "Details verschieben sich leicht zwischen Profil, Nachrichten und Gespräch.",
          "Ein Videocall oder ein Treffen noch in derselben Woche wird immer wieder verschoben, aber nie abgelehnt.",
        ],
      },
      { type: "h2", accent: "green", text: "Was du tun kannst" },
      { type: "p", text: "Geh von etwas Politur aus und mach daraus kein Urteil. Fast alle schrauben sich ein wenig nach oben, und die Studie oben legt nahe, dass diese Korrektur meistens klein genug ist, um keine Rolle zu spielen. Was wirklich hilft: sich früher treffen als später, an einem gewöhnlichen öffentlichen Ort, bevor das Bild im Kopf zu einer Erwartung erstarrt, die niemand einlösen kann. Ein kurzes erstes Treffen klärt in zwanzig Minuten, was wochenlanges Schreiben nicht klärt." },
      { type: "p", text: "Die Grenze, auf die es ankommt, ist nicht Genauigkeit, sondern Ausmaß. Ein geschöntes Foto ist Eitelkeit. Ein anderes Alter, ein Job, den es nicht gibt, eine Partnerin oder ein Partner, die in der Erzählung nie vorkommen — das ist kein Kittenfishing mehr, und die ehrliche Antwort darauf ist zu gehen, nicht zu verhandeln. Und es lohnt sich, die Frage umzudrehen: Ausgerechnet die Teile eines Profils, die sich polieren lassen, sagen am wenigsten darüber, ob ihr euch in der Gesellschaft des anderen wohlfühlen werdet." },
    ],
  },
  fr: {
    term: "Kittenfishing",
    summary:
      "Se présenter en ligne sous un jour flatteur mais trompeur — une photo ancienne ou retouchée, une taille arrondie vers le haut, un intitulé de poste plus brillant que le travail réel — sans inventer toute une personne comme le fait le catfishing.",
    blocks: [
      { type: "h2", text: "Un petit arrangement, pas une fausse identité" },
      { type: "p", text: "Une application de rencontre a lancé le mot en 2017 et il est resté, parce qu’il nommait quelque chose que le vocabulaire existant laissait de côté. Le catfishing, c’est une personne entièrement inventée. Le kittenfishing en est la version « chaton » : la personne est réelle, elle viendra au rendez-vous, et elle est bien celle qu’elle a dit être — elle a simplement été généreuse avec elle-même. La photo a trois ans et une coupe de cheveux de retard. La taille est arrondie au chiffre au-dessus. Le métier est décrit comme il le serait un bon jour." },
      { type: "p", text: "Ce n’est pas un travers rare, et la recherche est inhabituellement nette là-dessus. Dans **The Truth about Lying in Online Dating Profiles** (Hancock, Toma et Ellison, CHI 2007), quatre-vingts personnes qui utilisaient des sites de rencontre ont été mesurées et pesées en laboratoire, leur âge vérifié, puis le tout comparé à ce que disait leur profil. Près des deux tiers se trompaient d’au moins deux kilos sur le poids, et près de la moitié avaient déplacé leur taille ; l’âge était l’information la moins retouchée. Mais l’écart moyen sur la taille était inférieur à un centimètre. Cette combinaison — très fréquent, très petit — c’est tout ce que ce mot décrit, et c’est pourquoi en faire un scandale passe généralement à côté." },
      { type: "h2", text: "Comment reconnaître ce schéma" },
      {
        type: "ul",
        items: [
          "Toutes les photos sont prises sous un angle avantageux, et aucune n’est récente ni simplement éclairée.",
          "Aucune photo en pied ni prise sur le vif : seulement des portraits et des vacances.",
          "Les détails se déplacent légèrement entre le profil, les messages et la conversation.",
          "Un appel vidéo ou un rendez-vous dans la semaine est sans cesse repoussé, sans jamais être refusé.",
        ],
      },
      { type: "h2", accent: "green", text: "Que faire" },
      { type: "p", text: "Partez du principe qu’il y a un peu de vernis, et n’en faites pas un verdict. Presque tout le monde se retouche légèrement vers le haut, et l’étude ci-dessus suggère que la retouche est le plus souvent trop petite pour compter. Ce qui vaut la peine, c’est de se voir tôt plutôt que tard, dans un lieu public ordinaire, avant que l’image que vous vous faites ne durcisse en une attente que la personne ne pourra pas satisfaire. Une première rencontre courte règle en vingt minutes ce que des semaines de messages ne règlent pas." },
      { type: "p", text: "La ligne à surveiller n’est pas l’exactitude, c’est l’échelle. Une photo adoucie relève de la vanité. Un autre âge, un métier qui n’existe pas, un ou une partenaire qui n’apparaît jamais dans le récit — ce n’est plus du kittenfishing, et la réponse honnête est de partir, pas de négocier. Et il vaut la peine de retourner la question : les parties d’un profil que l’on peut polir sont justement celles qui disent le moins si vous prendrez plaisir à la compagnie de l’autre." },
    ],
  },
  es: {
    term: "Kittenfishing",
    summary:
      "Presentarse en internet con una versión favorecedora pero engañosa de uno mismo — una foto antigua o retocada, una estatura redondeada hacia arriba, un puesto con más brillo que el trabajo real — sin inventarse a la persona entera como hace el catfishing.",
    blocks: [
      { type: "h2", text: "Una exageración pequeña, no una identidad falsa" },
      { type: "p", text: "El término lo acuñó una aplicación de citas en 2017 y cuajó, porque le puso nombre a algo que el vocabulario existente se dejaba fuera. El catfishing es una persona inventada entera. El kittenfishing es su versión en pequeño: la persona es real, aparecerá en la cita y es quien dijo ser — solo que ha sido generosa consigo misma. La foto tiene tres años y un corte de pelo de retraso. La estatura está redondeada al número de arriba. El trabajo está contado como sonaría en un buen día." },
      { type: "p", text: "No es un defecto raro, y la investigación es inusualmente limpia en esto. En **The Truth about Lying in Online Dating Profiles** (Hancock, Toma y Ellison, CHI 2007) se midió y se pesó en un laboratorio a ochenta personas que usaban aplicaciones de citas, se comprobó su edad y luego se comparó todo con lo que decía su perfil. A casi dos tercios el peso les bailaba dos kilos o más, y casi la mitad había movido su estatura; la edad fue el dato menos retocado. Pero la diferencia media en la estatura era de menos de un centímetro. Esa combinación — muy frecuente, muy pequeña — es todo lo que describe esta palabra, y es la razón por la que tratarlo como un escándalo suele errar el tiro." },
      { type: "h2", text: "Cómo reconocer el patrón" },
      {
        type: "ul",
        items: [
          "Todas las fotos están tomadas desde un ángulo favorecedor, y ninguna es reciente ni tiene luz plana.",
          "No hay fotos de cuerpo entero ni espontáneas: solo retratos y vacaciones.",
          "Los detalles se desplazan un poco entre el perfil, los mensajes y la conversación.",
          "Aplaza una videollamada o una quedada esta misma semana sin llegar a rechazarla nunca.",
        ],
      },
      { type: "h2", accent: "green", text: "Qué puedes hacer" },
      { type: "p", text: "Da por hecho que hay algo de barniz y no lo conviertas en un veredicto. Casi todo el mundo se retoca un poco hacia arriba, y el estudio de arriba sugiere que ese retoque suele ser demasiado pequeño para importar. ¿Qué compensa de verdad? Verse pronto en lugar de tarde, en un sitio público y corriente, antes de que la imagen que tienes en la cabeza se endurezca en una expectativa que la otra persona no puede cumplir. Un primer encuentro corto resuelve en veinte minutos lo que semanas de mensajes no resuelven." },
      { type: "p", text: "La línea que hay que mirar no es la exactitud, sino la escala. Una foto suavizada es vanidad. Una edad distinta, un trabajo que no existe, una pareja que nunca aparece en el relato — eso ya no es kittenfishing, y la respuesta honesta es irse, no negociar. Y conviene darle la vuelta a la pregunta: las partes de un perfil que se pueden pulir son justo las que menos dicen sobre si vas a disfrutar de su compañía." },
    ],
  },
  ar: {
    term: "Kittenfishing",
    summary:
      "أن تقدّم على الإنترنت نسخة مجمَّلة ومضلِّلة عن نفسك: صورة قديمة أو معدَّلة، وطول مقرَّب إلى الرقم الأعلى، ومسمّى وظيفي أبهى من العمل نفسه، من دون أن تخترع شخصًا كاملًا كما يفعل التصيّد بهوية مزيّفة (catfishing).",
    blocks: [
      { type: "h2", text: "كذبة صغيرة، لا هوية مزيّفة" },
      { type: "p", text: "أطلق أحد تطبيقات المواعدة هذه الكلمة عام 2017 فثبتت، لأنها سمّت شيئًا كانت المفردات الموجودة تفوّته. التصيّد بهوية مزيّفة شخص مخترَع بالكامل. أمّا kittenfishing فهو النسخة الصغيرة منه، بحجم هرّ صغير: الشخص حقيقي، وسيحضر إلى اللقاء، وهو فعلًا من قال إنه هو؛ لكنه كان كريمًا مع نفسه بعض الشيء. الصورة أقدم بثلاث سنوات وقصّة شعر واحدة. الطول مقرَّب إلى الرقم الذي فوقه. والعمل موصوف كما يُوصف في يوم جيّد." },
      { type: "p", text: "وهذا ليس عيبًا نادرًا، والبحث في هذه النقطة واضح بدرجة غير معتادة. في دراسة **The Truth about Lying in Online Dating Profiles** (Hancock, Toma & Ellison, CHI 2007) قِيست أطوال ثمانين من مستخدمي المواعدة عبر الإنترنت وأوزانهم في المختبر، وجرى التحقّق من أعمارهم، ثم قورن ذلك بما كتبوه في ملفاتهم. وزن ما يقارب الثلثين منهم كان مختلفًا بأكثر من كيلوغرامين، وما يقارب النصف حرّكوا أطوالهم؛ وكان العمر أقلّ المعلومات تعديلًا. لكن متوسّط الفارق في الطول ظلّ دون السنتيمتر الواحد. هذا الجمع بين الشيوع الكبير والحجم الصغير هو كامل ما تصفه هذه الكلمة، وهو سبب أنّ التعامل معها كفضيحة يخطئ الهدف في الغالب." },
      { type: "h2", text: "كيف تتعرّف على هذا النمط" },
      {
        type: "ul",
        items: [
          "كلّ الصور من زاوية مجامِلة، ولا واحدة منها حديثة أو بإضاءة عادية.",
          "لا صور بالطول الكامل ولا لقطات عفوية، بل صور شخصية وصور إجازات فقط.",
          "التفاصيل تتزحزح قليلًا بين الملف الشخصي والرسائل والحديث.",
          "يماطل في مكالمة الفيديو أو في لقاء خلال الأسبوع نفسه، من دون أن يرفض ذلك صراحةً أبدًا.",
        ],
      },
      { type: "h2", accent: "green", text: "ماذا تفعل حيال ذلك" },
      { type: "p", text: "افترض وجود شيء من التجميل، ولا تجعل منه حكمًا. الجميع تقريبًا يرفعون صورتهم عن أنفسهم قليلًا، والدراسة أعلاه تشير إلى أنّ هذا التعديل يبقى عادةً أصغر من أن يهمّ. المفيد فعلًا هو أن تلتقيا مبكّرًا لا متأخّرًا، في مكان عام عادي، قبل أن تتصلّب الصورة التي في رأسك وتصير توقّعًا لا يستطيع الطرف الآخر أن يفي به. لقاء أوّل قصير يحسم في عشرين دقيقة ما تعجز عنه أسابيع من الرسائل." },
      { type: "p", text: "الخط الذي يستحق الانتباه ليس الدقّة بل الحجم. صورة مُلطَّفة قليلًا زهوٌ بالنفس. أمّا عمر مختلف، أو وظيفة لا وجود لها، أو شريك غائب عن الحكاية، فلم يعد ذلك kittenfishing، والردّ الأمين هو أن تنصرف لا أن تتفاوض. ويستحق الأمر أن تُقلب المسألة أيضًا: أجزاء الملف الشخصي القابلة للتلميع هي أقلّ الأجزاء دلالةً على ما إذا كنتما ستستمتعان بصحبة أحدكما الآخر." },
    ],
  },
  ru: {
    term: "Киттенфишинг",
    summary:
      "Подача себя в сети в приукрашенном, но обманчивом виде — старое или отредактированное фото, округлённый вверх рост, должность, которая звучит солиднее самой работы, — без выдумывания человека целиком, как это делают при кэтфишинге.",
    blocks: [
      { type: "h2", text: "Небольшое приукрашивание, а не поддельная личность" },
      { type: "p", text: "Слово придумало в 2017 году одно приложение для знакомств, и оно прижилось, потому что назвало то, что прежний словарь упускал. Кэтфишинг — это человек, выдуманный целиком. Киттенфишинг — то же самое размером с котёнка: человек настоящий, придёт на встречу и окажется тем, кем себя назвал, — просто был щедр к себе. Фото трёхлетней давности и на одну стрижку раньше. Рост округлён до следующего числа. Работа описана так, как её описывают в хороший день." },
      { type: "p", text: "Это не редкий изъян, и исследование говорит об этом на удивление ясно. В работе «**The Truth about Lying in Online Dating Profiles**» (Hancock, Toma и Ellison, CHI 2007) восьмидесяти людям, знакомящимся онлайн, измерили в лаборатории рост и вес, проверили возраст, а затем сравнили это с тем, что было указано в их анкетах. Почти у двух третей вес расходился больше чем на два килограмма, почти половина сдвинула свой рост; меньше всего меняли возраст. Но среднее расхождение по росту не дотягивало до сантиметра. Именно это сочетание — очень частое и очень небольшое — и есть всё содержание слова, и поэтому относиться к нему как к скандалу обычно неверно." },
      { type: "h2", text: "Как распознать этот рисунок" },
      {
        type: "ul",
        items: [
          "Все фотографии сняты с выигрышного ракурса, и ни одна не свежая и не при обычном свете.",
          "Нет ни снимков в полный рост, ни случайных кадров — только портреты и отпуск.",
          "Детали слегка расходятся между анкетой, перепиской и разговором.",
          "Видеозвонок или встреча на этой же неделе всё время откладываются, хотя прямо от них не отказываются.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Исходите из того, что некоторый лоск будет, и не превращайте это в приговор. Почти каждый немного подтягивает себя вверх, а исследование выше говорит, что поправка обычно слишком мала, чтобы иметь значение. По-настоящему помогает встретиться скорее раньше, чем позже, в обычном людном месте — пока картинка в вашей голове не затвердела в ожидание, которому человек не сможет соответствовать. Короткая первая встреча решает за двадцать минут то, чего не решают недели переписки." },
      { type: "p", text: "Следить стоит не за точностью, а за масштабом. Смягчённое фото — это тщеславие. Другой возраст, несуществующая работа, партнёр, оставшийся за рамками рассказа, — это уже не киттенфишинг, и честный ответ здесь не переговоры, а уход. И вопрос стоит развернуть: те части анкеты, которые поддаются полировке, меньше всего говорят о том, будет ли вам хорошо вместе." },
    ],
  },
  pt: {
    term: "Kittenfishing",
    summary:
      "Apresentar-se online numa versão mais favorável, porém enganosa — uma foto antiga ou editada, uma altura arredondada para cima, um cargo com mais brilho do que o trabalho em si —, sem inventar a pessoa inteira como faz o catfishing.",
    blocks: [
      { type: "h2", text: "Uma mentira pequena, não uma identidade falsa" },
      { type: "p", text: "Um aplicativo de namoro cunhou a palavra em 2017 e ela pegou, porque deu nome a algo que o vocabulário existente não alcançava. Catfishing é uma pessoa inventada do zero. Kittenfishing é a versão em miniatura disso: a pessoa é real, vai aparecer e é quem disse ser — apenas foi generosa consigo mesma. A foto tem três anos e um corte de cabelo de diferença. A altura foi arredondada para o número de cima. O trabalho é descrito do jeito que seria descrito num dia bom." },
      { type: "p", text: "Isso não é um defeito raro, e a pesquisa a respeito é incomumente limpa. Em **The Truth about Lying in Online Dating Profiles** (Hancock, Toma e Ellison, CHI 2007), oitenta usuários de sites de namoro tiveram altura e peso medidos em laboratório e a idade conferida, e tudo foi comparado com o que diziam seus perfis. Quase dois terços erravam o peso em mais de dois quilos e quase metade tinha deslocado a altura; a idade foi o dado menos alterado. Mas a diferença média de altura ficava abaixo de um centímetro. Essa combinação — muito comum, muito pequena — é tudo o que a palavra descreve, e é por isso que tratar o assunto como escândalo costuma ser uma leitura errada." },
      { type: "h2", text: "Como reconhecer o padrão" },
      {
        type: "ul",
        items: [
          "Todas as fotos são de um ângulo favorável, e nenhuma delas é recente ou com luz comum.",
          "Não há fotos de corpo inteiro nem cliques espontâneos, só retratos e viagens.",
          "As informações mudam um pouco entre o perfil, as mensagens e a conversa.",
          "A pessoa adia a chamada de vídeo ou um encontro nos próximos dias sem nunca recusar de fato.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer" },
      { type: "p", text: "Parta do princípio de que existe algum retoque e não transforme isso em veredito. Quase todo mundo se ajeita um pouco para cima, e o estudo acima sugere que o ajuste costuma ser pequeno demais para fazer diferença. O que vale mesmo é se encontrar cedo em vez de tarde, num lugar público comum, antes que a imagem na sua cabeça endureça numa expectativa que a pessoa não vai conseguir alcançar. Um primeiro encontro curto resolve em vinte minutos o que semanas de mensagens não resolvem." },
      { type: "p", text: "A linha que importa não é a exatidão, é a escala. Uma foto suavizada é vaidade. Já uma idade diferente, um emprego que não existe, um parceiro deixado de fora da história — isso não é mais kittenfishing, e a resposta honesta é ir embora, não negociar. E vale virar a pergunta do avesso: as partes de um perfil que dá para lustrar são justamente as que menos dizem sobre se vocês vão gostar da companhia um do outro." },
    ],
  },
  it: {
    term: "Kittenfishing",
    summary:
      "Presentarsi online in una versione più lusinghiera ma fuorviante di sé — una foto vecchia o ritoccata, un’altezza arrotondata per eccesso, un titolo di lavoro più brillante del lavoro stesso — senza inventare la persona intera come fa il catfishing.",
    blocks: [
      { type: "h2", text: "Una piccola bugia, non un’identità falsa" },
      { type: "p", text: "Un’app di incontri ha coniato la parola nel 2017 ed è rimasta, perché dava un nome a qualcosa che il vocabolario esistente si lasciava sfuggire. Il catfishing è una persona inventata da capo. Il kittenfishing ne è la versione in miniatura: la persona è reale, si presenterà davvero ed è chi ha detto di essere — è solo stata generosa con se stessa. La foto ha tre anni e un taglio di capelli. L’altezza è arrotondata al numero sopra. Il lavoro è raccontato come lo si racconterebbe in una buona giornata." },
      { type: "p", text: "Non è un difetto raro, e la ricerca su questo è insolitamente pulita. In **The Truth about Lying in Online Dating Profiles** (Hancock, Toma e Ellison, CHI 2007) a ottanta persone iscritte a siti di incontri sono stati misurati altezza e peso in laboratorio ed è stata verificata l’età, poi si è confrontato tutto con quello che dicevano i loro profili. Quasi due terzi si discostavano di più di due chili sul peso e quasi la metà aveva spostato l’altezza; l’età era il dato meno ritoccato. Ma lo scarto medio di altezza restava sotto il centimetro. Questa combinazione — molto diffusa, molto piccola — è tutto ciò che questa parola descrive, ed è il motivo per cui trattare la cosa come uno scandalo di solito significa fraintenderla." },
      { type: "h2", text: "Come riconoscere lo schema" },
      {
        type: "ul",
        items: [
          "Tutte le foto sono prese da un’angolazione vantaggiosa, e nessuna è recente o con una luce piena.",
          "Non ci sono foto a figura intera né scatti spontanei, solo ritratti e vacanze.",
          "I dettagli si spostano leggermente tra il profilo, i messaggi e la conversazione.",
          "Rimanda la videochiamata o un incontro a breve senza però rifiutarli mai.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa fare" },
      { type: "p", text: "Dai per scontato un po’ di ritocco e non trasformarlo in una sentenza. Quasi tutti si ritoccano un po’ verso l’alto, e lo studio qui sopra suggerisce che il ritocco è di solito abbastanza piccolo da non contare. Quello che vale la pena fare è vedersi presto anziché tardi, in un posto pubblico e ordinario, prima che l’immagine che hai in testa si indurisca in un’aspettativa che la persona non potrà soddisfare. Un primo incontro breve risolve in venti minuti quello che settimane di messaggi non risolvono." },
      { type: "p", text: "La linea da tenere d’occhio non è l’esattezza, è la scala. Una foto addolcita è vanità. Un’età diversa, un lavoro che non esiste, un partner lasciato fuori dal racconto — quello non è più kittenfishing, e la risposta onesta è andarsene, non trattare. E vale la pena ribaltare la domanda: le parti di un profilo che si possono lucidare sono proprio quelle che dicono meno su quanto vi troverete bene insieme." },
    ],
  },
  ja: {
    term: "キトゥンフィッシング",
    summary:
      "キャットフィッシングのように別人をまるごと作り上げるのではなく、古い写真や加工した写真、切り上げた身長、実際の仕事より輝いて見える肩書きといった形で、自分を少しだけ良く見せてネットに差し出すことです。",
    blocks: [
      { type: "h2", text: "小さな盛りであって、偽の身元ではない" },
      { type: "p", text: "この言葉は2017年にあるマッチングアプリが名づけ、そのまま定着しました。それまでの語彙が取りこぼしていたものに、名前がついたからです。キャットフィッシングは、まるごと作り上げられた別人のこと。キトゥンフィッシングはその子猫サイズの版です。相手は実在し、待ち合わせにも現れ、名乗ったとおりの人物です。ただ、自分に対して少し気前がよかっただけ。写真は三年と一回の散髪ぶん古い。身長はひとつ上の数字に切り上げてある。仕事は、調子のいい日の言い方で書いてある。" },
      { type: "p", text: "これは珍しい欠点ではありませんし、研究のほうも珍しいほど明快です。**The Truth about Lying in Online Dating Profiles**（Hancock, Toma & Ellison, CHI 2007）では、オンラインで出会いを探す八十人の身長と体重を実験室で測り、年齢を確認したうえで、プロフィールの記載と突き合わせました。三分の二近くは体重が二キロ以上ずれており、半数近くが身長を動かしていました。もっとも手が加えられていなかったのは年齢です。ただし身長の食い違いは、平均すると一センチに届きませんでした。とても多く、とても小さい。この組み合わせがこの言葉の指す内容のすべてで、これを醜聞のように扱うとたいてい的を外すのは、そのためです。" },
      { type: "h2", text: "パターンの見分け方" },
      {
        type: "ul",
        items: [
          "写真がどれも良く映る角度で、新しいものも、普通の光で撮ったものもない。",
          "全身写真や自然なスナップがなく、ポートレートと旅行の写真ばかり。",
          "プロフィールとメッセージと会話のあいだで、細部がわずかにずれていく。",
          "ビデオ通話や近いうちの対面を、はっきり断ることはないまま先延ばしにする。",
        ],
      },
      { type: "h2", accent: "green", text: "どうすればいいか" },
      { type: "p", text: "多少は盛られていると考えて、それを判決にはしないでください。ほとんどの人は自分を少し上に寄せますし、先ほどの研究が示すのは、その修正はたいてい問題にならない程度に小さいということです。役に立つのは、遅くではなく早めに、ふつうの人の多い場所で会っておくこと。頭のなかの像が固まって、相手には応えようのない期待に変わってしまう前にです。短い初対面は、何週間ものやり取りで解けないことを二十分で片づけます。" },
      { type: "p", text: "見るべき線は正確さではなく、規模のほうです。柔らかく写した写真は見栄です。違う年齢、存在しない仕事、話から抜け落ちたパートナー。ここまで来るともうキトゥンフィッシングではありませんし、誠実な応じ方は交渉ではなく、その場を離れることです。そして、問いを裏返してみる価値もあります。プロフィールのうち磨ける部分は、その人と一緒にいて楽しいかどうかについて、いちばん語らない部分でもあるのです。" },
    ],
  },
  ko: {
    term: "키튼피싱",
    summary:
      "캣피싱처럼 사람을 통째로 지어내지는 않으면서, 오래되었거나 보정한 사진, 올려 잡은 키, 실제 하는 일보다 그럴듯한 직함처럼 자신을 조금 더 좋게 꾸며 온라인에 내놓는 일을 말합니다.",
    blocks: [
      { type: "h2", text: "작은 과장이지, 가짜 신분은 아니다" },
      { type: "p", text: "2017년 한 데이팅 앱이 이 말을 만들었고 그대로 자리를 잡았습니다. 그때까지의 어휘가 놓치고 있던 것에 이름을 붙였기 때문입니다. 캣피싱은 통째로 지어낸 사람입니다. 키튼피싱은 그 새끼 고양이만 한 판본입니다. 상대는 실제로 있고, 약속에 나오고, 말한 그 사람이 맞습니다. 다만 자기 자신에게 조금 후했을 뿐입니다. 사진은 삼 년과 머리 한 번 자른 만큼 오래되었습니다. 키는 한 칸 위 숫자로 올려 잡혔습니다. 하는 일은 컨디션 좋은 날에 설명할 법한 방식으로 적혀 있습니다." },
      { type: "p", text: "이건 드문 흠이 아니고, 연구도 이 대목에서만큼은 유난히 깔끔합니다. **The Truth about Lying in Online Dating Profiles**(Hancock, Toma & Ellison, CHI 2007)에서는 온라인으로 만남을 찾는 여든 명의 키와 몸무게를 실험실에서 재고 나이를 확인한 뒤, 프로필에 적힌 내용과 비교했습니다. 3분의 2에 가까운 사람이 몸무게에서 2킬로그램 넘게 어긋났고, 절반 가까이가 키를 옮겨 적었습니다. 가장 덜 손댄 정보는 나이였습니다. 그런데 키의 평균 차이는 1센티미터에 못 미쳤습니다. 아주 흔하고 아주 작다는 이 조합이 이 말이 가리키는 전부이고, 이걸 스캔들처럼 다루면 대개 어긋나는 이유이기도 합니다." },
      { type: "h2", text: "이 패턴을 알아보는 법" },
      {
        type: "ul",
        items: [
          "사진이 하나같이 잘 나오는 각도이고, 최근이거나 평범한 조명에서 찍힌 것은 없습니다.",
          "전신 사진이나 자연스러운 스냅은 없고, 인물 사진과 여행 사진뿐입니다.",
          "프로필과 메시지와 실제 대화 사이에서 세부가 조금씩 어긋납니다.",
          "영상 통화나 이번 주 안의 만남을 한 번도 거절하지는 않으면서 계속 미룹니다.",
        ],
      },
      { type: "h2", accent: "green", text: "무엇을 하면 좋을까" },
      { type: "p", text: "어느 정도 손질은 있으려니 하고, 그걸 판결로 삼지는 마세요. 거의 모두가 자기를 조금 위로 끌어올리고, 앞의 연구는 그 손질이 대개 문제 될 만큼 크지 않다고 말합니다. 정말 도움이 되는 건 늦게보다 일찍 만나는 일입니다. 평범하고 사람 많은 곳에서, 머릿속 이미지가 상대는 맞출 수 없는 기대로 굳어지기 전에요. 짧은 첫 만남은 몇 주의 메시지가 풀지 못한 것을 이십 분 만에 정리해 줍니다." },
      { type: "p", text: "지켜볼 선은 정확함이 아니라 규모입니다. 부드럽게 찍힌 사진은 허영입니다. 다른 나이, 존재하지 않는 직장, 이야기에서 빠진 애인. 여기까지 오면 더 이상 키튼피싱이 아니고, 정직한 대응은 협상이 아니라 그 자리를 떠나는 일입니다. 그리고 질문을 뒤집어 볼 만도 합니다. 프로필에서 다듬을 수 있는 부분은, 그 사람과 함께 있는 시간이 즐거울지에 대해 가장 적게 말해 주는 부분이기도 하니까요." },
    ],
  },
  zh: {
    term: "Kittenfishing",
    summary:
      "不像网络身份造假那样凭空造出一整个人，只是把自己在网上呈现得比实际更好看一点——旧的或修过的照片、往上取整的身高、比工作本身更体面的头衔。",
    blocks: [
      { type: "h2", text: "一点小小的美化，不是假身份" },
      { type: "p", text: "这个词是 2017 年由一款交友软件造出来的，后来就留了下来，因为它给原有词汇漏掉的那件事命了名。网络身份造假是从头到尾虚构出来的一个人。Kittenfishing 则是它的幼猫版：人是真的，会如约出现，也确实是他说的那个人——只是对自己宽厚了一点。照片是三年前、上一个发型时拍的。身高往上取整到了下一个数字。工作是按状态最好的那天来描述的。" },
      { type: "p", text: "这不是什么罕见的毛病，而且研究在这件事上难得地干净。在**The Truth about Lying in Online Dating Profiles**（Hancock、Toma 和 Ellison，CHI 2007）这项研究里，八十位网络交友的人在实验室里量了身高体重、核对了年龄，再和他们资料上写的做比较。将近三分之二的人体重偏差超过两公斤，将近一半的人挪动了身高；被改动最少的是年龄。但平均的身高误差还不到一厘米。这个组合——非常普遍，又非常轻微——就是这个词所描述的全部，也是把它当成丑闻通常会弄错的原因。" },
      { type: "h2", text: "怎么看出这个模式" },
      {
        type: "ul",
        items: [
          "每张照片都挑了显好看的角度，没有一张是近期拍的，也没有一张是在平光下拍的。",
          "没有全身照，也没有随手拍的抓拍，只有半身照和旅行照。",
          "一些细节在资料、聊天记录和当面说的话之间有细微出入。",
          "视频通话或者这周就见一面，他从不明说拒绝，但一直往后拖。",
        ],
      },
      { type: "h2", accent: "green", text: "可以怎么做" },
      { type: "p", text: "先假定对方多少修饰过，但别把它当成判决。几乎每个人都会把自己往上调一点，而上面那项研究说明，这点调整通常小到不影响什么。真正值得做的是早一点见面，而不是拖着：找个普通的公共场所，赶在你脑子里的那个形象固化成对方达不到的期待之前见上一面。一次简短的初次见面，二十分钟就能解决聊上几个星期都解决不了的事。" },
      { type: "p", text: "值得留意的那条线不是准不准，而是差多少。一张修柔了的照片只是虚荣。换掉的年龄、根本不存在的工作、从故事里被略过的伴侣——那已经不是 kittenfishing 了，诚实的回应是走人，而不是讨价还价。还有一点值得反过来想：一份资料里能被修饰的那些部分，恰恰是最说明不了你们相处得开不开心的部分。" },
    ],
  },
  nl: {
    term: "Kittenfishing",
    summary:
      "Jezelf online mooier maar misleidend presenteren — een oude of bewerkte foto, een naar boven afgeronde lengte, een functietitel met meer glans dan het werk zelf — zonder de hele persoon te verzinnen zoals catfishing dat doet.",
    blocks: [
      { type: "h2", text: "Een kleine leugen, geen valse identiteit" },
      { type: "p", text: "Een datingapp bedacht het woord in 2017 en het bleef hangen, omdat het iets benoemde wat in de bestaande woordenschat ontbrak. Catfishing is een compleet verzonnen persoon. Kittenfishing is de kittenversie daarvan: de ander is echt, komt ook opdagen en is wie die zei te zijn — alleen wat royaal geweest voor zichzelf. De foto is drie jaar en één kapsel oud. De lengte is naar boven afgerond. Het werk wordt beschreven zoals je het op een goede dag zou beschrijven." },
      { type: "p", text: "Dit is geen zeldzame misstap, en het onderzoek is er ongewoon helder over. In **The Truth about Lying in Online Dating Profiles** (Hancock, Toma en Ellison, CHI 2007) werden bij tachtig gebruikers van datingsites lengte en gewicht in een lab gemeten en hun leeftijd gecontroleerd, en daarna vergeleken met wat hun profiel zei. Bijna twee derde zat er met het gewicht meer dan twee kilo naast en bijna de helft had de lengte verschoven; leeftijd werd het minst aangepast. Maar het gemiddelde verschil in lengte bleef onder de centimeter. Die combinatie — heel gewoon, heel klein — is precies wat dit woord beschrijft, en het is de reden dat er een schandaal van maken er meestal naast zit." },
      { type: "h2", text: "Hoe je het patroon herkent" },
      {
        type: "ul",
        items: [
          "Elke foto is vanuit een flatteuze hoek genomen, en geen ervan is recent of gewoon belicht.",
          "Er zijn geen foto’s ten voeten uit en geen spontane kiekjes, alleen portretten en vakanties.",
          "Details verschuiven licht tussen het profiel, de berichten en het gesprek.",
          "Een videogesprek of een afspraak deze week wordt steeds uitgesteld, zonder ooit geweigerd te worden.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je kunt doen" },
      { type: "p", text: "Ga uit van wat opsmuk en maak er geen vonnis van. Bijna iedereen poetst zichzelf een beetje op, en het onderzoek hierboven suggereert dat die opsmuk meestal klein genoeg is om niet uit te maken. Wat wél helpt is elkaar eerder dan later ontmoeten, op een gewone openbare plek, voordat het beeld in je hoofd verhardt tot een verwachting waaraan de ander niet kan voldoen. Een korte eerste ontmoeting maakt in twintig minuten duidelijk wat weken appen niet duidelijk maken." },
      { type: "p", text: "De grens die telt is niet nauwkeurigheid maar schaal. Een verzachte foto is ijdelheid. Een andere leeftijd, een baan die niet bestaat, een partner die uit het verhaal is weggelaten — dat is geen kittenfishing meer, en het eerlijke antwoord is weggaan, niet onderhandelen. En het is de moeite waard de vraag om te draaien: juist de onderdelen van een profiel die je kunt oppoetsen, zeggen het minst over de vraag of jullie het samen leuk zullen hebben." },
    ],
  },
  pl: {
    term: "Kittenfishing",
    summary:
      "Pokazywanie w sieci korzystniejszej, ale mylącej wersji siebie — stare albo podretuszowane zdjęcie, wzrost zaokrąglony w górę, stanowisko brzmiące okazalej niż sama praca — bez wymyślania całej osoby od zera, jak przy catfishingu.",
    blocks: [
      { type: "h2", text: "Drobne podkoloryzowanie, nie fałszywa tożsamość" },
      { type: "p", text: "Słowo ukuła w 2017 roku pewna aplikacja randkowa i przyjęło się, bo nazwało coś, czego wcześniejsze słownictwo nie obejmowało. Catfishing to człowiek wymyślony od zera. Kittenfishing to ta sama rzecz w rozmiarze kociaka: ta osoba istnieje, przyjdzie na spotkanie i jest tą, za którą się podaje — po prostu była dla siebie hojna. Zdjęcie ma trzy lata i jedną fryzurę mniej. Wzrost zaokrąglono do liczby wyżej. Praca opisana jest tak, jak opisywałoby się ją w dobry dzień." },
      { type: "p", text: "To nie jest rzadka przywara, a badania mówią o tym wyjątkowo jasno. W pracy **The Truth about Lying in Online Dating Profiles** (Hancock, Toma i Ellison, CHI 2007) osiemdziesięciu osobom randkującym w sieci zmierzono w laboratorium wzrost i wagę oraz sprawdzono wiek, a potem porównano to z ich profilami. U prawie dwóch trzecich waga rozmijała się o ponad dwa kilogramy, prawie połowa przesunęła swój wzrost; najmniej zmieniano wiek. Ale średnia różnica wzrostu nie sięgała centymetra. To połączenie — bardzo częste, bardzo drobne — jest całą treścią tego słowa i powodem, dla którego robienie z tego skandalu zwykle mija się z celem." },
      { type: "h2", text: "Jak rozpoznać ten schemat" },
      {
        type: "ul",
        items: [
          "Każde zdjęcie jest z korzystnego ujęcia i żadne nie jest świeże ani zrobione w zwykłym świetle.",
          "Nie ma zdjęć całej sylwetki ani spontanicznych kadrów, są tylko portrety i wakacje.",
          "Szczegóły lekko się rozjeżdżają między profilem, wiadomościami i rozmową.",
          "Rozmowa wideo albo spotkanie w tym tygodniu ciągle się przesuwają, choć nikt ich wprost nie odmawia.",
        ],
      },
      { type: "h2", accent: "green", text: "Co możesz zrobić" },
      { type: "p", text: "Załóż, że trochę lukru będzie, i nie traktuj tego jak wyroku. Prawie każdy podkręca się nieco w górę, a przytoczone badanie sugeruje, że ta poprawka jest zwykle za mała, żeby miała znaczenie. Naprawdę pomaga spotkanie raczej wcześniej niż później, w zwyczajnym miejscu wśród ludzi, zanim obraz w twojej głowie stwardnieje w oczekiwanie, któremu ta osoba nie sprosta. Krótkie pierwsze spotkanie rozstrzyga w dwadzieścia minut to, czego tygodnie pisania rozstrzygnąć nie potrafią." },
      { type: "p", text: "Granica warta uwagi to nie dokładność, tylko skala. Złagodzone zdjęcie to próżność. Inny wiek, nieistniejąca praca, partner pominięty w opowieści — to już nie jest kittenfishing, a uczciwą odpowiedzią jest odejść, a nie negocjować. Warto też odwrócić pytanie: te części profilu, które da się wypolerować, mówią najmniej o tym, czy dobrze wam będzie ze sobą." },
    ],
  },
  sv: {
    term: "Kittenfishing",
    summary:
      "Att visa upp en snyggare men missvisande version av sig själv på nätet — ett gammalt eller retuscherat foto, en uppåtrundad längd, en jobbtitel som glänser mer än arbetet — utan att hitta på hela personen så som vid catfishing.",
    blocks: [
      { type: "h2", text: "En liten skönmålning, inte en falsk identitet" },
      { type: "p", text: "Ordet myntades av en dejtingapp 2017 och blev kvar, för det satte namn på något som de befintliga orden missade. Catfishing är en helt påhittad person. Kittenfishing är kattungeversionen: personen finns på riktigt, dyker upp och är den hen sagt sig vara — hen har bara varit generös mot sig själv. Fotot är tre år och en frisyr gammalt. Längden är avrundad till siffran ovanför. Jobbet beskrivs som det skulle beskrivas en bra dag." },
      { type: "p", text: "Det här är ingen ovanlig brist, och forskningen är ovanligt tydlig på just den punkten. I **The Truth about Lying in Online Dating Profiles** (Hancock, Toma och Ellison, CHI 2007) fick åttio nätdejtare sin längd och vikt uppmätta i ett labb och sin ålder kontrollerad, varefter siffrorna jämfördes med profilerna. Nästan två tredjedelar låg fel på vikten med mer än två kilo, och nästan hälften hade justerat sin längd; åldern ändrades minst. Men den genomsnittliga längdavvikelsen låg under en centimeter. Just den kombinationen — mycket vanlig, mycket liten — är hela innebörden i ordet, och skälet till att det oftast blir fel att behandla saken som en skandal." },
      { type: "h2", text: "Så känner du igen mönstret" },
      {
        type: "ul",
        items: [
          "Varje foto är taget ur en fördelaktig vinkel, och inget av dem är nytt eller taget i vanligt ljus.",
          "Det finns inga helbilder och inga spontana kort, bara porträtt och semesterbilder.",
          "Detaljerna glider lite mellan profilen, meddelandena och samtalet.",
          "Videosamtal eller en träff samma vecka skjuts hela tiden upp, utan att någonsin tackas nej till.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra" },
      { type: "p", text: "Räkna med lite polering och gör ingen dom av det. Nästan alla justerar sig själva en aning uppåt, och studien ovan tyder på att justeringen oftast är för liten för att spela roll. Det som faktiskt hjälper är att ses tidigare snarare än senare, på ett vanligt ställe med folk omkring, innan bilden i ditt huvud hinner stelna till en förväntan som personen inte kan leva upp till. En kort första träff avgör på tjugo minuter det som veckor av meddelanden inte klarar." },
      { type: "p", text: "Gränsen värd att hålla ögonen på är inte exaktheten utan omfattningen. Ett förskönat foto är fåfänga. En annan ålder, ett jobb som inte finns, en partner som utelämnats ur berättelsen — det är inte kittenfishing längre, och det ärliga svaret är att gå, inte att förhandla. Det är också värt att vända på frågan: de delar av en profil som går att polera säger minst om ni kommer att trivas ihop." },
    ],
  },
  hi: {
    term: "किटनफ़िशिंग",
    summary:
      "कैटफ़िशिंग की तरह पूरा इंसान गढ़े बिना, ख़ुद को ऑनलाइन असल से थोड़ा बेहतर पेश करना — पुरानी या एडिट की हुई तस्वीर, ऊपर की ओर गोल किया हुआ क़द, और काम से ज़्यादा चमकदार लगने वाला ओहदा।",
    blocks: [
      { type: "h2", text: "छोटी सी बढ़ा-चढ़ाकर कही बात, नक़ली पहचान नहीं" },
      { type: "p", text: "यह शब्द 2017 में एक डेटिंग ऐप ने गढ़ा और चल पड़ा, क्योंकि इसने उस चीज़ को नाम दे दिया जो पुराने शब्दों से छूट रही थी। कैटफ़िशिंग में पूरा इंसान ही गढ़ा हुआ होता है। किटनफ़िशिंग उसका बिल्ली के बच्चे जितना छोटा रूप है: सामने वाला असली है, मिलने आएगा, और वही है जो उसने बताया — बस उसने ख़ुद के साथ थोड़ी उदारता बरत ली। तस्वीर तीन साल और एक हेयरकट पुरानी है। क़द ऊपर वाले आँकड़े तक गोल कर दिया गया है। काम को ऐसे बताया गया है जैसे वह किसी अच्छे दिन लगता है।" },
      { type: "p", text: "यह कोई दुर्लभ ख़ामी नहीं है, और शोध इस मामले में असामान्य रूप से साफ़ है। **The Truth about Lying in Online Dating Profiles** (Hancock, Toma और Ellison, CHI 2007) में अस्सी ऑनलाइन डेटिंग करने वालों का क़द और वज़न प्रयोगशाला में नापा गया और उम्र जाँची गई, फिर इसका मिलान उनकी प्रोफ़ाइल में लिखी बातों से किया गया। लगभग दो-तिहाई लोगों का वज़न दो किलो से ज़्यादा हटकर निकला, लगभग आधों ने अपना क़द खिसका रखा था; सबसे कम फेरबदल उम्र में मिला। लेकिन क़द का औसत फ़र्क़ एक सेंटीमीटर से भी कम था। यही मेल — बहुत आम और बहुत छोटा — इस शब्द का पूरा मतलब है, और यही वजह है कि इसे घोटाले की तरह लेना अक्सर ग़लत बैठता है।" },
      { type: "h2", text: "इस पैटर्न को कैसे पहचानें" },
      {
        type: "ul",
        items: [
          "हर तस्वीर ऐसे कोण से ली गई है जिसमें वे बेहतर दिखें; कोई भी हाल की नहीं, न ही सीधी रोशनी में।",
          "पूरे क़द की या बिना तैयारी वाली कोई तस्वीर नहीं, सिर्फ़ पोर्ट्रेट और छुट्टियों के फ़ोटो।",
          "ब्योरे प्रोफ़ाइल, मैसेज और बातचीत के बीच हल्के-हल्के खिसकते रहते हैं।",
          "वीडियो कॉल या इसी हफ़्ते की मुलाक़ात से वे कभी साफ़ इनकार नहीं करते, बस लगातार टालते रहते हैं।",
        ],
      },
      { type: "h2", accent: "green", text: "क्या किया जा सकता है" },
      { type: "p", text: "मान लीजिए कि कुछ न कुछ चमकाया गया होगा, पर इसे फ़ैसला मत बनाइए। लगभग हर कोई ख़ुद को थोड़ा ऊपर करके दिखाता है, और ऊपर बताया गया अध्ययन कहता है कि यह फेरबदल आमतौर पर इतना छोटा होता है कि फ़र्क़ नहीं पड़ता। काम की बात यह है कि देर से नहीं, जल्दी मिल लिया जाए — किसी आम सार्वजनिक जगह पर, इससे पहले कि आपके दिमाग़ की बनाई तस्वीर ऐसी उम्मीद में बदल जाए जिस पर वह इंसान खरा उतर ही न सके। एक छोटी सी पहली मुलाक़ात बीस मिनट में वह तय कर देती है जो हफ़्तों की मैसेजबाज़ी नहीं कर पाती।" },
      { type: "p", text: "देखने लायक़ रेखा सच्चाई नहीं, पैमाना है। थोड़ी नरम की गई तस्वीर बस दिखावा है। बदली हुई उम्र, ऐसा काम जो है ही नहीं, कहानी से बाहर छोड़ा गया कोई साथी — यह अब किटनफ़िशिंग नहीं रहा, और ईमानदार जवाब मोलभाव करना नहीं, उठकर चले जाना है। और सवाल को उलटकर देखना भी ठीक रहता है: प्रोफ़ाइल के जो हिस्से चमकाए जा सकते हैं, वही हिस्से इस बारे में सबसे कम बताते हैं कि आप दोनों को एक-दूसरे का साथ अच्छा लगेगा या नहीं।" },
    ],
  },
};
