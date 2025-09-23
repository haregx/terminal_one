import 'package:flutter/material.dart';
import 'platform_typography.dart';

/// Theme configuration and management for the app
/// 
/// Provides both light and dark theme definitions with consistent
/// color schemes, typography, and component styling.
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    const ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      // Primary colors - Main brand colors (heller)
      primary: Color(0xFF2196F3), // Helleres Blau
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFE3F2FD), // Sehr helles Blau
      onPrimaryContainer: Color(0xFF0D47A1),
      
      // Secondary colors - Accent colors (heller)
      secondary: Color(0xFF9C27B0), // Helleres Lila
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFF3E5F5), // Sehr helles Lila
      onSecondaryContainer: Color(0xFF4A148C),
      
      // Surface colors - Background and surface elements (sehr hell)
      surface: Color(0xFFFFFFFE), // Fast reines Weiß (moderne Material Design 3)
      onSurface: Color(0xFF1A1A1A), // Sehr dunkler Text für Kontrast
      surfaceContainerHighest: Color(0xFFF8F9FA), // Sehr heller Grau
      onSurfaceVariant: Color(0xFF424242), // Mittlerer Grau für weniger wichtigen Text
      
      // Error colors
      error: Color(0xFFE53935), // Klareres Rot
      onError: Colors.white,
      errorContainer: Color(0xFFFFEBEE), // Sehr helles Rot
      onErrorContainer: Color(0xFFB71C1C),
      
      // Outline and other colors (heller)
      outline: Color(0xFFE0E0E0), // Heller Grau für Umrandungen
      outlineVariant: Color(0xFFF5F5F5), // Sehr heller Grau
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF121212),
      onInverseSurface: Color(0xFFFFFFFF),
      inversePrimary: Color(0xFF90CAF9),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      
      // Platform-aware Typography
      textTheme: PlatformTypography.createTextTheme(Brightness.light),
      
      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: lightColorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: lightColorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          minimumSize: const Size(88, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightColorScheme.primary,
          minimumSize: const Size(88, 48),
          side: BorderSide(color: lightColorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    const ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      // Primary colors - Adjusted for dark theme
      primary: Color(0xFF90CAF9), // Lighter blue for dark mode
      onPrimary: Color(0xFF0D47A1),
      primaryContainer: Color(0xFF1565C0),
      onPrimaryContainer: Color(0xFFE3F2FD),
      
      // Secondary colors
      secondary: Color(0xFFB39DDB), // Lighter purple for dark mode
      onSecondary: Color(0xFF4A148C),
      secondaryContainer: Color(0xFF673AB7),
      onSecondaryContainer: Color(0xFFF3E5F5),
      
      // Surface colors - Dark surfaces (moderne Material Design 3)
      surface: Color(0xFF121212), // Dunkler Hintergrund für beide (surface + background)
      onSurface: Color(0xFFE0E0E0), // Heller Text für beide (onSurface + onBackground)
      surfaceContainerHighest: Color(0xFF1E1E1E), // Ersetzt surfaceVariant
      onSurfaceVariant: Color(0xFFBDBDBD),
      
      // Error colors
      error: Color(0xFFCF6679),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      
      // Outline and other colors
      outline: Color(0xFF616161),
      outlineVariant: Color(0xFF424242),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFE0E0E0),
      onInverseSurface: Color(0xFF303030),
      inversePrimary: Color(0xFF1976D2),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      
      // Platform-aware Typography (Dark theme)
      textTheme: PlatformTypography.createTextTheme(Brightness.dark),
      
      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: darkColorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: darkColorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          minimumSize: const Size(88, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkColorScheme.primary,
          minimumSize: const Size(88, 48),
          side: BorderSide(color: darkColorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}