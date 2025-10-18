import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget buildSettingsTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback? onTap,
    bool isDark, 
    {
      bool isDestructive = false,
      Widget? trailing,
    }
  ) 
  {
    final titleColor = isDestructive ? Colors.red.withAlpha(230) : isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230);
    final iconColor = isDestructive ? Colors.red  : isDark ? Colors.white.withAlpha(204) : Colors.black.withAlpha(204);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.white.withAlpha(153) : Colors.black.withAlpha(153),  
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else if (onTap != null)
              Icon(
                LucideIcons.chevronRight,
                size: 20,
                color: isDark ? Colors.white.withAlpha(128) : Colors.black.withAlpha(128),    
              ),
          ],
        ),
      ),
    );
  }