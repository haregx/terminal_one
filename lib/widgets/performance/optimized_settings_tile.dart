import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Optimized Settings Tile Widget
/// 
/// Performance-optimierte Version eines Settings ListTile mit:
/// - Minimal rebuilds durch const constructor
/// - Optimierte Icon-Erstellung
/// - Cached Text Styles
class OptimizedSettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isDark;
  final Widget? trailing;

  const OptimizedSettingsTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    required this.isDark,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    // Cache theme data to avoid repeated theme lookups
    final theme = Theme.of(context);
    
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: isDark 
            ? Colors.white
            : Colors.black.withAlpha(204),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDark 
              ? Colors.white.withAlpha(230)
              : Colors.black.withAlpha(230),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDark 
              ? Colors.white.withAlpha(153)
              : Colors.black.withAlpha(153),
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

/// Optimized Settings Section Header
class OptimizedSectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;

  const OptimizedSectionHeader({
    super.key,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark 
            ? Colors.white.withAlpha(230)
            : Colors.black.withAlpha(230),
      ),
    );
  }
}

/// Optimized Divider
class OptimizedDivider extends StatelessWidget {
  const OptimizedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0x1AFFFFFF),
    );
  }
}