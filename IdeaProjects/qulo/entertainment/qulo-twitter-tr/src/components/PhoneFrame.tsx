import {theme} from '../theme';

type Props = {children: React.ReactNode; heightPx?: number};

export const PhoneFrame: React.FC<Props> = ({children, heightPx = 760}) => {
  const h = heightPx;
  const w = Math.round(h * 0.49);
  const bezel = Math.round(h * 0.012);
  const radius = Math.round(h * 0.07);
  return (
    <div
      style={{
        width: w,
        height: h,
        borderRadius: radius,
        background: '#000',
        padding: bezel,
        boxShadow: '0 40px 80px rgba(0,0,0,0.7), 0 0 0 3px #2a2a2a, 0 0 90px rgba(187,134,252,0.22)',
        position: 'relative',
      }}
    >
      <div
        style={{
          width: '100%',
          height: '100%',
          borderRadius: radius - bezel,
          background: theme.colors.bg,
          overflow: 'hidden',
          position: 'relative',
        }}
      >
        {children}
      </div>
    </div>
  );
};
