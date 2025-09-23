import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/platform_utils.dart';

/// Shared constants, utilities and styling for all input components
/// 
/// This file centralizes common patterns used across InputEmail, InputPassword,
/// and InputCodeGroup to reduce code duplication and ensure consistency.
class InputDefaults {
  InputDefaults._(); // Private constructor to prevent instantiation

  // ==================== DIMENSIONS ====================
  
  /// Standard icon sizes for input fields
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 18.0;
  static const double iconSizeLarge = 20.0;
  
  /// Platform-specific border radius values
  static const double borderRadiusIOS = 12.0;
  static const double borderRadiusAndroid = 8.0;
  
  /// Standard border width values
  static const double borderWidthDefault = 1.0;
  static const double borderWidthFocused = 2.0;
  
  /// Input field spacing
  static const EdgeInsets verticalPadding = EdgeInsets.symmetric(vertical: 8.0);
  
  // ==================== ALPHA VALUES ====================
  
  /// Commonly used alpha values for modern withAlpha() calls
  static const int alphaDisabled = 153;     // 0.6 * 255 (60%)
  static const int alphaSubtle = 128;       // 0.5 * 255 (50%)
  static const int alphaLight = 77;         // 0.3 * 255 (30%)
  static const int alphaVeryLight = 51;     // 0.2 * 255 (20%)
  static const int alphaMedium = 179;       // 0.7 * 255 (70%)
  
  // ==================== TEXT INPUT LIMITS ====================
  
  /// Standard length limits for different input types
  static const int emailMaxLength = 254;
  static const int passwordMaxLength = 128;
  static const int codeDigitMaxLength = 1;
  
  // ==================== UTILITY METHODS ====================
  
  /// Get platform-appropriate border radius
  static double getBorderRadius(BuildContext context) {
    return PlatformUtils.isIOSContext(context) 
        ? borderRadiusIOS 
        : borderRadiusAndroid;
  }
  
  /// Get platform-appropriate content padding
  static EdgeInsets getContentPadding(BuildContext context) {
    final isIOS = PlatformUtils.isIOSContext(context);
    return EdgeInsets.symmetric(
      horizontal: isIOS ? 16.0 : 12.0,
      vertical: isIOS ? 16.0 : 14.0,
    );
  }
  
  /// Calculate responsive input width based on screen constraints
  static double getInputWidth(BuildContext context, {double maxWidth = 360.0}) {
    final screenWidth = MediaQuery.of(context).size.width;
    double inputWidth = screenWidth * 0.9; // Use 90% of screen width by default
    
    // Limit maximum width for larger screens
    if (screenWidth > maxWidth + 100) {
      inputWidth = maxWidth + 60; // Slightly wider than max
    }
    
    return inputWidth;
  }
  
  // ==================== INPUT FORMATTERS ====================
  
