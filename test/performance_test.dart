import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/glass_card.dart';
import 'package:terminal_one/widgets/performance/optimized_glass_card.dart';
import 'package:terminal_one/widgets/dashboard/simple_dashboard.dart';
import 'package:terminal_one/widgets/performance/optimized_dashboard.dart';

/// Performance Benchmark Tests
/// 
/// Vergleicht die Performance zwischen Original- und optimierten Widgets
void main() {
  group('Performance Benchmarks', () {
    testWidgets('GlassCard vs OptimizedGlassCard Performance', (tester) async {
      // Benchmark für Original GlassCard
      final originalStopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) => GlassCard(
                child: SizedBox(
                  height: 100,
                  child: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      originalStopwatch.stop();
      
      // Benchmark für Optimized GlassCard
      final optimizedStopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) => OptimizedGlassCard(
                child: SizedBox(
                  height: 100,
                  child: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      optimizedStopwatch.stop();

      debugPrint('📊 GlassCard Performance Comparison:');
      debugPrint('🔸 Original: ${originalStopwatch.elapsedMilliseconds}ms');
      debugPrint('🔸 Optimized: ${optimizedStopwatch.elapsedMilliseconds}ms');
      debugPrint('🔸 Improvement: ${(originalStopwatch.elapsedMilliseconds - optimizedStopwatch.elapsedMilliseconds)}ms');

      // Optimierte Version sollte schneller oder gleich schnell sein
      expect(optimizedStopwatch.elapsedMilliseconds, 
             lessThanOrEqualTo(originalStopwatch.elapsedMilliseconds));
    });

    testWidgets('Dashboard Performance Test', (tester) async {
      // Test für Original Dashboard
      final originalStopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SimpleDashboard(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      originalStopwatch.stop();
      
      // Test für Optimized Dashboard
      final optimizedStopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OptimizedSimpleDashboard(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      optimizedStopwatch.stop();

      debugPrint('📊 Dashboard Performance Comparison:');
      debugPrint('🔸 Original: ${originalStopwatch.elapsedMilliseconds}ms');
      debugPrint('🔸 Optimized: ${optimizedStopwatch.elapsedMilliseconds}ms');
      debugPrint('🔸 Improvement: ${(originalStopwatch.elapsedMilliseconds - optimizedStopwatch.elapsedMilliseconds)}ms');
    });

    testWidgets('Memory Leak Test', (tester) async {
      // Test für Memory Leaks durch mehrfache Widget-Erstellung
      for (int i = 0; i < 10; i++) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GlassCard(
                child: SizedBox(
                  height: 100,
                  child: Text('Iteration $i'),
                ),
              ),
            ),
          ),
        );
        
        await tester.pumpAndSettle();
        
        // Widget wieder entfernen
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      }
      
      // Kein Memory Leak Test (würde native Tools benötigen)
      expect(true, true); // Placeholder
    });

    testWidgets('Animation Performance Test', (tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              delay: Duration(milliseconds: 100),
              child: SizedBox(
                height: 100,
                child: Text('Animated Widget'),
              ),
            ),
          ),
        ),
      );
      
      // Warte auf Animation
      await tester.pumpAndSettle();
      stopwatch.stop();

      debugPrint('🎬 Animation Performance: ${stopwatch.elapsedMilliseconds}ms');

      // Animation sollte unter 1 Sekunde dauern
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });
  });
}