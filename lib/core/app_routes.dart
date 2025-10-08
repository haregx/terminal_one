import 'package:flutter/material.dart';
import 'package:terminal_one/screens/auth/login_screen.dart';
import 'package:terminal_one/screens/auth/logout_screen.dart';
import 'package:terminal_one/screens/auth/password_request_screen.dart';
import 'package:terminal_one/screens/auth/register_screen.dart';
import 'package:terminal_one/screens/games/more_games.dart';
import 'package:terminal_one/screens/games/promocode_screen.dart';
import 'package:terminal_one/screens/home/home_screen_loggedin.dart';
import 'package:terminal_one/screens/home/home_screen_loggedout.dart';
import 'package:terminal_one/screens/home/home_screen_router.dart';

/// Central App Routes Configuration
/// 
/// This class contains all route definitions for the application.
/// It provides a centralized way to manage navigation and routing.
class AppRoutes {
  // Route names as constants
  static const String home = '/';
  static const String homeLoggedIn = '/home-logged-in';
  static const String homeLoggedOut = '/home-logged-out';
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String passwordRequest = '/password-request';
  static const String moreGames = '/more-games';
  static const String promoCode = '/promo-code';

  /// Generate routes for the application
  /// 
  /// This method handles all route generation and provides
  /// proper error handling for unknown routes.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreenRouter(),
          settings: settings,
        );

      case homeLoggedIn:
        return MaterialPageRoute(
          builder: (_) => const HomeScreenLoggedIn(),
          settings: settings,
        );

      case homeLoggedOut:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );

      case logout:
        return MaterialPageRoute(
          builder: (_) => const LogoutScreen(),
          settings: settings,
        );

      case passwordRequest:
        return MaterialPageRoute(
          builder: (_) => const PasswordRequestScreen(),
          settings: settings,
        );

      case moreGames:
        return MaterialPageRoute(
          builder: (_) => const MoreGamesScreen(),
          settings: settings,
        );

      case promoCode:
        // Extract code length from arguments if provided
        final args = settings.arguments as Map<String, dynamic>?;
        final codeLength = args?['codeLength'] as int? ?? 6;
        
        return MaterialPageRoute(
          builder: (_) => PromoCodeScreen(codeLength: codeLength),
          settings: settings,
        );

      default:
        return _errorRoute(settings);
    }
  }

  /// Error route for unknown routes
  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Route not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'The route "${settings.name}" does not exist.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    home,
                    (route) => false,
                  );
                },
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
      settings: settings,
    );
  }

  /// Navigation helper methods for easy access
  static void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, home, (route) => false);
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, login);
  }

  static void navigateToRegister(BuildContext context) {
    Navigator.pushNamed(context, register);
  }

  static void navigateToLogout(BuildContext context) {
    Navigator.pushNamed(context, logout);
  }

  static void navigateToPasswordRequest(BuildContext context) {
    Navigator.pushNamed(context, passwordRequest);
  }

  static void navigateToMoreGames(BuildContext context) {
    Navigator.pushNamed(context, moreGames);
  }

  static void navigateToPromoCode(BuildContext context, {int codeLength = 6}) {
    Navigator.pushNamed(
      context,
      promoCode,
      arguments: {'codeLength': codeLength},
    );
  }

  static void navigateToHomeLoggedIn(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, homeLoggedIn, (route) => false);
  }

  static void navigateToHomeLoggedOut(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, homeLoggedOut, (route) => false);
  }

  /// Get all route names for debugging/testing
  static List<String> getAllRoutes() {
    return [
      home,
      homeLoggedIn,
      homeLoggedOut,
      login,
      register,
      logout,
      passwordRequest,
      moreGames,
      promoCode,
    ];
  }
}