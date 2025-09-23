import 'package:flutter/material.dart';

/// AppLogo - A reusable logo widget for the Terminal.One app
/// 
/// This widget provides a consistent logo across all screens.
/// It can be used in different sizes and variants.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = LogoSize.medium,
    this.variant = LogoVariant.full,
    this.color,
  });

  final LogoSize size;
  final LogoVariant variant;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logoColor = color ?? theme.colorScheme.primary;
    
    double fontSize;
    double iconSize;
    double spacing;
    
    switch (size) {
      case LogoSize.small:
        fontSize = 16;
        iconSize = 20;
        spacing = 4;
        break;
      case LogoSize.medium:
        fontSize = 24;
        iconSize = 28;
        spacing = 8;
        break;
      case LogoSize.large:
        fontSize = 32;
        iconSize = 36;
        spacing = 12;
        break;
      case LogoSize.extraLarge:
        fontSize = 40;
        iconSize = 44;
        spacing = 16;
        break;
    }

    switch (variant) {
      case LogoVariant.iconOnly:
        return Container(
          padding: EdgeInsets.all(spacing),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                logoColor,
                logoColor.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: logoColor.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.terminal,
            size: iconSize,
            color: Colors.white,
          ),
        );
        
      case LogoVariant.textOnly:
        return Text(
          'Terminal.One',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: logoColor,
            letterSpacing: 1.2,
          ),
        );
        
      case LogoVariant.full:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: spacing * 1.5,
            vertical: spacing,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                logoColor,
                logoColor.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: logoColor.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.terminal,
                size: iconSize,
                color: Colors.white,
              ),
              SizedBox(width: spacing),
              Text(
                'Terminal.One',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        );
        
      case LogoVariant.minimal:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.terminal,
              size: iconSize,
              color: logoColor,
            ),
            SizedBox(width: spacing),
            Text(
              'Terminal.One',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: logoColor,
                letterSpacing: 0.8,
              ),
            ),
          ],
        );
    }
  }
}

enum LogoSize {
  small,
  medium,
  large,
  extraLarge,
}

enum LogoVariant {
  iconOnly,
  textOnly,
  full,
  minimal,
}