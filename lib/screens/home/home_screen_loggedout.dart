import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:terminal_one/components/buttons/ghost_button.dart';
import 'package:terminal_one/components/buttons/secondary_button.dart';
import 'package:terminal_one/components/snackbars/fancy_success_snackbar.dart';
import 'package:terminal_one/components/spacer/separator_withtext.dart';
import 'package:terminal_one/providers/auth_provider.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/inputs/input_code_group.dart';
import '../../utils/platform_utils.dart';
import '../../widgets/responsive_code_input.dart';
import '../../widgets/theme_toggle.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../providers/theme_provider.dart';
import '../../l10n/app_localizations.dart';
import '../auth/login_screen.dart';
import '../games/more_games.dart';

class HomeScreen extends StatefulWidget {
  final int codeLength;
  const HomeScreen({
    super.key,
    this.codeLength = 6,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isCodeComplete = false;
  final GlobalKey<InputCodeGroupState> _codeInputKey = GlobalKey<InputCodeGroupState>();
  //final AuthService _authService = AuthService();
  //final AuthStateNotifier _authStateNotifier = AuthStateNotifier();

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

  /*Future<void> _handleLogout() async {
    try {
      await _authService.logout();
      _authStateNotifier.onLogout();
      debugPrint('User logged out successfully');
    } catch (e) {
      debugPrint('Logout error: $e');
      _authStateNotifier.onLogout();
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GlassmorphismScaffold(
      title: Text(''),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: ThemeToggle(
            themeMode: themeProvider.themeMode,
            onThemeChanged: (ThemeMode newMode) {
              themeProvider.setThemeMode(newMode);
            },
          ),
        ),
        if (Provider.of<AuthProvider>(context).isLoggedIn)
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              debugPrint('🚪 User logged out.');
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                FancySuccessSnackbar.build('You have been logged out.'),
              );
              await Provider.of<AuthProvider>(context, listen: false).setLoggedIn(false);
            },
          ),
      ],
      body: AppBarAwareSafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: ResponsiveSpacing.large(context),
                          children: [
                            SizedBox(height: ResponsiveSpacing.large(context)),
                            const AppLogo(
                              size: LogoSize.extraLarge,
                              variant: LogoVariant.minimal,
                            ),
                            Text(
                              AppLocalizations.of(context)!.welcomeMessage,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              AppLocalizations.of(context)!.enterAccessCode,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            GhostButton(
                              leading: LucideIcons.helpCircle,
                              label: AppLocalizations.of(context)!.whatIsPromoCode,
                              onPressed: () {
                                _showPromoCodeInfo(context);
                              },
                            ),
                            ResponsiveCodeInput(
                              codeInputKey: _codeInputKey,
                              codeLength: widget.codeLength,
                              onChanged: (value) {
                                setState(() {
                                  _isCodeComplete = false;
                                });
                                debugPrint('Code input: $value');
                              },
                              onCompleted: (value) {
                                setState(() {
                                  _isCodeComplete = value.length == widget.codeLength && value.isNotEmpty;
                                });
                                debugPrint('Code completed: $value (${widget.codeLength} digits)');
                              },
                              onValid: (isValid) {
                                setState(() {
                                  _isCodeComplete = isValid;
                                });
                                debugPrint('Code validity changed: $isValid');
                              },
                            ),
                            PrimaryButton(
                              label: AppLocalizations.of(context)!.verifyCode,
                              enabled: _isCodeComplete,
                              onPressed: _isCodeComplete ? () {
                                debugPrint('Verifying code: ${_codeInputKey.currentState?.code ?? ''}');
                              } : null,
                            ),
                            GhostButton(
                              leading: LucideIcons.x,
                              onPressed: () {
                                _codeInputKey.currentState?.clearAll();
                                setState(() {
                                  _isCodeComplete = false;
                                });
                                debugPrint('Code cleared');
                              },
                              label: AppLocalizations.of(context)!.clearCode,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: ResponsiveSpacing.large(context),
                            children: [
                              SeparatorWithText(
                                text: Provider.of<AuthProvider>(context).isLoggedIn
                                  ? 'Mehr Promo-Codes?'
                                  : AppLocalizations.of(context)!.promoCodeSignupText,
                              ),
                              SecondaryButton(
                                onPressed: () {
                                  if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MoreGamesScreen(),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                    );
                                  }
                                },
                                leading: Provider.of<AuthProvider>(context).isLoggedIn
                                  ? LucideIcons.gamepad2
                                  : LucideIcons.logIn,
                                label: Provider.of<AuthProvider>(context).isLoggedIn
                                  ? 'Mehr Promo-Codes'
                                  : AppLocalizations.of(context)!.toLogin,
                              ),
                            ],
                        
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
