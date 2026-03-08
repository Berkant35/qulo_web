abstract final class AppConstants {
  static const int maxPhotos = 6;
  static const int minQuestions = 2;
  static const int maxQuestions = 6;
  static const int questionTimeSeconds = 30;
  static const int timeExtendSeconds = 15;
  static const double greenDiamondRewardRatio = 0.30;
  static const int boostCostGreen = 30;
  static const int boostDurationMinutes = 30;
  static const int passportCostPurple = 50;

  static const List<int> timePresets = [15, 30, 60, 90];
  static const List<String> questionCategories = [
    'personality', 'music', 'film', 'sports', 'travel',
    'food', 'technology', 'general', 'other',
  ];
}
