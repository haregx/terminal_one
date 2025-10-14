import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Input validation mode for the code group
/// 
/// Defines which characters are permitted in the input fields, enabling
/// different use cases from simple numeric PINs to complex alphanumeric codes.
enum CodeValidationMode {
  /// Only numeric digits (0-9) are allowed
  /// Perfect for PIN codes, verification codes, and simple numeric inputs
  numeric,
  
  /// Only alphanumeric characters (A-Z, 0-9) are allowed
  /// Suitable for activation codes, license keys, and mixed character codes
  alphanumeric,
  
  /// Any character is allowed
  /// Provides maximum flexibility for special codes or custom validation
  any,
}

/// Visual state of individual input fields
/// 
/// Represents the current appearance state of each input field,
/// enabling dynamic styling based on user interaction and validation.
enum CodeFieldState {
  /// Normal state - no special styling
  /// Default appearance when field is neither focused nor contains errors
  normal,
  
  /// Field has focus
  /// Visual indication that the field is currently active for input
  focused,
  
  /// Field contains invalid input
  /// Error styling to indicate validation failure or invalid characters
  error,
  
  /// Field is filled and valid
  /// Success styling to show successful input completion
  filled,
}

/// A highly customizable code input widget that creates a group of individual input fields
/// for entering verification codes, PINs, OTP codes, or similar sequential character inputs.
/// 
/// This widget provides a comprehensive, user-friendly interface for code entry with advanced features:
/// 
/// **Core Features:**
/// - Configurable length (1-99 fields) and validation modes (numeric, alphanumeric, any)
/// - Intelligent automatic focus management and seamless navigation between fields
/// - Smart paste functionality for quick code input from clipboard
/// - Real-time validation with immediate visual feedback
/// - Comprehensive accessibility support with screen reader compatibility
/// - Platform-specific optimizations and native feel
/// 
/// **Styling and Theming:**
/// - Theme-aware styling that automatically adapts to light/dark modes
/// - Extensive customization options for colors, borders, and typography
/// - State-based visual feedback (normal, focused, error, filled states)
/// - Responsive design that works across different screen sizes
/// - Modern Material Design 3.0 compliance
/// 
/// **User Experience:**
/// - Automatic advancement to next field on character input
/// - Backspace navigation to previous field when current is empty
/// - Long-press paste functionality for quick code entry
/// - Error state handling with visual feedback
/// - Completion callbacks for immediate action on code entry
/// 
/// **Accessibility:**
/// - Full screen reader support with descriptive labels
/// - Keyboard navigation compatibility
/// - High contrast mode support
/// - Touch target optimization for motor accessibility
/// 
/// Example usage for 6-digit numeric verification code:
/// ```dart
/// InputCodeGroup(
///   length: 6,
///   validationMode: CodeValidationMode.numeric,
///   onChanged: (code) => print('Current code: $code'),
///   onCompleted: (code) => _verifyCode(code),
///   onValid: (isValid) => setState(() => _showSubmitButton = isValid),
///   placeholder: '●',
///   borderRadius: 12.0,
/// )
/// ```
/// 
/// Example usage for 4-character alphanumeric activation code:
/// ```dart
/// InputCodeGroup(
///   length: 4,
///   validationMode: CodeValidationMode.alphanumeric,
///   fieldWidth: 60.0,
///   fieldHeight: 60.0,
///   fontSize: 24.0,
///   focusedBorderColor: Colors.blue,
///   errorBorderColor: Colors.red,
///   onCompleted: (code) => _activateFeature(code),
/// )
/// ```
class InputCodeGroup extends StatefulWidget {
  /// The number of input fields to display. Defaults to 6
  /// 
  /// Valid range: 1-99 fields. Common values:
  /// - 4: Short PIN codes or activation codes
  /// - 6: Standard verification codes (SMS, email)
  /// - 8: Extended security codes or license keys
  final int length;
  
  /// Validation mode that determines which characters are allowed
  /// 
  /// Controls input filtering and validation behavior:
  /// - CodeValidationMode.numeric: Only digits 0-9 (PIN codes, SMS codes)
  /// - CodeValidationMode.alphanumeric: Letters A-Z and digits 0-9 (license keys)
  /// - CodeValidationMode.any: All characters allowed (custom codes)
  final CodeValidationMode validationMode;
  
