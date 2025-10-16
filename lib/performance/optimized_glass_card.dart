import 'package:flutter/material.dart';
import 'dart:ui';
import 'widget_cache.dart';

/// Performance-optimierte Version des GlassCard Widgets
/// 
/// Verbesserungen:
/// - Reduzierte Rebuilds durch bessere State-Management
/// - Cached Decorations
/// - Optimierte Animation-Controller
/// - Const Constructors wo möglich
class OptimizedGlassCard extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  const OptimizedGlassCard({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  State<OptimizedGlassCard> createState() => _OptimizedGlassCardState();
}

class _OptimizedGlassCardState extends State<OptimizedGlassCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  
  // Cache Decorations to avoid recreating them
  BoxDecoration? _cachedDecoration;
  ImageFilter? _cachedFilter;
  BorderRadius? _cachedBorderRadius;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: ConstWidgets.easeOutCubic,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: ConstWidgets.easeInOut,
    ));

    // Start animation with delay
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recreate cached decorations if theme changed
    _cachedDecoration = null;
    _cachedFilter = null;
    _cachedBorderRadius = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BoxDecoration _getDecoration(bool isDark) {
    if (_cachedDecoration != null) return _cachedDecoration!;
    
    _cachedDecoration = BoxDecoration(
      color: isDark ? Colors.white.withAlpha(30) : Colors.white.withAlpha(90),
      borderRadius: widget.borderRadius ?? ConstWidgets.borderRadius16,
      border: Border.all(
        color: isDark ? Colors.white.withAlpha(60) : Colors.white.withAlpha(120), 
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(isDark ? 77 : 26),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
    
    return _cachedDecoration!;
  }

  ImageFilter _getFilter(bool isDark) {
    if (_cachedFilter != null) return _cachedFilter!;
    
    final sigma = isDark ? 15.0 : 8.0;
    _cachedFilter = ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
    
    return _cachedFilter!;
  }

  BorderRadius _getBorderRadius() {
    if (_cachedBorderRadius != null) return _cachedBorderRadius!;
    
    _cachedBorderRadius = widget.borderRadius ?? ConstWidgets.borderRadius16;
    return _cachedBorderRadius!;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AnimatedBuilder(
      animation: _controller,
      child: _buildContent(isDark),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildContent(bool isDark) {
    return ClipRRect(
      borderRadius: _getBorderRadius(),
      child: BackdropFilter(
        filter: _getFilter(isDark),
        child: Container(
          margin: widget.margin,
          decoration: _getDecoration(isDark),
          child: widget.padding != null
              ? Padding(
                  padding: widget.padding!,
                  child: widget.child,
                )
              : widget.child,
        ),
      ),
    );
  }
}

/// Stateless version für bessere Performance bei statischen Inhalten
class StaticGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  const StaticGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ClipRRect(
      borderRadius: borderRadius ?? ConstWidgets.borderRadius16,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: isDark ? 15 : 8,
          sigmaY: isDark ? 15 : 8,
        ),
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withAlpha(30) : Colors.white.withAlpha(90),
            borderRadius: borderRadius ?? ConstWidgets.borderRadius16,
            border: Border.all(
              color: isDark ? Colors.white.withAlpha(60) : Colors.white.withAlpha(120), 
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(isDark ? 77 : 26),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: padding != null
              ? Padding(
                  padding: padding!,
                  child: child,
                )
              : child,
        ),
      ),
    );
  }
}