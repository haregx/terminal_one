import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/dashboard/animated_glass_card.dart';
import 'package:terminal_one/widgets/dashboard/dashboard_container.dart';
import 'package:terminal_one/widgets/dashboard/responsive_padding.dart';


class ScrollableDashboard extends StatelessWidget {
  final Widget? headerWidget; // Flexibles Widget statt title/subtitle
  final String assetPath; // Asset-Bild Pfad
  final double assetWidth; // Bild Breite
  final double assetHeight; // Bild Höhe
  final EdgeInsetsGeometry assetPadding; // Bild Position/Padding
  final MainAxisAlignment assetRowAlignment; // Horizontale Ausrichtung der Row
  final CrossAxisAlignment assetCrossAlignment; // Vertikale Ausrichtung der Row
  final bool assetBeforeText; // Asset vor oder nach Text
  final BoxFit assetFit; // Wie das Asset skaliert wird
  // Positioned Parameter
  final bool usePositioned; // Soll Positioned verwendet werden?
  final double? positionedTop; // Top Position
  final double? positionedRight; // Right Position
  final double? positionedBottom; // Bottom Position
  final double? positionedLeft; // Left Position
  final bool autoPositionText; // Text automatisch rechts vom Pokal positionieren
  // Transform-basierte sichere Positionierung
  final bool useTransform; // Sichere Transform-basierte Positionierung
  final double transformX; // X-Verschiebung
  final double transformY; // Y-Verschiebung
  // Flag positioning parameters
  final bool showFlag; // Flagge anzeigen?
  final double? flagTop; // Flag Top Position
  final double? flagRight; // Flag Right Position
  final double? flagBottom; // Flag Bottom Position
  final double? flagLeft; // Flag Left Position
  final double flagWidth; // Flag Breite
  final double flagHeight; // Flag Höhe
  final String flagAssetPath; // Flag Asset Pfad
  final double flagTransformX; // Flag X-Verschiebung
  final double flagTransformY; // Flag Y-Verschiebung
  final List<Widget> dashboardItems;
  final Duration animationDelay;
  final Color? cardColor;
  final ScrollController? scrollController;

