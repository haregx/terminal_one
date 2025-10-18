import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/languages_regions/languages.dart';
import 'package:terminal_one/widgets/snackbars/fancy_success_snackbar.dart';

Future<String?> showLanguageSelector(BuildContext context, String selectedLanguageCode) async {
  final languageCodes = Languages.supportedLanguages;
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
              'settings.select_language'.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          ...languageCodes.map(
            (languageCode) => ListTile(
              title: Text(Languages.getLanguageDisplayName(languageCode)),
              trailing: selectedLanguageCode == languageCode
                  ? const Icon(LucideIcons.check, color: Colors.green)
                  : null,
              onTap: () async {
                final newLocale = Locale(languageCode);
                context.setLocale(newLocale);
                Navigator.pop(context, languageCode); // Return selected language
                ScaffoldMessenger.of(context).showSnackBar(
                  FancySuccessSnackbar.build(
                    'settings.language_switched'.tr(),
                  )
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
