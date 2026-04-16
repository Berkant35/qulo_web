export interface City {
  slug: string;
  names: Record<string, string>;
  country: Record<string, string>;
  emoji: string;
  population: string;
  coordinates: { lat: number; lng: number };
}

export const CITIES: City[] = [
  {
    slug: "istanbul",
    names: { tr: "İstanbul", en: "Istanbul", de: "Istanbul", fr: "Istanbul", es: "Estambul", ar: "إسطنبول", ru: "Стамбул", pt: "Istambul", it: "Istanbul", ja: "イスタンブール", ko: "이스탄불", zh: "伊斯坦布尔", nl: "Istanbul", pl: "Stambuł", sv: "Istanbul", hi: "इस्तांबुल" },
    country: { tr: "Türkiye", en: "Turkey", de: "Türkei", fr: "Turquie", es: "Turquía", ar: "تركيا", ru: "Турция", pt: "Turquia", it: "Turchia", ja: "トルコ", ko: "터키", zh: "土耳其", nl: "Turkije", pl: "Turcja", sv: "Turkiet", hi: "तुर्की" },
    emoji: "🇹🇷",
    population: "16M+",
    coordinates: { lat: 41.0082, lng: 28.9784 },
  },
  {
    slug: "berlin",
    names: { tr: "Berlin", en: "Berlin", de: "Berlin", fr: "Berlin", es: "Berlín", ar: "برلين", ru: "Берлин", pt: "Berlim", it: "Berlino", ja: "ベルリン", ko: "베를린", zh: "柏林", nl: "Berlijn", pl: "Berlin", sv: "Berlin", hi: "बर्लिन" },
    country: { tr: "Almanya", en: "Germany", de: "Deutschland", fr: "Allemagne", es: "Alemania", ar: "ألمانيا", ru: "Германия", pt: "Alemanha", it: "Germania", ja: "ドイツ", ko: "독일", zh: "德国", nl: "Duitsland", pl: "Niemcy", sv: "Tyskland", hi: "जर्मनी" },
    emoji: "🇩🇪",
    population: "3.7M+",
    coordinates: { lat: 52.52, lng: 13.405 },
  },
  {
    slug: "london",
    names: { tr: "Londra", en: "London", de: "London", fr: "Londres", es: "Londres", ar: "لندن", ru: "Лондон", pt: "Londres", it: "Londra", ja: "ロンドン", ko: "런던", zh: "伦敦", nl: "Londen", pl: "Londyn", sv: "London", hi: "लंदन" },
    country: { tr: "İngiltere", en: "United Kingdom", de: "Vereinigtes Königreich", fr: "Royaume-Uni", es: "Reino Unido", ar: "المملكة المتحدة", ru: "Великобритания", pt: "Reino Unido", it: "Regno Unito", ja: "イギリス", ko: "영국", zh: "英国", nl: "Verenigd Koninkrijk", pl: "Wielka Brytania", sv: "Storbritannien", hi: "यूनाइटेड किंगडम" },
    emoji: "🇬🇧",
    population: "9M+",
    coordinates: { lat: 51.5074, lng: -0.1278 },
  },
  {
    slug: "paris",
    names: { tr: "Paris", en: "Paris", de: "Paris", fr: "Paris", es: "París", ar: "باريس", ru: "Париж", pt: "Paris", it: "Parigi", ja: "パリ", ko: "파리", zh: "巴黎", nl: "Parijs", pl: "Paryż", sv: "Paris", hi: "पेरिस" },
    country: { tr: "Fransa", en: "France", de: "Frankreich", fr: "France", es: "Francia", ar: "فرنسا", ru: "Франция", pt: "França", it: "Francia", ja: "フランス", ko: "프랑스", zh: "法国", nl: "Frankrijk", pl: "Francja", sv: "Frankrike", hi: "फ्रांस" },
    emoji: "🇫🇷",
    population: "12M+",
    coordinates: { lat: 48.8566, lng: 2.3522 },
  },
  {
    slug: "new-york",
    names: { tr: "New York", en: "New York", de: "New York", fr: "New York", es: "Nueva York", ar: "نيويورك", ru: "Нью-Йорк", pt: "Nova York", it: "New York", ja: "ニューヨーク", ko: "뉴욕", zh: "纽约", nl: "New York", pl: "Nowy Jork", sv: "New York", hi: "न्यूयॉर्क" },
    country: { tr: "ABD", en: "United States", de: "USA", fr: "États-Unis", es: "Estados Unidos", ar: "الولايات المتحدة", ru: "США", pt: "Estados Unidos", it: "Stati Uniti", ja: "アメリカ", ko: "미국", zh: "美国", nl: "Verenigde Staten", pl: "Stany Zjednoczone", sv: "USA", hi: "अमेरिका" },
    emoji: "🇺🇸",
    population: "8.3M+",
    coordinates: { lat: 40.7128, lng: -74.006 },
  },
  {
    slug: "tokyo",
    names: { tr: "Tokyo", en: "Tokyo", de: "Tokio", fr: "Tokyo", es: "Tokio", ar: "طوكيو", ru: "Токио", pt: "Tóquio", it: "Tokyo", ja: "東京", ko: "도쿄", zh: "东京", nl: "Tokio", pl: "Tokio", sv: "Tokyo", hi: "टोक्यो" },
    country: { tr: "Japonya", en: "Japan", de: "Japan", fr: "Japon", es: "Japón", ar: "اليابان", ru: "Япония", pt: "Japão", it: "Giappone", ja: "日本", ko: "일본", zh: "日本", nl: "Japan", pl: "Japonia", sv: "Japan", hi: "जापान" },
    emoji: "🇯🇵",
    population: "14M+",
    coordinates: { lat: 35.6762, lng: 139.6503 },
  },
  {
    slug: "dubai",
    names: { tr: "Dubai", en: "Dubai", de: "Dubai", fr: "Dubaï", es: "Dubái", ar: "دبي", ru: "Дубай", pt: "Dubai", it: "Dubai", ja: "ドバイ", ko: "두바이", zh: "迪拜", nl: "Dubai", pl: "Dubaj", sv: "Dubai", hi: "दुबई" },
    country: { tr: "BAE", en: "UAE", de: "VAE", fr: "EAU", es: "EAU", ar: "الإمارات", ru: "ОАЭ", pt: "EAU", it: "EAU", ja: "UAE", ko: "UAE", zh: "阿联酋", nl: "VAE", pl: "ZEA", sv: "Förenade Arabemiraten", hi: "यूएई" },
    emoji: "🇦🇪",
    population: "3.5M+",
    coordinates: { lat: 25.2048, lng: 55.2708 },
  },
  {
    slug: "madrid",
    names: { tr: "Madrid", en: "Madrid", de: "Madrid", fr: "Madrid", es: "Madrid", ar: "مدريد", ru: "Мадрид", pt: "Madrid", it: "Madrid", ja: "マドリード", ko: "마드리드", zh: "马德里", nl: "Madrid", pl: "Madryt", sv: "Madrid", hi: "मैड्रिड" },
    country: { tr: "İspanya", en: "Spain", de: "Spanien", fr: "Espagne", es: "España", ar: "إسبانيا", ru: "Испания", pt: "Espanha", it: "Spagna", ja: "スペイン", ko: "스페인", zh: "西班牙", nl: "Spanje", pl: "Hiszpania", sv: "Spanien", hi: "स्पेन" },
    emoji: "🇪🇸",
    population: "3.3M+",
    coordinates: { lat: 40.4168, lng: -3.7038 },
  },
  {
    slug: "sao-paulo",
    names: { tr: "São Paulo", en: "São Paulo", de: "São Paulo", fr: "São Paulo", es: "São Paulo", ar: "ساو باولو", ru: "Сан-Паулу", pt: "São Paulo", it: "San Paolo", ja: "サンパウロ", ko: "상파울루", zh: "圣保罗", nl: "São Paulo", pl: "São Paulo", sv: "São Paulo", hi: "साओ पाउलो" },
    country: { tr: "Brezilya", en: "Brazil", de: "Brasilien", fr: "Brésil", es: "Brasil", ar: "البرازيل", ru: "Бразилия", pt: "Brasil", it: "Brasile", ja: "ブラジル", ko: "브라질", zh: "巴西", nl: "Brazilië", pl: "Brazylia", sv: "Brasilien", hi: "ब्राज़ील" },
    emoji: "🇧🇷",
    population: "12M+",
    coordinates: { lat: -23.5505, lng: -46.6333 },
  },
  {
    slug: "moscow",
    names: { tr: "Moskova", en: "Moscow", de: "Moskau", fr: "Moscou", es: "Moscú", ar: "موسكو", ru: "Москва", pt: "Moscou", it: "Mosca", ja: "モスクワ", ko: "모스크바", zh: "莫斯科", nl: "Moskou", pl: "Moskwa", sv: "Moskva", hi: "मॉस्को" },
    country: { tr: "Rusya", en: "Russia", de: "Russland", fr: "Russie", es: "Rusia", ar: "روسيا", ru: "Россия", pt: "Rússia", it: "Russia", ja: "ロシア", ko: "러시아", zh: "俄罗斯", nl: "Rusland", pl: "Rosja", sv: "Ryssland", hi: "रूस" },
    emoji: "🇷🇺",
    population: "13M+",
    coordinates: { lat: 55.7558, lng: 37.6173 },
  },
];
