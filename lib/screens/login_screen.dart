import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/components/buttons/ghost_button.dart';
import 'package:terminal_one/components/buttons/secondary_button.dart';
import 'package:terminal_one/components/spacer/separator_withtext.dart';
import '../utils/responsive_layout.dart';
import '../widgets/glassmorphism_scaffold.dart';
import '../widgets/app_logo.dart';
import '../components/buttons/primary_button.dart';
import '../components/inputs/input_email.dart';
import '../components/inputs/input_password.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../services/api_exceptions.dart';
import '../providers/auth_state_provider.dart';
import '../config/api_config.dart';
import 'register_screen.dart';
import 'password_request_screen.dart';

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
  final AuthService _authService = AuthService();
  final AuthStateNotifier _authStateNotifier = AuthStateNotifier();
  
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

  // Handles the login process, including API call and error handling
  void _handleLogin() async {
    if (!_canLogin) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // API login request
      final loginResult = await _authService.login(
        context: context,
        loginname: _emailController.text.trim(),
        password: _passwordController.text,
        apiKey: EnvironmentConfig.apiKey,
      );

      if (!mounted) return;

      debugPrint('Login successful with code: ${loginResult.code}');
      // Handle successful login
      if (loginResult.code == 0) {
        debugPrint('Login successful: UserGuid=${loginResult.userGuid.substring(0, 10)}...');
      }
      debugPrint('Login successful: PubGuid=${loginResult.pubGuid.substring(0, 10)}...');

      // handle PIN required
      if (loginResult.code == 1) {
        // TODO: Navigate to PIN Page
        debugPrint('Authenticated with restrictions');
      }

      // Additional login handling for first login or password change
      if (loginResult.isFirstLogin) {
        // TODO: Navigate to welcome page
        debugPrint('First login detected');
      }
      
      if (loginResult.needsPasswordChange) {
        // TODO: Navigate to password change page
        debugPrint('Password change required');
      }
      
      // Notify AuthStateNotifier of successful login
      _authStateNotifier.onLoginSuccess();
      // AuthGuard will automatically navigate to HomeScreen

    } on ValidationException catch (e) {
      if (!mounted) return;
      // Show validation errors
      _showErrorDialog(
        'Input error',
        _formatValidationErrors(e.validationErrors),
      );
    } on AuthenticationException catch (e) {
      if (!mounted) return;
      // Show authentication errors with user-friendly messages
      String userMessage;
      switch (e.message) {
        case 'Ungültiger Benutzer':
          userMessage = 'Username or password is incorrect.';
          break;
        case 'Falsches Passwort':
          userMessage = 'Username or password is incorrect.';
          break;
        case 'Benutzer ist gesperrt':
          userMessage = 'Your account is locked. Please contact support.';
          break;
        case 'E-Mail bereits vorhanden':
          userMessage = 'This email is already registered.';
          break;
        default:
          userMessage = e.message.isNotEmpty && e.message != 'null'
            ? e.message
            : 'Login failed. Please check your credentials.';
      }
      _showErrorDialog(
        'Login failed',
        userMessage,
      );
    } on NetworkException {
      if (!mounted) return;
      // Show network error
      _showErrorDialog(
        'Connection error',
        'Please check your internet connection and try again.',
      );
    } catch (e) {
      if (!mounted) return;
      // Show unknown error
      _showErrorDialog(
        'Error',
        'An unexpected error occurred. Please try again.',
      );
      debugPrint('Unexpected login error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Shows an error dialog with the given title and message
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Formats validation errors for display in the error dialog
  String _formatValidationErrors(Map<String, List<String>>? errors) {
    if (errors == null || errors.isEmpty) {
      return 'Please check your input.';
    }

    final buffer = StringBuffer();
    errors.forEach((field, messages) {
      for (final message in messages) {
        buffer.writeln('• $message');
      }
    });

    return buffer.toString().trim();
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
        title: Text(localizations.login),
        body: SafeArea(
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
                                        localizations.loginDescription,
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
                                        child: InputPassword(
                                          controller: _passwordController,
                                          focusNode: _passwordFocus,
                                          textInputAction: TextInputAction.done,
                                          onValidationChanged: (isValid) {
                                            setState(() {
                                              _isPasswordValid = isValid;
                                            });
                                          },
                                          onSubmitted: (_) {
                                            if (_canLogin) _handleLogin();
                                          },
                                        ),
                                      ),
                                      GhostButton(
                                        leading: LucideIcons.helpCircle,
                                        onPressed: _navigateToPasswordRequest,
                                        label: localizations.forgotPin,
                                      ),
                                      // Login button
                                      PrimaryButton(
                                        label: localizations.login,
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
                              SeparatorWithText(text: 'Noch kein Konto?'),
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
                                label: localizations.toRegistration,
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