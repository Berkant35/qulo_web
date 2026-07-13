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

// Varyant P "İlgi Bombardımanı" — TR flört draması mizahı (keskin soru kuralı).
export const SORULAR_DM: readonly SoruSpec[] = [
  {soru: 'Bende en çok ne dikkatini çekti?', dogru: 'Kitap yorumların', yanlis: 'Fotoğrafların'},
  {soru: 'Kaç kişiye bu mesajı attın?', dogru: 'Sadece sana', yanlis: 'Kopyala-yapıştır'},
  {soru: 'Beni tanımak için ne sorarsın?', dogru: 'Neye güldüğünü', yanlis: 'Numaranı'},
] as const;

// Varyant R2 "Sorgu Odası" — 4 şıklı ifade sorgusu: dogruIndex adayın dürüst olsa verirdi seçilecek
// şık, secimIndex adayın panikle/kaçamakla gerçekte seçtiği şık (bkz. plan: 2026-07-12-qulo-reels-tr-variant-r2.md).
export type SorguSoru = {
  soru: string;
  siklar: readonly [string, string, string, string]; // A-D
  dogruIndex: 0 | 1 | 2 | 3; // dürüst cevap
  secimIndex: 0 | 1 | 2 | 3; // adayın seçtiği şık
};
export const SORGU_SORULARI: readonly SorguSoru[] = [
  {soru: 'Eski sevgilinizle son görüşmeniz?', siklar: ['Yıllar önce', 'Geçen hafta, kahve', 'Hatırlamıyorum', 'Hangisi?'], dogruIndex: 0, secimIndex: 3},
  {soru: 'Telefonunuzda kaç dating uygulaması var?', siklar: ['Sadece Qulo', 'İki-üç', 'Hepsi var', 'Avukatımı istiyorum'], dogruIndex: 0, secimIndex: 3},
  {soru: 'Profil fotoğrafınız kaç yıllık?', siklar: ['Geçen hafta çektim', '2-3 sene olmuştur', 'Üniversiteden', 'Askerden'], dogruIndex: 0, secimIndex: 0},
] as const;
