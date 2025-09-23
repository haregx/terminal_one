import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Theme toggle widget with smooth animation
/// 
/// Provides an animated button to switch between light and dark themes.
/// Features smooth transitions and clear visual feedback.
class ThemeToggle extends StatefulWidget {
  /// Current theme mode
  final ThemeMode themeMode;
  
  /// Callback when theme should change
  final ValueChanged<ThemeMode> onThemeChanged;
  
  /// Size of the toggle button (default: 24.0)
  final double size;
  
  /// Whether to show tooltip (default: true)
  final bool showTooltip;

  const ThemeToggle({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
    this.size = 24.0,
    this.showTooltip = true,
  });

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    // Set initial animation state based on current theme
    if (widget.themeMode == ThemeMode.dark) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(ThemeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update animation when theme changes externally
    if (widget.themeMode != oldWidget.themeMode) {
      if (widget.themeMode == ThemeMode.dark) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    final newTheme = widget.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    
    // Animate the toggle
    if (newTheme == ThemeMode.dark) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    
    // Notify parent
    widget.onThemeChanged(newTheme);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _toggleTheme,
        borderRadius: BorderRadius.circular(widget.size / 2),
        child: Container(
          width: widget.size * 2,
          height: widget.size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.size / 2),
            border: Border.all(
              color: theme.colorScheme.outline.withAlpha(128),
              width: 1,
            ),
          ),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  // Background gradient
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.size / 2),
                      gradient: LinearGradient(
                        colors: [
                          Color.lerp(
                            theme.colorScheme.primary.withAlpha(204), // Primary Button Farbe für Light Mode
                            const Color(0xFF424242), // Dark mode color (dark gray)
                            _animation.value,
                          )!,
                          Color.lerp(
                            theme.colorScheme.primary, // Primary Button Farbe für Light Mode
                            const Color(0xFF212121), // Dark mode color (black)
                            _animation.value,
                          )!,
                        ],
                      ),
                    ),
                  ),
                  
                  // Moving circle (sun/moon)
                  Positioned(
                    left: _animation.value * (widget.size) + 1, // +1 für Border-Kompensation
                    top: 1, // Reduziert wegen Border
                    child: Container(
                      width: widget.size - 4,
                      height: widget.size - 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(26),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          _animation.value > 0.5
                              ? LucideIcons.moon
                              : LucideIcons.sun,
                          key: ValueKey(_animation.value > 0.5),
                          size: widget.size * 0.6,
                          color: _animation.value > 0.5
                              ? theme.colorScheme.primary
                              : theme.colorScheme.primary, // Primary Button Farbe für Light Mode
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    if (widget.showTooltip) {
      return Tooltip(
        message: widget.themeMode == ThemeMode.light
            ? 'Switch to dark mode'
            : 'Switch to light mode',
        child: button,
      );
    }

    return button;
  }
}