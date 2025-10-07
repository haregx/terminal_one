import 'package:flutter/material.dart';

class DashboardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const DashboardContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;

    // Optimierte Container-Padding für Dashboard
    EdgeInsetsGeometry containerPadding = padding ?? 
      (isDesktop 
        ? const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0)
        : isTablet 
          ? const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0)
          : const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0)
      );

    EdgeInsetsGeometry containerMargin = margin ?? 
      (isDesktop 
        ? const EdgeInsets.symmetric(horizontal: 16.0)
        : isTablet 
          ? const EdgeInsets.symmetric(horizontal: 12.0)
          : const EdgeInsets.symmetric(horizontal: 6.0)
      );

    return Container(
      width: double.infinity,
      margin: containerMargin,
      padding: containerPadding,
      child: child,
    );
  }
}