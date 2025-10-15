// 3D-styled common button used for primary actions throughout the app.
// This widget displays a 3D-styled button with gradients, shadow, and customizable text for primary actions.
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// A 3D-styled button for primary actions, with gradient, shadow, and customizable text.
// Stateless widget for a 3D-styled common button.

/// A 3D-styled customizable button for primary actions.
/// Supports enabled/disabled state, platform-adaptive border radius and colors.
class PrimaryButton3D extends StatefulWidget {
  /// Optional leading icon (left of text).
  final IconData? leadingIcon;
  /// Optional trailing icon (right of text).
  final IconData? trailingIcon;
  /// The button label text.
  final String label;
  /// The button height. If null, will be responsive to screen size.
  final double? height;
  /// The border radius of the button.
  /// If not set, uses iOS/Android defaults.
  final double borderRadius;
  /// Optional text style for the label.
  final TextStyle? textStyle;
  /// Callback when the button is pressed.
  final VoidCallback? onPressed;
  /// Horizontal padding for the label.
  final double paddingHorizontal;
  /// Gradient colors for the button background.
  final List<Color> colors;
  /// Shadow color for the button.
  final Color shadowColor;
  /// Inner vertical gradient overlay colors.
  final List<Color> innerColor;
  /// Whether the button is enabled (default: true).
  final bool enabled;

  /// Creates a 3D-styled button with platform-adaptive border radius and disabled state.
  PrimaryButton3D({
    super.key,
    required this.label,
  this.height,
    double? borderRadius,
    this.textStyle,
    this.paddingHorizontal = 32,
    this.onPressed,
    this.colors = const [ Color(0xFF64B5F6), Color(0xFF1976D2)], // Blau-Gradient
    this.shadowColor = const Color(0x803197C9), // Blauer Schatten
    this.innerColor = const [ Color(0xFFBBDEFB), Color(0x003197C9)], // Helles Blau innen
  this.enabled = true,
  this.leadingIcon,
  this.trailingIcon,
  }) : borderRadius = borderRadius ?? _defaultBorderRadius();

  /// Returns the default border radius for the current platform.
  static double _defaultBorderRadius() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 12;
      case TargetPlatform.android:
        return 8;
      default:
        return 10;
    }
  }

  @override
  State<PrimaryButton3D> createState() => _PrimaryButton3DState();
}

/// State for PrimaryButton3D, manages pressed and disabled visuals.
class _PrimaryButton3DState extends State<PrimaryButton3D> {
  /// Returns the platform-conform spacing between icon and text.
  double _iconTextSpacing() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 8.0;
      case TargetPlatform.android:
        return 12.0;
      default:
        return 10.0;
    }
  }


  /// Returns a responsive button height based on device type and platform guidelines.
  /// Uses shortestSide to distinguish phone/tablet, so orientation does not affect the result.
  double _responsiveHeight(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isTablet = shortestSide >= 600;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return isTablet ? 54.0 : 44.0; // iOS: 44 (phone), 54 (tablet)
      case TargetPlatform.android:
        return isTablet ? 56.0 : 48.0; // Android: 48 (phone), 56 (tablet)
      default:
        return isTablet ? 56.0 : 48.0;
    }
  }
  /// Whether the button is currently pressed.
  bool _pressed = false;

  /// Returns the background gradient colors depending on state and platform.
  List<Color> get _currentColors {
    if (!widget.enabled) {
      // Disabled colors: iOS = light gray, Android = darker gray
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return [const Color(0xFFE5E5EA), const Color(0xFFD1D1D6)];
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        return [const Color(0xFFBDBDBD), const Color(0xFF757575)];
      } else {
        return [Colors.grey.shade300, Colors.grey.shade500];
      }
    }
    // Slightly darken when pressed
    return _pressed
        ? widget.colors.map((c) => _darken(c, 0.12)).toList()
        : widget.colors;
  }

  /// Returns the inner vertical gradient overlay colors depending on state and platform.
  List<Color> get _currentInnerColors {
    if (!widget.enabled) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return [const Color(0xFFF2F2F7), const Color(0x00D1D1D6)];
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        return [const Color(0xFFE0E0E0), const Color(0x00757575)];
      } else {
        return [Colors.grey.shade100, Colors.grey.shade400.withAlpha(0)];
      }
    }
    return _pressed
        ? widget.innerColor.map((c) => _darken(c, 0.10)).toList()
        : widget.innerColor;
  }

  /// Returns the shadow color depending on state and platform.
  Color get _currentShadowColor {
    if (!widget.enabled) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return const Color(0x40D1D1D6);
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        return const Color(0x40757575);
      } else {
        return Colors.grey.shade400.withAlpha(64);
      }
    }
    return _pressed
        ? _darken(widget.shadowColor, 0.18)
        : widget.shadowColor;
  }

  /// Utility to darken a color by a given amount (0-1).
  static Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  /// Builds the button widget tree with all visual states and effects.
  @override
  Widget build(BuildContext context) {
    final bool isDisabled = !widget.enabled;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        onTap: isDisabled ? null : widget.onPressed,
        onTapDown: isDisabled ? null : (_) => setState(() => _pressed = true),
        onTapUp: isDisabled ? null : (_) => setState(() => _pressed = false),
        onTapCancel: isDisabled ? null : () => setState(() => _pressed = false),
        splashColor: isDisabled ? Colors.transparent : null,
        highlightColor: isDisabled ? Colors.transparent : null,
        child: Opacity(
          opacity: isDisabled ? 0.6 : 1.0,
          child: Container(
            height: widget.height ?? _responsiveHeight(context),
            // Outer decoration: radial gradient and shadow for 3D effect
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: RadialGradient(
                center: const Alignment(0.7, -0.2),
                radius: 1.2,
                colors: _currentColors,
                stops: const [0.0, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: _currentShadowColor,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
                BoxShadow(
                  color: Colors.white.withAlpha(128),
                  blurRadius: 4,
                  offset: Offset(0, -1),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Container(
              // Inner decoration: subtle vertical gradient overlay
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: _currentInnerColors,
                  stops: const [0.0, 0.4],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.leadingIcon != null) ...[
                        Icon(
                          widget.leadingIcon,
                          size: 22,
                          color: isDisabled
                              ? (defaultTargetPlatform == TargetPlatform.iOS
                                  ? const Color(0xFFAEAEB2)
                                  : defaultTargetPlatform == TargetPlatform.android
                                      ? const Color(0xFF424242)
                                      : Colors.grey.shade600)
                              : (widget.textStyle?.color ?? Colors.white),
                        ),
                        SizedBox(width: _iconTextSpacing()),
                      ],
                      Text(
                        widget.label,
                        style: (widget.textStyle ?? const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        )).copyWith(
                          color: isDisabled
                              ? (defaultTargetPlatform == TargetPlatform.iOS
                                  ? const Color(0xFFAEAEB2)
                                  : defaultTargetPlatform == TargetPlatform.android
                                      ? const Color(0xFF424242)
                                      : Colors.grey.shade600)
                              : (widget.textStyle?.color ?? Colors.white),
                        ),
                      ),
                      if (widget.trailingIcon != null) ...[
                        SizedBox(width: _iconTextSpacing()),
                        Icon(
                          widget.trailingIcon,
                          size: 22,
                          color: isDisabled
                              ? (defaultTargetPlatform == TargetPlatform.iOS
                                  ? const Color(0xFFAEAEB2)
                                  : defaultTargetPlatform == TargetPlatform.android
                                      ? const Color(0xFF424242)
                                      : Colors.grey.shade600)
                              : (widget.textStyle?.color ?? Colors.white),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
