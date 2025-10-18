import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';

/// StatData - Datenmodell für Statistik Karten
class StatData {
  final String id;
  final String value;
  final String label; // Fallback label
  final String? labelKey; // Übersetzungsschlüssel für Internationalisierung
  final IconData icon;
  final Color? color; // Farbe für die Karte
  final Color? iconColor; // Farbe für Icon und Text

  const StatData({
    required this.id,
    required this.value,
    required this.label,
    this.labelKey,
    required this.icon,
    this.color,
    this.iconColor,
  });

  /// Gibt das lokalisierte Label zurück, falls labelKey vorhanden ist
  String getLocalizedLabel() {
    if (labelKey != null) {
      return labelKey!.tr();
    }
    return label;
  }
}

/// Zentrale Liste aller Statistiken
class StatsData {
  static const List<StatData> stats = [
    StatData(
      id: 'games_played',
      value: '12',
      label: 'Games played', // Fallback
      labelKey: 'stats.games_played',
      icon: LucideIcons.gamepad2,
      color: Color(0xFF3B82F6), // Blue - for games
      iconColor: Colors.white,
    ),
    StatData(
      id: 'games_won',
      value: '3',
      label: 'Games won', // Fallback
      labelKey: 'stats.games_won',
      icon: LucideIcons.trophy,
      color: Color(0xFFF59E0B), // Amber/Gold - for wins
      iconColor: Colors.white,
    ),
    StatData(
      id: 'success_rate',
      value: '89%',
      label: 'Success rate', // Fallback
      labelKey: 'stats.success_rate',
      icon: LucideIcons.trendingUp,
      color: Color(0xFF10B981), // Emerald - for success/growth
      iconColor: Colors.white,
    ),
  ];

  /// Hilfsmethode um eine Statistik nach ID zu finden
  static StatData? getStatById(String id) {
    try {
      return stats.firstWhere((stat) => stat.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Hilfsmethode um Anzahl der Statistiken zu bekommen
  static int get count => stats.length;
}