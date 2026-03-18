# Discover Card Photo Browse — Design Spec

## Overview

Discover kartında kullanıcının tüm fotoğraflarını Tinder tarzı tap-to-navigate ile gezme. Şu an sadece ilk fotoğraf gösteriliyor — bu özellik kartın fotoğraf alanını `PageView` tabanlı galeriye dönüştürüyor.

## Mevcut Durum

- `ProfileCard` widget'ı `card.photos!.first` ile tek fotoğraf gösteriyor
- `DiscoverCardView` kartın tamamına `onTap` → profil detay navigasyonu bağlı
- `ProfilePhotoGallery` widget'ı profil detayda zaten tap-to-navigate + progress bar mantığı ile çalışıyor
- Test kullanıcılarına 2-5 arası fotoğraf eklendi (randomuser.me)

## Tasarım

### Fotoğraf Galerisi

`ProfileCard` widget'ının fotoğraf alanı tek `CachedNetworkImage` yerine `PageView.builder` olacak:

- **Tap geçişi:** Kartın sağ yarısına tap → sonraki foto, sol yarısına tap → önceki foto
- **Progress bar'lar:** Kartın üst kısmında ince beyaz çubuklar (aktif = opak, diğerleri = %40 opaklık)
- **Tek fotoğraf:** Bar'lar ve tap alanları gizli, şu anki gibi çalışır
- **Animasyon:** 300ms `easeInOut` page transition (mevcut `ProfilePhotoGallery` ile aynı)

### Tap Alanları Ayrımı

Mevcut durumda `DiscoverCardView` kartın tamamına `onTap: _navigateToProfile` bağlıyor. Bu değişecek:

| Alan | Tap Aksiyonu |
|------|-------------|
| Fotoğraf alanı (Stack'in üstü) | Fotoğraf geçişi (sol/sağ yarı) |
| Info alanı (alt ~%30 — isim, yaş, şehir, sorular) | Profil detay ekranına git |

**Uygulama:** `DiscoverCardView`'daki `onTap: _navigateToProfile` kaldırılacak. Bunun yerine:
- `ProfileCard` fotoğraf tap'lerini kendi içinde yönetecek (PageView)
- `ProfileCard` info bölümüne ayrı bir `onInfoTap` callback'i eklenecek → profil detaya git
- `DiscoverCardView` bu callback'i `ProfileCard`'a geçirecek (`_isProcessing` guard callback tarafında kalır)
- Info bölümü: `Positioned(bottom)` info widget'ının tamamı `GestureDetector` ile sarılır (dinamik yükseklik — sabit yüzde değil)

### Swipe Çakışması

Fotoğraf geçişi **tap** bazlı, discover swipe **horizontal drag** bazlı — çakışma yok. `PageView`'ın kendi swipe gesture'ını devre dışı bırakacağız (`physics: NeverScrollableScrollPhysics()`) çünkü yatay swipe discover reject/like için kullanılıyor.

### Widget Değişiklikleri

**`ProfileCard` (değişecek):**
- `StatelessWidget` → `StatefulWidget` (PageController için)
- Tek `CachedNetworkImage` → `PageView.builder` + `CachedNetworkImage`
- Progress bar overlay eklenir (üst kısım)
- `onInfoTap` callback parametresi eklenir
- Info bölümü `GestureDetector` ile sarılır

**`DiscoverCardView` (minimal değişiklik):**
- `GestureDetector.onTap` kaldırılır
- `ProfileCard`'a `onInfoTap: _navigateToProfile` geçilir

### Dosya Yapısı

Mevcut dosyalar değiştirilecek, yeni dosya oluşturulmayacak:

| Dosya | Değişiklik |
|-------|-----------|
| `lib/features/discover/widgets/profile_card.dart` | PageView galerisi + progress bar + onInfoTap callback |
| `lib/features/discover/widgets/discover_card_view.dart` | onTap kaldır, onInfoTap callback geçir |

### Neden ProfilePhotoGallery Yeniden Kullanılmıyor?

`ProfilePhotoGallery` profil detay ekranı için tasarlandı — close butonu, photo counter, sabit %55 yükseklik, SafeArea padding'leri var. Discover kartı tamamen farklı bir layout: tam kart boyutu, gradient overlay, üstünde info katmanı. Galeri mantığı (PageView + tap + bar) basit olduğundan kopyalamak yerine `ProfileCard` içine inline yazılacak (~30 satır ekleme). Ortak widget çıkarmak overengineering olur.

### Teknik Detaylar

- **Tap pozisyon hesabı:** `onTapUp` → `details.localPosition.dx` kullanılacak (widget genişliğinin yarısına göre karşılaştır). `globalPosition` kullanılmayacak çünkü kart `Transform` ve `Padding` içinde — global koordinatlar yanlış sonuç verir.
- **Kart değişimi:** `ProfileCard`'a `ValueKey(card.userId)` verilecek — swipe sonrası yeni kart geldiğinde `PageController` state'i sıfırlanır, eski fotoğraf indexi yeni karta taşınmaz.
- **Progress bar pozisyonu:** Kartın üst kenarından `AppSpacing.sm` mesafe (SafeArea padding kullanılmayacak, kart zaten page padding içinde).
- **Navigasyon sonrası state:** Profil detaya gidip geri dönüldüğünde fotoğraf indexi korunur (Flutter'ın varsayılan StatefulWidget davranışı).

### Edge Case'ler

- **photos null veya boş:** Mevcut placeholder (user icon) gösterilir, bar yok
- **Tek fotoğraf:** Bar gizli, tap geçişi devre dışı — şu anki davranış korunur
- **6+ fotoğraf:** Bar margin'i daralır (1px), `ProfilePhotoGallery`'deki pattern
- **Fotoğraf yüklenirken:** `CachedNetworkImage` placeholder gösterir (mevcut davranış)
- **Drag sırasında tap:** `_isProcessing` guard fotoğraf tap'lerini de engelleyecek (callback üzerinden)
