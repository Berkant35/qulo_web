import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../data/repositories/repositories.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(apiClientProvider)),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(ref.read(apiClientProvider)),
);

final questionRepositoryProvider = Provider<QuestionRepository>(
  (ref) => QuestionRepository(ref.read(apiClientProvider)),
);

final matchRepositoryProvider = Provider<MatchRepository>(
  (ref) => MatchRepository(ref.read(apiClientProvider)),
);

final quizRepositoryProvider = Provider<QuizRepository>(
  (ref) => QuizRepository(ref.read(apiClientProvider)),
);

final diamondRepositoryProvider = Provider<DiamondRepository>(
  (ref) => DiamondRepository(ref.read(apiClientProvider)),
);

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepository(ref.read(apiClientProvider)),
);

final passportRepositoryProvider = Provider<PassportRepository>(
  (ref) => PassportRepository(ref.read(apiClientProvider)),
);

final powerRepositoryProvider = Provider<PowerRepository>(
  (ref) => PowerRepository(ref.read(apiClientProvider)),
);

final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) => ReportRepository(ref.read(apiClientProvider)),
);
