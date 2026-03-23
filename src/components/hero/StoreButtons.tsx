import { StoreButton } from "@/components/shared/StoreButton";
import { APP_STORE_URL, PLAY_STORE_URL } from "@/lib/constants/links";

export function StoreButtons() {
  return (
    <div className="flex flex-wrap items-center gap-3">
      <StoreButton platform="ios" href={APP_STORE_URL} />
      <StoreButton platform="android" href={PLAY_STORE_URL} />
    </div>
  );
}
