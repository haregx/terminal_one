import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// FancyBackground - Glassmorphism background for all screens
/// 
/// Provides a consistent, beautiful glassmorphism effect with:
/// - Gradient background that adapts to theme
/// - Subtle geometric pattern overlay
/// - Frosted glass blur effect
/// - Automatic theme color integration
/// 
/// Features:
/// - Theme-aware colors (Light/Dark mode support)
/// - Responsive geometric patterns
/// - Performance optimized
/// - Easy integration for all screens
class FancyBackground extends StatelessWidget {
  /// The child widget to display on top of the background
  final Widget child;
  
  /// Whether to enable the blur effect (default: true)
  /// Set to false for better performance on older devices
  final bool enableBlur;
  
  /// Intensity of the pattern overlay (0.0 to 1.0, default: 0.3)
  final double patternOpacity;
  
  const FancyBackground({
    super.key,
    required this.child,
    this.enableBlur = true,
    this.patternOpacity = 0.1, // Viel subtiler
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Multi-stop gradient that adapts to theme
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.4, 0.7, 1.0],
          colors: _buildGradientColors(context),
        ),
      ),
      child: Stack(
        children: [
          // Geometric pattern overlay
          if (patternOpacity > 0.0)
            Positioned.fill(
              child: CustomPaint(
                painter: GeometricPatternPainter(
                  context: context,
                  opacity: patternOpacity,
                ),
              ),
            ),
          
          // Main content with optional blur effect
          if (enableBlur)
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.2, // Sehr subtiler Blur für Body
                sigmaY: 0.2, // Sehr subtiler Blur für Body
              ), // Viel weniger Blur für bessere Lesbarkeit
              child: child,
            )
          else
            child,
        ],
      ),
    );
  }
  
  /// Build theme-aware gradient colors
  List<Color> _buildGradientColors(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    
    if (brightness == Brightness.dark) {
      // Dark theme: Subtle, elegant dark gradients
      return [
        colorScheme.primary.withAlpha(13),
        colorScheme.secondary.withAlpha(20),
        colorScheme.surface.withAlpha(250),
        colorScheme.surface,
      ];
    } else {
      // Light theme: Subtile helle Glassmorphism-Effekte (guter Zustand)
      return [
        colorScheme.primary.withAlpha(20), // Leicht sichtbarer blauer Schimmer
        Colors.blue.shade50.withAlpha(153), // Sehr helles Blau
        Colors.white.withAlpha(242), // Fast reines Weiß
        Colors.grey.shade50.withAlpha(204), // Sehr helles Grau für Tiefe
      ];
    }
  }
}

/// CustomPainter for subtle geometric patterns
/// 
/// Creates a beautiful, responsive geometric overlay that:
/// - Adapts to screen size
/// - Uses theme colors
/// - Provides subtle visual interest
/// - Maintains performance
class GeometricPatternPainter extends CustomPainter {
  final BuildContext context;
  final double opacity;
  
  const GeometricPatternPainter({
    required this.context,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    
    // Pattern colors based on theme
    final patternColor = brightness == Brightness.dark
        ? colorScheme.primary.withAlpha((opacity * 38.25).round())
        : colorScheme.primary.withAlpha((opacity * 20.4).round());
    
    final accentColor = brightness == Brightness.dark
        ? colorScheme.secondary.withAlpha((opacity * 25.5).round())
        : colorScheme.secondary.withAlpha((opacity * 15.3).round());
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    // Calculate responsive grid size
    final gridSize = math.min(size.width, size.height) / 20;
    final cols = (size.width / gridSize).ceil();
    final rows = (size.height / gridSize).ceil();
    
    // Draw subtle geometric grid
    paint.color = patternColor;
    for (int i = 0; i <= cols; i += 3) {
      final x = i * gridSize;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    for (int i = 0; i <= rows; i += 3) {
      final y = i * gridSize;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
    
    // Add subtle diagonal lines for extra elegance
    paint.color = accentColor;
    paint.strokeWidth = 0.5;
    
    for (int i = 0; i < cols + rows; i += 6) {
      final startX = i * gridSize;
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX - size.height, size.height),
        paint,
      );
    }
    
    // Add some circular accent points
    paint.style = PaintingStyle.fill;
    final circleRadius = gridSize * 0.1;
    
    for (int i = 2; i < cols; i += 8) {
      for (int j = 2; j < rows; j += 6) {
        final center = Offset(i * gridSize, j * gridSize);
        canvas.drawCircle(center, circleRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}