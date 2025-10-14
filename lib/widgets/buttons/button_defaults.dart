import 'package:flutter/material.dart';

/// iOS-specific button configuration
class IOSButtonDefaults {
  IOSButtonDefaults._();

  // Colors
  static const Color primaryButtonColor = Color(0xFF007AFF); // CupertinoColors.activeBlue
  static const Color primaryTextColor = Colors.white;
  static const Color primaryBorderColor = Colors.transparent;
  
  static const Color secondaryBorderColor = Color(0xFFD1D1D6);
  static const Color secondaryTextColor = Color(0xFF007AFF); // iOS blue
  
  // Disabled states
  static const Color disabledButtonColor = Color(0xFFB0B0B0);
  static const Color disabledTextColor = Color(0xFFC7C7CC);
  static const Color disabledBorderColor = Colors.transparent;

  // Dimensions
  static const double height = 48.0;
  static const double borderRadius = 12.0;
  static const double iconSpacing = 8.0;
  static const double horizontalPadding = 28.0;
  static const double verticalPadding = 10.0;
  static const double fontSize = 17.0;
  
  // Ghost button specific dimensions
  static const double ghostHeight = 44.0;
  static const double ghostBorderRadius = 12.0;
  static const double ghostIconSpacing = 8.0;
  static const double ghostHorizontalPadding = 20.0;
  static const double ghostVerticalPadding = 6.0;
  static const double ghostFontSize = 15.0;

  /// Get secondary button color based on theme
  static Color getSecondaryButtonColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor.withAlpha(200);
  }
}

/// Android-specific button configuration
class AndroidButtonDefaults {
  AndroidButtonDefaults._();

  // Colors
  static const Color primaryTextColor = Colors.white;
  static const Color primaryBorderColor = Colors.transparent;
  
  // Disabled states
  static const Color disabledButtonColor = Color(0xFFBDBDBD);
  static const Color disabledTextColor = Color(0xFFEEEEEE);
  static const Color disabledBorderColor = Colors.transparent;

  // Dimensions
  static const double height = 48.0;
  static const double borderRadius = 12.0;
  static const double iconSpacing = 8.0;
  static const double horizontalPadding = 20.0;
  static const double verticalPadding = 12.0;
  static const double fontSize = 16.0;
  
  // Ghost button specific dimensions
  static const double ghostHeight = 40.0;
  static const double ghostBorderRadius = 4.0;
  static const double ghostIconSpacing = 8.0;
  static const double ghostHorizontalPadding = 16.0;
  static const double ghostVerticalPadding = 6.0;
  static const double ghostFontSize = 14.0;

  /// Get primary button color based on theme
  static Color getPrimaryButtonColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  /// Get disabled button color based on theme
  static Color getDisabledButtonColor(BuildContext context) {
    return Theme.of(context).colorScheme.outline.withAlpha(100);
  }

  /// Get secondary button color based on theme
  static Color getSecondaryButtonColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor.withAlpha(200);
  }

  /// Get secondary text/border color based on theme
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }
}

/// Centralized configuration for button defaults across iOS and Android platforms
class ButtonDefaults {
  ButtonDefaults._(); // Private constructor to prevent instantiation

  // Common dimensions
  static const double defaultBorderWidth = 1.2;

  /// Helper methods for platform detection and value selection
  static bool isIOS(BuildContext context) {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }

  /// Get splash color based on button background color and platform
  static Color getSplashColor(Color buttonColor, bool isIOS) {
    return buttonColor.a < 1.0 
        ? (isIOS ? Colors.white.withAlpha(38) : Colors.white.withAlpha(38))
        : (isIOS ? Colors.white.withAlpha(64) : Colors.white.withAlpha(46));
  }

  /// Get platform-specific value
  static T getPlatformValue<T>(BuildContext context, T iosValue, T androidValue) {
    return isIOS(context) ? iosValue : androidValue;
  }
  
  /// Get ghost button color based on theme and enabled state
  static Color getGhostColor(BuildContext context, bool enabled, {Color? customColor}) {
    if (customColor != null) return customColor;
    return Theme.of(context).colorScheme.primary.withAlpha(enabled ? 200 : 100);
  }
  
  /// Get ghost button splash color based on theme
  static Color getGhostSplashColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary.withAlpha(30);
  }
  
  /// Get secondary button splash color based on theme and background
  static Color getSecondarySplashColor(BuildContext context) {
    // Use a subtle splash effect that works well with transparent/light backgrounds
    return Theme.of(context).colorScheme.primary.withAlpha(25);
  }
}