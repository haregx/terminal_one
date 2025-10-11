import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Settings Provider für App-weite Einstellungen
/// 
/// Verwaltet alle Benutzereinstellungen mit automatischer Persistierung
/// über SharedPreferences
class SettingsProvider extends ChangeNotifier {
  bool _isLoaded = false;
  
  // Benachrichtigungen
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  
  // Privacy & Analytics
  bool _analyticsEnabled = false;
  bool _crashReportsEnabled = true;
  
  // Sprache & Region
  String _selectedLanguageCode = 'de';
  String _selectedRegionCode = 'auto';

  // SharedPreferences Keys
  static const String _keyNotifications = 'push_notifications';
  static const String _keySound = 'sound_enabled';
  static const String _keyVibration = 'vibration_enabled';
  static const String _keyAnalytics = 'analytics_enabled';
  static const String _keyCrashReports = 'crash_reports';
  static const String _keyLanguage = 'language_code';
  static const String _keyRegion = 'region_code';

  // Getters
  bool get isLoaded => _isLoaded;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;
  bool get analyticsEnabled => _analyticsEnabled;
  bool get crashReportsEnabled => _crashReportsEnabled;
  String get selectedLanguageCode => _selectedLanguageCode;
  String get selectedRegionCode => _selectedRegionCode;

  /// Initialisiert den Provider und lädt gespeicherte Einstellungen
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    _notificationsEnabled = prefs.getBool(_keyNotifications) ?? true;
    _soundEnabled = prefs.getBool(_keySound) ?? true;
    _vibrationEnabled = prefs.getBool(_keyVibration) ?? true;
    _analyticsEnabled = prefs.getBool(_keyAnalytics) ?? false;
    _crashReportsEnabled = prefs.getBool(_keyCrashReports) ?? true;
    _selectedLanguageCode = prefs.getString(_keyLanguage) ?? 'de';
    _selectedRegionCode = prefs.getString(_keyRegion) ?? 'auto';
    
    _isLoaded = true;
    notifyListeners();
  }

  /// Speichert alle aktuellen Einstellungen in SharedPreferences
  Future<void> _saveAllSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setBool(_keyNotifications, _notificationsEnabled),
      prefs.setBool(_keySound, _soundEnabled),
      prefs.setBool(_keyVibration, _vibrationEnabled),
      prefs.setBool(_keyAnalytics, _analyticsEnabled),
      prefs.setBool(_keyCrashReports, _crashReportsEnabled),
      prefs.setString(_keyLanguage, _selectedLanguageCode),
      prefs.setString(_keyRegion, _selectedRegionCode),
    ]);
  }

  /// Speichert eine einzelne Einstellung
  Future<void> _saveSingleSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  // Setter-Methoden mit automatischer Persistierung

  /// Setzt den Status für Push-Benachrichtigungen
  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    notifyListeners();
    await _saveSingleSetting(_keyNotifications, enabled);
  }

  /// Setzt den Status für Sound-Benachrichtigungen
  Future<void> setSoundEnabled(bool enabled) async {
    _soundEnabled = enabled;
    notifyListeners();
    await _saveSingleSetting(_keySound, enabled);
  }

  /// Setzt den Status für Vibrations-Benachrichtigungen
  Future<void> setVibrationEnabled(bool enabled) async {
    _vibrationEnabled = enabled;
    notifyListeners();
    await _saveSingleSetting(_keyVibration, enabled);
  }

  /// Setzt den Status für Analytics
  Future<void> setAnalyticsEnabled(bool enabled) async {
    _analyticsEnabled = enabled;
    notifyListeners();
    await _saveSingleSetting(_keyAnalytics, enabled);
  }

  /// Setzt den Status für Crash Reports
  Future<void> setCrashReportsEnabled(bool enabled) async {
    _crashReportsEnabled = enabled;
    notifyListeners();
    await _saveSingleSetting(_keyCrashReports, enabled);
  }

  /// Setzt die ausgewählte Sprache
  Future<void> setSelectedLanguageCode(String languageCode) async {
    _selectedLanguageCode = languageCode;
    notifyListeners();
    await _saveSingleSetting(_keyLanguage, languageCode);
  }

  /// Setzt die ausgewählte Region
  Future<void> setSelectedRegionCode(String regionCode) async {
    _selectedRegionCode = regionCode;
    notifyListeners();
    await _saveSingleSetting(_keyRegion, regionCode);
  }

  /// Setzt alle Einstellungen auf Standardwerte zurück
  Future<void> resetToDefaults() async {
    _notificationsEnabled = true;
    _soundEnabled = true;
    _vibrationEnabled = true;
    _analyticsEnabled = false;
    _crashReportsEnabled = true;
    _selectedLanguageCode = 'en';
    _selectedRegionCode = 'auto';
    
    notifyListeners();
    await _saveAllSettings();
  }

  /// Exportiert alle Einstellungen als Map
  Map<String, dynamic> exportSettings() {
    return {
      'notifications_enabled': _notificationsEnabled,
      'sound_enabled': _soundEnabled,
      'vibration_enabled': _vibrationEnabled,
      'analytics_enabled': _analyticsEnabled,
      'crash_reports_enabled': _crashReportsEnabled,
      'selected_language_code': _selectedLanguageCode,
      'selected_region_code': _selectedRegionCode,
    };
  }

  /// Importiert Einstellungen aus einer Map
  Future<void> importSettings(Map<String, dynamic> settings) async {
    _notificationsEnabled = settings['notifications_enabled'] ?? true;
    _soundEnabled = settings['sound_enabled'] ?? true;
    _vibrationEnabled = settings['vibration_enabled'] ?? true;
    _analyticsEnabled = settings['analytics_enabled'] ?? false;
    _crashReportsEnabled = settings['crash_reports_enabled'] ?? true;
    _selectedLanguageCode = settings['selected_language_code'] ?? 'en';
    _selectedRegionCode = settings['selected_region_code'] ?? 'auto';
    
    notifyListeners();
    await _saveAllSettings();
  }

  /// Gibt alle verfügbaren Sprachen zurück
 /* static const Map<String, String> availableLanguages = {
    'en': 'English',
    'de': 'Deutsch',
  };*/

  /// Gibt alle verfügbaren Regionen zurück
 /* static const Map<String, String> availableRegions = {
    'auto': 'Automatic',
    'us': 'United States',
    'eu': 'Europe',
    'asia': 'Asia',
    'other': 'Other',
  };*/
}