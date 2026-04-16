export const SITE_URL = "https://quloapp.com";
export const SITE_NAME = "Qulo";

export const SEO: Record<string, { title: string; description: string }> = {
  tr: {
    title: "Qulo — Sorularla Tanış | AI Dating Uygulaması",
    description:
      "Soru hazırla, paylaş, doğru cevaplayan kişiyle eşleş. AI destekli yeni nesil tanışma uygulaması.",
  },
  en: {
    title: "Qulo — Meet Through Questions | AI Dating App",
    description:
      "Create questions, share them, match with the person who answers correctly. AI-powered next-gen dating app.",
  },
  de: {
    title: "Qulo — Kennenlernen durch Fragen | AI Dating App",
    description:
      "Erstelle Fragen, teile sie und matche mit der Person, die richtig antwortet. KI-gestützte Dating-App der nächsten Generation.",
  },
  fr: {
    title: "Qulo — Rencontrez par les Questions | App de Dating IA",
    description:
      "Créez des questions, partagez-les, matchez avec la personne qui répond correctement. App de rencontre nouvelle génération propulsée par l'IA.",
  },
  es: {
    title: "Qulo — Conoce a Través de Preguntas | App de Citas con IA",
    description:
      "Crea preguntas, compártelas, haz match con quien responda correctamente. App de citas de nueva generación con IA.",
  },
  ar: {
    title: "Qulo — تعارف من خلال الأسئلة | تطبيق مواعدة بالذكاء الاصطناعي",
    description:
      "أنشئ أسئلة، شاركها، وتطابق مع من يجيب بشكل صحيح. تطبيق مواعدة من الجيل الجديد مدعوم بالذكاء الاصطناعي.",
  },
  ja: {
    title: "Qulo — 質問で出会う | AI マッチングアプリ",
    description:
      "質問を作成し、共有し、正しく答えた人とマッチ。AI搭載の次世代マッチングアプリ。",
  },
  ko: {
    title: "Qulo — 질문으로 만남 | AI 데이팅 앱",
    description:
      "질문을 만들고, 공유하고, 정답을 맞힌 사람과 매칭하세요. AI 기반 차세대 데이팅 앱.",
  },
  zh: {
    title: "Qulo — 通过问题认识 | AI 约会应用",
    description:
      "创建问题、分享问题、与答对的人匹配。AI驱动的新一代约会应用。",
  },
  ru: {
    title: "Qulo — Знакомства через вопросы | AI приложение для знакомств",
    description:
      "Создавайте вопросы, делитесь ими и находите пару с тем, кто ответит правильно. Приложение для знакомств нового поколения на базе ИИ.",
  },
  pt: {
    title: "Qulo — Conheça Através de Perguntas | App de Namoro com IA",
    description:
      "Crie perguntas, compartilhe e combine com quem responder corretamente. App de namoro de nova geração com IA.",
  },
  it: {
    title: "Qulo — Incontra Attraverso le Domande | App di Incontri con IA",
    description:
      "Crea domande, condividile e fai match con chi risponde correttamente. App di incontri di nuova generazione con IA.",
  },
  nl: {
    title: "Qulo — Ontmoet Via Vragen | AI Dating App",
    description:
      "Maak vragen, deel ze en match met degene die correct antwoordt. AI-gestuurde dating-app van de nieuwe generatie.",
  },
  pl: {
    title: "Qulo — Poznawaj Przez Pytania | Aplikacja Randkowa z AI",
    description:
      "Twórz pytania, udostępniaj je i dopasowuj się z osobą, która odpowie poprawnie. Aplikacja randkowa nowej generacji z AI.",
  },
  sv: {
    title: "Qulo — Träffas Genom Frågor | AI Dejtingapp",
    description:
      "Skapa frågor, dela dem och matcha med den som svarar rätt. AI-driven dejtingapp av nästa generation.",
  },
  hi: {
    title: "Qulo — सवालों से मिलें | AI डेटिंग ऐप",
    description:
      "सवाल बनाएं, शेयर करें, सही जवाब देने वाले से मैच करें। AI-संचालित अगली पीढ़ी का डेटिंग ऐप।",
  },
};

