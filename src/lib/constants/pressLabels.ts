import type { Locale } from "@/lib/i18n/config";

/**
 * Every string on /[locale]/press.
 *
 * The page used to build its copy from ~44 `isTr ? … : …` ternaries, so
 * fourteen of the sixteen locales were served English under an `hreflang`, a
 * canonical and a JSON-LD `inLanguage` that all promised otherwise. This module
 * is the same shape as `glossaryLabels.ts` and `answerLabels.ts`: `en` first,
 * then the rest, complete for all sixteen.
 *
 * Unlike those two, the record is keyed by `Locale` rather than `string`. A
 * press page is the one page a journalist quotes verbatim, so a locale missing
 * here must be a compile error, not a silent slide into English — see
 * `pressLabelsFor` below, which throws instead of falling back.
 *
 * THE FACTS, and why they are worded the way they are. These were all wrong on
 * the page at some point; a correction that survives here has to survive in
 * sixteen languages at once:
 *
 *  - The founder is one person. Berkant Çalıkuşu is an independent developer in
 *    Istanbul who founded Qulo in 2026, builds and runs it himself, and is the
 *    data controller named in the privacy policy. No team, no funding claim, no
 *    user-count claim, and no "CEO" — the old page printed "Founder & CEO"
 *    under a bio that says there is nobody else.
 *  - The mechanic: 2 to 4 multiple-choice questions on the free plan, up to 10
 *    on a paid plan, four options each, one marked correct; a match needs every
 *    answer right; hints are a paid item. `npm run verify:claims` fails the
 *    build on any line that pairs the 2 and the 10 without naming the paid
 *    plan, so the qualifier stays in the same sentence in every language.
 *  - Platforms are iOS and Android. quloapp.com is a marketing site, and each
 *    locale says so — a journalist who reads "16 languages" next to a web
 *    address will otherwise write that there is a web app.
 *  - 16 languages is the app interface. The in-app library of suggested
 *    questions covers 10 of them, which is why the third paragraph separates
 *    the two numbers instead of letting "16 languages" stand for everything.
 *  - No identity verification, photo screening, fake-profile detection,
 *    personality measurement or AI matching is claimed, because none exists.
 *    The second paragraph states the absence of scoring positively (no
 *    percentage, no ranking, no compatibility figure) rather than implying a
 *    cleverness the app does not have.
 *  - No response-time promise. The old page advertised a reply "within 24
 *    hours" from a one-person operation, so the press-contact block now lists
 *    only the address and what it is useful for.
 *  - No press coverage is listed, because there is none.
 *
 * There is also no statistic anywhere in here. The single figure the site can
 * source (78% of dating-app users reporting burnout — Forbes Health/OnePoll,
 * 2024) would need its citation carried in the same sentence in sixteen
 * languages, and a press kit is the worst place for a number that might get
 * quoted loose from its source. Prefer none.
 */

/** The quick-facts rows, in the order the page prints them. */
export type PressFactKey =
  | "name"
  | "founded"
  | "category"
  | "platforms"
  | "price"
  | "languages"
  | "basedIn"
  | "tagline"
  | "website";

/** Logo files offered in the gallery. The paths live in the page. */
export type PressLogoKey = "purple" | "green" | "splash";

/** Internal links in the footer of the page. The hrefs live in the page. */
export type PressLinkKey = "about" | "statistics" | "blog" | "contact";

export interface PressFact {
  /** Row label, e.g. "Platforms". */
  term: string;
  /** Row value. Localized too: "2026年", "iOS、Android", "İstanbul, Türkiye". */
  value: string;
}

export interface PressLogoLabel {
  label: string;
  /** Alt text. Describes the mark, not the word "logo" twice. */
  alt: string;
}

export interface PressLabels {
  breadcrumb: string;
  eyebrow: string;
  heroTitle: string;
  heroSubtitle: string;
  quickFactsHeading: string;
  facts: Record<PressFactKey, PressFact>;
  aboutHeading: string;
  /** Three paragraphs: the mechanic, the matching condition, where it runs. */
  aboutParagraphs: string[];
  logosHeading: string;
  logosSubtitle: string;
  logos: Record<PressLogoKey, PressLogoLabel>;
  colorsHeading: string;
  colorsSubtitle: string;
  founderHeading: string;
  /** Also the JSON-LD `jobTitle`. "Founder and developer", never "CEO". */
  founderRole: string;
  founderBio: string;
  coverageHeading: string;
  coverageMessage: string;
  contactHeading: string;
  contactEmailLabel: string;
  contactTopicsLabel: string;
  contactTopics: string[];
  filesHeading: string;
  filesUsageNote: string;
  moreHeading: string;
  moreLinks: Record<PressLinkKey, string>;
  ctaHeading: string;
  ctaText: string;
}

