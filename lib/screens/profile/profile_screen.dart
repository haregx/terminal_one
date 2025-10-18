import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/screens/settings/functions/build_tile.dart';
import 'package:terminal_one/screens/settings/functions/show_about.dart';
import 'package:terminal_one/screens/settings/functions/show_snackbars.dart';
import 'package:terminal_one/widgets/buttons/ghost_button.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/appbar_aware_safe_area.dart';
import 'package:terminal_one/widgets/glassmorphism_scaffold.dart';
import 'package:terminal_one/widgets/spacer/dividors.dart';
import 'package:terminal_one/widgets/spacer/responsive_spacer.dart';

/// Profile Screen - User profile management and settings
/// 
/// Features user information display, account settings,
/// theme preferences, and logout functionality
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  // Mock user data - replace with real user data from provider/API
  final String _userEmail = "profile.dummy_email".tr();
  final String _userName = "profile.dummy_username".tr();
  final DateTime _memberSince = DateTime(2025, 1, 15);
  final int _totalCodes = 42;
  final int _rewardPoints = 1337;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start animation
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _showEditProfileDialog() {
    // TODO: Implement edit profile functionality
    showComingSoonSnackbar(context, 'profile.feature_help_support'.tr());
  }

  void _showChangePasswordDialog() {
    // TODO: Implement change password functionality
    showComingSoonSnackbar(context, 'profile.change_password_coming_soon'.tr());
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('profile.delete_account_dialog_title'.tr()),
        content: Text('profile.delete_account_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement account deletion functionality
              showComingSoonSnackbar(context, 'profile.delete_account_coming_soon'.tr());
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('common.delete'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassmorphismScaffold(
      title: Text('profile.title'.tr()),
      body: AppBarAwareSafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                spacing: ResponsiveSpacing.large(context),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Header
                  _buildProfileHeader(isDark),
                  // Stats Cards
                  _buildStatsSection(isDark),
                  // Account Settings
                  _buildAccountSettingsSection(isDark),
                  // App Settings
                  _buildAppSettingsSection(isDark),
                  // Danger Zone
                  SizedBox(height: ResponsiveSpacing.small(context)),
                  _buildDangerZoneSection(isDark),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return GlassCard(
      delay: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue.withAlpha(77),Colors.purple.withAlpha(77),],
              ),
              border: Border.all(
                color: Colors.white.withAlpha(77),
                width: 2,
              ),
            ),
            child: const Icon(
              LucideIcons.user,
              size: 40,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // User Name
          Text(
            _userName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Email
          Text(
            _userEmail,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white.withAlpha(179) : Colors.black.withAlpha(179),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Member since
          Text(
            'profile.member_since'.tr(namedArgs: {'year': _memberSince.year.toString()}),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white.withAlpha(153) : Colors.black.withAlpha(153),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Edit Profile Button
          GhostButton(
            leading: LucideIcons.edit,
            label: 'profile.edit_profile'.tr(),
            onPressed: _showEditProfileDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'profile.codes_used'.tr(),
            _totalCodes.toString(),
            LucideIcons.qrCode,
            Colors.blue,
            isDark,
            delay: 300,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'profile.reward_points'.tr(),
            _rewardPoints.toString(),
            LucideIcons.star,
            Colors.orange,
            isDark,
            delay: 400,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    bool isDark, {
    int delay = 0,
  }) {
    return GlassCard(
      delay: Duration(milliseconds: delay),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(51),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color.withAlpha(77),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white.withAlpha(179) : Colors.black.withAlpha(179),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettingsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'profile.account_settings'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 500),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              buildSettingsTile(
                context,
                'profile.change_password'.tr(),
                'profile.change_password_desc'.tr(),
                LucideIcons.lock,
                () => _showChangePasswordDialog(),
                isDark,
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'profile.email_notifications'.tr(),
                'profile.email_notifications_desc'.tr(),
                LucideIcons.mail,
                () => showComingSoonSnackbar(context, 'profile.feature_email_notifications'.tr()),
                isDark,
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'profile.privacy_settings'.tr(),
                'profile.privacy_settings_desc'.tr(),
                LucideIcons.shield,
                () => showComingSoonSnackbar(context, 'profile.feature_privacy_settings'.tr()),
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppSettingsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.about_support'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 600),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
            /*  buildSettingsTile(
                context,
                'profile.language'.tr(),
                'profile.language_desc'.tr(),
                LucideIcons.globe,
                () => showComingSoonSnackbar(context, 'profile.feature_language_settings'.tr()),
                isDark,
              ),
              buildDivider(isDark),
              */
              buildSettingsTile(
                context,
                'profile.about'.tr(),
                'profile.about_desc'.tr(),
                LucideIcons.info,
                () => showAbout(context),
                isDark,
              ),
              buildDivider(isDark),
              buildSettingsTile(
                context,
                'profile.help_support'.tr(),
                'profile.help_support_desc'.tr(),
                LucideIcons.helpCircle,
                () => showComingSoonSnackbar(context, 'profile.feature_help_support'.tr()),
                isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDangerZoneSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassCard(
          delay: const Duration(milliseconds: 700),
          padding: EdgeInsets.zero,
          child: buildSettingsTile(
            context,
            'profile.delete_account'.tr(),
            'profile.delete_account_desc'.tr(),
            LucideIcons.trash2,
            _showDeleteAccountDialog,
            isDark,
            isDestructive: true,
          ),
        ),
      ],
    );
  }
}
