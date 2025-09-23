import 'package:flutter/material.dart';
import '../widgets/fancy_background.dart';

/// ResponsiveLayout - Universal responsive wrapper for all screens
/// 
/// Automatically handles responsive behavior for mobile, tablet, and desktop.
/// Use this widget to wrap any screen content for consistent responsive design.
/// 
/// Features:
/// - Automatic device detection (mobile/tablet/desktop)
/// - Centralized responsive constraints
/// - Consistent padding and spacing
/// - Optimized for different screen sizes
/// - Automatic scrolling when content exceeds screen height (landscape mode)
class ResponsiveLayout extends StatelessWidget {
  /// The child widget to make responsive
  final Widget child;
  
  /// Maximum width for content on large screens (default: 600px)
  final double maxWidth;
  
  /// Whether to add standard padding around content
  final bool addPadding;
  
  /// Custom padding (overrides addPadding if provided)
  final EdgeInsets? padding;
  
  /// Whether to enable scrolling when content overflows (default: true)
  final bool enableScrolling;
  
  /// Whether to enable the fancy glassmorphism background (default: true)
  final bool enableFancyBackground;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.maxWidth = 600.0,
    this.addPadding = true,
    this.padding,
    this.enableScrolling = true,
    this.enableFancyBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 900;
    
    // Calculate responsive padding
    EdgeInsets responsivePadding;
    if (padding != null) {
      responsivePadding = padding!;
    } else if (addPadding) {
      responsivePadding = EdgeInsets.all(
        isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0)
      );
    } else {
      responsivePadding = EdgeInsets.zero;
    }

    Widget content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );

    // Add scrolling capability, especially useful in landscape mode
    if (enableScrolling) {
      content = SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            // Ensure content takes at least the available height minus padding
            minHeight: screenHeight - 
                       MediaQuery.of(context).padding.top - 
                       MediaQuery.of(context).padding.bottom -
                       (responsivePadding.top + responsivePadding.bottom) -
                       kToolbarHeight, // Account for AppBar
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: child,
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: enableFancyBackground 
        ? FancyBackground(
            child: Padding(
              padding: responsivePadding,
              child: content,
            ),
          )
        : Padding(
            padding: responsivePadding,
            child: content,
          ),
    );
  }
}

/// ResponsiveSpacing - Provides device-appropriate spacing
class ResponsiveSpacing {
  static double small(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600 ? 12.0 : 8.0;
  }
  
  static double medium(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600 ? 24.0 : 16.0;
  }
  
  static double large(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600 ? 32.0 : 24.0;
  }
}

/// ResponsiveInputCalculator - Centralized input field calculations
class ResponsiveInputCalculator {
  /// Calculate optimal field width for code inputs
  static double calculateFieldWidth({
    required BuildContext context,
    required int fieldCount,
    double? maxContainerWidth,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    // Container width (limited on tablets)
    final containerWidth = maxContainerWidth ?? 
        (isTablet ? (screenWidth > 600 ? 600.0 : screenWidth) : screenWidth);
    
    // Available width for input fields
    final availableWidth = containerWidth - (isTablet ? 40 : 32); // Account for padding
    final spacing = isTablet ? 12.0 : 8.0;
    final spacingTotal = (fieldCount - 1) * spacing;
    final fieldWidth = (availableWidth - spacingTotal) / fieldCount;
    
    // Device-specific field size constraints
    final minWidth = isTablet ? 50.0 : (fieldCount <= 6 ? 40.0 : 35.0);
    final maxWidth = isTablet ? 80.0 : (fieldCount <= 6 ? 60.0 : 50.0);
    
    return fieldWidth.clamp(minWidth, maxWidth);
  }
  
  /// Get appropriate spacing between input fields
  static double getFieldSpacing(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600 ? 12.0 : 8.0;
  }
}