import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/network_manager.dart';
import '../core/network/services/auth_service.dart';
import '../core/network/services/user_service.dart';
import '../core/network/services/question_service.dart';
import '../core/network/services/match_service.dart';
import '../core/network/services/quiz_service.dart';
import '../core/network/services/chat_service.dart';
import '../core/network/services/diamond_service.dart';
import '../core/network/services/power_service.dart';
import '../core/network/services/passport_service.dart';
import '../core/network/services/report_service.dart';
import '../core/network/services/subscription_service.dart';
import '../data/repositories/repositories.dart';

// ─── NetworkManager ───
final networkManagerProvider = Provider<NetworkManager>(
  (_) => NetworkManager.instance,
);

// ─── Retrofit Services ───
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.read(networkManagerProvider).dio),
);
final userServiceProvider = Provider<UserService>(
  (ref) => UserService(ref.read(networkManagerProvider).dio),
);
final questionServiceProvider = Provider<QuestionService>(
  (ref) => QuestionService(ref.read(networkManagerProvider).dio),
);
final matchServiceProvider = Provider<MatchService>(
  (ref) => MatchService(ref.read(networkManagerProvider).dio),
);
final quizServiceProvider = Provider<QuizService>(
  (ref) => QuizService(ref.read(networkManagerProvider).dio),
);
final chatServiceProvider = Provider<ChatService>(
  (ref) => ChatService(ref.read(networkManagerProvider).dio),
);
final diamondServiceProvider = Provider<DiamondService>(
  (ref) => DiamondService(ref.read(networkManagerProvider).dio),
);
final powerServiceProvider = Provider<PowerService>(
  (ref) => PowerService(ref.read(networkManagerProvider).dio),
);
final passportServiceProvider = Provider<PassportService>(
  (ref) => PassportService(ref.read(networkManagerProvider).dio),
);
final reportServiceProvider = Provider<ReportService>(
  (ref) => ReportService(ref.read(networkManagerProvider).dio),
);
final subscriptionServiceProvider = Provider<SubscriptionService>(
  (ref) => SubscriptionService(ref.read(networkManagerProvider).dio),
);

// ─── Repositories ───
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(authServiceProvider)),
);
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(
    ref.read(userServiceProvider),
    ref.read(networkManagerProvider),
  ),
);
final questionRepositoryProvider = Provider<QuestionRepository>(
  (ref) => QuestionRepository(
    ref.read(questionServiceProvider),
    ref.read(networkManagerProvider),
  ),
);
final matchRepositoryProvider = Provider<MatchRepository>(
  (ref) => MatchRepository(ref.read(matchServiceProvider)),
);
final quizRepositoryProvider = Provider<QuizRepository>(
  (ref) => QuizRepository(ref.read(quizServiceProvider)),
);
final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepository(ref.read(chatServiceProvider)),
);
final diamondRepositoryProvider = Provider<DiamondRepository>(
  (ref) => DiamondRepository(ref.read(diamondServiceProvider)),
);
final powerRepositoryProvider = Provider<PowerRepository>(
  (ref) => PowerRepository(ref.read(powerServiceProvider)),
);
final passportRepositoryProvider = Provider<PassportRepository>(
  (ref) => PassportRepository(
    ref.read(passportServiceProvider),
    ref.read(networkManagerProvider),
  ),
);
final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) => ReportRepository(ref.read(reportServiceProvider)),
);
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>(
  (ref) => SubscriptionRepository(ref.read(subscriptionServiceProvider)),
);
