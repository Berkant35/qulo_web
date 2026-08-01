import type { Metadata } from "next";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.help[locale] || PAGE_SEO.help.en;
  const pageUrl = `${SITE_URL}/${locale}/help`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/help`;
  languages["x-default"] = `${SITE_URL}/tr/help`;
  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: seo.title, description: seo.description, url: pageUrl, siteName: SITE_NAME, type: "website", images: ogImages() },
  };
}

export default function HelpLayout({ children }: { children: React.ReactNode }) {
  return children;
}
