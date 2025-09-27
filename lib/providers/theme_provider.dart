import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme provider for managing app-wide theme state
/// 
/// Provides theme management functionality with state persistence
/// and automatic theme switching capabilities.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  static const String _themePrefKey = 'theme_mode';

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final modeString = prefs.getString(_themePrefKey);
    if (modeString != null) {
      switch (modeString) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        default:
          _themeMode = ThemeMode.system;
      }
      notifyListeners();
    }
  }

  /// Current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Whether the current theme is dark
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Whether the current theme is light
  bool get isLightMode => _themeMode == ThemeMode.light;

  /// Whether the theme follows system setting
  bool get isSystemMode => _themeMode == ThemeMode.system;

  /// Set theme mode and notify listeners
  void setThemeMode(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String modeString;
      switch (mode) {
        case ThemeMode.light:
          modeString = 'light';
          break;
        case ThemeMode.dark:
          modeString = 'dark';
          break;
        default:
          modeString = 'system';
      }
      await prefs.setString(_themePrefKey, modeString);
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