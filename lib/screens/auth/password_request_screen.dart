import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:terminal_one/api_services/auth/password_request_service.dart';
import 'package:terminal_one/api_services/simple_https_post.dart';
import 'package:terminal_one/components/snackbars/fancy_success_snackbar.dart';
import 'package:terminal_one/utils/layout_constants.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/inputs/input_email.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/glassmorphism_scaffold.dart';

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
  // Controller for the email input field
  final TextEditingController _emailController = TextEditingController();
  // Focus node for the email input field
  final FocusNode _emailFocus = FocusNode();
  // Tracks if the entered email is valid
  bool _isEmailValid = false;

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    
    // Initial validation check for the email field
    _validateInitialState();
    
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

  // Checks the initial state of the email field and updates the button state
  void _validateInitialState() {
    setState(() {
      _isEmailValid = 
        _emailController.text.isNotEmpty && 
        _emailController.text.contains('@') && 
        _emailController.text.contains('.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: Text(AppLocalizations.of(context)!.passwordRequest),
      body: GestureDetector(
        onTap: () {
           // Hide keyboard and refocus email field if empty (simulator/dev convenience)
          FocusScope.of(context).unfocus();
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted && _emailController.text.isEmpty) {
              _emailFocus.requestFocus();
            }
          });
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Main content area (expanded)
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
                                // App logo
                                const AppLogo(
                                  size: LogoSize.medium,
                                  variant: LogoVariant.minimal,
                                ),
                                SizedBox(height: ResponsiveSpacing.large(context)),
                                // Description text
                                Text(AppLocalizations.of(context)!.passwordRequestDescription,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                                  ),
                                ),
                                SizedBox(height: ResponsiveSpacing.large(context)),
                                // Email input field with keyboard shortcut for submit
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
                                 SizedBox(height: LayoutConstants.codeInputButtonSpacing),
                                // Button to send password reset request
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
  
  final PasswordRequestService _passwordRequestService = PasswordRequestService();

  void _handlePasswordRequest() async {
    if (!_isEmailValid) return;
    //setState(() { _isLoading = true; });
    final result = await _passwordRequestService.requestPassword(_emailController.text);
    //setState(() { _isLoading = false; });
    if (!mounted) return;
    if (result.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        FancySuccessSnackbar.build('Dir wurde an deine E-Mail-Adresse ${_emailController.text.trim()} ein neues Kennwort gesendet.'),
      );
      Navigator.of(context).pop(_emailController.text.trim());
    } else {
      HttpsErrorHandler.handle(context, result.error as Object);
    }
    // End of _handlePasswordRequest
  }
}