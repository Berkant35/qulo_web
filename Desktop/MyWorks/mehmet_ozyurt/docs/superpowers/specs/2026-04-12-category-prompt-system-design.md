# Tabul Category Prompt System — Design Spec

**Tarih:** 2026-04-12
**Branch:** APP-1915
**Durum:** Onaylandı

---

## Ozet

Kullanicilarin chip-bazli kategori secimi ile hizli prompt olusturmasini saglayan, server-driven, localize edilmis kategori sistemi. Main category + sonsuz derinlikte sub category destegi, 2 adimli stepper UI, admin panelde CRUD yonetimi.

---

## 1. Veritabani

### Tablo: `tabul_categories`

| Kolon | Tip | Aciklama |
|-------|-----|----------|
| `id` | UUID | PK, `gen_random_uuid()` |
| `parent_id` | UUID (nullable) | FK → `tabul_categories.id`. NULL = main category |
| `names` | JSONB | `{"tr": "Film & Dizi", "en": "Movies & Series", ...}` |
| `prompts` | JSONB | `{"tr": "Film dunyasindan tabul kartlari olustur", ...}` |
| `sort_order` | INTEGER | Default 0, siralama icin |
| `is_active` | BOOLEAN | Default true, soft delete / gizleme |
| `is_trending` | BOOLEAN | Default false, trend badge icin |
| `created_at` | TIMESTAMPTZ | Default `now()` |
| `updated_at` | TIMESTAMPTZ | Default `now()` |

### Kurallar

- `parent_id = NULL` → Main category
- `parent_id = <id>` → O ID'nin sub category'si
- Sonsuz derinlik: sub'in sub'i olabilir (recursive tree, `parent_id` self-referencing)
- `names` ve `prompts` JSONB — desteklenmeyen dil icin fallback: `en`, yoksa ilk key
- `sort_order` ile admin siralama yapabilir
- `is_active = false` ile silmeden gizleme

### Ornek Veri

```json
// Main category
{"id": "aaa", "parent_id": null, "names": {"tr": "Film & Dizi", "en": "Movies"}, "prompts": {"tr": "Film ve dizi dunyasindan tabul kartlari olustur"}, "sort_order": 1, "is_trending": false}

// Sub category
{"id": "bbb", "parent_id": "aaa", "names": {"tr": "Netflix Yapimlari", "en": "Netflix Originals"}, "prompts": {"tr": "Netflix orijinal yapimlarindan tabul kartlari olustur"}, "sort_order": 1, "is_trending": false}

// Sub-sub category
{"id": "ccc", "parent_id": "bbb", "names": {"tr": "Stranger Things", "en": "Stranger Things"}, "prompts": {"tr": "Stranger Things dizisinin karakter ve olaylarindan tabul kartlari olustur"}, "sort_order": 1, "is_trending": true}
```

---

## 2. Server API

### 2.1 Public Endpoint — Kategorileri Cek

```
GET /api/categories?locale=tr
```

**Response:**
```json
{
  "version": "3.5.0",
  "success": true,
  "data": {
    "locale": "tr",
    "categories": [
      {
        "id": "aaa",
        "name": "Film & Dizi",
        "prompt": "Film ve dizi dunyasindan tabul kartlari olustur",
        "sortOrder": 1,
        "isTrending": false,
        "children": [
          {
            "id": "bbb",
            "name": "Netflix Yapimlari",
            "prompt": "Netflix orijinal yapimlarindan tabul kartlari olustur",
            "sortOrder": 1,
            "isTrending": false,
            "children": []
          }
        ]
      }
    ]
  },
  "message": "Categories fetched successfully"
}
```

**Mantik:**
1. Supabase'den tum `is_active = true` kayitlari cek (tek sorgu, flat list)
2. `locale` key'ine gore `names[locale]` → `name`, `prompts[locale]` → `prompt` map'le
3. Locale bulunamazsa fallback: `en` → yoksa ilk key
4. Flat list'i `parent_id` ile recursive tree'ye donustur
5. `sort_order`'a gore sirala

### 2.2 Admin Endpoints — Kategori CRUD

Tum admin endpoint'ler `requireAdminAuth` middleware arkasinda.

```
GET    /api/admin/categories          → Tum kategoriler (tum diller, flat list)
POST   /api/admin/categories          → Yeni kategori olustur
PATCH  /api/admin/categories/:id      → Guncelle (names, prompts, sort, trending)
DELETE /api/admin/categories/:id       → Sil (soft: is_active=false)
PATCH  /api/admin/categories/reorder   → Toplu siralama guncelle
```

**POST/PATCH Body:**
```json
{
  "parentId": "aaa",
  "names": {"tr": "Netflix Yapimlari", "en": "Netflix Originals"},
  "prompts": {"tr": "Netflix orijinal yapimlarindan...", "en": "From Netflix originals..."},
  "sortOrder": 2,
  "isTrending": false
}
```

**Kurallar:**
- DELETE: Cocuklari olan kategori silinmeye calisilirsa hata don (`HAS_CHILDREN`)
- Admin GET'te tum diller donulur (JSONB oldugu gibi)
- Public GET'te sadece istenen locale

---

## 3. Admin Panel (Web UI)

`tabul_server/public/admin-categories.html` dosyasi olarak eklenir.

### Ozellikler

- Mevcut admin auth sistemi kullanilir (JWT + `admin_users` tablosu)
- Nested tree gorunumu — her node'un altinda sub category'ler
- Her node icin: isim (tum diller), prompt (tum diller), sort_order, is_trending, is_active
- Yeni kategori ekleme: parent secimi (dropdown/tree), dil bazli isim ve prompt girisi
- Duzenleme: inline edit veya modal
- Silme: soft delete (is_active toggle), cocugu varsa uyari
- Siralama: drag-drop veya sort_order input

