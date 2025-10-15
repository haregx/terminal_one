import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/widgets/buttons/button3d_primary.dart';
import 'package:terminal_one/widgets/snackbars/fancy_success_snackbar.dart';
import 'package:terminal_one/providers/auth_provider.dart';
import 'package:terminal_one/widgets/buttons/primary_button.dart';

/// LogoutScreen - Einfacher Logout-Bestätigungsscreen
/// 
/// Wird als Modal von unten angezeigt und nimmt die halbe Bildschirmhöhe ein
class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  /// Zeigt den LogoutScreen als Bottom Sheet an
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LogoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.5, // Halbe Bildschirmhöhe
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Drag Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Icon
            Icon(
              LucideIcons.logOut,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            
            const SizedBox(height: 24),
            
            // Titel
            Text(
              'auth.logout'.tr(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bestätigungstext
            Text(
              'auth.logout_confirmation'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // Logout Button - Nur so breit wie nötig
            IntrinsicWidth(
              child: PrimaryButton3D(
                label: 'auth.logout'.tr(),
                onPressed: () async {
                  // Navigator schließen
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    FancySuccessSnackbar.build('auth.logout_success'.tr()),
                  );
                  // Ausloggen
                  await Provider.of<AuthProvider>(context, listen: false).setLoggedIn(false);
                },
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Abbrechen Button
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('common.cancel'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}