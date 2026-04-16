export interface DatingStat {
  category: string;
  value: string;
  labels: Record<string, string>;
  source?: string;
  highlight?: boolean;
}

export interface StatCategory {
  key: string;
  emoji: string;
  titles: Record<string, string>;
  stats: DatingStat[];
}

export const STAT_CATEGORIES: StatCategory[] = [
  {
    key: "usage",
    emoji: "📱",
    titles: {
      tr: "Dating Uygulaması Kullanımı",
      en: "Dating App Usage",
      de: "Dating-App-Nutzung",
      fr: "Utilisation des apps de rencontre",
      es: "Uso de apps de citas",
    },
    stats: [
      {
        category: "usage",
        value: "381M+",
        labels: {
          tr: "Dünya genelinde aktif dating app kullanıcısı (2026)",
          en: "Active dating app users worldwide (2026)",
          de: "Aktive Dating-App-Nutzer weltweit (2026)",
          fr: "Utilisateurs actifs d'apps de rencontre dans le monde (2026)",
          es: "Usuarios activos de apps de citas en el mundo (2026)",
        },
        source: "Statista 2025",
        highlight: true,
      },
      {
        category: "usage",
        value: "30-40dk",
        labels: {
          tr: "Ortalama günlük dating app kullanım süresi",
          en: "Average daily dating app usage time",
          de: "Durchschnittliche tägliche Nutzungszeit",
          fr: "Temps moyen d'utilisation quotidien",
          es: "Tiempo medio de uso diario",
        },
      },
      {
        category: "usage",
        value: "115",
        labels: {
          tr: "Bir eşleşme için ortalama swipe sayısı",
          en: "Average swipes per match",
          de: "Durchschnittliche Swipes pro Match",
          fr: "Swipes moyens par match",
          es: "Swipes promedio por match",
        },
      },
      {
        category: "usage",
        value: "0.5sn",
        labels: {
          tr: "Bir profile bakma süresi",
          en: "Time spent reviewing a profile",
          de: "Profilbetrachtungszeit",
          fr: "Temps passé sur un profil",
          es: "Tiempo viendo un perfil",
        },
      },
    ],
  },
  {
    key: "fatigue",
    emoji: "😩",
    titles: {
      tr: "Swipe Yorgunluğu ve Tükenmişlik",
      en: "Swipe Fatigue & Burnout",
      de: "Swipe-Müdigkeit & Burnout",
      fr: "Fatigue du Swipe & Burnout",
      es: "Cansancio del Swipe & Burnout",
    },
    stats: [
      {
        category: "fatigue",
        value: "%78",
        labels: {
          tr: "Kullanıcılar dating app'den tükenmişlik hissediyor",
          en: "Of users feel burnout from dating apps",
          de: "Der Nutzer fühlen sich ausgebrannt",
          fr: "Des utilisateurs ressentent un burnout",
          es: "De usuarios sienten burnout",
        },
        highlight: true,
      },
      {
        category: "fatigue",
        value: "%54",
        labels: {
          tr: "Uygulama kullandıktan sonra daha yalnız hissediyor",
          en: "Feel lonelier after using apps",
          de: "Fühlen sich nach App-Nutzung einsamer",
          fr: "Se sentent plus seuls après l'utilisation",
          es: "Se sienten más solos después de usar apps",
        },
      },
      {
        category: "fatigue",
        value: "%80+",
        labels: {
          tr: "Eşleşmelerde ghosting oranı",
          en: "Ghosting rate in matches",
          de: "Ghosting-Rate bei Matches",
          fr: "Taux de ghosting dans les matchs",
          es: "Tasa de ghosting en matches",
        },
      },
      {
        category: "fatigue",
        value: "%50",
        labels: {
          tr: "Erkek kullanıcı neredeyse hiç eşleşme almıyor",
          en: "Of male users receive almost no matches",
          de: "Der männlichen Nutzer bekommen kaum Matches",
          fr: "Des utilisateurs masculins reçoivent peu de matchs",
          es: "De usuarios masculinos reciben casi ningún match",
        },
      },
    ],
  },
  {
    key: "matching",
    emoji: "💕",
    titles: {
      tr: "Eşleşme ve Buluşma",
      en: "Matching & Dating",
      de: "Matching & Dating",
      fr: "Matching & Rencontres",
      es: "Matching & Citas",
    },
    stats: [
      {
        category: "matching",
        value: "%2-5",
        labels: {
          tr: "Eşleşmelerin gerçek bir buluşmaya dönüşme oranı",
          en: "Of matches turn into actual dates",
          de: "Der Matches führen zu echten Dates",
          fr: "Des matchs deviennent de vrais rendez-vous",
          es: "De matches se convierten en citas reales",
        },
        highlight: true,
      },
      {
        category: "matching",
        value: "39%",
        labels: {
          tr: "Heteroseksüel çiftler online olarak tanışıyor (2024)",
          en: "Of heterosexual couples meet online (2024)",
          de: "Der heterosexuellen Paare lernen sich online kennen",
          fr: "Des couples hétéros se rencontrent en ligne",
          es: "De parejas heterosexuales se conocen online",
        },
        source: "Stanford Study",
      },
      {
        category: "matching",
        value: "65%",
        labels: {
          tr: "LGBTQ+ çiftler online olarak tanışıyor",
          en: "Of LGBTQ+ couples meet online",
          de: "Der LGBTQ+ Paare lernen sich online kennen",
          fr: "Des couples LGBTQ+ se rencontrent en ligne",
          es: "De parejas LGBTQ+ se conocen online",
        },
        source: "Stanford Study",
      },
      {
        category: "matching",
        value: "53%",
        labels: {
          tr: "Kullanıcılar profilde yalan söyleyenle karşılaşmış",
          en: "Of users encountered profile lies",
          de: "Begegneten Nutzer Profil-Lügen",
          fr: "Ont rencontré des mensonges sur les profils",
          es: "Encontraron mentiras en perfiles",
        },
      },
    ],
  },
  {
    key: "demographics",
    emoji: "👥",
    titles: {
      tr: "Demografik Veriler",
      en: "Demographics",
      de: "Demografie",
      fr: "Démographie",
      es: "Demografía",
    },
    stats: [
      {
        category: "demographics",
        value: "30%",
        labels: {
          tr: "ABD'deki yetişkinler dating app kullanmış",
          en: "Of US adults have used dating apps",
          de: "Der US-Erwachsenen haben Dating-Apps genutzt",
          fr: "Des adultes US ont utilisé des apps de rencontre",
          es: "De adultos en EE.UU. han usado apps de citas",
        },
        source: "Pew Research 2024",
      },
      {
        category: "demographics",
        value: "53%",
        labels: {
          tr: "30 yaş altı yetişkinler dating app kullanmış",
          en: "Of adults under 30 have used dating apps",
          de: "Der unter 30-Jährigen",
          fr: "Des adultes de moins de 30 ans",
          es: "De adultos menores de 30 años",
        },
      },
      {
        category: "demographics",
        value: "Z Kuşağı",
        labels: {
          tr: "En aktif dating app kullanan kuşak",
          en: "Most active dating app generation",
          de: "Aktivste Dating-App-Generation",
          fr: "Génération la plus active sur les apps",
          es: "Generación más activa en apps",
        },
      },
      {
        category: "demographics",
        value: "60%",
        labels: {
          tr: "Z kuşağı 'swipe yorgunluğu' yaşıyor",
          en: "Of Gen Z experience swipe fatigue",
          de: "Der Gen Z erleben Swipe-Müdigkeit",
          fr: "De la Gen Z subit la fatigue du swipe",
          es: "De Gen Z experimenta cansancio del swipe",
        },
      },
    ],
  },
  {
    key: "trends",
    emoji: "📈",
    titles: {
      tr: "2026 Trendleri",
      en: "2026 Trends",
      de: "2026 Trends",
      fr: "Tendances 2026",
      es: "Tendencias 2026",
    },
    stats: [
      {
        category: "trends",
        value: "+200%",
        labels: {
          tr: "Quiz dating arama hacmi artışı (2024-2026)",
          en: "Increase in quiz dating searches (2024-2026)",
          de: "Anstieg der Quiz-Dating-Suchen",
          fr: "Augmentation des recherches quiz dating",
          es: "Aumento de búsquedas quiz dating",
        },
        highlight: true,
      },
      {
        category: "trends",
        value: "%72",
        labels: {
          tr: "Kullanıcılar 'slow dating' yaklaşımını tercih ediyor",
          en: "Of users prefer 'slow dating' approach",
          de: "Bevorzugen Slow-Dating-Ansatz",
          fr: "Préfèrent l'approche slow dating",
          es: "Prefieren el enfoque slow dating",
        },
      },
      {
        category: "trends",
        value: "%85",
        labels: {
          tr: "Kullanıcılar AI destekli eşleşmeyi denemek istiyor",
          en: "Of users want to try AI-powered matching",
          de: "Wollen KI-gestütztes Matching ausprobieren",
          fr: "Veulent essayer le matching IA",
          es: "Quieren probar matching con IA",
        },
      },
      {
        category: "trends",
        value: "30-40%",
        labels: {
          tr: "Cuffing season döneminde kullanım artışı",
          en: "Usage increase during cuffing season",
          de: "Nutzungssteigerung in der Cuffing Season",
          fr: "Augmentation pendant la cuffing season",
          es: "Aumento durante la cuffing season",
        },
      },
    ],
  },
];

/** Highlight stats — most prominent stats for hero section */
export function getHighlightStats(): DatingStat[] {
  const result: DatingStat[] = [];
  for (const cat of STAT_CATEGORIES) {
    for (const stat of cat.stats) {
      if (stat.highlight) result.push(stat);
    }
  }
  return result;
}

/** Localized label fallback to English */
export function getLabel(stat: DatingStat, locale: string): string {
  return stat.labels[locale] || stat.labels.en;
}

/** Localized category title fallback to English */
export function getCategoryTitle(cat: StatCategory, locale: string): string {
  return cat.titles[locale] || cat.titles.en;
}
