import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';

/// SplashScreen - Zeigt einen eleganten Loading-Screen beim App-Start
/// 
/// Wird angezeigt während die Auth-Token aus dem Storage geladen werden
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            const AppLogo(
              size: LogoSize.large,
              variant: LogoVariant.minimal,
            ),
            
            const SizedBox(height: 48),
            
            // Loading Indicator
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            
            const SizedBox(height: 24),
            
            // Loading Text
            Text(
              'App wird geladen...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}