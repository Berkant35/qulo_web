import { supabase } from "../config/supabase.js";
import { Errors } from "../utils/errors.js";

export class DiamondService {
  async getBalance(userId: string) {
    const { data, error } = await supabase
      .from("users")
      .select("green_diamonds, purple_diamonds")
      .eq("id", userId)
      .single();

    if (error || !data) {
      throw Errors.USER_NOT_FOUND();
    }

    return { green: data.green_diamonds, purple: data.purple_diamonds };
  }

  async getHistory(userId: string, page = 1, limit = 20) {
    const from = (page - 1) * limit;
    const to = from + limit - 1;

    const { data, error, count } = await supabase
      .from("diamond_transactions")
      .select("*", { count: "exact" })
      .eq("user_id", userId)
      .order("created_at", { ascending: false })
      .range(from, to);

    if (error) {
      throw Errors.SERVER_ERROR();
    }

    return {
      items: data ?? [],
      total: count ?? 0,
      page,
      limit,
    };
  }

  async spendPurple(
    userId: string,
    amount: number,
    reason: string,
    referenceId?: string,
  ) {
    // Read current balance
    const { data: user, error: readErr } = await supabase
      .from("users")
      .select("purple_diamonds")
      .eq("id", userId)
      .single();

    if (readErr || !user) {
      throw Errors.USER_NOT_FOUND();
    }

    if (user.purple_diamonds < amount) {
      throw Errors.INSUFFICIENT_DIAMONDS(amount, user.purple_diamonds);
    }

    // Decrement balance
    const { error: updateErr } = await supabase
      .from("users")
      .update({ purple_diamonds: user.purple_diamonds - amount })
      .eq("id", userId);

    if (updateErr) {
      throw Errors.SERVER_ERROR();
    }

    // Insert transaction log
    const { error: txErr } = await supabase
      .from("diamond_transactions")
      .insert({
        user_id: userId,
        type: "PURPLE",
        amount: -amount,
        reason,
        reference_id: referenceId ?? null,
      });

    if (txErr) {
      throw Errors.SERVER_ERROR();
    }

    return { purple: user.purple_diamonds - amount };
  }

  async addPurple(
    userId: string,
    amount: number,
    reason: string,
    referenceId?: string,
  ) {
    // Read current balance
    const { data: user, error: readErr } = await supabase
      .from("users")
      .select("purple_diamonds")
      .eq("id", userId)
      .single();

    if (readErr || !user) {
      throw Errors.USER_NOT_FOUND();
    }

    // Increment balance
    const newBalance = user.purple_diamonds + amount;

    const { error: updateErr } = await supabase
      .from("users")
      .update({ purple_diamonds: newBalance })
      .eq("id", userId);

    if (updateErr) {
      throw Errors.SERVER_ERROR();
    }

    // Insert transaction log
    const { error: txErr } = await supabase
      .from("diamond_transactions")
      .insert({
        user_id: userId,
        type: "PURPLE",
        amount: +amount,
        reason,
        reference_id: referenceId ?? null,
      });

    if (txErr) {
      throw Errors.SERVER_ERROR();
    }

    return { purple: newBalance };
  }

  async earnGreen(
    userId: string,
    amount: number,
    reason: string,
    referenceId?: string,
  ) {
    // Read current balance
    const { data: user, error: readErr } = await supabase
      .from("users")
      .select("green_diamonds")
      .eq("id", userId)
      .single();

    if (readErr || !user) {
      throw Errors.USER_NOT_FOUND();
    }

    // Increment balance
    const newBalance = user.green_diamonds + amount;

    const { error: updateErr } = await supabase
      .from("users")
      .update({ green_diamonds: newBalance })
      .eq("id", userId);

    if (updateErr) {
      throw Errors.SERVER_ERROR();
    }

    // Insert transaction log
    const { error: txErr } = await supabase
      .from("diamond_transactions")
      .insert({
        user_id: userId,
        type: "GREEN",
        amount: +amount,
        reason,
        reference_id: referenceId ?? null,
      });

    if (txErr) {
      throw Errors.SERVER_ERROR();
    }

    return { green: newBalance };
  }

  async spendGreen(
    userId: string,
    amount: number,
    reason: string,
    referenceId?: string,
  ) {
    // Read current balance
    const { data: user, error: readErr } = await supabase
      .from("users")
      .select("green_diamonds")
      .eq("id", userId)
      .single();

    if (readErr || !user) {
      throw Errors.USER_NOT_FOUND();
    }

    if (user.green_diamonds < amount) {
      throw Errors.INSUFFICIENT_DIAMONDS(amount, user.green_diamonds);
    }

    // Decrement balance
    const newBalance = user.green_diamonds - amount;

    const { error: updateErr } = await supabase
      .from("users")
      .update({ green_diamonds: newBalance })
      .eq("id", userId);

    if (updateErr) {
      throw Errors.SERVER_ERROR();
    }

    // Insert transaction log
    const { error: txErr } = await supabase
      .from("diamond_transactions")
      .insert({
        user_id: userId,
        type: "GREEN",
        amount: -amount,
        reason,
        reference_id: referenceId ?? null,
      });

    if (txErr) {
      throw Errors.SERVER_ERROR();
    }

    return { green: newBalance };
  }
}

export const diamondService = new DiamondService();
