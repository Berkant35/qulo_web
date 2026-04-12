# Tabul Category Prompt System — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Server-driven, localize edilmis kategori sistemiyle kullanicilarin chip-bazli secimlerle hizli AI prompt olusturmasini saglamak.

**Architecture:** Supabase `tabul_categories` tablosu (JSONB locale), Node.js Express API (public + admin CRUD), Flutter client (CategoryCubit HydratedCubit + 2-adimli stepper bottom sheet). Mevcut generate akisi degismez — sadece prompt'un olusturulma sekli degisiyor.

**Tech Stack:** Supabase PostgreSQL (JSONB), Node.js + Express + @supabase/supabase-js, Flutter + flutter_bloc + hydrated_bloc + freezed + retrofit + dartz

---

## File Map

### Server (tabul_server/)

| File | Action | Purpose |
|------|--------|---------|
| `server.js` | Modify | Supabase client init, category endpoints (public + admin CRUD), admin auth middleware |
| `package.json` | Modify | Add `@supabase/supabase-js` dependency |
| `public/admin-categories.html` | Create | Admin panel UI — nested tree CRUD, multi-locale form |

### Client (tabul/lib/)

| File | Action | Purpose |
|------|--------|---------|
| `feature/home/data/dto/tabul_category_dto.dart` | Create | Freezed DTO for category tree |
| `feature/home/data/dto/categories_response_dto.dart` | Create | Wrapper DTO for categories response |
| `feature/home/data/repo/card_repo.dart` | Modify | Add `getCategories(locale)` method |
| `feature/home/bloc/cubit/category_cubit.dart` | Create | HydratedCubit — fetch, cache, toggle, prompt build |
| `feature/home/bloc/state/category_state.dart` | Create | Freezed state — categories, selected, builtPrompt |
| `feature/home/view/widgets/sheets/create_own_tabul_sheet.dart` | Modify | 2-adimli stepper controller'a donustur |
| `feature/home/view/widgets/sheets/category_step_widget.dart` | Create | Adim 1: Kategori chip secimi |
| `feature/home/view/widgets/sheets/prompt_step_widget.dart` | Create | Adim 2: Prompt duzenleme |
| `core/service/server/api_service.dart` | Modify | Add `getCategories()` Retrofit endpoint |
| `core/service/server/tabul_server_api_endpoints.dart` | Modify | Add categories endpoint constant |
| `core/injection/locator.dart` | Modify | Register CategoryCubit |
| `l10n/intl_tr.arb` | Modify | Add category UI keys |
| `l10n/intl_en.arb` | Modify | Add category UI keys |

---

## Task 1: Supabase Migration — tabul_categories tablosu

**Files:**
- Supabase Dashboard (SQL Editor)

- [ ] **Step 1: Migration SQL'i calistir**

Supabase SQL Editor'da calistir:

```sql
CREATE TABLE IF NOT EXISTS tabul_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_id UUID REFERENCES tabul_categories(id) ON DELETE RESTRICT,
  names JSONB NOT NULL DEFAULT '{}'::jsonb,
  prompts JSONB NOT NULL DEFAULT '{}'::jsonb,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  is_trending BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_tabul_categories_parent_id ON tabul_categories(parent_id);
CREATE INDEX idx_tabul_categories_is_active ON tabul_categories(is_active);
CREATE INDEX idx_tabul_categories_sort_order ON tabul_categories(sort_order);

CREATE OR REPLACE FUNCTION update_tabul_categories_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_tabul_categories_updated_at
  BEFORE UPDATE ON tabul_categories
  FOR EACH ROW
  EXECUTE FUNCTION update_tabul_categories_updated_at();
```

- [ ] **Step 2: Seed data ekle**

