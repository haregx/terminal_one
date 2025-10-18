import 'package:flutter/material.dart';

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