/** FAQ data for FAQPage structured data — Google rich snippets */
export const FAQ_DATA: Record<string, { q: string; a: string }[]> = {
  tr: [
    { q: "Qulo nasıl çalışır?", a: "Sorular hazırlarsın, diğer kullanıcılar bu soruları çözer. Tüm sorularını doğru cevaplayan kişiyle eşleşirsin. Swipe yok, quiz var!" },
    { q: "Qulo ücretsiz mi?", a: "Evet, Qulo ücretsiz olarak kullanılabilir. Ek özellikler için Plus ve Premium abonelik seçenekleri de mevcuttur." },
    { q: "Qulo diğer dating uygulamalarından ne farkı var?", a: "Qulo swipe tabanlı değil, soru-cevap tabanlı bir eşleşme sistemi kullanır. Bu sayede yüzeysel değil, derinlikli eşleşmeler oluşur." },
    { q: "Qulo güvenli mi?", a: "Evet. Verileriniz şifrelenerek korunur, profil doğrulama sistemi mevcuttur ve istenmeyen kullanıcıları engelleme özelliği vardır." },
    { q: "Hangi ülkelerde kullanılabilir?", a: "Qulo dünya genelinde kullanılabilir. 16 farklı dilde destek sunuyoruz." },
  ],
  en: [
    { q: "How does Qulo work?", a: "You create questions, other users solve them. You match with the person who answers all your questions correctly. No swiping, just quizzing!" },
    { q: "Is Qulo free?", a: "Yes, Qulo is free to use. Plus and Premium subscription options are available for additional features." },
    { q: "How is Qulo different from other dating apps?", a: "Qulo uses a question-and-answer matching system instead of swiping. This creates deeper, more meaningful matches." },
    { q: "Is Qulo safe?", a: "Yes. Your data is encrypted, profile verification is available, and you can block unwanted users." },
    { q: "Which countries is Qulo available in?", a: "Qulo is available worldwide. We support 16 different languages." },
  ],
  de: [
    { q: "Wie funktioniert Qulo?", a: "Du erstellst Fragen, andere Nutzer lösen sie. Du matchst mit der Person, die alle deine Fragen richtig beantwortet. Kein Swipen, nur Quizzen!" },
    { q: "Ist Qulo kostenlos?", a: "Ja, Qulo ist kostenlos nutzbar. Für zusätzliche Funktionen gibt es Plus- und Premium-Abonnements." },
    { q: "Was unterscheidet Qulo von anderen Dating-Apps?", a: "Qulo nutzt ein Frage-Antwort-System statt Swipen. So entstehen tiefere, bedeutungsvollere Matches." },
    { q: "Ist Qulo sicher?", a: "Ja. Deine Daten werden verschlüsselt, Profilverifizierung ist verfügbar und du kannst unerwünschte Nutzer blockieren." },
    { q: "In welchen Ländern ist Qulo verfügbar?", a: "Qulo ist weltweit verfügbar. Wir unterstützen 16 verschiedene Sprachen." },
  ],
  fr: [
    { q: "Comment fonctionne Qulo ?", a: "Vous créez des questions, d'autres utilisateurs les résolvent. Vous matchez avec la personne qui répond correctement à toutes vos questions. Pas de swipe, juste du quiz !" },
    { q: "Qulo est-il gratuit ?", a: "Oui, Qulo est gratuit. Des abonnements Plus et Premium sont disponibles pour des fonctionnalités supplémentaires." },
    { q: "Qulo est-il sûr ?", a: "Oui. Vos données sont chiffrées, la vérification de profil est disponible et vous pouvez bloquer les utilisateurs indésirables." },
  ],
  es: [
    { q: "¿Cómo funciona Qulo?", a: "Creas preguntas, otros usuarios las resuelven. Haces match con quien responda correctamente a todas tus preguntas. ¡Sin deslizar, solo cuestionarios!" },
    { q: "¿Es Qulo gratis?", a: "Sí, Qulo es gratuito. Hay suscripciones Plus y Premium para funciones adicionales." },
    { q: "¿Es Qulo seguro?", a: "Sí. Tus datos están encriptados, la verificación de perfil está disponible y puedes bloquear usuarios no deseados." },
  ],
  ar: [
    { q: "كيف يعمل Qulo؟", a: "تنشئ أسئلة، ويحلها المستخدمون الآخرون. تتطابق مع الشخص الذي يجيب على جميع أسئلتك بشكل صحيح. لا تمرير، فقط اختبارات!" },
    { q: "هل Qulo مجاني؟", a: "نعم، Qulo مجاني. تتوفر اشتراكات Plus وPremium لميزات إضافية." },
  ],
  ja: [
    { q: "Quloはどう使いますか？", a: "質問を作成し、他のユーザーが解きます。すべての質問に正しく答えた人とマッチします。スワイプなし、クイズだけ！" },
    { q: "Quloは無料ですか？", a: "はい、Quloは無料で利用できます。追加機能にはPlusとPremiumのサブスクリプションがあります。" },
  ],
  ko: [
    { q: "Qulo는 어떻게 작동하나요?", a: "질문을 만들고 다른 사용자가 풀어요. 모든 질문에 정확하게 답한 사람과 매칭됩니다. 스와이프 없이, 퀴즈로!" },
    { q: "Qulo는 무료인가요?", a: "네, Qulo는 무료입니다. 추가 기능을 위한 Plus 및 Premium 구독이 있습니다." },
  ],
  zh: [
    { q: "Qulo如何运作？", a: "你创建问题，其他用户来解答。与正确回答你所有问题的人匹配。没有滑动，只有问答！" },
    { q: "Qulo免费吗？", a: "是的，Qulo免费使用。还有Plus和Premium订阅提供额外功能。" },
  ],
  ru: [
    { q: "Как работает Qulo?", a: "Вы создаёте вопросы, другие пользователи их решают. Вы матчитесь с тем, кто правильно ответит на все ваши вопросы. Никаких свайпов, только викторины!" },
    { q: "Qulo бесплатный?", a: "Да, Qulo можно использовать бесплатно. Для дополнительных функций доступны подписки Plus и Premium." },
  ],
  pt: [
    { q: "Como o Qulo funciona?", a: "Você cria perguntas, outros usuários resolvem. Você combina com quem responder corretamente a todas as suas perguntas. Sem deslizar, só quiz!" },
    { q: "O Qulo é grátis?", a: "Sim, o Qulo é gratuito. Assinaturas Plus e Premium estão disponíveis para recursos adicionais." },
  ],
  it: [
    { q: "Come funziona Qulo?", a: "Crei domande, altri utenti le risolvono. Fai match con chi risponde correttamente a tutte le tue domande. Niente swipe, solo quiz!" },
    { q: "Qulo è gratuito?", a: "Sì, Qulo è gratuito. Sono disponibili abbonamenti Plus e Premium per funzionalità aggiuntive." },
  ],
};

