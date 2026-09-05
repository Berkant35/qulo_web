import { StoreButton } from "@/components/shared/StoreButton";
import { storeLinks } from "@/lib/constants/links";

/**
 * `campaign` names the part of the site the visitor came from, so installs can
 * be attributed in Play Console and App Store Connect. It defaults to the home
 * page rather than being required, so no existing call site silently loses its
 * links — but every content section should pass its own.
 */
export function StoreButtons({ campaign = "web-home" }: { campaign?: string }) {
  const links = storeLinks(campaign);
  return (
    <div className="flex flex-wrap items-center gap-3">
      <StoreButton platform="ios" href={links.ios} />
      <StoreButton platform="android" href={links.android} />
    </div>
  );
}
