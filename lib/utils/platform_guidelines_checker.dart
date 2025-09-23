import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';

/// Guidelines checker that ensures UI components follow platform conventions
/// 
/// This utility provides static analysis and runtime checks to ensure
/// components follow iOS Human Interface Guidelines and Material Design Guidelines
class PlatformGuidelinesChecker {
  PlatformGuidelinesChecker._();

  /// Check if text follows platform typography guidelines
  static Map<String, dynamic> checkTypography(BuildContext context, TextStyle? style) {
    final results = <String, dynamic>{};
    
    if (PlatformUtils.isIOSContext(context)) {
      // iOS Typography Guidelines
      results['platform'] = 'iOS';
      results['recommendations'] = <String>[];
      
      if (style?.fontSize != null) {
        // iOS standard font sizes: 11, 12, 13, 15, 17, 20, 24, 28, 34
        final standardSizes = [11.0, 12.0, 13.0, 15.0, 17.0, 20.0, 24.0, 28.0, 34.0];
        if (!standardSizes.contains(style!.fontSize)) {
          results['recommendations'].add('Consider using iOS standard font sizes: ${standardSizes.join(", ")}pt');
        }
      }
      
      // Check for San Francisco font family (default in iOS)
      if (style?.fontFamily != null && !style!.fontFamily!.contains('SF')) {
        results['recommendations'].add('Consider using San Francisco font family (.SF UI Text/Display)');
      }
      
    } else {
      // Android Material Design Typography
      results['platform'] = 'Android';
      results['recommendations'] = <String>[];
      
      if (style?.fontSize != null) {
        // Material Design type scale
        final materialSizes = [10.0, 11.0, 12.0, 14.0, 16.0, 20.0, 24.0, 28.0, 32.0, 36.0, 45.0, 57.0];
        if (!materialSizes.contains(style!.fontSize)) {
          results['recommendations'].add('Consider using Material Design type scale sizes');
        }
      }
      
      // Check for Roboto font family
      if (style?.fontFamily != null && !style!.fontFamily!.contains('Roboto')) {
        results['recommendations'].add('Consider using Roboto font family');
      }
    }
    
    return results;
  }

  /// Check if spacing follows platform guidelines
  static Map<String, dynamic> checkSpacing(BuildContext context, EdgeInsets padding) {
    final results = <String, dynamic>{};
    
    if (PlatformUtils.isIOSContext(context)) {
      results['platform'] = 'iOS';
      results['recommendations'] = <String>[];
      
      // iOS standard spacing: 4, 8, 12, 16, 20, 24, 32, 44
      final standardSpacing = [4.0, 8.0, 12.0, 16.0, 20.0, 24.0, 32.0, 44.0];
      
      if (!standardSpacing.contains(padding.left)) {
        results['recommendations'].add('Consider using iOS standard spacing for horizontal padding');
      }
      
      if (!standardSpacing.contains(padding.top)) {
        results['recommendations'].add('Consider using iOS standard spacing for vertical padding');
      }
      
    } else {
      results['platform'] = 'Android';
      results['recommendations'] = <String>[];
      
      // Material Design spacing: 4dp increments (4, 8, 12, 16, 24, 32, 48, 64)
      final materialSpacing = [4.0, 8.0, 12.0, 16.0, 24.0, 32.0, 48.0, 64.0];
      
      if (!materialSpacing.contains(padding.left)) {
        results['recommendations'].add('Consider using Material Design 4dp grid spacing');
      }
      
      if (!materialSpacing.contains(padding.top)) {
        results['recommendations'].add('Consider using Material Design 4dp grid spacing');
      }
    }
    
    return results;
  }

