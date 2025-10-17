import 'package:flutter/material.dart';

/// AppBarAwareSafeArea - SafeArea that takes a transparent AppBar into account
/// 
/// This widget ensures that content does not disappear under a transparent
/// AppBar, while still allowing the background to remain visible.
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

    // TODO: Implement for respectAppBar

/*    if (!respectAppBar) {
      return SafeArea(child: child);
    }
*/
    
    // Einfaches SafeArea ohne zusätzliches Padding
    // Die AppBar-Höhe wird automatisch von Scaffold gehandhabt
    // Simple SafeArea without extra padding
    // The AppBar height is automatically handled by Scaffold
    return SafeArea(
      child: child,
    );
  }
}