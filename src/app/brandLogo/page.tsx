import type { Metadata } from "next";
import Link from "next/link";
import Image from "next/image";

export const metadata: Metadata = {
  title: "Qulo Brand Logo — Download",
  description:
    "Download the official Qulo app logo in multiple sizes (PNG). Free to use for press and partners.",
  robots: { index: true, follow: true },
};

const BRAND_COLOR = "#2A132E";

const SIZES = [
  { px: 1024, kb: "62 KB" },
  { px: 512, kb: "22 KB" },
  { px: 256, kb: "10 KB" },
  { px: 128, kb: "5 KB" },
] as const;

export default function BrandLogoPage() {
  return (
    <main
      id="main-content"
      className="min-h-screen bg-qulo-bg text-white flex flex-col items-center px-6 py-16"
    >
      <div className="w-full max-w-2xl">
        {/* Header */}
        <header className="text-center mb-12">
          <h1 className="text-4xl font-bold mb-3">Qulo Brand Logo</h1>
          <p className="text-qulo-text-secondary">
            Official app logo, ready to download. Free to use for press and partners.
          </p>
        </header>

        {/* Logo preview */}
        <div className="flex justify-center mb-12">
          <div className="rounded-3xl overflow-hidden shadow-[0_0_40px_rgba(187,134,252,0.25)]">
            <Image
              src="/brand/qulo-logo-512.png"
              alt="Qulo logo"
              width={220}
              height={220}
              priority
            />
          </div>
        </div>

        {/* Download list */}
        <section aria-label="Download sizes" className="space-y-3 mb-12">
          {SIZES.map(({ px, kb }) => (
            <a
              key={px}
              href={`/brand/qulo-logo-${px}.png`}
              download
              className="flex items-center justify-between rounded-2xl border border-white/10 bg-white/[0.03] px-5 py-4 transition-colors hover:bg-white/[0.06]"
            >
              <div className="flex items-center gap-4">
                <span className="font-semibold">
                  {px} × {px}
                </span>
                <span className="text-sm text-qulo-text-secondary">PNG · {kb}</span>
              </div>
              <span className="flex items-center gap-2 rounded-full bg-gradient-to-r from-qulo-purple to-qulo-purple-dark px-4 py-2 text-sm font-semibold">
                Download
              </span>
            </a>
          ))}
        </section>

        {/* Brand color */}
        <section aria-label="Brand color" className="mb-12">
          <h2 className="text-sm font-semibold uppercase tracking-wide text-qulo-text-secondary mb-3">
            Brand color
          </h2>
          <div className="flex items-center gap-4 rounded-2xl border border-white/10 bg-white/[0.03] px-5 py-4">
            <span
              className="h-10 w-10 shrink-0 rounded-lg border border-white/10"
              style={{ backgroundColor: BRAND_COLOR }}
              aria-hidden="true"
            />
            <code className="select-all font-mono text-lg">{BRAND_COLOR}</code>
          </div>
        </section>

        {/* Back link */}
        <div className="text-center">
          <Link
            href="/en/"
            className="text-sm text-qulo-text-secondary transition-colors hover:text-white"
          >
            ← Back to Qulo
          </Link>
        </div>
      </div>
    </main>
  );
}
