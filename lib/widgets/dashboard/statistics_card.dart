import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/dashboard/animated_glass_card.dart';

class StatisticCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color? color;
  final Duration delay;
  final VoidCallback? onTap;

  const StatisticCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.color,
    this.delay = Duration.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AnimatedGlassCard(
      delay: delay,
      blur: 8.0,
      opacity: isDark ? 0.20 : 0.50, // Noch höhere Opazität für brillante Farben
      color: color ?? Colors.green,
      padding: EdgeInsets.all(isTablet ? 16 : 10),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isTablet ? 28 : 20,
            color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 12 : 10,
              color: isDark ? Colors.white.withOpacity(0.8) : Colors.black54,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
