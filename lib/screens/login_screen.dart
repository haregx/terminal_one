import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../utils/responsive_layout.dart';
import '../widgets/glassmorphism_scaffold.dart';
import '../widgets/platform_widgets.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final AuthService _authService = AuthService();
  final AuthStateNotifier _authStateNotifier = AuthStateNotifier();
  
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isLoading = false;
  
  bool get _canLogin => _isEmailValid && _isPasswordValid && !_isLoading;

  @override
  void initState() {
    super.initState();
    
    // Setup focus traversal order for proper Tab navigation
    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus) {
        // Email field lost focus - could be due to Tab
        setState(() {});
      }
    });
    
    // Fix für Simulator: Auto-Focus auf Email-Feld nach Screen-Aufbau
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Kleine Verzögerung für bessere Simulator-Kompatibilität
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
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!_canLogin) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // API-Login-Request
      final loginResult = await _authService.login(
        context: context,
        loginname: _emailController.text.trim(),
        password: _passwordController.text,
        apiKey: EnvironmentConfig.apiKey,
      );

      if (!mounted) return;

      // Erfolgreicher Login - Auth-State aktualisieren
      debugPrint('Login successful: UserGuid=${loginResult.userGuid.substring(0, 10)}...');
      
      // Zusätzliche Login-Behandlung
      if (loginResult.isFirstLogin) {
        // TODO: Zur Willkommens-Seite navigieren
        debugPrint('First login detected');
      }
      
      if (loginResult.needsPasswordChange) {
        // TODO: Zur Passwort-Ändern-Seite navigieren
        debugPrint('Password change required');
      }
      
      // AuthStateNotifier über erfolgreichen Login informieren
      _authStateNotifier.onLoginSuccess();
      
      // AuthGuard wird automatisch auf HomeScreen wechseln

    } on ValidationException catch (e) {
      if (!mounted) return;
      // Validation-Fehler anzeigen
      _showErrorDialog(
        'Eingabefehler',
        _formatValidationErrors(e.validationErrors),
      );
    } on AuthenticationException catch (e) {
      if (!mounted) return;
      // Login fehlgeschlagen
      String userMessage;
      switch (e.message) {
        case 'Ungültiger Benutzer':
          userMessage = 'Benutzername oder Passwort ist falsch.';
          break;
        case 'Falsches Passwort':
          userMessage = 'Benutzername oder Passwort ist falsch.';
          break;
        case 'Benutzer ist gesperrt':
          userMessage = 'Dein Account ist gesperrt. Bitte kontaktiere den Support.';
          break;
        case 'E-Mail bereits vorhanden':
          userMessage = 'Diese E-Mail ist bereits registriert.';
          break;
        default:
          userMessage = e.message.isNotEmpty && e.message != 'null'
            ? e.message
            : 'Login fehlgeschlagen. Bitte überprüfe Deine Eingaben.';
      }
      _showErrorDialog(
        'Login fehlgeschlagen',
        userMessage,
      );
    } on NetworkException {
      if (!mounted) return;
      // Netzwerk-Fehler
      _showErrorDialog(
        'Verbindungsfehler',
        'Bitte prüfe deine Internetverbindung und versuche es erneut.',
      );
    } catch (e) {
      if (!mounted) return;
      // Unbekannter Fehler
      _showErrorDialog(
        'Fehler',
        'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.',
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

  /// Error-Dialog anzeigen
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

  /// Validation-Errors formatieren
  String _formatValidationErrors(Map<String, List<String>>? errors) {
    if (errors == null || errors.isEmpty) {
      return 'Bitte überprüfe deine Eingaben.';
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
        // Simulator-Fix: Verstecke Tastatur und reaktiviere Focus-System
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
            return Column(
              children: [
                // Top section: Takes remaining space after bottom section
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 600.0,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveSpacing.medium(context),
                            vertical: ResponsiveSpacing.medium(context),
                          ),
                          child: FocusTraversalGroup(
                            policy: OrderedTraversalPolicy(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // App Logo
                              const AppLogo(
                                size: LogoSize.medium,
                                variant: LogoVariant.minimal,
                              ),
                              SizedBox(height: ResponsiveSpacing.large(context)),
                              
                              // Description
                              Text(
                                localizations.loginDescription,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: ResponsiveSpacing.large(context)),
                              
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
                                  onChanged: (email) {
                                    // Optional: Additional logic on email change
                                  },
                                  onSubmitted: (_) {
                                    // Bei Enter/Tab: Fokus auf Passwort-Feld
                                    _passwordFocus.requestFocus();
                                  },
                                ),
                              ),
                              
                              SizedBox(height: ResponsiveSpacing.medium(context)),
                              
                              // Password Input
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
                                  onChanged: (password) {
                                    // Optional: Additional logic on password change
                                  },
                                  onSubmitted: (_) {
                                    // Bei Enter: Login ausführen (falls bereit)
                                    if (_canLogin) {
                                      _handleLogin();
                                    }
                                  },
                                ),
                              ),
                              
                              SizedBox(height: ResponsiveSpacing.medium(context)),
                              
                              // Forgot password button
                              PlatformButton(
                                icon: LucideIcons.helpCircle,
                                isSecondary: true,
                                onPressed: () {
                                  _navigateToPasswordRequest();
                                  debugPrint('Navigating to Password Request');
                                },
                                child: Text(localizations.forgotPin),
                              ),
                              
                              SizedBox(height: ResponsiveSpacing.large(context)),
                              
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
                ),
                
                // Bottom section: Navigation only
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveSpacing.medium(context),
                    vertical: ResponsiveSpacing.medium(context),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Divider with "or" text
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.8)
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                              thickness: 1.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              localizations.or,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.8)
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                              thickness: 1.0,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: ResponsiveSpacing.medium(context)),
                      
                      // Registration navigation button
                      PlatformButton(
                        icon: LucideIcons.userPlus,
                        isSecondary: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                          debugPrint('Navigating to RegisterScreen');
                        },
                        child: Text(localizations.toRegistration),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      ), // GestureDetector schließen
    );
  }
}