```sql
INSERT INTO tabul_categories (id, parent_id, names, prompts, sort_order, is_trending) VALUES
  ('11111111-1111-1111-1111-111111111111', NULL,
   '{"tr": "Film & Dizi", "en": "Movies & Series"}'::jsonb,
   '{"tr": "Film ve dizi dunyasindan tabul kartlari olustur", "en": "Create tabul cards from the world of movies and series"}'::jsonb,
   1, false),
  ('22222222-2222-2222-2222-222222222222', NULL,
   '{"tr": "Spor", "en": "Sports"}'::jsonb,
   '{"tr": "Spor dunyasindan tabul kartlari olustur", "en": "Create tabul cards from the world of sports"}'::jsonb,
   2, false),
  ('33333333-3333-3333-3333-333333333333', NULL,
   '{"tr": "Yapay Zeka", "en": "Artificial Intelligence"}'::jsonb,
   '{"tr": "Yapay zeka dunyasindan tabul kartlari olustur", "en": "Create tabul cards about artificial intelligence"}'::jsonb,
   3, true);

INSERT INTO tabul_categories (parent_id, names, prompts, sort_order) VALUES
  ('11111111-1111-1111-1111-111111111111',
   '{"tr": "Netflix Yapimlari", "en": "Netflix Originals"}'::jsonb,
   '{"tr": "Netflix orijinal yapimlarindan tabul kartlari olustur", "en": "Create tabul cards from Netflix originals"}'::jsonb, 1),
  ('11111111-1111-1111-1111-111111111111',
   '{"tr": "Sinema Klasikleri", "en": "Cinema Classics"}'::jsonb,
   '{"tr": "Sinema klasiklerinden tabul kartlari olustur", "en": "Create tabul cards from cinema classics"}'::jsonb, 2),
  ('22222222-2222-2222-2222-222222222222',
   '{"tr": "Futbol", "en": "Football"}'::jsonb,
   '{"tr": "Futbol dunyasindan tabul kartlari olustur", "en": "Create tabul cards from the world of football"}'::jsonb, 1);
```

- [ ] **Step 3: Dogrula**

```sql
SELECT id, parent_id, names->>'tr' as name_tr, sort_order FROM tabul_categories ORDER BY sort_order;
```

Beklenen: 6 satir (3 main + 2 film sub + 1 spor sub).

- [ ] **Step 4: Commit**

```bash
git add -A && git commit -m "docs: add seed SQL for tabul_categories table"
```

---

## Task 2: Server — Supabase client + public categories endpoint

**Files:**
- Modify: `tabul_server/package.json`
- Modify: `tabul_server/server.js`

