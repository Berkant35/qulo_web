# Qulo Reels Varyant K2 — "Kadıköy Kedileri" (30sn, yeni kast + Kadıköy ortamları)

Altyapı: `entertainment/qulo-reels-tr`. Global kurallar + keskin soru + kast rotasyonu kuralı (memory feedback_qulo_ad_character_rotation) geçerli.
Konsept: Kadıköy'de yaşayan kadının jürisi mahallenin sokak kedileri. Üç yeni arketip aday sırayla dener: zengin "erko" (lüks araba övünmesi), kaslı spor salonu tipi, İtalyan stili şık erkek. Kedileri ve soruları geçemeyen elenir. Mizah + yerel doku.
Süre: 900f (30sn), müzik music_30s.mp3 (mevcut).
POLİCY: kadın çekici ama giyinik/zarif; kaslı adam giyinik (fitted t-shirt); araba MARKASI/LOGOSU ASLA görünmez (anahtarlık + tip anlatır).

## Soru seti (questions.ts — SoruSpec formatı)
```ts
export const KADIKOY_SORULARI: readonly SoruSpec[] = [
  {soru: 'İlk buluşmada nereye gidiyoruz?', dogru: 'Moda sahiline', yanlis: 'Arabamla tur atarız'},
  {soru: 'En uzun ilişkin?', dogru: '3 yıl', yanlis: 'Spor salonuyla, 5 yıl'},
  {soru: 'Kediler mi, ben mi?', dogru: 'İkiniz de', yanlis: 'Tabii ki sen'},
];
```
Aday 1 (erko_zengin) → yanlis çip ✗ → kediler ret → yırtılma+ELENDİ. Aday 2 (erko_kasli) → yanlis ✗ → kediler esner → ELENDİ. Aday 3 (italyan) → dogru ✓ "İkiniz de" → kediler kalp → eşleşme (w4+italyan).

