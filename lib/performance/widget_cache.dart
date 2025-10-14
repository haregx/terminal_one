import 'package:flutter/material.dart';

/// Widget Cache Manager
/// 
/// Cacht häufig verwendete Widgets um Rebuilds zu vermeiden
class WidgetCache {
  static final Map<String, Widget> _cache = {};
  
  /// Cached Icon erstellen
  static Widget cachedIcon(
    IconData iconData, {
    required String cacheKey,
    double size = 24,
    Color? color,
  }) {
    final key = '${cacheKey}_${iconData.codePoint}_${size}_${color?.value}';
    
    return _cache.putIfAbsent(key, () => Icon(
      iconData,
      size: size,
      color: color,
    ));
  }
  
  /// Cached Text Style erstellen
  static TextStyle? cachedTextStyle(
    String cacheKey, {
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    final key = '${cacheKey}_${fontSize}_${fontWeight}_${color?.value}';
    final cached = _textStyleCache[key];
    
    if (cached != null) return cached;
    
    final style = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
    
    _textStyleCache[key] = style;
    return style;
  }
  
  static final Map<String, TextStyle> _textStyleCache = {};
  
  /// Cache leeren (bei Theme-Wechsel)
  static void clearCache() {
    _cache.clear();
    _textStyleCache.clear();
  }
  
  /// Spezifische Cache-Bereiche leeren
  static void clearIconCache() {
    _cache.removeWhere((key, value) => value is Icon);
  }
  
  static void clearTextStyleCache() {
    _textStyleCache.clear();
  }
}

/// Performance Monitor Widget
/// 
/// Hilft beim Debugging von Performance-Problemen
class PerformanceMonitor extends StatelessWidget {
  final Widget child;
  final String name;
  final bool enabled;
  
  const PerformanceMonitor({
    super.key,
    required this.child,
    required this.name,
    this.enabled = false,
  });
  
  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    
    return Builder(
      builder: (context) {
        final stopwatch = Stopwatch()..start();
        
        return LayoutBuilder(
          builder: (context, constraints) {
            stopwatch.stop();
            debugPrint('🔍 $name build time: ${stopwatch.elapsedMicroseconds}μs');
            
            return child;
          },
        );
      },
    );
  }
}

/// Const Widget Factory
/// 
/// Erstellt const Widgets für bessere Performance
class ConstWidgets {
  // Häufig verwendete SizedBoxes
  static const sizedBox4 = SizedBox(height: 4);
  static const sizedBox8 = SizedBox(height: 8);
  static const sizedBox12 = SizedBox(height: 12);
  static const sizedBox16 = SizedBox(height: 16);
  static const sizedBox20 = SizedBox(height: 20);
  static const sizedBox24 = SizedBox(height: 24);
  static const sizedBox32 = SizedBox(height: 32);
  static const sizedBox40 = SizedBox(height: 40);
  
  // Häufig verwendete Padding
  static const padding8 = EdgeInsets.all(8);
  static const padding12 = EdgeInsets.all(12);
  static const padding16 = EdgeInsets.all(16);
  static const padding20 = EdgeInsets.all(20);
  static const padding24 = EdgeInsets.all(24);
  
  // Häufig verwendete BorderRadius
  static const borderRadius8 = BorderRadius.all(Radius.circular(8));
  static const borderRadius12 = BorderRadius.all(Radius.circular(12));
  static const borderRadius16 = BorderRadius.all(Radius.circular(16));
  static const borderRadius20 = BorderRadius.all(Radius.circular(20));
  
  // Häufig verwendete Curves
  static const easeInOut = Curves.easeInOut;
  static const easeOutCubic = Curves.easeOutCubic;
  static const elasticOut = Curves.elasticOut;
}