import {AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

type Props = {
  badge?: 'flawless' | 'speed_solver' | 'power_master' | 'determined' | 'matched';
  myName?: string;
  matchName?: string;
  correct?: number;
  total?: number;
  timeSec?: string;
  score?: string;
  diamondsEarned?: number;
};

const BADGE_CONFIG = {
  flawless: {label: 'FLAWLESS', icon: '⭐', gradient: ['#FFC107', '#FF9800']},
  speed_solver: {label: 'SPEED SOLVER', icon: '⚡', gradient: ['#64B5F6', '#00BCD4']},
  power_master: {label: 'POWER MASTER', icon: '🔮', gradient: ['#BB86FC', '#673AB7']},
  determined: {label: 'DETERMINED', icon: '💪', gradient: ['#69F0AE', '#009688']},
  matched: {label: 'MATCH FOUND', icon: '💜', gradient: ['#BB86FC', '#E91E63']},
};

export const MatchCelebration: React.FC<Props> = ({
  badge = 'flawless',
  myName = 'You',
  matchName = 'Maya',
  correct = 3,
  total = 3,
  timeSec = '1:24',
  score,
  diamondsEarned,
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const cfg = BADGE_CONFIG[badge];

  const badgeScale = spring({frame: frame - 6, fps, config: {damping: 7, stiffness: 130, mass: 0.7}});
  const badgeOpacity = interpolate(frame, [6, 14], [0, 1], {extrapolateRight: 'clamp'});
  const titleOpacity = interpolate(frame, [20, 32], [0, 1], {extrapolateRight: 'clamp'});

  const photoSlide = interpolate(frame, [24, 48], [0, 1], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const myX = interpolate(photoSlide, [0, 1], [-160, 0]);
  const matchX = interpolate(photoSlide, [0, 1], [160, 0]);
  const heartOpacity = interpolate(photoSlide, [0, 0.5, 1], [0, 1, 0.6]);
  const heartScale = spring({frame: frame - 40, fps, config: {damping: 10, stiffness: 140}});

  const statsOpacity = interpolate(frame, [48, 64], [0, 1], {extrapolateRight: 'clamp'});
  const ctaOpacity = interpolate(frame, [64, 78], [0, 1], {extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill
      style={{
        background: 'rgba(0,0,0,0.96)',
        padding: `${theme.safeZone.top}px ${theme.safeZone.horizontal}px ${theme.safeZone.bottom}px`,
        justifyContent: 'center',
        alignItems: 'center',
      }}
    >
      <div
        style={{
          background: `linear-gradient(135deg, ${cfg.gradient[0]} 0%, ${cfg.gradient[1]} 100%)`,
          padding: '14px 32px',
          borderRadius: theme.radius.pill,
          color: '#fff',
          fontFamily: theme.fonts.display,
          fontWeight: 900,
          fontSize: 36,
          letterSpacing: 2,
          display: 'flex',
          alignItems: 'center',
          gap: 12,
          transform: `scale(${badgeScale})`,
          opacity: badgeOpacity,
          boxShadow: `0 12px 40px ${cfg.gradient[0]}88`,
        }}
      >
        <span style={{fontSize: 40}}>{cfg.icon}</span>
        {cfg.label}
      </div>

      {/* score badge — top-right absolute */}
      {score ? (
        <div
          style={{
            position: 'absolute',
            top: theme.safeZone.top + 8,
            right: theme.safeZone.horizontal,
            background: theme.colors.bgAlt,
            border: `2px solid ${theme.colors.secondary}`,
            borderRadius: 24,
            padding: '8px 20px',
            color: theme.colors.secondary,
            fontFamily: theme.fonts.display,
            fontWeight: 800,
            fontSize: 28,
            opacity: badgeOpacity,
          }}
        >
          {score}
        </div>
      ) : null}

      <div
        style={{
          marginTop: 36,
          color: theme.colors.text,
          fontFamily: theme.fonts.display,
          fontWeight: 900,
          fontSize: 80,
          opacity: titleOpacity,
          letterSpacing: -2,
          textAlign: 'center',
        }}
      >
        It's a Match!
      </div>

      {diamondsEarned != null ? (
        <div
          style={{
            marginTop: 16,
            background: `linear-gradient(135deg, ${theme.colors.green}33 0%, ${theme.colors.purple}33 100%)`,
            border: `2px solid ${theme.colors.green}`,
            borderRadius: 32,
            padding: '10px 28px',
            color: theme.colors.green,
            fontFamily: theme.fonts.display,
            fontWeight: 800,
            fontSize: 36,
            opacity: titleOpacity,
          }}
        >
          +{diamondsEarned} 💎
        </div>
      ) : null}

      <div
        style={{
          marginTop: 56,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          gap: 24,
          height: 200,
        }}
      >
        <div
          style={{
            width: 180,
            height: 180,
            borderRadius: 90,
            background: 'linear-gradient(135deg, #6BCBFF 0%, #4F8BFF 100%)',
            border: `4px solid ${theme.colors.primary}`,
            transform: `translateX(${myX}px)`,
            display: 'flex',
            alignItems: 'flex-end',
            justifyContent: 'center',
            paddingBottom: 28,
            fontSize: 28,
            fontWeight: 800,
            color: '#fff',
            fontFamily: theme.fonts.display,
            boxShadow: `0 12px 28px rgba(187,134,252,0.45)`,
          }}
        >
          {myName}
        </div>

        <div
          style={{
            fontSize: 80,
            color: theme.colors.primary,
            opacity: heartOpacity,
            transform: `scale(${heartScale})`,
            textShadow: `0 0 40px ${theme.colors.primary}cc`,
          }}
        >
          💜
        </div>

        <div
          style={{
            width: 180,
            height: 180,
            borderRadius: 90,
            background: 'linear-gradient(135deg, #FFAFBD 0%, #C780A5 100%)',
            border: `4px solid ${theme.colors.primary}`,
            transform: `translateX(${matchX}px)`,
            display: 'flex',
            alignItems: 'flex-end',
            justifyContent: 'center',
            paddingBottom: 28,
            fontSize: 28,
            fontWeight: 800,
            color: '#fff',
            fontFamily: theme.fonts.display,
            boxShadow: `0 12px 28px rgba(187,134,252,0.45)`,
          }}
        >
          {matchName}
        </div>
      </div>

      <div
        style={{
          marginTop: 56,
          background: theme.colors.surfaceElevated,
          borderRadius: theme.radius.lg,
          padding: '32px 56px',
          display: 'flex',
          gap: 56,
          opacity: statsOpacity,
          fontFamily: theme.fonts.body,
          color: theme.colors.text,
        }}
      >
        <div style={{textAlign: 'center'}}>
          <div style={{fontSize: 64, fontWeight: 900, color: theme.colors.secondary}}>
            {correct}/{total}
          </div>
          <div style={{fontSize: 22, color: theme.colors.textMuted, marginTop: 6, fontWeight: 600}}>
            Correct
          </div>
        </div>
        <div style={{width: 1, background: theme.colors.border}} />
        <div style={{textAlign: 'center'}}>
          <div style={{fontSize: 64, fontWeight: 900, color: theme.colors.info}}>{timeSec}</div>
          <div style={{fontSize: 22, color: theme.colors.textMuted, marginTop: 6, fontWeight: 600}}>
            Time
          </div>
        </div>
      </div>

      <div
        style={{
          marginTop: 32,
          fontSize: 28,
          color: theme.colors.textMuted,
          fontFamily: theme.fonts.body,
          fontStyle: 'italic',
          opacity: ctaOpacity,
        }}
      >
        You earned this match.
      </div>
    </AbsoluteFill>
  );
};
