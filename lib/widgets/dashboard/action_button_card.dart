import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/dashboard/animated_glass_card.dart';


class ActionButtonCard extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color? color;
  final Duration delay;

  const ActionButtonCard({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AnimatedGlassCard(
      delay: delay,
      blur: 8.0,
      opacity: isDark ? 0.18 : 0.45, // Noch höhere Opazität für brillante Farben
      color: color ?? Colors.grey,
      padding: EdgeInsets.all(isTablet ? 16 : 10),
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
              size: isTablet ? 28 : 20,
            ),
          ),
        ),
      ),
    );
  }
}