- [ ] **Step 1: @supabase/supabase-js paketini ekle**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && npm install @supabase/supabase-js
```

- [ ] **Step 2: server.js'e Supabase client init ekle**

Mevcut `require` satirlarindan sonra ekle:

```javascript
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);
```

- [ ] **Step 3: Tree builder utility fonksiyonu ekle**

```javascript
function buildCategoryTree(flatList, locale) {
  const localized = flatList.map(row => ({
    id: row.id,
    parentId: row.parent_id,
    name: row.names[locale] || row.names['en'] || Object.values(row.names)[0] || '',
    prompt: row.prompts[locale] || row.prompts['en'] || Object.values(row.prompts)[0] || '',
    sortOrder: row.sort_order,
    isTrending: row.is_trending,
    children: [],
  }));

  const map = {};
  localized.forEach(item => { map[item.id] = item; });

  const tree = [];
  localized.forEach(item => {
    if (item.parentId && map[item.parentId]) {
      map[item.parentId].children.push(item);
    } else if (!item.parentId) {
      tree.push(item);
    }
  });

  const sortRecursive = (nodes) => {
    nodes.sort((a, b) => a.sortOrder - b.sortOrder);
    nodes.forEach(n => sortRecursive(n.children));
  };
  sortRecursive(tree);

  const cleanParentId = (nodes) => {
    nodes.forEach(n => {
      delete n.parentId;
      cleanParentId(n.children);
    });
  };
  cleanParentId(tree);

  return tree;
}
```

- [ ] **Step 4: GET /api/categories endpoint'i ekle**

```javascript
app.get('/api/categories', async (req, res) => {
  try {
    const locale = req.query.locale || 'en';

    const { data, error } = await supabase
      .from('tabul_categories')
      .select('*')
      .eq('is_active', true);

    if (error) {
      console.error('Supabase error:', error);
      return res.status(500).json({
        success: false, errorCode: 'DB_ERROR', message: 'Kategoriler alinamadi',
      });
    }

    const tree = buildCategoryTree(data || [], locale);

    return res.json({
      success: true,
      data: { locale, categories: tree },
      message: 'Categories fetched successfully',
    });
  } catch (err) {
    console.error('Categories error:', err);
    return res.status(500).json({
      success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi',
    });
  }
});
```

- [ ] **Step 5: Test et**

```bash
curl "http://localhost:8080/api/categories?locale=tr" | python3 -m json.tool
```

Beklenen: `success: true`, 3 main category, Film'in altinda 2 children.

- [ ] **Step 6: Commit**

```bash
git add tabul_server/package.json tabul_server/package-lock.json tabul_server/server.js && git commit -m "feat(server): add Supabase client and public categories endpoint"
```

---

## Task 3: Server — Admin auth middleware + CRUD endpoints

**Files:**
- Modify: `tabul_server/server.js`

- [ ] **Step 1: Admin login endpoint ekle**

```javascript
app.post('/api/admin/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ success: false, message: 'Email ve sifre gerekli' });
    }

    const { data, error } = await supabase.auth.signInWithPassword({ email, password });
    if (error || !data.session) {
      return res.status(401).json({ success: false, message: 'Gecersiz kimlik bilgileri' });
    }

    const { data: admin } = await supabase
      .from('admin_users').select('id').eq('user_id', data.user.id).single();

    if (!admin) {
      return res.status(403).json({ success: false, message: 'Admin yetkisi yok' });
    }

    return res.json({ success: true, data: { token: data.session.access_token }, message: 'Giris basarili' });
  } catch (err) {
    console.error('Login error:', err);
    return res.status(500).json({ success: false, message: 'Sunucu hatasi' });
  }
});
```

- [ ] **Step 2: Admin auth middleware ekle**

```javascript
async function requireAdminAuth(req, res, next) {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ success: false, errorCode: 'UNAUTHORIZED', message: 'Token gerekli' });
    }

    const token = authHeader.split(' ')[1];
    const { data: { user }, error } = await supabase.auth.getUser(token);
    if (error || !user) {
      return res.status(401).json({ success: false, errorCode: 'INVALID_TOKEN', message: 'Gecersiz token' });
    }

    const { data: admin } = await supabase
      .from('admin_users').select('id').eq('user_id', user.id).single();
    if (!admin) {
      return res.status(403).json({ success: false, errorCode: 'FORBIDDEN', message: 'Admin yetkisi gerekli' });
    }

    req.adminUser = user;
    next();
  } catch (err) {
    console.error('Auth error:', err);
    return res.status(500).json({ success: false, errorCode: 'AUTH_ERROR', message: 'Yetkilendirme hatasi' });
  }
}
```

- [ ] **Step 3: Validation helper ekle**

```javascript
function validateCategoryBody(body) {
  const errors = [];
  if (!body.names || typeof body.names !== 'object' || Object.keys(body.names).length === 0) {
    errors.push({ field: 'names', message: 'En az bir dilde isim gerekli', code: 'REQUIRED' });
  }
  if (!body.prompts || typeof body.prompts !== 'object' || Object.keys(body.prompts).length === 0) {
    errors.push({ field: 'prompts', message: 'En az bir dilde prompt gerekli', code: 'REQUIRED' });
  }
  return errors;
}
```

- [ ] **Step 4: Admin CRUD endpoint'leri ekle (GET, POST, PATCH, DELETE, REORDER)**

```javascript
app.get('/api/admin/categories', requireAdminAuth, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('tabul_categories').select('*').order('sort_order', { ascending: true });
    if (error) return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: error.message });
    return res.json({ success: true, data: data || [], message: 'OK' });
  } catch (err) {
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

app.post('/api/admin/categories', requireAdminAuth, async (req, res) => {
  try {
    const errors = validateCategoryBody(req.body);
    if (errors.length > 0) return res.status(400).json({ success: false, errorCode: 'VALIDATION_ERROR', errors });

    const row = {
      parent_id: req.body.parentId || null,
      names: req.body.names,
      prompts: req.body.prompts,
      sort_order: req.body.sortOrder ?? 0,
      is_trending: req.body.isTrending ?? false,
      is_active: true,
    };

    if (row.parent_id) {
      const { data: parent } = await supabase
        .from('tabul_categories').select('id').eq('id', row.parent_id).single();
      if (!parent) return res.status(400).json({ success: false, errorCode: 'INVALID_PARENT', message: 'Parent kategori bulunamadi' });
    }

    const { data, error } = await supabase.from('tabul_categories').insert(row).select().single();
    if (error) return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: error.message });
    return res.status(201).json({ success: true, data, message: 'Kategori olusturuldu' });
  } catch (err) {
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

app.patch('/api/admin/categories/:id', requireAdminAuth, async (req, res) => {
  try {
    const { id } = req.params;
    const updates = {};
    if (req.body.names) updates.names = req.body.names;
    if (req.body.prompts) updates.prompts = req.body.prompts;
    if (req.body.sortOrder !== undefined) updates.sort_order = req.body.sortOrder;
    if (req.body.isTrending !== undefined) updates.is_trending = req.body.isTrending;
    if (req.body.isActive !== undefined) updates.is_active = req.body.isActive;
    if (req.body.parentId !== undefined) updates.parent_id = req.body.parentId || null;

    if (Object.keys(updates).length === 0) {
      return res.status(400).json({ success: false, errorCode: 'NO_UPDATES', message: 'Guncellenecek alan yok' });
    }

    const { data, error } = await supabase
      .from('tabul_categories').update(updates).eq('id', id).select().single();
    if (error) return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: error.message });
    return res.json({ success: true, data, message: 'Kategori guncellendi' });
  } catch (err) {
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

app.delete('/api/admin/categories/:id', requireAdminAuth, async (req, res) => {
  try {
    const { id } = req.params;
    const { data: children } = await supabase
      .from('tabul_categories').select('id').eq('parent_id', id).eq('is_active', true).limit(1);

    if (children && children.length > 0) {
      return res.status(400).json({ success: false, errorCode: 'HAS_CHILDREN', message: 'Aktif alt kategorileri olan kategori silinemez' });
    }

    const { data, error } = await supabase
      .from('tabul_categories').update({ is_active: false }).eq('id', id).select().single();
    if (error) return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: error.message });
    return res.json({ success: true, data, message: 'Kategori silindi' });
  } catch (err) {
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

app.patch('/api/admin/categories/reorder', requireAdminAuth, async (req, res) => {
  try {
    const { items } = req.body;
    if (!Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ success: false, errorCode: 'VALIDATION_ERROR', message: 'items dizisi gerekli' });
    }
    await Promise.all(items.map(item =>
      supabase.from('tabul_categories').update({ sort_order: item.sortOrder }).eq('id', item.id)
    ));
    return res.json({ success: true, message: 'Siralama guncellendi' });
  } catch (err) {
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});
```

- [ ] **Step 5: admin_users tablosu yoksa olustur (Supabase SQL Editor)**

```sql
CREATE TABLE IF NOT EXISTS admin_users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

- [ ] **Step 6: Commit**

```bash
git add tabul_server/server.js && git commit -m "feat(server): add admin auth middleware and category CRUD endpoints"
```

---

## Task 4: Admin Panel — Web UI

**Files:**
- Create: `tabul_server/public/admin-categories.html`
- Modify: `tabul_server/server.js` (route ekle)

- [ ] **Step 1: Admin panel HTML dosyasini olustur**

`tabul_server/public/admin-categories.html` — tam HTML dosyasi. Auth form + nested tree CRUD + multi-locale modal form. Admin-only, Supabase auth entegrasyonu. DOM manipulation icin `document.createElement()` + `textContent` kullanarak XSS korunmali tree rendering.

Ozellikler:
- Login form (email + password) → `/api/admin/login` → token localStorage'a
- Tree gorunumu — her node'un altinda children, recursive render
- Her node: isim (tum diller), duzenle/alt-ekle/sil butonlari
- Modal form: parent secimi, locale tab'lari (tr/en/de/es/fr/it/pt/ru/ar/ja/zh/ko), isim + prompt inputlari
- Soft delete, HAS_CHILDREN korumasi
- `/admin` route'u server.js'e eklenmeli

- [ ] **Step 2: Server'da /admin route'u ekle**

`server.js`'e ekle:

```javascript
app.get('/admin', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'admin-categories.html'));
});
```

- [ ] **Step 3: Test et**

Tarayicida `http://localhost:8080/admin` ac, login yap, CRUD islemlerini dene.

- [ ] **Step 4: Commit**

```bash
git add tabul_server/public/admin-categories.html tabul_server/server.js && git commit -m "feat(server): add admin panel for category management"
```

---

## Task 5: Flutter — DTO + API endpoint + Repo

**Files:**
- Create: `tabul/lib/feature/home/data/dto/tabul_category_dto.dart`
- Create: `tabul/lib/feature/home/data/dto/categories_response_dto.dart`
- Modify: `tabul/lib/core/service/server/api_service.dart`
- Modify: `tabul/lib/core/service/server/tabul_server_api_endpoints.dart`
- Modify: `tabul/lib/feature/home/data/repo/card_repo.dart`

- [ ] **Step 1: TabulCategoryDto olustur**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tabul_category_dto.freezed.dart';
part 'tabul_category_dto.g.dart';

@freezed
sealed class TabulCategoryDto with _$TabulCategoryDto {
  const factory TabulCategoryDto({
    String? id,
    String? name,
    String? prompt,
    int? sortOrder,
    @Default(false) bool isTrending,
    @Default([]) List<TabulCategoryDto> children,
  }) = _TabulCategoryDto;

  factory TabulCategoryDto.fromJson(Map<String, Object?> json) =>
      _$TabulCategoryDtoFromJson(json);
}
```

- [ ] **Step 2: CategoriesResponseDto olustur**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabul/feature/home/data/dto/tabul_category_dto.dart';

part 'categories_response_dto.freezed.dart';
part 'categories_response_dto.g.dart';

@freezed
sealed class CategoriesResponseDto with _$CategoriesResponseDto {
  const factory CategoriesResponseDto({
    String? locale,
    @Default([]) List<TabulCategoryDto> categories,
  }) = _CategoriesResponseDto;

  factory CategoriesResponseDto.fromJson(Map<String, Object?> json) =>
      _$CategoriesResponseDtoFromJson(json);
}
```

- [ ] **Step 3: Endpoint sabiti ekle**

`tabul_server_api_endpoints.dart`'a ekle:

```dart
static const String categories = '/api/categories';
```

- [ ] **Step 4: ApiService'e getCategories ekle**

```dart
@GET(TabulServerApiEndpoints.categories)
Future<ItemDto<CategoriesResponseDto>> getCategories(
  @Query('locale') String locale,
);
```

- [ ] **Step 5: CardRepo'ya getCategories ekle**

```dart
Future<Either<Failure, ItemDto<CategoriesResponseDto>>> getCategories(
  String locale,
) async {
  return await ApiHelper.requestItem<CategoriesResponseDto>(
    apiCall: () => locator<ApiService>().getCategories(locale),
  );
}
```

- [ ] **Step 6: Build runner calistir**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul && flutter pub run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 7: Commit**

```bash
git add tabul/lib/feature/home/data/dto/ tabul/lib/core/service/server/ tabul/lib/feature/home/data/repo/ && git commit -m "feat(client): add category DTO, API endpoint, and repo method"
```

---

## Task 6: Flutter — CategoryCubit + State (HydratedCubit)

**Files:**
- Create: `tabul/lib/feature/home/bloc/state/category_state.dart`
- Create: `tabul/lib/feature/home/bloc/cubit/category_cubit.dart`
- Modify: `tabul/lib/core/injection/locator.dart`

- [ ] **Step 1: CategoryState olustur**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabul/core/models/failure.dart';
import 'package:tabul/core/utils/ui_status.dart';
import 'package:tabul/feature/home/data/dto/tabul_category_dto.dart';

part 'category_state.freezed.dart';
part 'category_state.g.dart';

@freezed
sealed class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    Failure? failure,
    @Default([]) List<TabulCategoryDto> categories,
    @Default([]) List<String> selectedCategoryIds,
    @Default('') String builtPrompt,
    @Default('tr') String currentLocale,
  }) = _CategoryState;

  const CategoryState._();

  factory CategoryState.fromJson(Map<String, dynamic> json) =>
      _$CategoryStateFromJson(json);
}
```

- [ ] **Step 2: CategoryCubit olustur**

```dart
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tabul/core/injection/locator.dart';
import 'package:tabul/core/utils/ui_status.dart';
import 'package:tabul/feature/home/bloc/state/category_state.dart';
import 'package:tabul/feature/home/data/dto/tabul_category_dto.dart';
import 'package:tabul/feature/home/data/repo/card_repo.dart';
import 'package:tabul/core/utils/my_logger.dart';

