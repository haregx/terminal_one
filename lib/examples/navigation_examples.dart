import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';

/// Example of how to use the centralized AppRoutes system
/// 
/// This file demonstrates the different ways to navigate using
/// the new routing system with named routes and helper methods.
class NavigationExamples {
  
  /// Example 1: Using Navigator.pushNamed directly
  static void navigateWithPushNamed(BuildContext context) {
    // Navigate to login screen
    Navigator.pushNamed(context, AppRoutes.login);
    
    // Navigate to promo code with arguments
    Navigator.pushNamed(
      context, 
      AppRoutes.promoCode,
      arguments: {'codeLength': 10},
    );
  }
  
  /// Example 2: Using the helper methods
  static void navigateWithHelpers(BuildContext context) {
    // Much cleaner and type-safe
    AppRoutes.navigateToLogin(context);
    AppRoutes.navigateToPromoCode(context, codeLength: 10);
    AppRoutes.navigateToMoreGames(context);
  }
  
  /// Example 3: Complex navigation patterns
  static void complexNavigationExamples(BuildContext context) {
    // Navigate to home and clear all previous routes
    AppRoutes.navigateToHome(context);
    
    // Navigate to logged in home (for after successful login)
    AppRoutes.navigateToHomeLoggedIn(context);
    
    // Replace current route with login
    Navigator.pushReplacementNamed(context, AppRoutes.login);
    
    // Pop and push to register
    Navigator.popAndPushNamed(context, AppRoutes.register);
  }
  
  /// Example 4: Handling route arguments in widgets
  static Widget buildPromoCodeExample() {
    return Builder(
      builder: (context) {
        return ElevatedButton(
          onPressed: () {
            // Pass custom code length
            AppRoutes.navigateToPromoCode(context, codeLength: 12);
          },
          child: const Text('Open 12-digit Promo Code'),
        );
      },
    );
  }
  
  /// Example 5: Route checking and validation
  static void routeDebugging() {
    // Get all available routes for debugging
    final allRoutes = AppRoutes.getAllRoutes();
    debugPrint('Available routes: $allRoutes');
    
    // Check if a route exists
    final hasPromoRoute = allRoutes.contains(AppRoutes.promoCode);
    debugPrint('Has promo code route: $hasPromoRoute');
  }
}

/// Example usage in a real widget
class ExampleNavigationWidget extends StatelessWidget {
  const ExampleNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('navigation_examples.title'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => AppRoutes.navigateToLogin(context),
              child: Text('navigation_examples.go_to_login'.tr()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => AppRoutes.navigateToRegister(context),
              child: Text('navigation_examples.go_to_register'.tr()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => AppRoutes.navigateToPromoCode(context),
              child: Text('navigation_examples.enter_promo_code'.tr()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => AppRoutes.navigateToMoreGames(context),
              child: Text('navigation_examples.more_games'.tr()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => AppRoutes.navigateToLogout(context),
              child: Text('navigation_examples.logout'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}