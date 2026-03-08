import { supabase } from '../config/supabase.js';
import { diamondService } from './diamond.service.js';
import {
  SubscriptionPlan,
  SubscriptionInfo,
  SUBSCRIPTION_LIMITS,
} from '../types/index.js';

class SubscriptionService {
  async getStatus(userId: string): Promise<SubscriptionInfo> {
    const { data: user, error } = await supabase
      .from('users')
      .select('subscription_plan, subscription_expires_at')
      .eq('id', userId)
      .single();

    if (error || !user) {
      return { plan: null, status: null, expiresAt: null, isActive: false };
    }

    const plan = user.subscription_plan as SubscriptionPlan | null;
    const expiresAt = user.subscription_expires_at;

    if (!plan || !expiresAt) {
      return { plan: null, status: null, expiresAt: null, isActive: false };
    }

    const isActive = new Date(expiresAt) > new Date();
    return {
      plan,
      status: isActive ? 'active' : 'expired',
      expiresAt,
      isActive,
    };
  }

  async activateSubscription(
    userId: string,
    plan: SubscriptionPlan,
    rcCustomerId: string,
    storeTransactionId: string,
    expiresAt: string
  ): Promise<void> {
    await supabase.from('user_subscriptions').insert({
      user_id: userId,
      plan,
      status: 'active',
      rc_customer_id: rcCustomerId,
      store_transaction_id: storeTransactionId,
      started_at: new Date().toISOString(),
      expires_at: expiresAt,
    });

    await supabase
      .from('users')
      .update({
        subscription_plan: plan,
        subscription_expires_at: expiresAt,
        rc_customer_id: rcCustomerId,
      })
      .eq('id', userId);

    const bonus = SUBSCRIPTION_LIMITS[plan].monthlyPurpleBonus;
    if (bonus > 0) {
      await diamondService.addPurple(
        userId,
        bonus,
        'SUBSCRIPTION_BONUS',
        storeTransactionId
      );
    }
  }

  async renewSubscription(
    userId: string,
    storeTransactionId: string,
    expiresAt: string
  ): Promise<void> {
    const { data: user } = await supabase
      .from('users')
      .select('subscription_plan')
      .eq('id', userId)
      .single();

    const plan = (user?.subscription_plan as SubscriptionPlan) || 'plus';

    await supabase
      .from('user_subscriptions')
      .update({
        status: 'active',
        expires_at: expiresAt,
        store_transaction_id: storeTransactionId,
        updated_at: new Date().toISOString(),
      })
      .eq('user_id', userId)
      .eq('status', 'active');

    await supabase
      .from('users')
      .update({ subscription_expires_at: expiresAt })
      .eq('id', userId);

    const bonus = SUBSCRIPTION_LIMITS[plan].monthlyPurpleBonus;
    if (bonus > 0) {
      await diamondService.addPurple(
        userId,
        bonus,
        'SUBSCRIPTION_BONUS',
        storeTransactionId
      );
    }
  }

  async cancelSubscription(userId: string): Promise<void> {
    await supabase
      .from('user_subscriptions')
      .update({
        status: 'cancelled',
        updated_at: new Date().toISOString(),
      })
      .eq('user_id', userId)
      .eq('status', 'active');
  }

  async expireSubscription(userId: string): Promise<void> {
    await supabase
      .from('user_subscriptions')
      .update({
        status: 'expired',
        updated_at: new Date().toISOString(),
      })
      .eq('user_id', userId)
      .eq('status', 'active');

    await supabase
      .from('users')
      .update({
        subscription_plan: null,
        subscription_expires_at: null,
      })
      .eq('id', userId);
  }

  async changeSubscription(
    userId: string,
    newPlan: SubscriptionPlan,
    storeTransactionId: string,
    expiresAt: string
  ): Promise<void> {
    await this.expireSubscription(userId);

    const { data: user } = await supabase
      .from('users')
      .select('rc_customer_id')
      .eq('id', userId)
      .single();

    await this.activateSubscription(
      userId,
      newPlan,
      user?.rc_customer_id || '',
      storeTransactionId,
      expiresAt
    );
  }

  getLimits(plan: SubscriptionPlan | null) {
    return SUBSCRIPTION_LIMITS[plan || 'free'];
  }
}

export const subscriptionService = new SubscriptionService();
