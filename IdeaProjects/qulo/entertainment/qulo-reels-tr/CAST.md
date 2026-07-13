# Qulo Reels — Kast & Aksiyon Kütüphanesi

Adlandırma: `<karakterId>` taban poz, `<karakterId>_<aksiyon>` aksiyon pozu (referanslı üretim → yüz/desen tutarlı).
Animatik: `SpriteFlip` bileşeni poz dizisini ardı ardına oynatır (ör. kedi: taban → bagir → pati).
Yeni aksiyon eklemek: manifest'e `<id>_<aksiyon>` girdisi (referenceOf: taban id) + `npm run assets -- <id>` + bu dosyaya satır.

## Kadınlar
| id | tanım | aksiyonlar |
|----|-------|-----------|
| w1 | marka kadını (video 1-8 ana karakter) | w1_hook (özgüven), w1_point (yazma), w1_tired (bunalmış), h_look_w (omuz bakışı), p_phone (telefon şaşkın) |
| w2 | casual şık aday | taban (yürüyüş) |
| w3 | sportif aday | taban (selam) |
| w4 | glamour (K2 Kadıköy kadını) | taban (özgüven) |

## Erkekler
| id | tanım | aksiyonlar |
|----|-------|-----------|
| m1 | smart-casual aday | taban (yürüyüş) |
| m2 | streetwear aday | taban (selam) |
| m3 | çiçekli kazanan (video 1-8) | taban; çift: c_cafe, c_cat, c_walk (w1 ile) |
| m_hook | Ters Köşe kural koyucu | taban (kollar çapraz), h_look_m (bakış) |
| e_host | 70'ler şovmeni | taban (mikrofon) |
| erko_zengin | lüks arabalı kendini beğenmiş tip | taban (anahtarlık sallama), erko_zengin_araba (arabaya yaslanmış) |
| erko_kasli | spor salonu tipi | taban (kollar çapraz kaslar) |
| italyan | Akdeniz karizması | taban (espresso) |

## Kediler (Kadıköy jürisi) 🐈
| id | tanım | aksiyonlar |
|----|-------|-----------|
| kedi_tekir | yargılayan tekir | taban (oturmuş bakış), _bagir (tıslama/bağırma), _pati (pençe atma) |
| kedi_sarman | sıkılmış sarman | taban (esneme), _bagir, _pati |
| kedi_sb | onaycı smokin kedi | taban (pati havada onay), _bagir, _pati |

## Ortamlar (bg_* tam kare plate)
bg_sorgu (film-noir sorgu odası), bg_mugshot (mugshot duvarı), bg_kadikoy (grafitili sokak), bg_moda (sahil).

## Prop'lar
prop_plak, prop_pizza, prop_disko, e_curtain (perde), prop_luks_sedan (logo'suz lüks sedan — MARKA LOGOSU ASLA), prop_anahtarlik (lüks araba anahtarlığı).

## Kurallar
- Araç/eşya markaları ve logoları ASLA görünmez (trademark).
- İnsanlar giyinik/policy-güvenli; "seksi" = glamour + zarafet.
- Sorular keskin TR flört draması (bkz. memory feedback_qulo_ad_questions_edgy).
- Kast rotasyonu: yeni varyantlarda farklı karakterler öne çıkar (bkz. feedback_qulo_ad_character_rotation).