  const ScrollableDashboard({
    super.key,
    this.headerWidget,
    this.assetPath = 'assets/pokals/a1.png', // Default Asset
    this.assetWidth = 50.0, // Default Breite
    this.assetHeight = 50.0, // Default Höhe
    this.assetPadding = const EdgeInsets.only(right: 16.0), // Default Position rechts
    this.assetRowAlignment = MainAxisAlignment.start, // Default: links
    this.assetCrossAlignment = CrossAxisAlignment.start, // Default: oben
    this.assetBeforeText = true, // Default: Asset vor Text
    this.assetFit = BoxFit.contain, // Default: proportional skalieren
    // Positioned Parameter
    this.usePositioned = false, // Default: normales Layout
    this.positionedTop, // Optional: Top Position
    this.positionedRight, // Optional: Right Position
    this.positionedBottom, // Optional: Bottom Position
    this.positionedLeft, // Optional: Left Position
    this.autoPositionText = true, // Default: Text automatisch positionieren
    // Transform Parameter (sichere Alternative zu Positioned)
    this.useTransform = false, // Default: normales Layout
    this.transformX = 0.0, // Default: keine X-Verschiebung
    this.transformY = 0.0, // Default: keine Y-Verschiebung
    // Flag Parameter
    this.showFlag = true, // Default: Flagge anzeigen
    this.flagTop = 5, // Default Flag Top Position (sichere positive Werte)
    this.flagRight = 5, // Default Flag Right Position (sichere positive Werte)
    this.flagBottom, // Optional Flag Bottom Position
    this.flagLeft, // Optional Flag Left Position
    this.flagWidth = 70.0, // Default Flag Breite
    this.flagHeight = 49.0, // Default Flag Höhe
    this.flagAssetPath = 'assets/flags/spanish.png', // Default Flag Asset
    this.flagTransformX = 0.0, // Default: keine Flag X-Verschiebung
    this.flagTransformY = 0.0, // Default: keine Flag Y-Verschiebung
    required this.dashboardItems,
    this.animationDelay = const Duration(milliseconds: 200),
    this.cardColor,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;
    final isWideTablet = screenWidth > 1000; // iPad Querformat

    // Verwende ResponsivePadding für konsistente Abstände
    double spacing = ResponsivePadding.getGridSpacing(context);
    double headerSpacing = spacing + 4;

    // Optimierte Responsive Grid-Parameter mit iPad Querformat
    int crossAxisCount = isDesktop 
        ? 4 
        : isWideTablet 
          ? 4  // iPad Querformat: 4 Spalten
          : isTablet 
            ? 3  // iPad Hochformat: 3 Spalten
            : 2; // Mobile: 2 Spalten
    
    double childAspectRatio = isDesktop 
        ? 1.1 
        : isWideTablet 
          ? 1.0  // iPad Querformat: etwas kompakter
          : isTablet 
            ? 1.0  // iPad Hochformat
            : 1.1; // Mobile: breitere Karten
    
    return DashboardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Dashboard-Header und Grid in gemeinsamem Layout
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Berechne die Breite basierend auf Screen-Größe und Spalten
                Builder(
                  builder: (context) {
                    // Einfache, direkte Breitenberechnung
                    final screenWidth = MediaQuery.of(context).size.width;
                    final containerPadding = screenWidth > 1200 ? 64.0 : screenWidth > 600 ? 48.0 : 24.0;
                    final availableWidth = screenWidth - containerPadding;
                    
                    // Minimale Kartenbreite für gute Lesbarkeit
                    final minCardWidth = screenWidth > 1200 ? 200.0 : screenWidth > 600 ? 180.0 : 150.0;
                    final totalSpacing = (crossAxisCount - 1) * spacing;
                    final cardWidth = (availableWidth - totalSpacing) / crossAxisCount;
                    final actualCardWidth = cardWidth < minCardWidth ? minCardWidth : cardWidth;
                    final dashboardWidth = (actualCardWidth * crossAxisCount) + totalSpacing;
                    
                    return SizedBox(
                      width: dashboardWidth,
                      child: Stack(
                        clipBehavior: Clip.none, // Wichtig: Erlaubt Elemente außerhalb der Grenzen
                        children: [
                          // Hauptcontainer
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          // Dashboard-Header mit Theme-aware Styling
                          Container(
                            margin: EdgeInsets.only(bottom: headerSpacing),
                            width: double.infinity,
                            child: Builder(
                              builder: (context) {
                                final isDark = Theme.of(context).brightness == Brightness.dark;
                                return AnimatedGlassCard(
                                  delay: animationDelay,
                                  animationDuration: const Duration(milliseconds: 800),
                                  blur: 15.0,
                                  opacity: isDark ? 0.25 : 0.45, // Noch höhere Opazität für lebendigere Farben
                                  color: isDark ? (cardColor ?? Colors.black) : Colors.white,
                                  padding: EdgeInsets.all(screenWidth > 1200 ? 24 : screenWidth > 600 ? 20 : 16),
                                  borderRadius: BorderRadius.circular(screenWidth > 1200 ? 20 : screenWidth > 600 ? 16 : 12),
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Dashboard-Hauptbereich')),
                                    );
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      // Standard Text-Inhalt (immer anzeigen außer bei Positioned mit AutoPosition)
                                      if (!usePositioned || !autoPositionText) 
                                        headerWidget ?? 
                                          Text(
                                            'Dashboard',
                                            style: TextStyle(
                                              fontSize: screenWidth > 1200 ? 20 : screenWidth > 600 ? 18 : 16,
                                              fontWeight: FontWeight.bold,
                                              color: isDark ? Colors.white : Colors.black87,
                                            ),
                                          ),
                                      
                                      // Asset für normales Layout (nur Assets ohne Transform/Positioned)
                                      if (!usePositioned && !useTransform) 
                                        Padding(
                                          padding: assetPadding,
                                          child: Image.asset(
                                            assetPath,
                                            width: assetWidth,
                                            height: assetHeight,
                                            fit: assetFit,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(
                                                Icons.dashboard,
                                                size: assetWidth,
                                                color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                                              );
                                            },
                                          ),
                                        ),
                                      
                                      // Text für Positioned Layout
                                      if (usePositioned && autoPositionText && 
                                          positionedTop != null && positionedLeft != null &&
                                          positionedTop! >= 0 && positionedLeft! >= 0) Positioned(
                                        // Text automatisch rechts vom Pokal positionieren - nur mit gültigen Werten
                                        top: positionedTop! + (assetHeight * 0.2).clamp(0, 100), // Begrenzte Berechnung
                                        left: positionedLeft! + assetWidth + 16, // Sichere Berechnung
                                        child: SizedBox(
                                          width: 200, // Feste Breite für den Text
                                          child: headerWidget ?? 
                                            Text(
                                              'Dashboard',
                                              style: TextStyle(
                                                fontSize: screenWidth > 1200 ? 20 : screenWidth > 600 ? 18 : 16,
                                                fontWeight: FontWeight.bold,
                                                color: isDark ? Colors.white : Colors.black87,
                                              ),
                                            ),
                                        ),
                                      ),
                                      

                                      
                                      // Text für Positioned Layout ohne AutoPosition
                                      if (usePositioned && !autoPositionText) 
                                        headerWidget ?? 
                                          Text(
                                            'Dashboard',
                                            style: TextStyle(
                                              fontSize: screenWidth > 1200 ? 20 : screenWidth > 600 ? 18 : 16,
                                              fontWeight: FontWeight.bold,
                                              color: isDark ? Colors.white : Colors.black87,
                                            ),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // Grid-Karten
                          if (dashboardItems.isNotEmpty) ...[
                            GridView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                childAspectRatio: childAspectRatio,
                              ),
                              itemCount: dashboardItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: dashboardItems[index],
                                );
                              },
                            ),
                          ],
                        ]),
                        
                        // Positioned Elements außerhalb des Containers aber scrollbar
                        // Asset mit Positioned (absolute Positionierung) - nur mit gültigen Werten
                        if (usePositioned && 
                            ((positionedTop != null && positionedTop! >= 0) ||
                             (positionedLeft != null && positionedLeft! >= 0) ||
                             (positionedRight != null && positionedRight! >= 0) ||
                             (positionedBottom != null && positionedBottom! >= 0))) Positioned(
                          top: positionedTop != null && positionedTop! >= 0 ? positionedTop : null,
                          right: positionedRight != null && positionedRight! >= 0 ? positionedRight : null,
                          bottom: positionedBottom != null && positionedBottom! >= 0 ? positionedBottom : null,
                          left: positionedLeft != null && positionedLeft! >= 0 ? positionedLeft : null,
                          child: Image.asset(
                            assetPath,
                            width: assetWidth,
                            height: assetHeight,
                            fit: assetFit,
                            errorBuilder: (context, error, stackTrace) {
                              final isDark = Theme.of(context).brightness == Brightness.dark;
                              return Icon(
                                Icons.dashboard,
                                size: assetWidth,
                                color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                              );
                            },
                          ),
                        ),
                        
                        // Text für Positioned Layout mit AutoPosition - außerhalb Container - nur mit gültigen Werten
                        if (usePositioned && autoPositionText &&
                            positionedTop != null && positionedLeft != null &&
                            positionedTop! >= 0 && positionedLeft! >= 0) Positioned(
                          // Text automatisch rechts vom Pokal positionieren
                          top: positionedTop! + (assetHeight * 0.2).clamp(0, 100), // Begrenzte Berechnung
                          left: positionedLeft! + assetWidth + 16, // Sichere Berechnung
                          child: SizedBox(
                            width: 200, // Feste Breite für den Text
                            child: headerWidget ?? 
                              Builder(
                                builder: (context) {
                                  final isDark = Theme.of(context).brightness == Brightness.dark;
                                  return Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontSize: screenWidth > 1200 ? 20 : screenWidth > 600 ? 18 : 16,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : Colors.black87,
                                    ),
                                  );
                                },
                              ),
                          ),
                        ),
                        
                        // FREIE POSITIONIERUNG - Vollständige Kontrolle über Position
                        // Frei positionierbarer Pokal (beim Scrollen mitbewegend)
                        if (useTransform) Positioned(
                          top: transformY,
                          left: transformX,
                          child: Image.asset(
                            assetPath,
                            width: assetWidth,
                            height: assetHeight,
                            fit: assetFit,
                            errorBuilder: (context, error, stackTrace) {
                              final isDark = Theme.of(context).brightness == Brightness.dark;
                              return Icon(
                                Icons.dashboard,
                                size: assetWidth,
                                color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                              );
                            },
                          ),
                        ),
                        
                        // Frei positionierbare Flagge (beim Scrollen mitbewegend)
                        if (useTransform && showFlag) Transform.translate(
                          offset: Offset(flagTransformX, flagTransformY),
                          child: Align(
                            alignment: Alignment.topRight, // Basis-Ausrichtung
                            child: Container(
                              width: flagWidth,
                              height: flagHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                // Kein Schatten - cleaner Look für beide Themes
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  flagAssetPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFFAA151B),
                                            Color(0xFFF1BF00),
                                            Color(0xFFAA151B),
                                          ],
                                          stops: [0.0, 0.5, 1.0],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

          // Optimiertes Spacing am Ende für besseres Scrolling
          SizedBox(height: spacing + 4),
        ],
      ),
    );
  }
}

class DashboardSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> items;
  final Duration delay;
  final Color? color;

  const DashboardSection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    this.delay = Duration.zero,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sektion-Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white.withOpacity(0.9),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),

        // Sektion-Items
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          Widget item = entry.value;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400 + (index * 150)),
              child: item,
            ),
          );
        }),
      ],
    );
  }
}




