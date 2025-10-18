import 'package:easy_localization/easy_localization.dart';

class Regions { 

  Regions._();

  static const regionCodes = ['auto', 'us', 'eu', 'asia', 'other'];
  

  static String getRegionDisplayName(String regionCode) {
    // Fully internationalized using translation keys
    switch (regionCode) {
      case 'auto':
        return 'settings.region_automatic'.tr();
      case 'us':
        return 'settings.region_united_states'.tr();
      case 'eu':
        return 'settings.region_europe'.tr();
      case 'asia':
        return 'settings.region_asia'.tr();
      case 'other':
        return 'settings.region_other'.tr();
      default:
        return 'settings.region_automatic'.tr();
    }
  }
}