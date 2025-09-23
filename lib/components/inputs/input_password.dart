import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/layout_constants.dart';
import 'input_defaults.dart';

/// Platform-aware password input component with comprehensive validation
/// 
/// Features:
/// - Responsive design integrated with project's layout system
/// - Platform-specific styling (iOS/Android)
/// - Internationalization support via AppLocalizations
/// - Real-time password strength validation with visual feedback
/// - Password visibility toggle with proper accessibility
/// - Consistent API with InputEmail component
/// - Proper memory management
class InputPassword extends StatefulWidget {
  /// Text controller for the password input
  final TextEditingController? controller;
  
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
  
  /// Whether to show password strength indicator
  final bool showStrengthIndicator;
  
  /// Whether to show detailed validation requirements
  final bool showRequirements;
  
  /// Custom password requirements (overrides default)
  final List<PasswordRequirement>? customRequirements;

  /// Callback triggered when submit action is performed (Enter/Tab)
  final void Function(String password)? onSubmitted;

  const InputPassword({
    super.key,
    this.controller,
    this.onValidationChanged,
    this.onChanged,
    this.onSubmitted,
    this.label,
    this.hint,
    this.enabled = true,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.validateRealTime = true,
    this.showStrengthIndicator = true,
    this.showRequirements = true,
    this.customRequirements,
  });

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _obscureText = true;
  bool _isValid = false;
  bool _hasBeenFocused = false;
  List<PasswordRequirement> _failedRequirements = [];

  /// Default password requirements
  static List<PasswordRequirement> get _defaultRequirements => 
      PasswordRequirements.defaultRequirements;

  List<PasswordRequirement> get _requirements => 
      widget.customRequirements ?? _defaultRequirements;

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
      // Validate immediately when focusing to show current state
      _validatePassword(_controller.text);
    } else if (_hasBeenFocused && _controller.text.isNotEmpty) {
      // Validate when losing focus if user has interacted and has text
      _validatePassword(_controller.text);
    }
  }

  void _validatePassword(String password) {
    final failedRequirements = _requirements
        .where((req) => !req.validate(password))
        .toList();
    
    final isValid = failedRequirements.isEmpty && password.isNotEmpty;
    
    setState(() {
      _isValid = isValid;
      _failedRequirements = failedRequirements;
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

  /// Calculate password strength (0-1)
  double _calculateStrength(String password) {
    if (password.isEmpty) return 0.0;
    
    final passedRequirements = _requirements
        .where((req) => req.validate(password))
        .length;
    
    return passedRequirements / _requirements.length;
  }

  Color _getStrengthColor(double strength) {
    final theme = Theme.of(context);
    if (strength < 0.25) return theme.colorScheme.error;
    if (strength < 0.5) return Colors.orange;
    if (strength < 0.75) return Colors.yellow.shade700;
    return theme.colorScheme.primary;
  }

  Widget _buildStrengthIndicator() {
    if (!widget.showStrengthIndicator || _controller.text.isEmpty) {
      return const SizedBox.shrink();
    }

    final strength = _calculateStrength(_controller.text);
    final color = _getStrengthColor(strength);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: strength,
            backgroundColor: color.withAlpha(InputDefaults.alphaVeryLight), // 0.2 * 255 = 51
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
          ),
          const SizedBox(height: 4),
          Text(
            strength < 0.25 ? AppLocalizations.of(context)!.passwordStrengthWeak : 
            strength < 0.5 ? AppLocalizations.of(context)!.passwordStrengthMedium : 
            strength < 0.75 ? AppLocalizations.of(context)!.passwordStrengthGood : AppLocalizations.of(context)!.passwordStrengthStrong,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirements() {
    if (!widget.showRequirements || (!_focusNode.hasFocus && _controller.text.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.passwordRequirements,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          ..._requirements.map((requirement) {
            final isFailed = _failedRequirements.contains(requirement);
            final color = isFailed 
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Row(
                children: [
                  Icon(
                    isFailed ? LucideIcons.xCircle : LucideIcons.checkCircle,
                    size: 16,
                    color: color,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      requirement.getLabel(context),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  InputDecoration _buildDecoration(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    
    return InputDecoration(
      labelText: widget.label ?? localizations.password,
      hintText: widget.hint ?? localizations.passwordHint,
      filled: true,
      fillColor: InputDefaults.getInputBackgroundColor(context),
      prefixIcon: Icon(
        LucideIcons.lock,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            label: 'Password input field',
            hint: 'Enter your password with required security criteria',
            textField: true,
            obscured: _obscureText,
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
          _buildStrengthIndicator(),
          _buildRequirements(),
        ],
      ),
    );
  }
}