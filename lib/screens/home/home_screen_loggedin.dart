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
  
  // ValueNotifier für Logo-Animation ohne setState
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
    
    // KEINE lokale Status Bar Konfiguration mehr
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // KEINE lokale Status Bar Konfiguration mehr
  }
  
  // Entfernte _updateStatusBar Methode da nicht mehr benötigt

  void _onScroll() {
    // Verwende ValueNotifier statt setState um Rebuilds zu vermeiden
    final shouldShow = _scrollController.offset > 50; // Reduziert von 100 auf 50px
    if (_showSmallLogo.value != shouldShow) {
      debugPrint('Logo state changed: offset=${_scrollController.offset}, show=$shouldShow'); // Debug
      _showSmallLogo.value = shouldShow;
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scrollController.dispose();
    _showSmallLogo.dispose(); // ValueNotifier auch disposen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // KEINE lokale AnnotatedRegion mehr - wird global in main.dart gehandhabt
    return GlassmorphismScaffold(
      // AppBar mit Logo Animation - nur sichtbar beim Scrollen
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
                // Header Bereich mit großem Logo (verschwindet beim Scrollen)
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

                // Einfaches Dashboard
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