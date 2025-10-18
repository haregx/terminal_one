import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/screens/settings/functions/build_about_section.dart';
import 'package:terminal_one/screens/settings/functions/build_appearence_section.dart';
import 'package:terminal_one/screens/settings/functions/build_language_section.dart';
import 'package:terminal_one/screens/settings/functions/build_notofication_section.dart';
import 'package:terminal_one/screens/settings/functions/build_privacy_section.dart';
import 'package:terminal_one/screens/settings/functions/build_reset_all_section.dart';
import 'package:terminal_one/screens/settings/functions/build_storage_section.dart';
import 'package:terminal_one/screens/settings/functions/load_settings.dart';
import 'package:terminal_one/widgets/spacer/responsive_spacer.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/widgets/app_logo.dart';
import 'package:terminal_one/widgets/appbar_aware_safe_area.dart';
import 'package:terminal_one/widgets/glassmorphism_scaffold.dart';

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
    _scrollController = ScrollController()..addListener(_onScroll);
    // Start animation
    _fadeController.forward();
    // Load saved settings
    loadSettings(context);
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
                      buildAppearanceSection( context, themeProvider, isDark),

                      // Notifications Settings
                      buildNotificationsSection(
                        context,
                        isDark,
                        _notificationsEnabled,
                        _soundEnabled,
                        _vibrationEnabled,
                        ({notificationsEnabled, soundEnabled, vibrationEnabled}) {
                          setState(() {
                            if (notificationsEnabled != null) _notificationsEnabled = notificationsEnabled;
                            if (soundEnabled != null) _soundEnabled = soundEnabled;
                            if (vibrationEnabled != null) _vibrationEnabled = vibrationEnabled;
                          });
                        },
                      ),

                      // Privacy & Security
                      buildPrivacySection(
                        context,
                        isDark,
                        _analyticsEnabled,
                        _crashReportsEnabled,
                        ( {bool? analyticsEnabled, bool? crashReportsEnabled} ) {
                          setState(() {
                            if (analyticsEnabled != null) _analyticsEnabled = analyticsEnabled;
                            if (crashReportsEnabled != null) _crashReportsEnabled = crashReportsEnabled;
                          });
                        },
                      ),

                      // Language & Region
                      buildLanguageSection( 
                        context,
                        isDark,
                        _selectedLanguageCode,
                        _selectedRegionCode,
                        ({String? selectedLanguageCode, String? selectedRegionCode}) {
                          setState(() {
                            if (selectedLanguageCode != null) {
                              _selectedLanguageCode = selectedLanguageCode;
                              context.setLocale(Locale(selectedLanguageCode));
                            }
                            if (selectedRegionCode != null) {
                              _selectedRegionCode = selectedRegionCode;
                            }
                          });
                        },
                      ),

                      // Storage & Cache
                      buildStorageSection(context, isDark),

                      // About & Support
                      buildAboutSection(context, isDark),

                      // Danger Zone
                      SizedBox(height: ResponsiveSpacing.small(context)),
                      // Reset Settings
                      buildDangerZoneSection(context, isDark),
                      
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
}
