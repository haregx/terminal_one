import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../components/buttons/primary_button.dart';
import '../components/inputs/input_email.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../config/api_config.dart';
import '../widgets/app_logo.dart';
import '../widgets/glassmorphism_scaffold.dart';

/// PasswordRequestScreen - Screen for requesting password reset
/// 
/// Simple screen that allows users to enter their email address
/// to receive password reset instructions.
class PasswordRequestScreen extends StatefulWidget {
  const PasswordRequestScreen({super.key});

  @override
  State<PasswordRequestScreen> createState() => _PasswordRequestScreenState();
}

class _PasswordRequestScreenState extends State<PasswordRequestScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  bool _isEmailValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    
    // Initial validation check
    _validateInitialState();
    
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

  void _validateInitialState() {
    // Beim Start ist das Feld leer, also Button deaktiviert
    setState(() {
      _isEmailValid = _emailController.text.isNotEmpty && 
                     _emailController.text.contains('@') && 
                     _emailController.text.contains('.');
    });
  }

  Future<void> _handlePasswordRequest() async {
    if (!_isEmailValid) return;
    final authService = AuthService();
    try {
        final result = await authService.passwordRequest(
          context: context,
        loginname: _emailController.text.trim(),
        apiKey: ApiConfig.apiKey,
      );
      if (!mounted) return;
      if (result.code == 0) {
        final email = _emailController.text.trim();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.passwordRequestSuccess(email)),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        Navigator.of(context).pop(email);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage.isNotEmpty && result.errorMessage != 'null'
                ? result.errorMessage
                : AppLocalizations.of(context)!.passwordRequestFailed),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.genericError),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: Text(AppLocalizations.of(context)!.passwordRequest),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_emailFocus);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FocusTraversalGroup(
                            policy: OrderedTraversalPolicy(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const AppLogo(
                                  size: LogoSize.medium,
                                  variant: LogoVariant.minimal,
                                ),
                                const SizedBox(height: 20),
                                Text(AppLocalizations.of(context)!.passwordRequestDescription,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                FocusTraversalOrder(
                                  order: const NumericFocusOrder(1),
                                  child: CallbackShortcuts(
                                    bindings: {
                                      const SingleActivator(LogicalKeyboardKey.tab): () {
                                        _handlePasswordRequest();
                                      },
                                    },
                                    child: InputEmail(
                                      controller: _emailController,
                                      focusNode: _emailFocus,
                                      onSubmitted: (_) => _handlePasswordRequest(),
                                      onValidationChanged: (isValid) {
                                        if (kDebugMode) {
                                          print('Email validation changed: $isValid, text: "${_emailController.text}"');
                                        }
                                        setState(() {
                                          _isEmailValid = isValid;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                PrimaryButton(
                                  label: AppLocalizations.of(context)!.sendPasswordRequest,
                                  enabled: _isEmailValid,
                                  onPressed: _isEmailValid ? _handlePasswordRequest : null,
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
    );
  }
}