import Link from "next/link";

export default function NotFound() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-center bg-qulo-bg text-white">
      <h1 className="text-6xl font-bold text-qulo-purple mb-4">404</h1>
      <p className="text-qulo-text-secondary mb-8">Page not found</p>
      <Link
        href="/en/"
        className="px-6 py-3 bg-gradient-to-r from-qulo-purple to-qulo-purple-dark rounded-full font-semibold hover:shadow-[0_0_30px_rgba(187,134,252,0.4)] transition-shadow"
      >
        Back to Home
      </Link>
    </main>
  );
}
