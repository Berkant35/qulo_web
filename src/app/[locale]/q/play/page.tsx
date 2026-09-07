import { setRequestLocale } from "next-intl/server";
import { QuizFrame } from "@/components/quiz/QuizFrame";
import { QuizPlayer } from "@/components/quiz/QuizPlayer";

/**
 * Serves every `/q/<slug>` link: Netlify rewrites the slug path to this static page
 * and the client reads the slug from the URL — the same trick the invite landing uses.
 */
export default async function QuizPlayPage({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  return (
    <QuizFrame>
      <QuizPlayer />
    </QuizFrame>
  );
}
