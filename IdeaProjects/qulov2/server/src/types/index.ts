export interface JwtPayload {
  userId: string;
  email: string;
}

export type PowerName =
  | "COPY"
  | "HALF"
  | "SKIP"
  | "SKIP_ALL"
  | "TIME_EXTEND"
  | "HINT";

export const QUESTION_COUNT_MULTIPLIERS: Record<number, number> = {
  2: 0.5,
  3: 0.75,
  4: 1.0,
  5: 1.25,
  6: 1.5,
};

export const GREEN_DIAMOND_REWARD_RATIO = 0.3;

// Subscription Plans
export type SubscriptionPlan = 'plus' | 'premium';
export type SubscriptionStatus = 'active' | 'expired' | 'cancelled';

export interface SubscriptionInfo {
  plan: SubscriptionPlan | null;
  status: SubscriptionStatus | null;
  expiresAt: string | null;
  isActive: boolean;
}

// Subscription limits
export const SUBSCRIPTION_LIMITS = {
  free: {
    dailySwipes: 20,
    dailyUndos: 0,
    monthlyPurpleBonus: 0,
    weeklyBoosts: 0,
    canSeeWhoViewed: false,
    hasAds: true,
  },
  plus: {
    dailySwipes: 50,
    dailyUndos: 3,
    monthlyPurpleBonus: 100,
    weeklyBoosts: 1,
    canSeeWhoViewed: false,
    hasAds: false,
  },
  premium: {
    dailySwipes: Infinity,
    dailyUndos: Infinity,
    monthlyPurpleBonus: 300,
    weeklyBoosts: 7,
    canSeeWhoViewed: true,
    hasAds: false,
  },
} as const;

// RevenueCat webhook event types
export type RCEventType =
  | 'INITIAL_PURCHASE'
  | 'RENEWAL'
  | 'CANCELLATION'
  | 'UNCANCELLATION'
  | 'EXPIRATION'
  | 'BILLING_ISSUE'
  | 'PRODUCT_CHANGE'
  | 'NON_RENEWING_PURCHASE';

// IAP Product mapping (store_id → purple amount)
export const IAP_PRODUCT_MAP: Record<string, number> = {
  qulopurple50: 50,
  qulopurple150: 150,
  qulopurple400: 400,
  qulopurple1000: 1000,
  qulopurple2500: 2500,
  qulopurple6000: 6000,
};

// Subscription product IDs
export const SUBSCRIPTION_PRODUCT_MAP: Record<string, SubscriptionPlan> = {
  quloplusmonthly: 'plus',
  qulopremiummonthly: 'premium',
};