class CategoryCubit extends HydratedCubit<CategoryState> {
  CategoryCubit() : super(const CategoryState());

  static const _cardRepo = CardRepo();

  Future<void> fetchCategories(String locale) async {
    emit(state.copyWith(status: UIStateStatus.loading, currentLocale: locale));
    final result = await _cardRepo.getCategories(locale);
    result.fold(
      (error) {
        myCustomLogger.e('Kategoriler alinamadi: ${error.messageValue}');
        if (state.categories.isNotEmpty) {
          emit(state.copyWith(status: UIStateStatus.success));
        } else {
          emit(state.copyWith(status: UIStateStatus.error, failure: error));
        }
      },
      (response) {
        final categories = response.data?.categories ?? [];
        myCustomLogger.i('${categories.length} kategori yuklendi ($locale)');
        emit(state.copyWith(
          status: UIStateStatus.success,
          categories: categories,
          currentLocale: locale,
        ));
      },
    );
  }

  void toggleCategory(TabulCategoryDto category) {
    final ids = List<String>.from(state.selectedCategoryIds);
    final categoryId = category.id ?? '';
    if (ids.contains(categoryId)) {
      ids.remove(categoryId);
      _removeChildrenIds(category, ids);
    } else {
      ids.add(categoryId);
    }
    emit(state.copyWith(selectedCategoryIds: ids));
    _rebuildPrompt();
  }

