import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:terminal_one/components/snackbars/fancy_success_snackbar.dart';
import 'package:terminal_one/providers/auth_provider.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/widgets/dashboard/theme_toggle_card.dart';
import 'package:terminal_one/widgets/dashboard/scrollable_dashboard.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/animated_glass_card.dart';

/// HomeScreenLoggedIn - Home screen with normal AppBar + custom scroll animation
class HomeScreenLoggedIn extends StatefulWidget {
  const HomeScreenLoggedIn({super.key});

  @override
  State<HomeScreenLoggedIn> createState() => _HomeScreenLoggedInState();
}

class _HomeScreenLoggedInState extends State<HomeScreenLoggedIn>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;
  
  // Animation für Logo-Übergang
  bool _showSmallLogo = false;

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

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Start animation
    _fadeController.forward();
    
    // KEINE lokale Status Bar Konfiguration mehr
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // KEINE lokale Status Bar Konfiguration mehr
  }
  
  // Entfernte _updateStatusBar Methode da nicht mehr benötigt

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      // Zeige kleines Logo ab 100px Scroll
      _showSmallLogo = _scrollOffset > 100;
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    
    // KEINE lokale AnnotatedRegion mehr - wird global in main.dart gehandhabt
    return GlassmorphismScaffold(
      // Standard AppBar mit Logo Animation - mittig positioniert, OHNE actions
      title: AnimatedOpacity(
        opacity: _showSmallLogo ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: const AppLogo(
          size: LogoSize.small,
          variant: LogoVariant.minimal,
        ),
      ),
      body: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header Bereich mit Logo (verschwindet beim Scrollen)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _showSmallLogo ? 0.0 : 1.0,
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppLogo(
                          size: LogoSize.large,
                          variant: LogoVariant.minimal,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Was möchtest Du heute erledigen?',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark 
                                ? Colors.white.withOpacity(0.7)
                                : Colors.black.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                // Dashboard Content
                ScrollableDashboard(
                  headerWidget: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                    child: Text(
                      'Schnellzugriff',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark 
                            ? Colors.white.withOpacity(0.95)
                            : Colors.black.withOpacity(0.95),
                      ),
                    ),
                  ),
                  dashboardItems: [
                    _buildActionCard(
                      context,
                      'Neuer Auftrag',
                      LucideIcons.plus,
                      Colors.blue,
                      () => _showSnackbar(context, 'Neuer Auftrag'),
                      delay: 200,
                    ),
                    _buildActionCard(
                      context,
                      'Aufträge anzeigen',
                      LucideIcons.list,
                      Colors.green,
                      () => _showSnackbar(context, 'Aufträge anzeigen'),
                      delay: 300,
                    ),
                    _buildActionCard(
                      context,
                      'Kunden verwalten',
                      LucideIcons.users,
                      Colors.purple,
                      () => _showSnackbar(context, 'Kunden verwalten'),
                      delay: 400,
                    ),
                    _buildActionCard(
                      context,
                      'Berichte',
                      LucideIcons.barChart3,
                      Colors.orange,
                      () => _showSnackbar(context, 'Berichte'),
                      delay: 500,
                    ),
                    // Theme Toggle
                    AnimatedBuilder(
                      animation: _fadeController,
                      builder: (context, child) {
                        return ThemeToggleCard(
                          delay: const Duration(milliseconds: 600),
                          includeSystemMode: false,
                        );
                      },
                    ),
                    // Logout
                    AnimatedBuilder(
                      animation: _fadeController,
                      builder: (context, child) {
                        return _buildLogoutCard(context);
                      },
                    ),
                  ],
                ),
                
                // Bottom safe area spacing
                SizedBox(height: MediaQuery.of(context).padding.bottom + 40),
              ],
            ),
          ),
        ),
    );
  }

  void _logout(BuildContext context) async {
    debugPrint('🚪 User logged out.');
    ScaffoldMessenger.of(context).showSnackBar(
      FancySuccessSnackbar.build('Sie wurden erfolgreich abgemeldet.'),
    );
    await Provider.of<AuthProvider>(context, listen: false).setLoggedIn(false);
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    int delay = 0,
  }) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return AnimatedGlassCard(
          onTap: onTap,
          delay: Duration(milliseconds: delay),
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: color.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white.withOpacity(0.9)
                        : Colors.black.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogoutCard(BuildContext context) {
    return AnimatedGlassCard(
      onTap: () async {
        debugPrint('🚪 User logged out.');
        ScaffoldMessenger.of(context).showSnackBar(
          FancySuccessSnackbar.build('Sie wurden erfolgreich abgemeldet.'),
        );
        await Provider.of<AuthProvider>(context, listen: false).setLoggedIn(false);
      },
      delay: const Duration(milliseconds: 700),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.red.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Icon(
                LucideIcons.logOut,
                size: 18,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Abmelden',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white.withOpacity(0.9)
                          : Colors.black.withOpacity(0.9),
                    ),
                  ),
                  Text(
                    'Aus der App abmelden',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white.withOpacity(0.6)
                          : Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 18,
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.white.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      FancySuccessSnackbar.build(message),
    );
  }
}