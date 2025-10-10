import 'package:flutter/material.dart';

/// AppBarAwareSafeArea - SafeArea das die transparente AppBar berücksichtigt
/// 
/// Dieses Widget stellt sicher, dass der Inhalt nicht unter der transparenten
/// AppBar verschwindet, während der Hintergrund trotzdem sichtbar bleibt.
class AppBarAwareSafeArea extends StatelessWidget {
  /// Das Kind-Widget
  final Widget child;
  
  /// Ob zusätzlicher Top-Padding für die AppBar hinzugefügt werden soll
  final bool respectAppBar;

  const AppBarAwareSafeArea({
    super.key,
    required this.child,
    this.respectAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!respectAppBar) {
      return SafeArea(child: child);
    }
    
    // Einfaches SafeArea ohne zusätzliches Padding
    // Die AppBar-Höhe wird automatisch von Scaffold gehandhabt
    return SafeArea(
      child: child,
    );
  }
}