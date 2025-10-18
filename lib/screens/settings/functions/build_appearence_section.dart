import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/screens/settings/functions/build_tile.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/spacer/dividors.dart';
import 'package:terminal_one/widgets/switches/simple_switch.dart';
import 'package:terminal_one/widgets/theme_toggle.dart';

Widget buildAppearanceSection(BuildContext context, ThemeProvider themeProvider, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.appearance'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),      
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 300),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildThemeSelector(context, themeProvider, isDark),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.auto_theme_mode'.tr(),
                themeProvider.themeMode == ThemeMode.system ? 'settings.theme_system'.tr() : 'settings.custom_theme_desc'.tr(),
                LucideIcons.moonStar,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: themeProvider.themeMode == ThemeMode.system,
                  onChanged: (value) {
                    themeProvider.setThemeMode(
                      value ? ThemeMode.system : ThemeMode.light,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSelector(BuildContext context, ThemeProvider themeProvider, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            themeProvider.themeMode == ThemeMode.dark ? LucideIcons.moon : LucideIcons.sun, 
            size: 24,
            color: isDark 
                ? Colors.white
                : Colors.black.withAlpha(204),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'settings.theme'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
                  ),
                ),
                Text(
                  _getThemeModeDescription(themeProvider.themeMode),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white.withAlpha(153) : Colors.black.withAlpha(153),
                  ),
                ),
              ],
            ),
          ),
          ThemeToggle(
            themeMode: themeProvider.themeMode,
            onThemeChanged: (ThemeMode newMode) {
              themeProvider.setThemeMode(newMode);
            },
          ),
        ],
      ),
    );
  }

  String _getThemeModeDescription(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'settings.theme_light'.tr();
      case ThemeMode.dark:
        return 'settings.theme_dark'.tr();
      case ThemeMode.system:
        return 'settings.theme_system'.tr();
    }
  }