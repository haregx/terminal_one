import 'package:flutter/material.dart';

class ResponsivePadding {
  static EdgeInsetsGeometry getDashboardPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth > 1200) {
      return const EdgeInsets.all(24.0);
    } else if (screenWidth > 600) {
      return const EdgeInsets.all(20.0);
    } else {
      return const EdgeInsets.all(16.0);
    }
  }

  static EdgeInsetsGeometry getCardPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth > 1200) {
      return const EdgeInsets.all(20.0);
    } else if (screenWidth > 600) {
      return const EdgeInsets.all(16.0);
    } else {
      return const EdgeInsets.all(12.0);
    }
  }

  static double getGridSpacing(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth > 1200) {
      return 20.0;
    } else if (screenWidth > 600) {
      return 16.0;
    } else {
      return 10.0; // Reduziert für Mobile
    }
  }
}