# Discover Card Photo Browse Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Discover kartındaki fotoğraf alanını Tinder tarzı tap-to-navigate galeriye dönüştürmek.

**Architecture:** `ProfileCard` widget'ı `StatefulWidget`'a çevrilip tek `CachedNetworkImage` yerine `PageView.builder` kullanılacak. Tap ile fotoğraf geçişi, üstte progress bar. `DiscoverCardView`'daki `onTap` kaldırılıp info bölümüne taşınacak.

**Tech Stack:** Flutter, CachedNetworkImage, PageView, Riverpod

---

## File Map

| Dosya | Değişiklik |
|-------|-----------|
| `qulov2/lib/features/discover/widgets/profile_card.dart` | StatelessWidget → StatefulWidget, PageView galeri, progress bar, onInfoTap callback |
| `qulov2/lib/features/discover/widgets/discover_card_view.dart` | GestureDetector.onTap kaldır, ProfileCard'a ValueKey + onInfoTap geçir |

---

## Task 1: ProfileCard — StatefulWidget'a çevir ve PageView galeri ekle

**Files:**
- Modify: `qulov2/lib/features/discover/widgets/profile_card.dart`

**Spec referans:** Fotoğraf Galerisi + Teknik Detaylar bölümleri

- [ ] **Step 1: ProfileCard'ı StatefulWidget'a çevir**

`ProfileCard` sınıfını `StatelessWidget` → `StatefulWidget` olarak değiştir. `_ProfileCardState` oluştur. `PageController _controller` ve `int _current = 0` state'i ekle. `dispose()`'da `_controller.dispose()` çağır. Mevcut `_photoPlaceholder()` ve `_relationshipGoalLabel()` metotlarını `_ProfileCardState` sınıfına taşı (artık instance metotları `widget.card` üzerinden erişir).

```dart
class ProfileCard extends StatefulWidget {
  final ProfileCardModel card;
  final VoidCallback? onInfoTap;
  final bool isInteractionEnabled;

  const ProfileCard({
    super.key,
    required this.card,
    this.onInfoTap,
    this.isInteractionEnabled = true,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final PageController _controller = PageController();
  int _current = 0;

  List<String> get _photos => widget.card.photos ?? [];
  bool get _hasMultiplePhotos => _photos.length > 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    if (page < 0 || page >= _photos.length) return;
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  // ...
}
```

- [ ] **Step 2: Tek CachedNetworkImage'ı PageView.builder ile değiştir**

Build metodundaki fotoğraf gösterimini değiştir. `_photos` boşsa mevcut placeholder'ı göster. Doluysa `PageView.builder` + `NeverScrollableScrollPhysics()` + `CachedNetworkImage`. Tap handler'da `details.localPosition.dx` kullan, `context.size!.width / 2` ile karşılaştır.

```dart
// Stack içinde, mevcut tek CachedNetworkImage yerine:
if (_photos.isEmpty)
  _photoPlaceholder(theme)
else
  PageView.builder(
    controller: _controller,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _photos.length,
    onPageChanged: (i) => setState(() => _current = i),
    itemBuilder: (context, index) {
      return GestureDetector(
        onTapUp: _hasMultiplePhotos && widget.isInteractionEnabled
            ? (details) {
                final width = context.size?.width ?? MediaQuery.of(context).size.width;
                final half = width / 2;
                if (details.localPosition.dx > half) {
                  _goTo(_current + 1);
                } else {
                  _goTo(_current - 1);
                }
              }
            : null,
        child: CachedNetworkImage(
          imageUrl: _photos[index],
          fit: BoxFit.cover,
          placeholder: (_, __) => _photoPlaceholder(theme),
          errorWidget: (_, __, ___) => _photoPlaceholder(theme),
        ),
      );
    },
  ),
```

- [ ] **Step 3: Progress bar overlay ekle**

Stack'e `_photos.length > 1` koşuluyla progress bar `Positioned` widget'ı ekle. Kartın üst kenarından `AppSpacing.sm` mesafe. Her bar `Expanded`, aktif olan `Colors.white`, diğerleri `Colors.white.withValues(alpha: 0.4)`. 6+ fotoğrafta margin 1px, altında 2px.

```dart
// Stack children'a ekle (gradient'ten sonra, info'dan önce):
if (_hasMultiplePhotos)
  Positioned(
    top: AppSpacing.sm,
    left: AppSpacing.lg,
    right: AppSpacing.lg,
    child: Row(
      children: List.generate(_photos.length, (i) {
        return Expanded(
          child: Container(
            height: 3,
            margin: EdgeInsets.symmetric(
              horizontal: _photos.length > 6 ? 1 : 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: i == _current
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.4),
            ),
          ),
        );
      }),
    ),
  ),
```

