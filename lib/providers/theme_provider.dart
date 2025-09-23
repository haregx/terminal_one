import 'package:flutter/material.dart';

/// Theme provider for managing app-wide theme state
/// 
/// Provides theme management functionality with state persistence
/// and automatic theme switching capabilities.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  /// Current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Whether the current theme is dark
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Whether the current theme is light
  bool get isLightMode => _themeMode == ThemeMode.light;

  /// Whether the theme follows system setting
  bool get isSystemMode => _themeMode == ThemeMode.system;

  /// Set theme mode and notify listeners
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
      // TODO: Save to SharedPreferences
    }
  }

  /// Toggle between light and dark mode
  void toggleTheme() {
    setThemeMode(_themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  /// Set to light mode
  void setLightMode() {
    setThemeMode(ThemeMode.light);
  }

  /// Set to dark mode
  void setDarkMode() {
    setThemeMode(ThemeMode.dark);
  }

  /// Set to system mode
  void setSystemMode() {
    setThemeMode(ThemeMode.system);
  }
}