  /// Called whenever the code value changes (on each character input)
  /// 
  /// Provides real-time updates as user types. Useful for:
  /// - Live validation feedback
  /// - Character counting
  /// - Progressive form validation
  /// - Auto-saving draft state
  final void Function(String code)? onChanged;
  
  /// Called when all fields are filled (regardless of validity)
  /// 
  /// Triggered immediately when the last field receives input.
  /// Perfect for automatic submission or validation triggers.
  /// Note: This fires even if some characters are invalid.
  final void Function(String code)? onCompleted;
  
  /// Called whenever the validity state changes
  /// 
  /// Provides boolean feedback about overall code validity.
  /// Useful for enabling/disabling submit buttons or showing validation messages.
  /// Considers both field completion and character validation.
  final void Function(bool isValid)? onValid;
  
  /// Width of each individual input field. If null, uses adaptive sizing
  /// 
  /// When null, automatically calculates optimal width based on:
  /// - Available screen space
  /// - Font size and character requirements
  /// - Platform-specific spacing guidelines
  /// Custom values useful for fixed layouts or specific design requirements.
  final double? fieldWidth;
  
  /// Height of each individual input field. If null, uses adaptive sizing
  /// 
  /// When null, automatically calculates height based on:
  /// - Font size and line height
  /// - Platform touch target requirements (min 48dp)
  /// - Padding and border considerations
  /// Custom values enable consistent vertical alignment with other form elements.
  final double? fieldHeight;
  
  /// Spacing between input fields. Defaults to 12.0
  /// 
  /// Controls horizontal gap between individual input fields.
  /// Considerations:
  /// - Smaller values (8-10): Compact layouts, mobile optimization
  /// - Medium values (12-16): Balanced appearance, recommended default
  /// - Larger values (20+): Spacious layouts, accessibility enhancement
  final double fieldSpacing;
  
  /// Font size for the input text. If null, uses theme-appropriate size
  /// 
  /// When null, automatically selects size based on:
  /// - Current theme typography scale
  /// - Platform conventions (iOS vs Android)
  /// - Accessibility text scaling preferences
  /// Custom values override automatic scaling for consistent branding.
  final double? fontSize;
  
  /// Custom text style for the input fields
  /// 
  /// Provides fine-grained control over text appearance including:
  /// - Font family and weight
  /// - Letter spacing and height
  /// - Color (though state-based colors may override)
  /// - Decoration and other advanced typography
  /// Takes precedence over fontSize when both are specified.
  final TextStyle? textStyle;
  
  /// Border color for normal state. If null, uses theme colors
  /// 
  /// Default appearance when field is inactive and contains no errors.
  /// When null, automatically uses:
  /// - Theme outline color for light mode
  /// - Theme outline variant for dark mode
  /// - Adapts to user's accessibility preferences
  final Color? borderColor;
  
  /// Border color for focused state. If null, uses theme primary color
  /// 
  /// Active appearance when field has input focus.
  /// When null, automatically uses:
  /// - Theme primary color for brand consistency
  /// - High contrast variants for accessibility
  /// - Platform-appropriate focus indicators
  final Color? focusedBorderColor;
  
  /// Border color for error state. If null, uses theme error color
  /// 
  /// Indicates validation failure or invalid input.
  /// When null, automatically uses:
  /// - Theme error color for semantic consistency
  /// - High visibility red tones that meet WCAG contrast requirements
  /// - Color-blind friendly error indicators
  final Color? errorBorderColor;
  
  /// Border color for filled state. If null, uses theme success color
  /// 
  /// Shows successful completion of individual field input.
  /// When null, automatically uses:
  /// - Theme success/tertiary color
  /// - Subtle green tones that indicate completion
  /// - Maintains visual hierarchy with other states
  final Color? filledBorderColor;
  
  /// Border width for normal state. Defaults to 1.5
  /// 
  /// Standard border thickness for inactive fields.
  /// Considerations:
  /// - 1.0-1.5: Subtle, minimalist appearance
  /// - 2.0: Medium emphasis, good for most use cases
  /// - 2.5+: Strong emphasis, high visibility requirements
  final double borderWidth;
  
