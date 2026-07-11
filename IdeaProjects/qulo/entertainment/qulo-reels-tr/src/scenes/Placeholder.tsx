import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';

export const Placeholder: React.FC = () => (
  <AbsoluteFill
    style={{
      background: theme.colors.bg,
      justifyContent: 'center',
      alignItems: 'center',
      fontFamily: theme.fonts.display,
      fontSize: theme.type.title,
      color: theme.colors.textMuted,
    }}
  >
    Sahne bekleniyor…
  </AbsoluteFill>
);
