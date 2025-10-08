import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// StatData - Datenmodell für Statistik Karten
class StatData {
  final String id;
  final String value;
  final String label;
  final IconData icon;
  final Color? color; // Farbe für die Karte
  final Color? iconColor; // Farbe für Icon und Text

  const StatData({
    required this.id,
    required this.value,
    required this.label,
    required this.icon,
    this.color,
    this.iconColor,
  });
}

/// Zentrale Liste aller Statistiken
class StatsData {
  static const List<StatData> stats = [
    StatData(
      id: 'games_played',
      value: '12',
      label: 'Spiele gespielt',
      icon: LucideIcons.gamepad2,
      color: Color(0xFF3B82F6), // Blue - für Spiele
      iconColor: Colors.white,
    ),
    StatData(
      id: 'games_won',
      value: '3',
      label: 'Gewonnen',
      icon: LucideIcons.trophy,
      color: Color(0xFFF59E0B), // Amber/Gold - für Siege
      iconColor: Colors.white,
    ),
    StatData(
      id: 'success_rate',
      value: '89%',
      label: 'Erfolgsrate',
      icon: LucideIcons.trendingUp,
      color: Color(0xFF10B981), // Emerald - für Erfolg/Wachstum
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