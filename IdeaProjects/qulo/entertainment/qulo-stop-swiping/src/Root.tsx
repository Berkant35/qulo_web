import React from "react";
import { Composition } from "remotion";
import { StopSwipingAd } from "./StopSwipingAd";
import { VIDEO, VIDEO_DURATION_FRAMES } from "./theme";

export const Root: React.FC = () => {
  return (
    <>
      <Composition
        id="StopSwipingAd"
        component={StopSwipingAd}
        durationInFrames={VIDEO_DURATION_FRAMES}
        fps={VIDEO.fps}
        width={VIDEO.width}
        height={VIDEO.height}
      />
    </>
  );
};
