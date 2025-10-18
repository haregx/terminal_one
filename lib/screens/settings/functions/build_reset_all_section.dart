import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/screens/settings/functions/build_tile.dart';
import 'package:terminal_one/screens/settings/functions/reset_settings.dart';
import 'package:terminal_one/widgets/glass_card.dart';

Widget buildDangerZoneSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassCard(
          delay: const Duration(milliseconds: 900),
          padding: EdgeInsets.zero,
          child: buildSettingsTile(
            context,
            'settings.reset_settings'.tr(),
            'settings.reset_settings_desc'.tr(),
            LucideIcons.rotateCcw,
            () => resetSettings(context),
            isDark,
            isDestructive: true,
          ),
        ),
      ],
    );
  }