import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/responsive_layout.dart';
import '../utils/layout_constants.dart';
import '../widgets/glassmorphism_scaffold.dart';
import '../widgets/app_logo.dart';
import '../components/buttons/primary_button.dart';
import '../components/inputs/input_email.dart';
import '../components/inputs/input_password.dart';
import '../components/inputs/input_password_confirm.dart';
import '../services/auth_service.dart';
import '../services/api_exceptions.dart';

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
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // Handles the registration process, including API call and error handling
  Future<void> _performRegistration() async {
    setState(() { _isLoading = true; });
    try {
      final result = await _authService.register(
        context: context,
        loginname: _emailController.text,
        emailAddress: _emailController.text,
        password: _passwordController.text,
        apiKey: 'TERMINAL_ONE_DEV_KEY', // Consider loading from config
      );
      if (result.isSuccessfulRegister) {
        debugPrint('Registration successful: PubGuid=${result.pubGuid}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your account has been created successfully!')),
        );
      } else {
        debugPrint('Registration failed: ${result.errorMessage}');
        String userMessage;
        switch (result.code) {
          case 2001:
            userMessage = 'This email is already registered.';
            break;
          case 2000:
            userMessage = 'This login name is already taken.';
            break;
          case 1005:
            userMessage = 'The password is not secure enough.';
            break;
          case 1012:
            userMessage = 'Invalid email address.';
            break;
          default:
            userMessage = result.errorMessage.isNotEmpty && result.errorMessage != 'null'
              ? result.errorMessage
              : 'Registration failed. Please check your input.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(userMessage)),
        );
      }
    } catch (e, stack) {
      debugPrint('Registration error: $e\n$stack');
      String userMessage = 'An error occurred. Please try again later.';
      if (e is AuthenticationException) {
        final authEx = e;
        if (authEx.message.isNotEmpty && authEx.message != 'null') {
          userMessage = authEx.message;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userMessage)),
      );
    } finally {
      setState(() { _isLoading = false; });
    }
  }
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
  bool get _canRegister => _isEmailValid && _isPasswordValid && _isConfirmPasswordValid;

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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
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
        title: Text(localizations.registerTitle),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  // Top section: Takes remaining space after bottom section
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 600.0, // Same constraint as ResponsiveLayout
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: FocusTraversalGroup(
                              policy: OrderedTraversalPolicy(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: ResponsiveSpacing.large(context),
                                children: [
                                  // App Logo
                                  const AppLogo(
                                    size: LogoSize.medium,
                                    variant: LogoVariant.minimal,
                                  ),
                                  // Description
                                  Text(
                                    localizations.registerDescription,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  // Email Input
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
                                        // On Enter/Tab: focus password field
                                        _passwordFocus.requestFocus();
                                      },
                                    ),
                                  ),
                                  // Password Input
                                  FocusTraversalOrder(
                                    order: const NumericFocusOrder(2),
                                    child: InputPassword(
                                      controller: _passwordController,
                                      focusNode: _passwordFocus,
                                      textInputAction: TextInputAction.next,
                                      onValidationChanged: (isValid) {
                                        setState(() {
                                          _isPasswordValid = isValid;
                                        });
                                      },
                                      onSubmitted: (_) {
                                        // On Enter/Tab: focus confirm password field
                                        _confirmPasswordFocus.requestFocus();
                                      },
                                    ),
                                  ),
                                  // Confirm Password Input
                                  FocusTraversalOrder(
                                    order: const NumericFocusOrder(3),
                                    child: InputPasswordConfirm(
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmPasswordFocus,
                                      textInputAction: TextInputAction.done,
                                      originalPassword: _currentPassword,
                                      onValidationChanged: (isValid) {
                                        setState(() {
                                          _isConfirmPasswordValid = isValid;
                                        });
                                      },
                                      onSubmitted: (_) {
                                        if (_canRegister && !_isLoading) {
                                          _performRegistration();
                                        }
                                      },
                                    ),
                                  ),
                                  // Register button
                                  PrimaryButton(
                                    label: localizations.registerButton,
                                    enabled: _canRegister && !_isLoading,
                                    onPressed: _canRegister && !_isLoading ? _performRegistration : null,
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