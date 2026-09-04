import type { ReactNode } from "react";

/**
 * Structured article content model.
 *
 * Blog posts authored as data (not per-locale JSX) so a single article can be
 * fully translated into all 16 locales without duplicating markup. Text may
 * contain `**bold**` spans, rendered as <strong className="text-white">.
 * All content is trusted static data authored in-repo (no user input).
 */
export type ArticleBlock =
  | { type: "h2"; text: string; accent?: "purple" | "green" }
  | { type: "h3"; text: string }
  | { type: "p"; text: string }
  | { type: "ul"; items: string[] }
  | { type: "quote"; text: string };

export type LocalizedArticle = Record<string, ArticleBlock[]>;

/** Render `**bold**` spans inside otherwise plain text. Static input only. */
function renderInline(text: string): ReactNode[] {
  return text.split(/(\*\*[^*]+\*\*)/g).map((part, i) => {
    if (part.startsWith("**") && part.endsWith("**")) {
      return (
        <strong key={i} className="text-white">
          {part.slice(2, -2)}
        </strong>
      );
    }
    return <span key={i}>{part}</span>;
  });
}

export function ArticleBlocks({ blocks }: { blocks: ArticleBlock[] }) {
  return (
    <>
      {blocks.map((block, i) => {
        switch (block.type) {
          case "h2":
            return (
              <h2
                key={i}
                className={`text-2xl font-bold ${
                  block.accent === "green" ? "text-qulo-green" : "text-qulo-purple"
                } mb-4 mt-10`}
              >
                {renderInline(block.text)}
              </h2>
            );
          case "h3":
            return (
              <h3 key={i} className="text-xl font-semibold text-white mb-3 mt-6">
                {renderInline(block.text)}
              </h3>
            );
          case "p":
            return (
              <p key={i} className="text-qulo-text-secondary leading-relaxed mb-4">
                {renderInline(block.text)}
              </p>
            );
          case "ul":
            return (
              <ul
                key={i}
                className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4"
              >
                {block.items.map((item, j) => (
                  <li key={j}>{renderInline(item)}</li>
                ))}
              </ul>
            );
          case "quote":
            return (
              <blockquote
                key={i}
                className="border-l-4 border-qulo-green pl-4 my-8 italic text-qulo-text-secondary"
              >
                {renderInline(block.text)}
              </blockquote>
            );
          default:
            return null;
        }
      })}
    </>
  );
}
