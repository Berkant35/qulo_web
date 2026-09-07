"use client";

import { useEffect, useState } from "react";
import { useLocale, useTranslations } from "next-intl";
import { fetchQuiz, submitAttempt, SLUG_PATTERN, type PublicQuiz, type AttemptResult } from "@/lib/api/webQuiz";
import { SITE_URL } from "@/lib/constants/metadata";
import { STORE_REDIRECT } from "@/lib/constants/links";
import { NeonButton } from "@/components/shared/NeonButton";
import { OptionButton } from "@/components/quiz/OptionButton";
import { ShareRow } from "@/components/quiz/ShareRow";

type Status = "loading" | "playing" | "submitting" | "result" | "notFound" | "error";

/** Slug is the last path segment (`/q/ABCD2345` or `/tr/q/ABCD2345`); the page itself is static. */
function slugFromPath(pathname: string): string | null {
  const last = pathname.split("/").filter(Boolean).pop() ?? "";
  return SLUG_PATTERN.test(last) ? last.toUpperCase() : null;
}

function verdictKey(score: number, total: number): "resultHigh" | "resultMid" | "resultLow" {
  if (score >= total - 1) return "resultHigh";
  if (score >= Math.ceil(total / 2)) return "resultMid";
  return "resultLow";
}

export function QuizPlayer() {
  const t = useTranslations("quiz");
  const locale = useLocale();
  const [status, setStatus] = useState<Status>("loading");
  const [slug, setSlug] = useState<string | null>(null);
  const [quiz, setQuiz] = useState<PublicQuiz | null>(null);
  const [answers, setAnswers] = useState<Record<number, number>>({});
  const [result, setResult] = useState<AttemptResult | null>(null);

  useEffect(() => {
    const s = slugFromPath(window.location.pathname);
    if (!s) {
      setStatus("notFound");
      return;
    }
    setSlug(s);
    fetchQuiz(s)
      .then((q) => {
        setQuiz(q);
        setStatus("playing");
      })
      .catch((err: { status?: number }) => setStatus(err?.status === 404 ? "notFound" : "error"));
  }, []);

  const total = quiz?.questions.length ?? 0;
  const answered = Object.keys(answers).length;

  async function submit() {
    if (!slug || !quiz || answered < total) return;
    setStatus("submitting");
    try {
      setResult(await submitAttempt(slug, quiz.questions.map((_, i) => answers[i])));
      setStatus("result");
    } catch {
      setStatus("error");
    }
  }

  const createHref = `/${locale}/q/`;

  if (status === "loading") {
    return <p className="text-center text-qulo-text-muted animate-pulse">{t("loading")}</p>;
  }
  if (status === "notFound" || status === "error") {
    return (
      <section className="flex flex-col items-center gap-5 text-center">
        <p className="text-qulo-text-secondary">{status === "notFound" ? t("notFound") : t("errorGeneric")}</p>
        <NeonButton href={createHref}>{t("makeOwn")}</NeonButton>
      </section>
    );
  }
  if (!quiz) return null;

  if (status === "result" && result) {
    const url = `${SITE_URL}/q/${slug}`;
    const shareText = t("shareResultText", { name: result.nickname, score: result.score, total: result.total, url });
    return (
      <section className="flex flex-col gap-6">
        <header className="text-center">
          <p className="text-6xl font-bold text-qulo-green">
            {result.score}/{result.total}
          </p>
          <p className="mt-2 text-lg font-semibold">{t(verdictKey(result.score, result.total), { name: result.nickname })}</p>
        </header>
        <ol className="flex flex-col gap-4">
          {quiz.questions.map((q, i) => {
            const r = result.results[i];
            return (
              <li key={i}>
                <p className="mb-2 text-sm font-semibold">{q.question_text}</p>
                <div className="grid grid-cols-1 gap-1.5">
                  {q.answers.map((label, j) => (
                    <OptionButton
                      key={j}
                      label={label}
                      state={j === r.correct ? "correct" : j === r.chosen ? "wrong" : "disabled"}
                    />
                  ))}
                </div>
                {!r.is_correct && (
                  <p className="mt-1 text-xs text-qulo-text-muted">
                    {t("answerOf", { name: result.nickname })} {q.answers[r.correct]}
                  </p>
                )}
              </li>
            );
          })}
        </ol>
        <div className="flex flex-col gap-3">
          <p className="text-center text-sm text-qulo-text-secondary">{t("shareResult")}</p>
          <ShareRow text={shareText} url={url} />
        </div>
        <div className="mt-4 flex flex-col items-center gap-3 border-t border-white/10 pt-6 text-center">
          <NeonButton href={createHref} className="w-full">{t("makeOwn")}</NeonButton>
          <p className="mt-2 text-sm text-qulo-text-secondary">{t("appCta")}</p>
          <NeonButton href={STORE_REDIRECT("web-quiz-play")} className="w-full">{t("appButton")}</NeonButton>
        </div>
      </section>
    );
  }

  return (
    <section className="flex flex-col gap-6">
      <header className="text-center">
        <h1 className="text-3xl font-bold text-qulo-purple">{t("playTitle", { name: quiz.nickname })}</h1>
        <p className="mt-2 text-qulo-text-secondary">{t("playDesc", { name: quiz.nickname, total })}</p>
      </header>
      <ol className="flex flex-col gap-5">
        {quiz.questions.map((q, i) => (
          <li key={i}>
            <p className="mb-2 text-sm font-semibold">
              {i + 1}. {q.question_text}
            </p>
            <div className="grid grid-cols-1 gap-1.5 sm:grid-cols-2">
              {q.answers.map((label, j) => (
                <OptionButton
                  key={j}
                  label={label}
                  state={answers[i] === j ? "selected" : "idle"}
                  onClick={() => setAnswers((prev) => ({ ...prev, [i]: j }))}
                />
              ))}
            </div>
          </li>
        ))}
      </ol>
      <div className="sticky bottom-0 -mx-5 border-t border-white/10 bg-qulo-bg/95 px-5 py-4 backdrop-blur">
        <button
          type="button"
          onClick={submit}
          disabled={answered < total || status === "submitting"}
          className="w-full rounded-xl bg-gradient-to-r from-qulo-purple to-qulo-purple-dark py-3 text-sm font-semibold disabled:opacity-40"
        >
          {status === "submitting" ? t("submitting") : t("submit", { answered, total })}
        </button>
      </div>
    </section>
  );
}
