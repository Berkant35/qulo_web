export interface Testimonial {
  id: string;
  name: string;
  initials: string;
  city: string;
  age: number;
  rating: number;
  datePublished: string;
  quotes: Record<string, string>;
}

export const TESTIMONIALS: Testimonial[] = [
  {
    id: "1", name: "Elif K.", initials: "EK", city: "Istanbul", age: 27, rating: 5, datePublished: "2026-02-10",
    quotes: {
      tr: "Swipe'dan bıkmıştım. Qulo'da sorularımla eşleşen biri ile artık ciddi bir ilişkim var. Gerçekten farklı bir deneyim!",
      en: "I was tired of swiping. Now I'm in a serious relationship with someone who matched my questions on Qulo. A truly different experience!",
    },
  },
  {
    id: "2", name: "Lukas M.", initials: "LM", city: "Berlin", age: 30, rating: 5, datePublished: "2026-02-18",
    quotes: {
      tr: "Qulo'nun en sevdiğim yanı, eşleştiğim kişiyle hemen doğru konuşmaya başlayabilmem. Sorular buzu kırıyor.",
      en: "What I love most about Qulo is being able to immediately have real conversations. Questions break the ice naturally.",
      de: "Was ich an Qulo liebe: Man kann sofort echte Gespräche führen. Fragen brechen das Eis.",
    },
  },
  {
    id: "3", name: "Sophie R.", initials: "SR", city: "Paris", age: 25, rating: 5, datePublished: "2026-03-01",
    quotes: {
      tr: "Tinder ve Bumble'da yüzeysel eşleşmelerden sıkılmıştım. Qulo derin bağlantılar kurmama yardım etti.",
      en: "I was bored of superficial matches on Tinder and Bumble. Qulo helped me build deeper connections.",
      fr: "J'étais fatiguée des matchs superficiels sur Tinder et Bumble. Qulo m'a aidée à créer des liens plus profonds.",
    },
  },
  {
    id: "4", name: "Carlos G.", initials: "CG", city: "Madrid", age: 32, rating: 5, datePublished: "2026-03-05",
    quotes: {
      tr: "Qulo'nun kişilik tabanlı eşleşmesi sayesinde 3 hafta içinde 2 gerçek buluşmaya çıktım. Swipe'ta aylarca bu olmuyordu!",
      en: "Thanks to Qulo's personality-based matching, I had 2 real dates in 3 weeks. That never happened on swipe apps!",
      es: "Gracias al matching basado en personalidad de Qulo, tuve 2 citas reales en 3 semanas.",
    },
  },
  {
    id: "5", name: "Yuki T.", initials: "YT", city: "Tokyo", age: 28, rating: 4, datePublished: "2026-03-10",
    quotes: {
      tr: "İçe dönük biri olarak Qulo benim için mükemmel. Sorular aracılığıyla gerçek beni gösterme şansı var.",
      en: "As an introvert, Qulo is perfect for me. I can show the real me through questions.",
    },
  },
  {
    id: "6", name: "Ahmed S.", initials: "AS", city: "Dubai", age: 34, rating: 5, datePublished: "2026-03-15",
    quotes: {
      tr: "Uluslararası dating için harika. 16 dil desteği sayesinde farklı ülkelerden insanlarla tanışıyorum.",
      en: "Great for international dating. Thanks to 16 language support, I meet people from different countries.",
    },
  },
  {
    id: "7", name: "Maria L.", initials: "ML", city: "São Paulo", age: 29, rating: 5, datePublished: "2026-03-20",
    quotes: {
      tr: "Quiz dating konsepti başta garip geldi ama şimdi bayılıyorum. Daha az ama daha kaliteli eşleşmeler.",
      en: "The quiz dating concept seemed strange at first but now I love it. Fewer but higher-quality matches.",
      pt: "O conceito de quiz dating pareceu estranho no início, mas agora eu adoro.",
    },
  },
  {
    id: "8", name: "Oliver W.", initials: "OW", city: "London", age: 31, rating: 5, datePublished: "2026-03-25",
    quotes: {
      tr: "Ghosting oranı inanılmaz düşük. İnsanlar soruları çözmek için çaba sarf ettiği için iletişim devam ediyor.",
      en: "Ghosting rate is incredibly low. Because people put effort into solving questions, communication continues.",
    },
  },
  {
    id: "9", name: "Chen W.", initials: "CW", city: "Istanbul", age: 26, rating: 4, datePublished: "2026-03-28",
    quotes: {
      tr: "Qulo'da geçirdiğim zaman daha kaliteli. Boşa harcanmış swipe değil, anlamlı soru çözmeler.",
      en: "Time spent on Qulo is higher quality. Not wasted swipes, but meaningful question solving.",
    },
  },
  {
    id: "10", name: "Emma T.", initials: "ET", city: "New York", age: 33, rating: 5, datePublished: "2026-04-01",
    quotes: {
      tr: "Burada eşleştiklerim arkadaşımın arkadaşı olabilecek kalitede insanlar. Algoritma gerçekten iyi çalışıyor.",
      en: "The people I match here are the kind who could be my friend's friends. The algorithm works really well.",
    },
  },
  {
    id: "11", name: "Noah K.", initials: "NK", city: "Berlin", age: 28, rating: 5, datePublished: "2026-04-03",
    quotes: {
      tr: "Quiz dating sayesinde ilk mesajlaşma aşamasını geçmek çok kolay. 'Naber' demekten çok daha iyisini yapabiliyorsun.",
      en: "Thanks to quiz dating, the initial messaging stage is very easy. You can do much better than 'what's up'.",
      de: "Dank Quiz-Dating ist die erste Messaging-Phase sehr einfach.",
    },
  },
  {
    id: "12", name: "Ayse T.", initials: "AT", city: "Istanbul", age: 24, rating: 5, datePublished: "2026-04-05",
    quotes: {
      tr: "Qulo'da profilime gelen sorular o kadar eğlenceli ki, uygulamayı açmak için bahane arıyorum!",
      en: "The questions coming to my Qulo profile are so fun, I look for excuses to open the app!",
    },
  },
];
