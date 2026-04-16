export interface HowToStep {
  nameKey: string;
  names: Record<string, string>;
  textKey: string;
  texts: Record<string, string>;
}

export interface HowToGuide {
  slug: string;
  emoji: string;
  publishedAt: string;
  titles: Record<string, string>;
  descriptions: Record<string, string>;
  keywords: string[];
  /** ISO 8601 duration string (e.g. "PT5M" for 5 minutes) */
  totalTime: string;
  steps: HowToStep[];
}

export const HOW_TO_GUIDES: HowToGuide[] = [
  {
    slug: "create-first-qulo-profile",
    emoji: "👤",
    publishedAt: "2026-04-16",
    titles: {
      tr: "İlk Qulo Profilinizi Nasıl Oluşturursunuz: 5 Adımda Rehber",
      en: "How to Create Your First Qulo Profile: A 5-Step Guide",
      de: "So erstellen Sie Ihr erstes Qulo-Profil: 5-Schritt-Anleitung",
      fr: "Comment créer votre premier profil Qulo : Guide en 5 étapes",
      es: "Cómo crear tu primer perfil de Qulo: Guía de 5 pasos",
    },
    descriptions: {
      tr: "Qulo'da mükemmel bir profil oluşturmanın 5 adımı. Fotoğraf seçiminden bio yazmaya kadar her şey.",
      en: "The 5 steps to creating a perfect Qulo profile. Everything from photo selection to bio writing.",
      de: "Die 5 Schritte zum perfekten Qulo-Profil.",
      fr: "Les 5 étapes pour un profil Qulo parfait.",
      es: "Los 5 pasos para un perfil de Qulo perfecto.",
    },
    keywords: [
      "how to create qulo profile",
      "qulo profil oluşturma",
      "dating profile setup",
      "how to make dating profile",
    ],
    totalTime: "PT5M",
    steps: [
      {
        nameKey: "download",
        names: {
          tr: "Qulo'yu İndirin",
          en: "Download Qulo",
          de: "Qulo herunterladen",
          fr: "Téléchargez Qulo",
          es: "Descarga Qulo",
        },
        textKey: "download_text",
        texts: {
          tr: "App Store veya Google Play'den Qulo uygulamasını ücretsiz indirin. iOS ve Android destekli.",
          en: "Download Qulo free from App Store or Google Play. Supports iOS and Android.",
          de: "Laden Sie Qulo kostenlos aus dem App Store oder Google Play herunter.",
          fr: "Téléchargez Qulo gratuitement depuis l'App Store ou Google Play.",
          es: "Descarga Qulo gratis desde App Store o Google Play.",
        },
      },
      {
        nameKey: "signup",
        names: {
          tr: "Hesap Oluşturun",
          en: "Sign Up",
          de: "Registrieren",
          fr: "Inscrivez-vous",
          es: "Regístrate",
        },
        textKey: "signup_text",
        texts: {
          tr: "Email veya Apple/Google ile hızlıca kaydolun. Yaş ve cinsiyet bilgilerinizi girin.",
          en: "Sign up quickly with email or Apple/Google. Enter your age and gender.",
          de: "Schnell mit E-Mail oder Apple/Google registrieren.",
          fr: "Inscrivez-vous rapidement avec email ou Apple/Google.",
          es: "Regístrate rápidamente con email o Apple/Google.",
        },
      },
      {
        nameKey: "photos",
        names: {
          tr: "Fotoğraflarınızı Yükleyin",
          en: "Upload Your Photos",
          de: "Fotos hochladen",
          fr: "Téléchargez vos photos",
          es: "Sube tus fotos",
        },
        textKey: "photos_text",
        texts: {
          tr: "En az 3, en fazla 6 fotoğraf yükleyin. Net yüz fotoğrafı, çeşitli aktivite fotoğrafları tercih edin.",
          en: "Upload between 3-6 photos. Use clear face photos and varied activity shots.",
          de: "Laden Sie 3-6 Fotos hoch. Verwenden Sie klare Gesichtsfotos.",
          fr: "Téléchargez 3-6 photos. Utilisez des photos de visage claires.",
          es: "Sube 3-6 fotos. Usa fotos de cara claras.",
        },
      },
      {
        nameKey: "bio",
        names: {
          tr: "Bio Yazın",
          en: "Write Your Bio",
          de: "Bio schreiben",
          fr: "Écrivez votre bio",
          es: "Escribe tu bio",
        },
        textKey: "bio_text",
        texts: {
          tr: "150-300 karakter arası samimi bir bio yazın. İlgi alanlarınızı, hayat tarzınızı yansıtın.",
          en: "Write a sincere 150-300 character bio. Reflect your interests and lifestyle.",
          de: "Schreiben Sie eine ehrliche 150-300 Zeichen Bio.",
          fr: "Écrivez une bio sincère de 150-300 caractères.",
          es: "Escribe una bio sincera de 150-300 caracteres.",
        },
      },
      {
        nameKey: "questions",
        names: {
          tr: "İlk Sorularınızı Hazırlayın",
          en: "Create Your First Questions",
          de: "Erste Fragen erstellen",
          fr: "Créez vos premières questions",
          es: "Crea tus primeras preguntas",
        },
        textKey: "questions_text",
        texts: {
          tr: "2-10 soru hazırlayın. Kişiliğinizi yansıtan sorular eşleşme kaliteniz için kritik.",
          en: "Create 2-10 questions. Questions that reflect your personality are critical for match quality.",
          de: "Erstellen Sie 2-10 Fragen.",
          fr: "Créez 2-10 questions.",
          es: "Crea 2-10 preguntas.",
        },
      },
    ],
  },
  {
    slug: "write-great-questions",
    emoji: "❓",
    publishedAt: "2026-04-16",
    titles: {
      tr: "Harika Qulo Soruları Nasıl Yazılır: 5 Adım",
      en: "How to Write Great Qulo Questions: 5 Steps",
      de: "So schreiben Sie großartige Qulo-Fragen: 5 Schritte",
      fr: "Comment écrire de super questions Qulo : 5 étapes",
      es: "Cómo escribir excelentes preguntas en Qulo: 5 pasos",
    },
    descriptions: {
      tr: "Eşleşme kaliteni artıracak soru yazma sanatı. Basit formül + örnekler + yaygın hatalar.",
      en: "The art of writing questions that improve match quality. Simple formula + examples + common mistakes.",
      de: "Die Kunst, Fragen zu schreiben, die die Match-Qualität verbessern.",
      fr: "L'art d'écrire des questions qui améliorent la qualité des matchs.",
      es: "El arte de escribir preguntas que mejoran la calidad del match.",
    },
    keywords: [
      "how to write dating questions",
      "qulo soru yazma",
      "good dating questions",
      "quiz dating questions",
    ],
    totalTime: "PT10M",
    steps: [
      {
        nameKey: "choose_topic",
        names: {
          tr: "Konu Seçin",
          en: "Choose a Topic",
          de: "Thema wählen",
          fr: "Choisissez un sujet",
          es: "Elige un tema",
        },
        textKey: "choose_topic_text",
        texts: {
          tr: "Müzik, film, yaşam felsefesi, seyahat, mizah — ilginizi çeken çeşitli konulardan başlayın.",
          en: "Music, movies, life philosophy, travel, humor — start with varied topics you're interested in.",
          de: "Musik, Filme, Lebensphilosophie, Reisen, Humor — beginnen Sie mit vielfältigen Themen.",
          fr: "Musique, cinéma, philosophie de vie, voyages, humour — commencez par des sujets variés.",
          es: "Música, películas, filosofía de vida, viajes, humor — empieza con temas variados.",
        },
      },
      {
        nameKey: "balance",
        names: {
          tr: "Zorluk Dengesi",
          en: "Balance Difficulty",
          de: "Schwierigkeit ausbalancieren",
          fr: "Équilibrez la difficulté",
          es: "Equilibra dificultad",
        },
        textKey: "balance_text",
        texts: {
          tr: "Ne çok kolay (herkes bilir) ne de çok zor (kimse bilemez) olsun. Orta zorluk optimum.",
          en: "Not too easy (everyone knows) or too hard (no one can answer). Medium difficulty is optimal.",
          de: "Weder zu einfach noch zu schwer. Mittelschwere Fragen sind optimal.",
          fr: "Ni trop facile ni trop difficile. La difficulté moyenne est optimale.",
          es: "Ni muy fácil ni muy difícil. La dificultad media es óptima.",
        },
      },
      {
        nameKey: "be_specific",
        names: {
          tr: "Spesifik Olun",
          en: "Be Specific",
          de: "Seien Sie spezifisch",
          fr: "Soyez spécifique",
          es: "Sé específico",
        },
        textKey: "be_specific_text",
        texts: {
          tr: "'En sevdiğim film nedir?' yerine '2020 sonrası en sevdiğim 3 filmden hangisini 3 kez izledim?' gibi.",
          en: "Instead of 'What's my favorite movie?' try 'Which movie from post-2020 did I watch 3 times?'",
          de: "Statt 'Was ist mein Lieblingsfilm?' fragen Sie spezifischer.",
          fr: "Au lieu de 'quel est mon film préféré?' soyez spécifique.",
          es: "En lugar de '¿cuál es mi película favorita?' sé específico.",
        },
      },
      {
        nameKey: "avoid_taboo",
        names: {
          tr: "Tabularden Kaçının",
          en: "Avoid Taboos",
          de: "Vermeiden Sie Tabus",
          fr: "Évitez les tabous",
          es: "Evita los tabús",
        },
        textKey: "avoid_taboo_text",
        texts: {
          tr: "Politika, din, maaş gibi tartışmalı konulardan başlangıçta kaçının. Pozitif ve eğlenceli tutun.",
          en: "Avoid controversial topics like politics, religion, salary initially. Keep it positive and fun.",
          de: "Vermeiden Sie anfangs umstrittene Themen wie Politik, Religion, Gehalt.",
          fr: "Évitez initialement les sujets controversés comme politique, religion, salaire.",
          es: "Evita temas controvertidos como política, religión, salario al principio.",
        },
      },
      {
        nameKey: "test_refine",
        names: {
          tr: "Test Edin ve Geliştirin",
          en: "Test and Refine",
          de: "Testen und verfeinern",
          fr: "Testez et affinez",
          es: "Prueba y refina",
        },
        textKey: "test_refine_text",
        texts: {
          tr: "Sorularınızın eşleşme oranına bakın. %0 eşleşme çok zor, %50+ çok kolay demek. Dengeyi bulun.",
          en: "Check your question match rates. 0% means too hard, 50%+ means too easy. Find balance.",
          de: "Prüfen Sie die Match-Raten Ihrer Fragen.",
          fr: "Vérifiez les taux de match de vos questions.",
          es: "Verifica las tasas de match de tus preguntas.",
        },
      },
    ],
  },
  {
    slug: "get-more-matches",
    emoji: "💕",
    publishedAt: "2026-04-16",
    titles: {
      tr: "Qulo'da Daha Fazla Eşleşme Nasıl Alınır: 5 Strateji",
      en: "How to Get More Matches on Qulo: 5 Proven Strategies",
      de: "Wie Sie mehr Matches auf Qulo bekommen: 5 Strategien",
      fr: "Comment obtenir plus de matchs sur Qulo : 5 stratégies",
      es: "Cómo obtener más matches en Qulo: 5 estrategias",
    },
    descriptions: {
      tr: "Eşleşme sayınızı artırmak için kanıtlanmış stratejiler. Profil optimizasyonu, aktif kullanım, soru seçimi.",
      en: "Proven strategies to increase your matches. Profile optimization, active usage, question selection.",
      de: "Bewährte Strategien für mehr Matches.",
      fr: "Stratégies éprouvées pour plus de matchs.",
      es: "Estrategias probadas para más matches.",
    },
    keywords: [
      "how to get matches dating app",
      "more matches qulo",
      "dating app tips",
      "qulo eşleşme artırma",
    ],
    totalTime: "PT15M",
    steps: [
      {
        nameKey: "optimize_profile",
        names: {
          tr: "Profilinizi Optimize Edin",
          en: "Optimize Your Profile",
          de: "Profil optimieren",
          fr: "Optimisez votre profil",
          es: "Optimiza tu perfil",
        },
        textKey: "optimize_profile_text",
        texts: {
          tr: "Ana fotoğraf net olmalı. Bio'nuzda spesifik ilgi alanları olsun. Genel ifadelerden kaçının.",
          en: "Main photo should be clear. Bio should have specific interests. Avoid generic phrases.",
          de: "Hauptfoto sollte klar sein. Bio sollte spezifische Interessen haben.",
          fr: "Photo principale doit être claire. Bio doit avoir des intérêts spécifiques.",
          es: "Foto principal debe ser clara. Bio debe tener intereses específicos.",
        },
      },
      {
        nameKey: "be_active",
        names: {
          tr: "Aktif Kullanıcı Olun",
          en: "Be Active",
          de: "Aktiv sein",
          fr: "Soyez actif",
          es: "Sé activo",
        },
        textKey: "be_active_text",
        texts: {
          tr: "Haftada en az 3-4 gün uygulamayı açın. Aktif kullanıcılar algoritmada daha çok öne çıkar.",
          en: "Open the app at least 3-4 days a week. Active users rank higher in the algorithm.",
          de: "Öffnen Sie die App mindestens 3-4 Tage pro Woche.",
          fr: "Ouvrez l'app au moins 3-4 jours par semaine.",
          es: "Abre la app al menos 3-4 días por semana.",
        },
      },
      {
        nameKey: "solve_questions",
        names: {
          tr: "Soruları Çözün",
          en: "Solve Questions",
          de: "Fragen lösen",
          fr: "Résolvez les questions",
          es: "Resuelve preguntas",
        },
        textKey: "solve_questions_text",
        texts: {
          tr: "Sadece profilinizi bekleyerek değil, aktif olarak başkalarının sorularını çözerek de eşleşme alın.",
          en: "Don't just wait for matches — actively solve others' questions to create matches.",
          de: "Warten Sie nicht nur auf Matches — lösen Sie aktiv die Fragen anderer.",
          fr: "N'attendez pas les matchs — résolvez activement les questions des autres.",
          es: "No solo esperes matches — resuelve activamente las preguntas de otros.",
        },
      },
      {
        nameKey: "right_questions",
        names: {
          tr: "Doğru Soruları Seçin",
          en: "Choose Right Questions",
          de: "Richtige Fragen wählen",
          fr: "Choisissez les bonnes questions",
          es: "Elige las preguntas correctas",
        },
        textKey: "right_questions_text",
        texts: {
          tr: "Çok zor sorular eşleşme oranınızı düşürür. %20-40 arası doğru cevap oranı olan sorular ideal.",
          en: "Too-hard questions reduce match rate. Questions with 20-40% correct answer rate are ideal.",
          de: "Zu schwere Fragen reduzieren die Match-Rate.",
          fr: "Les questions trop difficiles réduisent le taux de match.",
          es: "Preguntas muy difíciles reducen la tasa de match.",
        },
      },
      {
        nameKey: "location_times",
        names: {
          tr: "Yer ve Zaman Ayarı",
          en: "Location and Time Settings",
          de: "Ort und Zeit Einstellungen",
          fr: "Réglages lieu et temps",
          es: "Configuración de ubicación y tiempo",
        },
        textKey: "location_times_text",
        texts: {
          tr: "Konumunuzu açık tutun. Akşam 19-22 arası en aktif saatlerdir, bu dilimde kullanmaya özen gösterin.",
          en: "Keep your location on. 7-10pm are the most active hours — use the app during this time.",
          de: "Halten Sie Ihren Standort an. 19-22 Uhr sind die aktivsten Zeiten.",
          fr: "Gardez votre localisation active. 19h-22h sont les heures les plus actives.",
          es: "Mantén tu ubicación activa. 19-22h son las horas más activas.",
        },
      },
    ],
  },
  {
    slug: "first-chat-tips",
    emoji: "💬",
    publishedAt: "2026-04-16",
    titles: {
      tr: "Eşleştikten Sonra İlk Sohbet Nasıl Başlar: 5 Altın Kural",
      en: "How to Start a Great First Chat After Matching: 5 Golden Rules",
      de: "Wie Sie nach dem Match einen großartigen ersten Chat starten",
      fr: "Comment démarrer un super premier chat après un match",
      es: "Cómo iniciar un gran primer chat después del match",
    },
    descriptions: {
      tr: "Eşleştikten sonraki ilk mesaj ilişkinin yönünü belirler. Etkili sohbet başlatma sanatı.",
      en: "The first message after matching sets the tone. The art of effective conversation starting.",
      de: "Die erste Nachricht nach dem Match bestimmt den Ton.",
      fr: "Le premier message après un match donne le ton.",
      es: "El primer mensaje después del match marca el tono.",
    },
    keywords: [
      "first message dating app",
      "how to start chat dating",
      "ilk mesaj dating",
      "opening line dating",
    ],
    totalTime: "PT5M",
    steps: [
      {
        nameKey: "reference_questions",
        names: {
          tr: "Sorularına Değinin",
          en: "Reference Their Questions",
          de: "Auf Fragen verweisen",
          fr: "Référencez leurs questions",
          es: "Referencia sus preguntas",
        },
        textKey: "reference_questions_text",
        texts: {
          tr: "Qulo'nun avantajı: Sorularına cevaplarından yola çıkarak kişiselleştirilmiş mesaj atın.",
          en: "Qulo's advantage: Send a personalized message based on their answers to your questions.",
          de: "Quloś Vorteil: Senden Sie eine personalisierte Nachricht.",
          fr: "L'avantage de Qulo : Envoyez un message personnalisé.",
          es: "La ventaja de Qulo: Envía un mensaje personalizado.",
        },
      },
      {
        nameKey: "avoid_generic",
        names: {
          tr: "Genel Mesajlardan Kaçının",
          en: "Avoid Generic Messages",
          de: "Vermeiden Sie Generisches",
          fr: "Évitez le générique",
          es: "Evita lo genérico",
        },
        textKey: "avoid_generic_text",
        texts: {
          tr: "'Merhaba', 'Nasılsın?' gibi genel mesajlar dikkat çekmez. Spesifik bir detay hakkında yorum yapın.",
          en: "Generic messages like 'Hi', 'How are you?' don't get attention. Comment on a specific detail.",
          de: "Generische Nachrichten ziehen keine Aufmerksamkeit an.",
          fr: "Les messages génériques n'attirent pas l'attention.",
          es: "Los mensajes genéricos no llaman la atención.",
        },
      },
      {
        nameKey: "ask_open_ended",
        names: {
          tr: "Açık Uçlu Sorular",
          en: "Ask Open-Ended Questions",
          de: "Offene Fragen stellen",
          fr: "Posez des questions ouvertes",
          es: "Haz preguntas abiertas",
        },
        textKey: "ask_open_ended_text",
        texts: {
          tr: "'Evet/hayır' soruları sohbeti öldürür. '...hakkında ne düşünüyorsun?' gibi açık uçlu sorular sor.",
          en: "'Yes/no' questions kill conversation. Ask open-ended questions like 'what do you think about...?'",
          de: "Ja/Nein-Fragen töten das Gespräch. Stellen Sie offene Fragen.",
          fr: "Les questions 'oui/non' tuent la conversation. Posez des questions ouvertes.",
          es: "Las preguntas 'sí/no' matan la conversación. Haz preguntas abiertas.",
        },
      },
      {
        nameKey: "be_authentic",
        names: {
          tr: "Kendiniz Olun",
          en: "Be Authentic",
          de: "Seien Sie authentisch",
          fr: "Soyez authentique",
          es: "Sé auténtico",
        },
        textKey: "be_authentic_text",
        texts: {
          tr: "Rol yapmayın. Doğal, samimi ve özgün olun. Karşı tarafın sizi gerçekten tanımasına izin verin.",
          en: "Don't pretend. Be natural, sincere and authentic. Let them get to know the real you.",
          de: "Seien Sie natürlich, aufrichtig und authentisch.",
          fr: "Soyez naturel, sincère et authentique.",
          es: "Sé natural, sincero y auténtico.",
        },
      },
      {
        nameKey: "suggest_meeting",
        names: {
          tr: "Tanışma Önerin",
          en: "Suggest Meeting",
          de: "Treffen vorschlagen",
          fr: "Suggérez une rencontre",
          es: "Sugiere conocerse",
        },
        textKey: "suggest_meeting_text",
        texts: {
          tr: "Birkaç günlük sohbet sonrası buluşma önerin. Mesajlaşma uzadıkça buluşma ihtimali azalır.",
          en: "Suggest meeting after a few days of chat. The longer you text, the less likely you'll meet.",
          de: "Schlagen Sie nach einigen Tagen Chat ein Treffen vor.",
          fr: "Suggérez une rencontre après quelques jours de chat.",
          es: "Sugiere conocerse después de unos días de chat.",
        },
      },
    ],
  },
];
