import { setRequestLocale } from "next-intl/server";
import { QuizFrame } from "@/components/quiz/QuizFrame";
import { QuizCreator } from "@/components/quiz/QuizCreator";

export default async function QuizCreatePage({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  setRequestLocale(locale);
  return (
    <QuizFrame>
      <QuizCreator />
    </QuizFrame>
  );
}
