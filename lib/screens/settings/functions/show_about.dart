import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/app_logo.dart';

void showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'application.name'.tr(),
      // TODO make it dynamic
      applicationVersion: '0.1.1',
      applicationIcon: const AppLogo(
        size: LogoSize.small,
        variant: LogoVariant.iconOnly,
      ),
   
      children: [
        Text('settings.app_description'.tr()),
        const SizedBox(height: 8),
        Text('settings.built_with_love'.tr()),
        const SizedBox(height: 8),
        Text('settings.copyright'.tr()),
      ],
    );
  }