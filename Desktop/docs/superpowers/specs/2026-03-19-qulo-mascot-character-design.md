# Qulo Maskot Karakteri — Tasarim Spec

## Ozet

Qulo dating app icin Duolingo'nun Duo'su gibi bir 3D maskot karakter olusturulmasi. Karakter Three.js ile tek bir HTML dosyasinda prototiplenecek, animasyonlar dogrulandiktan sonra Lottie formatina cevrilerek Flutter uygulamasina entegre edilecek.

## Karakter Tasarimi

### Konsept
Soru isareti + sevimli hayvan karisimi bir yaratik.

### Fiziksel Ozellikler
- **Govde:** Yuvarlak, kure bazli (soru isaretinin nokta kismi)
- **Bas ustunde:** Soru isaretinin kivrimini andiran anten/kuyruk
- **Gozler:** Buyuk, sevimli hayvan gozleri (iki kure, ici siyah pupil)
- **Kulaklar:** Kucuk, yuvarlak kulaklar (iki kucuk kure/yarim kure)
- **Kollar:** Kisa silindir kollar, ucunda kure eller
- **Bacaklar:** Kisa silindir bacaklar, ucunda kure ayaklar
- **Stil:** Stickman+ (silindir/kure bazli, organik gorunum)

### Renk Paleti
- Qulo'nun mevcut marka renkleriyle uyumlu olacak
- Ana govde: Canli, sicak bir renk (mor/pembe tonlari — dating temasina uygun)
- Gozler: Beyaz sclera + siyah pupil
- Anten/kuyruk: Govdeden biraz daha koyu ton
- Yanak: Hafif pembe blush efekti

### Skeleton / Bone Yapisi
```
root
├── body (ana govde - yukari/asagi nefes hareketi)
│   ├── head (bas - sag/sol/yukari/asagi)
│   │   ├── left_ear
│   │   ├── right_ear
│   │   ├── left_eye (scale ile kirpma)
│   │   ├── right_eye
│   │   ├── mouth (scale ile acma/kapama)
│   │   └── antenna (fizik bazli sallanma)
│   ├── left_arm (omuz pivot)
│   │   └── left_hand
│   ├── right_arm (omuz pivot)
│   │   └── right_hand
│   ├── left_leg (kalca pivot)
│   │   └── left_foot
│   └── right_leg (kalca pivot)
│       └── right_foot
```

## Animasyonlar

### 1. Idle (Nefes Alma / Hafif Sallanma)
- **Sure:** 2 saniye dongu
- **Hareket:** Govde hafif yukari-asagi (nefes), anten yavascar sallanma, gozler arada kirpma (3-4 saniyede bir)
- **Kullanim:** Her yerde varsayilan animasyon
- **Teknik:** Sin wave ile body.position.y, antenna rotation

### 2. El Sallama / Merhaba
- **Sure:** 1.5 saniye
- **Hareket:** Sag kol yukari kalkar, el sag-sol sallanir (3 kez), govde hafif one egilir
- **Kullanim:** Onboarding, karsilama ekranlari
- **Teknik:** Arm rotation keyframe, hand rotation oscillation

### 3. Kalp Gonderme / Ask
- **Sure:** 2 saniye
- **Hareket:** Her iki el gogsun onunde birlesir, sonra one acilir ve aradan 3D kalp particle yükselir. Gozler kalp seklini alir (scale + shape morph)
- **Kullanim:** Eslesme ani, begeni
- **Teknik:** Hand position keyframe + particle system (kalp geometry)

### 4. Yurume
- **Sure:** 1 saniye dongu
- **Hareket:** Bacaklar sirayla ileri-geri, kollar zit yonde sallanir, govde hafif sag-sol sallanir
- **Kullanim:** Gecis ekranlari, loading
- **Teknik:** Leg/arm rotation cycle, body sway

### 5. Isaret Etme / Yonlendirme
- **Sure:** 1.5 saniye
- **Hareket:** Sag kol yana uzanir ve isaret eder, bas isaret yonune doner, govde hafif o yone egilir
- **Kullanim:** Onboarding, tooltip, yonlendirme
- **Teknik:** Arm extension keyframe, head rotation, body lean

## Teknik Mimari

### Dosya Yapisi
Tek HTML dosyasi icinde:
- Three.js CDN import (r158+)
- Karakter modelleme (geometri + material)
- Bone/skeleton sistemi
- Animasyon mixer + clip'ler
- UI kontrolleri (butonlar)
- Orbit camera kontrol
- Isiklandirma setup

### 3D Sahne
- **Kamera:** PerspectiveCamera + OrbitControls (serbest dondurme)
- **Isik:** Ambient light + DirectionalLight (soft golge)
- **Zemin:** Basit daire veya grid (karakter referansi icin)
- **Arka plan:** Gradient veya solid renk

### Animasyon Sistemi
- Three.js AnimationMixer + AnimationClip kullanimi
- Her animasyon icin keyframe track'ler (position, rotation, scale)
- Animasyonlar arasi crossfade (0.3s blend)
- Idle animasyonu varsayilan, diger animasyonlar bitince idle'a don

### UI Kontrolleri
- 5 buton (her animasyon icin bir tane)
- Animasyon adi + kucuk ikon
- Aktif animasyon vurgulanir
- Alt kisimda: kamera reset butonu

## Basari Kriterleri

1. Karakter sevimli ve taninabilir olmali
2. Animasyonlar akici (60fps) ve dogal gorunmeli
3. Animasyonlar arasi gecis keskin olmamali (crossfade)
4. Tek HTML dosyasinda calismali (CDN haric dis bagimlilik yok)
5. Herhangi bir modern browser'da calismali
6. Orbit kamera ile karakteri her acidan inceleyebilme
7. Lottie'ye cevirmeye uygun sadelikte olmali (asiri karmasik mesh yok)

## Gelecek Adimlari (kapsam disi)
- Lottie export ve Flutter entegrasyonu
- Ek animasyonlar (mutlu, uzgun, sasirma, dans, uyuma, kizgin)
- Yuz ifadesi detaylari (morph target)
- Ses entegrasyonu
- Karakter kiyafet/aksesuar sistemi
