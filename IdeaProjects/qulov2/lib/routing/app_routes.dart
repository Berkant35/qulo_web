part of 'app_router.dart';

final _routes = <RouteBase>[
  GoRoute(
    path: '/',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const SplashScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ),

  // Auth
  GoRoute(
    path: '/auth/login',
    name: RouteNames.login,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    ),
    routes: [
      GoRoute(
        path: 'register',
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: 'forgot-password',
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
  ),

  // Onboarding
  GoRoute(
    path: '/onboarding',
    name: RouteNames.onboarding,
    builder: (context, state) => const OnboardingScreen(),
  ),

  // Main shell (bottom nav)
  StatefulShellRoute.indexedStack(
    builder: (context, state, shell) => _MainShell(shell: shell),
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(
          path: '/discover',
          name: RouteNames.discover,
          builder: (context, state) => const DiscoverScreen(),
          routes: [
            GoRoute(
              path: 'quiz/:targetId',
              name: RouteNames.quiz,
              builder: (context, state) => QuizScreen(
                targetId: state.pathParameters['targetId']!,
              ),
            ),
          ],
        ),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
          path: '/matches',
          name: RouteNames.matches,
          builder: (context, state) => const MatchesScreen(),
          routes: [
            GoRoute(
              path: 'chat/:matchId',
              name: RouteNames.chat,
              builder: (context, state) => ChatScreen(
                matchId: state.pathParameters['matchId']!,
              ),
            ),
          ],
        ),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
          path: '/profile',
          name: RouteNames.profile,
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'questions',
              name: RouteNames.questions,
              builder: (context, state) => const QuestionsScreen(),
            ),
            GoRoute(
              path: 'diamonds',
              name: RouteNames.diamonds,
              builder: (context, state) => const DiamondsScreen(),
            ),
            GoRoute(
              path: 'passport',
              name: RouteNames.passport,
              builder: (context, state) => const PassportScreen(),
            ),
            GoRoute(
              path: 'settings',
              name: RouteNames.settings,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ]),
    ],
  ),
];

class _MainShell extends StatelessWidget {
  final StatefulNavigationShell shell;
  const _MainShell({required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            color: const Color(0xFFBB86FC).withValues(alpha: 0.3),
          ),
          NavigationBar(
            selectedIndex: shell.currentIndex,
            onDestinationSelected: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.explore), label: 'Discover'),
              NavigationDestination(icon: Icon(Icons.favorite), label: 'Matches'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ],
      ),
    );
  }
}