  void _removeChildrenIds(TabulCategoryDto category, List<String> ids) {
    for (final child in category.children) {
      ids.remove(child.id ?? '');
      _removeChildrenIds(child, ids);
    }
  }

  void _rebuildPrompt() {
    final prompts = <String>[];
    for (final mainCat in state.categories) {
      if (!state.selectedCategoryIds.contains(mainCat.id)) continue;
      final deepestPrompts = _collectDeepestPrompts(mainCat);
      if (deepestPrompts.isNotEmpty) {
        prompts.addAll(deepestPrompts);
      } else if (mainCat.prompt != null && mainCat.prompt!.isNotEmpty) {
        prompts.add(mainCat.prompt!);
      }
    }
    emit(state.copyWith(builtPrompt: prompts.join('. ')));
  }

  List<String> _collectDeepestPrompts(TabulCategoryDto category) {
    final result = <String>[];
    for (final child in category.children) {
      if (!state.selectedCategoryIds.contains(child.id)) continue;
      final deeperPrompts = _collectDeepestPrompts(child);
      if (deeperPrompts.isNotEmpty) {
        result.addAll(deeperPrompts);
      } else if (child.prompt != null && child.prompt!.isNotEmpty) {
        result.add(child.prompt!);
      }
    }
    return result;
  }

