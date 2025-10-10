import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'app_background.dart';

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
    final isWeb = kIsWeb;
    
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: false, // Status Bar sichtbar lassen
        appBar: showAppBar ? AppBar(
          title: title, // Für alle Plattformen gleich - keine WebStatusBar hier!
          centerTitle: centerTitle,
          leading: leading,
          actions: actions,
          backgroundColor: Colors.transparent, // Vollständig transparent
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface, // Sichtbare Textfarbe
          toolbarHeight: kToolbarHeight, // Standard-Höhe für alle Plattformen
        ) : null,
        body: isWeb 
          ? body // Web: Kein SafeArea, da kein nativer Status Bar
          : SafeArea(
              top: true, // Mobile: Status Bar Bereich respektieren
              child: body,
            ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        drawer: drawer,
      ),
    );
  }
}