---

## 4. Client (Flutter)

### 4.1 Dosya Yapisi

```
lib/feature/home/
├── data/
│   ├── dto/
│   │   └── tabul_category_dto.dart
│   └── repo/
│       └── card_repo.dart                 // +getCategories(locale) eklenir
├── bloc/
│   └── cubit/
│       └── category_cubit.dart            // HydratedCubit — fetch, cache, toggle, prompt build
└── view/
    └── widgets/
        └── sheets/
            ├── create_own_tabul_sheet.dart // Stepper controller'a donusur
            ├── category_step_widget.dart   // Adim 1: Kategori secimi
            └── prompt_step_widget.dart     // Adim 2: Prompt duzenleme
```

### 4.2 DTO

```dart
@freezed
class TabulCategoryDto {
  const factory TabulCategoryDto({
    String? id,
    String? name,
    String? prompt,
    int? sortOrder,
    @Default(false) bool isTrending,
    @Default([]) List<TabulCategoryDto> children,
  }) = _TabulCategoryDto;
}
```

### 4.3 CategoryCubit (HydratedCubit)

**State alanlari:** `status`, `categories`, `selectedCategories`, `builtPrompt`, `currentLocale`

**Metodlar:**

- `fetchCategories(String locale)` → `CardRepo.getCategories(locale)` → basarili: cache'le + emit, hata: cache varsa onu kullan
- `toggleCategory(TabulCategoryDto category)` → selected'a ekle/cikar, builtPrompt'u yeniden hesapla
- `buildPrompt()` → secili kategorilerin prompt'larini topla
- `resetSelection()` → tum secimleri temizle

### 4.4 Prompt Build Mantigi

Her main category agacinda, secili en derin node'un prompt'u kullanilir. Ayni agacta birden fazla sub seciliyse hepsi eklenir. Farkli main category'ler arasi prompt'lar birlestirilir.

**Ornek:**
```
Secili: [Film(main), Netflix(sub), Spor(main), NBA(sub), LeBron(sub-sub)]

Build:
1. Film grubunda en derin secimler: Netflix → "Netflix yapimlarindan..."
2. Spor grubunda en derin secim: LeBron → "LeBron James hakkinda..."
3. Birlestir: "Netflix yapimlarindan tabul kartlari olustur. LeBron James hakkinda tabul kartlari olustur"
```

**Kural:** Sub category secildiginde, parent'in prompt'u sub'in prompt'u ile override edilir. Sub kaldirildiginda parent'in orijinal prompt'u geri gelir.

### 4.5 UI Akisi — 2 Adimli Stepper

#### Adim 1 — Kategori Secimi (`CategoryStepWidget`)

- Ustte: "Direkt yaz →" link butonu (Adim 2'ye atlar, kategorisiz)
- Main category chip'leri (horizontal scroll, text-only, secili olanlarda checkmark)
- Secili main'in alt kategorileri (accordion/expandable, recursive render)
- Alt kisimda secili tag'ler ozeti
- "Devam →" butonu (en az 1 kategori seciliyse aktif)

#### Adim 2 — Prompt Duzenleme (`PromptStepWidget`)

- Ustte secili kategori tag'leri (readonly chip'ler)
- Prompt input alani — kategorilerden olusan prompt pre-filled, kullanici duzenleyebilir
- Karakter sayaci
- Kart sayisi secimi (Bronze/Silver/Gold) — mevcut mantik
- "← Geri" butonu (Adim 1'e doner, prompt sifirlanir, kategorilerden yeniden build edilir)
- "TabuL'unu Olustur" butonu

#### "Direkt Yaz" Akisi

- Adim 1'de "Direkt yaz →" tiklandiginda Adim 2'ye atlanir
- Prompt alani bos gelir, kullanici serbest yazar
- Mevcut min 20 / max 500 karakter kurali gecerli
- Geri butonuyla Adim 1'e donebilir

### 4.6 Mevcut Akisa Entegrasyon

- `CreateOwnTabulSheet` → stepper controller olur (`currentStep: 0 veya 1`)
- `GenerateTabulCardCubit.generateCardByCondition(prompt)` → degismez
- `GenerateCardParam` → degismez, prompt string olarak gider
- Server tarafi generate akisi → degismez
- Sadece prompt'un olusturulma sekli degisiyor (serbest metin → kategori-bazli + duzenleme)

### 4.7 Cache ve Offline

- App acilisinda `CategoryCubit.fetchCategories(locale)` cagrilir
- Dil degistiginde `LocaleCubit` listener'i tetikler → yeni locale ile re-fetch
- Internet yoksa: cache'deki kategoriler gosterilir (varsa), yoksa kategoriler bos, sadece "direkt yaz" aktif
- Internet yoksa: "TabuL'unu Olustur" butonu disabled + "Internet baglantisi gerekli" mesaji
- Cache stratejisi: `HydratedBloc` ile locale bazli son basarili fetch saklanir

---

## 5. Degismeyen Kisimlar

- `GenerateTabulCardCubit` → prompt alir, generate eder (ayni)
- `GenerateCardParam` → prompt, cardCount, language, model (ayni)
- `ApiService.generateCards()` → ayni endpoint, ayni body
- Server `POST /api/generate-cards` → ayni mantik
- Kredi sistemi → ayni
- Kaydetme akisi → ayni

---

## 6. Kapsam Disi

- Kategori bazli istatistik/analytics (ileride eklenebilir)
- Kategori bazli populerlik siralama (ileride `is_trending` ile baslatildi)
- Kullanici bazli favori kategoriler
- Kategori ikonlari/gorselleri (simdilik text-only chip, ileride eklenebilir)