  void resetSelection() {
    emit(state.copyWith(selectedCategoryIds: [], builtPrompt: ''));
  }

  List<TabulCategoryDto> get selectedCategories {
    final result = <TabulCategoryDto>[];
    _findSelected(state.categories, result);
    return result;
  }

  void _findSelected(List<TabulCategoryDto> cats, List<TabulCategoryDto> result) {
    for (final cat in cats) {
      if (state.selectedCategoryIds.contains(cat.id)) result.add(cat);
      _findSelected(cat.children, result);
    }
  }

  @override
  CategoryState? fromJson(Map<String, dynamic> json) {
    try { return CategoryState.fromJson(json); }
    catch (e) { return const CategoryState(); }
  }

  @override
  Map<String, dynamic>? toJson(CategoryState state) {
    try { return state.toJson(); }
    catch (e) { return null; }
  }
}
```

- [ ] **Step 3: GetIt'e register et**

`locator.dart`'a ekle:

```dart
locator.registerLazySingleton(() => CategoryCubit());
```

- [ ] **Step 4: Build runner calistir**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul && flutter pub run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 5: Commit**

```bash
git add tabul/lib/feature/home/bloc/ tabul/lib/core/injection/locator.dart && git commit -m "feat(client): add CategoryCubit with HydratedCubit caching and prompt builder"
```

---

## Task 7: Flutter — Localization keys

**Files:**
- Modify: `tabul/lib/l10n/intl_tr.arb`
- Modify: `tabul/lib/l10n/intl_en.arb`

- [ ] **Step 1: Turkce key'leri ekle**

```json
"category_step_title": "Konu Sec",
"category_step_skip": "Direkt yaz",
"category_step_continue": "Devam",
"category_step_empty": "Henuz secim yok",
"category_step_selected_count": "{count} secili",
"category_trending": "TREND",
"prompt_step_title": "Prompt Duzenle",
"prompt_step_back": "Geri",
"prompt_step_category_tags": "Secilen konular",
"prompt_step_hint": "Prompt'u duzenleyebilir veya ek detay ekleyebilirsin...",
"no_internet_generate_disabled": "Internet baglantisi gerekli",
"category_loading": "Kategoriler yukleniyor...",
"category_load_error": "Kategoriler yuklenemedi"
```

- [ ] **Step 2: Ingilizce key'leri ekle**

```json
"category_step_title": "Choose Topic",
"category_step_skip": "Write directly",
"category_step_continue": "Continue",
"category_step_empty": "No selection yet",
"category_step_selected_count": "{count} selected",
"category_trending": "TREND",
"prompt_step_title": "Edit Prompt",
"prompt_step_back": "Back",
"prompt_step_category_tags": "Selected topics",
"prompt_step_hint": "Edit the prompt or add details...",
"no_internet_generate_disabled": "Internet connection required",
"category_loading": "Loading categories...",
"category_load_error": "Failed to load categories"
```

- [ ] **Step 3: gen-l10n calistir**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul && flutter gen-l10n
```

