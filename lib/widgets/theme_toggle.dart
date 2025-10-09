import 'package:flutter/material.dart';

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

class _ThemeToggleState extends State<ThemeToggle> {

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;
    
    // Einfacher Switch ohne externe Icons
    Widget button = Switch(
      value: isDark,
      onChanged: (value) {
        final newTheme = value ? ThemeMode.dark : ThemeMode.light;
        widget.onThemeChanged(newTheme);
      },
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