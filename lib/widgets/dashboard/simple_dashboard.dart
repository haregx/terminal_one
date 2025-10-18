import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/data/quick_actions_data.dart';
import 'package:terminal_one/data/stats_data.dart';
import 'package:terminal_one/screens/auth/logout_screen.dart';
import 'package:terminal_one/utils/layout_constants.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/spacer/responsive_spacer.dart';

/// SimpleDashboard - Minimalistisches, übersichtliches Dashboard
class SimpleDashboard extends StatelessWidget {
  const SimpleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Responsive Größen für Schnelle Aktionen
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = LayoutHelpers.isTablet(screenWidth);
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ResponsiveSpacing.large(context),
        children: [
          // Schnelle Aktionen Header
          Text(
            'dashboard.quick_actions'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
            ),
          ),

          // Schnelle Aktionen Grid
         _buildQuickActionsGrid(context, isTablet, isDark),
          
          // Statistiken
          Text(
            'dashboard.statistics'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
            ),
          ),
          _buildStatsGrid(context, isDark),
          // Aktivität
          Text(
            'dashboard.last_activity'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
            ),
          ),
          _buildActivityCard(context, isDark),
          
          SizedBox(height: ResponsiveSpacing.tiny(context)),
          // Logout Button
          _buildLogoutCard(context, isDark),
        ],
      ),
    );
  }

  /// Erstellt das Grid für schnelle Aktionen mit GlassCards
  Widget _buildQuickActionsGrid(BuildContext context, bool isTablet, bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 4 : 2,
        childAspectRatio: isTablet ? 1.1 : 1.0,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: QuickActionsData.actions.length,
      itemBuilder: (context, index) {
        final actionData = QuickActionsData.actions[index];
        return _buildActionGlassCard(context, actionData, index, isDark);
      },
    );
  }

  /// Erstellt eine einzelne Aktions-GlassCard
  Widget _buildActionGlassCard(BuildContext context, QuickActionData actionData, int index, bool isDark) {
    return GlassCard(
      delay: Duration(milliseconds: 200 + (index * 100)),
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          if (actionData.isThemeToggle) {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          } else if (actionData.route != null) {
            Navigator.pushNamed(context, actionData.route!);
          } else if (actionData.action != null) {
            actionData.action!();
          } else {
            debugPrint('TODO: Implementierung für ${actionData.getLocalizedTitle()}');
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (actionData.color ?? Colors.blue).withAlpha(51),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (actionData.color ?? Colors.blue).withAlpha(77),
                  width: 1,
                ),
              ),
              child: Icon(
                actionData.icon,
                size: 28,
                color: actionData.iconColor ?? Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              actionData.getLocalizedTitle(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
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

  /// Erstellt das Statistiken-Grid mit GlassCards
  Widget _buildStatsGrid(BuildContext context, bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: StatsData.stats.length,
      itemBuilder: (context, index) {
        final stat = StatsData.stats[index];
        return GlassCard(
          delay: Duration(milliseconds: 400 + (index * 100)),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                stat.icon,
                size: 24,
                color: stat.iconColor,
              ),
              const SizedBox(height: 8),
              Text(
                stat.value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stat.getLocalizedLabel(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white.withAlpha(179) : Colors.black.withAlpha(179),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Erstellt die Aktivitäts-GlassCard
  Widget _buildActivityCard(BuildContext context, bool isDark) {
    return GlassCard(
      delay: const Duration(milliseconds: 600),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.activity,
                size: 24,
                color: Colors.blue.withAlpha(204),
              ),
              const SizedBox(width: 12),
              Text(
                'dashboard.last_activity'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            context,
            'dashboard.activity_code_scanned'.tr(),
            'dashboard.time_today_at'.tr(namedArgs: {'time': '14:30'}),
            LucideIcons.gift,
            Colors.green,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildActivityItem(
            context,
            'dashboard.activity_settings_changed'.tr(),
            'dashboard.time_yesterday_at'.tr(namedArgs: {'time': '18:45'}),
            LucideIcons.settings,
            Colors.orange,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildActivityItem(
            context,
            'dashboard.activity_profile_updated'.tr(),
            'dashboard.time_days_ago'.tr(namedArgs: {'days': '2'}),
            LucideIcons.user,
            Colors.purple,
            isDark,
          ),
        ],
      ),
    );
  }

  /// Erstellt einen einzelnen Aktivitätseintrag
  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String time,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(51),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
                ),
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white.withAlpha(153) : Colors.black.withAlpha(153),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Erstellt die Logout-GlassCard
  Widget _buildLogoutCard(BuildContext context, bool isDark) {
    return GlassCard(
      delay: const Duration(milliseconds: 700),
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () async {
          LogoutScreen.show(context);
        },
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(51),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.red.withAlpha(77),
                  width: 1,
                ),
              ),
              child: const Icon(
                LucideIcons.logOut,
                size: 24,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'dashboard.logout'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
                ),
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: isDark ? Colors.white.withAlpha(128) : Colors.black.withAlpha(128),
            ),
          ],
        ),
      ),
    );
  }
}