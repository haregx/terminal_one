import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../utils/layout_constants.dart';
import '../../l10n/app_localizations.dart';
import 'input_defaults.dart';

/// Platform-aware email input component with comprehensive validation
/// 
/// Features:
/// - Responsive design integrated with project's ResponsiveLayout system
/// - Platform-specific styling (iOS/Android)
/// - Internationalization support via AppLocalizations
/// - Real-time email validation with visual feedback
/// - Accessibility support
/// - Proper memory management
/// - Consistent with project's design patterns
class InputEmail extends StatefulWidget {
  /// Text controller for the email input
  final TextEditingController? controller;
  
  /// Callback triggered when validation state changes
  final void Function(bool isValid)? onValidationChanged;
  
  /// Callback triggered when email value changes
  final void Function(String email)? onChanged;
  
  /// Custom label text (defaults to localized text)
  final String? label;
  
  /// Custom hint text (defaults to localized text)  
  final String? hint;
  
  /// Custom error message override
  final String? customErrorMessage;
  
  /// Whether the input is enabled
  final bool enabled;
  
  /// Focus node for managing focus
  final FocusNode? focusNode;
  
  /// Text input action for keyboard
  final TextInputAction textInputAction;
  
  /// Whether to validate on every change or only on submit
  final bool validateRealTime;
  
  /// Whether to show clear button (iOS style)
  final bool showClearButton;

  /// Callback triggered when submit action is performed (Enter/Tab)
  final void Function(String email)? onSubmitted;

  const InputEmail({
    super.key,
    this.controller,
    this.onValidationChanged,
    this.onChanged,
    this.onSubmitted,
    this.label,
    this.hint,
    this.customErrorMessage,
    this.enabled = true,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.validateRealTime = true,
    this.showClearButton = true,  });

  @override
  State<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _errorText;
  bool _isValid = false;
  bool _hasBeenFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    
    // Add focus listener to track when user has interacted
    _focusNode.addListener(_onFocusChanged);
    
    // Validate initial value if controller has text
    if (_controller.text.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _validateEmail(_controller.text);
      });
    }
  }

  @override
  void dispose() {
    // Clean up only if we created the controller/focus node
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      setState(() {
        _hasBeenFocused = true;
      });
    } else if (_hasBeenFocused && _controller.text.isNotEmpty) {
      // Validate when losing focus if user has interacted and has text
      _validateEmail(_controller.text);
    }
  }

  bool _isValidEmail(String email) {
    return InputDefaults.isValidEmail(email);
  }

  void _validateEmail(String value) {
    final isValid = _isValidEmail(value);
    final shouldShowError = !isValid && value.isNotEmpty && 
                           (widget.validateRealTime || _hasBeenFocused);
    
    setState(() {
      _isValid = isValid;
      _errorText = shouldShowError 
          ? (widget.customErrorMessage ?? _getLocalizedErrorMessage())
          : null;
    });
    
    widget.onValidationChanged?.call(isValid);
  }

  String _getLocalizedErrorMessage() {
    final localizations = AppLocalizations.of(context);
    if (localizations != null) {
      return localizations.emailValidationError;
    }
    return 'Please enter a valid email address';
  }

  void _onChanged(String value) {
    _validateEmail(value);
    widget.onChanged?.call(value);
  }

  void _clearInput() {
    _controller.clear();
    _onChanged('');
    _focusNode.requestFocus();
  }

  Widget _buildClearButton() {
    return InputDefaults.createClearButton(
      context,
      onPressed: _clearInput,
      isVisible: widget.showClearButton && 
                 _controller.text.isNotEmpty && 
                 _focusNode.hasFocus,
    );
  }

  InputDecoration _buildDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    
    return InputDecoration(
      labelText: widget.label ?? localizations?.emailAddress ?? 'E-Mail-Adresse',
      hintText: widget.hint ?? localizations?.emailHint ?? 'erika@example.com',
      errorText: _errorText,
      filled: true,
      fillColor: InputDefaults.getInputBackgroundColor(context),
      prefixIcon: Icon(
        LucideIcons.mail,
        size: InputDefaults.iconSizeLarge,
        color: InputDefaults.getIconColor(
          context,
          isValid: _isValid,
          hasContent: _controller.text.isNotEmpty,
        ),
      ),
      suffixIcon: widget.showClearButton ? _buildClearButton() : null,
      border: InputDefaults.createBorder(context, color: theme.colorScheme.outline),
      enabledBorder: InputDefaults.getEnabledBorder(context),
      focusedBorder: InputDefaults.getFocusedBorder(context),
      errorBorder: InputDefaults.getErrorBorder(context),
      focusedErrorBorder: InputDefaults.getFocusedErrorBorder(context),
      contentPadding: InputDefaults.getContentPadding(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputWidth = InputDefaults.getInputWidth(
      context, 
      maxWidth: LayoutConstants.buttonMaxWidth,
    );
    
    return Container(
      width: inputWidth,
      padding: InputDefaults.verticalPadding,
      child: InputDefaults.wrapWithSemantics(
        label: 'Email address input field',
        hint: 'Enter your email address for account access',
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.tab): () {
              if (_focusNode.hasFocus) {
                widget.onSubmitted?.call(_controller.text);
              }
            },
          },
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.emailAddress,
            textInputAction: widget.textInputAction,
            enabled: widget.enabled,
            autofillHints: const [AutofillHints.email],
            autocorrect: false,
            enableSuggestions: false,
            inputFormatters: InputDefaults.emailFormatters,
            decoration: _buildDecoration(context),
            onChanged: _onChanged,
            onEditingComplete: () {
              // This is called for both Tab and Enter
              widget.onSubmitted?.call(_controller.text);
            },
            onSubmitted: (value) {
              // Ensure validation happens on submit
              if (!widget.validateRealTime) {
                _validateEmail(_controller.text);
              }
              // Call the external onSubmitted callback
              widget.onSubmitted?.call(value);
            },
          ),
        ),
      ),
    );
  }
}