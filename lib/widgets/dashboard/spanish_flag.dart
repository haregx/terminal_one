import 'package:flutter/material.dart';

class SpanishFlag extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool showShadow;
  final double shadowBlur;
  final Offset shadowOffset;
  final VoidCallback? onTap;
  final String? tooltip;

  const SpanishFlag({
    super.key,
    this.width = 60.0,
    this.height = 42.0,
    this.borderRadius = 8.0,
    this.showShadow = true,
    this.shadowBlur = 6.0,
    this.shadowOffset = const Offset(0, 3),
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    Widget flag = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: shadowBlur,
            offset: shadowOffset,
          ),
        ] : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          'assets/flags/spanish.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback: Spanische Flagge mit Farben
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(color: const Color(0xFFAA151B)), // Rot
                  ),
                  Expanded(
                    child: Container(color: const Color(0xFFF1BF00)), // Gelb
                  ),
                  Expanded(
                    child: Container(color: const Color(0xFFAA151B)), // Rot
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    // Wenn onTap definiert ist, mache es klickbar
    if (onTap != null) {
      flag = GestureDetector(
        onTap: onTap,
        child: flag,
      );
    }

    // Wenn Tooltip definiert ist, füge es hinzu
    if (tooltip != null) {
      flag = Tooltip(
        message: tooltip!,
        child: flag,
      );
    }

    return flag;
  }
}

class PositionedSpanishFlag extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double width;
  final double height;
  final double borderRadius;
  final bool showShadow;
  final VoidCallback? onTap;
  final String? tooltip;
  final Widget child;

  const PositionedSpanishFlag({
    super.key,
    required this.child,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width = 60.0,
    this.height = 42.0,
    this.borderRadius = 8.0,
    this.showShadow = true,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: SpanishFlag(
            width: width,
            height: height,
            borderRadius: borderRadius,
            showShadow: showShadow,
            onTap: onTap,
            tooltip: tooltip,
          ),
        ),
      ],
    );
  }
}

class AnimatedSpanishFlag extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool showShadow;
  final VoidCallback? onTap;
  final String? tooltip;
  final Duration animationDuration;
  final Duration delay;
  final bool autoStart;

  const AnimatedSpanishFlag({
    super.key,
    this.width = 60.0,
    this.height = 42.0,
    this.borderRadius = 8.0,
    this.showShadow = true,
    this.onTap,
    this.tooltip,
    this.animationDuration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.autoStart = true,
  });

  @override
  State<AnimatedSpanishFlag> createState() => _AnimatedSpanishFlagState();
}

class _AnimatedSpanishFlagState extends State<AnimatedSpanishFlag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    if (widget.autoStart) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    _controller.forward();
  }

  void stopAnimation() {
    _controller.stop();
  }

  void resetAnimation() {
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: SpanishFlag(
              width: widget.width,
              height: widget.height,
              borderRadius: widget.borderRadius,
              showShadow: widget.showShadow,
              onTap: widget.onTap,
              tooltip: widget.tooltip,
            ),
          ),
        );
      },
    );
  }
}

// Utility-Klasse für vordefinierte Flaggen-Größen
class FlagSizes {
  static const double smallWidth = 40.0;
  static const double smallHeight = 28.0;
  
  static const double mediumWidth = 60.0;
  static const double mediumHeight = 42.0;
  
  static const double largeWidth = 80.0;
  static const double largeHeight = 56.0;
  
  static const double extraLargeWidth = 100.0;
  static const double extraLargeHeight = 70.0;
}

// Vordefinierte Flaggen-Komponenten
class SmallSpanishFlag extends StatelessWidget {
  final VoidCallback? onTap;
  final String? tooltip;
  
  const SmallSpanishFlag({
    super.key,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SpanishFlag(
      width: FlagSizes.smallWidth,
      height: FlagSizes.smallHeight,
      borderRadius: 4.0,
      onTap: onTap,
      tooltip: tooltip,
    );
  }
}

class MediumSpanishFlag extends StatelessWidget {
  final VoidCallback? onTap;
  final String? tooltip;
  
  const MediumSpanishFlag({
    super.key,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SpanishFlag(
      width: FlagSizes.mediumWidth,
      height: FlagSizes.mediumHeight,
      onTap: onTap,
      tooltip: tooltip,
    );
  }
}

class LargeSpanishFlag extends StatelessWidget {
  final VoidCallback? onTap;
  final String? tooltip;
  
  const LargeSpanishFlag({
    super.key,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SpanishFlag(
      width: FlagSizes.largeWidth,
      height: FlagSizes.largeHeight,
      borderRadius: 12.0,
      onTap: onTap,
      tooltip: tooltip,
    );
  }
}

class ExtraLargeSpanishFlag extends StatelessWidget {
  final VoidCallback? onTap;
  final String? tooltip;
  
  const ExtraLargeSpanishFlag({
    super.key,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SpanishFlag(
      width: FlagSizes.extraLargeWidth,
      height: FlagSizes.extraLargeHeight,
      borderRadius: 16.0,
      shadowBlur: 10.0,
      onTap: onTap,
      tooltip: tooltip,
    );
  }
}