import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/core/app_routes.dart';

/// QuickActionData - Data model for Quick Actions cards
class QuickActionData {
  final String id;
  final String title; // Fallback title
  final String? titleKey; // Translation key for internationalization
  final IconData icon;
  final String? route;
  final VoidCallback? action;
  final bool isThemeToggle;
  final Color? color; // New property for card color
  final Color? iconColor; // New property for icon color

  const QuickActionData({
    required this.id,
    required this.title,
    this.titleKey,
    required this.icon,
    this.route,
    this.action,
    this.isThemeToggle = false,
    this.color,
    this.iconColor,
  });

  /// Returns the localized title if titleKey is present
  String getLocalizedTitle() {
    if (titleKey != null) {
      return titleKey!.tr();
    }
    return title;
  }
}

/// Central list of all quick actions
class QuickActionsData {
  static const List<QuickActionData> actions = [
    QuickActionData(
      id: 'code',
  title: 'Promocode eingeben', // Fallback
  titleKey: 'quick_actions.enter_promo_code',
  icon: LucideIcons.ticket, // Suitable for promo codes
  route: AppRoutes.promoCode,
  color: Color(0xFF06B6D4), // Cyan - for input
  iconColor: Colors.white,
    ),
     QuickActionData(
      id: 'games',
  title: 'Mehr Promocodes', // Fallback
  titleKey: 'quick_actions.more_promo_codes',
  icon: LucideIcons.gift, // Gift icon for more codes
  route: AppRoutes.moreGames,
  color: Color(0xFF8B5CF6), // Violet - for rewards
  iconColor: Colors.white,
    ),
    QuickActionData(
      id: 'profile',
      title: 'Profil bearbeiten', // Fallback
      titleKey: 'quick_actions.edit_profile',
      icon: LucideIcons.userCircle, // Besseres Profil-Icon
      color: Color(0xFF10B981), // Emerald - für persönliche Daten
      iconColor: Colors.white,
      route: AppRoutes.profile
    ),
    QuickActionData(
      id: 'settings',
      title: 'Einstellungen ändern', // Fallback
      titleKey: 'quick_actions.change_settings',
      icon: LucideIcons.settings2, // Moderneres Settings-Icon
      color: Color(0xFF6B7280), // Gray - neutral für Einstellungen
      iconColor: Colors.white,
      route: AppRoutes.settings,
    ),
    QuickActionData(
      id: 'help',
      title: 'Hilfe', // Fallback
      titleKey: 'quick_actions.help',
      icon: LucideIcons.helpCircle,
      color: Color(0xFFF59E0B), // Amber - aufmerksamkeitsstarb für Hilfe
      iconColor: Colors.white,
      // TODO: add Route 
    ),
   /* QuickActionData(
      id: 'theme',
      title: 'Theme', // Fallback
      titleKey: 'quick_actions.theme',
      icon: LucideIcons.palette, // Palette für Theme-Wechsel
      isThemeToggle: true,
      color: Color(0xFFEC4899), // Pink - kreativ für Theme
      iconColor: Colors.white,
    ),
    */
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