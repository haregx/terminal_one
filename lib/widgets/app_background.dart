import 'package:flutter/material.dart';

/// Background Widget - Zentrale Komponente für den App-Hintergrund
/// 
/// Dieses Widget stellt einen konsistenten Hintergrund für alle Screens bereit:
/// - Lädt das Hintergrundbild aus assets/background/backgound.png
/// - Wendet passende Deckkraft je nach Theme an
/// - Fallback auf Gradient falls Bild nicht verfügbar
class AppBackground extends StatelessWidget {
  /// Das Kind-Widget, das über dem Hintergrund angezeigt wird
  final Widget child;
  
  /// Deckkraft des Hintergrundbildes (default: automatisch je nach Theme)
  final double? opacity;

  const AppBackground({
    super.key,
    required this.child,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundOpacity = opacity ?? (isDark ? 0.3 : 0.2);
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    return Container(
      decoration: BoxDecoration(
        // Fallback Gradient - angepasst für bessere Light Mode Unterstützung
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark ? [
            // Dark Mode: Originaler Gradient
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface.withAlpha(250),
            Theme.of(context).colorScheme.primary.withAlpha(5),
          ] : [
            // Light Mode: Hellerer Gradient um dunkles Hintergrundbild zu überblendet
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface.withAlpha(240),
            Theme.of(context).colorScheme.surface.withAlpha(200), // Mehr weißer Overlay
            Theme.of(context).colorScheme.surface.withAlpha(180), // Starker weißer Overlay am Ende
          ],
        ),
      ),
      child: Stack(
        children: [
          // Hintergrundbild
          Positioned.fill(
            child: Image.asset(
              'assets/background/backgound.png', // Note: Dateiname hat Tippfehler
              fit: BoxFit.cover,
              opacity: AlwaysStoppedAnimation(backgroundOpacity),
              errorBuilder: (context, error, stackTrace) {
                // Falls Bild nicht gefunden wird, zeigen wir nur den Gradient
                debugPrint('Background image not found: $error');
                return const SizedBox.shrink();
              },
            ),
          ),
          
          // Status Bar Overlay - dunkler Bereich oben für bessere Icon-Sichtbarkeit
          if (!isDark) // Nur im Light Mode
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: statusBarHeight + 10, // Status Bar + 10px extra
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3), // Dunkler oben für weiße Icons
                      Colors.black.withOpacity(0.1), // Fade nach unten
                      Colors.transparent, // Transparent am Ende
                    ],
                  ),
                ),
              ),
            ),
          
          // Zusätzlicher weißer Overlay für Light Mode
          if (!isDark)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Theme.of(context).colorScheme.surface.withAlpha(100), // Sanfter Übergang
                      Theme.of(context).colorScheme.surface.withAlpha(150), // Stärkerer weißer Overlay unten
                    ],
                  ),
                ),
              ),
            ),
          // Content über dem Hintergrund
          child,
        ],
      ),
    );
  }
}