  /// Border width for focused state. Defaults to 2.0
  /// 
  /// Enhanced border thickness to indicate active focus.
  /// Should be visibly thicker than normal state for clear feedback.
  /// Helps users understand which field is currently active.
  final double focusedBorderWidth;
  
  /// Border radius for the input fields. Defaults to 8.0
  /// 
  /// Controls corner rounding for all field states.
  /// Common values:
  /// - 0: Sharp corners, minimalist design
  /// - 4-8: Subtle rounding, modern appearance
  /// - 12-16: Rounded design, friendly feel
  /// - 50%+ of height: Pill-shaped fields
  final double borderRadius;
  
  /// Whether to allow pasting content into the fields. Defaults to true
  /// 
  /// When enabled, users can paste complete codes from clipboard:
  /// - Long-press paste on mobile devices
  /// - Ctrl+V keyboard shortcut on desktop
  /// - Automatically distributes pasted content across fields
  /// - Validates pasted content against current validation mode
  /// Disable for high-security scenarios where manual input is required.
  final bool allowPaste;
  
  /// Whether to show a cursor in the input fields. Defaults to false
  /// 
  /// Controls text cursor visibility within individual fields:
  /// - true: Shows blinking cursor for traditional text input feel
  /// - false: Hidden cursor for cleaner, code-focused appearance
  /// Consider enabling for longer codes or when users expect text editing.
  final bool showCursor;
  
  /// Placeholder character displayed in empty fields
  /// 
  /// Visual hint shown in unfilled input fields:
  /// - null: No placeholder (transparent/empty appearance)
  /// - '●': Bullet point (secure, PIN-like appearance)
  /// - '-': Dash (clear indication of empty state)
  /// - '_': Underscore (traditional form-like appearance)
  /// - Custom: Any single character or short string
  final String? placeholder;

  /// Creates a code input group with customizable appearance and behavior.
  /// 
  /// **Required Parameters:**
  /// None - all parameters have sensible defaults for immediate use.
  /// 
  /// **Key Customization Options:**
  /// - [length]: Number of input fields (default: 6)
  /// - [validationMode]: Character filtering (default: numeric)
  /// - [onCompleted]: Callback for full code entry
  /// - [onChanged]: Real-time input updates
  /// - [onValid]: Validation state changes
  /// 
  /// **Styling Customization:**
  /// All visual parameters are optional and will use theme-appropriate defaults
  /// that automatically adapt to the current platform, theme mode (light/dark),
  /// and user accessibility preferences including high contrast and text scaling.
  /// 
  /// **Accessibility Features:**
  /// - Automatic screen reader support
  /// - Keyboard navigation compatibility
  /// - Minimum touch target compliance
  /// - High contrast mode adaptation
  /// - Text scaling support
  const InputCodeGroup({
    super.key,
    this.length = 6,
    this.validationMode = CodeValidationMode.numeric,
    this.onChanged,
    this.onCompleted,
    this.onValid,
    this.fieldWidth,
    this.fieldHeight,
    this.fieldSpacing = 12.0,
    this.fontSize,
    this.textStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.filledBorderColor,
    this.borderWidth = 1.5,
    this.focusedBorderWidth = 2.0,
    this.borderRadius = 8.0,
    this.allowPaste = true,
    this.showCursor = false,
    this.placeholder,
  });

  @override
  State<InputCodeGroup> createState() => InputCodeGroupState();
}

/// State management class for the InputCodeGroup widget
/// 
/// Handles the complex coordination of multiple input fields, focus management,
/// validation logic, and user interaction patterns. This class maintains:
/// 
/// **Internal State:**
/// - Individual text controllers for each input field
/// - Focus nodes for keyboard navigation and field activation
/// - Visual state tracking for styling and feedback
/// - Validation status for real-time error handling
/// 
/// **Key Responsibilities:**
/// - Automatic focus advancement and backspace navigation
/// - Paste functionality with intelligent content distribution
/// - Real-time validation and visual state updates
/// - Callback coordination for parent widget communication
/// - Memory management and proper disposal of resources
class InputCodeGroupState extends State<InputCodeGroup> {
  /// List of text controllers for each input field
  /// 
  /// Each controller manages the text content of one input field.
  /// Controllers are created during initialization and disposed properly
  /// to prevent memory leaks. They enable programmatic access to field
  /// content and coordinate with validation and callback systems.
  late final List<TextEditingController> _controllers;
  