- [ ] **Step 4: Commit**

```bash
git add tabul/lib/l10n/ && git commit -m "feat(client): add category UI localization keys (tr + en)"
```

---

## Task 8: Flutter — CategoryStepWidget (Adim 1)

**Files:**
- Create: `tabul/lib/feature/home/view/widgets/sheets/category_step_widget.dart`

- [ ] **Step 1: CategoryStepWidget'i olustur**

Main category horizontal chip'ler, sub category accordion, recursive sub rendering, selected tags, "Direkt yaz" skip linki, "Devam" butonu. Secili chip'lerde checkmark icon. Trending kategorilerde kirmizi dot. BlocBuilder ile CategoryCubit dinlenir.

Detayli widget kodu spec'teki Section 4.5 Adim 1'e uygun olmali:
- `_SelectedTags` — secili kategorilerin chip'leri, x ile kaldirma
- `_MainCategoryChips` — horizontal scroll, text chip'ler
- `_SubCategorySection` — recursive widget, `depth` parametresiyle indentation

- [ ] **Step 2: Commit**

```bash
git add tabul/lib/feature/home/view/widgets/sheets/category_step_widget.dart && git commit -m "feat(client): add CategoryStepWidget with recursive chip selection"
```

---

## Task 9: Flutter — PromptStepWidget (Adim 2)

