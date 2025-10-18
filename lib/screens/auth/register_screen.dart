import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/widgets/buttons/button3d.dart';
import 'package:terminal_one/widgets/spacer/responsive_spacer.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../widgets/inputs/input_email.dart';
import '../../widgets/inputs/input_password_extended.dart';
import '../../widgets/inputs/input_password_confirm.dart';
import '../../widgets/switches/text_right_switch.dart';
import 'package:terminal_one/api_services/auth/register_service.dart';
import 'package:terminal_one/api_services/https_post_service.dart';

import '../statics/privacy_screen.dart';

/// RegisterScreen - User registration form
/// 
/// This screen provides a registration form using the same modern input components
/// as the login screen, following the consistent design patterns.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _privacyAccepted = false;
  bool _isLoading = false;
  final RegisterService _registerService = RegisterService();

  // Handles the registration process, including API call and error handling
  
  // Controllers and focus nodes for form fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  String _currentPassword = ''; // Track password for InputPasswordConfirm
  
  // Returns true if the register button should be enabled
  bool get _canRegister => _isEmailValid && _isPasswordValid && _isConfirmPasswordValid && _privacyAccepted;

  @override
  void initState() {
    super.initState();
    // Listen to password changes to update the confirm password validation
    _passwordController.addListener(() {
      setState(() {
        _currentPassword = _passwordController.text;
      });
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
    _confirmPasswordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _handleRegistration() async {
    if (!_canRegister || _isLoading) return;
    setState(() => _isLoading = true);
    final result = await _registerService.register(
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );
    setState(() => _isLoading = false);
    if (!mounted) return;
    if (result.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('auth.register_success'.tr())),
      );
      Navigator.of(context).pop(_emailController.text.trim());
    } else {
      HttpsErrorHandler.handle(context, result.error as Object);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && _emailController.text.isEmpty) {
            _emailFocus.requestFocus();
          }
        });
      },
      child: GlassmorphismScaffold(
      //  title: Text('auth.register_title'.tr()),
        body: AppBarAwareSafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 600.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: FocusTraversalGroup(
                              policy: OrderedTraversalPolicy(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: ResponsiveSpacing.large(context),
                                children: [
                                  const AppLogo(size: LogoSize.medium, variant: LogoVariant.minimal),
                                  Text(
                                    'auth.register_description'.tr(),
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
                                        setState(() { _isEmailValid = isValid; });
                                      },
                                      onSubmitted: (_) { _passwordFocus.requestFocus(); },
                                    ),
                                  ),
                                  FocusTraversalOrder(
                                    order: const NumericFocusOrder(2),
                                    child: InputPasswordExtended(
                                      controller: _passwordController,
                                      focusNode: _passwordFocus,
                                      textInputAction: TextInputAction.next,
                                      onValidationChanged: (isValid) {
                                        setState(() { _isPasswordValid = isValid; });
                                      },
                                      onSubmitted: (_) { _confirmPasswordFocus.requestFocus(); },
                                    ),
                                  ),
                                  FocusTraversalOrder(
                                    order: const NumericFocusOrder(3),
                                    child: InputPasswordConfirm(
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmPasswordFocus,
                                      textInputAction: TextInputAction.done,
                                      originalPassword: _currentPassword,
                                      onValidationChanged: (isValid) {
                                        setState(() { _isConfirmPasswordValid = isValid; });
                                      },
                                      onSubmitted: (_) {
                                        if (_canRegister && !_isLoading) {
                                          _handleRegistration();
                                        }
                                      },
                                    ),
                                  ),
                                  SimpleSwitchLeftWithText(
                                    value: _privacyAccepted,
                                    onChanged: (val) {
                                      setState(() { _privacyAccepted = val; });
                                    },
                                      onLabelTap: () async {
                                        var result = await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => PrivacyScreen(showBottomButtons: true,),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() { _privacyAccepted = result; });
                                        }
                                      },
                                    label: 'auth.privacy_policy_accept'.tr(),
                                  ),
                                  IntrinsicWidth(
                                    child: Button3D(
                                      label: 'auth.register_button'.tr(),
                                      enabled: _canRegister && !_isLoading,
                                      onPressed: _canRegister && !_isLoading ? _handleRegistration : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}