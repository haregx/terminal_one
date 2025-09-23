import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/platform_widgets.dart';
import '../l10n/app_localizations.dart';

/// Example usage of platform-aware buttons with icons
/// 
/// This demonstrates best practices for using icons in buttons
/// following iOS and Android design guidelines
class PlatformButtonExamples extends StatelessWidget {
  const PlatformButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Primary action with icon (e.g., Login/Register)
          PlatformButton(
            icon: LucideIcons.logIn,
            onPressed: () {},
            child: Text(AppLocalizations.of(context)!.toRegistration),
          ),
          
          const SizedBox(height: 16),
          
          // Secondary action with icon (e.g., Cancel/Back)
          PlatformButton(
            icon: LucideIcons.arrowLeft,
            isSecondary: true,
            onPressed: () {},
            child: const Text('Zurück'),
          ),
          
          const SizedBox(height: 16),
          
          // Icon-only buttons for navigation/actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlatformIconButton(
                icon: LucideIcons.settings,
                tooltip: 'Einstellungen',
                onPressed: () {},
              ),
              PlatformIconButton(
                icon: LucideIcons.helpCircle,
                tooltip: 'Hilfe',
                onPressed: () {},
              ),
              PlatformIconButton(
                icon: LucideIcons.share,
                tooltip: 'Teilen',
                onPressed: () {},
              ),
              PlatformIconButton(
                icon: LucideIcons.info,
                tooltip: 'Information',
                onPressed: () {},
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Platform-specific icon recommendations
          Text(
            'Platform-spezifische Icon Empfehlungen:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 12),
          
          _buildIconRecommendation(
            context,
            'Hauptaktion (Primary)',
            'iOS: SF Symbols, Android: Material Icons',
            [LucideIcons.plus, LucideIcons.arrowRight, LucideIcons.check],
          ),
          
          _buildIconRecommendation(
            context,
            'Navigation',
            'Zurück, Menü, Schließen',
            [LucideIcons.arrowLeft, LucideIcons.menu, LucideIcons.x],
          ),
          
          _buildIconRecommendation(
            context,
            'Aktionen',
            'Teilen, Favorit, Bearbeiten',
            [LucideIcons.share, LucideIcons.heart, LucideIcons.edit],
          ),
          
          _buildIconRecommendation(
            context,
            'Information',
            'Hilfe, Info, Einstellungen',
            [LucideIcons.helpCircle, LucideIcons.info, LucideIcons.settings],
          ),
        ],
      ),
    );
  }

  Widget _buildIconRecommendation(
    BuildContext context,
    String category,
    String description,
    List<IconData> icons,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withAlpha(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: icons.map((icon) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(
                  icon,
                  size: 20.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}