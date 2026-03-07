export interface JwtPayload {
  userId: string;
  email: string;
}

export type PowerName =
  | "COPY"
  | "HALF"
  | "SKIP"
  | "SKIP_ALL"
  | "TIME_EXTEND"
  | "HINT";

export const QUESTION_COUNT_MULTIPLIERS: Record<number, number> = {
  2: 0.5,
  3: 0.75,
  4: 1.0,
  5: 1.25,
  6: 1.5,
};

export const GREEN_DIAMOND_REWARD_RATIO = 0.3;
