import { setRequestLocale } from "next-intl/server";
import { GridOverlay } from "@/components/shared/GridOverlay";
import { Navbar } from "@/components/shared/Navbar";
import { Hero } from "@/components/hero/Hero";

export default async function Home({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  return (
    <main className="min-h-screen bg-qulo-bg relative">
      <GridOverlay />
      <Navbar />
      <Hero />
    </main>
  );
}
