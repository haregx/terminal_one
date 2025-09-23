import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../utils/platform_stub.dart'
    if (dart.library.io) '../utils/platform_io.dart' as platform;

/// Platform-aware typography that automatically uses the appropriate
/// font families following iOS and Android design guidelines
class PlatformTypography {
  PlatformTypography._();

  /// Get platform-appropriate font family
  static String get primaryFontFamily {
    if (kIsWeb) {
      return 'Roboto';
    }
  if (platform.Platform.isIOS || platform.Platform.isMacOS) {
      return '.SF UI Text';
    } else {
      return 'Roboto';
    }
  }

  /// Get platform-appropriate display font family (for large text)
  static String get displayFontFamily {
    if (kIsWeb) {
      return 'Roboto';
    }
  if (platform.Platform.isIOS || platform.Platform.isMacOS) {
      return '.SF UI Display';
    } else {
      return 'Roboto';
    }
  }

  /// iOS Typography Scale (Human Interface Guidelines)
  static const Map<String, double> iosFontSizes = {
    'largeTitle': 34.0,
    'title1': 28.0,
    'title2': 22.0,
    'title3': 20.0,
    'headline': 17.0,
    'body': 17.0,
    'callout': 16.0,
    'subhead': 15.0,
    'footnote': 13.0,
    'caption1': 12.0,
    'caption2': 11.0,
  };

  /// Android Typography Scale (Material Design 3)
  static const Map<String, double> androidFontSizes = {
    'displayLarge': 57.0,
    'displayMedium': 45.0,
    'displaySmall': 36.0,
    'headlineLarge': 32.0,
    'headlineMedium': 28.0,
    'headlineSmall': 24.0,
    'titleLarge': 22.0,
    'titleMedium': 16.0,
    'titleSmall': 14.0,
    'bodyLarge': 16.0,
    'bodyMedium': 14.0,
    'bodySmall': 12.0,
    'labelLarge': 14.0,
    'labelMedium': 12.0,
    'labelSmall': 11.0,
  };

  /// Create platform-appropriate TextTheme
  static TextTheme createTextTheme(Brightness brightness) {
  final bool isIOS = !kIsWeb && (platform.Platform.isIOS || platform.Platform.isMacOS);
    final String fontFamily = primaryFontFamily;
    final String displayFontFamily = PlatformTypography.displayFontFamily;
    
    final Color textColor = brightness == Brightness.light 
        ? const Color(0xFF1A1A1A) 
        : const Color(0xFFFFFFFF);
    
    final Color secondaryTextColor = brightness == Brightness.light 
        ? const Color(0xFF666666) 
        : const Color(0xFFBBBBBB);

    if (isIOS) {
      // iOS Typography following Human Interface Guidelines
      return TextTheme(
        // Large Title (iOS specific)
        displayLarge: TextStyle(
          fontFamily: displayFontFamily,
          fontSize: iosFontSizes['largeTitle']!,
          fontWeight: FontWeight.w700, // Bold
          letterSpacing: -0.5,
          height: 1.2,
          color: textColor,
        ),
        
        // Title 1
        displayMedium: TextStyle(
          fontFamily: displayFontFamily,
          fontSize: iosFontSizes['title1']!,
          fontWeight: FontWeight.w600, // Semibold
          letterSpacing: -0.3,
          height: 1.3,
          color: textColor,
        ),
        
        // Title 2
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['title2']!,
          fontWeight: FontWeight.w600, // Semibold
          letterSpacing: 0,
          height: 1.4,
          color: textColor,
        ),
        
        // Title 3
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['title3']!,
          fontWeight: FontWeight.w500, // Medium
          letterSpacing: 0,
          height: 1.4,
          color: textColor,
        ),
        
        // Headline
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['headline']!,
          fontWeight: FontWeight.w600, // Semibold
          letterSpacing: 0,
          height: 1.4,
          color: textColor,
        ),
        
        // Body
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['body']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.5,
          color: textColor,
        ),
        
        // Callout
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['callout']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.5,
          color: textColor,
        ),
        
        // Subhead
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['subhead']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.5,
          color: secondaryTextColor,
        ),
        
        // Footnote
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['footnote']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.4,
          color: secondaryTextColor,
        ),
        
        // Caption 1
        labelMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['caption1']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.3,
          color: secondaryTextColor,
        ),
        
        // Caption 2
        labelSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: iosFontSizes['caption2']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.3,
          color: secondaryTextColor,
        ),
      );
    } else {
      // Android Material Design 3 Typography
      return TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['displayLarge']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: -0.25,
          height: 1.12,
          color: textColor,
        ),
        
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['displayMedium']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.16,
          color: textColor,
        ),
        
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['displaySmall']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.22,
          color: textColor,
        ),
        
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['headlineLarge']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.25,
          color: textColor,
        ),
        
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['headlineMedium']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.29,
          color: textColor,
        ),
        
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['headlineSmall']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0,
          height: 1.33,
          color: textColor,
        ),
        
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['titleLarge']!,
          fontWeight: FontWeight.w500, // Medium
          letterSpacing: 0,
          height: 1.27,
          color: textColor,
        ),
        
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['titleMedium']!,
          fontWeight: FontWeight.w500, // Medium
          letterSpacing: 0.15,
          height: 1.50,
          color: textColor,
        ),
        
        titleSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['titleSmall']!,
          fontWeight: FontWeight.w500, // Medium
          letterSpacing: 0.1,
          height: 1.43,
          color: textColor,
        ),
        
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['bodyLarge']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0.5,
          height: 1.50,
          color: textColor,
        ),
        
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['bodyMedium']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0.25,
          height: 1.43,
          color: textColor,
        ),
        
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['bodySmall']!,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: 0.4,
          height: 1.33,
          color: secondaryTextColor,
        ),
        
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['labelLarge']!,
          fontWeight: FontWeight.w500, // Medium
          letterSpacing: 0.1,
          height: 1.43,
          color: textColor,
        ),
        
        labelMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['labelMedium']!,
          fontWeight: FontWeight.w500, // Medium
          letterSpacing: 0.5,
          height: 1.33,
          color: secondaryTextColor,
        ),
        
        labelSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: androidFontSizes['labelSmall']!,
          fontWeight: FontWeight.w500, // Medium
          letterSpacing: 0.5,
          height: 1.45,
          color: secondaryTextColor,
        ),
      );
    }
  }

  /// Get platform-appropriate letter spacing for specific font size
  static double getLetterSpacing(double fontSize, {bool isIOS = false}) {
    if (isIOS) {
      // iOS typically uses tighter letter spacing
      if (fontSize >= 28) return -0.3;
      if (fontSize >= 20) return -0.1;
      return 0.0;
    } else {
      // Android Material Design letter spacing
      if (fontSize >= 28) return -0.25;
      if (fontSize >= 16) return 0.15;
      if (fontSize >= 14) return 0.25;
      if (fontSize >= 12) return 0.4;
      return 0.5;
    }
  }

  /// Get platform-appropriate line height
  static double getLineHeight(double fontSize, {bool isIOS = false}) {
    if (isIOS) {
      // iOS line heights (more compact)
      if (fontSize >= 28) return 1.2;
      if (fontSize >= 20) return 1.3;
      if (fontSize >= 16) return 1.4;
      return 1.5;
    } else {
      // Android line heights (more spacious)
      if (fontSize >= 28) return 1.25;
      if (fontSize >= 20) return 1.35;
      if (fontSize >= 16) return 1.45;
      return 1.55;
    }
  }
}