import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// GlassmorphAppBar - Glassmorphism AppBar for all screens
/// 
/// Provides a beautiful glassmorphism effect that matches the FancyBackground.
/// Features:
/// - Transparent background with blur effect
/// - Theme-aware colors (Light/Dark mode support)
/// - Automatic status bar styling
/// - Consistent with app design language
/// 
/// Usage:
/// ```dart
/// appBar: GlassmorphAppBar(
///   title: Text('My Screen'),
/// ),
/// ```
class GlassmorphAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title widget for the app bar
  final Widget? title;
  
  /// Whether the title should be centered (default: true)
  final bool centerTitle;
  
  /// Leading widget (usually back button)
  final Widget? leading;
  
  /// Actions for the app bar
  final List<Widget>? actions;
  
  /// Background opacity (0.0 to 1.0, default: 0.15)
  final double backgroundOpacity;
  
  /// Blur intensity (default: 10.0)
  final double blurIntensity;
  
  const GlassmorphAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.backgroundOpacity = 0.15, // Ursprünglicher Wert
    this.blurIntensity = 8.0, // Ursprünglicher Wert
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    
    // Set status bar style based on theme
    SystemChrome.setSystemUIOverlayStyle(
      brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
    );
    
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _buildAppBarGradient(context),
          ),
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withAlpha(26), // Ursprünglicher Wert
              width: 0.5, // Ursprünglicher Wert
            ),
          ),
        ),
        child: AppBar(
          title: title,
          centerTitle: centerTitle,
          leading: leading,
          actions: actions,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
  
  /// Build theme-aware gradient for the app bar
  List<Color> _buildAppBarGradient(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    
    if (brightness == Brightness.dark) {
      // Dark theme: Subtle dark glassmorphism
      return [
        colorScheme.surface.withAlpha(((backgroundOpacity + 0.1) * 255).round()),
        colorScheme.surface.withAlpha((backgroundOpacity * 255).round()),
        colorScheme.surface.withAlpha(((backgroundOpacity - 0.05) * 255).round()),
      ];
    } else {
      // Light theme: Subtiler heller Glassmorphism mit leichtem Schimmer
      return [
        Colors.white.withAlpha(217), // Ursprünglicher Zustand
        Colors.blue.shade50.withAlpha(77), // Ursprünglicher Zustand
        Colors.white.withAlpha(204), // Ursprünglicher Zustand
      ];
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}