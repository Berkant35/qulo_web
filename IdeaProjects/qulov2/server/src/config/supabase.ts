import { createClient } from '@supabase/supabase-js';
import { env } from './env.js';

export const supabase = createClient(env.SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);

export async function ensureStorageBuckets() {
  const { data: buckets, error } = await supabase.storage.listBuckets();
  if (error) {
    console.error("[storage] Failed to list buckets:", error.message);
    return;
  }

  const bucketName = "photos";
  const exists = buckets?.some((b) => b.name === bucketName);

  if (!exists) {
    const { error: createError } = await supabase.storage.createBucket(bucketName, {
      public: true,
      fileSizeLimit: 5 * 1024 * 1024, // 5MB
      allowedMimeTypes: ["image/jpeg", "image/png"],
    });

    if (createError) {
      console.error("[storage] Failed to create bucket:", createError.message);
    } else {
      console.log("[storage] Created 'photos' bucket");
    }
  } else {
    console.log("[storage] 'photos' bucket exists");
  }
}
