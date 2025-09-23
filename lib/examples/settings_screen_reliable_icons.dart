import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../core/platform_screen_mixin.dart';
import '../widgets/platform_widgets.dart';
import '../utils/platform_utils.dart';
import '../themes/platform_typography.dart';

/// SettingsScreen - Platform-compliant example screen with reliable icons
/// 
/// Demonstrates:
/// - Automatic iOS/Android adaptation using mixins
/// - Platform-aware list styling with reliable icons
/// - Correct navigation and dialogs
/// - Typography compliance
/// - Platform-specific spacing and colors
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with PlatformScreenMixin<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return buildPlatformScaffold(
      title: 'Einstellungen',
      leading: PlatformUtils.isIOSContext(context)
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: CupertinoColors.systemBlue,
                    size: 18,
                  ),
                  SizedBox(width: 2),
                  Text(
                    'Zurück',
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      fontFamily: PlatformTypography.primaryFontFamily,
                    ),
                  ),
                ],
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      body: ListView(
        children: [
          // Account Section
          _buildPlatformSectionHeader('Account'),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.person_outline,
              onPressed: () {}, // Just for display
            ),
            title: 'Profil bearbeiten',
            subtitle: 'Name, E-Mail, Foto',
            trailing: Icon(Icons.chevron_right),
            onTap: () => _editProfile(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.notifications_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Benachrichtigungen',
            subtitle: 'Push, E-Mail, SMS',
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showNotificationSettings(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.security_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Datenschutz & Sicherheit',
            subtitle: 'Passwort, 2FA, Daten',
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showPrivacySettings(),
          ),

          // App Section
          _buildPlatformSectionHeader('App'),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.palette_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Design',
            subtitle: 'Theme, Farben, Schriftarten',
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showThemeSettings(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.language_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Sprache',
            subtitle: 'Deutsch',
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showThemeSettings(),
          ),

          // Support Section
          _buildPlatformSectionHeader('Support'),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.help_outline,
              onPressed: () {}, // Just for display
            ),
            title: 'Hilfe',
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showHelp(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.feedback_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Feedback senden',
            trailing: Icon(Icons.chevron_right),
            onTap: () => _sendFeedback(),
          ),

          // Account Section
          _buildPlatformSectionHeader('Konto'),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.logout,
              onPressed: () {}, // Just for display
            ),
            title: 'Abmelden',
            onTap: () => _logout(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.delete_outline,
              onPressed: () {}, // Just for display
            ),
            title: 'Konto löschen',
            onTap: () => _deleteAccount(),
          ),
        ],
      ),
    );
  }

  /// Platform-aware section header with correct spacing and typography
  Widget _buildPlatformSectionHeader(String title) {
    final isIOS = PlatformUtils.isIOSContext(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isIOS ? 20.0 : 16.0, // iOS uses 20, Android uses 16
        isIOS ? 32.0 : 24.0, // iOS uses more top spacing
        isIOS ? 20.0 : 16.0, // iOS uses 20, Android uses 16
        isIOS ? 8.0 : 8.0,   // Bottom spacing consistent
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: isIOS ? 15.0 : 16.0, // iOS uses slightly smaller
          fontWeight: FontWeight.w600,
          color: isIOS 
              ? CupertinoColors.secondaryLabel
              : Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.none,
          fontFamily: PlatformTypography.primaryFontFamily,
        ),
      ),
    );
  }

  void _editProfile() {
    showPlatformMessage(context, 'Profil-Editor wird geöffnet...');
  }

  void _showNotificationSettings() {
    showPlatformDialog(
      context,
      title: 'Benachrichtigungen',
      content: 'Hier können Sie Ihre Benachrichtigungseinstellungen verwalten.',
      actions: [
        PlatformDialogAction(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showPrivacySettings() {
    showPlatformDialog(
      context,
      title: 'Datenschutz',
      content: 'Ihre Daten sind sicher und werden verschlüsselt gespeichert.',
      actions: [
        PlatformDialogAction(
          child: const Text('Verstanden'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showThemeSettings() {
    showPlatformMessage(context, 'Typography Demo wird geöffnet...');
  }

  void _showHelp() {
    showPlatformMessage(context, 'Hilfe-Center wird geöffnet...');
  }

  void _sendFeedback() {
    showPlatformMessage(context, 'Feedback-Formular wird geöffnet...');
  }

  void _logout() {
    showPlatformDialog(
      context,
      title: 'Abmelden',
      content: 'Möchten Sie sich wirklich abmelden?',
      actions: [
        PlatformDialogAction(
          child: const Text('Abmelden'),
          isDestructive: true,
          onPressed: () {
            Navigator.pop(context);
            showPlatformMessage(context, 'Sie wurden abgemeldet');
          },
        ),
        PlatformDialogAction(
          child: const Text('Abbrechen'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _deleteAccount() {
    showPlatformDialog(
      context,
      title: 'Konto löschen',
      content: 'ACHTUNG: Diese Aktion kann nicht rückgängig gemacht werden!',
      actions: [
        PlatformDialogAction(
          child: const Text('Löschen'),
          isDestructive: true,
          onPressed: () {
            Navigator.pop(context);
            showPlatformMessage(context, 'Konto-Löschung eingeleitet');
          },
        ),
        PlatformDialogAction(
          child: const Text('Abbrechen'),
          isDefault: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}