import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/data/quick_actions_data.dart';
import 'package:terminal_one/data/stats_data.dart';
import 'package:terminal_one/utils/layout_constants.dart';
import 'optimized_glass_card.dart';
import 'widget_cache.dart';
import '../utils/performance_analyzer.dart';

/// Performance-optimierte Version des Simple Dashboard
/// 
/// Optimierungen:
/// - Const constructors
/// - Widget caching
/// - Reduced rebuilds
/// - Performance monitoring
class OptimizedSimpleDashboard extends StatelessWidget {
  const OptimizedSimpleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return PerformanceWidget(
      name: 'OptimizedSimpleDashboard',
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = LayoutHelpers.isTablet(screenWidth);
    
    return Padding(
      padding: ConstWidgets.padding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header mit cached Text Style
          _OptimizedSectionHeader(
            title: 'dashboard.quick_actions'.tr(),
            isDark: isDark,
          ),
          
          ConstWidgets.sizedBox16,
          
          // Optimierte Quick Actions
          _OptimizedQuickActionsGrid(
            isTablet: isTablet,
            isDark: isDark,
          ),
          
          ConstWidgets.sizedBox32,
          
          // Statistiken Header
          _OptimizedSectionHeader(
            title: 'dashboard.statistics'.tr(),
            isDark: isDark,
          ),
          
          ConstWidgets.sizedBox16,
          
          // Optimierte Stats
          _OptimizedStatsGrid(isDark: isDark),
        ],
      ),
    );
  }
}

/// Optimierter Section Header
class _OptimizedSectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;

  const _OptimizedSectionHeader({
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: WidgetCache.cachedTextStyle(
        'section_header',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isDark 
            ? Colors.white.withAlpha(230)
            : Colors.black.withAlpha(230),
      ),
    );
  }
}

/// Optimiertes Quick Actions Grid
class _OptimizedQuickActionsGrid extends StatelessWidget {
  final bool isTablet;
  final bool isDark;

  const _OptimizedQuickActionsGrid({
    required this.isTablet,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return PerformanceWidget(
      name: 'QuickActionsGrid',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = isTablet ? 4 : 2;
          final childAspectRatio = isTablet ? 1.2 : 1.1;
          
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: QuickActionsData.getActiveActions().length,
            itemBuilder: (context, index) {
              final action = QuickActionsData.getActiveActions()[index];
              return _OptimizedQuickActionCard(
                action: action,
                isDark: isDark,
              );
            },
          );
        },
      ),
    );
  }
}

/// Optimierte Quick Action Card
class _OptimizedQuickActionCard extends StatelessWidget {
  final QuickActionData action;
  final bool isDark;

  const _OptimizedQuickActionCard({
    required this.action,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return StaticGlassCard(
      padding: ConstWidgets.padding16,
      child: InkWell(
        onTap: () => _handleTap(context),
        borderRadius: ConstWidgets.borderRadius16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cached Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: action.color ?? Colors.blue,
                borderRadius: ConstWidgets.borderRadius12,
              ),
              child: WidgetCache.cachedIcon(
                action.icon,
                cacheKey: 'quick_action_${action.id}',
                size: 24,
                color: action.iconColor ?? Colors.white,
              ),
            ),
            
            ConstWidgets.sizedBox12,
            
            // Title mit cached Text Style
            Text(
              action.getLocalizedTitle(),
              style: WidgetCache.cachedTextStyle(
                'quick_action_title',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark 
                    ? Colors.white.withAlpha(230)
                    : Colors.black.withAlpha(230),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (action.isThemeToggle) {
      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
    } else if (action.route != null) {
      Navigator.pushNamed(context, action.route!);
    } else if (action.action != null) {
      action.action!();
    }
  }
}

/// Optimiertes Stats Grid
class _OptimizedStatsGrid extends StatelessWidget {
  final bool isDark;

  const _OptimizedStatsGrid({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return PerformanceWidget(
      name: 'StatsGrid',
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: StatsData.stats.length,
        itemBuilder: (context, index) {
          final stat = StatsData.stats[index];
          return _OptimizedStatCard(
            stat: stat,
            isDark: isDark,
          );
        },
      ),
    );
  }
}

/// Optimierte Stat Card
class _OptimizedStatCard extends StatelessWidget {
  final StatData stat;
  final bool isDark;

  const _OptimizedStatCard({
    required this.stat,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return StaticGlassCard(
      padding: ConstWidgets.padding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon
          WidgetCache.cachedIcon(
            stat.icon,
            cacheKey: 'stat_${stat.id}',
            size: 32,
            color: stat.color,
          ),
          
          // Value und Titel
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.value,
                style: WidgetCache.cachedTextStyle(
                  'stat_value',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark 
                      ? Colors.white.withAlpha(230)
                      : Colors.black.withAlpha(230),
                ),
              ),
              
              Text(
                stat.getLocalizedLabel(),
                style: WidgetCache.cachedTextStyle(
                  'stat_title',
                  fontSize: 12,
                  color: isDark 
                      ? Colors.white.withAlpha(179)
                      : Colors.black.withAlpha(179),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}