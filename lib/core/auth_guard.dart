import 'package:flutter/material.dart';
import '../providers/auth_state_provider.dart';
import '../screens/home_screen.dart';
import '../providers/theme_provider.dart';
import '../widgets/splash_screen.dart';

/// AuthGuard - Lädt die App-Initialisierung und zeigt dann den HomeScreen
/// 
/// Der HomeScreen wird immer angezeigt - Login ist optional
/// Reagiert auf Änderungen des Anmeldestatus über den AuthStateNotifier
class AuthGuard extends StatefulWidget {
  final int codeLength;
  final ThemeProvider themeProvider;
  
  const AuthGuard({
    super.key,
    required this.codeLength,
    required this.themeProvider,
  });

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  final AuthStateNotifier _authStateNotifier = AuthStateNotifier();

  @override
  void initState() {
    super.initState();
    // Initialisierung der Auth-State
    _authStateNotifier.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _authStateNotifier,
      builder: (context, child) {
        // Warten bis Initialisierung abgeschlossen ist
        if (!_authStateNotifier.isInitialized) {
          return const SplashScreen();
        }
        
        // Immer HomeScreen anzeigen - Login ist optional
        return HomeScreen(
          codeLength: widget.codeLength,
          themeProvider: widget.themeProvider,
        );
      },
    );
  }
}