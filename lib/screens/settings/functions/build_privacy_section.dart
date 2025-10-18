import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/screens/settings/functions/build_tile.dart';
import 'package:terminal_one/screens/settings/functions/show_snackbars.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/spacer/dividors.dart';
import 'package:terminal_one/widgets/switches/simple_switch.dart';

typedef PrivacySettingsChanged = void Function({bool? analyticsEnabled, bool? crashReportsEnabled});

Widget buildPrivacySection(
  BuildContext context,
  bool isDark,
  bool analyticsEnabled,
  bool crashReportsEnabled,
  PrivacySettingsChanged onChanged,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.privacy_security'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 500),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              buildSettingsTile(
                context,
                'settings.analytics'.tr(),
                'settings.analytics_desc'.tr(),
                LucideIcons.barChart3,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: analyticsEnabled,
                  onChanged: (value) {
                    onChanged(analyticsEnabled: value);
                  },
                ),
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.crash_reports'.tr(),
                'settings.crash_reports_desc'.tr(),
                LucideIcons.bug,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: crashReportsEnabled,
                  onChanged: (value) {
                    onChanged(crashReportsEnabled: value);
                  },
                ),
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.privacy_policy'.tr(),
                'settings.privacy_policy_desc'.tr(),
                LucideIcons.shield,
                () => showComingSoonSnackbar(context, 'settings.feature_privacy_policy'.tr()),
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }