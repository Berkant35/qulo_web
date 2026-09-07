import type { LocalizedGlossaryEntry } from "@/lib/constants/glossary";

/**
 * SOURCE, verified at source rather than through a summary:
 * Impett, E. A., Park, H. G., & Muise, A. (2024). "Popular Psychology Through a
 * Scientific Lens: Evaluating Love Languages From a Relationship Science
 * Perspective." Current Directions in Psychological Science, 33(2), 87-92.
 * DOI 10.1177/09637214231217663, CC-BY. The publisher returns 403 to automated
 * fetches, so the full text was read from the authors' own repository copy and
 * checked line by line against the abstract the publisher deposited at Crossref.
 *
 * WHAT THE PAPER IS: a critical narrative review. Not a meta-analysis, no
 * pooled effect sizes, no new data, no sample. The page says so, because
 * "researchers reviewed the evidence" and "a study measured this" are different
 * claims and only the first one is true here.
 *
 * NOT USED — three figures that circulate in summaries of this paper and could
 * not be traced to it:
 * - "none of ten studies supported it": the number ten appears nowhere in the
 *   paper's text, only in a spoken quote in a university press release. The
 *   paper itself says two studies DID find support for one version of the
 *   hypothesis, so the press-release line is sharper than the paper.
 * - "white couples": the word does not appear in the paper.
 * - "#lovelanguages has 500 million views": unsourced.
 *
 * BALANCE: the review is critical but not dismissive, and this page keeps that.
 * Studies that DID find support are named (Hughes & Camden 2020; Mostova et al.
 * 2022), and the paper's own explanation for why the book feels useful — it
 * gives partners an occasion to talk about what they need — is the closing note.
 *
 * NO QULO ANGLE. No study shows that question- or quiz-based matching improves
 * relationship quality, so tying the evidence to this product would be exactly
 * the overreach the page criticises.
 */
