import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:terminal_one/screens/settings/functions/show_snackbars.dart';

void clearCache(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('settings.clear_cache_dialog_title'.tr()),
        content: Text('settings.clear_cache_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showComingSoonSnackbar(context, 'settings.feature_cache_clearing'.tr());
            },
            child: Text('settings.clear_cache'.tr()),
          ),
        ],
      ),
    );
  }