import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/languages_regions/languages.dart';
import 'package:terminal_one/languages_regions/regions.dart';
import 'package:terminal_one/screens/settings/functions/build_tile.dart';
import 'package:terminal_one/screens/settings/functions/show_language_selector.dart';
import 'package:terminal_one/screens/settings/functions/show_region_selector.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/spacer/dividors.dart';

typedef LanguageSectionChanged = void Function({String? selectedLanguageCode, String? selectedRegionCode});

Widget buildLanguageSection(
  BuildContext context,
  bool isDark,
  String selectedLanguageCode,
  String selectedRegionCode,
  LanguageSectionChanged onChanged,
) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.language_region'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 600),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              buildSettingsTile(
                context,
                'settings.language'.tr(),
                Languages.getLanguageDisplayName(selectedLanguageCode),
                LucideIcons.globe,
                () async {
                  final selected = await showLanguageSelector(context, selectedLanguageCode);
                  if (selected != null) {
                    onChanged(selectedLanguageCode: selected);
                  }
                },
                isDark,
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'settings.region'.tr(),
                Regions.getRegionDisplayName(selectedRegionCode),
                LucideIcons.mapPin,
                () async {
                  final selected = await showRegionSelector(context, selectedRegionCode);
                  if (selected != null) {
                    onChanged(selectedRegionCode: selected);
                  }
                },
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }