import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terminal_one/providers/auth_provider.dart';
import 'package:terminal_one/screens/home/home_screen_loggedout.dart';
import 'package:terminal_one/screens/home/home_screen_loggedin.dart';

/// HomeScreenRouter - Routes to appropriate home screen based on auth state
/// 
/// This widget automatically determines which home screen to show based on
/// the user's authentication status:
/// - HomeScreenLoggedOut for unauthenticated users
/// - HomeScreenLoggedIn for authenticated users
class HomeScreenRouter extends StatelessWidget {
  const HomeScreenRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        debugPrint('🏠 HomeScreenRouter: Auth state is ${authProvider.isLoggedIn ? "LOGGED IN" : "LOGGED OUT"}');
        
        if (authProvider.isLoggedIn) {
          debugPrint('🏠 HomeScreenRouter: Showing HomeScreenLoggedIn');
          return const HomeScreenLoggedIn();
        } else {
          debugPrint('🏠 HomeScreenRouter: Showing HomeScreen (logged out)');
          return const HomeScreen(); // HomeScreenLoggedOut
        }
      },
    );
  }
}