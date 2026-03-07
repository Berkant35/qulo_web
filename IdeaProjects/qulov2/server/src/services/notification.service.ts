import { createRequire } from 'node:module';
import { getFcm } from '../config/firebase.js';
import { supabase } from '../config/supabase.js';

const require = createRequire(import.meta.url);

const locales: Record<string, Record<string, Record<string, string>>> = {
  en: require('../locales/en.json'),
  tr: require('../locales/tr.json'),
};

type PushType = 'new_message' | 'new_message_image' | 'new_match' | 'quiz_started' | 'passport_expired';

function interpolate(template: string, params: Record<string, string>): string {
  return template.replace(/\{(\w+)\}/g, (_, key: string) => params[key] ?? `{${key}}`);
}

export class NotificationService {
  static async sendPush(
    userId: string,
    type: PushType,
    params: Record<string, string> = {},
    data?: Record<string, string>,
  ): Promise<void> {
    try {
      // 1. Get user's push_token and locale
      const { data: user, error } = await supabase
        .from('users')
        .select('push_token, locale')
        .eq('id', userId)
        .single();

      if (error || !user?.push_token) return;

      // 2. Resolve locale and get template
      const locale = user.locale && locales[user.locale] ? user.locale : 'en';
      const template = locales[locale]?.push?.[type];
      if (!template) return;

      // 3. Interpolate params into template
      const body = interpolate(template, params);

      // 4. Send via FCM
      const fcm = getFcm();
      if (!fcm) return;
      await fcm.send({
        token: user.push_token,
        notification: { title: 'Qulo', body },
        data: { type, ...data },
      });
    } catch (err) {
      console.error(`[NotificationService] Failed to send push (type=${type}, user=${userId}):`, err);
    }
  }
}
