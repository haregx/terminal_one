import 'package:flutter/material.dart';
import 'button_defaults.dart';

/// A customizable primary button widget that adapts to platform-specific design guidelines.
/// 
/// This button automatically switches between iOS and Android styling based on the current platform,
/// providing a native look and feel. It supports leading/trailing icons, disabled states,
/// and extensive customization options while maintaining Material Design ripple effects.
/// 
/// Example usage:
/// ```dart
/// PrimaryButton(
///   label: 'Save Changes',
///   leading: Icons.save,
///   enabled: true,
///   onPressed: () => print('Button pressed'),
/// )
/// ```
class PrimaryButton extends StatelessWidget {
  /// The text displayed on the button
  final String label;
  
  /// Custom height for the button. If null, uses platform-specific default (48dp)
  final double? height;
  
  /// Custom background color for the button. If null, uses platform-specific primary color
  final Color? buttonColor;
  
  /// Custom border color for the button. If null, uses platform-specific default (transparent)
  final Color? borderColor;
  
  /// Custom text color for the button. If null, uses platform-specific default (white)
  final Color? textColor;
  
  /// Custom border radius for rounded corners. If null, uses platform-specific default (12dp)
  final double? borderRadius;
  
  /// Icon displayed before the label text
  final IconData? leading;
  
  /// Icon displayed after the label text
  final IconData? trailing;
  
  /// Spacing between icons and text. If null, uses platform-specific default (8dp)
  final double? iconSpacing;
  
  /// Callback function executed when the button is pressed. Can be null for disabled state
  final VoidCallback? onPressed;
  
  /// Whether the button is enabled or disabled
  final bool enabled;
  
  /// Custom background color when button is disabled. If null, uses platform-specific disabled color
  final Color? disabledButtonColor;
  
  /// Custom text color when button is disabled. If null, uses platform-specific disabled text color
  final Color? disabledTextColor;
  
  /// Custom border color when button is disabled. If null, uses platform-specific disabled border color
  final Color? disabledBorderColor;

  /// Creates a primary button with platform-adaptive styling.
  /// 
  /// The [label] and [enabled] parameters are required.
  /// All other parameters are optional and will use platform-specific defaults if not provided.
  const PrimaryButton({
    super.key,
    required this.label,
    this.height,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.borderRadius,
    this.leading,
    this.trailing,
    this.iconSpacing,
    this.onPressed,
    this.enabled = true,
    this.disabledButtonColor,
    this.disabledTextColor,
    this.disabledBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    // === PLATFORM DETECTION ===
    // Determine if this is an iOS or Android platform for adaptive styling
    // This enables platform-specific defaults and design patterns
    final bool isIOS = ButtonDefaults.isIOS(context);

    // === DIMENSION CALCULATIONS ===
    // Calculate effective button dimensions using platform-specific defaults from ButtonDefaults
    // Falls back to iOS/Android specific values if no custom dimensions are provided
    final double height = this.height ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.height, AndroidButtonDefaults.height);
    
    // Calculate border radius for rounded corners using platform-specific defaults
    // Primary buttons typically use consistent radius values across the app
    final double borderRadius = this.borderRadius ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.borderRadius, AndroidButtonDefaults.borderRadius);
    
