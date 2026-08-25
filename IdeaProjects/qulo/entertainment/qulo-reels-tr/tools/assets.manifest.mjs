// Her asset: id, prompt (kişiye özgü kısım), aspectRatio, referenceOf (opsiyonel — karakter tutarlılığı).
// STYLE_SUFFIX her prompt'un sonuna eklenir; kolaj sticker dilini ve yasakları sabitler.

export const STYLE_SUFFIX =
  ' Retro 1960s editorial magazine cut-out collage style with a modern twist: the person is MODERN, wearing contemporary 2020s fashion with a modern hairstyle. Black-and-white photographic figure, cut out as a sticker with a thick solid white contour outline tracing the silhouette. Full body visible head to shoes, photorealistic fashion-editorial quality, attractive and charismatic, fully clothed, tasteful. The figure is isolated on a solid pure green (#00FF00) background, nothing else in frame, figure does not touch image edges. No text, no letters, no numbers, no logos, no watermarks, no UI elements. Clothing must not contain any green colors.';

// Çift sahneleri (c_*): iki referans görselle (kadın + erkek) karakter tutarlılığı.
export const COUPLE_SUFFIX =
  ' Retro 1960s editorial magazine cut-out collage style with a modern twist: both people are MODERN, wearing contemporary 2020s fashion. Black-and-white photographic scene, cut out as a SINGLE sticker with one thick solid white contour outline tracing the whole group silhouette (people + described props together). Both people fully visible, photorealistic fashion-editorial quality, attractive, fully clothed, tasteful. Isolated on a solid pure green (#00FF00) background, nothing else in frame beyond the described scene, sticker does not touch image edges. No text, no letters, no numbers, no logos, no watermarks, no UI elements. Clothing must not contain any green colors.';

// Tam kare ortam plate'leri (bg_*): chroma key YOK, full-bleed arka plan.
export const BG_SUFFIX =
  ' Full-bleed vertical 9:16 background plate. Retro 1960s film-noir black-and-white photography with visible halftone print texture, cinematic dramatic lighting. Completely EMPTY of people — no humans, no silhouettes. No text, no letters, no numbers, no logos, no watermarks.';

// Gündüz sokak plate'leri (bg_* gündüz): chroma yok, retro sokak fotoğrafı.
export const BG_GUN_SUFFIX =
  ' Full-bleed vertical 9:16 background plate. Retro 1960s black-and-white STREET photography with visible halftone print texture, bright daylight, cinematic depth. Completely EMPTY of people — no humans, no silhouettes. No text, no letters, no numbers, no signage text, no logos, no watermarks.';

// Kedi sticker'ları (kedi_*): tek hayvan, sticker dili.
export const CAT_SUFFIX =
  ' Retro 1960s editorial magazine cut-out collage style: a single cat cut out as a sticker with a thick solid white contour outline. Black-and-white photographic animal with subtle halftone print texture. The whole cat fully visible, isolated on a solid pure green (#00FF00) background, nothing else in frame, does not touch image edges. No people, no text, no letters, no logos, no watermarks.';

// Nesne sticker'ları (prop_*): insan yok, tek nesne.
export const PROP_SUFFIX =
  ' Retro 1960s editorial magazine cut-out collage style: a single object cut out as a sticker with a thick solid white contour outline. Black-and-white photographic object with subtle halftone print texture. Isolated on a solid pure green (#00FF00) background, nothing else in frame, object does not touch image edges. No people, no text, no letters, no logos, no watermarks.';

