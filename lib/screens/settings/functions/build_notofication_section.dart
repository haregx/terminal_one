import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/screens/settings/functions/build_tile.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/spacer/dividors.dart';
import 'package:terminal_one/widgets/switches/simple_switch.dart';

typedef NotificationSettingsChanged = void Function({bool? notificationsEnabled, bool? soundEnabled, bool? vibrationEnabled});

Widget buildNotificationsSection(
  BuildContext context,
  bool isDark,
  bool notificationsEnabled,
  bool soundEnabled,
  bool vibrationEnabled,
  NotificationSettingsChanged onChanged,
) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.notifications'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 400),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              buildSettingsTile(
                context,
                'settings.push_notifications'.tr(),
                'settings.push_notifications_desc'.tr(),
                LucideIcons.bell,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: notificationsEnabled,
                  onChanged: (value) {
                    onChanged(notificationsEnabled: value);
                  },
                ),
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.sound'.tr(),
                'settings.sound_desc'.tr(),
                LucideIcons.volume2,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: soundEnabled,
                  onChanged: (value) {
                    onChanged(soundEnabled: value);
                  },
                ),
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.vibration'.tr(),
                'settings.vibration_desc'.tr(),
                LucideIcons.smartphone,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: vibrationEnabled,
                  onChanged: (value) {
                    onChanged(vibrationEnabled: value);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }