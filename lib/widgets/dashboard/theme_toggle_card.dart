import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'animated_glass_card.dart';


class ThemeToggleCard extends StatelessWidget {
  final Duration delay;
  final bool includeSystemMode;
  
  const ThemeToggleCard({
    super.key,
    this.delay = Duration.zero,
    this.includeSystemMode = true, // Standard: alle 3 Modi verfügbar
  });

  // Helper method to get icon for theme mode
  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }

  // Helper method to get label for theme mode
  String _getThemeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Hell';
      case ThemeMode.dark:
        return 'Dunkel';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        
        return AnimatedGlassCard(
          delay: delay,
          blur: 8.0,
          opacity: isDark ? 0.18 : 0.55,
          padding: EdgeInsets.all(isTablet ? 16 : 12),
          onTap: () {
            ThemeMode nextMode;
            
            if (includeSystemMode) {
              // Vollständiger Toggle: System -> Light -> Dark -> System
              switch (themeProvider.themeMode) {
                case ThemeMode.system:
                  nextMode = ThemeMode.light;
                  break;
                case ThemeMode.light:
                  nextMode = ThemeMode.dark;
                  break;
                case ThemeMode.dark:
                  nextMode = ThemeMode.system;
                  break;
              }
            } else {
              // Einfacher Toggle: Light <-> Dark (ohne System)
              switch (themeProvider.themeMode) {
                case ThemeMode.system:
                case ThemeMode.light:
                  nextMode = ThemeMode.dark;
                  break;
                case ThemeMode.dark:
                  nextMode = ThemeMode.light;
                  break;
              }
            }
            
            themeProvider.setThemeMode(nextMode);
            
            if (context.mounted) {
              String modeLabel;
              switch (nextMode) {
                case ThemeMode.system:
                  modeLabel = 'System';
                  break;
                case ThemeMode.light:
                  modeLabel = 'Hell';
                  break;
                case ThemeMode.dark:
                  modeLabel = 'Dunkel';
                  break;
              }
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Theme geändert zu: $modeLabel'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getThemeIcon(themeProvider.themeMode),
                color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                size: isTablet ? 32 : 24,
              ),
              const SizedBox(height: 8),
              Text(
                'Theme',
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                _getThemeLabel(themeProvider.themeMode),
                style: TextStyle(
                  fontSize: isTablet ? 11 : 10,
                  color: isDark ? Colors.white.withValues(alpha: 0.7) : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}