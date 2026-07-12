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

// Varyant A "Ters Köşe" — erkek perspektifi soru seti.
export const SORULAR_ERKEK: readonly SoruSpec[] = [
  {soru: 'Plak mı playlist mi?', dogru: 'Plak', yanlis: 'Playlist'},
  {soru: 'Dağ mı deniz mi?', dogru: 'Dağ', yanlis: 'Deniz'},
  {soru: 'Pizza mı sushi mi?', dogru: 'Pizza', yanlis: 'Sushi'},
] as const;

// Varyant E "TV Yarışması" — TR flört draması mizahı (keskin soru kuralı).
export const SORULAR_SOV: readonly SoruSpec[] = [
  {soru: 'Evli misin?', dogru: 'Hayır!', yanlis: 'Ayrılmak üzereyiz'},
  {soru: 'Aynı anda kaç kişiyle yazışıyorsun?', dogru: 'Sadece seninle', yanlis: 'Üç... belki dört'},
  {soru: 'Eski sevgilin numaranı biliyor mu?', dogru: 'Engelledim', yanlis: 'Dün aradı'},
] as const;

// Varyant H "Kalabalık Yalnızlığı" — TR flört draması mizahı (keskin soru kuralı).
export const SORULAR_PARTI: readonly SoruSpec[] = [
  {soru: 'Gerçekten bekâr mısın?', dogru: 'Evet, gerçekten', yanlis: 'Karmaşık'},
  {soru: 'Buradaki kaç kişiye mesaj attın?', dogru: 'Kimseye', yanlis: 'Saymadım'},
] as const;
