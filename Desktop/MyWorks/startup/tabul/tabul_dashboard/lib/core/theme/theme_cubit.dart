import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

/// Theme state'i
class ThemeState extends Equatable {
  const ThemeState({
    required this.isDarkMode,
    required this.isSystemMode,
  });

  final bool isDarkMode;
  final bool isSystemMode;

  /// Initial state
  static const initial = ThemeState(
    isDarkMode: false,
    isSystemMode: true,
  );

  /// Copy with method
  ThemeState copyWith({
    bool? isDarkMode,
    bool? isSystemMode,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isSystemMode: isSystemMode ?? this.isSystemMode,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, isSystemMode];
}

/// Theme yönetim cubit'i
/// Light/Dark mode ve system theme desteği ile
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial) {
    _loadThemePreference();
  }

  // ==================== CONSTANTS ====================

  static const String _themePreferenceKey = 'theme_preference';
  static const String _darkModeKey = 'dark_mode';
  static const String _systemModeKey = 'system_mode';

  // ==================== THEME ACTIONS ====================

  /// Light theme'e geç
  void setLightTheme() {
    _updateTheme(isDarkMode: false, isSystemMode: false);
  }

  /// Dark theme'e geç
  void setDarkTheme() {
    _updateTheme(isDarkMode: true, isSystemMode: false);
  }

  /// System theme'e geç
  void setSystemTheme() {
    _updateTheme(isSystemMode: true);
  }

  /// Theme'i toggle et (light/dark arasında)
  void toggleTheme() {
    if (state.isSystemMode) {
      // System mode'daysa dark theme'e geç
      setDarkTheme();
    } else {
      // Manual mode'daysa toggle et
      _updateTheme(isDarkMode: !state.isDarkMode, isSystemMode: false);
    }
  }

  /// Manual olarak dark mode'u ayarla
  void setDarkMode(bool isDark) {
    _updateTheme(isDarkMode: isDark, isSystemMode: false);
  }

  /// System brightness'a göre theme ayarla
  void updateSystemTheme(bool isSystemDark) {
    if (state.isSystemMode) {
      emit(state.copyWith(isDarkMode: isSystemDark));
    }
  }

  // ==================== PRIVATE METHODS ====================

  /// Theme'i güncelle ve kaydet
  void _updateTheme({bool? isDarkMode, bool? isSystemMode}) {
    final newState = state.copyWith(
      isDarkMode: isDarkMode,
      isSystemMode: isSystemMode,
    );

    emit(newState);
    _saveThemePreference();
  }

  /// Theme tercihini yükle
  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final isDarkMode = prefs.getBool(_darkModeKey) ?? false;
      final isSystemMode = prefs.getBool(_systemModeKey) ?? true;

      emit(ThemeState(
        isDarkMode: isDarkMode,
        isSystemMode: isSystemMode,
      ));
    } catch (e) {
      // Error durumunda default state'i koru
      emit(ThemeState.initial);
    }
  }

  /// Theme tercihini kaydet
  Future<void> _saveThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool(_darkModeKey, state.isDarkMode);
      await prefs.setBool(_systemModeKey, state.isSystemMode);
    } catch (e) {
      // Error handling - sessizce başarısız ol
      // Production'da logging eklenebilir
    }
  }

  // ==================== GETTERS ====================

  /// Aktif tema mode'u
  String get currentThemeMode {
    if (state.isSystemMode) {
      return 'System';
    } else if (state.isDarkMode) {
      return 'Dark';
    } else {
      return 'Light';
    }
  }

  /// Theme seçenekleri listesi
  List<String> get availableThemes => ['Light', 'Dark', 'System'];

  /// Theme mode'u index'e göre ayarla
  void setThemeByIndex(int index) {
    switch (index) {
      case 0:
        setLightTheme();
        break;
      case 1:
        setDarkTheme();
        break;
      case 2:
        setSystemTheme();
        break;
      default:
        setSystemTheme();
    }
  }

  /// Current theme mode'unun index'ini al
  int get currentThemeIndex {
    if (state.isSystemMode) return 2;
    if (state.isDarkMode) return 1;
    return 0;
  }

  // ==================== UTILITY METHODS ====================

  /// Debug bilgisi
  Map<String, dynamic> get debugInfo => {
        'isDarkMode': state.isDarkMode,
        'isSystemMode': state.isSystemMode,
        'currentThemeMode': currentThemeMode,
      };

  /// Theme'i reset et
  void resetTheme() {
    emit(ThemeState.initial);
    _saveThemePreference();
  }

  /// Preference'ları temizle
  Future<void> clearPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_darkModeKey);
      await prefs.remove(_systemModeKey);
      emit(ThemeState.initial);
    } catch (e) {
      // Error handling
    }
  }
}
