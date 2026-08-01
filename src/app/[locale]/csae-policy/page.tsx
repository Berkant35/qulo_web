import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { rtlLocales, locales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const pageUrl = `${SITE_URL}/${locale}/csae-policy`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/csae-policy`;
  languages["x-default"] = `${SITE_URL}/en/csae-policy`;
  return {
    title: `Child Safety Standards – ${SITE_NAME}`,
    description: "Qulo's Child Sexual Abuse and Exploitation (CSAE) prevention policy, safety standards, and reporting procedures.",
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: `Child Safety Standards – ${SITE_NAME}`, description: "Qulo's CSAE prevention policy and safety standards.", url: pageUrl, siteName: SITE_NAME, type: "website", images: ogImages() },
  };
}

const sections = [
  {
    title: "1. Age Restriction",
    body: "Qulo is a dating application intended exclusively for users aged 18 and older. Users must confirm they are at least 18 years old during registration. Accounts that are found to belong to minors are immediately suspended and permanently deleted.",
  },
  {
    title: "2. Zero-Tolerance Policy",
    body: `Qulo maintains a strict zero-tolerance policy against child sexual abuse and exploitation (CSAE) content. Any content that sexualizes, endangers, or exploits minors is strictly prohibited. This includes, but is not limited to:

\u2022 Images, videos, or text depicting or promoting child sexual abuse
\u2022 Grooming behaviors or solicitation of minors
\u2022 Sharing or requesting child sexual abuse material (CSAM)
\u2022 Any content that sexualizes minors in any way`,
  },
  {
    title: "3. Detection & Reporting",
    body: `We employ the following measures to detect and respond to CSAE content:

\u2022 All user-generated content is subject to automated and manual moderation
\u2022 Users can report inappropriate content or behavior directly within the app
\u2022 Reported content is reviewed promptly by our trust and safety team
\u2022 Confirmed CSAE content is immediately removed and reported to the National Center for Missing & Exploited Children (NCMEC) and relevant law enforcement authorities`,
  },
  {
    title: "4. Enforcement",
    body: "Violations of this policy result in immediate and permanent account termination. We cooperate fully with law enforcement investigations related to child exploitation. User data associated with confirmed violations is preserved and provided to authorities as required by law.",
  },
  {
    title: "5. In-App Safety Features",
    body: `\u2022 Block and report functionality available on every user profile and in chat
\u2022 Photo moderation before public display
\u2022 Proactive detection of suspicious messaging patterns`,
  },
  {
    title: "6. Contact",
    body: "To report child safety concerns, please contact us at: safety@quloapp.com",
  },
  {
    title: "7. Standards Compliance",
    body: "This policy is developed in accordance with the Google Play Families Policy, NCMEC guidelines, and applicable international child protection laws including the UN Convention on the Rights of the Child.",
  },
] as const;

export default async function CsaePolicyPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <div className="pt-24 pb-20 px-6" dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}>
        <div className="max-w-2xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: "Child Safety" }]}
          />

          <h1 className="text-4xl font-bold text-qulo-purple mb-3">
            Child Safety Standards
          </h1>
          <p className="text-qulo-text-muted text-sm mb-10">
            Last updated: April 18, 2026
          </p>
          {sections.map(({ title, body }) => (
            <section key={title} className="mb-8">
              <h2 className="text-xl font-semibold text-white mb-3">
                {title}
              </h2>
              <div className="text-qulo-text-secondary leading-relaxed text-base whitespace-pre-line">
                {body}
              </div>
            </section>
          ))}
        </div>
      </div>
    </main>
  );
}
