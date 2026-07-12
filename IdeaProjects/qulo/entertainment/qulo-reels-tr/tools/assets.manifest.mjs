// Her asset: id, prompt (kişiye özgü kısım), aspectRatio, referenceOf (opsiyonel — karakter tutarlılığı).
// STYLE_SUFFIX her prompt'un sonuna eklenir; kolaj sticker dilini ve yasakları sabitler.

export const STYLE_SUFFIX =
  ' Retro 1960s editorial magazine cut-out collage style with a modern twist: the person is MODERN, wearing contemporary 2020s fashion with a modern hairstyle. Black-and-white photographic figure, cut out as a sticker with a thick solid white contour outline tracing the silhouette. Full body visible head to shoes, photorealistic fashion-editorial quality, attractive and charismatic, fully clothed, tasteful. The figure is isolated on a solid pure green (#00FF00) background, nothing else in frame, figure does not touch image edges. No text, no letters, no numbers, no logos, no watermarks, no UI elements. Clothing must not contain any green colors.';

// Çift sahneleri (c_*): iki referans görselle (kadın + erkek) karakter tutarlılığı.
export const COUPLE_SUFFIX =
  ' Retro 1960s editorial magazine cut-out collage style with a modern twist: both people are MODERN, wearing contemporary 2020s fashion. Black-and-white photographic scene, cut out as a SINGLE sticker with one thick solid white contour outline tracing the whole group silhouette (people + described props together). Both people fully visible, photorealistic fashion-editorial quality, attractive, fully clothed, tasteful. Isolated on a solid pure green (#00FF00) background, nothing else in frame beyond the described scene, sticker does not touch image edges. No text, no letters, no numbers, no logos, no watermarks, no UI elements. Clothing must not contain any green colors.';

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
];