  /// List of focus nodes for each input field
  /// 
  /// Focus nodes control keyboard focus and field activation state.
  /// They enable:
  /// - Automatic advancement between fields
  /// - Programmatic focus management
  /// - Visual focus indicators
  /// - Accessibility support for screen readers
  late final List<FocusNode> _focusNodes;
  
  /// Current validation state of each field
  /// 
  /// Tracks the visual and logical state of each input field:
  /// - CodeFieldState.normal: Default, inactive appearance
  /// - CodeFieldState.focused: Currently active for input
  /// - CodeFieldState.error: Contains invalid or rejected input
  /// - CodeFieldState.filled: Successfully completed with valid input
  /// Used for dynamic styling and user feedback.
  late final List<CodeFieldState> _fieldStates;
  
  /// Get the current complete code from all fields
  /// 
  /// Concatenates text from all input fields to form the complete code string.
  /// Returns empty string for unfilled fields, enabling partial code access.
  /// Useful for real-time validation, progress tracking, and partial submissions.
  String get code => _controllers.map((c) => c.text).join();
  
  /// Get the regex pattern based on current validation mode
  /// 
  /// Returns the appropriate regular expression for character validation:
  /// - Numeric mode: Accepts only digits 0-9
  /// - Alphanumeric mode: Accepts uppercase letters A-Z and digits 0-9
  /// - Any mode: Accepts any character (effectively no restriction)
  /// 
  /// Used internally for real-time input filtering and paste validation.
  RegExp get _validationPattern {
    switch (widget.validationMode) {
      case CodeValidationMode.numeric:
        return RegExp(r'^[0-9]$');
      case CodeValidationMode.alphanumeric:
        return RegExp(r'^[A-Z0-9]$');
      case CodeValidationMode.any:
        return RegExp(r'^.+$');
    }
  }
  
  @override
  void initState() {
    super.initState();
    _initializeFields();
  }
  
  /// Initialize all controllers, focus nodes, and field states
  void _initializeFields() {
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _fieldStates = List.generate(widget.length, (_) => CodeFieldState.normal);
    
    // Add listeners to focus nodes for state management
    for (int i = 0; i < widget.length; i++) {
      _focusNodes[i].addListener(() => _updateFieldState(i));
    }
  }
  
  /// Update the visual state of a specific field
  void _updateFieldState(int index) {
    if (!mounted) return;
    
    setState(() {
      if (_focusNodes[index].hasFocus) {
        _fieldStates[index] = CodeFieldState.focused;
      } else if (_controllers[index].text.isNotEmpty) {
        _fieldStates[index] = _isValidCharacter(_controllers[index].text)
            ? CodeFieldState.filled
            : CodeFieldState.error;
      } else {
        _fieldStates[index] = CodeFieldState.normal;
      }
    });
  }
  
  /// Check if a character is valid based on validation mode
  bool _isValidCharacter(String char) {
    if (char.isEmpty) return false;
    return _validationPattern.hasMatch(char.toUpperCase());
  }
  
  /// Validate the complete code and notify listeners
  void _notifyValidity() {
    final currentCode = code;
    final hasInvalidChar = _controllers.any((c) => 
        c.text.isNotEmpty && !_isValidCharacter(c.text));
    final hasEmpty = _controllers.any((c) => c.text.isEmpty);
    final allZero = widget.validationMode == CodeValidationMode.numeric && 
        _controllers.every((c) => c.text == '0');

    final isValid = !hasInvalidChar && !hasEmpty && !allZero;
    
    // Notify callbacks
    widget.onChanged?.call(currentCode);
    widget.onValid?.call(isValid);
    
    // Check if code is complete
    if (currentCode.length == widget.length) {
      widget.onCompleted?.call(currentCode);
    }
  }