- [ ] **Step 4: Info bölümünü GestureDetector ile sar**

Mevcut `Positioned(left, right, bottom)` info `Column`'u `GestureDetector` ile sarılacak. `onTap: widget.onInfoTap`.

```dart
Positioned(
  left: AppSpacing.lg,
  right: AppSpacing.lg,
  bottom: AppSpacing.lg,
  child: GestureDetector(
    onTap: widget.onInfoTap,
    behavior: HitTestBehavior.translucent,
    child: Column(
      // ... mevcut info içeriği aynen kalır
    ),
  ),
),
```

- [ ] **Step 5: Flutter analyze çalıştır**

Run: `cd qulov2 && flutter analyze lib/features/discover/widgets/profile_card.dart`
Expected: No issues found

---

## Task 2: DiscoverCardView — onTap kaldır, onInfoTap + ValueKey geçir

**Files:**
- Modify: `qulov2/lib/features/discover/widgets/discover_card_view.dart`

**Spec referans:** Tap Alanları Ayrımı + Teknik Detaylar (ValueKey)

- [ ] **Step 1: GestureDetector.onTap kaldır**

`discover_card_view.dart`'daki dıştaki `GestureDetector`'un `onTap: _isProcessing ? null : _navigateToProfile` parametresini kaldır. Bu parametre `GestureDetector`'dan silinecek (horizontal drag handler'lar kalacak).

```dart
// Önceki:
GestureDetector(
  onTap: _isProcessing ? null : _navigateToProfile,
  onHorizontalDragUpdate: _onHorizontalDragUpdate,
  onHorizontalDragEnd: _onHorizontalDragEnd,
  // ...

// Sonraki:
GestureDetector(
  onHorizontalDragUpdate: _onHorizontalDragUpdate,
  onHorizontalDragEnd: _onHorizontalDragEnd,
  // ...
```

- [ ] **Step 2: ProfileCard'a ValueKey ve onInfoTap geçir**

Stack children'daki `ProfileCard(card: widget.card)` satırını güncelle:

```dart
// Önceki:
ProfileCard(card: widget.card),

// Sonraki:
ProfileCard(
  key: ValueKey(widget.card.userId),
  card: widget.card,
  onInfoTap: _isProcessing ? null : _navigateToProfile,
  isInteractionEnabled: !_isProcessing,
),
```

- [ ] **Step 3: Flutter analyze çalıştır**

Run: `cd qulov2 && flutter analyze lib/features/discover/widgets/discover_card_view.dart`
Expected: No issues found

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/discover/widgets/profile_card.dart qulov2/lib/features/discover/widgets/discover_card_view.dart
git commit -m "feat: add photo browse to discover card — tap-to-navigate with progress bars"
```

---

## Task 3: Manuel Test

- [ ] **Step 1: Uygulamayı "Local Dev" run config ile başlat (full rebuild)**

IntelliJ'den "Local Dev" run config seç ve çalıştır. `dart-define` compile-time sabiti olduğundan hot restart yetmez.

- [ ] **Step 2: Test senaryoları**

| Senaryo | Beklenen |
|---------|----------|
| Çoklu fotoğraflı kart | Üstte progress bar'lar görünür, sağ tap → sonraki, sol tap → önceki |
| Tek fotoğraflı kart | Bar yok, tap'te hiçbir şey olmaz |
| Fotoğrafsız kart | Placeholder icon, bar yok |
| İlk fotoğraftayken sol tap | Hiçbir şey olmaz (sınır kontrolü) |
| Son fotoğraftayken sağ tap | Hiçbir şey olmaz (sınır kontrolü) |
| Info alanına tap | Profil detay ekranı açılır |
| Sağa swipe (horizontal drag) | Quiz ekranına gider (değişmedi) |
| Sola swipe | Reject animasyonu (değişmedi) |
| Swipe sonrası yeni kart | Fotoğraf index'i 0'dan başlar (ValueKey) |
| Profil detaya gidip geri dön | Fotoğraf index'i korunur |
| Swipe animasyonu sırasında fotoğraf tap | Hiçbir şey olmaz (isInteractionEnabled: false) |
| Kategori chip'lerini yatay scroll | Scroll çalışır, info tap tetiklenmez |
