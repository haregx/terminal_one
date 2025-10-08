import 'package:flutter/material.dart';
import 'dart:ui';

/// SimpleCard - Eine minimalistische, responsive Card für das Dashboard
/// 
/// Ersetzt alle komplexen Dashboard-Cards durch eine einzige, einfache Implementierung
class SimpleCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  
  const SimpleCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Colors.white.withValues(alpha: 0.4),
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.1),
                ]
              : [
                  Colors.white.withValues(alpha: 0.35), // Reduziert von 0.5 auf 0.35
                  Colors.white.withValues(alpha: 0.2),  // Reduziert von 0.3 auf 0.2
                  Colors.white.withValues(alpha: 0.05), // Reduziert von 0.1 auf 0.05
                ],
          stops: const [0.0, 0.5, 1.0],
        ),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.5), // Reduziert von 0.7 auf 0.5
          width: 1.5,
        ),
        boxShadow: [
          // Haupt-Schatten
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.5)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          // Highlight-Glow (verstärkt)
          BoxShadow(
            color: isDark
                ? Colors.white.withValues(alpha: 0.15) // Verstärkt für mehr Glow
                : Colors.white.withValues(alpha: 0.95), // Verstärkt für mehr Glow
            blurRadius: 25, // Erhöht für stärkeren Glow
            spreadRadius: -2,
            offset: const Offset(0, -3),
          ),
          // Zusätzlicher äußerer Glow
          BoxShadow(
            color: isDark
                ? Colors.blue.withValues(alpha: 0.1) // Subtiler blauer Glow
                : Colors.blue.withValues(alpha: 0.05), // Subtiler blauer Glow
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
          // Innerer Glow-Simulation
          BoxShadow(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.7),
            blurRadius: 15,
            spreadRadius: -8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withValues(alpha: 0.15),
                        Colors.white.withValues(alpha: 0.05),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.15), // Reduziert von 0.2 auf 0.15
                        Colors.white.withValues(alpha: 0.03), // Reduziert von 0.05 auf 0.03
                      ],
              ),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.4), // Reduziert für subtileren inneren Border
                width: 0.5,
              ),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              splashColor: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.2), // Reduziert für subtilere Interaktion
              highlightColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.1), // Reduziert für subtilere Interaktion
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// QuickAction - Einfache Action Card
class QuickAction extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color; // Neue Eigenschaft für Hintergrundfarbe
  final Color? iconColor; // Neue Eigenschaft für Icon-Farbe

  const QuickAction({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Responsive Schriftgrößen und Abstände
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600; // iPad Erkennung
    final double fontSize = isTablet ? 16.0 : 12.0; // Größer auf iPad
    final double iconSize = isTablet ? 96.0 : 48.0; // Icon auch responsive
    final double topPadding = isTablet ? 36.0 : 16.0; // Mehr Abstand von oben auf iPad
    final double iconTextSpacing = isTablet ? 16.0 : 12.0; // Mehr Abstand zwischen Icon und Text auf iPad
    
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: color != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color!.withValues(alpha: isDark ? 0.9 : 0.95),
                  color!.withValues(alpha: isDark ? 0.7 : 0.8),
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withValues(alpha: 0.4),
                        Colors.white.withValues(alpha: 0.2),
                        Colors.white.withValues(alpha: 0.1),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.35),
                        Colors.white.withValues(alpha: 0.2),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                stops: color == null ? const [0.0, 0.5, 1.0] : null,
              ),
        border: Border.all(
          color: color != null
              ? color!.withValues(alpha: 0.15) // Reduziert von 0.3 auf 0.15 für subtileren Rand
              : isDark
                  ? Colors.white.withValues(alpha: 0.3) // Reduziert von 0.5 auf 0.3
                  : Colors.white.withValues(alpha: 0.3), // Reduziert von 0.5 auf 0.3
          width: 1.0, // Reduziert von 1.5 auf 1.0 für dünneren Rand
        ),
        // Entferne alle Schatten, die außerhalb der Karte sichtbar werden könnten
        boxShadow: const [], // Keine Schatten
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            decoration: BoxDecoration(
              color: color != null
                  ? color!.withValues(alpha: isDark ? 0.15 : 0.2)
                  : isDark
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.15),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              splashColor: color != null
                  ? color!.withValues(alpha: 0.2)
                  : isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.white.withValues(alpha: 0.2),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // Oben ausrichten statt zentriert
                  crossAxisAlignment: CrossAxisAlignment.center, // Horizontal zentriert
                  children: [
                    SizedBox(height: topPadding), // Responsive Abstand von oben
                    Icon(
                      icon,
                      size: iconSize, // Responsive Icon-Größe
                      color: iconColor ?? (color != null ? Colors.white : null),
                    ),
                    SizedBox(height: iconTextSpacing), // Responsive Abstand zwischen Icon und Text
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: fontSize, // Responsive Schriftgröße
                        color: iconColor ?? (color != null ? Colors.white : null),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// StatCard - Einfache Statistik Card
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color? color; // Neue Eigenschaft für Hintergrundfarbe
  final Color? iconColor; // Neue Eigenschaft für Icon- und Textfarbe

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.color,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: color != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color!.withValues(alpha: isDark ? 0.9 : 0.95),
                  color!.withValues(alpha: isDark ? 0.7 : 0.8),
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withValues(alpha: 0.4),
                        Colors.white.withValues(alpha: 0.2),
                        Colors.white.withValues(alpha: 0.1),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.35),
                        Colors.white.withValues(alpha: 0.2),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                stops: color == null ? const [0.0, 0.5, 1.0] : null,
              ),
        border: Border.all(
          color: color != null
              ? color!.withValues(alpha: 0.15)
              : isDark
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.3),
          width: 1.0,
        ),
        boxShadow: const [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            decoration: BoxDecoration(
              color: color != null
                  ? color!.withValues(alpha: isDark ? 0.15 : 0.2)
                  : isDark
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon, 
                    size: 20,
                    color: iconColor ?? (color != null ? Colors.white : null),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: iconColor ?? (color != null ? Colors.white : null),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 10,
                        color: iconColor ?? (color != null ? Colors.white : null),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ThemeCard - Einfache Theme Toggle Card
class ThemeCard extends StatelessWidget {
  final VoidCallback onTap;
  final String currentTheme;

  const ThemeCard({
    super.key,
    required this.onTap,
    required this.currentTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SimpleCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            size: 36, // Vergrößert von 24 auf 36
          ),
          const SizedBox(height: 12), // Vergrößert von 8 auf 12
          const Text(
            'Theme',
            style: TextStyle(fontSize: 14), // Vergrößert von 12 auf 14
          ),
          const SizedBox(height: 4),
          Text(
            currentTheme,
            style: const TextStyle(fontSize: 12), // Vergrößert von 10 auf 12
          ),
        ],
      ),
    );
  }
}