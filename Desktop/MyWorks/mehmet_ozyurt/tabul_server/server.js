require('dotenv').config();
const express = require('express');
const cors = require('cors');
const axios = require('axios');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Ana sayfa - HTML UI
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Tabul kartları oluşturma endpoint'i
app.post('/api/generate-cards', async (req, res) => {
  try {
    const { prompt, cardCount = 50 } = req.body;

    if (!prompt) {
      return res.status(400).json({
        error: 'Lütfen bir açıklama girin'
      });
    }

    if (!process.env.OPENAI_API_KEY) {
      return res.status(500).json({
        error: 'API key tanımlanmamış. Lütfen .env dosyasına OPENAI_API_KEY ekleyin'
      });
    }

    console.log(`📝 Tabul kartları oluşturuluyor: "${prompt}" (${cardCount} kart)`);

    // OpenAI API'ye istek
    const response = await axios.post(
      'https://api.openai.com/v1/chat/completions',
      {
        model: 'gpt-4',
        messages: [
          {
            role: 'system',
            content: `Sen bir Tabul (Tabu) kart oyunu kart oluşturucususun. Verilen tema veya açıklamaya göre ${cardCount} adet Tabul kartı oluşturacaksın.

Her kart şu formatta olmalı:
{
  "kelime": "ANA KELİME",
  "yasakliKelimeler": ["yasaklı1", "yasaklı2", "yasaklı3", "yasaklı4", "yasaklı5"]
}

Kurallar:
- Her kartta tam olarak 5 yasaklı kelime olmalı
- Yasaklı kelimeler ana kelimeyle ilgili en yakın kelimeleri olmalı
- Kartlar tema ile uyumlu olmalı
- Kelimeler Türkçe olmalı
- Sadece JSON array döndür, başka açıklama yapma`
          },
          {
            role: 'user',
            content: `${cardCount} adet Tabul kartı oluştur. Tema: ${prompt}`
          }
        ],
        temperature: 0.8,
        max_tokens: 4000
      },
      {
        headers: {
          'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
          'Content-Type': 'application/json'
        }
      }
    );

    const content = response.data.choices[0].message.content;

    // JSON'u parse et
    let cards;
    try {
      // Markdown code block varsa temizle
      const jsonMatch = content.match(/```json\n([\s\S]*?)\n```/) || content.match(/```([\s\S]*?)```/);
      const jsonString = jsonMatch ? jsonMatch[1] : content;
      cards = JSON.parse(jsonString.trim());
    } catch (parseError) {
      console.error('JSON parse hatası:', parseError);
      return res.status(500).json({
        error: 'AI yanıtı işlenemedi',
        details: content
      });
    }

    console.log(`✅ ${cards.length} adet kart başarıyla oluşturuldu`);

    res.json({
      success: true,
      tema: prompt,
      kartSayisi: cards.length,
      kartlar: cards
    });

  } catch (error) {
    console.error('Hata:', error.response?.data || error.message);
    res.status(500).json({
      error: 'Kartlar oluşturulurken hata oluştu',
      details: error.response?.data?.error?.message || error.message
    });
  }
});

// Sunucu durumu kontrolü
app.get('/api/health', (req, res) => {
  res.json({
    status: 'OK',
    apiKeyConfigured: !!process.env.OPENAI_API_KEY
  });
});

// ─── Utility: Build category tree from flat list ───
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
    nodes.forEach(n => { delete n.parentId; cleanParentId(n.children); });
  };
  cleanParentId(tree);
  return tree;
}

// ─── Public: GET /api/categories ───
app.get('/api/categories', async (req, res) => {
  try {
    const locale = req.query.locale || 'en';
    const { data, error } = await supabase.from('tabul_categories').select('*').eq('is_active', true);
    if (error) {
      console.error('Supabase error:', error);
      return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: 'Kategoriler alinamadi' });
    }
    const tree = buildCategoryTree(data || [], locale);
    return res.json({ success: true, data: { locale, categories: tree }, message: 'Categories fetched successfully' });
  } catch (err) {
    console.error('Categories error:', err);
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

app.listen(PORT, () => {
  console.log(`🚀 Tabul Server çalışıyor: http://localhost:${PORT}`);
  console.log(`📋 API Key durumu: ${process.env.OPENAI_API_KEY ? '✅ Tanımlı' : '❌ Tanımlı değil'}`);
  console.log(`\n📍 Endpoints:`);
  console.log(`   GET  /                          - Test UI`);
  console.log(`   POST /api/generate-cards        - Tabul kartları oluştur`);
  console.log(`   GET  /api/health                - Sunucu durumu`);
  console.log(`   GET  /api/categories            - Kategoriler (public)`);
});
