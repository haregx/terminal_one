import 'package:flutter/material.dart';

/// Glassmorphism Scaffold - Wiederverwendbares Scaffold mit dezenten Glassmorphism-Effekten
/// 
/// Bietet konsistente, subtile Glassmorphism-Effekte für alle Screens:
/// - Dezente AppBar mit subtilen Farben (OHNE withOpacity)
/// - Subtiler Hintergrund-Gradient mit normalen Farben
/// - Perfekte Lesbarkeit in Light/Dark Mode
class GlassmorphismScaffold extends StatelessWidget {
  /// Der Titel der AppBar
  final Widget? title;
  
  /// Ob der Titel zentriert werden soll (default: true)
  final bool centerTitle;
  
  /// Leading Widget für die AppBar
  final Widget? leading;
  
  /// Actions für die AppBar
  final List<Widget>? actions;
  
  /// Der Hauptinhalt des Screens
  final Widget body;
  
  /// Floating Action Button
  final Widget? floatingActionButton;
  
  /// Bottom Navigation Bar
  final Widget? bottomNavigationBar;
  
  /// Drawer
  final Widget? drawer;
  
  /// Ob die AppBar angezeigt werden soll (default: true)
  final bool showAppBar;

  const GlassmorphismScaffold({
    super.key,
    this.title,
    this.centerTitle = true,
    this.leading,
    this.actions,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: showAppBar ? AppBar(
        title: title,
        centerTitle: centerTitle,
        leading: leading,
        actions: actions,
        backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(242), // 95% Sichtbarkeit (255 * 0.95 = 242)
        elevation: 0,
        scrolledUnderElevation: 0,
      ) : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withAlpha(250), // 98% Sichtbarkeit
              Theme.of(context).brightness == Brightness.dark 
                ? Theme.of(context).colorScheme.primary.withAlpha(5) // Sehr subtil (2% Sichtbarkeit)
                : Theme.of(context).colorScheme.primary.withAlpha(3), // Extrem subtil (1% Sichtbarkeit)
            ],
          ),
        ),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }
}