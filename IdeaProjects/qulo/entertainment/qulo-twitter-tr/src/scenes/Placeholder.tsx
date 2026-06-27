import {AbsoluteFill} from 'remotion';
import {theme} from '../theme';

type Props = {label?: string};

export const Placeholder: React.FC<Props> = ({label = 'Placeholder'}) => {
  return (
    <AbsoluteFill
      style={{
        background: theme.colors.bg,
        justifyContent: 'center',
        alignItems: 'center',
        fontFamily: theme.fonts.display,
        color: theme.colors.textMuted,
        fontSize: theme.type.body,
        fontWeight: theme.type.weight,
      }}
    >
      {label}
    </AbsoluteFill>
  );
};
