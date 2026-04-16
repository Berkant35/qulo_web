require('dotenv').config();
const functions = require('firebase-functions');
const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');

const cardsConfig = require('./lib/cards/config');
const cardGenerator = require('./lib/cards/generator');
const { newReqId, createLogger } = require('./lib/logger');

// Environment variables: Firebase Functions config veya .env
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

const app = express();

// Middleware
app.use(cors({ origin: true }));
app.use(express.json());

// Tabul kartlari olusturma endpoint'i (strict-count, chunked, fill-loop)
app.post('/api/generate-cards', async (req, res) => {
  const reqId = newReqId();
  const logger = createLogger(reqId);

  try {
    const {
      prompt,
      cardCount = 50,
      model = cardsConfig.DEFAULT_MODEL,
      language = 'tr',
    } = req.body || {};

    // Input validation
    if (typeof prompt !== 'string' || prompt.trim().length === 0) {
      return res.status(400).json({
        success: false, errorCode: 'MISSING_PROMPT', message: 'Prompt gerekli', reqId,
      });
    }
    if (prompt.length > cardsConfig.MAX_PROMPT_LENGTH) {
      return res.status(400).json({
        success: false, errorCode: 'PROMPT_TOO_LONG',
        message: `Prompt en fazla ${cardsConfig.MAX_PROMPT_LENGTH} karakter olabilir`, reqId,
      });
    }
    const numericCount = Number(cardCount);
    if (!Number.isInteger(numericCount) || numericCount < cardsConfig.MIN_CARD_COUNT || numericCount > cardsConfig.MAX_CARD_COUNT) {
      return res.status(400).json({
        success: false, errorCode: 'INVALID_CARD_COUNT',
        message: `cardCount ${cardsConfig.MIN_CARD_COUNT}-${cardsConfig.MAX_CARD_COUNT} arasinda integer olmali`, reqId,
      });
    }
    const selectedModel = cardsConfig.ALLOWED_MODELS.includes(model) ? model : null;
    if (!selectedModel) {
      return res.status(400).json({
        success: false, errorCode: 'INVALID_MODEL',
        message: `model şunlardan biri olmalı: ${cardsConfig.ALLOWED_MODELS.join(', ')}`, reqId,
      });
    }
    if (!OPENAI_API_KEY) {
      return res.status(500).json({
        success: false, errorCode: 'OPENAI_AUTH_ERROR', message: 'OpenAI API key tanımlanmamış', reqId,
      });
    }

    // Generate
    const result = await cardGenerator.generate({
      prompt: prompt.trim(),
      cardCount: numericCount,
      model: selectedModel,
      language,
      apiKey: OPENAI_API_KEY,
      logger,
    });

    const status = result.success
      ? 200
      : (result.errorCode === 'INSUFFICIENT_CARDS' ? 422
        : result.errorCode === 'OPENAI_AUTH_ERROR' ? 500
        : result.errorCode === 'OPENAI_QUOTA' ? 500
        : 500);
    return res.status(status).json({ ...result, reqId });
  } catch (error) {
    logger.error('Unhandled error:', error?.message || error);
    return res.status(500).json({
      success: false, errorCode: 'GENERATION_ERROR',
      message: 'Kartlar oluşturulurken hata oluştu', reqId,
    });
  }
});

// Sunucu durumu kontrolü
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', apiKeyConfigured: !!OPENAI_API_KEY });
});