export const MANIFEST = [
  {
    id: 'w1_hook',
    aspectRatio: '2:3',
    prompt:
      'A very attractive stylish young woman in her mid-20s, confident power pose with one hand on her hip, slight knowing smile, chic tailored outfit, looking straight at the camera.',
  },
  {
    id: 'w1_point',
    aspectRatio: '2:3',
    referenceOf: 'w1_hook',
    prompt:
      'The SAME woman as in the reference image — identical face, identical hairstyle, identical outfit. She now holds a large marker pen raised as if writing on an invisible board, playful confident expression, body turned slightly sideways.',
  },
  {
    id: 'm1',
    aspectRatio: '2:3',
    prompt:
      'A handsome well-groomed young man in his late 20s, modern smart-casual outfit (open collar shirt, chinos), confident smile, mid-stride walking pose facing the camera.',
  },
  {
    id: 'm2',
    aspectRatio: '2:3',
    prompt:
      'A handsome athletic young man in his mid-20s, stylish modern streetwear (bomber jacket, sneakers), waving hello with one hand, friendly grin.',
  },
  {
    id: 'm3',
    aspectRatio: '2:3',
    prompt:
      'A very charming handsome young man in his late 20s, stylish modern casual blazer over a t-shirt, warm genuine smile, presenting a small bouquet of flowers towards the camera.',
  },

  // ---- Varyant asset'leri (plan: 2026-07-12-qulo-reels-tr-variants.md) ----
  {
    id: 'm_hook',
    aspectRatio: '2:3',
    prompt:
      'A very handsome stylish young man in his late 20s, arms crossed, confident slight smirk, modern tailored dark overshirt and trousers, looking straight at the camera.',
  },
  {
    id: 'w2',
    aspectRatio: '2:3',
    prompt:
      'A very attractive stylish young woman in her mid-20s, chic casual outfit (leather jacket, jeans, ankle boots), mid-stride walking pose facing the camera, playful smile.',
  },
  {
    id: 'w3',
    aspectRatio: '2:3',
    prompt:
      'A very attractive athletic young woman in her mid-20s, stylish sporty-chic outfit, waving hello with one hand, friendly warm grin.',
  },
  {
    id: 'w1_tired',
    aspectRatio: '2:3',
    referenceOf: 'w1_hook',
    prompt:
      'The SAME woman as in the reference image — identical face, identical hairstyle. She now looks tired and overwhelmed: slumped shoulders, one hand pressed to her forehead, the other hand loosely holding a smartphone at her side, exhausted fed-up expression.',
  },
  {
    id: 'c_cafe',
    aspectRatio: '3:4',
    referenceOf: ['w1_hook', 'm3'],
    styleSuffix: COUPLE_SUFFIX,
    prompt:
      'A couple sitting close together at a small round café table with two coffee cups, laughing warmly at each other mid-conversation. The woman is the EXACT same woman as in the first reference image; the man is the EXACT same man as in the second reference image (no flower bouquet).',
  },
  {
    id: 'c_cat',
    aspectRatio: '3:4',
    referenceOf: ['w1_hook', 'm3'],
    styleSuffix: COUPLE_SUFFIX,
    prompt:
      'The same couple crouching down together, playing with a cute small cat between them, both smiling with delight at the cat. EXACTLY two people and one cat — no other people, no extra faces or heads, no duplicates. NO floor, NO ground plane, NO wooden boards, NO furniture: the figures and cat float directly on the solid pure green background as one cut-out sticker. The woman is the EXACT same woman as in the first reference image; the man is the EXACT same man as in the second reference image.',
  },
  {
    id: 'c_walk',
    aspectRatio: '3:4',
    referenceOf: ['w1_hook', 'm3'],
    styleSuffix: COUPLE_SUFFIX,
    prompt:
      'The same couple walking side by side arm in arm, relaxed and happy, both mid-laugh, mid-stride. NO scenery, NO trees, NO park, NO ground, NO bench — ONLY the two figures cut out as one sticker floating on the solid pure green background. The woman is the EXACT same woman as in the first reference image; the man is the EXACT same man as in the second reference image.',
  },
  {
    id: 'prop_plak',
    aspectRatio: '1:1',
    styleSuffix: PROP_SUFFIX,
    prompt: 'A classic vinyl record halfway out of its plain paper sleeve.',
  },
  {
    id: 'prop_pizza',
    aspectRatio: '1:1',
    styleSuffix: PROP_SUFFIX,
    prompt: 'A single appetizing slice of pizza with melted cheese.',
  },

  // ---- 2. dalga (plan: 2026-07-12-qulo-reels-tr-variants-2.md) ----
  {
    id: 'e_host',
    aspectRatio: '2:3',
    prompt:
      'A charismatic 1970s TV game show host: man in his 30s with a flashy patterned blazer and bow tie, holding a retro chrome microphone, exaggerated showman smile, one arm gesturing to the side as if presenting a stage.',
  },
  {
    id: 'e_curtain',
    aspectRatio: '3:4',
    styleSuffix: PROP_SUFFIX,
    prompt:
      'A section of heavy pleated theater stage curtain with dramatic vertical folds, retro TV studio look.',
  },
  {
    id: 'h_crowd1',
    aspectRatio: '3:4',
    styleSuffix: COUPLE_SUFFIX,
    prompt:
      'A group of three young modern people at a party standing close together, EVERY one of them staring down at their own smartphone, drinks in hands, completely ignoring each other. Cut out as one single group sticker.',
  },
  {
    id: 'h_crowd2',
    aspectRatio: '3:4',
    styleSuffix: COUPLE_SUFFIX,
    prompt:
      'A different group of three young modern people at a party, two half-turned away, all absorbed in their smartphones, one holding a cocktail glass. Cut out as one single group sticker.',
  },
  {
    id: 'h_look_w',
    aspectRatio: '2:3',
    referenceOf: 'w1_hook',
    prompt:
      'The SAME woman as in the reference image — identical face, identical hairstyle. At a party, glancing back over her shoulder towards the viewer with a subtle intrigued smile, holding a drink glass in one hand, stylish evening-casual outfit.',
  },
  {
    id: 'h_look_m',
    aspectRatio: '2:3',
    referenceOf: 'm_hook',
    prompt:
      'The SAME man as in the reference image — identical face, identical hairstyle. Looking off to the side with a curious interested expression, holding a glass in one hand, other hand in pocket, smart-casual evening outfit. ONLY this single figure — NO other people, NO background, NO room, NO curtains: the lone figure floats on the solid pure green background.',
  },
  {
    id: 'prop_disko',
    aspectRatio: '1:1',
    styleSuffix: PROP_SUFFIX,
    prompt: 'A classic mirrored disco ball hanging from a short chain.',
  },

  // ---- Varyant P "İlgi Bombardımanı" ----
  {
    id: 'p_phone',
    aspectRatio: '2:3',
    referenceOf: 'w1_hook',
    prompt:
      'The SAME woman as in the reference image — identical face, identical hairstyle. She holds a smartphone up with both hands at chest height, glancing down at the screen with a slightly overwhelmed, surprised expression (eyebrows raised), stylish chic outfit. ONLY this single figure — no other people, no background, floating on the solid pure green background.',
  },

  // ---- Varyant R2 "Sorgu Odası" — ortam plate'leri (chroma yok) ----
  {
    id: 'bg_sorgu',
    aspectRatio: '9:16',
    styleSuffix: BG_SUFFIX,
    prompt:
      'A police interrogation room: a bare metal table with one empty chair on the far side, a single bare light bulb hanging from a cord above the table casting a hard cone of light, a large one-way mirror window on the wall, faint cigarette smoke haze in the air, dark shadowy corners.',
  },
  {
    id: 'bg_mugshot',
    aspectRatio: '9:16',
    styleSuffix: BG_SUFFIX,
    prompt:
      'A police mugshot backdrop wall: plain wall with evenly spaced horizontal height-measurement lines (plain lines ONLY, no numbers, no letters), lit by a harsh direct camera flash, slight vignette at the edges.',
  },

  // ---- Varyant K2 "Kadıköy Kedileri" — yeni kast + Kadıköy ortamları ----
  {
    id: 'bg_kadikoy',
    aspectRatio: '9:16',
    styleSuffix: BG_GUN_SUFFIX,
    prompt:
      'A narrow charming Istanbul Kadıköy-style street: old buildings with bay windows, large colorful street-art mural painted on one wall, small café tables and chairs along the sidewalk, string lights across the street, cobblestones.',
  },
  {
    id: 'bg_moda',
    aspectRatio: '9:16',
    styleSuffix: BG_GUN_SUFFIX,
    prompt:
      'Istanbul Moda seaside promenade: waterfront railing in the foreground, calm sea, distant island silhouette on the horizon, a few seagulls flying far away, late afternoon light.',
  },
  {
    id: 'w4',
    aspectRatio: '2:3',
    prompt:
      'A very attractive glamorous young woman in her mid-20s with long wavy hair, elegant chic midi summer dress and heels, confident alluring pose with a knowing smile, looking at the camera.',
  },
  {
    id: 'erko_zengin',
    aspectRatio: '2:3',
    prompt:
      'A smug wealthy-looking man in his early 30s: open-collar shirt under a designer blazer, holding sunglasses in one hand and dangling a luxury car key fob from the other hand, self-satisfied smirk, flashy watch. NO car, NO brand logos, NO emblems anywhere.',
  },
  {
    id: 'erko_kasli',
    aspectRatio: '2:3',
    prompt:
      'A very muscular gym-guy in his late 20s wearing a tight fitted plain t-shirt and joggers, arms crossed to show off his biceps, confident chin-up posture, fully clothed.',
  },
  {
    id: 'italyan',
    aspectRatio: '2:3',
    prompt:
      'A very handsome Mediterranean Italian-style man in his early 30s: impeccably tailored light linen suit with open-collar shirt, neatly styled hair, warm charismatic smile, holding a tiny espresso cup elegantly, effortlessly stylish.',
  },
  {
    id: 'kedi_tekir',
    aspectRatio: '1:1',
    styleSuffix: CAT_SUFFIX,
    prompt: 'A tabby street cat sitting upright, looking straight at the camera with a serious judgmental expression.',
  },
  {
    id: 'kedi_sarman',
    aspectRatio: '1:1',
    styleSuffix: CAT_SUFFIX,
    prompt: 'An orange street cat mid-yawn, eyes squeezed shut, bored expression, sitting.',
  },
  {
    id: 'kedi_sb',
    aspectRatio: '1:1',
    styleSuffix: CAT_SUFFIX,
    prompt: 'A cute black-and-white tuxedo cat sitting with one front paw raised up as if approving or waving.',
  },

  // ---- K2 kedi aksiyon pozları (animatik: taban→bagir→pati, SpriteFlip) ----
  {
    id: 'kedi_tekir_bagir',
    aspectRatio: '1:1',
    referenceOf: 'kedi_tekir',
    styleSuffix: CAT_SUFFIX,
    prompt: 'The SAME tabby cat as in the reference image — identical fur pattern. Now yowling loudly: mouth wide open, ears flattened back, annoyed aggressive expression, still sitting.',
  },
  {
    id: 'kedi_tekir_pati',
    aspectRatio: '1:1',
    referenceOf: 'kedi_tekir',
    styleSuffix: CAT_SUFFIX,
    prompt: 'The SAME tabby cat as in the reference image — identical fur pattern. Now swiping one front paw forward fast in a rejecting slap motion, ears back, fierce look.',
  },
  {
    id: 'kedi_sarman_bagir',
    aspectRatio: '1:1',
    referenceOf: 'kedi_sarman',
    styleSuffix: CAT_SUFFIX,
    prompt: 'The SAME orange cat as in the reference image — identical fur. Now meowing loudly with mouth wide open, complaining expression, sitting.',
  },
  {
    id: 'kedi_sarman_pati',
    aspectRatio: '1:1',
    referenceOf: 'kedi_sarman',
    styleSuffix: CAT_SUFFIX,
    prompt: 'The SAME orange cat as in the reference image — identical fur. Now swiping a front paw sideways dismissively, unimpressed face.',
  },
  {
    id: 'kedi_sb_bagir',
    aspectRatio: '1:1',
    referenceOf: 'kedi_sb',
    styleSuffix: CAT_SUFFIX,
    prompt: 'The SAME tuxedo cat as in the reference image — identical fur pattern. Now meowing enthusiastically with mouth open, excited happy energy, sitting.',
  },
  {
    id: 'kedi_sb_pati',
    aspectRatio: '1:1',
    referenceOf: 'kedi_sb',
    styleSuffix: CAT_SUFFIX,
    prompt: 'The SAME tuxedo cat as in the reference image — identical fur pattern. Now playfully batting both front paws up in the air like a happy high-five, joyful.',
  },

  // ---- Lüks araç materyalleri (LOGO/AMBLEM/PLAKA ASLA) ----
  {
    id: 'prop_luks_sedan',
    aspectRatio: '3:2',
    styleSuffix: PROP_SUFFIX,
    prompt:
      'A sleek modern German-style luxury sedan, three-quarter front-side view, tinted windows, elegant lines, chrome details. NO brand badges, NO emblems, NO logos, blank license plate area with NO text.',
  },
  {
    id: 'prop_anahtarlik',
    aspectRatio: '1:1',
    styleSuffix: PROP_SUFFIX,
    prompt: 'A luxury car key fob with a leather keychain strap, dangling as if held up. NO brand logos, NO emblems, NO text.',
  },
  // ---- Varyant AN "Anne Onayı" (kültürel mizah) ----
  {
    id: 'bg_salon',
    aspectRatio: '9:16',
    styleSuffix: BG_SUFFIX,
    prompt:
      'A cozy traditional Turkish living room: a sofa with lace doilies on the armrests, a low coffee table with small tulip-shaped tea glasses, a patterned rug on the wall, warm homely atmosphere, soft lamp light.',
  },
  {
    id: 'anne',
    aspectRatio: '2:3',
    prompt:
      'A middle-aged Turkish mother in her 50s wearing an elegant blouse and cardigan, arms firmly crossed, a skeptical scrutinizing serious expression as if sizing someone up, looking straight at the camera. Dignified, fully clothed, tasteful.',
  },
  {
    id: 'anne_terlik',
    aspectRatio: '2:3',
    referenceOf: 'anne',
    styleSuffix: STYLE_SUFFIX,
    prompt:
      'The SAME middle-aged Turkish mother as in the reference image — identical face, identical outfit. Now she has one arm raised holding a house slipper up in the air as if about to playfully throw it, eyebrows furrowed with comic determination.',
  },
  {
    id: 'prop_terlik',
    aspectRatio: '1:1',
    styleSuffix: PROP_SUFFIX,
    prompt: 'A single classic house slipper, side view, mid-air throwing angle.',
  },

  // ---- Varyant S1 "Biz Neyiz?" (situationship, araştırma temelli) ----
  {
    id: 'bg_kafe',
    aspectRatio: '9:16',
    styleSuffix: BG_SUFFIX,
    prompt:
      'A dim intimate cocktail bar interior at night: small round tables with flickering candles, warm soft bokeh lights in the background, a long bar counter with bottles far behind, moody low-key lighting, cozy but a little melancholic.',
  },
  {
    id: 'w6',
    aspectRatio: '2:3',
    prompt:
      'A very attractive stylish young woman in her mid-20s with a chic elegant outfit, standing with arms lightly crossed and a skeptical, slightly tired but composed expression — as if she is done waiting for an answer, one eyebrow raised, waiting.',
  },
  {
    id: 'm_kacamak',
    aspectRatio: '2:3',
    prompt:
      'A handsome young man in his late 20s, casual trendy outfit, caught mid-shrug with both palms up and an awkward evasive half-smile, avoiding eye contact slightly, the look of someone dodging a serious question.',
  },

  // ---- Glam kast (Meta policy tavanında çekicilik: dekolte odağı YOK, üstsüz YOK) ----
  {
    id: 'w5',
    aspectRatio: '2:3',
    prompt:
      'A stunning glamorous young woman in her mid-20s: long flowing styled hair, elegant fitted knee-length evening dress with a tasteful modest V-neckline (no cleavage exposure, chest covered), high heels, confident alluring pose with one hand brushing her hair back, captivating smile.',
  },
  {
    id: 'm_fit',
    aspectRatio: '2:3',
    prompt:
      'A very handsome athletic man in his late 20s with a visibly muscular physique under a fitted open-collar dress shirt (only the top button open, chest covered), sleeves rolled up showing strong forearms, confident warm smile, smart trousers.',
  },
  {
    id: 'm_zengin2',
    aspectRatio: '2:3',
    prompt:
      'A wealthy-looking very handsome man in his early 30s wearing a tailored black tuxedo with the bow tie undone hanging loose around the collar, luxury wristwatch, adjusting his cufflink, self-assured charming smirk. NO brand logos.',
  },

  // ---- Varyant G1 "Hayalet Avı" (ghosting) ----
  {
    id: 'bg_gece',
    aspectRatio: '9:16',
    styleSuffix: BG_SUFFIX,
    prompt:
      'A dim night street: a single street lamp casting a cone of light, long shadows on cobblestones, light mist, dark building silhouettes, moody and slightly eerie but not scary.',
  },
  {
    id: 'hayalet_1',
    aspectRatio: '1:1',
    styleSuffix: PROP_SUFFIX,
    prompt:
      'A cute funny cartoon bedsheet ghost floating, simple white sheet with two oval dark eye holes, small arms out to the sides, friendly comic look.',
  },
  {
    id: 'hayalet_2',
    aspectRatio: '1:1',
    referenceOf: 'hayalet_1',
    styleSuffix: PROP_SUFFIX,
    prompt:
      'The SAME cute bedsheet ghost as in the reference image — identical style. Now turned slightly sideways, one arm raised waving goodbye, drifting upward.',
  },

  {
    id: 'erko_zengin_araba',
    aspectRatio: '3:4',
    referenceOf: 'erko_zengin',
    styleSuffix: COUPLE_SUFFIX,
    prompt:
      'EXACTLY one man and one car, no other people: the SAME smug wealthy man as in the reference image — identical face, identical outfit — leaning casually back against the side of a sleek luxury sedan with arms crossed and a self-satisfied smirk. The car has NO brand badges, NO emblems, NO logos, and a blank license plate with NO text. Man and car cut out together as ONE sticker.',
  },
];
