import { HINGE_GENZ_2025, HUANG_JPSP_2017, SSRS_2026, type StatSource } from "@/lib/constants/stats";

/**
 * Answer pages: one page per question people actually type.
 *
 * SHAPE (this is the whole point — do not turn these into blog posts):
 *   question-shaped H1 -> a direct answer in the first two or three sentences
 *   -> supporting detail. AI assistants and search snippets lift the direct
 *   answer, so it must stand alone without the body around it.
 *
 * RULES:
 * - `directAnswer` answers the question completely on its own. No teasing, no
 *   "read on to find out".
 * - Product claims must match what the app actually does (help dictionary is
 *   the source of truth). External figures must carry a `StatSource`.
 * - Never name or disparage a competitor app — talk about "swipe-based apps".
 * - `updatedAt` moves only on a real content revision.
 */
export interface AnswerPage {
  slug: string;
  publishedAt: string;
  updatedAt?: string;
  /** The question, verbatim, as the H1. */
  questions: Record<string, string>;
  /** Self-contained answer, 2–3 sentences. Also used as the meta description. */
  directAnswers: Record<string, string>;
  keywords: string[];
  /** External sources cited in the body, listed at the foot of the page. */
  sources?: StatSource[];
}

export const ANSWER_PAGES: AnswerPage[] = [
  {
    slug: "how-question-based-matching-works",
    publishedAt: "2026-09-01",
    questions: {
      en: "How does question-based matching work?",
      tr: "Soru tabanlı eşleşme nasıl çalışır?",
      de: "Wie funktioniert fragenbasiertes Matching?",
      fr: "Comment fonctionne le matching par questions ?",
      es: "¿Cómo funciona el emparejamiento por preguntas?",
      ar: "كيف يعمل التوافق القائم على الأسئلة؟",
      ru: "Как работает подбор пар по вопросам?",
      pt: "Como funciona o match por perguntas?",
      it: "Come funziona l'abbinamento tramite domande?",
      ja: "質問に答えてマッチングする仕組みとは？",
      ko: "질문 기반 매칭은 어떻게 작동하나요?",
      zh: "基于问题的配对是怎么运作的？",
      nl: "Hoe werkt matchen via vragen?",
      pl: "Jak działa dopasowanie na podstawie pytań?",
      sv: "Hur fungerar matchning med frågor?",
      hi: "सवालों पर आधारित मैचिंग कैसे काम करती है?",
    },
    directAnswers: {
      en: "In question-based matching you match by answering questions the other person wrote, not by swiping on their photo. On Qulo each person writes 2 to 10 multiple-choice questions with four options each and marks the correct answer; another user matches with them only by getting every one of those questions right. The filter is a small act of attention rather than a snap judgement on a picture.",
      tr: "Soru tabanlı eşleşmede, karşınızdakinin fotoğrafına kaydırarak değil, onun yazdığı soruları doğru yanıtlayarak eşleşirsiniz. Qulo'da her kullanıcı dört şıklı 2 ila 10 soru hazırlar ve doğru cevabı işaretler; bir başkası ancak bu soruların hepsini doğru bilirse onunla eşleşir. Yani ilk filtre bir fotoğrafa verilen ani karar değil, küçük bir dikkat eylemidir.",
      de: "Beim fragenbasierten Matching kommt ein Match zustande, weil du die Fragen der anderen Person richtig beantwortest – nicht, weil du ihr Foto zur Seite wischst. Bei Qulo schreibt jede Person 2 bis 10 Multiple-Choice-Fragen mit je vier Antwortmöglichkeiten und markiert die richtige Lösung; wer sie alle richtig beantwortet, bekommt das Match. Der erste Filter ist damit ein kleiner Moment der Aufmerksamkeit statt eines schnellen Urteils über ein Bild.",
      fr: "Dans le matching par questions, vous matchez en répondant correctement aux questions écrites par l'autre personne, et non en balayant sa photo. Sur Qulo, chacun rédige de 2 à 10 questions à choix multiple, avec quatre réponses possibles chacune, et désigne la bonne ; une autre personne ne matche avec vous que si elle répond juste à toutes. Le premier filtre devient un petit geste d'attention plutôt qu'un jugement instantané sur une photo.",
      es: "En el emparejamiento por preguntas haces match respondiendo correctamente a las preguntas que escribió la otra persona, no deslizando su foto. En Qulo cada persona escribe entre 2 y 10 preguntas de opción múltiple, con cuatro opciones cada una, y marca la respuesta correcta; otro usuario solo hace match si las acierta todas. Así el primer filtro es un pequeño gesto de atención y no un juicio inmediato sobre una foto.",
      ar: "في التوافق القائم على الأسئلة تتوافق مع الشخص الآخر بالإجابة الصحيحة عن الأسئلة التي كتبها، لا بتمرير صورته. في Qulo يكتب كل شخص من 2 إلى 10 أسئلة اختيار من متعدد، لكل سؤال أربعة خيارات، ويحدد الإجابة الصحيحة؛ ولا يتوافق معه أحد إلا إذا أجاب عنها كلها إجابة صحيحة. وهكذا يصبح الفلتر الأول لحظة انتباه صغيرة بدلاً من حكم سريع على صورة.",
      ru: "При подборе по вопросам вы совпадаете с человеком, правильно ответив на вопросы, которые он написал, а не пролистнув его фото. В Qulo каждый составляет от 2 до 10 вопросов с четырьмя вариантами ответа и отмечает верный; другой пользователь получает совпадение, только если ответит правильно на все. Так первым фильтром становится небольшое усилие внимания, а не мгновенная оценка по фотографии.",
      pt: "No match por perguntas, você combina com alguém respondendo corretamente às perguntas que essa pessoa escreveu, e não deslizando a foto dela. No Qulo cada pessoa cria de 2 a 10 perguntas de múltipla escolha, com quatro alternativas cada, e marca a resposta certa; o match só acontece se o outro acertar todas. Assim o primeiro filtro é um pequeno gesto de atenção, não um julgamento instantâneo de uma foto.",
      it: "Nell'abbinamento tramite domande ottieni un match rispondendo correttamente alle domande scritte dall'altra persona, non scorrendo la sua foto. Su Qulo ognuno scrive da 2 a 10 domande a risposta multipla, con quattro opzioni ciascuna, e indica quella giusta; un altro utente ottiene il match solo se le indovina tutte. Il primo filtro diventa così un piccolo gesto di attenzione invece di un giudizio immediato su una foto.",
      ja: "質問ベースのマッチングでは、写真をスワイプするのではなく、相手が書いた質問にすべて正解することでマッチします。Qulo では一人ひとりが選択肢四つの質問を2問から10問つくり、正解を設定します。ほかのユーザーは、その質問すべてに正解したときだけマッチできます。最初のフィルターになるのは写真への一瞬の判断ではなく、相手にきちんと目を向ける小さな行為です。",
      ko: "질문 기반 매칭에서는 사진을 스와이프하는 대신 상대가 직접 쓴 질문을 모두 맞혀야 매칭됩니다. Qulo에서는 각자 보기 네 개짜리 객관식 질문을 2개에서 10개까지 만들고 정답을 표시하며, 다른 사용자는 그 질문을 전부 맞혔을 때만 매칭됩니다. 그래서 첫 관문은 사진에 대한 순간적인 판단이 아니라 상대에게 잠깐 마음을 쓰는 일이 됩니다.",
      zh: "在基于问题的配对里，你不是靠滑动照片，而是靠答对对方写下的问题来配对。在 Qulo，每个人写 2 到 10 道单选题，每题四个选项，并标出正确答案；另一位用户必须全部答对，才能和他配对。第一道筛选因此变成一次小小的用心，而不是对照片的瞬间判断。",
      nl: "Bij matchen via vragen krijg je een match door de vragen van de ander goed te beantwoorden, niet door over een foto te swipen. Op Qulo schrijft iedereen 2 tot 10 meerkeuzevragen met elk vier antwoorden en markeert het juiste antwoord; een ander matcht alleen met je als die ze allemaal goed heeft. De eerste filter is zo een kleine daad van aandacht in plaats van een snel oordeel over een foto.",
      pl: "W dopasowaniu na podstawie pytań łączysz się z kimś, poprawnie odpowiadając na pytania, które ta osoba ułożyła, a nie przesuwając jej zdjęcie. W Qulo każdy układa od 2 do 10 pytań jednokrotnego wyboru z czterema odpowiedziami i zaznacza tę prawidłową; inny użytkownik dopasuje się tylko wtedy, gdy trafi wszystkie. Pierwszym filtrem staje się więc chwila uwagi, a nie błyskawiczna ocena zdjęcia.",
      sv: "Vid matchning med frågor matchar du genom att svara rätt på frågorna som den andra personen har skrivit, inte genom att svepa på ett foto. På Qulo skriver varje person 2 till 10 flervalsfrågor med fyra svarsalternativ vardera och markerar det rätta; någon annan matchar med dig först när alla svar är rätta. Det första filtret blir en liten stund av uppmärksamhet i stället för en snabb dom över ett foto.",
      hi: "सवालों पर आधारित मैचिंग में आप किसी की फ़ोटो स्वाइप करके नहीं, बल्कि उसके लिखे सवालों के सही जवाब देकर मैच करते हैं। Qulo पर हर व्यक्ति चार विकल्पों वाले 2 से 10 सवाल बनाता है और उनका सही जवाब चुनता है; कोई दूसरा उपयोगकर्ता तभी मैच करता है जब वह हर सवाल सही कर दे। इसलिए पहली छलनी फ़ोटो पर लिया गया तुरंत फ़ैसला नहीं, बल्कि थोड़ा ध्यान देने की एक छोटी कोशिश बन जाती है।",
    },
    keywords: [
      "how does question based matching work",
      "question based dating app",
      "quiz based matching",
      "dating app where you answer questions",
      "soru tabanlı eşleşme",
      "quiz dating nasıl çalışır",
    ],
    sources: [HUANG_JPSP_2017, HINGE_GENZ_2025],
  },
  {
    slug: "is-qulo-free",
    publishedAt: "2026-09-01",
    questions: {
      en: "Is Qulo free?",
      tr: "Qulo ücretsiz mi?",
      de: "Ist Qulo kostenlos?",
      fr: "Qulo est-il gratuit ?",
      es: "¿Qulo es gratis?",
      ar: "هل تطبيق Qulo مجاني؟",
      ru: "Qulo — это бесплатно?",
      pt: "O Qulo é gratuito?",
      it: "Qulo è gratis?",
      ja: "Qulo は無料ですか？",
      ko: "Qulo는 무료인가요?",
      zh: "Qulo 是免费的吗？",
      nl: "Is Qulo gratis?",
      pl: "Czy Qulo jest darmowe?",
      sv: "Är Qulo gratis?",
      hi: "क्या Qulo मुफ़्त है?",
    },
    directAnswers: {
      en: "Yes. Qulo is free to download and free to use for its core loop: you can write your questions, solve other people's questions and match without paying. Two optional subscriptions, Plus at $4.99 and Premium at $9.99 per month, add convenience features, and an in-app diamond currency powers optional boosts — none of which are required to match.",
      tr: "Evet. Qulo'yu indirmek ve temel döngüsünü kullanmak ücretsizdir: sorularınızı yazabilir, başkalarının sorularını çözebilir ve para ödemeden eşleşebilirsiniz. İsteğe bağlı iki abonelik (aylık 4,99 $ Plus ve 9,99 $ Premium) ek kolaylıklar sunar, uygulama içi elmas para birimi de isteğe bağlı güçleri çalıştırır — hiçbiri eşleşmek için zorunlu değildir.",
      de: "Ja. Qulo lässt sich kostenlos herunterladen, und der Kern der App bleibt gratis: Du kannst deine Fragen schreiben, die Fragen anderer lösen und matchen, ohne zu bezahlen. Zwei optionale Abos – Plus für 4,99 $ und Premium für 9,99 $ pro Monat – bringen zusätzlichen Komfort, und die Diamanten in der App treiben optionale Extras an; nichts davon ist nötig, um zu matchen.",
      fr: "Oui. Qulo est gratuit à télécharger, et sa boucle principale reste gratuite : vous pouvez écrire vos questions, résoudre celles des autres et matcher sans payer. Deux abonnements facultatifs, Plus à 4,99 $ et Premium à 9,99 $ par mois, ajoutent du confort, et une monnaie interne en diamants alimente des bonus optionnels ; rien de tout cela n'est nécessaire pour matcher.",
      es: "Sí. Qulo es gratis de descargar y su funcionamiento básico también lo es: puedes escribir tus preguntas, resolver las de otras personas y hacer match sin pagar. Dos suscripciones opcionales, Plus por 4,99 $ y Premium por 9,99 $ al mes, añaden comodidades, y una moneda interna de diamantes activa mejoras opcionales; nada de eso hace falta para hacer match.",
      ar: "نعم. تنزيل Qulo مجاني، واستخدامه في وظيفته الأساسية مجاني أيضًا: يمكنك كتابة أسئلتك، وحل أسئلة الآخرين، والتوافق معهم دون أن تدفع شيئًا. هناك اشتراكان اختياريان، Plus بـ 4.99 دولار وPremium بـ 9.99 دولار شهريًا، يضيفان مزايا تسهّل الاستخدام، كما تشغّل عملة الألماس داخل التطبيق ميزات إضافية اختيارية؛ ولا شيء من ذلك مطلوب للتوافق.",
      ru: "Да. Скачать Qulo бесплатно, и основной сценарий тоже бесплатный: вы можете написать свои вопросы, разгадывать чужие и совпадать, ничего не платя. Две необязательные подписки — Plus за 4,99 $ и Premium за 9,99 $ в месяц — добавляют удобства, а внутренняя валюта в виде алмазов включает дополнительные возможности; ничего из этого для совпадения не требуется.",
      pt: "Sim. Baixar o Qulo é gratuito e o essencial do app também é: você pode escrever suas perguntas, responder às dos outros e dar match sem pagar nada. Duas assinaturas opcionais, Plus por 4,99 $ e Premium por 9,99 $ por mês, acrescentam comodidades, e uma moeda interna de diamantes ativa recursos extras opcionais — nada disso é necessário para dar match.",
      it: "Sì. Qulo si scarica gratis e il suo funzionamento di base resta gratuito: puoi scrivere le tue domande, risolvere quelle degli altri e ottenere match senza pagare. Due abbonamenti facoltativi, Plus a 4,99 $ e Premium a 9,99 $ al mese, aggiungono comodità, e una valuta interna in diamanti alimenta funzioni extra opzionali: nulla di tutto ciò serve per ottenere un match.",
      ja: "はい。Qulo はダウンロードも、基本的な使い方も無料です。自分の質問をつくり、ほかの人の質問に答え、マッチするところまで一切お金はかかりません。任意のサブスクリプションが二つあり、Plus は月額 4.99 ドル、Premium は月額 9.99 ドルで、便利な機能が加わります。アプリ内のダイヤモンドも任意の機能に使うもので、マッチするために必要なものはひとつもありません。",
      ko: "네. Qulo는 다운로드도 무료이고 핵심 기능도 무료입니다. 내 질문을 만들고, 다른 사람의 질문을 풀고, 매칭되는 것까지 돈을 낼 필요가 없습니다. 선택 구독은 두 가지로 Plus는 월 4.99달러, Premium은 월 9.99달러이며 편의 기능을 더해 줍니다. 앱 안의 다이아몬드도 선택 기능에 쓰이며, 매칭에 꼭 필요한 것은 하나도 없습니다.",
      zh: "是的。Qulo 下载免费，核心玩法也免费：你可以写自己的问题、解答别人的问题并配对，全程不用付费。两种可选订阅——Plus 每月 4.99 美元、Premium 每月 9.99 美元——提供更多便利功能，应用内的钻石则用于可选的加成；这些都不是配对的必要条件。",
      nl: "Ja. Qulo is gratis te downloaden en de kern van de app blijft gratis: je kunt je vragen schrijven, die van anderen oplossen en matchen zonder te betalen. Twee optionele abonnementen, Plus voor 4,99 $ en Premium voor 9,99 $ per maand, voegen gemak toe, en de diamanten in de app zetten optionele extra's aan — niets daarvan is nodig om te matchen.",
      pl: "Tak. Qulo pobierzesz za darmo i jego podstawowa mechanika też jest darmowa: możesz ułożyć własne pytania, rozwiązywać pytania innych i dopasowywać się bez płacenia. Dwie opcjonalne subskrypcje – Plus za 4,99 $ i Premium za 9,99 $ miesięcznie – dodają wygodne funkcje, a diamenty w aplikacji napędzają dodatkowe ułatwienia; nic z tego nie jest potrzebne, żeby się dopasować.",
      sv: "Ja. Qulo är gratis att ladda ner och appens kärna är också gratis: du kan skriva dina frågor, lösa andras frågor och matcha utan att betala. Två valfria abonnemang, Plus för 4,99 $ och Premium för 9,99 $ i månaden, lägger till bekvämligheter, och diamanterna i appen driver valfria extrafunktioner – inget av det krävs för att matcha.",
      hi: "हाँ। Qulo डाउनलोड करना मुफ़्त है और इसका मुख्य इस्तेमाल भी मुफ़्त है: आप अपने सवाल लिख सकते हैं, दूसरों के सवाल हल कर सकते हैं और बिना पैसे दिए मैच कर सकते हैं। दो वैकल्पिक सदस्यताएँ हैं — Plus 4.99 डॉलर और Premium 9.99 डॉलर प्रति माह — जो सुविधाएँ जोड़ती हैं, और ऐप के अंदर के डायमंड वैकल्पिक बूस्ट चलाते हैं; मैच करने के लिए इनमें से कुछ भी ज़रूरी नहीं है।",
    },
    keywords: [
      "is qulo free",
      "qulo price",
      "free dating app without swiping",
      "qulo ücretsiz mi",
      "qulo abonelik fiyat",
    ],
  },
  {
    slug: "is-qulo-safe",
    publishedAt: "2026-09-01",
    questions: {
      en: "Is Qulo safe to use?",
      tr: "Qulo güvenli mi?",
      de: "Ist Qulo sicher?",
      fr: "Qulo est-il sûr ?",
      es: "¿Qulo es seguro?",
      ar: "هل تطبيق Qulo آمن؟",
      ru: "Насколько безопасен Qulo?",
      pt: "O Qulo é seguro?",
      it: "Qulo è sicuro?",
      ja: "Qulo は安全に使えますか？",
      ko: "Qulo는 안전한가요?",
      zh: "Qulo 安全吗？",
      nl: "Is Qulo veilig?",
      pl: "Czy Qulo jest bezpieczne?",
      sv: "Är Qulo säkert?",
      hi: "क्या Qulo सुरक्षित है?",
    },
    directAnswers: {
      en: "Qulo stores your data encrypted, verifies email addresses before a profile can appear, and puts block and report controls on every profile and every chat. Reports go to a moderation panel and are reviewed by a person. No dating app can make meeting a stranger risk-free, so treat the in-app tools as one layer and ordinary first-date precautions as the other.",
      tr: "Qulo verilerinizi şifreli saklar, bir profil görünür olmadan önce e-posta adresini doğrular ve her profilde ve her sohbette engelleme ile şikayet kontrolleri sunar. Şikayetler moderasyon paneline düşer ve bir insan tarafından incelenir. Hiçbir dating uygulaması bir yabancıyla buluşmayı risksiz kılamaz; uygulama içi araçları bir katman, sıradan ilk buluşma tedbirlerini ikinci katman olarak görün.",
      de: "Qulo speichert deine Daten verschlüsselt, prüft die E-Mail-Adresse, bevor ein Profil sichtbar wird, und stellt in jedem Profil und jedem Chat Funktionen zum Blockieren und Melden bereit. Meldungen landen in einem Moderationsbereich und werden von einem Menschen geprüft. Keine Dating-App kann das Treffen mit einer fremden Person völlig risikofrei machen: Sieh die Werkzeuge in der App als eine Schicht und die üblichen Vorsichtsmaßnahmen beim ersten Date als die andere.",
      fr: "Qulo chiffre vos données, vérifie l'adresse e-mail avant qu'un profil puisse apparaître et place des boutons de blocage et de signalement sur chaque profil et chaque conversation. Les signalements arrivent dans un panneau de modération et sont examinés par une personne. Aucune application de rencontre ne peut rendre une rencontre avec un inconnu totalement sans risque : considérez les outils de l'app comme une couche de protection, et les précautions habituelles d'un premier rendez-vous comme l'autre.",
      es: "Qulo guarda tus datos cifrados, verifica la dirección de correo antes de que un perfil pueda aparecer y coloca opciones de bloqueo y denuncia en cada perfil y en cada chat. Las denuncias llegan a un panel de moderación y las revisa una persona. Ninguna app de citas puede eliminar el riesgo de conocer a un desconocido: trata las herramientas de la app como una capa de protección y las precauciones habituales de una primera cita como la otra.",
      ar: "يحفظ Qulo بياناتك مشفَّرة، ويتحقق من عنوان بريدك الإلكتروني قبل أن يظهر ملفك للآخرين، ويضع أدوات الحظر والإبلاغ في كل ملف شخصي وكل محادثة. تصل البلاغات إلى لوحة إشراف ويراجعها شخص حقيقي. لا يمكن لأي تطبيق مواعدة أن يجعل لقاء شخص غريب بلا مخاطر، لذلك اعتبر أدوات التطبيق طبقة حماية، واحتياطاتك المعتادة في اللقاء الأول هي الطبقة الأخرى.",
      ru: "Qulo хранит ваши данные в зашифрованном виде, проверяет адрес электронной почты до того, как анкета станет видимой, и добавляет кнопки блокировки и жалобы в каждый профиль и каждый чат. Жалобы попадают в панель модерации, и их разбирает человек. Ни одно приложение для знакомств не сделает встречу с незнакомцем полностью безопасной, поэтому считайте инструменты в приложении одним слоем защиты, а обычные меры предосторожности на первом свидании — другим.",
      pt: "O Qulo guarda seus dados criptografados, confirma o e-mail antes de o perfil aparecer e coloca opções de bloquear e denunciar em cada perfil e cada conversa. As denúncias vão para um painel de moderação e são analisadas por uma pessoa. Nenhum aplicativo de relacionamento consegue tornar um encontro com um desconhecido isento de risco, então trate as ferramentas do app como uma camada de proteção e os cuidados comuns de um primeiro encontro como a outra.",
      it: "Qulo conserva i tuoi dati cifrati, verifica l'indirizzo e-mail prima che un profilo possa comparire e mette i comandi per bloccare e segnalare in ogni profilo e in ogni chat. Le segnalazioni finiscono in un pannello di moderazione e vengono lette da una persona. Nessuna app di incontri può rendere del tutto privo di rischi un incontro con uno sconosciuto: considera gli strumenti dell'app come una protezione e le normali precauzioni di un primo appuntamento come l'altra.",
      ja: "Qulo はデータを暗号化して保存し、プロフィールが表示される前にメールアドレスを確認します。すべてのプロフィールとチャットにブロックと報告の機能があり、報告はモデレーション画面に届いて担当者が目を通します。知らない人と会うことのリスクをゼロにできるアプリはありません。アプリの機能をひとつの備えとし、初めて会うときのふだんの用心をもうひとつの備えとして考えてください。",
      ko: "Qulo는 데이터를 암호화해 저장하고, 프로필이 공개되기 전에 이메일 주소를 확인하며, 모든 프로필과 모든 대화에 차단과 신고 기능을 둡니다. 신고는 운영 화면으로 전달되어 사람이 직접 검토합니다. 어떤 데이팅 앱도 낯선 사람을 만나는 일을 완전히 안전하게 만들 수는 없으니, 앱의 기능을 한 겹의 보호막으로, 첫 만남에서 지키는 평소의 조심을 또 한 겹으로 생각하세요.",
      zh: "Qulo 会加密保存你的数据，在资料公开前先验证邮箱地址，并在每个资料页和每段聊天里都提供拉黑与举报入口。举报会进入审核后台，由真人逐条查看。没有哪款交友软件能让见陌生人变得毫无风险，所以请把应用内的工具当作一层保护，把初次见面的常规谨慎当作另一层。",
      nl: "Qulo bewaart je gegevens versleuteld, controleert het e-mailadres voordat een profiel zichtbaar wordt en zet blokkeer- en meldknoppen bij elk profiel en elke chat. Meldingen komen in een moderatiepaneel terecht en worden door een mens bekeken. Geen enkele datingapp kan een ontmoeting met een onbekende risicoloos maken, dus zie de middelen in de app als één laag en de gewone voorzorgen bij een eerste date als de andere.",
      pl: "Qulo przechowuje twoje dane w postaci zaszyfrowanej, weryfikuje adres e-mail, zanim profil stanie się widoczny, i umieszcza opcje blokowania oraz zgłaszania przy każdym profilu i każdej rozmowie. Zgłoszenia trafiają do panelu moderacji i czyta je człowiek. Żadna aplikacja randkowa nie sprawi, że spotkanie z nieznajomym będzie wolne od ryzyka, więc traktuj narzędzia w aplikacji jako jedną warstwę ochrony, a zwykłą ostrożność na pierwszej randce jako drugą.",
      sv: "Qulo lagrar dina uppgifter krypterat, verifierar e-postadressen innan en profil kan visas och har knappar för att blockera och anmäla i varje profil och varje chatt. Anmälningar hamnar i en moderationspanel och läses av en människa. Ingen dejtingapp kan göra ett möte med en främling helt riskfritt, så se verktygen i appen som ett lager skydd och vanlig försiktighet inför en första dejt som ett annat.",
      hi: "Qulo आपका डेटा एन्क्रिप्ट करके रखता है, प्रोफ़ाइल दिखने से पहले ईमेल पता सत्यापित करता है, और हर प्रोफ़ाइल तथा हर चैट में ब्लॉक और रिपोर्ट के विकल्प देता है। रिपोर्ट मॉडरेशन पैनल में जाती है और उसे एक इंसान पढ़ता है। किसी अजनबी से मिलने को कोई भी डेटिंग ऐप पूरी तरह जोखिम-मुक्त नहीं बना सकता, इसलिए ऐप के ये विकल्प सुरक्षा की एक परत हैं और पहली मुलाक़ात की आम सावधानियाँ दूसरी परत।",
    },
    keywords: [
      "is qulo safe",
      "dating app safety",
      "is online dating safe",
      "qulo güvenli mi",
      "dating uygulaması güvenliği",
    ],
    sources: [SSRS_2026],
  },
  {
    slug: "what-makes-a-good-dating-app-question",
    publishedAt: "2026-09-01",
    questions: {
      en: "What makes a good dating app question?",
      tr: "İyi bir dating uygulaması sorusu nasıl olur?",
      de: "Was macht eine gute Frage in einer Dating-App aus?",
      fr: "Qu'est-ce qui fait une bonne question sur une application de rencontre ?",
      es: "¿Qué hace que una pregunta de app de citas sea buena?",
      ar: "ما الذي يجعل السؤال في تطبيق المواعدة سؤالًا جيدًا؟",
      ru: "Каким должен быть хороший вопрос в приложении для знакомств?",
      pt: "O que faz uma boa pergunta em um app de namoro?",
      it: "Cosa rende buona una domanda su un'app di incontri?",
      ja: "デーティングアプリで良い質問とは？",
      ko: "데이팅 앱에서 좋은 질문이란?",
      zh: "交友软件上什么才算好问题？",
      nl: "Wat maakt een goede vraag op een datingapp?",
      pl: "Jak wygląda dobre pytanie w aplikacji randkowej?",
      sv: "Vad är en bra fråga på en dejtingapp?",
      hi: "डेटिंग ऐप पर अच्छा सवाल कैसा होता है?",
    },
    directAnswers: {
      en: "A good question is specific, open enough to need a real answer, and about something the other person can actually speak to — and the strongest one of all is a follow-up to what they just said. Hinge's 2025 survey of around 30,000 daters found follow-up questions were the type that landed best, ahead of questions about interests or values, and 85% of daters said thoughtful questions make them more likely to want a second date.",
      tr: "İyi bir soru somuttur, gerçek bir cevap gerektirecek kadar açıktır ve karşınızdakinin hakkında gerçekten konuşabileceği bir şeydir — en güçlüsü ise onun az önce söylediğinin üzerine gelen takip sorusudur. Hinge'in yaklaşık 30.000 kullanıcıyla yaptığı 2025 araştırmasında en iyi işleyen tip takip soruları oldu; ilgi alanları ve değerlerle ilgili soruların önünde. Kullanıcıların %85'i düşünceli sorular sorulduğunda ikinci buluşmayı daha çok istediğini söyledi.",
      de: "Eine gute Frage ist konkret, offen genug für eine echte Antwort und dreht sich um etwas, wozu die andere Person wirklich etwas sagen kann – am stärksten wirkt die Nachfrage zu dem, was sie gerade erzählt hat. In einer Hinge-Umfrage von 2025 unter rund 30.000 Datenden kamen Nachfragen am besten an, noch vor Fragen zu Interessen oder Werten, und 85 % gaben an, dass durchdachte Fragen die Lust auf ein zweites Date steigern.",
      fr: "Une bonne question est précise, assez ouverte pour appeler une vraie réponse et porte sur quelque chose dont l'autre peut réellement parler ; la plus efficace de toutes est celle qui rebondit sur ce qu'il vient de dire. Une enquête Hinge de 2025 auprès d'environ 30 000 célibataires a montré que les questions de relance fonctionnaient le mieux, devant celles sur les centres d'intérêt ou les valeurs, et 85 % des personnes interrogées ont dit que des questions attentives leur donnaient davantage envie d'un deuxième rendez-vous.",
      es: "Una buena pregunta es concreta, lo bastante abierta como para pedir una respuesta de verdad y trata sobre algo de lo que la otra persona puede hablar de verdad; la más potente de todas es la que retoma lo que acaba de contarte. Una encuesta de Hinge de 2025 a unas 30.000 personas encontró que las preguntas de seguimiento eran las que mejor funcionaban, por delante de las de intereses o valores, y el 85% dijo que las preguntas cuidadas les daban más ganas de una segunda cita.",
      ar: "السؤال الجيد محدد، ومفتوح بما يكفي ليستدعي إجابة حقيقية، ويدور حول شيء يستطيع الطرف الآخر التحدث عنه فعلًا؛ وأقواها جميعًا هو السؤال الذي يبني على ما قاله للتو. وجد استطلاع Hinge لعام 2025 الذي شمل نحو 30,000 شخص أن أسئلة المتابعة هي الأفضل أداءً، متقدمة على الأسئلة عن الاهتمامات أو القيم، وقال 85% إن الأسئلة المدروسة تزيد رغبتهم في موعد ثانٍ.",
      ru: "Хороший вопрос конкретен, достаточно открыт, чтобы на него нельзя было ответить одним словом, и касается того, о чём собеседник действительно может рассказать; сильнее всего работает уточняющий вопрос о том, что он только что сказал. Опрос Hinge 2025 года, охвативший около 30 000 человек, показал, что именно уточняющие вопросы заходили лучше всего — впереди вопросов об интересах и ценностях, — а 85% ответили, что продуманные вопросы усиливают желание пойти на второе свидание.",
      pt: "Uma boa pergunta é específica, aberta o suficiente para exigir uma resposta de verdade e trata de algo sobre o que a outra pessoa realmente consegue falar; a mais forte de todas é a que retoma o que ela acabou de dizer. Uma pesquisa da Hinge de 2025 com cerca de 30.000 pessoas mostrou que as perguntas de continuidade eram as que funcionavam melhor, à frente das sobre interesses ou valores, e 85% disseram que perguntas atenciosas aumentam a vontade de marcar um segundo encontro.",
      it: "Una buona domanda è specifica, abbastanza aperta da richiedere una risposta vera e riguarda qualcosa di cui l'altra persona può davvero parlare; la più efficace di tutte è quella che riprende ciò che ha appena detto. Un'indagine Hinge del 2025 su circa 30.000 persone ha rilevato che le domande di approfondimento funzionavano meglio di quelle su interessi o valori, e l'85% ha dichiarato che domande pensate aumentano la voglia di un secondo appuntamento.",
      ja: "良い質問は具体的で、ひと言では答えられないくらい開かれていて、相手が本当に語れることについて尋ねます。いちばん強いのは、相手がいま話したことを掘り下げる質問です。Hinge が 2025 年に約 30,000 人を対象に行った調査では、掘り下げの質問が最も効果的で、趣味や価値観についての質問を上回りました。回答者の 85% は、よく考えられた質問をされると次に会いたい気持ちが強くなると答えています。",
      ko: "좋은 질문은 구체적이고, 한마디로 답할 수 없을 만큼 열려 있으며, 상대가 실제로 이야기할 수 있는 것을 묻습니다. 그중에서도 가장 강한 질문은 상대가 방금 한 말을 이어받아 더 묻는 것입니다. Hinge가 2025년에 약 30,000명을 대상으로 한 조사에서 이런 후속 질문이 관심사나 가치관에 관한 질문보다 더 잘 통했고, 응답자의 85%는 사려 깊은 질문을 받으면 다시 만나고 싶어진다고 답했습니다.",
      zh: "好问题足够具体，开放到必须认真作答，而且问的是对方真的能聊的事；其中最有力的，是顺着对方刚说的话继续追问。Hinge 在 2025 年对约 30,000 名用户的调查发现，追问类问题的效果最好，胜过关于兴趣或价值观的问题，还有 85% 的人表示，被问到用心的问题会让他们更想再见一面。",
      nl: "Een goede vraag is concreet, open genoeg om een echt antwoord te vragen en gaat over iets waar de ander daadwerkelijk over kan vertellen; de sterkste van allemaal is de doorvraag op wat die net zei. Een Hinge-onderzoek uit 2025 onder ongeveer 30.000 daters liet zien dat doorvragen het beste werkten, nog vóór vragen over interesses of waarden, en 85% zei dat doordachte vragen de zin in een tweede date vergroten.",
      pl: "Dobre pytanie jest konkretne, na tyle otwarte, że wymaga prawdziwej odpowiedzi, i dotyczy czegoś, o czym druga osoba naprawdę może opowiedzieć; najmocniejsze ze wszystkich jest dopytanie o to, co przed chwilą powiedziała. Badanie Hinge z 2025 roku wśród około 30 000 osób pokazało, że najlepiej działały właśnie pytania pogłębiające – lepiej niż pytania o zainteresowania czy wartości – a 85% badanych stwierdziło, że przemyślane pytania zwiększają ochotę na drugą randkę.",
      sv: "En bra fråga är konkret, tillräckligt öppen för att kräva ett riktigt svar och handlar om något den andra personen faktiskt kan berätta om; allra starkast är följdfrågan på det som just sagts. En Hinge-undersökning från 2025 med omkring 30 000 dejtande visade att just följdfrågor fungerade bäst, före frågor om intressen eller värderingar, och 85 % sa att omtänksamma frågor gör dem mer sugna på en andra dejt.",
      hi: "अच्छा सवाल ठोस होता है, इतना खुला कि उसका असली जवाब देना पड़े, और उसी बारे में होता है जिस पर सामने वाला सचमुच बात कर सकता है; सबसे असरदार सवाल वह है जो उसकी अभी कही बात को आगे बढ़ाए। Hinge के 2025 के सर्वेक्षण में, जिसमें करीब 30,000 लोग शामिल थे, ऐसे आगे बढ़ाने वाले सवाल सबसे अच्छे रहे — रुचियों या मूल्यों के सवालों से भी बेहतर — और 85% लोगों ने कहा कि सोच-समझकर पूछे गए सवाल उन्हें दोबारा मिलने की इच्छा बढ़ा देते हैं।",
    },
    keywords: [
      "good dating app questions",
      "what questions to ask on a dating app",
      "questions that reveal personality",
      "iyi dating sorusu",
      "dating uygulamasında ne sorulur",
    ],
    sources: [HINGE_GENZ_2025, HUANG_JPSP_2017],
  },
];

/** Localized question with English fallback. */
export function answerQuestion(page: AnswerPage, locale: string): string {
  return page.questions[locale] || page.questions.en;
}

/** Localized direct answer with English fallback. */
export function answerSummary(page: AnswerPage, locale: string): string {
  return page.directAnswers[locale] || page.directAnswers.en;
}
