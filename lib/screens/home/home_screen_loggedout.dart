import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/widgets/buttons/button3d.dart';
import 'package:terminal_one/widgets/buttons/ghost_button.dart';
import 'package:terminal_one/widgets/spacer/dividors.dart';
import 'package:terminal_one/screens/games/game_details_screen.dart';
import 'package:terminal_one/widgets/spacer/responsive_spacer.dart';
import '../../widgets/inputs/input_code_group.dart';
import '../../utils/platform_utils.dart';
import '../../widgets/responsive_code_input.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import 'package:easy_localization/easy_localization.dart';
import '../auth/login_screen.dart';
import '../settings/settings_screen.dart';
import '../statics/privacy_screen.dart';

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
  String _codeValue = '';
  final GlobalKey<InputCodeGroupState> _codeInputKey = GlobalKey<InputCodeGroupState>();
  
  final bool _isProcessing = false;
  //final AuthService _authService = AuthService();
  //final AuthStateNotifier _authStateNotifier = AuthStateNotifier();

  void _showPromoCodeInfo(BuildContext context) {
    PlatformUtils.showPlatformDialog(
      context: context,
      title: Text('home.what_is_promo_code'.tr()),
      content: Text(
        'home.promo_code_explanation'.tr(),
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
          child: Text('home.understood'.tr()),
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
    return GlassmorphismScaffold(
      title: Text(''),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.shield),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyScreen(showBottomButtons: false,),
              ),
            );
          },
          tooltip: 'navigation.privacy_policy'.tr(),
        ),
        IconButton(
          icon: const Icon(LucideIcons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          },
          tooltip: 'navigation.settings'.tr(),
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
                              size: LogoSize.large,
                              variant: LogoVariant.minimal,
                            ),

                            Text(
                              'home.welcome_message'.tr(),
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            Text(
                              'home.enter_access_code'.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),

                            GhostButton(
                              leading: LucideIcons.helpCircle,
                              label: 'home.what_is_promo_code'.tr(),
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
                                  _codeValue = value;
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
                            
                            IntrinsicWidth(
                              child: Button3D(
                                label: _isProcessing ? 'common.loading'.tr() : 'promocode.redeem'.tr(),
                                leadingIcon: _isProcessing ? null : LucideIcons.gift,
                                enabled: _isCodeComplete,
                                onPressed: _isCodeComplete ? () {
                                  debugPrint('Verifying code: ${_codeInputKey.currentState?.code ?? ''}');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GameDetailsScreen(),
                                    ),
                                  );
                                } : null,
                              ),
                            ),

                            _codeValue.isNotEmpty
                              ? GhostButton(
                                  leading: LucideIcons.x,
                                  onPressed: () {
                                    _codeInputKey.currentState?.clearAll();
                                    setState(() {
                                      _isCodeComplete = false;
                                    });
                                    debugPrint('Code cleared');
                                  },
                                  label: 'home.clear_code'.tr(),
                                )
                              : const SizedBox.shrink(),
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
                                  text: 'home.promo_code_signup_text'.tr(),
                              ),
                              IntrinsicWidth(
                                child: Button3D(
                                  isSecondary: true,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  leadingIcon: LucideIcons.logIn,
                                  label: 'home.to_login'.tr(),
                                ),
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
