import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  AppThemeMode _themeMode = AppThemeMode.system;
  
  AppThemeMode get themeMode => _themeMode;
  
  // Singleton Pattern
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();
  
  // Initialisierung - lädt gespeicherte Theme-Einstellung
  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themeKey);
      
      switch (savedTheme) {
        case 'light':
          _themeMode = AppThemeMode.light;
          break;
        case 'dark':
          _themeMode = AppThemeMode.dark;
          break;
        default:
          _themeMode = AppThemeMode.system;
      }
    } catch (e) {
      // Fallback wenn SharedPreferences nicht verfügbar
      _themeMode = AppThemeMode.system;
    }
    
    notifyListeners();
  }
  
  // Theme ändern und speichern
  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      switch (mode) {
        case AppThemeMode.system:
          await prefs.setString(_themeKey, 'system');
          break;
        case AppThemeMode.light:
          await prefs.setString(_themeKey, 'light');
          break;
        case AppThemeMode.dark:
          await prefs.setString(_themeKey, 'dark');
          break;
      }
    } catch (e) {
      // Fehlerbehandlung falls Speichern fehlschlägt
      print('Theme konnte nicht gespeichert werden: $e');
    }
    
    notifyListeners();
  }
  
  // Flutter ThemeMode für MaterialApp
  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
  
  // Nächster Theme-Modus (für Toggle-Button)
  AppThemeMode get nextThemeMode {
    switch (_themeMode) {
      case AppThemeMode.system:
        return AppThemeMode.light;
      case AppThemeMode.light:
        return AppThemeMode.dark;
      case AppThemeMode.dark:
        return AppThemeMode.system;
    }
  }
  
  // Icon für aktuellen Theme-Modus
  IconData get currentIcon {
    switch (_themeMode) {
      case AppThemeMode.system:
        return Icons.brightness_auto;
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
    }
  }
  
  // Text für aktuellen Theme-Modus
  String get currentLabel {
    switch (_themeMode) {
      case AppThemeMode.system:
        return 'System';
      case AppThemeMode.light:
        return 'Hell';
      case AppThemeMode.dark:
        return 'Dunkel';
    }
  }
}