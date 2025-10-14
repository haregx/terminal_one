import 'package:flutter/material.dart';
import 'button_defaults.dart';

/// A minimalistic ghost button with transparent background and no border.
/// 
/// This button provides a subtle interactive element with only text and optional icons,
/// following platform-specific design guidelines for iOS and Android.
/// 
/// Features:
/// - Transparent background with no border
/// - Platform-specific styling (iOS/Android)
/// - Configurable text, icons, and spacing
/// - Theme-aware colors with automatic disabled states
/// - Ripple effects for user feedback
/// - Enhanced accessibility support
/// - Customizable text styling and minimum touch targets
/// 
/// Example usage:
/// ```dart
/// GhostButton(
///   label: 'Skip',
///   leading: Icons.arrow_back,
///   onPressed: () => Navigator.pop(context),
/// )
/// ```
class GhostButton extends StatelessWidget {
  /// The text displayed on the button
  final String label;
  
  /// Button height. If null, uses platform-specific defaults
  final double? height;
  
  /// Text and icon color. If null, uses theme primary color with alpha
  final Color? textColor;
  
  /// Button border radius. If null, uses platform-specific defaults
  final double? borderRadius;
  
  /// Optional leading icon displayed before the text
  final IconData? leading;
  
  /// Optional trailing icon displayed after the text
  final IconData? trailing;
  
  /// Spacing between icon and text. If null, uses platform-specific defaults
  final double? iconSpacing;
  
  /// Horizontal padding inside the button. If null, uses platform-specific defaults
  final double? horizontalPadding;
  
  /// Vertical padding inside the button. If null, uses platform-specific defaults
  final double? verticalPadding;
  
  /// Font size for the button text. If null, uses platform-specific defaults
  final double? fontSize;
  
  /// Callback function executed when button is pressed
  final VoidCallback? onPressed;
  
  /// Whether the button is enabled and can be pressed
  final bool enabled;
  
  /// Custom text style for the button text. If provided, takes precedence over fontSize
  final TextStyle? textStyle;
  
  /// Minimum size for touch targets (accessibility)
  final Size? minimumSize;

