/** Full-bleed shell shared by the quiz create and play pages — same look as the invite landing. */
export function QuizFrame({ children }: { children: React.ReactNode }) {
  return (
    <main className="min-h-screen flex flex-col items-center bg-qulo-bg text-white px-5 py-10">
      <a
        href="/"
        className="text-3xl font-bold tracking-tight mb-8"
        style={{ textShadow: "0 0 40px rgba(187,134,252,0.6)", color: "#BB86FC" }}
      >
        Qulo
      </a>
      <div className="w-full max-w-lg">{children}</div>
    </main>
  );
}
