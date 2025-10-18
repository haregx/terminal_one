 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/languages_regions/regions.dart';
import 'package:terminal_one/screens/settings/functions/show_snackbars.dart';

Future<String?> showRegionSelector(BuildContext context, String selectedRegionCode) async {
  final regionCodes = Regions.regionCodes;
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(77),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'settings.select_region'.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          ...regionCodes.map(
            (regionCode) => ListTile(
              title: Text(Regions.getRegionDisplayName(regionCode)),
              trailing: selectedRegionCode == regionCode
                  ? const Icon(LucideIcons.check, color: Colors.green)
                  : null,
              onTap: () {
                Navigator.pop(context, regionCode); // Return selected region
                showComingSoonSnackbar(context, 'settings.feature_region_switching'.tr());
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}