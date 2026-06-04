import type {PromoConfig} from '../types';

const FPS = 30;
const s = (seconds: number) => Math.round(seconds * FPS);

export const fullAppIntroConfig: PromoConfig = {
  slug: 'full-app-intro',
  template: 'full-app-intro',
  durationInFrames: s(140),
  scenes: [
    // ─── 1. Cold open (0-4s) ───
    {
      component: 'PhoneFrame',
      startFrame: s(0),
      durationFrames: s(4),
      props: {},
    },
    {
      component: 'GenericSwipeStack',
      startFrame: s(0),
      durationFrames: s(4),
      props: {count: 4, ghostMode: false, brand: 'neutral'},
    },
    {
      component: 'DriftingCard',
      startFrame: s(0),
      durationFrames: s(4),
      props: {direction: 'left', label: '', delay: 0},
    },

    // ─── 2. Ghost loop (4-10s) ───
    {
      component: 'GenericSwipeStack',
      startFrame: s(4),
      durationFrames: s(6),
      props: {count: 4, ghostMode: true, brand: 'neutral'},
    },
    {
      component: 'ChatBubble',
      startFrame: s(7),
      durationFrames: s(3),
      props: {text: '...', fromMe: false, startFrame: 0, mood: 'ghost'},
    },

    // ─── 3. Reveal (10-16s) ───
    {
      component: 'HookScene',
      startFrame: s(10),
      durationFrames: s(6),
      props: {text: 'Stop swiping.', accentText: 'Start solving.', logoReveal: true},
    },
    {
      component: 'DiamondBurst',
      startFrame: s(13),
      durationFrames: s(3),
      props: {scale: 'large', color: 'green'},
    },

    // ─── 4. Discover (16-30s) ───
    {
      component: 'QuloDiscoverCard',
      startFrame: s(16),
      durationFrames: s(14),
      props: {name: 'Maya', age: 26, questionCount: 3},
    },
    {
      component: 'QuestionPill',
      startFrame: s(22),
      durationFrames: s(8),
      props: {label: '3 questions to solve', accent: true},
    },

    // ─── 5. Solve Q1 (30-38.5s) ───
    {
      component: 'QuestionPill',
      startFrame: s(30),
      durationFrames: s(8),
      props: {label: 'Q1 of 3'},
    },
    {
      component: 'QuizSolve',
      startFrame: s(30),
      durationFrames: s(7),
      props: {
        question: 'Pineapple on pizza?',
        options: ['Yes obviously', 'Never', 'I respect it'],
        correctIndex: 0,
      },
    },
    {
      component: 'AnswerFeedback',
      startFrame: s(37),
      durationFrames: Math.round(1.5 * FPS),
      props: {correct: true},
    },
    {
      component: 'DiamondBurst',
      startFrame: s(37),
      durationFrames: Math.round(1.5 * FPS),
      props: {scale: 'micro', color: 'green', count: 1},
    },

    // ─── 5b. Solve Q2 (38.5-47s) ───
    {
      component: 'QuestionPill',
      startFrame: Math.round(38.5 * FPS),
      durationFrames: s(8),
      props: {label: 'Q2 of 3'},
    },
    {
      component: 'QuizSolve',
      startFrame: Math.round(38.5 * FPS),
      durationFrames: s(7),
      props: {
        question: 'Mountains or beach?',
        options: ['Mountains', 'Beach', 'City'],
        correctIndex: 0,
      },
    },
    {
      component: 'AnswerFeedback',
      startFrame: Math.round(45.5 * FPS),
      durationFrames: Math.round(1.5 * FPS),
      props: {correct: true},
    },
    {
      component: 'DiamondBurst',
      startFrame: Math.round(45.5 * FPS),
      durationFrames: Math.round(1.5 * FPS),
      props: {scale: 'micro', color: 'green', count: 1},
    },

    // ─── 5c. Solve Q3 (47-55s, urgent) ───
    {
      component: 'QuestionPill',
      startFrame: s(47),
      durationFrames: s(8),
      props: {label: 'Q3 of 3', urgent: true},
    },
    {
      component: 'QuizSolve',
      startFrame: s(47),
      durationFrames: s(7),
      props: {
        question: 'Biggest red flag in a date?',
        options: ['Checks phone constantly', 'Only talks about ex', 'Splits bill weirdly'],
        correctIndex: 1,
        showTimer: true,
      },
    },
    {
      component: 'AnswerFeedback',
      startFrame: s(54),
      durationFrames: s(1),
      props: {correct: true},
    },

    // ─── 6. Match earned (55-65s) ───
    {
      component: 'MatchCelebration',
      startFrame: s(55),
      durationFrames: s(10),
      props: {name: 'Maya', score: '3/3', diamondsEarned: 5},
    },
    {
      component: 'DiamondBurst',
      startFrame: s(56),
      durationFrames: s(4),
      props: {scale: 'huge', color: 'green', count: 14},
    },
    {
      component: 'StatsGrid',
      startFrame: s(60),
      durationFrames: s(5),
      props: {
        stats: [
          {label: 'Answered', value: '3/3'},
          {label: 'Diamonds', value: '+5'},
          {label: 'Status', value: 'Matched'},
        ],
        compact: true,
      },
    },

    // ─── 7. Chat substantive (65-78s) ───
    {
      component: 'TimeOfDay',
      startFrame: s(65),
      durationFrames: s(13),
      props: {time: 'evening', subtle: true},
    },
    {
      component: 'ChatBubble',
      startFrame: s(66),
      durationFrames: s(12),
      props: {
        thread: [
          {text: 'Pineapple on pizza? Bold take. 😄', fromMe: false, startFrame: 0},
          {text: "It's called confidence", fromMe: true, startFrame: s(3)},
          {text: 'You solved all 3 — respect.', fromMe: false, startFrame: s(6)},
        ],
      },
    },
    {
      component: 'QuestionPill',
      startFrame: s(70),
      durationFrames: s(6),
      props: {label: 'Earned this chat', accent: true},
    },

    // ─── 8. Create your own (78-93s) ───
    {
      component: 'QuestionCreate',
      startFrame: s(78),
      durationFrames: s(15),
      props: {
        steps: [
          'Q1: Your weekend vibe?',
          'Q2: Mountains or beach?',
          'Q3: Biggest dealbreaker?',
        ],
        typewriter: true,
      },
    },
    {
      component: 'QuestionPill',
      startFrame: s(85),
      durationFrames: s(8),
      props: {label: 'Your filter', accent: true},
    },

    // ─── 9. AI helps (93-103s) ───
    {
      component: 'QuestionCreate',
      startFrame: s(93),
      durationFrames: s(10),
      props: {
        steps: [
          'Q1: Last book that changed you?',
          'Q2: Cancel plans or push through?',
          'Q3: What do you Google at 2 AM?',
        ],
        typewriter: true,
        aiSuggested: true,
      },
    },
    {
      component: 'QuestionPill',
      startFrame: s(95),
      durationFrames: s(8),
      props: {label: '✨ AI-written', accent: true},
    },
    {
      component: 'DiamondBurst',
      startFrame: s(101),
      durationFrames: s(2),
      props: {scale: 'micro', color: 'purple'},
    },

    // ─── 10. Diamond Economy (103-118s) ───
    {
      component: 'DiamondBurst',
      startFrame: s(103),
      durationFrames: s(15),
      props: {scale: 'continuous', color: 'flow', dual: true},
    },
    {
      component: 'StatsGrid',
      startFrame: s(106),
      durationFrames: s(8),
      props: {
        stats: [
          {label: 'Green', value: 'Earn'},
          {label: 'Purple', value: 'Spend'},
          {label: 'Boost', value: '30 = 30min'},
        ],
        infographic: true,
      },
    },
    {
      component: 'ProcessStep',
      startFrame: s(112),
      durationFrames: s(6),
      props: {
        steps: ['Answer', 'Earn', 'Boost', 'Match more'],
        compact: true,
      },
    },

    // ─── 11. Why this works (118-128s) ───
    {
      component: 'TimeOfDay',
      startFrame: s(118),
      durationFrames: s(10),
      props: {time: 'week-transition', subtle: true},
    },
    {
      component: 'StatsGrid',
      startFrame: s(118),
      durationFrames: s(10),
      props: {
        stats: [
          {label: 'Real', value: 'Questions'},
          {label: 'Real', value: 'Answers'},
          {label: 'Real', value: 'Matches'},
        ],
        large: true,
      },
    },
    {
      component: 'ProcessStep',
      startFrame: s(122),
      durationFrames: s(6),
      props: {
        steps: ['Answer', 'Earn', 'Match'],
        labelAbove: true,
      },
    },

    // ─── 12. CTA finale (128-140s) ───
    {
      component: 'CTAScene',
      startFrame: s(128),
      durationFrames: s(12),
      props: {
        headline: 'Stop swiping. Start matching.',
        subline: 'Qulo — free on iOS and Android.',
        showBadges: true,
      },
    },
    {
      component: 'DiamondBurst',
      startFrame: s(131),
      durationFrames: s(9),
      props: {scale: 'finale', color: 'mixed', count: 20},
    },
  ],
  captions: [
    // Sahne 1 (0-4s)
    {text: 'months on a dating app', startFrame: s(0.5), durationFrames: s(2)},
    {text: 'met no one', startFrame: s(2.5), durationFrames: s(1.5)},

    // Sahne 2 (4-10s)
    {text: 'you match', startFrame: s(4.5), durationFrames: s(1.2)},
    {text: 'they ghost', startFrame: s(5.7), durationFrames: s(1.3)},
    {text: 'forever loop', startFrame: s(7.5), durationFrames: s(1.8)},
    {text: 'sound familiar?', startFrame: s(9.3), durationFrames: s(0.7)},

    // Sahne 3 (10-16s)
    {text: 'a new app', startFrame: s(10.5), durationFrames: s(2)},
    {text: "you don't swipe", startFrame: s(12.7), durationFrames: s(1.6)},
    {text: 'you SOLVE', startFrame: s(14.3), durationFrames: s(1.7)},

    // Sahne 4 (16-30s)
    {text: "it's called Qulo", startFrame: s(16.5), durationFrames: s(2.5)},
    {text: 'see someone interesting?', startFrame: s(19.5), durationFrames: s(2.5)},
    {text: "read her 3 questions", startFrame: s(22.5), durationFrames: s(3)},
    {text: 'she wrote to filter', startFrame: s(26), durationFrames: s(3.5)},

    // Sahne 5 (30-55s)
    {text: 'answer all three', startFrame: s(30.5), durationFrames: s(2.5)},
    {text: 'pineapple on pizza?', startFrame: s(33.5), durationFrames: s(3)},
    {text: 'mountains or beach?', startFrame: s(38.5), durationFrames: s(3)},
    {text: "don't guess", startFrame: s(42), durationFrames: s(2)},
    {text: 'last red-flag question', startFrame: s(47), durationFrames: s(3)},
    {text: 'nail it', startFrame: s(50.5), durationFrames: s(2)},
    {text: 'one wrong, no match', startFrame: s(52.5), durationFrames: s(2.5)},

    // Sahne 6 (55-65s)
    {text: 'BOOM', startFrame: s(55.5), durationFrames: s(1.5)},
    {text: 'three for three', startFrame: s(57), durationFrames: s(2)},
    {text: 'MATCH UNLOCKED', startFrame: s(59), durationFrames: s(3)},
    {text: '+5 diamonds', startFrame: s(62), durationFrames: s(2.5)},

    // Sahne 7 (65-78s)
    {text: 'now you actually talk', startFrame: s(65.5), durationFrames: s(3)},
    {text: 'about something real', startFrame: s(68.5), durationFrames: s(2.5)},
    {text: 'no awkward opener', startFrame: s(72), durationFrames: s(3)},
    {text: 'match handed you the script', startFrame: s(75), durationFrames: s(3)},

    // Sahne 8 (78-93s)
    {text: 'your turn', startFrame: s(78.5), durationFrames: s(2)},
    {text: 'build your filter', startFrame: s(81), durationFrames: s(3)},
    {text: '3 questions', startFrame: s(84.5), durationFrames: s(2.5)},
    {text: 'weed out the noise', startFrame: s(88), durationFrames: s(4.5)},

    // Sahne 9 (93-103s)
    {text: 'stuck for ideas?', startFrame: s(93.5), durationFrames: s(2.5)},
    {text: 'tap once', startFrame: s(96.5), durationFrames: s(1.5)},
    {text: '✨ AI writes them', startFrame: s(98.5), durationFrames: s(3.5)},

    // Sahne 10 (103-118s)
    {text: 'green diamonds: EARN', startFrame: s(103.5), durationFrames: s(3.5)},
    {text: 'purple: SPEND', startFrame: s(107.5), durationFrames: s(3)},
    {text: '30 = 30 min boost', startFrame: s(111), durationFrames: s(3.5)},
    {text: 'a whole economy', startFrame: s(115), durationFrames: s(3)},

    // Sahne 11 (118-128s)
    {text: 'no empty chats', startFrame: s(118.5), durationFrames: s(2.5)},
    {text: 'no guessing', startFrame: s(121.5), durationFrames: s(2)},
    {text: 'real questions, real matches', startFrame: s(124), durationFrames: s(4)},

    // Sahne 12 (128-140s)
    {text: 'stop swiping', startFrame: s(128.5), durationFrames: s(2)},
    {text: 'start matching', startFrame: s(131), durationFrames: s(2.5)},
    {text: 'Qulo — iOS + Android', startFrame: s(134), durationFrames: s(3.5)},
    {text: 'go earn one 💎', startFrame: s(138), durationFrames: s(2)},
  ],
  audioTrack: {
    path: 'audio/qulo-full-app-intro-mix.mp3',
    volume: 1.0,
    startFrom: 0,
  },
};
