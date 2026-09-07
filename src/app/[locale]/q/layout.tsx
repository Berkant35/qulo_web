import type { Metadata } from "next";
import { getTranslations } from "next-intl/server";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";
import { SITE_NAME, SITE_URL } from "@/lib/constants/metadata";

/**
 * "Can you answer me?" — the one page on the site that produces something people
 * send to each other. It is indexable (a real landing page with a real title), unlike
 * the per-quiz play pages below it, which are thin and noindexed.
 */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "quiz" });
  const title = t("metaTitle");
  const description = t("metaDesc");
  const url = `${SITE_URL}/${locale}/q`;

  return {
    title: `${title} — ${SITE_NAME}`,
    description,
    alternates: { canonical: url, languages: alternateLanguages("/q") },
    openGraph: { title, description, url, siteName: SITE_NAME, type: "website", images: ogImages() },
    twitter: { card: "summary_large_image", title, description, images: ogImages() },
  };
}

export default function QuizLayout({ children }: { children: React.ReactNode }) {
  return children;
}
