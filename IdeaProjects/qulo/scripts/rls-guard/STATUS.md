# RLS Guard — Calisma Durumu (PARALEL SESSION KILIDI)

> **Diger session'lar:** Supabase prod DB'de migration calistirmadan ONCE bu dosyayi
> oku. `DURUM: DEVAM EDIYOR` ise DB'ye DDL uygulama — yesil/kirmizi test sonuclari
> bozulur ve yanlis rollback tetiklenir. Kod tarafinda calismaya devam edebilirsin.

**DURUM:** A GRUBU TAMAM (A1+A2+A3) · B partisi BLOKE — Faz 3 (JWT) gerekli.
> Bu noktadan sonra prod'a RLS DDL'i planlanmiyor; diger session'lar serbest.
**Rezerve migration araligi:** 038-045 (baskasi bu numaralari KULLANMASIN; son mevcut: 037)
**Dokunulan dosyalar:** `scripts/rls-guard/**`, `CLAUDE.md`, DB (public sema RLS)
**Dokunulmayan:** qulov2/**, qulo-server/src/** — kod tarafi paralel calismaya acik

## Baseline
- Alindi: 2026-09-01 · `results/baseline.tsv`
- Kirmizi: 25/25 tablo anon'a ACIK (hepsi HTTP 200)
- Yesil: 9/9 uygulama testi 200
- `service_role.rolbypassrls = true` dogrulandi → server RLS'ten etkilenmez

## Ilerleme
| Parti | Tablolar | Durum |
|---|---|---|
| A1 | refresh_tokens, admin_users, user_details, account_deletion_feedback, support_tickets, email_unsubscribe_tokens, reports, blocks | **TAMAM** (038, 2026-09-01) |
| A2 | diamond_transactions, iap_transactions, user_subscriptions, quiz_sessions, quiz_answers, swipes | **TAMAM** (039, 2026-09-01) |
| A3 | questions, question_pending_changes, ai_question_suggestions, app_config, powers, iap_products, page_messages, page_message_events | **TAMAM** (040, 2026-09-01) |
| B  | messages, matches, users (Realtime — Faz 3 JWT isi gerekli) | BLOKE |

## Bilinen acik
- Yesil testler Realtime teslimatini KAPSAMIYOR. B partisi icin cihazda manuel
  chat testi zorunlu.
- `chat_questions` + `media_requests`: RLS acik, policy yok → abonelikler bugun
  zaten olu. Ayri olarak dogrulanmali.

## A1 sonucu (migration 038 — 2026-09-01)
- 7 tablo `200/rows` -> `200/empty` (kapandi). `reports` zaten bos oldugu icin
  SELECT testi sonucsuz; `relrowsecurity=true, policy=0` ile yapisal dogrulandi.
- 8/8 tabloda `relrowsecurity = true`, `policy_sayisi = 0`.
- Yesil regresyon: YOK (9/9 test 200).
- A1 disinda hicbir kirmizi test yon degistirmedi -> baska session mudahale etmemis.
- verify.tsv yeni baseline olarak alindi.

### Metodolojik not (sonraki partiler icin)
Bos tablolarda SELECT testi kanit URETMEZ (`200/empty` her iki durumda da ayni).
A2'de `iap_transactions`, A3'te `ai_question_suggestions` + `question_pending_changes`
bu durumda — onlar `pg_class.relrowsecurity` ile yapisal dogrulanacak.

## A2 sonucu (migration 039 — 2026-09-01)
- 5 tablo `200/rows` -> `200/empty`. `iap_transactions` bos oldugu icin SELECT
  testi sonucsuz; 6/6 tabloda `relrowsecurity=true` ile yapisal dogrulandi.
- Yesil regresyon: YOK (14/14 test 200). Yesil set A2 oncesi genisletildi:
  `diamonds/history`, `subscriptions/status`, `subscriptions/daily-stats`,
  `users/me/languages`, `users/me/notification-preferences`.
- A2 disinda hicbir test yon degistirmedi.

### Quiz kapsam notu
Test kullanicisinin eslesmesi olmadigi icin `quiz/match/:id/summary` cagrilamadi;
quiz_sessions/quiz_answers icin davranissal yesil test YOK. Yerine yapisal kanit:
qulo-server'da `src/config/supabase.ts` disinda `createClient` yok, o tek client
SERVICE_ROLE_KEY kullaniyor, server kodunda anon key sifir, `rolbypassrls=true`.
=> RLS hicbir server kod yolunu etkileyemez.

## A3 sonucu (migration 040 — 2026-09-01)
- 6 tablo `200/rows` -> `200/empty`. `question_pending_changes` +
  `ai_question_suggestions` bos oldugu icin SELECT testi sonucsuz; yapisal
  dogrulama: `pg_class` taramasinda ikisi de artik RLS acik.
- Yesil regresyon: YOK (17/17 test 200). Yesil set once genisletildi:
  `app/economy`, `powers`, `page-messages`.

## A GRUBU KAPANIS
Baslangic: 26 tablo anon'a acik. Simdi: 3 (+ spatial_ref_sys).
Kalan: `messages`, `matches`, `users` — ucu de supabase_realtime yayininda,
policy'siz RLS acmak chat teslimatini KESER. Faz 3 (server'in Supabase-uyumlu
JWT imzalamasi + mobil `realtime.setAuth`) tamamlanmadan DOKUNULMAZ.
`spatial_ref_sys` PostGIS sistem tablosu — ALTER edilemez, kamuya acik referans
verisi, risk tasimaz.
