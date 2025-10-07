import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/dashboard/animated_glass_card.dart';





class ResponsiveGlassCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? blur;
  final double? opacity;
  final bool showShadow;
  final Duration animationDuration;
  final Duration delay;
  final bool showSpanishFlag;
  final double flagWidth;
  final double flagHeight;
  final double flagTopPosition;
  final double flagRightPosition;

  const ResponsiveGlassCard({
    super.key,
    required this.child,
    this.title,
    this.icon,
    this.onTap,
    this.margin,
    this.color,
    this.blur,
    this.opacity,
    this.showShadow = true,
    this.animationDuration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.showSpanishFlag = false,
    this.flagWidth = 60.0,
    this.flagHeight = 40.0,
    this.flagTopPosition = 5.0,  // Sichere positive Werte
    this.flagRightPosition = 5.0,  // Sichere positive Werte
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;

    // Responsive Werte
    double? cardWidth;
    double cardPadding;
    double titleFontSize;
    double iconSize;
    double borderRadius;

    if (isDesktop) {
      cardWidth = null; // Nutze volle verfügbare Breite für Dashboard
      cardPadding = 24;
      titleFontSize = 20;
      iconSize = 28;
      borderRadius = 20;
    } else if (isTablet) {
      cardWidth = null; // Nutze volle verfügbare Breite für Dashboard
      cardPadding = 20;
      titleFontSize = 18;
      iconSize = 24;
      borderRadius = 16;
    } else {
      cardWidth = null; // Nutze volle verfügbare Breite für Dashboard
      cardPadding = 16;
      titleFontSize = 16;
      iconSize = 20;
      borderRadius = 12;
    }

    return ClipRect(
      child: AnimatedGlassCard(
        width: cardWidth, // null = volle verfügbare Breite
        margin: margin ?? EdgeInsets.all(cardPadding / 2),
        padding: EdgeInsets.all(cardPadding),
        borderRadius: BorderRadius.circular(borderRadius),
        blur: blur ?? 15.0,
        opacity: opacity ?? 0.15,
        color: color ?? Colors.white,
        elevation: showShadow ? 8 : 0,
        onTap: onTap,
        animationDuration: animationDuration,
        delay: delay,
        child: Stack(
          clipBehavior: Clip.none, // Erlaubt Overflow
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null || icon != null)
                  Row(
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: iconSize,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        SizedBox(width: cardPadding / 2),
                      ],
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ),
                      // Platz für die große Flagge rechts oben lassen
                      if (showSpanishFlag) SizedBox(width: flagWidth * 0.3),
                    ],
                  ),
                if (title != null || icon != null) SizedBox(height: cardPadding / 2),
                child,
              ],
            ),
            // Spanische Flagge rechts oben - jetzt größer und über Card hinaus
            if (showSpanishFlag)
              Positioned(
                top: flagTopPosition,
                right: flagRightPosition,
                child: Container(
                  width: flagWidth,
                  height: flagHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/flags/spanish.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback falls das Bild nicht gefunden wird
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.yellow, Colors.red],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.flag,
                            color: Colors.white,
                            size: flagWidth * 0.4,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final List<Widget>? actions;
  final Duration animationDuration;
  final Duration delay;
  final bool showSpanishFlag;
  final double? flagWidth;
  final double? flagHeight;
  final double? flagTopPosition;
  final double? flagRightPosition;

  const HomeCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.color,
    this.actions,
    this.animationDuration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.showSpanishFlag = true, // Standardmäßig aktiviert
    this.flagWidth,
    this.flagHeight,
    this.flagTopPosition,
    this.flagRightPosition,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;
    
    // Responsive Flaggen-Größen
    double responsiveFlagWidth = flagWidth ?? (isDesktop ? 80.0 : isTablet ? 70.0 : 60.0);
    double responsiveFlagHeight = flagHeight ?? (isDesktop ? 56.0 : isTablet ? 49.0 : 42.0);
    
    return ResponsiveGlassCard(
      title: title,
      icon: icon,
      onTap: onTap,
      color: color ?? Colors.white,
      animationDuration: animationDuration,
      delay: delay,
      showSpanishFlag: showSpanishFlag,
      flagWidth: responsiveFlagWidth,
      flagHeight: responsiveFlagHeight,
      flagTopPosition: flagTopPosition ?? 5.0,  // Sichere positive Werte
      flagRightPosition: flagRightPosition ?? 5.0,  // Sichere positive Werte
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: isTablet ? 14 : 12,
                color: Colors.white.withOpacity(0.8),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (actions != null) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }
}

class GlassInfoCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;
  final Duration animationDuration;
  final Duration delay;

  const GlassInfoCard({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.color,
    this.onTap,
    this.animationDuration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;

    double valueFontSize = isDesktop ? 24 : isTablet ? 20 : 18;
    double labelFontSize = isDesktop ? 14 : isTablet ? 12 : 10;

    return AnimatedGlassCard(
      onTap: onTap,
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      color: color ?? Colors.white,
      animationDuration: animationDuration,
      delay: delay,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: isTablet ? 32 : 24,
              color: Colors.white.withOpacity(0.9),
            ),
            const SizedBox(height: 8),
          ],
          Text(
            value,
            style: TextStyle(
              fontSize: valueFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: labelFontSize,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Beispiel für die Verwendung mit gestaffelten Animationen
class AnimatedExampleGlassCards extends StatelessWidget {
  const AnimatedExampleGlassCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/spanish.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Titel-Karte mit Delay
                HomeCard(
                  title: 'Willkommen',
                  subtitle: 'Das ist ein Beispiel für animierte Glaskarten mit responsivem Design',
                  icon: Icons.home,
                  delay: const Duration(milliseconds: 200),
                  onTap: () {
                    print('Home Card getippt');
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Info-Karten in einer Reihe mit gestaffelten Delays
                Row(
                  children: [
                    Expanded(
                      child: GlassInfoCard(
                        value: '42',
                        label: 'Benutzer',
                        icon: Icons.people,
                        color: Colors.blue,
                        delay: const Duration(milliseconds: 400),
                        animationDuration: const Duration(milliseconds: 600),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassInfoCard(
                        value: '128',
                        label: 'Nachrichten',
                        icon: Icons.message,
                        color: Colors.green,
                        delay: const Duration(milliseconds: 600),
                        animationDuration: const Duration(milliseconds: 600),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Weitere gestaffelte Karten
                Row(
                  children: [
                    Expanded(
                      child: GlassInfoCard(
                        value: '99%',
                        label: 'Erfolgsrate',
                        icon: Icons.trending_up,
                        color: Colors.orange,
                        delay: const Duration(milliseconds: 800),
                        animationDuration: const Duration(milliseconds: 700),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassInfoCard(
                        value: '24/7',
                        label: 'Online',
                        icon: Icons.online_prediction,
                        color: Colors.purple,
                        delay: const Duration(milliseconds: 1000),
                        animationDuration: const Duration(milliseconds: 700),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Benutzerdefinierte Glaskarte mit spätem Delay
                ResponsiveGlassCard(
                  title: 'Benutzerdefiniert',
                  icon: Icons.settings,
                  delay: const Duration(milliseconds: 1200),
                  animationDuration: const Duration(milliseconds: 900),
                  child: Column(
                    children: [
                      Text(
                        'Dies ist eine benutzerdefinierte Glaskarte mit schönen Fading-Animationen.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Animierte Aktion'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Beispiel für die Verwendung (Original - ohne Animation)
class ExampleGlassCards extends StatelessWidget {
  const ExampleGlassCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/spanish.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Titel-Karte
                HomeCard(
                  title: 'Willkommen',
                  subtitle: 'Das ist ein Beispiel für eine Glaskarte mit responsivem Design',
                  icon: Icons.home,
                  onTap: () {
                    print('Home Card getippt');
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Info-Karten in einer Reihe
                Row(
                  children: [
                    Expanded(
                      child: GlassInfoCard(
                        value: '42',
                        label: 'Benutzer',
                        icon: Icons.people,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassInfoCard(
                        value: '128',
                        label: 'Nachrichten',
                        icon: Icons.message,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Benutzerdefinierte Glaskarte
                ResponsiveGlassCard(
                  title: 'Benutzerdefiniert',
                  icon: Icons.settings,
                  child: Column(
                    children: [
                      Text(
                        'Dies ist eine benutzerdefinierte Glaskarte mit responsivem Design.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Aktion'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}