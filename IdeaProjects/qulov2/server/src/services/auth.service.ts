import { supabase } from "../config/supabase.js";
import { AppError, Errors } from "../utils/errors.js";
import { hashPassword, comparePassword, hashToken, generateToken } from "../utils/hash.js";
import { signAccessToken, signRefreshToken, verifyRefreshToken } from "../utils/jwt.js";
import { sendVerificationEmail, sendPasswordResetEmail } from "../utils/email.js";
import type { RegisterInput, LoginInput } from "../validators/auth.validator.js";

export class AuthService {
  async register(data: RegisterInput) {
    // Check if email already exists
    const { data: existing } = await supabase
      .from("users")
      .select("id")
      .eq("email", data.email)
      .maybeSingle();

    if (existing) {
      throw Errors.EMAIL_ALREADY_EXISTS();
    }

    const passwordHash = await hashPassword(data.password);
    const verifyToken = generateToken();
    const verifyTokenHash = hashToken(verifyToken);

    const { data: user, error } = await supabase
      .from("users")
      .insert({
        email: data.email,
        password_hash: passwordHash,
        name: data.name,
        surname: data.surname,
        age: data.age,
        gender: data.gender,
        locale: data.locale,
        verify_token: verifyTokenHash,
        email_verified: false,
      })
      .select("id, email")
      .single();

    if (error || !user) {
      throw Errors.SERVER_ERROR();
    }

    // Send verification email (non-blocking — don't let email failure block registration)
    sendVerificationEmail(data.email, verifyToken, data.locale).catch((err) => {
      console.error("[auth] Failed to send verification email:", err);
    });

    return { userId: user.id, email: user.email };
  }

  async verifyEmail(token: string) {
    const tokenHash = hashToken(token);

    const { data: user, error } = await supabase
      .from("users")
      .select("id")
      .eq("verify_token", tokenHash)
      .eq("email_verified", false)
      .maybeSingle();

    if (error || !user) {
      throw Errors.INVALID_TOKEN();
    }

    const { error: updateError } = await supabase
      .from("users")
      .update({ email_verified: true, verify_token: null })
      .eq("id", user.id);

    if (updateError) {
      throw Errors.SERVER_ERROR();
    }

    return { userId: user.id };
  }

  async login(email: string, password: string) {
    const { data: user, error } = await supabase
      .from("users")
      .select("id, email, password_hash, email_verified, deleted_at")
      .eq("email", email)
      .maybeSingle();

    if (error || !user) {
      throw Errors.INVALID_CREDENTIALS();
    }

    if (user.deleted_at) {
      throw Errors.INVALID_CREDENTIALS();
    }

    if (!user.email_verified) {
      throw Errors.EMAIL_NOT_VERIFIED();
    }

    const valid = await comparePassword(password, user.password_hash);
    if (!valid) {
      throw Errors.INVALID_CREDENTIALS();
    }

    const payload = { userId: user.id, email: user.email };
    const accessToken = signAccessToken(payload);
    const refreshToken = signRefreshToken(payload);
    const refreshTokenHash = hashToken(refreshToken);

    // Store refresh token
    await supabase.from("refresh_tokens").insert({
      user_id: user.id,
      token_hash: refreshTokenHash,
      expires_at: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
    });

    // Update last_seen and is_online
    await supabase
      .from("users")
      .update({ last_seen: new Date().toISOString(), is_online: true })
      .eq("id", user.id);

    return { accessToken, refreshToken, userId: user.id };
  }

  async refresh(refreshToken: string) {
    let payload;
    try {
      payload = verifyRefreshToken(refreshToken);
    } catch {
      throw Errors.INVALID_TOKEN();
    }

    const oldHash = hashToken(refreshToken);

    // Find and delete the old refresh token
    const { data: storedToken, error } = await supabase
      .from("refresh_tokens")
      .select("id, user_id")
      .eq("token_hash", oldHash)
      .maybeSingle();

    if (error || !storedToken) {
      throw Errors.INVALID_TOKEN();
    }

    // Delete old token
    await supabase.from("refresh_tokens").delete().eq("id", storedToken.id);

    // Create new tokens
    const newPayload = { userId: payload.userId, email: payload.email };
    const newAccessToken = signAccessToken(newPayload);
    const newRefreshToken = signRefreshToken(newPayload);
    const newRefreshTokenHash = hashToken(newRefreshToken);

    // Store new refresh token
    await supabase.from("refresh_tokens").insert({
      user_id: payload.userId,
      token_hash: newRefreshTokenHash,
      expires_at: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
    });

    return { accessToken: newAccessToken, refreshToken: newRefreshToken };
  }

  async logout(userId: string, refreshToken?: string) {
    if (refreshToken) {
      const tokenHash = hashToken(refreshToken);
      await supabase
        .from("refresh_tokens")
        .delete()
        .eq("token_hash", tokenHash);
    }

    await supabase
      .from("users")
      .update({ is_online: false })
      .eq("id", userId);
  }

  async forgotPassword(email: string) {
    const { data: user } = await supabase
      .from("users")
      .select("id, locale")
      .eq("email", email)
      .maybeSingle();

    // Don't reveal whether email exists
    if (!user) return;

    const token = generateToken();
    const tokenHash = hashToken(token);

    await supabase
      .from("users")
      .update({ verify_token: tokenHash })
      .eq("id", user.id);

    sendPasswordResetEmail(email, token, user.locale).catch((err) => {
      console.error("[auth] Failed to send password reset email:", err);
    });
  }

  async resetPassword(token: string, password: string) {
    const tokenHash = hashToken(token);

    const { data: user, error } = await supabase
      .from("users")
      .select("id")
      .eq("verify_token", tokenHash)
      .maybeSingle();

    if (error || !user) {
      throw Errors.INVALID_TOKEN();
    }

    const passwordHash = await hashPassword(password);

    await supabase
      .from("users")
      .update({ password_hash: passwordHash, verify_token: null })
      .eq("id", user.id);

    // Delete all refresh tokens for this user
    await supabase
      .from("refresh_tokens")
      .delete()
      .eq("user_id", user.id);

    return { userId: user.id };
  }
}

export const authService = new AuthService();
