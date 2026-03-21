export function GridOverlay() {
  return (
    <div
      className="fixed inset-0 pointer-events-none z-0"
      style={{
        backgroundImage: `
          linear-gradient(rgba(187,134,252,0.04) 1px, transparent 1px),
          linear-gradient(90deg, rgba(187,134,252,0.04) 1px, transparent 1px)
        `,
        backgroundSize: "60px 60px",
      }}
      aria-hidden="true"
    />
  );
}
