import type { Metadata } from "next";
import { getTranslations } from "next-intl/server";
import { ogImages } from "@/lib/seo/openGraph";
import { SITE_NAME, SITE_URL } from "@/lib/constants/metadata";

/** Per-quiz links travel through WhatsApp/DMs: the preview is the pitch. Thin page, so noindex. */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "quiz" });
  const title = t("playMetaTitle");
  const description = t("playMetaDesc");

  return {
    title: `${title} — ${SITE_NAME}`,
    description,
    robots: { index: false, follow: true },
    alternates: { canonical: `${SITE_URL}/${locale}/q` },
    openGraph: { title, description, siteName: SITE_NAME, type: "website", images: ogImages() },
    twitter: { card: "summary_large_image", title, description, images: ogImages() },
  };
}

export default function QuizPlayLayout({ children }: { children: React.ReactNode }) {
  return children;
}
