import {AbsoluteFill, Audio, Sequence, staticFile} from 'remotion';
import {getConfig} from './configs';
import type {PromoConfig, SceneSpec} from './types';
import {HookScene} from './components/HookScene';
import {StatsGrid} from './components/StatsGrid';
import {ProcessStep} from './components/ProcessStep';
import {DriftingCard} from './components/DriftingCard';
import {QuestionPill} from './components/QuestionPill';
import {DiamondBurst} from './components/DiamondBurst';
import {CTAScene} from './components/CTAScene';
import {CaptionTrack} from './components/CaptionTrack';
import {PhoneFrame} from './components/PhoneFrame';
import {TinderMock} from './components/TinderMock';
import {QuloDiscoverCard} from './components/QuloDiscoverCard';
import {QuestionCreate} from './components/QuestionCreate';
import {QuizSolve} from './components/QuizSolve';
import {AnswerFeedback} from './components/AnswerFeedback';
import {MatchCelebration} from './components/MatchCelebration';
import {ChatBubble} from './components/ChatBubble';
import {TimeOfDay} from './components/TimeOfDay';
import {theme} from './theme';

type Props = {
  configSlug: string;
};

const renderScene = (scene: SceneSpec, idx: number) => {
  const props = (scene.props ?? {}) as Record<string, never>;
  const cast = <T,>() => props as unknown as T;
  switch (scene.component) {
    case 'HookScene':
      return <HookScene {...cast<React.ComponentProps<typeof HookScene>>()} />;
    case 'StatsGrid':
      return <StatsGrid {...cast<React.ComponentProps<typeof StatsGrid>>()} />;
    case 'ProcessStep':
      return <ProcessStep {...cast<React.ComponentProps<typeof ProcessStep>>()} />;
    case 'DriftingCard':
      return <DriftingCard {...cast<React.ComponentProps<typeof DriftingCard>>()} />;
    case 'QuestionPill':
      return <QuestionPill {...cast<React.ComponentProps<typeof QuestionPill>>()} />;
    case 'DiamondBurst':
      return <DiamondBurst {...cast<React.ComponentProps<typeof DiamondBurst>>()} />;
    case 'CTAScene':
      return <CTAScene {...cast<React.ComponentProps<typeof CTAScene>>()} />;
    case 'PhoneFrame':
      return <PhoneFrame {...cast<React.ComponentProps<typeof PhoneFrame>>()} />;
    case 'TinderMock':
      return <TinderMock />;
    case 'QuloDiscoverCard':
      return <QuloDiscoverCard {...cast<React.ComponentProps<typeof QuloDiscoverCard>>()} />;
    case 'QuestionCreate':
      return <QuestionCreate {...cast<React.ComponentProps<typeof QuestionCreate>>()} />;
    case 'QuizSolve':
      return <QuizSolve {...cast<React.ComponentProps<typeof QuizSolve>>()} />;
    case 'AnswerFeedback':
      return <AnswerFeedback {...cast<React.ComponentProps<typeof AnswerFeedback>>()} />;
    case 'MatchCelebration':
      return <MatchCelebration {...cast<React.ComponentProps<typeof MatchCelebration>>()} />;
    case 'ChatBubble':
      return <ChatBubble {...cast<React.ComponentProps<typeof ChatBubble>>()} />;
    case 'TimeOfDay':
      return <TimeOfDay {...cast<React.ComponentProps<typeof TimeOfDay>>()} />;
    default:
      throw new Error(`Unknown scene component at index ${idx}: ${(scene as SceneSpec).component}`);
  }
};

export const TikTokPromo: React.FC<Props> = ({configSlug}) => {
  const config: PromoConfig = getConfig(configSlug);

  return (
    <AbsoluteFill style={{background: theme.colors.bg}}>
      {config.scenes.map((scene, i) => (
        <Sequence
          key={`${scene.component}-${i}-${scene.startFrame}`}
          from={scene.startFrame}
          durationInFrames={scene.durationFrames}
          name={`${i + 1}. ${scene.component}`}
        >
          {renderScene(scene, i)}
        </Sequence>
      ))}

      {config.captions && config.captions.length > 0 ? (
        <Sequence from={0} name="Captions">
          <CaptionTrack words={config.captions} />
        </Sequence>
      ) : null}

      {config.audioTrack ? (
        <Audio
          src={staticFile(config.audioTrack.path)}
          volume={config.audioTrack.volume ?? 0.85}
          startFrom={config.audioTrack.startFrom ?? 0}
        />
      ) : null}
    </AbsoluteFill>
  );
};