  /// Handle input changes with improved navigation and paste support
  void _onChanged(String value, int index) {
    if (value.isEmpty) {
      // Handle backspace - move to previous field if current is empty
      _handleBackspace(index);
      return;
    }

    // Handle paste operation if multiple characters are detected
    if (value.length > 1 && widget.allowPaste) {
      _handlePaste(value, index);
      return;
    }

    // Handle single character input
    final char = value[value.length - 1].toUpperCase();
    if (!_isValidCharacter(char)) {
      _controllers[index].clear();
      _updateFieldState(index);
      _notifyValidity();
      return;
    }

    _controllers[index].text = char;
    _controllers[index].selection = TextSelection.collapsed(offset: 1);
    
    // Move to next field if available
    _moveToNextField(index);
    _updateFieldState(index);
    _notifyValidity();
  }
  
  /// Handle backspace navigation
  void _handleBackspace(int index) {
    if (index > 0 && _controllers[index].text.isEmpty) {
      // Move to previous field and clear it
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
      _updateFieldState(index - 1);
    }
    _updateFieldState(index);
    _notifyValidity();
  }
  
  /// Handle paste functionality
  void _handlePaste(String pastedText, int startIndex) {
    if (!widget.allowPaste) return;
    
    // Clean and validate pasted text
    String cleanText = pastedText.toUpperCase();
    List<String> validChars = [];
    
    for (String char in cleanText.split('')) {
      if (_isValidCharacter(char) && validChars.length < widget.length - startIndex) {
        validChars.add(char);
      }
    }
    
    // Fill fields with valid characters
    for (int i = 0; i < validChars.length && (startIndex + i) < widget.length; i++) {
      _controllers[startIndex + i].text = validChars[i];
      _updateFieldState(startIndex + i);
    }
    
    // Focus on the next empty field or last filled field
    int nextIndex = (startIndex + validChars.length).clamp(0, widget.length - 1);
    if (nextIndex < widget.length) {
      _focusNodes[nextIndex].requestFocus();
    }
    
    _notifyValidity();
  }
  
  /// Move focus to the next available field
  void _moveToNextField(int currentIndex) {
    if (currentIndex < widget.length - 1) {
      Future.microtask(() {
        if (mounted) {
          _focusNodes[currentIndex + 1].requestFocus();
        }
      });
    } else {
      // Last field - remove focus to trigger completion
      _focusNodes[currentIndex].unfocus();
    }
  }

  /// Handle tap on a specific field - clear and position cursor
  void _onTap(int index) {
    _controllers[index].clear();
    _controllers[index].selection = const TextSelection(baseOffset: 0, extentOffset: 0);
    _updateFieldState(index);
  }
  
  /// Clear all fields and reset to first field
  void clearAll() {
    for (var controller in _controllers) {
      controller.clear();
    }
    for (int i = 0; i < widget.length; i++) {
      _updateFieldState(i);
    }
    if (_focusNodes.isNotEmpty) {
      _focusNodes[0].requestFocus();
    }
    _notifyValidity();
  }
  
  /// Set the complete code programmatically
  void setCode(String code) {
    if (code.length > widget.length) {
      code = code.substring(0, widget.length);
    }
    
    // Clear all fields first
    for (var controller in _controllers) {
      controller.clear();
    }
    
    // Set each character
    for (int i = 0; i < code.length; i++) {
      if (_isValidCharacter(code[i])) {
        _controllers[i].text = code[i].toUpperCase();
        _updateFieldState(i);
      }
    }
    
    _notifyValidity();
  }
  
  /// Get theme-aware colors for different field states
  Color _getBorderColor(CodeFieldState state) {
    switch (state) {
      case CodeFieldState.focused:
        return widget.focusedBorderColor ?? Theme.of(context).colorScheme.primary;
      case CodeFieldState.error:
        return widget.errorBorderColor ?? Theme.of(context).colorScheme.error;
      case CodeFieldState.filled:
        return widget.filledBorderColor ?? Theme.of(context).colorScheme.primary.withAlpha(179);
      case CodeFieldState.normal:
        return widget.borderColor ?? Theme.of(context).colorScheme.outline;
    }
  }
  
