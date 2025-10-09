import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/components/buttons/ghost_button.dart';
import 'package:terminal_one/components/buttons/primary_button.dart';
import 'package:terminal_one/core/app_routes.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/app_logo.dart';
import 'package:terminal_one/widgets/appbar_aware_safe_area.dart';
import 'package:terminal_one/widgets/glassmorphism_scaffold.dart';

/// Profile Screen - User profile management and settings
/// 
/// Features user information display, account settings,
/// theme preferences, and logout functionality
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('profile.edit_profile_dialog_title'.tr()),
        content: Text('profile.edit_profile_coming_soon'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.ok'.tr()),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('profile.change_password_dialog_title'.tr()),
        content: Text('profile.change_password_coming_soon'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.ok'.tr()),
          ),
        ],
      ),
    );
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('profile.delete_account_coming_soon'.tr()),
                  backgroundColor: Colors.orange,
                ),
              );
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
     /* actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: ThemeToggle(
            themeMode: themeProvider.themeMode,
            onThemeChanged: (ThemeMode newMode) {
              themeProvider.setThemeMode(newMode);
            },
          ),
        ),
      ],*/
      body: AppBarAwareSafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Header
                  _buildProfileHeader(isDark),
                  
                  SizedBox(height: ResponsiveSpacing.large(context)),
                  
                  // Stats Cards
                  _buildStatsSection(isDark),
                  
                  SizedBox(height: ResponsiveSpacing.large(context)),
                  
                  // Account Settings
                  _buildAccountSettingsSection(isDark),
                  
                  SizedBox(height: ResponsiveSpacing.large(context)),
                  
                  // App Settings
                  _buildAppSettingsSection(isDark),
                  
                  SizedBox(height: ResponsiveSpacing.large(context)),
                  
                  // Danger Zone
                  _buildDangerZoneSection(isDark),
                  
                  SizedBox(height: ResponsiveSpacing.large(context)),
                  
                  // Logout Button
                  _buildLogoutSection(isDark),
                  
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
                colors: [
                  Colors.blue.withAlpha(77),
                  Colors.purple.withAlpha(77),
                ],
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
              color: isDark 
                  ? Colors.white.withAlpha(230)
                  : Colors.black.withAlpha(230),
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Email
          Text(
            _userEmail,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark 
                  ? Colors.white.withAlpha(179)
                  : Colors.black.withAlpha(179),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Member since
          Text(
            'profile.member_since'.tr(namedArgs: {'year': _memberSince.year.toString()}),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark 
                  ? Colors.white.withAlpha(153)
                  : Colors.black.withAlpha(153),
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
              color: isDark 
                  ? Colors.white.withAlpha(230)
                  : Colors.black.withAlpha(230),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark 
                  ? Colors.white.withAlpha(179)
                  : Colors.black.withAlpha(179),
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
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 500),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildSettingsTile(
                'profile.change_password'.tr(),
                'profile.change_password_desc'.tr(),
                LucideIcons.lock,
                _showChangePasswordDialog,
                isDark,
              ),
              _buildDivider(),
              _buildSettingsTile(
                'profile.email_notifications'.tr(),
                'profile.email_notifications_desc'.tr(),
                LucideIcons.mail,
                () => _showComingSoonSnackbar('profile.feature_email_notifications'.tr()),
                isDark,
              ),
              _buildDivider(),
              _buildSettingsTile(
                'profile.privacy_settings'.tr(),
                'profile.privacy_settings_desc'.tr(),
                LucideIcons.shield,
                () => _showComingSoonSnackbar('profile.feature_privacy_settings'.tr()),
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
          'profile.app_settings'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark 
                ? Colors.white.withAlpha(230)
                : Colors.black.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 600),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildSettingsTile(
                'profile.language'.tr(),
                'profile.language_desc'.tr(),
                LucideIcons.globe,
                () => _showComingSoonSnackbar('profile.feature_language_settings'.tr()),
                isDark,
              ),
              _buildDivider(),
              _buildSettingsTile(
                'profile.about'.tr(),
                'profile.about_desc'.tr(),
                LucideIcons.info,
                () => _showAboutDialog(),
                isDark,
              ),
              _buildDivider(),
              _buildSettingsTile(
                'profile.help_support'.tr(),
                'profile.help_support_desc'.tr(),
                LucideIcons.helpCircle,
                () => _showComingSoonSnackbar('profile.feature_help_support'.tr()),
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
        Text(
          'profile.danger_zone'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.red.withAlpha(230),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          delay: const Duration(milliseconds: 700),
          padding: EdgeInsets.zero,
          child: _buildSettingsTile(
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

  Widget _buildLogoutSection(bool isDark) {
    return GlassCard(
      delay: const Duration(milliseconds: 800),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(
            LucideIcons.logOut,
            size: 32,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          Text(
            'profile.ready_to_go'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark 
                  ? Colors.white.withAlpha(230)
                  : Colors.black.withAlpha(230),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'profile.comeback_anytime'.tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark 
                  ? Colors.white.withAlpha(179)
                  : Colors.black.withAlpha(179),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'auth.logout'.tr(),
            leading: LucideIcons.logOut,
            onPressed: () => AppRoutes.navigateToLogout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
    bool isDark, {
    bool isDestructive = false,
  }) {
    final titleColor = isDestructive 
        ? Colors.red.withAlpha(230)
        : isDark 
            ? Colors.white.withAlpha(230)
            : Colors.black.withAlpha(230);
    final iconColor = isDestructive 
        ? Colors.red 
        : isDark 
            ? Colors.white.withAlpha(204)
            : Colors.black.withAlpha(204);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark 
                          ? Colors.white.withAlpha(153)
                          : Colors.black.withAlpha(153),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: isDark 
                  ? Colors.white.withAlpha(128)
                  : Colors.black.withAlpha(128),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 1,
      color: isDark 
          ? Colors.white.withAlpha(26)
          : Colors.black.withAlpha(26),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  void _showComingSoonSnackbar(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('profile.coming_soon_message'.tr(namedArgs: {'feature': feature})),
        backgroundColor: Colors.blue.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Terminal.One',
      applicationVersion: '1.0.0',
      applicationIcon: const AppLogo(
        size: LogoSize.small,
        variant: LogoVariant.minimal,
      ),
      children: [
        Text('profile.app_description'.tr()),
        const SizedBox(height: 8),
        Text('profile.built_with_love'.tr()),
      ],
    );
  }
}