// ─── Utility: Build category tree from flat list ───
function buildCategoryTree(flatList, locale) {
  // Sadece istenen dilde ismi olan kategorileri al
  const filtered = flatList.filter(row => row.names && row.names[locale]);
  const localized = filtered.map(row => ({
    id: row.id,
    parentId: row.parent_id,
    name: row.names[locale],
    prompt: (row.prompts && row.prompts[locale]) || '',
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
    } else {
      // parent_id yoksa root, parent locale'de filtrelendiyse de root'a terfi
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
    const { data: admin } = await supabase.from('admin_users').select('id').eq('id', data.user.id).single();
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
    const { data: admin } = await supabase.from('admin_users').select('id').eq('id', user.id).single();
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
  // prompts bossa names'den otomatik olustur
  if (!body.prompts || typeof body.prompts !== 'object' || !Object.keys(body.prompts).length) {
    body.prompts = {};
    if (body.names && typeof body.names === 'object') {
      Object.entries(body.names).forEach(([locale, name]) => {
        body.prompts[locale] = name + ' ile ilgili tabul kartlari olustur';
      });
    }
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

// ─── Referral Codes ───

const REFERRAL_TIERS = ['bronze', 'silver', 'gold'];

// GET /api/admin/referral-codes
app.get('/api/admin/referral-codes', requireAdminAuth, async (req, res) => {
  try {
    const isActive = req.query.is_active;
    const order = req.query.order === 'current_redemptions.desc'
      ? 'current_redemptions' : 'created_at';

    let query = supabase.from('referral_codes').select('*');
    if (isActive === 'true') query = query.eq('is_active', true);
    if (isActive === 'false') query = query.eq('is_active', false);
    query = query.order(order, { ascending: false });

    const { data, error } = await query;
    if (error) throw error;
    return res.json({ success: true, data: data || [], message: 'Referans kodlari listelendi' });
  } catch (error) {
    console.error('Referral list error:', error.message);
    return res.status(500).json({ success: false, errorCode: 'REFERRAL_LIST_ERROR', message: error.message });
  }
});

// POST /api/admin/referral-codes
app.post('/api/admin/referral-codes', requireAdminAuth, async (req, res) => {
  try {
    const body = req.body || {};
    const code = (typeof body.code === 'string' ? body.code.trim() : '').toUpperCase();
    const tier = (body.tier || '').toLowerCase();
    const creditAmount = body.credit_amount != null ? Number(body.credit_amount) : 1;
    const maxRedemptions = body.max_redemptions != null ? Number(body.max_redemptions) : null;

    if (!code || code.length < 4 || code.length > 20) {
      return res.status(400).json({ success: false, message: 'Kod 4-20 karakter olmali' });
    }
    if (!REFERRAL_TIERS.includes(tier)) {
      return res.status(400).json({ success: false, message: 'Gecersiz tier. bronze, silver veya gold olmali' });
    }
    if (!Number.isInteger(creditAmount) || creditAmount < 1) {
      return res.status(400).json({ success: false, message: 'Kredi miktari 1 veya daha fazla olmali' });
    }

    const insertRow = {
      code, tier, credit_amount: creditAmount,
      max_redemptions: maxRedemptions || null,
      expires_at: body.expires_at || null,
      created_by: body.created_by || null,
      source: body.source || null,
      notes: body.notes || null,
    };

    const { data, error } = await supabase.from('referral_codes').insert(insertRow).select().single();
    if (error) {
      if (error.code === '23505') {
        return res.status(409).json({ success: false, message: 'Bu kod zaten mevcut' });
      }
      throw error;
    }
    return res.status(201).json({ success: true, data, message: 'Referans kodu olusturuldu' });
  } catch (error) {
    console.error('Referral create error:', error.message);
    return res.status(500).json({ success: false, errorCode: 'REFERRAL_CREATE_ERROR', message: error.message });
  }
});

// PATCH /api/admin/referral-codes/:code
app.patch('/api/admin/referral-codes/:code', requireAdminAuth, async (req, res) => {
  try {
    const code = (req.params.code || '').trim().toUpperCase();
    if (!code) return res.status(400).json({ success: false, message: 'Kod parametresi gerekli' });

    const body = req.body || {};
    const updates = {};
    if (typeof body.is_active === 'boolean') updates.is_active = body.is_active;
    if (body.max_redemptions != null) updates.max_redemptions = Number(body.max_redemptions);
    if (body.expires_at !== undefined) updates.expires_at = body.expires_at || null;
    if (body.notes !== undefined) updates.notes = body.notes;
    if (body.created_by !== undefined) updates.created_by = body.created_by;
    if (body.source !== undefined) updates.source = body.source;

    if (!Object.keys(updates).length) {
      return res.status(400).json({ success: false, message: 'Guncellenecek alan belirtilmedi' });
    }

    const { data, error } = await supabase.from('referral_codes').update(updates).eq('code', code).select().maybeSingle();
    if (error) throw error;
    if (!data) return res.status(404).json({ success: false, message: 'Referans kodu bulunamadi' });
    return res.json({ success: true, data, message: 'Referans kodu guncellendi' });
  } catch (error) {
    console.error('Referral update error:', error.message);
    return res.status(500).json({ success: false, errorCode: 'REFERRAL_UPDATE_ERROR', message: error.message });
  }
});

// GET /api/admin/referral-codes/:code/redemptions
app.get('/api/admin/referral-codes/:code/redemptions', requireAdminAuth, async (req, res) => {
  try {
    const code = (req.params.code || '').trim().toUpperCase();
    if (!code) return res.status(400).json({ success: false, message: 'Kod parametresi gerekli' });

    const { data: codeRow, error: codeError } = await supabase
      .from('referral_codes').select('id').eq('code', code).maybeSingle();
    if (codeError) throw codeError;
    if (!codeRow) return res.status(404).json({ success: false, message: 'Referans kodu bulunamadi' });

    const { data, error } = await supabase
      .from('referral_code_redemptions').select('*')
      .eq('referral_code_id', codeRow.id)
      .order('redeemed_at', { ascending: false });
    if (error) throw error;
    return res.json({ success: true, data: data || [], message: 'Kullanim loglari listelendi' });
  } catch (error) {
    console.error('Referral redemptions error:', error.message);
    return res.status(500).json({ success: false, errorCode: 'REFERRAL_REDEMPTIONS_ERROR', message: error.message });
  }
});

// Firebase Cloud Function olarak export (timeout 300sn, memory 512MB)
exports.api = functions.runWith({ timeoutSeconds: 300, memory: '512MB' }).https.onRequest(app);