    // Calculate horizontal padding inside button using platform-specific defaults
    // Affects button width and content spacing for optimal touch targets
    final double horizontalPadding = ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.horizontalPadding, AndroidButtonDefaults.horizontalPadding);
    
    // Calculate spacing between icons and text using platform-specific defaults
    // Different platforms may prefer different spacing for visual balance
    final double iconSpacing = this.iconSpacing ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.iconSpacing, AndroidButtonDefaults.iconSpacing);

    // === COLOR AND STYLING CALCULATIONS ===
    // Calculate effective button background color based on enabled state and platform defaults
    // Enabled: Uses custom color or platform-specific primary color with theme integration
    // Disabled: Uses custom disabled color or platform-specific disabled color with reduced opacity
    final Color buttonColor = enabled 
        ? (this.buttonColor ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.primaryButtonColor, AndroidButtonDefaults.getPrimaryButtonColor(context)))
        : (disabledButtonColor ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.disabledButtonColor, AndroidButtonDefaults.getDisabledButtonColor(context)));
    
    // Calculate effective text and icon color based on enabled state and platform defaults
    // Maintains high contrast ratio for accessibility and readability
    // Automatically adapts to light/dark themes through platform-specific color methods
    final Color textColor = enabled 
        ? (this.textColor ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.primaryTextColor, AndroidButtonDefaults.primaryTextColor))
        : (disabledTextColor ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.disabledTextColor, AndroidButtonDefaults.disabledTextColor));
    
    // Calculate effective border color based on enabled state and platform defaults
    // Primary buttons typically have transparent borders but support customization
    // Disabled state uses muted border colors for visual consistency
    final Color borderColor = enabled 
        ? (this.borderColor ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.primaryBorderColor, AndroidButtonDefaults.primaryBorderColor))
        : (disabledBorderColor ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.disabledBorderColor, AndroidButtonDefaults.disabledBorderColor));

    // === TYPOGRAPHY AND INTERACTION SETUP ===
    // Calculate font size for button text using platform-specific defaults
    // Ensures consistent typography that feels native to each platform
    final double fontSize = ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.fontSize, AndroidButtonDefaults.fontSize);

    // Generate platform-appropriate splash/ripple color for touch feedback during user interaction
    // Provides visual feedback when button is pressed, enhancing user experience
    // Color calculation considers button background for optimal contrast and visibility
    final Color splashColor = ButtonDefaults.getSplashColor(buttonColor, isIOS);

    // === WIDGET COMPOSITION AND ACCESSIBILITY ===
    // Wrap entire button in Semantics widget for screen reader and accessibility support
    // Provides essential information for assistive technologies:
    // - button: true = identifies this as an interactive button element
    // - enabled: reflects current button state for proper user feedback
    // - label: provides text content for screen readers
    // - hint: gives context-aware usage instructions based on button state
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      hint: enabled ? 'Tap to activate' : 'Button is disabled',
      child: Material(
        // Material provides the base layer for elevation and Material Design effects
        // Background color is applied here to work with InkWell ripple effects
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          // InkWell provides Material Design touch feedback (ripple effect)
          // Creates consistent interaction patterns across all button types
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: splashColor, // Theme-aware splash color for press feedback
          highlightColor: Colors.transparent, // No persistent highlight color for clean appearance
          onTap: enabled ? onPressed : null, // Conditional callback based on enabled state
          child: Container(
            // Main button container with all size and styling constraints
            height: height,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            decoration: BoxDecoration(
              // Border radius for consistent rounded corners throughout widget tree
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                // Border styling for primary buttons (typically transparent)
                // Supports customization for outlined primary button variants
                color: borderColor,
                width: ButtonDefaults.defaultBorderWidth,
              ),
            ),
            child: Row(
              // === CONTENT LAYOUT CONFIGURATION ===
              // Row layout optimized for primary button content arrangement
              mainAxisSize: MainAxisSize.min, // Button only takes necessary width for flexible layouts
              mainAxisAlignment: MainAxisAlignment.center, // Center all content horizontally
              children: [
                // === LEADING ICON SECTION ===
                // Conditionally render leading icon if provided by user
                // Uses spread operator (...[]) for conditional widget inclusion
                if (leading != null) ...[
                  Icon(
                    leading,
                    // Dynamic color based on enabled state for better accessibility
                    // Disabled state reduces opacity while maintaining color harmony
                    color: enabled ? textColor : textColor.withAlpha(128),
                    size: fontSize + 3, // Icon slightly larger than text for better visual balance
                  ),
                  SizedBox(width: iconSpacing), // Platform-specific spacing after leading icon
                ],
                
                // === BUTTON TEXT SECTION ===
                // Main button label with calculated styling and theming
                Text(
                  label,
                  style: TextStyle(
                    // Text color matches icon color for consistency
                    // Opacity reduction in disabled state maintains visual hierarchy
                    color: enabled ? textColor : textColor.withAlpha(128),
                    fontSize: fontSize, // Platform-specific font size for native feel
                    fontWeight: FontWeight.w600, // Semi-bold for better readability and prominence
                    letterSpacing: 0.2, // Slight letter spacing for cleaner appearance and legibility
                  ),
                ),
                
                // === TRAILING ICON SECTION ===
                // Conditionally render trailing icon if provided by user
                // Mirrors leading icon implementation for consistent appearance
                if (trailing != null) ...[
                  SizedBox(width: iconSpacing), // Platform-specific spacing before trailing icon
                  Icon(
                    trailing,
                    // Consistent color matching with leading icon and text
                    color: enabled ? textColor : textColor.withAlpha(128),
                    size: fontSize + 3, // Consistent sizing with leading icon for visual balance
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}