  /// Creates a ghost button with transparent background and customizable styling.
  /// 
  /// The [label] parameter is required and defines the button text.
  /// All styling parameters are optional and will fall back to platform-appropriate defaults.
  /// 
  /// Set [enabled] to false to disable the button and show disabled styling.
  const GhostButton({
    super.key,
    required this.label,
    this.height,
    this.textColor,
    this.borderRadius,
    this.leading,
    this.trailing,
    this.iconSpacing,
    this.horizontalPadding,
    this.verticalPadding,
    this.fontSize,
    this.onPressed,
    this.enabled = true,
    this.textStyle,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    // === DIMENSION CALCULATIONS ===
    // Calculate effective button height using platform-specific defaults from ButtonDefaults
    // Falls back to iOS/Android ghost-specific heights if no custom height is provided
    final double effectiveHeight = height ?? ButtonDefaults.getPlatformValue(
      context,
      IOSButtonDefaults.ghostHeight,
      AndroidButtonDefaults.ghostHeight,
    );
    
    // Calculate border radius for rounded corners using platform-specific defaults
    // Ghost buttons typically use smaller radius values for subtle appearance
    final double effectiveBorderRadius = borderRadius ?? ButtonDefaults.getPlatformValue(
      context,
      IOSButtonDefaults.ghostBorderRadius,
      AndroidButtonDefaults.ghostBorderRadius,
    );
    
    // Calculate spacing between icons and text using platform-specific defaults
    // Different platforms may prefer different spacing for visual balance
    final double effectiveIconSpacing = iconSpacing ?? ButtonDefaults.getPlatformValue(
      context,
      IOSButtonDefaults.ghostIconSpacing,
      AndroidButtonDefaults.ghostIconSpacing,
    );
    
    // Calculate horizontal padding inside button using platform-specific defaults
    // Ghost buttons often use minimal padding to maintain lightweight appearance
    final double effectiveHorizontalPadding = horizontalPadding ?? ButtonDefaults.getPlatformValue(
      context,
      IOSButtonDefaults.ghostHorizontalPadding,
      AndroidButtonDefaults.ghostHorizontalPadding,
    );
    
    // Calculate vertical padding inside button using platform-specific defaults
    // Affects button height and text positioning within the button area
    final double effectiveVerticalPadding = verticalPadding ?? ButtonDefaults.getPlatformValue(
      context,
      IOSButtonDefaults.ghostVerticalPadding,
      AndroidButtonDefaults.ghostVerticalPadding,
    );
    
    // Calculate font size for button text using platform-specific defaults
    // Ghost buttons may use smaller fonts to emphasize their subtle nature
    final double effectiveFontSize = fontSize ?? ButtonDefaults.getPlatformValue(
      context,
      IOSButtonDefaults.ghostFontSize,
      AndroidButtonDefaults.ghostFontSize,
    );

    // === COLOR AND STYLING CALCULATIONS ===
    // Generate ghost button color using centralized color methods with proper alpha transparency
    // Automatically handles enabled/disabled states and applies custom color if provided
    // Ghost buttons use transparent background with only text/icon coloring
    final Color ghostColor = ButtonDefaults.getGhostColor(context, enabled, customColor: textColor);
    
    // Create enhanced text styling with custom style support and fallback defaults
    // Combines custom textStyle with calculated ghostColor, or creates new style with:
    // - Semi-bold font weight for better readability against transparent background
    // - Slight letter spacing for cleaner appearance and improved legibility
    // - Platform-appropriate font size for consistent user experience
    final TextStyle effectiveTextStyle = textStyle?.copyWith(color: ghostColor) ?? TextStyle(
      color: ghostColor,
      fontSize: effectiveFontSize,
      fontWeight: FontWeight.w600, // Semi-bold for better readability
      letterSpacing: 0.2, // Slight letter spacing for cleaner appearance
    );
    
    // === ACCESSIBILITY COMPLIANCE ===
    // Ensure minimum touch target size for accessibility compliance (WCAG 2.1 Guidelines)
    // Default 48x48dp meets mobile accessibility standards for touch targets
    // Prevents buttons from being too small to interact with reliably
    final Size effectiveMinimumSize = minimumSize ?? const Size(48.0, 48.0);

    // Generate platform-appropriate splash color for touch feedback during user interaction
    // Provides visual feedback when button is pressed, enhancing user experience
    // Uses theme-aware colors that work well with ghost button's transparent design
    final Color splashColor = ButtonDefaults.getGhostSplashColor(context);

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
        // Transparent background maintains ghost button's minimalistic appearance
        // while providing Material Design foundation for ripple effects
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: InkWell(
          // InkWell provides touch feedback and handles tap interactions
          // Border radius matches container for consistent visual appearance
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          splashColor: splashColor, // Theme-aware splash color for press feedback
          highlightColor: Colors.transparent, // Keep highlight transparent for ghost style
          onTap: enabled ? onPressed : null, // Conditional callback based on enabled state
          child: Container(
            // Main button container with all size and styling constraints
            height: effectiveHeight,
            constraints: BoxConstraints(
              // Enforce minimum touch target sizes for accessibility
              minWidth: effectiveMinimumSize.width,
              minHeight: effectiveMinimumSize.height,
            ),
            padding: EdgeInsets.symmetric(
              // Apply calculated platform-specific padding for optimal content spacing
              horizontal: effectiveHorizontalPadding,
              vertical: effectiveVerticalPadding,
            ),
            decoration: BoxDecoration(
              // Transparent decoration maintains ghost button aesthetic
              // Border radius ensures consistent rounded corners throughout widget tree
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
            child: Row(
              // === CONTENT LAYOUT CONFIGURATION ===
              // Row layout with minimal width and centered alignment for clean appearance
              mainAxisSize: MainAxisSize.min, // Only take required space, don't expand
              mainAxisAlignment: MainAxisAlignment.center, // Center all content horizontally
              children: [
                // === LEADING ICON SECTION ===
                // Conditionally render leading icon if provided by user
                // Uses spread operator (...[]) for conditional widget inclusion
                if (leading != null) ...[
                  Transform.translate(
                    // Subtle vertical offset (1px down) for better visual alignment with text
                    // Compensates for icon baseline differences and improves perceived alignment
                    offset: const Offset(0, 1),
                    child: Icon(
                      leading,
                      color: ghostColor, // Match icon color to calculated ghost text color
                      size: effectiveFontSize + 3, // Icon slightly larger than text for better prominence
                    ),
                  ),
                  SizedBox(width: effectiveIconSpacing), // Platform-specific spacing after leading icon
                ],
                // === BUTTON TEXT SECTION ===
                // Main button label with calculated styling and theming
                Text(
                  label,
                  style: effectiveTextStyle, // Applied calculated text style with all customizations
                ),
                // === TRAILING ICON SECTION ===
                // Conditionally render trailing icon if provided by user
                // Mirrors leading icon implementation for consistent appearance
                if (trailing != null) ...[
                  SizedBox(width: effectiveIconSpacing), // Platform-specific spacing before trailing icon
                  Transform.translate(
                    // Same vertical alignment adjustment as leading icon for consistency
                    offset: const Offset(0, 1),
                    child: Icon(
                      trailing,
                      color: ghostColor, // Consistent color matching with leading icon and text
                      size: effectiveFontSize + 3, // Consistent sizing with leading icon
                    ),
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