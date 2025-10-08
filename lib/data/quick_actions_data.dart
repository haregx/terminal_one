import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:terminal_one/core/app_routes.dart';

/// QuickActionData - Datenmodell für Schnelle Aktionen Karten
class QuickActionData {
  final String id;
  final String title;
  final IconData icon;
  final String? route;
  final VoidCallback? action;
  final bool isThemeToggle;
  final Color? color; // Neue Eigenschaft für Kartenfarbe
  final Color? iconColor; // Neue Eigenschaft für Icon-Farbe

  const QuickActionData({
    required this.id,
    required this.title,
    required this.icon,
    this.route,
    this.action,
    this.isThemeToggle = false,
    this.color,
    this.iconColor,
  });
}

/// Zentrale Liste aller Schnelle Aktionen
class QuickActionsData {
  static const List<QuickActionData> actions = [
    QuickActionData(
      id: 'code',
      title: 'Promo-Code eingeben',
      icon: LucideIcons.ticket, // Passender für Promo-Codes
      route: AppRoutes.promoCode,
      color: Color(0xFF06B6D4), // Cyan - für Eingabe/Input
      iconColor: Colors.white,
    ),
     QuickActionData(
      id: 'games',
      title: 'Mehr Promo-Codes',
      icon: LucideIcons.gift, // Geschenk-Icon für mehr Codes
      route: AppRoutes.moreGames,
      color: Color(0xFF8B5CF6), // Violet - für Belohnungen
      iconColor: Colors.white,
    ),
    QuickActionData(
      id: 'profile',
      title: 'Profil bearbeiten',
      icon: LucideIcons.userCircle, // Besseres Profil-Icon
      color: Color(0xFF10B981), // Emerald - für persönliche Daten
      iconColor: Colors.white,
      // TODO: Route wird später hinzugefügt
    ),
    QuickActionData(
      id: 'settings',
      title: 'Einstellungen ändern',
      icon: LucideIcons.settings2, // Moderneres Settings-Icon
      color: Color(0xFF6B7280), // Gray - neutral für Einstellungen
      iconColor: Colors.white,
      // TODO: Route wird später hinzugefügt
    ),
    QuickActionData(
      id: 'help',
      title: 'Hilfe',
      icon: LucideIcons.helpCircle,
      color: Color(0xFFF59E0B), // Amber - aufmerksamkeitsstarb für Hilfe
      iconColor: Colors.white,
      // TODO: Route wird später hinzugefügt
    ),
    QuickActionData(
      id: 'theme',
      title: 'Theme',
      icon: LucideIcons.palette, // Palette für Theme-Wechsel
      isThemeToggle: true,
      color: Color(0xFFEC4899), // Pink - kreativ für Theme
      iconColor: Colors.white,
    ),
    // Weitere Aktionen können hier einfach hinzugefügt werden:
    // QuickActionData(
    //   id: 'settings',
    //   title: 'Einstellungen',
    //   icon: LucideIcons.settings,
    //   route: '/settings',
    //   color: Color(0xFF6B7280), // Gray
    //   iconColor: Colors.white,
    // ),
    // QuickActionData(
    //   id: 'achievements',
    //   title: 'Erfolge',
    //   icon: LucideIcons.trophy,
    //   route: '/achievements',
    //   color: Color(0xFFEF4444), // Red
    //   iconColor: Colors.white,
    // ),
  ];

  /// Hilfsmethode um eine Aktion nach ID zu finden
  static QuickActionData? getActionById(String id) {
    try {
      return actions.firstWhere((action) => action.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Hilfsmethode um nur aktive Aktionen zu bekommen (mit Route oder Action)
  static List<QuickActionData> getActiveActions() {
    return actions.where((action) => 
      action.route != null || 
      action.action != null || 
      action.isThemeToggle
    ).toList();
  }
}