export const loveLanguages: LocalizedGlossaryEntry = {
  en: {
    term: "Love languages",
    summary:
      "The popular idea that each person mainly gives and receives affection in one of five ways — words, time, gifts, acts of service or touch — and that couples do better when their languages match.",
    blocks: [
      { type: "h2", text: "Where it came from" },
      { type: "p", text: "Gary Chapman published the book in 1992. He is a Baptist minister and marriage counsellor rather than a research psychologist, and the framework came out of the patterns he noticed in counselling rather than out of a study. It has sold somewhere around twenty million copies, been translated into some fifty languages, and its thirty-item quiz has been taken by tens of millions of people. The three claims underneath it are that everyone has one primary language, that there are five of them, and that couples do better when theirs match." },
      { type: "p", text: "The research arrived long after the popularity did. In **Popular Psychology Through a Scientific Lens** (Impett, Park and Muise, Current Directions in Psychological Science, 2024) three relationship researchers went back over the evidence — a critical review of existing work, not a new study — and the clearest result concerns the third claim. Across the studies that tested whether partners who share a primary language are more satisfied, none found that they were. There is a second version of the idea that fares better: when a partner shows affection in the way you say you prefer, satisfaction does go up. But that is where the methods run out — the studies cannot separate the effect of the preferred language from the effect of simply being shown affection, and when every combination was tested, expressions in all five languages tracked with satisfaction regardless of what the person had said they preferred." },

      { type: "h2", text: "Why the categories themselves are shaky" },
      {
        type: "ul",
        items: [
          "People rate all five as meaningful — average scores cluster near the top of the scale rather than picking out one.",
          "The forced-choice quiz and a rating scale disagree: gifts comes out as the primary language for 0 to 4 percent of people on the quiz, and for more than half in some samples when scored on a scale.",
          "The five scores correlate strongly with each other, roughly .54 to .75 — not the behaviour of five separate boxes.",
          "Factor analyses have found three, four and five factors in different samples, and none of them lines up with the five as described.",
        ],
      },

      { type: "h2", accent: "green", text: "What to do with it" },
      { type: "p", text: "Treat the quiz as a conversation starter rather than a diagnosis. The review's own suggestion for why the book feels so useful is worth more than the taxonomy: it hands couples an occasion to say out loud what they want more of, and being responsive to what your partner actually tells you is one of the better-supported findings in relationship research. The categories may be doing nothing; the conversation they cause is doing the work." },
      { type: "p", text: "So it is fine to enjoy the test and to know your result. What does not follow is using it to sort people, or reading a mismatch as a warning sign — the mismatch is the part the evidence specifically does not support. If you want to know what makes someone feel cared for, the question is not which of five boxes they belong in. It is what they would want on an ordinary Tuesday, and that one only has an answer if you ask it." },
    ],
  },
  tr: {
    term: "Sevgi dilleri",
    summary:
      "Her insanın sevgiyi ağırlıkla beş yoldan biriyle verdiği ve aldığı — sözler, zaman, hediye, hizmet ya da dokunuş — ve dilleri eşleşen çiftlerin daha iyi gittiği yönündeki popüler fikir.",
    blocks: [
      { type: "h2", text: "Nereden geldi" },
      { type: "p", text: "Gary Chapman kitabı 1992'de yayımladı. Kendisi araştırmacı bir psikolog değil, Baptist bir papaz ve evlilik danışmanı; çerçeve de bir çalışmadan değil, danışmanlıkta fark ettiği örüntülerden doğdu. Kitap yirmi milyon civarında sattı, elli kadar dile çevrildi ve otuz maddelik testi on milyonlarca kişi tarafından çözüldü. Altındaki üç iddia şu: herkesin bir birincil sevgi dili vardır, bunlardan beş tane vardır ve çiftlerin dilleri eşleştiğinde ilişki daha iyi gider." },
      { type: "p", text: "Araştırma, popülerlikten çok sonra geldi. **Popular Psychology Through a Scientific Lens** (Impett, Park ve Muise, Current Directions in Psychological Science, 2024) çalışmasında üç ilişki araştırmacısı mevcut kanıtı yeniden gözden geçirdi — yeni bir çalışma değil, eleştirel bir derleme — ve en net sonuç üçüncü iddiaya dair. Birincil dili aynı olan partnerlerin daha memnun olup olmadığını sınayan çalışmaların hiçbiri böyle bir şey bulamadı. Fikrin daha iyi durumda olan ikinci bir biçimi var: partner, senin tercih ettiğini söylediğin biçimde sevgi gösterdiğinde doyum gerçekten artıyor. Ama yöntemler tam burada tükeniyor — çalışmalar tercih edilen dilin etkisini, sadece sevgi gösterilmesinin etkisinden ayıramıyor; üstelik bütün kombinasyonlar sınandığında beş dilin hepsindeki ifadeler, kişinin ne tercih ettiğinden bağımsız olarak doyumla birlikte hareket etti." },

      { type: "h2", text: "Kategorilerin kendisi neden zayıf" },
      {
        type: "ul",
        items: [
          "İnsanlar beşini de anlamlı buluyor — puanlar birini öne çıkarmak yerine ölçeğin üst ucunda kümeleniyor.",
          "Zorunlu seçimli test ile puanlama ölçeği birbirini tutmuyor: hediye, testte insanların yüzde 0 ila 4'ünde birincil dil çıkarken, ölçekle puanlandığında bazı örneklemlerde yarıdan fazlasında çıkıyor.",
          "Beş puan birbiriyle güçlü biçimde ilişkili, kabaca .54 ile .75 arasında — birbirinden ayrı beş kutunun davranışı bu değil.",
          "Faktör analizleri farklı örneklemlerde üç, dört ve beş faktör buldu; hiçbiri tarif edilen beşliyle örtüşmüyor.",
        ],
      },

      { type: "h2", accent: "green", text: "Bununla ne yapmalı" },
      { type: "p", text: "Testi bir tanı değil, bir sohbet başlangıcı olarak gör. Derlemenin kitabın neden bu kadar işe yarar hissettirdiğine dair kendi açıklaması, sınıflandırmanın kendisinden daha değerli: çiftlere neyi daha çok istediklerini yüksek sesle söyleme fırsatı veriyor — ve partnerinin sana söylediğine karşılık vermek, ilişki araştırmalarının en sağlam bulgularından biri. Kategoriler hiçbir şey yapmıyor olabilir; asıl işi, yol açtıkları konuşma yapıyor." },
      { type: "p", text: "Yani testi sevmekte ve sonucunu bilmekte bir sakınca yok. Sakıncalı olan, insanları buna göre ayıklamak ya da uyuşmazlığı bir uyarı işareti gibi okumak — kanıtın özellikle desteklemediği kısım tam olarak o uyuşma fikri. Birinin kendini nasıl değerli hissettiğini öğrenmek istiyorsan, soru onun beş kutudan hangisine ait olduğu değil. Sıradan bir salı günü ne isterdi — ve bunun cevabı ancak sorulursa var." },
    ],
  },
  de: {
    term: "Die fünf Sprachen der Liebe",
    summary:
      "Die populäre Idee, dass jeder Mensch Zuneigung vor allem auf eine von fünf Arten gibt und empfängt — Worte, Zeit, Geschenke, Hilfsbereitschaft oder Berührung — und dass Paare besser zurechtkommen, wenn ihre Sprachen zusammenpassen.",
    blocks: [
      { type: "h2", text: "Woher die Idee kommt" },
      { type: "p", text: "Gary Chapman veröffentlichte das Buch 1992. Er ist Baptistenpastor und Eheberater, kein forschender Psychologe, und das Modell entstand aus Mustern, die ihm in der Beratung auffielen, nicht aus einer Studie. Das Buch hat sich rund zwanzig Millionen Mal verkauft, wurde in etwa fünfzig Sprachen übersetzt, und seinen Test mit dreißig Fragen haben zig Millionen Menschen ausgefüllt. Darunter liegen drei Behauptungen: dass jeder Mensch eine primäre Sprache hat, dass es fünf davon gibt, und dass Paare besser zurechtkommen, wenn ihre Sprachen übereinstimmen." },
      { type: "p", text: "Die Forschung kam lange nach der Popularität. In **Popular Psychology Through a Scientific Lens** (Impett, Park und Muise, Current Directions in Psychological Science, 2024) sind drei Beziehungsforscherinnen und -forscher die vorhandenen Belege noch einmal durchgegangen — eine kritische Übersichtsarbeit über bereits vorhandene Arbeiten, keine neue Studie — und das klarste Ergebnis betrifft die dritte Behauptung. Von den Studien, die geprüft haben, ob Partner mit derselben primären Sprache zufriedener sind, hat das keine einzige gefunden. Es gibt eine zweite Version der Idee, die besser dasteht: Wenn jemand Zuneigung auf die Art zeigt, die du als deine bevorzugte angibst, steigt die Zufriedenheit tatsächlich. Aber genau dort enden die Methoden — die Studien können den Effekt der bevorzugten Sprache nicht davon trennen, dass überhaupt Zuneigung gezeigt wurde; und als alle Kombinationen geprüft wurden, gingen Ausdrucksformen in allen fünf Sprachen mit der Zufriedenheit einher, unabhängig davon, was die Person als Präferenz angegeben hatte." },
      { type: "h2", text: "Warum schon die Kategorien wackeln" },
      {
        type: "ul",
        items: [
          "Menschen finden alle fünf bedeutsam — die Durchschnittswerte drängen sich am oberen Ende der Skala, statt eine herauszuheben.",
          "Der Test mit erzwungener Wahl und eine Bewertungsskala widersprechen sich: Geschenke kommen im Test bei null bis vier Prozent der Menschen als primäre Sprache heraus, auf einer Skala erhoben in manchen Stichproben bei mehr als der Hälfte.",
          "Die fünf Werte hängen stark miteinander zusammen, etwa .54 bis .75 — so verhalten sich keine fünf getrennten Schubladen.",
          "Faktorenanalysen fanden in verschiedenen Stichproben drei, vier und fünf Faktoren, und keine davon deckt sich mit den fünf beschriebenen.",
        ],
      },
      { type: "h2", accent: "green", text: "Was man damit anfangen kann" },
      { type: "p", text: "Nimm den Test als Gesprächsanlass, nicht als Diagnose. Die Erklärung, die die Übersichtsarbeit selbst dafür anbietet, warum sich das Buch so nützlich anfühlt, ist mehr wert als die Einteilung: Es gibt Paaren einen Anlass, laut auszusprechen, wovon sie mehr möchten — und auf das einzugehen, was die andere Person einem tatsächlich sagt, gehört zu den am besten belegten Befunden der Beziehungsforschung. Die Kategorien tun vielleicht gar nichts; die Arbeit macht das Gespräch, das sie auslösen." },
      { type: "p", text: "Es ist also völlig in Ordnung, Spaß an dem Test zu haben und sein Ergebnis zu kennen. Was daraus nicht folgt: Menschen danach zu sortieren oder eine Nichtübereinstimmung als Warnsignal zu lesen — genau diese Passung ist der Teil, den die Belege ausdrücklich nicht stützen. Wenn du wissen willst, was jemandem das Gefühl gibt, umsorgt zu sein, lautet die Frage nicht, in welche der fünf Schubladen diese Person gehört. Sie lautet, was sich diese Person an einem ganz gewöhnlichen Dienstag wünschen würde — und darauf gibt es nur dann eine Antwort, wenn man sie stellt." },
    ],
  },
  fr: {
    term: "Langages de l’amour",
    summary:
      "L’idée populaire selon laquelle chacun donne et reçoit l’affection surtout de l’une de cinq façons — les mots, le temps, les cadeaux, les services rendus ou le toucher — et selon laquelle les couples s’en sortent mieux quand leurs langages coïncident.",
    blocks: [
      { type: "h2", text: "D’où vient l’idée" },
      { type: "p", text: "Gary Chapman a publié le livre en 1992. Il est pasteur baptiste et conseiller conjugal, pas psychologue chercheur, et le cadre est né des régularités qu’il observait en consultation, pas d’une étude. Le livre s’est vendu à quelque vingt millions d’exemplaires, a été traduit dans une cinquantaine de langues, et son test de trente items a été passé par des dizaines de millions de personnes. Trois affirmations le soutiennent : chacun aurait un langage principal, il y en aurait cinq, et les couples s’en sortiraient mieux quand les leurs coïncident." },
      { type: "p", text: "La recherche est arrivée bien après la popularité. Dans **Popular Psychology Through a Scientific Lens** (Impett, Park et Muise, Current Directions in Psychological Science, 2024), trois chercheurs en psychologie des relations ont repris les travaux existants — une synthèse critique de ce qui avait déjà été publié, pas une nouvelle étude — et le résultat le plus net porte sur la troisième affirmation. Parmi les études qui ont testé si les partenaires partageant un même langage principal étaient plus satisfaits, aucune ne l’a constaté. Il existe une seconde version de l’idée qui s’en tire mieux : quand un partenaire manifeste son affection de la manière que vous dites préférer, la satisfaction augmente bel et bien. Mais c’est là que les méthodes s’arrêtent — les études ne parviennent pas à séparer l’effet du langage préféré de celui du simple fait de recevoir de l’affection ; et lorsque toutes les combinaisons ont été testées, les manifestations dans les cinq langages allaient de pair avec la satisfaction, quelle que soit la préférence déclarée." },
      { type: "h2", text: "Pourquoi les catégories elles-mêmes sont fragiles" },
      {
        type: "ul",
        items: [
          "Les gens jugent les cinq significatifs — les scores moyens se massent en haut de l’échelle au lieu d’en désigner un.",
          "Le test à choix forcé et une échelle de notation se contredisent : les cadeaux ressortent comme langage principal chez 0 à 4 % des personnes au test, et chez plus de la moitié dans certains échantillons lorsqu’on les mesure sur une échelle.",
          "Les cinq scores sont fortement corrélés entre eux, autour de .54 à .75 — ce n’est pas le comportement de cinq cases distinctes.",
          "Les analyses factorielles ont trouvé trois, quatre et cinq facteurs selon les échantillons, et aucune ne recoupe les cinq tels qu’ils sont décrits.",
        ],
      },
      { type: "h2", accent: "green", text: "Qu’en faire" },
      { type: "p", text: "Traitez le test comme une amorce de conversation, pas comme un diagnostic. L’explication que la synthèse avance elle-même pour dire pourquoi le livre paraît si utile vaut mieux que la classification : il donne aux couples une occasion de dire à voix haute ce dont ils voudraient davantage — et répondre à ce que votre partenaire vous dit réellement fait partie des résultats les mieux établis de la recherche sur les relations. Les catégories ne font peut-être rien ; c’est la conversation qu’elles provoquent qui travaille." },
      { type: "p", text: "Rien n’empêche donc d’aimer ce test et d’en connaître le résultat. Ce qui n’en découle pas, c’est de s’en servir pour trier les gens, ou de lire un écart comme un signal d’alarme — cette histoire de correspondance est précisément la partie que les données ne soutiennent pas. Si vous voulez savoir ce qui fait qu’une personne se sent aimée, la question n’est pas de savoir dans laquelle des cinq cases elle entre. Elle est de savoir ce qui lui ferait plaisir un mardi ordinaire, et cette question-là n’a de réponse que si on la pose." },
    ],
  },
  es: {
    term: "Lenguajes del amor",
    summary:
      "La idea popular de que cada persona da y recibe afecto sobre todo de una de cinco maneras — palabras, tiempo, regalos, actos de servicio o contacto físico — y de que a las parejas les va mejor cuando sus lenguajes coinciden.",
    blocks: [
      { type: "h2", text: "De dónde viene la idea" },
      { type: "p", text: "Gary Chapman publicó el libro en 1992. Es pastor bautista y consejero matrimonial, no psicólogo investigador, y el esquema salió de los patrones que veía en consulta, no de un estudio. El libro ha vendido unos veinte millones de ejemplares, se ha traducido a unas cincuenta lenguas y su test de treinta preguntas lo han hecho decenas de millones de personas. Debajo hay tres afirmaciones: que cada persona tiene un lenguaje principal, que son cinco y que a las parejas les va mejor cuando los suyos coinciden." },
      { type: "p", text: "La investigación llegó mucho después que la popularidad. En **Popular Psychology Through a Scientific Lens** (Impett, Park y Muise, Current Directions in Psychological Science, 2024) tres investigadores de las relaciones de pareja repasaron lo que ya se había publicado — una revisión crítica de trabajos existentes, no un estudio nuevo — y el resultado más claro tiene que ver con la tercera afirmación. De los estudios que comprobaron si las parejas que comparten lenguaje principal están más satisfechas, ninguno lo encontró. Hay una segunda versión de la idea que sale mejor parada: cuando la otra persona muestra afecto de la manera que tú dices preferir, la satisfacción sí sube. Pero ahí es donde se acaban los métodos — los estudios no pueden separar el efecto del lenguaje preferido del efecto de que sencillamente te muestren afecto; y cuando se probaron todas las combinaciones, las expresiones en los cinco lenguajes acompañaban a la satisfacción con independencia de lo que la persona hubiera dicho que prefería." },
      { type: "h2", text: "Por qué las propias categorías flaquean" },
      {
        type: "ul",
        items: [
          "La gente valora las cinco como significativas: las puntuaciones medias se agolpan en la parte alta de la escala en lugar de destacar una.",
          "El test de elección forzosa y una escala de puntuación se contradicen: los regalos salen como lenguaje principal para entre el 0 y el 4 % de las personas en el test, y para más de la mitad en algunas muestras cuando se puntúan en una escala.",
          "Las cinco puntuaciones correlacionan fuerte entre sí, en torno a .54 y .75 — no es así como se comportan cinco cajones separados.",
          "Los análisis factoriales han encontrado tres, cuatro y cinco factores según la muestra, y ninguno encaja con los cinco tal como se describen.",
        ],
      },
      { type: "h2", accent: "green", text: "Qué hacer con todo esto" },
      { type: "p", text: "Toma el test como el arranque de una conversación, no como un diagnóstico. La explicación que da la propia revisión sobre por qué el libro resulta tan útil vale más que la clasificación: les da a las parejas una ocasión para decir en voz alta de qué querrían más — y responder a lo que tu pareja te dice de verdad es uno de los hallazgos mejor sostenidos de la investigación sobre relaciones. Puede que las categorías no estén haciendo nada; el trabajo lo hace la conversación que provocan." },
      { type: "p", text: "Así que no pasa nada por disfrutar del test y por saber tu resultado. Lo que no se deduce de ahí es usarlo para clasificar a la gente, ni leer una falta de coincidencia como una señal de alarma: justo esa idea de encaje es la parte que las pruebas no respaldan. Si quieres saber qué hace que alguien se sienta querido, la pregunta no es en cuál de cinco cajones entra. Es qué le apetecería un martes cualquiera, y eso solo tiene respuesta si se lo preguntas." },
    ],
  },
  ar: {
    term: "لغات الحب",
    summary:
      "الفكرة الشائعة القائلة إنّ كلّ إنسان يمنح المودّة ويتلقّاها أساسًا بواحدة من خمس طرق، هي الكلمات والوقت والهدايا وأفعال الخدمة واللمس، وإنّ العلاقة تسير على نحو أفضل حين تتطابق لغتا الشريكين.",
    blocks: [
      { type: "h2", text: "من أين جاءت الفكرة" },
      { type: "p", text: "نشر غاري تشابمان كتابه عام 1992. وهو قسّ معمداني ومستشار زواج، لا عالِم نفس باحث، والإطار كلّه خرج من أنماط لاحظها في جلسات الإرشاد لا من دراسة. بيع من الكتاب نحو عشرين مليون نسخة، وتُرجم إلى خمسين لغة تقريبًا، وأجرى اختباره المكوَّن من ثلاثين بندًا عشرات الملايين من الناس. والادّعاءات الثلاثة التي يقوم عليها هي: أنّ لكلّ شخص لغة أساسية واحدة، وأنّ هذه اللغات خمس، وأنّ العلاقة تسير على نحو أفضل حين تتطابق لغتا الشريكين." },
      { type: "p", text: "أمّا البحث فجاء بعد الشهرة بزمن طويل. في **Popular Psychology Through a Scientific Lens** (Impett, Park & Muise, Current Directions in Psychological Science, 2024) عاد ثلاثة من باحثي العلاقات إلى الأدلّة الموجودة وأعادوا فحصها، وهي مراجعة نقدية لأعمال سابقة لا دراسة جديدة، وأوضحُ نتيجة فيها تخصّ الادّعاء الثالث. فمن بين الدراسات التي اختبرت ما إذا كان الشريكان اللذان يتشاركان اللغة الأساسية نفسها أكثر رضًا، لم تجد أيّ دراسة أنّهما كذلك. وهناك صيغة ثانية للفكرة حالها أفضل: حين يُظهر الشريك مودّته بالطريقة التي تقول إنّك تفضّلها، يرتفع الرضا فعلًا. لكنّ المناهج تنفد عند هذه النقطة بالذات، إذ لا تستطيع الدراسات أن تفصل أثر اللغة المفضَّلة عن أثر مجرّد تلقّي المودّة؛ وحين اختُبرت التوليفات كلّها، سارت التعبيرات بلغات الحبّ الخمس جميعها مع الرضا، بصرف النظر عمّا قال الشخص إنّه يفضّله." },
      { type: "h2", text: "لماذا الفئات نفسها هشّة" },
      {
        type: "ul",
        items: [
          "الناس يجدون الطرق الخمس كلّها ذات معنى؛ فالدرجات تتجمّع قرب أعلى المقياس بدل أن تُبرز واحدة منها.",
          "الاختبار ذو الخيار الإجباري ومقياس التقدير لا يتّفقان: الهدايا تخرج لغةً أساسية لدى ما بين 0 و4 في المئة من الناس في الاختبار، ولدى أكثر من النصف في بعض العيّنات حين تُحتسب على مقياس.",
          "الدرجات الخمس مترابطة فيما بينها ارتباطًا قويًا، نحو 0.54 إلى 0.75، وليس هذا سلوك خمسة صناديق منفصلة.",
          "أعطت التحليلات العاملية ثلاثة عوامل في عيّنة وأربعة في أخرى وخمسة في ثالثة، ولا واحد منها يتطابق مع اللغات الخمس كما وُصفت.",
        ],
      },
      { type: "h2", accent: "green", text: "كيف تتعامل معها" },
      { type: "p", text: "عامل الاختبار كبداية لحديث لا كتشخيص. فتفسير المراجعة نفسها لسبب شعور القرّاء بأنّ الكتاب مفيد إلى هذا الحدّ يساوي أكثر من التصنيف ذاته: إنّه يمنح الشريكين مناسبة ليقولا بصوت مسموع ما يريدان المزيد منه، والاستجابة لما يقوله لك شريكك فعلًا واحدة من أرسخ النتائج في أبحاث العلاقات. قد لا تفعل الفئات شيئًا؛ لكنّ الحديث الذي تُشعله هو الذي يقوم بالعمل." },
      { type: "p", text: "لا بأس إذن أن تستمتع بالاختبار وأن تعرف نتيجتك. ما لا يصحّ هو أن تفرز الناس على أساسه، أو أن تقرأ اختلاف اللغتين كإشارة إنذار، فمسألة التطابق هذه تحديدًا هي الجزء الذي لا تسنده الأدلّة. وإذا أردت أن تعرف ما الذي يجعل شخصًا يشعر بأنّ أحدًا يهتمّ به، فالسؤال ليس إلى أيّ من الصناديق الخمسة ينتمي، بل ما الذي كان يودّه في يوم ثلاثاء عادي؛ وهذا سؤال لا جواب له إلّا إن سألته." },
    ],
  },
  ru: {
    term: "Языки любви",
    summary:
      "Популярное представление о том, что каждый человек в основном выражает и принимает любовь одним из пяти способов — слова, время, подарки, помощь в делах или прикосновения — и что парам лучше, когда их языки совпадают.",
    blocks: [
      { type: "h2", text: "Откуда это взялось" },
      { type: "p", text: "Гэри Чепмен выпустил книгу в 1992 году. Он не исследователь-психолог, а баптистский пастор и семейный консультант, и сама схема выросла не из исследования, а из закономерностей, которые он подмечал на консультациях. Книга разошлась тиражом около двадцати миллионов экземпляров, её перевели примерно на пятьдесят языков, а её тест из тридцати пунктов прошли десятки миллионов человек. Под всем этим лежат три утверждения: у каждого есть один основной язык, языков этих пять, и парам лучше, когда их языки совпадают." },
      { type: "p", text: "Исследования появились намного позже популярности. В работе «**Popular Psychology Through a Scientific Lens**» (Impett, Park и Muise, Current Directions in Psychological Science, 2024) трое исследователей отношений заново прошлись по накопленным данным — это критический обзор уже сделанных работ, а не новое исследование, — и самый ясный вывод касается третьего утверждения. Среди работ, проверявших, довольнее ли партнёры с одинаковым основным языком, ни одна этого не обнаружила. Есть вторая версия той же идеи, и у неё дела лучше: когда партнёр проявляет любовь тем способом, который человек назвал предпочтительным, удовлетворённость действительно растёт. Но именно здесь методы заканчиваются — исследования не могут отделить действие предпочитаемого языка от действия самого по себе проявленного внимания, а когда проверили все сочетания, проявления на всех пяти языках шли вместе с удовлетворённостью независимо от того, что человек называл своим предпочтением." },
      { type: "h2", text: "Почему шатки сами категории" },
      {
        type: "ul",
        items: [
          "Люди отмечают все пять как значимые — средние оценки сбиваются к верхнему краю шкалы, а не выделяют что-то одно.",
          "Тест с принудительным выбором и оценочная шкала расходятся: в тесте подарки оказываются основным языком для 0–4 процентов людей, а при оценке по шкале в некоторых выборках — более чем для половины.",
          "Пять показателей сильно связаны между собой, примерно от 0,54 до 0,75 — так пять отдельных ячеек себя не ведут.",
          "Факторный анализ на разных выборках давал три, четыре и пять факторов, и ни один из этих наборов не совпадает с пятёркой в том виде, в каком её описывают.",
        ],
      },
      { type: "h2", accent: "green", text: "Что с этим делать" },
      { type: "p", text: "Относитесь к тесту как к началу разговора, а не как к диагнозу. Собственное объяснение обзора, почему книга кажется такой полезной, стоит больше самой классификации: она даёт паре повод вслух сказать, чего хочется больше, — а отзывчивость к тому, что партнёр вам действительно говорит, относится к наиболее подтверждённым находкам в исследованиях отношений. Категории, возможно, не делают ничего; работу делает разговор, который они затевают." },
      { type: "p", text: "Так что любить этот тест и знать свой результат вполне нормально. Не следует из него другое — право сортировать по нему людей или читать несовпадение как тревожный знак: именно совпадение языков доказательства прямо не подтверждают. Если вы хотите понять, от чего человек чувствует заботу, вопрос не в том, к какой из пяти ячеек он относится. Вопрос в том, чего ему хотелось бы в обычный вторник, — а ответ на него появляется, только если его задать." },
    ],
  },
  pt: {
    term: "Linguagens do amor",
    summary:
      "A ideia popular de que cada pessoa dá e recebe afeto principalmente de uma entre cinco formas — palavras, tempo, presentes, atos de serviço ou toque — e de que os casais vão melhor quando essas linguagens coincidem.",
    blocks: [
      { type: "h2", text: "De onde veio" },
      { type: "p", text: "Gary Chapman publicou o livro em 1992. Ele não é um psicólogo pesquisador: é pastor batista e conselheiro matrimonial, e o modelo saiu dos padrões que ele notava no aconselhamento, não de um estudo. O livro vendeu por volta de vinte milhões de exemplares, foi traduzido para umas cinquenta línguas e o teste de trinta itens já foi respondido por dezenas de milhões de pessoas. As três afirmações que sustentam tudo isso são: cada pessoa tem uma linguagem principal, essas linguagens são cinco, e os casais vão melhor quando as suas coincidem." },
      { type: "p", text: "A pesquisa chegou muito depois da popularidade. Em **Popular Psychology Through a Scientific Lens** (Impett, Park e Muise, Current Directions in Psychological Science, 2024), três pesquisadores de relacionamentos revisitaram as evidências existentes — uma revisão crítica do que já havia sido feito, não um estudo novo — e o resultado mais claro diz respeito à terceira afirmação. Entre os estudos que testaram se parceiros com a mesma linguagem principal são mais satisfeitos, nenhum encontrou que fossem. Há uma segunda versão da ideia que se sai melhor: quando o parceiro demonstra afeto do jeito que você diz preferir, a satisfação realmente sobe. Mas é aí que os métodos se esgotam — os estudos não conseguem separar o efeito da linguagem preferida do efeito de simplesmente receber demonstrações de afeto, e, quando todas as combinações foram testadas, as demonstrações nas cinco linguagens acompanharam a satisfação independentemente do que a pessoa havia dito preferir." },
      { type: "h2", text: "Por que as próprias categorias são frágeis" },
      {
        type: "ul",
        items: [
          "As pessoas consideram as cinco significativas: as médias se agrupam na parte de cima da escala em vez de destacar uma só.",
          "O teste de escolha forçada e uma escala de avaliação discordam: no teste, presentes aparece como linguagem principal em 0 a 4 por cento das pessoas; numa escala, em mais da metade em algumas amostras.",
          "As cinco pontuações se correlacionam fortemente entre si, mais ou menos entre 0,54 e 0,75 — não é assim que se comportam cinco caixas separadas.",
          "Análises fatoriais encontraram três, quatro e cinco fatores em amostras diferentes, e nenhuma delas coincide com as cinco linguagens tal como são descritas.",
        ],
      },
      { type: "h2", accent: "green", text: "O que fazer com isso" },
      { type: "p", text: "Trate o teste como início de conversa, não como diagnóstico. A explicação que a própria revisão dá para o livro parecer tão útil vale mais do que a classificação: ele dá ao casal uma ocasião para dizer em voz alta do que gostaria de ter mais — e responder ao que o outro de fato conta é um dos achados mais bem sustentados da pesquisa sobre relacionamentos. As categorias podem não estar fazendo nada; quem faz o trabalho é a conversa que elas provocam." },
      { type: "p", text: "Então não há problema nenhum em curtir o teste e saber o seu resultado. O que não decorre daí é usá-lo para separar pessoas, ou ler uma diferença como sinal de alerta — a coincidência é justamente a parte que as evidências não sustentam. Se você quer saber o que faz alguém se sentir cuidado, a pergunta não é em qual das cinco caixas essa pessoa cabe. É o que ela gostaria numa terça-feira comum, e isso só tem resposta se você perguntar." },
    ],
  },
  it: {
    term: "Linguaggi dell’amore",
    summary:
      "L’idea popolare secondo cui ognuno dà e riceve affetto soprattutto in uno di cinque modi — parole, tempo, regali, gesti concreti o contatto fisico — e secondo cui le coppie funzionano meglio quando i loro linguaggi coincidono.",
    blocks: [
      { type: "h2", text: "Da dove viene" },
      { type: "p", text: "Gary Chapman ha pubblicato il libro nel 1992. Non è uno psicologo che fa ricerca: è un pastore battista e un consulente matrimoniale, e lo schema è nato dagli andamenti che notava nei colloqui, non da uno studio. Il libro ha venduto circa venti milioni di copie, è stato tradotto in una cinquantina di lingue e il suo test da trenta voci è stato fatto da decine di milioni di persone. Le tre affermazioni che stanno sotto sono queste: ognuno ha un linguaggio primario, i linguaggi sono cinque, e le coppie vanno meglio quando i loro coincidono." },
      { type: "p", text: "La ricerca è arrivata molto dopo la popolarità. In **Popular Psychology Through a Scientific Lens** (Impett, Park e Muise, Current Directions in Psychological Science, 2024) tre studiosi delle relazioni sono tornati sulle prove esistenti — una rassegna critica del lavoro già fatto, non un nuovo studio — e il risultato più netto riguarda la terza affermazione. Fra gli studi che hanno verificato se i partner con lo stesso linguaggio primario siano più soddisfatti, nessuno ha trovato che lo siano. C’è una seconda versione dell’idea che se la cava meglio: quando il partner mostra affetto nel modo che dici di preferire, la soddisfazione sale davvero. Ma è lì che i metodi si fermano — gli studi non riescono a separare l’effetto del linguaggio preferito dall’effetto del ricevere affetto e basta, e quando sono state messe alla prova tutte le combinazioni, le espressioni in tutti e cinque i linguaggi andavano di pari passo con la soddisfazione, a prescindere da quello che la persona aveva detto di preferire." },
      { type: "h2", text: "Perché le categorie stesse sono fragili" },
      {
        type: "ul",
        items: [
          "Le persone giudicano significativi tutti e cinque: i punteggi medi si addensano verso l’alto della scala invece di far emergere un linguaggio solo.",
          "Il test a scelta obbligata e una scala di valutazione non concordano: con il test i regali risultano linguaggio primario per una quota fra lo 0 e il 4 per cento delle persone, mentre con la scala, in alcuni campioni, per più della metà.",
          "I cinque punteggi sono fortemente correlati fra loro, all’incirca fra 0,54 e 0,75: non è il comportamento di cinque scatole separate.",
          "Le analisi fattoriali hanno trovato tre, quattro e cinque fattori in campioni diversi, e nessuna di esse coincide con i cinque linguaggi così come vengono descritti.",
        ],
      },
      { type: "h2", accent: "green", text: "Che cosa farne" },
      { type: "p", text: "Prendi il test come uno spunto di conversazione, non come una diagnosi. La spiegazione che la rassegna stessa dà del perché il libro risulti così utile vale più della classificazione: offre alle coppie l’occasione di dire ad alta voce di che cosa vorrebbero di più — ed essere ricettivi verso ciò che il partner dice davvero è uno dei risultati più solidi della ricerca sulle relazioni. Le categorie potrebbero non fare nulla; il lavoro lo fa la conversazione a cui danno il via." },
      { type: "p", text: "Quindi va benissimo divertirsi con il test e conoscere il proprio risultato. Quello che non ne consegue è usarlo per selezionare le persone, o leggere una mancata coincidenza come un campanello d’allarme: la coincidenza è proprio la parte che le prove non sostengono. Se vuoi sapere che cosa fa sentire qualcuno accudito, la domanda non è in quale delle cinque scatole rientri. È che cosa gli farebbe piacere in un martedì qualunque, e quella domanda ha una risposta solo se la fai." },
    ],
  },
  ja: {
    term: "愛の5つの言語",
    summary:
      "人はそれぞれ、言葉・時間・贈り物・尽くすこと・触れることという五つのうちのどれか一つを主な形として愛情を伝え、また受け取っていて、その言語が一致している二人ほどうまくいく、という広く知られた考え方です。",
    blocks: [
      { type: "h2", text: "どこから来た考え方か" },
      { type: "p", text: "ゲーリー・チャップマンがこの本を出したのは1992年です。研究者としての心理学者ではなく、バプテスト派の牧師であり結婚カウンセラーで、この枠組みも研究から出てきたものではなく、カウンセリングの現場で気づいた傾向から生まれました。本は二千万部前後を売り、五十ほどの言語に訳され、三十問のテストは何千万人もの人が受けています。その下敷きになっている主張は三つあります。誰にでも主要な言語が一つあるということ、その言語は五種類だということ、そして二人の言語が一致しているほどうまくいくということです。" },
      { type: "p", text: "研究のほうは、人気よりずっとあとにやって来ました。**Popular Psychology Through a Scientific Lens**（Impett, Park & Muise, Current Directions in Psychological Science, 2024）で、三人の関係研究者がそれまでの証拠をあらためて見直しています。新しい研究ではなく、既存の研究に対する批判的なレビューです。そこでいちばんはっきり出ているのは、三つめの主張についてでした。主要な言語が同じ二人のほうが満足度が高いかどうかを調べた研究のうち、そうだと示したものは一つもありません。ただし、この考えにはもう少し分のいい第二の形があります。自分が好きだと言った形で相手が愛情を示してくれると、満足度は実際に上がるのです。しかし方法が尽きるのもそこで、研究は、好みの言語による効果と、ただ愛情を示されたという効果とを切り分けられません。しかも組み合わせを全部試してみると、五つの言語のどの表現も、その人が何を好むと答えたかに関係なく満足度と一緒に動いていました。" },
      { type: "h2", text: "カテゴリー自体があやういわけ" },
      {
        type: "ul",
        items: [
          "人は五つのどれもが大事だと答える。点数は一つを選び出すのではなく、尺度の上のほうに固まる。",
          "二択式のテストと評価尺度の結果が食い違う。贈り物が主要な言語になるのは、テストでは0〜4%の人だが、尺度で採点するとサンプルによっては半数以上になる。",
          "五つの点数は互いに強く相関していて、およそ.54から.75。五つの別々の箱がふるまう数字ではない。",
          "因子分析はサンプルによって三因子、四因子、五因子と別々の答えを出していて、そのどれも、説明されている五つとはそろわない。",
        ],
      },
      { type: "h2", accent: "green", text: "これをどう使えばいいか" },
      { type: "p", text: "テストは診断ではなく、話のきっかけとして扱ってください。この本がこれほど役に立つと感じられるのはなぜか、というレビュー自身の説明のほうが、分類そのものよりも値打ちがあります。二人に、自分はもっと何が欲しいのかを声に出して言う機会を渡してくれる、という説明です。そして、相手が実際に口にしたことに応えることは、関係の研究のなかでも裏づけの厚い知見のひとつです。カテゴリーは何もしていないかもしれません。仕事をしているのは、そのカテゴリーが引き起こす会話のほうです。" },
      { type: "p", text: "ですから、テストを楽しむのも、自分の結果を知っているのもかまいません。そこから続かないのは、それで人を仕分けることや、食い違いを警告のしるしとして読むことです。一致するかどうかというその部分こそ、証拠がはっきり支えていないところなのですから。誰かが何をされると大事にされたと感じるのかを知りたいなら、問いは、五つの箱のどれに入る人かではありません。なんでもない火曜日に何をしてほしいか。そして、その問いは、たずねたときにだけ答えを持ちます。" },
    ],
  },
  ko: {
    term: "사랑의 언어",
    summary:
      "사람마다 말, 함께하는 시간, 선물, 봉사, 스킨십이라는 다섯 가지 가운데 주로 한 가지 방식으로 애정을 주고받으며, 두 사람의 언어가 맞을수록 관계가 더 잘 굴러간다는 널리 알려진 생각입니다.",
    blocks: [
      { type: "h2", text: "어디에서 온 생각인가" },
      { type: "p", text: "게리 채프먼이 이 책을 낸 것은 1992년입니다. 그는 연구하는 심리학자가 아니라 침례교 목사이자 결혼 상담사였고, 이 틀도 연구에서 나온 것이 아니라 상담실에서 눈에 띈 패턴에서 나왔습니다. 책은 이천만 부 안팎이 팔렸고, 오십 개쯤 되는 언어로 번역됐으며, 서른 문항짜리 테스트는 수천만 명이 해 봤습니다. 그 아래에 깔린 주장은 셋입니다. 누구에게나 주된 언어가 하나 있다는 것, 그 언어가 다섯 가지라는 것, 그리고 두 사람의 언어가 맞을 때 관계가 더 잘 굴러간다는 것입니다." },
      { type: "p", text: "연구는 인기보다 한참 뒤에 도착했습니다. **Popular Psychology Through a Scientific Lens**(Impett, Park & Muise, Current Directions in Psychological Science, 2024)에서 관계 연구자 세 사람이 그때까지 나온 증거를 다시 훑었습니다. 새로운 연구가 아니라 기존 연구를 비판적으로 검토한 리뷰입니다. 여기서 가장 분명하게 나온 결과는 세 번째 주장에 관한 것이었습니다. 주된 언어가 같은 두 사람이 관계에 더 만족하는지 검증한 연구들 가운데, 그렇다고 나온 것은 하나도 없었습니다. 이 생각에는 사정이 좀 나은 두 번째 판본이 있습니다. 내가 좋다고 말한 방식으로 상대가 애정을 표현해 주면 만족도는 실제로 올라갑니다. 다만 방법이 바닥나는 지점도 바로 거기입니다. 연구들은 선호하는 언어의 효과와 그냥 애정을 표현받았다는 효과를 갈라내지 못하고, 모든 조합을 다 검증해 보니 다섯 언어 어느 쪽의 표현이든 그 사람이 무엇을 선호한다고 답했는지와 상관없이 만족도와 같이 움직였습니다." },
      { type: "h2", text: "범주 자체가 흔들리는 이유" },
      {
        type: "ul",
        items: [
          "사람들은 다섯 가지를 모두 의미 있다고 답합니다. 점수는 하나를 골라내기보다 척도의 위쪽에 몰립니다.",
          "강제 선택 방식의 테스트와 평정 척도가 서로 어긋납니다. 선물이 주된 언어로 나오는 비율은 테스트에서 0~4퍼센트인데, 척도로 채점하면 어떤 표본에서는 절반이 넘습니다.",
          "다섯 점수는 서로 강하게 상관합니다. 대략 .54에서 .75 사이인데, 서로 떨어진 상자 다섯 개가 낼 만한 숫자가 아닙니다.",
          "요인 분석은 표본에 따라 세 요인, 네 요인, 다섯 요인을 각각 내놓았고, 그중 어느 것도 설명된 다섯 가지와 맞아떨어지지 않습니다.",
        ],
      },
      { type: "h2", accent: "green", text: "그러면 이걸 어떻게 쓰면 좋을까" },
      { type: "p", text: "테스트는 진단이 아니라 대화의 시작으로 다루세요. 이 책이 왜 그렇게 쓸모 있게 느껴지는지에 대해 리뷰가 스스로 내놓은 설명이, 분류 자체보다 값어치가 큽니다. 두 사람에게 무엇을 더 원하는지 소리 내어 말할 자리를 만들어 준다는 설명입니다. 그리고 상대가 실제로 하는 말에 반응해 주는 일은 관계 연구에서 비교적 탄탄하게 뒷받침되는 결과 가운데 하나입니다. 범주는 아무 일도 하지 않고 있을지 모릅니다. 일을 하고 있는 쪽은 그 범주가 불러오는 대화입니다." },
      { type: "p", text: "그러니 테스트를 재미있게 해 보는 것도, 자기 결과를 알고 있는 것도 괜찮습니다. 거기서 이어지지 않는 것은 그걸로 사람을 걸러 내는 일, 그리고 언어가 어긋난다는 걸 경고 신호처럼 읽는 일입니다. 맞아떨어져야 한다는 바로 그 부분이 증거가 특별히 받쳐 주지 않는 대목이니까요. 누가 어떨 때 사랑받는다고 느끼는지 알고 싶다면, 물어야 할 것은 그 사람이 다섯 상자 중 어디에 속하느냐가 아닙니다. 평범한 화요일에 무엇을 바랄까 하는 것이고, 그 물음은 물어봐야만 답이 생깁니다." },
    ],
  },
  zh: {
    term: "爱的五种语言",
    summary:
      "一个流行的说法：每个人给出和接受爱意的方式，主要只落在五种里的一种——言语、时间、礼物、为对方做事、身体接触——而两个人的语言对得上时，关系会更好。",
    blocks: [
      { type: "h2", text: "它是从哪里来的" },
      { type: "p", text: "加里·查普曼在 1992 年出版了那本书。他是一位浸信会牧师和婚姻辅导员，不是做研究的心理学家；这套框架来自他在辅导里看到的规律，而不是来自一项研究。书卖了两千万册左右，被译成五十来种语言，那份三十道题的测验有几千万人做过。它底下有三个说法：每个人都有一种主要的爱的语言；这样的语言一共有五种；两个人的语言对得上时，关系会更好。" },
      { type: "p", text: "研究是在流行之后很久才到的。在**Popular Psychology Through a Scientific Lens**（Impett、Park 和 Muise，Current Directions in Psychological Science，2024）里，三位研究亲密关系的学者把已有的证据重新梳理了一遍——这是一篇对既有研究的批判性综述，不是一项新研究——而最清楚的结论落在第三个说法上。凡是检验过“主要语言相同的伴侣是不是更满意”的研究，没有一项发现他们更满意。这个想法还有另一个版本，处境要好一些：当伴侣用你说过自己偏好的方式表达爱意时，满意度确实会上升。但方法到这里就用尽了——这些研究没办法把“偏好的语言”的作用，和“有人对你表达了爱意”的作用分开；而当所有组合都被逐一检验时，五种语言里的表达都和满意度一起变动，与那个人说自己偏好哪一种无关。" },
      { type: "h2", text: "为什么这些分类本身就不牢靠" },
      {
        type: "ul",
        items: [
          "五种，人们都觉得对自己有意义——平均分挤在量表的高分一端，并没有把某一种单独挑出来。",
          "二选一的测验和评分量表对不上：礼物在测验里是 0% 到 4% 的人的主要语言，而改用量表打分时，在有些样本里超过一半的人是它。",
          "五项分数彼此之间相关很强，大致在 .54 到 .75 之间——这不是五个彼此分开的盒子该有的样子。",
          "不同样本里的因素分析分别得出三个、四个和五个因素，没有一个和书里描述的那五种对得上。",
        ],
      },
      { type: "h2", accent: "green", text: "可以拿它怎么办" },
      { type: "p", text: "把测验当成话题的开头，而不是一份诊断。这篇综述自己给出的解释——为什么这本书让人觉得那么有用——比那套分类更有价值：它给了两个人一个机会，把自己想要多一点的东西说出口；而对伴侣真正告诉你的事情有所回应，是关系研究里比较站得住的发现之一。分类也许什么都没做；真正在起作用的，是它引出的那场对话。" },
      { type: "p", text: "所以，喜欢这个测验、知道自己的结果，都没有问题。不成立的是拿它去给人分类，或者把两个人对不上读成一个警示信号——恰恰是“对得上更好”这一条，证据明确地不支持。如果你想知道怎样才能让一个人觉得被在乎，问题不是他属于五个盒子里的哪一个。问题是在一个平常的星期二他会想要什么——而这个问题只有问出口才有答案。" },
    ],
  },
  nl: {
    term: "Liefdestalen",
    summary:
      "Het populaire idee dat ieder mens genegenheid vooral op één van vijf manieren geeft en ontvangt — woorden, tijd, cadeaus, dingen voor elkaar doen of aanraking — en dat het beter gaat met stellen van wie die talen overeenkomen.",
    blocks: [
      { type: "h2", text: "Waar het vandaan komt" },
      { type: "p", text: "Gary Chapman publiceerde het boek in 1992. Hij is geen onderzoekspsycholoog maar baptistenpredikant en huwelijkstherapeut, en het model kwam voort uit de patronen die hij in gesprekken zag, niet uit een studie. Het boek is zo’n twintig miljoen keer verkocht, in een vijftigtal talen vertaald, en de test van dertig items is door tientallen miljoenen mensen ingevuld. De drie claims eronder zijn: iedereen heeft één primaire taal, er zijn er vijf, en het gaat beter met stellen van wie die talen overeenkomen." },
      { type: "p", text: "Het onderzoek kwam ruim na de populariteit. In **Popular Psychology Through a Scientific Lens** (Impett, Park en Muise, Current Directions in Psychological Science, 2024) namen drie relatieonderzoekers het bestaande bewijs opnieuw door — een kritisch overzicht van eerder werk, geen nieuw onderzoek — en de duidelijkste uitkomst gaat over die derde claim. Van de studies die toetsten of partners met dezelfde primaire taal tevredener zijn, vond er geen enkele dat dat zo was. Er is een tweede versie van het idee die het beter doet: als je partner genegenheid toont op de manier die jij zegt te verkiezen, gaat de tevredenheid wel degelijk omhoog. Maar daar houden de methodes op — de studies kunnen het effect van de voorkeurstaal niet scheiden van het effect van simpelweg genegenheid krijgen, en toen alle combinaties werden getoetst, liepen uitingen in alle vijf de talen mee met de tevredenheid, ongeacht wat iemand had gezegd te verkiezen." },
      { type: "h2", text: "Waarom de categorieën zelf wankel zijn" },
      {
        type: "ul",
        items: [
          "Mensen vinden alle vijf betekenisvol: de gemiddelde scores klonteren samen aan de bovenkant van de schaal in plaats van er één uit te lichten.",
          "De test met gedwongen keuze en een beoordelingsschaal spreken elkaar tegen: cadeaus komt in de test bij 0 tot 4 procent van de mensen als primaire taal uit de bus, en op een schaal in sommige steekproeven bij meer dan de helft.",
          "De vijf scores hangen sterk met elkaar samen, ruwweg tussen 0,54 en 0,75 — zo gedragen vijf losse hokjes zich niet.",
          "Factoranalyses vonden in verschillende steekproeven drie, vier en vijf factoren, en geen daarvan valt samen met de vijf zoals ze beschreven worden.",
        ],
      },
      { type: "h2", accent: "green", text: "Wat je ermee kunt" },
      { type: "p", text: "Behandel de test als een aanleiding tot een gesprek, niet als een diagnose. De verklaring die het overzicht zelf geeft voor waarom het boek zo bruikbaar voelt, is meer waard dan de indeling: het geeft stellen een gelegenheid om hardop te zeggen waar ze meer van willen — en ingaan op wat je partner je werkelijk vertelt, is een van de beter onderbouwde bevindingen uit het relatieonderzoek. De categorieën doen misschien niets; het werk wordt gedaan door het gesprek dat ze uitlokken." },
      { type: "p", text: "Het is dus prima om plezier aan de test te beleven en je uitslag te kennen. Wat er niet uit volgt, is mensen ermee sorteren of een verschil lezen als waarschuwing — juist die overeenkomst is het deel dat het bewijs nadrukkelijk niet steunt. Wil je weten waardoor iemand zich gezien voelt, dan is de vraag niet in welk van vijf hokjes die persoon thuishoort. De vraag is wat diegene zou willen op een doodgewone dinsdag, en daar bestaat alleen een antwoord op als je het vraagt." },
    ],
  },
  pl: {
    term: "Języki miłości",
    summary:
      "Popularne przekonanie, że każdy człowiek okazuje i odbiera uczucie głównie na jeden z pięciu sposobów — słowa, czas, prezenty, przysługi albo dotyk — i że parom układa się lepiej, gdy ich języki są zgodne.",
    blocks: [
      { type: "h2", text: "Skąd się to wzięło" },
      { type: "p", text: "Gary Chapman wydał książkę w 1992 roku. Nie jest badaczem-psychologiem, tylko baptystycznym pastorem i doradcą małżeńskim, a sama koncepcja wyrosła nie z badania, lecz ze wzorców, które zauważył w poradnictwie. Książka sprzedała się w około dwudziestu milionach egzemplarzy, została przetłumaczona na jakieś pięćdziesiąt języków, a jej test złożony z trzydziestu pytań wypełniły dziesiątki milionów osób. Pod spodem leżą trzy twierdzenia: że każdy ma jeden podstawowy język, że jest ich pięć i że parom układa się lepiej, kiedy ich języki są zgodne." },
      { type: "p", text: "Badania pojawiły się długo po popularności. W **Popular Psychology Through a Scientific Lens** (Impett, Park i Muise, Current Directions in Psychological Science, 2024) troje badaczy zajmujących się relacjami przeszło jeszcze raz przez zgromadzone dowody — to krytyczny przegląd istniejących prac, a nie nowe badanie — i najwyraźniejszy wynik dotyczy trzeciego twierdzenia. Spośród badań, które sprawdzały, czy partnerzy o tym samym podstawowym języku są bardziej zadowoleni, żadne tego nie wykazało. Jest druga wersja tej idei, która wypada lepiej: kiedy partner okazuje uczucie w sposób, który dana osoba wskazała jako preferowany, zadowolenie rzeczywiście rośnie. Ale właśnie tu kończą się możliwości metod — badania nie potrafią oddzielić efektu preferowanego języka od efektu samego okazania uczucia, a kiedy sprawdzono wszystkie kombinacje, wyrazy uczucia we wszystkich pięciu językach szły w parze z zadowoleniem, niezależnie od tego, co ktoś podał jako swoją preferencję." },
      { type: "h2", text: "Dlaczego same kategorie są chwiejne" },
      {
        type: "ul",
        items: [
          "Ludzie oceniają wszystkie pięć jako ważne — średnie wyniki skupiają się przy górnym końcu skali, zamiast wskazywać jeden z nich.",
          "Test z wymuszonym wyborem i skala ocen przeczą sobie nawzajem: w teście prezenty wychodzą jako podstawowy język dla 0–4 procent osób, a przy punktacji na skali w niektórych próbach dla ponad połowy.",
          "Pięć wyników silnie ze sobą koreluje, mniej więcej od 0,54 do 0,75 — pięć osobnych szufladek tak się nie zachowuje.",
          "Analizy czynnikowe znajdowały w różnych próbach trzy, cztery i pięć czynników, a żaden z tych układów nie pokrywa się z opisywaną piątką.",
        ],
      },
      { type: "h2", accent: "green", text: "Co z tym zrobić" },
      { type: "p", text: "Traktuj test jako początek rozmowy, a nie diagnozę. Własne wyjaśnienie autorów przeglądu, dlaczego książka wydaje się tak przydatna, jest warte więcej niż sama klasyfikacja: daje parom okazję, żeby powiedzieć na głos, czego chcą więcej — a reagowanie na to, co druga osoba faktycznie mówi, należy do najlepiej potwierdzonych ustaleń w badaniach nad relacjami. Kategorie być może nie robią nic; robotę wykonuje rozmowa, którą wywołują." },
      { type: "p", text: "Nie ma więc nic złego w tym, żeby lubić ten test i znać swój wynik. Nie wynika z niego natomiast, że wolno po nim sortować ludzi albo czytać rozbieżność jako sygnał ostrzegawczy — zgodność języków jest właśnie tą częścią, której dowody wprost nie potwierdzają. Jeśli chcesz wiedzieć, co sprawia, że druga osoba czuje się zaopiekowana, pytanie nie brzmi, do której z pięciu szufladek należy. Brzmi ono: czego chciałaby w zwykły wtorek — a odpowiedź na nie istnieje tylko wtedy, gdy się je zada." },
    ],
  },
  sv: {
    term: "Kärleksspråk",
    summary:
      "Den populära idén att varje människa främst ger och tar emot kärlek på ett av fem sätt — ord, tid, presenter, tjänster eller beröring — och att par har det bättre när deras språk stämmer överens.",
    blocks: [
      { type: "h2", text: "Var idén kommer ifrån" },
      { type: "p", text: "Gary Chapman gav ut boken 1992. Han är baptistpastor och äktenskapsrådgivare snarare än forskande psykolog, och modellen växte fram ur mönster han såg i sina samtal, inte ur en studie. Boken har sålt i omkring tjugo miljoner exemplar, översatts till ett femtiotal språk, och dess test med trettio frågor har gjorts av tiotals miljoner människor. De tre anspråken under alltihop är att var och en har ett primärt språk, att de är fem till antalet, och att par har det bättre när deras språk stämmer överens." },
      { type: "p", text: "Forskningen kom långt efter populariteten. I **Popular Psychology Through a Scientific Lens** (Impett, Park och Muise, Current Directions in Psychological Science, 2024) gick tre relationsforskare igenom det som redan fanns — en kritisk genomgång av befintlig forskning, inte en ny studie — och det tydligaste resultatet gäller det tredje anspråket. Bland de studier som prövat om partner med samma primära språk är mer nöjda fann ingen att de var det. Det finns en andra version av idén som klarar sig bättre: när en partner visar kärlek på det sätt man själv säger sig föredra ökar tillfredsställelsen faktiskt. Men det är där metoderna tar slut — studierna kan inte skilja effekten av det föredragna språket från effekten av att över huvud taget bli visad kärlek, och när alla kombinationer prövades följdes uttryck på samtliga fem språk åt med tillfredsställelsen, oavsett vad personen hade uppgett att hen föredrog." },
      { type: "h2", text: "Varför själva kategorierna vacklar" },
      {
        type: "ul",
        items: [
          "Folk skattar alla fem som betydelsefulla — snittvärdena samlas nära skalans övre ände i stället för att peka ut ett av dem.",
          "Testet med tvingande val och en skattningsskala säger emot varandra: presenter blir primärt språk för 0 till 4 procent i testet, och för mer än hälften i vissa urval när det skattas på skala.",
          "De fem värdena samvarierar starkt med varandra, ungefär 0,54 till 0,75 — så beter sig inte fem åtskilda fack.",
          "Faktoranalyser har funnit tre, fyra och fem faktorer i olika urval, och ingen av dem stämmer med de fem så som de beskrivs.",
        ],
      },
      { type: "h2", accent: "green", text: "Vad du kan göra med det" },
      { type: "p", text: "Se testet som en samtalsöppning snarare än en diagnos. Genomgångens egen förklaring till varför boken känns så användbar är värd mer än indelningen: den ger par ett tillfälle att säga högt vad de vill ha mer av, och att svara an på det som partnern faktiskt berättar hör till de bäst belagda fynden i relationsforskningen. Kategorierna gör kanske ingenting; det är samtalet de sätter igång som gör jobbet." },
      { type: "p", text: "Så det är helt i sin ordning att tycka om testet och att veta sitt resultat. Det som inte följer är att sortera människor efter det, eller att läsa en olikhet som en varningssignal — matchningen är just den del som forskningen uttryckligen inte stöder. Vill du veta vad som får någon att känna sig omhändertagen är frågan inte vilket av fem fack den personen hör hemma i. Den är vad hen skulle vilja ha en helt vanlig tisdag, och den frågan har bara ett svar om den ställs." },
    ],
  },
  hi: {
    term: "लव लैंग्वेज",
    summary:
      "यह लोकप्रिय ख़याल कि हर इंसान प्यार मुख्य रूप से पाँच में से किसी एक तरीक़े से देता और लेता है — शब्द, साथ बिताया वक़्त, तोहफ़े, काम करके दिखाना या छूना — और जिन जोड़ों की भाषा आपस में मिलती है, उनका रिश्ता बेहतर चलता है।",
    blocks: [
      { type: "h2", text: "यह कहाँ से आया" },
      { type: "p", text: "गैरी चैपमैन ने यह किताब 1992 में छापी। वे शोध करने वाले मनोवैज्ञानिक नहीं, एक बैप्टिस्ट पादरी और विवाह परामर्शदाता हैं; और यह ढाँचा किसी अध्ययन से नहीं, बल्कि परामर्श में उन्हें दिखे तौर-तरीक़ों से निकला। किताब की क़रीब दो करोड़ प्रतियाँ बिकीं, यह पचास के आसपास भाषाओं में अनूदित हुई, और इसका तीस सवालों वाला टेस्ट करोड़ों लोग हल कर चुके हैं। इसके नीचे तीन दावे हैं: हर किसी की एक मुख्य भाषा होती है, ऐसी भाषाएँ पाँच हैं, और जिन जोड़ों की भाषा आपस में मिलती है उनका रिश्ता बेहतर चलता है।" },
      { type: "p", text: "शोध लोकप्रियता के बहुत बाद आया। **Popular Psychology Through a Scientific Lens** (Impett, Park और Muise, Current Directions in Psychological Science, 2024) में रिश्तों का अध्ययन करने वाले तीन शोधकर्ताओं ने मौजूदा सबूतों को दोबारा खंगाला — यह पहले से मौजूद काम की आलोचनात्मक समीक्षा है, कोई नया अध्ययन नहीं — और सबसे साफ़ नतीजा तीसरे दावे को लेकर है। जिन अध्ययनों ने यह जाँचा कि एक ही मुख्य भाषा वाले साथी ज़्यादा संतुष्ट होते हैं या नहीं, उनमें से किसी को भी ऐसा नहीं मिला। इस ख़याल का एक दूसरा रूप भी है, जिसकी हालत बेहतर है: जब साथी उसी तरीक़े से प्यार जताता है जिसे आपने अपनी पसंद बताया था, तो संतुष्टि सचमुच बढ़ती है। लेकिन तरीक़े ठीक यहीं आकर चुक जाते हैं — ये अध्ययन पसंदीदा भाषा के असर को केवल प्यार जताए जाने के असर से अलग नहीं कर पाते; और जब सारे जोड़ मिलाकर जाँचे गए, तो पाँचों भाषाओं में जताया गया प्यार संतुष्टि के साथ-साथ चला, चाहे उस इंसान ने अपनी पसंद कुछ भी बताई हो।" },
      { type: "h2", text: "ये श्रेणियाँ ख़ुद क्यों कमज़ोर हैं" },
      {
        type: "ul",
        items: [
          "लोग पाँचों को अपने लिए अर्थपूर्ण बताते हैं — औसत अंक किसी एक को अलग से उभारने के बजाय पैमाने के ऊपरी सिरे पर जमा हो जाते हैं।",
          "दो में से एक चुनने वाला टेस्ट और अंक देने वाला पैमाना आपस में मेल नहीं खाते: टेस्ट में तोहफ़े 0 से 4 प्रतिशत लोगों की मुख्य भाषा निकलते हैं, जबकि पैमाने पर अंक देने पर कुछ नमूनों में आधे से ज़्यादा लोगों की।",
          "पाँचों अंक आपस में मज़बूती से जुड़े हैं, मोटे तौर पर .54 से .75 तक — पाँच अलग-अलग ख़ानों का बर्ताव यह नहीं होता।",
          "अलग-अलग नमूनों में फ़ैक्टर विश्लेषण ने तीन, चार और पाँच कारक निकाले; इनमें से कोई भी उन पाँच से मेल नहीं खाता जैसा उन्हें बताया गया है।",
        ],
      },
      { type: "h2", accent: "green", text: "इसका क्या किया जाए" },
      { type: "p", text: "टेस्ट को निदान नहीं, बातचीत की शुरुआत मानिए। किताब इतनी काम की क्यों लगती है, इसकी जो वजह ख़ुद इस समीक्षा ने बताई है, वह इस वर्गीकरण से कहीं ज़्यादा क़ीमती है: यह जोड़ों को एक मौक़ा देती है कि वे ज़ोर से कह सकें कि उन्हें किस चीज़ की और ज़रूरत है — और साथी आपसे जो कह रहा है उस पर ध्यान देना, रिश्तों के शोध की सबसे भरोसेमंद बातों में से एक है। हो सकता है श्रेणियाँ कुछ भी न कर रही हों; असल काम वह बातचीत कर रही है जो उनकी वजह से शुरू होती है।" },
      { type: "p", text: "तो टेस्ट का मज़ा लेने और अपना नतीजा जानने में कोई हर्ज नहीं। जो इससे नहीं निकलता, वह है इसके आधार पर लोगों को छाँटना, या भाषा न मिलने को ख़तरे की घंटी की तरह पढ़ना — सबूत ख़ास तौर पर उसी मिलान वाली बात का समर्थन नहीं करते। अगर आप जानना चाहते हैं कि किसी को कब लगता है कि उसका ख़याल रखा जा रहा है, तो सवाल यह नहीं है कि वह पाँच ख़ानों में से किसमें आता है। सवाल यह है कि किसी आम मंगलवार को वह क्या चाहेगा — और इसका जवाब तभी मिलता है जब आप पूछें।" },
    ],
  },
};
