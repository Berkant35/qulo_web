export type SceneComponent =
  | 'HookScene'
  | 'StatsGrid'
  | 'ProcessStep'
  | 'DriftingCard'
  | 'QuestionPill'
  | 'DiamondBurst'
  | 'CTAScene'
  | 'PhoneFrame'
  | 'TinderMock'
  | 'QuloDiscoverCard'
  | 'QuestionCreate'
  | 'QuizSolve'
  | 'AnswerFeedback'
  | 'MatchCelebration'
  | 'ChatBubble'
  | 'TimeOfDay';

export type SceneSpec = {
  component: SceneComponent;
  startFrame: number;
  durationFrames: number;
  props?: Record<string, unknown>;
};

export type CaptionWord = {
  text: string;
  startFrame: number;
  durationFrames: number;
};

export type AudioTrack = {
  path: string;
  volume?: number;
  startFrom?: number;
};

export type PromoConfig = {
  slug: string;
  template: string;
  durationInFrames: number;
  scenes: SceneSpec[];
  captions?: CaptionWord[];
  audioTrack?: AudioTrack;
};
