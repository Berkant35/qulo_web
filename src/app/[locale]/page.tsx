import { setRequestLocale } from "next-intl/server";
import { GridOverlay } from "@/components/shared/GridOverlay";
import { Navbar } from "@/components/shared/Navbar";
import { Hero } from "@/components/hero/Hero";
import { SectionDivider } from "@/components/shared/SectionDivider";
import { HowItWorks } from "@/components/how-it-works/HowItWorks";
import { Features } from "@/components/features/Features";
import { AppPreview } from "@/components/app-preview/AppPreview";
import { WhyDifferent } from "@/components/why-different/WhyDifferent";
import { DownloadCTA } from "@/components/download-cta/DownloadCTA";
import { Footer } from "@/components/footer/Footer";
import { ScrollToTop } from "@/components/shared/ScrollToTop";

export default async function Home({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  return (
    <main id="main-content" className="min-h-screen bg-qulo-bg relative">
      <GridOverlay />
      <Navbar />
      <Hero />
      <SectionDivider />
      <HowItWorks />
      <SectionDivider />
      <Features />
      <SectionDivider />
      <AppPreview />
      <SectionDivider />
      <WhyDifferent />
      <SectionDivider />
      <DownloadCTA />
      <Footer />
      <ScrollToTop />
    </main>
  );
}
