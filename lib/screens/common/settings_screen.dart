import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/widgets/switches/simple_switch.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/app_logo.dart';
import 'package:terminal_one/widgets/appbar_aware_safe_area.dart';
import 'package:terminal_one/widgets/glassmorphism_scaffold.dart';
import 'package:terminal_one/widgets/theme_toggle.dart';

/// Settings Screen - Application settings and preferences
/// 
/// Features comprehensive app settings including theme preferences,
/// notifications, privacy settings, and app information
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  // Logo animation as in Home Screen
  late ScrollController _scrollController;
  final ValueNotifier<bool> _showSmallLogo = ValueNotifier<bool>(false);
  
  // Settings state variables
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _analyticsEnabled = false;
  bool _crashReportsEnabled = true;
  String _selectedLanguageCode = 'de';
  String _selectedRegionCode = 'auto';
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

  // Logo animation setup
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Start animation
    _fadeController.forward();
    
    // Load saved settings
    _loadSettings();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Initialize with current locale safely - only once
    if (!_isInitialized && mounted) {
      _selectedLanguageCode = context.locale.languageCode;
      _isInitialized = true;
    }
  }

  void _onScroll() {
    final shouldShow = _scrollController.offset > 50;
    if (_showSmallLogo.value != shouldShow) {
      debugPrint('Settings Logo state changed: offset=${_scrollController.offset}, show=$shouldShow');
      _showSmallLogo.value = shouldShow;
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scrollController.dispose();
    _showSmallLogo.dispose();
    super.dispose();
  }

  void _loadSettings() {
    // TODO: Load settings from SharedPreferences or provider
    // This is a placeholder implementation
  }

  void _saveSettings() {
    // TODO: Save settings to SharedPreferences or provider
    _showSettingsSavedSnackbar();
  }

  String _getLanguageDisplayName(String languageCode) {
    // Dynamisch basierend auf aktueller Locale
   // final currentLocale = context.locale.languageCode;

      // TODO: Change language display names
      switch (languageCode) {
        case 'en':
          return 'English';
        case 'de':
          return 'Deutsch';
 /*       case 'fr':
          return 'Francais';
        case 'es':
          return 'Espańol';
        case 'it':
          return 'Italienisch';
        */
        default:
          return 'English';
      }
  }

  String _getRegionDisplayName(String regionCode) {
    // Dynamisch basierend auf aktueller Locale
    final currentLocale = context.locale.languageCode;
    
    if (currentLocale == 'de') {
      switch (regionCode) {
        case 'auto':
          return 'Automatisch';
        case 'us':
          return 'Vereinigte Staaten';
        case 'eu':
          return 'Europa';
        case 'asia':
          return 'Asien';
        case 'other':
          return 'Andere';
        default:
          return 'Automatisch';
      }
    } else {
      // Englisch als Fallback
      switch (regionCode) {
        case 'auto':
          return 'Automatic';
        case 'us':
          return 'United States';
        case 'eu':
          return 'Europe';
        case 'asia':
          return 'Asia';
        case 'other':
          return 'Other';
        default:
          return 'Automatic';
      }
    }
  }

  void _showLanguageSelector() {
    // TODO: Change language selection
    // final languageCodes = ['en', 'de', 'fr', 'es'];
    final languageCodes = ['en', 'de'];
    
    showModalBottomSheet(
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
                context.locale.languageCode == 'de' ? 'Sprache auswählen' : 'Select Language',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            ...languageCodes.map(
              (languageCode) => ListTile(
                title: Text(_getLanguageDisplayName(languageCode)),
                trailing: _selectedLanguageCode == languageCode
                    ? const Icon(LucideIcons.check, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguageCode = languageCode;
                  });
                  
                  // Tatsächliche Sprachumschaltung
                  final newLocale = Locale(languageCode);
                  context.setLocale(newLocale);
                  
                  Navigator.pop(context);
                  
                  // Erfolgs-Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        languageCode == 'de' ? 'Sprache auf Deutsch geändert' : 'Language changed to English'
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
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

  void _showRegionSelector() {
    final regionCodes = ['auto', 'us', 'eu', 'asia', 'other'];
    
    showModalBottomSheet(
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
                'settings.select_region'.tr(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            ...regionCodes.map(
              (regionCode) => ListTile(
                title: Text(_getRegionDisplayName(regionCode)),
                trailing: _selectedRegionCode == regionCode
                    ? const Icon(LucideIcons.check, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedRegionCode = regionCode;
                  });
                  Navigator.pop(context);
                  _showComingSoonSnackbar('settings.feature_region_switching'.tr());
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _resetSettings() {
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
              Navigator.pop(context);
              setState(() {
                _notificationsEnabled = true;
                _soundEnabled = true;
                _vibrationEnabled = true;
                _analyticsEnabled = false;
                _crashReportsEnabled = true;
                _selectedLanguageCode = 'en';
                _selectedRegionCode = 'auto';
              });
              _saveSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('settings.settings_reset_success'.tr()),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('settings.reset_settings'.tr()),
          ),
        ],
      ),
    );
  }

  void _clearCache() {
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
              _showComingSoonSnackbar('settings.feature_cache_clearing'.tr());
            },
            child: Text('settings.clear_cache'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassmorphismScaffold(
      // AppBar mit Logo Animation - genau wie bei HomeScreenLoggedIn
      title: ValueListenableBuilder<bool>(
        valueListenable: _showSmallLogo,
        builder: (context, showLogo, child) {
          debugPrint('Settings AppBar Logo showLogo: $showLogo'); // Debug
          return AnimatedOpacity(
            opacity: showLogo ? 1.0 : 0.0, // Bei showLogo=false komplett transparent (leer)
            duration: const Duration(milliseconds: 300),
            child: const AppLogo(
              size: LogoSize.small,
              variant: LogoVariant.minimal,
            ),
          );
        },
      ),
    /*  actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: ThemeToggle(
            themeMode: themeProvider.themeMode,
            onThemeChanged: (ThemeMode newMode) {
              themeProvider.setThemeMode(newMode);
            },
          ),
        ),
      ],*/
      body: AppBarAwareSafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header Bereich mit großem Logo (verschwindet beim Scrollen)
                ValueListenableBuilder<bool>(
                  valueListenable: _showSmallLogo,
                  builder: (context, showSmallLogo, child) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: showSmallLogo ? 0.0 : 1.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: isDark 
                                ? Colors.transparent
                                : Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AppLogo(
                                size: LogoSize.medium,
                                variant: LogoVariant.minimal,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'settings.app_settings'.tr(),
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark 
                                      ? Colors.white.withAlpha(230)
                                      : Colors.black.withAlpha(230),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'settings.customize_experience'.tr(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: isDark 
                                      ? Colors.white.withAlpha(179)
                                      : Colors.black.withAlpha(179),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Settings content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: ResponsiveSpacing.large(context),
                    children: [
                      // Appearance Settings
                      _buildAppearanceSection(themeProvider, isDark),
                      // Notifications Settings
                      _buildNotificationsSection(isDark),
                      // Privacy & Security
                      _buildPrivacySection(isDark),
                      // Language & Region
                      _buildLanguageSection(isDark),
                      // Storage & Cache
                      _buildStorageSection(isDark),
                      // About & Support
                      _buildAboutSection(isDark),
                      // Danger Zone
                      _buildDangerZoneSection(isDark),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildAppearanceSection(ThemeProvider themeProvider, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.appearance'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),      
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 300),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildThemeSelector(themeProvider, isDark),
              _buildDivider(),
              _buildSettingsTile(
                'settings.auto_dark_mode'.tr(),
                'settings.auto_dark_mode_desc'.tr(),
                LucideIcons.moonStar,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: themeProvider.themeMode == ThemeMode.system,
                  onChanged: (value) {
                    themeProvider.setThemeMode(
                      value ? ThemeMode.system : ThemeMode.light,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSelector(ThemeProvider themeProvider, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            themeProvider.themeMode == ThemeMode.dark ? LucideIcons.moon : LucideIcons.sun, 
            size: 24,
            color: isDark 
                ? Colors.white
                : Colors.black.withAlpha(204),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'settings.theme'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
                  ),
                ),
                Text(
                  _getThemeModeDescription(themeProvider.themeMode),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white.withAlpha(153) : Colors.black.withAlpha(153),
                  ),
                ),
              ],
            ),
          ),
          ThemeToggle(
            themeMode: themeProvider.themeMode,
            onThemeChanged: (ThemeMode newMode) {
              themeProvider.setThemeMode(newMode);
            },
          ),
        ],
      ),
    );
  }

  String _getThemeModeDescription(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'settings.theme_light'.tr();
      case ThemeMode.dark:
        return 'settings.theme_dark'.tr();
      case ThemeMode.system:
        return 'settings.theme_system'.tr();
    }
  }

  Widget _buildNotificationsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.notifications'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 400),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildSettingsTile(
                'settings.push_notifications'.tr(),
                'settings.push_notifications_desc'.tr(),
                LucideIcons.bell,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ),
              _buildDivider(),
              _buildSettingsTile(
                'settings.sound'.tr(),
                'settings.sound_desc'.tr(),
                LucideIcons.volume2,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: _soundEnabled,
                  onChanged: (value) {
                    setState(() {
                      _soundEnabled = value;
                    });
                  },
                ),
              ),
              _buildDivider(),
              _buildSettingsTile(
                'settings.vibration'.tr(),
                'settings.vibration_desc'.tr(),
                LucideIcons.smartphone,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: _vibrationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _vibrationEnabled = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.privacy_security'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 500),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildSettingsTile(
                'settings.analytics'.tr(),
                'settings.analytics_desc'.tr(),
                LucideIcons.barChart3,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: _analyticsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _analyticsEnabled = value;
                    });
                  },
                ),
              ),
              _buildDivider(),
              _buildSettingsTile(
                'settings.crash_reports'.tr(),
                'settings.crash_reports_desc'.tr(),
                LucideIcons.bug,
                null,
                isDark,
                trailing: SimpleSwitch(
                  value: _crashReportsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _crashReportsEnabled = value;
                    });
                  },
                ),
              ),
              _buildDivider(),
              _buildSettingsTile(
                'settings.privacy_policy'.tr(),
                'settings.privacy_policy_desc'.tr(),
                LucideIcons.shield,
                () => _showComingSoonSnackbar('settings.feature_privacy_policy'.tr()),
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.language_region'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 600),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildSettingsTile(
                context.locale.languageCode == 'de' ? 'Sprache' : 'Language',
                _getLanguageDisplayName(_selectedLanguageCode),
                LucideIcons.globe,
                _showLanguageSelector,
                isDark,
              ),
              _buildDivider(),
              _buildSettingsTile(
                context.locale.languageCode == 'de' ? 'Region' : 'Region',
                _getRegionDisplayName(_selectedRegionCode),
                LucideIcons.mapPin,
                _showRegionSelector,
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStorageSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.storage_cache'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 700),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildSettingsTile(
                'settings.storage_used'.tr(),
                '45.2 MB', // Placeholder data
                LucideIcons.hardDrive,
                () => _showComingSoonSnackbar('settings.feature_storage_details'.tr()),
                isDark,
              ),
              _buildDivider(),
              _buildSettingsTile(
                'settings.clear_cache'.tr(),
                'settings.clear_cache_desc'.tr(),
                LucideIcons.trash2,
                _clearCache,
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.about_support'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 800),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildSettingsTile(
                'settings.app_version'.tr(),
                // TODO make it dynamic
                '0.1.1', // Could be dynamic
                LucideIcons.info,
                () => _showAboutDialog(),
                isDark,
              ),
              _buildDivider(),
              _buildSettingsTile(
                'settings.help_support'.tr(),
                'settings.help_support_desc'.tr(),
                LucideIcons.helpCircle,
                () => _showComingSoonSnackbar('settings.feature_help_support'.tr()),
                isDark,
              ),
              _buildDivider(),
              _buildSettingsTile(
                'settings.rate_app'.tr(),
                'settings.rate_app_desc'.tr(),
                LucideIcons.star,
                () => _showComingSoonSnackbar('settings.feature_app_rating'.tr()),
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDangerZoneSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     /*   Text(
          'settings.danger_zone'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.red.withAlpha(230),
          ),
        ),
        */
        const SizedBox(height: 32),
        GlassCard(
          delay: const Duration(milliseconds: 900),
          padding: EdgeInsets.zero,
          child: _buildSettingsTile(
            'settings.reset_settings'.tr(),
            'settings.reset_settings_desc'.tr(),
            LucideIcons.rotateCcw,
            _resetSettings,
            isDark,
            isDestructive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback? onTap,
    bool isDark, {
    bool isDestructive = false,
    Widget? trailing,
  }) {
    final titleColor = isDestructive 
        ? Colors.red.withAlpha(230)
        : isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230);
    final iconColor = isDestructive ? Colors.red  : isDark ? Colors.white.withAlpha(204) : Colors.black.withAlpha(204);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.white.withAlpha(153) : Colors.black.withAlpha(153),  
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else if (onTap != null)
              Icon(
                LucideIcons.chevronRight,
                size: 20,
                color: isDark ? Colors.white.withAlpha(128) : Colors.black.withAlpha(128),    
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.white.withAlpha(26),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  void _showSettingsSavedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('messages.settings_saved'.tr()),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showComingSoonSnackbar(String feature) {
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

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Terminal.One',
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
}
