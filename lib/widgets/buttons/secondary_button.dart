import 'package:flutter/material.dart';
import 'button_defaults.dart';

/// A customizable secondary button widget that adapts to platform-specific design guidelines.
/// 
/// This button provides a more subtle alternative to the primary button, typically featuring
/// a transparent or light background with colored text and border. It automatically switches
/// between iOS and Android styling based on the current platform while maintaining a
/// lightweight touch interaction without Material Design ripple effects.
/// 
/// Key differences from PrimaryButton:
/// - Uses GestureDetector instead of Material/InkWell (no ripple effect)
/// - Typically has transparent/light background with colored border
/// - Supports both horizontal and vertical padding customization
/// - More suitable for secondary actions or outline-style buttons
/// 
/// Example usage:
/// ```dart
/// SecondaryButton(
///   label: 'Cancel',
///   leading: Icons.close,
///   enabled: true,
///   onPressed: () => Navigator.of(context).pop(),
/// )
/// ```
class SecondaryButton extends StatelessWidget {
  /// The text displayed on the button
  final String label;
  
  /// Custom height for the button. If null, uses platform-specific default (48dp)
  final double? height;
  
  /// Custom background color for the button. If null, uses platform-specific secondary color (typically transparent/light)
  final Color? buttonColor;
  
  /// Custom border color for the button. If null, uses platform-specific accent color
  final Color? borderColor;
  
  /// Custom text color for the button. If null, uses platform-specific accent color
  final Color? textColor;
  
  /// Custom border radius for rounded corners. If null, uses platform-specific default (12dp)
  final double? borderRadius;
  
  /// Icon displayed before the label text
  final IconData? leading;
  
  /// Icon displayed after the label text
  final IconData? trailing;
  
  /// Spacing between icons and text. If null, uses platform-specific default (8dp)
  final double? iconSpacing;
  
  /// Custom horizontal padding inside the button. If null, uses platform-specific default
  final double? horizontalPadding;
  
  /// Custom vertical padding inside the button. If null, uses platform-specific default
  final double? verticalPadding;
  
  /// Callback function executed when the button is pressed. Can be null for disabled state
  final VoidCallback? onPressed;
  
  /// Whether the button is enabled or disabled. Defaults to true
  final bool enabled;

  /// Creates a secondary button with platform-adaptive styling.
  /// 
  /// The [label] parameter is required. The [enabled] parameter defaults to true.
  /// All other parameters are optional and will use platform-specific defaults if not provided.
  /// 
  /// Unlike the primary button, this button supports customizable vertical padding,
  /// making it suitable for different content layouts and spacing requirements.
  const SecondaryButton({
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
    this.horizontalPadding,
    this.verticalPadding,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    // Detect current platform for adaptive styling (iOS/macOS vs Android/other)
    final bool isIOS = ButtonDefaults.isIOS(context);

    // === STYLE CONFIGURATION ===
    // Resolve all styling properties, using custom values if provided, otherwise platform defaults
    
    /// Button height - uses platform-specific default if not customized
    /// Different platforms may have different preferred button heights for optimal UX
    final double height = this.height ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.height, AndroidButtonDefaults.height);
    
    /// Background color - typically transparent or light for secondary buttons
    /// Uses theme-aware colors that adapt to light/dark mode automatically
    /// Secondary buttons often use subtle background colors to differentiate from primary actions
    final Color buttonColor = this.buttonColor ?? (isIOS ? IOSButtonDefaults.getSecondaryButtonColor(context) : AndroidButtonDefaults.getSecondaryButtonColor(context));
    
    /// Border color - uses platform accent colors for visual distinction
    /// The border is the primary visual element that defines secondary button appearance
    final Color borderColor = this.borderColor ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.secondaryBorderColor, AndroidButtonDefaults.getSecondaryTextColor(context));
    
    /// Text and icon color - matches platform accent color for consistency
    /// Ensures text remains readable and follows platform design guidelines
    final Color textColor = this.textColor ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.secondaryTextColor, AndroidButtonDefaults.getSecondaryTextColor(context));
    
    /// Corner radius for rounded appearance
    /// Platform-specific values ensure buttons feel native to each platform
    final double borderRadius = this.borderRadius ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.borderRadius, AndroidButtonDefaults.borderRadius);
    
    /// Spacing between icons and text
    /// Proper spacing ensures visual balance and readability
    final double iconSpacing = this.iconSpacing ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.iconSpacing, AndroidButtonDefaults.iconSpacing);
    
    /// Horizontal padding inside the button - affects button width
    /// Controls the internal spacing and overall button width
    final double horizontalPadding = this.horizontalPadding ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.horizontalPadding, AndroidButtonDefaults.horizontalPadding);
    
    /// Vertical padding inside the button - affects button height beyond base height
    /// Allows fine-tuning of button height and content positioning
    final double verticalPadding = this.verticalPadding ?? ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.verticalPadding, AndroidButtonDefaults.verticalPadding);
    
    /// Font size for the button text
    /// Platform-specific sizing ensures optimal readability and platform consistency
    final double fontSize = ButtonDefaults.getPlatformValue(context, IOSButtonDefaults.fontSize, AndroidButtonDefaults.fontSize);

    // Generate platform-appropriate splash color for touch feedback during user interaction
    // Provides visual feedback when button is pressed, enhancing user experience
    // Uses subtle colors that work well with secondary button's outlined design
    final Color splashColor = ButtonDefaults.getSecondarySplashColor(context);

    // === WIDGET COMPOSITION AND ACCESSIBILITY ===
    // Material + InkWell provides Material Design ripple effects and consistent UX
    // This creates consistent interaction patterns with PrimaryButton and GhostButton
    // Ensures all buttons in the app follow the same interaction paradigm
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      hint: enabled ? 'Tap to activate' : 'Button is disabled',
      child: Material(
        // Background color for secondary buttons (typically transparent/light)
        // Material widget provides foundation for ripple effects and accessibility
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          // InkWell handles touch interactions and provides visual feedback
          // Border radius matches container for consistent visual appearance
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: splashColor, // Theme-aware splash color for press feedback
          highlightColor: Colors.transparent, // Keep highlight subtle for secondary style
          onTap: enabled ? onPressed : null, // Conditional callback based on enabled state
          child: Container(
            // Main button container with all size and styling constraints
            height: height,
            // Symmetric padding allows for different horizontal/vertical spacing
            // This flexibility is important for secondary buttons in various layouts
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            decoration: BoxDecoration(
              // Border radius for consistent rounded corners throughout widget tree
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                // Prominent border is the defining characteristic of secondary buttons
                // Provides clear visual distinction from primary buttons
                color: borderColor,
                width: ButtonDefaults.defaultBorderWidth,
              ),
            ),
            child: Row(
              // === CONTENT LAYOUT CONFIGURATION ===
              // Row layout optimized for secondary button content arrangement
              mainAxisSize: MainAxisSize.min, // Button only takes necessary width - important for secondary buttons
              mainAxisAlignment: MainAxisAlignment.center, // Center all content horizontally
              children: [
                // === LEADING ICON SECTION ===
                // Conditionally render leading icon if provided by user
                // Uses spread operator (...[]) for conditional widget inclusion
                if (leading != null) ...[
                  Icon(
                    leading,
                    // Dynamic color based on enabled state for better accessibility
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
                  // Dynamic color ensures proper contrast and accessibility
                  color: enabled ? textColor : textColor.withAlpha(128),
                  fontSize: fontSize, // Platform-specific font size
                  fontWeight: FontWeight.w600, // Semi-bold for better readability against border
                  letterSpacing: 0.2, // Slight letter spacing for cleaner appearance
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