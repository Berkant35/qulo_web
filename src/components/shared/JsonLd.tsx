/**
 * Renders a JSON-LD structured data block.
 *
 * SECURITY: `data` MUST originate from trusted server-side constants (page i18n
 * data, in-repo content files). Never pass user-controlled input — the payload
 * is injected via `dangerouslySetInnerHTML`. `<` is escaped so a stray `</script>`
 * inside any string cannot break out of the script element.
 */
export function JsonLd({ data }: { data: object }) {
  const json = JSON.stringify(data).replace(/</g, "\\u003c");

  return (
    <script
      type="application/ld+json"
      // eslint-disable-next-line react/no-danger
      dangerouslySetInnerHTML={{ __html: json }}
    />
  );
}