/** Per-page SEO metadata for sub-pages */
export const PAGE_SEO: Record<string, Record<string, { title: string; description: string }>> = {
  privacy: {
    tr: { title: "Gizlilik Politikası — Qulo", description: "Qulo gizlilik politikası. Verilerinizin nasıl toplandığını, kullanıldığını ve korunduğunu öğrenin." },
    en: { title: "Privacy Policy — Qulo", description: "Qulo privacy policy. Learn how your data is collected, used, and protected." },
    de: { title: "Datenschutzrichtlinie — Qulo", description: "Qulo Datenschutzrichtlinie. Erfahren Sie, wie Ihre Daten erhoben, verwendet und geschützt werden." },
    fr: { title: "Politique de Confidentialité — Qulo", description: "Politique de confidentialité de Qulo. Découvrez comment vos données sont collectées, utilisées et protégées." },
    es: { title: "Política de Privacidad — Qulo", description: "Política de privacidad de Qulo. Descubre cómo se recopilan, usan y protegen tus datos." },
    ar: { title: "سياسة الخصوصية — Qulo", description: "سياسة خصوصية Qulo. تعرف على كيفية جمع بياناتك واستخدامها وحمايتها." },
    ja: { title: "プライバシーポリシー — Qulo", description: "Quloのプライバシーポリシー。データの収集、使用、保護について。" },
    ko: { title: "개인정보 처리방침 — Qulo", description: "Qulo 개인정보 처리방침. 데이터 수집, 사용 및 보호에 대해 알아보세요." },
    zh: { title: "隐私政策 — Qulo", description: "Qulo隐私政策。了解您的数据如何被收集、使用和保护。" },
    ru: { title: "Политика конфиденциальности — Qulo", description: "Политика конфиденциальности Qulo. Узнайте, как собираются, используются и защищаются ваши данные." },
    pt: { title: "Política de Privacidade — Qulo", description: "Política de privacidade do Qulo. Saiba como seus dados são coletados, usados e protegidos." },
    it: { title: "Informativa sulla Privacy — Qulo", description: "Informativa sulla privacy di Qulo. Scopri come vengono raccolti, utilizzati e protetti i tuoi dati." },
  },
  terms: {
    tr: { title: "Kullanım Koşulları — Qulo", description: "Qulo kullanım koşulları ve hizmet şartları. Uygulamayı kullanmadan önce okuyun." },
    en: { title: "Terms of Service — Qulo", description: "Qulo terms of service. Read before using the app." },
    de: { title: "Nutzungsbedingungen — Qulo", description: "Qulo Nutzungsbedingungen. Bitte lesen Sie diese vor der Nutzung der App." },
    fr: { title: "Conditions d'Utilisation — Qulo", description: "Conditions d'utilisation de Qulo. Lisez avant d'utiliser l'application." },
    es: { title: "Términos de Servicio — Qulo", description: "Términos de servicio de Qulo. Lee antes de usar la aplicación." },
    ar: { title: "شروط الاستخدام — Qulo", description: "شروط خدمة Qulo. اقرأها قبل استخدام التطبيق." },
    ja: { title: "利用規約 — Qulo", description: "Quloの利用規約。アプリを使用する前にお読みください。" },
    ko: { title: "이용약관 — Qulo", description: "Qulo 이용약관. 앱 사용 전 읽어주세요." },
    zh: { title: "服务条款 — Qulo", description: "Qulo服务条款。使用应用前请阅读。" },
    ru: { title: "Условия использования — Qulo", description: "Условия использования Qulo. Прочтите перед использованием приложения." },
    pt: { title: "Termos de Serviço — Qulo", description: "Termos de serviço do Qulo. Leia antes de usar o aplicativo." },
    it: { title: "Termini di Servizio — Qulo", description: "Termini di servizio di Qulo. Leggere prima di utilizzare l'app." },
  },
  help: {
    tr: { title: "Yardım & SSS — Qulo", description: "Qulo hakkında sık sorulan sorular ve yardım merkezi. Nasıl çalışır, hesap yönetimi ve daha fazlası." },
    en: { title: "Help & FAQ — Qulo", description: "Frequently asked questions and help center for Qulo. How it works, account management and more." },
    de: { title: "Hilfe & FAQ — Qulo", description: "Häufig gestellte Fragen und Hilfezentrum für Qulo." },
    fr: { title: "Aide & FAQ — Qulo", description: "Questions fréquemment posées et centre d'aide pour Qulo." },
    es: { title: "Ayuda y Preguntas Frecuentes — Qulo", description: "Preguntas frecuentes y centro de ayuda de Qulo." },
  },
  blog: {
    tr: { title: "Blog — Qulo | Dating, İlişkiler ve Uyumluluk", description: "Qulo blog: dating trendleri, ilişki ipuçları, swipe yorgunluğu, quiz dating ve daha fazlası." },
    en: { title: "Blog — Qulo | Dating, Relationships & Compatibility", description: "Qulo blog: dating trends, relationship tips, swipe fatigue, quiz dating and more." },
    de: { title: "Blog — Qulo | Dating, Beziehungen & Kompatibilität", description: "Qulo Blog: Dating-Trends, Beziehungstipps und mehr." },
    fr: { title: "Blog — Qulo | Dating, Relations & Compatibilité", description: "Blog Qulo : tendances dating, conseils relations et plus." },
    es: { title: "Blog — Qulo | Citas, Relaciones y Compatibilidad", description: "Blog Qulo: tendencias de citas, consejos de relaciones y más." },
    ar: { title: "مدونة — Qulo | المواعدة والعلاقات", description: "مدونة Qulo: اتجاهات المواعدة ونصائح العلاقات والمزيد." },
    ja: { title: "ブログ — Qulo | デート・恋愛・相性", description: "Quloブログ：デートトレンド、恋愛のヒントなど。" },
    ko: { title: "블로그 — Qulo | 데이팅, 관계 & 호환성", description: "Qulo 블로그: 데이팅 트렌드, 관계 팁 등." },
    zh: { title: "博客 — Qulo | 约会、关系与兼容性", description: "Qulo博客：约会趋势、关系建议等。" },
    ru: { title: "Блог — Qulo | Свидания, Отношения и Совместимость", description: "Блог Qulo: тренды знакомств, советы по отношениям и многое другое." },
    pt: { title: "Blog — Qulo | Namoro, Relacionamentos e Compatibilidade", description: "Blog Qulo: tendências de namoro, dicas de relacionamento e mais." },
    it: { title: "Blog — Qulo | Incontri, Relazioni e Compatibilità", description: "Blog Qulo: tendenze degli incontri, consigli sulle relazioni e altro." },
    nl: { title: "Blog — Qulo | Dating, Relaties & Compatibiliteit", description: "Qulo Blog: datingtrends, relatietips en meer." },
    pl: { title: "Blog — Qulo | Randki, Związki i Kompatybilność", description: "Blog Qulo: trendy randkowe, porady dotyczące związków i więcej." },
    sv: { title: "Blogg — Qulo | Dejting, Relationer & Kompatibilitet", description: "Qulo Blogg: dejtingtrender, relationstips och mer." },
    hi: { title: "ब्लॉग — Qulo | डेटिंग, रिश्ते और अनुकूलता", description: "Qulo ब्लॉग: डेटिंग ट्रेंड, रिश्ते की सलाह और बहुत कुछ।" },
  },
  dating: {
    tr: { title: "Sehirlerde Dating — Qulo", description: "Dunyanin en buyuk sehirlerinde Qulo ile tanisin. Sorularla eslesin, anlamli baglantilar kurun." },
    en: { title: "Dating in Cities — Qulo", description: "Meet people with Qulo in the world's biggest cities. Match through questions, build meaningful connections." },
    de: { title: "Dating in Stadten — Qulo", description: "Treffen Sie Menschen mit Qulo in den grossten Stadten der Welt. Matchen Sie durch Fragen." },
    fr: { title: "Dating dans les villes — Qulo", description: "Rencontrez des gens avec Qulo dans les plus grandes villes du monde. Matchez par questions." },
    es: { title: "Citas en ciudades — Qulo", description: "Conoce gente con Qulo en las ciudades mas grandes del mundo. Haz match con preguntas." },
    ar: { title: "المواعدة في المدن — Qulo", description: "تعرف على أشخاص مع Qulo في أكبر مدن العالم. تطابق من خلال الأسئلة." },
    ru: { title: "Знакомства в городах — Qulo", description: "Встречайте людей с Qulo в крупнейших городах мира. Знакомьтесь через вопросы." },
    pt: { title: "Namoro em cidades — Qulo", description: "Conheca pessoas com Qulo nas maiores cidades do mundo. Combine por perguntas." },
    it: { title: "Incontri nelle citta — Qulo", description: "Incontra persone con Qulo nelle piu grandi citta del mondo. Fai match con domande." },
    ja: { title: "都市でデート — Qulo", description: "世界の大都市でQuloと出会いましょう。質問でマッチング。" },
    ko: { title: "도시에서 데이팅 — Qulo", description: "세계 최대 도시에서 Qulo로 사람들을 만나세요. 질문으로 매칭." },
    zh: { title: "城市约会 — Qulo", description: "在世界最大的城市用Qulo认识人。通过问题匹配。" },
    nl: { title: "Dating in steden — Qulo", description: "Ontmoet mensen met Qulo in de grootste steden ter wereld. Match via vragen." },
    pl: { title: "Randki w miastach — Qulo", description: "Poznaj ludzi z Qulo w najwiekszych miastach swiata. Dopasowuj sie przez pytania." },
    sv: { title: "Dejting i stader — Qulo", description: "Traffa manniskor med Qulo i varldens storsta stader. Matcha genom fragor." },
    hi: { title: "शहरों में डेटिंग — Qulo", description: "दुनिया के सबसे बड़े शहरों में Qulo से लोगों से मिलें। सवालों से मैच करें।" },
  },
  features: {
    tr: { title: "Ozellikler — Qulo | Quiz Dating App", description: "Qulo'nun benzersiz ozellikleri: quiz dating, kisilik eslestirme, AI soru onerileri ve daha fazlasi." },
    en: { title: "Features — Qulo | Quiz Dating App", description: "Qulo's unique features: quiz dating, personality matching, AI question suggestions and more." },
    de: { title: "Funktionen — Qulo | Quiz Dating App", description: "Qulos einzigartige Funktionen: Quiz-Dating, Personlichkeits-Matching, KI-Fragenvorschlage und mehr." },
    fr: { title: "Fonctionnalites — Qulo | Quiz Dating App", description: "Les fonctionnalites uniques de Qulo : quiz dating, matching de personnalite, suggestions de questions IA et plus." },
    es: { title: "Caracteristicas — Qulo | Quiz Dating App", description: "Caracteristicas unicas de Qulo: quiz dating, matching de personalidad, sugerencias de preguntas con IA y mas." },
  },
  compare: {
    tr: { title: "Karsilastirmalar — Qulo vs Digerleri", description: "Qulo'yu Tinder, Bumble ve Hinge ile karsilastirin. Hangisi sizin icin daha uygun?" },
    en: { title: "Comparisons — Qulo vs Others", description: "Compare Qulo with Tinder, Bumble and Hinge. Which one is right for you?" },
    de: { title: "Vergleiche — Qulo vs Andere", description: "Vergleichen Sie Qulo mit Tinder, Bumble und Hinge. Welche passt zu Ihnen?" },
    fr: { title: "Comparaisons — Qulo vs Autres", description: "Comparez Qulo avec Tinder, Bumble et Hinge. Lequel vous convient ?" },
    es: { title: "Comparaciones — Qulo vs Otros", description: "Compara Qulo con Tinder, Bumble y Hinge. Cual es mejor para ti?" },
    ar: { title: "المقارنات — Qulo مقابل الآخرين", description: "قارن Qulo مع Tinder و Bumble و Hinge. أيهما أنسب لك؟" },
    ja: { title: "比較 — Qulo vs 他のアプリ", description: "QuloをTinder、Bumble、Hingeと比較。どれがあなたに合っていますか？" },
    ko: { title: "비교 — Qulo vs 다른 앱", description: "Qulo를 Tinder, Bumble, Hinge와 비교하세요. 어떤 것이 맞을까요?" },
    zh: { title: "对比 — Qulo vs 其他应用", description: "将Qulo与Tinder、Bumble和Hinge进行比较。哪个适合你？" },
    ru: { title: "Сравнения — Qulo vs Другие", description: "Сравните Qulo с Tinder, Bumble и Hinge. Что подходит вам?" },
    pt: { title: "Comparacoes — Qulo vs Outros", description: "Compare o Qulo com Tinder, Bumble e Hinge. Qual e o melhor para voce?" },
    it: { title: "Confronti — Qulo vs Altri", description: "Confronta Qulo con Tinder, Bumble e Hinge. Quale fa per te?" },
    nl: { title: "Vergelijkingen — Qulo vs Anderen", description: "Vergelijk Qulo met Tinder, Bumble en Hinge. Welke past bij jou?" },
    pl: { title: "Porownania — Qulo vs Inne", description: "Porownaj Qulo z Tinder, Bumble i Hinge. Ktora jest dla Ciebie?" },
    sv: { title: "Jamforelser — Qulo vs Andra", description: "Jamfor Qulo med Tinder, Bumble och Hinge. Vilken passar dig?" },
    hi: { title: "तुलना — Qulo vs अन्य", description: "Qulo की Tinder, Bumble और Hinge से तुलना करें। कौन सा आपके लिए सही है?" },
  },
  glossary: {
    tr: { title: "Dating S\u00F6zl\u00FC\u011F\u00FC \u2014 A'dan Z'ye Dating Terimleri | Qulo", description: "Ghosting, catfishing, swipe fatigue ve daha fazlas\u0131. Online dating d\u00FCnyas\u0131n\u0131n t\u00FCm terimlerini \u00F6\u011Frenin." },
    en: { title: "Dating Glossary \u2014 A to Z Dating Terms | Qulo", description: "Ghosting, catfishing, swipe fatigue and more. Learn all the terms of the online dating world." },
    de: { title: "Dating-Glossar \u2014 Dating-Begriffe von A bis Z | Qulo", description: "Ghosting, Catfishing, Swipe-M\u00FCdigkeit und mehr. Lernen Sie alle Begriffe der Online-Dating-Welt." },
    fr: { title: "Glossaire du Dating \u2014 Termes de A \u00E0 Z | Qulo", description: "Ghosting, catfishing, fatigue du swipe et plus encore. D\u00E9couvrez tous les termes du dating en ligne." },
    es: { title: "Glosario de Citas \u2014 T\u00E9rminos de la A a la Z | Qulo", description: "Ghosting, catfishing, cansancio del swipe y m\u00E1s. Aprende todos los t\u00E9rminos del mundo de las citas online." },
    ar: { title: "\u0642\u0627\u0645\u0648\u0633 \u0627\u0644\u0645\u0648\u0627\u0639\u062F\u0629 \u2014 \u0645\u0635\u0637\u0644\u062D\u0627\u062A \u0645\u0646 \u0627\u0644\u0623\u0644\u0641 \u0625\u0644\u0649 \u0627\u0644\u064A\u0627\u0621 | Qulo", description: "Ghosting \u0648catfishing \u0648\u0625\u0631\u0647\u0627\u0642 \u0627\u0644\u062A\u0645\u0631\u064A\u0631 \u0648\u0627\u0644\u0645\u0632\u064A\u062F. \u062A\u0639\u0644\u0645 \u062C\u0645\u064A\u0639 \u0645\u0635\u0637\u0644\u062D\u0627\u062A \u0639\u0627\u0644\u0645 \u0627\u0644\u0645\u0648\u0627\u0639\u062F\u0629." },
    ja: { title: "\u30C7\u30FC\u30C8\u7528\u8A9E\u96C6 \u2014 A\u304B\u3089Z\u307E\u3067\u306E\u30C7\u30FC\u30C8\u7528\u8A9E | Qulo", description: "\u30B4\u30FC\u30B9\u30C6\u30A3\u30F3\u30B0\u3001\u30AD\u30E3\u30C3\u30C8\u30D5\u30A3\u30C3\u30B7\u30F3\u30B0\u306A\u3069\u3002\u30AA\u30F3\u30E9\u30A4\u30F3\u30C7\u30FC\u30C8\u306E\u5168\u7528\u8A9E\u3092\u5B66\u3073\u307E\u3057\u3087\u3046\u3002" },
    ko: { title: "\uB370\uC774\uD305 \uC6A9\uC5B4\uC9D1 \u2014 A\uBD80\uD130 Z\uAE4C\uC9C0 | Qulo", description: "\uACE0\uC2A4\uD305, \uCEBF\uD53C\uC2DC\uADF8 \uB4F1. \uC628\uB77C\uC778 \uB370\uC774\uD305 \uC138\uACC4\uC758 \uBAA8\uB4E0 \uC6A9\uC5B4\uB97C \uBC30\uC6B0\uC138\uC694." },
    zh: { title: "\u7EA6\u4F1A\u672F\u8BED\u8868 \u2014 A\u5230Z\u7EA6\u4F1A\u672F\u8BED | Qulo", description: "Ghosting\u3001catfishing\u3001\u6ED1\u52A8\u75B2\u52B3\u7B49\u3002\u5B66\u4E60\u5728\u7EBF\u7EA6\u4F1A\u4E16\u754C\u7684\u6240\u6709\u672F\u8BED\u3002" },
    ru: { title: "\u0413\u043B\u043E\u0441\u0441\u0430\u0440\u0438\u0439 \u0437\u043D\u0430\u043A\u043E\u043C\u0441\u0442\u0432 \u2014 \u0422\u0435\u0440\u043C\u0438\u043D\u044B \u043E\u0442 \u0410 \u0434\u043E \u042F | Qulo", description: "\u0413\u043E\u0441\u0442\u0438\u043D\u0433, \u043A\u044D\u0442\u0444\u0438\u0448\u0438\u043D\u0433, \u0443\u0441\u0442\u0430\u043B\u043E\u0441\u0442\u044C \u043E\u0442 \u0441\u0432\u0430\u0439\u043F\u043E\u0432 \u0438 \u043C\u043D\u043E\u0433\u043E\u0435 \u0434\u0440\u0443\u0433\u043E\u0435." },
    pt: { title: "Gloss\u00E1rio de Namoro \u2014 Termos de A a Z | Qulo", description: "Ghosting, catfishing, fadiga do swipe e mais. Aprenda todos os termos do mundo do namoro online." },
    it: { title: "Glossario del Dating \u2014 Termini dalla A alla Z | Qulo", description: "Ghosting, catfishing, stanchezza da swipe e altro. Scopri tutti i termini del mondo degli incontri online." },
    nl: { title: "Dating Woordenlijst \u2014 Dating Termen van A tot Z | Qulo", description: "Ghosting, catfishing, swipe-moeheid en meer. Leer alle termen van de online datingwereld." },
    pl: { title: "S\u0142owniczek Randkowy \u2014 Terminy od A do Z | Qulo", description: "Ghosting, catfishing, zm\u0119czenie swipe'owaniem i wi\u0119cej. Poznaj wszystkie terminy \u015Bwiata randk\u00F3w online." },
    sv: { title: "Dejting Ordlista \u2014 Dejtingtermer fr\u00E5n A till \u00D6 | Qulo", description: "Ghosting, catfishing, swipe-tr\u00F6tthet och mer. L\u00E4r dig alla termer i online-dejtingv\u00E4rlden." },
    hi: { title: "\u0921\u0947\u091F\u093F\u0902\u0917 \u0936\u092C\u094D\u0926\u093E\u0935\u0932\u0940 \u2014 A \u0938\u0947 Z \u0924\u0915 \u0921\u0947\u091F\u093F\u0902\u0917 \u0936\u092C\u094D\u0926 | Qulo", description: "\u0917\u094B\u0938\u094D\u091F\u093F\u0902\u0917, \u0915\u0948\u091F\u092B\u093F\u0936\u093F\u0902\u0917 \u0914\u0930 \u0905\u0927\u093F\u0915\u0964 \u0911\u0928\u0932\u093E\u0907\u0928 \u0921\u0947\u091F\u093F\u0902\u0917 \u0926\u0941\u0928\u093F\u092F\u093E \u0915\u0947 \u0938\u092D\u0940 \u0936\u092C\u094D\u0926 \u0938\u0940\u0916\u0947\u0902\u0964" },
  },
  about: {
    tr: { title: "Qulo Hakkında — Soru-Cevap Tabanlı Dating Uygulaması", description: "Qulo nedir? Swipe yerine soru-cevap ile eşleşen yeni nesil dating uygulaması. Quiz dating app ile tanışmanın yeni yolu." },
    en: { title: "About Qulo — Quiz-Based Dating App", description: "What is Qulo? A next-gen dating app that matches through questions instead of swiping. Discover the new way to date with a quiz dating app." },
    de: { title: "Über Qulo — Fragenbasierte Dating App", description: "Was ist Qulo? Eine Dating-App der nächsten Generation, die durch Fragen statt Swipen matcht." },
    fr: { title: "À propos de Qulo — App de rencontre par questions", description: "Qu'est-ce que Qulo ? Une app de rencontre nouvelle génération qui matche par les questions." },
    es: { title: "Sobre Qulo — App de Citas basada en Preguntas", description: "¿Qué es Qulo? Una app de citas de nueva generación que hace match a través de preguntas." },
    ar: { title: "عن Qulo — تطبيق مواعدة قائم على الأسئلة", description: "ما هو Qulo؟ تطبيق مواعدة من الجيل الجديد يطابق من خلال الأسئلة." },
    ja: { title: "Quloについて — クイズベースのマッチングアプリ", description: "Quloとは？スワイプではなく質問でマッチする次世代マッチングアプリ。" },
    ko: { title: "Qulo 소개 — 퀴즈 기반 데이팅 앱", description: "Qulo란? 스와이프 대신 질문으로 매칭하는 차세대 데이팅 앱." },
    zh: { title: "关于Qulo — 基于问答的约会应用", description: "Qulo是什么？通过问答而非滑动匹配的新一代约会应用。" },
    ru: { title: "О Qulo — Приложение для знакомств на основе вопросов", description: "Что такое Qulo? Приложение нового поколения, которое создаёт пары через вопросы." },
    pt: { title: "Sobre o Qulo — App de Namoro baseado em Perguntas", description: "O que é Qulo? Um app de namoro de nova geração que combina através de perguntas." },
    it: { title: "Chi è Qulo — App di Incontri basata su Domande", description: "Cos'è Qulo? Un'app di incontri di nuova generazione che fa match attraverso le domande." },
    nl: { title: "Over Qulo — Vragengebaseerde Dating App", description: "Wat is Qulo? Een dating app van de nieuwe generatie die matcht via vragen." },
    pl: { title: "O Qulo — Aplikacja randkowa oparta na pytaniach", description: "Czym jest Qulo? Aplikacja randkowa nowej generacji, która łączy przez pytania." },
    sv: { title: "Om Qulo — Frågebaserad Dejtingapp", description: "Vad är Qulo? En dejtingapp av nästa generation som matchar genom frågor." },
    hi: { title: "Qulo के बारे में — सवाल-आधारित डेटिंग ऐप", description: "Qulo क्या है? स्वाइप की जगह सवालों से मैच करने वाला अगली पीढ़ी का डेटिंग ऐप।" },
  },
};

/** Locale → OG locale mapping (BCP 47 → Open Graph format) */
export const OG_LOCALES: Record<string, string> = {
  tr: "tr_TR", en: "en_US", de: "de_DE", fr: "fr_FR", es: "es_ES",
  ar: "ar_SA", ru: "ru_RU", pt: "pt_BR", it: "it_IT", ja: "ja_JP",
  ko: "ko_KR", zh: "zh_CN", nl: "nl_NL", pl: "pl_PL", sv: "sv_SE",
  hi: "hi_IN",
};