**Files:**
- Create: `tabul/lib/feature/home/view/widgets/sheets/prompt_step_widget.dart`

- [ ] **Step 1: PromptStepWidget'i olustur**

Geri butonu, readonly kategori tag'leri, pre-filled prompt input (AppTextInput.large), karakter sayaci, kart sayisi secimi (mevcut _CardCountOptions pattern'i), "TabuL'unu Olustur" butonu. Generate mantigi mevcut create_own_tabul_sheet.dart'taki _onGenerate ile ayni (kredi kontrol, interstitial, cubit.generateCardByCondition).

Not: `_CardCountOptions` widget'ini ayri dosyaya cikar veya burada tekrar yaz.

- [ ] **Step 2: Commit**

```bash
git add tabul/lib/feature/home/view/widgets/sheets/prompt_step_widget.dart && git commit -m "feat(client): add PromptStepWidget with editable prompt and generate flow"
```

---

## Task 10: Flutter — CreateOwnTabulSheet stepper donusumu

**Files:**
- Modify: `tabul/lib/feature/home/view/widgets/sheets/create_own_tabul_sheet.dart`

- [ ] **Step 1: Sheet'i stepper'a donustur**

- `_currentStep` state degiskeni (0 = category, 1 = prompt)
- `initState`'te `CategoryCubit.fetchCategories(locale)` cagrisi
- `_StepIndicator` widget'i (2 cubuk, aktif/pasif renk)
- Step 0: `CategoryStepWidget(onContinue, onSkip)`
- Step 1: `PromptStepWidget(onBack, initialPrompt, hasCategories)`
- `_goToPromptStep()`, `_skipToPromptStep()`, `_goBackToCategoryStep()`
- Geri donuste kategori resetSelection YAPILMAZ — prompt sifirlanir ve yeniden build edilir

- [ ] **Step 2: Eski `_WriteTabulCardTheme` widget'ini sil**

- [ ] **Step 3: flutter analyze**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul && flutter analyze
```

- [ ] **Step 4: Commit**

```bash
git add tabul/lib/feature/home/view/widgets/sheets/ && git commit -m "feat(client): convert CreateOwnTabulSheet to 2-step stepper"
```

---

## Task 11: Flutter — Locale degisiminde re-fetch

**Files:**
- Modify: App root widget veya locale listener olan yer

- [ ] **Step 1: Locale listener ekle**

```dart
BlocListener<LocaleCubit, LocaleState>(
  bloc: locator<LocaleCubit>(),
  listenWhen: (prev, curr) => prev.languageCode != curr.languageCode,
  listener: (context, state) {
    locator<CategoryCubit>().fetchCategories(state.languageCode);
  },
),
```

- [ ] **Step 2: Commit**

```bash
git add -A && git commit -m "feat(client): add locale change listener for category re-fetch"
```

---

## Task 12: Entegrasyon testi + son dogrulama

- [ ] **Step 1: Server test**

```bash
curl "http://localhost:8080/api/categories?locale=tr" | python3 -m json.tool
curl "http://localhost:8080/api/categories?locale=en" | python3 -m json.tool
```

- [ ] **Step 2: Admin panel test**

`http://localhost:8080/admin` — login, CRUD, nested kategori

- [ ] **Step 3: Flutter app test**

1. Sheet ac → Adim 1 (kategoriler)
2. Main sec → sub'lar acilir
3. Sub sec → prompt override
4. Devam → Adim 2 pre-filled prompt
5. Direkt yaz → bos prompt
6. Geri → Adim 1
7. Dil degistir → re-fetch

- [ ] **Step 4: flutter analyze**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul && flutter analyze
```

- [ ] **Step 5: Final commit**

```bash
git add -A && git commit -m "test: verify category prompt system end-to-end"
```
