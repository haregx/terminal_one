import 'package:flutter/material.dart';
import 'package:terminal_one/core/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';

/// Example demonstrating ProfileScreen navigation
/// 
/// This example shows different ways to navigate to the profile screen
/// using the centralized AppRoutes system.
class ProfileNavigationExample extends StatelessWidget {
  const ProfileNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profile_navigation_example.title'.tr())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Method 1: Using AppRoutes helper method (Recommended)
            ElevatedButton(
              onPressed: () => AppRoutes.navigateToProfile(context),
              child: Text('profile_navigation_example.navigate_to_profile'.tr()),
            ),
            const SizedBox(height: 16),
            // Method 2: Using Navigator.pushNamed directly
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
              child: Text('profile_navigation_example.navigate_using_route_name'.tr()),
            ),
            const SizedBox(height: 16),
            // Method 3: From AppBar action (as shown in HomeScreenLoggedIn)
            // (This is a code sample, so we keep it as is)
            const Text(
              'Profile button in AppBar:\n'
              'IconButton(\n'
              '  icon: Icon(LucideIcons.user),\n'
              '  onPressed: () => AppRoutes.navigateToProfile(context),\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Example showing how to customize the ProfileScreen
/// 
/// The ProfileScreen is designed to be easily extendable.
/// You can override methods or extend the class for custom behavior.
class CustomProfileScreenExample {
  // Example: Custom user data source
  static Map<String, dynamic> getUserData() {
    return {
      'email': 'custom@example.com',
      'name': 'Custom User',
      'memberSince': DateTime(2024, 1, 1),
      'totalCodes': 99,
      'rewardPoints': 2500,
    };
  }
  
  // Example: Custom profile actions
  static void showCustomEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('profile_navigation_example.custom_edit_profile'.tr()),
        content: Text('profile_navigation_example.implement_custom_edit'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('profile_navigation_example.close'.tr()),
          ),
        ],
      ),
    );
  }
}