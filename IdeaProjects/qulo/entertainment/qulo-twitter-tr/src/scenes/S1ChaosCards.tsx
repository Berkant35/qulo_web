import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';
import {ChaosCard} from '../components/ChaosCard';
import {StaggerText} from '../components/StaggerText';

const CARDS = [
  {xStart: 760, yStart: 180, rotateStart: -8, driftX: -900, driftY: 120, driftRotate: -40, appearFrame: 0, label: 'Profil'},
  {xStart: 820, yStart: 240, rotateStart: 6, driftX: 1000, driftY: 80, driftRotate: 50, appearFrame: 8, label: 'Profil'},
  {xStart: 780, yStart: 200, rotateStart: -3, driftX: -1100, driftY: -60, driftRotate: -30, appearFrame: 16, label: 'Profil'},
  {xStart: 840, yStart: 260, rotateStart: 10, driftX: 1150, driftY: 160, driftRotate: 60, appearFrame: 24, label: 'Profil'},
  {xStart: 800, yStart: 220, rotateStart: -6, driftX: -1000, driftY: 200, driftRotate: -50, appearFrame: 32, label: 'Profil'},
  {xStart: 810, yStart: 210, rotateStart: 4, driftX: 1080, driftY: -40, driftRotate: 45, appearFrame: 40, label: 'Profil'},
];

export const S1ChaosCards: React.FC = () => {
  return (
    <AbsoluteFill style={{background: `radial-gradient(circle at 50% 35%, ${theme.colors.bgAlt} 0%, ${theme.colors.bg} 70%)`}}>
      {CARDS.map((c, i) => (
        <ChaosCard key={i} {...c} />
      ))}
      <div
        style={{
          position: 'absolute',
          left: 0,
          right: 0,
          bottom: theme.safeZone.bottom + 40,
          display: 'flex',
          justifyContent: 'center',
        }}
      >
        <StaggerText
          lines={['Yüzlerce kart.', 'Sıfır gerçek eşleşme.']}
          startFrame={55}
          perLineFrames={18}
          fontSize={theme.type.title}
          accentColor={theme.colors.danger}
        />
      </div>
    </AbsoluteFill>
  );
};
