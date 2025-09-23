import 'package:flutter/material.dart';
import '../core/platform_base_screen.dart';
import '../widgets/platform_widgets.dart';
import '../utils/platform_utils.dart';

/// SettingsScreen - Platform-compliant example screen
/// 
/// Demonstrates:
/// - Automatic iOS/Android adaptation using mixins
/// - Platform-aware list styling
/// - Correct navigation and dialogs
/// - Typography compliance
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with PlatformBaseScreenMixin<SettingsScreen>, PlatformListMixin<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return buildPlatformScaffold(
      title: 'Einstellungen',
      body: ListView(
        children: [
          // Account Section
          buildSectionHeader('Account'),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.person_outline,
              onPressed: () {}, // Just for display
            ),
            title: 'Profil bearbeiten',
            subtitle: 'Name, E-Mail, Foto',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _editProfile(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.notifications_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Benachrichtigungen',
            subtitle: 'Push, E-Mail, SMS',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showNotificationSettings(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.security_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Datenschutz & Sicherheit',
            subtitle: 'Passwort, 2FA, Daten',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showPrivacySettings(),
          ),

          // App Section
          buildSectionHeader('App'),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.palette_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Design',
            subtitle: 'Theme, Farben, Schriftarten',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeSettings(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.language_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Sprache',
            subtitle: 'Deutsch',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageSettings(),
          ),

          // Support Section
          buildSectionHeader('Support'),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.help_outline,
              onPressed: () {}, // Just for display
            ),
            title: 'Hilfe',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showHelp(),
          ),
          buildPlatformListTile(
            leading: PlatformIconButton(
              icon: Icons.bug_report_outlined,
              onPressed: () {}, // Just for display
            ),
            title: 'Feedback senden',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _sendFeedback(),
          ),

          // Danger Zone
          buildSectionHeader('Konto'),
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
              icon: Icons.delete_forever,
              onPressed: () {}, // Just for display
            ),
            title: 'Konto löschen',
            onTap: () => _deleteAccount(),
          ),
        ],
      ),
    );
  }

  void _editProfile() {
    navigateToPlatformScreen(context, const ProfileEditScreen());
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
    navigateToPlatformScreen(context, const TypographyDemoScreen());
  }

  void _showLanguageSettings() {
    showPlatformDialog(
      context,
      title: 'Sprache ändern',
      content: 'Möchten Sie die Sprache ändern?',
      actions: [
        PlatformDialogAction(
          child: const Text('Deutsch'),
          onPressed: () => Navigator.pop(context),
        ),
        PlatformDialogAction(
          child: const Text('English'),
          onPressed: () => Navigator.pop(context),
        ),
        PlatformDialogAction(
          child: const Text('Abbrechen'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showHelp() {
    showPlatformMessage(context, 'Hilfe wird geöffnet...');
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

/// Simple Profile Edit Screen demonstrating form mixin
class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>
    with PlatformBaseScreenMixin<ProfileEditScreen>, PlatformFormMixin<ProfileEditScreen> {

  @override
  Widget build(BuildContext context) {
    return buildPlatformScaffold(
      title: 'Profil bearbeiten',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) => value?.isEmpty == true ? 'Name erforderlich' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-Mail',
                ),
                validator: (value) => value?.isEmpty == true ? 'E-Mail erforderlich' : null,
              ),
              const SizedBox(height: 32),
              PlatformButton(
                onPressed: () {
                  if (validateForm()) {
                    saveForm();
                    showPlatformMessage(context, 'Profil gespeichert');
                  }
                },
                child: const Text('Speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Typography Demo showing platform fonts
class TypographyDemoScreen extends StatefulWidget {
  const TypographyDemoScreen({super.key});

  @override
  State<TypographyDemoScreen> createState() => _TypographyDemoScreenState();
}

class _TypographyDemoScreenState extends State<TypographyDemoScreen>
    with PlatformBaseScreenMixin<TypographyDemoScreen> {

  @override
  Widget build(BuildContext context) {
    return buildPlatformScaffold(
      title: 'Typography Demo',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Platform Typography',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'iOS: San Francisco Font Family',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Android: Roboto Font Family',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Body Text Example',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Dies ist ein Beispieltext der zeigt, wie sich die Schriftarten automatisch an die jeweilige Plattform anpassen.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}