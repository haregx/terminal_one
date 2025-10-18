import 'package:easy_localization/easy_localization.dart';

class Languages {

  Languages._();

  static const List<String> supportedLanguages = ['en', 'de'];

  static String get fallbackLanguageCode => 'en';

  static String getLanguageDisplayName(String languageCode) {
    // Use translation keys for language names
    return 'settings.language_$languageCode'.tr();
  }
}