## Asset (Gemini — 9 adet)
BG_GUN_SUFFIX (yeni, manifest'e): full-bleed 9:16 plate, retro 1960s B&W STREET photography + halftone, bright daylight, empty of people, no text.
| id | içerik | aspect | suffix |
|----|--------|--------|--------|
| bg_kadikoy | grafitili/duvar resimli dar Kadıköy sokağı, cumbalı binalar, kafe masaları, gündüz; İNSANSIZ | 9:16 | BG_GUN |
| bg_moda | Moda sahili: korkuluk, deniz, uzak ada silueti, martı siluetleri, gündüz; İNSANSIZ | 9:16 | BG_GUN |
| w4 | YENİ kadın: glamour, uzun dalgalı saç, şık midi yazlık elbise, topuklu, özgüvenli poz, çekici gülümseme | 2:3 | STYLE |
| erko_zengin | 30'lar erkek: blazer + açık yaka gömlek, güneş gözlüğü elinde, DİĞER elinde araba anahtarlığı sallıyor, kendini beğenmiş sırıtış; LOGO YOK | 2:3 | STYLE |
| erko_kasli | kaslı erkek: dar fitted t-shirt (GİYİNİK), kollar kavuşuk kaslar belirgin, kendinden emin | 2:3 | STYLE |
| italyan | Akdeniz/İtalyan stili şık erkek: keten takım/gömlek, düzgün taranmış saç, zarif duruş, sıcak karizmatik gülümseme, elinde küçük espresso fincanı | 2:3 | STYLE |
| kedi_tekir | oturan tekir sokak kedisi, yargılayan ciddi bakış, kamera bakışı | 1:1 | CAT (yeni: tek hayvan sticker, beyaz kontur, yeşil fon, insan yok) |
| kedi_sarman | esneyen/sıkılmış sarman kedi | 1:1 | CAT |
| kedi_sb | siyah-beyaz smokin kedi, bir patisi havada (onay jesti), sevimli | 1:1 | CAT |

## Animatik + lüks araç eklentileri (kullanıcı isteği, 2026-07-12)
- `SpriteFlip` {frames: string[], x, y, width, frameDuration?: number (default 8), startFrame?, loop?: boolean}: poz görsellerini ardı ardına oynatır (stop-motion animatik). Deterministik.
- Kedi aksiyon setleri üretildi: kedi_X + kedi_X_bagir + kedi_X_pati (3 kedi × 3 poz). CatJury reject/approve reaksiyonları SpriteFlip ile: reject = taban→bagir→pati→bagir (8f/poz, 2 tur); approve = taban→bagir(sevinç)→pati(havada)→loop.
- Lüks araç: erko_zengin_araba (adam arabaya yaslanmış, logo YOK) — KadikoyScene1'de erko_zengin yerine BU kullanılır (width ~700, araba+adam tek sticker); prop_anahtarlik S2'de? gerekmez, yedek. prop_luks_sedan yedek/gelecek varyantlar.
- Kast kütüphanesi: CAST.md (proje kökü) — karakter/aksiyon taksonomisi; yeni aksiyonlar `<id>_<aksiyon>` + referenceOf ile eklenir.

## Yeni bileşen/sahneler
- `CatJury` {reaction: 'watch'|'reject'|'approve', reactFrame, y?}: 3 kedi sticker'ı alt bantta yan yana (width ~230, x ~250/540/830); watch: hafif idle sway (mevcut sway); reactFrame'de reject → üstlerinde ✗ baloncukları (danger, pop) + kediler kısa zıplama (translateY spring); approve → ❤ baloncukları (green) + zıplama. Deterministik.
- `KadikoyHook` (sahne): BackdropPlate(bg_kadikoy) + w4 sticker sağda + CatJury (watch) altta + başlık ['Kadıköy''de bir kız.', 'Ve üç *tüylü* jüri.'] accent purple.
- `KadikoyScene` (parametrik sahne) {bg, suspectSrc, soru: SoruSpec, correct: boolean}: BackdropPlate + QuestionCard (answer=correct?dogru:yanlis, answerTone correct?'correct':'wrong', mevcut bileşen!) üstte + aday sticker ortada + CatJury altta (reject/approve reactFrame verdict sonrası) + eliminated: aday tearFrame ile yırtılır + EliminationStamp 'ELENDİ'; correct: MatchSpark 'Eşleşme!' + w4 mini sticker slide-in soldan.
- Kapanış: S5Closing {topLine: 'Kadıköy''de kedilerin onayı şart.'}

## Config (k2.config.ts, 900f)
- KadikoyHook s(0)/s(4)
- KadikoyKurallar YOK — hook'tan direkt akış; kurallar başlığı hook'un ikinci beat'i (frame 60+: alt satır 'Sorular ondan. *Onay* kedilerden.')
- KadikoyScene1 s(4)/s(7): erko_zengin + Q1 + eliminated (bg_kadikoy)
- KadikoyScene2 s(11)/s(7): erko_kasli + Q2 + eliminated (bg_kadikoy)
- KadikoyScene3 s(18)/s(8): italyan + Q3 + correct (bg_moda! mekân değişir — sahil finali)
- S5Closing s(26)/s(4): topLine.
Toplam 120+210+210+240+120=900 ✓. Composition `QuloReelsKadikoy`.

## Görevler
1. Manifest (BG_GUN_SUFFIX + CAT_SUFFIX + 9 asset) + üretim + temizlik + KULLANICI ONAYI (ana session).
2. CatJury + KadikoyHook + KadikoyScene + KADIKOY_SORULARI + k2.config + kayıt + still + review. (Mevcut bileşen/sahnelere dokunma; BackdropPlate/EliminationStamp/QuestionCard/MatchSpark yeniden kullan.)
3. Render + kapak + deliverables 09 + birleşik + KATALOG + teslim.
Doğrulama: tsc + still + göz + commit. Git yavaş (timeout ≥300s).
