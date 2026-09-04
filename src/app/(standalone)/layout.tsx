import type { Metadata } from "next";
import { RootHtml } from "@/components/layout/RootHtml";
import { ROOT_METADATA } from "@/lib/constants/rootMetadata";

/**
 * Root layout for the routes that sit outside the localized tree: the apex
 * redirect stub, /brandLogo and the global 404. English is correct for these —
 * none of them carry localized content.
 */
export const metadata: Metadata = {
  ...ROOT_METADATA,
  title: "Qulo",
  description: "Dating app where you meet by answering each other's questions",
};

export default function StandaloneLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return <RootHtml lang="en">{children}</RootHtml>;
}