  /// Check if colors follow platform accessibility guidelines
  static Map<String, dynamic> checkColorContrast(Color foreground, Color background) {
    final results = <String, dynamic>{};
    
    // Calculate relative luminance
    double getLuminance(Color color) {
      double getRed() {
        final red = ((color.r * 255.0).round() & 0xff) / 255.0;
        return red <= 0.03928 ? red / 12.92 : ((red + 0.055) / 1.055).pow(2.4);
      }
      
      double getGreen() {
        final green = ((color.g * 255.0).round() & 0xff) / 255.0;
        return green <= 0.03928 ? green / 12.92 : ((green + 0.055) / 1.055).pow(2.4);
      }
      
      double getBlue() {
        final blue = ((color.b * 255.0).round() & 0xff) / 255.0;
        return blue <= 0.03928 ? blue / 12.92 : ((blue + 0.055) / 1.055).pow(2.4);
      }
      
      return 0.2126 * getRed() + 0.7152 * getGreen() + 0.0722 * getBlue();
    }
    
    final l1 = getLuminance(foreground);
    final l2 = getLuminance(background);
    final ratio = (l1 > l2) ? (l1 + 0.05) / (l2 + 0.05) : (l2 + 0.05) / (l1 + 0.05);
    
    results['contrastRatio'] = ratio.toStringAsFixed(2);
    results['wcagAA'] = ratio >= 4.5; // WCAG AA compliance
    results['wcagAAA'] = ratio >= 7.0; // WCAG AAA compliance
    
    if (ratio < 4.5) {
      results['recommendation'] = 'Increase color contrast for better accessibility (WCAG AA requires 4.5:1)';
    } else if (ratio < 7.0) {
      results['recommendation'] = 'Good contrast (WCAG AA compliant). Consider higher contrast for WCAG AAA compliance';
    } else {
      results['recommendation'] = 'Excellent contrast (WCAG AAA compliant)';
    }
    
    return results;
  }

  /// Check if button follows platform guidelines
  static Map<String, dynamic> checkButtonDesign(BuildContext context, {
    required double? height,
    required EdgeInsets? padding,
    required double? borderRadius,
  }) {
    final results = <String, dynamic>{};
    
    if (PlatformUtils.isIOSContext(context)) {
      results['platform'] = 'iOS';
      results['recommendations'] = <String>[];
      
      // iOS button height should be at least 44pt for touch targets
      if (height != null && height < 44.0) {
        results['recommendations'].add('iOS buttons should be at least 44pt tall for touch accessibility');
      }
      
      // iOS standard corner radius is 8-12pt
      if (borderRadius != null && (borderRadius < 6.0 || borderRadius > 14.0)) {
        results['recommendations'].add('Consider iOS standard corner radius (8-12pt)');
      }
      
    } else {
      results['platform'] = 'Android';
      results['recommendations'] = <String>[];
      
      // Material buttons should be at least 48dp tall
      if (height != null && height < 48.0) {
        results['recommendations'].add('Material buttons should be at least 48dp tall for touch accessibility');
      }
      
      // Material Design corner radius is typically 4dp for buttons
      if (borderRadius != null && borderRadius != 4.0) {
        results['recommendations'].add('Consider Material Design standard corner radius (4dp for buttons)');
      }
    }
    
    return results;
  }

  /// Generate comprehensive platform compliance report
  static Map<String, dynamic> generateComplianceReport(BuildContext context) {
    final report = <String, dynamic>{};
    final platform = PlatformUtils.isIOSContext(context) ? 'iOS' : 'Android';
    
    report['platform'] = platform;
    report['timestamp'] = DateTime.now().toIso8601String();
    report['guidelines'] = platform == 'iOS' 
        ? 'Human Interface Guidelines'
        : 'Material Design Guidelines';
    
    // Platform-specific recommendations
    report['generalRecommendations'] = platform == 'iOS' ? [
      'Use San Francisco font family',
      'Minimum touch target: 44x44pt',
      'Standard spacing: 4, 8, 12, 16, 20, 24, 32, 44pt',
      'Corner radius: 8-12pt for buttons',
      'Use CupertinoAlertDialog for dialogs',
      'Use CupertinoButton for primary actions',
      'Follow iOS color semantic tokens',
    ] : [
      'Use Roboto font family', 
      'Minimum touch target: 48x48dp',
      'Spacing based on 4dp grid',
      'Corner radius: 4dp for buttons',
      'Use AlertDialog for dialogs',
      'Use ElevatedButton for primary actions',
      'Follow Material Design color tokens',
    ];
    
    return report;
  }
}

// Extension to add pow method to double
extension DoubleExtension on double {
  double pow(double exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= this;
    }
    return result;
  }
}