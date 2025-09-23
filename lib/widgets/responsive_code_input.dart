import 'package:flutter/material.dart';
import '../components/inputs/input_code_group.dart';
import '../utils/responsive_layout.dart';

/// ResponsiveCodeInput - Ready-to-use responsive code input widget
/// 
/// Automatically handles responsive behavior for code inputs across all devices.
/// Just specify the code length and callbacks - all responsive logic is handled internally.
/// 
/// Usage:
/// ```dart
/// final codeInputKey = GlobalKey<InputCodeGroupState>();
/// ResponsiveCodeInput(
///   key: codeInputKey,
///   codeLength: 6,
///   onChanged: (value) => print('Input: $value'),
///   onCompleted: (value) => print('Completed: $value'),
/// )
/// // To clear: codeInputKey.clearAll();
/// ```
class ResponsiveCodeInput extends StatelessWidget {
  /// Number of digits for the verification code
  final int codeLength;
  
  /// Callback when input changes
  final ValueChanged<String>? onChanged;
  
  /// Callback when input is completed
  final ValueChanged<String>? onCompleted;
  
  /// Callback when validation state changes
  final void Function(bool isValid)? onValid;
  
  /// Maximum container width (optional)
  final double? maxWidth;
  
  /// Global key to access InputCodeGroup methods
  final GlobalKey<InputCodeGroupState>? codeInputKey;

  const ResponsiveCodeInput({
    super.key,
    required this.codeLength,
    this.onChanged,
    this.onCompleted,
    this.onValid,
    this.maxWidth,
    this.codeInputKey,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Use centralized responsive calculations
        final fieldWidth = ResponsiveInputCalculator.calculateFieldWidth(
          context: context,
          fieldCount: codeLength,
          maxContainerWidth: maxWidth,
        );
        
        final fieldSpacing = ResponsiveInputCalculator.getFieldSpacing(context);
        
        return InputCodeGroup(
          key: codeInputKey,
          length: codeLength,
          fieldWidth: fieldWidth,
          fieldSpacing: fieldSpacing,
          onChanged: onChanged,
          onCompleted: onCompleted,
          onValid: onValid,
        );
      },
    );
  }
}