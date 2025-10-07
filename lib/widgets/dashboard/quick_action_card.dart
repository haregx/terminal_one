// Optimierte Dashboard-Widgets mit kompakterem Design
import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/dashboard/animated_glass_card.dart';

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final Duration delay;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
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
      opacity: isDark ? 0.20 : 0.50, // Noch höhere Opazität für brillante Farben
      color: color ?? Colors.blue,
      padding: EdgeInsets.all(isTablet ? 16 : 10),
      onTap: onTap, // WICHTIG: onTap an AnimatedGlassCard weiterleiten
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isTablet ? 32 : 24,
            color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: isTablet ? 14 : 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}