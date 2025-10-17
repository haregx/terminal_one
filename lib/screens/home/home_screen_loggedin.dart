import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/widgets/dashboard/simple_dashboard.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';

/// HomeScreenLoggedIn - Home screen with normal AppBar + custom scroll animation
class HomeScreenLoggedIn extends StatefulWidget {
  const HomeScreenLoggedIn({super.key});

  @override
  State<HomeScreenLoggedIn> createState() => _HomeScreenLoggedInState();
}

class _HomeScreenLoggedInState extends State<HomeScreenLoggedIn> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  late ScrollController _scrollController;
  
  // ValueNotifier for logo animation without setState
  final ValueNotifier<bool> _showSmallLogo = ValueNotifier<bool>(false);

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
    
  // NO local status bar configuration anymore
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  // NO local status bar configuration anymore
  }
  
  // Removed _updateStatusBar method as it is no longer needed

  void _onScroll() {
  // Use ValueNotifier instead of setState to avoid rebuilds
  final shouldShow = _scrollController.offset > 50; // Reduced from 100 to 50px
    if (_showSmallLogo.value != shouldShow) {
      debugPrint('Logo state changed: offset=${_scrollController.offset}, show=$shouldShow'); // Debug
      _showSmallLogo.value = shouldShow;
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scrollController.dispose();
  _showSmallLogo.dispose(); // Also dispose ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
  // NO local AnnotatedRegion anymore - handled globally in main.dart
    return GlassmorphismScaffold(
  // AppBar with logo animation - only visible when scrolling
      title: ValueListenableBuilder<bool>(
        valueListenable: _showSmallLogo,
        builder: (context, showLogo, child) {
          debugPrint('AppBar Logo showLogo: $showLogo'); // Debug
          return AnimatedOpacity(
            opacity: showLogo ? 1.0 : 0.0, // Zurück auf 0.0 für komplett transparent
            duration: const Duration(milliseconds: 300),
            child: const AppLogo(
              size: LogoSize.small,
              variant: LogoVariant.minimal,
            ),
          );
        },
      ),
      actions: [
      /*  IconButton(
          icon: const Icon(LucideIcons.settings),
          onPressed: () => AppRoutes.navigateToSettings(context),
          tooltip: 'navigation.settings'.tr(),
        ),
        IconButton(
          icon: const Icon(LucideIcons.user),
          onPressed: () => AppRoutes.navigateToProfile(context),
          tooltip: 'navigation.profile'.tr(),
        ),*/
      ],
      body: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header area with large logo (disappears when scrolling)
                ValueListenableBuilder<bool>(
                  valueListenable: _showSmallLogo,
                  builder: (context, showSmallLogo, child) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: showSmallLogo ? 0.0 : 1.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: isDark 
                                ? Colors.transparent
                                : Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AppLogo(
                                size: LogoSize.medium,
                                variant: LogoVariant.minimal,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'home.welcome_back'.tr(),
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark 
                                      ? Colors.white.withAlpha(230)
                                      : Colors.black.withAlpha(230),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'home.what_would_you_like_to_do'.tr(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: isDark 
                                      ? Colors.white.withAlpha(179)
                                      : Colors.black.withAlpha(179),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Simple dashboard
                const SimpleDashboard(),
                
                // Bottom safe area spacing
                SizedBox(height: MediaQuery.of(context).padding.bottom + 40),
              ],
            ),
          ),
        ),
    );
  }
}