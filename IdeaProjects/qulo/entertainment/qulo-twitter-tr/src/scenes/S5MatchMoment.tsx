import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';
import {PhoneFrame} from '../components/PhoneFrame';
import {QuizSolveMini} from '../components/QuizSolveMini';
import {MatchPop} from '../components/MatchPop';
import {StaggerText} from '../components/StaggerText';

export const S5MatchMoment: React.FC = () => {
  const frame = useCurrentFrame();
  const phoneFade = interpolate(frame, [40, 55], [1, 0.25], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(circle at 50% 45%, rgba(105,240,174,0.08), ${theme.colors.bg} 60%)`,
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      <div style={{position: 'absolute', opacity: phoneFade}}>
        <PhoneFrame heightPx={720}>
          <QuizSolveMini
            question="Hayalindeki ilk buluşma nasıl olurdu?"
            options={['Sahilde yürüyüş', 'Konser', 'Kahve & sohbet', 'Yemek']}
            correctIndex={2}
            startFrame={0}
            perItemFrames={9}
          />
        </PhoneFrame>
      </div>
      <div style={{position: 'absolute'}}>
        <MatchPop startFrame={45} />
      </div>
      <div style={{position: 'absolute', bottom: theme.safeZone.bottom + 20, width: '70%', display: 'flex', justifyContent: 'center'}}>
        <StaggerText
          lines={['Doğru soruyu soran, *doğru insanı* bulur.']}
          startFrame={70}
          fontSize={theme.type.body}
          accentColor={theme.colors.green}
        />
      </div>
    </AbsoluteFill>
  );
};
