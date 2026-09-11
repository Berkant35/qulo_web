/**
 * Pages whose URL carries a secret or a personal identifier — Google Analytics
 * must never see them, because GA records the full URL of every page view:
 *
 * - `reset-password?token=…` — a one-hour password reset token. Anyone with
 *   access to the GA property could read it in Realtime and take over the account.
 * - `invite/<CODE>` — identifies the inviting user, who never consented.
 * - `email-verified` — reached straight from a verification email.
 *
 * Netlify also serves the unprefixed legacy paths (`/reset-password`), so the
 * locale segment is optional. Kept dependency-free for plain-Node tests.
 */
const SENSITIVE_PATH = /^(?:\/[a-z]{2})?\/(?:reset-password|email-verified|invite)(?:\/|$)/;

export function isSensitivePath(pathname: string): boolean {
  return SENSITIVE_PATH.test(pathname);
}