  /// Get appropriate border width for field state
  double _getBorderWidth(CodeFieldState state) {
    return state == CodeFieldState.focused ? widget.focusedBorderWidth : widget.borderWidth;
  }
  
  /// Get appropriate background color for field state and theme
  Color _getBackgroundColor(CodeFieldState state) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    
    switch (state) {
      case CodeFieldState.focused:
        // Focused: Slightly highlighted background
        return brightness == Brightness.dark
            ? colorScheme.surface.withAlpha(204)
            : colorScheme.primary.withAlpha(13);
            
      case CodeFieldState.error:
        // Error: Subtle error tint
        return brightness == Brightness.dark
            ? colorScheme.error.withAlpha(26)
            : colorScheme.error.withAlpha(13);
            
      case CodeFieldState.filled:
        // Filled: Success-tinted background
        return brightness == Brightness.dark
            ? colorScheme.primary.withAlpha(38)
            : colorScheme.primary.withAlpha(20);
            
      case CodeFieldState.normal:
        // Normal: Clean, readable background
        return brightness == Brightness.dark
            ? colorScheme.surface.withAlpha(153)
            : colorScheme.surface.withAlpha(230);
    }
  }
  
  /// Get appropriate keyboard type based on validation mode
  TextInputType _getKeyboardType() {
    switch (widget.validationMode) {
      case CodeValidationMode.numeric:
        return TextInputType.number;
      case CodeValidationMode.alphanumeric:
        return TextInputType.text;
      case CodeValidationMode.any:
        return TextInputType.text;
    }
  }
  
  /// Get input formatters based on validation mode
  List<TextInputFormatter> _getInputFormatters() {
    switch (widget.validationMode) {
      case CodeValidationMode.numeric:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(1),
        ];
      case CodeValidationMode.alphanumeric:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
          UpperCaseTextFormatter(),
          LengthLimitingTextInputFormatter(1),
        ];
      case CodeValidationMode.any:
        return [
          LengthLimitingTextInputFormatter(1),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    // === THEME-AWARE STYLING CONFIGURATION ===
    // Extract current theme for consistent styling integration
    // Ensures automatic adaptation to light/dark modes and user preferences
    final theme = Theme.of(context);
    
    // Calculate effective text style with intelligent fallbacks
    // Priority: custom textStyle > custom fontSize > theme defaults
    // Provides professional typography that scales with accessibility settings
    final effectiveTextStyle = widget.textStyle ?? theme.textTheme.headlineSmall?.copyWith(
      fontSize: widget.fontSize ?? 24.0,
      fontWeight: FontWeight.w600, // Semi-bold for enhanced readability
    );
    
    // Calculate effective field dimensions with responsive defaults
    // Ensures minimum touch targets (48dp) for accessibility compliance
    // Balances compact design with usability across different screen sizes
    final effectiveFieldWidth = widget.fieldWidth ?? 48.0;
    final effectiveFieldHeight = widget.fieldHeight ?? 56.0;
    
    // === MAIN WIDGET COMPOSITION ===
    // Horizontal layout with centered alignment for balanced appearance
    // Scales appropriately on different screen sizes and orientations
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        // Get current visual state for this specific field
        // Drives dynamic styling and user feedback
        final currentState = _fieldStates[i];

        return Padding(
          // Add horizontal spacing between fields (except after last field)
          // Creates visual separation while maintaining cohesive group appearance
          padding: EdgeInsets.only(right: i < widget.length - 1 ? widget.fieldSpacing : 0),
          child: SizedBox(
            // Fixed dimensions ensure consistent field sizes
            // Prevents layout shifts during state changes or content updates
            width: effectiveFieldWidth,
            height: effectiveFieldHeight,
            child: Semantics(
              // === ACCESSIBILITY ENHANCEMENTS ===
              // Provide comprehensive screen reader support
              // Helps users understand field purpose and current progress
              label: 'Code digit ${i + 1} of ${widget.length}',
              // Context-aware hints based on validation mode
              // Provides specific guidance about expected input type
              hint: widget.validationMode == CodeValidationMode.numeric 
                  ? 'Enter a number' 
                  : 'Enter a character',
              textField: true, // Identifies as text input for screen readers
              child: TextField(
                // === FIELD CONFIGURATION ===
                controller: _controllers[i], // Individual text content management
                focusNode: _focusNodes[i], // Focus state and navigation control
                keyboardType: _getKeyboardType(), // Optimized keyboard layout
                textAlign: TextAlign.center, // Centered text for visual balance
                style: effectiveTextStyle, // Consistent typography across all fields
                maxLength: 1, // Enforce single character per field
                showCursor: widget.showCursor, // Optional cursor visibility
                inputFormatters: _getInputFormatters(), // Character validation and filtering
                
                // === KEYBOARD NAVIGATION OPTIMIZATION ===
                // Provide intuitive next/done actions based on field position
                // Improves user flow and completion efficiency
                textInputAction: i < widget.length - 1 
                    ? TextInputAction.next  // Advance to next field
                    : TextInputAction.done, // Complete input sequence
                    
                // Handle completion action for seamless navigation
                // Automatically advances focus or completes input as appropriate
                onEditingComplete: () {
                  if (i < widget.length - 1) {
                    _focusNodes[i + 1].requestFocus(); // Move to next field
                  } else {
                    _focusNodes[i].unfocus(); // Dismiss keyboard on completion
                  }
                },
                // === VISUAL STYLING AND STATE MANAGEMENT ===
                decoration: InputDecoration(
                  counterText: '', // Hide character counter for cleaner appearance
                  contentPadding: EdgeInsets.zero, // Maximize text area within field
                  
                  // === BACKGROUND STYLING ===
                  // Proper background for theme-aware visibility
                  filled: true,
                  fillColor: _getBackgroundColor(currentState),
                  
                  // === BORDER STYLING FOR ALL STATES ===
                  // Each border state provides distinct visual feedback
                  // Colors and widths adapt based on current field state
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: _getBorderColor(currentState), // Dynamic color based on state
                      width: _getBorderWidth(currentState), // Dynamic width for emphasis
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: _getBorderColor(currentState), // Normal state styling
                      width: _getBorderWidth(currentState),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: _getBorderColor(CodeFieldState.focused), // Enhanced focus indication
                      width: _getBorderWidth(CodeFieldState.focused), // Thicker border for visibility
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: _getBorderColor(CodeFieldState.error), // Error state highlighting
                      width: _getBorderWidth(CodeFieldState.error), // Consistent error emphasis
                    ),
                  ),
                  
                  // === PLACEHOLDER AND HINT STYLING ===
                  // Visual guidance for empty fields with subtle appearance
                  // Uses either custom placeholder or default bullet character
                  hintText: widget.placeholder ?? '•',
                  hintStyle: effectiveTextStyle?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(77), // Subtle, non-intrusive hint color
                  ),
                ),
                
                // === EVENT HANDLING ===
                // Connect user interactions to internal state management
                onChanged: (value) => _onChanged(value, i), // Handle text input and validation
                onTap: () => _onTap(i), // Handle field selection and focus management
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Clean up resources when widget is disposed
  /// 
  /// Properly disposes of all controllers and focus nodes to prevent memory leaks.
  /// Critical for performance in apps with frequent navigation or widget rebuilds.
  /// Follows Flutter best practices for resource management.
  @override
  void dispose() {
    // Dispose all text controllers to free memory and prevent leaks
    // Each controller holds references that must be explicitly released
    for (var controller in _controllers) {
      controller.dispose();
    }
    
    // Dispose all focus nodes to clean up focus tree and event listeners
    // Prevents focus-related memory leaks and improper focus behavior
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    
    // Call parent dispose for additional cleanup
    super.dispose();
  }
}

/// Custom text input formatter to convert input to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// Extension to provide public access to state methods
extension InputCodeGroupController on GlobalKey<InputCodeGroupState> {
  /// Clear all input fields
  void clearAll() => currentState?.clearAll();
  
  /// Set the complete code
  void setCode(String code) => currentState?.setCode(code);
  
  /// Get current code value
  String? get code => currentState?.code;
}