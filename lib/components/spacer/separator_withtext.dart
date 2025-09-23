import 'package:flutter/material.dart';

/// A customizable separator widget that displays a horizontal divider line with centered text.
/// 
/// This widget creates a visual separator commonly used in forms, settings screens, or content sections
/// to group related elements. The separator consists of two horizontal lines with centered text between them,
/// providing both visual separation and contextual labeling.
/// 
/// The component automatically adapts to the current theme for colors and typography,
/// while allowing customization of appearance and spacing.
/// 
/// Example usage:
/// ```dart
/// SeparatorWithText(
///   text: 'OR',
///   lineColor: Colors.grey.shade300,
///   spacing: 20.0,
/// )
/// 
/// // Theme-aware separator
/// SeparatorWithText(
///   text: 'Settings',
///   textStyle: Theme.of(context).textTheme.labelMedium,
/// )
/// ```
class SeparatorWithText extends StatelessWidget {
  /// The text displayed in the center of the separator
  final String text;
  
  /// Color of the divider lines. If null, uses theme's divider color
  final Color? lineColor;
  
  /// Custom text style for the separator text. If null, uses theme's bodyMedium style
  final TextStyle? textStyle;
  
  /// Thickness of the divider lines in logical pixels. Defaults to 2.0
  final double thickness;
  
  /// Total horizontal spacing around the text. Defaults to 16.0 (8.0 on each side)
  final double spacing;
  
  /// Vertical padding around the entire separator widget. Defaults to 8.0
  final double verticalPadding;
  
  /// Text alignment within its space. Defaults to center alignment
  final TextAlign textAlign;

  /// Creates a separator with text in the center.
  /// 
  /// The [text] parameter is required and will be displayed in the center of the separator.
  /// All other parameters are optional and will use sensible defaults that adapt to the current theme.
  const SeparatorWithText({
    super.key,
    required this.text,
    this.lineColor,
    this.textStyle,
    this.thickness = 2.0,
    this.spacing = 16.0,
    this.verticalPadding = 8.0,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    // Use theme-aware defaults with better contrast for readability
    final TextStyle effectiveTextStyle = textStyle ?? 
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface, // Sicherstellt besseren Kontrast
          fontWeight: FontWeight.w500, // Etwas fetter für bessere Lesbarkeit
        ) ?? 
        TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        );
    final Color effectiveLineColor = lineColor ?? 
        (Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.outline.withAlpha(200)
            : Theme.of(context).colorScheme.onSurface.withAlpha(100)); // Theme-spezifische Sichtbarkeit

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        children: [
          // Left divider line
          Expanded(
            child: Divider(
              color: effectiveLineColor,
              thickness: thickness,
              endIndent: spacing / 2,
              height: thickness,
            ),
          ),
          
          // Center text
          Text(
            text,
            style: effectiveTextStyle,
            textAlign: textAlign,
          ),
          
          // Right divider line
          Expanded(
            child: Divider(
              color: effectiveLineColor,
              thickness: thickness,
              indent: spacing / 2,
              height: thickness,
            ),
          ),
        ],
      ),
    );
  }
}