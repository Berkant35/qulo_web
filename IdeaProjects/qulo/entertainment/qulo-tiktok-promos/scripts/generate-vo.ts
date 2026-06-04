import 'dotenv/config';
import {ElevenLabsClient} from 'elevenlabs';
import {writeFile, mkdir} from 'node:fs/promises';
import {dirname, resolve} from 'node:path';
import {fileURLToPath} from 'node:url';
const __dirname = dirname(fileURLToPath(import.meta.url));

const SCRIPT_TEXT = `Be honest. Months on a dating app. Met no one.

You match. They ghost. You match. They ghost. Forever loop. Sound familiar?

But there's a new app. You don't swipe. You solve.

It's called Qulo. You open it, see someone interesting — but instead of swiping, you read her three questions. The ones she wrote to filter people exactly like you.

Answer all three. Get them right. Pineapple on pizza? You better know her answer. Mountains or beach? Don't guess. Last red-flag question? Nail it. Get one wrong — game over, no match. Get all three? You just earned something most apps never made you earn.

Boom. Three for three. Match unlocked. You didn't swipe your way in — you earned it. And yeah, you just earned five diamonds too.

Now you actually talk. About something real. Pineapple on pizza? Bold take. She just opened with that. No "hey," no awkward opener — the match handed you the script.

Now your turn. Build your own three questions — the filter only people who actually get you will pass. Want only mountain people? Make question two impossible for beach people. The boring ones never make it through.

Stuck for ideas? Tap once. Qulo's AI reads your profile and writes three questions in your voice. Done in two seconds.

Here's the fun part. When someone solves your questions, you earn green diamonds. Spend thirty on a boost — thirty minutes of priority placement, and suddenly everyone interesting is solving yours. A whole economy.

No empty chats. No guessing if they actually like you. No effort wasted on people who'd ghost anyway. Just real questions, real answers, real matches.

So stop swiping. Start matching. Qulo is free, on iOS and Android right now. Link in bio. Go earn one.`;

async function main() {
  const apiKey = process.env.ELEVENLABS_API_KEY;
  const voiceId = process.env.ELEVENLABS_VOICE_ID ?? 'AZnzlk1XvdvUeBnXmlld';
  if (!apiKey) {
    throw new Error('ELEVENLABS_API_KEY missing — copy .env.example to .env and set the key');
  }

  const client = new ElevenLabsClient({apiKey});
  console.log(`Generating VO (voice: ${voiceId}, ${SCRIPT_TEXT.length} chars)...`);

  const audioStream = await client.textToSpeech.convert(voiceId, {
    text: SCRIPT_TEXT,
    model_id: 'eleven_multilingual_v2',
    output_format: 'mp3_44100_192',
    voice_settings: {
      stability: 0.45,
      similarity_boost: 0.75,
      style: 0.55,
      use_speaker_boost: true,
    },
  });

  const chunks: Buffer[] = [];
  for await (const chunk of audioStream) {
    chunks.push(Buffer.from(chunk));
  }
  const buffer = Buffer.concat(chunks);

  const outPath = resolve(__dirname, '..', 'public', 'audio', 'raw', 'vo.mp3');
  await mkdir(dirname(outPath), {recursive: true});
  await writeFile(outPath, buffer);
  console.log(`✓ VO written to ${outPath} (${(buffer.length / 1024).toFixed(1)} KB)`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
