"use client";

import { useState, useEffect, useRef } from "react";
import { useTranslations } from "next-intl";

type State = "form" | "loading" | "success" | "error";

const API_URL =
  process.env.NEXT_PUBLIC_API_URL ||
  "https://qulo-server-production.up.railway.app";

export default function ResetPasswordPage() {
  const t = useTranslations("resetPassword");
  const [state, setState] = useState<State>("form");
  const [token, setToken] = useState<string | null>(null);
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [validationError, setValidationError] = useState<string | null>(null);

  const newPasswordRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const tokenParam = params.get("token");
    if (!tokenParam || !/^[a-f0-9]{64}$/.test(tokenParam)) {
      setState("error");
      return;
    }
    setToken(tokenParam);
    if (newPasswordRef.current) newPasswordRef.current.focus();
  }, []);

  function validate(): string | null {
    if (newPassword.length < 8) return t("passwordMinLength");
    if (newPassword !== confirmPassword) return t("passwordMismatch");
    return null;
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    const err = validate();
    if (err) {
      setValidationError(err);
      return;
    }
    setValidationError(null);
    setState("loading");

    try {
      const res = await fetch(`${API_URL}/api/v1/auth/reset-password`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ token, password: newPassword }),
      });

      if (res.ok) {
        setState("success");
      } else {
        setState("error");
      }
    } catch {
      setState("error");
    }
  }

  return (
    <main className="min-h-screen flex flex-col items-center justify-center bg-qulo-bg text-white px-6 py-12">
      {/* Logo */}
      <a
        href="/"
        className="text-3xl font-bold tracking-tight mb-10"
        style={{
          textShadow: "0 0 40px rgba(187,134,252,0.6)",
          color: "#BB86FC",
        }}
      >
        Qulo
      </a>

      <div className="w-full max-w-sm bg-qulo-bg-surface rounded-2xl border border-white/[0.08] p-8 shadow-xl">
        {/* SUCCESS STATE */}
        {state === "success" && (
          <div className="flex flex-col items-center text-center gap-4">
            <div className="w-16 h-16 rounded-full bg-green-500/10 border border-green-500/30 flex items-center justify-center">
              <svg
                className="w-8 h-8 text-green-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                strokeWidth={2}
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M5 13l4 4L19 7"
                />
              </svg>
            </div>
            <h1 className="text-xl font-bold text-white">{t("success")}</h1>
            <p className="text-sm text-qulo-text-secondary">{t("successDesc")}</p>
            <a
              href="qulo://"
              className="mt-4 inline-flex items-center justify-center px-6 py-2.5 rounded-xl font-semibold text-sm bg-gradient-to-r from-qulo-purple to-qulo-purple-dark text-white transition-all duration-200 hover:-translate-y-0.5 hover:shadow-[0_0_24px_rgba(187,134,252,0.5)]"
            >
              {t("backToApp")}
            </a>
          </div>
        )}

        {/* ERROR STATE */}
        {state === "error" && (
          <div className="flex flex-col items-center text-center gap-4">
            <div className="w-16 h-16 rounded-full bg-red-500/10 border border-red-500/30 flex items-center justify-center">
              <svg
                className="w-8 h-8 text-red-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                strokeWidth={2}
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </div>
            <h1 className="text-xl font-bold text-white">{t("error")}</h1>
            <p className="text-sm text-qulo-text-secondary">{t("errorDesc")}</p>
            <a
              href="qulo://"
              className="mt-4 inline-flex items-center justify-center px-6 py-2.5 rounded-xl font-semibold text-sm bg-gradient-to-r from-qulo-purple to-qulo-purple-dark text-white transition-all duration-200 hover:-translate-y-0.5 hover:shadow-[0_0_24px_rgba(187,134,252,0.5)]"
            >
              {t("backToApp")}
            </a>
          </div>
        )}

        {/* FORM / LOADING STATE */}
        {(state === "form" || state === "loading") && (
          <>
            <h1 className="text-xl font-bold text-white mb-6 text-center">
              {t("title")}
            </h1>

            <form onSubmit={handleSubmit} className="flex flex-col gap-4">
              {/* New Password */}
              <div className="flex flex-col gap-1.5">
                <label htmlFor="new-password" className="text-sm text-qulo-text-secondary">
                  {t("newPassword")}
                </label>
                <input
                  id="new-password"
                  ref={newPasswordRef}
                  type="password"
                  value={newPassword}
                  onChange={(e) => {
                    setNewPassword(e.target.value);
                    setValidationError(null);
                  }}
                  required
                  minLength={8}
                  disabled={state === "loading"}
                  className="w-full px-4 py-3 rounded-xl bg-white/[0.06] border border-white/[0.12] text-white placeholder-qulo-text-muted text-sm focus:outline-none focus:border-qulo-purple/60 focus:bg-white/[0.08] transition-colors disabled:opacity-50"
                  placeholder="••••••••"
                  autoComplete="new-password"
                />
              </div>

              {/* Confirm Password */}
              <div className="flex flex-col gap-1.5">
                <label htmlFor="confirm-password" className="text-sm text-qulo-text-secondary">
                  {t("confirmPassword")}
                </label>
                <input
                  id="confirm-password"
                  type="password"
                  value={confirmPassword}
                  onChange={(e) => {
                    setConfirmPassword(e.target.value);
                    setValidationError(null);
                  }}
                  required
                  minLength={8}
                  disabled={state === "loading"}
                  className="w-full px-4 py-3 rounded-xl bg-white/[0.06] border border-white/[0.12] text-white placeholder-qulo-text-muted text-sm focus:outline-none focus:border-qulo-purple/60 focus:bg-white/[0.08] transition-colors disabled:opacity-50"
                  placeholder="••••••••"
                  autoComplete="new-password"
                />
              </div>

              {/* Validation Error */}
              {validationError && (
                <p className="text-red-400 text-xs" role="alert">{validationError}</p>
              )}

              {/* Submit */}
              <button
                type="submit"
                disabled={state === "loading"}
                className="mt-2 w-full inline-flex items-center justify-center px-6 py-3 rounded-xl font-semibold text-sm bg-gradient-to-r from-qulo-purple to-qulo-purple-dark text-white transition-all duration-200 hover:-translate-y-0.5 hover:shadow-[0_0_24px_rgba(187,134,252,0.5)] disabled:opacity-60 disabled:cursor-not-allowed disabled:translate-y-0 disabled:shadow-none"
              >
                {state === "loading" ? (
                  <span className="flex items-center gap-2">
                    <svg
                      className="animate-spin h-4 w-4 text-white"
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                    >
                      <circle
                        className="opacity-25"
                        cx="12"
                        cy="12"
                        r="10"
                        stroke="currentColor"
                        strokeWidth="4"
                      />
                      <path
                        className="opacity-75"
                        fill="currentColor"
                        d="M4 12a8 8 0 018-8v8H4z"
                      />
                    </svg>
                    {t("submit")}
                  </span>
                ) : (
                  t("submit")
                )}
              </button>
            </form>
          </>
        )}
      </div>
    </main>
  );
}
