import type { Metadata } from "next";
import { getTranslations } from "next-intl/server";
import { utilityRouteMetadata } from "@/lib/seo/utilityRoute";
import { ogImages } from "@/lib/seo/openGraph";
import { SITE_NAME, SITE_URL } from "@/lib/constants/metadata";
import { REFERRAL_REWARD_PURPLE } from "@/lib/constants/referral";

/**
 * Invite links travel almost exclusively through WhatsApp and DMs, where the
 * link preview is the whole pitch. Without its own Open Graph block the page
 * inherited the homepage's ("Qulo — Meet Through Questions"), which says
 * nothing about an invitation or the reward. This makes the preview say what
 * the message is: you were invited, you both get diamonds.
 */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "invite" });
  const title = t("title");
  const description = `${t("desc")} ${t("reward", { reward: REFERRAL_REWARD_PURPLE })}`;
  const url = `${SITE_URL}/${locale}/invite`;

  return {
    ...utilityRouteMetadata(locale, "invite", title),
    description,
    openGraph: {
      title,
      description,
      url,
      siteName: SITE_NAME,
      type: "website",
      images: ogImages(),
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: ogImages(),
    },
  };
}

export default function InviteLayout({ children }: { children: React.ReactNode }) {
  return children;
}
