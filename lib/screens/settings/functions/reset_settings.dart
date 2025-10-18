import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/snackbars/fancy_success_snackbar.dart';

void resetSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('settings.reset_settings_dialog_title'.tr()),
        content: Text('settings.reset_settings_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement reset logic
              Navigator.pop(context);
             /* setState(() {
                _notificationsEnabled = true;
                _soundEnabled = true;
                _vibrationEnabled = true;
                _analyticsEnabled = false;
                _crashReportsEnabled = true;
                _selectedLanguageCode = 'en';
                _selectedRegionCode = 'auto';
              });
              _saveSettings();
              */
              ScaffoldMessenger.of(context).showSnackBar(
                FancySuccessSnackbar.build('settings.settings_reset_success'.tr()),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('settings.reset_settings'.tr()),
          ),
        ],
      ),
    );
  }