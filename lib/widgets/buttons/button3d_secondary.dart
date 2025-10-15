import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// A 3D-styled secondary button for less prominent actions.
/// Matches the API and responsive/adaptive behavior of PrimaryButton3D.
class SecondaryButton3D extends StatefulWidget {
  final String label;
  final double? height;
  final double borderRadius;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double paddingHorizontal;
  final List<Color> colors;
  final Color shadowColor;
  final List<Color> innerColor;
  final bool enabled;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  SecondaryButton3D({
    super.key,
    required this.label,
    this.height,
    double? borderRadius,
    this.textStyle,
    this.paddingHorizontal = 32,
    this.onPressed,
  this.colors = const [ Color(0xFFBDBDBD), Color(0xFF757575)], // Satterer Grau-Gradient
  this.shadowColor = const Color(0x40606060), // Dunklerer grauer Schatten
  this.innerColor = const [ Color(0xFFE0E0E0), Color(0x00757575)], // Etwas dunkleres Grau innen
    this.enabled = true,
    this.leadingIcon,
    this.trailingIcon,
  }) : borderRadius = borderRadius ?? _defaultBorderRadius();

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
  State<SecondaryButton3D> createState() => _SecondaryButton3DState();
}

class _SecondaryButton3DState extends State<SecondaryButton3D> {
  bool _pressed = false;

  List<Color> get _currentColors {
    if (!widget.enabled) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return [const Color(0xFFE5E5EA), const Color(0xFFD1D1D6)];
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        return [const Color(0xFFBDBDBD), const Color(0xFF757575)];
      } else {
        return [Colors.grey.shade300, Colors.grey.shade500];
      }
    }
    return _pressed
        ? widget.colors.map((c) => _darken(c, 0.10)).toList()
        : widget.colors;
  }

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
        ? widget.innerColor.map((c) => _darken(c, 0.08)).toList()
        : widget.innerColor;
  }

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
        ? _darken(widget.shadowColor, 0.15)
        : widget.shadowColor;
  }

  static Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  double _responsiveHeight(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isTablet = shortestSide >= 600;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return isTablet ? 54.0 : 44.0;
      case TargetPlatform.android:
        return isTablet ? 56.0 : 48.0;
      default:
        return isTablet ? 56.0 : 48.0;
    }
  }

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
