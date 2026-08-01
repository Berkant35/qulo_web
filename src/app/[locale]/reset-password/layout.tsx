import type { Metadata } from "next";
import { utilityRouteMetadata } from "@/lib/seo/utilityRoute";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  return utilityRouteMetadata(locale, "reset-password", "Reset Password");
}

export default function ResetPasswordLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return children;
}