export const PRESS_LABELS: Record<Locale, PressLabels> = {
  en: {
    breadcrumb: "Press kit",
    eyebrow: "For journalists",
    heroTitle: "Press kit",
    heroSubtitle:
      "Logos, brand colours, the facts about the app and where to write. Everything on this page is current and can be quoted as it stands.",
    quickFactsHeading: "Quick facts",
    facts: {
      name: { term: "Name", value: "Qulo" },
      founded: { term: "Founded", value: "2026" },
      category: { term: "Category", value: "Dating app built on questions" },
      platforms: { term: "Platforms", value: "iOS, Android" },
      price: { term: "Price", value: "Free, with paid plans" },
      languages: { term: "App languages", value: "16" },
      basedIn: { term: "Based in", value: "Istanbul, Turkey" },
      tagline: { term: "Tagline", value: "Meet through questions" },
      website: { term: "Website", value: "quloapp.com" },
    },
    aboutHeading: "About Qulo",
    aboutParagraphs: [
      "Qulo is a dating app where people meet by answering questions instead of swiping. On the free plan every member writes 2 to 4 multiple-choice questions about themselves, and up to 10 on a paid plan, with four options each and one marked correct.",
      "To reach you, somebody has to answer every one of those questions correctly; a single wrong answer and there is no match. Hints can be bought inside the app when a question is hard to guess. Nothing else is scored — no percentage, no ranking, no compatibility figure.",
      "Qulo runs on iOS and Android. quloapp.com is a marketing site, not a web version of the app. The interface is available in 16 languages, and the library of suggested questions inside the app covers 10 of them.",
    ],
    logosHeading: "Logos",
    logosSubtitle:
      "Click one to open the SVG in a new tab, or use the file list further down.",
    logos: {
      purple: { label: "Purple diamond", alt: "Qulo logo, purple diamond" },
      green: { label: "Green diamond", alt: "Qulo logo, green diamond" },
      splash: { label: "Splash logo", alt: "Qulo logo from the splash screen" },
    },
    colorsHeading: "Brand colours",
    colorsSubtitle:
      "The colours the app and this site are built on, with HEX and RGB values.",
    founderHeading: "Founder",
    founderRole: "Founder and developer",
    founderBio:
      "Berkant Çalıkuşu is an independent developer based in Istanbul, Turkey. He founded Qulo in 2026 and builds and runs it himself — there is no team behind it. He is also the data controller named in the privacy policy.",
    coverageHeading: "Qulo in the press",
    coverageMessage:
      "Nothing has been published about Qulo yet. When something is, it will be listed here with a link to the original.",
    contactHeading: "Press contact",
    contactEmailLabel: "Email",
    contactTopicsLabel: "What we can help with",
    contactTopics: [
      "Review request",
      "Interview",
      "How matching works",
      "Product questions",
    ],
    filesHeading: "Brand files",
    filesUsageNote:
      "Each file downloads directly. The logo may be used to illustrate coverage of Qulo; please keep its colours and proportions as they are.",
    moreHeading: "More from Qulo",
    moreLinks: {
      about: "About",
      statistics: "Dating statistics",
      blog: "Blog",
      contact: "Contact",
    },
    ctaHeading: "See how it works",
    ctaText:
      "Write a few questions and see who gets them right. Free on iOS and Android.",
  },

  tr: {
    breadcrumb: "Basın kiti",
    eyebrow: "Basın için",
    heroTitle: "Basın kiti",
    heroSubtitle:
      "Logolar, marka renkleri, uygulamayla ilgili temel bilgiler ve iletişim adresi. Bu sayfadaki her şey güncel; olduğu gibi alıntılanabilir.",
    quickFactsHeading: "Künye",
    facts: {
      name: { term: "Ad", value: "Qulo" },
      founded: { term: "Kuruluş", value: "2026" },
      category: { term: "Kategori", value: "Soru tabanlı tanışma uygulaması" },
      platforms: { term: "Platformlar", value: "iOS, Android" },
      price: { term: "Ücret", value: "Ücretsiz, ücretli planlar da var" },
      languages: { term: "Uygulama dilleri", value: "16" },
      basedIn: { term: "Merkez", value: "İstanbul, Türkiye" },
      tagline: { term: "Slogan", value: "Sorularla tanış" },
      website: { term: "Web sitesi", value: "quloapp.com" },
    },
    aboutHeading: "Qulo hakkında",
    aboutParagraphs: [
      "Qulo, insanların kaydırarak değil soru cevaplayarak tanıştığı bir uygulama. Ücretsiz planda herkes kendisi hakkında 2 ila 4 çoktan seçmeli soru yazar, ücretli planda 10'a kadar; her sorunun dört şıkkı vardır ve biri doğru olarak işaretlenir.",
      "Sana ulaşmak isteyen kişinin bu soruların hepsini doğru bilmesi gerekir; tek yanlış varsa eşleşme olmaz. Tahmin edilmesi zor bir soruda uygulama içinden ipucu satın alınabilir. Bunun dışında ölçülen bir şey yok: yüzde de yok, sıralama da, uyum puanı da.",
      "Qulo iOS ve Android'de çalışıyor. quloapp.com bir tanıtım sitesi, uygulamanın web sürümü değil. Arayüz 16 dilde; uygulama içindeki hazır soru kütüphanesi bu dillerin 10'unu kapsıyor.",
    ],
    logosHeading: "Logolar",
    logosSubtitle:
      "Tıklayınca SVG dosyası yeni sekmede açılır; dosyaların tamamı aşağıdaki listede.",
    logos: {
      purple: { label: "Mor elmas", alt: "Qulo logosu, mor elmas" },
      green: { label: "Yeşil elmas", alt: "Qulo logosu, yeşil elmas" },
      splash: { label: "Açılış logosu", alt: "Qulo'nun açılış ekranındaki logosu" },
    },
    colorsHeading: "Marka renkleri",
    colorsSubtitle:
      "Uygulamanın ve bu sitenin kurulu olduğu renkler, HEX ve RGB değerleriyle.",
    founderHeading: "Kurucu",
    founderRole: "Kurucu ve geliştirici",
    founderBio:
      "Berkant Çalıkuşu, İstanbul'da yaşayan bağımsız bir geliştirici. Qulo'yu 2026'da kurdu; uygulamayı kendisi geliştiriyor ve yürütüyor, arkasında bir ekip yok. Gizlilik politikasında adı geçen veri sorumlusu da kendisi.",
    coverageHeading: "Medyada Qulo",
    coverageMessage:
      "Qulo hakkında henüz yayımlanmış bir haber yok. Yayımlandığında burada, aslına bağlantı verilerek listelenecek.",
    contactHeading: "Basın iletişimi",
    contactEmailLabel: "E-posta",
    contactTopicsLabel: "Yardımcı olabileceğimiz konular",
    contactTopics: [
      "İnceleme talebi",
      "Röportaj",
      "Eşleşme nasıl çalışıyor",
      "Ürünle ilgili sorular",
    ],
    filesHeading: "Marka dosyaları",
    filesUsageNote:
      "Dosyalar doğrudan iniyor. Logo, Qulo'yla ilgili haberleri görselleştirmek için kullanılabilir; renklerini ve oranlarını değiştirmeden bırakın.",
    moreHeading: "Qulo'dan devamı",
    moreLinks: {
      about: "Hakkımızda",
      statistics: "Tanışma istatistikleri",
      blog: "Blog",
      contact: "İletişim",
    },
    ctaHeading: "Nasıl çalıştığını gör",
    ctaText:
      "Birkaç soru yaz, kimin doğru bildiğini gör. iOS ve Android'de ücretsiz.",
  },

  de: {
    breadcrumb: "Pressekit",
    eyebrow: "Für die Presse",
    heroTitle: "Pressekit",
    heroSubtitle:
      "Logos, Markenfarben, die Fakten zur App und die Kontaktadresse. Alles auf dieser Seite ist aktuell und darf so zitiert werden.",
    quickFactsHeading: "Kurzprofil",
    facts: {
      name: { term: "Name", value: "Qulo" },
      founded: { term: "Gegründet", value: "2026" },
      category: { term: "Kategorie", value: "Dating-App auf Fragenbasis" },
      platforms: { term: "Plattformen", value: "iOS, Android" },
      price: { term: "Preis", value: "Kostenlos, mit bezahlten Tarifen" },
      languages: { term: "Sprachen der App", value: "16" },
      basedIn: { term: "Sitz", value: "Istanbul, Türkei" },
      tagline: { term: "Slogan", value: "Kennenlernen durch Fragen" },
      website: { term: "Website", value: "quloapp.com" },
    },
    aboutHeading: "Über Qulo",
    aboutParagraphs: [
      "Qulo ist eine Dating-App, in der man sich über Fragen kennenlernt statt über Wischen. Im kostenlosen Tarif schreibt jedes Mitglied 2 bis 4 Multiple-Choice-Fragen über sich, im bezahlten bis zu 10, mit je vier Antwortmöglichkeiten, von denen eine als richtig markiert ist.",
      "Wer dich erreichen will, muss jede dieser Fragen richtig beantworten; eine falsche Antwort, und es gibt kein Match. Ist eine Frage schwer zu erraten, lassen sich in der App Hinweise kaufen. Sonst wird nichts bewertet: keine Prozentzahl, kein Ranking, kein Kompatibilitätswert.",
      "Qulo läuft auf iOS und Android. quloapp.com ist eine Infoseite, keine Webversion der App. Die Oberfläche gibt es in 16 Sprachen; die Bibliothek mit Fragenvorschlägen in der App deckt 10 davon ab.",
    ],
    logosHeading: "Logos",
    logosSubtitle:
      "Ein Klick öffnet die SVG-Datei in einem neuen Tab; alle Dateien stehen weiter unten.",
    logos: {
      purple: { label: "Lila Diamant", alt: "Qulo-Logo, lila Diamant" },
      green: { label: "Grüner Diamant", alt: "Qulo-Logo, grüner Diamant" },
      splash: { label: "Splash-Logo", alt: "Qulo-Logo vom Startbildschirm" },
    },
    colorsHeading: "Markenfarben",
    colorsSubtitle:
      "Die Farben, auf denen die App und diese Seite aufgebaut sind, mit HEX- und RGB-Werten.",
    founderHeading: "Gründer",
    founderRole: "Gründer und Entwickler",
    founderBio:
      "Berkant Çalıkuşu ist selbstständiger Entwickler in Istanbul, Türkei. Er hat Qulo 2026 gegründet und entwickelt und betreibt die App allein — ein Team gibt es nicht. Er ist zugleich der in der Datenschutzerklärung genannte Verantwortliche.",
    coverageHeading: "Qulo in den Medien",
    coverageMessage:
      "Über Qulo ist bisher nichts erschienen. Sobald es so weit ist, steht es hier — mit Link zum Original.",
    contactHeading: "Pressekontakt",
    contactEmailLabel: "E-Mail",
    contactTopicsLabel: "Wobei wir helfen können",
    contactTopics: [
      "Anfrage für einen Test",
      "Interview",
      "Wie das Matching funktioniert",
      "Fragen zum Produkt",
    ],
    filesHeading: "Markendateien",
    filesUsageNote:
      "Jede Datei lädt direkt herunter. Das Logo darf Berichte über Qulo illustrieren; bitte Farben und Proportionen unverändert lassen.",
    moreHeading: "Mehr von Qulo",
    moreLinks: {
      about: "Über uns",
      statistics: "Dating-Statistiken",
      blog: "Blog",
      contact: "Kontakt",
    },
    ctaHeading: "Sieh es dir selbst an",
    ctaText:
      "Schreib ein paar Fragen und sieh, wer sie richtig beantwortet. Kostenlos für iOS und Android.",
  },

  fr: {
    breadcrumb: "Kit presse",
    eyebrow: "Espace presse",
    heroTitle: "Kit presse",
    heroSubtitle:
      "Logos, couleurs de marque, les faits sur l'application et l'adresse de contact. Tout ce qui figure ici est à jour et citable tel quel.",
    quickFactsHeading: "L'essentiel",
    facts: {
      name: { term: "Nom", value: "Qulo" },
      founded: { term: "Création", value: "2026" },
      category: {
        term: "Catégorie",
        value: "Application de rencontre fondée sur des questions",
      },
      platforms: { term: "Plateformes", value: "iOS, Android" },
      price: { term: "Prix", value: "Gratuit, avec des formules payantes" },
      languages: { term: "Langues de l'application", value: "16" },
      basedIn: { term: "Siège", value: "Istanbul, Turquie" },
      tagline: { term: "Slogan", value: "Rencontrez par les questions" },
      website: { term: "Site web", value: "quloapp.com" },
    },
    aboutHeading: "À propos de Qulo",
    aboutParagraphs: [
      "Qulo est une application de rencontre où l'on fait connaissance en répondant à des questions plutôt qu'en swipant. Avec la formule gratuite, chaque membre écrit de 2 à 4 questions à choix multiple sur lui-même, et jusqu'à 10 avec un abonnement payant, quatre options par question dont une cochée comme correcte.",
      "Pour vous atteindre, il faut répondre juste à toutes ces questions : une seule erreur et il n'y a pas de match. Quand une question est difficile à deviner, des indices s'achètent dans l'application. Rien d'autre n'est noté : ni pourcentage, ni classement, ni score de compatibilité.",
      "Qulo fonctionne sur iOS et Android. quloapp.com est un site de présentation, pas une version web de l'application. L'interface existe en 16 langues et la bibliothèque de questions suggérées dans l'application en couvre 10.",
    ],
    logosHeading: "Logos",
    logosSubtitle:
      "Un clic ouvre le fichier SVG dans un nouvel onglet ; tous les fichiers sont listés plus bas.",
    logos: {
      purple: { label: "Diamant violet", alt: "Logo Qulo, diamant violet" },
      green: { label: "Diamant vert", alt: "Logo Qulo, diamant vert" },
      splash: {
        label: "Logo d'ouverture",
        alt: "Logo Qulo de l'écran d'ouverture",
      },
    },
    colorsHeading: "Couleurs de marque",
    colorsSubtitle:
      "Les couleurs sur lesquelles reposent l'application et ce site, avec leurs valeurs HEX et RGB.",
    founderHeading: "Fondateur",
    founderRole: "Fondateur et développeur",
    founderBio:
      "Berkant Çalıkuşu est un développeur indépendant établi à Istanbul, en Turquie. Il a fondé Qulo en 2026 ; il développe et exploite l'application seul, sans équipe derrière lui. C'est aussi le responsable de traitement indiqué dans la politique de confidentialité.",
    coverageHeading: "Qulo dans la presse",
    coverageMessage:
      "Rien n'a encore été publié sur Qulo. Dès que ce sera le cas, l'article figurera ici avec un lien vers l'original.",
    contactHeading: "Contact presse",
    contactEmailLabel: "E-mail",
    contactTopicsLabel: "Ce sur quoi nous pouvons aider",
    contactTopics: [
      "Demande de test",
      "Interview",
      "Le fonctionnement du match",
      "Questions sur le produit",
    ],
    filesHeading: "Fichiers de marque",
    filesUsageNote:
      "Chaque fichier se télécharge directement. Le logo peut illustrer un article sur Qulo ; merci d'en conserver les couleurs et les proportions.",
    moreHeading: "Plus sur Qulo",
    moreLinks: {
      about: "À propos",
      statistics: "Statistiques sur les rencontres",
      blog: "Blog",
      contact: "Contact",
    },
    ctaHeading: "Voyez par vous-même",
    ctaText:
      "Écrivez quelques questions et voyez qui trouve les bonnes réponses. Gratuit sur iOS et Android.",
  },

  es: {
    breadcrumb: "Kit de prensa",
    eyebrow: "Sala de prensa",
    heroTitle: "Kit de prensa",
    heroSubtitle:
      "Logos, colores de marca, los datos de la aplicación y la dirección de contacto. Todo lo que hay en esta página está al día y se puede citar tal cual.",
    quickFactsHeading: "Datos básicos",
    facts: {
      name: { term: "Nombre", value: "Qulo" },
      founded: { term: "Fundación", value: "2026" },
      category: {
        term: "Categoría",
        value: "App de citas basada en preguntas",
      },
      platforms: { term: "Plataformas", value: "iOS, Android" },
      price: { term: "Precio", value: "Gratis, con planes de pago" },
      languages: { term: "Idiomas de la app", value: "16" },
      basedIn: { term: "Sede", value: "Estambul, Turquía" },
      tagline: { term: "Lema", value: "Conoce a través de preguntas" },
      website: { term: "Sitio web", value: "quloapp.com" },
    },
    aboutHeading: "Sobre Qulo",
    aboutParagraphs: [
      "Qulo es una app de citas en la que la gente se conoce respondiendo preguntas en lugar de deslizando. En el plan gratuito cada persona escribe de 2 a 4 preguntas de opción múltiple sobre sí misma, y hasta 10 con un plan de pago, con cuatro opciones cada una y una marcada como correcta.",
      "Para llegar hasta ti hay que acertar todas esas preguntas: un solo fallo y no hay match. Cuando una pregunta es difícil de adivinar, dentro de la app se pueden comprar pistas. No se puntúa nada más: ni porcentajes, ni clasificaciones, ni índice de compatibilidad.",
      "Qulo funciona en iOS y Android. quloapp.com es un sitio de presentación, no una versión web de la app. La interfaz está en 16 idiomas y la biblioteca de preguntas sugeridas dentro de la app cubre 10 de ellos.",
    ],
    logosHeading: "Logos",
    logosSubtitle:
      "Al hacer clic se abre el archivo SVG en una pestaña nueva; todos los archivos están más abajo.",
    logos: {
      purple: { label: "Diamante morado", alt: "Logo de Qulo, diamante morado" },
      green: { label: "Diamante verde", alt: "Logo de Qulo, diamante verde" },
      splash: {
        label: "Logo de apertura",
        alt: "Logo de Qulo de la pantalla de apertura",
      },
    },
    colorsHeading: "Colores de marca",
    colorsSubtitle:
      "Los colores sobre los que están construidos la app y este sitio, con sus valores HEX y RGB.",
    founderHeading: "Fundador",
    founderRole: "Fundador y desarrollador",
    founderBio:
      "Berkant Çalıkuşu es un desarrollador independiente con base en Estambul, Turquía. Fundó Qulo en 2026 y la desarrolla y la gestiona él mismo: no hay ningún equipo detrás. Es también el responsable del tratamiento que figura en la política de privacidad.",
    coverageHeading: "Qulo en los medios",
    coverageMessage:
      "Todavía no se ha publicado nada sobre Qulo. Cuando ocurra, se listará aquí con un enlace al original.",
    contactHeading: "Contacto de prensa",
    contactEmailLabel: "Correo",
    contactTopicsLabel: "En qué podemos ayudar",
    contactTopics: [
      "Solicitud de prueba",
      "Entrevista",
      "Cómo funciona el match",
      "Preguntas sobre el producto",
    ],
    filesHeading: "Archivos de marca",
    filesUsageNote:
      "Cada archivo se descarga directamente. El logo puede ilustrar una información sobre Qulo; conserva sus colores y proporciones tal como están.",
    moreHeading: "Más de Qulo",
    moreLinks: {
      about: "Sobre nosotros",
      statistics: "Estadísticas de citas",
      blog: "Blog",
      contact: "Contacto",
    },
    ctaHeading: "Míralo tú mismo",
    ctaText:
      "Escribe unas cuantas preguntas y mira quién las acierta. Gratis en iOS y Android.",
  },

  ar: {
    breadcrumb: "ملف الصحافة",
    eyebrow: "للصحافة",
    heroTitle: "ملف الصحافة",
    heroSubtitle:
      "الشعارات وألوان العلامة والمعلومات الأساسية عن التطبيق وعنوان التواصل. كل ما في هذه الصفحة محدَّث ويمكن اقتباسه كما هو.",
    quickFactsHeading: "معلومات أساسية",
    facts: {
      name: { term: "الاسم", value: "Qulo" },
      founded: { term: "سنة التأسيس", value: "2026" },
      category: { term: "الفئة", value: "تطبيق مواعدة قائم على الأسئلة" },
      platforms: { term: "المنصات", value: "iOS، Android" },
      price: { term: "السعر", value: "مجاني، مع خطط مدفوعة" },
      languages: { term: "لغات التطبيق", value: "16" },
      basedIn: { term: "المقر", value: "إسطنبول، تركيا" },
      tagline: { term: "الشعار النصي", value: "تعارف من خلال الأسئلة" },
      website: { term: "الموقع", value: "quloapp.com" },
    },
    aboutHeading: "عن Qulo",
    aboutParagraphs: [
      "Qulo تطبيق مواعدة يتعارف فيه الناس بالإجابة عن الأسئلة بدل التمرير. في الخطة المجانية يكتب كل عضو عن نفسه من سؤالين إلى أربعة أسئلة اختيار من متعدد، وحتى عشرة أسئلة في خطة مدفوعة، لكل سؤال أربعة خيارات واحد منها محدَّد بوصفه الصحيح.",
      "من يريد الوصول إليك عليه أن يجيب عن هذه الأسئلة كلها إجابة صحيحة؛ خطأ واحد يعني ألا يحدث التطابق. وحين يصعب تخمين سؤال يمكن شراء تلميحات داخل التطبيق. وما عدا ذلك لا يُقاس شيء: لا نسبة مئوية ولا ترتيب ولا درجة توافق.",
      "يعمل Qulo على iOS وAndroid. أما quloapp.com فهو موقع تعريفي، وليس نسخة ويب من التطبيق. وواجهة التطبيق متاحة بـ16 لغة، ومكتبة الأسئلة المقترحة داخله تغطي 10 منها.",
    ],
    logosHeading: "الشعارات",
    logosSubtitle:
      "بالنقر يُفتح ملف SVG في تبويب جديد، وكل الملفات مدرجة في الأسفل.",
    logos: {
      purple: {
        label: "الماسة البنفسجية",
        alt: "شعار Qulo، الماسة البنفسجية",
      },
      green: { label: "الماسة الخضراء", alt: "شعار Qulo، الماسة الخضراء" },
      splash: {
        label: "شعار شاشة البدء",
        alt: "شعار Qulo على شاشة البدء",
      },
    },
    colorsHeading: "ألوان العلامة",
    colorsSubtitle:
      "الألوان التي بُني عليها التطبيق وهذا الموقع، بقيم HEX وRGB.",
    founderHeading: "المؤسس",
    founderRole: "المؤسس والمطوّر",
    founderBio:
      "Berkant Çalıkuşu مطوّر مستقل مقيم في إسطنبول بتركيا. أسّس Qulo عام 2026، وهو يطوّره ويديره بنفسه، ولا فريق خلفه. وهو أيضًا المسؤول عن البيانات المذكور في سياسة الخصوصية.",
    coverageHeading: "Qulo في الإعلام",
    coverageMessage:
      "لم يُنشر شيء عن Qulo حتى الآن. وحين يحدث ذلك سيُدرج هنا مع رابط إلى المصدر الأصلي.",
    contactHeading: "التواصل الصحفي",
    contactEmailLabel: "البريد الإلكتروني",
    contactTopicsLabel: "ما يمكننا المساعدة فيه",
    contactTopics: [
      "طلب مراجعة",
      "مقابلة",
      "كيف يحدث التطابق",
      "أسئلة عن المنتج",
    ],
    filesHeading: "ملفات العلامة",
    filesUsageNote:
      "كل ملف يُنزَّل مباشرة. ويمكن استخدام الشعار لتوضيح تغطية عن Qulo، مع الإبقاء على ألوانه ونسبه كما هي.",
    moreHeading: "المزيد من Qulo",
    moreLinks: {
      about: "من نحن",
      statistics: "إحصاءات المواعدة",
      blog: "المدونة",
      contact: "اتصل بنا",
    },
    ctaHeading: "جرّبه بنفسك",
    ctaText:
      "اكتب بضعة أسئلة وانظر من يجيب عنها إجابة صحيحة. مجاني على iOS وAndroid.",
  },

  ru: {
    breadcrumb: "Пресс-кит",
    eyebrow: "Для прессы",
    heroTitle: "Пресс-кит",
    heroSubtitle:
      "Логотипы, фирменные цвета, факты о приложении и адрес для связи. Всё на этой странице актуально и годится для прямой цитаты.",
    quickFactsHeading: "Коротко о главном",
    facts: {
      name: { term: "Название", value: "Qulo" },
      founded: { term: "Год основания", value: "2026" },
      category: {
        term: "Категория",
        value: "Приложение для знакомств на вопросах",
      },
      platforms: { term: "Платформы", value: "iOS, Android" },
      price: { term: "Цена", value: "Бесплатно, есть платные тарифы" },
      languages: { term: "Языки приложения", value: "16" },
      basedIn: { term: "Где базируется", value: "Стамбул, Турция" },
      tagline: { term: "Слоган", value: "Знакомства через вопросы" },
      website: { term: "Сайт", value: "quloapp.com" },
    },
    aboutHeading: "О Qulo",
    aboutParagraphs: [
      "Qulo — приложение для знакомств, где люди сходятся, отвечая на вопросы, а не свайпая. На бесплатном тарифе каждый пишет о себе от 2 до 4 вопросов с вариантами ответа, на платном — до 10; в каждом вопросе четыре варианта, и один отмечен как верный.",
      "Чтобы дойти до вас, человек должен ответить верно на все эти вопросы: одна ошибка — и совпадения не будет. Если вопрос трудно угадать, подсказки можно купить в приложении. Больше ничего не оценивается: ни процентов, ни рейтинга, ни показателя совместимости.",
      "Qulo работает на iOS и Android. quloapp.com — сайт-визитка, а не веб-версия приложения. Интерфейс переведён на 16 языков, а библиотека готовых вопросов внутри приложения охватывает 10 из них.",
    ],
    logosHeading: "Логотипы",
    logosSubtitle:
      "По клику файл SVG открывается в новой вкладке; все файлы перечислены ниже.",
    logos: {
      purple: {
        label: "Фиолетовый алмаз",
        alt: "Логотип Qulo, фиолетовый алмаз",
      },
      green: { label: "Зелёный алмаз", alt: "Логотип Qulo, зелёный алмаз" },
      splash: {
        label: "Логотип заставки",
        alt: "Логотип Qulo с экрана заставки",
      },
    },
    colorsHeading: "Фирменные цвета",
    colorsSubtitle:
      "Цвета, на которых построены приложение и этот сайт, со значениями HEX и RGB.",
    founderHeading: "Основатель",
    founderRole: "Основатель и разработчик",
    founderBio:
      "Berkant Çalıkuşu — независимый разработчик из Стамбула, Турция. Он основал Qulo в 2026 году и сам разрабатывает и ведёт приложение: команды за ним нет. Он же указан в политике конфиденциальности как оператор данных.",
    coverageHeading: "Qulo в СМИ",
    coverageMessage:
      "О Qulo пока ничего не выходило. Когда выйдет, публикация появится здесь со ссылкой на оригинал.",
    contactHeading: "Контакт для прессы",
    contactEmailLabel: "Почта",
    contactTopicsLabel: "С чем мы можем помочь",
    contactTopics: [
      "Запрос на обзор",
      "Интервью",
      "Как устроено совпадение",
      "Вопросы о продукте",
    ],
    filesHeading: "Файлы бренда",
    filesUsageNote:
      "Каждый файл скачивается напрямую. Логотип можно использовать в материалах о Qulo — пожалуйста, не меняйте его цвета и пропорции.",
    moreHeading: "Ещё о Qulo",
    moreLinks: {
      about: "О нас",
      statistics: "Статистика знакомств",
      blog: "Блог",
      contact: "Контакты",
    },
    ctaHeading: "Посмотрите сами",
    ctaText:
      "Напишите несколько вопросов и посмотрите, кто ответит верно. Бесплатно на iOS и Android.",
  },

  pt: {
    breadcrumb: "Kit de imprensa",
    eyebrow: "Sala de imprensa",
    heroTitle: "Kit de imprensa",
    heroSubtitle:
      "Logos, cores da marca, os dados do aplicativo e o endereço de contato. Tudo nesta página está atualizado e pode ser citado como está.",
    quickFactsHeading: "Dados básicos",
    facts: {
      name: { term: "Nome", value: "Qulo" },
      founded: { term: "Fundação", value: "2026" },
      category: {
        term: "Categoria",
        value: "App de relacionamento baseado em perguntas",
      },
      platforms: { term: "Plataformas", value: "iOS, Android" },
      price: { term: "Preço", value: "Grátis, com planos pagos" },
      languages: { term: "Idiomas do app", value: "16" },
      basedIn: { term: "Sede", value: "Istambul, Turquia" },
      tagline: { term: "Slogan", value: "Conheça através de perguntas" },
      website: { term: "Site", value: "quloapp.com" },
    },
    aboutHeading: "Sobre o Qulo",
    aboutParagraphs: [
      "O Qulo é um app de relacionamento em que as pessoas se conhecem respondendo perguntas, e não deslizando. No plano gratuito cada pessoa escreve de 2 a 4 perguntas de múltipla escolha sobre si, e até 10 num plano pago, com quatro alternativas em cada uma e a correta marcada.",
      "Para chegar até você, alguém precisa acertar todas essas perguntas: um único erro e não há match. Quando uma pergunta é difícil de adivinhar, dá para comprar dicas dentro do app. Nada além disso é pontuado: não há porcentagem, ranking nem índice de compatibilidade.",
      "O Qulo roda em iOS e Android. quloapp.com é um site de apresentação, não uma versão web do app. A interface está em 16 idiomas e a biblioteca de perguntas sugeridas dentro do app cobre 10 deles.",
    ],
    logosHeading: "Logos",
    logosSubtitle:
      "Um clique abre o arquivo SVG em uma nova aba; todos os arquivos estão listados abaixo.",
    logos: {
      purple: { label: "Diamante roxo", alt: "Logo do Qulo, diamante roxo" },
      green: { label: "Diamante verde", alt: "Logo do Qulo, diamante verde" },
      splash: {
        label: "Logo de abertura",
        alt: "Logo do Qulo da tela de abertura",
      },
    },
    colorsHeading: "Cores da marca",
    colorsSubtitle:
      "As cores sobre as quais o app e este site foram construídos, com valores HEX e RGB.",
    founderHeading: "Fundador",
    founderRole: "Fundador e desenvolvedor",
    founderBio:
      "Berkant Çalıkuşu é um desenvolvedor independente sediado em Istambul, na Turquia. Ele fundou o Qulo em 2026 e desenvolve e mantém o app sozinho — não há equipe por trás. É também o controlador de dados indicado na política de privacidade.",
    coverageHeading: "O Qulo na imprensa",
    coverageMessage:
      "Ainda não foi publicado nada sobre o Qulo. Quando for, será listado aqui com link para o original.",
    contactHeading: "Contato de imprensa",
    contactEmailLabel: "E-mail",
    contactTopicsLabel: "Com o que podemos ajudar",
    contactTopics: [
      "Pedido de teste",
      "Entrevista",
      "Como o match funciona",
      "Dúvidas sobre o produto",
    ],
    filesHeading: "Arquivos da marca",
    filesUsageNote:
      "Cada arquivo baixa direto. O logo pode ilustrar uma matéria sobre o Qulo; mantenha as cores e as proporções como estão.",
    moreHeading: "Mais do Qulo",
    moreLinks: {
      about: "Sobre",
      statistics: "Estatísticas de relacionamento",
      blog: "Blog",
      contact: "Contato",
    },
    ctaHeading: "Veja você mesmo",
    ctaText:
      "Escreva algumas perguntas e veja quem acerta. Grátis no iOS e no Android.",
  },

  it: {
    breadcrumb: "Kit stampa",
    eyebrow: "Area stampa",
    heroTitle: "Kit stampa",
    heroSubtitle:
      "Loghi, colori del marchio, i dati dell'app e l'indirizzo di contatto. Tutto quello che c'è in questa pagina è aggiornato e citabile così com'è.",
    quickFactsHeading: "In breve",
    facts: {
      name: { term: "Nome", value: "Qulo" },
      founded: { term: "Fondazione", value: "2026" },
      category: {
        term: "Categoria",
        value: "App di incontri basata sulle domande",
      },
      platforms: { term: "Piattaforme", value: "iOS, Android" },
      price: { term: "Prezzo", value: "Gratis, con piani a pagamento" },
      languages: { term: "Lingue dell'app", value: "16" },
      basedIn: { term: "Sede", value: "Istanbul, Turchia" },
      tagline: { term: "Slogan", value: "Incontra attraverso le domande" },
      website: { term: "Sito", value: "quloapp.com" },
    },
    aboutHeading: "Che cos'è Qulo",
    aboutParagraphs: [
      "Qulo è un'app di incontri in cui ci si conosce rispondendo a delle domande invece di scorrere i profili. Con il piano gratuito ogni persona scrive da 2 a 4 domande a risposta multipla su di sé, e fino a 10 con un piano a pagamento, quattro opzioni ciascuna e una segnata come giusta.",
      "Per arrivare a te bisogna indovinare tutte quelle domande: basta un errore e il match non c'è. Quando una domanda è difficile da indovinare si possono comprare degli indizi dentro l'app. Nient'altro viene misurato: niente percentuali, niente classifiche, nessun punteggio di compatibilità.",
      "Qulo funziona su iOS e Android. quloapp.com è un sito di presentazione, non una versione web dell'app. L'interfaccia è in 16 lingue e la libreria di domande suggerite dentro l'app ne copre 10.",
    ],
    logosHeading: "Loghi",
    logosSubtitle:
      "Un clic apre il file SVG in una nuova scheda; tutti i file sono elencati più sotto.",
    logos: {
      purple: { label: "Diamante viola", alt: "Logo Qulo, diamante viola" },
      green: { label: "Diamante verde", alt: "Logo Qulo, diamante verde" },
      splash: {
        label: "Logo di apertura",
        alt: "Logo Qulo della schermata di apertura",
      },
    },
    colorsHeading: "Colori del marchio",
    colorsSubtitle:
      "I colori su cui sono costruiti l'app e questo sito, con i valori HEX e RGB.",
    founderHeading: "Fondatore",
    founderRole: "Fondatore e sviluppatore",
    founderBio:
      "Berkant Çalıkuşu è uno sviluppatore indipendente con sede a Istanbul, in Turchia. Ha fondato Qulo nel 2026 e sviluppa e gestisce l'app da solo: non c'è nessun team dietro. È anche il titolare del trattamento indicato nell'informativa sulla privacy.",
    coverageHeading: "Qulo sui media",
    coverageMessage:
      "Su Qulo non è ancora uscito nulla. Quando succederà, lo troverete elencato qui con il link all'originale.",
    contactHeading: "Contatto stampa",
    contactEmailLabel: "E-mail",
    contactTopicsLabel: "Su cosa possiamo aiutare",
    contactTopics: [
      "Richiesta di prova",
      "Intervista",
      "Come funziona il match",
      "Domande sul prodotto",
    ],
    filesHeading: "File del marchio",
    filesUsageNote:
      "Ogni file si scarica direttamente. Il logo può illustrare un articolo su Qulo; lasciane invariati colori e proporzioni.",
    moreHeading: "Altro da Qulo",
    moreLinks: {
      about: "Chi siamo",
      statistics: "Statistiche sugli incontri",
      blog: "Blog",
      contact: "Contatti",
    },
    ctaHeading: "Guarda tu stesso",
    ctaText:
      "Scrivi qualche domanda e guarda chi le indovina. Gratis su iOS e Android.",
  },

  ja: {
    breadcrumb: "プレスキット",
    eyebrow: "報道関係の方へ",
    heroTitle: "プレスキット",
    heroSubtitle:
      "ロゴ、ブランドカラー、アプリの基本情報、連絡先。このページの内容はすべて最新で、そのまま引用していただけます。",
    quickFactsHeading: "基本情報",
    facts: {
      name: { term: "名称", value: "Qulo" },
      founded: { term: "設立", value: "2026年" },
      category: { term: "カテゴリー", value: "質問で出会うデーティングアプリ" },
      platforms: { term: "対応OS", value: "iOS、Android" },
      price: { term: "料金", value: "無料、有料プランあり" },
      languages: { term: "アプリの対応言語", value: "16言語" },
      basedIn: { term: "拠点", value: "トルコ・イスタンブール" },
      tagline: { term: "タグライン", value: "質問で出会う" },
      website: { term: "ウェブサイト", value: "quloapp.com" },
    },
    aboutHeading: "Quloについて",
    aboutParagraphs: [
      "Quloは、スワイプではなく質問に答えることで人と出会うデーティングアプリです。無料プランでは自分について選択式の質問を2〜4問、有料プランなら最大10問まで用意し、それぞれ四つの選択肢のうち一つを正解として設定します。",
      "あなたに届くには、その質問すべてに正解しなければなりません。一問でも間違えればマッチは成立しません。推測が難しい質問には、アプリ内でヒントを購入できます。それ以外に測られるものはなく、パーセンテージも順位も相性スコアもありません。",
      "QuloはiOSとAndroidで動きます。quloapp.comは紹介用のサイトで、アプリのウェブ版ではありません。画面表示は16言語に対応し、アプリ内の質問例のライブラリはそのうち10言語をカバーしています。",
    ],
    logosHeading: "ロゴ",
    logosSubtitle:
      "クリックするとSVGファイルが新しいタブで開きます。ファイルの一覧は下にあります。",
    logos: {
      purple: { label: "紫のダイヤ", alt: "Quloのロゴ、紫のダイヤ" },
      green: { label: "緑のダイヤ", alt: "Quloのロゴ、緑のダイヤ" },
      splash: { label: "起動画面のロゴ", alt: "Quloの起動画面のロゴ" },
    },
    colorsHeading: "ブランドカラー",
    colorsSubtitle:
      "アプリとこのサイトを構成している色です。HEXとRGBの値を添えています。",
    founderHeading: "創業者",
    founderRole: "創業者・開発者",
    founderBio:
      "Berkant Çalıkuşuは、トルコ・イスタンブールを拠点とする個人開発者です。2026年にQuloを立ち上げ、開発も運営も一人で行っています。チームはありません。プライバシーポリシーに記載されているデータ管理者も本人です。",
    coverageHeading: "メディア掲載",
    coverageMessage:
      "Quloについての記事はまだありません。掲載された際は、原典へのリンクとともにここに並べます。",
    contactHeading: "報道関係のお問い合わせ",
    contactEmailLabel: "メール",
    contactTopicsLabel: "お手伝いできること",
    contactTopics: [
      "レビュー用のご相談",
      "インタビュー",
      "マッチの仕組み",
      "製品についての質問",
    ],
    filesHeading: "ブランド素材",
    filesUsageNote:
      "各ファイルはそのままダウンロードできます。ロゴはQuloに関する記事にお使いいただけます。色と比率は変えずにご利用ください。",
    moreHeading: "Quloについてもっと見る",
    moreLinks: {
      about: "Quloについて",
      statistics: "恋愛のデータ",
      blog: "ブログ",
      contact: "お問い合わせ",
    },
    ctaHeading: "実際に試す",
    ctaText:
      "質問をいくつか書いて、誰が正解するか見てみてください。iOSとAndroidで無料です。",
  },

  ko: {
    breadcrumb: "프레스 키트",
    eyebrow: "언론 문의",
    heroTitle: "프레스 키트",
    heroSubtitle:
      "로고, 브랜드 컬러, 앱의 기본 정보와 연락처입니다. 이 페이지의 내용은 모두 최신이며 그대로 인용하셔도 됩니다.",
    quickFactsHeading: "기본 정보",
    facts: {
      name: { term: "이름", value: "Qulo" },
      founded: { term: "설립", value: "2026년" },
      category: { term: "분류", value: "질문으로 만나는 데이팅 앱" },
      platforms: { term: "지원 플랫폼", value: "iOS, Android" },
      price: { term: "가격", value: "무료, 유료 플랜 있음" },
      languages: { term: "앱 지원 언어", value: "16개" },
      basedIn: { term: "거점", value: "터키 이스탄불" },
      tagline: { term: "태그라인", value: "질문으로 만남" },
      website: { term: "웹사이트", value: "quloapp.com" },
    },
    aboutHeading: "Qulo 소개",
    aboutParagraphs: [
      "Qulo는 스와이프가 아니라 질문에 답하며 사람을 만나는 데이팅 앱입니다. 무료 플랜에서는 자기 자신에 대한 객관식 질문을 2~4개, 유료 플랜에서는 최대 10개까지 쓰고, 질문마다 보기를 네 개 두어 그중 하나를 정답으로 지정합니다.",
      "누군가 나에게 닿으려면 그 질문을 모두 맞혀야 합니다. 하나라도 틀리면 매칭은 이루어지지 않습니다. 맞히기 어려운 질문에는 앱 안에서 힌트를 살 수 있습니다. 그 밖에 측정되는 것은 없습니다. 백분율도, 순위도, 궁합 점수도 없습니다.",
      "Qulo는 iOS와 Android에서 작동합니다. quloapp.com은 소개용 사이트이며 앱의 웹 버전이 아닙니다. 화면은 16개 언어를 지원하고, 앱 안의 추천 질문 라이브러리는 그중 10개 언어를 담고 있습니다.",
    ],
    logosHeading: "로고",
    logosSubtitle:
      "누르면 SVG 파일이 새 탭에서 열립니다. 전체 파일 목록은 아래에 있습니다.",
    logos: {
      purple: { label: "보라색 다이아", alt: "Qulo 로고, 보라색 다이아" },
      green: { label: "초록색 다이아", alt: "Qulo 로고, 초록색 다이아" },
      splash: { label: "시작 화면 로고", alt: "Qulo 시작 화면의 로고" },
    },
    colorsHeading: "브랜드 컬러",
    colorsSubtitle:
      "앱과 이 사이트를 이루는 색입니다. HEX와 RGB 값을 함께 적었습니다.",
    founderHeading: "창업자",
    founderRole: "창업자 겸 개발자",
    founderBio:
      "Berkant Çalıkuşu는 터키 이스탄불에 있는 독립 개발자입니다. 2026년에 Qulo를 만들었고, 개발과 운영을 혼자 하고 있습니다. 뒤에 팀은 없습니다. 개인정보 처리방침에 적힌 데이터 관리자도 같은 사람입니다.",
    coverageHeading: "언론 보도",
    coverageMessage:
      "Qulo에 대해 나온 기사는 아직 없습니다. 나오면 원문 링크와 함께 여기에 정리하겠습니다.",
    contactHeading: "언론 연락처",
    contactEmailLabel: "이메일",
    contactTopicsLabel: "도와드릴 수 있는 것",
    contactTopics: ["리뷰 요청", "인터뷰", "매칭 방식", "제품 관련 질문"],
    filesHeading: "브랜드 파일",
    filesUsageNote:
      "각 파일은 바로 내려받을 수 있습니다. 로고는 Qulo를 다루는 기사에 쓰셔도 됩니다. 색과 비율은 그대로 두고 사용해 주세요.",
    moreHeading: "Qulo 더 보기",
    moreLinks: {
      about: "소개",
      statistics: "데이팅 통계",
      blog: "블로그",
      contact: "문의",
    },
    ctaHeading: "직접 확인해 보세요",
    ctaText:
      "질문을 몇 개 써 두고 누가 맞히는지 보세요. iOS와 Android에서 무료입니다.",
  },

  zh: {
    breadcrumb: "媒体资料",
    eyebrow: "媒体中心",
    heroTitle: "媒体资料",
    heroSubtitle:
      "Logo、品牌色、应用的基本信息和联系方式。本页内容均为最新，可以直接引用。",
    quickFactsHeading: "基本信息",
    facts: {
      name: { term: "名称", value: "Qulo" },
      founded: { term: "创立", value: "2026 年" },
      category: { term: "类别", value: "以问答配对的交友应用" },
      platforms: { term: "平台", value: "iOS、Android" },
      price: { term: "价格", value: "免费，另有付费方案" },
      languages: { term: "应用语言", value: "16 种" },
      basedIn: { term: "所在地", value: "土耳其伊斯坦布尔" },
      tagline: { term: "标语", value: "通过问题认识" },
      website: { term: "网站", value: "quloapp.com" },
    },
    aboutHeading: "关于 Qulo",
    aboutParagraphs: [
      "Qulo 是一款靠答题而不是滑动来认识人的交友应用。免费方案下，每个人为自己写 2 到 4 道选择题，付费方案最多 10 道；每题四个选项，其中一个标为正确答案。",
      "别人要走到你面前，必须把这些题全部答对；错一道就没有配对。遇到难猜的题，可以在应用内购买提示。除此之外不再衡量任何东西：没有百分比，没有排名，也没有所谓的契合度分数。",
      "Qulo 支持 iOS 和 Android。quloapp.com 是介绍用的网站，不是应用的网页版。界面提供 16 种语言，应用内的推荐题库覆盖其中 10 种。",
    ],
    logosHeading: "Logo",
    logosSubtitle: "点击可在新标签页打开 SVG 文件，完整文件列表见下方。",
    logos: {
      purple: { label: "紫色钻石", alt: "Qulo 的 Logo，紫色钻石" },
      green: { label: "绿色钻石", alt: "Qulo 的 Logo，绿色钻石" },
      splash: { label: "启动画面 Logo", alt: "Qulo 启动画面上的 Logo" },
    },
    colorsHeading: "品牌色",
    colorsSubtitle: "构成应用和本站的颜色，附 HEX 与 RGB 数值。",
    founderHeading: "创始人",
    founderRole: "创始人兼开发者",
    founderBio:
      "Berkant Çalıkuşu 是常驻土耳其伊斯坦布尔的独立开发者。他在 2026 年创立 Qulo，开发和运营都由他一人完成，背后没有团队。他也是隐私政策中列明的数据控制者。",
    coverageHeading: "媒体报道",
    coverageMessage:
      "目前还没有关于 Qulo 的报道。有了之后，会连同原文链接一起列在这里。",
    contactHeading: "媒体联系",
    contactEmailLabel: "邮箱",
    contactTopicsLabel: "我们可以协助的事",
    contactTopics: ["评测咨询", "采访", "配对如何进行", "产品相关问题"],
    filesHeading: "品牌文件",
    filesUsageNote:
      "文件可直接下载。Logo 可用于关于 Qulo 的报道配图，请保持颜色和比例不变。",
    moreHeading: "更多关于 Qulo",
    moreLinks: {
      about: "关于我们",
      statistics: "约会数据",
      blog: "博客",
      contact: "联系我们",
    },
    ctaHeading: "自己看看",
    ctaText: "写几道题，看看谁能答对。iOS 和 Android 上均可免费使用。",
  },

  nl: {
    breadcrumb: "Perskit",
    eyebrow: "Voor de pers",
    heroTitle: "Perskit",
    heroSubtitle:
      "Logo's, merkkleuren, de feiten over de app en het contactadres. Alles op deze pagina is actueel en mag zo geciteerd worden.",
    quickFactsHeading: "In het kort",
    facts: {
      name: { term: "Naam", value: "Qulo" },
      founded: { term: "Opgericht", value: "2026" },
      category: { term: "Categorie", value: "Datingapp op basis van vragen" },
      platforms: { term: "Platforms", value: "iOS, Android" },
      price: { term: "Prijs", value: "Gratis, met betaalde abonnementen" },
      languages: { term: "Talen in de app", value: "16" },
      basedIn: { term: "Gevestigd in", value: "Istanbul, Turkije" },
      tagline: { term: "Slogan", value: "Ontmoet via vragen" },
      website: { term: "Website", value: "quloapp.com" },
    },
    aboutHeading: "Over Qulo",
    aboutParagraphs: [
      "Qulo is een datingapp waarin mensen elkaar leren kennen door vragen te beantwoorden in plaats van te swipen. In het gratis plan schrijft iedereen 2 tot 4 meerkeuzevragen over zichzelf, en met een betaald abonnement tot 10, met vier opties per vraag en één als juist gemarkeerd.",
      "Wie jou wil bereiken, moet al die vragen goed beantwoorden; één fout antwoord en er is geen match. Is een vraag lastig te raden, dan kun je in de app hints kopen. Verder wordt er niets gemeten: geen percentage, geen ranglijst, geen compatibiliteitscijfer.",
      "Qulo draait op iOS en Android. quloapp.com is een informatiesite, geen webversie van de app. De interface is er in 16 talen en de bibliotheek met voorbeeldvragen in de app dekt er 10 van.",
    ],
    logosHeading: "Logo's",
    logosSubtitle:
      "Een klik opent het SVG-bestand in een nieuw tabblad; alle bestanden staan verderop.",
    logos: {
      purple: { label: "Paarse diamant", alt: "Qulo-logo, paarse diamant" },
      green: { label: "Groene diamant", alt: "Qulo-logo, groene diamant" },
      splash: {
        label: "Logo van het startscherm",
        alt: "Qulo-logo van het startscherm",
      },
    },
    colorsHeading: "Merkkleuren",
    colorsSubtitle:
      "De kleuren waarop de app en deze site zijn gebouwd, met HEX- en RGB-waarden.",
    founderHeading: "Oprichter",
    founderRole: "Oprichter en ontwikkelaar",
    founderBio:
      "Berkant Çalıkuşu is een zelfstandige ontwikkelaar in Istanbul, Turkije. Hij richtte Qulo in 2026 op en bouwt en beheert de app zelf; er zit geen team achter. Hij is ook de verwerkingsverantwoordelijke die in het privacybeleid staat.",
    coverageHeading: "Qulo in de media",
    coverageMessage:
      "Er is nog niets over Qulo gepubliceerd. Zodra dat gebeurt, staat het hier met een link naar het origineel.",
    contactHeading: "Perscontact",
    contactEmailLabel: "E-mail",
    contactTopicsLabel: "Waarmee we kunnen helpen",
    contactTopics: [
      "Verzoek om te testen",
      "Interview",
      "Hoe matchen werkt",
      "Vragen over het product",
    ],
    filesHeading: "Merkbestanden",
    filesUsageNote:
      "Elk bestand downloadt direct. Het logo mag bij berichtgeving over Qulo worden gebruikt; laat kleuren en verhoudingen ongewijzigd.",
    moreHeading: "Meer van Qulo",
    moreLinks: {
      about: "Over ons",
      statistics: "Datingstatistieken",
      blog: "Blog",
      contact: "Contact",
    },
    ctaHeading: "Bekijk het zelf",
    ctaText:
      "Schrijf een paar vragen en kijk wie ze goed heeft. Gratis op iOS en Android.",
  },

  pl: {
    breadcrumb: "Materiały prasowe",
    eyebrow: "Dla mediów",
    heroTitle: "Materiały prasowe",
    heroSubtitle:
      "Logo, kolory marki, fakty o aplikacji i adres kontaktowy. Wszystko na tej stronie jest aktualne i można to cytować wprost.",
    quickFactsHeading: "W skrócie",
    facts: {
      name: { term: "Nazwa", value: "Qulo" },
      founded: { term: "Powstanie", value: "2026" },
      category: {
        term: "Kategoria",
        value: "Aplikacja randkowa oparta na pytaniach",
      },
      platforms: { term: "Platformy", value: "iOS, Android" },
      price: { term: "Cena", value: "Za darmo, z planami płatnymi" },
      languages: { term: "Języki aplikacji", value: "16" },
      basedIn: { term: "Siedziba", value: "Stambuł, Turcja" },
      tagline: { term: "Hasło", value: "Poznawaj przez pytania" },
      website: { term: "Strona", value: "quloapp.com" },
    },
    aboutHeading: "O Qulo",
    aboutParagraphs: [
      "Qulo to aplikacja randkowa, w której ludzie poznają się przez odpowiadanie na pytania, a nie przez przesuwanie. W planie darmowym każdy pisze o sobie od 2 do 4 pytań wielokrotnego wyboru, a w planie płatnym nawet 10, po cztery odpowiedzi w każdym, z jedną oznaczoną jako poprawna.",
      "Żeby do ciebie dotrzeć, ktoś musi odpowiedzieć poprawnie na wszystkie te pytania; jeden błąd i dopasowania nie ma. Gdy pytanie trudno zgadnąć, w aplikacji można kupić podpowiedzi. Poza tym nic nie jest mierzone: żadnych procentów, rankingów ani wskaźnika dopasowania.",
      "Qulo działa na iOS i Androidzie. quloapp.com to strona informacyjna, a nie wersja webowa aplikacji. Interfejs jest w 16 językach, a biblioteka podpowiadanych pytań w aplikacji obejmuje 10 z nich.",
    ],
    logosHeading: "Logo",
    logosSubtitle:
      "Kliknięcie otwiera plik SVG w nowej karcie; pełna lista plików jest niżej.",
    logos: {
      purple: { label: "Fioletowy diament", alt: "Logo Qulo, fioletowy diament" },
      green: { label: "Zielony diament", alt: "Logo Qulo, zielony diament" },
      splash: {
        label: "Logo ekranu startowego",
        alt: "Logo Qulo z ekranu startowego",
      },
    },
    colorsHeading: "Kolory marki",
    colorsSubtitle:
      "Kolory, na których zbudowane są aplikacja i ta strona, z wartościami HEX i RGB.",
    founderHeading: "Założyciel",
    founderRole: "Założyciel i programista",
    founderBio:
      "Berkant Çalıkuşu jest niezależnym programistą ze Stambułu w Turcji. Założył Qulo w 2026 roku i sam tworzy oraz prowadzi aplikację — nie stoi za nią żaden zespół. Jest też administratorem danych wskazanym w polityce prywatności.",
    coverageHeading: "Qulo w mediach",
    coverageMessage:
      "O Qulo nic jeszcze nie napisano. Kiedy się to zmieni, materiał znajdzie się tutaj wraz z linkiem do oryginału.",
    contactHeading: "Kontakt dla mediów",
    contactEmailLabel: "E-mail",
    contactTopicsLabel: "W czym możemy pomóc",
    contactTopics: [
      "Prośba o test aplikacji",
      "Wywiad",
      "Jak działa dopasowanie",
      "Pytania o produkt",
    ],
    filesHeading: "Pliki marki",
    filesUsageNote:
      "Każdy plik pobiera się bezpośrednio. Logo można wykorzystać przy materiałach o Qulo; prosimy nie zmieniać jego kolorów ani proporcji.",
    moreHeading: "Więcej o Qulo",
    moreLinks: {
      about: "O nas",
      statistics: "Statystyki randkowe",
      blog: "Blog",
      contact: "Kontakt",
    },
    ctaHeading: "Zobacz sam",
    ctaText:
      "Napisz kilka pytań i zobacz, kto na nie odpowie. Za darmo na iOS i Androidzie.",
  },

  sv: {
    breadcrumb: "Presskit",
    eyebrow: "För press",
    heroTitle: "Presskit",
    heroSubtitle:
      "Logotyper, varumärkesfärger, fakta om appen och adressen att skriva till. Allt på den här sidan är aktuellt och går att citera som det står.",
    quickFactsHeading: "Kort om Qulo",
    facts: {
      name: { term: "Namn", value: "Qulo" },
      founded: { term: "Grundat", value: "2026" },
      category: { term: "Kategori", value: "Dejtingapp byggd på frågor" },
      platforms: { term: "Plattformar", value: "iOS, Android" },
      price: { term: "Pris", value: "Gratis, med betalda abonnemang" },
      languages: { term: "Språk i appen", value: "16" },
      basedIn: { term: "Bas", value: "Istanbul, Turkiet" },
      tagline: { term: "Slogan", value: "Träffas genom frågor" },
      website: { term: "Webbplats", value: "quloapp.com" },
    },
    aboutHeading: "Om Qulo",
    aboutParagraphs: [
      "Qulo är en dejtingapp där man lär känna varandra genom att svara på frågor i stället för att svepa. I gratisplanen skriver var och en 2 till 4 flervalsfrågor om sig själv, och upp till 10 med ett betalt abonnemang, fyra alternativ per fråga och ett markerat som rätt.",
      "Den som vill nå fram till dig måste svara rätt på varenda fråga; ett enda fel svar och det blir ingen matchning. Är en fråga svår att gissa går det att köpa ledtrådar i appen. Något annat mäts inte: ingen procentsats, ingen rangordning, inget kompatibilitetsvärde.",
      "Qulo finns för iOS och Android. quloapp.com är en informationssida, inte en webbversion av appen. Gränssnittet finns på 16 språk, och biblioteket med föreslagna frågor inne i appen täcker 10 av dem.",
    ],
    logosHeading: "Logotyper",
    logosSubtitle:
      "Ett klick öppnar SVG-filen i en ny flik; alla filer finns listade längre ner.",
    logos: {
      purple: { label: "Lila diamant", alt: "Qulos logotyp, lila diamant" },
      green: { label: "Grön diamant", alt: "Qulos logotyp, grön diamant" },
      splash: {
        label: "Startskärmens logotyp",
        alt: "Qulos logotyp från startskärmen",
      },
    },
    colorsHeading: "Varumärkesfärger",
    colorsSubtitle:
      "Färgerna som appen och den här sidan är byggda på, med HEX- och RGB-värden.",
    founderHeading: "Grundare",
    founderRole: "Grundare och utvecklare",
    founderBio:
      "Berkant Çalıkuşu är en oberoende utvecklare i Istanbul i Turkiet. Han grundade Qulo 2026 och bygger och driver appen själv — det finns inget team bakom. Han är också den personuppgiftsansvarige som anges i integritetspolicyn.",
    coverageHeading: "Qulo i medierna",
    coverageMessage:
      "Inget har publicerats om Qulo än. När det sker listas det här, med länk till originalet.",
    contactHeading: "Presskontakt",
    contactEmailLabel: "E-post",
    contactTopicsLabel: "Det här kan vi hjälpa till med",
    contactTopics: [
      "Förfrågan om att testa",
      "Intervju",
      "Hur matchningen fungerar",
      "Frågor om produkten",
    ],
    filesHeading: "Varumärkesfiler",
    filesUsageNote:
      "Varje fil laddas ner direkt. Logotypen får användas i material om Qulo; behåll färger och proportioner som de är.",
    moreHeading: "Mer från Qulo",
    moreLinks: {
      about: "Om oss",
      statistics: "Dejtingstatistik",
      blog: "Blogg",
      contact: "Kontakt",
    },
    ctaHeading: "Se det själv",
    ctaText:
      "Skriv några frågor och se vem som svarar rätt. Gratis på iOS och Android.",
  },

  hi: {
    breadcrumb: "प्रेस किट",
    eyebrow: "प्रेस के लिए",
    heroTitle: "प्रेस किट",
    heroSubtitle:
      "लोगो, ब्रांड रंग, ऐप की बुनियादी जानकारी और संपर्क पता। इस पेज पर जो कुछ है वह ताज़ा है और जस का तस उद्धृत किया जा सकता है।",
    quickFactsHeading: "बुनियादी जानकारी",
    facts: {
      name: { term: "नाम", value: "Qulo" },
      founded: { term: "शुरुआत", value: "2026" },
      category: { term: "श्रेणी", value: "सवालों पर आधारित डेटिंग ऐप" },
      platforms: { term: "प्लेटफ़ॉर्म", value: "iOS, Android" },
      price: { term: "कीमत", value: "मुफ़्त, सशुल्क प्लान भी" },
      languages: { term: "ऐप की भाषाएँ", value: "16" },
      basedIn: { term: "ठिकाना", value: "इस्तांबुल, तुर्की" },
      tagline: { term: "टैगलाइन", value: "सवालों से मिलें" },
      website: { term: "वेबसाइट", value: "quloapp.com" },
    },
    aboutHeading: "Qulo के बारे में",
    aboutParagraphs: [
      "Qulo एक डेटिंग ऐप है जिसमें लोग स्वाइप करके नहीं, सवालों के जवाब देकर एक-दूसरे से मिलते हैं। मुफ़्त प्लान में हर कोई अपने बारे में 2 से 4 बहुविकल्पीय सवाल लिखता है और सशुल्क प्लान में 10 तक; हर सवाल में चार विकल्प होते हैं और एक सही चिह्नित होता है।",
      "आप तक पहुँचने के लिए सामने वाले को वे सारे सवाल सही करने होते हैं; एक भी गलत हुआ तो मैच नहीं होता। जिस सवाल का अंदाज़ा लगाना मुश्किल हो, उसके लिए ऐप में संकेत खरीदे जा सकते हैं। इसके अलावा कुछ नहीं आँका जाता — न प्रतिशत, न रैंकिंग, न कोई अनुकूलता स्कोर।",
      "Qulo iOS और Android पर चलता है। quloapp.com एक परिचय वाली साइट है, ऐप का वेब संस्करण नहीं। इंटरफ़ेस 16 भाषाओं में है और ऐप के भीतर सुझाए गए सवालों की लाइब्रेरी उनमें से 10 भाषाओं को कवर करती है।",
    ],
    logosHeading: "लोगो",
    logosSubtitle:
      "क्लिक करने पर SVG फ़ाइल नए टैब में खुलती है; सभी फ़ाइलें नीचे सूचीबद्ध हैं।",
    logos: {
      purple: { label: "बैंगनी हीरा", alt: "Qulo का लोगो, बैंगनी हीरा" },
      green: { label: "हरा हीरा", alt: "Qulo का लोगो, हरा हीरा" },
      splash: {
        label: "शुरुआती स्क्रीन का लोगो",
        alt: "Qulo की शुरुआती स्क्रीन का लोगो",
      },
    },
    colorsHeading: "ब्रांड रंग",
    colorsSubtitle:
      "ऐप और यह साइट जिन रंगों पर बनी है, HEX और RGB मानों के साथ।",
    founderHeading: "संस्थापक",
    founderRole: "संस्थापक और डेवलपर",
    founderBio:
      "Berkant Çalıkuşu तुर्की के इस्तांबुल में रहने वाले स्वतंत्र डेवलपर हैं। उन्होंने 2026 में Qulo शुरू किया और ऐप को खुद ही बनाते और चलाते हैं — पीछे कोई टीम नहीं है। प्राइवेसी पॉलिसी में दर्ज डेटा कंट्रोलर भी वही हैं।",
    coverageHeading: "मीडिया में Qulo",
    coverageMessage:
      "Qulo के बारे में अभी तक कुछ प्रकाशित नहीं हुआ है। जब होगा, तब मूल लिंक के साथ यहीं दर्ज किया जाएगा।",
    contactHeading: "प्रेस संपर्क",
    contactEmailLabel: "ईमेल",
    contactTopicsLabel: "हम किन बातों में मदद कर सकते हैं",
    contactTopics: [
      "समीक्षा के लिए अनुरोध",
      "इंटरव्यू",
      "मैच कैसे होता है",
      "उत्पाद से जुड़े सवाल",
    ],
    filesHeading: "ब्रांड फ़ाइलें",
    filesUsageNote:
      "हर फ़ाइल सीधे डाउनलोड होती है। Qulo से जुड़ी ख़बर में लोगो इस्तेमाल किया जा सकता है; इसके रंग और अनुपात जस के तस रखें।",
    moreHeading: "Qulo के बारे में और",
    moreLinks: {
      about: "हमारे बारे में",
      statistics: "डेटिंग आँकड़े",
      blog: "ब्लॉग",
      contact: "संपर्क",
    },
    ctaHeading: "खुद देखिए",
    ctaText:
      "कुछ सवाल लिखिए और देखिए कौन उन्हें सही करता है। iOS और Android पर मुफ़्त।",
  },
};

/**
 * Labels for a locale.
 *
 * Throws rather than returning English. `PRESS_LABELS` is keyed by `Locale`, so
 * the sixteen shipped locales are guaranteed at compile time and this can only
 * fire on a locale that is not in `locales` at all — which `generateStaticParams`
 * never produces. A loud build failure beats a page that serves English prose
 * under `hreflang="ja"`, which is exactly what the old `getCopy` did.
 */
export function pressLabelsFor(locale: string): PressLabels {
  const labels = PRESS_LABELS[locale as Locale];
  if (!labels) {
    throw new Error(`pressLabels: no press copy for locale "${locale}"`);
  }
  return labels;
}
