import type { Metadata } from "next";
import { utilityRouteMetadata } from "@/lib/seo/utilityRoute";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  return utilityRouteMetadata(locale, "email-verified", "Email Verified");
}

export default function EmailVerifiedLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return children;
}
