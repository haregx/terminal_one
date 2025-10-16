import 'package:flutter/material.dart';
import 'package:terminal_one/core/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';

/// Example demonstrating SettingsScreen navigation and customization
/// 
/// This example shows different ways to navigate to the settings screen
/// and how to extend its functionality
class SettingsNavigationExample extends StatelessWidget {
  const SettingsNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings_navigation_example.title'.tr())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Method 1: Using AppRoutes helper method (Recommended)
            ElevatedButton(
              onPressed: () => AppRoutes.navigateToSettings(context),
              child: Text('settings_navigation_example.navigate_to_settings'.tr()),
            ),
            const SizedBox(height: 16),
            // Method 2: Using Navigator.pushNamed directly
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
              child: Text('settings_navigation_example.navigate_using_route_name'.tr()),
            ),
            const SizedBox(height: 16),
            // Method 3: From AppBar action (as shown in HomeScreenLoggedIn)
            // (This is a code sample, so we keep it as is)
            const Text(
              'Settings button in AppBar:\n'
              'IconButton(\n'
              '  icon: Icon(LucideIcons.settings),\n'
              '  onPressed: () => AppRoutes.navigateToSettings(context),\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Example showing how to extend SettingsScreen with custom settings
/// 
/// The SettingsScreen can be extended to include app-specific settings
class CustomSettingsExample {
  // Example: Custom settings storage
  static Future<void> saveCustomSetting(String key, dynamic value) async {
    // TODO: Implement with SharedPreferences or your preferred storage
    debugPrint('Saving setting: $key = $value');
  }
  
  static Future<T?> loadCustomSetting<T>(String key) async {
    // TODO: Implement with SharedPreferences or your preferred storage
    debugPrint('Loading setting: $key');
    return null;
  }
  
  // Example: Custom setting validation
  static bool validateNotificationTime(TimeOfDay time) {
    // Example: Don't allow notifications between 10 PM and 6 AM
    return !(time.hour >= 22 || time.hour < 6);
  }
  
  // Example: Custom theme creation
  static ThemeData createCustomTheme(Color primaryColor) {
    return ThemeData(
      primarySwatch: MaterialColor(
        primaryColor.value,
        <int, Color>{
          50: primaryColor.withAlpha(26),
          100: primaryColor.withAlpha(51),
          200: primaryColor.withAlpha(77),
          300: primaryColor.withAlpha(102),
          400: primaryColor.withAlpha(128),
          500: primaryColor.withAlpha(153),
          600: primaryColor.withAlpha(179),
          700: primaryColor.withAlpha(204),
          800: primaryColor.withAlpha(230),
          900: primaryColor,
        },
      ),
    );
  }
}

/// Example settings model for type-safe settings management
class AppSettings {
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final bool analyticsEnabled;
  final bool crashReportsEnabled;
  final String selectedLanguage;
  final String selectedRegion;
  final ThemeMode themeMode;
  
  const AppSettings({
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.analyticsEnabled = false,
    this.crashReportsEnabled = true,
    this.selectedLanguage = 'English',
    this.selectedRegion = 'Automatic',
    this.themeMode = ThemeMode.system,
  });
  
  AppSettings copyWith({
    bool? notificationsEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    bool? analyticsEnabled,
    bool? crashReportsEnabled,
    String? selectedLanguage,
    String? selectedRegion,
    ThemeMode? themeMode,
  }) {
    return AppSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      crashReportsEnabled: crashReportsEnabled ?? this.crashReportsEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      themeMode: themeMode ?? this.themeMode,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'analyticsEnabled': analyticsEnabled,
      'crashReportsEnabled': crashReportsEnabled,
      'selectedLanguage': selectedLanguage,
      'selectedRegion': selectedRegion,
      'themeMode': themeMode.name,
    };
  }
  
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      soundEnabled: json['soundEnabled'] ?? true,
      vibrationEnabled: json['vibrationEnabled'] ?? true,
      analyticsEnabled: json['analyticsEnabled'] ?? false,
      crashReportsEnabled: json['crashReportsEnabled'] ?? true,
      selectedLanguage: json['selectedLanguage'] ?? 'English',
      selectedRegion: json['selectedRegion'] ?? 'Automatic',
      themeMode: ThemeMode.values.firstWhere(
        (mode) => mode.name == json['themeMode'],
        orElse: () => ThemeMode.system,
      ),
    );
  }
}