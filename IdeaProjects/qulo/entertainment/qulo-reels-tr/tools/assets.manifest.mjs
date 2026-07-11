// Her asset: id, prompt (kişiye özgü kısım), aspectRatio, referenceOf (opsiyonel — karakter tutarlılığı).
// STYLE_SUFFIX her prompt'un sonuna eklenir; kolaj sticker dilini ve yasakları sabitler.

export const STYLE_SUFFIX =
  ' Retro 1960s editorial magazine cut-out collage style with a modern twist: the person is MODERN, wearing contemporary 2020s fashion with a modern hairstyle. Black-and-white photographic figure, cut out as a sticker with a thick solid white contour outline tracing the silhouette. Full body visible head to shoes, photorealistic fashion-editorial quality, attractive and charismatic, fully clothed, tasteful. The figure is isolated on a solid pure green (#00FF00) background, nothing else in frame, figure does not touch image edges. No text, no letters, no numbers, no logos, no watermarks, no UI elements. Clothing must not contain any green colors.';

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
];
