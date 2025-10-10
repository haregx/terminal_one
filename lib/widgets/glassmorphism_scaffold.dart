import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
        extendBodyBehindAppBar: false,
        appBar: showAppBar ? AppBar(
          title: title,
          centerTitle: centerTitle,
          leading: leading,
          actions: actions,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          toolbarHeight: kToolbarHeight,
        ) : null,
        body: SafeArea(
          top: !isWeb, // Web: false (kein SafeArea top), Mobile: true
          child: body,
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        drawer: drawer,
      ),
    );
  }
}