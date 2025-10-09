import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Performance Analyzer für Flutter Apps
/// 
/// Überwacht und meldet Performance-Metriken
class PerformanceAnalyzer {
  static final PerformanceAnalyzer _instance = PerformanceAnalyzer._internal();
  factory PerformanceAnalyzer() => _instance;
  PerformanceAnalyzer._internal();

  static bool _isEnabled = kDebugMode;
  static final List<PerformanceMetric> _metrics = [];
  static final Map<String, Stopwatch> _timers = {};

  /// Performance-Monitoring aktivieren/deaktivieren
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Frame-Rate Monitoring starten
  static void startFrameMonitoring() {
    if (!_isEnabled) return;
    
    SchedulerBinding.instance.addPersistentFrameCallback((duration) {
      final frameTime = duration.inMicroseconds / 1000.0; // ms
      
      if (frameTime > 16.67) { // 60 FPS = 16.67ms pro Frame
        debugPrint('⚠️ Slow frame detected: ${frameTime.toStringAsFixed(2)}ms');
        
        _addMetric(PerformanceMetric(
          type: MetricType.frameTime,
          value: frameTime,
          timestamp: DateTime.now(),
          description: 'Frame time exceeded 16.67ms threshold',
        ));
      }
    });
  }

  /// Timer für Build-Zeit starten
  static void startBuildTimer(String widgetName) {
    if (!_isEnabled) return;
    
    _timers[widgetName] = Stopwatch()..start();
  }

  /// Build-Timer stoppen und Metrik hinzufügen
  static void stopBuildTimer(String widgetName) {
    if (!_isEnabled) return;
    
    final timer = _timers[widgetName];
    if (timer != null) {
      timer.stop();
      final buildTime = timer.elapsedMicroseconds / 1000.0; // ms
      
      if (buildTime > 5.0) { // Build-Zeit > 5ms
        debugPrint('🐌 Slow build detected: $widgetName took ${buildTime.toStringAsFixed(2)}ms');
        
        _addMetric(PerformanceMetric(
          type: MetricType.buildTime,
          value: buildTime,
          timestamp: DateTime.now(),
          description: '$widgetName build time',
          metadata: {'widget': widgetName},
        ));
      }
      
      _timers.remove(widgetName);
    }
  }

  /// Memory Usage prüfen
  static void checkMemoryUsage() {
    if (!_isEnabled) return;
    
    // Note: Real memory monitoring würde native Code benötigen
    // Hier als Placeholder für zukünftige Implementation
    debugPrint('💾 Memory check placeholder');
  }

  /// Metrik hinzufügen
  static void _addMetric(PerformanceMetric metric) {
    _metrics.add(metric);
    
    // Behalte nur die letzten 100 Metriken
    if (_metrics.length > 100) {
      _metrics.removeAt(0);
    }
  }

  /// Performance-Report generieren
  static PerformanceReport generateReport() {
    final frameMetrics = _metrics.where((m) => m.type == MetricType.frameTime).toList();
    final buildMetrics = _metrics.where((m) => m.type == MetricType.buildTime).toList();
    
    return PerformanceReport(
      frameMetrics: frameMetrics,
      buildMetrics: buildMetrics,
      averageFrameTime: frameMetrics.isNotEmpty 
          ? frameMetrics.map((m) => m.value).reduce((a, b) => a + b) / frameMetrics.length
          : 0.0,
      averageBuildTime: buildMetrics.isNotEmpty
          ? buildMetrics.map((m) => m.value).reduce((a, b) => a + b) / buildMetrics.length
          : 0.0,
    );
  }

  /// Metriken zurücksetzen
  static void clearMetrics() {
    _metrics.clear();
    _timers.clear();
  }
}

/// Performance Metrik
class PerformanceMetric {
  final MetricType type;
  final double value;
  final DateTime timestamp;
  final String description;
  final Map<String, dynamic>? metadata;

  PerformanceMetric({
    required this.type,
    required this.value,
    required this.timestamp,
    required this.description,
    this.metadata,
  });
}

/// Metrik-Typen
enum MetricType {
  frameTime,
  buildTime,
  memoryUsage,
  networkTime,
}

/// Performance Report
class PerformanceReport {
  final List<PerformanceMetric> frameMetrics;
  final List<PerformanceMetric> buildMetrics;
  final double averageFrameTime;
  final double averageBuildTime;

  PerformanceReport({
    required this.frameMetrics,
    required this.buildMetrics,
    required this.averageFrameTime,
    required this.averageBuildTime,
  });

  /// Report als String ausgeben
  @override
  String toString() {
    return '''
📊 Performance Report:
🎞️ Frame Metrics: ${frameMetrics.length} slow frames
   Average: ${averageFrameTime.toStringAsFixed(2)}ms
🏗️ Build Metrics: ${buildMetrics.length} slow builds  
   Average: ${averageBuildTime.toStringAsFixed(2)}ms
''';
  }
}

/// Performance Widget Wrapper
class PerformanceWidget extends StatelessWidget {
  final Widget child;
  final String name;

  const PerformanceWidget({
    super.key,
    required this.child,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    PerformanceAnalyzer.startBuildTimer(name);
    
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          PerformanceAnalyzer.stopBuildTimer(name);
        });
        
        return child;
      },
    );
  }
}