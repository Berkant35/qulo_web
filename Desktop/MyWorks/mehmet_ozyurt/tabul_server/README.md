# 🎲 Tabul Kart Oluşturucu Sunucu

AI destekli akıllı Tabul (Tabu) kartları oluşturan Node.js sunucusu. OpenAI API kullanarak istediğiniz temaya göre otomatik olarak Tabul kartları üretir.

## 🚀 Özellikler

- ✨ AI destekli otomatik kart oluşturma
- 🎨 Modern ve kullanıcı dostu web arayüzü
- 📦 JSON formatında kart dışa aktarma
- 🔧 Basit ve esnek API
- 🎯 Özelleştirilebilir tema ve kart sayısı

## 📋 Gereksinimler

- Node.js (v14 veya üzeri)
- OpenAI API Key ([buradan](https://platform.openai.com/api-keys) alabilirsiniz)

## 🛠️ Kurulum

1. Bağımlılıkları yükleyin:
```bash
npm install
```

2. `.env` dosyası oluşturun ve OpenAI API anahtarınızı ekleyin:
```bash
echo "OPENAI_API_KEY=your_api_key_here" > .env
echo "PORT=3000" >> .env
```

3. API anahtarınızı `.env` dosyasına ekleyin:
```
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
PORT=3000
```

## 🎮 Kullanım

### Sunucuyu Başlatma

```bash
npm start
```

veya geliştirme modu için (otomatik yeniden başlatma):

```bash
npm run dev
```

Sunucu `http://localhost:3000` adresinde çalışmaya başlayacak.

### Web Arayüzü

Tarayıcınızda `http://localhost:3000` adresine gidin ve arayüzü kullanarak kartlarınızı oluşturun.

## 📡 API Endpoints

### 1. Kart Oluşturma

**POST** `/api/generate-cards`

Verilen temaya göre Tabul kartları oluşturur.

**Request Body:**
```json
{
  "prompt": "Sadece doktorların birbirileriyle anlaşabileceği tabul kartları oluştur",
  "cardCount": 50
}
```

**Response:**
```json
{
  "success": true,
  "tema": "Sadece doktorların birbirileriyle anlaşabileceği tabul kartları oluştur",
  "kartSayisi": 50,
  "kartlar": [
    {
      "kelime": "STETESKOP",
      "yasakliKelimeler": [
        "dinleme",
        "kalp",
        "göğüs",
        "muayene",
        "kulak"
      ]
    },
    {
      "kelime": "ÖNLÜK",
      "yasakliKelimeler": [
        "beyaz",
        "giysi",
        "doktor",
        "hastane",
        "koruma"
      ]
    }
  ]
}
```

### 2. Sunucu Durumu

**GET** `/api/health`

Sunucu durumunu ve API key yapılandırmasını kontrol eder.

**Response:**
```json
{
  "status": "OK",
  "apiKeyConfigured": true
}
```

## 🔧 Örnek Kullanım (cURL)

```bash
curl -X POST http://localhost:3000/api/generate-cards \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Yazılım geliştiriciler için tabul kartları",
    "cardCount": 20
  }'
```

## 📝 Örnek Temalar

- "Sadece doktorların birbirileriyle anlaşabileceği tabul kartları"
- "Yazılım geliştiriciler için tabul kartları"
- "Futbol tutkunları için tabul kartları"
- "Aşçılar ve yemek severler için tabul kartları"
- "Tarih meraklıları için tabul kartları"

## 🎨 Proje Yapısı

```
tabul_server/
├── server.js           # Ana sunucu dosyası
├── package.json        # Proje bağımlılıkları
├── .env               # Çevre değişkenleri (oluşturmanız gerekiyor)
├── .gitignore         # Git ignore dosyası
├── README.md          # Bu dosya
└── public/
    └── index.html     # Web arayüzü
```

## 🔒 Güvenlik

- `.env` dosyasını asla Git'e eklemeyin
- API anahtarınızı kimseyle paylaşmayın
- Production ortamında CORS ayarlarını sınırlandırın

## 🐛 Sorun Giderme

### "API key tanımlanmamış" hatası
`.env` dosyasını oluşturduğunuzdan ve `OPENAI_API_KEY` değişkenini eklediğinizden emin olun.

### Port zaten kullanımda
`.env` dosyasında `PORT` değişkenini değiştirin veya şu komutla farklı bir port kullanın:
```bash
PORT=3001 npm start
```

## 📄 Lisans

ISC

## 🤝 Katkıda Bulunma

Pull request'ler memnuniyetle karşılanır!

## 📞 İletişim

Sorularınız için issue açabilirsiniz.

---

Made with ❤️ using Node.js and OpenAI
