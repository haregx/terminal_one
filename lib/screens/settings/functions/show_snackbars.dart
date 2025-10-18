import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/snackbars/fancy_success_snackbar.dart';

void showSettingsSavedSnackbar(BuildContext context) {
   FancySuccessSnackbar.build('messages.settings_saved'.tr());
}
    

void showComingSoonSnackbar(BuildContext context, String feature) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('messages.coming_soon'.tr(namedArgs: {'feature': feature})),
      backgroundColor: Colors.blue.shade600,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}