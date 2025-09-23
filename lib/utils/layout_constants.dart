/// LayoutConstants - Zentrale Layout-Konstanten für die gesamte App
/// 
/// Diese Datei enthält alle wiederkehrenden Layout-Werte, die in verschiedenen
/// Screens verwendet werden. Dadurch wird Konsistenz gewährleistet und 
/// Änderungen können zentral vorgenommen werden.
/// 
/// Kategorien:
/// - Section Heights: Höhen für verschiedene UI-Bereiche
/// - Button Dimensions: Standard-Größen für Buttons
/// - Spacing Values: Abstände zwischen Elementen
/// - Breakpoints: Responsive Design Breakpoints
class LayoutConstants {
  // Verhindert Instanziierung dieser Utility-Klasse
  LayoutConstants._();
  
  // ==================== SECTION HEIGHTS ====================
  
  /// Standard-Höhe für untere Aktions-Bereiche (Continue + Button + Padding)
  /// Wird in HomeScreen, LoginScreen und anderen verwendet
  static const double bottomSectionHeight = 120.0;
  
  /// Höhe für Header-Bereiche mit Titel und Beschreibung
  static const double headerSectionHeight = 100.0;
  
  /// Minimale Höhe für Code-Input-Bereiche
  static const double codeInputSectionMinHeight = 200.0;
  
  // ==================== BUTTON DIMENSIONS ====================
  
  /// Standard-Höhe für Primary und Secondary Buttons
  static const double buttonHeight = 48.0;
  
  /// Minimale Breite für Buttons
  static const double buttonMinWidth = 120.0;
  
  /// Maximale Breite für Buttons auf großen Bildschirmen
  static const double buttonMaxWidth = 300.0;
  
  // ==================== SPACING VALUES ====================
  
  /// Standard-Padding um Separator-Text
  static const double separatorTextPadding = 16.0;
  
  /// Abstand zwischen Code-Input und Verify-Button
  static const double codeInputButtonSpacing = 24.0;
  
  /// Abstand zwischen Separator und Submit-Button
  static const double separatorButtonSpacing = 20.0;
  
  // ==================== RESPONSIVE BREAKPOINTS ====================
  
  /// Breakpoint für Tablet-Layout (600px+)
  static const double tabletBreakpoint = 600.0;
  
  /// Breakpoint für Desktop-Layout (900px+)
  static const double desktopBreakpoint = 900.0;
  
  /// Maximale Content-Breite auf großen Bildschirmen
  static const double maxContentWidth = 600.0;
  
  // ==================== BORDER RADIUS ====================
  
  /// Standard Border Radius für Buttons und Cards
  static const double standardBorderRadius = 8.0;
  
  /// Border Radius für Input Fields
  static const double inputBorderRadius = 12.0;
  
  // ==================== ANIMATION DURATIONS ====================
  
  /// Standard Animation Duration für UI-Übergänge
  static const Duration standardAnimationDuration = Duration(milliseconds: 300);
  
  /// Schnelle Animation für Button-Feedback
  static const Duration quickAnimationDuration = Duration(milliseconds: 150);
}

/// LayoutHelpers - Statische Hilfsmethoden für Layout-Berechnungen
/// 
/// Diese Klasse stellt Methoden zur Verfügung, die häufig verwendete
/// Layout-Berechnungen vereinfachen.
class LayoutHelpers {
  LayoutHelpers._();
  
  /// Berechnet die verfügbare Höhe nach Abzug der Bottom Section
  /// 
  /// [totalHeight] - Gesamte verfügbare Höhe
  /// [bottomSectionHeight] - Höhe der unteren Sektion (optional, verwendet Standard)
  static double calculateAvailableHeight(
    double totalHeight, {
    double? bottomSectionHeight,
  }) {
    final bottom = bottomSectionHeight ?? LayoutConstants.bottomSectionHeight;
    return (totalHeight - bottom).clamp(0.0, double.infinity);
  }
  
  /// Gibt die passende Content-Breite basierend auf der Bildschirmbreite zurück
  /// 
  /// [screenWidth] - Aktuelle Bildschirmbreite
  static double getContentWidth(double screenWidth) {
    if (screenWidth > LayoutConstants.desktopBreakpoint) {
      return LayoutConstants.maxContentWidth;
    } else if (screenWidth > LayoutConstants.tabletBreakpoint) {
      return screenWidth * 0.8; // 80% auf Tablets
    } else {
      return screenWidth - 32; // 16px Padding links/rechts auf Mobile
    }
  }
  
  /// Überprüft, ob das aktuelle Layout ein Tablet-Layout ist
  static bool isTablet(double screenWidth) {
    return screenWidth > LayoutConstants.tabletBreakpoint && 
           screenWidth <= LayoutConstants.desktopBreakpoint;
  }
  
  /// Überprüft, ob das aktuelle Layout ein Desktop-Layout ist
  static bool isDesktop(double screenWidth) {
    return screenWidth > LayoutConstants.desktopBreakpoint;
  }
  
  /// Überprüft, ob das aktuelle Layout ein Mobile-Layout ist
  static bool isMobile(double screenWidth) {
    return screenWidth <= LayoutConstants.tabletBreakpoint;
  }
}