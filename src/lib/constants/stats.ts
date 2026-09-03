/**
 * Dating statistics shown on /[locale]/dating-statistics.
 *
 * RULE: every figure here MUST carry a full, checkable citation — publisher,
 * report title, publication date and a URL. The page invites journalists to cite
 * it ("Cite This Report"), so an unsourced number is a credibility liability,
 * not a gap to fill later. If a claim cannot be sourced, delete it rather than
 * hunting for a source that fits.
 *
 * RULE: Qulo is the only dating app that may be named on this site. Never cite a
 * dating app as a source, not even neutrally. If a claim can only be sourced to
 * one, delete the claim and its figure together — never strip the attribution
 * and keep the number, which is how an unsourced statistic gets laundered into
 * a "fact".
 *
 * Every figure below was verified against the primary source on 2026-09-01.
 */

export interface StatSource {
  /** Organisation that published the figure. */
  publisher: string;
  /** Report or paper title. */
  title: string;
  /** Publication date, human-readable. */
  date: string;
  /** Direct link to the source. */
  url: string;
  /** Sample size / methodology note, when the publisher states one. */
  sample?: string;
}

export interface DatingStat {
  category: string;
  value: string;
  labels: Record<string, string>;
  source: StatSource;
  highlight?: boolean;
}

export interface StatCategory {
  key: string;
  emoji: string;
  titles: Record<string, string>;
  stats: DatingStat[];
}

/* ------------------------------------------------------------------ */
/*  Sources (verified 2026-09-01) — also consumed by /trends/2026      */
/* ------------------------------------------------------------------ */

export const SSRS_2026: StatSource = {
  publisher: "SSRS",
  title: "The Public and Online Dating 2026",
  date: "2 February 2026",
  url: "https://ssrs.com/insights/online-dating-2026/",
  sample: "n=2,012 US adults · fielded 2–4 and 16–20 January 2026 · MoE ±2.5pp",
};

export const FORBES_ONEPOLL_2024: StatSource = {
  publisher: "Forbes Health / OnePoll",
  title: "Dating app burnout survey",
  date: "10 May 2024",
  url: "https://www.globaldatinginsights.com/news/new-forbes-study-explores-dating-app-burnout/",
  sample:
    "n=1,000 US adults who used a dating app in the past year \u00b7 fielded 27 March \u2013 1 April 2024 \u00b7 MoE \u00b13.1pp",
};

export const HUANG_JPSP_2017: StatSource = {
  publisher: "Huang, Yeomans, Brooks, Minson & Gino",
  title:
    "It Doesn't Hurt to Ask: Question-Asking Increases Liking \u2014 Journal of Personality and Social Psychology 113(3), 430\u2013452",
  date: "September 2017",
  url: "https://www.hbs.edu/ris/Publication%20Files/Huang%20et%20al%202017_6945bc5e-3b3e-4c0a-addd-254c9e603c60.pdf",
  sample:
    "110 speed daters \u00b7 15\u201319 four-minute dates each \u00b7 1,961 second-date decisions analysed (Study 3)",
};

