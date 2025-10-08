import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terminal_one/providers/theme_provider.dart';
import 'package:terminal_one/widgets/dashboard/simple_dashboard.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/app_logo.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    
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
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppLogo(
                              size: LogoSize.large,
                              variant: LogoVariant.minimal,
                            ),
                 /*           const SizedBox(height: 16),
                            Text(
                              'Was möchtest Du heute erledigen?',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isDark 
                                    ? Colors.white.withValues(alpha: 0.7)
                                    : Colors.black.withValues(alpha: 0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            */
                          ],
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