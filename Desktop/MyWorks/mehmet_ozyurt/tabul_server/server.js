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

// ─── Admin: Login ───
app.post('/api/admin/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) return res.status(400).json({ success: false, message: 'Email ve sifre gerekli' });
    const { data, error } = await supabase.auth.signInWithPassword({ email, password });
    if (error || !data.session) return res.status(401).json({ success: false, message: 'Gecersiz kimlik bilgileri' });
    const { data: admin } = await supabase.from('admin_users').select('id').eq('user_id', data.user.id).single();
    if (!admin) return res.status(403).json({ success: false, message: 'Admin yetkisi yok' });
    return res.json({ success: true, data: { token: data.session.access_token }, message: 'Giris basarili' });
  } catch (err) {
    console.error('Login error:', err);
    return res.status(500).json({ success: false, message: 'Sunucu hatasi' });
  }
});

// ─── Middleware: Admin auth ───
async function requireAdminAuth(req, res, next) {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) return res.status(401).json({ success: false, errorCode: 'UNAUTHORIZED', message: 'Token gerekli' });
    const token = authHeader.split(' ')[1];
    const { data: { user }, error } = await supabase.auth.getUser(token);
    if (error || !user) return res.status(401).json({ success: false, errorCode: 'INVALID_TOKEN', message: 'Gecersiz token' });
    const { data: admin } = await supabase.from('admin_users').select('id').eq('user_id', user.id).single();
    if (!admin) return res.status(403).json({ success: false, errorCode: 'FORBIDDEN', message: 'Admin yetkisi gerekli' });
    req.adminUser = user;
    next();
  } catch (err) {
    console.error('Auth error:', err);
    return res.status(500).json({ success: false, errorCode: 'AUTH_ERROR', message: 'Yetkilendirme hatasi' });
  }
}

// ─── Validation helper ───
function validateCategory(body) {
  const errors = [];
  if (!body.names || typeof body.names !== 'object' || !Object.keys(body.names).length) {
    errors.push('names alani gerekli (en az bir dil)');
  }
  if (!body.prompts || typeof body.prompts !== 'object' || !Object.keys(body.prompts).length) {
    errors.push('prompts alani gerekli (en az bir dil)');
  }
  return errors;
}

// ─── Admin CRUD: GET all categories (flat) ───
app.get('/api/admin/categories', requireAdminAuth, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('tabul_categories')
      .select('*')
      .order('sort_order', { ascending: true });
    if (error) {
      console.error('Admin categories fetch error:', error);
      return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: 'Kategoriler alinamadi' });
    }
    return res.json({ success: true, data: data || [], message: 'Kategoriler basariyla getirildi' });
  } catch (err) {
    console.error('Admin categories error:', err);
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

// ─── Admin CRUD: POST create category ───
app.post('/api/admin/categories', requireAdminAuth, async (req, res) => {
  try {
    const errors = validateCategory(req.body);
    if (errors.length) return res.status(400).json({ success: false, message: errors.join(', ') });

    const { names, prompts, parent_id, sort_order, is_active, is_trending } = req.body;
    const insertData = {
      names,
      prompts,
      parent_id: parent_id || null,
      sort_order: sort_order ?? 0,
      is_active: is_active ?? true,
      is_trending: is_trending ?? false,
    };

    const { data, error } = await supabase.from('tabul_categories').insert(insertData).select().single();
    if (error) {
      console.error('Category create error:', error);
      return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: 'Kategori olusturulamadi' });
    }
    return res.status(201).json({ success: true, data, message: 'Kategori basariyla olusturuldu' });
  } catch (err) {
    console.error('Category create error:', err);
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

// ─── Admin CRUD: PATCH reorder (MUST be before /:id) ───
app.patch('/api/admin/categories/reorder', requireAdminAuth, async (req, res) => {
  try {
    const { orders } = req.body;
    if (!Array.isArray(orders)) return res.status(400).json({ success: false, message: 'orders dizisi gerekli' });

    const updates = orders.map(({ id, sort_order }) =>
      supabase.from('tabul_categories').update({ sort_order }).eq('id', id)
    );
    const results = await Promise.all(updates);
    const failed = results.filter(r => r.error);
    if (failed.length) {
      console.error('Reorder errors:', failed.map(f => f.error));
      return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: 'Siralama guncellenemedi' });
    }
    return res.json({ success: true, message: 'Siralama basariyla guncellendi' });
  } catch (err) {
    console.error('Reorder error:', err);
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

// ─── Admin CRUD: PATCH update category ───
app.patch('/api/admin/categories/:id', requireAdminAuth, async (req, res) => {
  try {
    const { id } = req.params;
    const { names, prompts, parent_id, sort_order, is_active, is_trending } = req.body;
    const updateData = {};
    if (names !== undefined) updateData.names = names;
    if (prompts !== undefined) updateData.prompts = prompts;
    if (parent_id !== undefined) updateData.parent_id = parent_id;
    if (sort_order !== undefined) updateData.sort_order = sort_order;
    if (is_active !== undefined) updateData.is_active = is_active;
    if (is_trending !== undefined) updateData.is_trending = is_trending;

    if (!Object.keys(updateData).length) return res.status(400).json({ success: false, message: 'Guncellenecek alan belirtilmedi' });

    const { data, error } = await supabase.from('tabul_categories').update(updateData).eq('id', id).select().single();
    if (error) {
      console.error('Category update error:', error);
      return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: 'Kategori guncellenemedi' });
    }
    return res.json({ success: true, data, message: 'Kategori basariyla guncellendi' });
  } catch (err) {
    console.error('Category update error:', err);
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

// ─── Admin CRUD: DELETE category ───
app.delete('/api/admin/categories/:id', requireAdminAuth, async (req, res) => {
  try {
    const { id } = req.params;
    const { error } = await supabase.from('tabul_categories').delete().eq('id', id);
    if (error) {
      console.error('Category delete error:', error);
      return res.status(500).json({ success: false, errorCode: 'DB_ERROR', message: 'Kategori silinemedi' });
    }
    return res.json({ success: true, message: 'Kategori basariyla silindi' });
  } catch (err) {
    console.error('Category delete error:', err);
    return res.status(500).json({ success: false, errorCode: 'SERVER_ERROR', message: 'Sunucu hatasi' });
  }
});

// ─── Admin panel HTML route ───
app.get('/admin', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'admin-categories.html'));
});

app.listen(PORT, () => {
  console.log(`🚀 Tabul Server çalışıyor: http://localhost:${PORT}`);
  console.log(`📋 API Key durumu: ${process.env.OPENAI_API_KEY ? '✅ Tanımlı' : '❌ Tanımlı değil'}`);
  console.log(`\n📍 Endpoints:`);
  console.log(`   GET  /                          - Test UI`);
  console.log(`   GET  /admin                     - Admin Panel`);
  console.log(`   POST /api/generate-cards        - Tabul kartları oluştur`);
  console.log(`   GET  /api/health                - Sunucu durumu`);
  console.log(`   GET  /api/categories            - Kategoriler (public)`);
  console.log(`   POST /api/admin/login           - Admin giriş`);
  console.log(`   GET  /api/admin/categories      - Admin: Tüm kategoriler`);
  console.log(`   POST /api/admin/categories      - Admin: Kategori oluştur`);
  console.log(`   PATCH /api/admin/categories/:id - Admin: Kategori güncelle`);
  console.log(`   DELETE /api/admin/categories/:id- Admin: Kategori sil`);
  console.log(`   PATCH /api/admin/categories/reorder - Admin: Sıralama`);
});
