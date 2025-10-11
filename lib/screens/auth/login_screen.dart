import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:terminal_one/api_services/auth/login_service.dart';
import 'package:terminal_one/api_services/https_post_service.dart';
import 'package:terminal_one/components/buttons/ghost_button.dart';
import 'package:terminal_one/components/buttons/secondary_button.dart';
import 'package:terminal_one/components/inputs/input_password_simple.dart';
import 'package:terminal_one/components/snackbars/fancy_success_snackbar.dart';
import 'package:terminal_one/components/spacer/separator_withtext.dart';
import 'package:terminal_one/providers/auth_provider.dart';
import '../../utils/responsive_layout.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/inputs/input_email.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/secure_storage.dart';
import '../home/home_screen_router.dart';
import 'register_screen.dart';
import 'password_request_screen.dart';
import 'pincode_screen.dart';

/// LoginScreen - Enhanced login screen with consistent design
///
/// This screen uses the same layout pattern as RegisterScreen and PasswordRequestScreen
/// for a consistent user experience across all authentication screens.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Navigates to the password reset screen and updates the email field if a result is returned
  void _navigateToPasswordRequest() async {
    final result = await Navigator.of(context).push<String?>(
      MaterialPageRoute(builder: (context) => const PasswordRequestScreen()),
    );
    if (result != null && result.isNotEmpty) {
      setState(() {
        _emailController.text = result;
      });
    }
  }
  // Controllers and focus nodes for form fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isLoading = false;
  
  // Returns true if the login button should be enabled
  bool get _canLogin => _isEmailValid && _isPasswordValid && !_isLoading;

  @override
  void initState() {
    super.initState();
    
    // Listen for focus changes to update UI when email field loses focus
    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus) {
        setState(() {});
      }
    });
    
    // Autofocus the email field after the screen is built (for simulator/dev convenience)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            _emailFocus.requestFocus();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  final LoginService _loginService = LoginService();

  void _handleLogin() async {
    if (!_canLogin) return;
    setState(() => _isLoading = true);
    final result = await _loginService.login(
      _emailController.text,
      _passwordController.text,
    );
    setState(() => _isLoading = false);
    if (!mounted) return;
    if (result.isSuccess) {
      if (result.hasRestrictions) {
        debugPrint('🗝️ Login JSON (with restrictions): ${result.data.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          FancySuccessSnackbar.build('Login successful, but with restrictions.'),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PincodeScreen(pubGuid: result.data['pubGuid'].toString(), confirmedIdent: result.data['confirmedIdent'].toString())),
        );
      } else {
        debugPrint('🗝️ Login JSON: ${result.data.toString()}');
        // Write userGuid to secure storage
        final userGuid = result.data['userGuid']?.toString();
        if (userGuid != null && userGuid.isNotEmpty) {
          try {
            await SecureStorage.writeUserGuid(userGuid);
            debugPrint('🔒 userGuid saved to secure storage: $userGuid');
            if (!mounted) return;
            Provider.of<AuthProvider>(context, listen: false).setLoggedIn(true);
            ScaffoldMessenger.of(context).showSnackBar(
              FancySuccessSnackbar.build('You have been successfully logged in!'),
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreenRouter(), ), (route) => false,
            );
          } catch (e, stack) {
            debugPrint('❌ Failed to save userGuid: $e\n$stack');
          }
        }
      }
    } else {
      HttpsErrorHandler.handle(context, result.error as Object);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide keyboard and refocus email field if empty (simulator/dev convenience)
        FocusScope.of(context).unfocus();
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && _emailController.text.isEmpty) {
            _emailFocus.requestFocus();
          }
        });
      },
      child: GlassmorphismScaffold(
        title: Text('auth.login'.tr()),
        body: AppBarAwareSafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Main login form area (expanded)
                        Expanded(
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 600.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: FocusTraversalGroup(
                                  policy: OrderedTraversalPolicy(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: ResponsiveSpacing.large(context),
                                    children: [
                                      // App logo
                                      const AppLogo(
                                        size: LogoSize.medium,
                                        variant: LogoVariant.minimal,
                                      ),
                                      Text(
                                        'auth.login_description'.tr(),
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      FocusTraversalOrder(
                                        order: const NumericFocusOrder(1),
                                        child: InputEmail(
                                          controller: _emailController,
                                          focusNode: _emailFocus,
                                          textInputAction: TextInputAction.next,
                                          onValidationChanged: (isValid) {
                                            setState(() {
                                              _isEmailValid = isValid;
                                            });
                                          },
                                          onSubmitted: (_) {
                                            _passwordFocus.requestFocus();
                                          },
                                        ),
                                      ),
                                      FocusTraversalOrder(
                                        order: const NumericFocusOrder(2),
                                        child: InputPasswordSimple(
                                          controller: _passwordController,
                                          focusNode: _passwordFocus,
                                          textInputAction: TextInputAction.done,
                                          onValidationChanged: (isValid) {
                                            setState(() {
                                              _isPasswordValid = isValid;
                                            });
                                          },
                                          onSubmitted: (_) => _handleLogin(),
                                        ),
                                      ),
                                      GhostButton(
                                        leading: LucideIcons.helpCircle,
                                        onPressed: _navigateToPasswordRequest,
                                        label: 'auth.forgot_pin'.tr(),
                                      ),
                                      // Login button
                                      PrimaryButton(
                                        label: 'auth.login'.tr(),
                                        enabled: _canLogin,
                                        onPressed: _canLogin ? _handleLogin : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Bottom area: registration prompt and button
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: ResponsiveSpacing.large(context),
                            children: [
                              // Registration separator text (internationalized)
                              SeparatorWithText(text: 'auth.no_account'.tr()),
                              // Registration button
                              SecondaryButton(
                                leading: LucideIcons.userPlus,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterScreen(),
                                    ),
                                  );
                                },
                                label: 'auth.to_registration'.tr(),
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
      ),
    );
  }
}