  /// Standard email input formatter
  static List<TextInputFormatter> get emailFormatters => [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._+-]')),
    LengthLimitingTextInputFormatter(emailMaxLength),
  ];
  
  /// Standard password input formatter
  static List<TextInputFormatter> get passwordFormatters => [
    LengthLimitingTextInputFormatter(passwordMaxLength),
  ];
  
  /// Single digit code formatter
  static List<TextInputFormatter> get codeDigitFormatters => [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(codeDigitMaxLength),
  ];
  
  // ==================== BACKGROUND COLORS ====================
  
  /// Get background color for input fields based on theme
  /// This provides a subtle background that works with both light and dark themes
  static Color getInputBackgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    
    // Same logic as CodeGroup for consistency
    return brightness == Brightness.dark
        ? colorScheme.surface.withAlpha(153)  // 60% opacity in dark mode
        : colorScheme.surface.withAlpha(230); // 90% opacity in light mode
  }
  
  // ==================== BORDER STYLING ====================
  
  /// Create platform-appropriate input border
  static OutlineInputBorder createBorder(
    BuildContext context, {
    required Color color,
    double? width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(getBorderRadius(context)),
      borderSide: BorderSide(
        color: color,
        width: width ?? borderWidthDefault,
      ),
    );
  }
  
  /// Get standard enabled border
  static OutlineInputBorder getEnabledBorder(BuildContext context) {
    final theme = Theme.of(context);
    return createBorder(
      context,
      color: theme.colorScheme.outline.withAlpha(alphaSubtle),
    );
  }
  
  /// Get standard focused border
  static OutlineInputBorder getFocusedBorder(BuildContext context) {
    final theme = Theme.of(context);
    return createBorder(
      context,
      color: theme.colorScheme.primary,
      width: borderWidthFocused,
    );
  }
  
  /// Get standard error border
  static OutlineInputBorder getErrorBorder(BuildContext context) {
    final theme = Theme.of(context);
    return createBorder(
      context,
      color: theme.colorScheme.error,
    );
  }
  
  /// Get standard focused error border
  static OutlineInputBorder getFocusedErrorBorder(BuildContext context) {
    final theme = Theme.of(context);
    return createBorder(
      context,
      color: theme.colorScheme.error,
      width: borderWidthFocused,
    );
  }
  
  // ==================== ICON STYLING ====================
  
  /// Get icon color based on validation state
  static Color getIconColor(
    BuildContext context, {
    required bool isValid,
    required bool hasContent,
  }) {
    final theme = Theme.of(context);
    return isValid && hasContent
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withAlpha(alphaDisabled);
  }
  
  /// Create a clear button for input fields
  static Widget createClearButton(
    BuildContext context, {
    required VoidCallback onPressed,
    required bool isVisible,
  }) {
    if (!isVisible) return const SizedBox.shrink();
    
    return IconButton(
      icon: Icon(
        LucideIcons.x,
        size: iconSizeMedium,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(alphaDisabled),
      ),
      onPressed: onPressed,
      tooltip: 'Clear input',
      splashRadius: iconSizeMedium,
    );
  }
  
  // ==================== VALIDATION PATTERNS ====================
  
  /// Enhanced email validation regex
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  
  /// Validate email format
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    return emailRegex.hasMatch(email.trim());
  }
  
  // ==================== FOCUS MANAGEMENT ====================
  
  /// Setup focus listener with common patterns
  static void setupFocusListener(
    FocusNode focusNode,
    VoidCallback onFocusGained,
    VoidCallback? onFocusLost,
  ) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        onFocusGained();
      } else if (onFocusLost != null) {
        onFocusLost();
      }
    });
  }
  
  // ==================== SEMANTIC HELPERS ====================
  
  /// Create semantic wrapper for input fields
  static Widget wrapWithSemantics({
    required Widget child,
    required String label,
    required String hint,
    bool isTextField = true,
    bool isObscured = false,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      textField: isTextField,
      obscured: isObscured,
      child: child,
    );
  }
}

/// Shared validation requirements for password fields
class PasswordRequirement {
  final String Function(BuildContext) getLabel;
  final bool Function(String) validate;
  final String identifier;

  const PasswordRequirement({
    required this.getLabel,
    required this.validate,
    required this.identifier,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordRequirement && identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}

/// Standard password validation requirements
class PasswordRequirements {
  PasswordRequirements._();
  
  // Static instances to ensure same objects are used for comparison
  static final PasswordRequirement _minLength = PasswordRequirement(
    identifier: 'minLength',
    getLabel: (context) => AppLocalizations.of(context)!.passwordMinLength,
    validate: (password) => password.length >= 8,
  );
  
  static final PasswordRequirement _hasNumber = PasswordRequirement(
    identifier: 'hasNumber',
    getLabel: (context) => AppLocalizations.of(context)!.passwordNeedNumber,
    validate: (password) => RegExp(r'[0-9]').hasMatch(password),
  );
  
  static final PasswordRequirement _hasUppercase = PasswordRequirement(
    identifier: 'hasUppercase',
    getLabel: (context) => AppLocalizations.of(context)!.passwordNeedUppercase,
    validate: (password) => RegExp(r'[A-Z]').hasMatch(password),
  );
  
  static final PasswordRequirement _hasLowercase = PasswordRequirement(
    identifier: 'hasLowercase',
    getLabel: (context) => AppLocalizations.of(context)!.passwordNeedLowercase,
    validate: (password) => RegExp(r'[a-z]').hasMatch(password),
  );
  
  static final PasswordRequirement _hasSpecialChar = PasswordRequirement(
    identifier: 'hasSpecialChar',
    getLabel: (context) => 'Mindestens ein Sonderzeichen', // Not localized yet
    validate: (password) => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password),
  );

  static PasswordRequirement minLength({int length = 8}) => _minLength;
  static PasswordRequirement hasNumber() => _hasNumber;
  static PasswordRequirement hasUppercase() => _hasUppercase;
  static PasswordRequirement hasLowercase() => _hasLowercase;
  static PasswordRequirement hasSpecialChar() => _hasSpecialChar;
  
  /// Get default password requirements
  static List<PasswordRequirement> get defaultRequirements => [
    _minLength,
    _hasNumber,
    _hasUppercase,
    _hasLowercase,
  ];
}