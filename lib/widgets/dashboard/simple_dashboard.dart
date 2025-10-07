import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/providers/auth_provider.dart';
import 'simple_card.dart';

/// SimpleDashboard - Minimalistisches, übersichtliches Dashboard
class SimpleDashboard extends StatelessWidget {
  const SimpleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive Größen für Schnelle Aktionen
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600; // iPad Erkennung
    final double cardWidth = isTablet ? 237 : 140; // 69% größer auf iPad (140 * 1.69 = 237)
    final double cardHeight = isTablet ? 304 : 180; // 69% größer auf iPad (180 * 1.69 = 304)
    
    // Responsive childAspectRatio für Statistiken (damit sie gleiche Höhe haben)
    final double statCardAspectRatio = isTablet ? 0.78 : 0.85; // Angepasst für iPad
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Schnelle Aktionen
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: const Text(
              'Schnelle Aktionen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: cardHeight, // Responsive Höhe
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16), // Nur für erste/letzte Card
              children: [
                SizedBox(
                  width: cardWidth, // Responsive Breite
                  child: QuickAction(
                    title: 'Spiele',
                    icon: LucideIcons.gamepad2,
                    onTap: () {
                      Navigator.pushNamed(context, '/games');
                    },
                  ),
                ),
                const SizedBox(width: 8), // Reduzierter Abstand zwischen Cards
                SizedBox(
                  width: cardWidth, // Responsive Breite
                  child: QuickAction(
                    title: 'Profil',
                    icon: LucideIcons.user,
                    onTap: () {
                      // TODO: Profile screen
                    },
                  ),
                ),
                const SizedBox(width: 8), // Reduzierter Abstand
                SizedBox(
                  width: cardWidth, // Responsive Breite
                  child: QuickAction(
                    title: 'Hilfe',
                    icon: LucideIcons.helpCircle,
                    onTap: () {
                      // TODO: Help screen
                    },
                  ),
                ),
                const SizedBox(width: 8), // Reduzierter Abstand
                SizedBox(
                  width: cardWidth, // Responsive Breite
                  child: Consumer<ThemeProvider>(
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
                  ),
                ),
                const SizedBox(width: 16), // Abstand am Ende
              ],
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
                children: const [
                  StatCard(
                    value: '12',
                    label: 'Spiele gespielt',
                    icon: LucideIcons.trophy,
                  ),
                  StatCard(
                    value: '3',
                    label: 'Gewonnen',
                    icon: LucideIcons.medal,
                  ),
                  StatCard(
                    value: '89%',
                    label: 'Erfolgsrate',
                    icon: LucideIcons.trendingUp,
                  ),
                ],
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
                await Provider.of<AuthProvider>(context, listen: false).setLoggedIn(false);
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
}