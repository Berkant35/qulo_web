import { createRequire } from 'node:module';
import { getFcm } from '../config/firebase.js';
import { supabase } from '../config/supabase.js';

const require = createRequire(import.meta.url);

const locales: Record<string, Record<string, Record<string, string>>> = {
  en: require('../locales/en.json'),
  tr: require('../locales/tr.json'),
};

type PushType = 'new_message' | 'new_message_image' | 'new_match' | 'quiz_started' | 'passport_expired' | 'campaign';

const ACTION_URL_MAP: Partial<Record<PushType, string>> = {
  new_match: '/matches',
  quiz_started: '/discover',
  passport_expired: '/profile/passport',
};

function interpolate(template: string, params: Record<string, string>): string {
  return template.replace(/\{(\w+)\}/g, (_, key: string) => params[key] ?? `{${key}}`);
}

export class NotificationService {
  static async sendPush(
    userId: string,
    type: PushType,
    params: Record<string, string> = {},
    data?: Record<string, string>,
    options?: {
      title?: string;
      imageUrl?: string;
      actionUrl?: string;
      actionLabel?: string;
      campaignId?: string;
    },
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
      const title = options?.title ?? 'Qulo';
      const actionUrl = options?.actionUrl ?? ACTION_URL_MAP[type] ?? null;

      // 4. Persist notification to DB
      const { data: notification } = await supabase
        .from('notifications')
        .insert({
          user_id: userId,
          campaign_id: options?.campaignId ?? null,
          type,
          title,
          body,
          image_url: options?.imageUrl ?? null,
          action_url: actionUrl,
          action_label: options?.actionLabel ?? null,
        })
        .select('id')
        .single();

      // 5. Send via FCM
      const fcm = getFcm();
      if (!fcm) return;
      await fcm.send({
        token: user.push_token,
        notification: { title, body },
        data: {
          type,
          ...(notification?.id ? { notification_id: notification.id } : {}),
          ...(actionUrl ? { action_url: actionUrl } : {}),
          ...data,
        },
      });
    } catch (err) {
      console.error(`[NotificationService] Failed to send push (type=${type}, user=${userId}):`, err);
    }
  }
}
