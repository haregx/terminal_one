import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/screens/settings/functions/build_tile.dart';
import 'package:terminal_one/screens/settings/functions/clear_cache.dart';
import 'package:terminal_one/screens/settings/functions/show_snackbars.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/spacer/dividors.dart';

Widget buildStorageSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.storage_cache'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 700),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              buildSettingsTile(
                context,
                'settings.storage_used'.tr(),
                '45.2 MB', // Placeholder data
                LucideIcons.hardDrive,
                () => showComingSoonSnackbar(context, 'settings.feature_storage_details'.tr()),
                isDark,
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.clear_cache'.tr(),
                'settings.clear_cache_desc'.tr(),
                LucideIcons.trash2,
                () => clearCache(context),
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }