import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/buttons/primary_button.dart';
import '../components/inputs/input_code_group.dart';
import '../utils/responsive_layout.dart';
import '../utils/layout_constants.dart';
import '../utils/platform_utils.dart';
import '../widgets/responsive_code_input.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/glassmorphism_scaffold.dart';
import '../widgets/platform_widgets.dart';
import '../widgets/app_logo.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_state_provider.dart';
import '../services/auth_service.dart';
import '../l10n/app_localizations.dart';
import '../examples/settings_screen_example.dart';
import 'login_screen.dart';

/// HomeScreen - Main application screen
/// 
/// StatefulWidget that serves as the primary interface for the application.
/// Uses centralized responsive design system for consistent behavior across all devices.
/// 
/// Parameters:
/// - codeLength: Number of digits for the verification code (default: 6)
/// 
/// Features:
/// - Automatic responsive layout via ResponsiveLayout wrapper
/// - Centralized code input via ResponsiveCodeInput widget
/// - Device-appropriate spacing via ResponsiveSpacing
class HomeScreen extends StatefulWidget {
  /// The number of digits required for the verification code
  final int codeLength;
  
  /// Theme provider for managing dark/light mode
  final ThemeProvider themeProvider;
  
  const HomeScreen({
    super.key,
    this.codeLength = 6, // Default to 6-digit codes
    required this.themeProvider,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variables for code input tracking and validation
  bool _isCodeComplete = false; // Flag to enable/disable verification button
  
  // Global key to control the code input widget
  final GlobalKey<InputCodeGroupState> _codeInputKey = GlobalKey<InputCodeGroupState>();
  
  // Auth-Services für Logout
  final AuthService _authService = AuthService();
  final AuthStateNotifier _authStateNotifier = AuthStateNotifier();

  /// Show platform-specific info dialog explaining what a promo code is
  void _showPromoCodeInfo(BuildContext context) {
    PlatformUtils.showPlatformDialog(
      context: context,
      title: Text(AppLocalizations.of(context)!.whatIsPromoCode),
      content: Text(
        AppLocalizations.of(context)!.promoCodeExplanation,
        style: PlatformUtils.isIOSContext(context) 
            ? const TextStyle(fontSize: 13.0)
            : Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        PlatformDialogAction(
          isDefault: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.understood),
        ),
      ],
    );
  }

  /// Logout-Funktionalität
  Future<void> _handleLogout() async {
    try {
      // Logout über AuthService
      await _authService.logout();
      
      // AuthStateNotifier über Logout informieren
      _authStateNotifier.onLogout();
      
      debugPrint('User logged out successfully');
    } catch (e) {
      debugPrint('Logout error: $e');
      // Auch bei Fehlern lokales Logout durchführen
      _authStateNotifier.onLogout();
    }
  }

  /// Logout-Bestätigung anzeigen
  void _showLogoutConfirmation() {
    PlatformUtils.showPlatformDialog(
      context: context,
      title: const Text('Abmelden'),
      content: const Text('Möchtest du dich wirklich abmelden?'),
      actions: [
        PlatformDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Abbrechen'),
        ),
        PlatformDialogAction(
          isDestructive: true,
          onPressed: () {
            Navigator.of(context).pop();
            _handleLogout();
          },
          child: const Text('Abmelden'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: Text(AppLocalizations.of(context)!.homeScreenTitle),
      actions: [
        // Settings icon button following platform guidelines
    /*    PlatformIconButton(
          icon: LucideIcons.settings,
          tooltip: 'Einstellungen',
          onPressed: () {
            // Navigate to Settings Screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
            debugPrint('Settings Screen opened');
          },
        ),
  */
        // Logout button
     /*   PlatformIconButton(
          icon: LucideIcons.logOut,
          tooltip: 'Abmelden',
          onPressed: _showLogoutConfirmation,
        ),
    */
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: ThemeToggle(
            themeMode: widget.themeProvider.themeMode,
            onThemeChanged: (ThemeMode newMode) {
              widget.themeProvider.setThemeMode(newMode);
            },
          ),
        ),
      ],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Verwende zentrale Layout-Konstante für Bottom Section
              final availableHeight = LayoutHelpers.calculateAvailableHeight(
                constraints.maxHeight,
              );
              
              return Column(
              children: [
                // Top section: Takes remaining space after bottom section
                Expanded(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: availableHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Add some top spacing
                          SizedBox(height: ResponsiveSpacing.large(context)),
                          
                          // App Logo
                          const AppLogo(
                            size: LogoSize.extraLarge,
                            variant: LogoVariant.minimal,
                          ),
                      SizedBox(height: ResponsiveSpacing.large(context)),
                      
                      // Welcome message
                      Text(
                        AppLocalizations.of(context)!.welcomeMessage,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ResponsiveSpacing.large(context)),
                      
                      // Instructions text
                      Text(
                        AppLocalizations.of(context)!.enterAccessCode,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ResponsiveSpacing.small(context)),
                      
                      // Info button for promo code explanation with platform-aware icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PlatformIconButton(
                            icon: LucideIcons.helpCircle,
                            tooltip: AppLocalizations.of(context)!.whatIsPromoCode,
                            onPressed: () {
                              _showPromoCodeInfo(context);
                            },
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              _showPromoCodeInfo(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.whatIsPromoCode,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveSpacing.large(context)),
                      
                      // Centralized responsive code input
                      ResponsiveCodeInput(
                        codeInputKey: _codeInputKey,
                        codeLength: widget.codeLength,
                        onChanged: (value) {
                          setState(() {
                            _isCodeComplete = false;
                          });
                          debugPrint('Code input: \$value');
                        },
                        onCompleted: (value) {
                          setState(() {
                            _isCodeComplete = value.length == widget.codeLength && value.isNotEmpty;
                          });
                          debugPrint('Code completed: \$value (\${widget.codeLength} digits)');
                        },
                        onValid: (isValid) {
                          setState(() {
                            _isCodeComplete = isValid;
                          });
                          debugPrint('Code validity changed: \$isValid');
                        },
                      ),
                      SizedBox(height: ResponsiveSpacing.large(context)),
                      // Primary verification button
                      PrimaryButton(
                        label: AppLocalizations.of(context)!.verifyCode,
                        enabled: _isCodeComplete,
                        onPressed: _isCodeComplete ? () {
                          // Get the current code from the widget directly
                          debugPrint('Verifying code: \${_codeInputKey.currentState?.code ?? ''}');
                        } : null,
                      ),
                      SizedBox(height: ResponsiveSpacing.medium(context)),
                      // Clear button with icon following platform guidelines
                      PlatformButton(
                        icon: LucideIcons.x,
                        isSecondary: true,
                        onPressed: () {
                          // Clear the input fields visually
                          _codeInputKey.currentState?.clearAll();
                          // Reset the local state
                          setState(() {
                            _isCodeComplete = false;
                          });
                          debugPrint('Code cleared');
                        },
                        child: Text(AppLocalizations.of(context)!.clearCode),
                      ),
                    ],
                  ),
                    ),
                  ),
                ),
                
                // Bottom section: Fixed height, always at bottom
                SizedBox(
                  height: LayoutConstants.bottomSectionHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Simple separator with text - verbesserte Sichtbarkeit
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).colorScheme.outline.withAlpha(200)
                                  : Theme.of(context).colorScheme.onSurface.withAlpha(100),
                              thickness: 2.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              AppLocalizations.of(context)!.promoCodeSignupText,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).colorScheme.outline.withAlpha(200)
                                  : Theme.of(context).colorScheme.onSurface.withAlpha(100),
                              thickness: 2.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveSpacing.large(context)),
                      PlatformButton(
                        icon: LucideIcons.logIn,
                        isSecondary: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                          debugPrint('Navigating to LoginScreen');
                        },
                        child: Text(AppLocalizations.of(context)!.toLogin),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ), // LayoutBuilder
    ), // Padding 
  ); // SafeArea
  }
}
