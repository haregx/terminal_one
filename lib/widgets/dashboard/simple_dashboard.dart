import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/data/quick_actions_data.dart';
import 'package:terminal_one/data/stats_data.dart';
import 'package:terminal_one/screens/auth/logout_screen.dart';
import 'package:terminal_one/utils/layout_constants.dart';
import 'simple_card.dart';

/// SimpleDashboard - Minimalistisches, übersichtliches Dashboard
class SimpleDashboard extends StatelessWidget {
  const SimpleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive Größen für Schnelle Aktionen
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = LayoutHelpers.isTablet(screenWidth);
    final double cardWidth = isTablet ? 237 : 140; // 69% größer auf iPad (140 * 1.69 = 237)
    final double cardHeight = isTablet ? 324 : 194; // 69% größer auf iPad (180 * 1.69 = 304)
    
    // Responsive childAspectRatio für Statistiken (damit sie gleiche Höhe haben)
    final double statCardAspectRatio = isTablet ? 1.3 : 1; // Angepasst für iPad
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Schnelle Aktionen
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: const Text(
              'Aktionen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: cardHeight, // Responsive Höhe
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16), // Nur für erste/letzte Card
              itemCount: QuickActionsData.actions.length,
              separatorBuilder: (context, index) => const SizedBox(width: 0),
              itemBuilder: (context, index) {
                final actionData = QuickActionsData.actions[index];
                
                return SizedBox(
                  width: cardWidth, // Responsive Breite
                  child: _buildQuickActionCard(context, actionData),
                );
              },
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Statistiken
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Statistiken',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true, // Passt sich dem Inhalt an
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: statCardAspectRatio, // Responsive Verhältnis
              children: StatsData.stats.map((stat) => StatCard(
                value: stat.value,
                label: stat.label,
                icon: stat.icon,
                color: stat.color,
                iconColor: stat.iconColor,
              )).toList(),
              ),
          ),
          
          const SizedBox(height: 24),
          
          // Aktuelle Aktivität
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Aktivität',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SimpleCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(LucideIcons.activity, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Letzte Aktivität',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Zuletzt gespielt: Heute um 14:30',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SimpleCard(
              onTap: () async {
                LogoutScreen.show(context);
                //await Provider.of<AuthProvider>(context, listen: false).setLoggedIn(false);
              },
              child: const Row(
                children: [
                  Icon(LucideIcons.logOut, color: Colors.red, size: 20),
                  SizedBox(width: 12),
                  Text('Abmelden'),
                  Spacer(),
                  Icon(LucideIcons.chevronRight, size: 16),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16), // Bottom padding
        ],
      ),
    );
  }

  /// Erstellt eine QuickAction Card basierend auf den Daten
  Widget _buildQuickActionCard(BuildContext context, QuickActionData actionData) {
    if (actionData.isThemeToggle) {
      return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          String themeName = themeProvider.themeMode == ThemeMode.dark
              ? 'Dark'
              : themeProvider.themeMode == ThemeMode.light
                  ? 'Light'
                  : 'Auto';
          
          return ThemeCard(
            onTap: () => themeProvider.toggleTheme(),
            currentTheme: themeName,
          );
        },
      );
    }

    return QuickAction(
      title: actionData.title,
      icon: actionData.icon,
      color: actionData.color,
      iconColor: actionData.iconColor,
      onTap: () {
        if (actionData.route != null) {
          Navigator.pushNamed(context, actionData.route!);
        } else if (actionData.action != null) {
          actionData.action!();
        } else {
          // TODO: Implementierung für ${actionData.title}
          debugPrint('TODO: Implementierung für ${actionData.title}');
        }
      },
    );
  }
}