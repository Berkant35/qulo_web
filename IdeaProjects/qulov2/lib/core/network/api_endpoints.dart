abstract final class ApiEndpoints {
  // Auth
  static const register = '/auth/register';
  static const login = '/auth/login';
  static const verifyEmail = '/auth/verify-email';
  static const refresh = '/auth/refresh';
  static const logout = '/auth/logout';
  static const forgotPassword = '/auth/forgot-password';
  static const resetPassword = '/auth/reset-password';

  // Users
  static const me = '/users/me';
  static const meDetails = '/users/me/details';
  static const meLocation = '/users/me/location';
  static const mePhotos = '/users/me/photos';
  static const mePushToken = '/users/me/push-token';
  static const meBoost = '/users/me/boost';

  // Questions
  static const questions = '/questions/me';
  static String questionByOrder(int order) => '/questions/me/$order';
  static const questionCount = '/questions/count/me';

  // Matching
  static const discover = '/match/discover';
  static const swipe = '/match/swipe';
  static const matchList = '/match/list';
  static String unmatch(String id) => '/match/$id';

  // Quiz
  static const quizStart = '/quiz/start';
  static String quizSession(String id) => '/quiz/$id';
  static String quizAnswer(String id) => '/quiz/$id/answer';
  static String quizResult(String id) => '/quiz/$id/result';

  // Diamonds
  static const diamondBalance = '/diamonds/balance';
  static const diamondHistory = '/diamonds/history';
  static const diamondPurchase = '/diamonds/purchase';

  // Powers
  static const powers = '/powers';

  // Passport
  static const passportActivate = '/passport/activate';
  static const passportDeactivate = '/passport/deactivate';

  // Chat
  static String chatMessages(String matchId) => '/chat/$matchId/messages';
  static String chatRead(String matchId) => '/chat/$matchId/read';

  // Reports
  static const reports = '/reports';
}
