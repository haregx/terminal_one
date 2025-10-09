import 'package:flutter/material.dart';
import 'package:terminal_one/core/app_routes.dart';

/// Example demonstrating ProfileScreen navigation
/// 
/// This example shows different ways to navigate to the profile screen
/// using the centralized AppRoutes system.
class ProfileNavigationExample extends StatelessWidget {
  const ProfileNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Navigation Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Method 1: Using AppRoutes helper method (Recommended)
            ElevatedButton(
              onPressed: () => AppRoutes.navigateToProfile(context),
              child: const Text('Navigate to Profile (Recommended)'),
            ),
            
            const SizedBox(height: 16),
            
            // Method 2: Using Navigator.pushNamed directly
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
              child: const Text('Navigate using Route Name'),
            ),
            
            const SizedBox(height: 16),
            
            // Method 3: From AppBar action (as shown in HomeScreenLoggedIn)
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
        title: const Text('Custom Edit Profile'),
        content: const Text('Implement your custom profile editing here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}