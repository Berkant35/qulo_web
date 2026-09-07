"use client";

import { useCallback, useEffect, useState } from "react";
import { useLocale, useTranslations } from "next-intl";
import { fetchBank, createQuiz, QUIZ_QUESTION_COUNT, type BankQuestion } from "@/lib/api/webQuiz";
import { SITE_URL } from "@/lib/constants/metadata";
import { STORE_REDIRECT } from "@/lib/constants/links";
import { NeonButton } from "@/components/shared/NeonButton";
import { OptionButton } from "@/components/quiz/OptionButton";
import { ShareRow } from "@/components/quiz/ShareRow";

type Status = "loading" | "ready" | "creating" | "done" | "error";

/**
 * Create flow: pick 5 questions from the bank sample, tap your own answer on each,
 * add a nickname, confirm 18+, get a link. Questions come from the server bank only,
 * so the creator never types free text beyond the nickname.
 */
export function QuizCreator() {
  const t = useTranslations("quiz");
  const locale = useLocale();
  const [status, setStatus] = useState<Status>("loading");
  const [bank, setBank] = useState<BankQuestion[]>([]);
  const [picked, setPicked] = useState<Record<string, number>>({});
  const [nickname, setNickname] = useState("");
  const [ageConfirmed, setAgeConfirmed] = useState(false);
  const [slug, setSlug] = useState<string | null>(null);

  const loadBank = useCallback(async () => {
    setStatus("loading");
    try {
      setBank(await fetchBank(locale));
      setPicked({});
      setStatus("ready");
    } catch {
      setStatus("error");
    }
  }, [locale]);

  useEffect(() => {
    void loadBank();
  }, [loadBank]);

  const pickedCount = Object.keys(picked).length;
  const full = pickedCount >= QUIZ_QUESTION_COUNT;

  function toggle(questionId: string, answerIndex: number) {
    setPicked((prev) => {
      const next = { ...prev };
      if (next[questionId] === answerIndex) {
        delete next[questionId];
      } else if (questionId in next || Object.keys(next).length < QUIZ_QUESTION_COUNT) {
        next[questionId] = answerIndex;
      }
      return next;
    });
  }

  async function submit() {
    if (!full || !ageConfirmed || !nickname.trim()) return;
    setStatus("creating");
    try {
      const result = await createQuiz({
        locale,
        nickname: nickname.trim(),
        age_confirmed: true,
        items: Object.entries(picked).map(([bank_id, correct]) => ({ bank_id, correct })),
      });
      setSlug(result.slug);
      setStatus("done");
    } catch {
      setStatus("error");
    }
  }

  if (status === "done" && slug) {
    const url = `${SITE_URL}/q/${slug}`;
    return (
      <section className="flex flex-col gap-5 text-center">
        <h1 className="text-3xl font-bold text-qulo-green">{t("readyTitle")}</h1>
        <p className="text-qulo-text-secondary">{t("readyDesc")}</p>
        <p className="select-all rounded-xl border border-qulo-green/30 bg-qulo-green/5 px-4 py-3 font-mono text-sm break-all">
          {url}
        </p>
        <ShareRow text={t("shareCreateText", { url })} url={url} />
        <div className="mt-6 flex flex-col items-center gap-3 border-t border-white/10 pt-6">
          <p className="text-sm text-qulo-text-secondary">{t("appCta")}</p>
          <NeonButton href={STORE_REDIRECT("web-quiz-create")}>{t("appButton")}</NeonButton>
        </div>
      </section>
    );
  }

  return (
    <section className="flex flex-col gap-6">
      <header className="text-center">
        <h1 className="text-3xl font-bold text-qulo-purple">{t("title")}</h1>
        <p className="mt-2 text-qulo-text-secondary">{t("subtitle")}</p>
      </header>

      {status === "loading" && <p className="text-center text-qulo-text-muted animate-pulse">{t("loading")}</p>}
      {status === "error" && (
        <p className="text-center text-red-300">
          {t("errorGeneric")}{" "}
          <button type="button" onClick={loadBank} className="underline">
            {t("retry")}
          </button>
        </p>
      )}

      {(status === "ready" || status === "creating") && (
        <>
          <div className="flex items-center justify-between text-sm">
            <span className={full ? "text-qulo-green font-semibold" : "text-qulo-text-secondary"}>
              {t("pickCount", { count: pickedCount, total: QUIZ_QUESTION_COUNT })}
            </span>
            <button type="button" onClick={loadBank} className="text-qulo-purple underline">
              {t("refresh")}
            </button>
          </div>
          <p className="text-xs text-qulo-text-muted">{t("pickHint")}</p>

          <ol className="flex flex-col gap-4">
            {bank.map((q) => {
              const chosen = picked[q.id];
              const locked = full && chosen === undefined;
              return (
                <li key={q.id} className={locked ? "opacity-40" : ""}>
                  <p className="mb-2 text-sm font-semibold">{q.question_text}</p>
                  <div className="grid grid-cols-1 gap-1.5 sm:grid-cols-2">
                    {q.answers.map((label, i) => (
                      <OptionButton
                        key={i}
                        label={label}
                        state={locked ? "disabled" : chosen === i ? "selected" : "idle"}
                        onClick={locked ? undefined : () => toggle(q.id, i)}
                      />
                    ))}
                  </div>
                </li>
              );
            })}
          </ol>

          <div className="sticky bottom-0 -mx-5 border-t border-white/10 bg-qulo-bg/95 px-5 py-4 backdrop-blur">
            <label className="block text-xs text-qulo-text-secondary" htmlFor="quiz-nickname">
              {t("nicknameLabel")}
            </label>
            <input
              id="quiz-nickname"
              value={nickname}
              maxLength={24}
              onChange={(e) => setNickname(e.target.value)}
              placeholder={t("nicknamePlaceholder")}
              className="mt-1 w-full rounded-lg border border-white/15 bg-white/5 px-3 py-2 text-sm outline-none focus:border-qulo-purple"
            />
            <label className="mt-3 flex items-center gap-2 text-xs text-qulo-text-secondary">
              <input type="checkbox" checked={ageConfirmed} onChange={(e) => setAgeConfirmed(e.target.checked)} />
              {t("ageConfirm")}
            </label>
            <button
              type="button"
              onClick={submit}
              disabled={!full || !ageConfirmed || !nickname.trim() || status === "creating"}
              className="mt-3 w-full rounded-xl bg-gradient-to-r from-qulo-purple to-qulo-purple-dark py-3 text-sm font-semibold disabled:opacity-40"
            >
              {status === "creating" ? t("creating") : t("create")}
            </button>
          </div>
        </>
      )}
    </section>
  );
}