export const STAT_CATEGORIES: StatCategory[] = [
  {
    key: "usage",
    emoji: "📱",
    titles: {
      tr: "Dating Uygulaması Kullanımı",
      en: "Dating App Usage",
      de: "Nutzung von Dating-Apps",
      fr: "Utilisation des applications de rencontre",
      es: "Uso de apps de citas",
      ar: "استخدام تطبيقات المواعدة",
      ru: "Использование приложений для знакомств",
      pt: "Uso de apps de namoro",
      it: "Utilizzo delle app di incontri",
      ja: "マッチングアプリの利用状況",
      ko: "데이팅 앱 이용 현황",
      zh: "交友软件使用情况",
      nl: "Gebruik van datingapps",
      pl: "Korzystanie z aplikacji randkowych",
      sv: "Användning av dejtingappar",
      hi: "डेटिंग ऐप का इस्तेमाल",
    },
    stats: [
      {
        category: "usage",
        value: "37%",
        labels: {
          tr: "ABD'li yetişkinlerin hayatının bir döneminde bir dating uygulaması kullanmış olma oranı; şu anda kullananlar %6",
          en: "Of US adults have used a dating site or app at some point; 6% are using one right now",
          de: "der US-Erwachsenen haben irgendwann eine Dating-Website oder -App genutzt; 6% nutzen derzeit eine",
          fr: "des adultes américains ont déjà utilisé un site ou une application de rencontre ; 6% en utilisent une actuellement",
          es: "de los adultos estadounidenses ha usado alguna vez un sitio o una app de citas; el 6% usa uno ahora mismo",
          ar: "من البالغين في الولايات المتحدة استخدموا موقع أو تطبيق مواعدة في وقت ما؛ و6% يستخدمون أحدها حاليًا",
          ru: "взрослых американцев когда-либо пользовались сайтом или приложением для знакомств; 6% пользуются прямо сейчас",
          pt: "dos adultos dos EUA já usaram um site ou app de namoro em algum momento; 6% usam um agora",
          it: "degli adulti statunitensi ha usato almeno una volta un sito o un'app di incontri; il 6% ne usa una in questo momento",
          ja: "の米国成人がこれまでにマッチングサイトやアプリを使ったことがある。現在使っている人は6%",
          ko: "의 미국 성인이 한 번쯤 데이팅 사이트나 앱을 사용해 본 적이 있으며, 6%는 지금 사용 중",
          zh: "的美国成年人曾经使用过交友网站或软件，目前正在使用的占6%",
          nl: "van de Amerikaanse volwassenen heeft ooit een datingsite of -app gebruikt; 6% gebruikt er nu een",
          pl: "dorosłych Amerykanów kiedykolwiek korzystało z serwisu lub aplikacji randkowej; 6% korzysta z niej obecnie",
          sv: "av amerikanska vuxna har någon gång använt en dejtingsajt eller -app; 6% använder en just nu",
          hi: "अमेरिकी वयस्कों ने कभी न कभी कोई डेटिंग साइट या ऐप इस्तेमाल किया है; 6% अभी इस्तेमाल कर रहे हैं",
        },
        source: SSRS_2026,
        highlight: true,
      },
      {
        category: "usage",
        value: "51-53%",
        labels: {
          tr: "18-29 yaş (%51) ve 30-49 yaş (%53) grubunda online dating kullanmış olma oranı",
          en: "Of 18–29 year olds (51%) and 30–49 year olds (53%) have used online dating",
          de: "der 18–29-Jährigen (51%) und der 30–49-Jährigen (53%) haben Online-Dating genutzt",
          fr: "des 18–29 ans (51%) et des 30–49 ans (53%) ont déjà utilisé les rencontres en ligne",
          es: "de las personas de 18–29 años (51%) y de 30–49 años (53%) ha usado citas online",
          ar: "من الفئة العمرية 18–29 عامًا (51%) والفئة 30–49 عامًا (53%) استخدموا المواعدة عبر الإنترنت",
          ru: "людей 18–29 лет (51%) и 30–49 лет (53%) пользовались онлайн-знакомствами",
          pt: "das pessoas de 18–29 anos (51%) e de 30–49 anos (53%) já usaram namoro online",
          it: "dei 18–29enni (51%) e dei 30–49enni (53%) ha usato il dating online",
          ja: "の18〜29歳（51%）と30〜49歳（53%）がオンラインデートを利用した経験がある",
          ko: "의 18–29세(51%)와 30–49세(53%)가 온라인 데이팅을 이용해 본 적이 있음",
          zh: "的18–29岁人群（51%）和30–49岁人群（53%）使用过网络交友",
          nl: "van de 18–29-jarigen (51%) en de 30–49-jarigen (53%) heeft online daten gebruikt",
          pl: "osób w wieku 18–29 lat (51%) i 30–49 lat (53%) korzystało z randek online",
          sv: "av 18–29-åringarna (51%) och 30–49-åringarna (53%) har använt nätdejting",
          hi: "18–29 आयु वर्ग (51%) और 30–49 आयु वर्ग (53%) के लोग ऑनलाइन डेटिंग इस्तेमाल कर चुके हैं",
        },
        source: SSRS_2026,
      },
    ],
  },
  {
    key: "burnout",
    emoji: "😮‍💨",
    titles: {
      tr: "Tükenmişlik ve Deneyim",
      en: "Burnout & Experience",
      de: "Burnout und Erfahrung",
      fr: "Épuisement et expérience",
      es: "Agotamiento y experiencia",
      ar: "الإرهاق والتجربة",
      ru: "Выгорание и опыт",
      pt: "Esgotamento e experiência",
      it: "Burnout ed esperienza",
      ja: "燃え尽きと利用体験",
      ko: "번아웃과 경험",
      zh: "倦怠与体验",
      nl: "Burn-out en ervaring",
      pl: "Wypalenie i doświadczenia",
      sv: "Utmattning och upplevelse",
      hi: "थकान और अनुभव",
    },
    stats: [
      {
        category: "burnout",
        value: "78%",
        labels: {
          tr: "Dating uygulaması kullanıcılarının tükenmişlik yaşadığını bildirme oranı (kadınlarda %80, erkeklerde %74)",
          en: "Of dating app users report burnout — 80% of women and 74% of men",
          de: "der Dating-App-Nutzer berichten von Burnout — 80% der Frauen und 74% der Männer",
          fr: "des utilisateurs d'applications de rencontre déclarent un épuisement — 80% des femmes et 74% des hommes",
          es: "de los usuarios de apps de citas declara agotamiento: el 80% de las mujeres y el 74% de los hombres",
          ar: "من مستخدمي تطبيقات المواعدة يشعرون بالإرهاق — 80% من النساء و74% من الرجال",
          ru: "пользователей приложений для знакомств сообщают о выгорании — 80% женщин и 74% мужчин",
          pt: "dos usuários de apps de namoro relatam esgotamento — 80% das mulheres e 74% dos homens",
          it: "degli utenti di app di incontri riferisce burnout — l'80% delle donne e il 74% degli uomini",
          ja: "のマッチングアプリ利用者が燃え尽きを感じている（女性80%、男性74%）",
          ko: "의 데이팅 앱 사용자가 번아웃을 겪고 있음 — 여성 80%, 남성 74%",
          zh: "的交友软件用户表示感到倦怠——女性80%，男性74%",
          nl: "van de datingapp-gebruikers ervaart burn-out — 80% van de vrouwen en 74% van de mannen",
          pl: "użytkowników aplikacji randkowych zgłasza wypalenie — 80% kobiet i 74% mężczyzn",
          sv: "av dejtingappanvändarna upplever utmattning — 80% av kvinnorna och 74% av männen",
          hi: "डेटिंग ऐप उपयोगकर्ता थकान महसूस करते हैं — महिलाओं में 80% और पुरुषों में 74%",
        },
        source: FORBES_ONEPOLL_2024,
        highlight: true,
      },
    ],
  },
  {
    key: "questions",
    emoji: "💬",
    titles: {
      tr: "Soru Sormanın Gücü",
      en: "The Power of Asking Questions",
      de: "Die Kraft des Fragens",
      fr: "Le pouvoir des questions",
      es: "El poder de hacer preguntas",
      ar: "قوة طرح الأسئلة",
      ru: "Сила вопросов",
      pt: "O poder de fazer perguntas",
      it: "Il potere delle domande",
      ja: "質問することの力",
      ko: "질문의 힘",
      zh: "提问的力量",
      nl: "De kracht van vragen stellen",
      pl: "Siła zadawania pytań",
      sv: "Kraften i att ställa frågor",
      hi: "सवाल पूछने की ताकत",
    },
    stats: [
      {
        category: "questions",
        value: "1,961",
        labels: {
          tr: "İncelenen hızlı tanışma buluşması: daha çok takip sorusu soranlar daha fazla ikinci buluşma daveti aldı",
          en: "Speed dates analysed: those who asked more follow-up questions received more second-date offers",
          de: "analysierte Speed-Dates: Wer mehr Nachfragen stellte, bekam häufiger ein zweites Date angeboten",
          fr: "speed dates analysés : celles et ceux qui posaient plus de questions de relance recevaient plus de propositions de deuxième rendez-vous",
          es: "citas rápidas analizadas: quienes hacían más preguntas de seguimiento recibían más propuestas de segunda cita",
          ar: "من مواعيد التعارف السريع جرى تحليلها: من طرحوا أسئلة متابعة أكثر تلقّوا دعوات أكثر لموعد ثانٍ",
          ru: "проанализированных быстрых свиданий: те, кто задавал больше уточняющих вопросов, чаще получали приглашение на второе свидание",
          pt: "encontros rápidos analisados: quem fez mais perguntas de acompanhamento recebeu mais convites para um segundo encontro",
          it: "speed date analizzati: chi faceva più domande di approfondimento riceveva più proposte per un secondo incontro",
          ja: "件のスピードデートを分析。追加の質問を多くした人ほど、次のデートに誘われた",
          ko: "건의 스피드 데이트를 분석: 후속 질문을 더 많이 한 사람이 다음 데이트 제안을 더 많이 받음",
          zh: "场快速约会经分析：追问更多的人收到了更多的再次约会邀请",
          nl: "geanalyseerde speeddates: wie meer vervolgvragen stelde, kreeg vaker een tweede date aangeboden",
          pl: "przeanalizowanych szybkich randek: osoby zadające więcej pytań pogłębiających częściej otrzymywały propozycję kolejnej randki",
          sv: "analyserade snabbdejter: de som ställde fler följdfrågor fick fler erbjudanden om en andra dejt",
          hi: "स्पीड डेट्स का विश्लेषण: जिन्होंने ज़्यादा फ़ॉलो-अप सवाल पूछे, उन्हें दूसरी डेट के ज़्यादा प्रस्ताव मिले",
        },
        source: HUANG_JPSP_2017,
      },
    ],
  },
  {
    key: "safety",
    emoji: "🛡️",
    titles: {
      tr: "Güvenlik Algısı",
      en: "Safety Perception",
      de: "Wahrgenommene Sicherheit",
      fr: "Perception de la sécurité",
      es: "Percepción de seguridad",
      ar: "إدراك الأمان",
      ru: "Восприятие безопасности",
      pt: "Percepção de segurança",
      it: "Percezione della sicurezza",
      ja: "安全性の受け止め方",
      ko: "안전에 대한 인식",
      zh: "安全感知",
      nl: "Perceptie van veiligheid",
      pl: "Postrzeganie bezpieczeństwa",
      sv: "Upplevd trygghet",
      hi: "सुरक्षा की धारणा",
    },
    stats: [
      {
        category: "safety",
        value: "57%",
        labels: {
          tr: "Uygulamada tanışılan biriyle yüz yüze buluşmayı genel olarak güvenli bulan ABD'li yetişkin oranı; %43 güvenli bulmuyor",
          en: "Of US adults think meeting an app match in person is generally safe; 43% think it is not",
          de: "der US-Erwachsenen halten es für grundsätzlich sicher, ein Match aus einer App persönlich zu treffen; 43% halten es für unsicher",
          fr: "des adultes américains estiment qu'il est globalement sûr de rencontrer en personne un match trouvé sur une application ; 43% pensent le contraire",
          es: "de los adultos estadounidenses cree que quedar en persona con un match de una app es generalmente seguro; el 43% cree que no",
          ar: "من البالغين في الولايات المتحدة يرون أن مقابلة شخص تعرّفوا عليه عبر التطبيق وجهًا لوجه آمنة عمومًا؛ و43% يرون العكس",
          ru: "взрослых американцев считают личную встречу с человеком из приложения в целом безопасной; 43% так не считают",
          pt: "dos adultos dos EUA acham que encontrar pessoalmente um match do app é geralmente seguro; 43% acham que não",
          it: "degli adulti statunitensi ritiene che incontrare di persona un match conosciuto in app sia generalmente sicuro; il 43% pensa il contrario",
          ja: "の米国成人が、アプリで出会った相手と実際に会うのはおおむね安全だと考えている。危険だと考える人は43%",
          ko: "의 미국 성인이 앱에서 만난 상대를 직접 만나는 것이 대체로 안전하다고 생각하며, 43%는 그렇지 않다고 봄",
          zh: "的美国成年人认为与软件上匹配的人线下见面总体上是安全的，43%认为并不安全",
          nl: "van de Amerikaanse volwassenen vindt het doorgaans veilig om een match uit een app in het echt te ontmoeten; 43% vindt van niet",
          pl: "dorosłych Amerykanów uważa spotkanie na żywo z osobą poznaną w aplikacji za ogólnie bezpieczne; 43% jest przeciwnego zdania",
          sv: "av amerikanska vuxna tycker att det i regel är tryggt att träffa en match från en app i verkligheten; 43% tycker inte det",
          hi: "अमेरिकी वयस्क मानते हैं कि ऐप पर मिले मैच से आमने-सामने मिलना आम तौर पर सुरक्षित है; 43% ऐसा नहीं मानते",
        },
        source: SSRS_2026,
        highlight: true,
      },
      {
        category: "safety",
        value: "55% / 30%",
        labels: {
          tr: "Kadınların buluşmayı güvensiz bulma oranı, erkeklerdeki %30'a karşılık — verideki en keskin cinsiyet farkı",
          en: "Of women say meeting a match is not safe, against 30% of men — the sharpest gender gap in the data",
          de: "der Frauen sagen, ein Treffen mit einem Match sei nicht sicher — gegenüber 30% der Männer, der deutlichste Geschlechterunterschied in den Daten",
          fr: "des femmes disent qu'il n'est pas sûr de rencontrer un match, contre 30% des hommes — l'écart entre les sexes le plus marqué des données",
          es: "de las mujeres dice que quedar con un match no es seguro, frente al 30% de los hombres: la mayor brecha de género de los datos",
          ar: "من النساء يقلن إن مقابلة شخص من التطبيق ليست آمنة، مقابل 30% من الرجال — وهي أكبر فجوة بين الجنسين في البيانات",
          ru: "женщин считают встречу с человеком из приложения небезопасной — против 30% мужчин: самый заметный гендерный разрыв в данных",
          pt: "das mulheres dizem que encontrar um match não é seguro, contra 30% dos homens — a maior diferença entre gêneros nos dados",
          it: "delle donne dice che incontrare un match non è sicuro, contro il 30% degli uomini: il divario di genere più netto dei dati",
          ja: "の女性が、マッチした相手と会うのは安全ではないと答えた。男性は30%で、データ中で最も大きな男女差",
          ko: "의 여성이 매치 상대를 만나는 것은 안전하지 않다고 답했으며, 남성은 30% — 데이터에서 가장 큰 성별 격차",
          zh: "的女性认为与匹配对象见面并不安全，男性为30%——这是数据中最悬殊的性别差距",
          nl: "van de vrouwen zegt dat afspreken met een match niet veilig is, tegenover 30% van de mannen — het scherpste genderverschil in de data",
          pl: "kobiet uważa, że spotkanie z osobą poznaną w aplikacji nie jest bezpieczne, wobec 30% mężczyzn — to najostrzejsza różnica między płciami w danych",
          sv: "av kvinnorna säger att det inte är tryggt att träffa en match, mot 30% av männen — den skarpaste könsskillnaden i datan",
          hi: "महिलाएँ कहती हैं कि मैच से मिलना सुरक्षित नहीं है, जबकि पुरुषों में यह 30% है — आँकड़ों में सबसे बड़ा लैंगिक अंतर",
        },
        source: SSRS_2026,
      },
    ],
  },
];

/** All stats flagged as headline figures, in category order. */
export function getHighlightStats(): DatingStat[] {
  return STAT_CATEGORIES.flatMap((cat) => cat.stats.filter((stat) => stat.highlight));
}

/** Localized label with English fallback. */
export function getLabel(stat: DatingStat, locale: string): string {
  return stat.labels[locale] || stat.labels.en;
}

/** Localized category title with English fallback. */
export function getCategoryTitle(cat: StatCategory, locale: string): string {
  return cat.titles[locale] || cat.titles.en;
}

/** Short attribution line, e.g. "SSRS — The Public and Online Dating 2026 (2 February 2026)". */
export function formatSource(source: StatSource): string {
  return `${source.publisher} — ${source.title} (${source.date})`;
}

/** Every distinct source cited on the page, in first-use order. */
export function getAllSources(): StatSource[] {
  const seen = new Set<string>();
  const result: StatSource[] = [];
  for (const cat of STAT_CATEGORIES) {
    for (const stat of cat.stats) {
      if (!seen.has(stat.source.url)) {
        seen.add(stat.source.url);
        result.push(stat.source);
      }
    }
  }
  return result;
}
