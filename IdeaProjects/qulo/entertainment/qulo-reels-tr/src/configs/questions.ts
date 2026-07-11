// Kadının kendi tercihleriyle ilgili ikili sorular — doğru cevabı o belirler (app mekaniği).
export type SoruSpec = {
  soru: string;
  dogru: string; // kadının belirlediği doğru cevap
  yanlis: string; // elenen adayın verdiği cevap
};

export const SORULAR: readonly SoruSpec[] = [
  {soru: 'Kahve mi çay mı?', dogru: 'Kahve', yanlis: 'Çay'},
  {soru: 'Kedi mi köpek mi?', dogru: 'Kedi', yanlis: 'Köpek'},
  {soru: 'İlk buluşma: sinema mı, yürüyüş mü?', dogru: 'Yürüyüş', yanlis: 'Sinema'},
] as const;
