import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WebStatusBar extends StatelessWidget {
  const WebStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final time = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF101012) : Colors.white;
    final iconColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.white : Colors.black;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 44, // typische iOS StatusBar-Höhe
        width: double.infinity,
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16), // kein extra vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(time, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(LucideIcons.signal, color: iconColor, size: 18),
                const SizedBox(width: 4),
                Icon(LucideIcons.wifi, color: iconColor, size: 18),
                const SizedBox(width: 4),
                Icon(LucideIcons.batteryFull, color: iconColor, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
