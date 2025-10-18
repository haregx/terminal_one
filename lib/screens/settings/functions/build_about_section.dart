 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/screens/settings/functions/build_tile.dart';
import 'package:terminal_one/screens/settings/functions/show_about.dart';
import 'package:terminal_one/screens/settings/functions/show_snackbars.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/spacer/dividors.dart';

Widget buildAboutSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.about_support'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 800),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              buildSettingsTile(
                context,
                'settings.app_version'.tr(),
                // TODO make it dynamic
                '0.1.1', // Could be dynamic
                LucideIcons.info,
                () => showAbout(context),
                isDark,
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.help_support'.tr(),
                'settings.help_support_desc'.tr(),
                LucideIcons.helpCircle,
                () => showComingSoonSnackbar(context, 'settings.feature_help_support'.tr()),
                isDark,
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.rate_app'.tr(),
                'settings.rate_app_desc'.tr(),
                LucideIcons.star,
                () => showComingSoonSnackbar(context, 'settings.feature_app_rating'.tr()),
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }