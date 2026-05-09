import React from "react";
import { AbsoluteFill } from "remotion";
import { colors } from "./theme";

export const StopSwipingAd: React.FC = () => {
  return (
    <AbsoluteFill
      style={{
        background: colors.bg,
        color: colors.white,
        fontFamily: "system-ui, sans-serif",
        fontSize: 64,
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      Qulo Hero Ad — scaffold ready
    </AbsoluteFill>
  );
};
