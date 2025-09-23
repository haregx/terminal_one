import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/layout_constants.dart';
import 'input_defaults.dart';

/// Platform-aware password confirmation input component
/// 
/// Features:
/// - Matches passwords with validation
/// - Responsive design integrated with project's layout system
/// - Platform-specific styling (iOS/Android)
/// - Internationalization support via AppLocalizations
/// - Password visibility toggle with proper accessibility
/// - Consistent API with InputPassword component
/// - Proper memory management
class InputPasswordConfirm extends StatefulWidget {
  /// Text controller for the confirmation input
  final TextEditingController? controller;
  
  /// The original password to compare against
  final String originalPassword;
  
  /// Callback triggered when validation state changes
  final void Function(bool isValid)? onValidationChanged;
  
  /// Callback triggered when password value changes
  final void Function(String password)? onChanged;
  
  /// Custom label text (defaults to localized text)
  final String? label;
  
  /// Custom hint text (defaults to localized text)
  final String? hint;
  
  /// Whether the input is enabled
  final bool enabled;
  
  /// Focus node for managing focus
  final FocusNode? focusNode;
  
  /// Text input action for keyboard
  final TextInputAction textInputAction;
  
  /// Whether to validate on every change or only on submit
  final bool validateRealTime;

  /// Callback triggered when submit action is performed (Enter/Tab)
  final void Function(String password)? onSubmitted;

  const InputPasswordConfirm({
    super.key,
    this.controller,
    required this.originalPassword,
    this.onValidationChanged,
    this.onChanged,
    this.onSubmitted,
    this.label,
    this.hint,
    this.enabled = true,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.validateRealTime = true,
  });

  @override
  State<InputPasswordConfirm> createState() => _InputPasswordConfirmState();
}

class _InputPasswordConfirmState extends State<InputPasswordConfirm> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _obscureText = true;
  bool _isValid = false;
  bool _hasBeenFocused = false;
  String? _errorText;

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
        _validatePassword(_controller.text);
      });
    }
  }

  @override
  void didUpdateWidget(InputPasswordConfirm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-validate if original password changed - defer to avoid setState during build
    if (oldWidget.originalPassword != widget.originalPassword) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _validatePassword(_controller.text);
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
      _hasBeenFocused = true;
    } else if (_hasBeenFocused && _controller.text.isNotEmpty) {
      // Validate when losing focus if user has interacted and has text
      _validatePassword(_controller.text);
    }
  }

  void _validatePassword(String confirmPassword) {
    final localizations = AppLocalizations.of(context)!;
    
    String? errorText;
    bool isValid = false;
    
    if (confirmPassword.isNotEmpty && confirmPassword != widget.originalPassword) {
      errorText = localizations.passwordsDoNotMatch;
    } else if (confirmPassword.isNotEmpty && confirmPassword == widget.originalPassword) {
      isValid = true;
    }
    
    setState(() {
      _isValid = isValid;
      _errorText = errorText;
    });
    
    widget.onValidationChanged?.call(isValid);
  }

  void _onChanged(String value) {
    if (widget.validateRealTime || _hasBeenFocused) {
      _validatePassword(value);
    }
    widget.onChanged?.call(value);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  InputDecoration _buildDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    
    return InputDecoration(
      labelText: widget.label ?? localizations.confirmPassword,
      hintText: widget.hint ?? localizations.confirmPasswordHint,
      errorText: _hasBeenFocused ? _errorText : null,
      filled: true,
      fillColor: InputDefaults.getInputBackgroundColor(context),
      prefixIcon: Icon(
        LucideIcons.shieldCheck,
        size: InputDefaults.iconSizeLarge,
        color: _isValid && _controller.text.isNotEmpty
            ? theme.colorScheme.primary
            : InputDefaults.getIconColor(context, isValid: _isValid, hasContent: _controller.text.isNotEmpty),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? LucideIcons.eyeOff : LucideIcons.eye,
          size: InputDefaults.iconSizeLarge,
        ),
        onPressed: _togglePasswordVisibility,
        tooltip: _obscureText 
            ? localizations.showPassword
            : localizations.hidePassword,
        splashRadius: 16,
        // Verhindere dass Tab-Navigation auf diesem Button stoppt
        focusNode: FocusNode(skipTraversal: true),
      ),
      border: InputDefaults.getEnabledBorder(context),
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
      child: Semantics(
        label: 'Password confirmation input field',
        hint: 'Re-enter your password to confirm it matches',
        textField: true,
        obscured: _obscureText,
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
            obscureText: _obscureText,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: widget.textInputAction,
            enabled: widget.enabled,
            autofillHints: const [AutofillHints.password],
            autocorrect: false,
            enableSuggestions: false,
            inputFormatters: InputDefaults.passwordFormatters,
            decoration: _buildDecoration(context),
            onChanged: _onChanged,
            onEditingComplete: () {
              // This is called for both Tab and Enter
              widget.onSubmitted?.call(_controller.text);
            },
            onSubmitted: (value) {
              // Ensure validation happens on submit
              if (!widget.validateRealTime) {
                _validatePassword(_controller.text);
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